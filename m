Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29119C542
	for <git@vger.kernel.org>; Thu,  8 May 2025 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675007; cv=fail; b=JgNopolAZFPaSsOarXtBFAGR1a448Ax0GQ2DI9eDn8TeJPe1+cjD0yOVB3tSJgyEp8N51nf1DCcCJzadurSC5WpPYF20Be7GX+bE5JnpICXuJRY1IQcLT5upfdJCQ1ek7Cjap923EurxxKwNn1gFVHd/blYLdJ4FUsRFB8e46Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675007; c=relaxed/simple;
	bh=2R/N3v6mQ74pk7rmKp32YB2ldonQAFkrp91ocwyN6Xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K0qVgZFybU5oEbqA4LC+wiq1h5Dy5JbcoPN2qkM7PvmA7x9PXeSiLbjdamUJSjR6FmBvw8S94BHwgyKOGIUNcVWfUA5agTVZ6zHJ10RKLPcATWhVTso6obBuGj8AtysppG7OUKdjVzSFPsMLQNHomw5DoFblx79Y15YsLSeU1sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=iDoaiFlw; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="iDoaiFlw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgonmCwCyBrk25HjnBPljc0loJEacI0/VqjMxi5DMGqUQRG22MbGyWEzW6UDTsSSNVAG2A4kv0W1GKWEdaTKyVzbRpjeo9Q38X4dWjWHz7m7fwc65Qti9/wGA83Ixuw/qjMcYqAqUFVtc2CPxFrYLCAm9M0sPkkYfd2O0bUciS+fHA0HF/SUURxUeYmpLWBqPCjj47evM39PThVwx6GPixlIiya9OU8s7XTYAZcyDPrv7NSjjspYGvpSNnnG79d98+stkM1J0pYWUAboTltkKS7dRhuffZnyBbWTymPv8OUcIi/f0X02kf9+Si8tihKTSrWVYCm5XCEuws+aMab/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2R/N3v6mQ74pk7rmKp32YB2ldonQAFkrp91ocwyN6Xk=;
 b=Xbvrl9Mn2f2757iFfQBt0uOp558xy1eudIa5z285oMI6H8SqusdyakXm4nFCNzBY2KY1kIIJBdnYyPotPIJmNlTQisAvtLgzArBqT7JoQi2K5WGp1vWATsp2V9/Shlzg6GM4USgEfZCiHJTYXYQDRlOwpEkaAqfwZLNiWEwXER1LjXg9p+N3+yqre1lWtvzboANE/z9wF1EXLGsfdiQHQnG9KZyiyAYgBP/z5waF6KuNOFNBFpbhGRZBwC8lzSO+Tuh/rx1fhacS32GZ10xyUnuas82qO9+yXb9Zygm1nk/bC1Nmax12n7oWE0HkVH+X9aDreuln6Ga3HXN8wQBHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R/N3v6mQ74pk7rmKp32YB2ldonQAFkrp91ocwyN6Xk=;
 b=iDoaiFlwyXSjSIdK81kq02DWskmGeLIVg6ue722NVQVbfuGoZesdvmqzI7WOUDAMZ15v5IuZTsKBgjesq+5te76Q+B14/auVRjOKj/AobcbDA8DNMClBypt58fzpvdIUzEeNlVd2+XUW4SkEFj3RNI2M8Odoc+YK1+qJq0GNuXDL9r+8OXo0UG6F8mxgf7lzSkD9Zc4kYkmUMama0ENbtgonnLmdFb/lXOqGCNnfj+hg3FuelIAORPjUkJSnVIaWK/dGGH2bswNNrppqHWVBfN9K3QMhIiLqlsFyvjJJBHIG26xTAd6SzwgXnr4e8OkJ4SW4VXyzZJQFG546YgDUUQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5613.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.22; Thu, 8 May
 2025 03:29:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 03:29:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v4 2/3] docs: improve send-email documentation
Thread-Index: AQHbv0zFVjfsAuRfzESA3EiZEdhM8rPHvkVHgABWFBk=
Date: Thu, 8 May 2025 03:29:58 +0000
Message-ID:
 <PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq5xicawp4.fsf@gitster.g>
