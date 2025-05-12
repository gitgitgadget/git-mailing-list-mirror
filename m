Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FE52505CB
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068409; cv=fail; b=QLAfHwIp1L0jxjeVRP90KuI0N6IFX/IgrJvIOoW0eR3qwUl7NZ2PsL3bK3AEDKVm3uEfn3ZZA/jGn+lSpswKpsdWgZION00zFYgQlagw3+7bi+TEePAAMZEioV8W7TKZAmJgXgkMroKz4pjcPWJFF1NHiKrUG2i8naC5f+xqKgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068409; c=relaxed/simple;
	bh=zutavACKMkMczGXoKJ8QyznzktuX8OCVngNuXM5N6b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oxHZ4t0i2lgNwJvxA7skWxw3WjLKzq9gfOfCYuBvDvqiTdgharhACizss0vW6kMM/9kpQhj5HOXQEYizS8Gls6dfiywUDzVivPGbx1SRkGRCXZRHmyCBqqMkRl4TD9/QZ5Ei9bFnjsatWwY06BZZ6KgP3hLOiHpEjmjrfHbagmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TStl+Rl1; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TStl+Rl1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvXxwp/parQvqYoRQKI9aPeBa34Bkhwldm5ov+dNk1dnEBy6c3Oh+QIo3YslpeVl0rIuxZ0a2jg8VNcEr6aVH6EULF7lSRGEFYs/tQ0D7HT+ixGOsG5rldTrtVuYfNKYDNYdSYdRBRaAkg3bTcM9wQlNJZf+IYLNRzN5ouDwRvOG8CS191TLW4nSqQGyoGybfRgXbTK/OeuXpZZac9cl4K3FjgLJuTAh/UclC2MEsmSjaFPc+jqZpU0tatqt0xGMO0QMxjtmntGw9TpEPMwQHA1CJXuNyi2zmt3rCLHGUrqHIYU/ud2l9YwQrWPb0LOhF9rQle+FNIOck7nuMSJhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zutavACKMkMczGXoKJ8QyznzktuX8OCVngNuXM5N6b4=;
 b=Bke7AOispfXx5+CdWzCzngK/TZRSzAlQkcOQ2simdAgSQ2p9Pv/23AWDEWgVmAF3BmeAF/zC0VbN4RF8ApTbgKzjhQgJPS9/Qrq2I2j4yJCBOfrLhAoeD2PNmmgdyitjOMX17LRd55u0u9ZprPHJeki37/mvC9VL9AnltRnwR6cKg7zeEg05x61ViscWfJAx1pdDgvPpsMuGjiDfJ1mG8f7+V5EtxvJsDVVL5VuVtH57mzPVDZ0+n7gGOc89tCpf1i5W10zAZGeW2VX+fcrQqWGYieGul39bozgPcFY4IRzuhbTl6PflORfOcgOE5nOqHpUfuM91/cALTx9JFSEYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zutavACKMkMczGXoKJ8QyznzktuX8OCVngNuXM5N6b4=;
 b=TStl+Rl1nYo0g4eD3RhSY5LcLFACJYLbV07o6M4wrBu6b+X2dgJus2g1W5v3mGT5CiGHUjYqqALVNJIqhtye0B2DLnc++Pj8FWYeUJj2uGfd0t14YGbfqjV3MEMGvPZ9Ni16mmd6fogDBlm90E6DI87g6Zi127xfeg1Zp2OS19ZPrdCMLpQoKuGnDftdmSlEneg52ChqHSak47j4N9/G8y005a8s7gE+sO5s9+MKER2VCD7AIlk6aR5NfMnPj4NZ8KjCeh+yZm9mTOKRVEVIdMfSH8lS77EMeOWJ5jU8oxIWw/S6KmtsAP4DOY+32YklwI63/xDG719PmEt4sJzodQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6083.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:68::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 16:46:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 16:46:41 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname --fqdn
 on Linux and macOS
