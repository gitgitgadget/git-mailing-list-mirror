Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B414286
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015081; cv=fail; b=nT3yl993ga5O7RdzlMh0n4SL7xeOXz91L335T3lJcKZfIUAYSZ9YnobZbw7wMR/6wiYD4E5/bZxopUu4vjhps6ENgjU4ydqMP2pPhbU0OUzAsNQ2N4uz77IS13hBrA+vtCmm+mlbl5X3KLR1QxB7cS0GupS9xXe//vm04uNR7Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015081; c=relaxed/simple;
	bh=EYuCOM0/gUEynOOUfjNgDWC2msrWleYvqSG4amKQ5mk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBIVx7BVe1e2cIzAzwKRbu8IIxS/KgR0xbGEdAutKmyrRH2oXkeaqT+nTM+Nf70GDWkGBCzcM0ZkMSYEEiBe5qFxOgm0aWXKfRhSo6Ay0LWjYrxmzZt3fHwuUyXPAAGDdjumlwPX7kOblRqyF3uSfoCN9buTKLGyNIskz8ljhRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lJ44wI7D; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lJ44wI7D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iyn5wM5ncqv4xeFEw1maSRCqnu263f/7cPk0KGBAZdmYa3BCUwXf/+OxzLWrTa2zfIErhsLFCMikhFydzTNj716v+VQraMqm654OHmNsh8gmTw8CBwlRITNi4x3wq5c1Fs+frPUACl7Fvm7pMaSVvxecL39RWE+xoCXSbmqpUVGprbEe1cmD5ylvAL3oc7gvOy/KvSGM3x0CgjO6rvMTDoFEprSbk4QuSeXvid3x4b0aO8bMO2O988UShZ6T0WlvOQLvk5GgMJ6b4/mXZVtbl56Z2WQzoSZaErV9wvnxmwjKlD4GN/fiV/EgbpU2SjNoN+7nRK1oWQ6WjRdt91GP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYuCOM0/gUEynOOUfjNgDWC2msrWleYvqSG4amKQ5mk=;
 b=bD9gCKzhI1aUxjgBn0AgHHCCGUdWDcp0xphZ0pQ7ojia7JiJ43iBNQ+c4JWO6tBYXpG+BbV00xl5q+2TSDh//znUu5ofADNExDg0Jx03x+4cSUcIQ6iMUe65I0KKFZHXxHdn2faseMsqO/EJJwvUxD3FFg5dsCLHvaQ38W0KPxAxixaChTU9mmINnkS2/HWQpBvT0HmAtGrawFjVw0rezpfJMsljY55sQewOvGTwVlNcCcn8FynIN4DjIGN14LBoEDhqPr+kCG8pA+EMouKY5ebA1cmomy4+um4A2f8vLINkbUGRGlNoAZS54KPZ5NM2WgMaeNPa2m0EcRyPT0kr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYuCOM0/gUEynOOUfjNgDWC2msrWleYvqSG4amKQ5mk=;
 b=lJ44wI7D1rio7MTUdcqpd8MtucSqS4B2oLp12sUN5xBGtWc9xE32wFh/BLd+Bbg6S8YT7pTdbj20LWVyBh+1/cLPOrs+ksVTN6qlk2wSyXEUemeKF+egiq5W8UJttxwGfKJSYTPRsyuIk86s+mO+a5Ph2d6TVTH2MkM4JSaYuF/J/XrARPaF8eHZ3MkLY2Nl6kvNKq4m26h/jl9JjJ5SPazVkNUpYwv0wKocKUOJ9hK9JcXCNRHaOa7deU+sg0BkkPufbM4vva2e99NhcLTSoFOu/NXYTVFKWFnDU5Eik99MwlF2/x32LTK5Tw9Go5OIgdfgee/VmXGt0EgUgmXyMA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7742.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Fri, 23 May
 2025 15:44:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 15:44:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Topic: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Index: AQHby/htKvZwXEEIHk+Dv+1uNiSao7PgWymA
