Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E392C3248
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748835709; cv=fail; b=iITb55OcMjRiP5gJRGKSBKHQM37rqRpousgl3AduTF49JClfBbb7jGZaU9jp49gNkSDrjZ+DMoFBYRCic/a4XGhd1gNn0dn08JMfjXVzV+GNBTHUgLjAeuX9Zi1oxby/L08zz8a6XBaLCe46PKoaEe/0iCkTIerVXgrBllhn0WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748835709; c=relaxed/simple;
	bh=ifY+07co2lKJxs4X6OMA9s7Ddjsk2w3MC6KgXC8BoUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fvaIh8Z+KuxLtRFt0SYvyaa9OWZyApcYJ4kTgGiIyIfo14YHnLu+Bq3ampFLA5Of3vwE7L4cnwxx4s8A9w/zSguufafJkeZ39o0ZBoxKjgmD5ztAmFh/b0softTTVwIet6cNhHm/1oGBhbSPhvNowSMdpLXJyLGxcLM6H8HcynQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UxvZ9DS1; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UxvZ9DS1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCWzUQ8dVg3T8/SUfaP386QI98YAOd5STfSyi/stkAbxd6LUu2qEJgegueEF6e4pmrfTy40QFCEuqAExi22rdAhotjn8oktG2uJ5zbVWaLiJtdxq+1mHbHuNYn3AhAeadhOH21Z9a/Yq/U6QvDBvxWfDCzTdpmwOWGe6K1eO8JzJitJu5kZa8CJtrfD0uNF3IKdHknK26IdeC8hom+QJsIshtql7ycpWPDLmDuuulpIzChLOtRG8E4o3mdfkmKljuKGDPFKHxyL8ExwfDOa4T64kDwD3izUBcSFeM3vGxz9yjev2YPn1ef/Jhx56FqjmVD2gPZ1eFUYVYjdmrxyFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifY+07co2lKJxs4X6OMA9s7Ddjsk2w3MC6KgXC8BoUw=;
 b=INwTFxK0BStt8UplNGiDH6rh/5yjO2bcMKDemf2MWmnQnYuAU0A/IB1NObTeYIewnoyCp1ZNosUPvVfyI4MMSmxmzWkHQS48hGQOHphfHr1LmY4BT9Zj8GRqoFUCJU23Vx8wrpIKdxEe52LDpQE9bRD6UY2uvBsFT54hZ8zQQIOe23Q/jcdvH5W0142OY6t036mcnZyZdHwOVAJI8Q1QsOPCUE6sp5aG0Ty7EOqhTLY3/ene/0me6CEVDKUNc3BaLSxkdIwO+KEh+iNPiTEOSsd7Wo4yTQM5KPpnQnSyY5L6CtrKhlojPvsa7zAFyFbF0hqLPZjZBx5A8ndV0JMm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifY+07co2lKJxs4X6OMA9s7Ddjsk2w3MC6KgXC8BoUw=;
 b=UxvZ9DS1dfVdHoMV1pHxp6uM9ovNkkqoYHHoGDrC8NCUXGzQtSzs4P/+hMZgmSPEbMg07s692X75mrv7BVk/Vhm68T8D8J+oHDUaazqixy9dv5pisDAU3fuf4fwL10cub7d1pljCFI9gHWzT4aMa0nnHort6lVwVcc4dqm5e39s4VGZ7/jJm02yVK9+EtJsogHFxeXfuExc6+JTwSGRTa0ZKd+plsYz/uBAtHw1tsFMXkqr0hspKsbZo9BrV7U8vlAMbWpL7mXwo59179MKeqrINEd0TpCq7nDk540khAzBoT3wwdQyN8UOkArL95fURyoc00XBIKLLRhB8ZTE+/gg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB5518.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 03:41:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 03:41:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 6/9] imap-send: fix minor mistakes in the logs
Thread-Topic: [PATCH v11 6/9] imap-send: fix minor mistakes in the logs
Thread-Index: AQHb0tCcWtoIpWR8ekOjgEZg/Ha6t7PvCNo8gAAx34A=
Date: Mon, 2 Jun 2025 03:41:42 +0000
Message-ID:
 <PN3PR01MB9597F8C2F0A8F38225B9CF96B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <xmqq8qmbvurr.fsf@gitster.g>
