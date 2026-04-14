Received: from gw9138.fortimail.com (gw9138.fortimail.com [82.98.199.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B41F92E
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=82.98.199.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129424; cv=fail; b=eMGAea7GRlq/0t8H0LmvZgH+BAD/FRFSSvb2IONeCIWEtK6Hp7qmeJOkXDRAb9prlCMm+mkaW8aVjbkaCkJcs9mwtbps/Hgwo9GSoATDA1TFyHySSj1me9u/q6esIQHPUKgKi8yiSS2s/otL9j2jxBhLm6JYKJH/5uKjQ6x5jqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129424; c=relaxed/simple;
	bh=D2J8UBWOIXHrd+rJMBD4iew2sKi5KiZyKvDTQZpoBqw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUag/v+efyUSQ/IxgROfEbyIF86e9Kdojk1dWgvXIaMeM0Iyuq7SsEv7aNo+ka1DGK7d83o7rJSPnzmp+Xi/ehSGxC7DM41UeH5/mQooeq68+xz25PSYh1AyjffPaJd0mGbXwQVECFrFUAvXQbL07b0xLC/lVhUpPzq+mmg66V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tr-advanced.co.jp; spf=none smtp.mailfrom=tr-advanced.co.jp; dkim=pass (1024-bit key) header.d=tokairika.onmicrosoft.com header.i=@tokairika.onmicrosoft.com header.b=ceCXDUx+; arc=fail smtp.client-ip=82.98.199.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tr-advanced.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tr-advanced.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tokairika.onmicrosoft.com header.i=@tokairika.onmicrosoft.com header.b="ceCXDUx+"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	by gw9138.fortimail.com  with ESMTPS id 63E1GvnX022853-63E1GvnZ022853
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 10:16:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BR59HrjwPoa93b6TB+2R7maDTIVM3p24vGdmPlx3wciQjcJX2dJDmnJnFRxQxPQGqWBpeT53k4MtajRnJ8LKgfO6jzv+4WnXwAV2v9yT3Xso5U6Fgepj7KXJWsoULDyo3R9neqSsQE7Gkgo5jvlK4KWRxorIqLWHqT1+TPp8AifDLQRyTdFdCzSWKTWu6M0My4T6rtZPuISOXj1iGYJQG/PJttNIZIaKyL1AY4tqtLqJTHF5D37uBmtCWv9vmqG5mfEfae48WJLl58cLH/dmAkWcVii77UOdcZTejr4w69whzwwozs52EVWBhMS0wntSNt7/S+7HNO1Nud7ifjg8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2J8UBWOIXHrd+rJMBD4iew2sKi5KiZyKvDTQZpoBqw=;
 b=EDSjc3GG0BYceYoDrUsLYsKYY2+7fyq/+M7y2+GlDx5Z6yzcq/Eg5KWDErcTC6+pJHCf4vYr1nE7ElbphuTUzzfLMafffEG3XD8tAZIh7/topnB0BwgShS7YNdiUdY/yJlY5+UNfvlPS44crwON+f1jxr/T2sZb/TtSOneAWdrV7D3IZDokpX9nRxuEe7jF+waVS788zvy5tgkOYJiHTA4xpyqsDD3t56KGbTDpcEzsb+0QIE6SBmViRl7K6NBxxz+qYdi+kB4Y4emhtwmkvWzdNurm2ot2nfFBP1lIlG1obQfvi6S1dOmqdS9VxNUol0S10UTMfzGes7nhQrICTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tr-advanced.co.jp; dmarc=pass action=none
 header.from=tr-advanced.co.jp; dkim=pass header.d=tr-advanced.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tokairika.onmicrosoft.com; s=selector2-tokairika-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2J8UBWOIXHrd+rJMBD4iew2sKi5KiZyKvDTQZpoBqw=;
 b=ceCXDUx+bGGN37KW6bHSSBC4OYGqBmegOieu4qUviDY0NjMv27YzVirwPR+BqbvdN+YwOYNseVd3OBtABhChwz8eKe1PAhN7DrEpuQXbRQpptK/wUAlw/fn4Vr1XtKYG0ecAoji0bsfz62QByc61A06HTL9TKf/RGdYw91OYZa0=
Received: from OSCPR01MB13450.jpnprd01.prod.outlook.com
 (2603:1096:604:32e::14) by OSZPR01MB6847.jpnprd01.prod.outlook.com
 (2603:1096:604:13d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 01:16:56 +0000
Received: from OSCPR01MB13450.jpnprd01.prod.outlook.com
 ([fe80::8fd4:6b1d:4f1:4b46]) by OSCPR01MB13450.jpnprd01.prod.outlook.com
 ([fe80::8fd4:6b1d:4f1:4b46%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 01:16:55 +0000
From: <kawai-m@tr-advanced.co.jp>
To: <gitster@pobox.com>
CC: <git@vger.kernel.org>, <hattori-m@tr-advanced.co.jp>
Subject: RE: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
Thread-Topic: Subject: Inquiry: Git versions you provide and Windows 11
 compatibility
Thread-Index: AdzLqvIiPp8/2/suQwqpKO+g0SPM4wAAPr8/AAAZoLA=
Date: Tue, 14 Apr 2026 01:16:55 +0000
Message-ID:
 <OSCPR01MB1345083E588E48B54FD997EEFEC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
References:
 <OSCPR01MB134507F2EDA90C775EF1DC571EC252@OSCPR01MB13450.jpnprd01.prod.outlook.com>
 <xmqqv7due43w.fsf@gitster.g>
In-Reply-To: <xmqqv7due43w.fsf@gitster.g>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tr-advanced.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13450:EE_|OSZPR01MB6847:EE_
x-ms-office365-filtering-correlation-id: ff104940-2d4b-4d34-8213-08de99c384c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|42112799006|1800799024|376014|3613699012|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 IFo8mztWvyotGpM2JwKXvlqjNcZL157UvQdTWgAF8+icCkg11UALeRyIVK6AeLnG8jiN3G63foGagTx+ctqoIn2Hcn97KcVaU7+f/0Gmx0xYTZtiiKKVyZnSbjkZml2x+xoN+7zvKhp0EzFkF7sLdSpOhpCD9nAndvZxMP+pDNG4uMBWgQjQ9STLFsKidZqMpvrVH14gcrAGUS1BMAjiXM3a0Nhpx1ToOqUL8PFUQa4xg1utzN02N5TT4ayPFmTDu9wqmFAdsNQiyTPM9wNtvkDHAVmmE/xkM2SKLZ7DKO7iVwjo5rMMnTf4hUQ0+nPchdEd1DBLrfKp70Km4GT5sEUwOElxcTDm2vNM/fQpBbbXF/4G20lqS+LwBekTGPwLNYDgyEawwFFA5u1RIekTXfS/yjvFv3zpcPGzSHLPBJHzi9DrX4a1mXnASV5vgnqPDc+NcG+SZbHW2yYOlgpfTSADgRjw1t8EY1yYyqxCAAgATHaMVQ4t2UkodY4a6TcECHy4mSUPwdUa6iNPhiiIvqdL+DdEKwhyUgSmsZiwJMqiQsO+RyFwxGTxDVS2gS7NoRJ9uQ8Fy3zb2pgg75SZ55AMpryY8+AiZ+6exsrWHOKYLmhzeRGBK2UzFOFWWOPpPBjgviQJlbfcI/P/aktOBJ+lpddo/6T14H2UmBFoSjCK7UrXj2RTZZC0pwVyAJOe4QUmeOsvX4cQXjvGxqAA0pDrqP41bwYzp6dxM4mdFOxPdGszDPwuKwPsNmNIhAwjdOCoI4Pmw/nhJlMYb4Bw8A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB13450.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(1800799024)(376014)(3613699012)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N0tuYmlSUEZrdWVTWS9qT3V5Q0dDVUJmMmUwemw4ait5OTBTM3ZpYXM1QzBZ?=
 =?utf-8?B?THp5eE1UdmVlaVRZTXdlRHM3R251TW9JN0I0UGlGdEdVYUlQaXBqTm0rd3Bq?=
 =?utf-8?B?WXVSdFlvclZ2VDlRZGFubUs1RS84TUtYWVVwK2dNZkp6dDZvQzZEcDZvK3Iv?=
 =?utf-8?B?NDIrSGZueE5oVENqMzVYcEsxdUs2K2lPYjM4RkFKeTdveEN3RDhBb1NxVXlI?=
 =?utf-8?B?YVQ1b3JSNFFwU1BkQ1p2QXpPZ2VTaWdBNWlsdmZidVFqTWRabnNQUlhaOGhQ?=
 =?utf-8?B?clBPaXhadFpsc1dRRkdWTWdWQ21JRHN4a0xqQjI1UG5TRnQ2SExPWXhrYkNC?=
 =?utf-8?B?YlgycVB0NFlkR1lldUpRS2ZoaXZ6eVEvWUVvNnZKZndMZ2dBejRRT0dlM0VX?=
 =?utf-8?B?c1d0OTdPS1piSnppZkZoY1hhckIwZ0xnMXY2WG1hTkpReWMrM0QyVFkrcit1?=
 =?utf-8?B?dloxNFFNSi96ZkQ5WEhvWmxNeDhUVDZReVN4eC9CNDNjWGlvR3ZTNDNxdUtu?=
 =?utf-8?B?QXd4SDFIeFN2YzNPZGd3b29XdGZuRm13UDlXN3BlbVZGczFvM09XUGora1Iw?=
 =?utf-8?B?aDkyN1dXYWV5NndGWEpvaWJSRzc0bmJhSEprL3RPVHZ3NVkwWld0MkhLb0xU?=
 =?utf-8?B?VkZpTXBIY2RwcWJTOXVXalllMFU4blI1eEhVK25LMEYwcUlNeklBa3B5dzRu?=
 =?utf-8?B?RnhIclI4T2FrcXdiRUs5VVB0VmowVU54QTh2TzkrZDRMZ1BLYmFpRktyQ3di?=
 =?utf-8?B?UFhxNHh3eUlBYXRVTEZvaVVlTHQyZFFVSk9Bbkc1L2VVMHdkK25GVSt2Tklv?=
 =?utf-8?B?NSttRHcwWGxXbFE4bUxMZDJGb0xKS1ZCV0tBRzk1UjJwSWdoc01RUkJDNFNu?=
 =?utf-8?B?OG9iT1l3QWtHeWlmVHExZTVIZmlkVEpNeVV6ZmM0Y0Q3dU9OTnJMMzV2a3ZR?=
 =?utf-8?B?VFdFWUZlVTZXZERUd2NMU1RSWEZSQk1QbFZBV3dXUTI0aWp2U1RnMTROYlRi?=
 =?utf-8?B?cDA1OFkzbHFFTXNKSHhnRGtuQUlyYSsrN3N3SUZqM1V5ZENDcGVSVVRWS0FI?=
 =?utf-8?B?MVZDUmp0Si9hblpUTUJ3U1NEMmZGYm5nUHZFSDFqNDJyRTAvb3NXUEI1ZkhG?=
 =?utf-8?B?UWhsem13N1grT2lESGk4MnhYdEVGRUZtdDV5TkR3Wlc2d3daM1AvNWQvVm01?=
 =?utf-8?B?UGhEaitTRTFPaHQ2V3VqM05UbFEvV1VGUzBLWDJ0Uk11TE5aT202YzVlTXhp?=
 =?utf-8?B?THBxaGxGRCt0SFYxb1MrOFN0WDJ4cWlRRXJCNkp2R0VqZXRsM1ZQOVVzMDRl?=
 =?utf-8?B?MVZreGFZMjVZYW5SL0o4VTdlMk9Sem5sVk41bXBHazI3UVo4bFhtbHl4c1k2?=
 =?utf-8?B?dklYQ2Jiemltdk05b254dHFhVmtVbXlIL0FJakNYNGM0RHV1clhRT1daQkRQ?=
 =?utf-8?B?TnJTNTNaV3Bvdi9FbXY2ZnNDeXJNcHhIT3h6R2xEbHgxcGRZZGNrMzNjeWdy?=
 =?utf-8?B?bStqMDROVmVTaEdpblNPa0lUaVdSS0pRbk5lMS8wNWJlUm05VVg5TWdlSkhQ?=
 =?utf-8?B?cXhHbFphNnlxV2JDejZpRXdvTWxielNINFptSkt2SkRuTXhUMU5EVzluQ0Jw?=
 =?utf-8?B?dXNvNVFNNWRDWXNVeEJET0ZoblBuY3lBQVJIeFZCZVdZUlM4RDRDcnR5ekx2?=
 =?utf-8?B?Nk1YSVMxZTl1c2ZZZmFxREtmUGp2M202c2ppM3ZMTXY2ZHhCeU9oQ3FCckxE?=
 =?utf-8?B?THpIUGUzZlExMHhnQ0plMmppTFFRbnFad0tBVHRDZUtMMTZyTDhhR0NZYmU2?=
 =?utf-8?B?NFlVL0RvVXR5OUVwYWs5dXh4cTJoeVMrWU1FdTJaa3ltS2NwZjNLRlJCUDNw?=
 =?utf-8?B?YkVMVGlHOGt1eDhZcEI2RmsydEFCeFJ2ZGw3aG5wcGhMTFo0cm52MWkzSEJL?=
 =?utf-8?B?K0FlVmtmLzNqa255bGd6RmswaHBNYzFxSW9wSFcwVnRncXk3WW8rMGk2d21n?=
 =?utf-8?B?SWRIcHcxQW44TCtNR0NjeXdmL3k3eW5EUXY5SmhaeVI4R1h6Z1FMUUtMKzFW?=
 =?utf-8?B?NnlNckd4R21KcDdSaVFvZi9HeUNBbit3ekowNVFhVlpSN0N3eXNIUGpCYWV4?=
 =?utf-8?B?SjhNZWpjZVBTNzFGRDQ4M3VVTnY4V1RGcjZsbEVCM2xpUUZMbmplZVQvY1Vo?=
 =?utf-8?B?UGl0RWFDMytWcm15T3NkcnkxRUtQa3QyalFqZUR5UzBkRTE5bGd0d3lHSEdm?=
 =?utf-8?B?Y3cxQlBUSUhKZlpPV3Z6T0FvM2pVMXBFS0h5QjBUN2FoVDlzNjJ4K3BDa1N6?=
 =?utf-8?B?M2VJekJHLys2N2Y5dlRNZStHdjlObzQ3UFZUbDh3alJkRUwxbVFlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	DYDkgz9VwwUyvaNnXMtvoOnO02resc9v8PRAY12dI3HfC61M5rtOglZGlvrKzMPMk7+ZlPt6Gvs0L5XCd06n1uZarIY5JEfzEKiqA8ILAlKZAG7gFjCCzGcVetTPCkTEf0yBimvfXiWxosQ7A4mzj56mOMvnvW4KJbb5N9KXFWkq5rUvRy0Llr3l75Suewj8lPezonl9Y82QfJlpRReJ7I4KffNtvTppxvx1f+q1U6gCv45vy1Ea9i0fuXU7GHIBo4mLsB2keyb6vzI90VVYk1uUfzWurL/A2e6zDK48S0UEUIiJQy0ELUhBKoIvMkBV99PmjQEG/M1xb6Wi8Pa+gA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xojPh06M0kib7EXaep0sYgXC40eZRSw8D2GpwJkLIW/HZ1monSEhxhhFyVZIxvDxLB/MR2iD7wv+dCslvt8iAk5Dls+Ll5DtYMNi3Hp+2pGAf0aa+d2NURbDjLLHVymcYTH1JdfiJql11ku4SMwriMMIPaufm+z9NtfbaeWwjHdjVVXFkjqZhl2EdB48zLPYZPjuxW9+8WW8JsoQKq9QsLDoDNlHNIk3S/LYJCQYmUSdmETwRzLR0Euc+lfCNjTPytVSFAuh+D1cHeI8qXTFTiqw8NMvixlGBmFEzb9IgLzmR02r+oRPwLMq15SZJVDzovJpRKiMg9QOPgRyEAK4wuzYQIC7HTBXLmPsajVWn8LxrnP64lLqnv/vwISfdUjc0am/V//sZG0ysNwAdCuxmYrSyz+KM7pG6Fcd1w54BV5KX1rqgRxWHHhYWYGRcuIfMP+NquqXETdxRfNc+WOM+TR/1N0TCfeebziqTutHc9CLI5vIq/5Z2t7Ev3i6zYMpLwRnvhXrqK6JMRincFMtAFnJxn5fDwf/FSvvUqQBfCdCx5B5R/8/ekEfGt/NYBpVIR/eZ2Hl2JLxe7vIefwCUPtZI1NqjlU8oKBYYLYhJUrIj0YMVOCFgRFgTdnFf5ut
X-OriginatorOrg: tr-advanced.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13450.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff104940-2d4b-4d34-8213-08de99c384c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 01:16:55.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8d8aae5b-4dc8-477f-966f-70bb2d9eaa30
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /r/IY77zLjTUclBEwPZ6FM9/Ibyv+NNA82r6fozot2PHXbu/XBQtDVHDhXi+/E3q/5vPUeXsgQIYSqcLxTHIS+57UJiR2mMmStinhzBFv18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6847
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lJTslWFhYWlpfW1teSFpdSAMJHwkBRQUoHBpFCQweCQYLDQxGCwdGAhhIWUhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpIWVtIXVpGWVhZRllaXUZeW0hQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 52.101.125.63
X-FE-Last-Public-Client-IP: 52.101.125.63
X-FE-Policy-ID: 1:3:14:SYSTEM

VGhhbmsgeW91IGZvciB5b3VyIHJlcGx5Lg0KVW5kZXJzdG9vZC4NCg0KVGhhdCBpcyBhbGwgZnJv
bSBteSBzaWRlLiBUaGFuayB5b3UgaW4gYWR2YW5jZSBmb3IgeW91ciBjb250aW51ZWQgc3VwcG9y
dC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEp1bmlvIEMgSGFtYW5vIDxn
aXRzdGVyQHBvYm94LmNvbT4gDQpTZW50OiBUdWVzZGF5LCBBcHJpbCAxNCwgMjAyNiAxMDoxMyBB
TQ0KVG86IOays+WQiCDkv6EgPGthd2FpLW1AdHItYWR2YW5jZWQuY28uanA+DQpDYzogZ2l0QHZn
ZXIua2VybmVsLm9yZzsg5pyN6YOoIOebiuaIkCA8aGF0dG9yaS1tQHRyLWFkdmFuY2VkLmNvLmpw
Pg0KU3ViamVjdDogUmU6IFN1YmplY3Q6IElucXVpcnk6IEdpdCB2ZXJzaW9ucyB5b3UgcHJvdmlk
ZSBhbmQgV2luZG93cyAxMSBjb21wYXRpYmlsaXR5DQoNCldlIGRvIG5vdCBzaGlwIG9yIGRpc3Ry
aWJ1dGUgYW55IGJpbmFyaWVzLiAgR2l0LWZvci1XaW5kb3dzIGlzIGEgcHJvZHVjdCBvZiBhbm90
aGVyIGdyb3VwIGFuZCB5b3VyIGlucXVpcnkgd2lsbCBiZSBiZXR0ZXIgc2VydmVkIHRoZXJlLg0K
DQogIGh0dHBzOi8vZ2l0Zm9yd2luZG93cy5vcmcvDQoNCg==