Thread-Topic: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
Thread-Index: AQHbwX6JzjtAxyUkKkmtcSJbF/t7h7POoNeAgACV0XWAAAE4sA==
Date: Mon, 12 May 2025 16:46:41 +0000
Message-ID:
 <PN3PR01MB9597D7CAABB0EEE93A5CC490B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org> <xmqqa57hvl0f.fsf@gitster.g>
In-Reply-To: <xmqqa57hvl0f.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB6083:EE_
x-ms-office365-filtering-correlation-id: 31b44fe4-9806-4c39-af93-08dd91749230
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzZx5fYXqP7epOz858UK+BQTmqLznK0zhv5iWVj+G1tFEKZy3w9PcZhWnGFx9SSFyBi0psz8p5Mp9zPzrpvLbeM1A31K5MOd+46ZCEQ4NJLV4+D8TV3u3TnbOw7WV2DcA9/cCLheph8RThY+6OhMk5D2qWUd1TEPviEl79gwKnbtMeOU4Ev1d8WL9PiDBEUjHtoqU+rBF8De+4IVuu6hz1Ze3GiMyiLTUAxKOthsYggv6zFesRW93p96eBQ2Nr8gV4g7jLWBaIyqLllSgEVIUq0kkYw+uu7Rb3T19tDLuxslLRUcU8sPRhnOfq+SyUg6bM65PM9eHl0x1yN4n3qmdZqeFY9jUQLNQuVCaeL1toDSwLgRKXW7F+jRdjWj+CgUM/3F12f1zYuBG6+TzpbtARaXaFOU9mLLkCWxw9Gq16rfgzgMTlnjSk3YdH8fZ9Qb4KktuvMyItXNZqZ/dDlyyjN5bzqOnUwi3inA4RIudvPVXDe+XtR76a3Q5Key5yggNRMVj0tRp60rTSs+q6oWntg4iHJ2IpstLgqFBV6bXGmjoh1EInKr8lwMUtG5O+Q1tj07YFOi8YA3NCPMAuTZ6QlEGDQb2rSqtHcgGLBqHOqKdb+/AV6uoJ7HyLQGmr30evdH4gICKqjEGtnLg8WeXr+YmV/VC79xXZ4zgfR0kPZXLjUuKDu77nNTwT6mLexdL8A1GOoQZzDvNcxs8bneVgBUZPxIyrWb8Y380QSP4A45hMhwYFIJ9peZR3zufSB2piMuKUxQwIC6Q/5QQeLg9le3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|7092599006|19110799006|15080799009|8060799009|6072599003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlcybEMySmZZWXdvM1lRa2pZRGFZejRVa2tCZVRtM05Fcm5uUGpHcWl0UXFO?=
 =?utf-8?B?RS8vNWZnM3I1bTRCRDQzZWV6aC9zQmVJYlMyVG4zTGxicmk5cWJaWGdKSVo5?=
 =?utf-8?B?UDVxUlEva0ZXVWoreWpDWmNuVXNCbEVUbVJFalRGK2hwZHYyeTlJR3A1cklt?=
 =?utf-8?B?aE9KQ3JqWC9hZVNkcEJhdWVuazBSNFVocXh1amJzQVBSUWxFa2dWQng3YnhE?=
 =?utf-8?B?bXZLMHBOb1NzTW1DR3pKREE0elFkK3VyRHB4a3d2N3JVN3NQOXhJNmt4WElh?=
 =?utf-8?B?K1JQL054d2NoQXlyalFqbzVNSWJuZ1JzWDhyaTh6UUF4SEp4RnBCQWd6eEN2?=
 =?utf-8?B?YTI5QURCNEtlUFBDMkFhRFNUZC9SL3Y0c0lnZlBDbU04ejdGaWh1bitRODFJ?=
 =?utf-8?B?VmszVC9IMldld1BTWElNM01nMkUvYWx3RW1Ndzd6NE9EM1ptV29iejJnSm9o?=
 =?utf-8?B?a0VPNXZRKzkvSkNvdVRuY045OGEzRjI0cUtTa0JmWERvVXdEbi9VcDErRmEy?=
 =?utf-8?B?WmI3Q0hQbjErOHVXOTJYOGJOekpRUkM3dkVlRVE0NkJGLzFKeExBR3ZFZWwr?=
 =?utf-8?B?U2dUV21aeTdTYWh1eFNUYlNmZ1RIM0F3bjlXOUY0NG9NU0xDT1ZVYWZTcUFU?=
 =?utf-8?B?Vm42S3V4SGtLN0MrVlZPdEdVRW5PbjU4S3lhWFRnRjdCT2ZYdUZkVkFSL2dn?=
 =?utf-8?B?SDcxUkNZZWFFRE9KV3VIdE9NS29tUmV3TTlmTHZBM0lTRzA3OTNPZGR6a29Q?=
 =?utf-8?B?MUJBdGZGT1lVMHNTUVhzVlpwT0pqSzdvOWx2UUlEd1lab2lvdW1YNDlrWDhF?=
 =?utf-8?B?QTJLdEwwVW53eGFWYmFSbEJ5MktFQVVMZnNvTmJydGN4YjBQOENwK21hVFpO?=
 =?utf-8?B?ZVhUbU1iSy9TMVBteDhRbFMvay9TQjk4b3BhRU94SUhMVTBuOHY3S0ZSU0RU?=
 =?utf-8?B?d3pBVjFZOTNaKzc0MTJZRmJEMDZWUTBwNDVKWlZxOEVyQlRxWTJ1WXdkb3pw?=
 =?utf-8?B?TllHcE5JMSttWC94dVovSHJka29vSTBKTjYwRzM1Zm9nZlJMZ3Y5bm5FaXJx?=
 =?utf-8?B?Vzlvcld3OUFQb01RNlV4bHlGNnA0UVFlSlNydDRoSnBnMkxtQk00WDRwVnhJ?=
 =?utf-8?B?UGtpNkVTVEhkM0xjVE0vVDd4SkkxTmkwczMxZm1HZ3c0LzdJMUF6aDFkZmVH?=
 =?utf-8?B?SExCQ21MMC9TUno4S09uT09WbUsxajJIQ3M1VzJBcExLVmVCL0lrOWlZV0Fa?=
 =?utf-8?B?TjhGOGRNbFBqVElCaW5ONnNhRDVYSlRibkRBb045Z3FhRlUvRGt1YnI0YWFs?=
 =?utf-8?B?cGtqQk5XOFUxd0ZJRUo0dVI1Mk5VUE1BWElXSStFSFpoNzNRREl3NFE4NUVa?=
 =?utf-8?B?TlI3SXpEbHhvYi90S2lzdjlXNGtLWitMTlgrOVB0akwwaW51eExNZjJNVGlJ?=
 =?utf-8?B?SGdINFgyZGpkYSsyWDRZd0tVMWthSHlOU3N0a2NCYU9JRSt3cWxsQ0d1eGRh?=
 =?utf-8?B?VW5BNHhMQTh3dFpNV3ZzRDZ4VEMxcW5Mb3NGdnRKMFZZa2hnZ3FhY3J1ekxY?=
 =?utf-8?B?RTRoUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFU0ajh3YUtsZGMwaytPOVhzVkxOOWZFeW1mWEpiRnBNYjkvNHREejIwQldM?=
 =?utf-8?B?L2JwUGVLLzl2b0Z4dzJSMkp5MHRTN3B3SXovSFRVQXd5bU9RYTJwd1B0YW5J?=
 =?utf-8?B?R1JmeUR3MGdtRlVkMkFTZmtsTDBHZ0M4cUJYeEpub3lmck5LUjFHZHBTS3Z4?=
 =?utf-8?B?SFlvQlRRSVlGSG1qMEh1UERqWmtpSjFYSVp2Sjdsdy9ZMDBIdzRvZVVrY29C?=
 =?utf-8?B?aEFHeE1McE5yMVUrTm5ueGM3VlRlZHVUcmpoVUZkUUJwN1dnNytqZ1poSGI0?=
 =?utf-8?B?aFE3VVJOaEJVWkMyMWc1WGlBWTJVVHBHTnc4RUpJS01qbU96MjVqU3dKendi?=
 =?utf-8?B?YWFBL2RsVnJMOXczYjFtZ25GeGhIZms3dTZvVHdxSmZweFZKWExPSTU2SUti?=
 =?utf-8?B?QTJpRlZqTXdaWUFXNFpsdmxReGRzdm85b0svNHpnQUREeVlMZlY0LzFvZ3pQ?=
 =?utf-8?B?R2JsNjNCQ1NtTi9DRHM1SzBGT25NSHdVcXc2TEl4UTFmalZQb0JaUHZqZEtC?=
 =?utf-8?B?SkxoNitJMTRCVGY5SncvdkdkNFlXZVBkWUMwRFcyc3J0M1RTMDFxajZvdXAw?=
 =?utf-8?B?TVg3YnV3cmxoaC9neHRQNlhtR2d1RmhZekhXRm5mbkZYbkNxRHREZkRZYkdJ?=
 =?utf-8?B?bWQzcDFCYzNCc3hYK2ppeFNoRTJjM2lWQ1VUMkF6SFUxWUNBbENZd2QvYm1P?=
 =?utf-8?B?OFlDVUFHSStjazZ1WW5zOGlvamo4VmQyYjZLZG40ZktUT3FTVGMxWUFtd0VU?=
 =?utf-8?B?TmthS1BmS0pheDMwSEplcW5LSTI1NmROQVhlbkVsWTJVUjF1SkFyZ1F0azJS?=
 =?utf-8?B?NHozRk54WnRaTlgxY0J2WEhlQitJU3dnVCtyc1BiYzBPUkZUMUw4Z1dGVkJ2?=
 =?utf-8?B?OVduazZrLzJFTm16Z2tEbkpXMURKWHo1RUl6V20va0R2WlRxVVdidlJBNVpU?=
 =?utf-8?B?OG9zazFwWGVSZE92QW4vcmVNNUVDT28zcHA2S05xaU1yK3crYUtGTlRNNjRa?=
 =?utf-8?B?cytHNU9vS1orNkhNRnNrU0hxbDJJNkhva1VxMElpS1JKWis2ejd0dFRORmpR?=
 =?utf-8?B?eUsweU4zcEkwQ2ZzeEljeXQ0ZUJuL3QvSlp1NVIyVitSbzZ2MTJzMnR6SkJ6?=
 =?utf-8?B?WTNoWmUwZ1g2WldEaWRtQ1c2SGVzNmdNNi92Q2tiSitwZ01VMHhpSElSOWNQ?=
 =?utf-8?B?UnNVNEVjWm1DakJmcy8wOGdTRVJYYUJFK1dqdW1ORGlKYU1mYWsyWmVuRWMz?=
 =?utf-8?B?NVJKZ0ZMWjFGN08vRDBDL1lqWWZWSUt3YzJJQUx6RXVDdi9qOSs0WE5HcGx3?=
 =?utf-8?B?Zzg5MHBHaVd0ekE3YVQyL2cvejArbnF5aWpocDBYNFkrR2xkb0c1Zm5Kb2VR?=
 =?utf-8?B?YVhtOE1vQkwxenkySzdJK1pwM2ViUm1aYkczRnZDQW1BK25tbW0xbCtaY1R0?=
 =?utf-8?B?OG5WaVNMb1BoM1NvYmMrbWEzQS85cUtsU1huKzBNcS8vbFd1eEdxbXJHeDdH?=
 =?utf-8?B?QlhjT2xqOEtJbTQ2cWNGb2xiM2ZiYmc5cG1GTFFLRUN4Tm9WWDJIQVNUbGVx?=
 =?utf-8?B?cEd4UWhXRkE1UmpNN0RnVExFR0NzWXpmWVFYY3JIQnMxU3IwS3hKdDZOL2Rm?=
 =?utf-8?B?OEtNM3BlQ013L2ZIZm1jL2JCVEJMMmJvWEp1Lzl6bEllN0p4My9jZTJvTXFm?=
 =?utf-8?B?Y0xXYnE4UDk3YllQaXhOQlU2a0NzWWc1WUFzWVRERFp3ci9sWW8rSks3d1FV?=
 =?utf-8?Q?J9QMu5xa8Li2cD1G7Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b44fe4-9806-4c39-af93-08dd91749230
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 16:46:41.0991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6083