In-Reply-To: <xmqq8qmbvurr.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB5518:EE_
x-ms-office365-filtering-correlation-id: 8e4cbaf3-8fd7-42d3-3179-08dda1876403
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8022599003|8062599006|8060799009|19110799006|7092599006|15080799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHIxU1VZUVM3cERWL1lqTFJQWnlTc3ZxbE5EVElhOHIreC8rTkVGSVpEZEVN?=
 =?utf-8?B?OEZUYllwOXRwUzZKV3ZNYk9xTDZYZVF4NXRIQTNmVmlqU1FNRFM3c0RMK1hi?=
 =?utf-8?B?elpjVTRVVFI5UWdkeERyUmxWTCthdGx1YkltTU1PcnRDTjlzc0l1NXVCRUNL?=
 =?utf-8?B?SnZOaHZlNlQ2WHVJZ3BGMllCZU1rY2ZzdGdoWjNsMjh4TFd2SlovRFlEV2tF?=
 =?utf-8?B?MXpBZUJodm94OWxCdkxIMUVMVW5sZ0F6YmZ3ZUtPS3ZMMmFDNy9QZmZGYU1w?=
 =?utf-8?B?R0FscVVkemlHbzlMMmV3alR1Z0FwTjJEZEJUUTd1U1BDUEdpbldhWWxZNDE1?=
 =?utf-8?B?U0k1NFVjc0pEZ1N4czJLaXQ3S2ZMNWM1NU0waE80bGtHbkI3R2ptZUR0Q0lR?=
 =?utf-8?B?TlJPalVpaXJsdnBmSjg5bkVrRExoZXczcWxNNWMyN1NpMmZ4SVpGb3VNdTdW?=
 =?utf-8?B?elk4eFN3NXhWTWlwTjZhMVFDSDNEOTFta3ZjT3ZEK0NQWFpiT0Z3UlNSQVEv?=
 =?utf-8?B?MlJKS3BGeTh1ZTdRN2ljV0JPR2JDL0pzNzNaeFk2QVZic1FKYURqeWRhRW5k?=
 =?utf-8?B?ZU9jMmNQSzNqaXZqY0U0ZnVFUDBLZTViMHJkUmR0RG1kbzNMYkJWV2V1RzRE?=
 =?utf-8?B?ckprSS9Hc0I4aEJHT0RTTGllZE93WTRmZVBNbk0xS3hwVFY0VTRzYWs3Vk9a?=
 =?utf-8?B?b1JGSFpGV0Z5NEFPTXdPUTdWQU1GZWV3NU5zSXdCam8wblJ4MlJPRk85Vi8y?=
 =?utf-8?B?ZjJKYXZZTldQNjQwTXV3UDNlNzlON1FxUDMvRVlESmt0WGpGOENpelVzSytp?=
 =?utf-8?B?R1lFQWtzc0s5ak9tMlZUclNMWU9GeGV2d3NpcEQ5VWFxcEZpcllUSDJCYXhz?=
 =?utf-8?B?UmEvUVZqVEF6U2kwZjlFc0RvOFZuK2xLc1JWNEI4ZGVBSmFVUzJlb0NvTXpD?=
 =?utf-8?B?STJiMVpoU3ZoWlhIT0VOUCtLZHdKMnUwZHZOMzhBYVAwT1VNUHIvRjVFNHEv?=
 =?utf-8?B?RlhsYktQMys4Z2dGRHNUNnpXTkczQkcvVk9MbWphVDkraXJmMm56MHI1ZXJt?=
 =?utf-8?B?aWZqZThFQit3WTFLSzBHazZzemtqQVplNUxNSWFYSkw4L1FwSXRGeDFXM0pH?=
 =?utf-8?B?a2V0TGwzQTdtT3FTNnhKelVGcFkxa1orZDdIWlRBb0Y0c2JQM0N4MWFGN0xD?=
 =?utf-8?B?RmFXYXZoOUU3cnFNeEVoUWdUZjRMNHE5aFhsMnZENmxoakRIUWFOSktWa2k4?=
 =?utf-8?B?K08zMTZLUUxRdjYyTi80WVUyUzk3MWlxZHREdmV6NEZ5bEtnNVNhMWRFeHk3?=
 =?utf-8?B?ZzBHb1lsTVdYZCswek1JVGxyekcxMUFraDVuMitzazcrRlpBWWdTeEhZbUho?=
 =?utf-8?B?RzJYQmY4NTNGMExGc2N4SlU5TFlmaGNhVkczUnova1NFYnh4akV6YU1YaWJX?=
 =?utf-8?B?L28wT2k4MFgyM0dtRHdKSU56OHc2UkJNNEZWa3RuODlCTzUxQTJKRnNKQlhp?=
 =?utf-8?B?NEdXVS9Ubkc2U0M4VTE5U3hSMWZvL1VCeVQ0N1R0RDQyTnJNaHdWemM4Y1gv?=
 =?utf-8?Q?3A9iqeDMLVtDu39B0WYO7OzZA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TndNS1hPZzRlL0xyM2psenVZdmlHNmxsR3Y0TmMyd0NpTUZKbEZpWjMzWE05?=
 =?utf-8?B?MzdVaFFOVVR4UEdNU3UrckdDME9lM3BETDVYNnFXSUFCR2ZqL3ZrYUEzeTJn?=
 =?utf-8?B?dEtaRVB3L1kzY3hjaXJwWGk1Ui8rRnBTeVNFOW00TkpWd1lTZDM1OGdjVkRX?=
 =?utf-8?B?dnJyV2pSTWxUdSsvK1ErNVNESi9MSDVYZS90bEk1ZGJ2UmVhWUhVV0o5bHh3?=
 =?utf-8?B?eDhvWHF1dFhyOUVHbjg0Zk9abFB2ZzZkNmpuNG9GYmFsWHlLZWZ0RjQyZzd0?=
 =?utf-8?B?UHN3a1k3dlJVaWtqQzBPaVpXTEg0MmMyTHBtUVc5MmFPMGhkMDBYN2k4V1lZ?=
 =?utf-8?B?NXdOSXNRSjJCSnkxeXEyRVZZTWgvYzRpWk41Qk5YS2tHUEZjcThWVHFpTTJ0?=
 =?utf-8?B?UE1sUmJ5T2p3VXQrTjc3akZMcXhFbmU4V2drcmZKK3Z0Yjl5YTFIemNmbURi?=
 =?utf-8?B?clY0V3gxYlQrS3cwVDI1bG5tQXdSSFRHN2pFVVZmQm1Od1JtWnVuVEUwQXo1?=
 =?utf-8?B?OE5mY3B3MWpYZTh3Zll4U21JY0NKY09lZkwyWG9ZblRyQy9HbUdJUnovdHAz?=
 =?utf-8?B?OFA5akRycWpURVFNaDViaWUxaFhYRTdvSUh6TklXSnhLOVJBcEhmLzRzOUlO?=
 =?utf-8?B?bmQ3aERUcHlva3NyeWsvRFVIMnBNa3AyMFZFQWgvN1RmdWZYT2h0TVVtQTdS?=
 =?utf-8?B?R05pM1NGNmZFazlzVmZHNDkvMTJWdXRnYnA5MGVaRG5IdG1xVEh6Nnc5ZC9S?=
 =?utf-8?B?QXQrODg3L25PV3pucW9PVTJFN2hwU3hZRjhHZndjdHVHNDR6S0h2NmNlVWJP?=
 =?utf-8?B?Z1pFMXM0VlhZYUtUNWdvNkVqZzRxeDFkTUVzZC9wRkhlU1ZjeHRycHd0aXZT?=
 =?utf-8?B?ejVkRUlrUzkzeTlQaEQ0Ym5WWThmc0h2WCtRSmtYTittRlc3QnFNOUxBTlBl?=
 =?utf-8?B?eXdINnZvWFkxNG5HMXhhWWRRWnhBZnRocVpJMGd6YkJLMVkvOFZPUzY0T0pa?=
 =?utf-8?B?MzZvekQxSGRiRVRWWjYzWnhlUW1FQ1lMdy9iSEI0RkcxNTMvaGpzRW00QkZl?=
 =?utf-8?B?ZzltdW1BaXFTZjlrQjlVd2NUTDh5d1lQRVhIcUVRSXJhUXhWNEpRaDhnZUUr?=
 =?utf-8?B?V2s3N2VyZnBVSWZHSnEyK3hBV2dxWDVGMXMwTWFVd3VFQ3A0ZGZyOUYyTU5O?=
 =?utf-8?B?L0xLdGhwWnBvQTd6YUpxRlJ0VExXTGZ2a2kxRm1iU2k5d0J2UmFuWlh5dkV3?=
 =?utf-8?B?M1FlbnVqQ3cxa0d4dmxqY1NYSVdHdzdTZE4yYk0vYTVUSHBTYUNSY0VoT1pX?=
 =?utf-8?B?V08wd2VvNWFEVERnNmFsSU00K3dVQjVzSnc5WDhmN1UrdU5hTldQbTdmVkh1?=
 =?utf-8?B?ZkV2aDJhbXQyRFkzSUN3a1BpeVk0NGd2cWVHeEVRSzZNdW1MZGZralByNlFW?=
 =?utf-8?B?bzV4eng1cnBFUXJzTk5TdU1XZGltNmpVbVE0N21RUHVoNFMvYnYweVEzN1RI?=
 =?utf-8?B?SUZNUUZ4NDR3dXYyODZPT3dvVHB0ZDYyL3MzSmJVSGVoYmZsRmE5VVZnRkVM?=
 =?utf-8?B?ZGNlWmF0TE1ra2pkM1BxTXg5UThFUlhnTWhvak8zeVhyMmZuUWp1dloxU3VV?=
 =?utf-8?B?S2RtTlJYVnBMYVNiS0ZsdHlVNmFQa2Zra3hkZjBGR0dXUTJpVnViR25XMkFi?=
 =?utf-8?B?V016eFJhU1gyZXcrdjBLVXNZNWpPbStYdW14ZTQreGJKU0JEV1hjY01JT0s1?=
 =?utf-8?Q?MmGZ37Zk7W7rDShycs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <95409151ACA15E42BDBC55666C518E36@sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4cbaf3-8fd7-42d3-3179-08dda1876403
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 03:41:42.6683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5518

