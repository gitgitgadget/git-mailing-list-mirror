Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7681E86E
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334672; cv=fail; b=qF7r4JJAvN6UohB38FjSkcPa+Uh8F6Kay4s8lBG6ZdwNjF03NXntCyTby5zJYsh9t0RT9oHgUdk6u/ojRX/mGM/p9ia3wSLK7vHB0fJ8SyIPa1lQ8vDQpzgWOCxO41ZO+SxShSeskDc3yb187pfnjPs/+/eFLprUI6pIrcmvmCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334672; c=relaxed/simple;
	bh=fuQdxbcJGoOssOI0JhP5uA+oQDdOauF7OqlzyfOd70Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TKRIW8uHzp6dV3rI0H01VEucaBe/zpf0HmI4FF8Sll8l28cWkU2wDhXD5Heft8zK6oXOO9TNoS+nSoNjHwKh6+pBqAPJmIitGpY3xoqG1zjzSSHhHx+GdNTbypyZcivVRSosD3Zx+RIuniZ2WLDIVQBW0PinNnjNZii5HNMifA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=C6hFdvjE; arc=fail smtp.client-ip=40.107.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C6hFdvjE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvVOb0xHnRLly3OPiy5voaq//Qp1Bu7KA0kJBctEF1BF3t2Lao8Wq6qrGmaWGS1LMnIZR5EMxEZLdRDCdvSX0gFq73FdQDdhr04OuyDI/lPpdwoydn76T0Q2sWFGvUHiOj4FqJUl90y2CCnGpFFrHQAdSCg9zLLKLjxNlVpkydOo4d1Ce0yEU01fN1MN/q2pURfos/MhitXCqNxSb+b2Y0y1mXe0G+klpqWS9CvBuyF28Fotkvp4bhgv88KlFaT4vppr/zJiOJfcIbD12LBDvPSgAgT5Fp2jaGi1iBIE1BD8z5MnmP1LqRSUhhUgRHMmaBH+/HmyVLgsQCEoWj3DJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuQdxbcJGoOssOI0JhP5uA+oQDdOauF7OqlzyfOd70Y=;
 b=R56TmbT9iTcEd6VblqZNPZJZrVV2Gaho/a7ek1BOG7uTGIYxa57r0Gmpq/FBs1IrfHupJT3Rzxy8sp+blEPsUR4prH84B1PvBNqaU5NHDc2NpISph2wne7VlrCedPr4BGnsUXnvBvx5Ua1shkNpU0N3PxvEtMpSNfSU0vhgAuutDv4FEOfDZbk8Tqrs7skJvoWmrF/NSHZpyusnhjgffrBN/0tfnorkra3vYemCc04b0K15OmNeEOTJCVbx5uAzL3vjWqgP+BEsu2iy7A0glbw6c/C3eTwKv2FhiVXllrbsp6r8YEuR6LNSl22N0P9X205AClO+IAHIC9h+kgbqPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuQdxbcJGoOssOI0JhP5uA+oQDdOauF7OqlzyfOd70Y=;
 b=C6hFdvjElzkRyrr68EuQ7l1TxRX/DY7bXejBNfLnS3rERoEqeivkyGVTeNKvcchS0rIBkx4sqxiMrNEKTzr3n57twriJ/9yQOPQXPSMHPK+mdT6/KEgfUwj5cxI3k8K09smWEoncVVpK9BMlEnqYMXRI79NAhNu/FIZ2Cnj+9Ak=
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM (2603:1096:990:66::7) by
 SEZP153MB0742.APCP153.PROD.OUTLOOK.COM (2603:1096:101:94::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.8; Thu, 26 Sep 2024 07:11:05 +0000
Received: from JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5]) by JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
 ([fe80::4922:44b2:6f40:adc5%3]) with mapi id 15.20.8026.005; Thu, 26 Sep 2024
 07:11:05 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Git clone failure
Thread-Topic: [EXTERNAL] Re: Git clone failure
Thread-Index: AdsNpfAbFAaj1HJpTgym8QYEmPxgqwBJSVsAAA5CWgAAInXsAAAVTJYw
Date: Thu, 26 Sep 2024 07:11:05 +0000
Message-ID:
 <JH0P153MB099919ABE06434F49ABF43F7D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
References:
 <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <ZvMy_gAL96v8ahfz@tapette.crustytoothpaste.net>
 <SI2P153MB07185B9AED66870BBAD3C78AD4692@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <ZvR58tnLEMBZC4fa@tapette.crustytoothpaste.net>
