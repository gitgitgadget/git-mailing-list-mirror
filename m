Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD624B1E7E
	for <git@vger.kernel.org>; Tue,  6 May 2025 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509926; cv=fail; b=nS/kaHfECFjDkXveuQWAj8+L4LnhVo8jga8sCJMyfcZxpOf4CEpdj/j2zWnnfk75rk/oPNOu8cZXI24CpoZpobRc0yEephWu6DCR+Q0PtwszVLUhvlyWPd+fKrdLOJhN/zVAdlmvNU1mdfNMJ3uRijkTl/hEPAyS07lY/gp8uR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509926; c=relaxed/simple;
	bh=gBMgGlhjFWTu9mjnznT2BMYDY5pNHdrpKT2RI63l7Dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KLxkdjGYpBJ26icUeadM/jPA0gynEycJV5ViFeoVN4RgtoJbtGhR4tQejNZPRMox4zfeJoYnz2t9E7N/3LSql6gvctsDHwxfHywp0gMUBf6qNGS2QfAoC/nHPnvOJpmxJR7L+yjL6uG+m03k97FXl/80NhbOwCYGksmhxnq0teU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Z5/IpPNB; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Z5/IpPNB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXKfgjj9N/lM1liMzHarFunXiBBSd6VWmFFnVwcKPnFm4kn9lclvKS+TpxiVHKwezt7qAxs0G2GtALIgkphQtkCGzcIKWCSiF54sWo6+qkjgntZ9lfKD6DnHRtpEMar4iQvrD+ZqlhSVY9eZRxZx1CfNnqkC7ufRz0Msf0TqPb7Rquc/ameH5Zy3U8EvzrETyTPDcg1NP8kDXRLdeAQU/NfnEBafRZFfWeOBD1iJcbi51YOeYHNWlrz5IMRy2QCPVEfAG4XzQ7qP4lMDB8GXJrC9yvKlmrRqi0cWDpfhdh+F717j1XOltou6S6eHzq2pu7ndpPYygecy3+dxxcROYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBMgGlhjFWTu9mjnznT2BMYDY5pNHdrpKT2RI63l7Dw=;
 b=JeevE7GWlOtrrlYB3rYJNyn7beVxBUWIlRtsGpGm96AvH16Q8tYrNP6B+6b0+JFqpjN0vztTBISNUqIc8o28LeGajAS6giFG5NL9w+QUbkhEhD0xwCNfc8zwB/oo5mHBzJv2l00z+oDcoeZHH/Q3ursvZfVqs/yPUE5vGfJp0TNbM01YX5Jk2T0zerSRpFpJKgOvvYlQNRcv9CWFKdRxfoB4eZhKrI0muPbFAbb2DHmEDpI/a1KFbWdaD8UKWoiBtH0+hLHJ7FfOqQFCdlp1zeDYuPWxjWeMPM47sYIW1fxsXv41OOkS0hR+vLlgYcLs7YvcYoLtT/rFaze7ryVljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBMgGlhjFWTu9mjnznT2BMYDY5pNHdrpKT2RI63l7Dw=;
 b=Z5/IpPNBBzXgXGv8IpDl7GsF/1cbkXZjHgLXU9Ahgx3ZToTLYoWDzPrFkDdXqnOI6/TTJA5u/Ubk9i5juK1RXiHUj9+q7LHpW6tv/fuE0y9grw83i0cIiiGtORbhuAqquMfDjBuQBB5Eqe/x7Zp3CsvTmryvpurbuKanktbvlbgHYBLV/LNYQwvePA8iW+XpYrl1SIqmqhY441C4IEb6FTBeD9/T//vnaUVTSVNluSFKiiYZBDkxU8yJa5DscPLfSwAN1I0ctOZ/M7nqPItO5baS5aq3Nhn/4QSZnAx4KN0vwgbnx8/syQH/IMQXbaz2QPL3FSQkau3kO7Lv1wMQJQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9323.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 05:38:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Tue, 6 May 2025
 05:38:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, Julian Swagemakers <julian@swagemakers.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Thread-Topic: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Thread-Index: AQHbvdIH1wi2Dpyl3k6jAvs66vPp1bPEtSClgABhdcQ=
Date: Tue, 6 May 2025 05:38:37 +0000
Message-ID:
 <PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqplgmlisy.fsf@gitster.g>
