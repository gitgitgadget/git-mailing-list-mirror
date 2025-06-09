Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5420EB
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495944; cv=fail; b=sO6y/Rx6wHNVOpFpv8EqfmXdwPPqG4KT7C6aljlexqvjSweELshd4rZAtxgmjoUo6ZkFqn1ux6IV80ShKU/3qtaQg4xLu97v0C2hT4Z8yBrX5Y0HUnyRNAXppT3li8UXvNzBNmLa6B61uZ6WC5mMjbzeugt5Chr7IiQp9bumCUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495944; c=relaxed/simple;
	bh=WDtizpE4rnd+HuUeiyo7uikF+zs7fdXUFOWNiUAL7hE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qvy6/88dfnYs+WUaCSe1KPxZYduLD7DV8HyL1D5pau7OyjKmiKc5HmNoMpYQGniVBTFR6El4IsJ0eMEN/vEOIn2WCfF4Hb+Vf1WUndTifnqsR6W4n1KIU3UyoA0+TwjNKIQVR9jriT9vFb1+fssWPdVNJyydgyoxHz1/RUx93uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=F8iJmJXc; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="F8iJmJXc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HizbGSJPnT4nkYPedhQk4IPwxnhf/FIMHsjdiRSxT/dLGyVm2ospskf/+zsJmcJQyamG864egYL5VreGJ0xhU+TgEom1GBNBEFe7qai4FyQd3NGvK+JJTZqIR4YnQsjumVDQeD+kAjNLFDkuzZ+JjszXTYwmGn8C6jGsRxVtkUXZfKjz6q2ZlqwVbGW7L2b88mY2tI1pIiK/rhqkdcoEuemk8Ww8j6fyxeENi6XUaJVSuuRv+s22vzF+AU0S+5Da7idLkhS/U1Uk8kZj16sU9Okr6m59YTY3S0VO/7FqI0Tki7RDlPQaIBiKMkIMi0auv2pLvny+H+AGxNt99z9ObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDtizpE4rnd+HuUeiyo7uikF+zs7fdXUFOWNiUAL7hE=;
 b=tYBmk77G8uiSKxaC9FhoGs58/QFmwOaxpIAfaamu9wubcDE4d8vj72aDXdkloOeJaGaTIFpCpPl1P0aZoqkmqhWH6XhJ+JscoHXNgRN7AGnGnkQxobyS8fNdlMR06UMBEqlSYYWDEi54uzeRzbITenZncOKefmiEgDj6GdupazTBqSZ9ov/otdleD+6UG//MVwCh+6CpImqTISREebD9CrRWO8dEum8s+Bc9Q6vEIqbw2VLP0bHi8hTcNRjTiikrfZyTZV8DBUCocwczexpOfnvhS7SyWqR7G4o/L3OZwjc66/LrEEhX6aVxlG4zhh7LWdL6+n/ILDIKmEQIOk3zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDtizpE4rnd+HuUeiyo7uikF+zs7fdXUFOWNiUAL7hE=;
 b=F8iJmJXc4pYvWnQDPQL/dYgJzAkOqS/XPwGCzIeQ+pIfvNJfPaGuKUxlK7VmRrl/qf6Jqw5OkuB5KVjDOmv9MEhVBpmLpRV4iaY1BPwod/vUeIktmzy++xnKvBvao43lozpUD/7bgeL5HTulcLaS4vn9oCTGnqYYY0YO3/tNCx6iAGWc0S9AdqH0nnmt0KcDR8G4b4wlQI2ZoEMwIceg4xSmVY0Wokld68+pWXb28FhtkFnnvEbBZ/JmCBkyNOJAnvUC/KRrScyU06FWQ9X7gfxbLJ4Zjh6QQwzMbmvrf6UWmUOJvuD/3eK/Xr9vLwRjPDwowCtAp7yGwQaCLKGWgg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7264.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.31; Mon, 9 Jun
 2025 19:05:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 19:05:36 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 09/10] imap-send: display the destination mailbox when
 sending a message
Thread-Topic: [PATCH v16 09/10] imap-send: display the destination mailbox
 when sending a message
