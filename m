Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011025.outbound.protection.outlook.com [52.103.32.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F4244694
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061106; cv=fail; b=eZbDcHXGsIbzx7gyJ7r8At+Rri5/D3g/6sZdNG+/MhFWsVsYn2mtFkEIkDEUxc0soFfudxka0iuVXWFRWq/nY9PM5Zp0uZRaO7iwneseN3hwvZgeFPNZHK9f4f688EtsCqTdonJ2iqnwJH6BW0+47h7CO3aP+sOlyoNERzA/hYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061106; c=relaxed/simple;
	bh=1eGQyh+joN0Un3MytGj7Et35Txfc128+yojO9w9cd7k=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uwCTBg5DGnAmnqEFkvzReYRnj+f0ZHT1W0yStZ6ZETFgEPhTUloOqfpBvtykLe+YqRse83R2LzNtgbvNb/tPKMRcqQkvJPJyKwazu9i2iE7UTK90tPwKv0q71kYxmV0tyRCmm40xY8aqgKtmISM+aH7cStZHWiPlscphAIYH4BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vJsL+Z05; arc=fail smtp.client-ip=52.103.32.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vJsL+Z05"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJzq7JGJsKeoCXOprAxIL31ITxvV4tDcBaLlQgFsTUor69gO/ueqylf3+skSGaAqUF5S9pldNm/Lp2eaQmxWyvvS4R0g3oXoDPzfYSd8sa/NtE09aJkiOW+ZyMXZIZAcCuswFvRoFYHuc41510QJoLsTJdQwB2aUYIxSliRviXlMz24YILH7fdwvzFourUWoMH2AK+9zwRdB+0GuBZJ8y2ynsmbyzm1X6zeU7KZyoITjmRcR91aLSzj6loGKa8WfuGIXhkUKTUWHGv+9y7nbIjFs+QhcrP7GNnCG6J5UUJEdOPII6KFsh+ks/oHjb9U/cLRH2zAjcIpcPs3/G8o55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eGQyh+joN0Un3MytGj7Et35Txfc128+yojO9w9cd7k=;
 b=L7BE6saV7SwKehMp7tEVXpQRbMtK4qsNzV2CRSvIaKhrh3Jie0NutgqbFyeD9TaNrugrQxzz30rmUD3mURiPC3bkoY1dfeOEWpBBlWyWAdx1UqT7MmuqDLOqTZYzd5WEqucXazf9lfx05AqNa09uj5VAkrHG1yGA/IEbO0n4gTVTwXNeuO475JKCXPdbiD6jFbjJP5h4QlhMti0z2R77VXp0kJrfXJFPIgQx2sVZoHr/IbCRXqYvGdHyuP96r4fhRnVsyAVbwnxp7VTYRGV4dEoyz7wGCzf402nCGT9YPlF7xxq8LBEn6f2QQy1rTF2LOkuxVtBxxjvBx34PJt4LPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eGQyh+joN0Un3MytGj7Et35Txfc128+yojO9w9cd7k=;
 b=vJsL+Z05OkJPvn6d0gAMzJyWo9+v3asfkLN+iWkGPWJW4skPawfu4o/jOkO2nqYlhtTzdpXPdy9aJLHxtGT/HcEjaENQeLkIwAKMb8ZTFRedbHgkiaX7iRnD8izlflD888DEtT8VRJjEYSgc/QTrZFzZZnGis7yfZYQ2Y+/4XdChQfIvGRm4i1KJGIbPQLCbUa2RvjnFwl4p5KAU8vg+y9RANYLT8zrCYbog+/FzJmwiKhiTr7mZ7OJ0qu9Rnd12zZEHAvDDH24eKmbOwURRxCzLLRKAt/vnYDecsFpFzjWuWft/ByUp6C6VhvREylUpI80EhtVyxJRIAJuoQMjs4A==
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com (2603:10a6:803:82::29)
 by AM7PPF3041E2F7E.eurprd02.prod.outlook.com (2603:10a6:20f:fff1::809) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 08:31:42 +0000
Received: from VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f]) by VI1PR02MB4271.eurprd02.prod.outlook.com
 ([fe80::473a:177d:640e:c07f%6]) with mapi id 15.20.9052.019; Fri, 5 Sep 2025
 08:31:42 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: Haridas Mahato <haridasmahato12@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Topic: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
