Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DD1FF7B3
	for <git@vger.kernel.org>; Sat, 31 May 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748682973; cv=fail; b=rYIfwgXwsNBXJk4eN7KZ+Z8QXT/+xvnu3jh49SrTO2TF9/mgzUqdzcZmL9VoNCVuoe+3WELw0IpRbk/JUbh6AclMJmksFVirFy6QEwhhaa1TvTqt0ShlQPBq3E1qXj9CYpyaXF4Idyye2JXfx95d2CMmE/GMkKywvqNu8Fjc1P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748682973; c=relaxed/simple;
	bh=X68uOnYWmnpJ4zkSh01kgQWvWjPFiqGKba07wUhe1Qk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dtF3lxIbFPW+gvbqziR+zQnZY3AqCHyi2in9+rLyoX96PyV132viTkWsMptP8OvRbqwuVCtQf3g0PfGwvLu6p/RxRm4pVDg8NbyYx86liy+Qu951Aos80DuqoSAuq/mL+sEFeR1eoFuv4oR8SHdp2LsPgyrxlQ/kSU59SG0jo3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MJl0K8Ek; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MJl0K8Ek"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrI+xWxInqJrCUdJwc0TqOPhPNQ0wbd9CBFUXAtycscPMh3TdVutxAn6QanLVJlT+FDoovC9blkkUN/S7Kvn0XF6LdDNdk055NXo0wuaWA/dqct4aLo7osQqj4m8rNyzQZcbGuHOfdVJQzNZRTY2CqP/YAaTmZy7TAcsub0c1n7yJ6l71LWjxMytgGvsvnr31uTRrqOJCw4kRhuOxsJS+OU9wT5FlBpLo3+rYk3DqvMCFCTKLVT1r5MhDa3jqx8Jn8GZsYbxRCEGo+cJWWs5R3OlG5LtYcFRGIlTiMef7lCC5uKqzR1/QNOHIHxxzuJnL3oMVe4QNJoE5eWHsGnJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X68uOnYWmnpJ4zkSh01kgQWvWjPFiqGKba07wUhe1Qk=;
 b=t0nuAeF+qeLXZ2Py9AVtoply6KMR8N65BNzN2SHh4SdvE2AVeIfO21JIgJcM3vz0iD/IOTHgDtFD2IvPNGLE0jFJaNkp6Zw0T8xJzK32RN8l2cLeA+rd4M3rzsUC1IyMkUp+3FKkmHUEH3fCi3Ps6usJycKnj+SFfyvrVTwjFbx7TdtgYJjYQ+JJPvM8DLyHXKivrrTxojEo4QepWhLGg/w2YOnz7J0h10bQOLMG7js1/5tNIXuUvF+pCatoPwogUjCnysQ8psun22sbHARgi1yI/cU8wZ1ESgvH6qWlepQyRFglBt3qEmo5ymZq50hO49UhNyUnE7b0bFLeE+mmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X68uOnYWmnpJ4zkSh01kgQWvWjPFiqGKba07wUhe1Qk=;
 b=MJl0K8EkH4oSQ+o9Nk3FkM7yaUqO609bbHxHEgpdeRKgVcVZCNDQ6GCFbdP78eLPR99sL6QqDP9uCPoIAuhBoI8n/XO5cbapkA672EKvW1/mAc9bfoZkhQaxzXsvEB709cb25nFglIItxiNjpKLJd3exQQVHpAgzYG/datoEbZE/ljDUn/xo+zawcHk/ghHHHcImXJEYkAnimQVYjikZIdvY5eUkJZlQd6eZD2EdSoDW1JyKTqglsTI9yWM/yc14RVviGb4vz2HyJrv3puKQJCiPg92oZ82SODMD3wcwtv6Cr1tKdSChpU4ExGpluefvOBV+6OxUtR5eeARPeiXS/g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5838.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Sat, 31 May
 2025 09:16:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Sat, 31 May 2025
 09:16:01 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: Re: [PATCH v9 5/9] imap-send: enable specifying the folder using the
 command line
Thread-Topic: [PATCH v9 5/9] imap-send: enable specifying the folder using the
 command line
Thread-Index: AQHb0YjbClAWJ2A620CpnutEL+L9xrPr54iNgACOpgY=
Date: Sat, 31 May 2025 09:16:01 +0000
Message-ID:
 <PN3PR01MB95978465D637DDDAE5B66D66B860A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597C14385FFA97ADF5ED3C9B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqecw5d2w0.fsf@gitster.g>