Thread-Index: AQHb2Q8mslVKeDxtf0mPOK15AN2HgbP7LorNgAACTp0=
Date: Mon, 9 Jun 2025 19:05:36 +0000
Message-ID:
 <PN3PR01MB95970507E31975C5E9F0AC4AB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597647A1FE9451BF9EB1C6DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq4iworbef.fsf@gitster.g>
In-Reply-To: <xmqq4iworbef.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7264:EE_
x-ms-office365-filtering-correlation-id: d35bf8a6-499d-4bb0-325c-08dda7889e37
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|7092599006|8060799009|461199028|15080799009|19110799006|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?WG1WWmtPcVFLLzBSQjVvZk82SDhRZXo1aW1HU0VwMnAydUwzR1ViNVFma25Z?=
 =?utf-8?B?TWVDOFpYSjVPUG5QS3FDWE0wQzNieUkyaWt5RUJoSHlWSVdnT2xQU05wT2or?=
 =?utf-8?B?SGNCbzkzS2FRRjhDS2xrSTJDckV3Zm1RTlZvY2NyaDIwRmRWblRYUDc5RHlt?=
 =?utf-8?B?dkFIYXJKUkVvcGkrWGk0b1c0ZHFxNDJHSU1sN0RQbzdUdXJ5QWhoZ2pJd3E2?=
 =?utf-8?B?QjFlMi9QNE9OQzMwUjJUTGY2aG9DOXRXNDVwbGQ1aUd6eFVUUi93UGhwb2JR?=
 =?utf-8?B?bzZYb2NLbUJZTSt2cjJ2ZWFoYXJmaWJaTnAwQUNTTndsU3hRS3FSUnJpc3U2?=
 =?utf-8?B?V2RqQU5kQitycFBBR3BDMGVlcFNheXFPSS9xNGphYjNxWjRjSTF3ZkFhUXNo?=
 =?utf-8?B?cVRCRVd1MjVsU09CNFNPVlppZ3dvUDdUclVDaDAyVXl6STFjVE9teVEzUGZl?=
 =?utf-8?B?bmM2bjRIL3lzei9mdHBlV2NYWUdLVUJYd2RmWGxKWXAySC9zZ0ZsWlh3RHVC?=
 =?utf-8?B?czNsZDQ5T0R3eFRZbGZLbE5xS2pvRWtLaWlYWTNaN2dWNDJBWjd4YnlKNmdT?=
 =?utf-8?B?OXdWeTB3WmdvWitjakhFRDQrNW5UakdKTVdpZ20xSUt1QVh6VVdkYnB3c2dX?=
 =?utf-8?B?L2pMOVhCK2g3ajkxYUFXWHBOMjZIK0REdTZnakpkeGQyK0s5eWlmLy9LSkxq?=
 =?utf-8?B?VmZzUGlEV1FQenJ4VVJRWDNMUC9ERkplbmwzalhKSGxmclJYaTZxM2NqTzA1?=
 =?utf-8?B?dmdTS0Q2TUxOQUxqMUQwNGN5ZjI4Sm5uV3V6bXRLVWpUOGxBaTFpV0hJOHQr?=
 =?utf-8?B?WFlsZUt6WFk1WUxFOFlGbHN2RytUTEhkYmlnQUdEZVR1Wnkya1dmVzFMa0Jw?=
 =?utf-8?B?RU4vbDZEaDRrTzd4T1hoK3JFckRkd21qRHdUZUtzM1g1ejVpVjlkUDFTR2gr?=
 =?utf-8?B?ZkwxMEdmcHptYURGc0lLaDdiK2prSlVtV054OGgyTEJQSjlxaFZnVVNiQUVx?=
 =?utf-8?B?ZGtrb1ZiVWpmNEZRVHdvNFJVaEs2N2F1Y0hWa0UrNjdwblpGRkRWa3crQmpu?=
 =?utf-8?B?Q052Tjc2OFVpa1kwSGkzVkpvSkx6M0hVTlUyOU5yTU9Bajh5Z2VKSUgrVUJ1?=
 =?utf-8?B?RGExUWx5RjRBbzlkbVhSbm1CeWZCdUZKTzdJdGRQZVRFOXhNaUlyNWJ1VUJG?=
 =?utf-8?B?YXB5UUJQZWR1VnJ4MHdYbVV3d25UN2pYNGVSdGQ0b2ZDL0F5QlZmdk9YeDVO?=
 =?utf-8?B?blByUmM4Zk9HcE5pTkZzdGRjY081T1lneVJLdC8ydEdweHo2WnRZMEJaN0du?=
 =?utf-8?B?cGEyUVh3alpCNldJZDRQMWF4clVBQXBTM1VQcTNPVmdOUi84SDNlTzhreXlu?=
 =?utf-8?B?WmZoQ1lzMnNrWUxwZUxHclRrbnF6cTJiRXo5QjVtS3pFM3cwaXBwd1ZtaU1r?=
 =?utf-8?B?amhKemU2cWFwUjRFUElPYlhtK1lzYzlMN3ZNTmJrTmNCQkRPZmVwMXR0TUZv?=
 =?utf-8?B?ajFCNlZQVlNsRGtScy94RjlCWXErdWc1bFIvR0NGOXVXSUpsY0ZJdE5LelVZ?=
 =?utf-8?B?MWFaUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUZUa3ZjOTRvOTg5S2VmQ3NQYVRad3hiaGVLWG10dG1WMnYxZStxMkx1NmlX?=
 =?utf-8?B?S2JoUkNvSXYrTW5hYlgyT1RLd3l6dXd0cVlyU2VCazRCaVc2VDdlTEdKZm94?=
 =?utf-8?B?c2NhSTc0VGtBa0FkTWlXRVJuK0JIMmhOY1V1bkg2eERFdGxpUnlKSDZsL2tk?=
 =?utf-8?B?M1ZyM1pCTUZzWTNIYWx3dkV1R0wwdk40SlNnK0tud1QwYnVyS25wSWhzNUhB?=
 =?utf-8?B?YlR5THp5bnd4RlBHMHZCU1lJWmtaTks1dUNqa21ldTMzOEZYVGVHZzVCbndj?=
 =?utf-8?B?NnBQQTlQRVBxUUw1bEpTYkVLcGk5em1RR2FmUU03VmxES1N1dEh4dWI3NW91?=
 =?utf-8?B?djNHZW82Wnc4Vnc2VDNIazJGS0NacmRHUEZNL0xkQVdGV1BWQ2liVUZlaEVu?=
 =?utf-8?B?REYza0hUdGF5YVROS2JtMGZxbjJYUUY1SjFJWlhWUktUSi9zeFJjRUVSanFF?=
 =?utf-8?B?YjZWVEVEdnNLVyt6eUo2d1JPajVmUzdwNUJXMG1GMnJ5YlI3U3lZeU9hQ2Rn?=
 =?utf-8?B?cTNCQS90SlRueHp3dUFqM2tGSVZ0TjU0QkFrRTdsZ05HMkdQQU5pR3M0SVVx?=
 =?utf-8?B?U1dKTmVXa1B1ajVGZEdQRjZpRzVEV1gzRnEvWUdMMjdCQjU0TVRhbDlTbmIr?=
 =?utf-8?B?SEpIZ2NmR0RGNmxBRURyaytSeGIwbVRsTE5zT2ZxemNWU1puczFBZ2NDM0Z2?=
 =?utf-8?B?M3dZVCtuMGc4VFdjYW9UbFBYU2NQY2ZpcFUwK1hZUUNsUk1TZkNYRVc2TmRR?=
 =?utf-8?B?eTdjcGMveGpta1k2V25JR0FBTi9Nck1KVENSYkhuVHVwMHpDeEl2bnZtQTk5?=
 =?utf-8?B?ekszWFA2MHArRjB4UnFkSk1FN2xXOFNtMXlvcWlaang2ai9GWjNkOHozWXZz?=
 =?utf-8?B?TnU4L1dEbXlhVWh3ZURSeVBycmZlWk15aW45b1MxcjJmeFpVOTRqOTV6NThH?=
 =?utf-8?B?OG04R3hMczZ3TmFMb3RvUnlJcG5DRzRxcmJUbktjcmZvS0dQUkRQSkpXZTVO?=
 =?utf-8?B?SDdTZXdPVEFWekdyR1Q5bEU4bnQrckY3MFVkUVR0eW9lRTd5cjY2MGcxRFJu?=
 =?utf-8?B?S01lRFlWZmJDTmFJTzJUbGZBRUU5R3hiRHhjbFZkZjNCREM2dVJVTjdPMllQ?=
 =?utf-8?B?NTc3S2JLRDJ2R0xvRDRlU0ZnMkJRdVBFa1JXeElmR3JVUjgwOFltRGFEZmFV?=
 =?utf-8?B?Q1lVUzF6WnY1UGZVMXkwU1JKN3VJdmRLdmtGUXlEb2RYVzVnRzU1dFZBeWYz?=
 =?utf-8?B?Sm5paWlJYWI3QmF1dFZVRXdydUVHRVF0eHh5S21veGUzKzVFdHpNOG54aTV4?=
 =?utf-8?B?S1dvY2VWT3MwY2N5Uk4yNnlCb3JVQnpVd1V5eVFpREN3am5QN2VLU2h4VmVj?=
 =?utf-8?B?TFFpbzUzdEdrV0QxZkFzM2JCNFAxUHF6Z2pSTUJCTnR4OFhxQTdJaGdkZGRq?=
 =?utf-8?B?VWJwaEVGS1l3S04ycm5pUzhLV1NkeTFRcXdLMklOR2hKcDJSYVZUY3lkWjJB?=
 =?utf-8?B?czlpNWRXTGx2R1Fqb00rdC9KV2lCSXY1eFlHWUdlYUtseFVJRmF3Yll6ckJ5?=
 =?utf-8?B?bXJ0T3QvVUxIUE9OR0NzNFhlNUNPREtIY25VLzQvc2Qzek5jcHRIaTZzR2Nr?=
 =?utf-8?B?VURhb2NkYytuaGlRQ2xTOWZxOXM1SG5LY0dweXU1K0ZIcXAyVGsxUE9vV3pC?=
 =?utf-8?B?MXhTNkNqbVRvcWd1UittcWZRb0U3R0ZXdm93RWl3eVM4YlFsOUlSOXl5TXF0?=
 =?utf-8?Q?LloJYKtsGLieS0OUsc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bf8a6-499d-4bb0-325c-08dda7889e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 19:05:36.7906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7264

