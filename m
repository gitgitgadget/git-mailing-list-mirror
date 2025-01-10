Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978020764C
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736552204; cv=fail; b=igNoYMCu17f3VxrdJam9A4lY9nefQr4b7KL4cz9wdIOX0/MrN2pX6xjSh4Z5oyPHhgEJJJBO7Lw1u1Xv93O5ymkis7gtbCHzkxL7dsdq4rVolDRPG9ETIIiA3FrqEbG6/mGUYJv2zEDu07gEm6nqaWc2aTerXRuOX7UMotqkvnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736552204; c=relaxed/simple;
	bh=xoFTb91tLne52wgcQBVLEsSHWQ7Ze6y5pbmcBfIBMpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U0vS/OQB9PR2muiJd5pMQ39sNRiUJR5x33cJfGvbV1LsaknlZcwZwHDTuSQoE71B3knOMTGYIh7Fpl9K6n8H2GFIzf4rgvT04AGmsGuk7J+rI+DkkQeXtCyAliYrp/shJdRguLnY+DMFcvHtXaJ8422stZ9uIksSvYGriCu2H/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=UU6WAu/t; arc=fail smtp.client-ip=40.107.93.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="UU6WAu/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPis7LhaiBtd/ZJ2KrOvrv131kx+LeFWDmfkMqQw5r6niffomAJWruSZyBIaXnKCqKuRO2v5Jvqxn39dB6XPBx1/Q0OzFRLzcqdSgE202YqzdIVEroN6Mrsxkr50nnYFULbspDkzfd2UWDsgk+twgbNZN3JQkwbz3lw+U6yVq5VGKemLSu/FHrmgxfDW80vnEl+DwPT1lKXJDgzSqkvdi/exWu5j+4s/wK8XGqBU6eDNYQBDRK0Cp8q5UFQ3zrdLT9QjSxLIb4e3uiXeMp1CQ6kYLkk4jUHckCDJ7sBSHOKuEfvI/vTJO80X1x18jjKk3zvexjlxS19nhv1H3PL0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoFTb91tLne52wgcQBVLEsSHWQ7Ze6y5pbmcBfIBMpw=;
 b=mZ60w1xc84eGPwH9ZNhfDdK5evz8fQI22eGsADJLocQH99QWmhOpd6bP8oB7Z93b5JDIJs5rLkB7BIpQI1z6gojgn4V1nCqm8KJKdrqdCtIXO2W8gi3jSpeAAizxEPE0VV6te4dB2pGQqiijV5MN9i7mME+LNyYwuN0YnBtA99LWUIXYBBdD0QdNi6AW5cVLGjwWnrD0Yh894xFkfGjnq82Mc5wADRyxoVvAd3EACpvok6eF5tcuT9FguYGhguqBQNfdeyGT2XYdyvyaPSLqOW2kRf1kr1ujWh6yb65KyXnLc/yjbyAcc+bOqrwjbwuESEFU8TuQAYEH9EvqBHrnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoFTb91tLne52wgcQBVLEsSHWQ7Ze6y5pbmcBfIBMpw=;
 b=UU6WAu/tlOlZ+hGqlPd0hBf6DC3Fmy7uQmbdGbebiXDWiOMXGhlElJl2yWzkkiMuzLRsn1khAheyRrRgVOkWYhn523Sa9mv+e63mF+Gbp3nzw9Zb6kN4kdv2oRJLv++wmxS8Ve6aBZHGvLyhrx6b9AVJxeFhJK0NDvLQAQIBFPE=
