Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC7E1E3DD6
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942231; cv=fail; b=VvznA1cAoEAo1d6uX3YOnbdwnesAyt/naO5TGCRhn5HT3ZYcodpy/3AFQNW8+0+7m8mQpu6coPJyDa9gGw3/DQhbZmI0CCoQsjcyU+y7e+hZFF2Nt1fYWhOV3f4P+fmz4OyOUxTnRERnmr2RZ+E0kubv0ykHfNPduFGFsqlnzao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942231; c=relaxed/simple;
	bh=VHYHoZ2zDE4fala1n+YMTFv+ZsknzT7Ck39wgsXp0Fs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CirWJvlKP+kWczC2C4WjDU8Fqucp1ee35t29tmxl6qLAeHcdahjnCGyJa766PMcNY2vefv2mqmaCOmgVS4EwY5EqU/38yXrX3JTgB9u1n7UTPKVNvPDQpwpWKBXF3+VuVOZurMCnDWlOf7fEVxSSzdOEDsladymXoUTqHxy/NSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jIAYtRRh; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jIAYtRRh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB2HLgqVcbuin47IQzznwJILTyjADGcOE/OabCpFi1V8LpY5cE445qwdGD1gSe2Fb2aet2Qo/RwX0BHHiy1hpB8GydTY3lVgsstNgDqzQfoaXhPZihse2ulbOzn/IsyjfAXT4VZCuH6YWrG6+yhGQA5fTDoV9Zg5uienVaSsaaVMOR40vDWysLvevM8djL0WkVkLC/ZzqXaMXWRkeunhrGMPaUiDgaGx3eL8gAqkinY9bGjqnvf1YbBtjRNPIG+TUJvUfZ7C3fG/h3xfAwtXgDyMkinEarT2N9J63BQfGvpBb2ysz5THPy6B6wkHCibv9QiVr3lL3XqfdwyitrliSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbCzTXD0WzUgmNpFDYYS/lUFiPwEIfGkvP038gfQLoE=;
 b=EYBPXeTUBf+2HfHzU7lCgmQTTcVMLzlDE4iZyTGul35EQfC73G1hkoscG94hO+wXhlxsG66d4cXtkQIlVoOQaUE1mnY6tiigo963rXFZbrrOQ4nOptqY8f5LATK6k/e6kM7ae6YKkbBjFCjEUxX1yDaDdKABR88FLaEdJithFX860CdjjU7NYpvjxLAu4gDbQgmH2jwvXaMvvBNfrVSk/H2BZbFs0F0WlMX5rXJf2l7jKchQUH2oib6yvtggNNsUCY9f1W8ZS8emdaxtsVjd8nwQ5CGG20PPUsjS8RqtSJ7Hw2aY8wlRDQD/Oyc2fi4e3h2yWBQ5Kuz1xQLdt6hZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbCzTXD0WzUgmNpFDYYS/lUFiPwEIfGkvP038gfQLoE=;
 b=jIAYtRRhhSr2NFwjSmWTu6s0iG7+DCQhz4/B9upCffncftUuPgB9TJV41Pe66J/h4XXjO4P3kHiFLwpiq7zLSfyzboXziQ/Mlhma4PkRWmK3cW5YOmJl9AmtUxCX3zOdm+KT8B59/CG9XAVCWeqIi4D5IkWgYZ1orNT4amoZWKarvVrS7P3GLKfMJ5MzmdjZSakoGFsVOpBEgHFxatFQ0degaH3YGXddG+Ahcb08Gqesxd1Z+BG2/kqvHQWro5KtS1CmEeQ0TfIZGRmHR1MPhI+Gxf5SmEKlMB2bkCEK5a+nBWT5W22vK9X8d51aSw6Rk8QNoTOvIJaQHJhBhKJQGQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAYPR01MB10746.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:153::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:30:18 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:30:18 +0000
Message-ID:
 <PN3PR01MB95972EB02A873B8998F51877B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 23 May 2025 01:00:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
