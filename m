Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348A360
	for <git@vger.kernel.org>; Thu, 29 May 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545572; cv=fail; b=nL9FAsCmh/vDJQj4LGQDR1mmtrIjQWHLvMiKeaiuIqyl5He/8Zg0kWdnsG0eykyaI5Ckc9vJsovJhoPVIHx9YFPwRQXZhObFacy2RRgiagzxNEqmDBYFuiJQIEu5IIQiGu2kTqy0BmKGwCKn5IC3L10wPAim5C9bbv2vE5xEFTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545572; c=relaxed/simple;
	bh=F6HXqB11fdzzz5aQAvCO3f3Qw8swhXQiBNL7xRXq7FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7FRF7aG0SkopY13U9WdACtFlFqbnYPcdLzOM/7HizT4Xe3rOih0zFnn7xsWmAPcLzaAUKLpKO7Q6HlMOXrpIu9c7HIET1aThqFz7X94nCXVMDARtRscPZm9kaSxzbhdvlbztr7VrG5BLwaqXiMFlSiuVSNPnTEs5B4mlSIA+Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KnOpdqgh; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KnOpdqgh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbrd7JnqNGbPHXIUWEBLhl4UJbqpOJDiS8OQjCVyOuo786HN2sC7a9XGFTfuzz1m2YDf6igbgG+4zTDzb6KJWWYOwEx44mJEJI80851QN3MZozqj0vvwva6BvlUyDRvEGhLUcxQe6eYVB191gSVHB2ohqCUFO3n8M+1ZpSAClUBaIZYXTGVUJIdIdj3HwmKjCqbYX/aCUZuYwdXRryvQQbqJ8Y/ZijIDiwxEnbboJuOrbR0h3+1fJgq9CjIwVurpqrcWHiVdvSbUvDB7j2Q99698Z4tslslFKgSOWDGc5+/O9uZFKRU/cnvHY0De27FBf8k0+2ghO1BDAZg5yz7xTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6HXqB11fdzzz5aQAvCO3f3Qw8swhXQiBNL7xRXq7FY=;
 b=fmSqBhKQAcvosHodw1gEVmKEiqEX6HBwkeNp7M3zffnY8ik2ExEnA0HltPX3qyBuIiLQkwXF7b673byZojj7u4q878QmkBmfHnCu41MU3ht7DFnVV/dWwZyK1bMdEmBmvXXbZKBWiqvITU2Wu4fpuO6lY6svuJVVT/joVZ95YA81ZAi4WpNiNDv6QPN8CUJ12P2Kg0S8VvSWxRLHhlHFzey0p2TBVgZt5raeq69J9EDJf8R5/GpGtQAuC00i/x68XYltSCWirqU2rGDaU+uVkp3G3mKd0xV94YrtYwdLOac3gbdfTfAhggrP6uB2cS7oztujb7xVn0ZP9ozremAufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6HXqB11fdzzz5aQAvCO3f3Qw8swhXQiBNL7xRXq7FY=;
 b=KnOpdqghrfHvCe0NlIalyNrkdkohhsrpcKbN57B/2fwvuXeVx3HhEXFrez/Ow15KHQhfOmmO3KC/8rp8xaspz9tvD2zafliYDdOkPXibOWmicoq2S68hJWRkO3swtDllPWDYg9JRypBBD2epl+mcdB3j/b+bohRCNLlyP3yevgcSdBZbPa4ijLxwa38MyOXB3+26cuXdzuq21npjIDxyheNBGrLagQ4XJKc/jo5YtNc5TGPSKRoFazMOG7FT4ceAqkHi5sQ53fgf29503CyUHaR7To9ICxDPyTUhnb2xX6wV8y6KGXb4/9YkR1bV6H+zerrr3V6ScGmymRlsCWvNag==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8900.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 19:06:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 19:06:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Julian Swagemakers
	<julian@swagemakers.org>, Eric Sunshine <sunshine@sunshineco.com>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
