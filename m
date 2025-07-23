Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED44229B2E
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293325; cv=fail; b=Grfh14VoWKAg6WyXr2UCnof6CVSpmDIJbGVYuhRBnoyY+e58Z2ys7t1D8sB5S7f1kkwxIwkSu4yXlUVpEsX5zptkm/gRO6SB5OeLlF1kMy8s2NKCUxkzTjSklcHdZOU6wLyrXKPo8YKiCB+cKkEZ8Ey2ZnzKf53JPWM488ZJo0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293325; c=relaxed/simple;
	bh=JcLDFI69LI3IEkXtTO1u/dLWnkm99AC8IjK7TD6Bv0Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TfMCuv8hls36EB3b8780QEBCX6/ZeTFfytutFtphOtW0ltrkQyHEWZEt3cmgd8/Aks5HoIQvkktp5PXWCTEubC9cldXLbFhr3JWaZVC9HU/1xcyUJgqFjk62eAS5COa9+hIUcJXTRJkGEty6WuWud7IWMbd272TrzwOSuwAZL6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=eni0jBYu; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="eni0jBYu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/DzGjZwPv6oelRAG1puCAjhlOi22OLGcjrMZZ3BgMo1HYnjaOqmqE9m/Aq50iGpC+0+HaavcPwttQsP+2teORr4MhhNlaJpBcB95YzMkfKjSCfKMYVZtGPamxhfyARyr4Od4InNnrY8wCRmQfGuEWpQ/7xKf3VznfR/IksQs5gfbaz8mD7Te375eHrrVOMOR0Qr74gnWC6SIGRM2KwE07Gku8UYoxbWeKy7LVDi0iCg9XkRJUcovkB8h8d2f9XKBFas0DKrGRn3eqEL6GRLXMQnjcD2u7hdKf8EH0Jv9OAdcCL3oMKC/px6TNx8cNaT5UoEZlx3tuP6WYOvlKSWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcLDFI69LI3IEkXtTO1u/dLWnkm99AC8IjK7TD6Bv0Y=;
 b=PdT+8BjCA05OWC4IrbSVmXbTiGjEmcfx1Kev435FUQCtU/vMfPE6vM4XhHX4S1Qs8w3xmfDMKQ3YF5d3a1syGbmnIwsKn99tJP/SXVQyy2CCY9yMNZfN6EEXCrX6TVErRJ7iCH5ft/zTUazATfrvhLkbBZooMNtKNiSNg6aTCVuWInA5NOXw5B/upSnXwZBWNu4U+XsA6m31tYfwQYJ/SF4HMSL0J7tHnJC6E6rflr4xzpN/RUAGilUGIu2y0okVi7EgEGQkwa1511KPbl75Iy0pqAjydq9TxMOtAbEN1EI2Ob3eTN02TrqU9MtGG4JGG0M9qvMyy+MHWX5KwlVfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcLDFI69LI3IEkXtTO1u/dLWnkm99AC8IjK7TD6Bv0Y=;
 b=eni0jBYuTp6g7+//tfr+SFslnDHNKfuUfDWTkycfq4ghmol2W/7vjw/Wah4DF9N+MCuwTVlZjakoDwz1BKmCSmcBuMVibWi89Y068X3rMHg5VpHnjq2/Gd5ZxVMUda0H4dTdpLADt5QmHvwCvto/uurLYPPq124nqtdN+dzkWjgkI9cH88dbeaTmx14OGo2tU0xkb5TGVDNAoUeryEEXAHh8NSbwsoUKTw/gRxUxZpdv0RA4yCNeTmqXahb/lLN1eFcPFLHdN33ptvKikHiwUc+Ou7M8+8xVCG9Ku1SvV4itwBvonmjd3Mky+kX4yb7e+dQjbUPA6NACiyQ/NUaPeQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:12c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:55:18 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:55:18 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, brian
 m carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
Thread-Topic: [PATCH] imap-send: add option to mark sent messages as read or
 unread
Thread-Index: AQHb+/rzfo4v+HgZgEC9EL0UMPLSGA==
Date: Wed, 23 Jul 2025 17:55:18 +0000
Message-ID:
 <PN3PR01MB9597E3E9F6356FC4DF651DA0B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB10018:EE_
