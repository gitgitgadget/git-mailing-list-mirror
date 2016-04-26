From: Nikolai Kosjar <nikolai.kosjar@qt.io>
Subject: "gitk --author=foo" shows also parent
Date: Tue, 26 Apr 2016 15:08:34 +0200
Message-ID: <571F6852.1070405@qt.io>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 15:42:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av3GE-0003F9-0f
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 15:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbcDZNmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 09:42:38 -0400
Received: from mail-am1on0119.outbound.protection.outlook.com ([157.56.112.119]:7872
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751507AbcDZNmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 09:42:37 -0400
X-Greylist: delayed 2033 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Apr 2016 09:42:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qtcompany.onmicrosoft.com; s=selector1-qt-io;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=15GqYvXPNpkxRy8oGF4kPyHi7jiy/nj3dAtwa1ZLnbM=;
 b=Au7gIE2dXu4IgrDA0Sb/XZiJAh87OH2jxFbwKtIMXqJoKpMIFzDt8Sgxfgs6csM2V2KSzErjjmWu9lDoT4u/OOo+qdanqc8ryAw7kn6GtwsVov0kWE3PCbFsBxZKpV/nUF+5SwQgljI+OIfHdpA42y7Bfcy2WTUHL0vq4KE0mPM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=qt.io;
Received: from [10.9.78.41] (62.220.2.194) by
 HE1PR02MB1643.eurprd02.prod.outlook.com (10.166.37.17) with Microsoft SMTP
 Server (TLS) id 15.1.477.8; Tue, 26 Apr 2016 13:08:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
X-Originating-IP: [62.220.2.194]
X-ClientProxiedBy: HE1PR06CA0072.eurprd06.prod.outlook.com (10.164.28.168) To
 HE1PR02MB1643.eurprd02.prod.outlook.com (10.166.37.17)
X-MS-Office365-Filtering-Correlation-Id: 2a789390-2f3d-4372-bc03-08d36dd3e2ec
X-Microsoft-Exchange-Diagnostics: 1;HE1PR02MB1643;2:PqFUcIVzuJWOBJJRY1IFdvjZ5ZBcHfOxFjmZKFufGuyDrnVNaiHKEf7QbGwmbYNxoXhjFW05WD927Uirbrjn6M/ISGD0p8Zp2GC7riVDSc5337b075kAjnQbIOdWgy8m4MTao7TyVmWZHICKQ7UGhMdL16j7mIVv+UWOBZJ1KaVAm9o5O2FvUOf4DNqCTEaN;3:0yqkAqMD3flTpr25b8xClOH6Ij6nzHy6sPJVa905KYMVM176Xjy95xFxR0aSAEWNI9IMC1hpnTMXHbGcSa+nmizTkJa5q80owBJzEPSgCYVcpBlNer/vciTc6lt0S621;25:voQgM2y5bHXeUQ8fn0BBIh0IKq0Hsh4syze3/VOqHJHjLPWf2vmddhsUgRlAusbWAflKTQSXvSRuNM1TP9jVahkerqQSGBETXeLIuRkdpaZ8fTQgGb4Z1yOzrGIV7zGrEkVlfW9vkGTKdq0XouBPfAestLVRgacZAO1h9CreBH2rvE6K8OV+gDNxVcYixMlwZYMChmci5mN5tSljYeOwuWT8yrPNaIevbfg5KSf3X53XHqOWuI/1GwPyN6hUCXDqOcdSyjFjJIwSxA9peoJ1E31QhLsroz2wowx2UM+ZXTqU0gYbWO2zGsyD6BrVuYA4LsnYYJJRk8hnEuo95wRz8A==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:HE1PR02MB1643;
X-Microsoft-Antispam-PRVS: <HE1PR02MB1643C84EB874BDB1F3DA110990630@HE1PR02MB1643.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(9101521072)(6040130)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041072)(6043046);SRVR:HE1PR02MB1643;BCL:0;PCL:0;RULEID:;SRVR:HE1PR02MB1643;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR02MB1643;4:vsrxVFWrKWoIsQVumEkv3dk56mbfOxk1sVKfKuumOTbCsa5eCoo6mKMdfuIRV0fcFggCNpbNhspC+SQQ57yIJx4tzNBCQgPfnznlsPj8sCyY2CQ/HUx+F/Xr5JQa+QZ2xEdylvx7D8PzHYYjK+HU1BKD4/AO/KgNF3Ma4BozqKBjWgiV9XGIIu+CjA3JMbCwrEpU7J1/wWX7Tjg6kQqPfe7CjKZIclXl5Ae4G25HAX2AGJ5KdPB2wIRw07gkHsuY+OJs0MMLQ9D9AwqKgwCCmzBx/Bf6WHAD0yzlpeWMG4+YhnFhG+YfPzAlbOwSuqpbrLwkHhwZLG8XQOB5Tuwq/NfVnqeenQU16b/KkHLJfpPO/5JIHu7j7J5VArn8dJsZX6tQzoKJJ0j829Kdz34agYkmZIQJWxcpf2aUxFWKcjk7Xb3f6tmu9zsvHt107vhBN9WoaTbacdIr/u0V/oXOUg==
X-Forefront-PRVS: 0924C6A0D5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6049001)(6009001)(54356999)(50986999)(87266999)(2906002)(4001350100001)(81166005)(110136002)(107886002)(189998001)(450100001)(83506001)(86362001)(23676002)(33656002)(36756003)(65816999)(50466002)(64126003)(5008740100001)(230700001)(2351001)(42186005)(77096005)(59896002)(65956001)(80316001)(74482002)(229853001)(586003)(5004730100002)(3846002)(1096002)(6116002)(47776003)(19580405001)(66066001)(92566002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR02MB1643;H:[10.9.78.41];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyTUIxNjQzOzIzOi92OVladWNsSWE1Q0RFVmxMa3F2R2FXYWZX?=
 =?utf-8?B?c3d2TDNtaEs4anNpR21ERFU3YlRKd3gzRC9aTW5DejYvU1ZCMGxKZTVEanRG?=
 =?utf-8?B?QzFxUXJPYmRNcWxaZlhuUGw2ZGFTZk1TWEc3WDZtb1dsay9NZy8yK1lPdmZ0?=
 =?utf-8?B?V3pJV1V1Y2IxdnM4bEsrYmpPWmRnbzlYbVppT0QwVnNuOTB1aTZXRHJPSDIw?=
 =?utf-8?B?SG9LOVpGZllua2tXa05UYndjWXBUb3RTTis1ZS92WUV0WWI5Yi8zWGZDSjlE?=
 =?utf-8?B?OU5MbXgrS0NjeVpjaStkRWpnSk1tcldMTkhERHBmOHRrY0FndmZPYVRLcVFG?=
 =?utf-8?B?bzRtNm9Pc0o0ZWhIY3JjcnBHRndrTlRDdTh0UVVoMFRxQnh2VzZYUkxzTXR0?=
 =?utf-8?B?Rm1BbXdlMjZPdmZSVnZQcHpHT3A1SlhZcjRnMW14S3M1V1JHOGdlakVqM3Fz?=
 =?utf-8?B?VU1SS0VWZEk4SkEyV3dhZ2ZXQnh4ZmxoZ0JYWXo5cnluZGNJUHFxaVVHY3d3?=
 =?utf-8?B?WHhKOFV2TmhnUkVLQjN6L05EclZqcEhDMFJzWWU5K3h1NXpsZUpzaDRxM1Na?=
 =?utf-8?B?L1JFNUY3QnVENEhDY1JzdXh2ci84eXo4RGkzK3d3dk5US0lINWlvalFvMnR5?=
 =?utf-8?B?RmhJSldxbHd0RUptWDlVVWZ4TkJYVHE1VXRiT3NlK0 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR02MB1643;5:bok8fR436cBzArNt1OAcbyWJ697HgMkPIeWa7g3go9MEBI/WvdPfkMycJvKxUCLd3DFyJQLrMLBejhXPxZsAN52JpuGOL/mLVp5Uy1ToUHkCBVpGp/p+9AndXzRR0bWPQfC9HsJJVpno4x3Oq9E9QQ==;24:hDBu+IdcKICEytt6OAtj2kSlyJgTUNrdo+l3EPa65WhUBeAH8s99mwo4ADgb0898DyQMPvWJsJjaiJtIOecZhuiW2vkMqdd4jgPxVgMBHa8=;7:W5fRmYs4S4VyXkLZzj447KkN1oPTiT9/+C94/Az/OYgvpwWGU5neMRsCBZMBHCaaan6g6UImxZ/kb8rkHf2SziktV9mw8ZZ3MsAND5pApql+ZumoU3OnChgQznDldxgxVhiJr/VPA+nBTsL8zNpysvhkwsvN0QIYzEtqo1ENT+4lfJ/zaMPswwq9iBJUEpXN
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2016 13:08:40.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR02MB1643
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292599>

Hi!

	$ gitk --author=foo

...seems to show also the parent of each author-matched commit, whereas

	$ git log --author=foo

does not. Is this intended or a bug? I've stumbled over this while 
configuring a gitk view with the author field.

Nikolai





# Setup
~/work/gitkBug % git init .
~/work/gitkBug % touch file1 file2
~/work/gitkBug % git add file1
~/work/gitkBug % git commit "--author=MrFoo <foo@world>" file1 -m "add 
file1"
~/work/gitkBug % git add file2
~/work/gitkBug % git commit "--author=MrBar <bar@world>" file2 -m "add 
file2"

# TEST: git log --author - OK
~/work/gitkBug % git log --author=MrBar # OK, as expected
commit 8aa4a4f651162bcb2275a1e9ee23fc1bb7226097
Author: MrBar <bar@world>
Date:   Tue Apr 26 14:22:58 2016 +0200

     add file2

# TEST: gitk --author - OPS
~/work/gitkBug % gitk --author=MrBar  # Ops, gitk shows also the parent 
commit
