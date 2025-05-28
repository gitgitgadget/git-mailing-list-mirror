Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14B2472AD
	for <git@vger.kernel.org>; Wed, 28 May 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426760; cv=fail; b=FRU+M6PpHzEJ+dTtSCIcmjkjTa8mcaBW1TikaZkzyzlG/FUtQNwcV6v5tG3ZyBcTq/YWFR1qA0W2zfoLtdsSu+vF/oac4xIUSTKWTD3kv8SNlxRh0hXBJfeZ7e6HRRNJgxzG/6c1e1q88HfHQIdZT4vML1bhET4UG90lKTWX9X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426760; c=relaxed/simple;
	bh=FzFTaxpozcVtsAte+WA9qhY5W7713Bt/mVF02VpBqUQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGxDMs9Dy/zYrs4xFAv3SU8BR04zt6nGDg7D4bCgLbN9bNWFp6Ln+scODJTwmNDM/a5NiQ1/0ZgoAr1I1mF+F1HWmrNVlbc74roStnRny9kokphvL+URFZaYGLapLDGx4YZewYtRffB+gVTC0Z0HaUAOxpxzK2id+tlnVZwtVAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MoYaW7mx; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MoYaW7mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCPV3mcrNRQJKGitOAir+Y1Ol3gAkHh2bwVTg2PJ8k6XKYZA7nzDscu+D7smk+PbxgaUkj2KnSQ08FTR0cmlqb8lHIi3msVILL9vf4wVh35UC0pd8965I9GJcxYHLVsKmPhyZ0cWxQV9OM8bSSKFZjkh6p+TiCbpyXp/EmpMiHWkRyeEWQhyhw4YTzo6yuWnIxitdlVdYhyggYYJUYxV4nIQQwfOpB/pCkn/622novXUn+ysRP9Vr1qlq2tdIl3V8coHob6luZbIttkuP3DtgyQww2BiZCT0evto5RBfkilELACeI3kRU0foB7b7uuMUfXcLH/hSKGv9BVxHoOwSew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn45Xvt9tVZ+OwWx9r3Odxe2f4BWKeEbrLuZ4RALunA=;
 b=OW3YhgXoNDmnNStN+9v3B1BW3ouqPGfVa/2K877so6qaIaLPQ0uFs4qCjqc5xc2BGeGh+l7vYr/XeQMRJqQ173esoEKfQOW/n2LZnN4AfE9e1bE5EtORpy0t58i64drUlHi+iDXdQr8LkuJJEXTf4I7OMZR2JjvFXtGq60fH7iF13C8pzQIlR+gh2UVr/qUrNo9oaYoii4jhicHSi3mFa/Jpp5puf1ulTEZ5SjICC2UFmMDyIbLKm4k/rwnE7rHi9C/Jdt7sMSXzOB9C69juGGyOLwQy6/G0P5b3NgFY4pF/Mhb/NjEapDcVfjH/L+tmM4rSLYjNNvbQq18+qdkIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn45Xvt9tVZ+OwWx9r3Odxe2f4BWKeEbrLuZ4RALunA=;
 b=MoYaW7mxEJz6J6fO3AUv+ZCqWNd+iS1lw39b93bxDlj9IkFYZwXILeapUnYk3Ed6GkCXWdlWyFrVzbhuGLuyBeIb2FRAqZRCbUcmiI6SV8KvafhIVKqKCk54V4YI0z7VfsrFppI4z9HtCdopX0th6HyAMDT2NvEw0gHVq5PX44E6US9ap5IshLfSN2o/bB/NP/rhRYRSNIUNqjlQTc1PytyG2totMgCT5auroK2+Lou1lqHGeObnX2GACiqKSRN43vyn1crseFaZ/v1xIc4IOt90TY/idEbgpCiZQaYVzpq8Tx21d/XUMYuJ0ho/3FBmmCWer7Ju+0S3zpZ577L/uw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7208.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 10:05:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 10:05:52 +0000
