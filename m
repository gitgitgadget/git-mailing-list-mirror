Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2053.outbound.protection.outlook.com [40.92.53.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B085152166
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725511939; cv=fail; b=APMVjTPHqmZGrOjdrUjwZihw9zUUTQ1MoHKB3MiC9AUtgl3e4opwugmECGEmM/d+/E1gBNuR0izEC039ex4Z9hFrYgPfUSAamt/esGcPZV/bUOi4SiRtq3P+bGDhEwsVMsML/ngYCFv0slcmmud5+XR3zYM3EZh+6lvMZHIWCL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725511939; c=relaxed/simple;
	bh=/XWsYJUMXVUKCxIAu6F3u1zd/7qwnh6H2UZ6U69ZO/A=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Crr/XJSwwBboKF2SjlnEZbwHYZJpdvQfY3lVKb42HNDg7prXBvbfRbPKy9N7SYe+sE7Lq+J29aGEQVBKD3cv5WKzv5/7nqLRvp3090XwtIXZ0X8VZZb3FC5sYshSsIkWtxfFcBWu+3U8rgxZaxIlg55ItVupVYX1qRE+XOEi3Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=deLuZqeS; arc=fail smtp.client-ip=40.92.53.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="deLuZqeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkIm22GUys/4l88nsArH3MpgKZfyuS9Njy77oyC3G0Cw+IdqcuLfd1GnpqZiSEHiVM+4b1TdUndJc7sZwD3qLID9Fmb5gQcg7SMDVo9n8IvOmxZXu2+fxdqgUdetYhQjF+Lc/PpDbUyQdq7nWkw+MpKwNdHLTj+8Yp7qRa9j2kAjh4BlXX7SshsqNa118SND3myXhUddSOxoz27Wds6xmHvnxDCq3ggtauXgKubPZ3XaexldGgimeQmn8wjPegs/uROF/OnaxOVCkJvTLvC4auoVNJ4MAp4EZ1Dv7ZQwve97YRovwWp4A3YzqyAZkTFKjzdkR5SmAC3UxROBpKquoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P08PWwfNpIgJeI66iGsh//QqfGD/Msup2E4zTMF/sq8=;
 b=BBHTtttvE3rSg1vpwrHoTF5ylHOV6xXH42vFcR3JCJj8v5i8BH3tUZ1AU5UFaEslI9LIWNpm6csQhQ1BqnxjegVvdZ/vR1y/emnNDzxoWGZbKuSnis9ifRGqUWCBjcUXllOylpTz5yAbHLtuv5+jSkmWyI/OS8EKUvlTiCDpSJMU76FxAV9OOPmAEHf2AvrO4FcMIS4SK+WfBjZbhaZ/QUWJq4kQ3o192MUkHh9imWrju6YHMnhIFFyzMXHDrYMWhM0zf0y46KTeDhNc0lYT83z245TXH8v7MjVWgmX93kGk4/G7xLgIEKHOJdtR+H0yPjSAdXFjVAyYSCvRaPZW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P08PWwfNpIgJeI66iGsh//QqfGD/Msup2E4zTMF/sq8=;
 b=deLuZqeSv6Izm2ckt9mbW2fhv/cZWvoDH8xQF5t4z47jGcoJiZotUTQa5PIsiI8zFn8MrISHcJoso412XZlv1npD4Aeyc8Zy3yMD7PM4kIMGh5Fs9KOYp9g/vEJK4RGGJhtvE0fxDCBJJt4Y6ahr2lnn5NlNy279v3CHVGVESa3II4IDz7tMfNO47gsYKx9rYds1NXVXAYfvY8I0WB1ohbI/xcy8GSa2jNoR4jZHHbdS353S6uIc5jRqLd4kc3BWlZPIVBDioo6J4SmKU3GHwpJLXuxcwQclUPKWbLPSc5+MdS7qi3Zg/D5Zt5MAQIyB5UQgoz+S1TFNkdzMJXh3wg==
Received: from SI6PR01MB6833.apcprd01.prod.exchangelabs.com
 (2603:1096:4:21c::10) by TYSPR01MB5615.apcprd01.prod.exchangelabs.com
 (2603:1096:400:42a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 04:52:14 +0000
Received: from SI6PR01MB6833.apcprd01.prod.exchangelabs.com
 ([fe80::7bd8:f933:56f3:ef3f]) by SI6PR01MB6833.apcprd01.prod.exchangelabs.com
 ([fe80::7bd8:f933:56f3:ef3f%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 04:52:14 +0000
Message-ID:
 <SI6PR01MB6833E05D68861E02407F7641FE9D2@SI6PR01MB6833.apcprd01.prod.exchangelabs.com>
Date: Thu, 5 Sep 2024 14:21:56 +0930
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: russell thamm <russell.thamm@hotmail.com>
Subject: git untracks my files
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [kXaOqV9onVI1BNbCHlcvy7iFWnhjFhGwDshSZMV7MmoTgkneX6tA+F7aNIUjNJiV]
X-ClientProxiedBy: MEWP282CA0140.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d5::18) To SI6PR01MB6833.apcprd01.prod.exchangelabs.com
 (2603:1096:4:21c::10)
X-Microsoft-Original-Message-ID:
 <a43fa057-c89e-44b6-9c75-9938b24ab324@hotmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR01MB6833:EE_|TYSPR01MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db2d7ff-4786-40b3-014f-08dccd668281
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|6090799003|5072599009|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	OeGcWw643Kl2Lt69AQCsKWavDBHnYCJppyEeBllx4PrYjjuTrnMGSYKodCrV23hDZkeIgZ531F/kWAR5McKnBkQobv3Rtt7V1N8crjtL2fP7a6gD+yhGg8BhqIyOUsCwLyAYjBauxzqV3jr9Vjcsh1cJTeH+7/zO+uAc/f3KoTIOc7JVoGa/1btycvObJ4LvTd8IDhjy6g61jos0So1OXTDRfEkgzwX2MQn73D8Yh0SWtMWEW/tegKqJjJlVjZc3q0VXsuKPn66ERws06LrtYDgIrPTd7Xod/XqvXZvXlji/zwg6od7bp0W8+e1m0IhXe1N8CG2vX7M4DS43o0urafbb0bJHblt+dMFVn2a7nwkRze/FnwKxUFV/dQUGbA57cJkUDuhZ1J6yiIot06SGNps2/qZhwynfPoZ3G5MYkxWcxMETQGsZbFrYs4fjN/hkgsKzpOK9Vi5HC81TTQ4dctDk2wj3De7v8C6b3NPraPeMHbGRZ3zL7iCHCzt+UOVCJJ3ueYtblJZkZdXgTt63B4Id69a5J/3r7RVw0JXumj8ZEat2j9552XM7oscSkoxiPcKQPqDUeUiyb7pKIF13ZzUV+eKIBQVu268QonJW+0BbVw9XtFty5xHcR9gcbGELclmju5tRRMgn0WMWsQyP0x+EZsKkDGRBUC/S1+MVu7Hn1cujSMvVuipW2TT9Lt6GF7fWY2s8x3gOZkE9qZvi5+y1n3NIEdNb2OxMNLLho2I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vmkzbnhqa1pyUnpyUGNpTmhiK1FLelpyS3hLSThlcStRcVNJMUFNa3dBODF3?=
 =?utf-8?B?ZEYvcnVZdEZXTnhlREJFdmtqdlRhSC9GZko2TU5lUjNxTTZDbWJpNWxsWDV2?=
 =?utf-8?B?Tld1bkZmVEh2d09tbUNKNkFxZ3VJUzFmZmxTMU1JZ3UwSlVLV0wyRk53cy9o?=
 =?utf-8?B?NFJvMTZsVERGSWhFd0pMNWt6UmRIZ1ZrdHNCUVZxU3hSK1ltUDFnbVZVNW9O?=
 =?utf-8?B?TzNuUG9sN2o2TGdURHpnMktnQTh0MFNKQ0tDTHlBeFBjOW1LRTNLcWppYnpz?=
 =?utf-8?B?V1BOZ3RDaUt1VlNEdW0wZEZTMzcyMmpCTTk3WXhtd3BSZCt6S000OU1Cd3pJ?=
 =?utf-8?B?VlZOL256b2luYXdiWEdURkQ5aVlHb0hVdy81MHhWcG05TUJJV05Hdm1zdk00?=
 =?utf-8?B?OGQ0dHJyNVdoejZ6T3lCNDlzV21QQlZiVzRlWVQ5RlFFTU9JYTlWSHJuUXFy?=
 =?utf-8?B?WkFPM0Z3bTl4MituRWRqWGN5UFZzZkQyUHYrN1JIQmVLTmJ3dVVvbGR6USs2?=
 =?utf-8?B?Qm42a2JacVFVSVFEUVpMUS9sTldwSVU5QXpRRXNoOUx2TDNwVWlnc0Irb0ZH?=
 =?utf-8?B?ejBGTGdTNml3QkNFMnlVdFRwTjJidHp0aHpCaFdwSE5qWEpmQWU3SkQzTVha?=
 =?utf-8?B?ODVzOUVpN1RaRzhEMDNiU2RRTHd0Q3ViM0JqaHR1aVVaUzdlcWM5eEZ2cWg4?=
 =?utf-8?B?TTk5ajh2cWI5WjFCd056cGtWMFdZdVQ1MEdqQlB1ZU1kNFR4QVJhWVpJYzBs?=
 =?utf-8?B?RjhUTkIxdEsxSTZJK1phR21RckRZdjlnLzBCc2JZYVpqSExmeFNNenpVWjdY?=
 =?utf-8?B?MVBCaDdZTDkxTHF0K2I0aC9MUEYwSDljV0ZEazRTOWNmcUVmQzBYUGpmdEE1?=
 =?utf-8?B?U29TS3FsZEpJWGlxYnBjQXVwWFh4eXZKMEFubXJEZlRZRFk1cGxwVVRuK2JP?=
 =?utf-8?B?Z2xCYkk4aDN5RWJrOFJvbFBkSW5CV0NxVllSSnNoZk5kUUhkVE1vYWsxY1Y1?=
 =?utf-8?B?Z3hQRHRkRVFiZk5hWjZWc0JkZGRZcy81MDJtanpaS1lteENsYWpPaXJ0T2pT?=
 =?utf-8?B?ZVdUN1ZOSDlrTlNjVzdlalRSRmtIQUF4SlA4RC9pT1VmMHZ1cWVkUmNMZ3o5?=
 =?utf-8?B?Y1FydWZyeE1KV3VkUmwzdjhVZGxrc3FuSlNodklMZlB5a0pSeng3Nml1bzlL?=
 =?utf-8?B?UDI2S1hBWkVPS3BtMlRBUzJLZytFbWRmWDFHa0Zsd2RoQ1M0NmhjeWJodkYy?=
 =?utf-8?B?U0daVkEvUTVVOHNXVHRpWm5ob1hlYkxhV1lOb0kxMTRiVW5HRndUeDVoNnh4?=
 =?utf-8?B?MmNNREFLemJRY2xCTEx3VGZDYlNVK1U4bE0zQkJyR09FTXZnUzFFSVJVVTlu?=
 =?utf-8?B?OUptdHhLWTdxbHpBOFYza0VxVXV1eCtJTjBrQklpclpINmkrQ3hIZVpxTSs1?=
 =?utf-8?B?aWtnWXBVMk4rYTg5TW5jNzRSODYxcnN1eDNCZzdhcWJSMlQ2Z2pZVnJicEp5?=
 =?utf-8?B?T09aSlNURHUvTEhhMnorOUF6UEVyR2xSS3R2Y2crYkN4U0hmZk54RDlibkxM?=
 =?utf-8?B?eDRkcFFRYmNNN2NPbmdFRUhyQmsyclhER0wxcXh1TXNFWFdMYmZwWXdsQk1P?=
 =?utf-8?B?S2h4UytYZm5GWUxrTGhhOTN5V21nbVlaNWE0cm9BOVVhNmtNeWppeTZNVHJF?=
 =?utf-8?B?LzFqOXFWL0F0SUM4ZjM3MWRyL3VZaHhaVnRRTU9tTkRhMHVHK3ArWWRwdVhI?=
 =?utf-8?Q?yKWuT9/CxBmkS6BSCF9S5jgvzNOltLXEXYtHIze?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-b4c57.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db2d7ff-4786-40b3-014f-08dccd668281
X-MS-Exchange-CrossTenant-AuthSource: SI6PR01MB6833.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 04:52:14.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5615

Under Ubuntu 20.04, when my program modifies one of its log files, git 
marks it as untracked. Other files that my program modifies are 
correctly marked as modified.

This does not happen under Windows 11 and it didn't use to happen under 
Ubuntu.

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Pulled the project, built and ran my program which modified log files.

What did you expect to happen? (Expected behavior)

I expected the log files to be marked as modified.

What happened instead? (Actual behavior)

The log files were marked as untracked.

What's different between what you expected and what actually happened?

I do not expect git to untrack my files.

Anything else you want to add:

Only happens on Ubuntu 24.04, and not on Windows 11.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-41-generic #41-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug  2 
20:41:06 UTC 2024 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]

