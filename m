Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED85228A3E1
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229963; cv=fail; b=MQYEBjopgeHU8nCGzEIa++qzJxNWqGzdKC3mOhfwRygFgbMzmXtdRYrDj9UFpXATEKtom7Qf+P9wTkE1y35Cbx2X8wdMOmyzDLz/q4eiJ06jJOtbJTnGg2MN+Ho7J3cSZ3EAV/tBpEB0q0/dWc4kZcfBHLzAWfOlbjvfD1JcWUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229963; c=relaxed/simple;
	bh=95e+UdKsH2q9OvETA6gQhqvxWzak7VtUjUm5ZNwXyVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cnkOd5tNufBlsuQs440UUOEYMnPHA1R1Y/13XEgMtofUEeRrEupWjCHB8qZxx9NYBfc1zszJ3RGiHTjRYe1mSXWqEVZrMPh3qRm/+Wnqis6zrFHUGQYi2mQPgyst8kLiZPaMs3koV18OJnjjjsA1L8IqDrKleUkTr+m6j0f0sRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bBepf0i6; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bBepf0i6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSBfSyhNF768yWe5wLOTCIq0684Q651fnGSv2YUxuOpm8XKuWfsmMU2K782t5igLJi/+swLBFvbGIk/Tc2MTnhzP2e+PyqlZf0hnAjZxVeJqtXZI0u8fwGCE0c1kMVbNK4dRJ5BIBdm1/leaTEyFCgVFq7VVxMl4C1t2rYD2lyW0A+2VYzWcIdVGA/8Wlryg5q1mHaCzE7V8fT+//9ZuhemAd0TBZJK1TaGbzBLdVZcFiNEKvWbq2mAvg8YfC2xCyepc81BlPuQ/kRm6+WFDQtGtCr6xasFNOS5n3yig6CYUOWCrpqnGbpJ8pXflYH5hn+117F5fBOkUI0pDJdlbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95e+UdKsH2q9OvETA6gQhqvxWzak7VtUjUm5ZNwXyVE=;
 b=jXdxWBGXXijHu08gDiozx5uV4DcaZxKo43nxm7nxvZ0syR+M+ItKCujFIsrV5Ru+toHsPOVkwZcMlN7JjhiQH77Nj9Kq0P4LGuIAsBCpLrX/tjmfgQD9uCAIi6Hepy4SHpsbgMZ9FNP1rLJtkb/uIL8nZbTHCnr+y1lViluxgkMphRIQEFdn45vc8Besky19TfKL7hJ/4UZR3qH4zJeTxfx6N8hPXYAdlFyjhVX8xVtIpn5tda6eTafTSxfmhoMN0SpW+YAbWBm5R3/HjF665cS9EckCoT84gZj9nS9d7b4BWQggliJMO68VOcOisyOdM2bkJoN1ow9SA5n+/vBlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95e+UdKsH2q9OvETA6gQhqvxWzak7VtUjUm5ZNwXyVE=;
 b=bBepf0i6hfVEiWeogn/FMn+lyJ7LgeinEBBWWFUd4mkmqSq10YtBEYuKFQA9R6S3uKTcsjW8FyyemEVhZXPHsB73UiUO3YYEUNRpvuLkaEKIDoNIA0zCGf+JvXcokziV0WOq1F48t/iSrkXRKJZ7dTdIppdiTbWUp7W/dpaw+fk44JfF82DqIqZJG2IHpAwEfWKi8KB27lnbZBMHvvs4nU7m4FOGWH8I+g5iR6XJ3qNRAn5ntTKDY/LGA1K2e/wkPg1jNHwQOmViUH6NE6hSUNJyagKP2HjXQooUJqPh11cChunxKwKC6tBGO9++Wjwlbe+vA2VIpMrOcBqk9zEDyA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8761.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Fri, 6 Jun
 2025 17:12:36 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 17:12:36 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Topic: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb1rCCpRSbkEC9pkCE5UNU00JzjLP2VZRcgAADWcaAAAO4ooAAAl5e
Date: Fri, 6 Jun 2025 17:12:36 +0000
Message-ID:
 <PN3PR01MB959793AA498C4FD81313B101B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqmsak3jwp.fsf@gitster.g>
	<PN3PR01MB959762A91208AEF089D3302BB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqbjr03ipu.fsf@gitster.g>