From: Aditya Garg <gargaditya08@live.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <adca3a3f-c239-4394-adc6-5268cc669753@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAYPR01MB10746:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d08b212-566a-4143-36d9-08dd996715dc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|15080799009|7092599006|8060799009|19110799006|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bllMNGErL1E2ZjFrZ1hucS9GVEcvaFZlY1FJaWFQWDNZOHF6dHlwWDNaWTM0?=
 =?utf-8?B?eUw3M2U0ZnMvQ1BCLzlkRmdnL09wMDVhdVpsL2F4VFU2QXNYVG1lWEJUY1dh?=
 =?utf-8?B?ZGN6Y0hxNjFtRWdKWE8zZmIzcGIzQ2twLzNDTG1HV1ptbmpzMXNYUG9Ya1Np?=
 =?utf-8?B?Y0pRVFpNMEtGWlRlSG84WG4vQmh0QmRkVzdzb1Z0THJGMlBNZ1pzdEZjbEo0?=
 =?utf-8?B?UXFObmJzNkhLajhTNFQ1b0NIMFVsMzNRbWxOM2Fab3orWnA0OGlob3pSK3pu?=
 =?utf-8?B?K05XNTBpTEc2WVEyOFZVSEpVVE5jcUEvVVJqYlUyV3MxT1Yza2hSSVowNkJR?=
 =?utf-8?B?czJRaXNZSUdhbGVQTmhReCsyTEwrRHczT2RjWWk5bkppb2NZMEVsUm8vMHls?=
 =?utf-8?B?czdwMmFPQ3IvZ0MwdlVVWjYxM1FvTGJJdjc4OERmWUgvRnJxYTNGSlVRWXFM?=
 =?utf-8?B?R3FmdnVNb1kxdTBiTThiVG5DVlQxdnFNMFNHRHJKZGU2OFlwaUYvZ3FPQjZ4?=
 =?utf-8?B?aFdOQU44cmM4QnF6RC9zYnlRc2hDa0kwMkEzUkNKZm5iZmNZbk8rOE0xaGN2?=
 =?utf-8?B?Z1Y2cExzR0J5Uk9vUFMrdXZRSUlCL0VQR0VrQXpsUkp3MTF6SFhLMU9tdjBa?=
 =?utf-8?B?T05RNCt1bkxMcUZFdjRETjZQanJKY0RKQjIzdUozN0d1OVB6Q1VUSFFZSnJD?=
 =?utf-8?B?TGhPeTcrblVucUxicFdTT1pYNUhaQ2JVL2pwRk8xV2FhcHJFRXUyUEt6VDdO?=
 =?utf-8?B?YXZ0dHhpZHk0TE5JemdLOVVKUXZYdytKTlUybU1LVjc2SWpYaGtNVUJ5S3hP?=
 =?utf-8?B?ZkRoRDBiNkN6Qm5qUHVJTUd5Rnladm1zcWd1WHE4ZUJNdDV1d2p4b2FJQ3JH?=
 =?utf-8?B?bFV4ZkFwMmdPZUI3ZUNxZ205RHhpdmNySnFqS3VKUU9MRXEyR1lKOElyTFBD?=
 =?utf-8?B?Nzh1M0Q1aGxMTUtEOEFTYm0zRnNHVUh5S29oMHdJelpPQ29HTTE3QmhIUnNC?=
 =?utf-8?B?bmRUczI4OEtGZVJsaUZIV0o2VnB0UUlJbC9kZ0pxRlBEK29QUDdQSXdiTXZZ?=
 =?utf-8?B?ZHh5SDIrb0VMKzFPNVQyWmE2YkJmUTM3Sm0xTFRENThicytLSjl6eGxaaXQy?=
 =?utf-8?B?K0pHREhETjRNREJEVDFjZXZGMUdvMWlKREkyeHl6d0R6WTZjK0lzSUlKTWcy?=
 =?utf-8?B?VHNSdUZMb2lQSkp0NWhIREdFenZuWWFMSnhMRTQ0Sjl4MkQ4eFJnMlByUmVU?=
 =?utf-8?B?TTNPZHFaNUNIbzNGczZvRmppc2FnV21XOC9HbEE2aVg1MFIrbnhnamJibGdT?=
 =?utf-8?B?cFcvdWd5WkJZZkkwN2Q3bm9DTWR4UGtXMHRwdU1TejliZ25TQWlkeldTRFdh?=
 =?utf-8?B?YThoOHVkZW5oZVRIanpIOXY4UkUvWExCV05BVVY3dk5XNHQyUnA3Q20wRkJY?=
 =?utf-8?B?Y2tFWFI0ZEpITWpiNUJVd3FhRmtjWkl4bmdYOWhaMFZBWmVaUUxnWWs1QWlo?=
 =?utf-8?B?RC9CT29aU3NkWExkN0dHeVJqUUdhQnI1ZjUzaUJubkpsYUhhclRkRnl5Q1lJ?=
 =?utf-8?B?Mmg3MEJVbEdDNjBYVjJBMWJCVFQxUVZNQWk2RytYY0ljZ2EwRE1tQ0VGaG0r?=
 =?utf-8?B?YWx2NTZNaWdqSFdhM2UzWjBZRjBWNEE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2VUdGsyQnpzbjNaZFRkdVE0T1ArYXdQVVhFWmVEOG40dituUGlIekhFTVR2?=
 =?utf-8?B?VXpMb01KZXh6YmRTSUlYV25CeWVKVE9hQVp6aHByc255MCtjaWUxbkJFK1cw?=
 =?utf-8?B?RmNIWXIyREFVYktmVTliMHllbXlvd0FZWXRBdjBnOFdyT3NQdVg3NWJvb2Yr?=
 =?utf-8?B?UnRhUlFXS0hydEp2M2ZzSUpXSUdPN3c2V0Zaa3dIUksxVzl3TlllK0xPeFA5?=
 =?utf-8?B?Rmd0N3QrcnQ2ZmFSdjYrUHFMSTlYZkdhdmxGR2lPRVg5UXVINTIrTXVpVVA4?=
 =?utf-8?B?U05jME4xRmhhVEEyVGtqS28xNDd4MnU5aWp1VlU2MlJxY3BhN0hTaDNrRU1G?=
 =?utf-8?B?RE1acVVQYkI5Zmk0UEU0b3ZHSzhDNkR1bzZ4MjV2Ym5hU2tXcXhIcDdyVEdR?=
 =?utf-8?B?OEduaUljRHQyNDlyVFF2Ny92VlZIRlpXdFc3MmRnaG5UQi9jYTV3NThyMGdn?=
 =?utf-8?B?eVd6SjNHbUhSbC9LNHU1RjhLUVBMb3RudWJJT0IrUDdLQytlS1NmRmNraXBB?=
 =?utf-8?B?L2ZuR1gvcitMelA5QW4vQnI2djdzNmRhTVY1YWdGVkdaanJPcXJ6ZVQzMW80?=
 =?utf-8?B?aEh4YTZ1SW9zdEVVQkNKZGJHUXhsNjhKNlhUbUt5UXBBcUlJOHlKbGFhU2dM?=
 =?utf-8?B?aVlld0ZuNUVQbGpoajNCcERPUzdNWXM3RWNHeVdjWE96ZE9KMVlTejRwcEtM?=
 =?utf-8?B?K2dSNEFJWnhEL01PN3pmV3RXYUliMGdGdHFBNDk4Q3JtY0xMN1hwamRsaTZa?=
 =?utf-8?B?WGpGTU9jVWdnTEdEL1JzNnlpKzhCU3ljck5admk5elBGNUd2djFzMGZlRHoy?=
 =?utf-8?B?UXZMSDZDdHBzbG1BT05DK0lYaUlGalpOV1EzN0ZRN1NiRjNzME1TSnF0SXFv?=
 =?utf-8?B?T0psOVY5MUNpL1NEUVJva1Q4Tjh2ZmZTY0F0MlNtNXd6S0NGZ3ZIbHNrOWQ0?=
 =?utf-8?B?QXpDRFdrR1JQeDN4ZkxvWEl6QjBXd1lMUE9PTno3SlJuME1MVnV6TWZ5OVUw?=
 =?utf-8?B?cGNIRmdZdHorODJ2clV5cnh4VzlDRmt0YkNZa2Ird1EyZkpyeVU2eEdLN0tJ?=
 =?utf-8?B?L01IU1BwbEhVOGQ5UTJCcEs5emJtazVrMTNuWEhYcFdoMnE1ZkxuSkt1OGpC?=
 =?utf-8?B?TXAxTlpyNjRDWFh1QTZiRjVwTzFXSkhOd0VPbFYxSXc2RDFqMS9yVE1BOWhv?=
 =?utf-8?B?T2JqUnFRaGttU0lvNlkxOW14V1V5M2tkdmtNcEdySURadkVnTWtkbmtUbUxp?=
 =?utf-8?B?V3ZOMzZnR3IzMXBQVVBQTHcxVmtWNE5vWTZkaVYyYUhIQU4vTFk0STdOdHlQ?=
 =?utf-8?B?RG9YU2o5NGpzRXBTQnR5aGp5a1I5SXdPd21Qendwc2F6Q1BOWE1vcU1MMDNS?=
 =?utf-8?B?ZWt6eTEybWRVaE5aTVYxNDQyUlhwZS9vdmdtVlp3ZDVUMldqaUlrRVcxYlY5?=
 =?utf-8?B?VWtzamk0YmZvaXozVmlId0hrclFIQjc1RHptK2NOR25YRmNrVWppK0Q2RmVq?=
 =?utf-8?B?T2Y2MUprMmtGL1VTcGZ1NlRJcTAzcTg2QXdNS2dBZEZOa1RUVDg4SFJCY2Vu?=
 =?utf-8?B?amFpTGh2QnliL3hOZnVIQjRibyt0SUJXRWlLN0E2Tzl1eEwybDN1OWdRS2s4?=
 =?utf-8?B?Y3lhRWQwcnliUDk2S3pZNXhFNFVHbERkekIzR1JmSzVqV1d2NVJGaUp2ZUZQ?=
 =?utf-8?B?cXBtdWlqY283UXU4Z25ha0hiWWlGYks4QUdzS3RuZmpYSXpTM01zeElXanp3?=
 =?utf-8?Q?8Iwc/TWmrK1bIbRM8c=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d08b212-566a-4143-36d9-08dd996715dc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:30:18.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYPR01MB10746

> Not sure about server_fill_credential(), but I think this is also
> a potential memory leak
> 
> static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
> {
> 	int ret;
> 	char *response;
> 
> 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
> 
> 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
> 	if (ret != strlen(response))
> +		free(response); // fix for the leak
> 		return error("IMAP error: sending response failed");
> 
> 	free(response);
> 
> 	return 0;
> }


So this change leads to:

  imap-send.c:990:2: error: code will never be executed [-Werror,-Wunreachable-code]
          free(response);
          ^~~~

I think it's better to leave the other leaks for a different series. You might want to
treat it as a bug report as well.