Date: Fri, 23 May 2025 15:44:33 +0000
Message-ID: <7077A82F-C1ED-4F67-9E85-94E42FA25FD4@live.com>
References: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
In-Reply-To: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7742:EE_
x-ms-office365-filtering-correlation-id: 13db9679-47fa-41a6-cdd3-08dd9a10b731
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|41001999006|8060799009|8062599006|19110799006|15080799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3hjamU3Q0IyVmNlSmhXUVEzRk5Wa24zOTlFRHhBcFRkNjNtMGQxYjdOb08v?=
 =?utf-8?B?cHJHQitkcXV6V2NqRk9zLyt2ZGk3WXBTQ1YwcmlGdERqWS8zMWxxTVExM3kz?=
 =?utf-8?B?Vnh4SG5qV0VVVGFNclFzQVVFUzM0WTZSSnJwQmZ6VWJWVjhRVUV5cC9xalNj?=
 =?utf-8?B?MWQ1TVdCMTQ5Y1Q1OEVSMU1pUWZSeUVYcThPSWEvL3FPR0hocGNRZWlFcFh6?=
 =?utf-8?B?NndvV3FoMkpUbExpZTljZW05clV1SDdVc3Z5ajJ5NjA2Y2x5dy9BN0trVFo3?=
 =?utf-8?B?VDBKcGZYVjlBRXZReGlRNnBRNXJhWG5Td2xjTG1hSXkzSUlKWHAzRFlweUFx?=
 =?utf-8?B?TS9pR1dSR3dLcXkwVEN5NU9wcExBNlpFeGtpMHNsTkF5WDBJbWYzOTN2aENa?=
 =?utf-8?B?Ykt2V3RFeFF6QVRtK29YcWc1UEJpR3N5bXFTMEMwbmFhWk1VeUdPUUplV3dE?=
 =?utf-8?B?Ykl4YlhJUzYxRDJtanVtSVVuV1lsQTFCeHMwTDFyNTlQRDBkOXA2dmVBR2FZ?=
 =?utf-8?B?T05QbS9XcTFHUWdqS05vNzcwdlFQekF3WVJ1dkxvb0Z3UDVwU3JVY0NoV0VG?=
 =?utf-8?B?SzVqTUtpRVljUG5QbzROeEJCdFpBLzdiNElRa3V5NUthNDZ0OEJ4b3FycnlF?=
 =?utf-8?B?c084Ni83cTd3Y0UxMVZVdkR2NTM0dDRDZkd6cGZQekdKTnpDOEZnTlZ0L1dw?=
 =?utf-8?B?QitwQzlUL0E4cXAvODVNRzd3SFFZN29oKzlqOVhBb01rM2NMeGEybmxCOC9m?=
 =?utf-8?B?VVY5QnloOU5xTkVXSU1hY1k0K1Fvblo0YXl6d0YwdXY0MG41MHVZN2Zad3Bw?=
 =?utf-8?B?aVR2THdoRHBqQ0xXeWVpRWpVWk5HNksxSE50SWVZSFFmVzErL2p4dUVLbXVJ?=
 =?utf-8?B?UWM1R3hOSUtLMkF5V01BMWZnTEFwZVliekQ4VFdteVJjNXlRTDN6NUlxZGRP?=
 =?utf-8?B?S2NRbmZGb1dRekM4dVpOeEhwVCtXRUg4dEdwQ2VLK1VxNnhpL2crdS9pM1dp?=
 =?utf-8?B?YWRGY0VIU3dCdkNWYW53UDZ6cjhhUXIxZlJJMWR1V1dpSHBNaUhpSXM2VG5i?=
 =?utf-8?B?Z3dQRlI1Uk1LUUJoNmRaeGRZbzhPaUU1T3NMNFNUVEZSb3RWQXBzWkdJMEg3?=
 =?utf-8?B?d0tLckZMR1ZrWkZqNXhCVDhvUjQ3R1hVSWl3TzJqQjMzOW15ZUFvNFZHVEJj?=
 =?utf-8?B?V3FpZDdyM3c0VndlMlV2NjRZc2U5WFdpUUZlenkrUW5sMlRQYURFckRjQlFM?=
 =?utf-8?B?OXhBR1FhVllxaWhFY1ZGSkVLVFAzSUxHSzNhSDdmdFpkcStPaE5PQ1MxUVBI?=
 =?utf-8?B?Z05Ib2t6NjVCa3kvZ01uZkFXUkJoSkRKRTRkSzZ6enZaNVVGVkJJTlErVTBa?=
 =?utf-8?B?dU9ZalZadmRubVk2djBDMkJsVXE1cG0yYTlqdEl6MHJQc0VGRzFOUklFSHdN?=
 =?utf-8?B?Nkw0Z3Y5U3NPOENmb1lYMklnUFhQQnRNUWFaayswQ0R1QjdUU25EcHgxWDJS?=
 =?utf-8?B?L2tRVjV2SGgzWFBKQnllcWJ3bFJXejFoYW5SbW85ejI4Wkluc2cxdVowbkdT?=
 =?utf-8?B?NiswQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NG5FZS9HeU5NRzdvcU9TQ2hDSFNjb0FzeXFwT3h4c1E3L21kejBScnprOERw?=
 =?utf-8?B?TENISUhTYUVraFZwTk52NE5iSGZLUUxHY1VNbGIxa0JGcXNRdklTNkx5dUVi?=
 =?utf-8?B?a3hvWGhGV2xObjdLMlhjQ3lZQ1E0OEZaOGRTWFR3cjAxSVlsVnI3UzVlVjFp?=
 =?utf-8?B?eTkrL1lHZFFkNDJtRFdyS3lQSjZrSFdnOUdOWW9CZzNmTVl0VXhKTXhidk1J?=
 =?utf-8?B?N2ppdlpad0ZVbkxNY2VqbGo4bkprcXRBbk5UNENTdEpjRFRaUk1jKzViUld0?=
 =?utf-8?B?TlErRnJXNzlCeW8yWmFpRFB5WHJUM0tTVTlQZGtEUG9pZUtIQXZQOWVWK0My?=
 =?utf-8?B?REVXRUJvU1Q4czFuWU1KRDdvWnlOYUdqMW9ZWEFwOWtwQUdxU2xkaEpXa0pl?=
 =?utf-8?B?aXNFVHlRdXlmQzR3QVNNTFRGMDRPWDVSNUc4WlB6aHZBWG51clJGb1dMdFRL?=
 =?utf-8?B?ZjBvMzdtSE8xczVOZU1LSm92OHZzMTkrQ0xxRDkxeVdIMVpwUE1lZFNhMi9w?=
 =?utf-8?B?T3RCRW8yQVdLUDZKY0RFVWI3a293WThNQWdGZ0FLTTFWREdrSnFJOHZRYTky?=
 =?utf-8?B?S3ZZRTVYUXZnOFBJZGxHVWRJVkFMajVBU0grcDRVTE8zMDFtWk1SYm5NRGdr?=
 =?utf-8?B?Ulh6OERnVCs3WUJIKzh2UFpzWFR3WkVKc3BQQ3NvTzBiczZNcE41cC9Fbm5X?=
 =?utf-8?B?RzJhdHdRS0JGeTVPVGpQeVNIczZiN2d0WFFrd0xoNDBKVlRocUZ5b3FWZXAv?=
 =?utf-8?B?UXI2amlqc1VNckdWbmdqNHFwZGF0cHpmZHkwd0FFaGJhZ0hLOENheWdkTXlP?=
 =?utf-8?B?MkpqbzJXbzZLRk9rVjVqSEdpRUdBVXlWbm1RYSsxMHRSWnBYSXFJeHBLa05M?=
 =?utf-8?B?dFd4SkZ0K1ZEcFRzVzNQWTF1eXFWbUR0VmIzL0FRajZ1bk1zNkYydXdVRkxh?=
 =?utf-8?B?aWhSTTU0K2VnOTRpU1JBQUk2bUliNjFXRWE5Uy9lbmk3Y0FVRDlZZjgwa2Fu?=
 =?utf-8?B?bG5mdEY5UXR2ckJYYTRpeGdLbTB5ZmczSFlkWW92RjUwZ3kzQS9vaTVsWTZD?=
 =?utf-8?B?ck9aY2p6Mzc2a0NVMGNsaFZZWnhnZEltQzVJb1ZQdHQwZVBEWHFwemZGUHJm?=
 =?utf-8?B?b29hcXY3a3lMRWQzZW1MbW43UEdRdDFwVGNwQXpVUkxraWc1UFRBa0pucTFI?=
 =?utf-8?B?Y3lidEgzQU5rZ3l6USsybHk3NC9yczlQQWltN01IZGowZEtWTWdUZjhFcW5U?=
 =?utf-8?B?ZWptWWZ4bGtUcG5RZEdWVHFDTHd6Mk9McUJnUzNOU0g0d0JXUmFOZlpKOE1x?=
 =?utf-8?B?Z0lBSjJYamJXMk8relVoK1hMVVMzRFNjTHIrQlkvemZUWkJBWmxMemlNZHM3?=
 =?utf-8?B?VC9DQ2F5NFlQUzhMbWZLM2ZBWlJkZ2Z5QkROY21RU3pxdS9kdVd2YlVXb3lS?=
 =?utf-8?B?YVg1YnhTUUdtaUtqTERFZjF0Qi9ZLzE0dkpLWU5LSXVuUTJjbnNwZkt2ME1Q?=
 =?utf-8?B?SHRFeXBweVdlWXNjU3VaNFNBOXd1bXJnaWgxckU0QXNsUjNlWXV1Y0puM1p5?=
 =?utf-8?B?SHRnbXpwUngxYy84R25sK05ud1J0K0wzd2pqQ0wraEZjZnBKRmNzTzFEQkRt?=
 =?utf-8?B?Q0lvcC9WY0FMTG1YS0V6TnRnUWkxSGlDdzkvcUZsZUxGdU5RaTdlNEp0L2Iy?=
 =?utf-8?B?SkpOU3pyZW8wU1l0K1pFZllBTkVoSmFrWEhSL09zQStoWnVMNE5La2x0eTVJ?=
 =?utf-8?Q?ufPsPvFIEmZMeVHz9DJpvqkbV2c1RijoWLcrE7l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAF11701F6CECB4F9212662F03A5B022@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db9679-47fa-41a6-cdd3-08dd9a10b731
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 15:44:33.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7742

