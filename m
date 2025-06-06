Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E9125DF
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182706; cv=fail; b=gS9SvT097+mK7vJAM3tCzoHCYDoTUiEAfR99a3OQw00b7DFr+om9CPtDXJk3JmYNxkuHmU3AaJzhPar4BZOk0mIz675eFRKcFlPp9COXkrSyNdxZrSTHUgNQtc4KVxnxW47Sm7zvQbvxEHcM6xsVD9QPiGCkcIHS8Mq5Y/flGuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182706; c=relaxed/simple;
	bh=BJXky2XaMARKLU4535yqg2ynCz0EwNoYOJcm0YdY6cE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=grSWUseEVNZr3t9zAuc+rBHu7A3KM7CTZC7rq6q3TIBMuZ008jinjzNKAqlQtIuj5EMMJlRYF26te9Uv/tgUXWKJYcKFOdEo1lkgscxOiN6Fd8XaDOrA763qMFborxAZMx/B0gS26H1cQvz607NJO75CdMn9GsU5aJGoHQa+WF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t9+NLnN7; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t9+NLnN7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXGX6tg40Ko0EVntpg8YiK7Nu/sTd0ccT5ZP2TwntFZZm8snL57uRkIMNxoPwh8HJNwIk81CTeG9OLTUj8CIXWAz57zX8Sg7eERGqmVvkLHn6EKyamO1+yEZ7L7XyV3ooVMZuOIdtSPmOMrJ1Has/OQE+fl0z7X/x5BLoi42ntLXQpmHw+MUT+Oa6hR8DJXii8UScUV3T+KAzNCqd+kaUJcOFrBNn8OJ/vpv435vAzjgA9tXPHM830pzJAyCuAwzCtOLyWDtnaHw5aorHq8DB6gWR+8Ek2HFs+oPYXFEO2jRwHXcZYuYUOVRSJgvRt4cGML37Lszo0biQg+TaywxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJXky2XaMARKLU4535yqg2ynCz0EwNoYOJcm0YdY6cE=;
 b=MSFAHd+Hpdxt4JpmV8gPRfESNJ5C6eEvRMLvcvhuxE8b6AL5Egb4xFxrHllq25SR7ra7AMJwyus5mZiutmVZim1n9+ohVbWvLKUh7YzSeR84BWn2vSzswiUAKnn25C0TV/6dEQwuXs1ygtBBF9/LmycZ4TiC0VxnvsmHIO6gfUC05+Lrs303uGrPx/91wYAqZSragoAR66YEKsc+2uXRJL23BoALKbEm4hnDB8dNilJsfYFyZMM6BeAj/TVJ5toNUWYka5JGCGQM3tElGN7gFDR9pRM8Vvjb/GaeDq2T8Ja+E71prg6Wd7n/kL4YLcLeUi1+X6J5dh0Wscm+M0gnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJXky2XaMARKLU4535yqg2ynCz0EwNoYOJcm0YdY6cE=;
 b=t9+NLnN7f2c3OqJfcJQgwqzZ0AQHG4SVcClR+tg2ZC8ScuWO+N5By1HARcHvRyQNAne3AexZag177ONYYKTcxDcNqOMHqojvJ+OZmf4aKzaUPKfHFZM2Ka/SvoOjtTp7Hf0Z/Kaw1V9VfZVhg1/3WTjGaUZX6OWmPC4OF/GC8gDRwYdux3QdM9LmDHpx6Yrcm0KdzTbb6IpR9PluLMPBGopmFRgNT/xSGpSUbiKHdkXv9iJF/4+U+7jJrZ8FNzfm6ITSxI8zY0nd2jIgOSAx8mb/kDqh2dXP1fQsD8B8COeM2edPDuL+mJ2LyZHYVnDAgeafviMisiYo0r5yEdTx4w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6354.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 04:04:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 04:04:59 +0000
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
Thread-Index: AQHb1fXClSX0hMaoWkio+rC4u/XbAbP0w146gAAL8ICAABmoa4AAkS2AgAAKQyc=
Date: Fri, 6 Jun 2025 04:04:59 +0000
Message-ID:
 <PN3PR01MB9597D29B9EB6F01C4834D653B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <cover.1749112640.git.gargaditya08@live.com>
 <0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
 <xmqqy0u687ww.fsf@gitster.g>
 <PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqy0u66n46.fsf@gitster.g>
 <PN3PR01MB9597D25829C2D0A4342DA311B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597D25829C2D0A4342DA311B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB6354:EE_