In-Reply-To: <xmqq5xicawp4.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB5613:EE_
x-ms-office365-filtering-correlation-id: 339ec8ec-c42b-4624-73a9-08dd8de09c36
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|8060799009|8062599006|12121999007|7092599006|15080799009|19110799006|6072599003|3412199025|440099028|10035399007|34005399003|19111999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?L1BVQVB0M2VXY016N3VlMGpqSXc2TVE2ZjE4dGFVWHpqTTVBcU5QTFhTdk9i?=
 =?utf-8?B?NElkaUlEY3dheTQxa09vRWVWYzFJVWlPOUFCUkNMUWQvQzIwMC9KSFhid0Rn?=
 =?utf-8?B?d0JHbjhXaXBLcmRhUlR4ZHcwYWRKRFZGNmEwV3NQbHJLbGdBN0NPOUhGclAz?=
 =?utf-8?B?MXM2aEc3RWZjU2NtcHNsUlIyUDViaWZKRms2WllNWlZjMGNaQ2g1WWg0K3lp?=
 =?utf-8?B?aFVVWVJmdzNXM3NrcHBqZXRzZWVOdzRZc1FUcS9Hd3NGVGJZT0VIUXNBd3BY?=
 =?utf-8?B?Z3Q4c2NQUkJ6MWZqRU9wVG42QWUxN3JhTzhxT24yNDRyemJnTkhxSnUxNWxY?=
 =?utf-8?B?VjJIVGZsY3NvcGRNZmY4NWh5T2JaTlY4em15dXo1bEl4ZEpTcm93UTM3bkVU?=
 =?utf-8?B?alZMSm1rVXpsRHRYYjk0YlVSTFZ1dGI0VjAyZEFyL21JQ3diRHpBOVNsRUtI?=
 =?utf-8?B?NHozTmJVZFNVeFFNMGpQUHhGRHh3TCtpaEJnaU9VVEtZa3V6NU9BTnNjTnhV?=
 =?utf-8?B?QTBKdEJGZ0JrWGVxLzYrWWY0T0EwRjJXR2l5eFJDbjROTUhyUStXMkFiUFB4?=
 =?utf-8?B?b21CRDMrUnFWVE04M0VCdWp1aEtWMUJBdjNYdjIwR3NUbjFqdkgxZHI3M2k4?=
 =?utf-8?B?dXNFVmdubDc5UWIrdjBmWHh0cDB1cUlnbDZ2ZlZCNlBiUFZJakZZYWErV2Fa?=
 =?utf-8?B?WjRvcUladElNYWx3VTc3cVlCUXFEVUxVRWlOd25NTUx2SktnbzkyVmRsT3k3?=
 =?utf-8?B?b05xWGZ5eFZCS0JzV3FtbTR3cnRiWk94WjlqNlNSbm96eVhZY1hEMnVSc2JS?=
 =?utf-8?B?c0NKSVBvdnZ5cDhRdjBvMnZRRkR3VVhQbmRXUmhKNDY3N2FoUEcwb2twTjNT?=
 =?utf-8?B?VHgzTWc4NDFiY2xPTVA3QVJjWGpBdWVlMCtDTGFTaEc5R2FoekNCbENPSmkz?=
 =?utf-8?B?bEllQ3B6SVFsQlVNNkRNYVBoUEVpbUU3UTUxUlNCVjJ2ZGpudlBQRFZsYVpm?=
 =?utf-8?B?eGJYTU9RZ2FhOVJXSmR6QUhqVFdXaUIxY1ZtZnpodTVPRDJnNloyNVo2ZDR6?=
 =?utf-8?B?clZaVWZ0U3JOenBabkovak9oQUlkckw1T0Y2M0RSVlprTlYzWVBGOGJpQk8y?=
 =?utf-8?B?RFBTYXo4Z3lYT0NMRzQ4bkswd3g0a1hlQ0poeWJJTFluTjFvSXFjTG5nSStw?=
 =?utf-8?B?SlYxVmpZR1poRzQ0d1JhMEF2U2pycDkxTUNCV3k2RFVjc1RCRFh2VHpSSFRm?=
 =?utf-8?B?RXRvL2M3cmZDck5wNkZVTDFra3RleGtFSkpEeDNieGJmSGl4OW1JL2l5b3hU?=
 =?utf-8?B?M1NQZGNYdldXL0xReTJsbjNKdTU2d2RZYXR2UXJMaXNzc3dVS0pKTUtQLzYy?=
 =?utf-8?B?ZDM2STFUcitYMkpKU2JnVit3VFNUV0xpL1E0NVhRbEtHdzk2cEFaekVzdmNT?=
 =?utf-8?B?QXRLZ09SVnlaSEhicm1ySUk3QWd0QmFzcGl1V1Z5amEzYmxhS1EyOFJ1ODFJ?=
 =?utf-8?B?V3hVdnphSHZqMVU5Y0JyVlRHN0RtL1c5ekFRaVNBTHdwMVpXWi96RkQyL0VD?=
 =?utf-8?B?MVVpNDd6b1lVT0pQbk5jMEhZNmV3SlBSRVVXNmlTc0Z6NkZKdFRMWjFCQVRK?=
 =?utf-8?B?a1JWZy9LNm56RlNUWFlKUWE0a05KMWJPWXMxbkRManVuZ0tyTnRGM1FLOXZD?=
 =?utf-8?B?VERyV3JMck42bC9OSklPQjlZU3R6c3JzeFhPMUkxMXNaVmVwUm1wWVgwY2xU?=
 =?utf-8?Q?1sC6qEjMzPAIURnFBU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djBwZ0ViUHlkQXUyZk8xcitsNHBCK3Y2L0cvQ3NWZW9ONnR1cXk5aHNsZHNp?=
 =?utf-8?B?Y1hIbGF5K2prKzhRL2U0MVF2Q3Z4UHpON2RDdTEzeUFYNWI2cFY5WkNvYk5v?=
 =?utf-8?B?bm9nZ0VhL2ptWEU5VWxiSDhkV1JKMDJoQmZZUVl3Nmh3VDNVTlhKSm1DVHND?=
 =?utf-8?B?UXJyTUZMVHByT3lqdnlrVHAwNlpkbmhLUGhYMXFYenZ4Lzc2Z2NZTFN3VlNk?=
 =?utf-8?B?bERtU09YWlBORTYveXlFU1BGQU1yOEh3NGx2N294aVhQeWk0QVE0S0ZjQkh0?=
 =?utf-8?B?RFdhT3Z1SGxKV0U0c0xEeGhMcTk2TEZKdE9qTWdzcEs3ei92WVcrUk5RTW1v?=
 =?utf-8?B?RnBMVmhGdndqcXBmK2gvRG5iUStiaTk4NDJLcHM0c09qOEcxOGlQeTVqTDk2?=
 =?utf-8?B?QzZWL3Y3Vk05UkY1YVI0cWp0a05YOWxaUTEzQjBMSG5EWjF1TzJFViswMVI1?=
 =?utf-8?B?OFN5UzRHOFFJcjd0eUtqK2FScHZ5ZDI5b08yWlVhOG9HSHpVeHZlMGpPVnB0?=
 =?utf-8?B?OVFZUHdyQzlTbk9xdUN2Zlp3em9iYkVtSFNkYzZPN0l3N05ieWlTem1TR3J3?=
 =?utf-8?B?SEVmZjFORDNpTVNmQWpGalYwYXFjZXFjcnFDYkk1VCtnSHVNVWQ3Y0RsWlky?=
 =?utf-8?B?SHJuZ2JCMXp4SE50a0xHejgvVC9abS9aODlDa3gzRDk5dVo1NjQyVXNFc081?=
 =?utf-8?B?N1pMVjJBMG5PQVN4Rm1jS05jTkJybTZ6Z1NDY041T0Zoc2U2eVNmN3d6RjdB?=
 =?utf-8?B?TDN0dVdGTUdVcmt2ajNQRGVGbE5PYzJSOTRuWThzYmY0K2Rad2JWYmlUSEVE?=
 =?utf-8?B?VFhFd013S3hTRTIvYzBLcHh3NWNYcXhSM1F6cm9FYjdtOU5sR1V0UlVScEoz?=
 =?utf-8?B?bi9vNnVOYmM3Q01pVTlSb3ZUbkI0dlQ0a1NVT3J2NEJTcFQ3VlIrNXVyZGx6?=
 =?utf-8?B?Rng2alBPalRIdlpsYVRSRjNHRnhNQWpud2FwSmlKY3ZPMjNHUk1hZ2ZiNTla?=
 =?utf-8?B?NFJBaDBEaUEwV2xjY3ZSSnNOTGlQdXRCWUU4L3dWQWVoZ1U5VzZURnlTUFlp?=
 =?utf-8?B?UFl6MzdiSit3bEF4azdrbzBSZ2p0dmpNV0xIemN4U2k2S3VMdGRwSWJ4UjhT?=
 =?utf-8?B?d2g1R3R2YlUwd1UrNTJVZytveDBHSStLbStsYnBrdzZ1UDRvRUdvanI2Und1?=
 =?utf-8?B?MDA2QmhOS3VXWjR4dERrdW8rd1RXc1JPVi9XdU1JRUNhclBjTk5kQXFMTVdn?=
 =?utf-8?B?MmYwYlJubTkxUkg1QU9td1Z1cHJwcFh3U3ZsQ1B6SC9SdFYyQXFRVHViUXVP?=
 =?utf-8?B?VzhmRlBSYkpVeTZ2WjVzWVV0QXZsNnVsZzNzdk14bUlUaThkUnFoRW5OWTZ6?=
 =?utf-8?B?d1ozM2hCUHgrRHI2L2RzQmFUN2g4YlFFWE1uYjZRUUJ6KzlVSVJLRndHbkZk?=
 =?utf-8?B?MXdsaUgxdGl5eUVIMzhXRks0K2dLQ2ZONy9QUXRxaGxhbjc2OFdPSEhFM2Jt?=
 =?utf-8?B?NzhNSXhJT1JOVjhiVTdGcldPWEZFT2U3SnRzcmJ5UWpLc3dWSmJ2bGNKdlpx?=
 =?utf-8?B?WDYxYkpSV2JORkN4dDRaVmpzK0tYNGkzK2tnU2FBVTVNTU9NZlBGMWh2MG91?=
 =?utf-8?Q?JQpTw8AKctu4PfbiRTHho4hpPCx5VtC1Mk9aRedBOHFA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ec8ec-c42b-4624-73a9-08dd8de09c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 03:29:58.9219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5613

