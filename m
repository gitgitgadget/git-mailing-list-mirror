Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010003.outbound.protection.outlook.com [52.103.68.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B20247289
	for <git@vger.kernel.org>; Tue,  6 May 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524113; cv=fail; b=CjQgqo5tVr84BFpguk7Gg2sWrjjcGzD10frg6LtziNZugWJ76aUPPop1iw3gqJVg36nEGzontt2wpMdWFDtBdC6weFYPqzct+nfa9C/sSvrySnPf5OJse3dIWIvodHWt4xs4grFLZ4norTPIKEzn1gkBGgseTNgOnsRxCFV66Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524113; c=relaxed/simple;
	bh=Aa5XHdikyF/OoL8rjwYr9C/iw8AOpH766A9gBD4gJTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=urVXctDRGElBEUZd58HqBopqDPmJv29vHUpVssLnfJ3mh8G2bRXfqE9zlpCaxHbQSxXLJ+yZ72yyXuxfM3kkTsy2gWUH77cmSPS/IQq5RjRoQGMiE2kmcUNWmSn6vUPwa+6E5/TM2Z8T1nJI77YGzqS3Qte0UIoFgWeJThL+HeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JWSOn918; arc=fail smtp.client-ip=52.103.68.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JWSOn918"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mhp/ACMUt8fXKWiKIodjhsPB8/jMm+IOfWgSZA35fb2MSgKLlxtpBJ6CGDnV6TNfLtfyBCtc++kWS2SvKpmvFJTCsRsurEAEhUHwLFfNObnhLEmgFL3q7ciKhe3QSaw6z5qbA3qtAu04+OeEvMX+sH4bzBrTWyjKJ3hsW0kR1Xvjjb77ekNzrpf8iKbwUtk3G7txeFzIrLzxzO/cunWv27J/5VZPGeGe88zwuY8v172kLUc0Y8RAxeEOJLBnZl4Zq9bXF54nw+zKUVARzG2NptrUJDJh9b4x70ToTUOFfHoyg3efPAs+SFXaZFr3nSTFLC9GPpwpk7XLXAPvpvQ8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aa5XHdikyF/OoL8rjwYr9C/iw8AOpH766A9gBD4gJTk=;
 b=NKc7y9aw3aCcaqj3uf/ttg8LGwhA6vIEITZDWet/PQQpJTEyYXR1o2e6x3qmBs2VtmDZ4jvkSqq/kYuYIeQjlgMyNGZgcBLSl4mmSPP7djG/5eylIfOBiZiowHU7VneP1Ms4Hz2KGwhRu3s8s5OknhLJZzV1C3jGnWP50k0zDaYuKllLouA9lp/M0mSYv/PJ1iM4/5oE4G8dIWG00pVCBauI2193iaqnz/t0+nRdVXGENsX0Hyo57VJNzv8rkuAn3VWxCdKdkiLeCNzGOKwXp7yV5BKRJdBmbr8rY3EZf7RGW4G6yob4tbSQ8J3HMPEmG8dQzjvH2LzxkbcQV3aRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aa5XHdikyF/OoL8rjwYr9C/iw8AOpH766A9gBD4gJTk=;
 b=JWSOn9188FGVVgho/r/UGUhPKZyVjeQJd/5eTkA3itHjucIO2ZApnwVk+ssUbc4QA1uGZaSltmoDbFYEN95DPLWypzzuu0QItvSJIzIsUEeDL3Cnx0Gc/i0dATjA/He0/wfx5UFbVjlHli8nxpNyr5eIADjgZtaOK9XkGgou1+3CUtctokNsHDzTihQgY3lynTx3HYoeFGwTM23bOudZIoHPxLaGJdu6c3Drr092Z3qyVBOta8gXC+2FGvqGMOGzbw30TDerCKRdaL7uU8wSoKkaMWcfE9Sx3vkclHYP49p5RXJ9ycUch+fEoc/CECRGi8WfkiPZTF1rwMRDaoLBOw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9083.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 09:35:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Tue, 6 May 2025
 09:35:05 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, Julian Swagemakers <julian@swagemakers.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Steve Hay <steve.m.hay@googlemail.com>
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Thread-Topic: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Thread-Index: AQHbvdIH1wi2Dpyl3k6jAvs66vPp1bPEtSClgABhdcSAAEIS+g==
Date: Tue, 6 May 2025 09:35:05 +0000
Message-ID:
 <PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqplgmlisy.fsf@gitster.g>
 <PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9083:EE_
x-ms-office365-filtering-correlation-id: d585d4d9-cff8-46c8-47b0-08dd8c8148d5
x-ms-exchange-slblob-mailprops:
 quCBMN2EvO+AFS2EpFL4Y7YHhB9dxsQ6C8eMtpwLcz8NXgVGWEV4knZw/pxg1MJJbSbqxIWkrXmdkfmw0Q6g7rjJWpSUG7A1AOADUP5X9HNZ90AXS1B8pkg4X9Brxi0bY7ZketGo6GMMHf7QrFhg0MyqTBONeytw9/9Uza/XOgFRCSjWN+a1Cay9UaZu7b8BMtB+kDyHtUVXf2INBLRkro+v0TcfLVuxiGTSlrxSugXkA2liX+5iMw/kZagftLzMkcB6udGeE/icrimi/toRUzWRrHJrX/9T2uSS18P3ftYwI83fIxD27NyWtrrY7vmlspsBKTNWS+heJuJmJBtSaejfKtTqe6gjRqmTncxyYnIWFLRqQnFmEgc4IbbDsJj+typLTHE3ht+wgW6WjhO1lRw20JSrZGzq5wBFJdfsRLZTYHRe05v9nSwxd1Xx7tgJIK0IoeQrjdW8F8yZOmqmowUBdEjMat8E7uliSFXg05xNDFrzPbOq4ushyokFlrRQpIktkLUSpXIi16HMds9zXxJx1eRaVTW4DNCvOjXNvIEIxoI+V+THAt5JLGcIvITvqZKsPowfCCACHL3ZHgpVkMXgZVazWfWaaBAeCCLSdpwtKQWb6Ok/t+ufavRLC6f+gJ+IWvaE+IEvzt3oPrTsb67T8ncjrYLZ8DmiYhqt9SHEjBsEh6ufLjFB9bG4Emehfsq+f3EJYNxjVPPfg0Ssiw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|461199028|19110799006|7092599006|8060799009|8062599006|15080799009|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?anZJUkJZUGE4dVpoRXpvL01DSDdCVXlrNmx0Y21zR29MbGFEWUIyVVV1NnA5?=
 =?utf-8?B?eDBEb0pHUm4vME1MM0xGMGNYT092VTEveVhoaksyYi8yUjhtUm94eE9WS1J0?=
 =?utf-8?B?b2E4aTFFUWlNU1F0ZlZJTjd3TEhIZk1FR1hzSE5VeHFSdGhHTS8wU0hCa0JP?=
 =?utf-8?B?OFViMExSSStTbDZkamtjTU9PRWUvdEViYko3ZTE4RW1ER3dpUTFVa3c2dzB4?=
 =?utf-8?B?TjFYUXl3VVBDNDNVUkZwZTVIelk1VW9MTzJ4MDlPTGhHbUJSaVAvM2t2c3lP?=
 =?utf-8?B?VjV1a3o0dmltOXZxZVI0d2NsY1FRYkNrdndvSWk1N0I4dER5QVBZTnZJNDZh?=
 =?utf-8?B?a2RWT296VGh0T3R2ZjJRbERqUGpDSGFLUnoxTlJrb2h4K1Blb1JpbmZwRzM3?=
 =?utf-8?B?R0xCcGZJRW5XUWR6QTk2UC95TVFuYjAwaFp0b25YRU5Jc1YxV0NEa010WkhM?=
 =?utf-8?B?SExicStUQnViODZBRWgyajlHSkhJYkhyeGNKOGZoQ2FqNGFWUFF5cjY3UEJ5?=
 =?utf-8?B?cW1ldDBDYTNVOUl3eEpndEJ3ZlhqMks3UUVqclIxa24xVXRUR01aVysvcitZ?=
 =?utf-8?B?UnkzSkFMTEx3eTIwTS9iamdjOThxNGllS1BhSXYwVW80c3NIQ25ZTkxSTGxS?=
 =?utf-8?B?UkFWNGx5Vkxmd0lQODFndDNVZ0RBazhjMmNPbUdwaHRkN0piS2FvQ042QVJs?=
 =?utf-8?B?d09ZZzR6UzdmYXFlaFBsNkZUYURLS0lJV3U3RkhIVkNzbktORDV0cS9QaE9j?=
 =?utf-8?B?dlJqSGNIZXFnVld0TThqVDRjNENBeXdyTzdWUUwyeFA3dlloL05DV0h3cGFv?=
 =?utf-8?B?VlZhdEd3cWFaTHNMckhpZGtaNjZTQU5jTGw5V3pCV2JROTlEUk55TG9MM2Z5?=
 =?utf-8?B?dFZ0a2lxM0FEODBwZVRVUnpoUFdneGJ2ODc5R0crU0d0ck4xeTl2azhya1Jr?=
 =?utf-8?B?MURtUDF5b3lsejVMK2p4RXR4VVhhSU1NTXpFZTdEbVhZbVVQZnQybzdEekxy?=
 =?utf-8?B?bGN1aVozb3hTYURUZEdVVEhaY1dWeC9IN1V5dlFLaGhIUUxkMmZNN1dpamp1?=
 =?utf-8?B?U1BZTHZvcDdBc0pTbTdiVDREQVJGTlk4Y2J5TDVNZTJ5aUhkdXN6eWYrZXhm?=
 =?utf-8?B?VUtnTnA3SVR0REZwUXZ0bnRYQkpldUdYcEowS2lWUThHOEZaWlljeUtTWTcw?=
 =?utf-8?B?WmNFU3NGdTByT0IwdEovTmpmUStZUW5nODAwUnZkT0V0VzdUOUZMcitCdHZF?=
 =?utf-8?B?Wlg1NURLQnJBaWk3ZGFFN085L3ozaFF2QW02dno0TUJNMHZWYzJTaS81SDVu?=
 =?utf-8?B?dmhKckVKWGgrV2w1bUFBQTdqMVkzUlVDc0piZ1NyU0lqZURjQXNOa0J1bFdM?=
 =?utf-8?B?NWRxb3p4dlFkNXc0eFdmdkdHNHdmbTREc0xyaEQ0cG1YQWRpU3c3YkVKQTBo?=
 =?utf-8?B?b1dOZDhEWVlpYWZSTU1tQTl6WHBSQUJWNnZqNzRIMDdRcnRYMWFnK1JCbGFq?=
 =?utf-8?B?Smp4cmVOc055YU5hc0RIN2NWdW9sdWtFQ2FsWmk0VWQwdjdBVStEbDJrNUZL?=
 =?utf-8?B?NEU4UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmNCbDFNc1BDbDdxVVhMcmtISCtzZ0J2VGUwRXVLVHh2ck1SU0Q1eUlKenc4?=
 =?utf-8?B?L1lPcHYxOGRUUi9yRUhsVFhUWFZQWS9ZeHVHNTl4NzV2NGNhUWJScUZCaTdp?=
 =?utf-8?B?bm95cldrR2N2c2xLWjdKY2ZFVThCK0ZMTWVwbjM0TzBxWmMvYk9HVGdWeC9i?=
 =?utf-8?B?cTRzRFpZRW9ndVBMYzZGT09yRmo5MDNoUHhieFg5M2U4Mlo2aGVFU3FmczBG?=
 =?utf-8?B?QTM3MXk3LzNGTWo2MThTUmFXOHcvc1c5cDh1ZFd6SkZ2L2hiTmxHK3BzcjhR?=
 =?utf-8?B?R2k4VVVCaC9zT09OVFVDeU55TC90dVBOemxva25wUWFQZ3JJSkpKLzBBdDZZ?=
 =?utf-8?B?UU1tMlhJNG5Qa2hMOHBPWHU5bXd4cUNUUkRYNXdHbklaUG9JVVNLYmh1QlE2?=
 =?utf-8?B?QzIrS3Y3SXNicSswazRvUjJZcnVaYmhqS2paRm96eTkxRjYzdXhQSFdQTG4z?=
 =?utf-8?B?WGgwS3JVOTFYUktEam90dkYwckgrVEdwd0FTa01BejRhamtvNXV3YXoyWVp6?=
 =?utf-8?B?NEVKSEFCUThEV0w5Wk91eUhKaFNRVWJGa0locXB4OHhJMVI3ak1GZXppSS9y?=
 =?utf-8?B?cW1VcVJLQXdzb3lsNUEzRURYV2E4WGpOQWc1TExGM29mRDVZVXI4emdCNTVa?=
 =?utf-8?B?Z1NObmY5L1k5UEQxWExGL3FYWGwzQTFYNW0yZ0c2NVNITy9vZXdKSllYcEh6?=
 =?utf-8?B?WndDZkZqbFRNQ09ldU5kRFN6bXF1RWJPTFlqSjhvaHlaODg2T1RlemNNWEs0?=
 =?utf-8?B?b3VmZzhpNldyWVA5WlVWcmlmQ280UTBYc2h3T2YxajBvVHZxelpJaTNIT3J3?=
 =?utf-8?B?bVVrUDFoU3JOS3Ryejd3WDZuN2hVUSs3ajBQZ1lySU85RE1pQWRFUlV3WnBL?=
 =?utf-8?B?aC9GbkZOMnJzQm1nWDlWdm40ek5XQkxmVVJMak1RUGNqR0FYTHpjVmQraUw4?=
 =?utf-8?B?aFdjZ09hM3MrcW10RHg3YjYrOUl4YldPQ0M5My9OYTg0T0pIMmFjSWZQdDBi?=
 =?utf-8?B?cC9QMENuSVRmSHdRKzJXQlZIUE5SUjgvQXhoZ05TdHRPYmZZMW9oRlo0Qy9Z?=
 =?utf-8?B?c2dhYk13aUFNWWJYSGZSRXJ6WFkwWkFQOWlLQTBLdndURzI3T0pWS2l4VnJN?=
 =?utf-8?B?TTJhb29tYjhkOStSK09EZWQrR3NvZnRGdURQb2ptRkpCOVNFdEdrMUZtdjZP?=
 =?utf-8?B?akRCVnIvMkpPdzRTUEFvM0ZHeHRaNWNlbGJ3d2FtMERSOXVBUlY3UDhsRWI5?=
 =?utf-8?B?WjhkcDJ3TkVlOHRZekhCRTdHQTdjRitNdm1CdHQvU3BHZ1ZFQU9KZXM2UlhP?=
 =?utf-8?B?blR3TWhNenhsQ1NyaDBXc0h1ZWtLOUp2VzVTY244U0NCUDg0SkJkOVBrUVN6?=
 =?utf-8?B?UmFtRU8rWHZ1UWJIQTlQeDU1UUt2RUtTSHowNTZEd2xXMUdvanlPUXNqUmww?=
 =?utf-8?B?bjNKUVFjOTVMZnpoZ29GSXJBVWR6TnBka2VSQ3ZkUWFKMk9sVjBmSGE4RGdv?=
 =?utf-8?B?a215ZnRiSWxKMDI3QllJOFY5cVNYLzNEUXo5a3ZQZWszNitSZUdUcFJlTkZV?=
 =?utf-8?B?dS9tbXEydTU4MmpiUnE3U3dCYkhaZzROSWUxTThHc3hXSWlLaHFkUWo3WG9q?=
 =?utf-8?B?a1ptMmdLdTR1MlRvMFNubFBscFBoeGxZUWhBWWY1TXB5cVg0ckVtOGh2clFS?=
 =?utf-8?B?TFZSb0ZKMC82bGVqY1FhcXUxNmttQkR6Q2I3MDlkKzRweGRYZHBBZEFVNFg4?=
 =?utf-8?Q?B0bsMNI6AtDxaTQjH4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d585d4d9-cff8-46c8-47b0-08dd8c8148d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 09:35:05.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9083

DQoNCj4gT24gNiBNYXkgMjAyNSwgYXQgMTE6MDjigK9BTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4gDQo+PiBPbiA2IE1heSAyMDI1LCBh
dCA1OjE54oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+
PiANCj4+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyaXRlczoNCj4+
IA0KPj4+IER1ZSB0byBjdXJyZW50IGltcGxlbWVudGF0aW9uLCBJIHdhcyBub3QgYWJsZSB0byBz
ZW5kIGVtYWlscyBmcm9tDQo+Pj4gVWJ1bnR1Lg0KPj4gDQo+PiBJdCBtYXkgYmUgdGhhdCBzZW5k
LWVtYWlsIGRpZCBub3QgY29tcGxhaW4sIGJ1dCBJIGhhdmUgYSBzdXNwaWNpb24NCj4+IHRoYXQg
aXQgdGhlIGFib3ZlIGlzIG9ubHkgaGFsZiB0cnV0aC4gIFdlIGRvIGhhdmUgYW4gdWdseSBsYXN0
LWRpdGNoDQo+PiBmYWxsYmFjayB0byBjbGFpbSB0aGF0IHdlIGFyZSBsb2NhbGhvc3QubG9jYWxk
b21haW4sIGluc3RlYWQgb2YNCj4+IHVzaW5nIGEgbWlzY29uZmlndXJlZCBtYWlsZG9tYWluIG5h
bWUgdGhhdCBzZXJ2ZXJzIHdvdWxkIG5vdCBsaWtlLA0KPj4gYnV0IHRoYXQgbmFtZSBpcyBhIG1l
YW5pbmdsZXNzIG5hbWU7IGZyb20gdGhlIHBvaW50IG9mIHZpZXcgb2YgdGhlDQo+PiBzZXJ2ZXIs
IGlmIGV2ZXJ5Ym9keSB1c2VzIHRoYXQgbmFtZSwgdGhlIG5hbWUgbG9zZXMgdGhlIG1lYW5pbmcg
YXMNCj4+IGFuIGlkZW50aWZpZXIuDQo+PiANCj4+IEl0IGlzIG1vcmUgbGlrZSBkdWUgdG8gbWlz
Y29uZmlndXJhdGlvbiB5b3UgY291bGRuJ3Qgc2VuZCBlLW1haWxzLA0KPj4gYW5kIGJ5IHRpZ2h0
ZW5pbmcgdGhlIGNvbmRpdGlvbiB0byB0ZWxsIGFuIGludmFsaWQgbWFpbGRvbWFpbiBuYW1lDQo+
PiBhbmQgaGF2ZSB0aGUgbWlzY29uZmlndXJlZCBtYWlsZG9tYWluIG5hbWUgdGhhdCBpcyBpbnZh
bGlkIHJlcGxhY2VkDQo+PiB3aXRoICJsb2NhbGhvc3QubG9jYWxkb21haW4iIGZhbGxiYWNrLCB5
b3UgbWFuYWdlZCB0byBzZW5kIHRoaW5ncw0KPj4gb3V0Lg0KPj4gDQo+PiBUaGUgcmVhbCBmaXgg
Zm9yIGluZGl2aWR1YWwgdXNlcnMgbWF5IHByb2JhYmx5IGJlIHRvIHNlZSBob3cNCj4+IG1haWxk
b21haW5fbmV0KCkgYW5kL29yIG1haWxkb21haW5fbXRhKCkgZ2l2ZXMgeW91IGEgYm9ndXMNCj4+
ICJNYWNib29rLi4iIGFuZCBmaXggX3RoYXRfLiAgVW50aWwgdGhhdCBnZXRzIGZpeGVkLCB0cnlp
bmcgdG8gdXNlDQo+PiAibG9jYWxob3N0LmxvY2FsZG9tYWluIiBmYWxsYmFjayBtaWdodCBiZSBh
IGdvb2Qgd29ya2Fyb3VuZCwgYnV0DQo+PiB0aGF0IGlzIGEgd29ya2Fyb3VuZCwgbm90IGEgcmVh
bCBzb2x1dGlvbiwgaXNuJ3QgaXQ/DQo+IA0KPiBJIHRoaW5rIEkgc2hvdWxkIGRpZyBkZWVwZXIg
b24gaG93IHRoZSBkb21haW4gbmFtZSBpcyBiZWluZyBhc3NpZ25lZC4NCj4gDQo+IE1heWJlIGl0
cyB0aW1lIHRvIGZpeCBhbm90aGVyIHBlcmwgbW9kdWxlIGFmdGVyIEF1dGhlbjo6U0FTTD8NCg0K
SSd2ZSBub3RpY2VkIGJ1ZyByZXBvcnRzIHJlZ2FyZGluZyB0aGlzIGluIE5ldDo6RG9tYWluIHBl
cmwgbGlicmFyeS4NCk1vc3QgcmVwb3J0cyBzZWVtIHRvIGJlIG5vdCBhZGRyZXNzZWQuIE1heWJl
IGl0cyBubyBsb25nZXIgbWFpbnRhaW5lZD8NCg0KSSB0aGluayB3ZSBjYW4gYWRkIGEgbWluaW1h
bCBjaGVjayB0byBlbnN1cmUgdGhhdCB0aGVyZSBhcmUgbm8gdHdvIGRvdHMgdG9nZXRoZXIuDQpE
b2VzIHRoYXQgc291bmQgZmFpcj8=