DQoNCj4gT24gMiBKdW4gMjAyNSwgYXQgNjoxMuKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IFNvbWUgbWlub3IgbWlzdGFrZXMgaGF2ZSBiZWVuIGZv
dW5kIGluIHRoZSBsb2dzLiBNb3N0IG9mIHRoZW0gaW5jbHVkZQ0KPj4gZXJyb3IgbWVzc2FnZXMg
c3RhcnRpbmcgd2l0aCBhIGNhcGl0YWwgbGV0dGVyLCBhbmQgZW5kaW5nIHdpdGggYSBwZXJpb2Qu
DQo+PiBBbHNvLCBhYmJyZXZpYXRpb25zIGxpa2UgIklNQVAiIGFuZCAiT0siIHNob3VsZCBiZSBp
biB1cHBlcmNhc2UuIEZpeCB0aGVtLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2Fy
ZyA8Z2FyZ2FkaXR5YTA4QGxpdmUuY29tPg0KPj4gLS0tDQo+PiBpbWFwLXNlbmQuYyB8IDI4ICsr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IFF1aXRlIGhvbmVzdGx5LCBJIGFtIG5vdCBz
dXJlIGlmIHRoaXMgY2h1cm4gaXMgd29ydGggaXQuDQoNCkl0IHdhcyBhIHNpZ25pZmljYW50bHkg
bG9uZyBwYXRjaCBiZWZvcmUgRXJpYydzIHJldmlldywgZXZlbiBJIHdhcyB0aGlua2luZw0KYWJv
dXQgZHJvcHBpbmcgaXQuIFRoZW4gSSBzYXcgdGhlIGFtb3VudCBvZiBjb25mbGljdHMgaXQgd2ls
bCBjYXVzZSAuLi4uLi4uDQoNCkkgdGhpbmsgaXRzIGp1c3QgZmluZSB0byBrZWVwIGl0LCBpdHMg
bm90IGNhdXNpbmcgYW55dGhpbmcgZGVncmFkaW5nLg0K
