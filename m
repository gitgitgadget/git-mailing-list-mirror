Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B2EEBB
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453820; cv=fail; b=tNZHaXTfMT10jdGckef7lpkojm4r/mYTf54gJHeNPtcpVkBrvY2fWuamLrcDS9vxf+qPrngGWF6GHCayOGULZUx8zbxvqXR8b+xoZUAKyhTjQvlu92QCeqRq06X+SMYqZwg/ctxcVvwbcDd4PZlexdEb/88/c/MWmvoHmhpj9KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453820; c=relaxed/simple;
	bh=l+SoFb312Sk+RWXoMNAKR+ic6NVqgrhYcFzbVTJuW0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFAJUvuEYQE1KE8VFScxTearGjKDcE68fvWwsDxBogxeDJbWRM5dpSibji4xpcUhekJg7v+RHEHws/L/KlHwAqifocTiWIZJUNwXUUa1+SsvUupUM+/eZIMGjtWOvNLscACiasdrT1a7LulChxbEhutFwIegXI58lMKX66AzXcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UerjA19h; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UerjA19h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5by+6TbDmQUX3OMkBIge/Su5lEZ/+HEx4xczSdgdBWw4b4n39W1GZs7nNdHBQluYDK0oRsHKXEsta2TBAAaFpi/EhzrPY6n4nnsryu48wtKr+t4Ik7Hyyc5nRmHwMhoHhgKXjE/sdDqlPlee1LLUJEmYHpSJ/OQsFaDc9IPEEt+ThSb86oYGZV5zklAj3hO2LNQtzhGuoNPLZOoRNH46el58LH92+EPQLVcoGtT+dRvVgQyEODPIpnIswZhokIZaA7K8GdWnxEuo+OtJF/VUkxqi+G7rHQwtWGOB9PVZdxIhiX+w4PkWlLbuTCgxyDdWXVbncg0wz3JWLsF4UpxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+SoFb312Sk+RWXoMNAKR+ic6NVqgrhYcFzbVTJuW0E=;
 b=xQnVMEV7NTCaY/22tsR4P6jykHeTTE2GbQYTp/6rbA5Kc/ZY4YqygdmnArIiFSbQI+PgXPQJJK6IL5T4OPk0HbbQChpC06udl1zb4mfSlcvDrDuwu2fiVD4S/PT+YKJf9G6FAoFotNOej6iY1GGyReKqUefmOPMQJNpBhR27wnCn56o1+5lWnQarDg2er68Hw3J6yVlVKK0YH8paF7J7fKs9mAxRYIHA07ESgMzYPGfnlSgZsEWsOU2xgfECog4/AqWV/TLQ/Rg5mkYYC1neTmjsMHvsYXmR+zJjQsD7L75y7AxrAd0RxFPr0w9TPCicL1ns3HbqUpj7V5Ah44gQtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+SoFb312Sk+RWXoMNAKR+ic6NVqgrhYcFzbVTJuW0E=;
 b=UerjA19hDYdImyx/xtbI1f5+8ZJFLEyhzO8QsmV9rEJfdUG9Y3ISW+Y308FfqpP2vzV+Jsx7mkluvlinJUOdsqMXi6BUi4gcU7546b8mmM6AtBJEokTdzpaovKns4/6DlSofO3paX2rej2QTR9TiRuYRknozBY3wvnzF9ndjATj55d3IU7LB22UJZ2GDxX1uybZq6FKh/OtxxBbV1ihyAfFNFfYqaFZ1dxtZ0OTy6zLppSABKk5xYfP0wqYYU6sVdFclyXkUFbVlMEICLgpeP+DaprD5yv0QiiowCYeaAJzL2xtUpaTQfYDp06vEoJtWQ4YTA8d1lgROVguPNU5v/g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:23:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:23:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v15 00/10] imap-send: make it usable again and add
 OAuth2.0 support
Thread-Topic: [PATCH v15 00/10] imap-send: make it usable again and add
 OAuth2.0 support
