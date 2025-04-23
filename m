Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE0265CB9
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433240; cv=fail; b=oV6JKtzBPYHgKpG/TuJ96MRqlllkvW+8O60DJ6fqXEaLxW2eMfHUP2505EIx5Vu2L0h9lbJsYEA06iNFJaN1uQ4QJ8DxOSN6+NbmCA9iuNzyXUIGWqJwCubEubeBAcvONRSxk1O/VvlEclFIuW+Az5EdkQSh7May//dzOiNnSN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433240; c=relaxed/simple;
	bh=ThhUaDgD0TK4ESritFRD5UUB7wahBpbs5w+idbvmOEg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WA/5iUblykVpIWGzii1Y/J9kY+PosUx8hNJf90vBsnWxlZ82fFiOFQbMAg4mFNoK9G6CVy9f37aaCRbea55yu+DYeMt/JAnx4DY5+iTx+lbKBAAjsFUTPS2icvI5uJUpo8LHjPj6TQrVu000VkzAYgen5VxbZyrxd9uYEr8CPZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Iyf7JqTE; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Iyf7JqTE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0E59p+Lc6LwpKtTpZr7AzCS3K7Udttt/DyOVFWF5Ih5T/R/3pkqBox5SkpUAqtZ80Z4o+ITwu+1oGOpLRfg3znlE/262VxRzfjjJOQTxc7BUOqCFe5qoRU7QUfvU/8/ZGyLpQks8WMsBzemodmb9tx3kq3Hdf4VMA4yVkODdfZkR26OznNHYOx6lW3r8x1tz8BKpiaQ2fEMd6YicD1efdi0CIsguPwBJkFEeIq5VEdaK3md6zZVq94K467uO7YaFKEJQk2v96eAm+jfGTRQn24TYdNvxs0cup1hD56BFmq2m+Hc5easbGexKa04TdpGfgVRsDTwcVH7oV3fwRbk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThhUaDgD0TK4ESritFRD5UUB7wahBpbs5w+idbvmOEg=;
 b=URjbRLfszeZMsEF9SEHWhbHFuNJExA64On4zo7RHLAnEEzrsd2/cx/TOBmLrsOYzeJM38NqGavquhm6B2A7qUAHHNsMMUKGNflv183YoQkkMrIfQjJ2st0Ny7+wO5Wnvxk/7S9S0bBcZzY+NriLSXsTWaItx4m+wGZ5mRXo/2tWbP55JcD2APuFLB9XBMfjMACu712b9OU6SoRi7mcAnAzQPP5AgL0WX0KB7IYta9QWgmz7UtLnNath5it7pzTJwK8lK+7cUA6eLx21/WPru9QzZ7H2ctXxm3G+XRQtknlIILfmqzyr7QAJHFCEgRVa+csIL+69+2INmi2dwBfaP3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThhUaDgD0TK4ESritFRD5UUB7wahBpbs5w+idbvmOEg=;
 b=Iyf7JqTEx1epYr5xqL/cywH2sDB7bpuryXe5HJMhOFNDxAZbX3bxk6VGdyOdZ6VrpkY3tgtO5NjIONXXd2qvHrRLMadhO8Af19ySrpkWhw31joJbWo5VY4kcW6kuPqY8K0HSYmJ0pNCDysnC1zdOjQUfKjnXS2Gs3fMs+kEEJAKUE7sDz1B85b1jV7Yw2vjQiKAKB3YWKTeJyloCgloeTVfw0KYbDQnk5DBDmZJ3tb3sqwrdzWAe3VqxEWeOtfT/t8yVZUhYoJoGaE2NzXiCxcIwhq6b2/huc/T9PqzA5GPuYl99Mko6ia1z4lMMHXzOHY3IXFVyJJlZCNDLUx6cJw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6208.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 18:33:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 18:33:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, M Hickford <mirth.hickford@gmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Shengyu Qu
	<wiagn233@outlook.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Erik
 Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v4 1/3] send-email: implement SMTP bearer authentication
Thread-Topic: [PATCH v4 1/3] send-email: implement SMTP bearer authentication
Thread-Index: AQHbtEtRovWEn95+SkOgELJUx54k/LOxi7xrgAAIMqw=
Date: Wed, 23 Apr 2025 18:33:52 +0000
Message-ID:
 <PN3PR01MB95970394B0E4E84DA244BD36B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597776CB37BE7B05A7ADD80B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqjz7azrdk.fsf@gitster.g>
