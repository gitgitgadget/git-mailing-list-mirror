Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050A1DD0D4
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751699373; cv=fail; b=HR+nSkBnjx6Rcb7NhFMxlOkOT13OxKi0P+u1pUsEOoIqNypik7yF/Ww2CmC6euEvuRBSKQ2RLnhyBGCrugr5QRA2/LYYzgjFJSAsbK+9O7S62Fw0155l8H4VILGa0UV148//onhmJx5/F243JS9lHFPnUtGneefk0a6H4tD8Ahs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751699373; c=relaxed/simple;
	bh=OTjkH0rTFL8vsQTohACHRKuBiCzn1qn7kSw4PoRsIIU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=qHAtEAaeBRNBqoYFOHsdAxX+PafF6JmqkDcbTNzCu98LzAGKLj67yLVDZmw92573P3uHtWTmgyvIL2QoSz1BN3/mJ08Uk8otobWwG44wEr2F0qQfG2SCqKS2+VKDWFkjmWhrcuRPoFi+La/0y67VWckdnDx79oXzvaRTDwN+AfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=S8ryeAi8; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="S8ryeAi8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEdGj/TjFLlDftN3AcI68xra5GYbzMhG3lOBWcOtp/MResDGmEljZcI6NjidKznqUd0EnUQb/VJDVogEg4ohQNbi3I68jvt7U3PIHizu3tHUnvtgFaS1W1H20Rn7k8rufE0hPZG4b4JOmLtoKNfE6sXgZy/XkY01omeVySmt+3zBtacxp9d11BjRLxBnjYoWsV6hZRe7tK2f2710xI7wprExAzO+nZISJdnhfgLmF6dHZQCuNFrWK1xNhks6453Ya1FUxAavTlxD16lV2srp/pNtATeTppCpk98EOmZCm4UknloRVw15aGl8kYaexz9rd9YGVGMYLOhx1aaH2513hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiJDRLh47zokTnHOyw3HQQYPhvjBhWe7+UNrYrAdgE0=;
 b=ovn4PLrQ1+W4j6SR9X+KA3psTULYvsWkUPXshdrMRJk7ghi3Jq4N98lMXLTO/jCnh2WcXHPxzQCQWvQPDbiLXiPvy8fE4kDgB9SYm4n2IUfcLMZwuGvd9QZX3Z2oj+vozuKYLU5y41RIYZFFmtp3wkVoJuOuWWegyv68ANHHutpJ3G1uQCh5Ht4o8TxkzCJZCom/bfGw5DGq3sUUNX3ZfA/rkYs0icbEUHZdnDGQEottY6LHb1/N7bxI70ctijVksd0UeC8BhRZ0ONxd4K3o+r2Y53hIsDukwP+Ry+xHUIrnpwlof87hVBkSEE+RwHjUeziL+02cB/FaBO42dZKZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiJDRLh47zokTnHOyw3HQQYPhvjBhWe7+UNrYrAdgE0=;
 b=S8ryeAi8tMXIbKFDjkyEJO03tCLyJBhWZ6ursksah3qRecO/JIKWDOqCZ8GrXCf3geUE46MnEZSFOL2zjHOMK//z6yDhZwUTJ+b+iGWuZgvZWltTzeGkBKf2sNtcxt3bzYUHAPx75LPqJQnnUzA0Rj8RHpmTq796ddop4Hx4n2F5FWSSS58X9IHxSUgV7Q5yEbwn0rkV/Dk5K/LKc10miHgUGYTvOOCfaGNLGGEOLQRljinXH7f49qhTpN4Z9IDHCD4q/yQ//WTUCI7QTAwiXo3hnDPdsmQ8xfMzL5DNjPkbaPeDlrM+wNzrW89sr1irfT0JO/srSpWOFlzMIu5lXw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN0PR01MB9289.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:11f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Sat, 5 Jul
 2025 07:09:27 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%4]) with mapi id 15.20.8901.023; Sat, 5 Jul 2025
 07:09:26 +0000
