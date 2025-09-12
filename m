Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011024.outbound.protection.outlook.com [52.103.14.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F73019BD
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684272; cv=fail; b=crkyJ22OfcDGR2EwkwSKzT/M2JFAdFncJNxCDLMUllIr86W7X39zsp9JyjcYdQnB4qo24oLXHlY2iLEZFpcW0Uhl5q7VyUdHtEo4/DVnbFzRUffekf6UJbYt7VTNikenblTO7lt8G70jrxULrODgInrLKXEGbFojN9yjoZJ5pp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684272; c=relaxed/simple;
	bh=IGoCewONK5YXMejDj16d2lZ/qbYVPHpEnwB9jpmWKrI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qD2jxJ/roYOLiLlKUzOeJQNbHa4PEBG0hZWfNX6hb4ayc+Rc1LMwr42vWTclKwLep0x2gocv0YZxEefWSl1AGOQ/wI1AowDHBUZvY5TjC8eqdGVzhViDiVQYQI1iM9QSReX7SFul2jy9jb+dnboBZKT0vfiABn6332Kg9gEeDQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DqQeZ4Wx; arc=fail smtp.client-ip=52.103.14.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DqQeZ4Wx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzJl5+AnDlRhF9QhR5Wkn7tvgt0sxwkXkVV2J9wwEe+I5SXm68sZ3LmLPSpGjo7FZDYiCLtw5VNsFGg7MMTXuA9fJc7qoXIUQ0foKIRYeUJYNo0fiJOBhkw+9tp1oWp2S0WhjKiJjj3kNoe7+mwDV1HZkj2jm0gcLcen8Z4uXW6ElI1POOqgNJkOXnDybDZ2tuKWooMGByfyNd2DLANKVIJuqxf/u/kGWS8RAJDdlCat8kiY6m39Ca8N3H3chQbredlzmopvD5FgTrQ/ytdRpcLE6N8UwOPDgxV/oJZt13VtzEjV3Xc2FQEbzGX2TKtttActCkL7DpuYiQjIo0WfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGoCewONK5YXMejDj16d2lZ/qbYVPHpEnwB9jpmWKrI=;
 b=LXQ2RuNMh3SQzE86byvkgEXPyGoWD3402hVWPqAxycvsMJplS4zo3GyFc3WohcXDPTaod0CsiCK5fnUfH1dlQejHHK0oD4But6WYHPrsyirYLmj8kVgbWr2MUXZKdrobVCOtpAEHa3F+6ACbZl5ZB33Mbm5AOBAtQ6D0drA9NIPa6ccEUswHMjrcqraST/Rvy7Vx3O1ZmO/29EO94i7F3CMAIwl9d0eb6DJZsv4m9yJT6a1N0G4cKLLfZg1sxloZU+A2/qPCcH8JkU2mtc9DV3ipHhHACsppEI7E4G8PrSrNueHmUvMF+hGIvLI58H3/AqHd1YUs7zloC5T3WO6oNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGoCewONK5YXMejDj16d2lZ/qbYVPHpEnwB9jpmWKrI=;
 b=DqQeZ4WxBvRkJ7Ev0L62Yng212TrXRr/btv2Ne6UqR1A35gl7PRAwGRvUMEvQvwOEVIQnAYdZcHWFOQMZcZzaC3QQz3xL8BpGqJVQ5BZNGfuAg6s3uPLIuL886TRl56yHb4db/r94ncQZ+lLmYwSKVDhJtXkN4cuVtXwu27eb+6wan+wTBGB120Jr9R9Lp4acChKbxfX5Z/m8HOUfbEMWW1v24hf6Z1onME3CUEYrFmOEDiWr3vq/akCHbMCJnXUSfF0pi6AXmdy1qgtAAZlzySNwqLLU/UrEvERQBDOG6Yu61+kDgnWs10CObG2EP7sOvGVVr28z/LqL/vH9EUI7g==
Received: from SN6PR03MB4285.namprd03.prod.outlook.com (2603:10b6:805:c1::17)
 by SJ0PR03MB5407.namprd03.prod.outlook.com (2603:10b6:a03:28f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 13:37:48 +0000
Received: from SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b]) by SN6PR03MB4285.namprd03.prod.outlook.com
 ([fe80::c791:d115:d795:c7b%5]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 13:37:48 +0000
From: Guo Tingsheng <CoriCraft16@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] git merge reports conflict when two branches add independent
 methods at the same location
Thread-Topic: [BUG] git merge reports conflict when two branches add
 independent methods at the same location
