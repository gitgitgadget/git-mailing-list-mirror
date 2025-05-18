Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019F2D023
	for <git@vger.kernel.org>; Sun, 18 May 2025 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747545963; cv=fail; b=ctmFX3BHomRsBOi3og2WkDftSv5hYWHu5L3h4eQrAIwsQMMfY/PWQuyfCqhJz9yHyQNToS3dj8QVOtXFSMSkR9buYmFUmIYXOmVTaWnTEU7n35o57J0R1pI49nVHV2Iegyk4CFWuTx0fbPRMRKQSnNkbA4ayrQtRH+fcm/2ZkvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747545963; c=relaxed/simple;
	bh=E+gZv84fhFJAvRx5rW3ndIMFsbe2xLEl6zqT+UHDE6s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T+Hp4c5PEzYk0J1hQtEDL0zoxD1N0OqKbZ6PEXc2YsqNdlXNrUsBfrRV77jGTKtFYc8BvP2dObDDIHrqCD+6OSF2So5VXh284YERIP4VUyx3iimvlKeH3gWTeEDbb3MUqlg38NyTu0rX+lhKWJwUOwYEY08XYTjfi+cppjxUTYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rSgtSs3Y; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rSgtSs3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnaEFfRm/HTzO9N7GfCeyEJeUNsr4m+NnbnwJ0jMBFSv6bRB2UME7lvnEUtWJYwGiJ3FfGlYOI45hjwXTGt8ULiuCBxYs9yY/h+2nZkNG4IKcLFooNu87zT1fPWs+DHij5EKnzl7DrKExwYnvBIjxdk6x4R7rdOTt8CfvqDukWC1kL+xKfOA1wYg4IeLFQRhVr6XR97p8ccnLzYB7tzrsI5B6CQAi5H8VRjSL/ybDAs8ZnUqhsT3DnBykdwrZdeCbdMpyofTePpcBqEa7JOGOH9vJ7kCV8QfoGSpC5Jz2ytqNfp+KIQVjt79/BzuEckHhXwBBz3LoT1VOplS6KitzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y96/XJ4mRfcFIBxXUurpg7H31v6cLuX8PKo1Bmog7n4=;
 b=ngLMwc0PQBLDjQgSLcQIX1jEbwgBhE/9m45mShokrMbSWc5kTfvSQDZJGA6PXwj8u9u8qu9Uy2VBNIISGgukFcRAqa/vsRfIanSq5OELiRsqF41tuX/AXORhU0fKiFLlnvKMHN6KLlpMtUzAx54+hXAgSbI0OWNATxWa4wMVLRu1tqCJEGyWmaxcSmusZpI4MIqFFUZP8ClNxkR7xa3hBehRLVh/2bfI8z4qqyfKxtKWiCmrkkC3cKnu2cLRcLr5ygHI/ZEgV5v9dYD3b8nIasqx6hgQm1dGX4BonqbJleGrfCMQfSK3lJeg2WSYZOl+oMM8hX2eXDaOXhE0LHs4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y96/XJ4mRfcFIBxXUurpg7H31v6cLuX8PKo1Bmog7n4=;
 b=rSgtSs3YwCb+h+1MmIMI5BRKiTO7L2ZH1mYcQOSn2hB4uOdgcKMSAGRlFZWNmjhRecKV+DUUge47Hf3WDXptlcsKEHxPBtoEnm4PGaMRFGhDD1h9Vxna/Q6EUng1J4ZBGnAFOWgHVVnXCNukoBl9eS/6cYaUERCRsvPVxLzAnbFpU3pms0rXrlsJfxNYsouHIpmUIY1X9AFgsy6o4cobwqT3YLZlDc8BXlU7s6aGjzAj2vtDPAk6MugrxK+9wnBvoZzHPqwj3FzVQ8CNSj+dYxvvjfwxjPioAFUYhUiSBtZ5Me+6tT3LfD1Or66GH0QpXe5b4526zTlTnQAiAA+vEg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB9288.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Sun, 18 May
 2025 05:25:57 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 05:25:57 +0000