DQoNCj4gT24gMTAgSnVuIDIwMjUsIGF0IDEyOjI34oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gV2hlbmV2ZXIgd2Ugc2VudCBhIG1lc3NhZ2UgdXNp
bmcgdGhlIGBpbWFwLXNlbmRgIGNvbW1hbmQsIGl0IHdvdWxkDQo+PiBkaXNwbGF5IGEgbG9nIHNo
b3dpbmcgdGhlIG51bWJlciBvZiBtZXNzYWdlcyB3aGljaCBhcmUgdG8gYmUgc2VudC4NCj4+IEZv
ciBleGFtcGxlOg0KPj4gDQo+PiAgICBzZW5kaW5nIDEgbWVzc2FnZQ0KPj4gICAgIDEwMCUgKDEv
MSkgZG9uZQ0KPj4gDQo+PiBUaGlzIGhhZCBiZWVuIG1hZGUgbW9yZSBpbmZvcm1hdGl2ZSBieSBh
ZGRpbmcgdGhlIG5hbWUgb2YgdGhlIGRlc3RpbmF0aW9uDQo+PiBmb2xkZXIgYXMgd2VsbDoNCj4+
IA0KPj4gICAgU2VuZGluZyAxIG1lc3NhZ2UgdG8gRHJhZnRzIGZvbGRlci4uLg0KPj4gICAgIDEw
MCUgKDEvMSkgZG9uZQ0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2Fk
aXR5YTA4QGxpdmUuY29tPg0KPj4gLS0tDQo+PiBpbWFwLXNlbmQuYyB8IDYgKysrKy0tDQo+PiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gSG1w
aCwgSSBoYXZlIHRvIHdvbmRlciBob3cgbXVjaCB2YWx1ZSB0aGlzIGFkZHMuICBJdCBpcyBub3Qg
bGlrZSB3ZQ0KPiBleHRlbmRlZCBpbWFwLXNlbmQgdG8gYWxsb3cgaXQgdG8gc3R1ZmYgbWVzc2Fn
ZXMgdG8gbXVsdGlwbGUgaW1hcA0KPiBmb2xkZXJzIGR1cmluZyB0aGUgc2FtZSBzZXNzaW9uIChp
biB3aGljaCBjYXNlLCAic2VuZGluZyAuLi4gdG8gQSINCj4gZm9sbG93ZWQgYnkgInNlbmRpbmcg
Li4uIHRvIEIiIG1heSBnaXZlIGEgZ29vZCBmZWVsIG9mIHByb2dyZXNzKS4NCg0KQnV0IGRvZXMg
Z2l2ZSB0aGUgaW5mb3JtYXRpb24gaW4gY2FzZXMgd2l0aCBhbmQgd2l0aG91dCB0aGUgLWYgYXJn
dW1lbnQuDQoNCj4gDQo+IEJ1dCB0aGF0IGlzIG1pbm9yLCBub3QgYW4gb2JqZWN0aW9uIHN0cm9u
ZyBlbm91Z2ggdG8gc2hvb3QgZG93biBhDQo+IHBpZWNlIG9mIGNvZGUgdGhhdCBoYXMgYWxyZWFk
eSBiZWVuIHdyaXR0ZW4uICBDYXBpdGFsaXppbmcgIlNlbmRpbmciDQo+IGNlcnRhaW5seSBpcyBh
IHZhc3QgY29zbWV0aWMgaW1wcm92ZW1lbnQgOy0pLg0KDQpQaGV3IDspDQo+IA0KPj4gZGlmZiAt
LWdpdCBhL2ltYXAtc2VuZC5jIGIvaW1hcC1zZW5kLmMNCj4+IGluZGV4IDk4MDcwMTIxNjkuLjNk
NmJjZDdlODggMTAwNjQ0DQo+PiAtLS0gYS9pbWFwLXNlbmQuYw0KPj4gKysrIGIvaW1hcC1zZW5k
LmMNCj4+IEBAIC0xNTYzLDcgKzE1NjMsOCBAQCBzdGF0aWMgaW50IGFwcGVuZF9tc2dzX3RvX2lt
YXAoc3RydWN0IGltYXBfc2VydmVyX2NvbmYgKnNlcnZlciwNCj4+ICAgIH0NCj4+ICAgIGN0eC0+
bmFtZSA9IHNlcnZlci0+Zm9sZGVyOw0KPj4gDQo+PiAtICAgIGZwcmludGYoc3RkZXJyLCAic2Vu
ZGluZyAlZCBtZXNzYWdlJXNcbiIsIHRvdGFsLCAodG90YWwgIT0gMSkgPyAicyIgOiAiIik7DQo+
PiArICAgIGZwcmludGYoc3RkZXJyLCAiU2VuZGluZyAlZCBtZXNzYWdlJXMgdG8gJXMgZm9sZGVy
Li4uXG4iLA0KPj4gKyAgICAgICAgdG90YWwsICh0b3RhbCAhPSAxKSA/ICJzIiA6ICIiLCBzZXJ2
ZXItPmZvbGRlcik7DQo+IA0KPiBUb3RhbGx5IG91dHNpZGUgdGhlIHRvcGljLCBidXQgYXMgI2xl
ZnRvdmVyYml0cyB3ZSBtYXkgd2FudCB0byBpMThuL2wxMG4NCj4gdGhlIG1lc3NhZ2VzIGZyb20g
dGhpcyBwcm9ncmFtIGFmdGVyIHRoZSBkdXN0IHNldHRsZXMgZnJvbSB0aGlzIHNlcmllcy4NCg==
