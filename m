Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011036.outbound.protection.outlook.com [52.103.68.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F521D3DF
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293623; cv=fail; b=kwMg6Q7JnvJMIBHH3JXlB6PnkcesqOMmDhcgCeOvdswwDzRdS3/+/mQEFeEUIdtMS+nKT6+FqU9DnfA2cPWGXy/NrnA3uJAFkXUmbd+Rp20m7B29W1tdsMsDa/7o6B+TA2GR/rkCfaXvBkTm4mgFpKCTwXK+Q86/wV2Q10cLu9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293623; c=relaxed/simple;
	bh=tleeURGtOXPAYKfhKCwSlAcSNJwy/fivYqsGvU9prZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jPiEQ2MvxFAzqyxidSAkYNeQf0Venz4XDNz3OWcB31y2z8xw0iAaRr8xqc+lNL85KScsM4viwEyI57ywlBkND9e2N6x/Foxc9d+G3oktmQKIcXe1iBcsCqIOH4pFcGn1M9LETYxV+b+Iegtq2joX3wnBjDEYCVgWl1jQgyVy9zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QcKlzHTX; arc=fail smtp.client-ip=52.103.68.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QcKlzHTX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0T9l1YzaG2lvOIaX44rSzNIQrPeOQNjklpFhnr87UVPXfVeblIryt6bY+RE8CEEVOTA/td1NNmO+VEgdB6VQlxhvP31OHXvtb31hxgLB5OfH1y6tuS6mKgNjP69JMuphpggQR8YrJ6cqdPz3yF/Ht5ikHYISqRX2WHk+ZTj9HG1rIGxJsqTULJrvLV5VDycHh1YFZ6awRXuc6PEZtd2XBWsBzpEZWLBskNwhM56ylRJ6ZiVJ+9QBzZ0GN5X3rHd0V03+vAWbqKPHukVifrj26p+6lirrO51vgKQDX5cxXH5f8wtd5ldHdE7umThT6fToaMutJEbtP5LnkdkzfyJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tleeURGtOXPAYKfhKCwSlAcSNJwy/fivYqsGvU9prZM=;
 b=Ml0c8fLpwwHd7eduiQ14lmfkrhsG8ZieB0yI5gwyjZuTxl2SuIOJSnmUTwVfhAfM0PXjmxWtY0s6h6Pl+vgiSbVuSq4Yv6zak0B1SNvh3GbW+dKvKOG33rOWgdG4pljOMcQb7fm444tq6MnZnRRgafCbqx7aPCShDlB5T9XNDQxt/J232h7MC/YH/s11u38Mwe9d1AHXylqqDJCLszCyZ1EHX5OQgIM6mjODJz6ILC53YD9PYjaKWUVDfemiPpi1Kla0txYXhMc78M0YthwXyy8pv9Iy8kxF0U/j0jICfN7auT4yYh+O3xEP6QddK6ibxEyAjXVWEVZg66EoPtiqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tleeURGtOXPAYKfhKCwSlAcSNJwy/fivYqsGvU9prZM=;
 b=QcKlzHTXJlc4Cy0rxvysMEzOYPMjgfS1LhNtkPjbJcNt2YWiIzFOr2AlXbV5dDZ9tm128/+RiXBm9X9XZItyrUF3nGfw1z7k2v4VhPHuiyM6hdsFmd0fn/DhWQZwjJzqSmAvNXTkaUPZkKqAcK+8A9sVU8YshbZjWi2hp2rT+quqbsEhSc8kN0UEbyPT7BvHdHozm/uHYwOoGrEdNu/fl3IG5DdOUKhXDUqPkPLygBr9ETFU4A5ALkVQKx7v0Y2WSApiE3rXEi4c6SqGs7N6rnDTLUxDTgq0j9ttfJR7ZNlPAsHBNH4H2pR/YTv7bhY2tzG0tQE2yLBbPcPFycqZNA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 23 Jul
 2025 18:00:16 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 18:00:15 +0000
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
Thread-Index: AQHb+81kOsb3aqbVj0WTwu91w6cBzLQ/9hKSgAACKMuAAACfHIAABcXlgAABD1w=
Date: Wed, 23 Jul 2025 18:00:15 +0000
Message-ID:
 <PN3PR01MB959724CCE0747A885E5B0B14B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
	<xmqqecu6om3t.fsf@gitster.g>
	<PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597A88A3CFCF9EC84ECCCC3B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqpldqn64c.fsf@gitster.g>
In-Reply-To: <xmqqpldqn64c.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8103:EE_
x-ms-office365-filtering-correlation-id: abcac198-5a86-400d-8ae0-08ddca12c714
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8060799015|8062599012|461199028|19110799012|15080799012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZzBEL0xieDNzbmM3MlBQQnBCYVp4Uk5NTVZGRHJSTjYvaExOS1J0ZUZiazl5?=
 =?utf-8?B?QW95KzhYK3ZQRm14dlZPc3VEZzdtYmFsQW9YNmY1MDViaForSGJ0WGs0OWNz?=
 =?utf-8?B?ZlFuZFhnMkd6RWI1MlNMM1NsU0luZit6ZVRTb1pNRnU5VTNFcEsyR3JhNzUx?=
 =?utf-8?B?bktUQTRLMG1zMzBFK3k1RXRJdVVidmx4dGZ4VElQbXN1THA2dXY0VWxsYVpP?=
 =?utf-8?B?MTBFQmZHVW9zaGJmNFJGRkxvalYyRjZROFRYME9kY2c0d2N6ekN5YnFoSy9G?=
 =?utf-8?B?bVd1bEtBWGlNTWVxTitGdjRRZjN4c0VvK2puTVJFVGpseHNpSlpEU1d6d3l2?=
 =?utf-8?B?RGxGc3FJZzdabWxHWHY0NEhCZEdxTENjZ1F0S2dLWFdBbVEwMTlRbUlnaE94?=
 =?utf-8?B?MWpTbmo0NkNpbVUyeHUyQ2RXOXNjWFQvZkJ1RjE2emY5a1gxd0hTemdIUjVH?=
 =?utf-8?B?MDF4SHhEUlJQbEJaVzFnMTZ6ZnovR1IwMy9aUFkzdFZjSGViV0ozT3NOTWFJ?=
 =?utf-8?B?WlR1WmNJYlRucEtjNXBaWnpwbkZEQ0JjZDdWbS9qWnhPZnFWS0tmUTZuQlVv?=
 =?utf-8?B?Z0czTU93T0w4L2x5Mktudm8rRFhPaGhiUjNRcDFic3VRcEQxejNnR3hFN0lh?=
 =?utf-8?B?bjY3NmF4WnJpK2V1TUp4Z2ZodEZmdm5NVVBrVkJMSE53emN4aGRZN2k5dlBP?=
 =?utf-8?B?ZXJwSnkzU1pjQ2U2WEpQVjFjeXpUcXF4SVprb2Q1cGFYbzZYNWgxd1hmalAx?=
 =?utf-8?B?d2I5ZDIrV2FQdHZaREhFUzZqR1ZtdlNocHNJb3g4Z2NNY1FzUEdnNzJ0OEN4?=
 =?utf-8?B?Tk54cDJSTm0vMVNFRWtub29VSjlyN2lvQURJSU8zMXdIdE9aWUQ5d0JHWFdn?=
 =?utf-8?B?MG9obXZKTitLSTZjeDJzU1pjeUJWMkdpeVR3ejBkdkV6eHZFQm9hZlg2a29T?=
 =?utf-8?B?cWgxdUFHZkNCNEN0YUpaTnZFbThIbllqRkJsUEZNRUtqaVBMMnNHMmVkT3FW?=
 =?utf-8?B?M2l3VFdhUnNxRVQ2MzhCb1cvanR0L2RqQU9UT2kwMStpRHpidTZBN21XQSsw?=
 =?utf-8?B?R2tnNXdIbER1VmdRY3ZlMkc2dExmbUU1dzNCV01kTkJ6dEoyb0pFTEVJSzQr?=
 =?utf-8?B?UWVuakJjNjZUSmw4V1lyQXpZTHNQazNPSm1oSU02c2pXOEhpWnc1L2pSVGFY?=
 =?utf-8?B?RWpwWUJiQ2gzeVZkOUh2TkQ0Q3o5WDh5eTBSYXZRSE1hUWFXVktjLzQzL0pB?=
 =?utf-8?B?T0swdUpjRW5CUnRDWEgweEppWFdzMXRpcHpEbXoyZGNlR2o4SEMwSUQrWk9K?=
 =?utf-8?B?QTZFOHBRbDgxUnlUVDAxY3VRSFVZbHpFZXpXNGVjK0ZpOGs0dzhnaVYzUmVu?=
 =?utf-8?B?a0RwaTFKZU51V3lyOUVIaU5YdGZ4QjErZFVINzI1NnlvN1BmRE9ZNWt2YWpQ?=
 =?utf-8?B?M2NmakFtdTdCWHlycXM2ZVZSY1NiY1RWV0FGVDJIampqM01NYjFmMElFWTBv?=
 =?utf-8?B?YjE3UVg1MDZtVmU2Qno2WC9kT2dVTDJHZWlCN0M2WDFuTUhnbWdqaWQ4WjlQ?=
 =?utf-8?B?UEl2QT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW8zZ1EvVVk4aVloWG1ZeDBsTU9oY2tJREpMeWZ6d1d5ajRDcEF4NVZUeVV6?=
 =?utf-8?B?QnVMMk1SRjhhUTFsUkZISkFiMGhjYmRRWWZaMk1wUFM3RXJJT0pSanYwbXk0?=
 =?utf-8?B?WGxjb2c3MnNDMUlKUlU2UGpHQmozQTlwajhOT3NoOEdPUm1ydFB0aVZUSTRi?=
 =?utf-8?B?blAzNHBwS04xS05iR2tKTW1iMEl5RDE4cXdZK1N4cHdtV0c0dzYyc244T0RB?=
 =?utf-8?B?U0hrZjdvMW5YZlBDNXVsYnpQTVJEcmQ0YUF4SC92NjhVWkhkd0tzWCttTlJU?=
 =?utf-8?B?QnJUOXRGSzloT3NzWS9PeXd2UzkyRG9Edm9JckEzNXVNWm1qZVZxMzZyZkRO?=
 =?utf-8?B?OUNyVDZJQitudDdtOWN4UmVGQjFHRzZYdytaZVp2SGVzYkJmak9iT00wVkhh?=
 =?utf-8?B?V2Z3K0ZGam83WS9LWmk0OGtOZVdWVFI2SVZ1NGY5akNXc0hnNk9HejBuOHpM?=
 =?utf-8?B?YlNXZks4d2RtRDYxOFBRclRCK1dUZjVzMkZLU0R1WnhUN3Rpa0dtcUJWcXRJ?=
 =?utf-8?B?M2YrWUNURkFpMWozR2U3SjYveEIzRFBMOUovOC9SWmhGWS9PY3dlZDNiRE00?=
 =?utf-8?B?QnFUWTc5N0ViMlZjUWJnNk5kRnV2SW53eFhHcHZGaGNyZGtNMUhzdVpZQ0pF?=
 =?utf-8?B?WStIWmtlQmNsTlJtQUJvUEQ0aGZjSTlsZkFiZDBZR3QvbnQ5VlUrRVV6MGJm?=
 =?utf-8?B?ZHlndFd2UlVnZzNVT1BMemM3eFBOWHNUTld0eU5lTEFYZ0VyclJDcHNqMGpX?=
 =?utf-8?B?YUhSZWRXdlcya2h2a2VYc3JYRVExMDM5RUx4alNacUEraHNWaCtOcjh1K2I1?=
 =?utf-8?B?QjU0aFJoUWptMzFOQ2lWSThQdVBEYkZDNis5Ky9FalE5ZWFtOHVucXRCYVZ3?=
 =?utf-8?B?alVIWEhzakM0RkRtamREakhDMkRuM1ByYW05bTduK0hRaStoemQrWTFEK1JP?=
 =?utf-8?B?TVRUOFB0UlUwZmRaODNzekJ4RXVzaG9tWktHTW10N05oZlk0Wnp3NTUwdHpI?=
 =?utf-8?B?T2ExSVZFRUd1K0YzSXVhQ1FnR1VnUWpVL0VIL3gzcnBMN3RGM0xWbUlHTUNH?=
 =?utf-8?B?V1pmQjJ6VlVSbHEvanA3dHBCOUxFdHFCa1Zsa0VBb2J1VEdkNWs0SjloSVFt?=
 =?utf-8?B?RWtFNTBJRDhxWVJFbU0xZTJsZmNjL0FwMkphaExlZ1ExclFvYnN4ZkQwOW5T?=
 =?utf-8?B?azBocHJPaVkySXFBcXJJQ1QwcWwvbmVQZ2xxZ204QlJNamRsSUpyZHdiOHI0?=
 =?utf-8?B?MTkxN0d5a28xSnVqMjhscTFCaFJhK1RFSTNUMm80MThBNVBlcEloMzEvYUpS?=
 =?utf-8?B?dElJMCtETmxZa1pWOW5LOUZSZk1QZ3VRczNvdURJQndYcjNra0hseVREeEZk?=
 =?utf-8?B?ZTRXTktjbzJtNlNXbWlLYitJZ25IN0F1RmVqRG5vcnIwdGZJczlWbXBOZUxw?=
 =?utf-8?B?c3U2SlpvTUd4NTVneERja05jblBIS212c29UdEpuUWZlQ2s1Q3dBRGM4MjJp?=
 =?utf-8?B?Z2JqZ0Z5Ym84MmZUaDBRMkM3SlpMOXVvQ3dEeVEyZ0ljVlA2WmtxdUtoZUox?=
 =?utf-8?B?S2djSzdyNDA4UkhKaEZva0wzS1RLT3BBaGZVVVJoaEhFR0dKSDc0cFFuczZM?=
 =?utf-8?B?RWVNMlIxNUJGV3BOa3RIcE9MMTdRNmFIYmdEZ2Q4WkFhV3lucnJOdENBTStj?=
 =?utf-8?B?WTMvUjNhMEZweWFVRExTeFltbDFFVmlTamkxbFp1eVZyRVF1bHRkbkZDcU4r?=
 =?utf-8?Q?yAWFS44ZBnp4VzMheM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abcac198-5a86-400d-8ae0-08ddca12c714
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 18:00:15.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8103

DQoNCj4gT24gMjMgSnVsIDIwMjUsIGF0IDExOjI24oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gRm9yIHNlbmQtZW1haWwgaW50ZWdyYXRpb24sIG1h
eWJlIGFkZCBhbm90aGVyIG9wdGlvbiBvdmVyIHRoZXJlIGFzIHdlbGw/DQo+IA0KPiBObywgbGV0
J3Mgc2NyYXAgdGhpcyBzdGVwLCBhcyBpdCByZXF1aXJlcyB3YXkgdG9vIG5ldyB2ZXJzaW9uIG9m
DQo+IGNVUkwuDQoNClllcyBJIGdvdCB0aGF0LiBCdHcsIHNvIEkganVzdCBrZWVwIHRoZSBpbmNv
bnNpc3RlbmN5IHRoYXQgT3BlblNTTCBtYXJrcyBpdCBhcyB1bnJlYWQgYW5kIGN1cmwgYXMgcmVh
ZCB0aGF0IHdheSwgb3IgbWFrZSBPcGVuU1NMIG1hcmsgaXQgYXMgcmVhZCAoaXQgZG9lc24ndCBu
ZWVkIGFueSBuZXcgYXBpKT8=