Thread-Index: AQHcGR0afBR4UVFtH0y7jlWzQ0OEhLR6DyAsgAM/ILKAARBogIAF69kQ
Date: Fri, 5 Sep 2025 08:31:41 +0000
Message-ID:
 <VI1PR02MB4271C163F38DB205BD30FFE1B303A@VI1PR02MB4271.eurprd02.prod.outlook.com>
References:
 <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com>
 <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <VI1PR02MB4271CE7B8F32225C98A2DCBEB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <VI1PR02MB42710CA61134BF19214F855AB304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <DCHIM5YWYM7F.1DO69EZ20ONH8@gmail.com>
In-Reply-To: <DCHIM5YWYM7F.1DO69EZ20ONH8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4271:EE_|AM7PPF3041E2F7E:EE_
x-ms-office365-filtering-correlation-id: ffac9e46-96bb-449b-aa4f-08ddec56a410
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|461199028|31061999003|15080799012|15030799006|52005399003|40105399003|4302099013|3412199025|440099028|13041999003|26104999006|12091999003|102099032|10035399007|1602099012|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?clYrdnl3ZlRpMGprUFRDUThuNDQyZjNGd1JLa0tRNFV0T1hvL1NDSjRLWCtv?=
 =?utf-8?B?NnVHWXF4UzRTcjdlRDF2MklpT0twSlBnQ2dPMTYwc1RNR0RpSXpZZFpIcFJL?=
 =?utf-8?B?blkrQktMZ0Foek5lSVhLMlI3UDNWdjZDWG5sZWFRbjExaXIwTnExQytxZHZz?=
 =?utf-8?B?NG1nYzZ0L1ZtVjltT3BEOVFybFlkakwwZDAwNURicm5QQ1VHdW1paEVSNnFS?=
 =?utf-8?B?U2d4MDVvWDUvMGxwZEd2d3krQnphb2VpRkFybDE1RUxScHpYb0xVL1o0SmVn?=
 =?utf-8?B?V1BXNjZjcTBuT1dJQm96YXN3aU9uTXJ5V0MxU3dXVkJ2dys4aXM3Qmw0ZnIy?=
 =?utf-8?B?MFV6cDZkNE9EN1J1MG8yTk51VXZJZGZwT0V2ZnZueU1BazVTSy8rdW1PN1Br?=
 =?utf-8?B?aEthYU9YWjNzM0k5bVBZekhUWDd0NlhkYmYxWjRiRWhycnYxVFhRS1FncmxE?=
 =?utf-8?B?TmFBRlV2enl3R0J0bmRabWRMOW9ybXVNZmpnTmlLMW1IZjNZa2FMWGdTOVNs?=
 =?utf-8?B?c1ZqZ2o2R2tYa0oyYlRvQk9LV2Y2dnVGdkw3VTJIWTlhVFkxME1RR1NqTDBT?=
 =?utf-8?B?aEpmcGQ5YTUrUnNmQmFBU2NHaG9Ga2Z3T3RXTG13RTdwb3dkUjFwbnhndlZJ?=
 =?utf-8?B?K0RYWXVqWk5ielJCSHgxNHh3VVc3dVdseWZiWDRTRUttK01nTzA5d2dIMVR5?=
 =?utf-8?B?WmpqcHlBRSs4MmUwa2RLMEJCL0JQcFFiZ0lqaXRwdHNDem5oYTE3MEFqYzJi?=
 =?utf-8?B?QWVvN0NPSEErVXk1VzJmOGoramgvc29qL05xcmsxVm93NEU0TEw1eHZPVVBy?=
 =?utf-8?B?M1R6UTlZTTlLVHplVkloWk9jeWpXbjZnUXoxcU9oVVN1KzdSQmw1Zk1GWStl?=
 =?utf-8?B?bFhsTHVUa3kxRllzVFMxR1RxVGdRdEZjL0R6aEJ4b0xUZDlkRmRhT1Vaa0Qz?=
 =?utf-8?B?ZzJGdFZFVE9mZ0tFcGFnbFZYMkxLcEtybGV4VFEyL0orS3NDeU1vZTd0QnR2?=
 =?utf-8?B?RG8vSmQ5OTA0TFp4NjN0UG1jNHhHWDBFVWtkWjhLMzV3YTN5WWgxMjBSYUx2?=
 =?utf-8?B?UGpVRGFnaDNxcVZUZFE3d09nKzgzNEs0SUFLR1dCVW43UTliU0U1TWsyMmpC?=
 =?utf-8?B?cGc4ZXdHOUZRakJPZlJxOEVLUmFvWXFEb0M3NVN6V0h4Y3R3czJtM2hKTWNW?=
 =?utf-8?B?QThZWHZuK2RTckJEaEwwNjRUaEJCTm9mdmNIM1VZblVScndXU2hVNWRiVzhh?=
 =?utf-8?B?NmxxRThUdCtKWXNxRmFUZmFpWm1aeEthMUtXc0xuUTBKMmF5OGNSQllCMmdq?=
 =?utf-8?B?eEczblFkQUxkS1YzZFBOdkhZSnZURFNKOFpTMUhuOVRIWkpNSWhvRktGYm5o?=
 =?utf-8?B?Yi9hYTJvaFBtbW5jK2puSDlVVVozbkgydjA5aXJhU2d5bHlOMXVJN2Z1T3dI?=
 =?utf-8?B?bTRod1ErMzMvTk5NaTlTNDl2Z1krUnBHbkFzT3ZUNjdwTXZSaC85ZFZVMlNm?=
 =?utf-8?B?UUt6QWtvRG9JQ1Z6VStsV0N6eVU5bGE4WENpSmVocE96ZjZjcUJwUjRPZjNL?=
 =?utf-8?B?bm1Hc2V0dlBCRFNKNnFJK09TelB6MXoxdU05eDdkM3JpSWg2QmJKUmswMlo3?=
 =?utf-8?B?bTg5R1UyVWRBZVYrOHBsV3JFckVqVG84Uk4vUUNQd3VEbys0NWp4cUlxTkpW?=
 =?utf-8?B?cWJYbmM0bGxNZWtsTVZBSE4waG82UUpWdEpqZ2ErOHJad2o3MlBzQ1ZtdndW?=
 =?utf-8?B?NG1nRVZxaGpNY1dUS1E5S3ROd2JaQkErNS9lOUw1YlQ2cmlPUlJKQzhqRG9O?=
 =?utf-8?B?bVg4ZHEyMVltb3hqWVRFY1c3TU9PcVZwVDUrT1d0b3ZJdzYreGF0LzIzV0ZS?=
 =?utf-8?Q?UW7pXF1o/elN0?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2kyYmtkTno0dFVQYyswMXhqT3h6QWlCNklic0NzNTd4N21FOGFGc1M0MFR0?=
 =?utf-8?B?QjFob0FpRythdU5rVHdTNk96MjNZZ1Jhb0x0MzNYOEQyemJmS1JYMnZRejZM?=
 =?utf-8?B?Qk5WQkFOUUJrYTRDTHI3UVZweDlqV1hNVlNxOU4vNFhtVExIT1RsNjg5ZW8r?=
 =?utf-8?B?WTZ6WkFaS1FKQXpnTjk0cGppeGFkVU9nRkxlV292VXhoaEg1VUs1NUovaG9x?=
 =?utf-8?B?REx5bHpMMjJoRGxsRmpBZ1NBTWhyemtLWEd4c1h2UDFGaU9iaFliV2tka2R2?=
 =?utf-8?B?dy9HQnZycmRDRjBiR2UraFY4YnhrVURhaE9NWjlPblRFUFQ3WGYrWVNoa2xL?=
 =?utf-8?B?bW1FS1VRUGxWNVVSdFQ3cmRLV3BzTVhmQ05QQk5PUm1tTS9ya2hNOHlYRE1T?=
 =?utf-8?B?OFJYRUxOTDF1SHdaSVdmUXVBUzUxcklJU1B3c3g3SEFwSWdza3JOazZzenBt?=
 =?utf-8?B?Z0VzdjZ4Tk9BbVRoT2oxYzR0RlgwV3dvckh5Q1ZKZWlHN0ltc2FOdmxBcS9t?=
 =?utf-8?B?elNYRndkVU96Sm1GQzVSM2l6enBxMTU3YURQOUdnYzVnMGdxMnQxL3crclFh?=
 =?utf-8?B?b1kvN25KNVpmdjJod3pwVk9qdVFYY296d1ExQmlibmxFVklOOHNBUjZML1Nu?=
 =?utf-8?B?Sm40eWZzK2YwVlNtbkJ1aWJ4UWVSVDN5czRLVzg2c0tlR0Z3TTRqdCszQXhN?=
 =?utf-8?B?U284L3g2ZjkwV1haeHFYYVFaYWhLYnFWR1NMdlVQdFpDeldRYnRxOGxsY3l0?=
 =?utf-8?B?WU9pOFlTQ1dlZTVRMy8zNW1tb0NGZ3o5Wm9hVzl6bmtRVE9lTGNpUFgyS0t6?=
 =?utf-8?B?K21VcCtGM3o1T0pLNmNSd3pQTjVuY25TZmFmemNFVERoaTdKT2N6c0tEaTVI?=
 =?utf-8?B?d0RCYWRTYzZiN2ZmYUxGZlVNcFQwMjQ3Nm5aWGp5elFLa2w3d3ZYdmZtdEhu?=
 =?utf-8?B?MzBwMXM3cVZTbUFRNVpGNDlaTlIxN2tROXVCOWE2K0RHTC9haG5qZ2F0M3c0?=
 =?utf-8?B?dlViVGd5MnoyS05ZbDNya3Ezc3VZQXVGeWl4UHVBeldudVZneGlIWGdxM2dX?=
 =?utf-8?B?MEZkME4yMnNxYnU3MEYydkl3bkJMaVYzVUIyMjhudy9kT1ptTzBrb1NJY09x?=
 =?utf-8?B?eFpKYzRNd2QrOFFrdEZCR2czN3Q3RnJTeXVIYnM4d0JTK2dHaThxaHBzc0Qy?=
 =?utf-8?B?ZGlkNlpmT2FZdkNTOEpWQ1pTWVZzRG5ROERuSXEyMTQrV01wTGxKNmJaZGV5?=
 =?utf-8?B?clpqRWxrNU5uVEtsUktrb0ZNZjhYbnZnM2owQlJiRVBBaDlJeUxDcFVVQ3FL?=
 =?utf-8?B?UGR2L04rR2E1b1U0SHlGTG55TEFmZlhZbVFCeHZtUW5zanQvaDF3dGV6SjBy?=
 =?utf-8?B?a0JkY1IwYjJkNlV1REdLdVFYN2JqcXFMWkprbTFvVnVJRG55ZnhDZDI0SFNh?=
 =?utf-8?B?S0I4N3JtTDZsbDZRRW16blAzTW1wTUN2WnloUUVPV1JyOUo4azc2QVBqNXJP?=
 =?utf-8?B?UGdKYzlLRk82bVlub01xSFY4OS9hdkk0ZEExeTRlQ1ZJZDZ5U2Jwb0xqWVhw?=
 =?utf-8?B?Q0pZeEZzQmx4d0ZMazV6YnFZVkNpRTRSdkFsY053SHlrNlNMdUtLdHpuRzdK?=
 =?utf-8?B?TXFIdzJJMnhJaFZha294dnFUdGQ4TDBNRTRSa0MxY3l4OTVmYVVwMXZGaWhS?=
 =?utf-8?B?RytmeEsyWXhyNXlLZ0QwRU90bmRBd3hlZGZTaUhWYlNLZm0zb2w0LzZ4bmhE?=
 =?utf-8?Q?pRZEBt271P0aGNJnNI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4271.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ffac9e46-96bb-449b-aa4f-08ddec56a410
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 08:31:42.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF3041E2F7E