Date: Sat, 05 Jul 2025 12:39:19 +0530
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: how will sha256sum be implemented in git
User-Agent: Thunderbird for Android
In-Reply-To: <aGgrIWSitF1NsN2L@fruit.crustytoothpaste.net>
References: <PN3PR01MB9597524FAEAA3B26B15804B9B842A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <aGgrIWSitF1NsN2L@fruit.crustytoothpaste.net>
Message-ID:
 <PN0PR01MB95888ED474AD92298DD290A3B84DA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MAXPR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::21) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <279A27D8-8857-43D7-9B02-90464F2519A5@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN0PR01MB9289:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b036a7-5599-4d23-4e50-08ddbb92dfb3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|15080799009|12121999007|5072599009|6090799003|19110799006|8022599003|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG05MTY2UnZwMkpPRkppaWllYW9Fd1QxR0VsZ0U4eGFXQ3RrdUZyblF3bURG?=
 =?utf-8?B?cllXaS9JVnZmcVRRbnpra1dsSG56aVlnc2pNYU9xWHZrMncyTUpyaWFhMkFK?=
 =?utf-8?B?QnJnejhRdjZLTDNSRTJDQVF2b1IxQnJ1aGhVRU9tMUhmK1JUU1ZjSVZFNXZR?=
 =?utf-8?B?VzhMUGwzTllUTWpONEpWcnFYV2xEQk50ZE9wVzVrcWJSNmNpVGIvVzNsazNi?=
 =?utf-8?B?a1hxUjhEZzN0UUVYOS9CdkpZVmtwYUl6OTZncEVQZ1hBYnVyWFBYc1NuMHhw?=
 =?utf-8?B?K1RrUllWMlRCWnZxOGpGOEpPZTl1SG85cFFNUFJ1VEFlTWo2dWdxRDUxelJk?=
 =?utf-8?B?SnlCNnlDenVDdk1PNHQ1SVltUFhQbzRWRVc0eE5TdnhnNTFCY2NlVzNuUWdV?=
 =?utf-8?B?V3ZMcUJkTmhYVmZDeDAzS1RGaG94UHRZbSsrYjRiT3dkeFNjRzI2UDhlaHZt?=
 =?utf-8?B?TEVpdHROVmlMQWFKRSsrSFNFNGtkUm03a2ttYmhVSThpU2tpNUNiK1ZPWmRz?=
 =?utf-8?B?M21sQjFWd2QxK1JtUS8xWm0xZG1zREhNYmc2OVlTeGE5NHNGVWh5L0tiUVF1?=
 =?utf-8?B?cC9RNmZMZCtlTXBJZTNYVzVBUzBvTS8yRFZLbmFVY2xtRXR3bldDaEROYnhh?=
 =?utf-8?B?ODN6TUFlS0EraEFuL1NBSC9ERDI4dWtQQVptbzUxdG01dlMyZEVnNGY0MkNM?=
 =?utf-8?B?bWMrT1V4VVFBM2VoWUtiSHZvOThkUnJXL1FRMm5Ba1ZyOS9JYVc5YVc5cHpU?=
 =?utf-8?B?c2g1ZzFwaHpFbkg2ajVmeWlLTGozc0FhWC9ld3JreEE0SEoxTzhTOG9KZHlo?=
 =?utf-8?B?TnY3dzhGbjMrUDN6ZWJsZ255S2doUFBSYW0rUGR2NUZ4RS9NNUN4YWtSb0ND?=
 =?utf-8?B?ZWN6bXJUb2RRbUVIeEZZMU5tQmtycitXTHlsVjRHUWFQYVU4RzZiM1lTN0hq?=
 =?utf-8?B?TGNvdXEyQWlmQjVXYm5QZTFkWWF6eEFZaTJlQy95SXQzRWRaMzkvMHN0aHZu?=
 =?utf-8?B?Ky9VL2pVTjc0QldWVDNEb0cvKytwWHA3ejNTZXlXU0hPRXhCVmFwNjdoWnJq?=
 =?utf-8?B?ZU5wOW1wZDR4RCttazhZTnBsNlM5aHdodWh1eWQyTklQdjR3ZlY3T1hvQml0?=
 =?utf-8?B?WTFlSEpwT1pXNm1yd0NMUFhrUFQzZks1ZElZa3dTcnh2aW00c0s4U1BVN0V1?=
 =?utf-8?B?Z1VWUmNDc3ZRZ2N3YXA0R3JQM1NtSGx1cmFsQVM5bnoxRzJZMElyalJGWjBY?=
 =?utf-8?B?UkFUSXZVY3dKYVZnVnU0NUYxRnNNaU16akZlVytiV0s2NHNtd1NibnE1Q2VL?=
 =?utf-8?B?RjFTMW4rZlhaRjlrY3dDb0krWXJQTHE3SVpHZkYxK1hnL1FCc2FWeVVkTUw3?=
 =?utf-8?B?Uy9yZlpyRi90Tm9YQ3pwRzBVaHdaNi9oOWN5N3gxV05BdVd5aFpnYXh5WmpF?=
 =?utf-8?B?R2hpWS9LTjhoK05FazNHSmJXb1c3T3REcHpSOUtXdi9zd0txZWtYMCtYZTRB?=
 =?utf-8?B?MS9mMGhPZzgrRGZQRkdKa3pXQ1RLR3NCWnFhVXJsNys2QkxxeU9JMXgwTytJ?=
 =?utf-8?B?QkYxcGJ6ZXZQb2phVWZGVkgzUlM3SWRiQ284TVNIQWdmZElKRzZxcitYU2RO?=
 =?utf-8?Q?P7efVnwQRXOVEZtlNvOLA9XhWbaD24szHJ7PNq99voEM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3JjQTVwZG5tWkNaOWlWMkxOTWtFazJ0MW9PU1FySnR4WG1xcE0yNGhoVVlm?=
 =?utf-8?B?ZFpCSndxOVFqdHpkL1pzT2QzSjFjUEI4Rjl6VlM3Vi9PbndNbVphaE5SbTRk?=
 =?utf-8?B?TTJEOFowQlF1N2pVNlNjdmQvaVJrN0xxY3ZuRTNsTWhpZVpKYWRXWlNHMVVr?=
 =?utf-8?B?MU02S1hCYXN1NzNNWThudE1rUnlWV3RQaUltbVRzMGxvQkJrZUlHandmRk83?=
 =?utf-8?B?bEJnc0JMeVNxem83Mm01TTdHb1pBVWhoWEtVYUk0b21XUDFPcWhnY083MllT?=
 =?utf-8?B?TWtHZVdZVUNKb1piL3dGM1pqWE9rSUhYdFE5RThOUW52aVh3WFJOcm9KK2tl?=
 =?utf-8?B?Qnk2enZnQXhLcWVjVnVqUS91L0hEcFpJQTc1ZUZwZlp3WG1Ra1BkR010ODVs?=
 =?utf-8?B?STJLQTVKMGR1MXZiVEh2ZzRHRktBYmRpOG43bitUVExHWmxPZ0pSUkpHSmsx?=
 =?utf-8?B?SnVSdzd6K3hIZ0tMbVRmRDF0ODd6aitRVGdzL2crZTFzeGhvSjlMbFZORDlN?=
 =?utf-8?B?YTB1ZDZaL0dscTN4UnVoZnR6NUFkcDZOWmJnWlNIRDE4aHQ3VkRyK1JIRkhk?=
 =?utf-8?B?NllBZ1pRVE5PN0VheHhhZk1OS25HUEQ3ZUhjWkdIWVlaUjY5cXlDMVgvbjdw?=
 =?utf-8?B?K3NyYnk1ak0ybVhEM0hpV09jNXJEY0FPN0tMUFQ0N1h5RHdTaEpiVS9sYnFo?=
 =?utf-8?B?TWp5ZGREQmFveEtsdUg5QXVIRTBEUWVxUFZ4eWtndzBrMlo4YUJpemE3eDVZ?=
 =?utf-8?B?UGlpUE95WStrb25OZVZyRnVlNXdOTWY0cGd2c0s5VS9wZlFkYXE0Mll1VkRW?=
 =?utf-8?B?VmVtQlBkR2NpR2RQTUdEWThqbTRzMUtQWFNpUzJxOXczZ1p4Z2ZrcHNqVExK?=
 =?utf-8?B?QmJtRG5YcFc2bE5NdDArMHlzK2pKcUhkb3JiYTllKytabUZYY0g0clRTL3g1?=
 =?utf-8?B?R1dQUHVPQ2J0bFdxRUpjTUw3U283QXMxUVJ3b3JFc09hY2tSNEZJdnIrRXBV?=
 =?utf-8?B?S2JzRmZ3a01TZ0ZQcXh4U2hsUCtQWlNqcGVoRTFyenErL0V1R3F2TUh1VktT?=
 =?utf-8?B?azR0S2IyQ0wycU1JRVV3YUlYbWQ2U3RaRGdkaEdzalFrSHdLcVQ3UE9haVFn?=
 =?utf-8?B?aVZMZUgxMWlWSlNhTms0SWdNRXY0S0t2QUxjM0dueFhCWCtCY3gvaDAxK0lG?=
 =?utf-8?B?bkFCWmROTlF5eUUvT3o2Nmt1WkJlWFM1Z0xGYStydXVMOWFqVWlVQXJqRXpB?=
 =?utf-8?B?QkFhSWhJbWpjOE1LZWVTV2tPeFBpeXZVSGVTU0ppQWRoS3AvdkIvQnhQbmZR?=
 =?utf-8?B?b2syOEJocjl2T0R1cElvNk9GUHFLV3A4YnhZK1FuVzNHQ1RXVTRuK005ai9M?=
 =?utf-8?B?Y1o2bi96U3RaYlJqdlBwdS9HRTZtRjRtTTk4Z011NUV1eVdHTWxnYmdtdDEx?=
 =?utf-8?B?NG94RjlRVTN3eHlKZnZKcGVtYXEwNWZsLzNTcU5hS0tVOWFnU3FLSmVkYmJo?=
 =?utf-8?B?WkJuaGE1eUVBNWpHVmpZV3h2SXE3dGp6YUtCdEw2QlZka0l3TjdybE5IUnlo?=
 =?utf-8?B?ZWJnakNheDhLblRZeU9XVHBla0J6WFBIY1JPazVOWUN1bllGSG4yMVV1QXBP?=
 =?utf-8?B?U014NmVRMDZYejllTGJOTXB4SE11ZGMzRXBuT2JKaGJYL1FPNzYrRmdoSkRm?=
 =?utf-8?B?aVNuZ0Zha1A5SXpGUitkckFURjNUbVNiOTF0NFJ1eFJQa3JCcGRRYXppZGRZ?=
 =?utf-8?Q?3DebOHGBAX4A4d86u1s84juoJtkeqMED1vpL/9L?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b036a7-5599-4d23-4e50-08ddbb92dfb3
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 07:09:26.7509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9289