Thread-Index: AQHcI+ovxgcVdMRdyUSzicmFsl5sEw==
Date: Fri, 12 Sep 2025 13:37:48 +0000
Message-ID:
 <SN6PR03MB4285B971FAD1CD485B9A8840AE08A@SN6PR03MB4285.namprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4285:EE_|SJ0PR03MB5407:EE_
x-ms-office365-filtering-correlation-id: f01d83cd-c9af-4b77-7716-08ddf2019040
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpVAjouTXUgUPX+o0ch3BuGwXxwJ6xlfJPTjolRP9y40nyjJLjSErkcpGLwzLetE4PMyKp/mgipcnxmHcnc41FEa7P4rIXg12yOoqA6DERXQF30o0bk2dIEIEsYlgQxRlNODmQZOyjrPcs60hxQViv2Bd8M7MqCGYKG/+B+kxz3t9FP0W0FaDYvdcxmsbZU+dNuVZVDONqJF0mssyj8X/ioee9sNpLJIoWv1WLKWV9/Db1itySiRiQQ/H5LKGFLEU+cdRyMCxM4Xw9Ta3TCz8Uo462ZlBIKbK6ED7Sa75jEkisiKlpphB+k6QhPMHVi6pHhn1bXiuOkZMnWa5SwtgDfEbPo/+kxvGvRPaHPTUb6E9/T5r2YN3Q+vAiWGD8yfpRs2ZELN0/jSwIzxh4I/Ot8LA1nSj//qdRpUUa9QUC5k4E4DSKrdXIyZ2GoYU/CRgEPS4CjVFQfJ3bspY30lR0Ew5NYa2bNl8SAeZgjbXJokHRI+N/liIPINanUHZcGSR71E8C9VmEr3z7sIUjtxJvXJzWE2OtTOHckvziTRHQBLEsWVGGZg7gyLR0k24UW7VCFQjdF+ZjmOYNULy3VVftMYsb/1v+ioHqBIiXYDb1lqunASTz5n8LO8dSto23k0Ml2TlRLGmzb3YwoMm7V2F8bQPktMBkwBOD5JsyOIZhWc97zR8xEwvQtyv3WBdU+yqBmrZDO6VkmaUAHb56LlzYYktS9iqNgkBipWzFP/4QFwq9060ZuKrJRO
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|461199028|19110799012|41001999006|31061999003|7042599007|15030799006|8062599012|15080799012|3412199025|40105399003|440099028|12091999003|3430499032|102099032;
x-microsoft-antispam-message-info:
 =?gb2312?B?cFF5WkY0RnZ6Tm1MWENzZW5QalcveERtcSswaWp1T1dWeGlOTTA3dWh1dUti?=
 =?gb2312?B?a3k1WDl6S1I5bTJ0enRrakxLQ3FubjcrWmNLdzVwVGdhVUVIZFlEZU1zZXkv?=
 =?gb2312?B?NVB3cDBpZ3JLU3lITHNwRmoyNWJVRkRNaVZ5K0hJWkFqRXRRZ2cySEZISnd1?=
 =?gb2312?B?MlJFZ2k0WExtaTFWTXVNSUtmZmFHME1qNWNBZFdpVFYyTGVhcDdFeEkwNk5l?=
 =?gb2312?B?bVVNakRsN0kwbnlVTlhMTm9Lb2lXTDBWZGp6eWtUME9SZEZ6dlNGNEdKNFd3?=
 =?gb2312?B?L1h5MVl6c3hLaWVFRGd2UFpIZkg1YnFLVjVpOXhUclU1Z3M1bjBWZnhONGdu?=
 =?gb2312?B?bE9kUmVCVGVvbHpVRldwdVM2Tzl6S01POWsvaVkzbk1oU1BQL2h2YmZvamFR?=
 =?gb2312?B?K0p5ZzhMOWc3VXc2QU5ITkdzS0tFcFBmbFJYNWdwRUxuMFlVNUpQdlcvQ2U0?=
 =?gb2312?B?dGsrd0tWQXdlMFpxWGpLK1lWcllSZnZmUEdyNUxvcjhTUGRzM3JiYWl1UGFS?=
 =?gb2312?B?dkF0T1RSUGVZWFMyT2tMWlhpVFFiY1FHRnB0bXFNUXJIUEQySTlNWWMrVFhq?=
 =?gb2312?B?aWpFZEUrOUhoSTV2UFhYZmhNQUZsV05rREJabE43bndLblBVRjRJUm5ubUZ5?=
 =?gb2312?B?RUpkSzBYTm8xOVhLK2kvYzdzU25JcFJUWERJcTkzeUFwL1RpbEVlaCt4OXRH?=
 =?gb2312?B?RkUwQmlLVlNzQnJGbTVSRUZidGRodE9SMTlyMnpYZ0lnUzJqakl1eEUrdkFl?=
 =?gb2312?B?RWFTT2ZLampMNG9Wa2JTeG80RkZLSEtpNW5Qblpvd1g3SzI3bmx0T2RBM2dx?=
 =?gb2312?B?TzhhTWZZUWZrZXpSdlFWZkYyeW9lSGh2MGtwb2c4RC91M2dnVTJHWkt4T3dX?=
 =?gb2312?B?TERKaXE0dFFUVjMvRjFzOERKUVJNM0d4eC80UytJWUcrVmRyWjlkZFNpY0c4?=
 =?gb2312?B?UU92KzlKQWxKb1NxK1BFKzdEcUcvYUZXSkNralAwN1FHaDA1UmJFR2dxamZX?=
 =?gb2312?B?NFJsUmdwN0UrZWk2L1VYM2pReWR3bTZjREk5OXZHeU1iSlMrSGI2Sm1UY0tR?=
 =?gb2312?B?OWRqNVpRU1NhbGRoMVBkV0FZQ3BBeHpkb0E1UHgyeEl0MWZzVUxmc0Z6MkRO?=
 =?gb2312?B?dVZFN3grOCtRZnRmWFhQdlpEdkh5NjBXdFhnUy9uRzNxNEErUXZwV3BsWUxr?=
 =?gb2312?B?UFUvYk8wdG1sQ3VNMkxzT3EyYzJQWmN2MTdFa0p2MGVMeEkvT0YwRzhicXZS?=
 =?gb2312?B?Y1VZanU3QW1JYzVBUmR3aXJTUmlKNXljSkRFNUh3MzhpNzVTcEZaR2MyZi96?=
 =?gb2312?B?djcybGs4SmpxTndRYnBxU2t5Uk5xODRyNS8zTXdhNWd3N2oxOHhFbFZ3cjdx?=
 =?gb2312?B?WFlTWGFCbDBWUGRBRkhWaXhmaHZwSytUZGJzQThiRzZLOUdFclJLb1lvOTlv?=
 =?gb2312?B?OUtqc2dmYmFRUTJmdkQ1WjRYOEdBY2lxTnd3RWo0Z3RTSmhzRCtaUmYwQ3Zj?=
 =?gb2312?B?NkFxL245dmRvOEZjSmZhckd1bHE4cC9nMCtoanhxZTNseCtKYjI3Q3VaUGtC?=
 =?gb2312?B?UWJjbW1EeXpkdFlNOFBVMDl5UUM5YlRGQ1plbm5GL2l1ZWx1YklTd29OWDM3?=
 =?gb2312?B?aUVIdGQwYUpUdE1wZDlqZ1VxeWtJREZ0Y3A3VytTaThQTVRkSVFGVnliM1ll?=
 =?gb2312?B?aWxrbERpS2RCVDBOV01GQ3NldVkwbWJleHVCQ3VIZDJCMFNLTkl4S0lBPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YURaNG9pVFRpTGU4djJCM3FhOCt2a3RvRmFVbUhudFlSY0VpWVg1R2lFTVV3?=
 =?gb2312?B?Zm4xaWxscU1HckdPbktlblVwTzRVRHJpT0IwSytsUHZQT3ZLSGt4WnE5WUt2?=
 =?gb2312?B?ZTU0UzFjZy9kWlRON3dySGs2R05YZFpxc0N6MXdjbEIyMXBRRlYyclJvdGgw?=
 =?gb2312?B?Q0pZNFJQTDhldnAxOU5XWjl2QmFFUmQxYTU4VWVyeS93NE5GRk5aWkEyVXZm?=
 =?gb2312?B?VEErRUtlaVdMam9DczBCQ240VnBtYXAyeTYxWlF5Y2h0WUlqdVh6RTh0NEF1?=
 =?gb2312?B?bXpsaEEwTlZwU0hLS2twMU5lcU9IR08wSHZCVWJDVVBXSWkvUm5YVkZ5aW1k?=
 =?gb2312?B?VHhEakovQmJiZ0xkeVdhaFhhR1Q3SGUvZ1lobWlJWDcxUTJOOEg3Z1BHamV3?=
 =?gb2312?B?dVMrZnpIc2duSnhXVzVxLzNPVUJPdWZ6dVcxZHVZWVFBK3hlcUErZGNEeWp2?=
 =?gb2312?B?MDFMWmNQY2I1QUQvdk9QWUVybXlUUzNvMEJ2R2wwZVF4b2M4YnRIWE5wUk9Q?=
 =?gb2312?B?cFdQSDFrd0FxcTZpZW83dUJCTkVabFlHNHJCYkJwVDRTQ3lmZUlCMmdzNHFY?=
 =?gb2312?B?cDlwdWNPOFhOYkRuRWU0QzNRb2hHQU0ySHh2MVIrWmxWZU1ZNFUvOVQxbG1u?=
 =?gb2312?B?SkRxcXd0eFFPV1F0eUMrVllvQytPdUhhNmJrU1Mwc2l4RVY2Tzc2UVIvYWVR?=
 =?gb2312?B?UWhrTjdZWTJ0THJmNDkvZWVIWGlPeVVXeHJoZVlQc1lCWFlsK0ZQMHBPNFhK?=
 =?gb2312?B?WGxzRVVvQXRRZHZZMGZkdFE2VXRlVFJOQXJMWW8rQXlNNll3TmFFQUMrbWtL?=
 =?gb2312?B?d29TdjFWcnk3SlBHSUdxbU9sY1ZtM3ZRc2pEWXRiNlRLUDFHMHhBY1ErRzZM?=
 =?gb2312?B?ZERXb0ZBZ0dVaFpTcnpyOFVvWEoyaVV3RUFuNTZhWHNtaFBWSWtSc2lDY2VY?=
 =?gb2312?B?QUM4TndXcCtOUUVJN3hJUm5zM1piQkRpdkYxTGpBRGZTZFcwV0NHdTdBZHZJ?=
 =?gb2312?B?b2sra0xtQ2RPT3ZlNUViMmc3WnBhRzl6Q0ZGOXJlZ2lXbkcrKzRYdVZxRWFG?=
 =?gb2312?B?VkhyKzAza1N1WUtuTTN1SXpvOUVuQ3o0bXZ5VFJRTnM5UkRwWlZKTEJUUGw2?=
 =?gb2312?B?ako1SGVvSlBrMnlwMjJXbFc5Z1Y0Um9KeCtRMlU5SE9lRkt1VTJ4VDZld0d2?=
 =?gb2312?B?VEY3YkVsQm95cGllR2gxNXA4cG40UzNFaW9wM21NZHgvV1daYk5QUWZWbWht?=
 =?gb2312?B?dk8vNTBEcE9NQWJxZmlObWljQ3hOc081NmZkajZHSlJxdVBWMG5lVEtsQTlj?=
 =?gb2312?B?ZVNOQ3FLZFJUdTRKN2JzTTJ0NTYwN2JJL3lUVUlFdU9RUmtYRlFoajRpZkp5?=
 =?gb2312?B?eUl3Mk15d2RzaWtjbU00ZWpsNWoxMmRNVkZXdWFiS1h6YWxHaGc2Vkw2RW5z?=
 =?gb2312?B?VWh6ZFVLVS9KTlZjSTdieDIyNGxkdDNWMlYyK1MySFhLMjZ3UGRFMkIwZU5l?=
 =?gb2312?B?enV2U1JKSENMaU1XcTFjcThXYzIxazk0OVFHNHhhdHJDcDdoVEFQdWFjWmhF?=
 =?gb2312?B?aE55d0pCQ0FLbnFSTkQzREtmOE1TT0NyRFpzTmJpWkNRWGxhNTZQd0FTZHN5?=
 =?gb2312?Q?61yoH2SfbNX4jRdmnHbqlIiL6IBNrqpbToetj2DuS5zo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4285.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f01d83cd-c9af-4b77-7716-08ddf2019040
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 13:37:48.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5407