Message-ID:
 <PN3PR01MB95971983DABB391AD64CB60BB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 28 May 2025 15:35:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] docs: update email credential helpers and improve
 formatting
From: Aditya Garg <gargaditya08@live.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
 <CAPig+cTs0+AUPp1euxqKkX0iFTdw9zGuMU-Qnp+ywhcyP8gxfA@mail.gmail.com>
 <PN3PR01MB9597EBE360893FA638B17952B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95972C400AE59DAB2EB388A5B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB95972C400AE59DAB2EB388A5B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <52af72dc-0a37-4cb1-ac04-cfa96d178414@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: 43649563-e346-4efd-d374-08dd9dcf3a93
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|21061999006|8060799009|7092599006|5072599009|15080799009|19110799006|6090799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVZhTHp0QnlIRzFFVVN1UkxEalpxY2VGYWdLU1VsTzJYUWpaRk9hNlFQSXRD?=
 =?utf-8?B?bnJtM3pCd005ZFhTZGJ3M1pqSkRFc1hnK1p5RytWNkFZM1RMelEvR1RGUlBN?=
 =?utf-8?B?Q2VUTmpJZ2VJNGlRSDhlTHRhNXdpcFF2WFFrNmd0UXNPYnpmRjBIYXlnUm9G?=
 =?utf-8?B?aExtZmV4dmN2bDBaMVkvOWpaalZVa1BtcXdFd3ZINGtBVW1KTTVoYkRublJC?=
 =?utf-8?B?a2N3dUt6RG9UNTM3eHc5QTcyUDNsTWNzWFF2Z2Y1eFowVVRUVTZlVTRjcllw?=
 =?utf-8?B?L25KbEQ1M2FxWmNrWWE4eTdVLzlldHJsYU1LaUIyWkhXMjZ0Zm9tcWFMSGo4?=
 =?utf-8?B?SkFpUEFKaUJKa1UwSldSR1cySXRtdlNzMFpxQlVaNVY5Y3IzdzB2U3VyTWdp?=
 =?utf-8?B?bWpGaElFbWxPbGxpQmFYa3YwcEUxcHJTbHFVL0tYTTBzbGo1UVZ0SjgxbThS?=
 =?utf-8?B?clFNL0NRVDJPZ1NsMEcwMjAxZlpvVnIxS01vL0YwNlhRenBXcFkyWXRJeVVD?=
 =?utf-8?B?ZEZYSnU0dVpRWUhRREJHWmJxazkvR29Gb1Z2NndsdUhZOEN2MGpadWxXZDNu?=
 =?utf-8?B?aUppN1RWSEhtM0VhdFBGRWlhNG9xVG1Va2o3SjJsRG9SQ0g2SEdmajdlL2ph?=
 =?utf-8?B?R0U5cTBicWRhUTlmUlZ4MVBvR0NLRWJSN0x0d01RcDRtSUZwdERtUXJYK0px?=
 =?utf-8?B?ZGxLcGlmbHJ6NUlmKzFUY0Q1ZmtDU0g5VFhGVHlwcFN1d1Y3UE9GVWdlLy9s?=
 =?utf-8?B?T3FZbE12K201OHd0ZGMySEhVaDZ1WDFicHRsTjJoSkhUcWdJZGdyb0dwMTFT?=
 =?utf-8?B?NytaT3RuSDkrMFJnQlVVRzJVY25KY2NNTWFvbTJCTEFyWHVUQjJCRVpaS2k2?=
 =?utf-8?B?cElCVWRjOHhmVStrUUdaQUZWWlN0dzNTNVFac0xib1F4eklYb3F2QXpIRzJJ?=
 =?utf-8?B?U0ZiRzA4VzFkM0lQazVwdTlBemUrODlyVm1FcWVhdFVtY3BuUUpjK2R1SXRW?=
 =?utf-8?B?Vm1Za24vdFpQamd2cm9uUjQyYXAwUFJYaHIvK0NmMnRBU3JqeXQ5cGhubGw1?=
 =?utf-8?B?dWVoY2R3OHpCZHo1MmtIS1RDa01yWVZQS3MwdlJwbDZlaHViUzVJSjhDajdo?=
 =?utf-8?B?bjJ2azNyYXhUUkVoamJsNW14UmtYU2Z6Y0twTmd5TjVVQ1k1SUlLS2R0bm1O?=
 =?utf-8?B?NHNtRDJhUGRpWEtGZlFYTTM1ejJNaHd2V1hmbFNjME9SZTExelBGWllPOGw4?=
 =?utf-8?B?ZVcyenRrVWo4R0VOQU9oQU1OUHB4QnJ3TG9oRlpwOWZjYXBuY2pkRytpeG95?=
 =?utf-8?B?ZTl3R3NmNUhrTWp6UjAxbXZTWjE3Y1RRZ0ZLOVRyRjdpOXNTOGhUdTlMTm1m?=
 =?utf-8?B?R0h2QUN3MEVPdGZpNXd0Zm1Vc3FpTFlpQ1d2RXlFQVJDNUpycHowWjRsYXh2?=
 =?utf-8?B?ZXZUSUx3VDBhM3RGeEk1Tnd2M2lLNEI5Vi9LZms4bGJEd2c4SHhURGhRRzVO?=
 =?utf-8?B?YkhQZm5RUzhHOFlyV21wU1EzZkxlUHE5c3pYVHhjUUxSWTc2WFR6YVV3dkVN?=
 =?utf-8?Q?jFLBI+QL8sm75/r3qWjq/tyVs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUMzcjN6VU03OURDMGxUOG9GamNvR20zMEFCcXd5T1hBOUdILy9YWktjY3Vq?=
 =?utf-8?B?WTlyVEZDVTNNVkRjWUVvdUkrTnYwalBibzkyeURjQkp0RmJaTEJyNDZCWnNt?=
 =?utf-8?B?QmNuZ0JXTnZTTEg5OFllU1pmZ2xaRUgzcy9TM2FodkVNSXpEZmo3UWRyS3RW?=
 =?utf-8?B?TUJCcDhzQVQ3dXNHNmpJTWQzekpDSlRNZGlERkg2RVF2c0FsVEw1bS9MeEYy?=
 =?utf-8?B?eGdwZkgycG1FcXg5SGxXb2dXdUNWMDhXY1NDVGdtSVBGVkFDaWxqMCttYzB6?=
 =?utf-8?B?TCtuQjdvOXNLKzdUbEQ4Q3NQR2Q5dEx1c251ZkNTRE9HbXNLQzlpNWRLMDhr?=
 =?utf-8?B?NVVnc2FDbk55Y2o4N1RUaWsvQys0ZlNxdWtsNUV1TEhVdXRKY1dwQ21KRFcw?=
 =?utf-8?B?d2kzQmdVYU5ObThuWXkrUXh2eGFYTWljb0FyT3MramlyYW9PU0JGK0pqMWFl?=
 =?utf-8?B?Y2VlU3M5WUNVYmZ0d0tRMUd3TjIzU3dod1Q4Rm1JTlh0RHRjMzlLYncyNEE3?=
 =?utf-8?B?WUpEd05IS2w4Z245SlNCM1BGck1uZHE5ZWY4RUV3MjRNYXpWZ1B3Szg2R0Rk?=
 =?utf-8?B?UWdZTnlmcldpNm4rUzNoUDkzNXJaYVhhS1oyMHduSDdoa2xsTUd0S1ovaHVP?=
 =?utf-8?B?TFFQTUk1ZVZ4MFBDSFNVNFkzanJ3ZnZFeG9ObTlRS2ZkVjFkUzVjVjF0L0tT?=
 =?utf-8?B?c0ZoTWo1L05QcHlPTFRUemJEcWJ6NDFycFZnOTFZMGdYUjc3Rk5PQWFBVXA0?=
 =?utf-8?B?SFhvZlluZk90aXlUb2I0bEZXNHp0cW5TclhPc2hueGdYSHZwQ1RWeWZPMk1W?=
 =?utf-8?B?NWdPbXo5Qnp2dWF6UEZ6NVBXaVNESDZPOTJBS0hSTVR6ZGtqM2pvR2dOYm11?=
 =?utf-8?B?aXNSTW00Tm5sdzkvVmNGZC9QOW1ZMHJ5bkJKYzVHWnhaWEcxbFpWTk9yNlJy?=
 =?utf-8?B?NDdndnY0UjJpSVBiOVNybkdtdmlGN0g4TEVhQWJCdmVlRjZDMGF5MXB0QjFn?=
 =?utf-8?B?Zm1ERzNXYmxDaUNqWHBrZUxicDg2NzZQNC9uMklzbGxzOVduR0RBaDlJZFJz?=
 =?utf-8?B?RjE1bUhHSEl4Q0RyVEpYZ1BXVFV6MmJYUFRrNk9aTzF0UWRjUkZjU3dVL0Ru?=
 =?utf-8?B?OTIzbExhSUcxRlBYcjlXc2x0UG96bnV1V2p1U1VBWkVvNkc2Z2x5NXJVRWhU?=
 =?utf-8?B?MENzYmRDelpQU3lZK2tLNmQ5QVdHTjhGTzl4RExDc1JHQkNvQU5KbU55b2VI?=
 =?utf-8?B?MG5pV0Q5SE1INnF6b3dka0t6YlE1ZHdoVUlQMytYV2lLWFZJRTl3NVR3bFJ4?=
 =?utf-8?B?aW1XLytiT1VrbENycW9CcWF0NVMzVjFxSUdCWlk2Q3ZlNUFwMUNzTVo1U1Ix?=
 =?utf-8?B?SzdVWlVZaDU0S3Z4anp0YXUyNkJZejdvYjdHSkM5YUNHcGNlelpvQUYrQStn?=
 =?utf-8?B?VnE4Sk4rY3p2V0tqRmEybDBtZWNWKzZ2eTJpb1phaHpDMkNlL1JyKzlJckRF?=
 =?utf-8?B?UlNIUENBZTUrOTlKUXNSNks4WUV2SjR2T0dhMXZvOVN2QlhldXZYM2RqRndK?=
 =?utf-8?B?WXlGa0lId3kxTVd6cG1SY1NpQ2grVGVsWkJyRU9YcStQd1FkRlRxbXpTWlFl?=
 =?utf-8?B?SllTd1pvaCtHQ2dYRWlhRTR5Y3R1MGpPZUxmenF4VmVNdFkyRWlmYXAzNTh3?=
 =?utf-8?B?TjczckJFVE9MaHpzUkhPNm81ZXpYc1djNDlUSVd3Z3BFbjltZmNqaXlQclNB?=
 =?utf-8?Q?Zc++vT0f8nTIv+sM0g=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 43649563-e346-4efd-d374-08dd9dcf3a93
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 10:05:52.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7208



On 28-05-2025 03:12 pm, Aditya Garg wrote:
> 
> 
> On 28-05-2025 03:06 pm, Aditya Garg wrote:
>>
>>
>> On 28-05-2025 12:53 pm, Eric Sunshine wrote:
>>> On Wed, May 28, 2025 at 3:05 AM Aditya Garg <gargaditya08@live.com> wrote:
>>>> v5: Added a patch to make the purpose of using app password for Gmail
>>>>     more clear in `send-email` documentation.
>>>>
>>>> Range-diff:
>>>> -:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and link Google's sendgmail tool
>>>> -:  ---------- > 2:  bc1d0471ca docs: improve formatting in git-send-email documentation
>>>> -:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for emails from gitcredentials
>>>> -:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app password for Gmail more clear in send-email
>>>
>>> Strange range-diff.
>>
>> I think because I used git version 2.43. When I compiled my branch with changes, git format-patch over there
>> had a very different range-diff from this.
> 
> I get this range-diff with git 2.49

Disregard this message, I just mixed up two different threads.