Thread-Index: AQHb2GQT1okuaSGNX0Km4V8Q6U7Ls7P5vU1AgACwukU=
Date: Mon, 9 Jun 2025 07:23:34 +0000
Message-ID:
 <PN3PR01MB9597614BED5F4940D1B807DDB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqcybevtxw.fsf@gitster.g>
In-Reply-To: <xmqqcybevtxw.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
x-ms-office365-filtering-correlation-id: c4a28894-7701-457a-c48b-08dda7268b42
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|6072599003|15080799009|7092599006|8060799009|8062599006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFF1YndEZGRFVTliU0F1Sm1RSEZhZzBPMzJsazJobEZsQS9aeG8xVDIyVXQw?=
 =?utf-8?B?Z3dXNGdKdTE3NFlKUXNsRkhGSzJqcVZ6ZTRIdDBnMlNhWUxHZEtocGtrcGo4?=
 =?utf-8?B?UkhRQ3E1VCt0UThkWmVnNGdUeHZ5ZjMxRXhndFRSMjF0Z3FDMlpwU0Z5RG85?=
 =?utf-8?B?SXhGM1hQWkdzMUFWdk1oUDhiZTBIOXo5MExkVHVnb3pZNzd2ZWtGcTgzUHEw?=
 =?utf-8?B?ZFhxdGVLVTh4V0M0VGFnTEVnamN3NEJiSVhnTGRobXM0d1lpOUE5MTRoN2o5?=
 =?utf-8?B?L2hqWHMxZmR3eVlvc1hJUGYwT3RTMnp0WW1kUVBHYkhCN1RJTXJiZjZvQXpr?=
 =?utf-8?B?RGlESmVPWXA1bHA3WlZndVpPaXBDejBjZ2F2MnBDNGR4QTJWL3orc1Zsc081?=
 =?utf-8?B?YnlJRjhEU3ZCUEI2YlQwZ2tDSmRINm5GTU1pdXBFQmRuQzRDZmlHNGNDMDVK?=
 =?utf-8?B?YWhVMlhyN0ZmcDE5K3QvSFdrVXJLd3Mzam8rRWdsbGtFSDNkbWE0T1FzaHlB?=
 =?utf-8?B?TEM2blBmUUFqTlVsZHdoTlBtY05KKzgxSS9lQnl5c3pRRjV2MWVheStuSHRV?=
 =?utf-8?B?QVpMVE1samtYbTRiWTdWak9lbHNHZnFLdVl6UFNFdkRKTUh1MTg5YlRMWXBo?=
 =?utf-8?B?NEVEK3Q1ejQvcWZlM2h1bEtMZS9jTmcrSDZrNW5BWVhad0FiQ3hYakNzb0ZV?=
 =?utf-8?B?R1JZaDJDU3o0MThJOEduNXY5OEZkQmYxd2Zlakx4eGt4KzJHdUNHVGlZT2pI?=
 =?utf-8?B?Z2x6V1NpQm9QTFhoZkRPdXp1ei9DbytZcDNENmxLTkVET2JVVEhvMDRUbnpW?=
 =?utf-8?B?K1dqcVJxQ3YrOWVGUW9Qc1ZURFc3UHhTZERMdngxZkdMTkVTdUR2Nk5uVzRo?=
 =?utf-8?B?RDFuYWdTSUY3T2dabENrTzRwdXVuaGtEdUxwcnJkUnBHWGZ4Q3pnVE1zV281?=
 =?utf-8?B?dDduWElsY2M4ZVBSWkMwNkQvQVNiSkl2RGhSVXQ4YitNZVBNQ0UzeWJPMzkv?=
 =?utf-8?B?SFFIOVU4c3gwMWJZcWlqQmxwZnM1Q2srUEc3anFUTmlRWTVwc1NrTWRSWnB1?=
 =?utf-8?B?YzIyUWVPRnJoZm1RbGw5R29TT2VUUEhIWmozaTRqbkJMYkhHdFB1S2lOTWxv?=
 =?utf-8?B?Z01YN1A4VzV3OVAwNGlzQmM2NER6clNtUy9nZm82ZExFVkYrK3AzaHFWTVRJ?=
 =?utf-8?B?U3hGY1BSaXAwMFNMZE5pMnlybXROWGQ3UTdHcWNWNGR6NmoxUlNaekZ6bnNT?=
 =?utf-8?B?V0FiWlJKVCtMZ1FyeFVtZTNyMnQveVNlUFlQUTJZeXJBYUFRL2dhRnVmS1Ez?=
 =?utf-8?B?YlV6Z1pJczdSWmtXMGlPcHBoN1d6dEF3c0h6RVpLaVVwZGdSaHdsQlhrZDI3?=
 =?utf-8?B?RkxIK3d6ZWtTVlFRYUMwTGVlSzUzZ3BqbHZ6RHZpdEtDb3h3b2FOak01T0Na?=
 =?utf-8?B?ZEJDYy9SNmdkei9DeWEvdjBKQ0FrL2NrNHdpOWlSU2tsdGZQbk9YREZPNTVy?=
 =?utf-8?B?eFhGNHhqZE0wMHBwWXVHZ0ltNWU5ZUZLN1daSzRSMUhzVXpkUUxEWFlVNEVi?=
 =?utf-8?B?RTYrdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnlYZDR6WU9BZS9LUW44S2hQV2VmWjJhQlZKMGNiVGM1SytqeDR3MVNBM3hj?=
 =?utf-8?B?eFh6b2cvM2NXTGVZRjZ5UXUwaEhYaEFSRnJnL2FlT3ZFUGdsTXdOUTRhVjBR?=
 =?utf-8?B?T05TcHlQWkRmZXFZQzNOTnI2Mm1OQmdscDlSS1h1bVZkalV3Y0tLMlhZazZP?=
 =?utf-8?B?OENPb0ZmNFIzQjhMa01mWGZEUCtPMmhab1Z2WUNHZjMyeTcvVk9rQWpmSTkv?=
 =?utf-8?B?OVJlUFZYNjJCdndIQmhybmdIUm4xaldrS05ZL1pwMUVqSEYzNklVRVZ0RFNu?=
 =?utf-8?B?T3owZDF2bTY0YnpWSm1lL2FZUGRzVmxTUXExdTdrb0NSUzJXQW5pdDlyTmd5?=
 =?utf-8?B?d0c0NnptQTVqNmxkQmRVUzJDZmtUS2ZRek5Vd2pVN2NtczhGVGtOUGxqQzJQ?=
 =?utf-8?B?MlBXaGtzWTM5TXI5RDdwUGdDZXZUdEM3VmtISmNEZlEwTzVsTEJyU1hhRjZa?=
 =?utf-8?B?cGdOaTNuY0JBb2QxM2J5MjVhakdqb0xRRlk2V3p4SC8yWU5Qa2NoRHFRa0NC?=
 =?utf-8?B?VndKREcvZElPTjVna3MrVEZjU3NjT1Q2NmxFRnJld1lZNDgzWWFIRUhZMnJL?=
 =?utf-8?B?MFA5Zk1Mc0xINUxhaGtONTVoeFNINUVJNm9GRDNPUzduNUJabUJBb2RIME82?=
 =?utf-8?B?OC9reEgzaHp0ajVPa3hkWlhJR2p2dmFUWW94SWxxWjI0bW5hVTJhOUovSTRO?=
 =?utf-8?B?Zkt4dk5qMjMvL0V1ZGc1bzYzRXo2YVB2YzNXajVxNFVRODZYODJTMEU5Ry9C?=
 =?utf-8?B?aTNKMkxuNlRFUjRuemwwWmpKMW9SdWhGUHd6WUhGaEx6UnFhSGdhSklGUURM?=
 =?utf-8?B?MHp0eUdZUmRIbkhNQno0ZWFPS0YxMWg2QTl5czgzUzgyaWhqeWFRR0NjNkhK?=
 =?utf-8?B?MElqK1BKcDF2NTJDR3VwU0l6OUJpaHlCcnJUQ3hpSTZacXdTaU1DbEl6OElp?=
 =?utf-8?B?TWhRc2kzYVlqMGpQWXdvVXMxd2R0QzZHQXNFNUtoVnpRSStFZUNibDk0OHQ0?=
 =?utf-8?B?MjdNeW5LMXRUZTFzRzJCQU5GRTlleTVBQzZpVXNMUTFoSW93T0gzVXUzSDRT?=
 =?utf-8?B?TUNHREp2VGpWdEMzVk9ac3N2VVdZK2V4YzJMWXVFblJYTXhGWTNkMUc4YVlS?=
 =?utf-8?B?M2pCTlp1Wi9ndzFSUjdXbTV2V1hoRE41S1NTSWU1U1d1S3NOMFEzcmJrTTJo?=
 =?utf-8?B?Tm9GYlpEMENKcWd0SlhmOW5hYWMxM0huc1V0a3E3bmdmYVhYSGJabTFGV1dp?=
 =?utf-8?B?cEdobUJEVi9FS2RRL2gwKzd4MnFWY2VLN0Nzc21Gc1o4aFoxOTRDRk1mN21O?=
 =?utf-8?B?QnNPUDN4WEJvVmFldk5UQThINXhyWVJxdzF1QWhBUjViNHI5MUwxV3hsaHBZ?=
 =?utf-8?B?ZE1zNWVQUkUvQ0lJU0ZDRlBkOG1vUm4xQ1FpM2orZEllcGcwUVNKVDJxSGh1?=
 =?utf-8?B?Y09PVzJORmFoMFFWd2VPSTNDZEN3S09NZFFFcmpJaDdPMDZiOEJXbnhrOU80?=
 =?utf-8?B?K2ptMXppMGJTSFR6eU5FempOYTJTQkdBV0MyelhSeHdhYm9BNCswRXpVQ28r?=
 =?utf-8?B?czhqdU1YVlJBNkVVVTVnY3d0QkZ5RUNtZ3ZvZXlOTEZGL1JTa25CSGVJV25w?=
 =?utf-8?B?OGVCeDJqcUJVWjlnaHlqdnY0YnZDTldQM0xGVkZiUW9XNWI5UmZVRThjOW1J?=
 =?utf-8?B?M2VXWWxYdDJnTDVFZmpPbEM2dkwzWWZrUW5EQjRQMnM4VmZCOVJ4YlVlSm9T?=
 =?utf-8?Q?wJTS0hEfr8uNK5hIjU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a28894-7701-457a-c48b-08dda7268b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 07:23:34.2989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

