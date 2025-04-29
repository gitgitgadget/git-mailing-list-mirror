Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6F2139B5
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943985; cv=fail; b=gEuGSw71rPmS3L3qv/l0an+aU43Y3gheKvQRhLPl3EuMgk8LbB+CXqGN/uTbqsYwRpch1wN8K36uJXzpsrbLPl2oXBcHeRRNDAUqg2T/uAJ4iQGJN8xSj1uo5EutapLI4U91IEbdorxGOldVb3dRC5UJhwz9UMuIQyYeGcZ4rYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943985; c=relaxed/simple;
	bh=uzYO0Z6n2vfpk2idKwZluTd7Xpuu5oswFnv7+xu3nSw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D9KCWLV+gl5KcLpQChTkL6VrJixPn7EPKG4lVfgkfdp+LvGCEnBzggI4xuOWM+JYVGGFodCN/VnpCabT/BGNknQ+/XkgQYdSRJDHEKou1aBq6d55RPWAtUUUWs9thrNdFiKO1vp8ACHD/9amY80F6t4a+zDV/sjjb+1xVRYjdBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PlLGds0L; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PlLGds0L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sR32CLfA9FHK1h7Ms5xuTaChp3kwa7DGbui1swiHVE+fr+zsXvRvviDpZVorFniVZwZmFdsFvwb9rRhsoexuvS/x95mh/h10LkSFhoCfxbx79TG47Eqptm7gWsCsKgUktiHk+LGshG7axgNnR9hAMErnkHZVa+nYtC3IfGmril32+JK6q570vjWuMPCe6DeV/yhSpU1oFB/8juraSCTXFlIIjWDFrv1hKY7cjyIIoe4pja4PJ76U8YubYt54bY/26NqJi5mKL4C1nCFUkCAoFeGmAfjnbymf0lkZb3swJVmjvGaHP616rxF9upGGCaI1u2XgwQRSwK2S5StnHSRvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucJe2KbKEZRBFMkVBkiAkcldGVoK02djZDy+vh8Edew=;
 b=McvIKnx2ht2nh8f18/bQwdXc3Z8b4g/0goMI+EqUdb2r2i4sM9wOHCXIlL/qerQYaek/4DE0wZzl4FWBvOKGOMFlV5P0xAdVK/17/Nygh23o2ZGHq5/LIOml/QbE0F2oTFOisTMVWV52Ql9iNQSAziEc3wKHMJQub9xhith1v4T1DEHSOpQZTpcAun0xackB4okae6g8Yt3jhWSwdv4GgRgAaNcqUarRqJoc8iOMPYNjf8xq1s6h88UDeQ6yHlTJM0y4BXtSFGRTB/nIBO9AKvdAm9l74xnSVzXkO6zkFWgTb9zYfBk5bJyUWS3Lj+/9RVZEbCYqOYbYHkBCjmEhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucJe2KbKEZRBFMkVBkiAkcldGVoK02djZDy+vh8Edew=;
 b=PlLGds0LFxGC5ulYnkHKyPqASXdMjzs4chKK9ztd9d2LQ32iynSE0H2oqy+7mqVdGy6NFQ6cKeTi2FBhchtNoZ3P6OF4cQatZEPazLP/geLbpKpU4F8LpWR8X0pUUav6vnOlzWYkW6xLmtCLZHwMa7u1TBvw9nMBoVkHSXNj5yG+9xQMBfHMsL2x8WOXDZtUBZEWX2s0O56Js8T4pCYGZvJJss9iSVXqDPM+eU3gOpgBVVcApJyDuKhtycdbUI7jS/dWPpVW+LKyr5w/JPSWBVqXlJEu8lMYEzcYzYiWieZJsuIt5n7VIuBE++f6Ea2BzcsWQo/Nk4hltYFGkccX0Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN4PR01MB10890.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:27a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 16:26:16 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 16:26:16 +0000
Message-ID:
 <PN3PR01MB9597ECC5F83BDFEF08FD8B90B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 29 Apr 2025 21:56:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] send-email: add --[no-]outlook-id-fix option