x-ms-office365-filtering-correlation-id: 46b564a1-ffbc-4fe9-edb1-08ddca12160f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|6072599003|15080799012|8060799015|8062599012|461199028|4295299021|440099028|40105399003|3412199025|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?OG5tb3N1SmhOY0RlYWFPaTU5ZlliZGluWWlEMnhnbUpHWi82NFh6bk4yZXFU?=
 =?utf-8?B?TDlXY0lydWxzN20rNlVuTzVkZjJ3cHVMYnpVeGV6eTVKOHFBMVpLODJZdU55?=
 =?utf-8?B?YUhZS0t3bnRqNWE0bEFqd2lXUkx3cEp4ejJsRDdhT3NVS2lRMXFHTERzMWIz?=
 =?utf-8?B?M1M0R2JrUGVhdjlZUzU0emZCVzRyRjF5YVRDbFV2ZFR5TTA4YmVaNGNyUmxV?=
 =?utf-8?B?ZHVKZERPSFhJU3R2M3M2WThtTU9iM2g4SjNQU2tKWEdMMGVhaTh4ZU1EVkMr?=
 =?utf-8?B?VFBrZVZOaGkycTRKUjkwcXpyUzFGdE5Zbkx2ZDBMZExyQVVUUk5GSGN3eW9i?=
 =?utf-8?B?VjBSKzhxNWVwSHJPZ083RGdkVll1Tmw2U2didFd4ZkdqUldBbFBqenEwcG1o?=
 =?utf-8?B?YlIvNkk5bEVuZWpxcEVHZitwTlhVMEM1blU3QzdKVzJpUmZ0MnhwcHBtVXMw?=
 =?utf-8?B?VWxFQkhrV0NhaGpOeWFVN1VRYjZwclluRTFJYjZqQis4eTdUS2l3Tk95cFlX?=
 =?utf-8?B?bXlMMkpHUXArOFE4Vk84aUo1UVRmUVhETGd1VTZPOVh6cG12YWx5WEdPWXBq?=
 =?utf-8?B?MWFGQ2Exa1dGUW96MFd0MEpUMnMwS3l4VVhENzczUlFDbUJrYTRqRngrUTRU?=
 =?utf-8?B?eVkvV2Fha1EvWGFrOUpraUdXRVd1Z1hseDFlWlBxUUtaRmtpOXdJcE0xQ2Qx?=
 =?utf-8?B?QVdSQjlQbTM3cjdYb3BSVXVkTkpwNS9SdHE4RE5kR2VTa3QvOXhabzNESWIw?=
 =?utf-8?B?WFQ4Q2tSUjJjS3g1TVhtMmk1OGRRcTB4UzdnNXQ5NUY5SEhSNDVmQWhOcUVI?=
 =?utf-8?B?emxHY2VZN2l2S1N1NWxpK1cyV0hiWkxCaE5XVFkwODFRWGs2TzhCZGxhOGNw?=
 =?utf-8?B?T1VoQlJTVFhSRGIyd21hN1kwZERNZ0RLN2xDTGF5QU4rS0FUeGdXVVFjeXZG?=
 =?utf-8?B?VVlqQ0dmdCtOUVoybGhiZkNETThwNzhCTnI3MWtWL2kyTWdicjVRWDU2a2Nl?=
 =?utf-8?B?cGlVNEFtYyt0NEhMWElBTC9yOFFUckFvdG81NXNlWkh0bTlmWExvNkxrYzlj?=
 =?utf-8?B?ajNpN2l4YndTZnRiam41Z25uUzd2eEJCNGdLZTFESU5rYjQzT3p4NklJbGMv?=
 =?utf-8?B?OGJnOXFBNVI3WnRWaWl0VXlBQXRBTDRnUGpCejF3aVpSbllMTUpuSk9LZHJx?=
 =?utf-8?B?Z1paajhQRW9CQkMrZ0FCSjlXWG5sR1Z1RTl5T2FOemdpSTRxUkt5RWlqNkRK?=
 =?utf-8?B?TDhqLzFkY1p0dzBkaFRUazBkZ1FRMjJ1cDZPcERpWXVUQjI0U3I1R3NyVEps?=
 =?utf-8?B?YUNVZ0lzRDhTR2pjQkJMM1B0dE8zNDU3cmprSGJQdWM1OFJPN2s2dEdDZVNy?=
 =?utf-8?B?MDF1bE1IS1RYclk0QWdyS2VnZmE4cnozd2JLVGdjVlRGTFhWY21pcGlyRWVk?=
 =?utf-8?B?UTZYZUZzdU91MDBEak04ZThtK0x3VDR2NzV5UkVvMERlRll5Z2xCYTNkZkRH?=
 =?utf-8?B?NXBpTzM3aXF2akx6WGVYNkxNSVNDblV3SE05MElHS3BhTG85WGJubytpU0dt?=
 =?utf-8?B?dSs1bTZaYlQ1OThZakNySm1PbklJYlQwOHYxRi9ZMWZMUHZLMU5KMzlSZHR0?=
 =?utf-8?B?anp6cUpjV2RZQ0FiUkY0YjJtN1JtcHc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm82OHVJb2l3NXN3dTA5MUd2ZThiQ0xwcEtNL2gvY2ZGTXBjUWVJTWFYUXJ2?=
 =?utf-8?B?NFVmUXo1RnVYSTJKK1Z3cmJxTnVYcCt3bUdBOGtlWk5oYWNOQkVLRzdSMlpI?=
 =?utf-8?B?YnpFeWdRSlhuRnlVMFlNZ2ZSL0wzMTlNOExoOUpVd0wvZDI2NVUzRHgyVnJI?=
 =?utf-8?B?c1VibkJ2b0hnWDQreXJGZHNuK2QxYWJYUHUyQmMzUnNJZVRibE5XSldXOHFP?=
 =?utf-8?B?aE5HTnFZVzB5bmNIbWYxSEZ4UjBXLzB6aUFYOEJlYld5MHFRak5vMnk5NWFq?=
 =?utf-8?B?MUgrbjZON05KSk9UeWVHSHduTExXcTFEOTBENmpJNE5RTjB3RnFOcmtWSDJ5?=
 =?utf-8?B?VDJ4dzM1STBTV29lMmxQRHUxVUQ1eXczM0tCMERwd1ZXb1FzNDBEekYvaXVa?=
 =?utf-8?B?bGdpNlNFMklVdDF3TkQzbzV6UExYVFlOVW13WS9GNXNXNUxVZEFGTjZ4N0Zm?=
 =?utf-8?B?a2o1NnBRa1AvYkQwWmpoekFJc3B3VXFBZ29aQnlZa2pGcWM4YUxMVHRKZnpC?=
 =?utf-8?B?cHBHSWJDZVJoeVNnTGlwaWFvSGpXMFhhdHNReVUyNzV3bDMyaXRDVThVUGRX?=
 =?utf-8?B?TG90TmxVa29IOFJIWkhsbkErK09UdGw4VVYweVVuN25CMFFsZEorcWJZWklh?=
 =?utf-8?B?N0dGaTVTQms1WXpiaDNEUGpwcENxa3c1YjE1RXoycThWS3g0M2E1cnRmQUJN?=
 =?utf-8?B?Z1hSOXZJK09zQjM5TW5aZWxhNmxMOEpJMEFVQmJPNG5LdXJzN1doMW93VkpP?=
 =?utf-8?B?UHVvR282d0FURWdhNTlYSDZUQmlDeWcvRkdRd0RDYit1YWU0bjdUQjdQak9B?=
 =?utf-8?B?ak1lVXF6NkpqcGk1VXlSbGs5RjFaRmU0NytFTVVGNm9wenRSSnFMbS9zNDRj?=
 =?utf-8?B?ZUNaOEpQdmNmdk9HVTBwd0F6Y2x1eFZVWXhZUC81UDAycGFmNG1nY0tqV1Zq?=
 =?utf-8?B?VnFQb2NLS1ZTUGJZU3pPN3FPcWtrSGJ0MU1HeFlmZkM1OS9zVkxDb3NMNnVS?=
 =?utf-8?B?a3RQSGR2UFhEMTRCOTJYc0dwRVpTd3E0NU9ZcHQ0TmxzdHdUQ2s0MXNneXdB?=
 =?utf-8?B?QmFzM1VydTV0Ull0eWR2REhYU1gyc09ETlczUDFncHJrcU1EOXJDcDdmS2pV?=
 =?utf-8?B?aE9DRC9iVU9weDlEdmxFa0hlSys0Z21qSVVCc0lZMDlRT3pyZmwyclJHaHUv?=
 =?utf-8?B?TVpSQ1lqY3FKekZPTTB0RE94L294R1QwVFVsd2xvUlpwV1AvbUlQbWxiOXJy?=
 =?utf-8?B?dTNpZG1zeVBmYlFHV3BWQ3RkdjdGbEN6L2dBNHM1NlhIYlZVVWE0c3IzVGdV?=
 =?utf-8?B?QU9CWTRTQkJNYkt5a01FY0FCc25rNTB4cmxuOW41MDVyRmwrWDlwZEQrYWQ4?=
 =?utf-8?B?dk8wYWZrbGxpbmh0bnVLRHhMWVliUmlyenV2SGZmOTBpRWdlc1VqTjJJWGN4?=
 =?utf-8?B?NmN3NHpibldvajE1cUVGRGdOUjAvMFJnNTEvQ01rVzE3QzVGdTQ1ZHM5T0w3?=
 =?utf-8?B?QjQ2TERsZjhHQmJpWlVQd3FHYW5hZlJ1N0luRUlIcEUxeWZ6L0VxNHZxeEVP?=
 =?utf-8?B?L0VseEFzM01qanhkWURYc1FicU5QMVcyZElQenpWaHgwbG5uc0NmMTJXMkxn?=
 =?utf-8?Q?cHUT7Y+jnd2pQifCKPPDsXP93fGzM8zhW87eKCZshvaY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <B7BF768F2867B944AA1F57F54779711C@sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b564a1-ffbc-4fe9-edb1-08ddca12160f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 17:55:18.4334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10018