In-Reply-To: <xmqqplgmlisy.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9323:EE_
x-ms-office365-filtering-correlation-id: 1c58bc63-0a02-475c-cddb-08dd8c603fe2
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|15080799009|8062599006|8060799009|7092599006|461199028|6072599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TTZ4cWdsOS84SW15UlFhUXBrVHFkZllNNmRpcGVKMmhwWVVLSFN5NVF0NGc4?=
 =?utf-8?B?SlFyK1d4anJiaW1DbStGMmdLeDRGaGloWWI5YzVVZWozNld6QU4ybEU3Mmtz?=
 =?utf-8?B?M1Y5ZlRWbm5RdEJCbkpBTWd1djF1dDZzdlFJRG1DTnBSOG5rREhNMzgyc0I2?=
 =?utf-8?B?Vjk0dG1MdkpvSHE0RFRsSUJVZGdyK3VCNU1wR1RYRHZGOTAzZDBEdkhPQVNC?=
 =?utf-8?B?U09KRFV3QVZJMGxoNWl6OXhiSEc0VXhoSFVldzBNclVYUVJybWpDUHdmWHRk?=
 =?utf-8?B?a0ZTT3Z0Yk5rM3dSYjIyVGtHMGRKdGY0d2lFYkxiR2ZKcEpGMWF3dVdKNGhZ?=
 =?utf-8?B?Zk0zUGthTEwvdGtIS3VlbmY5RzVGZktmRjhVVUNQbmhxekhBcjRwc2s1Znlr?=
 =?utf-8?B?ZmNhSDNSWElFS0pUNzNvYzFwdWhSS2VBV2hTZDQzc2RCWEwvYzVzVVJ4RXVV?=
 =?utf-8?B?K1VLb1ZGSU9yWk5lUzcwM3lldjJOQkZhcEZoK3N5WmluSy9TWmJyREtQOG96?=
 =?utf-8?B?Z214SnNPUnRhREtVWEV3bldFYVVJaTBUOFJnb0toUTJ0ampqcDhUd2ExdGVC?=
 =?utf-8?B?UWRwam11bURkU25wOUs2UVdhZW5xZnIvWTdqcnF0b2MxTGtQVzdZL21ONFI1?=
 =?utf-8?B?SlBvbjZML3Fjb1l5TXl3Q2xJNS9kVlNwYmQ0ZWZJVXZOeHBxSExyQXNvdHpn?=
 =?utf-8?B?VjhWTk80akN0ZUJvUFFIbUtsNTlHMTlJZTltTW5zT2Z3WndpRmp1cnMrK21C?=
 =?utf-8?B?emo0dFM1cTlkRHpYRld5ZHM5UTduVVdQUXZwQmNUUmlmalZPQk14Ulh4cEFS?=
 =?utf-8?B?OHloVGpxZ3pHeSt6bnN3M08rSHhGZ2xzVHNWdDJnaUE4L1JoYS84K1BSMDZF?=
 =?utf-8?B?K0JPaUNyWVo0NFpiWFdIeUJYQ1M5cUt1WXR2emdkQkdjTVpMS0N3eEVFQzRZ?=
 =?utf-8?B?SmRHbWpsQXNtbGVGeU5oR1JlbkJYbTFiUW9BWHlDWWV2bStKd0pVV1FWdkQ0?=
 =?utf-8?B?M2t0aFNiTGJmdnFlQ005TDJRZkZXcTEyVFFkR0MwcTdiTzVaOTFjakcrRHl6?=
 =?utf-8?B?YXVBdmt3OHZJTWVkeXpQMnFMV3lWeEtsQmJMK0hxYzh0WFJrRGNBNlozWmxY?=
 =?utf-8?B?dCtpL0NOb085Qm9jZFUxR0lLSmE1bmhMZmRlZzhjSW5ZazkzVGw0ek1XaThE?=
 =?utf-8?B?V1dWMis5cyt3Z1A3elFYK2NQRi9MZzZNeG1Cb0lTRmhha1hPOGFsQlFKZVhF?=
 =?utf-8?B?YmFxYXV6U202aEJ6Qm5XQjFsaVpCSUl2UjdUd01nYnZYZGN4d3RGcUdOa2sr?=
 =?utf-8?B?ak9kWWMwUGRjcno2OFBmbFJWSU50YjE3UzRHbDd6NHpIellUUXUzYngrVisv?=
 =?utf-8?B?blBTSERuQk04anpHTmROYjZaTHNWL1BYR1ZrdlRQSjQrRVpQdnh5OUpGakZI?=
 =?utf-8?B?QjZIRStiVXFmMFBkdlQreHFIOU9RQW11Y0ZyRjF6TkM1WmwyNGtFL2lmSU5u?=
 =?utf-8?B?OTBPZmFwelNmeHpRM2NzQmtKRU1MTjJjaEJnYzVlb25ZSzRUSFBJa0pzQitx?=
 =?utf-8?B?RDY0Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z21QQ21JaWtQWW4zNVZXNjhLd3ZnUkxnNWJrZndYdU5JbWw0S2VaNjE0am1p?=
 =?utf-8?B?MVF6K1ZhbDlsREZrRTdPaUd1VWpmVjR4MlNERGpsd09mbmplMytmT205YTBQ?=
 =?utf-8?B?WTl6MmR3cGdJSnkrS1haZkJxT0V3ZWFCeHJBcXV3VnpCUGhsTHVPUXNVbGM3?=
 =?utf-8?B?SUtRZmp0MjhKN2ZRWFJlVmoxcE9PNUo4Q2dQQ1JXV1poeTRIVXFoSXc2Q09V?=
 =?utf-8?B?L2l1M0dWUk92SzczcjVOaUxraG9XY3djZzRJWXVQOEdmeUkyU1hrTktkZDdo?=
 =?utf-8?B?OWNmaEFwaW5VWUpNTUVKMzRvY0o4bVNPVEpnMkdQd0Q0bDA3WjE0NFdYTlRo?=
 =?utf-8?B?dmE3eCsreWZDbHhGWXZXVmNSWnNuMGxZYVpNS3ArTmticm1EbjJNenE1RjJn?=
 =?utf-8?B?L21CV2d4MUFYVjhYQ1kzdHRNdVJpcC9HY2VkTkE1dG5YR1JaS2t2MXc0cVdL?=
 =?utf-8?B?MHJST1cyb2xzdFRuVzRaWU95WE5hZEdXK0pnMEtSbkNJcHNpdjVSL0ZpQzN4?=
 =?utf-8?B?eHpmeXRIMUN4bmF0MnRlSzFCR05qWG9YQ2k4Qmd2ZUdPWVRLTlcxZGNaMXVU?=
 =?utf-8?B?Mkg1bFFvcVIwUEluSFRZb0hWZHZQclhoa1JEdXlyNTFXek5kZnN4N3N6ZitC?=
 =?utf-8?B?K0xBUlJSd1hiOHRrcGIzRHdVcXhEZkkwZjhQYVNQK1d3eEFzNnd2V2FhVkxl?=
 =?utf-8?B?SmdSeU5iWFVINXRGeUhZMjg1c3J4aTRTb2x3WnNUc3laU1hoSnlPLzk2dlRW?=
 =?utf-8?B?eEpEOVdmWVR0NWM4TVRHY3R3Y3NXNHRlM1ZtVDZnZ252RjE4S1pUVys0K2Jz?=
 =?utf-8?B?Q0RIS0lQbGUzVWkvaGhQZHNQS0tkNmc3ODhrQ3JwQkJpNEh5M3pEaTFsMGhD?=
 =?utf-8?B?OWdJQzFYVVc2Znk1SUJucEptMmUrQy9qc0tCa1hsMUhvZytHVG8yeG1PZXVN?=
 =?utf-8?B?dkRoODFPSnNlcDB2TmM3WjRyYy9xdFYzNDQ4TlpYM1NFcGxkNk1UeUEyT2ti?=
 =?utf-8?B?ejY5YXEvM3NIWnZhNmVmcnErTHJTZ0JFYWg5M0xJdzFxSnZ6NWxMMytuM0x1?=
 =?utf-8?B?Z2FTV2ZKM2FtVWxZRnVmMVM1cVFrRGlMdERMeklFbkgrOVNobFZ2Nk8zS2dF?=
 =?utf-8?B?M0lGSzk5clNxWUxzSm9XNHIrY05ROHN4SlJDZDM5ek1ZY1ZXbzBQak9JczVP?=
 =?utf-8?B?UVQzaVlxS1ZLdVJ5UkMrS3ZzMTJTbnVIUHhIMUhRajZwd282OXkvSHFBTXlD?=
 =?utf-8?B?S05QR0Uxem5WaEYwTEU4eEk3ZFlYT0J4RTNWdXMxTE5VN3FxT3dFV1p3L2Fp?=
 =?utf-8?B?QkRqVjFxL1dPMnMxR0xOdXR5aytnd0VSeWl2aGZ0T0xvV2hqRWl4Qi9FQ2Ri?=
 =?utf-8?B?SVE1Vk5YN3lyd29YS1A4WC80UnRybHdoTFFBM0hmRjY0ZHhnTUhCTWgzeEpW?=
 =?utf-8?B?ek5DZm8wc0hhVDVCdUIwZ2NISGFzbk9EMHlvSVNCOEFlUTBXZE51SElOUHJ6?=
 =?utf-8?B?NWx6N3FKRDFTVnJHU1k2b3lvZlZLRjFEblk4UDRJalRXUENZNjNNNUs3SjdI?=
 =?utf-8?B?US9KdGVyTFRnMXdjaW4xWDlQMjJ3ZWJ1WlA1eTVEWkRaS1BaU0xMSlBHZUQ5?=
 =?utf-8?B?WURKekF5UklRa3hnSTFxc1dnQ21Hb3l0NThkemRvZ3BUWmVXNHhDQndsUzVk?=
 =?utf-8?B?KzI5TnpyVDdtSDNWRmpiVWFRUGZyaHgvWnVKRlpURWtueHBYSFgyMy95MEVt?=
 =?utf-8?Q?fsqNQv0RkuDxp3c2WA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c58bc63-0a02-475c-cddb-08dd8c603fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 05:38:37.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9323