DQoNCj4gT24gOSBKdW4gMjAyNSwgYXQgMjoyMeKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IEFkaXR5YSBHYXJnICgxMCk6DQo+PiAgaW1hcC1zZW5k
OiBmaXggYnVnIGNhdXNpbmcgY2ZnLT5mb2xkZXIgYmVpbmcgc2V0IHRvIE5VTEwNCj4+ICBpbWFw
LXNlbmQ6IGZpeCBtZW1vcnkgbGVhayBpbiBjYXNlIGF1dGhfY3JhbV9tZDUgZmFpbHMNCj4+ICBp
bWFwLXNlbmQ6IGdyYWNlZnVsbHkgZmFpbCBpZiBDUkFNLU1ENSBhdXRoZW50aWNhdGlvbiBpcyBy
ZXF1ZXN0ZWQNCj4+ICAgIHdpdGhvdXQgT3BlblNTTA0KPj4gIGltYXAtc2VuZDogYWRkIHN1cHBv
cnQgZm9yIE9BdXRoMi4wIGF1dGhlbnRpY2F0aW9uDQo+PiAgaW1hcC1zZW5kOiBhZGQgUExBSU4g
YXV0aGVudGljYXRpb24gbWV0aG9kIHRvIE9wZW5TU0wNCj4+ICBpbWFwLXNlbmQ6IGVuYWJsZSBz
cGVjaWZ5aW5nIHRoZSBmb2xkZXIgdXNpbmcgdGhlIGNvbW1hbmQgbGluZQ0KPj4gIGltYXAtc2Vu
ZDogZml4IG1pbm9yIG1pc3Rha2VzIGluIHRoZSBsb2dzDQo+PiAgaW1hcC1zZW5kOiBkaXNwbGF5
IHBvcnQgYWxvbmd3aXRoIGhvc3Qgd2hlbiBnaXQgY3JlZGVudGlhbCBpcyBpbnZva2VkDQo+PiAg
aW1hcC1zZW5kOiBkaXNwbGF5IHRoZSBkZXN0aW5hdGlvbiBtYWlsYm94IHdoZW4gc2VuZGluZyBh
IG1lc3NhZ2UNCj4+ICBpbWFwLXNlbmQ6IGFkZCBhYmlsaXR5IHRvIGxpc3QgdGhlIGF2YWlsYWJs
ZSBmb2xkZXJzDQo+IA0KPiBWZXJ5IG5pY2VseSBvcmdhbml6ZWQsIHN0YXJ0aW5nIGZyb20gb2J2
aW91cyBmaXhlcyBhbmQgdXNhYmlsaXR5DQo+IHBvbGlzaGluZyBhdCB0aGUgYmVnaW5uaW5nIG9m
IHRoZSBzZXJpZXMsIGZvbGxvd2VkIGJ5IGZlYXR1cmUNCj4gZW5oYW5jZW1lbnRzIHRvIGFkZCBu
ZXcgdmFyaWFudHMgdG8gdGhlIGV4aXN0aW5nIGZyYW1ld29yaywgZm9sbG93ZWQNCj4gYnkgdGhy
ZWUgbmV3IGZlYXR1cmVzLiAgVGhlICJvayItPiJPSyIgY2hhbmdlIHNlZW1zIHNvbWV3aGF0IG91
dCBvZg0KPiBwbGFjZSAoSSB3b3VsZCBoYXZlIGRvbmUgaXQgZWFybHkgaWYgdGhlIGNoYW5nZXMg
YXJlIG5vdCBjb250cm92ZXJzaWFsLA0KPiBvciB2ZXJ5IGxhdGUgYWZ0ZXIgdGhlIHNlcmllcyBp
ZiB0aGUgY2hhbmdlcyBsb29rZWQgbWVyZWx5IHN1YmplY3RpdmUsDQo+IGFuZCBub3QgaW4gdGhl
IG1pZGRsZSBlaXRoZXIgY2FzZSksIGJ1dCBvdGhlciB0aGFuIHRoYXQgdGhlIHNlcmllcyBpcw0K
PiBub3cgb3JnYW5pemVkIHBlcmZlY3RseS4NCj4gDQoNCkZpeGVkIGluIHYxNg0KDQo+IEkgdGhp
bmsgdGhlICJmaXhlcyIgYW5kICJhdXRoIG1ldGhvZCBlbmhhbmNlbWVudHMiIGluIHRoZSBlYXJs
aWVyDQo+IHBhcnQgYXJlIHRoZSBzYW1lIGFzIGJlZm9yZSBhbmQgSSB3YXMgaGFwcHkgd2l0aCB0
aGUgcmVzdWx0aW5nIGNvZGUuDQo+IA0KPiBJIGRpZG4ndCBzZXJpb3VzbHkgcmVhZCB0aGUgbGFz
dCB0aHJlZSBvciBmb3VyIHBhdGNoZXMgZHVyaW5nIHRoZQ0KPiBwcmV2aW91cyByb3VuZCwgc28g
SSB3b3VsZCBzYXkgdGhleSBzdGlsbCBuZWVkIHJldmlld3MsIGJ1dCB0aGUNCj4gZWFybHkgcGFy
dCBvZiB0aGUgc2VyaWVzIG5vdyBsb29rcyB2ZXJ5IHdlbGwuDQo+IA0KPiBUaGFua3MuDQo+IA0K