DQoNCj4gT24gMjMgSnVsIDIwMjUsIGF0IDExOjIy4oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79KdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBw
b2JveC5jb20+IHdyaXRlczoNCj4gDQo+PiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxpdmUu
Y29tPiB3cml0ZXM6DQo+Pj4gKyAgICBpZiAobWFya19zZWVuKSB7DQo+Pj4gKyAgICAgICAgY3Vy
bF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1VQTE9BRF9GTEFHUywgQ1VSTFVMRkxBR19TRUVO
KTsNCj4+PiArICAgIH0gZWxzZSB7DQo+Pj4gKyAgICAgICAgY3VybF9lYXN5X3NldG9wdChjdXJs
LCBDVVJMT1BUX1VQTE9BRF9GTEFHUywgMEwpOw0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+IFdoeSBz
byBtYW55IGJyYWNlcyBhcm91bmQgc2luZ2xlLXN0YXRlbWVudCBibG9ja3M/DQo+PiBBY2NvcmRp
bmcgdG8NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9jdXJsL2N1cmwvYmxvYi9tYXN0ZXIvZG9jcy9s
aWJjdXJsL3N5bWJvbHMtaW4tdmVyc2lvbnMNCj4+IENVUkxVTEZMQUdfU0VFTiBmaXJzdCBhcHBl
YXJlZCBpbiA4LjEzLjA7IElOU1RBTEwgc2F5cyB3ZSByZXF1aXJlIDcuNjEuMA0KPj4gb3IgbGF0
ZXIsIHNvIHRoaXMgbWF5IGJlIE9LLg0KPiANCj4gSXQgbWlnaHQgYmUgb2J2aW91cywgYnV0IEkg
bWVhbnQgIm1heSBub3QgYmUgT0siIGhlcmUuDQoNCkkgdW5kZXJzdGFuZC4gSXQgYW55d2F5cyBp
c24ndCBhIHZlcnkgaW1wb3J0YW50IGZlYXR1cmUu