To: Junio C Hamano <gitster@pobox.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Yao Zi <ziyao@disroot.org>
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqldrj6imh.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqldrj6imh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::34) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <bd74b9fc-4cb2-47fd-82c2-b8f7471f657d@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN4PR01MB10890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4324b6c9-490d-4c93-1ac7-08dd873a90f7
X-MS-Exchange-SLBlob-MailProps:
	B8gWPGiJ24QS2so22zLR7hsEnkhoqq/LwPGLkbZz+jqjg2bROAyRTVLUjhOALzcl0d7p6e0WfBwjaTaJ7k6X/vqYM5JNr7KxWAVJWW1uhah35L4tbInAKVfXC09n6YRc9575BlIcQM/gfAbWVRlbjnvkn0pF7PXPJOfOm7d56vgrFg6hJGFMu2yeJTeBtEtmR82ZPWxfuYmglw1FojbI/gtEJlAg7bLAJ2H3G3sNEnyMvlLPYR2HFjDNRrq6oUzmQS/O59tml1R00vUDrBxdBf+gAw00JP/Vz/1jAq1yMmISZ8NA59tUSzSHb+ipfu3tbCjn8zpE33CvwnZ/r5cbfgz3r02cjmsZD7qDQoarDnsGgbsDlhJemhcTo/ZV8+gaiCZ3fRDGH5dVPpbacUW2Bd6i6NAyUmceWVALxTDNOkoD7nV+X7jVXXLpnDgX99St6N0oh6ZFeNUTNQYEyJNxhzYapyb/OYNP1mOzdRrG+Rd4jv7U2amdojYIY2Z35qGDZL3zbZpljtR0ybHpXsgYmyOae57fUL3D6F0WZIo5s8EcQ4ASykdzqXMkHygehssUD+GEK/tajP9UJvkSyOzjHRJVyADNhrvOm/De6BMAy0H9yP33G/MmZql/zwSVVJYJw5n9PdFBBZopm0rb2BXkXmvBUSqJ7vjbm3u9wPxpV7pApychypeiRY7uy+RZzeSRwFV3w4fjZg4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|6090799003|5072599009|19110799003|8060799006|15080799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDdtYmJ3Z2crdDFDRU5yMkNPWjRhOWpmdkdYb3ZZOTFVcEtUS1JqczkxQ205?=
 =?utf-8?B?SWJqSDE2d3BZK0xMKzh3a3QvbjRES1VwVlJvdlErWGFHTWhBS0VMa1RSOVR4?=
 =?utf-8?B?UUF3aWFBeEovWjVlcVIvOTVSMlh2MXhYZ0I5Tm9LQ21vaE9DamlBMDZJR2Ez?=
 =?utf-8?B?dFYza0RxOHRINHNYLzlIblRvMTRzYlBaUi9lSndoZXFXTFcyeGZXQy9zQzhD?=
 =?utf-8?B?endkbzJJSFAyVUpaR1REbVg3UVUyVDBhdlVKYkt6cWxmTzVhbWp2d2dDM1ph?=
 =?utf-8?B?Ym04NFRlbjcyM3dHZUtER0YvaWxCZngvN2VpWEdzanRHQWtlcDh4dCttWits?=
 =?utf-8?B?Z1BLNExSMWVvQ3plRzF0VlB6NFo2WXBjRWZNY09TaGVSU0dIbmFuTlZtZHpv?=
 =?utf-8?B?NkFDTTh5bmh6dzNhZVFWWG43UDRxa082TnR2emdSL1I1UkE5a3BXTTh3QXdp?=
 =?utf-8?B?T2Q4WGFZMk1YTVFKb0Z5dEQwUHFWelpuMms5WENnMUJaalowVEZXaTFnOHVz?=
 =?utf-8?B?c3ZCVHdJVEdzYXpDZzJIYWl3OEhKYmcwbWJ3aEYrNEhiK1V0b3NsaVR4SnJG?=
 =?utf-8?B?RW9YbUNhTFEvUXdhT3M0eHduME9JSU9ieVB2L1hkWXVUYlZuOC9YbnFmcENJ?=
 =?utf-8?B?c1JmQ29RMnhtZEZRV0NSamJJM0VxM0Q0c1ZVbHp3Uit1UkpzejVQbVF1SkJz?=
 =?utf-8?B?S0pUK3dsSDQ1cVoxdTJQZDk0d3Z5ck9MK2pNeTJKcU51QXgrRndvTnNRbDFO?=
 =?utf-8?B?ajJmMnRtN2JuRXZ2OTZqM0NvVmdZZ0IvN1ZwSll6eGxtM0Jodk1WNk4vaktO?=
 =?utf-8?B?bHJmcndVMWZDQ2N0QVBqWFNDdGNHdzhVNW40MCtESE8zcjl2Q21FbnNjaWlL?=
 =?utf-8?B?VUxYWG9NYVNFWDJIaEhIRXl1S3FBT2h2cHdTL2krNkRPODVSWnh5Mkc5Umdv?=
 =?utf-8?B?TGZ4aGxVd1hCM09ZZWJzMlFINS9aMDd4ZUlWZUVGa0xWWWRUV3c2aFNocGFh?=
 =?utf-8?B?OUVWbnE5cnhtcmdpTjhFaUovWHdUU3cvNTh4Y3JDOE5Jd0hDcHJQd2VtdnZt?=
 =?utf-8?B?K2FTZXQ0UW9SeW5xMngzMHZOZHdaMGFXcjAvUHVhNTh1dDRQUFBsV241YTZn?=
 =?utf-8?B?MUZ3WE0reG9qRXNRMURzb3QwaGszOFRjSTQ0MEx0UCs0cTBsTkluRjBxaEhM?=
 =?utf-8?B?NVUvaWNkNm02OXVWTk5BWjFqOFVsREt1NGxaVWd4YThEZlB3STdQSmc2a1hp?=
 =?utf-8?B?VXdHcURuNjhvMVg0Syt3NmJDNkZycm5Famt6WHpBL0J3Y2ZuTVQzYkJyVjhL?=
 =?utf-8?B?UUpRalJpdXFtZHhJM0x4ZlYvd1phMkhpZlJ1NEo0dllVa0RhQW9nVzVEOGZR?=
 =?utf-8?B?SzJPalovTSttd0VzWG1TeC90YWtDWDNtZ21CcXkwdmRDTk5MSHFnVDlTWnRo?=
 =?utf-8?B?cUJoN3ZNSHRhUzAzeWNYczdmbkFIZldpZ0diWWVITThaNWV1bkhZY1IzZGhi?=
 =?utf-8?B?VFlWT2VMRmJEN3l0c2JJUFd5TWdsWFpFbko2NURvYkpzMzFZcEdrS08xcXJx?=
 =?utf-8?B?dWxhQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzdjMjdWOFNDTnVEbWVaRGtGUkRyMFYwOGE3ZkQrZ2pBZUtxcXExWjVqVzJm?=
 =?utf-8?B?ZXFCL2NmdkttOU5GNmJHWmtQZ0tLeW0rMnV0TGYrcHRFeXk5VjlEMVpaVzdo?=
 =?utf-8?B?aEZUWFVsdmp5S2xTdzNvcXhsMGN4aEFaRExjV0FzQkw1Y1V4aHhKaE9WR2Rp?=
 =?utf-8?B?eGw2MUVjREpLZHo5cGdsUFdVSENUNStCZ05FS0ZBLy9abWk1Q3hxZDY4VFRr?=
 =?utf-8?B?a2tiR0JRNXBtRlJxN2FkYUU5eWVxbi8rQkU1cGpMZ3l4Ky9WUVNteGp0bDJ4?=
 =?utf-8?B?NE9IVmFUMzNzcytXSWVucXFpcnRGT1Vxd1dVcHFLNEVqZnM3WGYzdno2bm43?=
 =?utf-8?B?OFJKRzJIaE9rUXcrRDFPc3lqVlZaWTlEdmd5L2RFSDFMTVVZU0JHbVBYelMz?=
 =?utf-8?B?djdBY1dxQk1EaUJUaEU4YjRTYjM3eW0xTnFvT1Y4WkcvZ24wNGp4TTRVOEZk?=
 =?utf-8?B?QnlFemlzbzhPZDlYQ2NhSGVwSldjbXRCQmNoN25tb2FVa1BNdy8yYUE0U0p2?=
 =?utf-8?B?QkRnbEV0YzNhZnBoZUFYSC9xVEFrZU83VFc1N0s1bDMrSmV4SXZoVkQrOGlq?=
 =?utf-8?B?OWZiOU9OdVpxV1BZY0szL1J6eXhEUUMxa2ZocVdGRWpiQmwrT0pha1pUQUtL?=
 =?utf-8?B?a09saStsbkNFdE5qcEZtd0tHSGdJdS9UeFh2S1RDS0NnTFp3czNtV05GWlRH?=
 =?utf-8?B?NUdJWmlnZElnR0wrSmNPMUd2VzRNNVg1V0J0MnlXK1R6YXhudy8welBZdDVv?=
 =?utf-8?B?cDhibGtLQ3ZoZzM2Q2tuODRaVi84NWR1UUQvRlpzZmIrNW1GRG1BRUh5TStO?=
 =?utf-8?B?RHdBd0JuVytYWTMrOG44ZHFJS2picEd3U1QyUXQvditiODFsZ0NrTm12SFg1?=
 =?utf-8?B?U3RUVm96OGRlbm9GME9MZ2tHY2JpcnNabnNHRytsL09Cck4vSlhZNy9zdFd1?=
 =?utf-8?B?YTNQdk5xSFFFRWd2Qjd3QXY4TjVzZEdEdXh2SmJnZENTWFZtUFByN1VqdzdH?=
 =?utf-8?B?TmlyRFBJaEI1eW1laVFSQ1dRcTQrdDMydG0wNmxpbDBFTG9iOExXK1BXQytS?=
 =?utf-8?B?Y0FZdS9nSmVGejNRZlBBaHp4MmplYWlZdUxLK0hqZm1wTnhJVktjY05Id1hV?=
 =?utf-8?B?LzBtRFZ5MWlmQkozMHpodmIrYXk2N3EyVUhtL0ttQW5WNkoyejI0cGp6OGxj?=
 =?utf-8?B?U2d1K2NaTU05QXZVL0kxVVc0NkFtSVoyNHU4QmV1KzNIWEZEZUp0UVdCQzRn?=
 =?utf-8?B?N0xtR2E0UFJ5emdHaVN6cWJBN3pUcG1aSEFYT2Urd0xiT1Z1eFNiMDl1am5w?=
 =?utf-8?B?c253RUVFUGNzYnBtc0ttMkhYeXF4d0VaTVRjVHB4ZFJCVGpwVm9zRnBBQ3c4?=
 =?utf-8?B?NEY2NEhJbkx0SjEvWTBLcmxrVHhValA1WE85aldRemhvOXBaOGwxSE9IR3F3?=
 =?utf-8?B?SVNGeXRhQ2JxOW54alU0TmRkZGtFQUlLcEVtN1hsd0xvOXlreVFlbi9saG0x?=
 =?utf-8?B?ejRrd25BQW5ka1lIZ1ZhY0xjZjh1OXdXenp1Ri9sYmRlb05McTVEWURtQmVo?=
 =?utf-8?B?TjJGb3U4b1FuVnZzT0U4UUFtN3plZy9hVU5qRDJ6YXNoT2pmUGU5R2h2Nkdw?=
 =?utf-8?B?dDBNNisxTVk4VVVhYUl0WGNESjBHcE5Sd2Ixc0J3aU9ZZmY0d0pHbjcvazdl?=
 =?utf-8?B?c2hVd1VIa2UrbHVjaTJyT3k5YUlxWFhqcFlyM09qWGF1K2d3enlZdXJwVmVZ?=
 =?utf-8?Q?MtXMonCyArV8KF1CV0=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4324b6c9-490d-4c93-1ac7-08dd873a90f7
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:26:16.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4PR01MB10890