In-Reply-To: <xmqqbjr03ipu.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB8761:EE_
x-ms-office365-filtering-correlation-id: f1890095-febd-4ad3-ef81-08dda51d554d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799009|6072599003|19110799006|15080799009|7092599006|8062599006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?amxNZnNkR3NQZUl2T1FWMDZNbUp6dlQ0b1lkK0lMcHdNS0RTNVA0dWlKNFRG?=
 =?utf-8?B?MlEzeHU1R0lKUmJyTW82akpZc2c2UFBJU2VkcUpVWXVMck9TZGdEQTRDOU55?=
 =?utf-8?B?bVM4YXExb3ZzSkNXTnB4cHJlYi9SbVRsWU80M1ZjUDdCcUZEL1RZWUpwdStx?=
 =?utf-8?B?M3lvLzRFVmp4djQvemhZZEd3WDFKdVVSR1dnU1B2V0N4NGw4UzhPT2tkaDA2?=
 =?utf-8?B?bEs5eCtXZUZ1RkRocjdxc2JZbHd6U0FNc2xuYXNqS3VhRDMvWEM2bjB3ZDIr?=
 =?utf-8?B?dzhNZkM0ZmNjeXVqdnZlNzBxVXlHZy93VU8vK3Y4SmNJdUs3SWt4b2J1N0hS?=
 =?utf-8?B?WWgvOSsvdGxpektpbmxzVnYyamttSHk3R3hPOWRieldDajJHc3NGK0VnTk9l?=
 =?utf-8?B?SzR1Y00zb3lCaWVSaURnMEZvOHJkTm5yc1AxRXdDSTdCZDZQSGM4a2RkTHRC?=
 =?utf-8?B?ZDcwN1N3SXlmdUVBMStVVUoxWmFrR0JxNG1KcWgra0o1UThGNXJWaVlQT0gw?=
 =?utf-8?B?OUhCZ20yR0V2djYvK1Z3aWFJM05qVTNKN0dVM2FwWVJxelNPRk5nTmdHN3Q1?=
 =?utf-8?B?bk9pWjNwcjl5ZStTaXFLOXgxT0wzdFYrVWl3ZURrcTRyUzBML1BsQ0lDNVZk?=
 =?utf-8?B?K21sR3dnQkZDTGNudTVrbFYvbzEyZVZLRnp1eW01MzhNck9nZk1yREEyaW1K?=
 =?utf-8?B?eDlJRXZyRUlkdlFJK0lLV1VpY2RTOTFVc1dXYWZUQ3JKZVgxeUphZ3FNSzh1?=
 =?utf-8?B?SE1aNTZocHRIanNJQTRxUGEzU2xwcEpHU0hBV3pTaGpjMWJTUGwzYkFLUHl0?=
 =?utf-8?B?UGZsd3VuR0dOdllxcDRBRC80M20xekloT2JZbGNvaGxGN0hPb3N1eXAycFRY?=
 =?utf-8?B?UGxTQTg4SjJYWGl0WHEvckhnamVWZW8vZnBUUnhGVUtnSkhKZmVvNWNVazJK?=
 =?utf-8?B?dnlhL3BTSGVnVDRla1k5UE1BaFJvYi9PM1pqTENDbmJZYlNxZEp3Z3NnSzcw?=
 =?utf-8?B?dEYxVnRobzhEWlRoSis4aSs4K0MyR2JleTZvcVhJa1dhVXpUTjdCTUczd0Jo?=
 =?utf-8?B?cWd6cnZpSkxCa1JTUnp3KzhUbkZJNnB5Szd3UWR6RW1rTU9tWEtLQm9yUURt?=
 =?utf-8?B?enBNS3UyeFZyd1k5VjdKTWdKdjd4aEJCKzdtVVJYWFRnZXEzUnh6c0cwaFhG?=
 =?utf-8?B?L2c2VE8yVE5FSEtXL2NzblBhVjBNK3NGWjFmRGZHVFZPU0dkQnJYb2RHck1q?=
 =?utf-8?B?amhGRDdpV2haaGNPNk1jWFI1VUp4Q2VjVnhMVmlDWHV3UzRpQnI2Y1kvamhm?=
 =?utf-8?B?NFpCU25RWnUvdGwyc2t5bVVadzFBaWEyUGl3ME5LMG9iN1ZPT1JKY2k0eXdi?=
 =?utf-8?B?ZmloY3JaMFNiWEpBYmw1bW1UTWtOeU8vM1V0RFRXMjhnZktSRkV6WE9nMjFm?=
 =?utf-8?B?Y29wZmdjcURCeGt2RnhyN3FqRHVSbmZJMDIybFhUcjlvZzFIS1JvM3lDU3ZW?=
 =?utf-8?B?NjgrZ2JMaWJTTzFnMDZUYXBoUjhvR05yTVB0T1RqdG8ydDJycWhrY1YzVnNk?=
 =?utf-8?B?Q0UxQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qjd5VHVHYW5NQWloUi9jMjNXOHd2eUlwWkxVR0w2MitaS2kvamNOOUIxVm0w?=
 =?utf-8?B?dEpRV0hWZDZscEZpUEUxNTVDN0t5RHVtWEgxVUlHWnQzeTJENFhUVHFHcE5y?=
 =?utf-8?B?aUk5UDVKcnMzTEdHN3dTeGU1bE9ML2lEMGpHYWdCVnp0VDZBTzIvVWQ2T2h0?=
 =?utf-8?B?OXUycVVwT09OSnpxQmxBK3FqK1dWTnRkZ3gwY08wR3hlc2dvcCt4VllQa1Jr?=
 =?utf-8?B?SVY0T1dSa1NSWXI1RTNQMEF5Rk1QSEVIZVUrSjZqSEZaM2RBOHVZODBGTDF5?=
 =?utf-8?B?dEFWQW95dlJyNEZyQlROTmwxQzdGVkFZTFkwb0JWWnk5VnJvK2FQekNEMHd6?=
 =?utf-8?B?c21SdkJrRldIQVVwQ0plb2RLWE1lZ3MxdFNyZHdxZUswT3RJNHVKUktydmZF?=
 =?utf-8?B?SU02L3VSaGplS2RBREZZL0xLN0pkdnF4bHVpMXdjblY2dVVkMVc0R2xaZytr?=
 =?utf-8?B?S1FMOTRrT0xpeHJwb1VqMm5HRFlYZmJ4aVZpNHJVZncwdFNpemtOT1h4REw5?=
 =?utf-8?B?ckpmOFQweTc3SHJ3cmJqencyNjdFenpnU2ZjK3dkZ0FFVDkvcUlHelllVERq?=
 =?utf-8?B?NzViYmhlKzlBUTVOeDU4MzVOTE9TU3hzaGN4dXhIdGhKdW5nUkFjMzhkWkVl?=
 =?utf-8?B?WXRHMTdMU1V2QmZhNmFrVlhXakJQQTU0bTc4YVVOckdjeGxSeGFEcGRyb2lJ?=
 =?utf-8?B?M01ib0UvZ0dzSUtYdk9QTjBROEtPRUVPOERKKzd1QlBkeEw1SnNybkVrL0Zt?=
 =?utf-8?B?YVdKK3duTlJxYlBBdTZXMkhBUjR3UXVBcE1kd2QyUU1QenpMd0xQSko5T1ZR?=
 =?utf-8?B?Tll5VFpWbEV5T0lKd0FWRUxCVURUb0N6dW9ydmh2SXFwZUk0d053ODlHYjNp?=
 =?utf-8?B?c0x6V2dIUGl3ZlV5ajNQN2cxQWZ3dGF1ZDBHdjZUUFlpYTdXbzZTRVk5N3RO?=
 =?utf-8?B?dEVvUU1JRUdPK2c1bWFOOFlwc1JYMlNvREtLc1hSU1p6VkpNYWtaK2FmWEFP?=
 =?utf-8?B?YXJjM3k3NFlRNEk3TGF5dDdXbEhESDdSUk9aaGtWY3ppalh0NWZSQjliRjhw?=
 =?utf-8?B?M2lneVdockZhWE1CRDkrNjNOSUYxNmoxQk9uQjZ5ZlhMci94Q0tEdk9BaC9R?=
 =?utf-8?B?RllaSENvWitkOTUrQ2tTV254V09Eam1DZGZ1OHNhN2NpUlpvVGsxS1hxdFpt?=
 =?utf-8?B?WjBSVStzdVBLbmxCZzZqdXVNZVJqbCt4L2lhdUhLaVJTZVc3OGdod21ROUxx?=
 =?utf-8?B?NWR6VUtTd2xCVjYzdXFXSzZlREJlWkdaRHdNbWlNWDRlNzhISjhFY2pYMURZ?=
 =?utf-8?B?aWxZSXFoRWRtS3NvekVqOGNtMlFEaWYzWTBhY1Z1K3RoYnBJMUhvTGhzdzFQ?=
 =?utf-8?B?dEFKZFM0N2Y5ai9wdjJJZlN0S0wvWXpJMkhOb2ZHMXFHdEhxRUVUU0paQW4w?=
 =?utf-8?B?U0hWaFdZVmRJV3l6TTNmWHN6dnVVM2wyU2MrS3pvYmhUZVA1bk10dDBvU3pm?=
 =?utf-8?B?N0pIb1lha1VsR0g3Rm9VSFdGTVZBRWVJMnUzUkh6T3ViZjBtMEdEYkNING9D?=
 =?utf-8?B?SWFVbFRuY1VrQU5HUTF4Y1prNVZra1pxdWdPV2NrNy9ycWJGYVc4RVpvaGUx?=
 =?utf-8?B?MUpYNDlSY1JSaVFYckFkU2VZbkJjb2cvdFpRcEh5UnBXWmdXVWZqRFp6SEZ1?=
 =?utf-8?B?TFFHalFvcmZ6NnNpRHNDcVVVL3VJeElhbStDaFFQcWFGVmRNWEhyWlg1WDlx?=
 =?utf-8?Q?brcDv7f83ohAlQ8lBw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1890095-febd-4ad3-ef81-08dda51d554d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 17:12:36.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8761