DQoNCj4gT24gMTIgTWF5IDIwMjUsIGF0IDEwOjEy4oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu78iSnVsaWFuIFN3YWdlbWFrZXJzIiA8anVs
aWFuQHN3YWdlbWFrZXJzLm9yZz4gd3JpdGVzOg0KPiANCj4+IFRoZXJlIGFyZSBtdWx0aXBsZSBp
bXBsZW1lbnRhdGlvbnMgb2YgdGhlIGhvc3RuYW1lIGNvbW1hbmQsIGFuZCB0aGV5DQo+PiBkb24n
dCBhbGwgc3VwcG9ydCBgLS1mcWRuYC4gRm9yIGV4YW1wbGUgdGhpcyB3aWxsIG5vdCB3b3JrIG9u
IEFscGluZQ0KPj4gTGludXggYXMgd2VsbCBhcyBtYWNPUy4NCj4+IC4uLg0KPj4gQWxsIHNlZW0g
dG8gc3VwcG9ydCBgLWZgIHRob3VnaCwgbWF5YmUgdGhhdCB3b3VsZCBiZSB0aGUgYmV0dGVyIG9w
dGlvbi4NCj4gDQo+IFdoYXQgbWFrZXMgbWUgd29ycmllZCBhYm91dCBzdWNoIGEgcHJvcG9zZWQg
Y2hhbmdlcyBpcyBpZiB0aGVyZSBhcmUNCj4gaW1wbGVtZW50YXRpb25zIHRoYXQgdGFrZXMgYC1m
YCBidXQgdXNlcyBpdCB0byBtZWFuIHNvbWV0aGluZw0KPiBjb21wbGV0ZWx5IGRpZmZlcmVudCBm
cm9tIGZxZG4sIGFuZCBlbWl0cyBzb21ldGhpbmcgdGhhdCBsb29rcyBsaWtlDQo+IGEgaG9zdG5h
bWUgYnV0IGlzIG5vdC4gIEF0IGxlYXN0IGFuIGltcGxlbWVudGF0aW9uIHRoYXQgdGFrZXMgLS1m
cWRuDQo+IHdpdGhvdXQgZXJyb3Jpbmcgb3V0IHdvdWxkIHRyeSB0byBnaXZlIHdoYXQgdGhpcyBj
b2RlIHdhbnRzIHRvIGZpbmQNCj4gb3V0IChvciBpdCBpcyBzaW1wbHkgY3JhenkpLCBidXQgLWYg
ZG9lcyBub3QgZmVlbCBzcGVjaWZpYyBlbm91Z2guDQoNCldoYXQgd2UgY2FuIGRvIGlzIHVzZSBg
aG9zdG5hbWUgLWZgIGZvciBtYWNPUywgYWZ0ZXIgYWxsIGl0cyB0aGUgb25seSBkYXJ3aW4gYmFz
ZWQNCk9TIHVzZWQgcm4sIGFuZCB1c2UgaG9zdG5hbWUgLS1mcWRuIGZvciBMaW51eC4NCg0KQWx0
aG91Z2ggaXQgc3RpbGwgbGVhdmVzIG91dCBBbHBpbmUgTGludXgu