In-Reply-To: <xmqqjz7azrdk.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6208:EE_
x-ms-office365-filtering-correlation-id: c4570e38-5692-4223-5f49-08dd829565c5
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|6072599003|7092599003|19110799003|15080799006|461199028|8062599003|3412199025|440099028|102099032|19111999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmhGTEpqNk9Xcm1WaGMva0RoOHI4V1p4dStmRHZ1eFFXSjRNNjRNaTBKMDVE?=
 =?utf-8?B?Mk1RZmFQRVF0WmluYUZjQTF4ZVJuSmorRFpHQ0N4Sm9VRXBzdzF6cDNPaHJo?=
 =?utf-8?B?Zmt1OUNhS1BTOEV6cUU5N2pFbU4rcnd6TURBOVZiYUFoTWpXT1JtYzdDNElG?=
 =?utf-8?B?L2xqd3JLcUd6Ny9STWVmUEdCZitrWmtkVEhGZXBMMmU3UFRGei9wY3RSK3pG?=
 =?utf-8?B?Z1hXRy9WLzNmR2JnaVJxL2ZtZURSc1ZNVWJuaFRJbGNveW1KWXZraEU4bnRS?=
 =?utf-8?B?V2FKVURvRkd2Y0F6OE9pbkdFYTNGb0Z5ekorSDlxTXNodUx6aGFXRUFGTEtZ?=
 =?utf-8?B?RTlzVWtWTitTU0plUmVuMmMwSzhpd0Zqd3VoWVM0TmlHcXNlaWxQdEVFYU1Q?=
 =?utf-8?B?MUtKVVpsWExtSUdMenFKUFVsUk00WkVtRGxrV0JrejVBa013NXRVUmxiWUtY?=
 =?utf-8?B?d3lMUnBxcHl2TTQ4dERXV2k5c2VXSnVmWjhCOVNvaEVIb3NxNm8zVThQdW8x?=
 =?utf-8?B?MjIxdVp3NEJ2Z3ord2c3NUxvSEhHNmxzbWhKeGxNbGQwR0lOUEpQOGRpRkhl?=
 =?utf-8?B?Nm52a0UvUC81R1NhSHc0Q0Z3NURNWmUxaldZbml4a1JRVVJ6ck5nU0RMY21k?=
 =?utf-8?B?VHRueGYzeEROWGI4YmY5T3BNOVpET2dFNVBvYStDR3dmcFJxRmlIRDJDK0VX?=
 =?utf-8?B?YzlPNlFJNWV5TEcxdUk1aXJCc3NYWmZjaFhTbzhnSUtLTlh3UUFaL2E3MnJG?=
 =?utf-8?B?U3lNZXRxWnJ1OWw2QVpJZnBDcnhUcXQ4ODVCWlVkSWxnZDA5aFFON2llU0tT?=
 =?utf-8?B?dk9vL2pLQ2J4WVM1U3B2YkwrWEg4bkh5b3hxVW93ZkJ3ek9wRW4zQ2pHUWhD?=
 =?utf-8?B?bUJRSEhlK09KTVltOHNFYWJjVUpNNUFWQ0toZVJPSTRic0hZaDc4ZWFRT3FE?=
 =?utf-8?B?UHc3dmo2SXB0ZEFxaElGQjQ3cTRhMDIwaHFyakdZZmtVQ2xoZFZ2dWdGeEk5?=
 =?utf-8?B?QTBXSHhnYTh2c0hpbUFPenI2MStnWldGWmxlL1F6T3lMTWwrN3BkWHFtOFFY?=
 =?utf-8?B?S1k2NzJRVVZBYTF5dXZESVFsOHNKRkp0bkpZSmZ6L3p3ODVpVWcxdGZZWTEv?=
 =?utf-8?B?RTd5SEtaRmxQT0RESlU3K2UzdDA1UFF3Wi9xODNmTWdJenpBd0JCd2xpN0o0?=
 =?utf-8?B?VWtZQ1pmdlUrT0hXU0RCVWpLMFo4cXhlaitwSHl5VEtIU2IrRVpVdStwUzUx?=
 =?utf-8?B?ZEJNWDZNano0QkIrTllSajFCMWFsRSt0aHpyeWJsQXRWZCtUd1lRSEtlbGh4?=
 =?utf-8?B?SEpDTFgwZjlFZnN5dGVVc05ZcjlvbmNQK2dhc3JsOXllbkc1eXlPb09BUGhv?=
 =?utf-8?B?RC9KcUtGN2xvL2JKODB1MmpRRGlMWllMV0p0QzY5MEtPYmNFM2VlbldmUmhT?=
 =?utf-8?B?emMrbEo1enB5R1l5ejBmMngvUFF3ZTJLMGRlL3ZYU2lUeFV1SkpmUE9PNFJa?=
 =?utf-8?B?MjRpbDZHREUyN1FJOEZZVXU5dDhlTGdqNUFHTnhDYnJNNFV6R21tOFg5ZHNt?=
 =?utf-8?Q?UAyllYbUJLKwRlwvMg+Ggeryo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTBTMmhGOGFrVGhRcjB2YzlISjgrKzBhclNLcDVmSVQ0bXMvQWM5QmM2alZt?=
 =?utf-8?B?YkZCQzU3OEdpT3dUeGFiSU9GSWdHWkdsUUdQQWowaVN6Z3JoWUhpNk0zaWRE?=
 =?utf-8?B?dTNIampvRTRzakU4cUNpY3U5bWNUSjZxUlIvNW83dHlvWVJmaStmYkV4UFNv?=
 =?utf-8?B?ZW1yaDJOdXVEemN3bWUxbSsrRVp6TUZJSjZWdkJjWENHRnkzcUgyRGRqbUxx?=
 =?utf-8?B?QWtDOUhuRU9wTkdCZHFIYlVDMlVITGJkYnV1OWtYKzVodmU4ZjdqUk1OTGdv?=
 =?utf-8?B?ekZVb1ExS2ZERnJGdFZYOEZqbHhzR2NFWDMxSjBTK3dyK0hHM1M4Uld0UkRF?=
 =?utf-8?B?K2RONWpNYUFFaUxDeDB1bmY0ZS9DUi9sVDQwQTdwUnRreXJwTzkwWVpLa2kz?=
 =?utf-8?B?akdpM1J4VFpVMWZ6R1hobFRZam5xR0tUNzNsQjVIWXFZNHdFaEpVTUNxV29R?=
 =?utf-8?B?SCtDYXJ4QmdSeE1mYmNkTFo4SDVNMzc4TzB4L0JzNmNVdWQ3eWNoWHpxVXJJ?=
 =?utf-8?B?LzBlNTNsWnBGYjdrRXA0NXZJSDZncDNIQ2pUNjkvdDdFb29CT3BLSFJRR0dT?=
 =?utf-8?B?VnZ4V2swSCsweVlFRTNmRndoN2dxd1YxOWhNYVYwU2FtMENRODFZUGZUNjVR?=
 =?utf-8?B?MFlzZVJ6a0FwVEdIUm1oT0c1QmtadStRNXRyYkM1dmV2UG82aXF3QkpmYzEw?=
 =?utf-8?B?ZzgzZnc3dnM0Q1NTRjV0bnR2czNIZjNMZjA0RnJWY3VmT0FaL1U4djFKTGpy?=
 =?utf-8?B?Y3pTYUE1SmptMW8xUE1kckYzWDArbGd4ejZWL3d5dWtTRnBnc3JNelVoTUZU?=
 =?utf-8?B?U25HeDkvVGplV2lyQlNMZlR6NVh0dmRKYUxXSzU4VWwraS83TW14U0FRRzRQ?=
 =?utf-8?B?VzNNdkJxUnBtVEQ0MHVPeDAzR2ZqSlgzZjNkY2N5aWZEeWRheXlvKzNNMm45?=
 =?utf-8?B?Mk1RR2lmQ2IvUk4vQTVmZWh2bjErbjNWT3hKaWcwdks0b2FqeGd3Zk5VNG9Q?=
 =?utf-8?B?SE42QncySnMrU3hETkZIRnJPV3kyY3EyVXgyQVN6L1NzY3kyZVdQaUtnYkVX?=
 =?utf-8?B?RUFTM1ZGQ2JhcU1LSVBwcE4ycFcrcHE4RDczSXg2UFJlbW1TQUVicURZdnBz?=
 =?utf-8?B?eDUrR3NHVzZnblg3bmxNQWlCcFZXbFlYUFZBZFppaEVpRjVqQjk1RW1HcjlZ?=
 =?utf-8?B?MjhYZW9nNWdxRFY0aUNrWmpsUk15TTM3cDZoVUpWZXNqMWw2NVdhUW9VcVMv?=
 =?utf-8?B?allqcW55cHNtQ3FVaGZ5cUM5SVB5OTZRQUNwa2xoSkpSU0pnQURrR1ZpVVVE?=
 =?utf-8?B?c0ErOGp6UVQrT2Rsem5TYWRNWE5QcStKNlQ4a2tyZFVWOWxobFArSlZaVDNH?=
 =?utf-8?B?b0M0alV1YmV0NGxhUE1jdHJJMEdmaDB2MGZDK2hJY3ArZzNaVXViQ2VhUS9p?=
 =?utf-8?B?VTNVc0dwVm93bjBUNUlMa2RTaEFodmx6aDI0eUF6YjFNTm1jV3czL1Y1dkJS?=
 =?utf-8?B?K3RkVG9QQjZWYnBnbG93ZEpDN0dMRFFiWjRZWXhqUTExMXBFc2JVcWFUMjI3?=
 =?utf-8?B?WVNYdk14UmpyRTZ0VjFUODRNRERncDRrOWE1eWNPdWxLTnQ2bVpYdFRwcXVj?=
 =?utf-8?Q?j9AL8Jnr1FNmD/DdF7KywlSZBbHJWpBaEiTFPcj913eU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4570e38-5692-4223-5f49-08dd829565c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 18:33:52.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6208