x-ms-office365-filtering-correlation-id: cefdede8-ff27-4526-0faa-08dda4af4e33
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|15080799009|6072599003|7092599006|8022599003|8060799009|19110799006|461199028|102099032|3412199025|440099028|19111999003|12091999003|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?ME1OZVZSSzhxOW1yVnV4d0FNb1FOSkZvVlM4REhrNHdLYnBFcitMeGZPdXND?=
 =?utf-8?B?eDIrWTJnaERCVllSaC9MSEpFVGh0eitlUzhQZkNBL29KSDJyK2Y2WmdxWlZw?=
 =?utf-8?B?WHo3Q1hRZkN6dW40T29qL2JiMWJuOEhOeTg4bjRSYWhUTHg1UU9XVThuWlRw?=
 =?utf-8?B?TnRnREFQSEZQUDBkeHZyc1pnUXlxQ3BxbDZTdTFQRWZzTU56RHhrOHZrWVJW?=
 =?utf-8?B?c3dpYXhJZDBybTM1RkJYQys2KzRMMkJRcng5Z3diaVAwNmhCMTlKb3FlU3B4?=
 =?utf-8?B?NWlDL0JMTkhJWDJDaUV5c3RMcU05MjZXNjFIaUIxYzlodXRRSWFVeHFlT2dy?=
 =?utf-8?B?UWJaaVk1Rm0xanhsSHV0NzlYWGVaMm44aUtCVnN1dGNGREVEWnE5NG5CamtU?=
 =?utf-8?B?bEtlYmdleEMyWDVhMkdyOUJPQmM2K1FIOFVxSDdtL3BRU0VBczA4eUJCOEIv?=
 =?utf-8?B?clhYaWIwZHN1VUFqcVNXcys4YWJDL0E5ekNsbmVxbnhkTEs2U0N1dVpZdXRG?=
 =?utf-8?B?dTV0R2U3Yko5K1lKREExdFhEcVdGNkhUWFU3MEU2RnN5a0dVdGRka2tETXRl?=
 =?utf-8?B?RURVUERxeitpaU9JZjZyK0ZEVk9KNDBYbmtYemNCT3RMQWtNUnp5RFNmNlNJ?=
 =?utf-8?B?Z2JvNEVNcHBEbWp1V1hEUWdhV3VuSUk2TElRbVd5MUNuUDRlaGpmNU5mVHlw?=
 =?utf-8?B?NlBtWGNIK3ErMkM0MVpaTWRYZWJEVmVveXJUWXVRRC9Dd1hFb0xBSzlSaDg5?=
 =?utf-8?B?dmRVb1V3bE03SWRMc2ExcjlxN09MNHNEU2VpUUVJS1Z1RU8yOE5CdCtlYjFo?=
 =?utf-8?B?Q1VLUzlManRrN1pQa09LZXJZNFltV2NkUTR1QzR2RWFUZndZVlM2MThoMm5E?=
 =?utf-8?B?NHdTb2IvcjBDbmttL1pNVzY4QmR2dFdnQ0ZsOTlTcXZRUGdGWlhyeU1JWENP?=
 =?utf-8?B?RmcxeXFRTmtxRG9IUEUvR0F4MkUxbERCVnhRUWpHRnc3S3E3K0Q5ZWpvaFNG?=
 =?utf-8?B?RTR0SHB6MHZ2RUVCaDhLdHlMYWRHeUVQSnRzeUVvRW56Y0JMWVBWaXg3aS9y?=
 =?utf-8?B?bmdabXMxQWpwdld4T0dCUkQ3Vk96NDVtNWJMRjh0WkpTYUN0ZzdzQWF0RGhn?=
 =?utf-8?B?WlhSNlBtK3QxOHRCQkk4bzByMDlERXZlSlFad2JyOU9ZckR6Z2VEWS8vVkFs?=
 =?utf-8?B?anZGYzQ1RDl5eHdYWjZpRjVTTEFZTkdqUTlna2tvV2Z1YUZEWjVqQlhtM2hQ?=
 =?utf-8?B?ODFyd2loUlZRQVhiOXEyWWpTcFMrS2NqbS81K1RBZkFpNnBnN016MENYK0Qz?=
 =?utf-8?B?RzBIT1RSWG9vME9HdDFhOWNKcTdyUlVESUNrUVAwUm1Pc0hJamduaXVvMGNT?=
 =?utf-8?B?cnZLRjdQRmtIM2gvaUR1VHZHZEJWa0V3Z3BlcEZyNXNVZ0N3ZHkrMU5ReHcv?=
 =?utf-8?B?bFgxZElCUDFpb3VYSnRCcXU4RG5oYy9NT3doMnU1My9YWTRoUFZnTFVMS25r?=
 =?utf-8?B?UmxBb1B4Uk51V1NENldQV2NTSUZlc0tEenZ2OEFzM2pVMngzZkFHZElQOU5V?=
 =?utf-8?B?NmFYeThlUmY0UE8wcVlTakxaK0R6Z1lCbU1RUXpMRDB2VEdOZDlHVTlxWjFj?=
 =?utf-8?Q?VHSTY9YffMoGHf/DbG++uK/rdFmNgri4+3iY6pha1Xzs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlR5b3pjMkpuc3FPdDMvY1lmYTQvZTZwVUNrNjBqM0VqRGZMN2tyRlFwWHpQ?=
 =?utf-8?B?YUovdllVV2xFaThPeXdIL0dqV3Z2TmlCK0hOOE5EVkxLNUhEOGl4Y3pTQWo4?=
 =?utf-8?B?QXd3bStJTFhPcWhYV29rbVN6SGRPVUhId1hTcTB0Si9UZWV4Z3RQZGdOZFdX?=
 =?utf-8?B?bC9EVnR3VGttakZ1MCtZQ1Urdk1JTWxlOVN6Y1Y1MjdIQnkwcFpiTlJsZ1BJ?=
 =?utf-8?B?QTlxdnEvZTZnejBNWkNZRGlZMEt4aWF0QTRKdEZsbzcvakhOMGJyZ2wybjNI?=
 =?utf-8?B?L0dRcTNlSUtkVDAzSGVSM0U1ZkR3ZFQyZWRHTUdTSkNuK0xVUHpyTENoRlUx?=
 =?utf-8?B?bTNjVVBBZFNxYTRqRjNRVXJKOGRibUNTYnVJK0ZRZGJPY0cxU0lEblFjSnFM?=
 =?utf-8?B?RnhLWHUrZ3Q4anJyTWpGSWF1WThCcDI1bUp2bDZLQWtucTRjMW8zYmRUQmdi?=
 =?utf-8?B?R2xvWUowQUg1bGhiSi9Sc2I5cHlMT2VYbGcwdW54eFFFNTJwZUo4cU8xYzBD?=
 =?utf-8?B?NCt2emJQcVp4Y3pXZnVsNU91VHZHeWNrd3FpbEowVisxL0N6YnZQWWd1b0d4?=
 =?utf-8?B?SUhkWEN5bnJHblgrY1YwN1BKdnBsZEwydFBFeDdwcmIwcXI0RUdjbU5kSWhr?=
 =?utf-8?B?NHlsQzk2RXdvTnJ2WEE4eU5aN3Z2bWluaE56TjBXK1puL0MxbjFrcjVOK0R3?=
 =?utf-8?B?QlFJZ0ZoN2JJMkt2QWVKczhUbDVmZXJlV1hyekFpRVpoendMVnlsWFQxalFZ?=
 =?utf-8?B?VnhrdTdVdzluYVdVUVVWa01kbm0vbUM4dXdsUG1ITktKWlNyZXBqTVVFUmpW?=
 =?utf-8?B?WjBGRVF6K1Z6VkxBbm9WL0czUWFPcGZiU3p3VEpvVmhvUlhLaGhLSFJMeDhR?=
 =?utf-8?B?RXhST1o4STlYTlZrZzJiRXJhVFIxQlBhMVk5cjlZWU55cnVWcG91ZmtkeDE1?=
 =?utf-8?B?MmY2VzJhR2ZwTHRmbE1qK0Z3UFUyRlNVbmFqUVd4Y2R1V1VWL1F2Zi8rUVhK?=
 =?utf-8?B?WGV1ejNqSmpTSVpMMjVFZHFxb1RnWjcralhYWS96cHQ3TElOM2laTGF2N3BM?=
 =?utf-8?B?S3pGZis4L2RJNkNueitKSVZCQmxjY1lkYkVyT3JjNmxLWDRGQk40UzF6M01l?=
 =?utf-8?B?WXlNU2V4SmdXVDhneFRXUHZWdWE0OXh1aWplVGlKVU5DV2hhWnU0ZHNwSGNh?=
 =?utf-8?B?RUVKMTRrc052QXJOcG4vVHdWa2ZIUnd5NWdnaXZ2VnVYYXoxS1ZxenFwdHpS?=
 =?utf-8?B?SCt4cCtBZW1XTHd5OTUxS0V3NUxFRnlQY211Z28vS09Ya2lzWUhoZmsvOW1m?=
 =?utf-8?B?eDBpME9DU1NNMnRIbUhkRzVFTnl3elpaK0NhR2JNVHRXakRvTVFpMzl4RXJP?=
 =?utf-8?B?QjJmdjFPUDl6dlBWVmdtNGZML2VvZUhqb0IyNklnclVlTEdkUHo3RzRVbXE3?=
 =?utf-8?B?TXRPc3ZIYU54eWJoSFU3TlFZTUkyQ25NWGxsWXpvK1lhS2pqd0hiU3J4bU1H?=
 =?utf-8?B?aTdYZmF1WXZtbGM2NXpwZGtvOFR6aWkxc3RxWCtDMXM1RXA3ZkpxakZJQncv?=
 =?utf-8?B?MVBDUmtTaktIellVLzVEUFo5ajNUWVlZMFVqZjhiRFBac053SGtFMzBwRkZR?=
 =?utf-8?B?aldsMVZHYmxDZTVKU2hNeEZ5K2cxaVNkU3M5MW5qNHV0VlMwRWswUEwwSkxR?=
 =?utf-8?B?N0ZEblNCdDhlRFJqMGdWak0zSTRrY1ZyRlFjQzV4ejByREYxaVZMNnhBN1Na?=
 =?utf-8?Q?NuGqs+UCKcZOPFmWWc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cefdede8-ff27-4526-0faa-08dda4af4e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 04:04:59.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6354