In-Reply-To: <ZvR58tnLEMBZC4fa@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85dc39e7-c184-493d-bc19-da334f1c60a3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-26T07:10:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0P153MB0999:EE_|SEZP153MB0742:EE_
x-ms-office365-filtering-correlation-id: 8cfa866c-5cca-45f4-d672-08dcddfa62e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjRFTXBtbWZTTThYekM5cGVZTUU3cHhXam1FeWZwemVpL1B1Ui9vRTdWL1VO?=
 =?utf-8?B?UTg1dEpyMmVhd0k5K2txbnRkY09Ldko0TFNqTlM1ZnlzVnhjUnc4T0VFRUNP?=
 =?utf-8?B?UXlqWjFOTGl2c01JQ0ZUbEE2SEdlRW8raU52ZjROTTdLaXJlbjl1VjZvYU1v?=
 =?utf-8?B?LzZYc2lTQVV0RWh0VlA5M0tKZVo1cm9ndFlCM3kxaHZ0QWdRcWtrMDBBb3px?=
 =?utf-8?B?MDdLaEk1cTJMUU9VNGhrUVpxbmhvVHhNUWtXVXh1MlVwcDV0UXlVaDlnREc0?=
 =?utf-8?B?TFdCQmkyTHFtNWpCbGZMbTdNSC9qS2ZnQ2pVRTdnRzB6ZHpuTitQZVBHRytB?=
 =?utf-8?B?R2IyY3dtYnRGQ2Q1QnRwNlZrcDJ4d2ZlMlVudW95dVkwa1dHbndTNXJDdmlk?=
 =?utf-8?B?aDlyeVM4cndaTXRVMXJDN2lqMHc1NDNCMTRPQmd5QmI4TDdFc1hHVWRYaUZU?=
 =?utf-8?B?cFlqeVVkRkJzYkh2eHpEOHNMVHZCRUowSUF6cHpxSmNOTGszbE9uSXl5T2J6?=
 =?utf-8?B?RkUrMTY0bm1YaVd6cDNKdVpGMzBUWTZhSTZWRVNucGtIK0d6Mzlra29xWlUv?=
 =?utf-8?B?TlVlOU1KMm1nRmIweDNqandCbDRrWGljUDlUUFgxRjhMcDF3d01XRFFPcDJm?=
 =?utf-8?B?SVVLMWNKeDdkWjdkZXZLQ2JYT05XSzBQYTcvZDNyeTB1V243N0Z5Q1BNUUNz?=
 =?utf-8?B?ZjllT0pvc0FFcHNEendrT1pZZlNzdzlkdG0zeENFeDlWcU1QM3RQRUhGUENI?=
 =?utf-8?B?dzBiVGg0UVdESGFTSlpUd3pkcDVLc3lsWlJIU0ZCQlRMbGx6OUpGRGZUYlBO?=
 =?utf-8?B?VU02YTk5aE9jRnVDUnc5Q2hoVEQ5SVlkRE5PTnUrNmcxUEVPQ0xybERqSzFH?=
 =?utf-8?B?TnZBVTh5UStZTkcvUGcyZ2xQNk9OMkhoZ09BaVZLVllWUGlqRGQvZ282Y1Ir?=
 =?utf-8?B?S2gycnZmei9jRExlemdBSmR5eEs5ai91NEREQW9kVnlHL2hQOVB6YlhQdlh2?=
 =?utf-8?B?MEdNSU1VYlgvOFo5TzdVUGR5ZHdoTkZsSEwrYXl6emd2MU1sQ3IvaGdOekxp?=
 =?utf-8?B?MU5yRzMzOU1uL01LRjJ2SXg5NUFXK3ZlcXZSUUNQYWczVlZDUVpsa1ZHR1hu?=
 =?utf-8?B?aVBmQmFRL292SVNKQkQwQyt4bmdsVXNCSE9aUUhtNU10VSt1aDg1akh5eGtY?=
 =?utf-8?B?RnRvNmRtQTBGclBhREU1MUhtZFl4QmJGUmRkTWxDSUk4STI4ZmdNRTZOdDhI?=
 =?utf-8?B?V1Y2K0ZQSW9aR1paTnVUTm50US9HODFMbWNNbVNLbGJiQUVJemdacGtnU3h6?=
 =?utf-8?B?a1MzckM0Q3FOU1B6eHY3U1Jzc0poVzdkRGxIbnV0cjcxRExPL2V4em90bng1?=
 =?utf-8?B?aEpueUZway8yZUdwUEF5NTBoYnFVZmMxRGF6K3ZFVmpsS2lQWEZQdmtJajhR?=
 =?utf-8?B?Ym9LVkN0c3dhNElnc2hLOW1uUDFMUTVTSkllU1N3OEE4cHdHQXVFZkxxQ1U0?=
 =?utf-8?B?L3FKWU1RdlVQSjlIc3dwTU1jd2w1NzVWRkZJWmMxM01oMDhjUlVZVFQzTHNQ?=
 =?utf-8?B?dXpYekY1ZG91M1VsbTFBdk9JU1pQa0cyZnlIaVFWQXdBdEozOVFlNVJKUEJs?=
 =?utf-8?B?cEJ0bUM0Wm5UZVVHQzhUMEVuN2srblN0aFcwUHlIblFrTS9URDV0UGhIL0hS?=
 =?utf-8?B?VVNBQ05iM0tlWGhkMzFsYWN2akcwQURQUHVLQTlBQjFnVE41RXV1bnZTYW9q?=
 =?utf-8?B?bkNlbW9MSUY0VzJwU3prdlY1a3RYcDBHNlFmUC9uM1RPUjIzQjBVSWsydk04?=
 =?utf-8?B?NWl2c0N5V1R0dm85Mkgvdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0P153MB0999.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVRsNk56MmVKQW9rY2wxNXAwb2QzRUN2VWszMXZPaDRpMERHS0piaERDNE1K?=
 =?utf-8?B?MnRvTUpGSEo5YjFFR01WcnB3bzJSc2ZYemlaeVdwRUhrbnBUUHpZU013N1Fk?=
 =?utf-8?B?VDZnMmxWejlNWXcyblZ6dkQzL2xyeW04a1F1Uk4yYkJjS2xSQThaQUFlVCtq?=
 =?utf-8?B?M2dpYXRpRVdjeXQ0ZkIzY05vYjdBeVZWZWZuTDZ2R2cydEVXa0k3T3RaaWd6?=
 =?utf-8?B?YUhTR1JDam5zeSs0WFFsVi9PN2RpUldEWEIybDJwWVUvUTlzWXNtUk1USlpT?=
 =?utf-8?B?RDVkSUdKWFYvVnhjTjVxMXBUZGR3UXZtUGJqSnpxdjlpVkNmTlE0d2U0T1FR?=
 =?utf-8?B?aER3UHlDVzUxb0FwMU5lNjhGR1h2VHBuZW52bEYrbWVJM2U3OTRzbWprK1dU?=
 =?utf-8?B?cEYzMldDellVWG9ydVp0WG9zaDIxTEFlUk1kZ3lwWkVQZXdRdldpYVN1L0VY?=
 =?utf-8?B?Y0haa0ZmS1FXQlZyZ0tQNGZybWZUVFYrVTg1WDA3SEhBbXBoMnJVZjYyVHJF?=
 =?utf-8?B?UFVta244MW01eFAwVmJOWlJIZVBBdVVJTG1GUHc1SWVJekVuWU0yNS90SVJx?=
 =?utf-8?B?MnBJaDZIMHh3RThSMm9HTXFHTkFwYVBLbWtHTDdLV3ZOVE1uQTNCNmRnRE1x?=
 =?utf-8?B?SjRUZFdOTlVrOUtsbEhib3E1YXpXZmhCdjRKWEttOEFvbW5EZk9Xb20vcWNO?=
 =?utf-8?B?dFNha2xCZ1NXM1REbkNKdnZWSzBmbGhvbDdVVG1yNmFjczFncVB5U3JEZlFo?=
 =?utf-8?B?dWd0d1p2SWNNb0dSZ1E4RFZHRE9rV2YzWlRwSVZkS0RQT29GTjZsZXo1eGRv?=
 =?utf-8?B?L0txWCs5NHJPYVllMkR5SDZGa2pZMm9FeXVaakRDMGRVTEdqQnZxd1dUNGxP?=
 =?utf-8?B?WVJoZlh0WGtydXpRZ3FjcW8za0tTN2l1dzJ4clZKcERMV0NkMU5PUHkvQU5v?=
 =?utf-8?B?ZGVJWHhzUlRaV2dFMzg4Tk10cXU3UCtrbEsvQVlkd1p2RjJuSjU2U3ZzRS94?=
 =?utf-8?B?Nkowc1NFV3R5YUw3TU92bWF1TWhLK1dyMWl3SWliMzUyeC9YWC84a3JodmtI?=
 =?utf-8?B?anFWRFRqM2xiNFk3TnFWaUpxajFTZmZSeW5iWVk3RmowWFZUOERJVExxUnBn?=
 =?utf-8?B?NzV3Q2RRWi93bzJwY1ZJRUJ0emhjMkdHeXJKL0R0Z0FaSmNZYnhIdTNDajV4?=
 =?utf-8?B?UkppNTNndU9ob1VFWnRjQWdUWmlaalVvT21vSkFZZ3lpd0NzejRTZ01GTGdk?=
 =?utf-8?B?d0dEQURuWmQwTXV5VEdadDdmb291U25iTmVmcnZqb2VZUGNnVWIwMUlLMU5p?=
 =?utf-8?B?a2c4bFVkWUgrVnRVWTlXZ0d5MlNDQk52TmMzWXVpZGdXeWNOVEM3NDZHYSt3?=
 =?utf-8?B?SUhPeUFibzhrZG10NUViSmF1OW9zcmZjTU4wakhJVWlQUVAvUytMQk1zTnpz?=
 =?utf-8?B?UXZWSVRrTm43NGRNby9uRlkwRUpwUWkzMEVDMVpmS2tzY0NKRWRZLzFubkw2?=
 =?utf-8?B?d0pON0hmS3ZZaUp2ZTh4NEsrcWhXZFVXVFV6Q3BFcmJleGJhaU96UkJIYkZC?=
 =?utf-8?B?eHkybENOUU9weVU3dzFFYXd6Zkpweit1NFhiMlhvVUc1ZFJEcGJ5WERSUHYv?=
 =?utf-8?B?Y0JLTHlaeVR2NkE5bitIWVZkbjcxbHlra3N4ZU5QQTdpV0g2blNvR1F4ZEJL?=
 =?utf-8?B?MDV5cTVmZXJlTlIzN0lGRXNkYTd4cm9QcG1Nc05ZajJxeEQ4UXhmS1BwZFBS?=
 =?utf-8?B?TURmUzZwWmZXaENSVFJOM0xUQVRNZktHaW4wbi9MRE8zV2tPcG9NbS9BaExq?=
 =?utf-8?B?anZDQkduWCtDbzVoTWpKZnRTcDRXbHlEN1hsQXAwWm9XNzJvOU1XOFpSVmIx?=
 =?utf-8?B?WXRPdFdQS0xIQVdOTFNOS0JMZVQzOS9ad2ZGcGlCVjhnN0NFSVNaRnNjdjlW?=
 =?utf-8?B?RC9sZytsVkMyWVNiTk1XNmx0VExBZWI5SEMwUjVlWEhCNjhZbDYrc0xCWksz?=
 =?utf-8?Q?Rb66I7mYID3OkU0lhPUfo6EjIx/9vI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0P153MB0999.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfa866c-5cca-45f4-d672-08dcddfa62e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 07:11:05.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wY7Fk3206cElDEA40MaqEiZl35xfs6hUQEJ0FuXrCHkeobI5lCPWTWsg8ikO7FCH865YYKy8cj8Mqs74dd5Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0742

