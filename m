Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10828E3F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111180; cv=fail; b=pL7/Hjx3MuRpu0Nw2DxXFWWyIqJg4gJ6QsG8Vs/ekemr4JZZjprIvDMKGIPQ91DnxpftEKtJecsRZgM+QlwFWPTXA+zcOqIJVJeWnll9x+umy/Ekj8vYYSNcVdpGRQwTwOKrogR/5DdaTYUreVk2yFWpVBZ4/kVtPb+8KVK7g2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111180; c=relaxed/simple;
	bh=FL1x3wYSlyVEcjQkvTIbM+LrzbUXWQ+RRKYCKxMbIbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R41AdDao1vYioDBSX5Q7A4376Rmmat6gaNU/MvFVZQiUXH8n41FlH1UtuFm5J4zPWllcJnLm2wenVc8N9RhDrmTTmX7vyvJ/t0Jw6Ci3BvJMvVZ+nv45k2ueTjDlcbv3r0WlslB1szY6GzqWGnDkM29DaLg2tu/70Sh1Ro+bodw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bQtP9h67; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bQtP9h67"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtvaiI59e5vH9czwau4zFYpx2Kb6HMPl6u6lgGA5LBXspdwo9lDv40DcMOZqNIpG/+6640CyKoh+DNLCrZRyeltJjDNQlgw9aQxfn0avrfGG3QOaWu59xa/fltVe48iKGFAIJ3Ffd/qTNf0OjDiJ+UpI+3B7rcNvx/NMi7K11k5D5AfuS8NY6V1zxoWDCWsPU+4gJ2oelq3nBleL/uBi7QWCKlS9JaaZRT2yKueSHqTjTSV7OIFUZwJBILKe2/L5VpWTbN/62yvDFLzV8q9MwTcpjLirzbsKuTXSfz6EQK7sr7ZXowMCfwRep8y/ZPYu7FLJkID2f1pQQkWKin/HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL1x3wYSlyVEcjQkvTIbM+LrzbUXWQ+RRKYCKxMbIbA=;
 b=dYuo08lxCUONtalJ2EHqTfH1wKIrXLdVSqay5SkpHeQ8Ieq0eLzOg/jqKm7XsfOsmnvWAQ2GjLXQrUMEvz/AjRHJY5F24sjrd0HPQ1mN99Gnu84W9fq+D0kh8J0qdCotR4n6IF/3AhBX3qboYt+L25bF4ogsjcIxVFBLqfjjE6NpS6h9AYlOKjCrXL+eds6DklQkZEd49kx6ZgERq1xnSdEIvYIH6lDo9pwPwXip5XQ7tUwurVhTS1JENLbMy8BfA1ds9p8aFigpthnqWCfRJpjSN/83M6VMbSvKQBP6OzP1tA5D4eGW86BQBV34uNz7Whe0XBhsLOBa/qB4AvEmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL1x3wYSlyVEcjQkvTIbM+LrzbUXWQ+RRKYCKxMbIbA=;
 b=bQtP9h67iNvNLXRKC0WvstWuCg7dwKP9+6WiL4vs7WV/ohBvfDUoXOtkJrwevnyE4pokqWqhReP+e3jD+XaJAXDso91UG49QQlfZei/s7ldVQ5yJU3nEgHCHSKxu664yMyq2CrdrHmTflRkkuG51GEmaljYr/mCD6H/FW9aO0T7JNtF3lYBbOkXV73/UYq0DyNi3SAZeYljRGer3YiS06mM4PXIrk35vT1BvLd6qIfyhN+fAfes/xK+eX43MrZk/VgOX5dnnJppS8uBvcKRPdnNgCGK6ykqLZB2PLfNJ0DYelpJCnSnTyi9x3wCD4suC45i3mWnpbOqMlYhvd2eLcw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF45CB6BB9A.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::58f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:12:53 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:12:53 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Jeff King <peff@peff.net>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>, Zi Yao
	<ziyao@disroot.org>, brian m carlson <sandals@crustytoothpaste.net>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Topic: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb062L/UXncuPtA0+SwhNYd5wiKrP0OFMAgAADlt4=