DQoNCj4gT24gNiBKdW4gMjAyNSwgYXQgODo1OOKAr0FNLCBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5
YTA4QGxpdmUuY29tPiB3cm90ZToNCj4gDQo+IO+7vw0KPiANCj4+IE9uIDYgSnVuZSAyMDI1IDEy
OjE4OjI14oCvYW0gSVNULCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+IHdyb3Rl
Og0KPj4gQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4gd3JpdGVzOg0KPj4gDQo+
Pj4gTWlnaHQgbG9vayBsZXNzIHVnbHksIGJ1dCB3aWxsIHJlc3VsdCBpbiBhIGNvbXBpbGVyIHdh
cm5pbmcgdGhhdCB0aGlzIHdpbGwgYWx3YXlzDQo+Pj4gYmUgdHJ1ZSBpZiBjb21waWxlZCB3aXRo
IE5PX09QRU5TU0wuIElmIHlvdSBhcmUgZmluZSB3aXRoIHRoYXQsIGdvb2QuIEVsc2UgdGJoDQo+
Pj4gSSBhbSBvdXQgb2YgaWRlYXMgOiguDQo+PiANCj4+IFNvdW5kcyBsaWtlIGEgZ29vZCBwbGFj
ZSB0byB1c2UgTk9UX0NPTlNUQU5UKCksIGl0IHNlZW1zPw0KPj4gDQo+PiAgICBpZiAoTk9UX0NP
TlNUQU5UKCFhdXRoX29hdXRoYmVhcmVyKSkgew0KPj4gICAgICAgIC4uLiBza2lwIHRoZSB0aGlu
ZyAuLi4NCj4+ICAgIH0NCj4+IA0KPj4gDQo+IA0KPiBPaw0KPiANCj4+Pj4+ICAgIHNlcnZlcl9m
aWxsX2NyZWRlbnRpYWwoc3J2YywgY3JlZCk7DQo+Pj4+PiAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1
cmwsIENVUkxPUFRfVVNFUk5BTUUsIHNydmMtPnVzZXIpOw0KPj4+Pj4gLSAgICBjdXJsX2Vhc3lf
c2V0b3B0KGN1cmwsIENVUkxPUFRfUEFTU1dPUkQsIHNydmMtPnBhc3MpOw0KPj4+Pj4gKw0KPj4+
Pj4gKyAgICBpZiAoIXNydmMtPmF1dGhfbWV0aG9kIHx8DQo+Pj4+PiArICAgICAgICAoc3RyY21w
KHNydmMtPmF1dGhfbWV0aG9kLCAiWE9BVVRIMiIpICYmDQo+Pj4+PiArICAgICAgICBzdHJjbXAo
c3J2Yy0+YXV0aF9tZXRob2QsICJPQVVUSEJFQVJFUiIpKSkNCj4+Pj4+ICsgICAgICAgIGN1cmxf
ZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9QQVNTV09SRCwgc3J2Yy0+cGFzcyk7DQo+Pj4+IA0K
Pj4+PiBDYW4gd2UgY2xhcmlmeSB0aGlzIHBhcnQsIHBvc3NpYmx5IHdpdGggYW4gaW4tY29kZSBj
b21tZW50Pw0KPj4+PiANCj4+Pj4gIlVubGVzcyBYT0FVVEgyIG9yIE9BVVRIQkVBUkVSLCB1c2Ug
dGhlIHBhc3N3b3JkIiBzb3VuZHMgYSBiaXQNCj4+Pj4gc3RyYW5nZS4gIFdoYXQgYWJvdXQgbWV0
aG9kcyBvdGhlciB0aGFuIHRoZXNlIHR3byB0aGF0IGFyZSBub3QgYQ0KPj4+PiBwbGFpbiBzaW1w
bGUgcGFzc3dvcmQgYXV0aGVudGljYXRpb24/ICBXaWxsIHdlIHJlbWVtYmVyIGV4dGVuZGluZw0K
Pj4+PiB0aGlzIGNvZGUgd2hlbiB3ZSBhZGQgeWV0IGFub3RoZXIgb25lIHRvIGV4Y2x1ZGUgaXQg
bGlrZSBYT0FVVEgyIGFuZA0KPj4+PiBPQVVUSEJFQVJFUiBhcmUgZXhjbHVkZWQgd2l0aCB0aGlz
IHBhdGNoPw0KPj4gDQo+Pj4gTGV0IG1lIGFuc3dlciB0aGlzIGZpcnN0LiBDVVJMT1BUX1BBU1NX
T1JEIGlzIGZvciBwbGFpbiBvciBsb2dpbiB0eXBlDQo+Pj4gYXV0aGVudGljYXRpb24sIGFuZCBp
ZiBzcnZjLT5hdXRoX21ldGhvZCBpcyBub3QgZGVmaW5lZCwgY3VybCdzIGJlaGF2aW91cg0KPj4+
IGRlZmF1bHRzIHRvIHRoZW0uDQo+PiANCj4+IFdoaWNoIG1ha2VzIGl0IHNvdW5kIGxpa2UgaWYg
KCFzcnZjLT5hdXRoX21ldGhvZCkgaXMgZW5vdWdoPw0KPj4gDQo+IA0KPiBOby4gSWYgdGhlIHVz
ZXIgc3BlY2lmaWVzIFBMQUlOIG9yIExPR0lOIHRoZW4gaXQncyBub3QgZW5vdWdoLg0KPiANCj4+
PiBPQVVUSEJFQVJFUiBhbmQgWE9BVVRIMiB1c2UgQ1VSTE9QVF9YT0FVVEgyX0JFQVJFUg0KPj4+
IGluIGN1cmwsIHdoaWNoIGNhbiB1c2UgZWl0aGVyIG9mIHRoZW0gYmFzZWQgb24gd2hhdCBzZXJ2
ZXIgc2F5cy4NCj4+IA0KPj4gVGhhdCBpcyB3aGF0IHdlIGNhbiByZWFkIGZyb20gdGhlIHVwZGF0
ZWQgY29kZS4NCj4+IA0KPj4gVGhlIHF1ZXN0aW9uIGlzIHdoYXQgaGFwcGVucyB3aGVuIHRoZSB1
c2VyIHNldHMgc3J2Yy0+YXV0aF9tZXRob2QgdG8NCj4+IHNvbWV0aGluZyBvdGhlciB0aGFuIE5V
TEwgKHVudXNlZC0tLXVzZSBwbGFpbiBwYXNzd29yZCksICJYT0FVVEgyIg0KPj4gb3IgIk9BVVRI
QkVBUkVSIi4NCj4+IA0KPj4gSWYgdGhlIGFuc3dlciB0byB0aGF0IHF1ZXN0aW9uIGlzIC4uLg0K
Pj4gDQo+Pj4gT3RoZXIgYXV0aCBtZXRob2RzDQo+Pj4gYXJlIG5vdCBzdXBwb3J0ZWQgeWV0IGlu
IHRoaXMgY29kZSwgYW5kIHRoaXMgaXMgdGhlIHJlYXNvbiBDUkFNX01ENSBpcyBzdXBwb3J0ZWQN
Cj4+PiBieSBvbmx5IE9wZW5TU0wuDQo+PiANCj4+IC4uLiAid2l0aCBzcnZjLT5hdXRoX21ldGhv
ZCBzZXQgdG8gb3RoZXIgbWV0aG9kcyBsaWtlIENSQU1fTUQ1LCB0aGUNCj4+IGNvbnRyb2wgd291
bGQgbmV2ZXIgZW50ZXIgdGhpcyBjb2RlcGF0aCwgYXMgdGhleSBhcmUgaW1wbGVtZW50ZWQNCj4+
IGVsc2V3aGVyZSIsIHRoZW4gSSB0aGluayBpdCB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UgdG8gd3Jp
dGUgdGhlIGFib3ZlDQo+PiBsaWtlIHRoaXM6DQo+PiANCj4+ICAgIGlmICghc3J2Yy0+YXV0aF9t
ZXRob2QpDQo+PiAgICAgICAgY3VybF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1BBU1NXT1JE
LCBzcnZjLT5wYXNzKTsNCj4+ICAgIGVsc2UgaWYgKHN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwg
IlhPQVVUSDIiKSAmJg0KPj4gICAgICAgICBzdHJjbXAoc3J2Yy0+YXV0aF9tZXRob2QsICJPQVVU
SEJFQVJFUiIpKQ0KPj4gICAgICAgIEJVRygid2Ugb25seSBzdXBwb3J0IFhPQVVUSDIgYW5kIE9B
VVRIQkVBUkVSIGluIHRoaXMgY29kZXBhdGgiKTsNCj4+IA0KPiANCj4gV2UgY2FuIGltcGxlbWVu
dCB0aGlzLCBidXQ6DQo+IA0KPiAxLiBJdCB3aWxsIGZhaWwgaWYgdXNlciBzcGVjaWZpZXMgUExB
SU4gb3IgTE9HSU4gYXMgYXV0aCBtZXRob2QuDQo+IA0KPiAyLiBXZSBoYXZlIHRoaXMgaW4gdGhl
IGNvZGUgYXMgd2VsbDoNCj4gDQo+ICAgIGlmIChzcnZjLT5hdXRoX21ldGhvZCkgew0KPiAgICAg
ICAgc3RydWN0IHN0cmJ1ZiBhdXRoID0gU1RSQlVGX0lOSVQ7DQo+ICAgICAgICBzdHJidWZfYWRk
c3RyKCZhdXRoLCAiQVVUSD0iKTsNCj4gICAgICAgIHN0cmJ1Zl9hZGRzdHIoJmF1dGgsIHNydmMt
PmF1dGhfbWV0aG9kKTsNCj4gICAgICAgIGN1cmxfZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9M
T0dJTl9PUFRJT05TLCBhdXRoLmJ1Zik7DQo+ICAgICAgICBzdHJidWZfcmVsZWFzZSgmYXV0aCk7
DQo+ICAgIH0NCj4gDQo+IFdoaWNoIGJhc2ljYWxseSBtZWFucyB0aGF0IGlmIGEgdXNlciBzcGVj
aWZpZXMgYW4gYXV0aCBtZXRob2QsDQo+IGN1cmwgd2lsbCB0cnkgdG8gdXNlIFNNVFAgQVVUSCBj
b21tYW5kIHdpdGggdGhhdCBtZXRob2QuDQo+IFNvIGlkZWFsbHksIHRoaXMgc2hvdWxkIGhhdmUg
d29ya2VkIGZvciBPQVVUSEJFQUVSIGFuZCBYT0FVVEgyDQo+IA0KPiBCdXQgdGhlIHByb2JsZW0g
d2l0aCB0aGF0IHdvdWxkIGJlIGEpIHdlIHdvdWxkIG5lZWQgdG8gZm9ybWF0DQo+IHRoZSBhY2Nl
c3MgdG9rZW4gYXMgcGVyIHRoZSBzcGVjaWZpY2F0aW9ucyBvZiB0aGVzZSBtZWNoYW5pc21zLg0K
PiBhbmQgYikgY3VybCBzaW1wbHkgc2F5cyB0aGVzZSBtZXRob2RzIGFyZSBub3Qgc3VwcG9ydGVk
IHdoZW4NCj4gd2UgdHJ5IHdpdGggdGhhdC4NCj4gDQo+IEkgZmlsZWQgYSBidWcgcmVwb3J0IHJl
Z2FyZGluZyB0aGlzIGFuZCB0aGV5IHdlcmUgbm90IHJlYWxseSBjbGVhcg0KPiBvbiB3aGV0aGVy
IENVUkxPUFRfTE9HSU5fT1BUSU9OUyBpcyBtZWFudCBmb3IgUExBSU4gb25seSBvciBzaG91bGQg
d29yayBsaWtlIHRoaXMgd2l0aCBvdGhlciBtZXRob2RzIHRvby4NCj4gDQo+IEJ1dCwgdGhlIGRv
Y3MgaW5kaWNhdGUgaXQncyBmb3IgUExBSU4gYXV0aCBvbmx5Lg0KPiANCj4gU28sIGNvbnNpZGVy
aW5nIHRoZSBmYWN0IHRoYXQgdGhlIG9yaWdpbmFsIGNvZGUgZm9yIGltYXAtc2VuZA0KPiB3YXMg
c2V0dGluZyBDVVJMT1BUX0xPR0lOX09QVElPTlMNCj4gdW5jb25kaXRpb25hbGx5IGFuZA0KPiB3
YXMgcnVubmluZyB0aGUgQVVUSCBjb21tYW5kIGV2ZW4gaWYgYXV0aCB3YXMgc2V0IHRvIENSQU0t
TUQ1DQo+IG9yIHdoYXRldmVyLCBJIGp1c3QgcHJlZmVycmVkIHRvIG5vdCBjaGFuZ2UgdGhhdCBi
ZWhhdmlvdXIgc2luY2UgSQ0KPiBtYXkgY2F1c2Ugc29tZSByZWdyZXNzaW9uLiBUaGVyZSBpcyBh
IHRpbnkgcG9zc2liaWxpdHkgdGhhdCBDUkFNLU1ENQ0KPiBtYXkgd29yaywgYnV0IEkgZG9uJ3Qg
cmVhbGx5IGhhdmUgYW55IGZyZWUgU01UUCBzZXJ2ZXIgd2hpY2ggdXNlcw0KDQpTTVRQIHdhcyBh
IHR5cG8uIEl0J3MgSU1BUC4=
