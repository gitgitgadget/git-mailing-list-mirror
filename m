Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7C46447
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425453; cv=fail; b=ZowEC7fv80GZkHvh34BcEAQcDI/qGKh8/sYXgpjwZ9TQe7f1bXY9MSA//L0Pq1C3K5p42SMRYWijlYHOImOZZWJyHk9xe0Wmi//THBCEkGyVBL682ui/uIZm5FjyQ5CFcIYR4D/cPQEXHlCHlgvW6Vx3CB0daylvggRVZmv1uLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425453; c=relaxed/simple;
	bh=pugu2teUD9efaCgakU+PptgOcEGYUFTGMYSowFY8M/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oq7gBCRLI2vi1Ri+I98oqmziy+kL5cAaizQRk3Xa4t/zDxv60WUyY3rdFaMJK4X7Nx3lwq6jdnYLE89o9ZHvm8xk58vG3EKdx/cNrSDWnbMcwjPFJqws660cxnigYF9LOAcKQw1eKFGxJvkDNJkXxjkyZq5rqnCuCuMEqQuCMLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rDoPsqYy; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rDoPsqYy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL0XuoAIaDhxp1n4ut6DyxqNZmLeCkLs9bL/JkTW2IhWWFoEvrNMjFEhmuKg6HJRZZtUEYra4GwCj6wN0FrT6bAjDIb0IDckMgiPrc7a571VSlZXudihWd/TMYniJeB9bYM92scfKVCBUpZiARiYBcpp9n/9oERmRqIMxiPJQ6BQ54M9+aTGqsF3FY3hURE6wYauiHjtkF/8tGmnCiXfxzQj9TzpB72NknkgWtt0PKM7jJSFtBdTKxLNoofPGyZUQuop8xPjXYU7lPVnUG1XTne2QjPqGzH1xyD5yhG7alS0vIJMiNEX83bIC8kKZOnjSTWggBCZfQHXHI14K/9zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pugu2teUD9efaCgakU+PptgOcEGYUFTGMYSowFY8M/0=;
 b=VT3keTQ6zkvvMv6+cPIIsswZvPr8ZFfDkjOvT1WaPTZQ4YYWHmSqSYeT3dS4SLq7H26wVI7KyV3kPrV33z1auda5I710ar2Ao6JWIRd+K4CfK01VXkgUAbcuICCaBgDkM0e/c3WkKEiRLVArzuuYWdQUyJh6HaJuFulP6VF8O2a1H/YHMons6oMNYhNTew8isGnm/qBsDi8UjhPggpqzBxDd+FOYpeUyQUUF+vqVmcW52RDFL/DhknG5v0BGReirwwW9fd/E4PMLQD+C1t+MJ5i/WSt7drPrtyNa4PF7NUq0lOM1MmlxblImXMVassgPF4iYfFimRhX6TCIHIXYISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pugu2teUD9efaCgakU+PptgOcEGYUFTGMYSowFY8M/0=;
 b=rDoPsqYylqu0VqDTYO+PgtktL+lNOvLvf6OL91YZgyQWisC/GIgtverW54/dJv/Am1zToi68sODYvV0oCuPQQyz0CWhUIcbRTQ12KjVy9X9VVBz+WEH7WdwXr22yJNY9L+jdU3uV0ZolgkiFYxWyjQAYG7aqtIVxtUW+qfnlfMRBcQNemc6ME8vw1k+yqRQVXfipyxdOntGNjvIWtf2yM7rvxYXAcsrBKhn/iwlmKsbjUKTkcfdV8HrlDkI4dv8CX/x+EcQvh/8sajKZGfN7m9nG5asoe0htLXikm99C5NAV1483zOvoVTwXd0riUl6+mLLXzCKuepuzfDouaV0MBg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB5631.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 16:24:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 16:24:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, M Hickford <mirth.hickford@gmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Shengyu Qu
	<wiagn233@outlook.com>
