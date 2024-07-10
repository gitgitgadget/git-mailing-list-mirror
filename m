Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2133.outbound.protection.outlook.com [40.107.241.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93934545
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632886; cv=fail; b=RI5OGJMLleHOiQdQrwd54pSSDOnLYNDeOv5dQJCTNLzeQyZLOCUE5Ch7KzmnJGQgQLL5lBoh0T8ve6efljKPW6oGciGgI+VQiqmljM7IV6acjxXee0tXYP8EY1H29nnUxG33e8rTgpYw7HxHJJSN+HNrQPSgdvK+1iQD7KQtDq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632886; c=relaxed/simple;
	bh=IJ2VzqgVRFq7U0dzgAFRS1PsSmafPX7WYoLKDdSFLTc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d5JqXNe1EDx4ZqpEKjdpPn1tEqfLha6sJYS2P4gKBsDED8oYAMyomSK6dqP1U+0uKXj/+AEJNYQjYBnscil32PYLVy0SjitgRQqQvqfkiRSZo1gF82al6Lt8pB23w0dCEGOYvJ5Xxl1xVmjP3OBWjdp0n6hgiApsvgugK24WyPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=envirovent.com; spf=pass smtp.mailfrom=envirovent.com; dkim=pass (1024-bit key) header.d=spvg.onmicrosoft.com header.i=@spvg.onmicrosoft.com header.b=YNxyJfPK; arc=fail smtp.client-ip=40.107.241.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=envirovent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envirovent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spvg.onmicrosoft.com header.i=@spvg.onmicrosoft.com header.b="YNxyJfPK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qo+D6ggWh1MoLcH/PVhmw8OHsik09da8OaFnhZd+zhnSPeJyfigH5ap2w2gUDlQj68mugZhRl168nRxR4aAl2rEh9RdIM5FuplVDWVqGFjIz1HkukUd3Ti8BTJ90ek/AZ5tweM2GzhU+9W8SPIcWYGSWvoMdbCVaaNT45lKUga/HXERRp4r1kSw+Tb8IoF8URSxCis2+kJKnVYe370wQj97GVccnDJoZWyE6Jau9O+/l5Hym/urNRxCnqRLgcL32KHV4KafUfO40se4z0zq9BFWF3LXmI3awW/HO7/NWPRGMRnUz1zxNTqA5SCt/s5bp6QNWhtfjyConzQJwXkGS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ2VzqgVRFq7U0dzgAFRS1PsSmafPX7WYoLKDdSFLTc=;
 b=kv0HGvK+GosCxsiZoQgpbiDA0LVtYqSxn4rPdD+hzH5ZVCYR3l9bfCxoTS+by+FT7jnQJy7clNiXw8viykgEhoLXj3KKw8eUnFkHng6HnuDGuoS4yh6b9OaO+3l0ixN5648/m/wWvD0loPX6CXmLAMQSAJMoPcNUOAzI2QC1IRUihMb3gNxyrE8tXaJz7hT8JW2qoi23ngO1cZZmqhJJE6PuNREgBDkPnNYFWq8suICz7Sp/IXSUxTxXXIuRlyOM7LteaViZNB2oCG8yrQcd2uerKijfiz57FOUqEljFR0z7wQbiDIiW1W5bx/Jxhz87cm8M8AmBVGyD0fHhmtVIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=envirovent.com; dmarc=pass action=none
 header.from=envirovent.com; dkim=pass header.d=envirovent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spvg.onmicrosoft.com;
 s=selector1-spvg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ2VzqgVRFq7U0dzgAFRS1PsSmafPX7WYoLKDdSFLTc=;
 b=YNxyJfPKCzDN8XAmhBbx4NYoWEqKCIajsXW8DNmF11iYZP7+CN4KrH9gSPQZ5u+eZn/3iNhUxPFeEBloso0ogk0J85ehlOwCB6sP6VjNa1Tdw8kN3f90vM4soYmjB3uuihSy0an77OLEZOdf+xgyEadlOvQcrDG+Go+aIbWaIkk=
Received: from DU0PR02MB9942.eurprd02.prod.outlook.com (2603:10a6:10:449::18)
 by GV1PR02MB10528.eurprd02.prod.outlook.com (2603:10a6:150:15e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 17:34:37 +0000
Received: from DU0PR02MB9942.eurprd02.prod.outlook.com
 ([fe80::baf3:8eac:68d8:5652]) by DU0PR02MB9942.eurprd02.prod.outlook.com
 ([fe80::baf3:8eac:68d8:5652%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 17:34:36 +0000
From: Adam Pickett <apickett@envirovent.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Git Update for Windows - Cloudflare Direct IP
Thread-Topic: Git Update for Windows - Cloudflare Direct IP
Thread-Index: AdrROEHkn/MB1lnUTc+FPo5r16SQYQASSBaAAFt8A2A=
Date: Wed, 10 Jul 2024 17:34:36 +0000
Message-ID:
 <DU0PR02MB99425B9202C3814BFB62413EA0A42@DU0PR02MB9942.eurprd02.prod.outlook.com>
References:
 <DU0PR02MB9942C645E78AC23619F05D0CA0DA2@DU0PR02MB9942.eurprd02.prod.outlook.com>
 <ZoxgCya4xt5JuLJP@tapette.crustytoothpaste.net>
In-Reply-To: <ZoxgCya4xt5JuLJP@tapette.crustytoothpaste.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=envirovent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR02MB9942:EE_|GV1PR02MB10528:EE_
x-ms-office365-filtering-correlation-id: 4610b937-694f-4a5a-7b4b-08dca106917a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWN4R2tSQnpQT2tXT3EzbzlaZ1pYblFQVERCNkVac1RwN1dTL0lVeWdmcGFr?=
 =?utf-8?B?bDVjRU80djd0TnBlWXY4a0tQVHRxbk1uV25jVFUvc01vQmh2dlM2WHFvZUZ3?=
 =?utf-8?B?azZtR2ZpamloUUk1amhzbUt4MENqejJ6cXhxVjR0UG9oUmNiSTQ2NEpxam5J?=
 =?utf-8?B?TW1LaEgveWFRdHZUM3IvQWI4TlNEbWFpTzhDWjcveEpQWTFkcDZpSktUU1pX?=
 =?utf-8?B?UEZPVXpPaS9QMWtxaW9peHVtZDRaWTNkMjBJOXhhYVR1UlZoZ2tpenA3Um13?=
 =?utf-8?B?aVB2N2srWGtGenYzSXNSMmNqejdQbDBqME9laU9WL3NhOUtMREZOTFFlQ2tJ?=
 =?utf-8?B?UjdwU0FxeW5ibDBZUWFEaUtPSUFVc2gzd1lHNyt2SVowQVdOZ3FqOFZxQXFY?=
 =?utf-8?B?c0RLb25yT1FmNk1waXFxR0F0d0w4Q25HTzg0SVFvLyt4VGllcDBYTVp6a2Ra?=
 =?utf-8?B?Q0ZLTGFjQ0ZQTEJrRjlhK3hjRmtRQzh5bW9ZcTFYWXRERTNVTWdvbGtkbE1w?=
 =?utf-8?B?TGhkVmF1YWhkU1ZHSlNVYXl3VExOd0YrQXN5dUlibVpqSThMZnA2N1d1NWlV?=
 =?utf-8?B?NXVPakhwczBJVnJMR3k2UnN0YkxZUVNYODZiUi9vRDZ3OGR1UXIrdENydUNX?=
 =?utf-8?B?MGU1VFY5YWRraHF4aWNaMExERnQyU3VzVW9XWlNnTS9vQTgzWGgxZ0djODRI?=
 =?utf-8?B?SjZGc2VYV1VKWW9ESWJXZFFmVzBrdnlMUkZaZ092Y1NNS2lseXd3S0txdXFV?=
 =?utf-8?B?eERMVjczRXdobzhlQnpySjF3WkZaUVZkZkFRa25GUmgyaHBaR1dseFBLZy84?=
 =?utf-8?B?NHNkR04rRHBMMllTbDJCeXhKaE9yaW1YODNvSVJPRnRHV0lua1pBbHdYazlX?=
 =?utf-8?B?RXZ1Zi9mRFprcGNpa1M3NS9vUXQwVFVpUnZCc1NnU3RjWFN0MEd0QTEzcDZa?=
 =?utf-8?B?WExVR0hFWnVJcExNbUY1UnZQYjIyRGdDajJPR1NDUWFrQUFEamJsQ3lBbVRP?=
 =?utf-8?B?UjVrQVJPNks5UlYwaWVjdXZxZ3Bqc0cweksxOVVHTDF0Z3doMWZHQnB2d1dP?=
 =?utf-8?B?S2RXSldPdWQyMGE5OTFxYU8xY09zUW1CN2QrRE1qN2cyNmV5OHJ3MDRIWWZQ?=
 =?utf-8?B?cDF5ZER4L0tZUWVjQzBtM2N5SlV1SStseWhFYWYwTVNXMWNGUVo1di9WOWtZ?=
 =?utf-8?B?VEJ5WVRVTDZwK0wvZWFyKzhjZkVqbTZpNVVnREwxNEhuYVdjekNEVHQ3WnZM?=
 =?utf-8?B?U0gwS1JkU2RMU1FoSlYwZnkvVU5IZmY0U3QvQTIxUDVleWtMZXhSSGVMbGFL?=
 =?utf-8?B?VEEvQXM5Z252eUNqZHgzaVo2OEVzYk5SRzdMSUNsMGVaUmhGeGJTakdIbTlW?=
 =?utf-8?B?WjRMWHFSQUdLT1E1Tm1EL1NEUHpxb0NaTTkybHVJN09hL0w4Q2dQb3hXRVhM?=
 =?utf-8?B?blJuMU91YVpncldOb3FOUU5KZ0FEUjZZaDVNT0JCTzRkeUxnOWQvYXhSRk1y?=
 =?utf-8?B?TURnWWhURThXRmR0MjBDUkxMRldzOE8zRSs3cm9WeU8zdXd5Ty92V1p1MFIw?=
 =?utf-8?B?ZHJaRWw0VE9jaXpaeGRCLzFNekY2SnhVbGk1NFduWFdFTTI4bHlGT0FUNThj?=
 =?utf-8?B?ZEg4Q0pkVHNIU2FlL3BjRFhINHJ1UjhmR01MSmovamZlUnVWYWZIdm44eEdU?=
 =?utf-8?B?djljeEZaTlpjWXlSMzVvN1JhOTdGNThLTXlWaEdPbmdQUW5IeGduNDNtKzho?=
 =?utf-8?B?QjhZSThhTWdNem5vRkNXV3hFa3ZodWloU3F0c0Q4amRtNmtkRTUwTzlqMWF4?=
 =?utf-8?Q?5K6iQ/+1ECFLO5BnqHOaDURcHmvmhhyX9iObk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9942.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnlmV2pIakIwM3UyOU1ZR3FvTmVUZmZqVkJmeFFMM1dDdlBMSWNUNVVHMXBl?=
 =?utf-8?B?ZjM4VlhYZE9kQkxPYkVZSFQ5bjRkd1piOGt2N25UWmtCTGI3NGF0SXZ2Vnd4?=
 =?utf-8?B?SXd1MmJCNnQ1MTViU25oVzBzc1VyaFY1R3pveTdIM2w0bWQ0Zzg4N1FrNU4r?=
 =?utf-8?B?Z2p5WStPRWZhc1J5STF1ckdGakhiYzVUU0IyQUI5aEJCMkgxdWczUEJQM3hQ?=
 =?utf-8?B?TVp3SlIyRktjOHhqTEMzZGI4OS84YmU4czZ0T3FsMWVaeEI5V2czR3d5STUw?=
 =?utf-8?B?ZUhqZ2VQRzl5eEtETzlLSmJ6a2VDTVRHVU41TzJFb01EUWNxWnNUZWc3QXpp?=
 =?utf-8?B?dlZkSEhWM2NuYllNNTEyZGlEN0ZmMW9VaWpKNVF4YU81aUpUajdKWXFPTlI3?=
 =?utf-8?B?alFGTXVQMmxwNmFnREhCZVFvWlZISVk2R1hyNVZLazNHQXFKZSt5a29TNTRL?=
 =?utf-8?B?dUZIQU1TbTNjN1NHTEhyZHVRU0w4eTFMYkJHc05oMS9ZR3A0bEl5MzQ5eGZ4?=
 =?utf-8?B?S3JPZG5kWnBUb0pPVWFFR0J0SmhESTBPd1pCQzVpZ3ZZRVBZQi91MktQdDRX?=
 =?utf-8?B?M0ltN2tRaXlBbjNaRnQyS1ZVMkpacjRoeHpKK0liSzVCWUQycXExZ1hLeXZs?=
 =?utf-8?B?Tmg1bmNTS2dkdWUxbmdYTzNvck1HQzJyQ1pLSjY5THZqUldaRDNZcjJZYWdy?=
 =?utf-8?B?cnBXZUZ5bnYxcXE0L2w2KytRR3BRbDJxQ2dHSzJmOUp1ZHFiVVlpTWxFREF6?=
 =?utf-8?B?VVV6T3haT2wycUpOaXViVkpTTGdJc0tvY1BVSXY3UXV3cVhzV3BCZDVDQW5n?=
 =?utf-8?B?MjBnZ0dnQVZQeTRVRThFUXh2UUhZY1hoNHpKRERRYStGaGhFQlVpSlQzNkI0?=
 =?utf-8?B?UlU5ZUxJdlVNSzIvN3ZvMnQzSi9xTUdKS1NrNjFka1VybEJ3dzhnTnhhRmFs?=
 =?utf-8?B?TVV6RVBhT0Y4UzJJeWVPVmYxQzJhMmFrb0VmUlh5cGJ4d0U5RnpjeDV0bU9Y?=
 =?utf-8?B?OHEvMTFROUpDN1V4Z1RTOVFNTkhTeG5nN1hJSk42UEpPbDRkM0E2UmgvVVF3?=
 =?utf-8?B?WHJDb3V3VGUwV2NYR0x3amZqSWJxL3J0VEdMYmd5cXBtbkFvbjBiYlQxOTY5?=
 =?utf-8?B?NXdETXYyQ1dCZUpMRU5FYmFMNkE1WTJmV2ppa0ZNSmdKd09BV3l3VFFabmg2?=
 =?utf-8?B?R2dtcHlpQURaaVBPL1BnM01rdExQOEpsRTdaOGhEZTFPVWpabGFMSWw3K2No?=
 =?utf-8?B?b2pORkIyeWxqNVpPbUs5U0NKRk9yWGs3MHRhSlRzOWF0YWNUejh5eFo5VVhl?=
 =?utf-8?B?djdRdWVpbU1obmRZcHB0UFlzTVEzajQwaHdnc1VjZmdjVXdDNzJFMWxpTm0z?=
 =?utf-8?B?VExpVkdNVjlmREY4VmlaVklTUUxnOXZIRHlUZ1FsTHZ0dUJEOHAxSG1ZSmxH?=
 =?utf-8?B?eFVzYko3bHhxZjZGdjFla3JNdUxCK3RlYkh5WVNQUkFYcG5uWUo2Y1hLdmkz?=
 =?utf-8?B?QzhtMzNaNk9QODdsMHM1M0xoT2xVRGFPaG5TQ0h5SHZPWVJWS01rcmtxR0Fw?=
 =?utf-8?B?SzVORWI3UWZEY0wrTEpjNDZpbkR4YllQT2R1NmMxT3RxKzltQ2RqL0JTV2hH?=
 =?utf-8?B?N3N4U1hzR3dEWWdudzYxYmxHWFR1cW0xNVBYZWcxN1ZOWE9pdThIZURSVDBE?=
 =?utf-8?B?eXBTNzhvVE9UNzMxaXY0Zm5CdFdOWllNUS83aDZLK2E5NkdpOXNFMHNhVllV?=
 =?utf-8?B?YUVxMFNGVHVHWXVYeTczVlZ3c1pVOTJhRWcwWWw4dmxaSTVyd1NlTTl6S1Nv?=
 =?utf-8?B?azhkNnJwaFoxa0lhUGs4VkxBbmo1MzdCWVpzZ3FQY3hWdnpkaWZkVnhYaWw2?=
 =?utf-8?B?Sk9oZzFwN0FPTUFsSStFTWRJWjBQVkZUZHRQamFtZDl3WmZuWG5rWUdyWHBM?=
 =?utf-8?B?WDRvck92N1hmMmhqWVJORkRnZllsbDJZSWpTeStWSHBhMmR3cWVzRjBlYng5?=
 =?utf-8?B?cW52N3l1QUxJS21tTmZ6QUFFMVNHTVVTOFZnWm42L0N3RytUM1BuV3BDOS9V?=
 =?utf-8?B?clJYQTVJQjJJbGErT2FxbThsaC9lK3ExL3doRDBKTmswTEMxM1E5T2dKSytu?=
 =?utf-8?Q?kx7ezLjAE5KHDkzPrMqXraaYl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: envirovent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9942.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4610b937-694f-4a5a-7b4b-08dca106917a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 17:34:36.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 89f218fb-501e-4768-9b1f-d1fc4a69cb9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqRYwK+2n1NrZiT9GmUJs4UhpTS5W3fFJAWB0nOSvZjRc8xecNryWnvJdDEDkD+54sqzZxTb8M9lTxily26G1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10528

VGhhbmsgeW91LCBJIHdpbGwgZm9sbG93IHRoaXMgdXAgZnVydGhlciB3aXRoIHRoZW0gcHJpb3Ig
dG8gcmVwb3J0aW5nIG92ZXIgdGhlcmUuDQoNCktpbmQgUmVnYXJkcw0KDQpBZGFtIFBpY2tldHQN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGJyaWFuIG0uIGNhcmxzb24gPHNh
bmRhbHNAY3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IA0KU2VudDogTW9uZGF5LCBKdWx5IDgsIDIwMjQg
MTA6NTQgUE0NClRvOiBBZGFtIFBpY2tldHQgPGFwaWNrZXR0QGVudmlyb3ZlbnQuY29tPg0KQ2M6
IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBHaXQgVXBkYXRlIGZvciBXaW5kb3dz
IC0gQ2xvdWRmbGFyZSBEaXJlY3QgSVANCg0KT24gMjAyNC0wNy0wOCBhdCAxMzoyMDoxMiwgQWRh
bSBQaWNrZXR0IHdyb3RlOg0KPiBIZWxsbyBFdmVyeW9uZSwNCj4gDQo+IEknbSBoYXZpbmcgYW4g
aXNzdWUgcnVubmluZyAnZ2l0IHVwZGF0ZS1naXQtZm9yLXdpbmRvd3MnDQo+IA0KPiBJIGdldCB0
aGUgZm9sbG93aW5nIGVycm9yOyBjdXJsOiAoMzUpIFJlY3YgZmFpbHVyZTogQ29ubmVjdGlvbiB3
YXMgcmVzZXQuDQo+IA0KPiBXaGVuIHNwZWFraW5nIHRvIG15IG5ldHdvcmsgdGVhbSB0aGF0IGhh
dmUgYWR2aXNlZCB0aGF0IHRoZXkgYXJlIHNlZWluZyBhbmQgZXJyb3IgZnJvbSBDbG91ZGZsYXJl
Lg0KPiANCj4gRXJyb3IgMTAwMyAtIERpcmVjdCBJUCBhY2Nlc3Mgbm90IGFsbG93ZWQgQSB2YWxp
ZCBob3N0IGhlYWRlciBtdXN0IGJlIA0KPiBzdXBwbGllZCB0byByZWFjaCB0aGUgZGVzaXJlZCB3
ZWJzaXRlLg0KPiAxNzIuNjcuMTIuMTcyDQo+IA0KPiBDYW4gYW55b25lIGNvbmZpcm0gaWYgdGhp
cyBpcyBhIGdlbmVyYWwgaXNzdWUgb3IgbGltaXRlZCB0byBvdXIgbmV0d29yay4NCg0KSXQgc291
bmRzIGxpa2UgeW91J3JlIHdyaXRpbmcgYWJvdXQgR2l0IGZvciBXaW5kb3dzLCB3aGljaCBpcyBt
YWludGFpbmVkIHNlcGFyYXRlbHkgYXQgaHR0cHM6Ly9naXRodWIuY29tL2dpdC1mb3Itd2luZG93
cy9naXQvLiAgWW91J2QgcHJvYmFibHkgd2FudCB0byByZXBvcnQgdGhpcyB0aGVyZSwgc2luY2Ug
dGhlIHV0aWxpdHkgeW91J3JlIGRlc2NyaWJpbmcgaXNuJ3QgYSBwYXJ0IG9mIGNvcmUgR2l0Lg0K
DQpJIHdpbGwganVzdCBzYXkgdGhhdCBpdCBzb3VuZHMgbGlrZSB5b3UgaGF2ZSBzb21lIHNvcnQg
b2YgY29ycG9yYXRlIHByb3h5IHdoaWNoIGlzIGludGVyY2VwdGluZyBhbmQgdGFtcGVyaW5nIHdp
dGggdGhlIHJlcXVlc3QsIGJlY2F1c2UgSSdtIHByZXR0eSBzdXJlIEdpdCBmb3IgV2luZG93cyBp
cyB1c2luZyBUTFMgZm9yIHVwZGF0ZXMgYW5kIHRoZXJlZm9yZSBtdXN0IGhhdmUgcHJvdmlkZWQg
YSB2YWxpZCBkb21haW4gdG8gY3VybC4gIElmIHNvLCB5b3UnbGwgd2FudCB0byB0cnkgd2l0aG91
dCB0aGF0IHByb3h5IGZpcnN0LCBzaW5jZSBpZiBpdCBfaXNfIHRoZSBjYXVzZSwgb2J2aW91c2x5
IHRoZSBHaXQgZm9yIFdpbmRvd3MgcHJvamVjdCB3b24ndCBiZSBhYmxlIHRvIGZpeCBpdC4NCi0t
DQpicmlhbiBtLiBjYXJsc29uICh0aGV5L3RoZW0gb3IgaGUvaGltKQ0KVG9yb250bywgT250YXJp
bywgQ0ENCg==