Received: from BL3PR17MB6020.namprd17.prod.outlook.com (2603:10b6:208:3b3::14)
 by PH0PR17MB4924.namprd17.prod.outlook.com (2603:10b6:510:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 23:36:38 +0000
Received: from BL3PR17MB6020.namprd17.prod.outlook.com
 ([fe80::edb:348f:3dbf:153d]) by BL3PR17MB6020.namprd17.prod.outlook.com
 ([fe80::edb:348f:3dbf:153d%5]) with mapi id 15.20.8314.018; Fri, 10 Jan 2025
 23:36:37 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "derrickstolee@github.com"
	<derrickstolee@github.com>, "stolee@gmail.com" <stolee@gmail.com>
Subject: RE: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
Thread-Topic: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
Thread-Index: AQHSQkeJdJwayZiGd7YmQhUjFFLawgKT1uCzsw4zuaA=
Date: Fri, 10 Jan 2025 23:36:37 +0000
Message-ID:
 <BL3PR17MB60207281A26259F5D577B2B9F41C2@BL3PR17MB6020.namprd17.prod.outlook.com>
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
 <xmqqh6665p8j.fsf@gitster.g>
In-Reply-To: <xmqqh6665p8j.fsf@gitster.g>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR17MB6020:EE_|PH0PR17MB4924:EE_
x-ms-office365-filtering-correlation-id: 30e2958c-d665-490e-474d-08dd31cfa07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWx5Q28xdmxZMDBCekl4SmE2WjFwL0JPV1pMTU9PUkZQazFVbysxbTFQQjRR?=
 =?utf-8?B?aWY5eGpaUzlkUEMvVXoxSVhPUU1YaVFrWFArMzVvSUR0dlhJeFV2WnZYWGky?=
 =?utf-8?B?R1QvR0ZmcGJ5NkNJWXBONUdockRDTUsxd0xKRXJTNXFqaE9Leis0a2Rsdkxu?=
 =?utf-8?B?ZGZwV2dKUFgrOFErbzZMMkM1ZDVRY2VsVXNnUG5PVU9TNU1KM0JGOGMyRVU0?=
 =?utf-8?B?cXNuelpRMmh6WlFjZFJUbUE3MTlNOGh5aXZEVDZyNWtyWjJVbHduN0kvN2Zk?=
 =?utf-8?B?Q3NNRXpwS3lCK2x0N2k3YXNzQitIUnlQNXlENjQ3OW9TYXVWSFRWVFVXOHhL?=
 =?utf-8?B?U3grSUNaTGwwbi9RaHJjcnZLK2lBQWFJTzEwU0xjSmoyeDEwZXJNSjFGYzZr?=
 =?utf-8?B?eENlZFVmb3VxS3JNbHF3T2ZuQko0WkRZLzlDTm1KK0MrazFVT1dQTDAvcTZT?=
 =?utf-8?B?SS9vdXZ4YVV3d3RhWTJ3NENOSFlYU2tOckNpUDZDRGtPL3Q4TzRnMWxYRjBx?=
 =?utf-8?B?NXNKdHRwbmpVSkxyRFRpWVIzaTQ1NWFhWXY2clB5R3owRzJMR3psZGl0ZWVQ?=
 =?utf-8?B?eEFMYXRDMnVjN1BzR2pPVHp1UUt3cEt3Znhpd0Zzb20rUm0zdkMvWUpjZzdR?=
 =?utf-8?B?T1c5dlJjWCtaekJaU0MwUzZxSHhJbDN1ZGM0SnFyTE9YSWpoemdDbnNmM3pI?=
 =?utf-8?B?NnZiYzVmWTVQcXdQRGxBS3pqQ05WaDhhUWlZTjF6ZWRqV2dMWlc4anhzOGtl?=
 =?utf-8?B?RlY0RUNVMm9zT1dsSGVDWGdlTEJ1bVhoeCszNWVWa0ZGb2lpZVhJdUdKVFVi?=
 =?utf-8?B?VlRSK2xZbXhKbnRxUTdicUZTZUtEdmxSVnpNeG1XZ1pzalhWVWRicGRtTHVa?=
 =?utf-8?B?ODZ5ZzYyL05BR0JiWmdSVzNEN2ZlcENZZU1NQnVOSlRrSzZJaFV3bWtTV0R0?=
 =?utf-8?B?YzN4L3NLU2kxUGdIMEVIOGxpL2RzZVFrSDZ5bUlpRHFVcTlVWDN2OUNIeEZX?=
 =?utf-8?B?RGFlYlRXNThmWDJyd2NCMFUzOGFyM0M0eG03ekZQY3BGMm1aMk5Sc2h3WVRn?=
 =?utf-8?B?M1p2OGs3MDZwRmdWbldKMktPbVlnLy93V1JMVXNQUVRxYTNVVy9zNkhtc2d0?=
 =?utf-8?B?eUV0cWNtR0lENzc5UXl2Rk5vZnRvNHRaYVkwaUVDdWZEOFI0bk1pSE1VTVhY?=
 =?utf-8?B?bG80NmFOc2dyaVdNbFQrMDlIN3ZvdXJINVpSTjZHWHYrelFFWFVHaWlDUEww?=
 =?utf-8?B?dnExNWlKS1RnRUlUNnMrUTBWZGlpNUkwL2V4bVVhaU9Ua3FLWXdPZzk3TW9r?=
 =?utf-8?B?SHR5ajlCOWdXTlB5QmVSaGdoZDVCaWtJdHhiRGI2cy9iR3J3alh0UVJ0M3la?=
 =?utf-8?B?aXVGYVdmSGtwTDlPcnFLUjhTNnpKUkgvQlhZT3pNSU8vdjdDbFJOaXBqVElW?=
 =?utf-8?B?U1ZNZkFNY2NkY0hKeXEzVy9IWUJNRkdzbUJzYm5NdFQrQ3E2SVFCaWw5RndI?=
 =?utf-8?B?VGQvK1ZPMDZuU3ZMSjBHdXRRcVRTZDEyM05peUxuaGZMcERCTTBZL0NCQXFo?=
 =?utf-8?B?ZHY3aCtudkxzeDNzaEFBWFR3VXJncnU4UjBHVk9yRWVHeUdybUlsYXBvNEFY?=
 =?utf-8?B?eVo2WDVlc3V3RXdDLzdLMTVCMFQ1TzQya0NoOXdzUTF6ejVyK1cvMWRsaXho?=
 =?utf-8?B?OXBIQmtuM25OQ094WUVuZkhmcHB6RmthVjBnYnhyNEJ3L1NJM0tPVW5mN0lI?=
 =?utf-8?B?V2F5ZHVJWFRzN0tTWnRSYjVTWDdoekh3VXYvcGVIWEFmNVp2ZThRZUlBTERv?=
 =?utf-8?B?dHB2aGc1Tm42UHdFdndCRE85VXZGRnNrdEdzM0VPQTBZVG80UFVXaVRRWEF2?=
 =?utf-8?B?c3NGZzlWQUVaVVA1SnFFUUZTNndxTC94SExpckpHWHdKMFBiMUxaV0F6WDdI?=
 =?utf-8?Q?mtSrzljxu9+M+A+woBWVGv6qhpxJIUw1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR17MB6020.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UHYzUmhsa2w3MVY0RmZuU2oraDRTTlZjaVoxR0hWWGpHc0d6VmMxcWt5aWpG?=
 =?utf-8?B?QVR4ZHBlM0ZJWGdzRW5icGdRSERLU0J1WGpGSWMzUGQzdEtrdlFNSGVuMW8v?=
 =?utf-8?B?V042Z2hpVTB6SVRlK2tSR3o5MTNSY0xHNWtWaFlnOWo5YWY2ek5MZG1udmVE?=
 =?utf-8?B?TWVqZERvMHptemRvdVdUblR4bWhVZlllQlNwTXZsNzhNc1lYSFNVNjNVbEtv?=
 =?utf-8?B?K2N1NTZmT2ExVDE4TnRnTkFTNlNpN0tBSEI4ZTRYQjBrUFZsYkFhaE5aYU04?=
 =?utf-8?B?RktMb29TTU42eUhrZGFHRVJNd2h1ell6cEdmRmpSaFBuSGpnVTJxZGY5MGdw?=
 =?utf-8?B?dnNNZENKTmZUSVNuZWNYRHdQQ2pZSy9Ba2kvck1iemRyOVFhelJxY3dETVA4?=
 =?utf-8?B?SlZWWmF3T0g1amJObkRPd2tRTWpNS0xiLzFaWkpYeUJvMjhMMXFTUGZWMmJ0?=
 =?utf-8?B?dnNUT3AzeWJYbUJoQnplNHlPVnIrUE40ZG0zekVUSUUxdUxlSm9sMXA3b1Bl?=
 =?utf-8?B?L2l3WmpXUVVxWUhKdlBzYkRDRHNxdm54bllVMk1iUFVEdzB4TkZKd2Y4MERH?=
 =?utf-8?B?cWNxeldMZVp3TEI1WjQweHRHRi93LzNxVEZSSFNUaWRSZUFnNHpUMzVVMFhv?=
 =?utf-8?B?N0ErTWpRakFvZXFPVUZPbXRLS2hCc2o5d2lqUnk4cnp0K3YwRXVKUEhVaXVV?=
 =?utf-8?B?Q2ZMKytWbkt2Y1B3cloxNlRnZ2FWejJyUFBKUVlDSGxSMVRISjZuZFlxUVls?=
 =?utf-8?B?SUVqOENCejhXZ3FJNldENmFDZEljUDMzM0N3TXZLK1N6YTEzd2l2aUQ2WXYw?=
 =?utf-8?B?b3ZIY0xTNGJvN0VRdnNqNTJzL00zWk9ZWFBwK2p0alEvTWxDUXdYUkIyeTZQ?=
 =?utf-8?B?RUk3Y1ROZTh3YmR4YzluNFRvbDhWalh6d3NjS1R1eWRPd29mcm9uVVk3NDF5?=
 =?utf-8?B?MW15TGJaRURzeE1ub2l3RktHTlZQTG9DTGlBRnFBSVpSZDNOaUFTbWVnMnEr?=
 =?utf-8?B?emVlZ1I5Zm84TnNsNFJLSFNSN3hlNnoxSGwyb3hUcFRPV0Z6QUszcXduQTRs?=
 =?utf-8?B?YXRyOXF0djNGelRRY1NLTUQzQ3JndXVpUldXakF6d1NkbkhKZ2ljZ2xpOFcw?=
 =?utf-8?B?VUtTL0thMWdrcHE0YmV3bzQ2WEhsMTRKYkJSL0o4Z1lVdk9ZMWVzSXlGTGpP?=
 =?utf-8?B?aWxtdGdCaTVIZTQ1VTFjMWJZMkFydmJpbjk3UXFxT2VXY245QkYrVk5QNVp3?=
 =?utf-8?B?d1o3VndqT2dxM0JiUDBDRDIxeFdBTHhRSkFZczdIc1FMVU5nZUZZcVd5Tzc2?=
 =?utf-8?B?U3BMWTFLbDJJZUpzMzN1Y0hVWXllbG9TcEVrTmwwdUpvMFE1QWVsWEpFMFRk?=
 =?utf-8?B?d0dJcGZHMkZFOGcxYUFJKzBVdUdWbVd6YWJEWGFPVkpTRWZZOFNEREFZaWdN?=
 =?utf-8?B?VU0xMHlUME9JN0RTOTRjTkVqTWJNYWJMNnR2U0hjNGhDbFovSzlIMy9acVhB?=
 =?utf-8?B?YW1lOWc5K0lJcWV4ZWpZQUxBRE1Md08yRXEyV0pxbmFDSXVNejlka2xBZ205?=
 =?utf-8?B?dU9MZ1JwSUZmV09VbjNiUmRyZGZoaGxvU2pZMGFRTEdNb2lHeC9ma3VBcFlW?=
 =?utf-8?B?SEREY1VEV0RWTnFJNE1vc25abVVHNXVVTGtNd3NrNmRGRHNsdDgvSzdIeE1C?=
 =?utf-8?B?M1dOUXZxSFZ1Lzh3OHlPbDA3M3JrT1Q4aS9rZTgxbDc2ZFZXaFBmY3RyK080?=
 =?utf-8?B?RUQ3Z2MvdmhrTXpKU0xpbHVIQjBXSmRyajJ6UW9KVGtPRVExeDlBMmdLbWpH?=
 =?utf-8?B?enpmZkZMekZoaGZjcVFHSDZYWW91TGY5K3ZUTnYzWU1BMUJkdEN2dkJIeStn?=
 =?utf-8?B?cmZBUG9KVnBDdy9FVG1xMllLcUQ0SGZ4WW1GSlNxTG1MWFFrcTAyTENGUiti?=
 =?utf-8?B?ZmF2U3BUK0g2M3ROSHQ3S0NobFh6SXo2dXdENFVmTmpaWlB6VEd6TzVZd3VE?=
 =?utf-8?B?NFNQMjFnSjBJSFBJcmlRRS8xVnZhQXNkTHFvRkpEZk52NFdDc3hpaHlkaDh4?=
 =?utf-8?B?UjJSS3I5eDdnU09Fa1dCZjJETW5vUHhESk14dURkWDhLRFI0WDYvcU9JUkxH?=
 =?utf-8?B?b2E2MXpoenNUUnVYekQxQjRBSlNORzZRTXVFOTkwRGVKMjErUERWVUYyZEVX?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR17MB6020.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e2958c-d665-490e-474d-08dd31cfa07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 23:36:37.6884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKKQFfLuvmEb08eNwHLUCNSAlREa/Qhm8qs45W63qZxZX0M4CqLmEa/YWq/qGgZiKGqzABuYjXLkLeaUT1lVyuOk1XM+8AfbPFDBeGcwC7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4924

TXkgZW1haWwgcnNiZWNrZXJAbmV4YnJpZGdlLmNvbSBpcyBiZWluZyBibG9ja2VkIGJ5IGdtYWls
LCBzbyBJIGNhbm5vdCBnZXQgdG8gRGVyZWsuDQpBbnlvbmUga25vdyB3aHk/IEhhdmUgSSBiZWVu
IGEgYmFkIGJveSBzb21laG93PyBSZXNlbmRpbmcgdmlhIGFub3RoZXIgYWNjb3VudC4NCg0KT24g
SmFudWFyeSAxMCwgMjAyNSA0OjMzIFBNLCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCj5NIEhpY2tm
b3JkIDxtaXJ0aC5oaWNrZm9yZEBnbWFpbC5jb20+IHdyaXRlczoNCj4NCj4+IEl0IHdvdWxkIGJl
IG5lYXQgdG8gd2FybiBzaW1pbGFybHkgaWYgdGhlIHVzZXIgaW5jbHVkZXMgYSBwZXJzb25hbCBh
Y2Nlc3MgdG9rZW4gaW4NCj50aGUgKnVzZXIqIGZpZWxkIG9mIHRoZSByZW1vdGUgVVJMOg0KPj4N
Cj4+ICAgICBnaXQgY2xvbmUgaHR0cHM6Ly88cGF0PkBnaXRodWIuY29tLy4uLg0KPj4NCj4+IFRo
aXMgaXMgYSBwb3B1bGFyIHByYWN0aWNlIGFjY29yZGluZyB0byBTdGFja092ZXJmbG93DQo+PiBo
dHRwczovL3N0YWNrb3ZlcmZsb3cuY29tL2EvNzAzMjA1NDEvMjg0Nzk1ICg4MDBrIHZpZXdzKS4N
Cj4+DQo+PiBHaXRIdWIgcGVyc29uYWwgYWNjZXNzIHRva2VucyBhcmUgZWFzaWx5IHJlY29nbmlz
ZWQgYnkgdGhlaXIgcHJlZml4ZXMNCj4+ICJnaHBfIiBhbmQgImdpdGh1Yl9wYXRfIg0KPg0KPkN1
cmlvdXMuICBJIGRvIG5vdCB0aGluayB3ZSBoYXZlICphbnkqIGNvZGUgdG8gc3BlY2lhbCBjYXNl
IHN1Y2ggYSAidG9rZW4iLCBzbyB0byBHaXQNCj5pdHNlbGYsIGh0dHBzOi8vPHBhdD5AZ2l0aHVi
LmNvbS8uLi4gc2hvdWxkIGxvb2sgYXMgaXQgKGFzc3VtaW5nIDxwYXQ+IGRvZXMgbm90DQo+aGF2
ZSBhbnkgY29sb24gaW4gaXQpIGlzIHRyeWluZyB0byBhY2Nlc3MgdGhlIHNpdGUgd2l0aCA8cGF0
PiBhcyB0aGUgdXNlcm5hbWUuDQo+DQo+SG93IGRvIHdlIF9rbm93XyB0aGF0IHRoaXMgcmVxdWVz
dCB3aXRoIDxwYXQ+IGRvIG5vdCBuZWVkIGEgcGFzc3dvcmQ/ICBJIGFzaw0KPmJlY2F1c2UgSSdk
IHByZWZlciBub3QgdG8gc2VlIHVzIGhhcmRjb2RpbmcgYW55IGhvc3Rpbmctc2l0ZSBzcGVjaWZp
YyBoZXVyaXN0aWNzIGluIHRoZQ0KPmNvZGUsIGFuZCB0aGVzZSB1c2VycyBhcHBhcmVudGx5IGFy
ZSBkb2luZyBmaW5lIHdpdGhvdXQgYW55IHN1Y2ggaGFyZGNvZGluZy4gIElmIHdlDQo+Y2FuIHJl
dXNlIHRoZSBtZWNoYW5pc20gdGhhdCBpcyBsZXR0aW5nIHRoZW0gZG8gc28gd2hlbiBkZWNpZGlu
ZyBpZiB3ZSBzaG91bGQNCj53YXJuLCBpdCB3b3VsZCBiZSBncmVhdC4NCj4NCj5BcmUgdXNlcnMg
ZXhwZWN0ZWQgdG8gY29uZmlndXJlIHRoZWlyIGNyZWRlbnRpYWwgaGVscGVycyBrbm93IHRoYXQg
aXQgaXMgYSA8cGF0Pg0KPihwZXJoYXBzIHdpdGggYXV0aHR5cGU9QmVhcmVyKT8NCg0KVGhpcyBp
cyB3aHkgSSBpbXBsZW1lbnRlZCBteSBvd24gY3JlZGVudGlhbCBsYXllciAtIHNvcnJ5LCBjYW5u
b3Qgc2hhcmUsDQpidXQgY2FuIGRlc2NyaWJlIGlmIGFza2VkIChtYXliZSBhdCBhIEdpdCBNZXJn
ZT8g8J+YiSApLiBHaXQgc2hvdWxkIG5vdCBuZWVkIHRvDQprbm93IGFib3V0IEdpdEh1YiBzcGVj
aWZpYyBhY2Nlc3MgbWV0aG9kcyBmb3IgSFRUUFMsIHdoZXJlIFBBVCBpcyByZXF1aXJlZA0KZm9y
IGdpdCBwdXNoLiBUaGVyZSBpcyBubyBwYXNzd29yZCBmb3IgUEFUIHVzZSwgd2hpY2ggbWFrZXMg
aXQgaGlnaGx5IGluc2VjdXJlDQppZiBwZXJzaXN0ZWQgb24gZGlzayAtIEkgZG8gbm90IGtub3cg
d2h5IEdpdEh1YiB3ZW50IGRvd24gdGhhdCBwYXRoLCBJIGd1ZXNzDQp0aGV5IGRpZCBub3Qgd2Fu
dCBhbnkgcG90ZW50aWFsIENWRXMgYXNzb2NpYXRlZCB3aXRoIFNTSC1saWtlIHBhc3NwaHJhc2Vz
Lg0KUEFUIGJlY2FtZSBhIHJlYWwgYW5ub3lhbmNlIGZvciBteSBjb21tdW5pdHksIHNvIEkgaGFk
IHRvIGRvIHNvbWV0aGluZyBxdWljaw0KYW5kIGFkZGluZyBteSBvd24gY3JlZGVudGlhbCBtYW5h
Z2VyIHNlZW1lZCBleHBlZGllbnQgKGFuZCB3b3JrcyBwcmV0dHkNCndlbGwgLSBidXQgaWYgc29t
ZW9uZSB3YW50cyB0byBkbyB0aGlzLCB0aGV5IG11c3QgYmUgdmVyeSBjYXJlZnVsIG1hbmFnaW5n
DQphY2Nlc3MgdG8gdGhlIGNhY2hlZCBQQVQncyBtZW1vcnkgdXNlKS4gVGhlIHByaW1hcnkgdXNl
IGNhc2UgaW4gbXkgc2l0dWF0aW9uDQppcyBub3QgYWN0dWFsbHkgZ2l0IHB1c2gsIGJ1dCB0aGUg
Y3JlYXRpb24gb2YgUHVsbCBSZXF1ZXN0cyBvbiBHaXRIdWIgZnJvbQ0Kc2NyaXB0cyBvciBhIENM
SSBzaW5jZSBOb25TdG9wIGhhcyBubyBHVUkgYWRhcHRlciB0byBhY2Nlc3MgdGhlaXIgd2Vic2l0
ZS4NCg0KPg0KPlNvcnJ5IGZvciBub3QgZ2l2aW5nIGFueSBhbnN3ZXIgYW5kIHBpbGluZyBtb3Jl
IHF1ZXN0aW9ucyBvbiB0b3AuDQo=