Subject: Re: [PATCH v3 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Thread-Topic: [PATCH v3 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Thread-Index: AQHbs5rtt8wQL5KkKUaMfVilcabxb7OwPkBmgABYUieAAMyx34AADcrT
Date: Wed, 23 Apr 2025 16:24:06 +0000
Message-ID:
 <PN3PR01MB959794B1F342A75D8E4FC559B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D68A4E7A570949672832B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqmsc73l8g.fsf@gitster.g>
	<PN3PR01MB9597D275C6E76AD7938230F9B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqo6wm28ok.fsf@gitster.g>
In-Reply-To: <xmqqo6wm28ok.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB5631:EE_
x-ms-office365-filtering-correlation-id: 768fedda-929f-4207-a489-08dd8283451c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|7092599003|8060799006|19110799003|6072599003|15080799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nkt5YjZMM3hyTitoVTZIRkdORjBsOWpYbW1kQ2p5SkpuVkI1Ump1cHpqMDJk?=
 =?utf-8?B?NXVGTW5wZ2UxaVdMNFdLUHFub1Z5U2lvaS9idCtlKzIwSDlMRktUYWVjcTF3?=
 =?utf-8?B?MVFXaVZPbEgwbHE3dURSZEhDaU9ldTNOZlRRaXpvaU1ZM3UwOW1GVFFDQ0Va?=
 =?utf-8?B?dlY4ZTF4WEkxb3pQV2NWNjkxK0pwZUZYcTQ1ZVdJd1ZFWHdwM3IrZktxSU9J?=
 =?utf-8?B?YklqTDdzaWg2VGNMNVNrbktRY1hTWDdaNGNMekJlQmo2VG9GR20wQ3RiaHZW?=
 =?utf-8?B?d3JvSG5JTkNRMm5jNGhtVmc3a2RYSGVwTy8wNk5mbFNCSHpvbE5PVGJGbm52?=
 =?utf-8?B?YUFuS2RQNGV1VXBNTUNQQ2w0SHNIbHJNTlZ5dEN0NUJraTdUWlNMVFlYaG83?=
 =?utf-8?B?OXJYbzZHcXFwalFkamhBcWR1NTh0YzA4TTlnbXBKRnNuMVpGMk13RE1LSlBo?=
 =?utf-8?B?UWRBcVV4bVh0SXdDekwvMGxTYlJoNDdMMWgwd2V0ZnUyck42ejgzNWI4MHFw?=
 =?utf-8?B?QWNxR3NqV1liZ1V1UExWeG1iM2QxT2I2cnd2cUFjdEl6WnFFV0xJUkJ4Unli?=
 =?utf-8?B?VnpqVjVac2pBM0xrMllLZ3dZVGQ1QzFhcHFWYWNwSm0vNGswNVdVb3d5MFQr?=
 =?utf-8?B?LzkrQXNubmJKTlk1dVdMN3FNaWFaV2p1U1RST21VV0tyN0xncGVIbnEzNmFV?=
 =?utf-8?B?dEJLWTZhRFM0bnliVDVwbFRUTHh4dXYxeGh2L2kwaHlmWFJuVFhvQnB5bDhr?=
 =?utf-8?B?U0lSY3QvOEJUWnBiVVlXbUo5dWYySExmUUQ2TnBXTWFXNG9OczA3UHBCVEFV?=
 =?utf-8?B?R2Zjc1pueGtKY0ZXK2JzMS93WHJGNFpqNzBFbEtZOWxMRElLRDl2QmpkcnRR?=
 =?utf-8?B?SjU0eGMwaFlRV04vT1M2aUtlYXpMTnB6NU5ONmRKQ3Vxcm1nVmhOT1VwM0c1?=
 =?utf-8?B?bzhuOGZsMU1IWFZUMks3VnRPNWtKaFFPZzRxd0djbWROYkFEb1c3OGsybTNR?=
 =?utf-8?B?TEJKRUxFU1FaeGFrVjFsNXBySllpUllzRmtHUTdSRGZTVzZKdWFydUxzMXZL?=
 =?utf-8?B?bWhCdk9oUnlYSCtVQkd1S0VtU0R1SjBCSTV5dWFWcUFlWDBScng5emZjNjZH?=
 =?utf-8?B?TjY4eUk2a3Y3V3drQWJIaVZqM053NnRmTnlML2xJUC9DZ0QvT3JVU0FMZjd0?=
 =?utf-8?B?OGpTd215RHUvTFJoZzdWMFkyZGtHbmhQK0hPTFZTNFRSd2JjMzhtcVQzdWsv?=
 =?utf-8?B?Ulp4dEdmMVN5NVlsU21nTkJMcE5aWHZEdDJnenJJN3NpL1BMVWNESkRFZUt6?=
 =?utf-8?B?RVA3VktBN3MzUEVudUxvbDY0QnZIR2F4THJMV012RSt6elM2SGFLWDBtUC92?=
 =?utf-8?B?RjBGcVlONlN0WGpWQ1ZMcjJMNU5wdHVtWGFhL1FzN0N6bllxSmVWR01pWXFv?=
 =?utf-8?B?bDV3V3Urc3I1ZVl4cDhDMm9TRHZFNUZKUGgycGU2VnZUV1JHS0RRSTFza3hL?=
 =?utf-8?B?c0ZMWHZ2T1ozMlBHQXdsdU4zR3B4V2hDem8xNGtOZTE1L2NodUQ2ZklFckIr?=
 =?utf-8?B?TWYwdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2hNRnJNMFJaTFROUW03emhpeEw2ZWgrc3RXN09KN3ZqbVZNdTc3REpvVjZx?=
 =?utf-8?B?Nlc1UVdCaWpwK0RxbWRaODhoUENXMjJoeEtsTTVyRFRhYWRPY3dEN0FiRmRz?=
 =?utf-8?B?UkYvZWpGb1o0WkZDbU5ndFpnSVJUUUY1dG54Z3pTeUhHc2NtcStNQk9zYktI?=
 =?utf-8?B?ZTgybnNPVE1HWjZtRVo5NmdyVStLdVg4TjhaZkpid1lndGgxZ29ZWUYvbHUv?=
 =?utf-8?B?Mnh0QmkyTnJqM2xzY1BIZThRUE9MY2Q4TmJIdFZjendnVWk2NUZ4R1Y0aUc4?=
 =?utf-8?B?Q2YzbXBZTzZGRDVBOWZYOC9qampINjlpeUtyaHpnZk00QjdrZWhRVVdVWWhJ?=
 =?utf-8?B?K21TcTFVMVhaMEtrN25PUE1mdjI1aHZnNS9PRnJFcmt4SldBdHNnRjFhN1ZV?=
 =?utf-8?B?eStmbFczeThTYmhUaURPRlRRSTVyZTcvQmNJVmNGZktLcm9WV1lNN25taHdK?=
 =?utf-8?B?VEQ3YW5mZlVZYW5vbXZPTGpIWW94RDVrQVhrdGdrYVQ1cmJPT015cWttRmYw?=
 =?utf-8?B?Q3U4SGNpZkt6M05wL2Vxc2hrQVRUVFBrR3ZhSG9rcmEwUXRpYUJnSkhFN2Rr?=
 =?utf-8?B?bndSN0hEdWZ5d1RiVlBqdXdFVytWK2dSZ29wS0ViSmhNV1ZHRk9zeS9VZ1hU?=
 =?utf-8?B?cDBFbW90Vmh6bHRMdFdVVmwxWTIvUkJNTU1DSElBN20yakUxWUJtWlJsQ2ZW?=
 =?utf-8?B?QmVyelpMVElhbEhscit5WG12MGxJVExRSEk0c3R1VHNrM0o0Q3l1STM2Ky8w?=
 =?utf-8?B?MkhCemJmK0x5YUZzRzlxbW55dDF1SFM4QktRTTF1c0NGbmt1eTRmUjFSeko5?=
 =?utf-8?B?SFRUcFFUTzcyZENycWZab3V4b2JYbUVGNzZzdWlHM1VyVWJQS3d5YVAyWkRM?=
 =?utf-8?B?aGFaVzc2UDhYc2p5VHVjdFFrak9NR2I1aml1QytxR3pwaDFHNzQwVzh4ZHB0?=
 =?utf-8?B?V0hzR3dvVHc0M2RQVzlOSmdjOC9oWjI1ZFZVZDVVOTZ4SWF4TWREUWtxM1FN?=
 =?utf-8?B?eitibzBqb29aNmV1ck43MnFBaG9SczVNWjNUTXFjdFdQdGp2S09RSTUyaTZn?=
 =?utf-8?B?ejdZUWlRVjRUSmV0aUlKRGw4S3grRHlzNFd2d1N0V0xoK2xaY0RVbklaanln?=
 =?utf-8?B?aUkxRTA5NEY5WmZQdUx1MGx2cXBiZldERzJkaWJMWEptU2tLNjM0MzcwZTd0?=
 =?utf-8?B?R2pEd2pZd1NLTG1RSm5McWRHRkc3QUxtRk1iblN6VHpXaFV1WS9zRGxJU3h1?=
 =?utf-8?B?UWpTUm5QYll4bWNyVWFma3ZWZnphbjB1L3FnbTkwL200YUFuRDBBZGFTLzJW?=
 =?utf-8?B?VGtFK3BISWFyK2FEZXlUYXVGTUdiYmVOeXBRZ0xEblhxQWRlak80eEpVcU4v?=
 =?utf-8?B?Yk1iMG1XdEJHTzliRVJWVjRlNm80WEpxcEU2MCtSSHpxS3FqM3ZYRFhkQ2VH?=
 =?utf-8?B?c2xieEVsYkdydnJ0OWs5TnFuQTdCbjI2K3BrZUtOL2Y0S2dkTnptODh5QjVJ?=
 =?utf-8?B?NzJIeVVrMTJMTG1vN245dlJVY3g3RTNyU0hTcUVWNnNza0dEZ0pwVVNUanJx?=
 =?utf-8?B?UkRSL3FqZjRFSlY3YWROT1dtd1lsVHkvL2o2OTdVTWNpdVhaMGs0bSt5ckFj?=
 =?utf-8?Q?xptXpveGQ8we5sQm/ED1gWPMdmHtRl5GIMv7k1by+X0w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 768fedda-929f-4207-a489-08dd8283451c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 16:24:06.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5631

DQoNCj4gT24gMjMgQXByIDIwMjUsIGF0IDk6MDTigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+Pj4+IE9uIDIzIEFwciAyMDI1LCBhdCAzOjM24oCvQU0s
IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4g77u/
QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4gd3JpdGVzOg0KPj4+IA0KPj4+PiBP
dXRsb29rIGRvZXMgbm90IGFjY2VwdCB0aGUgTWVzc2FnZS1JRCBoZWFkZXIgaW4gdGhlIGVtYWls
IGJvZHkuIEluc3RlYWQNCj4+Pj4gaXQgc2F2ZXMgaXQgaW4gaXRzIG93biBwcm9wcmlldGFyeSBY
LU1pY3Jvc29mdC1PcmlnaW5hbC1NZXNzYWdlLUlEDQo+Pj4+IGhlYWRlciBhbmQgYSByYW5kb20g
TWVzc2FnZS1JRCBpcyBzZXQgbXkgdGhlIHNlcnZlci4gQXMgYSByZXN1bHQsDQo+Pj4+IHJlcGx5
aW5nIHRvIHRocmVhZHMgZG9lcyBub3Qgd29yay4NCj4+Pj4gDQo+Pj4+IFRoZSAkc210cC0+bWVz
c2FnZSB2YXJpYWJsZSBpbiB0aGlzIHNjcmlwdCBmb3Igb3V0bG9vayBpcyBzb21ldGhpbmcgbGlr
ZQ0KPj4+PiB0aGlzOg0KPj4+PiANCj4+Pj4gMi4wLjAgT0sgPE1lc3NhZ2UtSUQ+IFtIb3N0bmFt
ZT1Tb21lLWhvc3RuYW1lXQ0KPj4+PiANCj4+Pj4gVGhpcyBjb250YWlucyB0aGUgTWVzc2FnZS1J
RCBzZXQgYnkgTWljcm9zb2Z0IGluIHRoZSBmaXJzdCA8Pi4NCj4+Pj4gDQo+Pj4+IFRoaXMgcGF0
Y2ggcmV0cmlldmVzIHRoZSBNZXNzYWdlLUlEIGZyb20gdGhpcyBzZXJ2ZXIgcmVzcG9uc2UNCj4+
Pj4gYW5kIHNldHMgaXQgaW4gdGhlIGVtYWlsIGhlYWRlcnMgaW5zdGVhZCBvZiB1c2luZyB0aGUg
c2VsZiBnZW5lcmF0ZWQgb25lLg0KPj4+IA0KPj4+IEhtcGguDQo+Pj4gDQo+Pj4gc2VuZF9tZXNz
YWdlIGNhbGxzIGdlbl9oZWFkZXIgYXMgdGhlIGZpcnN0IHRoaW5nLiAgVGhpcyBwcmVwYXJlcyB0
aGUNCj4+PiB1c3VhbCBGcm9tOi9UbzovU3ViamVjdDovRGF0ZTovTWVzc2FnZS1JRDogbGluZXMg
YW5kIHJldHVybnMgdGhlDQo+Pj4gaGVhZGVyIHRleHQgYXMgd2VsbCBhcyByZWNpcGllbnQgYWRk
cmVzc2VzIGJyb2tlbiBvdXQgaW50byBkaWZmZXJlbnQNCj4+PiBjbGFzc2VzLCBhbW9uZyBvdGhl
ciB0aGluZ3MuDQo+Pj4gDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBnaXQtc2VuZC1lbWFpbC5wZXJsIHwgMTEg
KysrKysrKysrKysNCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4+Pj4g
DQo+Pj4+IGRpZmYgLS1naXQgYS9naXQtc2VuZC1lbWFpbC5wZXJsIGIvZ2l0LXNlbmQtZW1haWwu
cGVybA0KPj4+PiBpbmRleCBhNmNhZmRhMjljLi4yMTZiMjNjYWE1IDEwMDc1NQ0KPj4+PiAtLS0g
YS9naXQtc2VuZC1lbWFpbC5wZXJsDQo+Pj4+ICsrKyBiL2dpdC1zZW5kLWVtYWlsLnBlcmwNCj4+
Pj4gQEAgLTE3OTksNiArMTc5OSwxNyBAQCBzdWIgc2VuZF9tZXNzYWdlIHsNCj4+PiANCj4+PiBB
bmQgYmVmb3JlIHRoZXNlIHByZS1jb250ZXh0IGxpbmVzLCB0aGUgY29tcG9zZWQgJGhlYWRlciB0
aGF0DQo+Pj4gY29udGFpbnMgdGhlIG1lc3NhZ2VfaWQgaGFzIGFscmVhZHkgYmVlbiBzZW50IGJ5
IGNhbGxpbmcgZGF0YXNlbmQoKQ0KPj4+IG1ldGhvZCBvbiB0aGUgc210cCBvYmplY3QuICBBZnRl
ciB0aGF0LCB3ZSBhcmUgLi4uDQo+Pj4gDQo+Pj4+ICAgICAgICAgICAkc210cC0+ZGF0YXNlbmQo
IiRsaW5lIikgb3IgZGllICRzbXRwLT5tZXNzYWdlOw0KPj4+PiAgICAgICB9DQo+Pj4gDQo+Pj4g
Li4uIHNlbmRpbmcgdGhlIGJvZHkgb2YgdGhlIGUtbWFpbCBoZXJlLg0KPj4+IA0KPj4+IFNvIGl0
IGlzIG5vdCBjbGVhciB0byBtZSBob3cgb3Zld3JpdGluZyB0aGUgJG1lc3NhZ2VfaWQgdmFyaWFi
bGUNCj4+PiBhZnRlciB0aGUgbWVzc2FnZSB3aXRoICRoZWFkZXIgd2l0aCAiTWVzc2FnZS1JRDoi
IGxpbmUgdGhhdA0KPj4+IGNvbnRhaW5lZCB0aGUgSUQgd2UgZ2VuZXJhdGVkIGhhcyBhbHJlYWR5
IGdpdmVuIHRvIHRoZSBTTVRQIHNlcnZlci4NCj4+PiBXaGF0IHRoZSBjb2RlIGlzIGRvaW5nIGNl
cnRhaW5seSBjb250cmFkaWN0cyB3aXRoIHdoYXQgdGhlIHByb3Bvc2VkDQo+Pj4gbG9nIG1lc3Nh
Z2UgZXhwbGFpbnMgaXQgZG9lcywgaS5lLg0KPj4+IA0KPj4+ICAgLi4uIHNldHMgaXQgaW4gdGhl
IGVtYWlsIGhlYWRlcnMgaW5zdGVhZCBvZiB1c2luZyAuLi4NCj4+PiANCj4+PiBJdCB3b3VsZCBh
ZmZlY3QgdGhlIG1lc3NhZ2UtSUQgdGhhdCBpcyB1c2VkIGJ5IHN1YnNlcXVlbnQgbWVzc2FnZXMN
Cj4+PiB3aGVuIHRoZXkgYXJlIHNlbnQgYXMgcmVwbGllcyB0byB0aGlzIG1lc3NhZ2UuICBJIGRv
IG5vdCB0aGluayB3ZQ0KPj4+IGNvbXB1dGVkIHRoZSBoZWFkZXIgKHRoZSBJbi1SZXBseS1Ubzog
ZmllbGQpIGZvciB0aGUgbmV4dCBtZXNzYWdlDQo+Pj4gYXQgdGhpcyBwb2ludCBvZiB0aGUgY29k
ZSwgYW5kIEkgY2FuIHdlbGwgYmVsaWV2ZSB0aGF0IG11Y2tpbmcgd2l0aA0KPj4+IHRoZSAkbWVz
c2FnZSB2YXJpYWJsZSBhdCB0aGlzIHBvaW50IHdvdWxkIG1ha2UgdGhlIG5leHQgbWVzc2FnZQ0K
Pj4+IGNvcnJlY3RseSBhIHJlc3BvbnNlIHRvIHRoaXMgb25lLg0KPj4+IA0KPj4+IFBlcmhhcHMg
eW91IG1lYW50IHRoYXQgT3V0bG9vayBESVNDQVJEUyB0aGUgTWVzc2FnZS1JRDogZmllbGQgaW4g
dGhlDQo+Pj4gbWVzc2FnZSBpdCB3YXMgaW5zdHJ1Y3RlZCB0byBzZW5kIG91dCwgYW5kIElOU0VS
VFMgaXRzIG93bj8gIFRoZW4gSQ0KPj4+IGNhbiBzZWUgaG93IHRoaXMgcGF0Y2ggd291bGQgaW1w
cm92ZSB0aGUgc2l0dWF0aW9uLCBidXQgdGhlIGxhc3QNCj4+PiBwYXJhZ3JhcGggaW4gdGhlIHBy
b3Bvc2VkIGxvZyBtZXNzYWdlIG5lZWRzIHRvIGJlIHJld3JpdHRlbi4NCj4+IA0KPj4gRXhhY3Rs
eS4gV2UgZG9uJ3QgY2FyZSB3aGF0IG1lc3NhZ2UgaWQgdGhlIHNjcmlwdCBpcyBzZW5kaW5nIGhl
cmUuIFdlIGp1c3QNCj4+IHNlbmQgdGhlIGZpcnN0IG1haWwsIGFuZCB0aGVuIHJldHJpZXZlIHRo
ZSBtZXNzYWdlIElEIHRoYXQgd2FzIHNldCBieSBvdXRsb29rLg0KPj4gDQo+PiANCj4+IFRoZW4g
d2UgY2hhbmdlIHRoZSB2YXJpYWJsZSBzbyB0aGF0IEluLXJlcGx5LXRvIGFuZCBSZWZlcmVuY2Vz
IHdvcmsgcHJvcGVybHkuDQo+PiANCj4+PiAgIEFmdGVyIHNlbmRpbmcgYSBtZXNzYWdlLCByZXRy
aWV2ZSB0aGUgbWVzc2FnZS1JRCB0aGUgT3V0bG9vaw0KPj4+ICAgc2VydmVyIGFzc2lnbmVkIHRv
IHRoZSBtZXNzYWdlIGFuZCBzdG9yZSBpdCBpbiAkbWVzc2FnZV9pZA0KPj4+ICAgdmFyaWFibGU7
IHRoaXMgdmFsdWUgd2lsbCBiZSB1c2VkIHdoZW4gbmV4dCBhbmQgc3Vic2VxdWVudA0KPj4+ICAg
bWVzc2FnZSBhcmUgc2VudCBhcyByZXBsaWVzIHRvIHRoZSBtZXNzYWdlLCBwcmVzZXJ2aW5nIHRo
ZQ0KPj4+ICAgdGhyZWFkaW5nIG9mIHRoZSBtZXNzYWdlcy4NCj4+PiANCj4+PiBvciBzb21ldGhp
bmcuDQo+Pj4gDQo+PiANCj4+IEknbGwgY2hhbmdlIHRoZSBsb2cgbWVzc2FnZSwgYWx0aG91Z2gg
aXQgc2VlbWVkIGNsZWFyIHRvIG1lLg0KPiANCj4gU291bmRzIGdvb2QuICBXaGF0IGNvbmZ1c2Vk
IG1lIHdhcyAiYW5kIHNldHMgaXQgaW4gdGhlIGVtYWlsDQo+IGhlYWRlcnMiIGluIHRoZSBwcm9w
b3NlZCBsb2cgbWVzc2FnZSBsb29rZWQgYXMgaWYgaXQgd2FzIHJlZmVycmluZw0KPiB0byB0aGUg
TWVzc2FnZS1JRDogZmllbGQgb2YgdGhlIG1lc3NhZ2Ugd2UgcmV0cmlldmVkIHRoZSBJRCBPdXRs
b29rDQo+IHdvdWxkIGFzc2lnbiB0byBpdCwgaS5lLiBhcyBpZiB0aGUgb3JkZXIgb2YgZXZlbnRz
IHdlcmUgKDApIHdlIGdyYWINCj4gYW4gSUQgZnJvbSBPdXRsb29rLCAoMSkgd2UgY29tcG9zZSB0
aGUgaGVhZGVyLCBlbWJlZGRpbmcgdGhlIElEIGluDQo+IGl0cyBNZXNzYWdlLUlEOiBmaWVsZCwg
KDIpIHdlIHNlbmQgdGhlIHJlc3VsdCBvdXQuICBXaGF0IGhhcHBlbnMgaW4NCj4gcmVhbGl0eSwg
aWYgSSB1bmRlcnN0YW5kIHlvdSBjb3JyZWN0bHksIGlzIHRoYXQgKDApIHdlIGNvbXBvc2UgdGhl
DQo+IGhlYWRlciwgd2l0aCBvdXIgbWVzc2FnZS1JRCBpbiBpdHMgTWVzc2FnZS1JRDogZmllbGQs
ICgxKSBPdXRsb29rDQo+IGRpc2NhcmQgb3VyIE1lc3NhZ2UtSUQ6IGZpZWxkLCByZXBsYWNlcyBp
dCB3aXRoIGl0cyBvd24sICgyKSB3ZSBjYW4NCj4gbGVhcm4gdGhlIElEIE91dGxvb2sgdXNlZCwg
YW5kICgzKSB3ZSdsbCBwcmV0ZW5kIGFzIGlmIHRoYXQgSUQgaXMNCj4gd2hhdCB3ZSBnYXZlIHRo
ZSBtZXNzYWdlIHdlIGp1c3Qgc2VudCBpbiB0aGUgZmlyc3QgcGxhY2UsIHdoaWNoDQo+IHdvdWxk
IGJlIHVzZWQgaW4gSW4tUmVwbHktVG86IGZpZWxkIG9mIHRoZSBtZXNzYWdlcyBzZW50IGFzIHJl
cGxpZXMNCj4gdG8gaXQsIGJ1dCBpdCB3YXMgdW5jbGVhciBmcm9tIHRoZSBkZXNjcmlwdGlvbiB3
aGljaCBvbmUgeW91IG1lYW50Lg0KDQpZb3UgdW5kZXJzdG9vZCBjb3JyZWN0bHkuIEkndmUgYWxy
ZWFkeSBzZW50IGEgdjQgd2l0aCBkZXRhaWxlZCBkZXNjcmlwdGlvbiBhcyB3ZWxsDQo+IA0KPiBU
aGFua3MuDQo=