In-Reply-To: <xmqqecw5d2w0.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB5838:EE_
x-ms-office365-filtering-correlation-id: 3d893862-7558-40b4-06eb-08dda023c348
x-ms-exchange-slblob-mailprops:
 KW6s2gPZH1dzm1VGkT6pM7tyH8w6y9te7O/j5NzRjLef2/cw+vJfqAwjVHXpliNzxpi2HzcVwt4GuRSkwvSsQDQ9Zwf32qu1LRNnV5wp0TYIZLCST32DLKzWj9/rH/7T1/quP1nXhs5zUKfgUZwtpbqZFF7CVoehEk81EWL3bDLzKeRKgxdC3AvYXp9NzqJv9pZp8ejVY+wEHxwa6p778kd9QlxdOTMGMap+AKu4K8y6pr6p0BvhfJrv4BHlM29Urul3Mj/3mzvAMV+eEx+I11vn/0KFOl+3F9lCVqrEmbkkQp22oJSuzUUHs1tAJavliZ42gmvFegCVZSzPf1IWEuiLVX8Vrt1vBlEC2P4yxXTTWmCTBuT5h8OvSPpmQiXfjRZiOyONd9MWfOjx+AWswwaoWCrl/wOBUk/35O/oFUm5LHZD0NLd7gqaZ6Tep51cGjWycCM4Es8M/1rywjE1YsEGIb8cSln5+6FnYGTcG5w2/ObQYZJl2x0tEJVpmEbXDhMHSGaHwn4JXCx1e8F3fTbqNJSROvDQXzdx55yVpyZbhiAR6NJHtaGk0e1REH3x/KQAJuotAtys3L/TXmutljLp/cpMTrGuOIS0yDFysNaNEBSMZkfiaHD/nA+zsMsL+mEu9KLv8am/h20FfMUcwV2zn7U0XviAupI3VXost1ULiMwM264ri+nPY3cgd4sFHm5IER74zZU6hJqqF4xKBtMi3mXBzXJionvoQaEc6UY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599006|8060799009|7092599006|19110799006|15080799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?S0xDSGxORnJHbGVMc0U4RFREd3NINnIxSFAvWURPYlFibG5aTVZOaS9FZm5T?=
 =?utf-8?B?NGVONUVXeCtzWE1DQzZpemk2Z3dsMm16L3U2eTVtYVo2SEhQSEE3Q2dyR2Fk?=
 =?utf-8?B?SHhleDFQcDdnZ0xoUWNORHFDWFVySGdZTXRtYUQyUVRGVi9SV3JTcnhzOWZJ?=
 =?utf-8?B?RnN3THhPckJuRUVxUEx0UHNSOEwvOTY3dzRXZTNxSkJsTXhnUExINi93RjRq?=
 =?utf-8?B?bTFsTEFXMGYrbjRPU1lobWJIdVFZSk1rNUxob1VVNFV2NWFBYUV1VWdRWnZW?=
 =?utf-8?B?dCtyL0l5ZEc4b29aUGVhQ0JzSG04L3ovVTliK1lBMFg0SDNRM1luWWpKa1Iy?=
 =?utf-8?B?S1pWcFdQK1JQZXdSZW56bHhmLy9EY2pkZGZDWnJvY2FsNnBRNjRLNllJNyts?=
 =?utf-8?B?QVBrdTFYbC84QmQ3aEtMaHNOZlJ1SmxmVUh1RXZSK2IyUEsycEpDNWllaXJD?=
 =?utf-8?B?VFJGVjlOc2J6VU80WU1hZ1o1Q1NtRFVvTDJ5RlkrNVVEejJ3NlRpNnFFTTUx?=
 =?utf-8?B?TzIyanM0SDNPcllXRDY0Tk1jZzBjQnZrNzI3UDIvbE1WWGRlQWdmaWQ1aGxM?=
 =?utf-8?B?SlJCMUdPNHRSRGUvTHcxRURNNVorYUkzSmROQ3FsSzl3ZTFWa2ZxTU1OVFlC?=
 =?utf-8?B?L0tCU2daN0hIUFd2WjdpaVMwRGVuSzArR2tUZ3c5RWZFSW1HZkJiSEcvQUtB?=
 =?utf-8?B?Rk52OEJFUFVJb0MvZFNrcEFhTDYyY0pqWWczUSs2c0srempLRm9CRzhCbnBU?=
 =?utf-8?B?MVREY2FwanFncVpFNFpWMUtOc1RsU21uNTBrRmR1bkhIck95MnprN3pvYmpG?=
 =?utf-8?B?amhORWVlTXlaazYrdUxTNE8zbGhzL2JEbmpXeGk0aUZFTEJZWGtReDNqYndO?=
 =?utf-8?B?K2xuTzl5YjZEMlZnazFjckRwS2NMS3M1Zkp1K2JmNHdtNFNWdTRLU051L0J1?=
 =?utf-8?B?NFMyM2hLWERwdEtOSWpIbXlhUUdCY2pWVjl2ZU9OU1d4MG05azRIQmd5VmlE?=
 =?utf-8?B?dTh1M29nMko4aGNDajVIVzJkbFhHZU8yVTRDTjN5djJQd24wdDE0YWFGSHd4?=
 =?utf-8?B?MmJ3THk5azFvSkU1bnRQbmhVK3VpTjVNK1RWVU5UMWlrZ2lwMkR2bkM3WGht?=
 =?utf-8?B?YXpZbk1hR0ZoNzcxR2VFSW4rZ0EzT2dzM0laVkkzQnE3YUdVNEFZUVAzQUl0?=
 =?utf-8?B?WE0wRk5oWUZjTzZXdUtNRy9KT2lETElQNGorbndpVUdaTnNkS0dLU3Y4bW5w?=
 =?utf-8?B?RU4xMVg4T2FSd213SWpPNG50WEVjaVZCa1Vqc2NXMFRrRGtsQU5mUFVtRGtO?=
 =?utf-8?B?a3djdzlGaWJwVTY2c2plZ3lZdWpNemNyYzBaaVhWVXI4TGE0S2kxQ2lsM2dy?=
 =?utf-8?B?cFhGSjhWdlNvZjVNRnV1SWd3dmxUSTlLKzlGMzVUNlN4K3VZRFpLYUJmZUVX?=
 =?utf-8?B?TDEvMW01TkFmbXI4RDdNaVlrcjVraFZvU3hVYzBvd3N6dm1nK1ZJMHVvVTE5?=
 =?utf-8?Q?j7hECcgq6DQ/t5yJCI2vWv61zkZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1l6Q3RxVW00OVN0OFZ3MEtuMkMxTGZLVVA1Q213eWlDeXRnWmpSWkRIbE41?=
 =?utf-8?B?MEc2dVVKekNqVnY0bjhZWDhVRW8wNnNPOEpRUmY0TWJGOXFNMHlSai9Kalk5?=
 =?utf-8?B?MERGQTgzaFlGUTZ2Rmp0R05tRGduNlpnOHlKT051QjRQajMzNnNISGNoMWNy?=
 =?utf-8?B?YWxwVjdFbmhRa2FValY0Z1NST01STjQzbVQyOGlEUWxPYVB2c1REWlpuWHRO?=
 =?utf-8?B?eExHZDk5cXYxVVVBZ1p0TEhQWkJaYXk5ODU0T29PRmRVK1JmSkJZc0VMemdy?=
 =?utf-8?B?K0E5VU1EV1VMY1M5QzJhRytSaHpYTDBRVGo2T1ZZRXMzeXdjNWViaUI0d0xw?=
 =?utf-8?B?TXhnR3JORkJJdnZKalFhWE5wbHBBK0JmeGhiNDdERkFmQTlMR2ZoSHIwMzR6?=
 =?utf-8?B?ZjlBSDF5NXIrTG10Qi85V1B3OUtORHQvOXlGRGl1VCtXMkZVcEM0bm9IZCtE?=
 =?utf-8?B?ZTRva1dmNUJub1hYMm51b0c3VHkzaUlldTFvaS9YOEUzVGxRQy9aQyt4b2Vt?=
 =?utf-8?B?Ykh1dTRBTVRMS3FuLzhrUHVVMk9qVVRzRTdNcm0wTmxwS0UzWTA5VFVpcXBX?=
 =?utf-8?B?azJOUFI1bXpXV0dkUVN4ZExKZEZpOVNzbkVlR3Z6R0NJT2VsZExBcThWU0NF?=
 =?utf-8?B?RStuRjlWQ0RwV0NwcVRINGJPdVl2L3NuMTdVSWxRL0gwcG5NOEM0Tjl0TVJY?=
 =?utf-8?B?ZG0yWkZ3T1J2Ukk3KzdBNXNLcU9UYmpLR004Z2ZkSmV6K0JaOVRsc1ZSSUFv?=
 =?utf-8?B?d2xMcDdlbStDNkY2L2tEa1pnOXUvb1BMN21XNkFEbEhtcXVZZEJMU3Evbk1l?=
 =?utf-8?B?SUJac25tdXNlVjNET1ZFeXBNRFM2L3JXZ0Ryc29pNjN3NjNUWEI0aTdTMVFx?=
 =?utf-8?B?NUhhTmg5OHRFaDVrY25weGpZaU1NTHdlOFVoRStHUEtNektDNjFjVVM5Q1hK?=
 =?utf-8?B?TmVJVzhWS2taQkQ0am14ZFFmdDBudGFhNEdWcXdyN0xBc0pxdnFhTmpHcHF1?=
 =?utf-8?B?bVcwbFc3MVVzWGZDYWVzMGVWZzk5bHlxZzJONUhEU3ZpTVFvK1JXR2l0Y3ZW?=
 =?utf-8?B?dDRsVFhSQzN6R0dPb21INXRKeDhCaWxlMy9iNDgwV2NYYlRQaEtHQUViNnpO?=
 =?utf-8?B?QUNoM0k4Y3IyV2VCZzNsSWFRVFgxYklSN05PWTZrSzhZYlhqV1ZNU01pNjc0?=
 =?utf-8?B?ZlkrWkdIc3pKdmxuT0FqQkFIVlhWTUQrejlIcFBuR2tleDV0K1B3eXE3U3Ft?=
 =?utf-8?B?ZC9KUkZPUXZtdHp2SUJIbjRxVzg5WjBzL2tHRlU2UHpwVmdidGQvalBqdWxF?=
 =?utf-8?B?bUhtVitiaHhoSDU2dzJDL1RFTCtLYnJ4N1R1VDM1NUFma1FVWWtxcys4c2pT?=
 =?utf-8?B?VEN0Z1FBWFRyS0tsWWF3TTgrZFlnajQ4QUM3OFVoTkJHMGw0ZE1WcmxOYWNV?=
 =?utf-8?B?dDRXaG83cVhUNGxVdDdzSVhPQW43cHk0L3NINTdBa3BaNnoyVXJTRkN5TXlS?=
 =?utf-8?B?YjlWY1lUeGlaUXBTOHkzNjVOMmdBRi9uNVc3S1lPMFFibXptODdBdm1ubXNh?=
 =?utf-8?B?eW56UlgvWUFxcUIwbW9NY000MEVXVkFSNWZsSzd0MVVHb1pvMDNOdEloeGRV?=
 =?utf-8?B?aTdxYzc5M3dHeFpFYWNuMWRDY3RLTFV3QkhOcEYzdk1WWXQwcWk4b2tpSFBO?=
 =?utf-8?B?a3JPVFNHb0xtclpiQTMvY1NTNmI5aHFzaG5mZzBHa3IyZFpiQjJ3Wm1xN1Vv?=
 =?utf-8?Q?C8ojBcPaV5Jhng2Pss=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d893862-7558-40b4-06eb-08dda023c348
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2025 09:16:01.6496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5838

