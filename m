Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A881EB18E
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402884; cv=fail; b=NKvwgWCmDwP3rnB+ehcJQc92J1zAgJNSXoCdS5nobW83xbopW26AbcX21hn9q6LPXS54mYyIF23sk19H3cSn+rr7gzInVnhikn6e90WDXxf9dEEPz08OgnLUV2y9waQ6SWZz7IGwaGviZ38VhUp5noToBoOmNlX6OJGoZWg8jTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402884; c=relaxed/simple;
	bh=UnqKpE6fzrvxnXpBsx8OclA2NB9np1/S1CQhlT/bmuY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YF+mlTuqaCpkCHzcKHglx5p5yvSY2YTX7bhRHcFHlp4H4CpNbbR1GSRqOVwJEtXZ1SpcLlDDYRUr7SrWSJwPki2Bk3yNsc1B3g0JKxXR4516VcVpFVVUtp9Xb7PSCAEeUY44cTU2hGDWkPIaWdRI6OYspmg9mY18nJSEBToISDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ooy5ujOJ; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ooy5ujOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGzO/rt6CCp0TkmbdyxSyk9/FmzFma4w0+zY4WYh3LR9GbAi8DLX2SJXlMRDGSn/quAWXVR7GoKFL3Hq9fah1rOOHVoXt+KmnjNReZvxGl2lU31EaPIqCS1Xoe1y7/slNE+QoOo+Qsvf+y2+UxclNf/tNd6yMBIOp//I59p4cv3ozLO0STFPedqt9H60qk+RO3q8sg/bJF3EIz/PuGZpME8iO5Sb8C+NNvGxlRMrz7/sknlKOXM+HQKxAKqQ8jL/iR5Ija9c+UAV013ajZE2wyLz70rl2ae3IwZSlYnMHrj5bswifgeHWDY2Bi9fwipuieDZP+WMUbOvAY2Jj6JKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixkf67S/i44cSgZRETF4Km5B//1Em5CPVe9aXEep8F4=;
 b=quODu5DEpzowpvwr7qbgeOvYJKocM4NlGVjOAecLUaqp18YJ6IW8SxNG1d6zMl/NwyFoWL1vMBUfu9IHBqaeQPHGPcluC6DWm5dpYhmCrsH2kwpySzUuEr9pCzijzr6K+qT5JOQKwfquwZd0S+2CHMs2nt2duUVracNwJBNREKAZV+vKlKmur60AvKPHktJ9Pzgxm4Mdk/Nz8aY0YrgT4v16CpEZ1ETBOEqOJoU1NsDgz35hBdmBbahROd17hp7r8bIltqMqaXe/B/ulsOukD7j2Tz6k1mWMyLCFuwC2MXtZuX1vdyhFmulmEwNauA8AXv1N5eFAtv99kh9EcDr2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixkf67S/i44cSgZRETF4Km5B//1Em5CPVe9aXEep8F4=;
 b=ooy5ujOJ7fg0zt0PSsnqRPZFOehZt4Di7uik5jb/a7yf9JZ9d3kqx4aJwkW2OD3UeBZGforH9viouwF/c99Ed2AgENogMUc1GLRKQ0tguWr8R5BId28GeRSfxFDXJkj7ivSAuUM6wVHvKgEm0uZiaRxpSiNaUIGKnyeCkjPFhpxM2T16xuBfRvhLOs1nWi5cy9Dw9mpPFNWcEaF2UYT3bqHEA72aXP38R+lJHkiGonuiP/DTjJVrpG0o39resAitMp6sh7l+izZuhKD7ouwQVbQBiuT9IV1UNPYKvswzXRVIAktLguzvk52hmh5nzziIPwRH6I9pdzG9snfNY5wkJg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4274.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:13::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 07:01:17 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 07:01:17 +0000
Message-ID:
 <PN3PR01MB9597001636F70B33B52650FDB87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 20 Jun 2025 12:30:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/10] imap-send: add support for OAuth2.0
 authentication
