From: Nikolai Kosjar <nikolai.kosjar@qt.io>
Subject: Re: "gitk --author=foo" shows also parent
Date: Tue, 26 Apr 2016 18:12:48 +0200
Message-ID: <571F9380.4070006@qt.io>
References: <571F6852.1070405@qt.io>
 <CANoM8SXn0CgUqQU3vmH-kwuxiDfC1=4FCh1SUsYuOOv4fQtWpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, <paulus@samba.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:13:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5bj-0006RL-KQ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbcDZQM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:12:59 -0400
Received: from mail-am1on0137.outbound.protection.outlook.com ([157.56.112.137]:44460
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751317AbcDZQM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qtcompany.onmicrosoft.com; s=selector1-qt-io;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QnmwHQ9qvYU15ne/mhkzQ4GY7wp/ZqIk4Fvmhqn0Nxs=;
 b=QCWSagwYzbVlp4o9YtF2nWj/V/JNjycKGxT5+5Dubpgpf77mY9qajDXMTsDHMPUtSTF17XwOYsoDAZ3uCWvEcsaMjQpdpvSw/IUVUc6v26RadSBgHgQ/UQ1c0g8gAo/YXx8ccA4iukQabWaZDkmUTtkbFRB9eB9O0+iFZjLcSRw=
Authentication-Results: samba.org; dkim=none (message not signed)
 header.d=none;samba.org; dmarc=none action=none header.from=qt.io;
Received: from [10.9.78.41] (62.220.2.194) by
 AM4PR02MB1633.eurprd02.prod.outlook.com (10.167.87.15) with Microsoft SMTP
 Server (TLS) id 15.1.466.19; Tue, 26 Apr 2016 16:12:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CANoM8SXn0CgUqQU3vmH-kwuxiDfC1=4FCh1SUsYuOOv4fQtWpw@mail.gmail.com>
X-Originating-IP: [62.220.2.194]
X-ClientProxiedBy: HE1PR02CA0055.eurprd02.prod.outlook.com (10.163.170.23) To
 AM4PR02MB1633.eurprd02.prod.outlook.com (10.167.87.15)
X-MS-Office365-Filtering-Correlation-Id: 85d0a5fb-dea1-44c0-8048-08d36ded9e77
X-Microsoft-Exchange-Diagnostics: 1;AM4PR02MB1633;2:qrCd4SOVzOyebVzWNQwbRMIhxtGpcd05Bnb7KjFDBAMj53AvBdJDMJxZ+Frhs8fYVi4wxNPRuHVa0Na5EwC82gQu525ZIRmiP1tawxFEdSEkiRvCd3kufdMNTWyse0SSY/snD10fzmQS5IqGWVnj/lUwCKr5rkqNYghE4j223ZYapoPTf2YQ4hJG7RSPUQ1x;3:apM5fhy7Z7zGHw2FI7tk2Sv12+7gwKURt/H1ZbiYNIRH4jc+WkQh9vCLyLM3djd9rlDauDXOaDfU73pB04dPHCiMtnNAfo520uMr0UBQFhUsNTGkttF+1dKnT4DVBqrc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM4PR02MB1633;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR02MB1633;25:awXT0ukHcJ3gUBuOKwRB9UbFcM0WGA5oN7/qI1acyHgrnUyHV3gpqW8sxvXT3q9gsl100dGlibpIXo0mOaIFXjAz8rhgvkK5FQhPnWzbJ6YIGqSmZoxPAot4jVxG+leNgT2V9udGxX/rQ5qc6zBXP6eOWZZcqdaYuQ48LaXv8MmKB4t6yb8/8vtGTElNcecevaeK6PxIPFg2xuhHVc8Iv5Ykf/JOuFxfByAxEQo1VvswZbjx1Uc9TmElo2fvM3Bu0gOQd2kbzHd3sgifjwlZ/h31733VTpv1ATKrBgd8+3RpQEkRWdcx+rf0JmDxs1SfNN/2khjxTJdDia8jCZ1QMecgbIxjdH/JF9sVuq2J8hxYOYlp97f6+FYz/vovZHI9SBcum8ITM5MST5yGvqDZkYrQTwocAUziL4zErIfne78ubfC9beSDtCKQ3EpW2JbHoDQ1ZvBCJbodP58UR/NCjt2BTsYgtf5l0nfpX5bsXdqpmh6xpzZ4Z+Coftl282aiz99N+5PiYFN77tRrUfdPfjdKfSIwu0MgHHYBE6jL0+YqaAE5iVevh/Fd1WXSF/cPWw40RSBPvUc7yU46H0iELngFWrn9zhLsR8qrmhjmiqI4Tem1b2VQLd6ie5eCYReVbPaWifomnL5qYjzZdOZdDQ==
X-Microsoft-Antispam-PRVS: <AM4PR02MB1633D71561D5C79366330AA990630@AM4PR02MB1633.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(9101521072)(6040130)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041072)(6043046);SRVR:AM4PR02MB1633;BCL:0;PCL:0;RULEID:;SRVR:AM4PR02MB1633;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR02MB1633;4:TYYkNyQY40B+kq0oj5YpiM7PRgTv5DkP8v5n0UMTDqIqxWkdaKsNmbK0dAVEfQOPGi/KtYcQfoFtA2vosfoRNKdAh2s1LclKDhn9+0DH/YJJ2OQSQYvWIbLwvQrejBRN9sBHqhylvXHMSbULi59krP8UBWXITk0pgnJ/x3v3UWkYe4zGtmjF6o+CNGcXO4VBo7GScVcHiKYXD35WdVGDZN5G+NwXOQ74//hzJE5Fv1jjNJq1vhxjyHCYCI8K5wEXirtgmKZW54p1cwMDJqgutlxa3FTFxolm+zuBbwAB205R7DJVHlhQZ0P5neu0dONX2Hq7s0kcRLnfeXM7DT7Sx2wcmG8jineBHkbTzgzdYH/oyV7BlffcOjtPOcIHwqq8TI3oFFdkq50TP9R6vPYBqrfq09BIVVukVLR8wRQ3uyLWHN9QZOwKxWM/GodRM8GW059raW6BrUtuJaPVhgiZ4A==
X-Forefront-PRVS: 0924C6A0D5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(6009001)(24454002)(377454003)(1411001)(65816999)(87266999)(54356999)(4001350100001)(81166005)(5004730100002)(110136002)(92566002)(42186005)(76176999)(5008740100001)(586003)(23676002)(50986999)(77096005)(4326007)(230700001)(86362001)(74482002)(3846002)(64126003)(47776003)(36756003)(1096002)(19580395003)(6116002)(33656002)(66066001)(2906002)(65956001)(65806001)(50466002)(80316001)(189998001)(19580405001)(2950100001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR02MB1633;H:[10.9.78.41];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyTUIxNjMzOzIzOklvRWV6M2FyV21QTEFCZXJkWnhCQkZJeWRR?=
 =?utf-8?B?YWFaNmtrUmdXVUNJcXEwUUVwRnhsMllJaEtZTTdYSWRDUmgxZDNxanVOU3dk?=
 =?utf-8?B?SGxzbjgvM1JzaHNJc21QSFRKMDdWTGdTdXV3SEIydlVlVUd2WGo5bU5sZ3oz?=
 =?utf-8?B?WEFJQ2ljc1ltVG1hS0FiVjM2L1hFR2xWaEdNdktXKzJ3TzFVbTVvaVdIdjBK?=
 =?utf-8?B?SFJ4NHNWMmtRUU9DaktXUzJ0Y2lIaGRtVk1QZkROd1JRaHhQS0FWL0JnY0pR?=
 =?utf-8?B?TjFZeDlHWU1jVldLclRPMkxSNXY0WHBLK2hmOU5seFZVcmg3QVYvdSt1bjA3?=
 =?utf-8?B?NVYzSC9xNTV5WllsYTNMWmJ4WXUwaVgwS1RDWnlxaFdacFhhRm8ySE5BMmNn?=
 =?utf-8?B?SmxIUW4vUVBhb0phcXZscDRGYzJoUUIrWTlSUy80TnB5T1U2c2JkQnJtTVVw?=
 =?utf-8?B?Smc5UGNoOGNOS09Jc3IzdWhBZE9UTWxSSnhpL1NoREUvMHBHSXRwTER3Yjd4?=
 =?utf-8?B?eW9IcGE2SEp5ZjZ6SSt4Tks4d3oxTjN3RHkvcm5qWFhvN3VXMkd3SnpnUmJi?=
 =?utf-8?B?SjdvTitXNWFrTXZwM2s2Q05DeWJPS3pXbU9ib1N4VFpFOHZQMFNLY2M3VTNX?=
 =?utf-8?B?OFRVdTFKUjVBWnpkUXlRbmlGNkUzeXdFMmdvdWxrR1 
X-Microsoft-Exchange-Diagnostics: 1;AM4PR02MB1633;5:grs4lNgWOGszRHBazIY3MVEsvy2OXKy0Vx6HEaJAR2xr6ffW7cwZQosFzdsNjrulV4gb3YXq8g1FWtIIM8ug8wkq/sqe6tQre6ULugCiZdcbdsPi0U8KuQ8CuJCwkHczieUgCa9B8fSER00/tEBO68SqK2Nav4XpgaZnHbkC6WndiAteFCHw6C6gz9qqyk9U;24:hIPGR+H4AUhfe6balPRFGS9L0cB9MWy9dxuLNp430/rbOBoe8o+HnZZGsfueSjXWmJpIClGg2xrjNWKUXldGd3peteNsCBJrVHy80vEsiR8=;7:sEg0s47ARsimFhYcEE1ncgiTduBYanB8Y3I0e5IOtUkYl1NbMYhEeNUStENLizDtcN0Ef/9XiJ18PwV7cPzBzw9YEyl+Y+EIIjSyXmcp1h1IbX/by7iBR8kq29Z2kY4KxEIA9l3n8jovdaW4DBJdBV8XGBpjcCYFTQYa2cTVgcMt1+AMc+7HJ1s1dflrLrgFPYhnuNSw7lgObjg+K+2EVJRym31bQRTTELLEWOedXhU=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2016 16:12:51.8461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB1633
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292608>

On 04/26/2016 04:06 PM, Mike Rappazzo wrote:
> On Tue, Apr 26, 2016 at 9:08 AM, Nikolai Kosjar <nikolai.kosjar@qt.io> wrote:
>> Hi!
>>
>>          $ gitk --author=foo
>>
>> ...seems to show also the parent of each author-matched commit, whereas
>>
>>          $ git log --author=foo
>>
>> does not. Is this intended or a bug? I've stumbled over this while
>> configuring a gitk view with the author field.
>
> I believe that this is intentional.  Notice that the parent commit's
> circle is just outlined
> compared to the selected authored commits are filled.  I consider this
> the context
> of the commits you are looking at.

Hmm, then I'm not interested in the context since it's too noisy. Is 
there any way to suppress this?

Nikolai