DQoNCj4gT24gMjMgTWF5IDIwMjUsIGF0IDk6MDbigK9QTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiBUaGVyZSBpcyBhIGJ1ZyBpbiBzZW5kLWVtYWls
IHRoYXQgdHVybnMgb2ZmIHNoYWxsb3cgdGhyZWFkaW5nIGlmDQo+IHNvbWUgc3BlY2lhbCBjb25k
aXRpb25zIGFyZSB0aGVyZS4gVGhvc2UgY29uZGl0aW9ucyBhcmU6DQo+IA0KPiAxLiBBbiAtLWlu
LXJlcGx5LXRvIG11c3QgYmUgc3BlY2lmaWVkIHdoZW4gc2VuZGluZyB0aGUgcGF0Y2gNCj4gMi4g
V2hlbiBhc2tlZCBmb3IgY29uZmlybWF0aW9uIGJlZm9yZSBzZW5kaW5nIHRoZSBmaXJzdCBwYXRj
aCwgdGhlDQo+ICB1c2VyIG11c3QgZWRpdCB0aGUgcGF0Y2ggKHByZXNzaW5nIGUgYW5kIGVudGVy
KS4NCj4gDQo+IElmIHRoZXNlIHR3byBjb25kaXRpb25zIGFyZSBmdWxmaWxsZWQsIHRoZSB0aHJl
YWRpbmcgd2lsbCB0dXJuIG9mZg0KPiBhbmQgYWxsIHN1YnNlcXVlbnQgbWVzc2FnZXMgd2lsbCBi
ZWNvbWUgYXMgcmVwbGllcyB0byB0aGUNCj4gTWVzc2FnZS1JRCBzZXQgaW4gLS1pbi1yZXBseS10
bywgcmF0aGVyIHRoYW4gYmVjb21pbmcgcmVwbGllcyB0bw0KPiB0aGUgZmlyc3QgcGF0Y2guDQo+
IA0KPiBUaGUgY2F1c2Ugb2YgdGhpcyBidWcgd2FzIHZlcnkgc2ltcGxlLiBUaGVyZSBhcmUgbWFu
eSBjb25kaXRpb25zDQo+IHRoYXQgZGV0ZXJtaW5lIHdoZXRoZXIgdGhyZWFkaW5nIHNob3VsZCBi
ZSBkb25lIG9yIG5vdC4gVGhlDQo+IHJlbGV2YW50IG9uZXMgZm9yIHRoaXMgY2FzZSBhcmU6DQo+
IA0KPiAxLiAtLWluLXJlcGx5LXRvIGlzIG5vdCBkZWZpbmVkDQo+IDIuICRtZXNzYWdlX251bSBp
cyAxDQo+IA0KPiBJZiBBTlkgT05FIG9mIHRoZXNlIGlzIGZ1bGZpbGxlZCwgdGhyZWFkaW5nIHdp
bGwgb2NjdXIuIE5vdywgaW4NCj4gb3VyIGNhc2UsIHdlIGhhdmUgZGVmaW5lZCBhbiAtLWluLXJl
cGx5LXRvLCBzbyBjb25kaXRpb24gMSBpcw0KPiBub3QgZnVsZmlsbGVkLCBhbmQgdGh1cyBpcyBv
bWl0dGVkIG91dC4gVGhlIG9ubHkgY29uZGl0aW9uIHRoYXQNCj4gY2FuIGVuYWJsZSB0aHJlYWRp
bmcgaXMgJG1lc3NhZ2VfbnVtIGJlaW5nIDEuIEFzIGZhciBhcyBJDQo+IHVuZGVyc3RhbmQsIHRo
aXMgY29uZGl0aW9uIHdhcyBiYXNlZCBvbiB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoZQ0KPiBmaXJz
dCBtZXNzYWdlIGJlaW5nIHNlbmQgd2lsbCBoYXZlICRtZXNzYWdlX251bSBhcyAxLCBzaW5jZSBp
bg0KPiBjYXNlIG9mIHNoYWxsb3cgdGhyZWFkcywgd2UganVzdCBzZXQgaW4tcmVwbHktdG8gb25s
eSBmb3IgdGhlDQo+IE1lc3NhZ2UtSUQgb2YgdGhlIGZpcnN0IHBhdGNoIHNlbnQuIEJ1dCwgaW4g
Y2FzZSB3ZSBlZGl0IGEgcGF0Y2gsDQo+IGl0cyAkbWVzc2FnZV9udW0gaW5jcmVhc2VzIGJ5IG9u
ZSwgYW5kIHRodXMsIG91ciBzZWNvbmQgY29uZGl0aW9uDQo+IGZvciB0aHJlYWRpbmcgaXMgYWxz
byBub3QgZnVsZmlsbGVkLCB0aHVzIHR1cm5pbmcgb2ZmIHRocmVhZGluZy4NCj4gDQo+IEx1Y2tp
bHksIHRoZSBzY3JpcHQgYWxzbyBrZWVwcyBjb3VudCBvZiB0aGUgbnVtYmVyIG9mIG1lc3NhZ2Vz
DQo+IGFjdHVhbGx5IHNlbnQgdXNpbmcgdGhlICRudW1fc2VudCB2YXJpYWJsZS4gVGhpcyB3YXMg
aW1wbGVtZW50ZWQNCj4gZm9yIHBlb3BsZSB3aG8gaGF2ZSBzZXQgYSBwYXJ0aWN1bGFyIGJhdGNo
IHNpemUgZm9yIGVtYWlscy4gVGhpcw0KPiBpcyBhIG1vcmUgcmVsaWFibGUgaW5kaWNhdG9yIHRv
IHRyYWNrIHRoZSBhY3R1YWwgZmlyc3QgcGF0Y2guDQo+IA0KPiBTbywgd2hlbmV2ZXIgdGhlIGZp
cnN0IHBhdGNoIGlzIHNlbnQsICRudW1fc2VudCB3aWxsIGJlY29tZSAxLg0KPiBJZiB3ZSByZXBs
YWNlIHRoZSBjb25kaXRpb24gdG8gdXNlIHRocmVhZGluZyBmcm9tICRtZXNzYWdlX251bQ0KPiB0
byAkbnVtX3NlbnQ9MSwgaXQgd2lsbCBhbHdheXMgYmUgZnVsZmlsbGVkIGlycmVzcGVjdGl2ZSBv
Zg0KPiB3aGV0aGVyIHRoZSB1c2VyIGVkaXRzIHRoZSBmaXJzdCBwYXRjaCBvciBub3QsIGFuZCB0
aHVzIHRocmVhZGluZw0KPiB3aWxsIHR1cm4gb24uDQo+IA0KPiBUaGlzIGJ1ZyB3aWxsIG5vdCBi
ZSB0cmlnZ2VyZWQgaWYgLS1pbi1yZXBseS10byBpcyBub3Qgc2V0LA0KPiBiZWNhdXNlIHRoZSBm
aXJzdCBjb25kaXRpb24gKG5vdCBoYXZpbmcgYW4gLS1pbi1yZXBseS10bykgZ2V0cw0KPiBmdWxm
aWxsZWQsIHNvIHRoZSBzY3JpcHQgZG9lc24ndCBjYXJlIHdoYXQgJG1lc3NhZ2VfbnVtIGlzIHRo
ZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZl
LmNvbT4NCg0KQlRXLCB0aGlzIHBhdGNoIGlzIGFsc28gbXkgZmlyc3Qgc3VjY2Vzc2Z1bCB0cmlh
bCB3aXRoIGltYXAtc2VuZA0KdXNpbmcgWE9BVVRIMiBhbmQgQXBwbGUgTWFpbCBhcyB0aGUgc2Vu
ZGVyIDspDQoNCg==