DQoNCj4gT24gMjMgQXByIDIwMjUsIGF0IDExOjM04oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gRnJvbTogSnVsaWFuIFN3YWdlbWFrZXJzIDxqdWxp
YW5Ac3dhZ2VtYWtlcnMub3JnPg0KPj4gDQo+PiBNYW51YWxseSBzZW5kIFNNVFAgQVVUSCBjb21t
YW5kIGZvciBhdXRoIHR5cGUgT0FVVEhCRUFSRVIgYW5kIFhPQVVUSDIuDQo+PiBUaGlzIGlzIG5l
Y2Vzc2FyeSBzaW5jZSB0aGV5IGFyZSBjdXJyZW50bHkgbm90IHN1cHBvcnRlZCBieSB0aGUgUGVy
bHMNCj4+IEF1dGhlbjo6U0FTTCBtb2R1bGUuDQo+PiANCj4+IFRoZSBiZWFyZXIgdG9rZW4gbmVl
ZHMgdG8gYmUgcGFzc2VkIGluIGFzIHRoZSBwYXNzd29yZC4gVGhpcyBjYW4gYmUgZG9uZQ0KPj4g
d2l0aCBnaXQtY3JlZGVudGlhbC1vYXV0aFswXSBhZnRlciBtaW5vciBtb2RpZmljYXRpb25zWzFd
LiBXaGljaCB3aWxsDQo+PiBhbGxvdyB1c2luZyBnaXQgc2VuZC1lbWFpbCB3aXRoIEdtYWlsIGFu
ZCBvYXV0aDIgYXV0aGVudGljYXRpb246DQo+IA0KPiBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIHRo
aXMgYXJlYSwgZXNwZWNpYWxseSB3aXRoIEF1dGhlbjo6U0FTTCwgc28NCj4gSSdkIGFwcHJlY2lh
dGUgYSBzZWNvbmQgZXllIGZyb20gb3RoZXIgcmV2aWV3ZXJzLg0KDQpXaGF0IEkndmUgbm90aWNl
ZCBpcyB0aGF0IG90aGVyIHJldmlld2VycyBkaWRuJ3Qgc2VlbSB0byBoYXZlIHJldmlld2VkIHRo
aXMNCnBhdGNoIGZvciBtb3JlIHRoYW4gYSB5ZWFyIHdoZW4gdGhlIG9yaWdpbmFsIGF1dGhvciBw
cm9wb3NlZCB0aGlzIHBhdGNoLg0KQWxzbywgb2F1dGgyIGlzIHNvbWV0aGluZyB0aGF0IGlzIHNp
Z25pZmljYW50IGluIHRvZGF5J3Mgd29ybGQgYW5kIGlzIGRlZmluaXRlbHkNCm1vcmUgc2VjdXJl
IGFzIHdlbGwuDQoNCk5ldmVydGhlbGVzcywgeW91ciBjb25jZXJuIGlzIHF1aXRlIHZhbGlkLCBi
dXQgSSB3b3VsZCBhbHNvIGFwcHJlY2lhdGUgYXRsZWFzdA0KcGluZ2luZyB0aGUgb3RoZXIgcmV2
aWV3ZXJzIHdobyBtaWdodCBoYXZlIHRoZSBrbm93bGVkZ2UuIA0KDQpJJ20gQ2NpbmcgR3JlZywg
d2hvIGlzIGNyZWRpdGVkIGZvciB0aGlzIHNjcmlwdCBhbmQgdGhlIG1haW50YWluZXIgb2YgdGhl
IHBlcmwgbW9kdWxlDQphcyB3ZWxsLCB3aXRoIGEgaG9wZSB0byBnZXQgYSBwb3NpdGl2ZSByZXNw
b25zZS4NCj4gDQo+IEhhdmluZyBzYWlkIHRoYXQsIHRoZSBkb2N1bWVudGF0aW9uIGlzIHZlcnkg
Y2xlYXJseSB3cml0dGVuLCBzbyBpcw0KPiB0aGUgYWJvdmUgbG9nIG1lc3NhZ2UuDQo+IA0KPiBQ
bGVhc2UgZm9sZCBvdmVybHkgbG9uZyBsaW5lcyB0aGUgcGF0Y2ggYWRkcy4gIFdlIG9mZmljaWFs
bHkgYWltIGZvcg0KPiA4MC1jb2x1bW4gc29mdCBsaW1pdCwgYW5kIHdlIGFsbG93IGdvaW5nIG92
ZXIgaXQgd2hlbiBmb2xkaW5nIGxpbmVzDQo+IHRvIHN0YXkgdW5kZXIgaXQgbWFrZXMgdGhlIHJl
c3VsdCBsZXNzIHJlYWRhYmxlLiBCdXQgbGluZXMgYWRkZWQgdG8NCj4gdGhlIGNyZWRlbnRpYWwg
Y2FsbGJhY2sgdG8gY2FsbCBzbXRwX2JlYXJlcl9hdXRoKCkgYXJlIGEgd2F5IHRvbw0KPiB3aWRl
LCBmb3IgZXhhbXBsZSBbKl0uDQo+IA0KPiBGb290bm90ZSBbKl0gVGhlIHRleHQgdGhlbXNlbHZl
cyBhcmUgbm90IG92ZXJseSB3aWRlLCBidXQgdGhlIGxvbmcNCj4gbGluZXMgdGhlcmUgYXJlIHBy
aW1hcmlseSBkdWUgdG8gdGhlbSBkZWVwbHkgaW5kZW50ZWQuICBJIGhhdmUgdG8NCj4gd29uZGVy
IGlmIGl0IGlzIGEgc2lnbiB0aGF0IHRoZSBwYXJ0IG9mIHRoZSBjb2RlIG5lZWRzIHRvIGJlIGEg
Yml0DQo+IGJldHRlciByZWZhY3RvcmVkLCBlLmcuLCBieSBkZWZpbmluZyB0aGUgY2FsbGJhY2sg
c3ViIGRlZmluZWQNCj4gZWxzZXdoZXJlIGFuZCBwYXNzZWQgdG8gR2l0OjpjcmVkZW50aWFsKCkg
Y2FsbCBhcyBhIHZhcmlhYmxlIHRoYXQNCj4gaG9sZHMgYSByZWZlcmVuY2UgdG8gaXQsIGluc3Rl
YWQgb2YgZGVmaW5pbmcgYW4gYW5vbnltb3VzIHN1YiBpbg0KPiBwbGFjZSB0aGVyZSwgZm9yIGV4
YW1wbGUuDQo=
