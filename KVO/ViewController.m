//
//  ViewController.m
//  KVO
//
//  Created by kuanter on 2017/2/9.
//  Copyright © 2017年 kuanter. All rights reserved.
//

#import "ViewController.h"
#import "myKVO.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *KVOlable;

@property (nonatomic,strong)myKVO *myKVO;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.myKVO = [[myKVO alloc]init];
    
    /*1.注册对象myKVO为被观察者:
     option中，
     NSKeyValueObservingOptionOld 以字典的形式提供 “初始对象数据”;
     NSKeyValueObservingOptionNew 以字典的形式提供 “更新后新的数据”;
     */
    [self.myKVO addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"num"] && object == self.myKVO)
    {
        // 响应变化处理：UI更新（label文本改变）
        self.KVOlable.text = [NSString stringWithFormat:@"当前的num值为：%@",[change valueForKey:@"new"]];
        
        //change的使用：上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\noldnum:%@ newnum:%@",[change valueForKey:@"old"],[change valueForKey:@"new"]);
    }
}
- (IBAction)KVObutton:(id)sender {
     self.myKVO.num = self.myKVO.num + 1;
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"num"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