Date: Thu, 5 Jun 2025 08:12:53 +0000
Message-ID:
 <PN3PR01MB9597EA7301052F34B6FE3E48B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250605080002.GA2998537@coredump.intra.peff.net>
In-Reply-To: <20250605080002.GA2998537@coredump.intra.peff.net>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPF45CB6BB9A:EE_
x-ms-office365-filtering-correlation-id: 9a8205df-fad0-4720-62fc-08dda408c55f
x-ms-exchange-slblob-mailprops:
 30ekHghIwFpEXYvL1fTCAal5OzV2tAdzdS0v9EuU8gXMIr1lV/DbJQrl7xZeCwU7QXBw8URlVFLtestkly7lP1khYeXa1+hYCNBoBcGpT/nHnwCI+F6U/oyrxpfyoDpiKKCIn9hC98oqRNYmiyaq08SZ9AgaNYHyOBQNsLmfSvuW/A7aibQ76dGoP0zLNQjq8mQTStZkcQNcugHAp1PiIXfT/j+M+BomgIh23Oll8njcBA0cYxD59RHycobKgjxPiBzKczr8KStSRi7UIFWz9n2V3xKsTj+VnNP1OX0FgCjBWm8NmoE7qHXkN4+C/t8x50RlVtWbTq8UKGX2RRSVmteI0uxPPgfaqlxeELU/sEJtNCW/O7RbXerC1P9dgvMEyodYtifaw+KXpQICBfLJua1U587tjw7sST5XemRaDJQ2lbCo+UzKuMzIiiLhpVl/L7Nns7zfw6REPfbYUmpVovYKJFI9NN3+jq8nOJouVfKHkiW0MAbLFFxr1qm07ohdZQZyJ6GxisAm8Jit38eTTA6KigmSAGSGP2iv2Qn/JgJthRm/HzutjAG+8Ubx20M1LfGZPM1DqpVvIwzR5A+B073BXtTiRj04CCBnS3un/9BQWaHOCRkrXFv5lPcGE/2LXpJK6tiK4BWdS1XYi5Tq6Q6N+SQlpj0BhgG+ZKH200v6afZMM950fKM/5bG3IMzCRGdj5vtHtqxhel1bFpVEs8Oehu2E+pmogTyJnJJdVHoa8CkUKkP6f3DpNbo73o0A
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|12121999007|41001999006|461199028|19110799006|15080799009|8060799009|7092599006|8062599006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmVuNDA5NG5GM2Y2Q3p4TDZmNFo4bEJTeWI0d1I0NWNRbm9vR3NpQWhzOG9Z?=
 =?utf-8?B?bVRIVUJWQVM1cHB5TXJlUm1uWHIwU0FlR1hxUndXV2E5NnFnMkhkSytYWFc5?=
 =?utf-8?B?KzJrajlWdkI5RjJ4ZkVzbWZvS3hXcUM3VlBGbjZDbW8zbU56RGJlWGJwS0RT?=
 =?utf-8?B?UjBQdExZd0ZOTXVDM3lxaDBsU3A0RStPWWlQV2UwbGlOaGdlVnNVRWJpd1NY?=
 =?utf-8?B?YUJpcDBSQUx6ZkJMd3Q3TEFRVzU2N2tCZURLZkEwZmhXRnNoTXBITzRYMGhr?=
 =?utf-8?B?TW1NYzRYZW52OWJYZUh1MDlZRTZEQjhJMGJaOHl6aWhFaUNDUWdsdFg3dU9L?=
 =?utf-8?B?bU80OUY0cW5jMDhMOFNiVmZxajRab1pmeHl6OEVKay9CcmtnUDJ5Tk5UbVAr?=
 =?utf-8?B?TDU4Qm1NMGM4UytkRG9ZUnZ1eGdpSHMwaVFoY2c1czFRMGJCdFBoT2dESUQz?=
 =?utf-8?B?ZkxxckI4aFRlcjRXNHJKYzV0VVVta0pOM1pGdC9NRWQ4aThjbVljMnY3VWxh?=
 =?utf-8?B?Q3BIVlZUZURnRWxnamNObGI0bFVUNUkwWGFXTWVPemZsNlhNY1N6ZVl0a1Nw?=
 =?utf-8?B?OXRHcjJtODczZTNXamdLekdFNDE4clk5ZjhXWDMzRGtyQXQ1QVVJK0EzSExm?=
 =?utf-8?B?Vm1FMGNUcTBZb1kwQng3bHFmQVhpeUt4MEcyOW8xdHRMTnoyOEVCR0I0U2Jy?=
 =?utf-8?B?WGs4d2tGSzl4ZEx2SjlPVmpGVDBRcmZFbExtSk5BK0w1bC92bWNVdzA2V2xF?=
 =?utf-8?B?d2pWMzZZOGhQckFqSWk0aUNjTVVhM1dPbkZibHNqTkVzaHdtdUc4dUh4a1pQ?=
 =?utf-8?B?ajBLK0JBU1FEUTk0bE4yWWE4enQraklJYWttaVdwTE00cDVFazRFQlUyRW1v?=
 =?utf-8?B?S0s3UlArNG9OMEo2bGdGT1ZjUDh1aXYyeTZmOVVwZmI1NDh4Zzlja1BNV09L?=
 =?utf-8?B?TlAvZ0hCN3dyRUpUVjFJQ0Z0RC9DQlY3eUIwZS9KLy90NllZNjlTb21EMDJM?=
 =?utf-8?B?eW5mYjZiNUxRMnFoaWhWMHZ5b2h1enhabHdVWDVlOFA4WjBRZitTZ2U5WVhD?=
 =?utf-8?B?UmkwcWdPdkQvaEJNWnNXQ094bml4K0oxNERBNndpcFVjdVllVkF2dEZYZ3NC?=
 =?utf-8?B?bHVmNEY1M1VOeEN0YmIrem16UGNUT0VwbDYwRmZibTVXVWRSYXJ0S09rU2hx?=
 =?utf-8?B?ZmxBd1lNdHBwZVBITFo5aFhtWWNFOFpEZG42R3l5Z1NZZTFmaFFqTndyeVpZ?=
 =?utf-8?B?WEJkRWsyNFkra09Ea202VnVGRVJWYkhVWEl6Z0NYZGtQRXVaNDFtRk90eG90?=
 =?utf-8?B?RWRLL21LQlFsTnl5YmJoc0I4RVRxYUtkbUw5KzIxNmdRTEs0aXRRMUhPWHEw?=
 =?utf-8?B?d1k0bmtGbnVFc0xXQlNUVjB4MVFxQS9YN3J0eTk1US9KMnlKVEZ3MzJhcEhV?=
 =?utf-8?B?aVNqZkZQajI4S0N1a3FDSlFZdFF2WVh6VFlsUWpBZEhDVFV0blR6c0FBcmxO?=
 =?utf-8?B?ejdFSE9rdDZKcU5MOEhhWHlKeXRwZE9VaDBMa2k1VHBlSVBCbU93UWFnVm0z?=
 =?utf-8?Q?5WWf7QjDV4ClFxSx9NKOQ7UMDCzC3oFSUoYEFSSMF1iJlo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3B0SmVRSGFhQUorckpQRUFQbXl6TUhGMGVVbmpZSU1zU2cyMWZ3MXdpU0E3?=
 =?utf-8?B?K0JsWkFla1hHREFZaUx1QlliWmR4SEpNZ0RiRWNEU1d1SnlvQ0VwVG5Eb2F6?=
 =?utf-8?B?RDh4dFlMS1hweEZaSmhxdFk1Q05FVzJBNy9ZZlJQaExKVnVHNW5GYjE2VURY?=
 =?utf-8?B?ZnRSRmJ6VVI5V2xyTlFLODBkT3A5KzZ0ZFFCaytHSFA4ZU5ha2pvOE1mYnJK?=
 =?utf-8?B?c3JEaUYzTktBZzlQVllyU2xteGdDMEw4UGtpN0tvbEVadC91akk1WG51ZGpQ?=
 =?utf-8?B?elZKcU5MR1JUZDlMakNFMjk1OWd0cWVCQmRJblM4dlIza1RoMG5ObnBrSE5v?=
 =?utf-8?B?b1p5Ym0vcTc1amZ4TWtINWFsams5T0dsUmRqSkgrVE1oRVdBb3dQejdsUHZE?=
 =?utf-8?B?NWRqbXp3bldVTE1PL01rOUNIQVg2V2RTWExNUGtrK0VDTVI4WGJCVTBxMXNh?=
 =?utf-8?B?WjdNTmREclBYV2R0c0QzRUJMdHN2L3p3UnVaY3lPZzZJOUE4Y3M5N2lOUnBV?=
 =?utf-8?B?bW9rWkw5MlpDUVppWUlYL21HYjNLeGplL3RwV1k4bVViMXRRM2xTZzVteGdV?=
 =?utf-8?B?MXNoS3ZCbkh5U1dBWC9ZTFQ5Z09qMldaanIrNjBWOElENDZoVkMzdEFmOGhq?=
 =?utf-8?B?M2pmVHhLc1dic1BSOXBrVG45RUhpQjhFbENPbnVwU3lNQjVTaURhWmJ6bFV6?=
 =?utf-8?B?VVA3TlVMN2VxVzJwa2lUSXBPelBialhDYW12NWVLYVlCWDBaaUlTYzVOMGJQ?=
 =?utf-8?B?YzUxZ1RmUzNFRzYrQ3VnK2MvWEdmWFhYZE5WcCs0T2gwODhLODl1RnljL1Vi?=
 =?utf-8?B?Rld6WHNGUTVwa1lYMU5SZVA5SXNVdFB1bG44aHk5bzFycmcwMG5WdFdlVFVJ?=
 =?utf-8?B?YnIvLzRjS3FMM0tQaDZSVS9mbU9IUUdvb3B2d1hkT3hBNFVWTkw0QnZITzFB?=
 =?utf-8?B?Y1ZCTlpVeXNCRzBmOUVaMUhnRzZyYkRyRVU3VnY3ME93VWZSK1VMcVFkeWtX?=
 =?utf-8?B?djZXenJOVEVPcmVVeHdIUGgzRy85NlF6alZhbVUwc0lMeDlXYm5GNTJqUFhi?=
 =?utf-8?B?NlNHUWs1TTQ5ZkRrcTZldi9GUGtwQUhFMytCWWtIdTE4SnlFM0lWeWRtS0Ix?=
 =?utf-8?B?dldoUkFPYTRWUWpBeUpkZm1KbHRqcHdjK3dBVGk0YjR2ckNCQnI5aWNiNkp0?=
 =?utf-8?B?OXRxS3JZUEE3SjRpQ2hrZUN4enAvemgrSzdZV3lGMWlkcS81UVlHYkZsSWtO?=
 =?utf-8?B?RG9oaWwwQXpMY3NSTXdlM1E0djVDRVRMcjFPMC9TUVlvRXJJWEtQU3JZNklt?=
 =?utf-8?B?L1VJano4UnJROXp2YTFwa2l3MjhGNUduUFhIVWErY0lYSFk4WmR5ZjVQT3FN?=
 =?utf-8?B?d2VmZUwyYlBtaUhPQzNueDRWQUVScXVYaE0yZm9aTHNCZ0FOcG5RR2NPMEl6?=
 =?utf-8?B?dkRSYnpzT3ZWY1NoRjJRSFl3ZUZValVwRzBaM2VKZXRVWVpmbHQrRlREL3Ja?=
 =?utf-8?B?Znd3eFh2V1djekxHeE5Gb2NyZStHeHNiN3pNeERRdFN3TjNoR1hwUlpVajlh?=
 =?utf-8?B?TTlzcGhHd2dMWkpHMHJEQXNmS0w5VFZwdzc3QnRoV3MxeDJLd0YzQzdXaVZY?=
 =?utf-8?B?L3BKTzlwT3FhRk9YSHdHRDlqd3orc3piTUMrTE1OUTRpK1l4bS9JZzZ1dVBi?=
 =?utf-8?B?QmwxczRJenFPQ2hvRXpKclU5ejhjczF2dGtsZ2grR3drS1dlbVc0bjUyMHJZ?=
 =?utf-8?Q?9I6yz0q8bLBLu1gGtA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8205df-fad0-4720-62fc-08dda408c55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:12:53.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF45CB6BB9A