DQoNCj4gT24gNiBKdW4gMjAyNSwgYXQgMTA6MzTigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBJIHdhcyB0aGlua2luZyB0aGUgc2FtZSBidXQgdGhv
dWdoIHRoZSBjb2RlIHdvdWxkIGJlIG1vcmUgcmVhZGFibGUNCj4+IGluIGNhc2UgaWYgcmVwZWF0
cy4NCj4gDQo+IFNvcnJ5IGJ1dCBJIGRvIG5vdCB1bmRlcnN0YW5kIHRoaXMgY29tbWVudCBhdCBh
bGwuICBOb3QgcmVwZWF0aW5nIHNvDQo+IHRoYXQgeW91IGRvIG5vdCBoYXZlIHRvIGZpeCBvciB1
cGRhdGUgYWxsIHRoZSByZXBldGl0aW9ucyBsYXRlciB3aGVuDQo+IHRoZSBjb2RlIG5lZWRzIHRv
IGRvIHNvbWV0aGluZyBkaWZmZXJlbnQgaXMgb25lIG9mIHRoZSBiYXNpY3MgaW4gdGhlDQo+IHNv
ZnR3YXJlIGVuZ2luZWVyaW5nLCBhbmQgbGVzcyByZXBldGl0aW91cyBjb2RlIGlzIGFsc28gZWFz
aWVyIHRvDQo+IHVuZGVyc3RuYWQgaW4gdGhlIGFydCBvZiBzb2Z0d2FyZSBmaWVsZC4NCj4gDQo+
IElmIHlvdSBzdGFydCBmcm9tIGEgMjAtbGluZSBibG9jayBhbmQgcmVwZWF0IGl0IDUgdGltZXMg
dG8gZ3JvdyBpdA0KPiAxMDAgbGluZXMgb2YgY29kZSwgdGhlIGV5ZXMgb2YgcmVhZGVycyB3aWxs
IHN0YXJ0IGNvYXN0aW5nIG92ZXINCj4gYWZ0ZXIgYSBmZXcgcmVwZXRpdGlvbnMsIGFuZCB5b3Ug
bWF5IGJlIGFibGUgdG8gc211Z2dsZSB1bndhbnRlZA0KPiBsaW5lcyB1bm5vdGljZWQuICBVbmxl
c3MgeW91IGFyZSBhaW1pbmcgZm9yIHN1Y2ggdGVjaG5pcXVlIHRvIGRvDQo+IHNvbWV0aGluZyBt
YWxpY2lvdXMsIGRvbid0IGdvIHRoZXJlLg0KDQpPTUcgd2h5IHdvdWxkIEkgYmUgbWFsaWNpb3Vz
ICjLg8yjzKPMpeGvhcuCzKPMo8ylKSBJdCdzIGp1c3QgYSBtYXR0ZXIgb2YgbXkgcGVyc29uYWwg
dGFzdGUuDQpPYnZpb3VzbHkgeW91ciBwb2ludHMgYXJlIHZhbGlkLiBBbmQgc29ycnkgZm9yIG15
IGlnbm9yYW5jZSwgSSBhbSBzdGlsbA0KYSByb29raWUgZGV2Lg==
