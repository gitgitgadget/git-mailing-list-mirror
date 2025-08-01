Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010007.outbound.protection.outlook.com [52.103.33.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C328DB78
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082241; cv=fail; b=uuppvJ7qp0MNAbiQy1VdmJag0BFhh9mU24ALyruCVvdcNAy/XqVB7On7yZ3J7kosBD3xBll7UsnL9TvQgjk+RvNQMTHt+i00Qp21/WudEZkpnVtr5T3K/WKDabH5pc/UWEjFpv8KL1yiq5UPdbld8d28I+G2G9Yu/BOclxqKNe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082241; c=relaxed/simple;
	bh=Buo3+Ufm6/NwISfEt317znRdJ8LhWEWRfIcj9jXt/5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oXezqL5l8Z5TIKIVQ86v/yth4zp6ojDAGWJebzf2uPNFR+zFk2LSlwSmKmy4QiiO5JCnqgljLfYBjkiTGa/h8bt96Qv4LpwHnGUgcx7phhkpCwVGCcjhxToiuZsFH0fpRcCRCoNtaSksmedfBaST4YbhYp5tStqWgm28d5QAJXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=kGsNrxPa; arc=fail smtp.client-ip=52.103.33.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="kGsNrxPa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpikJWyp8MiBF6ADGtAmN5+RVOgRkle3ElK5OMcsl/kK3JxQ5YuNgYObZKJpxM/lw0Rev1yuppGvXiFjPKebk7zanT7gLvyTmbJUFKsoHC4/+PPpZ4iPlaFYMls3ex7EBOoNqU+zPGAg3QaAc+QnyKOlZIjyV5deR9lkXzqOsJvyBMLOILXg0CNTWt2YpFK66DNXsx08cOw4vPZo9QsEwRjwJMMHiGsthXxEp8aQ1aewMAAAr7HbVFPVM711ehgSQH7tuMpF3oZPBUnYHIJOtxQ/kvNowDghHHgNlAZpd8pZWO0KedHVsZfNbzzLeXynJKQiCNL8y3kcba2E35/iVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Buo3+Ufm6/NwISfEt317znRdJ8LhWEWRfIcj9jXt/5s=;
 b=FsVq1LCRHOQnrwAr+osszQqmw2a5IXZe7d1TthRwCiiL8suE6bCxihJuar0Y4c4BnzKBhgTxA23WGD0lfcmuD1egyP5daMQxYxTWu/RmOLcKeCBMGHLc8ZjzlvlAC0jSHqTGKxBPXGlRAJv2WDt/wjFq/rVWqzLbkFNz2MSXn75VcsSC16khbRE/e31TB+Tv6NypXG2Yu72Yz9MyUmIo1wr8Aj70HM4bducCWYznVkRc7Tfq1bkU9s+IkKc5yCx6A2VrtTRAX9oz2PTKd61e9EwRyn419SnAbc166G6dmxwXrbjBV6ljTQPf0Z6+MPFJC+Uv59HHbeC/gqIVMNRGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buo3+Ufm6/NwISfEt317znRdJ8LhWEWRfIcj9jXt/5s=;
 b=kGsNrxPatfjF6vhfJKNCeuvDr4RvOxlMZOthzBfK7FCfP/0PvzTAdu6L6mPr8sRjDwhQhjF5+xbevgxDz0sJ00935ei3y516lla1drtgfQ0nXNgUdW5q8m3ChgF54aLh3b81rL1OcxEG+H+wYOxpIIB7vMeFKPTnH8OWwDdWEu8qhKwbDGZgsYpXv3goxQOkhz3rWueAMs9w3BiGUl8Nm5Wu56G4vm73X6vUcG5+VO7uI5u7vyd1mjiapBhsXAKhFrlLPphMkPZ8+MLs9fip4q3tCbrjOadrjqBWfkSXRbKVLnt5CBbXFs0o3BD6BwioRCZyQ+Xnun9rWW2bdgbJIg==
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com (2603:10a6:10:43::19)
 by GV2PR02MB9567.eurprd02.prod.outlook.com (2603:10a6:150:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 21:03:57 +0000
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf]) by DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf%6]) with mapi id 15.20.8880.029; Fri, 1 Aug 2025
 21:03:57 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: tanish desai <tanishdesai37@icloud.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Discussion: Future-Proofing Git for Massive AI Parallelism