To: Phillip Wood <phillip.wood123@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 "brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
 <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597607108917195B9690F67B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <F0A06034-99B8-4BD1-9CDE-515A3EA430DA@gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <F0A06034-99B8-4BD1-9CDE-515A3EA430DA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <3f038dc3-8148-4681-b9ba-707ca9daa7c9@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PR01MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a837dc3-c278-409c-8245-08ddafc840c6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|15080799009|19110799006|7092599006|5072599009|8060799009|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU5QakVtcnNRNlNDQWlWV3h2bk5Pd2pjbHBDVXNwMmVhZ2ErZzRSL2xSb1ZR?=
 =?utf-8?B?bjZsbm9Fa2V2WFZGRHlhREVBOTZ5c0lTMWVTeXJjTGxnNGhNNGswNlFZSmhQ?=
 =?utf-8?B?WHd0bjd3a1VGNjhCditiTk13R3QwbVVXQVJkUHppTXZkbld4L25ocE9oLzZB?=
 =?utf-8?B?UkVJT2dFTkNNZ3NyTEY4RzcvZmRyTm1BWDU5WHRWQlVTMHdmRFVFL2FuTjh1?=
 =?utf-8?B?NWtFcXRHRkZCYjNncTlCakRHTUY0dWZMTnlsRnFDRUp2dlVDWlBwbmpZMDF3?=
 =?utf-8?B?VURjamVxRURnczB4UmJ6T1QyUFd0WmU2UmhTRlJsNWhaREVyZ09vWTBsMC9N?=
 =?utf-8?B?ek1WTnVNSVVmRUtYZFlZblNlRktzWE1NMDQrODc1MWh5Z2oxVEdZcEhVWUho?=
 =?utf-8?B?NWlQTVlycEl5L2xlWllOOWc2UHVycDR0SFJDV0dkM2RhVi9veTVLNjk0U25T?=
 =?utf-8?B?TlBzZTRQc3dsVXgxbm9hdDFuSGtCblUxWUVUMU9tcC9PbktZYnV5WlkrWnd6?=
 =?utf-8?B?djMwMGxBaThHOVYwUUE5TEx3TGpBbFJVZ095VkxkYVJucnVzWHJaOGlIVnMv?=
 =?utf-8?B?a2d0S00wYWErN1J6bHdXMUprV01ZMk9wSzErdVlsZkpRNWhXQ3VHV0Iwc0ha?=
 =?utf-8?B?cGVKRkJYN01jdFB1N0Q1SGFRMDVhUTB5Q3duWi9mY2R3a2lRTW4vMmdJUXhi?=
 =?utf-8?B?bEtNZzJHTEc3YTBkdURIQVNkMFhIUFdpNWhGeVNmWEowQ1JIYTBNZkZoRjhj?=
 =?utf-8?B?VnpxR2xJTU5RK2hYSStwMnhHNFlQLzcrTkRxR0pubHRjZEk1STIzTE50SVo0?=
 =?utf-8?B?ODNDYnpGTkt3WUZKUmwxbWpDbmJyQ2dGS3NTOVRKT1hHbTA3QVFjN2hUeFBa?=
 =?utf-8?B?aTBTaUt0ZzZrUmJKQ2hwdXRlRG1na0ZkZHd0V2VvbFFjL2UvRWNaTHg1TFpL?=
 =?utf-8?B?bUNqbnduUU9lWi8zeE44YmpnVHdYSXJPNEU3WG9VdmZFT2xDV2YwV2R4OU5X?=
 =?utf-8?B?SmY1S3VjRXR2bEtrY3AyUXVqL3BxTHEzYXZISkJnTVdxcFhnZjdDaHdCSTdW?=
 =?utf-8?B?U2VZazBUeTBQUUZkeGx0d24yUTh3NTBOdSs3cEhoVTRyK1ZEejRJaXJUdm1q?=
 =?utf-8?B?aW9FZWtQSjdlS01qMGhITG81RkxWc3FVeE1XRVo3eFdiWUYzcjZWK002eHF6?=
 =?utf-8?B?YkZDK25uTm9MUDdEVGRXN2NaVmN2dWFHVXpoa2djVXJGQjE3RmFVdDZUS000?=
 =?utf-8?B?R3JaYks1YmV4ZjRoK1lGczM0RHpPNGlpRnYrUEhuTGtxRW8xM2NzQVkwdlVR?=
 =?utf-8?B?TnVKYXpPcGt5bmphbzFGOFh2UTJmS1FjbXIycWR2Q2dIQ29CUm00SGRRT3Fi?=
 =?utf-8?B?a0xjbWNQMFhjay9MT3o5RnZSNDhYRjl6MmdWak1MOTRtRE1TUkRkQ0tua2Qz?=
 =?utf-8?B?dzRIWk5lRXA1RFpKQjlzKzQ0NEpBMkJzd2h1cmtkQTN6Q2t1Rng0T1JOMHVy?=
 =?utf-8?B?R3hEMnl3RzRGS3pmaHY1QlZ3eWEwS3lSbTFyemlmS1FpeEpGU2I5OFpxZmFv?=
 =?utf-8?Q?qS2EZ8pspGIroT2DbJ6ROFvNc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJBSGMwL0lFTGY3czA3YXlmVjJmZVFNVlVIM05tb2VIcHArdW5hZmQxelJM?=
 =?utf-8?B?K2JVTS9jL0xMT1VRYTJMb0xWME1FOW1VOCtPUnlXVFFDNVNDejJNK3BHSVAz?=
 =?utf-8?B?R1d2OFdNMnA2by9yK2xUUVozMS9QVjRtdGhMbjlwVlM2YXp2eDdOOHBaejZx?=
 =?utf-8?B?QnV0ckE3WWdaS2NLNWx2NTRQVmJwSUhoZFkxU3dMN1VnaDJ1L1lkNUxUci9w?=
 =?utf-8?B?ODVDNGxWR0NWQlNOSGZjaENKS1lUVjBlZ3ZxVlFlNWh5eUJhN2d1Q3JudzVW?=
 =?utf-8?B?b2M5ZzRjeFQ1N2NRS1JEUEJmUEh6Y1U1dmdwYlZmSlYvUWNuYlRzMEJoN1Ru?=
 =?utf-8?B?bmUyTFZQZCtWMXBpSUlNdm16ekMxd2puODRHQ01aQ0h4NGdyVlVLcWJaYWRF?=
 =?utf-8?B?Qkt3RnJMb1BUK1l3azJtMHBqNjRCSWxQaXQ0YUVscWR4OWNRZVpVODBpTzd6?=
 =?utf-8?B?SUM4cTlmUlNZMUZWNkJMcjNhVTlUK1BtU3dnQkRxOEpMRHZ1QVV4VEJIc1dV?=
 =?utf-8?B?L0dZTGZlWWxLUnpGVFBsQXFjWms4Z3hrS0tNU3QwcUhQTjhmNmZUS2owVlBz?=
 =?utf-8?B?QkwwdFM1SlZtNFJjVjNwSXRSZGNnUVRBUmRLMUE4ZFlTV1FaMXpUdmN0ZHpO?=
 =?utf-8?B?TUtHeWFIRnNXNC9DR1o2UHFIUkYrNjI4RHVISk5taVhLL0o3eXl2eExpeHU4?=
 =?utf-8?B?SnRhMDAzaVBac0ZINXM5VVY1Wmc0bkdobVdYczNETXZtUG5HcHp2bXRRUmla?=
 =?utf-8?B?dVpCSmFpNUp3VjdOWVh2UUxzTFFEcDBLVVJPR0cybGR2VTJjNWpzSnhIZ0p6?=
 =?utf-8?B?U3hDZ2FScnZTM3B5OGxHdXlxRGlTTEk1TXZ0aFQyeE50V0dQK3Z6QXUzMFAy?=
 =?utf-8?B?N2NZaEVjYW5mWkFMWlIrM3lKbDU2WkVZRkk2WjhKM1lCNUM2OUQ5VWJnNEQ3?=
 =?utf-8?B?aXQyeUNVZldUdHNIRStXS0NObU5HenlzZHdWNUNVdU9UMkhEY1RXU09xU0M5?=
 =?utf-8?B?L2tUTjBBa2h2czUwVG4rbVYyM1d4cmZGbGVxTHN2NG1sS011OVBacG5MdjNF?=
 =?utf-8?B?cUMxVVVVeTJhTEhlelVVbDBxZm9uUzN4Um93OUVlUXRScE5XYTJHQVplSStP?=
 =?utf-8?B?NDdBZ3RvRG9UckZwQ1FJZ1FYTHZpcDQvSlhRMGFWNEpySXdqditZbnBYa3Yy?=
 =?utf-8?B?MEd3THdjTUs0Sm5KWFBhYlViSXg5QnZqUkFHSUdBZmV3VG8zK0hORmxPWlVo?=
 =?utf-8?B?Z2F1YzNxc1QvcldMdGZQRmgzTXBxb25MRk9VMXkwQ3hzRmtCKzJlSjBhN0hC?=
 =?utf-8?B?NFFHbWp0RVZBZkJRRGNUOFIzdWJaMUV1elZWc0V1enQvcHlKNnJxUEJ0Ujkw?=
 =?utf-8?B?ZlpvNndxemRYTTFmRlU5RDJzcVZldjVVMFdsTUhENzRhSHdjV1JHTm9NcGNu?=
 =?utf-8?B?anVWcWdlWHQ5YXppVk8xWHl6RmJsYUhyRVpvaW5neVVHV1BhYzFXMFlWdnBt?=
 =?utf-8?B?c3FhZGk0d1plSXlaOUxsRUxmTUFUdEUyckFwVlFRdUZQT1YyNUU1aWVLamU2?=
 =?utf-8?B?VVJZelZTcTNoNDRZK0VHZjNNU0hpdE1DSUtENlk0V0FkakRUNTJSMXFCeG5z?=
 =?utf-8?B?SVF0T3p2KzFXNTRsMStMTnhMMWNHRkJudkVCSDNCWEtnbWQ1enVsak10cXpJ?=
 =?utf-8?B?QmJjRC9ZcGo5Ny80WmZDRTlSa2s1eTBZN3Fub3V5Q3lCUjdwb0xwSXJoUDdi?=
 =?utf-8?Q?tW8xI5C08SqCuXcWOU=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a837dc3-c278-409c-8245-08ddafc840c6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 07:01:17.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4274

 
> This looks very fragile. It would be safer to use an strbuf or if there are no embedded nul bytes xstrfmt() and strlen(). This applies to the next patch as well and any others that are building strings with snprintf() or memcpy(). 
> 

v19 should have these fixed.