DQoNCj4gT24gNiBNYXkgMjAyNSwgYXQgNToxOeKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IER1ZSB0byBjdXJyZW50IGltcGxlbWVudGF0aW9uLCBJ
IHdhcyBub3QgYWJsZSB0byBzZW5kIGVtYWlscyBmcm9tDQo+PiBVYnVudHUuDQo+IA0KPiBJdCBt
YXkgYmUgdGhhdCBzZW5kLWVtYWlsIGRpZCBub3QgY29tcGxhaW4sIGJ1dCBJIGhhdmUgYSBzdXNw
aWNpb24NCj4gdGhhdCBpdCB0aGUgYWJvdmUgaXMgb25seSBoYWxmIHRydXRoLiAgV2UgZG8gaGF2
ZSBhbiB1Z2x5IGxhc3QtZGl0Y2gNCj4gZmFsbGJhY2sgdG8gY2xhaW0gdGhhdCB3ZSBhcmUgbG9j
YWxob3N0LmxvY2FsZG9tYWluLCBpbnN0ZWFkIG9mDQo+IHVzaW5nIGEgbWlzY29uZmlndXJlZCBt
YWlsZG9tYWluIG5hbWUgdGhhdCBzZXJ2ZXJzIHdvdWxkIG5vdCBsaWtlLA0KPiBidXQgdGhhdCBu
YW1lIGlzIGEgbWVhbmluZ2xlc3MgbmFtZTsgZnJvbSB0aGUgcG9pbnQgb2YgdmlldyBvZiB0aGUN
Cj4gc2VydmVyLCBpZiBldmVyeWJvZHkgdXNlcyB0aGF0IG5hbWUsIHRoZSBuYW1lIGxvc2VzIHRo
ZSBtZWFuaW5nIGFzDQo+IGFuIGlkZW50aWZpZXIuDQo+IA0KPiBJdCBpcyBtb3JlIGxpa2UgZHVl
IHRvIG1pc2NvbmZpZ3VyYXRpb24geW91IGNvdWxkbid0IHNlbmQgZS1tYWlscywNCj4gYW5kIGJ5
IHRpZ2h0ZW5pbmcgdGhlIGNvbmRpdGlvbiB0byB0ZWxsIGFuIGludmFsaWQgbWFpbGRvbWFpbiBu
YW1lDQo+IGFuZCBoYXZlIHRoZSBtaXNjb25maWd1cmVkIG1haWxkb21haW4gbmFtZSB0aGF0IGlz
IGludmFsaWQgcmVwbGFjZWQNCj4gd2l0aCAibG9jYWxob3N0LmxvY2FsZG9tYWluIiBmYWxsYmFj
aywgeW91IG1hbmFnZWQgdG8gc2VuZCB0aGluZ3MNCj4gb3V0Lg0KPiANCj4gVGhlIHJlYWwgZml4
IGZvciBpbmRpdmlkdWFsIHVzZXJzIG1heSBwcm9iYWJseSBiZSB0byBzZWUgaG93DQo+IG1haWxk
b21haW5fbmV0KCkgYW5kL29yIG1haWxkb21haW5fbXRhKCkgZ2l2ZXMgeW91IGEgYm9ndXMNCj4g
Ik1hY2Jvb2suLiIgYW5kIGZpeCBfdGhhdF8uICBVbnRpbCB0aGF0IGdldHMgZml4ZWQsIHRyeWlu
ZyB0byB1c2UNCj4gImxvY2FsaG9zdC5sb2NhbGRvbWFpbiIgZmFsbGJhY2sgbWlnaHQgYmUgYSBn
b29kIHdvcmthcm91bmQsIGJ1dA0KPiB0aGF0IGlzIGEgd29ya2Fyb3VuZCwgbm90IGEgcmVhbCBz
b2x1dGlvbiwgaXNuJ3QgaXQ/DQoNCkkgdGhpbmsgSSBzaG91bGQgZGlnIGRlZXBlciBvbiBob3cg
dGhlIGRvbWFpbiBuYW1lIGlzIGJlaW5nIGFzc2lnbmVkLg0KDQpNYXliZSBpdHMgdGltZSB0byBm
aXggYW5vdGhlciBwZXJsIG1vZHVsZSBhZnRlciBBdXRoZW46OlNBU0w/
