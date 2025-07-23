Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010012.outbound.protection.outlook.com [52.103.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EE208961
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292156; cv=fail; b=BmQuNPpAJQN3HnW03KIU/sHkjYE3ugH8M/R37xsA0tB9pBPSRGAhCnSNMTYI9puHF/WXFzoDPLxdQHGSW4UT7rt1FXVswLrJjL3Peet8xa8EZczeQMa28SmLdZFEDUwY9juOU2q6Dqiq484jnYjlgLeb16cmNwURsfdMN5DPbB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292156; c=relaxed/simple;
	bh=1C/RXesC0rBsaR/01d9FXcU7OeHvbyd96v4NPyXZ7cE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EfW8ZtV6N1Ym3GrXlx1+sIRCTMht8T5n5KZEKUkiMzzBGXkcIVCWyE5NOK+dCVo8I6487xPfa44VCXvbYJjulfCxag/ArIpQuT81EXpsNUCsR0cPcTqZHbzJvzFxASeBjR2i4Wn1CnCJa6utDpEbcoyrPH52+Ao8KsaDwLiAquI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QDw5etQ1; arc=fail smtp.client-ip=52.103.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QDw5etQ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjlcCS0L8vT3iPDp2sy0NJxDPMmlx5U3oaW8rZyAQPAHoAQAbXh5dhQTa67a5fMyvkPMQYLXtnsjM4Id/XYa/LGqzxtL0zBVMq2VOyGdEm8R60zNZZ7pFuBVnldGbk/JNfBQQ6oAv7b9lSHLvPkUuTihWnlWtOBOuAu8+N96nYYa0p7fO2BBps2nrDoWfP8ZOzRPD2MBpb8UOAzTlOwatBw3dzWh3tATrVGm0xmVkEoiG9Tai07m3enoi5AcojvBP38h3T6PbpUOKXsKCHlWWH4dwl6C1920w1PGjiwBPc654TREcaN7xxHwfRTgYwfSx4TxqWoBgPtXm47Eo/UH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C/RXesC0rBsaR/01d9FXcU7OeHvbyd96v4NPyXZ7cE=;
 b=A7gCS5MHCmw8OiqlkzmVtKGkGSjxUv8Kc0q6KsHDykgOFvWR8n8SpMsKLI3ihBazTZ9hXNEakqA0khGzEF+pwh/jYC4W0iep2beNkNgwku8CS3Sv5k7ahmPR/ZU8Py5Xua4rIX4CFFw+xIKdWXTFDPQGBkmB9ry+/ClVh85/JMe204rFQ4rsfYtaytdE04xhVVd21zODkuLLMYQ7BaI/IPJorF8vR9ryGnNHE5DMDW4f8fYSK3Ci5SIVtgSzBkrmFkQaXBvrFYE7t9cebxNFSGGFnT8OlyOm8ckcFbp4/6y9H/YcfclRWXqk3q3RhORscsBhPiBpw39ZF/3Ec7S3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1C/RXesC0rBsaR/01d9FXcU7OeHvbyd96v4NPyXZ7cE=;
 b=QDw5etQ12Ty6QL+BlMO8YkjHsmprlOnP8BYsMZjGRlVMascnHeozE/5kZxpNQ32vKR/FIBYR6vBTb8PzTjHpm5npjk2OtoU9KSxcLMT5ccbUVXGtMGoXdFAHUM97r1pHw95rGsqMlyemz8dLcnvhlB1XrwLLHghgBuiwph0Dowvq+2obXQEX8zyIauh53cjEh1r2nfEQvwp5xFBGRMygpfgCL9f8WbGpM7IEDMLgcn3g+EJI7X61UCTalDj+q7ufjsN92QjG+Sod5ulqgaLT1rfOFZRsk0BCa10xVHgsgpwV+IpqouzdEdEBMfGo3li+++RauUnOz+4InXmKGqIn0A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:75::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:35:50 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:35:50 +0000
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
Thread-Index: AQHb+81kOsb3aqbVj0WTwu91w6cBzLQ/9hKSgAACKMuAAACfHA==
Date: Wed, 23 Jul 2025 17:35:49 +0000
Message-ID:
 <PN3PR01MB9597A88A3CFCF9EC84ECCCC3B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
 <xmqqecu6om3t.fsf@gitster.g>
 <PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB6380:EE_
x-ms-office365-filtering-correlation-id: 87633145-c66b-4d86-d0a5-08ddca0f5d8c
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|19110799012|6072599003|8062599012|8060799015|102099032|40105399003|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGg4aWxXYWY3NUhyZU5ac2txa1VGN3hwQWJETTFiU3NRYTBCbm5OWnlJTlg4?=
 =?utf-8?B?QjNjMGpueW8vQnk4SDc0eHlPdnVBOEt6NmdEN2tyTlhKWjE3VDNQeGZaU2tC?=
 =?utf-8?B?bEJFTTcvK24xMjgycldVejdub1dsMHlMa21HaHZLMk9BcTd0MFZabEZvUDNL?=
 =?utf-8?B?WVlZSlFoNm1mVXBuem1OdzRIdXBzQVpGS2tBWkdwSThEOWZ3UktTNVVRVzRt?=
 =?utf-8?B?VDdoQ2JFeWo4Ti9NN2QyV2szbCtOQ3MvZmFjQVlTMjd4anFrSzg5M1FJbExv?=
 =?utf-8?B?MDlvSDBjd01YMXpBUWdvdUxUeE1Mc05hNlFMR0hDOHl4eXQ4NWdvbllpZ2xa?=
 =?utf-8?B?S2pWWXJOUFRwR0lMbFZuWHpsaGVOTmdPTHdrQThaWjVSZFl5WkN0QmtwUG9t?=
 =?utf-8?B?OEhVcjB2WnJDZ29nQ3FKLzYwQ2cxRGpubkZWajNlbitJcWluOEFsbjRSZWFw?=
 =?utf-8?B?czZNa012V2pMNkF6Y1p1MUI5OWdsSG9SZVM3TDlLR0xETndmcWtnVmg5cUdS?=
 =?utf-8?B?S09jcnM2T2xYUVRoUzdCUk5ZRzNpc0xhQUVjeEZnclFVVktpcERqVTFVbGdT?=
 =?utf-8?B?ZElrNStuRzRpcVFJQXBKZDdPcGxlbVlScWxPSm9MSkVWUGMyK0N4eTkyUWVS?=
 =?utf-8?B?eGdMT0NmRkhjaFdVYVYvT3pzWUpkazFPSmhSSWt1ZHYreVpkaVMwNFJLbWo0?=
 =?utf-8?B?aW12VTRXd01WVkJRWDJqbHlrdHA3MFpVZ3dsQWpPRGtyYWVUdHlad3RqWjJP?=
 =?utf-8?B?U1VsWThDd24wY1d6TmwxMzFSU2lnR3lFcGhXa3pGcEV0VnU4SDZvelhVOTNs?=
 =?utf-8?B?cGJHK04vem5GUlJHZzJYR3pidWZZQ2pzTlpoOWdQdy85Z1VXY2c4d0QvdzIw?=
 =?utf-8?B?My9KTzQ4Zm5tM2RaVFFObnEraklmYnQxeTRiMk0vVUl4VXJoMmk2czJudWFZ?=
 =?utf-8?B?SCtEaEplYVdKZHZtNXdEUzBERnJ2Q08vc3paL0VENXpMVmc2aXQycW44RXNn?=
 =?utf-8?B?SDdVR29pcUJZZlFCcENKS2NaOEJwb3ZPUXByc0ZWTzZ3MDVZK0MvTjdidE5l?=
 =?utf-8?B?QUdqSDhMemNOQ3luK3UrbFBvZnNKcXArN2l2dm05YzFSbHNLQWFzZmJhclhO?=
 =?utf-8?B?NUtmNGNReE42cjRkMHhpODNCb2EzQUxabFNaV3ZqZndZZThnaWlVWDIrazdo?=
 =?utf-8?B?Uk1TUjdWRXlUMThLM0w4ZUwzWFpEUEZNUGVxdCszTHdaV0pnSTM1S3pONEZS?=
 =?utf-8?B?V3J0NURsN2ptMGJFQ3R6eVNYRTJpNXR3SklxMG4rK1dsRjBJbThhdXVVdzlX?=
 =?utf-8?B?cGtpS2dsVmErekx0ckhSM2RyRFZ3b1IwZ0FNbXErcktiN3d0SHJDQnNoTkhO?=
 =?utf-8?B?T2MzemkybzBITnA0SmpHd05MTXduRmxyQURxZktFdXBVWmZraXp3M2plUERo?=
 =?utf-8?B?ZDBqL1hJVHd1bFMrcUJNWkN3alRqZG85MUx2WktaTkF6eVZXTEJBME5KZ3pO?=
 =?utf-8?B?WG5OSGtWeFdCZmxmRFJldW5jNmVkeVNmWU1KZnV2TWFmSm5YNDdzSUdSQmFw?=
 =?utf-8?B?RWJ5QT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmQ4V056WmxtOE9KU1Rqc0FOOTFPWFBtRllML2p4VXFYZm1wNmRjZDZIOGpQ?=
 =?utf-8?B?T1Z3bEtnUk5FWDVSVUt0OHFIc2E0c2tjU3U3MVJGbEhBdkJZUDdFZHE5dkox?=
 =?utf-8?B?UW10R2tGWnBkR0gzcE9EcE1mKzNWdG5FTmlJUTdZZDVUdGtBZWR2N3pOWnoy?=
 =?utf-8?B?RW1OU2wvbjlIb0xFY2hpViszVHN4T2lqakZoZ3BCMFVUM1RlMnFNQk1LNWlY?=
 =?utf-8?B?OTBjU0FmcFZKVGJTU0FQQ0tSa1B0c0llbnIwVE9FR2o1ZXdlS1JWOW9ZTk5u?=
 =?utf-8?B?c0J6a1JacXcyU0tRU2pKRzRacXk3cjRQcUdRN0hjYlpWL0lZN2hWUTVDOGk0?=
 =?utf-8?B?bC9CVkdBaHpXak5GNlJYTExYWlMrQlVOaTdEL1dCdlUzQjA1Y0d5amsxSmlT?=
 =?utf-8?B?U25OK0Nkamx2M1BHWnprZEVsTUtubjZoNDEvdFhQQnRnZFFYNGo2eXNtbUov?=
 =?utf-8?B?VW5lblVXRzFFZ280SCswQzIzb1F0blJSbWh5R3o1dnhhcHdMSWVWelAyVmV4?=
 =?utf-8?B?SzE4Q091dzJMMlVZQnd5Vk92OE02T3BnRmJjd0hKZ1pyc1RTN3VSSFdPU0Yr?=
 =?utf-8?B?UVBnaGY0eGc2dmlxRnBTYjJrYVZCdFBDV0pVRlVGNG1uODRnWnYzeFVpemtM?=
 =?utf-8?B?b1pmMy9vYjE0bXA2eURrU3dBK0IzdytndUVXdDZyWW5JcHJraGhHV0xrQmpU?=
 =?utf-8?B?YWlLU25tZFBBWHBTN0JqUExzL3MyMjl0SlB2V1cvTytERStDblRTL0svQzRE?=
 =?utf-8?B?ZTZRK1RQdWd3Z09BSlRWY3dTRXg2TFl5ZnF4MnQzcUllUzBodlNBSGNwNFhW?=
 =?utf-8?B?WXRQWXBJTXl1a3owbGQzdllEa2RGVFlIT09PaXNISE4rVUI1UEVmZ0poN2VD?=
 =?utf-8?B?R2s1cGlNSDN3bkE5RTlxZHpNNmhEcXk3M1FEME90aGNTQm05eFFwZ3paamtM?=
 =?utf-8?B?ZThnWGk3MlpuMmd2ZHV0UDVsZlhBdGl1ZkVwY2U4OU9GRUdjRTlMR1ZGRllN?=
 =?utf-8?B?TlZ2dmxrTDJyWVlZN0QwcGlCVm02ZzJHbjg4YlNoWVMrcGxyLzRKOWx0M2l5?=
 =?utf-8?B?MmF5VWwvYlVoU0paYy9Db1V0MDgvaW9OQzNma0d3OUV1a2xqY3VPYVlLRWNo?=
 =?utf-8?B?SjN2dm5LbllDTHY5M2F0WlZxdVZORzZuS0FHeVIzdm8rY2tZTFVKY1hMTGtZ?=
 =?utf-8?B?dWprSzJOcW55ZTZHekwrYWM1RFFCL1dDWEFjRml6SktpOFpBQlQ0c24vMzZ4?=
 =?utf-8?B?S29yZU5oZXRFdVNLSEtKdngwdmJRQmc1MU9MTUkvVUd3aHk2Y24zeFlkcHlS?=
 =?utf-8?B?bDZxY0lrRzJUenZrT3l3d2tqRmtCRWdmT093QkFhYVFKL05ONkcxc0RJRTVN?=
 =?utf-8?B?bXNHMDRlOGVqb0pURjBjOE5FVkcyZjY1ZHhuYlowOUUyMXdvOVVSOXdVTlM5?=
 =?utf-8?B?NVdaQm5UUkZReFFKYmw0bU5UOEkvOXA3b05seXEwNTV6bkVnc0NOWTAvSlhJ?=
 =?utf-8?B?em1zQkhtY3VOdHNQdHFMakZFbnlTWG9saDhqTkpqYUwrTDBJdDRJdzYvUEJO?=
 =?utf-8?B?STQ5SGVQZ3gya1JlRmxLem1nbnJReUp0N1RvOUszOW0wYnRjalhGalBVZW1a?=
 =?utf-8?B?RmEycXNlUmlSVGxPL1orZ1RSMFZSN2tNN0FZTEFKekF2TGRLY0Y4MHV1cTJa?=
 =?utf-8?B?OXBlUUt4dm5raXpnT3NrcTBGbEptV3lQdUlqckpvU0d5WXhrb3pWUjVoWDNw?=
 =?utf-8?Q?32O1tsPH/nz3+/s/Cg=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87633145-c66b-4d86-d0a5-08ddca0f5d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 17:35:49.9078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6380

DQoNCj4gT24gMjMgSnVsIDIwMjUsIGF0IDExOjAz4oCvUE0sIEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IA0KPj4gT24gMjMgSnVsIDIwMjUs
IGF0IDEwOjU14oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6
DQo+PiANCj4+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyaXRlczoN
Cj4+IA0KPj4+ICtpbWFwLm1hcmtBc1JlYWQ6Og0KPj4+ICsgICAgQ2hvb3NlIHdoZXRoZXIgdG8g
bWFyayB0aGUgc2VudCBtZXNzYWdlIGFzIHJlYWQgb3Igbm90Lg0KPj4gDQo+PiBJcyB0aGlzIHNv
bWV0aGluZyB1c2VyIHR5cGljYWxseSB3YW50IHRvIHVzZSBhIHNpbmdsZSBzZXR0aW5nLA0KPj4g
b3Igd291bGQgaXQgb2Z0ZW4gYmUgcGVyIGludm9jYXRpb24/ICBFc3BlY2lhbGx5IHdpdGggdGhl
IG5ldw0KPj4gaW52b2tlciBpbiBzZW5kLWVtYWlsLCB3b3VsZG4ndCBpdCBiZWNvbWUgbW9yZSBs
aWtlICJpZiBJIHVzZQ0KPj4gaW1hcC1zZW5kIHRvIHN0dWZmIHRoaW5ncyBpbiBteSBvdXRnb2lu
ZyBmb2xkZXIsIHRoZXkgc2hvdWxkbid0IGJlDQo+PiBtYXJrZWQgYXMgcmVhZCwgYnV0IGZjYyBj
b3BpZXMgc2VuZC1lbWFpbCBzdHVmZnMgdmlhIGltYXAtc2VuZA0KPj4gc2hvdWxkIGJlIG1hcmtl
ZCBhcyByZWFkIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Pw0KPiANCj4gU28gd2hlbmV2ZXIgdGhl
IHVzZXIgY2hhbmdlcyB0aGUgZm9sZGVyLCBoZSBjYW4gY2hhbmdlIHRoaXMgb3B0aW9uIHRvbz8N
Cj4gDQo+IEFsc28sIHdlIGhhdmUgYSBjb21tYW5kIGxpbmUgd2F5IGFzIHdlbGwuDQoNCkZvciBz
ZW5kLWVtYWlsIGludGVncmF0aW9uLCBtYXliZSBhZGQgYW5vdGhlciBvcHRpb24gb3ZlciB0aGVy
ZSBhcyB3ZWxsPw0K