DQoNCj4gT24gNSBKdW4gMjAyNSwgYXQgMTozMOKAr1BNLCBKZWZmIEtpbmcgPHBlZmZAcGVmZi5u
ZXQ+IHdyb3RlOg0KPiANCj4g77u/T24gTW9uLCBKdW4gMDIsIDIwMjUgYXQgMDQ6Mjk6MzNQTSAr
MDUzMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+IA0KPj4gQEAgLTE0MDUsNyArMTU1OCwxMSBAQCBz
dGF0aWMgQ1VSTCAqc2V0dXBfY3VybChzdHJ1Y3QgaW1hcF9zZXJ2ZXJfY29uZiAqc3J2Yywgc3Ry
dWN0IGNyZWRlbnRpYWwgKmNyZWQpDQo+PiANCj4+ICAgIHNlcnZlcl9maWxsX2NyZWRlbnRpYWwo
c3J2YywgY3JlZCk7DQo+PiAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfVVNFUk5B
TUUsIHNydmMtPnVzZXIpOw0KPj4gLSAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRf
UEFTU1dPUkQsIHNydmMtPnBhc3MpOw0KPj4gKw0KPj4gKyAgICBpZiAoIXNydmMtPmF1dGhfbWV0
aG9kIHx8DQo+PiArICAgICAgICBzdHJjbXAoc3J2Yy0+YXV0aF9tZXRob2QsICJYT0FVVEgyIikg
fHwNCj4+ICsgICAgICAgIHN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwgIk9BVVRIQkVBUkVSIikp
DQo+PiArICAgICAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfUEFTU1dPUkQsIHNy
dmMtPnBhc3MpOw0KPiANCj4gQ292ZXJpdHkgY29tcGxhaW5zIHRoYXQgdGhpcyAiaWYiIHdpbGwg
YWx3YXlzIGJlIHRydWUsIHNpbmNlIG9uZSBvZiB0aGUNCj4gc3RyY21wKCkgY2FsbHMgbXVzdCBy
ZXR1cm4gbm9uLXplcm8gKHNydmMtPmF1dGhfbWV0aG9kIGNhbm5vdCBtYXRjaCBib3RoDQo+IHN0
cmluZ3MhKS4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGF0IHRoZSBsb2dpYyBpcyBzdXBwb3NlZCB0
byBiZSBoZXJlLiBJZiB3ZSBhcmUgbWF0Y2hpbmcNCj4gZWl0aGVyIHN0cmluZywgaXQgc2hvdWxk
IGJlICFzdHJjbXAoKSBmb3IgYm90aC4gSWYgd2Ugd2FudCB0byBtYXRjaA0KPiBuZWl0aGVyLCB0
aGVuIGl0IHNob3VsZCBiZSAmJiwgbm90IHx8Lg0KDQpHb29kIGNhdGNoLiBUaGUgYWltIHdhcyB0
byBub3QgZXhlY3V0ZSB0aGF0IHN0YXRlbWVudCBpZiBhdXRoZW50aWNhdGlvbiBpcw0KWE9BVVRI
MiBvciBPQVVUSEJFQVJFUi4gSSdsbCBmaXggdGhpcyBsb2dpYy4NCg==