Message-ID:
 <PN3PR01MB959730D1273DD2BBF79F0CB6B89DA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 18 May 2025 10:55:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (May 2025, #05; Fri, 16)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqjz6grtbx.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqjz6grtbx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <c0b51b6e-7cf2-4ed5-874e-f20dfe9c4a21@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB9288:EE_
X-MS-Office365-Filtering-Correlation-Id: 4066a111-b54e-4a12-e193-08dd95cc7781
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|19110799006|7092599006|8060799009|5072599009|6090799003|461199028|4302099013|440099028|3412199025|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWlWbmhWS1pwZENqMXRRTTVxdnpTdmZBL0h0NUlrTURZQkFZdXY4SEYwdGto?=
 =?utf-8?B?KzBsNXVnS1F5SHVUSFVhdDIzNDZxbllxQUw1MWppN1pOL0x1Z1ZWOHVwNWhH?=
 =?utf-8?B?UklacndocVQvdHNvL0ZSWVBIVThRbnorZm52NWgvQlN4b1ptSFFJQTZiYTFw?=
 =?utf-8?B?NlZLZ3E4cWNiUE9wTDVQeldTcmE3d09hcjFjeDhpQTh1SkFVYWhuK3dPR3ZJ?=
 =?utf-8?B?c3E4OHVxVTAreG1Ldyt3d2VDL2lyUEQyR1hPdk45Y2E2eTZISEdpSVhPWXNU?=
 =?utf-8?B?cW9Yci93Si9wZjBzZ2ZLN0lqcUQ4TDB1cDEyL2Z0OTBQam1xd0t6UFFWdnN0?=
 =?utf-8?B?VHhWTGE0SCtqUWRMNEVlNWFRUHIxT1VHQ21hK09SRmtoVUZHSVBLelIzREQx?=
 =?utf-8?B?ckdaVkFSaGZRTEpzOW1ySUNQQ0szYTNLWTdiMDZ3RFVwUWN2Q3NESVBvOFVZ?=
 =?utf-8?B?SHU5MllRZ25rMkVNN2thcG8wVnk5c0FnaU5VR0xXaVVxdXpmT0I0YnNLaUYx?=
 =?utf-8?B?aWFvNGMrQXFrcVNRQ3dGTk56UC93dmtvMmlFVlVpbUt1ekZWdHF1bjh4ajYy?=
 =?utf-8?B?djNZN0FBMEhWa1Y4N2M0azNlRjRhempRNkt6TExoVXErS2xsTEZIcnRjWTlF?=
 =?utf-8?B?OHhBbkc0bUdRMUxDS2w0K1IzMWZPM1orWVpxSE5Eb0FNSEJjY3EvdUlvcWtT?=
 =?utf-8?B?bzhueTczZ09BVGVOWFhYUnd6Yi9lWXV6QW1nSnMxb2d5bVIxOTZWOWhFb3JU?=
 =?utf-8?B?aysveWNJekphbVBSR0lFZ0lIeVhnQ1JkbUJoRnZRUHZxR1JjQ25zN3JDWFht?=
 =?utf-8?B?NjdaQzFMSnZUSFhNN0ZHMXpPYkI5Q2c3ZTBPdVR4SUQzUXlwUjlTM2pmdFFR?=
 =?utf-8?B?WGl2ODFjck9VMnZNb05IVFRLS1FrRit0VFFLS0Z2bE9iSHI5UDdOSzJsVzF4?=
 =?utf-8?B?WUcyM1lOYmpLSk9DV251SkZuSVk5ekhIWllBRWdNRmM0WS96SHIwRzhLcjk5?=
 =?utf-8?B?dGJuTGhoenlNM3AybjF2SzdKcmVBSmlOVHdwMHFQVHdBKzdYaW5vV0M4MWdQ?=
 =?utf-8?B?NXFFa1BzRkZFVmVHQ3Q0Z2RGVDlteURPcjlTeUFaUTRoTGJ5OS9zLy9kc1da?=
 =?utf-8?B?V3JydlYrcFBoZW1XRG5HZVNvU3h3bWlFaHlFSHhkRGxvMXQzU2Q1dHhYdFRm?=
 =?utf-8?B?Y3J4YnUra0NuZFVuR1dVU0hKeWF0eDlZK2JtaGlDTlBiZks4by80KzJhNStD?=
 =?utf-8?B?bzU0VFM5Yk1RYklxUEYvZ2ptMUxnRlYvV01tVmFvdXRUZG02ZE8vbzNtTlgy?=
 =?utf-8?B?dGR0NDZFQUdYdzhRQmtjcDg4dHVNTERwaEI0TnluK0lUMTF5NkVyTS8zT21m?=
 =?utf-8?B?QVNBaDlZMWZsU3RXQjVkSk1IR3pRcHRzWjFNaXljUWc4TmozSENIYlhGY08r?=
 =?utf-8?B?eVIrSVNxRncyYnNBaXRlYmFiUmQwY1VFVjhHN3Q3S0MxWi80TmhreHF4UVoz?=
 =?utf-8?B?bUZwZjBSM21GZW9tTk9GTm42b1g2bmN4WFRhVlpNdmV4YXZ0TVZDSlN3TU92?=
 =?utf-8?B?VjkvdXZJRW1iOHBRL2czRHQzallORDFpTzFsMEhGdFFwdCtzOUdhY2ZsVGFL?=
 =?utf-8?B?SjlSSnJNVWdselo3a2hyTzJVTWQ2NkpWcW9UamVsS0tMTDlIUENUNzBGMW1I?=
 =?utf-8?B?L0J4UzVXUmF2cEllN0xtSXB3SG9sVXdVWnRDbFR1NSt3UTlQSkcxQm1HNyt6?=
 =?utf-8?Q?mhUSE7mcPFsdGjUWrk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDEwL2dnSXpnbjJVdnVHbVdxaDhzVXJjSlVVbjJpMjZqT3pLV2lyeFNFaXNY?=
 =?utf-8?B?NFRlWUd3QVozZmtFTVJjblRQOGE2NXJweGhiYjJxd2FQTHp2QmJoUnFtcjBp?=
 =?utf-8?B?THdkTnRJbkNhT1pTQ201VlF5alJaMGxEM2o2OWVJMThsK25mNnJsT3ZCTE50?=
 =?utf-8?B?OHpjd0hTR2dmUlQ1aGphdTJreUZhemRKaTA3b0hoRUNOOUVqc3BnUVc5Wjg0?=
 =?utf-8?B?bXdOL3BYOU5pWXFQcFVuNlNOSFd6Y3ZPMExUWGxleWhwa3hRUkkwNExYZlk2?=
 =?utf-8?B?d1QybjhtN0loZDhSNTdKOGV2clJoUk52dkFMMzMxeWw1Q0hWUFdFQjVpckhp?=
 =?utf-8?B?cHFzNjNmNzl4SnQ2YlBSVnJ1SlBraVF5eHFGNU45QTUwREh4aGZEam93ZW9T?=
 =?utf-8?B?SkRiWTdKN0xueUtxYTVyRnZ3dTBSMUgzdTFVTjN3WWhQZVZwd1Q1SlZGeTRO?=
 =?utf-8?B?TVZyY0llOFlYdjJIT1NZOUJ2RWQ0aFlaUVJ4SmMxNXlTbGhyZ1d3bWZ4N2ZJ?=
 =?utf-8?B?L3FCRExiTWhpSTdOS0NvZisyQTBwcXMxRkQxSzJUOTFMZDdWNGp4YkhjK3Nv?=
 =?utf-8?B?SFBlZ3B0REE4ZmFJcFMyYUdYcUZzZE5VU0M0QzNicHRJdVorcWIrazNQVE9h?=
 =?utf-8?B?cVdHWldlczZ6WXVraXFMbFNMZHVnQUl1ekZzR3FZZnFuN1FkNU1vc1IzY3o0?=
 =?utf-8?B?bG9PZS8xYUpCOURyL3laN1pnUDlXbUZ1c1p3TmhYQ3oxbkF0L1N3K002L09K?=
 =?utf-8?B?bDFPcTk2dWErT2VrejV2ZFpHREdsWkFWbnN6THhZOUdmNm1IZlRqcE55RW1r?=
 =?utf-8?B?RkNrRUVmaTVDSWNKYkI3TE53ZHZrdm8vY0U0Q3hmQ2xyOGlRNGZEa3pCNG9W?=
 =?utf-8?B?bHRvWGE1em9zMVVIYnFRSm44VlhiZDh6VEtwT2tuT2FGY0s1TTBSTWtWY2pU?=
 =?utf-8?B?aEZ6RmFvNmVHSFA5c3JsVTExeDlJb0dlalJGdTQ1WDhCZDV0K3MrYXdTbkFy?=
 =?utf-8?B?MGhsZXJROEZtSEtJWEpoS1YxeVRKWSsxd3labUUzTmJEU01ZTmFtT3JJNG1z?=
 =?utf-8?B?TDFralpCdDZmZTNJYy9xa1pXZVMrdlhRTlVINkJnem9TU04wQWU5UkhoK1ZY?=
 =?utf-8?B?cG1EZUhJY2R4S0RlMXVZTGRXckYvSEZIWG5lTDBpWHBybnE2eUFDWnJ0WkNL?=
 =?utf-8?B?UHVIZ09BM0t1UmFrTXBFU1hUeEtMbnMzRmRvNEFhVzlDbWNNZldNeGhVdWFU?=
 =?utf-8?B?ZVdDQXNybkt2dHpKZGxiYkh0dUQ2QjUrQTJ0ekI4cUI0YUJZU1JIc1JVSzdY?=
 =?utf-8?B?NnpuYWcreWlhWDJSZnhpV29CQkZoMEdxbEdWeHdSbmEwc2ZBdVdULzgrR045?=
 =?utf-8?B?ZllaSElxd015Y2MyVFRsOWRWWkxXVytZRktQRTl5OHY5TE1MN0xySkFNaktv?=
 =?utf-8?B?czV1K2FBMVRhcDhvay9WTVZERklWZGVtNWZTVkhDQzBJRlhkR1BHcXNqNnI2?=
 =?utf-8?B?VllzTkkreGFEeFlyUm5xazlHblAxQnJHd25IcWJHMjlIZ2FKN0tkZzNTQUVh?=
 =?utf-8?B?aWFiTEY2eDZ1MDhzNDJCTmRRMzNYZTVKNzdBbEdBdGMxUFlhM0lIZEJFUGxu?=
 =?utf-8?B?MFJWTUovZkt1KzF4bUJRQzhqTHd6Mmg3M0t0cW9rbUhLUTViRncvRVcwWGpR?=
 =?utf-8?B?Zm5QdlNoUUZLb2JENkZLUHNMV05zZ1kwMlFCRmRsT3lIS0JaSTNLMU1aSW9H?=
 =?utf-8?Q?Qn/Ek4hGJlXkVvx4O1nd78sciYVXZPU8h4WEgGq?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4066a111-b54e-4a12-e193-08dd95cc7781
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 05:25:57.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB9288

> * ag/doc-send-email (2025-05-08) 3 commits
>   (merged to 'next' on 2025-05-13 at 6eb746c6c2)
>  + docs: add credential helper for outlook and gmail in OAuth list of helpers

Patch in the link below is technically a revert of this:

https://lore.kernel.org/git/PN3PR01MB95974833251AAE9531F8ED62B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM/

Rest 2 are fine

>  + docs: improve send-email documentation
>  + send-mail: improve checks for valid_fqdn
> 
>  The `send-email` documentation has been updated with OAuth2.0
>  related examples.
> 
>  Will merge to 'master'.
>  source: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