SGkgQnJpYW4NCg0KQ2FuIHlvdSBwb2ludCBtZSB0byB0aGUgR0lUIEZBUSBhYm91dCB0aGUgcmVj
b21tZW5kYXRpb24uDQoNCg0KDQpUaGFuayB5b3UsDQpLcmlzaG5hIFZpdmVrDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBicmlhbiBtLiBjYXJsc29uIDxzYW5kYWxzQGNydXN0
eXRvb3RocGFzdGUubmV0PiANClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjQgMjoz
MSBBTQ0KVG86IEtyaXNobmEgVml2ZWsgVml0dGEgPGt2aXR0YUBtaWNyb3NvZnQuY29tPg0KQ2M6
IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBHaXQgY2xv
bmUgZmFpbHVyZQ0KDQpPbiAyMDI0LTA5LTI1IGF0IDA4OjQ5OjExLCBLcmlzaG5hIFZpdmVrIFZp
dHRhIHdyb3RlOg0KPiANCj4gSGkgQnJpYW4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlc3BvbnNl
Lg0KPiANCj4gSXQgaXMgYSBXU0wyIGVudmlyb25tZW50IHdpdGgga2VybmVsIHZlcnNpb246IDUu
MTUuMTUzLiBXZSBoYXZlIHVzZWQgYSBrZXJuZWwgdmVyc2lvbiA2LjYuMzYuMyBhcyB3ZWxsLiBT
Y2VuYXJpbyBmYWlscyB0aGVyZSBhcyB3ZWxsLg0KPiANCj4gcm9vdEBERVNLVE9QLU9PSEQ1VUc6
L3N5cy9rZXJuZWwvZGVidWcvdHJhY2luZyMgdW5hbWUgLWEgTGludXggDQo+IERFU0tUT1AtT09I
RDVVRyA1LjE1LjE1My4xLW1pY3Jvc29mdC1zdGFuZGFyZC1XU0wyICMxIFNNUCBGcmkgTWFyIDI5
IA0KPiAyMzoxNDoxMyBVVEMgMjAyNCB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgNCj4g
DQo+IE1vdW50IHBvaW50IGluZm9ybWF0aW9uOg0KPiBDOlwgb24gL21udC9jIHR5cGUgOXAgDQo+
IChydyxub2F0aW1lLGRpcnN5bmMsYW5hbWU9ZHJ2ZnM7cGF0aD1DOlw7dWlkPTEwMDA7Z2lkPTEw
MDA7c3ltbGlua3Jvb3QNCj4gPS9tbnQvLG1tYXAsYWNjZXNzPWNsaWVudCxtc2l6ZT02NTUzNix0
cmFucz1mZCxyZmQ9NSx3ZmQ9NSkNCj4gDQo+IFdlIGFyZW4ndCB1c2luZyBhbnkgc29ydCBvZiBm
aWxlIHN5bmNpbmcgc2VydmljZS4NCj4gDQo+IFdlIGhhdmUgaW5zdGFsbGVkIGEgZGVmZW5kZXIg
c29mdHdhcmUgd2hpY2ggaXMgbWFya2luZyBtb3VudCBwb2ludHMgZm9yIEZBTk9USUZZIHRvIGlu
dGVyY2VwdCBmaWxlc3lzdGVtIGV2ZW50cy4gT24gcmVtb3ZpbmcgdGhlIG1hcmtpbmcsIGdpdCBj
bG9uZSBzdWNjZWVkcy4NCg0KTXkgZ3Vlc3MgaXMgdGhhdCB3aGF0ZXZlciBzb2Z0d2FyZSB5b3Un
cmUgdXNpbmcgdG8gaW50ZXJjZXB0IGZpbGUgc3lzdGVtIGV2ZW50cyBpcyBjYXVzaW5nIHRoZSAi
dW5rbm93biBlcnJvciBvY2N1cnJlZCB3aGlsZSByZWFkaW5nIHRoZSBjb25maWd1cmF0aW9uIGZp
bGVzIiBtZXNzYWdlIGFuZCB5b3Ugc2hvdWxkIHJlbW92ZSB0aGF0IHNvZnR3YXJlIGFuZCByZWJv
b3QgdG8gc2VlIGlmIHRoZSBwcm9ibGVtIGdvZXMgYXdheSwgZXZlbiB0aG91Z2ggZmFub3RpZnkg
aXMgZW5hYmxlZC4NCg0KSXQncyB2ZXJ5IGNvbW1vbiB0aGF0IHRoZSBraW5kIG9mICJkZWZlbmRl
ciBzb2Z0d2FyZSIgeW91J3JlIHVzaW5nIGJyZWFrcyBhIHZhcmlldHkgb2Ygc29mdHdhcmUsIGlu
Y2x1ZGluZyBHaXQgYW5kIEdpdCBMRlMsIGFuZCBpbiBnZW5lcmFsLCB0aGUgcmVjb21tZW5kYXRp
b24gd2UgZ2l2ZSBpbiB0aGUgR2l0IEZBUSBpcyB0aGF0IHlvdSB1c2Ugb25seSB0aGUgc3lzdGVt
IGRlZmF1bHQgYW50aXZpcnVzIChhbmQgb24gTGludXggb3IgV1NMLCBub25lLCBzaW5jZSB0aGVy
ZSBpcyBubyBkZWZhdWx0KS4NCi0tDQpicmlhbiBtLiBjYXJsc29uICh0aGV5L3RoZW0gb3IgaGUv
aGltKQ0KVG9yb250bywgT250YXJpbywgQ0ENCg==