DQoNCj4gT24gOCBNYXkgMjAyNSwgYXQgMzo1MeKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiANCj4+IC1FWEFNUExFUw0KPj4gLS0t
LS0tLS0tDQo+PiAtVXNlIGdtYWlsIGFzIHRoZSBzbXRwIHNlcnZlcg0KPj4gK0VYQU1QTEVTIE9G
IFNNVFAgU0VSVkVSUw0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gK1VzZSBHbWFp
bCBhcyB0aGUgU01UUCBTZXJ2ZXINCj4gDQo+IE5pY2UgdG8gc2VlIHRoYXQgeW91IGdvdCB0aGUg
Y2FwaXRhbGl6YXRpb24gZ290IHJpZ2h0IHdoaWxlIGF0IGl0Lg0KPiANCj4+IH5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4NCj4+IC1UbyB1c2UgJ2dpdCBzZW5kLWVtYWlsJyB0byBzZW5kIHlv
dXIgcGF0Y2hlcyB0aHJvdWdoIHRoZSBHTWFpbCBTTVRQIHNlcnZlciwNCj4+IC1lZGl0IH4vLmdp
dGNvbmZpZyB0byBzcGVjaWZ5IHlvdXIgYWNjb3VudCBzZXR0aW5nczoNCj4+ICtUbyB1c2UgJ2dp
dCBzZW5kLWVtYWlsJyB0byBzZW5kIHlvdXIgcGF0Y2hlcyB0aHJvdWdoIHRoZSBHbWFpbCBTTVRQ
IHNlcnZlciwNCj4+ICtlZGl0ICd+Ly5naXRjb25maWcnIHRvIHNwZWNpZnkgeW91ciBhY2NvdW50
IHNldHRpbmdzOg0KPiANCj4gVGhlIGZvdXIgc2luZ2xlIHF1b3RlcyBhYm92ZSBzaG91bGQgcHJv
YmFibHkgYmUgY2hhbmdlZCB0byBiYWNrDQo+IHF1b3RlcywgdG8gbWF0Y2ggdGhlICJZb3UgY2Fu
IGFsc28gdXNlIE9BdXRoMi4wLi4uIiBiZWxvdy4NCg0KSSB0aGluayB+Ly5naXRjb25maWcgc2hv
dWxkIGJlIGluIHNpbmdsZSBxdW90ZXMsIGl0cyBub3QgYSBjb21tYW5kLg0KDQo+IA0KPj4gQEAg
LTUyOCw2ICs1MjgsMzcgQEAgSWYgeW91IGhhdmUgbXVsdGktZmFjdG9yIGF1dGhlbnRpY2F0aW9u
IHNldCB1cCBvbiB5b3VyIEdtYWlsIGFjY291bnQsIHlvdSBjYW4NCj4+IGdlbmVyYXRlIGFuIGFw
cC1zcGVjaWZpYyBwYXNzd29yZCBmb3IgdXNlIHdpdGggJ2dpdCBzZW5kLWVtYWlsJy4gVmlzaXQN
Cj4+IGh0dHBzOi8vc2VjdXJpdHkuZ29vZ2xlLmNvbS9zZXR0aW5ncy9zZWN1cml0eS9hcHBwYXNz
d29yZHMgdG8gY3JlYXRlIGl0Lg0KPj4gDQo+PiArWW91IGNhbiBhbHNvIHVzZSBPQXV0aDIuMCBh
dXRoZW50aWNhdGlvbiB3aXRoIEdtYWlsLiBUbyBkbyB0aGlzLCBlZGl0IHlvdXINCj4+ICtgfi8u
Z2l0Y29uZmlnYCBmaWxlIGFuZCBhZGQgYHNtdHBBdXRoID0gT0FVVEhCRUFSRVJgIHRvIHlvdXIg
YWNjb3VudCBzZXR0aW5nczoNCj4+ICsNCj4+ICstLS0tDQo+PiArW3NlbmRlbWFpbF0NCj4+ICsg
ICAgc210cEVuY3J5cHRpb24gPSB0bHMNCj4+ICsgICAgc210cFNlcnZlciA9IHNtdHAuZ21haWwu
Y29tDQo+PiArICAgIHNtdHBVc2VyID0geW91cm5hbWVAZ21haWwuY29tDQo+PiArICAgIHNtdHBT
ZXJ2ZXJQb3J0ID0gNTg3DQo+PiArICAgIHNtdHBBdXRoID0gT0FVVEhCRUFSRVINCj4+ICstLS0t
DQo+PiArDQo+PiArVXNlIE1pY3Jvc29mdCBPdXRsb29rIGFzIHRoZSBTTVRQIFNlcnZlcg0KPj4g
K35+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4+ICtVbmxpa2UgR21h
aWwsIE1pY3Jvc29mdCBPdXRsb29rIG5vIGxvbmdlciBzdXBwb3J0cyBhcHAtc3BlY2lmaWMgcGFz
c3dvcmRzLg0KPj4gK1RoZXJlZm9yZSwgT0F1dGgyLjAgYXV0aGVudGljYXRpb24gbXVzdCBiZSB1
c2VkIGZvciBPdXRsb29rLg0KPj4gKw0KPj4gK0VkaXQgJ34vLmdpdGNvbmZpZycgdG8gc3BlY2lm
eSB5b3VyIGFjY291bnQgc2V0dGluZ3MgZm9yIE91dGxvb2sgYW5kIHVzZSBpdHMNCj4+ICtTTVRQ
IHNlcnZlciB3aXRoICdnaXQgc2VuZC1lbWFpbCc6DQo+PiArDQo+PiArLS0tLQ0KPj4gK1tzZW5k
ZW1haWxdDQo+PiArICAgIHNtdHBFbmNyeXB0aW9uID0gdGxzDQo+PiArICAgIHNtdHBTZXJ2ZXIg
PSBzbXRwLm9mZmljZTM2NS5jb20NCj4+ICsgICAgc210cFVzZXIgPSB5b3VybmFtZUBvdXRsb29r
LmNvbQ0KPj4gKyAgICBzbXRwU2VydmVyUG9ydCA9IDU4Nw0KPj4gKyAgICBzbXRwQXV0aCA9IFhP
QVVUSDINCj4+ICstLS0tDQo+IA0KPiBKdXN0IGZvciBteSBlZHVjYXRpb24sIHRoZSBhYm92ZSBk
ZXNjcmlwdGlvbiBkb2VzIHNheSB3aHkgT3V0bG9vaw0KPiBuZWVkcyB0byB1c2UgT0F1dGgyLjAs
IGJ1dCBkb2VzIG5vdCBoaW50IHRoZSByZWFzb24gZm9yIHRoZQ0KPiBkaWZmZXJlbmNlIGJldHdl
ZW4gdGhlIHR3byBleGFtcGxlLCBPQVVUSEJFQVJFUiB2cyBYT0FVVEgyLiAgRG8NCj4gdGhlc2Ug
dHdvIHNlcnZpY2VzIHN1cHBvcnQgYm90aCwgb3IgZG9lcyBHbWFpbCBzdXBwb3J0IG9ubHkNCj4g
T0FVVEhCRUFSRVIgd2hpbGUgT3V0bG9vayBzdXBwb3J0cyBvbmx5IFhPQVVUSDI/ICANCg0KR21h
aWwgc3VwcG9ydHMgZm9yIE9BVVRIQkVBUkVSIGFuZCBYT0FVVEgyLiBJIGFkZGVkIE9BVVRIQkVB
UkVSDQpqdXN0IGZvciB0aGUgc2FrZSBvZiBhIGRpZmZlcmVudCBleGFtcGxlLiBJIHRoaW5rIGFk
ZGRpbmcgYSBjaG9pY2UgYmV0d2VlbiB0d28NCndpbGwganVzdCBjYXVzZSBjb25mdXNpb24gYW1v
bmcgcGVvcGxlLg0KDQpPdXRsb29rIHN1cHBvcnRzIG9ubHkgWE9BVVRIMiAod2hpY2ggaXMgc3Vy
cHJpc2luZyBzaW5jZSBPQVVUSEJFQVJFUg0KaXMgZGVzY3JpYmVkIGluIFJGQywgYW5kIFhPQVVU
SDIgaXMgR29vZ2xlJ3MpLg0KPiANCj4gR2l2ZW4gdGhhdCB0aGUgZm9ybWVyIGlzIGRlc2NyaWJl
ZCBpbiBSRkMgYW5kIHRoZSBsYXR0ZXIgc29tZXRpbWVzDQo+IGRlc2NyaWJlZCBhcyAiUHJvcHJp
ZXRhcnkgR29vZ2xlIGV4dGVuc2lvbiwgbm90IGEgc3RhbmRhcmQiLCBpdCBpcw0KPiBzb21ld2hh
dCBmdW5ueSB0byBzZWUgdGhhdCBHbWFpbCBleGFtcGxlIHVzZXMgT0FVVEhCRUFSRVIgd2hpbGUN
Cj4gT3V0bG9vayBleGFtcGxlIHVzZXMgWE9BVVRIMi4NCj4gDQo+PiArU0VORElORyBQQVRDSEVT
DQo+PiArLS0tLS0tLS0tLS0tLS0tDQo+PiBPbmNlIHlvdXIgY29tbWl0cyBhcmUgcmVhZHkgdG8g
YmUgc2VudCB0byB0aGUgbWFpbGluZyBsaXN0LCBydW4gdGhlDQo+PiBmb2xsb3dpbmcgY29tbWFu
ZHM6DQo+PiANCj4+IEBAIC01MzYsOSArNTY3LDIzIEBAIGZvbGxvd2luZyBjb21tYW5kczoNCj4+
ICAgICQgZ2l0IHNlbmQtZW1haWwgb3V0Z29pbmcvKg0KPj4gDQo+PiBUaGUgZmlyc3QgdGltZSB5
b3UgcnVuIGl0LCB5b3Ugd2lsbCBiZSBwcm9tcHRlZCBmb3IgeW91ciBjcmVkZW50aWFscy4gIEVu
dGVyIHRoZQ0KPj4gLWFwcC1zcGVjaWZpYyBvciB5b3VyIHJlZ3VsYXIgcGFzc3dvcmQgYXMgYXBw
cm9wcmlhdGUuICBJZiB5b3UgaGF2ZSBjcmVkZW50aWFsDQo+PiAtaGVscGVyIGNvbmZpZ3VyZWQg
KHNlZSBsaW5rZ2l0OmdpdC1jcmVkZW50aWFsWzFdKSwgdGhlIHBhc3N3b3JkIHdpbGwgYmUgc2F2
ZWQgaW4NCj4+IC10aGUgY3JlZGVudGlhbCBzdG9yZSBzbyB5b3Ugd29uJ3QgaGF2ZSB0byB0eXBl
IGl0IHRoZSBuZXh0IHRpbWUuDQo+PiArYXBwLXNwZWNpZmljIG9yIHlvdXIgcmVndWxhciBwYXNz
d29yZCBhcyBhcHByb3ByaWF0ZS4NCj4+ICsNCj4+ICtJZiB5b3UgaGF2ZSBhIGNyZWRlbnRpYWwg
aGVscGVyIGNvbmZpZ3VyZWQgKHNlZSBsaW5rZ2l0OmdpdC1jcmVkZW50aWFsWzFdKSwgdGhlDQo+
PiArcGFzc3dvcmQgd2lsbCBiZSBzYXZlZCBpbiB0aGUgY3JlZGVudGlhbCBzdG9yZSBzbyB5b3Ug
d29uJ3QgaGF2ZSB0byB0eXBlIGl0IHRoZQ0KPj4gK25leHQgdGltZS4NCj4+ICsNCj4+ICtJZiB5
b3UgYXJlIHVzaW5nIE9BdXRoMi4wIGF1dGhlbnRpY2F0aW9uLCB5b3UgbmVlZCB0byB1c2UgYW4g
YWNjZXNzIHRva2VuIGluDQo+PiArcGxhY2Ugb2YgYSBwYXNzd29yZCB3aGVuIHByb21wdGVkLiBW
YXJpb3VzIE9BdXRoMi4wIHRva2VuIGdlbmVyYXRvcnMgYXJlDQo+PiArYXZhaWxhYmxlIG9ubGlu
ZS4gQ29tbXVuaXR5IG1haW50YWluZWQgY3JlZGVudGlhbCBoZWxwZXJzIGZvciBHbWFpbCBhbmQg
T3V0bG9vaw0KPj4gK2FyZSBhbHNvIGF2YWlsYWJsZToNCj4+ICsNCj4+ICsgICAgLSBodHRwczov
L2dpdGh1Yi5jb20vQWRpdHlhR2FyZzgvZ2l0LWNyZWRlbnRpYWwtZW1haWxbZ2l0LWNyZWRlbnRp
YWwtZ21haWxdIChjcm9zcyBwbGF0Zm9ybSwgZGVkaWNhdGVkIGhlbHBlciBmb3IgYXV0aGVudGlj
YXRpbmcgR21haWwgYWNjb3VudHMpDQo+PiArDQo+PiArICAgIC0gaHR0cHM6Ly9naXRodWIuY29t
L0FkaXR5YUdhcmc4L2dpdC1jcmVkZW50aWFsLWVtYWlsW2dpdC1jcmVkZW50aWFsLW91dGxvb2td
IChjcm9zcyBwbGF0Zm9ybSwgZGVkaWNhdGVkIGhlbHBlciBmb3IgYXV0aGVudGljYXRpbmcgTWlj
cm9zb2Z0IE91dGxvb2sgYWNjb3VudHMpDQo+IA0KPiBHaXZlbiB0aGF0IHRoaXMgd2lsbCBiZSBm
b3JtYXR0ZWQgdmlhIEFzY2lpRG9jIChvciBhc2NpaWRvY3RvciksDQo+IHdvdWxkIGl0IG1ha2Ug
c2Vuc2UgdG8gbWFrZSBpdCBlYXNpZXIgZm9yIHJlYWRlcnMgb2YgdGhlIHNvdXJjZQ0KPiBkb2N1
bWVudCBieSBmb2xkaW5nIGxpbmVzLCBsaWtlOg0KPiANCj4gICAgLSBodHRwczovL2dpdGh1Yi5j
b20vQWRpdHlhR2FyZzgvZ2l0LWNyZWRlbnRpYWwtZW1haWxbZ2l0LWNyZWRlbnRpYWwtZ21haWxd
DQo+ICAgICAgKGNyb3NzIHBsYXRmb3JtLCBkZWRpY2F0ZWQgaGVscGVyIGZvciBhdXRoZW50aWNh
dGluZyBHbWFpbCBhY2NvdW50cykNCj4gDQo+ICAgIC0gaHR0cHM6Ly9naXRodWIuY29tL0FkaXR5
YUdhcmc4L2dpdC1jcmVkZW50aWFsLWVtYWlsW2dpdC1jcmVkZW50aWFsLW91dGxvb2tdDQo+ICAg
ICAgKGNyb3NzIHBsYXRmb3JtLCBkZWRpY2F0ZWQgaGVscGVyIGZvciBhdXRoZW50aWNhdGluZyBN
aWNyb3NvZnQgT3V0bG9vayBhY2NvdW50cykNCj4gDQo+IG9yIHNvbWV0aGluZz8NCj4gDQo+IE90
aGVyIHRoYW4gdGhhdCwgdmVyeSBuaWNlbHkgZG9uZS4gIFRoYW5rcy4NCg==