Thread-Topic: [PATCH v5 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
Thread-Index: AQHbz57qbnQbXLfgxEaEDq8ePWOP+7Pp9c9jgAAEZeo=
Date: Thu, 29 May 2025 19:06:04 +0000
Message-ID:
 <PN3PR01MB959790451CAA275910CFE8D9B866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-5-gargaditya08@live.com> <xmqq5xhjl09q.fsf@gitster.g>
In-Reply-To: <xmqq5xhjl09q.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB8900:EE_
x-ms-office365-filtering-correlation-id: b6b47d0d-f651-494f-afa9-08dd9ee3dc33
x-ms-exchange-slblob-mailprops:
 F3kBGFPBgzZx5fYXqP7epOz858UK+BQTH85UanI7gXS3V8UzVzg2lDhIAnFDRpCWXkU4QmQBubHFvES6pOXmBBqETY1QFRyslHiIfDiDnTX6FPV9Ef4RuswUrYsmMpBtOb3FNllbDGDA0XTH7QbqbpM9ueasfdXKGd8Nv6s0WMj9hQghXzlUTD9GjdToukFvsHHiRqVPw5ISDsjLq3zJwAPdg1oCu5QNvjDUm+rd7l7QK/97V4QFkMdfjc1FhYtjD52C8J92MhM/lJiBJl7N3LZ4kW/3/xFmcZ6n5jZ8/x7dMpv4bhlFMAYA1MNnETxThLKgm2km9R+uRovp3rkl4MM2+I8ncxPjVOkgOnGETkdthrRyaNiX14oESw7RUvX1qnTmBZ3z3V3ZtIZptX4RWQ1DEJFf1LwSv6yIPnp66PGJ+EkhR1u22IFMTTbpibMNbpNufGn/qoHWQ4JoIQQTVDETgq2kQyOy60zE+OQJedMDQs+kXMhdmR075fYuRl+GgYL3I/+FzDxRT2APC0Av/UaNzv3Q69DgTsg/ZqNSdRbxkn1ap12bfXemmQRmn+wiunIU5mMDxeiQXqWSW+6PeS6Q4aXHewHrLsKHt/uEk+Ijtl17lsZJdYhi2Mqebif9SQ641nFWYi4ZpvEmmeZdChQ65YeZPEl8SOHYxsANVPG8Mv+FkPTX6HYspMI4iD60D2FsXZTAyCtw/Ge1D0pQdklsYr9y9d52yY5rV+xKOVGF6LPGFliKmAMPAUAj3JhvM5FFJx5yGluc3YcyoNn5EX/T0cq1Caex
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|461199028|7092599006|12121999007|8062599006|8060799009|21061999006|15080799009|19110799006|102099032|19061999003|3412199025|440099028|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVVYaHJKQk5RRHBoQlU4SVVWamg1T2lKaTl1SVRENkdJNUVleDRpRUFIYUZU?=
 =?utf-8?B?WU54SDU2eHBkdDFWM00yS2MyS0RRSU9kMmxIS0VHMGpiVmdYZ2NWSm5pdlFw?=
 =?utf-8?B?aTRFSS8rb3N0U1NuenJNbDZ0Zi8zL1RTanJZWjdWZ1BEV3FmYlVXanZ0cDhQ?=
 =?utf-8?B?L0xSNlQ3VU9ZQm1yVkErRTd0eUpFcitwYitFWjFYclR0QnJBaVFDNklTTEdT?=
 =?utf-8?B?ZlJSd1E3U3lIdWxXWnRnUEo5ZnNjSkdNZ05ydGhmS1BoOHYrRmpvM2ZqRjBG?=
 =?utf-8?B?bHU4bXNaeU8wamZQditTSDQzZjNmMk5ibzd3QTZDclJpQVNjQlBZNStBOGZz?=
 =?utf-8?B?L0tZZ0VySWpUNkVwZDlNeElQNmpIc2s2WTFyTWdXM1VFZEVqNVAvZGM1eklH?=
 =?utf-8?B?TUlyQXZxd2NTem41WGpiUDRGUVFMZ05WZmk1em9pdGlzOXo1QTRzYWhlOExZ?=
 =?utf-8?B?N21HdXBmUldCRkwrYTkvdWl3Ym4zdjNLTnVSK1NGYm5La1R5VldmckRPRm9R?=
 =?utf-8?B?SE9Db0d4NjRZUEkwL2lwODBPWmxNbmJhZU5NVDdWbzc2V0hDaFVQN29zb2dW?=
 =?utf-8?B?d2tXc2dKNUlvdXk4VXB6UnhvaFZiM3ljY29NdU5tMnRUUzc1b1NKaWl4RFJG?=
 =?utf-8?B?Y0dwMXhxOFdaR2V3My9HSUdXMkZyTXBJWFNjZkVKRFU5bmQxOUVPMkR4L0xD?=
 =?utf-8?B?Z2JxM1NJcjBESXdaU1RkZVgxdXg3T3R0Z203OHNMU0RZK1c5Nlgvd2s5S2xF?=
 =?utf-8?B?R0VuNGg3MVNlUGpzbDhZQlVUa2RFejY2Z3BFdkdScS8wSWxRSWRkRzBVSXhR?=
 =?utf-8?B?TWZ3Y2hxOVZ3c1d2RHlzUVI2UEkwUFkwMmZmTzUzSnF3OTNiUGpEbWxSM1lB?=
 =?utf-8?B?YXljKzRzUFhuUFNoR1haeVVrWm1sVHNsK1BSZG9DWXJYeFdwcVpsV3RPR2s5?=
 =?utf-8?B?MWo1NUpETHFIMjI4UktDTGF5OVMvVXhOQWhuSEtkL3kyNUhoaFhzaFdFUUNF?=
 =?utf-8?B?aTNzaGRodm9MTUNaUmUwa0NxdDZYbUtaZTh2QUtBTjJLZjBxSXhVQy9ieGNR?=
 =?utf-8?B?K2tOODk5YUhTY0FETEptcStqR2t2Mml0UVZzTHJvd1BpbU1qMGhOaU53S1p1?=
 =?utf-8?B?am1aNkxvSjlpT1RuUXpQY3VFZEw3cmN3MWlaY1B6Rk5yY1pHTUN1QmUzcHBB?=
 =?utf-8?B?QXNEbVh4ODNGMWZoYlpWdG5xV2t3dWFBWGtEb2hvK1R6N1JJZEsvOFVFc2ds?=
 =?utf-8?B?NnJZV1hoSXl3UGlJc2Rpd1VPbDViRjl6a3pESmUzVGtwZjk2K01YREpaWkx4?=
 =?utf-8?B?Q0hXZklwZ2JxM3FwblFxd1hYN1NxVjh4TnpiTGFMNlVRSDhkNFNBWlI1aXdO?=
 =?utf-8?B?VSsrUjlpMmk2N2RTek5BZTlYSWFoVEZMWW00N3hUYXR3VTQvK2taak5aaFBO?=
 =?utf-8?B?ejRXbmtDOHBqeVZoNWk1Z29lS1FlbEY1Zy9xVXdseDFUUDhVYk1nK25EZUpH?=
 =?utf-8?B?WExuZlViL0d3YVd2YmI5N2R5UDd0SGhqR05ZRWhsU0tXZlYvQUV6TkIxWjMx?=
 =?utf-8?B?NVgzc3VwbzNQaTA1SEdYcStSWG9FQzNHUHoxd29vK2Rkb1FBQU1SbWJTRG14?=
 =?utf-8?B?RjRwV2Exbm1vbmpMRkVOQ3BiQXpMbURHTVYrSTZKTktpdGtkbUQzTlJlUS9F?=
 =?utf-8?B?YU12SjhuS2dsQk5ublRwYlJ6My95emZHUEpSSi8wV1NlYmo1cSsxT1F1TzVP?=
 =?utf-8?Q?pMdnijHhU8Bg8pXfnY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tk9XbUVmS0JFVzlHZldmR2ZueUsrL1NMSjR4M1J4RmkxQmQreXRUUXlNNXpy?=
 =?utf-8?B?NTk5ZE1NL2pGdmU1OFBTZDBrSzJEcDVlQkFPczh5bEoxc0ZmWHR0KzBkNVFy?=
 =?utf-8?B?cGFkRHhrVVBmdklxdDBtNXA3RUsyb3F6ajV2R0R2WURLVTRwWlVRcDdTcHFx?=
 =?utf-8?B?dnpUdjZJOVkxRkhoSXNacTdLa0NKMlRZaHNaV0tMbDFlczVtSUVwSy9HKzBW?=
 =?utf-8?B?N1F5Tmg2eDVHZThBUU5lWEpHVmRBV3FhZ1o1bUlHQk91bVJNN1RrYTNmSHhn?=
 =?utf-8?B?VE9yMXZ5UXpRaGxZd0poM2dFMS9jQ25MNnFVZkRyWTUzeVBTS05wQVl1OG0y?=
 =?utf-8?B?Rit3V2xONGxONUN6cEFsc1JFbC8zSklGTCsrYVBrQ3ZFV0FJMXN1N2xWcmha?=
 =?utf-8?B?aU1EMGtnNk5JeHZwQ3o4cGJzbWlzZE9oWktTTDVBVmlvT0FkSjFxTjRFeXF1?=
 =?utf-8?B?YUhsM05oakJUMnRHRUxZdFNIZjRxSkdOSUgwL1ZEQ05Ucm5VWnhlTHBXTVEz?=
 =?utf-8?B?VHliWnFHaWF1MHNXUXllSlFtekI3YmZEV1lSM1FyeWNteDU3YkNxaW9PaVIw?=
 =?utf-8?B?QjlSbWVDd1FRWVAvSzFRM2pOK3AyNDdMNDU1US9JU05JMVQwTDNGLzZycVlu?=
 =?utf-8?B?b1k3by8yb3BhN29SMkoreWRLTDJtZFowKzFlNGxmckhkRWJQQ0RXVmd2Qk5W?=
 =?utf-8?B?c1M5RXd0UVBuZlFBbmUwRWxQd08vNmxxbmlRbmw1QUhwUUhGdGFzVmVjM3pZ?=
 =?utf-8?B?enMwdTIrK2VUanZkNDJjcEo3SC90b09IaktsUVV3VFlUSFllMWtQTnArY3RD?=
 =?utf-8?B?WFo4TGlFeE03bXVpYS9QOGdIM1E5cUlRR0EwazdqYXBjNTdBY0VjRDA0WWxF?=
 =?utf-8?B?QkFGMVkvTTVIbEJtM1RLQ2lUWTZzeTk5VjRuTHh3Mk1nMWRvMzdhMlM2UlNC?=
 =?utf-8?B?V1BsV0E0aVVkdUxxSmpnbFp1M3pUaEtFRndYQVFiQlhrSHFOMy9LQVNxb1dk?=
 =?utf-8?B?N1o0V0dKZXJKNjBSbE1ZVTFHcjBDNDdES0JyRGU2c2NzaW5MaHhWdVdmYUhU?=
 =?utf-8?B?dk5hc3ZvSk1rTkN1a0NnVW5lbGs4RENOVWRQOU9KdGxOSkFUV2RVZTNveXlO?=
 =?utf-8?B?OWtDNElGZnVGVXk1VUJ4VWplRUR2aXBmLzNlSnFIM2M2T2Q4NGRBb3RCcElY?=
 =?utf-8?B?dW1sNGZKeXhsUU9uRXNMOVpGWHdYRStvWTM2am1FY2k2T0p2U0dOY0FNWUpw?=
 =?utf-8?B?MXlQVklINFhVZDRJLzlWSW5oQTc2dXZ1SDV5eXV5SUNrU1UxUEZBSUZJZTBU?=
 =?utf-8?B?VEpoUUM1Y1BqbzZqeEQ2ZnVsZDlnbmRjaFhLd21lNGxrNjU0Zy9hN0VnOUhi?=
 =?utf-8?B?OTYxSEFDWEZwN0xhNGIwTkUrK2R5cnlOcjNwVHpKQ1RlMlliblBiNWd4UHQ5?=
 =?utf-8?B?b0tMT0w3cUgwc29CVGN1YjFFTXNqVUhqbG52djhYQVIrVTJwL2FxRTRKYzhh?=
 =?utf-8?B?VU1La1NDeW5rcm5QNTJJRkkzVnRYTktMZjlxaFZhUy9sS1ZLSytoeS83ZUYv?=
 =?utf-8?B?enlvdDJNQWVTeTdmWkR4NFdta3F0ZDU1cG1WcVJtYXZPNmpoa0hCaFV5RUhX?=
 =?utf-8?B?VHR0ZVNTb2J4RjhKR3I1YlFvdmFsWUtCOXJrRUd4enlTczJCZEd2VUZEMHlE?=
 =?utf-8?B?L0g4VnRiU2p3QmdjeEtiM3FOSzhIMWllTU5sMVYzNGN5bGxTdjlYOU01NlM0?=
 =?utf-8?Q?bhi6YZo8yXEZcOkBuI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b47d0d-f651-494f-afa9-08dd9ee3dc33
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 19:06:04.5499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8900

DQoNCj4gT24gMzAgTWF5IDIwMjUsIGF0IDEyOjIw4oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gVGhlIGN1cnJlbnQgZXhhbXBsZSBmb3IgR21haWwg
c3VnZ2VzdHMgdXNpbmcgYXBwIHBhc3N3b3JkcyBmb3INCj4+IHNlbmQtZW1haWwgaWYgdXNlciBo
YXMgbXVsdGktZmFjdG9yIGF1dGhlbnRpY2F0aW9uIHNldCB1cCBmb3IgdGhlaXINCj4+IGFjY291
bnQuIEhvd2V2ZXIsIGl0IGRvZXMgbm90IGNsYXJpZnkgdGhhdCB0aGUgdXNlciBjYW5ub3QgdXNl
IHRoZWlyDQo+PiBub3JtYWwgcGFzc3dvcmQgaW4gY2FzZSB0aGV5IGRvIG5vdCBoYXZlIG11bHRp
LWZhY3RvciBhdXRoZW50aWNhdGlvbg0KPj4gZW5hYmxlZC4NCj4gDQo+IENvcnJlY3QsIGFuZCB0
aGUgY2xhcmlmaWNhdGlvbiBsb29rcyBnb29kLg0KPiANCj4gDQo+PiBUaGlzIGNvbW1pdCBjbGFy
aWZpZXMgdGhhdCBhcHAgcGFzc3dvcmRzIGFyZSByZXF1aXJlZCBhbmQgc3VnZ2VzdHMgdXNpbmcN
Cj4+IE9BdXRoMiBpZiB0aGUgdXNlciBkb2VzIG5vdCB3YW50IHRvIGVuYWJsZSBtdWx0aS1mYWN0
b3IgYXV0aGVudGljYXRpb24uDQo+IA0KPiBEdWJpb3VzLiAgSWYgdGhlIHVzZXIgZG9lcyB3YW50
IHRvIHVzZSAyRkEgKG9yIGFscmVhZHkgZG9lcyB1c2UgaXQpLA0KPiB0aGVyZSBtYXkgYmUgcmVh
c29ucyB3aHkgdGhleSBzdGlsbCB3YW50IHRvIGdvIHRoZSBvYXV0aCByb3V0ZSwgbm8/DQo+IA0K
Pj4gLS0tDQo+PiBEb2N1bWVudGF0aW9uL2dpdC1zZW5kLWVtYWlsLmFkb2MgfCAzICsrKw0KPj4g
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gTm90IHNpZ25lZCBvZmYuDQoN
Ck9vcHMuDQoNCj4gDQo+PiANCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dpdC1zZW5k
LWVtYWlsLmFkb2MgYi9Eb2N1bWVudGF0aW9uL2dpdC1zZW5kLWVtYWlsLmFkb2MNCj4+IGluZGV4
IGFmZjA4NjFkMjkuLjk5YzEyNmNkNWEgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2dp
dC1zZW5kLWVtYWlsLmFkb2MNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZ2l0LXNlbmQtZW1haWwu
YWRvYw0KPj4gQEAgLTUyNCw5ICs1MjQsMTIgQEAgZWRpdCBgfi8uZ2l0Y29uZmlnYCB0byBzcGVj
aWZ5IHlvdXIgYWNjb3VudCBzZXR0aW5nczoNCj4+ICAgIHNtdHBTZXJ2ZXJQb3J0ID0gNTg3DQo+
PiAtLS0tDQo+PiANCj4+ICtHbWFpbCBkb2VzIG5vdCBhbGxvdyB1c2luZyB5b3VyIGFjY291bnQg
cGFzc3dvcmQgZm9yIGBnaXQgc2VuZC1lbWFpbGAuDQo+PiBJZiB5b3UgaGF2ZSBtdWx0aS1mYWN0
b3IgYXV0aGVudGljYXRpb24gc2V0IHVwIG9uIHlvdXIgR21haWwgYWNjb3VudCwgeW91IGNhbg0K
Pj4gZ2VuZXJhdGUgYW4gYXBwLXNwZWNpZmljIHBhc3N3b3JkIGZvciB1c2Ugd2l0aCBgZ2l0IHNl
bmQtZW1haWxgLiBWaXNpdA0KPj4gaHR0cHM6Ly9zZWN1cml0eS5nb29nbGUuY29tL3NldHRpbmdz
L3NlY3VyaXR5L2FwcHBhc3N3b3JkcyB0byBjcmVhdGUgaXQuDQo+PiArSWYgeW91IGRvIG5vdCB3
YW50IHRvIGVuYWJsZSBtdWx0aS1mYWN0b3IgYXV0aGVudGljYXRpb24sIHlvdSBjYW4gdXNlIE9B
dXRoMi4wDQo+PiArYXV0aGVudGljYXRpb24gYXMgZGVzY3JpYmVkIGJlbG93Lg0KPiANCj4gSG93
IGFib3V0IHBocmFzaW5nIGl0IG1vcmUgbmV1dHJhbGx5IGxpa2UgLi4uDQo+IA0KPiAgICAiQWx0
ZXJuYXRpdmVseSwgaW5zdGVhZCBvZiB1c2luZyBhcHAtc3BlY2lmaWMgcGFzc3dvcmQsIHlvdSBj
YW4gdXNlIC4uLiINCj4gDQo+IFRoZSBvcmlnaW5hbCBzb21laG93IG1ha2VzIGl0IHNvdW5kIGxp
a2UgdXNpbmcgMkZBICsgYXBwX3Bhc3N3b3JkIGlzDQo+IHRoZSBnb2xkZW4gd2F5LCBhbmQgc2hv
cnQgb2YgdGhhdCB5b3UgY291bGQgZmFsbCBiYWNrIHRvIE9BVVRILCBidXQNCj4gdGhhdCBpcyBu
b3QgdGhlIGltcHJlc3Npb24geW91IHdvdWxkIHdhbnQgdG8gZ2l2ZSB0byB5b3VyIHJlYWRlcnMs
IEkNCj4gdGhpbmsuDQo+IA0KPj4gWW91IGNhbiBhbHNvIHVzZSBPQXV0aDIuMCBhdXRoZW50aWNh
dGlvbiB3aXRoIEdtYWlsLiBgT0FVVEhCRUFSRVJgIGFuZA0KPj4gYFhPQVVUSDJgIGFyZSBjb21t
b24gbWV0aG9kcyB1c2VkIGZvciB0aGlzIHR5cGUgb2YgYXV0aGVudGljYXRpb24uIEdtYWlsDQo+
IA0KPiBXaGV0aGVyIHlvdSB0YWtlIG15IHN1Z2dlc3Rpb24gb3Igbm90LCBJIHRoaW5rIHRoZSBm
aXJzdCBzZW50ZW5jZQ0KPiBoZXJlIGlzIG5vdyByZWR1bmRhbnQgYW5kIGNhbiBiZSBzYWZlbHkg
cmVtb3ZlZC4NCj4gDQoNCkknbGwgdGFrZSB5b3VyIHN1Z2dlc3Rpb24sIGFuZCBqdXN0IHJld29y
ZCB0aGlzIHdob2xlIHRoaW5nIGluIGEgYml0IGJldHRlciB3YXku