On 29-04-2025 09:54 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> +--[no-]outlook-id-fix::
>> +	Outlook servers discard the Message-ID sent via email and assign a
>> +	new random Message-ID, thus breaking threads.
>> ++
>> +--
>> +- '--outlook-id-fix' will attempt to retrieve the ID from the server
>> +  irrespective of the SMTP server being used. Use only if Microsoft is your
>> +  email provider.
>> +- '--no-outlook-id-fix' will disable this tweak irrespective of the SMTP
>> +  server being used.
>> +--
>> ++
>> +If not specified, the default behaviour will be to enable the tweak only if the
>> +SMTP server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.
> 
> I found "irrespective of the SMTP server being used" part a bit
> confusing, which seemed to contradict with the next sentence to tell
> you to use it only against Outlook based servers.
> 
> After reading the "If not specified" part, I can sort of guess that
> you wanted to "irrespective" mean "even when we are (or are not)
> talking to outlook.com", but it is still a confusing description.
> 
> Would the following work better, I wonder...?
> 
> 	Microsoft Outlook SMTP servers ..., thus breaking threads.
> 
> 	With `--outlook-id-fix`, "git send-email" uses a mechanism
> 	specific to Outlook servers to learn the Message-ID the
> 	server assigned to fix the threading.  Use it only when you
> 	know that the server reports the rewritten Message-ID the
> 	same way as Outlook servers do.
> 
> 	Without this option specified, the fix is done by default
> 	when talking to smtp.office365.com or smtp-mail.outlook.com.
> 	Use `--no-outlook-id-fix` to disable even when talking to
> 	these two servers.

I'll just add this.