SGVsbG8gSGFyaWRhcyBNYWhhdG8sCgpUaGUgcHJvY2VkdXJlIHdhcyB1cGRhdGVkIGFuZCB0aGUg
dXBkYXRlZCBjb2RlIGlzIGF2YWlsYWJsZSBvbiBnaXRodWI6CgpDaGVjayBoZXJlOgoKaHR0cHM6
Ly9naXRodWIuY29tL1NreWJ1Y2tGbHlpbmcvU2t5YnVjay1zLUdpdGZsb3cKCkdvb2QgbHVjayB1
c2luZyBpdC4gSSdkIGxvdmUgdG8gaGVhciBmcm9tIHlvdSBpZiB5b3Ugd2VyZSBzdWNjZXNzZnVs
bCB3aXRoIGl0ICEgOikgb3Igbm90ID8hIDspIPCfmYIKCkJ5ZSBmb3Igbm93LArCoCBTa3lidWNr
IEZseWluZy4KClAuUy46IEkndmUgYmVlbiB2ZXJ5IGJ1c3kgd2l0aCBjcmVhdGluZyBhIHZpcnR1
YWxpemVkIHdpbmRvd3MgMTEgaW5zaWRlIGh5cGVyLXYgdG8gcHJvdGVjdCBteSBob3N0IG9zIGZy
b20gYW55IEFJIHNoZW5pZ2FuZ3MgISA7KSBWZXJ5IGNsb3NlIHRvIGdldHRpbmcgaXQgd29ya2lu
ZzogV2luZG93cyAxMSBQcm8gZm9yIFdvcmtzdGF0aW9ucyAoRW5nbGlzaCBYNjQgaXNvKSAyNGgy
IHNlZW1zIHRvIGJlIHRoZSBtYWdpYyBidWxsaXQsIG1hbnkgb3RoZXIgdmVyc2lvbnMgb2Ygd2lu
ZG93cyBmYWlsZWQgc28gZmFyLi4uIGluY2x1ZGluZyBjbG9uaW5nIGFsc28ga2luZGEgZmFpbGVk
LCBuZXR3b3JrIGFkYXB0ZXIgcHJvYmxlbXMgd2l0aCB0aGF0IHdpbmRvd3MgMTEgMjNoMiB2ZXJz
aW9uLCBidXQgdGhpcyBXaW5kb3dzIDExIFBybyBmb3IgV29ya3N0YXRpb25zIDI0aDIgc2VlbXMg
dG8gaGF2ZSBnb29kIG5ldHdvcmtpbmcsIGhvd2V2ZXIgTWljcm9zb2Z0IGlzIHN0aWxsIG9mZmVy
aW5nIHRoZSBkcmVhZGVkICJwb29mIHlvdXIgZHJpdmVzIiBhcmUgZ29uZSB1cGRhdGUuLi4gc28g
bXVzdCBiZSBjYXJlZnVsbC4uIFRlc3Rpbmcgb3V0IGh5cGVyLXYgY2hlY2twb2ludGluZywgbm90
IHRvIGdyZWF0LCBraW5kYSBmbGltc3kuIEFuIGVhc3kgd2F5IHRvIGNvcHkgJiBwYXN0ZSB2bSBt
YWNoaW5lcyBhbmQgdmVyc2lvbiB0aGVtIGlzIHNpbXBseSBjb3B5IHRoZSB2aGR4IGZpbGUgYW5k
IHJlLWNyZWF0ZSBhIG5ldyB2aXJ0dWFsIG1hY2hpbmUuLi4gc2V0IHRoZSBuYW1lIGZvciB0aGUg
dm0gbWFjaGluZSB0byBzaW1wbHkgdGhlIHZlcnNpb24gbnVtYmVyLCB0aGVuIHNhdmUgdGhlIGxv
Y2F0aW9uIGFzIHRoZSB2aXJ0dWFsIG1hY2hpbmUgbmFtZSwgdGhlbiBpdCB3aWxsIGxvb2sgbGlr
ZSAidm0gbmFtZSBcIHZlcnNpb24iIGZvbGRlciBzdHJ1Y3R1cmUgaGFuZHkgbGl0dGxlIHRyaWNr
LiBMYXRlciAhCgpXaW5kb3dzIDExIHdvcnJpZXMgbWUgdGhvdWdoLCBhbHJlYWR5IHNhdyBleHBs
b3JlciBzY3JlZW4gZGlzYXBwZWFyIGR1cmluZyB0ZXN0aW5nIGluIHZtLi4uIGhtbS4uLgoKVW5m
b3J0dW5hdGVseSBXaW5kb3dzIDExIHdpbGwgcHJvYmFibHkgYmUgbmVjZXNzYXJ5IHRvIFJ1biBE
ZWxwaGkgMTIuMyBhbmQgYWx0ZXJuYXRpdmUgY291bGQgYmUgdG8gdHJ5IEZyZWUgUGFzY2FsIG9u
IExpbnV4IGFuZCBXaW5kb3dzLi4u
