Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D8620229
	for <e@80x24.org>; Wed,  2 Nov 2016 00:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754459AbcKBAPN (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 20:15:13 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:19008
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752726AbcKBAPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 20:15:12 -0400
X-Greylist: delayed 10817 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Nov 2016 20:15:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SmartAction.onmicrosoft.com; s=selector1-smartaction-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=mEUnyt383eS+dsPiRdeKlS8Bh61GGpmx9letNc18J3w=;
 b=MFMVbw3RUDOf8BEVWPht5j8XdeBc6Xs8lz7mdULLprRPV71BKjF2ODQ+W4IFLaS6xLIdxLYVdl8vpk3fat8aa44OIxdoMGSvNUCAre2luP9r854Xg5UyZPzoHsk967gfReRa5xnShQpPK/tbeK+aR0NLfsG9+7j8PZFxFP/gI8k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kkm@smartaction.com; 
Received: from [10.40.1.37] (173.227.18.210) by
 BN6PR02MB2449.namprd02.prod.outlook.com (10.173.141.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.693.12; Tue, 1 Nov 2016 19:41:56 +0000
To:     <git@vger.kernel.org>, <apenwarr@gmail.com>
From:   Kirill Katsnelson <kkm@smartaction.com>
Subject: should git-subtree ignore submodules?
Organization: SmartAction
Message-ID: <183ca87e-1bc0-080c-3d42-87c689b9f62e@smartaction.com>
Date:   Tue, 1 Nov 2016 12:41:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.227.18.210]
X-ClientProxiedBy: BY2PR08CA0004.namprd08.prod.outlook.com (10.163.62.142) To
 BN6PR02MB2449.namprd02.prod.outlook.com (10.173.141.16)
X-MS-Office365-Filtering-Correlation-Id: d0dac0ee-9655-4d48-f0e1-08d4028f23df
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2449;2:5tJbg7FQMdGrAN56zvNF8GBnajKkpvYJMzzpyVMb6ChpEGgYiupHjrkXozcZk71v+XbRAUDbOLschkEQQQR0X6EUcBz9xnao/YX+TDwiGaLXaPLEbJ8ZiyOQQnr3nOYdG8eG8TKxvn+ZVtZ/XAMv1StSeamHH8PyevZy60Jghqum8qkZX1Q7ZjYFDfwbXqU9qUcLWR9Ra4+uY4i9cJFW4A==;3:2oJ0DDObxWDjvvABo9/P/RUvAPKPpj655GOkhusHyz1sgBIt6YFrVhNmD4bovfoo/aFoBJSsRvaXe+th8Cok4d7b+/aYse/qUwcUSYRjlIL6lRKHRsklqDDHf9Z9499NClAKfANC+qQEHiY9beRq1w==;25:7C0UvYW3RZIBzBZiv0P8Rx+3TIs6c4hgnrghtypgfEcE3WhSeq/2NI/6ffiSFNRIt8Pgpe6f5yjZR7W+G9VcpH/Kt2L8L8Jix3FsjUDNfD4z7hn3zYalVvmiJdqBNyJVum1dffi2J2R18J7TIW6E/f5wJ55gUifd7dm8a8G4ii07OMk4CeQiYPhUp1AYHL/7cS4h8s5wxHeUdss/lfQOsoslKfcfF0McIsJSmCEm88mlrSG5u542I/aebcwuRHuV7SiPXIaZt19e9XlyjzLHPcuc5wc7bEINDV17IRbdwvhPyHnGPSdlhd9LflFa17EHg/eYgqyry9AoLA0oyQtOhOb1OWkPn4D9z67GjFpPFLReOnyeKokk9/B++Q44NjwGiXfp7xypzZ4wmenLRpDI+d237u2Lf32VEOmDrXFe7SI=
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2449;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2449;31:sQMLAwzjvP5vjulM8bWcI9TKGxMy/o6kYYfFJ9WyRZGnUDjRMvqEoqBDmHcE9MJQoA7yiGCBq2cP8uSRWo/OAaW5jSI8XINCZ3ygPI9shSRWYoIsWDdWnAHm8IWq36YGMerOf9x99gyGluCuISCiKjOq6qq4INnRsODyyqxou/p0Ik7DH69OtaXPE2nx1n8fdDbal/12Mg9c5FJ8QUtETVProZ1QnLm1Ovd5IMkVViIf691IYX3UuX/cJlae9b4zo6SwEPV6+3vq5LexzzAK7w==;4:2pYOzNnEPUxJ98vhw3y+cON+EDgNijwQwqkDsXCLzwC2HJBpEtRt/1De2JuNh9tQqRGmECqoxhPy2rAlfEYy5m2AT3g6OhPtDZtxHpfA8XU9E8XkLj4nWTnCBTb3Pzbwo+K2Y1lvQiHUZeeW2eVP9OAQsurytauaH1sQ9CJzzaAe+o0f3vN4WQVtmo9W+mEvoQjm29O9X0xmzme9mMM6Dl3IaEFUOHLDiM0uXNhucafNgYA71k82TFETQ78CkpsjSpXaxJ1f2yr1f7U4HGkat5FsFZcKlQI2rzoWFvOX2R6BzkFlq1qbPRlAcEwm9f81nO22G0urldWwJHd/1CFQ8ghqQmc9+10P7mg1RieVI/WmlDAkbHmT0N/UyXJ0G5cDNMwt31RBu2M8c0dblSzfmUUQVNq9lrIefLl5MEHT0jj3myJIcnI7C2PpuM4BRizCcQd5P6es3+6iqX+37ODOJURcguKU1yDqB63Qcyt3pnVpcM5EpvabkUlQ3H+fykFL3nz53CpXrIsaqZRLZUGcOA==
X-Microsoft-Antispam-PRVS: <BN6PR02MB2449FDDFA6FF7B8F7ABF5C99BFA10@BN6PR02MB2449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(211171220733660);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6042046)(6043046);SRVR:BN6PR02MB2449;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2449;
X-Forefront-PRVS: 01136D2D90
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6049001)(6009001)(7916002)(199003)(189002)(3480700004)(86362001)(7736002)(92566002)(305945005)(15975445007)(77096005)(5660300001)(7846002)(8676002)(65826007)(81166006)(229853001)(586003)(4001350100001)(36756003)(97736004)(81156014)(6116002)(19580395003)(3846002)(5001770100001)(31696002)(83506001)(107886002)(31686004)(230700001)(54356999)(50466002)(47776003)(65956001)(50986999)(23676002)(105586002)(65806001)(189998001)(64126003)(33646002)(42186005)(2906002)(6666003)(106356001)(66066001)(101416001)(68736007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR02MB2449;H:[10.40.1.37];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: smartaction.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAyTUIyNDQ5OzIzOjJTSWwzTmhXdktWZWgyY1VrMkJzR3hBdVBn?=
 =?utf-8?B?YXRwSEVmNS82YldwRjJqeXdGdGhxNjdCSjRXUmJzNU9pMmI4Y3QrdFFhMVo0?=
 =?utf-8?B?Z2dtLzFmWEtLK1ZjcWhxWUxLWHV4YWdRc2VKMk1jTkM3bktPTENSWk1ybDh4?=
 =?utf-8?B?dWd5eXFNMlZvWkluSmlsQ0xQNzBGelRJeklmSW5VRDFNbGpqNW1kMGl4RGpz?=
 =?utf-8?B?RXZjUWJqdk1tKzJTWnBVeXpBTzQ2U1dzV2hmYnVDekRqeENTdzRYNVIwYTcv?=
 =?utf-8?B?NUZqSFZVNUpzYk50Wm1DTHpRZjMyRUhUaWh6L1poek9YM1Zzb0V4ZXVhcHlD?=
 =?utf-8?B?WUVWQjVhWHVYRWVqUzJVUGhzSnlzQUNId3dnSkk2QSswYW9sZDUvcTEzTjBQ?=
 =?utf-8?B?QVZmeXM4VUdyY2l2OVR5czdSVHNQVTdYejMxMENxQm9sU1hsbE9CczRabnZU?=
 =?utf-8?B?T3FTaDcvOTYvdUJ0NndzYnZEb3BtN0w0NWlqUG1VNks1cU5ZSmVPZkJOTVhp?=
 =?utf-8?B?b1QvMU91enRrL241Q0hOekUwOHZHVENZZUxKdVpDSnNEeFBuODVURUhuZ0pT?=
 =?utf-8?B?YWhMaEJlQ0ZNYkYrMzNXZnFFalNFZlliV0tIWFM0a2VCbC9MTE15aFlkb1JC?=
 =?utf-8?B?VzJZQ1BpUUFlNXBHOE9OaGEvcVlaYWprNGs1Vm43NUpjTU9YR250MFhEaWVm?=
 =?utf-8?B?L08waFdXWFVHVWpVR0JheVEyRS9ITWYraldBK0pwL3R5ZVEweVNCb0VnN2Ft?=
 =?utf-8?B?WWdIeUNhQXJNc0dGYzJsQ0p2RkdJcm9GRTdKSzRtcWltR1YweGpkYi9zMTZj?=
 =?utf-8?B?Vit3TlMwSzE3NGp1WTcwVkdrVVUxaHBUTGN0R3FiZW5IclV0VFAzVG16K1Ev?=
 =?utf-8?B?bjNTWXdwdlB4TEc1LysxL2NkZ0MrYVpCR09HVm1JVk5SdXBaYXdLTFIrNjRN?=
 =?utf-8?B?eXpBdWRuMnBJaHpBY1NuYnNNdUJ0VnhZL1dGL2hsWEhOby9XN2ZXMzNiWC9O?=
 =?utf-8?B?aFkvNkdSTjFLdXRGbld2YmNicG5LSkFyUnBDM1ExTi93NVg0L0xuc1Y1eElS?=
 =?utf-8?B?RjhwcnlpWWpqd09HaEZXeGlLNE1pRmEvM3plK09XUTkrTVRLNkQvL09peEIv?=
 =?utf-8?B?YUNTNHhDa0ZIOTE5MGsvYkN0bUY0Q1BSR2hwdlZLeW0yNXdOY3RaZm5HV3hK?=
 =?utf-8?B?RWFaN2NYeWxSU2U1U2lxUWZHT2tIb3lFN3JVRU1Pb0JGU3MwT2hiTmEyRHpP?=
 =?utf-8?B?ZGU4OHNEOVdwTGZhU1BRR05Yd01hQVBVVW9oTFRPRGJXbk1QMXZtZHZPMklT?=
 =?utf-8?B?ZS9XZDNibTY1SnljbWhOYVhjcndaOTFLUWtvcHJRdmpKY1FRU256cmIxZWFY?=
 =?utf-8?B?ZzF2MWhxTVJMMkxWV0M0ZUF6SStSZWJibElKOVF5UzczM2c0Y2JGOUo4eTgy?=
 =?utf-8?B?dTkrMWg0Wklhd29VbXJqaDlNcWNzSEJnQ3NrZjMwTkhtZ25sNWlkQnVGckFS?=
 =?utf-8?B?aHIreHNZZHVzVGVXQk5YY0s4bGNhOWoxdXRIdzNXT0JzZllRZndiOUdvYkVV?=
 =?utf-8?B?T0VWUjVsRnBkYUI0dU9vRG9YS3RCOE5QaUpMUmdtcXRkMHZzOEQrd1o4MzJE?=
 =?utf-8?B?Ui9jWThzd2JaZnlrVitjT1JkVUlxQ2U3YWZVRzg1WnlXUGJNZzdjRHVwdEdL?=
 =?utf-8?Q?5OHr3sVkMSocIVXZlJ7A8wBZyQIy+IMYHd3KeZR?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2449;6:tH/o4jkYsozqFYq1Zbvj7q71LPa/VP1wQ2tQwaCJQEvcfghTx4R0U1Gq++Fzx48yQI03KJCFNfYl4avpddWm85dJz26pycxgE0jkGkeYpVE69/iXwepaZrioPxLwvbvtjO9dnBq1URpIRX4csC7DRn8CWe50Bdmoub3hP6viBdEWhpw/1v9feNiLaBULndRfDCGPWvEdXR/JP7aNGCyvetyn2QmRW8VdEQMZQqYe9kd+28wPzhkcstFgCtzhzfXcN2pGVhocRh6SeEpvMz/axTmEqXDMSnGAlwCjhdr9aTmqAC2KNmUzmkkC3KBdLddHgx8zqgdfg2JaQx9N+Ngqng==;5:ejWxg250q4UcFzdhK7+OgVxvMjQhPzvp5D7QoDbQ2BkYomZxqFknC+q2OL+4fvJYJKE0K3gLIT+1izsVgWUMBKZgbtWFTyrtKdLRdL8a9mzjh2piOr7cEJIxzyB1AVMypHkGWUFmOv7ow0WOCDOmzQ==;24:rgKgbm3WUc7ruPGYtFsfbUzzi3/u/QqcUrlJoKwOFcDC7ivr3ETL4vhR5fZvUBKBbJ2JepYZPVn2zyOtHJazUFRxTjwWk9Vcsc7kaYGKwWM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2449;7:tyhI+ywCTyLwcaITZ8rIYax5ppnitoNxupfkCTE6zRyP1SPV+J6HQ+c0KLwWW62MRI5Wfs0NUpMtozfxqWjgeDV15LgUWr/meBZcLic5LAD0weelXPdyz7yIQW7cJJuVKFXL21pr3d4ev/BetsljpMxaUtp6MTqpUv3juzZ6j552d9hkeQYR9KjNeo9RHgKqwIa64CUS3/uOCPxfYdduusTXMo17VjCGx7uyu6O35fJSnzQ+BHVq4UT8424IAXuRZWT2Tmu+WIweqV5l5kxPoMkZqnxP2OvIWNEK/Pv4r5KAHZ6Gk4f23ScAI0otIEystkr2bEkd27twsTprZzmrq+b+F13EF/m5OCLwYKH/4HE=
X-OriginatorOrg: smartaction.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2016 19:41:56.8657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2449
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git-subtree add" fails to add the subtree into a repository with 
submodules, reporting that the worktree is not clean, while `git status` 
says that everything is clean (including submodules). I tracked the 
problem down to the command "git index HEAD" returning all submodules as 
having the M status:

$ git diff-index HEAD
:160000 160000 d3812c9318c4d0336897fd2d666be908fa1a7953 
d3812c9318c4d0336897fd2d666be908fa1a7953 M      ext/grpc
<snip more submodules>
$ git --version
git version 2.9.2.windows.1

I worked around the problem in my local copy of git-subtree shell script 
by adding "--ignore-submodules=all" to the two invocations of `git 
diff-index` in the ensure_clean() function (direct link 
<https://github.com/git/git/blob/next/contrib/subtree/git-subtree.sh#L586>).

I am wondering, is this a defect in git-subtree? To my understanding, 
the command should not care about submodules more than ensuring their 
worktree is not in the way of new prefix, and that's a separate check. 
So *even if* the submodule is modified, this should not be a show 
stopper for "git-subtree add". Or am I missing some subtleties?

  -kkm