DQoNCj4gT24gMzEgTWF5IDIwMjUsIGF0IDY6MTXigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBTb21lIHVzZXJzIG1heSB2ZXJ5IG9mdGVuIHdhbnQg
dG8gaW1hcC1zZW5kIG1lc3NhZ2VzIHRvIGEgZm9sZGVyDQo+PiBvdGhlciB0aGFuIHRoZSBkZWZh
dWx0IHNldCBpbiB0aGUgY29uZmlnLiBBZGQgYSBjb21tYW5kIGxpbmUNCj4+IGFyZ3VtZW50IGZv
ciB0aGUgc2FtZS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4NCj4+IC0tLQ0KPj4gRG9jdW1lbnRhdGlvbi9jb25maWcvaW1hcC5hZG9j
ICAgfCAgNSArKystLQ0KPj4gRG9jdW1lbnRhdGlvbi9naXQtaW1hcC1zZW5kLmFkb2MgfCAxNSAr
KysrKysrKysrKy0tLS0NCj4+IGltYXAtc2VuZC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDkg
KysrKysrKystDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+IA0KPiBEaWQgeW91IGZvcmdldCB0byBhZGp1c3QgdGVzdHMgdGhhdCBleHBlY3Qg
dGhlIHRyYWRpdGlvbmFsIG1lc3NhZ2VzPw0KDQpJIGFtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4g
aGVyZS4gQ291bGQgYmUgbW9yZSBzcGVjaWZpYz8NCg0KSW4gYW55IGNhc2UsIHdoYXRldmVyIGZv
bGRlciBpcyBwYXNzZWQgdXNpbmcgdGhlIC0tZm9sZGVyIGFyZ3VtZW50LA0Kd2lsbCBiZSB0cmVh
dGVkIHRoZSBzYW1lIHdheSBhcyB0aGUgc2FtZSBmb2xkZXIgd291bGQgYmUgd2hlbiBzZXQNCnVz
aW5nIHRoZSBjb25maWcu
