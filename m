Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979428399
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924444; cv=fail; b=kB6b8gixIiQabCruTvlAC8JT18jJavr6yrIJSD0iq9OUoqm1JGczIQc7YnvJtBVNfGjpyxwdyQWQOyujllr8Y7i778SXm8NflDeHnjswftHMbA5yNkAJ9N/65kLqkLr2jUoiT6xr7hk9NjxcPBGCerMHJcuBWCczfPR+5hJWciY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924444; c=relaxed/simple;
	bh=66bJ5DMpazf7+3g7xdNmnrBht2E7sdtSp3/386FXWDo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T4bsQmLFglxdsB6Pgm/Hh1HP6LKBdcaM58sHf7V9guGprn0h4WLiedx8+59KJhxFTvUeNpZSE3CFvX0Uh3yJUruwXAaE4vnDrXJDZukF4KY0nSd5Da9e1jOAC/HWuMcsH6wFgF0u5TyBAQ6bRsRneX9XvMWCwVL8VyGzBRvW9Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mDdQ6bPz; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mDdQ6bPz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1EsqtKM0pYyffb5y2uBDd27npi3zjk/Kf+VxZIZoNtYEc2Z6inaEAtXDBjDyHlUZtw4bOFkZkKUXsaypW8qCotzsKus3XY9QSJ428fk/7rgCfE3kkNo7W/vRNG7fH7NRqjpUHJy1B5TQvGRagpP1bfGcZj14HSQ8wtctfC5FQQ8pIKAyBjCFzw/PkdjR1q7sdJJ+1HF6Kx1T2XMm5w0adj22mSMmgMR6LfrJHKhyjG597EpZX+FNnunW4EDN0slkjMJDVrPGPhxOmzIipkLUEpHFa4zBNID3ulGD35/oblmVZJ9L68Cd5YKh5vn4DKmQUpypYDFhyLhNiv56D7KUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9rprrw1RmLhFDtAcHCOQAAMK84tyrKxyFU3fShjUuI=;
 b=EC2VH/r7UAVbe6r+eDYnSOuUWo03AwjwSzsfG9cHJ5TLeKeQCUFSNOHSSxOiPE0AJdyKaNLj2P24DvgtuA2ZJQtFVTFNOlvPcA22wvZ0Wtu2YUIcpV4Slz0nXHUNf9e6YzzThsuMkxyz57ibEc8PmMO5GlGM7V7QGD5WqxUauoMzuE05pVhZ6rDkuOxF9S2dM8np/fVbKJHQuqIQaMt1JUQgdpcFsZRhAhf70mlVa4gFpT/6Px5kWFsgGJ7Yw8ZlBNGNqD326ESY+O7fiUARHU1ecJKT/J5Spg4IieFLDQV9+FlZ6hBp8+xZogNiJO/ocGArw4rxNcnyKpOQ2GQYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9rprrw1RmLhFDtAcHCOQAAMK84tyrKxyFU3fShjUuI=;
 b=mDdQ6bPzEojfx9Rrp61oJmx2Nb0++scbU+8ClXUT/3ADec3dsqEelNij12ZB14xh6BIhAMf9W/yBWUIb+M/jsvObkPPo22uuz3aZWcp2syINJFS6qSUrm/dzRryypLHhJBssjLDAXK1ipZWU+CxUHJjguW6B2CdYdwQslkLCorY9Yc/9b8ELD+NiG/UM609vV89aZlk1O7NBCoEhFJocztHA/NVLdWH3axRS369w34u9t0k+6WQzO4mvzft4PdQ3dNoikanOsN6zjYmN8qzKFFLInd1IOqxHNSq5HEGXebbHS6RThLiO0fXrMmvhzHYk7ebB8RS9ZdRMhlvB6Xm1uw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9743.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:170::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 11:00:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 11:00:37 +0000
