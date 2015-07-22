//
//  ViewController.m
//  SimpleTest
//
//  Created by Alex Um on 7/21/15.
//  Copyright (c) 2015 Streamlyzer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UIWebViewDelegate, UITextFieldDelegate>
{
    
}
@property (retain) UIWebView *webview;
@property (retain) UITextField *textField;
@end



@implementation ViewController

- (void) updateURL
{
    NSMutableString *str = [[NSMutableString alloc] initWithString:_textField.text];
    
    if (![str hasPrefix:@"http://"] && ![str hasPrefix:@"https://"])
        [str insertString:@"http://" atIndex:0];
    
    NSURL *candidateURL = [NSURL URLWithString:str];
    if (candidateURL)
    {
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [_textField resignFirstResponder];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    
    float frameWidth = self.view.frame.size.width;
    float frameHeight = self.view.frame.size.height;
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, frameHeight * 0.1, frameWidth, frameHeight * 0.9)];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]]];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frameWidth * 0.8, frameHeight * 0.1)];
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    [self.view addSubview:_textField];
    
    UIButton *uiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [uiButton setFrame:CGRectMake(frameWidth * 0.8, 0, frameWidth * 0.2, frameHeight * 0.1)];
    [uiButton addTarget:self
                action:@selector(updateURL)
                forControlEvents:UIControlEventTouchUpInside];
    [uiButton setTitle:@"GO" forState:UIControlStateNormal];
    [self.view addSubview:uiButton];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _textField.text = _webview.request.mainDocumentURL.absoluteString;
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    //Execute javascript method or pure javascript if needed
    [_webview stringByEvaluatingJavaScriptFromString:@"methodName();"];
    _textField.text = _webview.request.mainDocumentURL.absoluteString;
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
//    return TRUE;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _textField) {
        [self updateURL];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