Thread-Topic: Discussion: Future-Proofing Git for Massive AI Parallelism
Thread-Index: AQHb+XNlVSr7t5kXDkyrjhZY1EgLb7RIm3EAgAW+2To=
Date: Fri, 1 Aug 2025 21:03:57 +0000
Message-ID:
 <DB7PR02MB4265771098F7314E47D9F2C0B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
References:
 <VI1PR02MB4271E311313F60FB07359BB0B352A@VI1PR02MB4271.eurprd02.prod.outlook.com>
 <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
In-Reply-To: <32989B0A-2DB0-4787-8A08-BDED46258C7D@icloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB4265:EE_|GV2PR02MB9567:EE_
x-ms-office365-filtering-correlation-id: 638512ff-cb4c-4057-2138-08ddd13eee3b
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|8060799015|31061999003|15030799006|15080799012|461199028|3412199025|440099028|40105399003|19061999003|102099032|26104999006;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFR6WW9ndjNtdXM3K2puamRVS254QWdIMlA1YkRTS0N3cnpiN1M3YVZ5djFJ?=
 =?utf-8?B?TUVvUTBFZmlsdGxIYmEyMURuUkQ4dU8rMkhwVGJMRHR4NW1CTXRMeWRUWnVH?=
 =?utf-8?B?UVlCNmdZTERPZWZneE5VaHczSW5PdWFxUWJDYTVHdEU0ZHVqUTBiNzFRZ2tJ?=
 =?utf-8?B?OGgxQ0wwR21Fd1dBVzM5NkdUZm1idEYvNThKM3A1TUtucjI1R3dHUnpyQ09R?=
 =?utf-8?B?SHdEcnFmTXNhU1hWRC9jdFJycjBNZzV0WndUQW8veFl6NUpiZzBmNFRqZmpT?=
 =?utf-8?B?dk55WVJUVndBRmdzN2k4VkN2UFBHVE5tU3I3ZWs5NnA4UllOOCtsaWV6S0E4?=
 =?utf-8?B?Sm42dnZhOXMzQXlhU0dYQnFtMW1ncXpWN2FIK3ZRY0VObFc2dUE4RWVWc1JI?=
 =?utf-8?B?VmVKKzdJN2hrTElsSWFpUkhZOEVxU2dlY3ZaRUwydFdVU3licVkyaUJwQzJv?=
 =?utf-8?B?cEFhYzZCWlR5WHBCR0Mwb1l2OVNPcHhnQ1BGU3c4YUE3Q3N5MW1JSUtkYnRh?=
 =?utf-8?B?UFBmR21kaEhadWxjWjZON215THpKWUpxYllyaFhQTktmWnlrZm9xLzNwZ09D?=
 =?utf-8?B?eUwzanFoQXErMU1kSUM2aWhqWUp2bWhIcFdkZUNobU1mY09jTm04QVFCZnpr?=
 =?utf-8?B?SzYvV3hRVG4yUWFGeXNNMWlnNVZCWkNQdzdqa3hxOHhwVDI1b3pvUFdhSVRl?=
 =?utf-8?B?THMrU2ExbTl3NXFQOG1CblE3YTNUV3VrUDJBdHV0Tk1YY0ZRRXF0emRJbUlh?=
 =?utf-8?B?MUpneFpYYWxwS2ZxKzZnNVcyVER3VXFCSXpudmR1NXJuUnVKZnVLZHNXY3p0?=
 =?utf-8?B?SmxvWEhWazlvWkMzVDVSSUEyMjBBN0FrOHRPQ2xYZkdLRlRDdkw0SWNNVGpN?=
 =?utf-8?B?dDAzdzVuT1JjL3BtV1EzbUw2NmsrUXoxNkErZEFrVHArV0dyb3dJL3h5THF0?=
 =?utf-8?B?RUZESVdLV0JUM3JiQU5UdFhOVXRseTArdnNWQ05xcHo3b2lZZHFxbWltM3Ry?=
 =?utf-8?B?SVNObUIrMmV2eHVWWVErUU54MStDTUNaRFpSUTFTR3VkT0wxampPN09ZVjNn?=
 =?utf-8?B?YUhneU5Fd2czUEIvV2k3UDNaWmk2U3RQeFlnSWlpZ2VpdE9zZ3d1Q3RkQndS?=
 =?utf-8?B?WjJqdklxN0FtcXpsL3BIM0cvbXV1a2h0NkZVTEYvRkkvT1lMRm9mcjEwcjZp?=
 =?utf-8?B?eVBpRzNSdnYzaUR3ZmhLZG1WQmUrSlZZKzdNSTd0dmFKODBhWFZ6ZWw2MTV2?=
 =?utf-8?B?L2RZakM0VUFVblFWRllzSUpNeDBDMWQ5b05raXNDSUpmUGhCYlJBZjM3OHFM?=
 =?utf-8?B?YytLWFpoYlRlV0t0d3VBZHgwYk9iTG9WTngyK20xaHdBZkY0YUVxTXY4eFpN?=
 =?utf-8?B?NkhFZEs2azBjK0k3UDdxVDZqWEx3cnEvd2pneGVRUzMrNmk5R3dUcjE2L2dn?=
 =?utf-8?B?VG1CaXRPM01lMmRJc056Y2Z3ekpoSHIvaTV0L3Zpemh2Nlc1TENBRXJSdHBo?=
 =?utf-8?B?d0tZSUtnRTh5RkRKQ3pYWmx1Ui9ocUE1M0dUdFF3UWlKQlVQQ2FkK1cxeUFX?=
 =?utf-8?B?UlB2MkMzQVFGeXVvSDBUWTYvdmlhaVVvYlplSWF6RHk5dzV5ZW9KRWUxbEZP?=
 =?utf-8?B?Zk5kQmpNUTBjSmtjeW9zcTUwbDhrK214Y0U4amd6SGlZcjI0a2hVckJLa2FO?=
 =?utf-8?Q?hrPJ3PCc84RYZyrI0KAq?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y3dSdWRJZXlwUlY0Tk1tYTdDSDJTNlRVY05vUkdRWXVlYS8vV29MUm1lRy94?=
 =?utf-8?B?SHpXQXN0NUR6Mlk1eGRTbGNRc0NaRTN5NDNWR25VRkVoNFA5MS9DRUpnMGZI?=
 =?utf-8?B?UHN5OTR2OGd6bkJHOWgrd0RmTWMxRk1WdHRwUGJRU0VzVnZZL0Nid2cya0l1?=
 =?utf-8?B?ZmZac1hQNWZZeVpxYlhCQnovdTNnWlNuc3U3eE9rOUNZNEkyRk54a05BMlRT?=
 =?utf-8?B?Q0ZycmR6VE43UHcvVDNkaVZFaXpYTy9XemZFUjVUM0RLb3h1TElDYlgyM3o1?=
 =?utf-8?B?c2h3bDJHRmFrRDlaQUdvRzhqMi9KQTdXM1JVdjYwdnhSQ1REYXVaVjd5QnF4?=
 =?utf-8?B?cXhUYTBlcGczVncwUVZiRXRYYmJWZGN3SlVZckRidTZtQkVhMHRGWksrbFhM?=
 =?utf-8?B?OGlraVJqSEYzWVphdWxMZ2ZTOW1EcGd5akpVNmJJN2xwZ2JDRDgvcG52dzlm?=
 =?utf-8?B?anlIeXhPU3lxK05mMkNibVEvaGxqVVYzTlJDUlVxZ0crdmpjb2JEcGFtblRE?=
 =?utf-8?B?S0NqVWpIVXNoZ1JDUlZ2MDM3VDhzeVhoNUhaemlPMzVES2htdkJRZ3FrSXpm?=
 =?utf-8?B?SDh0Q3MvdS85NHAvRDAzeTdBNDA4SDE5OVRkNUxxa3lSWnJ0KzdXcFM3TWJx?=
 =?utf-8?B?cG5pQ05zYTB6RmxvbFB1amdVcWw2Z1BMRTYydTR1STdVa2RUWkZUT3l1Q001?=
 =?utf-8?B?ZVh2V2Y2VTVOaEpJU2Fxc01sQjJWbytxM2Q4ZzAzMlVDS1VRVmFrOXdaMmNE?=
 =?utf-8?B?VE5zUHgzeTAwOU4vZURZT3ZGL2Z4UG9YRzhpRG9iZWxLb3dPUHNybHAxM09v?=
 =?utf-8?B?OWRhak1IWDlJK05abFNLV0paZW90V3RES1MzcERRVlMrN1FBMmplekhJSWFj?=
 =?utf-8?B?NU1zV0pnVDdNQzUwekRIYVZJTU8wcFdUT3lDTnJDTndHT3NJZ2lQcm43Qlpy?=
 =?utf-8?B?TDRUWGhWZ0FlTzFvbUlJeXpMa0hyT0tNbEpkZU9MTitzdEZ5TUxJSm42ZlE5?=
 =?utf-8?B?ZzBrK29hQmVNK1p4UWhlOWZoUTNqd3JVUXBOa3NBNkdKTUNITUR0S25zYThV?=
 =?utf-8?B?QkQrSkN5SjNJaGNrYWd6b1dPN2ExemVNa1ZQRzF6amozQnptU0FmWE1JcDBq?=
 =?utf-8?B?R2M0WTl1MUUxaldBM2Z6cWxLWUN0enhFbFNSclpkQlh4bmpweWNBaUV1Q0E1?=
 =?utf-8?B?NTlaaXJjRUw1b0JrYmd2dElFaFo4SnRmV01FcVJ4NS93MS8rdXRtTXpEY1d1?=
 =?utf-8?B?aDZFU0RFSXU1aFdVQ2xhaENjVE1VUmVvb0VaVkVJazkxMlZEbmtKZm14Rkh0?=
 =?utf-8?B?WVZvNEwzNFVwVTR2UnJGVytXa3FiWVlzSk5qSHpVdFo0MjBYV2ZVMlpWMVVM?=
 =?utf-8?B?a0xjc0Z5bmhGOXZObHcwTG1iMjdQNFhRZ1JGVFZrZ21kamRVNzRTZi83WUxR?=
 =?utf-8?B?WllZSkZJaVd3Y0hod3VVSGNGeVVyakgwaWV0SUdpeEtqSkhwVmdxU05uc3FQ?=
 =?utf-8?B?a2xUVGl3a1IzTmJoRzNvUURQbThidm5hZkttQ3hLdGdMUEdheS9zS0I1Sk9t?=
 =?utf-8?B?Mk1HS3FpbVVqYkdUVWJBL044YTlleG1RN0J2amRjTVE2UFhEZG9uNTdTczZr?=
 =?utf-8?B?RGNaVnUwWmp4MVRSMmJORnpuVVVHbmI0cUtKQ3lKeDZqMndRQTZ4ZFdtaUZF?=
 =?utf-8?B?ZFhJVlpuQlVscHZpYmkrT3Rva1ZUY05VRG5zcnhUV0owaFlIZ2xOOHgra2Nu?=
 =?utf-8?Q?jgsQ/W94g5Y6Bkx9nA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4265.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 638512ff-cb4c-4057-2138-08ddd13eee3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 21:03:57.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9567

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LCBpdCB3YXMgZnVuIHJlYWRpbmcgIQoKTXkgY3VycmVu
dCBwbGFuIHRvIGV4cGVyaW1lbnQgd2l0aCBnaXQsIGFpIGFnZW50cyBhbmQgcGFyYWxsZWxpc20g
aXMgYXMgZm9sbG93czoKCuKAguKAguKAgjEuIFdpbmRvd3MgMTEgYXMgYmFzZSBvcGVyYXRpbmcg
c3lzdGVtLgrigILigILigIIyLiBQb3N0R3JlU1FMIGRhdGFiYXNlIHNlcnZlciAoZm9yIHdpbmRv
d3MgMTEpIGFzIGJhY2stZW5kL3N1cHBvcnQgZm9yOgrigILigILigIIzLiBHaXRlYSBnaXQgc2Vy
dmVyIChmb3Igd2luZG93cyAxMSkgZm9yIGxvY2FsIGdpdCBzZXJ2ZXIvZ2l0aHViLWxpa2Ugc3Vw
cG9ydC4K4oCC4oCC4oCCNC4gR2l0IGNsaWVudCAoZm9yIHdpbmRvd3MgMTEpCuKAguKAguKAgjUu
IEdlbWluaSBjbGkgKGZvciB3aW5kb3dzIDExL25wbS9ldGMpCuKAguKAguKAgjYuIEdlbWluaSAy
LjUgcHJvL2Nsb3VkIGFjY2VzcyBmcm9tIGdvb2dsZS4K4oCC4oCC4oCCNy4gKFBlcmhhcHMgc29t
ZSkgY3VzdG9tIGRldmVsb3BlZCBjb21tdW5pY2F0aW9uIGxheWVyL2NoYW5uZWwgdXRpbGl6aW5n
IFBvc3RHcmVTUUwgZGF0YWJhc2Ugc2VydmVyIHRvIHN0b3JlL3JldHJpZXZlIG1lc3NhZ2VzIGZv
ciBBSS4gKFN0aWxsIGluIHRlc3RpbmcgcGhhc2UpLgoKKE9wdGlvbmFsIDguIEkgYWxzbyBjb25z
aWRlcmVkIE1haWxFbmFibGUgbWFpbCBzZXJ2ZXIgKGZvciB3aW5kb3dzIDExKSwgYnV0IEkgc3Vz
cGVjdCB1c2luZyBlLW1haWwgZm9yIEFJLXRvLUFJIG1pZ2h0IGJlIHRvbyBzbG93IGJlY2F1c2Ug
b2YgZS1tYWlsIGFudGktc3BhbSBhbmTCoCDCoCDCoCB0aHJvdHRsaW5nIGlzc3Vlcy9yYXRlIGxp
bWl0dGVycywgYW5kIGNvbXBsZXhpdHkgb3ZlcmhlYWQgYW5kIHByb2Nlc3Npbmcgb3ZlcmhlYWQg
b2YgZS1tYWlsIHByb3RvY29scyBpbiBnZW5lcmFsIGxpa2Ugc210cCBmb3Igc2VuZGluZywgcG9w
My9pbWFwIGZvciByZWNlaXZpbmcuKQoKKEZ1dHVyZSBtYXliZSA5LiBPbGxhbWEvbG9jYWwgQUkg
bW9kZWxzLCBidXQgbm90IHBvd2VyZnVsLWVub3VnaCBoYXJkd2FyZSBmb3Igbm93IHRvIHJ1biBl
aXRoZXIgbGFyZ2UgQUkgbW9kZWxzIG9yIEFJIG1vZGVscyB3aXRoIGxhcmdlIGNvbnRleHQgd2lu
ZG93cykuCihBbHNvIHRlc3RlZCAxMC4gTE0gU3R1ZGlvIHRvIHNlcnZlIGxvY2FsIEFJIG1vZGVs
cyBhbmQgbWltaWMvZmFrZSBPcGVuQUkgQVBJIGZvciBjbGkgdG9vbHMgd2hpY2ggdXNlIE9wZW5B
SSBBUEkpLgoKSSdkIGxvdmUgdG8gaGVhciBtb3JlIGZyb20geW91LCB3aGljaCBzb2Z0d2FyZSBz
b2x1dGlvbnMgeW91IGhhdmUgdHJpZWQgc28gZmFyLCBvciB3aGF0IHlvdSBhcmUgZXhwZXJpbWVu
dGluZyB3aXRoIGl0IG9yIGNvbnNpZGVyaW5nIGZvciBmdXR1cmUgdXNlLgoKQnllIGZvciBub3cs
CsKgIFNreWJ1Y2sgRmx5aW5nLgoKCgoKCgo=