On 5 July 2025 12:57:29=E2=80=AFam IST, "brian m. carlson" <sandals@crustyt=
oothpaste.net> wrote:
>On 2025-07-04 at 11:18:12, Aditya Garg wrote:
>> Hi all
>>=20
>> I just read that git aims to transition to SHA256 by default, and conver=
sion from SHA1 to SHA256 is needed for old
>> repos. I was just curious how will that be achieved.
>>=20
>> Dumb idea, but maybe we can just encode the existing SHA1 sums' string t=
o SHA256?
>>=20
>> Eg:=20
>>=20
>> $ echo -n 8994f255af5451b6cd1db01ee16d8cf15b9df81e | sha256sum
>> bf8d6d915848377db81ee47e883c0a683b3d86a49ab120191ea1c3d76a30c33f *-
>>=20
>> so bf8d6d915848377db81ee47e883c0a683b3d86a49ab120191ea1c3d76a30c33f will=
 be our new commit hash.
>
>This would unfortunately still be vulnerable to collisions in SHA-1,
>which is the problem we're trying to avoid.  For instance, if I can
>create two blobs with that SHA-1 hash, then I can also create two blobs
>with the corresponding SHA-256 value, since the input in this case is
>just the SHA-1 value.
>
>The way we do the transition is pretty simple.  Blobs don't change; we
>just hash them with either SHA-1 or SHA-256.  For trees, we re-write all
>of the entries to use the SHA-256 object IDs instead of the SHA-1 object
>IDs and then we hash the result with SHA-256.  And for commits and tags,
>the headers that represent objects (tree, parent, and object) are
>converted in a similar manner and then, again, hashed with SHA-256.
>
>You can actually see how the conversion operates in
>`object-file-convert.c`.  `repo_oid_to_algop` converts an object from
>one format to another based on the loose object map outlined in
>`Documentation/technical/hash-function-transition.adoc`, or the v3 pack
>index functionality which is not yet upstream but is available in my
>`sha256-interop` branch.  In general, the hash function transition
>document explains a lot of the decision behind why we're doing what
>we're doing and how it works.  I have to give credit to Jonathan Nieder
>for writing the document and to many people on the list for helping to
>contribute to it, and I encourage you to read it: it's not too complex.
>

I'll have a look

>So with this approach, the SHA-256 object ID is computed totally
>independently of the SHA-1 object ID but in the exact same way, just
>with SHA-256 object IDs inside.  We already have support for
>SHA-256-only repositories right now: you can do `git init
>--object-format=3Dsha256` and create one, although not all forges and
>tools currently support them.
>
>The process of the conversion when we're in interoperability mode means
>that we can take a repository that's in SHA-1, convert it to SHA-256,
>continue to interoperate with the old SHA-1 version if we like, and
>then, when we no longer want to use SHA-1, simply stick with the SHA-256
>version and avoid using SHA-1 at all.  That's part of what I'm working
>on right now, and I'm pleased to report that I'm making a good amount of
>progress.  If you're able to attend Git Merge this year, either in
>person or remotely, I'll be giving a talk on this topic.

I'll see if remotely is possible. I neither have a US visa for in person, n=
or it suits my budget.

>
>I'm also planning to open a discussion on the list within the next
>couple days or weeks about some protocol extensions that will be
>necessary to let us fetch, clone, and push all repositories in
>interoperability mode, so please feel free to follow along for that.

Great!