SGVsbG8gR2l0IGRldmVsb3BlcnMsCgpJIHdvdWxkIGxpa2UgdG8gcmVwb3J0IGEgcG90ZW50aWFs
IGlzc3VlIGluIEdpdCdzIG1lcmdlIGJlaGF2aW9yLCB3aGVyZSBzZW1hbnRpY2FsbHkgaW5kZXBl
bmRlbnQgY2hhbmdlcyBhdCB0aGUgc2FtZSBwb3NpdGlvbiBhcmUgcmVwb3J0ZWQgYXMgYSBjb25m
bGljdCwgZXZlbiB0aG91Z2ggdGhleSBjb3VsZCBiZSBtZXJnZWQgYXV0b21hdGljYWxseS4KCkVu
dmlyb25tZW50OgotIGdpdCB2ZXJzaW9uOiAyLjQzLjAKLSBPUzogVWJ1bnR1IDI0LjA0IExUUwoK
U3RlcHMgdG8gcmVwcm9kdWNlOgoxLiBTdGFydCB3aXRoIGEgZmlsZSBjb250YWluaW5nIG9ubHk6
CgogICBwdWJsaWMgY2xhc3MgQ2FsY3VsYXRvciB7CiAgIH0KCjIuIE9uIGJyYW5jaCBBLCBhZGQg
YSBuZXcgbWV0aG9kIGBhZGRgOgoKICAgQEAgLTEsMSArMSwzIEBACiAgIHB1YmxpYyBjbGFzcyBD
YWxjdWxhdG9yIHsKICAgKyAgICBwdWJsaWMgc3RhdGljIGRvdWJsZSBhZGQoZG91YmxlIGEsIGRv
dWJsZSBiKSB7CiAgICsgICAgICAgIHJldHVybiBhICsgYjsKICAgKyAgICB9CgozLiBPbiBicmFu
Y2ggQiwgYWRkIGEgbmV3IG1ldGhvZCBgc3VidHJhY3RgOgoKICAgQEAgLTEsMSArMSwzIEBACiAg
IHB1YmxpYyBjbGFzcyBDYWxjdWxhdG9yIHsKICAgKyAgICBwdWJsaWMgc3RhdGljIGRvdWJsZSBz
dWJ0cmFjdChkb3VibGUgYSwgZG91YmxlIGIpIHsKICAgKyAgICAgICAgcmV0dXJuIGEgLSBiOwog
ICArICAgIH0KCjQuIE1lcmdlIGJyYW5jaCBBIGFuZCBicmFuY2ggQi4KCkV4cGVjdGVkIHJlc3Vs
dDoKLSBUaGUgbWVyZ2Ugc2hvdWxkIHN1Y2NlZWQgYXV0b21hdGljYWxseSwgcHJvZHVjaW5nIGEg
ZmlsZSB0aGF0IGNvbnRhaW5zIGJvdGggbWV0aG9kcyAob3JkZXIgZG9lcyBub3QgbWF0dGVyKS4g
IAogIEZvciBleGFtcGxlOgoKICAgcHVibGljIGNsYXNzIENhbGN1bGF0b3IgewogICAgICAgcHVi
bGljIHN0YXRpYyBkb3VibGUgYWRkKGRvdWJsZSBhLCBkb3VibGUgYikgewogICAgICAgICAgIHJl
dHVybiBhICsgYjsKICAgICAgIH0KICAgICAgIHB1YmxpYyBzdGF0aWMgZG91YmxlIHN1YnRyYWN0
KGRvdWJsZSBhLCBkb3VibGUgYikgewogICAgICAgICAgIHJldHVybiBhIC0gYjsKICAgICAgIH0K
ICAgfQoKQWN0dWFsIHJlc3VsdDoKLSBHaXQgcmVwb3J0cyBhIGNvbmZsaWN0IGFuZCBhYm9ydHMg
dGhlIG1lcmdlLCByZXF1aXJpbmcgbWFudWFsIGNvbmZsaWN0IHJlc29sdXRpb24uCgpBZGRpdGlv
bmFsIGluZm9ybWF0aW9uOgotIEFsdGhvdWdoIHRoZSB0d28gY2hhbmdlcyBvY2N1ciBhdCB0aGUg
c2FtZSBsb2NhdGlvbiBpbiB0aGUgZmlsZSwgdGhleSBhcmUgaW5kZXBlbmRlbnQgYWRkaXRpb25z
IHdpdGggbm8gc2VtYW50aWMgb3ZlcmxhcC4KLSBJdCB3b3VsZCBiZSBkZXNpcmFibGUgZm9yIEdp
dCdzIG1lcmdlIGFsZ29yaXRobSB0byBhdXRvbWF0aWNhbGx5IGNvbWJpbmUgc3VjaCBjaGFuZ2Vz
LCBhcyB0aGUgZmluYWwgbWVyZ2VkIHN0YXRlIGlzIGRldGVybWluaXN0aWMgYW5kIGNvbmZsaWN0
LWZyZWUuCi0gVGhpcyBsaW1pdGF0aW9uIG1heSBpbXBhY3QgZGV2ZWxvcGVyIHByb2R1Y3Rpdml0
eSBpbiByZWFsLXdvcmxkIHByb2plY3RzIHdoZXJlIG11bHRpcGxlIGNvbnRyaWJ1dG9ycyBleHRl
bmQgdGhlIHNhbWUgY2xhc3Mgb3IgY29uZmlndXJhdGlvbiBmaWxlIGluZGVwZW5kZW50bHkuCgpU
aGFua3MsICAKQ29yaQo=