Message-ID:
 <PN3PR01MB9597BA68242D6229F2662F97B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 29 Apr 2025 16:30:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] send-email: add --[no-]outlook-id-fix option
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Yao Zi <ziyao@disroot.org>
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <de5c8cc1-e006-441c-852f-d32c7ac1d27e@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 50302bdd-5568-4c0b-4ff3-08dd870d128d
X-MS-Exchange-SLBlob-MailProps:
	7qh87CJt6y1ZnXZw9s8oIeZlMXmhQCjQYbyJW/9Q9bC1mTbWotkJ4S/tgzCdWObQ06pL2asrv0YfSwC6OjI5pfbwJ8jchxHUyMaU5MyEAsb2O/GCPYfNb8Pk1ZpRSQB8+E7+m863aeSudFA6/d7elhwQQd2QIIXz4ujpxy/2nJ0iD2k1XjMPe/H6lJONAOdWuQY8wpDtEpO+m9UXNCQmKKnTx660GjUbEE3wNwtcN1HCmnVNVqCSLQNey2nOjIjQ5VMrPAbI96svKDUBtx9hpuY9vRP8SBGkToIcuwlQ2l5qlH+w7zpnk9pWuRKIbTwNeC0jg7IVp/Pr5VR6SOi7nXVuRi//TwJXUnA2aDXKQ3LrVUcEoTjeipB2NfrHr03a+DdrW35vM3eE1yMH2NhzXm8lNEp6o7TvhzEVnxE5DNoUzOFiBDzKQVhFrTU5eTgD80Kc4bbv6pIhEQ5e9O6tTmi7hlMYEF1BtSBoPfWo+CX8qz8/RcKcDW7rxbMHNoa0iP5r7VZD7iSZu/grVoWLHxeQ+rs2nDsXDWYHXPUShpb9EgadH7FpzdvkTZxvYffDuPUKXl7X2BzgnFkSHXPNE1yfpj8AhnrUcgsshwSzS7oGw4b70JF1srWj/Cd889NL+NTs8xoQ/EplQc8kMHVgjynuNqPRp+P7/ETp5rMt6qqQCqsKygIW6tYEPvcAF8R2Wj4IRtAN8KH8jR+SrXBgkgE4wQUZ+TZyTH604xoByRF3oTDRfQv/kX7uug7A3pru
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|19110799003|7092599003|8060799006|5072599009|15080799006|10035399004|4302099013|440099028|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2tFWU12eWJxTjV0bHBlcFpKeXJsaWp4d3BETzBuV0QxbmNEcWYwdFpIQ0VE?=
 =?utf-8?B?SlhIRTBzaVFTeFlTa2JpSUNSbUNZWlR0dDFmbFFuUjg5Z0Z3RXBqSzFrWnU2?=
 =?utf-8?B?RzdtclhKbXJuV0NMVk1UYlFuL1dDWG9waHdtaUczNXVkVXU4eVhra3ZTMjZ6?=
 =?utf-8?B?TytDQ0FsYi9ORmh0NUVaK0h2OS9RUjgrUXZtTGgyTUs4b1JITzRUNm9CVFFr?=
 =?utf-8?B?cnE4bmhnbnFGNDdsdm01ZWdRdnNDVjNxVHRuTXRIcEFqRVQ3WURvRFFLc2ho?=
 =?utf-8?B?M3E4Mnd1bU4vekpkbmVJZFR3cTNYYjdBQWF0M3dPOThadW5rL1Y3RlgvNnVO?=
 =?utf-8?B?YVU1QUVjbjE4Rk9zYUZraGc3Nnh1L1VtUHU1dHc4VFlaRk9tek9MOWpWeUpI?=
 =?utf-8?B?RVNGTmJmVDdZRnppQTN4bkFmclZtc3dXcUtWMFRoQ3dOTU55MTQ2aGEwVGZE?=
 =?utf-8?B?NDhHbUk0amtCUlRISUtSYXFiN0NnSlJDWFAxa0NvOGFZMG1Ub0N6TGFieUps?=
 =?utf-8?B?SDFUeWRCeGpJQlh1aHVXYWdsUUNjOHd3VWIxUDV0dUFiVnZLakI4RTRRZkE4?=
 =?utf-8?B?VVdwbHQveUpod1BmckJxQjh0cTdXcjgvT0VkNTRPcW1kMFFiR1k3U25wRVE5?=
 =?utf-8?B?TjNLazgycjVIVHhsd0JPajFnZHkxcjRweEN3akhRR0FkNW42R3lYdk15eVdM?=
 =?utf-8?B?YWhlWG05clVkbXYzZWxzcHVZaEpEbG82NUVjNEpvZHYrRU0xTktPTDhvMnpI?=
 =?utf-8?B?eUt0UDRaQnVvYVpydEJRd1VabEZpU01Jc0RLbEJ4VVJLTC83WnFSRU8zWGpk?=
 =?utf-8?B?b3FIMDY1SjZMbjlhMnBLVEovdnBNM0V4MStENXhJVlh6ak1yMTAxQmRkQVFj?=
 =?utf-8?B?WWlFZ3craVhmd1lwdmU1RXoyZVZ4aS9hVHJBWWs0ZmpPVWZnTkJZSGViK1hm?=
 =?utf-8?B?QklacjRFWThwemppUzRXcXpRWW9TRVE2dWJtemhnQkdvOVdFTldyTjU0cnha?=
 =?utf-8?B?SkNpc0pVUElOVkFST3FqcHlyelBjckxZVlF6MmFlVzNxS0xGUHY3T0t4N3VL?=
 =?utf-8?B?azd2R1R4T1hPUDNxNDlaN2loS0t6WS9wTURjOVhEMXJndTFmem5LN0NYUmw2?=
 =?utf-8?B?dHdhQko4ZUozVVNOUWVKVzg5UElIMHd2VGJ4WTREcEpkR2RzYjZsUFhiNHpL?=
 =?utf-8?B?RFFsVzJmVnE4dExOQ254dDExTWZHQ1dQU1VxNmpkNzMwRUp5WEIwUXpUU3RZ?=
 =?utf-8?B?YjkwcWZldmFvRG5ZaFJTSHlJenNQR1ZTRnJNSGJXNzJDUVdCSy9hbEMwTElK?=
 =?utf-8?B?VUpBZnhSM0dZYUlmaEx4WGN1TkkydUtjZ0R3QTRNdXY3aVp3d1RQZUVzZC9M?=
 =?utf-8?B?WTZNVEE2a1lGZ3lROHFJcDdlbjlhWVFFZDZJMXdqQ29mdkEyRHBuMXVYaW5a?=
 =?utf-8?B?NFh3WkRiYTdpU3lSdmYrTkd6ZjdJczBWTjFjQnZ4bkl3dUVDWU1yK1I5WDVi?=
 =?utf-8?B?ZCtWc2NRL2NqMURnUndsM3ZnT1lSM2hGT2NrbGtoT3I5R3hVeVY3LzJ1Q3dY?=
 =?utf-8?B?eFVJeW42bzNyRTlxeFZCcHVVWWZaazZEL29ua1k3UGpBa0J4TmxUdW9rOVNC?=
 =?utf-8?B?eERFQWg3MFVEMkZReExwU1lEL1ZoTTRpZEpIZFRLblMzUzFVejFQQmJ2V3Zx?=
 =?utf-8?B?U3VBdG5mZ09uYllWNklDdW1OZEhCKzRUWmxmdWx6cFozZldQclc2SjlleG41?=
 =?utf-8?Q?qisDpGyRh0l349xUkk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm9aWjFYSkFhVTROWGFLVVJTMG1tOXlya2N4ZDJLcGlWMnN0YU9vSklNSjIw?=
 =?utf-8?B?b21CUEdnTFNULzh5NEU1T25oRUlnMkR4QWZSTndIcWlHUmgrNGl0YllvLzh1?=
 =?utf-8?B?VFdsRzd2TWlnT2tuTklCd1IxYTNrRzNGcTc5VWRUdVVuRTdyRGxGOUJjaUJs?=
 =?utf-8?B?WWFWUWYwb3NKd3Q2dnpWQXFVMDhOQVBhditmeTcvL2QyTVdMSFV4Nlp4QXVF?=
 =?utf-8?B?eE12REdnSzUwN3U5RTVZeUJQck01b2MxNjExRjhhWmJvaUFvNVBJbmtlc0VO?=
 =?utf-8?B?UEFDWExUanZ0QTFmTGxFV21DejBENDFkU3RKTks5L0ZFUEppVTlwUFNHYWcr?=
 =?utf-8?B?SmZiUWFsaGZraE5sM05OUXNLdi95NGdqd3NGWGhhMmlYSWZjd2UvanVlQlV5?=
 =?utf-8?B?OVBsdmVFaXh1SkY2bDdSVDA5T1ZWcTBhcExycm5nWHJSSUNnRFQwcGU3VHJC?=
 =?utf-8?B?UWVpRmR6RU1Mc05xY1ROWXN3VmFyL1JYTVZ4VitrRCtOUjc5dm5nNENlNWpR?=
 =?utf-8?B?RnJHdDFjTU5BcVN3WmxxWG51V2dRUEtUUHprRExYWFhUdURrenNGTXBtZzdt?=
 =?utf-8?B?NEFvZnNZQU5EM0srNFdhM3hTWDlGK2V1NWI3MnRiV0ZnR1hoUVZ4d2Y0RW5N?=
 =?utf-8?B?OC8zLytZdEpCZk9Ea1dRZWcyOUppYTk2aTBsN2gzaml5ak1zNjB3RmVhZlhp?=
 =?utf-8?B?Q1JLV3cvc3VVR3Q0Rit1TXNhb2JXb3FNUkdCU29jUTA5QVVsN0EzaEkySGph?=
 =?utf-8?B?OEhBdmlpRnlSbUFNR1d4dkt3WTFGRUpZVHVNdStyNkJZdXJWbUVYTXkvNGFR?=
 =?utf-8?B?K1h3M2tGa3VPZU9jUzZoZG40cGEzVVJsM1BSS2pLSlJvV09MUWtuNTB4aHYw?=
 =?utf-8?B?TTNXcGdQVXN5cE5zckRZSU8xOWk0aFJSVzZuWkQ2a3dNTHFGcE9VWEJmYzFt?=
 =?utf-8?B?SUhQWGltYVFpY1BDYXEySnNWbTJiNGkvcDQwNTBMZklJeTBYbkVTcGdlYUQz?=
 =?utf-8?B?aFRVeUtRbDhvcWpvdjZOazdxVk5nODhGNnVsZ0xxakI5Ukd2NEJLbWl4b0Ix?=
 =?utf-8?B?elNuT09HQWZUZ1RHTnYvUmllbDA3OVk5ZmgvL2FkN1psa0FkTzJBL3YyMElv?=
 =?utf-8?B?dUdObmE3R3NrU3M1amc5WHJ1TTBaNXI0TWd4eFVTTjAyNWtmcU9lS0JBSkd1?=
 =?utf-8?B?eWlhV28rQ1lmL1VnVmI5S3p0TU85RmpOWlZEY05sVDhVWDYzUEh1TzI1cnF1?=
 =?utf-8?B?cGpBZC85eExTalk1NUsxVXJzTXhFRjlISHhrbHRaOFMrLzhjejgwaVRsR2Uz?=
 =?utf-8?B?SGRrRnlpZWlsQW40YVBlc29lemUxYjc4SkdGOHExNzJpY09vUVZURjFQdHlM?=
 =?utf-8?B?WEgrRDl6U2dhTlVlU09idEQ2TEErZnc3U2VHY0F5dXg3VE9ESW80ZWhlTisw?=
 =?utf-8?B?SjhHZllvSmlWZThlQzhINS9xT3VXbHNyZzliS0hwMnd2b0hwWVR3d0hYZCta?=
 =?utf-8?B?aHF5MjgyUUhpT2JsRjNEVmUvd2lWTW1FYzJsWHM3VS9tM3VpZG5GYzVyTG40?=
 =?utf-8?B?RXl5NlZoT0RkYjN5d1VYRDR5V3hENTZnY3A4alpobVU0SUxFWU5EZnVyWVBh?=
 =?utf-8?B?NVBlbjlTeFQrSnZuKzV1cGcvOW94cFIzWWozemkxV2pVODdqSVpMUHJ3M0V2?=
 =?utf-8?B?Z25mY2VwMGlRdUpIT2xWL2pWZU5zclNLWHpZejRDNlhWVEtHU3NNQmhabWRs?=
 =?utf-8?Q?mCm5Bt2sQYSHWy6ZTSUMdABmnWZtswuHLYspoW+?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50302bdd-5568-4c0b-4ff3-08dd870d128d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 11:00:37.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9743



On 29-04-2025 04:22 pm, Aditya Garg wrote:
> Add an option to allow users to specifically enable or disable
> retrieving the Message-ID from the Outlook SMTP server. This can be used
> for other hosts mimicking the behaviour of Outlook, or for users who set
> a custom domain to be a CNAME for the Outlook SMTP server.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---

BTW, I am not sure whether I need to send this patch in this thread too. It
is a bug fix, which I encountered with my adventures with git send-email.

Link: https://lore.kernel.org/git/PN0PR01MB9588EBBF200EA002E558D4E0B8872@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM/
