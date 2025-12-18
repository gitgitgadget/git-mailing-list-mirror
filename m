Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010003.outbound.protection.outlook.com [52.103.32.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7C339875
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065559; cv=fail; b=jUknyVGPSczvRv06ajAQeoZ0kmg8RJdF7cJtSkbkkbirq0dosFp9n8yMKWXRbjmc7XMJ6yLYKKMNxOGqsUKwrvyCUq91t59XLsSSI9506JGLB7CmLLSTSOtD0yKFFIEdmyoQS65lAzd505ZKAp0zSUGvOqHmBISE+NRICZNt6mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065559; c=relaxed/simple;
	bh=yuakuvnvffD3goHnQAZpfytFHdKDjnnOy++LPwDApNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2am2GnxilGjGeyosWxNKENE9DXLx6wE0+zsZm2PdrUmYjuardBFVbisygo6PfetJ0TrNNiVRM1jnqJ2cHoDBJLOmTUAKso1m/CYkur3Hm3omG68JI7IuQXfsEUG6JMQsHiAk3fxje8U4Q/pjZ/7y1JQy0hW+p/qsssfDQfATfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gyl1SeTK; arc=fail smtp.client-ip=52.103.32.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gyl1SeTK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohHAMEiSZ1no3H1wbSsrn8Q45AEqUFL5s4IjAm787Wh8VRcTKdvlc9Ze0U1oBxeWUhQbkITQmKQVFiEu1JloFgW6vMhOihsQNm4AqEFGoRZy3uGTQQj2YuYMnu1o5ZxMGN79F4NH9e1WaKsQMkVFAwntwUmGLGzOtTU0HUwdaQOM7tLqNR7f4KaOZOgyoRnAzJdEKx4VfuCFON2ZEfEXM1lbrMDPVXNYQF9mMknca721g9Tv4hmQYFxuob6VXGvTwxVLVRoE8wgP7WIXnvxn2TMlkyGIjUrignBBQb6T8W/0RCoFSFIAUpwSdRiPvmUgzZmR1/6xh5YGR2FvUipUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uxeIKrz8OkdQEzOsBvYzZU5UhYLxJw1GDKM9m9/aRY=;
 b=m6j6CmFtL5TrwIcwRhSL/8HBgDZtmAOVwZZpwbXdnAKfImaK/1zcfwyambzfr77VSK1/xO6MzJpLpniC5pmgUMHHWSutN7dAowcquU5LuTTRHRIdJr0BJdST5l5C9gzHKe0VbtfIfVAFpISBYU4Bg2pqYacMxQCQU8F8U3FuWfg85HyBwlGKBa1Ntt7yEXepwvLOO6rFbTCGGklYpn6nKr3P77WwfltgUlzpznyqCwb2fG0W8XWML2kO9zV5ZgJ+3v2A+rEcEcT427M3xjfff2UGKqNA+GArNJDIN16TdxGnxI5gDGq9f3TijlBbjxylDU/6uTBbETzRVK+pzg1JPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uxeIKrz8OkdQEzOsBvYzZU5UhYLxJw1GDKM9m9/aRY=;
 b=gyl1SeTKtBZ5cufHu1sbpVAaAf7o5MBLCSQZVlNo3OOlYESbso0aUMbU7ALv9uE/IplPP3/8p1HMbFGFqFlMa/cdW2uac+b7eJw4dwpeQUNTZOhAfVWcU/A3a+p/z298pUXM+8OxxktjsRctcG3gehFQc1kq+chgpW7fRhjoDSeZjg0/8eSrcf+N/56n3Fdl1arhmlQNSOi5xA6NTYClQrl8+/rufMAD4/k0xZIeorNWwaIFcXz7FrR1o1xexYD4pdJVB3oY4j+VP0JdPhYHlHS0qwd7R9+fmtgN+0ND14x6UZoC9sZ8i9nngViBS93Sz4N3j9K18ksI1aSdr9CAcA==
Received: from FRWPR03MB11065.eurprd03.prod.outlook.com (2603:10a6:d10:1a3::9)
 by GV2PR03MB8726.eurprd03.prod.outlook.com (2603:10a6:150:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 13:45:53 +0000
Received: from FRWPR03MB11065.eurprd03.prod.outlook.com
 ([fe80::d94f:c0a:f839:e920]) by FRWPR03MB11065.eurprd03.prod.outlook.com
 ([fe80::d94f:c0a:f839:e920%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 13:45:51 +0000
Message-ID:
 <FRWPR03MB11065628883E63378EF8EB329C0A8A@FRWPR03MB11065.eurprd03.prod.outlook.com>
Date: Thu, 18 Dec 2025 13:45:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] t5563: relax whitespace assumptions for unfolded
 headers
Content-Language: en-GB
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
 <20251218122204.GC3758205@coredump.intra.peff.net>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <20251218122204.GC3758205@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To FRWPR03MB11065.eurprd03.prod.outlook.com
 (2603:10a6:d10:1a3::9)
X-Microsoft-Original-Message-ID:
 <d190d33e-2965-4838-851f-afc3bb2cd5a3@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWPR03MB11065:EE_|GV2PR03MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd2bc1f-48fe-4a71-6734-08de3e3bc1fe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|23021999003|8060799015|51005399006|12121999013|461199028|15080799012|5072599009|6090799003|19061999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFhZZ25QSUdyTTVZcENYQVdYenl3ckhQTFd6OTRZV0hGVUhjNU9DNGR6SDF2?=
 =?utf-8?B?MEYxUzV0OXVranBHbit2bEg2OHNaY2kyRGNzSDZNN3gzeVhIZVBSa29Wb2pT?=
 =?utf-8?B?eng0YVV4MlovSE1HT0U3dFlkVUZ0SXZJQlRLeXBBR1ZiNnA0VXY4RUFiWWlQ?=
 =?utf-8?B?S2gxOXRIdXc5N2JReUVTeFRPekxvdkRWYXpGVXhJaVBIaG9IQXJtbEthL2pN?=
 =?utf-8?B?Y1FtZEVjZllqQmFCS1BkUnl1OVpaZE9jWU5hNUJLbktDZmpFUHFtUDZuRXlD?=
 =?utf-8?B?UUE2SmlUTS9MNXR2RVBTRERmYWdHM3pzRnlZb1RzV3U2WW1GcEl1RS9iSHh5?=
 =?utf-8?B?NEdHOXdwZjRpclZjdXlzK00wbmV2L2dZbUVaTFJxTDVFMEw4Yk9mbjdjcUJq?=
 =?utf-8?B?V05iTDZpSVNGekxJNjBESStuS0E5dHNZTmNjbE5rUjJkVjIyRjEzN3NTSkoy?=
 =?utf-8?B?U24rRDJVdjNXU3o4RmduYVM1WlVxczgzT1FLU21wbWttL3kxSFNFci9DZUY3?=
 =?utf-8?B?OVByeG92YlZGNUJTelZlTlZaS0tOR1Urek9tZHU0RFJsUUV5aXM1QmxSbnVw?=
 =?utf-8?B?ckpCbW9MeFU4RlJhMkM0Z3lxU3krdG1iTk50R0NlQUZ6eGRJcTgwWjNVQ0o0?=
 =?utf-8?B?RDdhVmN0RXprSVJYNDEvb1JNdXJyQXhVVFlzTUhFbVVicHl0RTRaaDZ4N1Zv?=
 =?utf-8?B?b1IrS04xMXhNc2tidjJWUnlCL3lHNEYrSGNDekM1SXRhVVNuTFFPYll3RHdJ?=
 =?utf-8?B?YVZLQzVPUEpOVnJja1BwbzBMTjBBYkx1cVlqWXkvT0ZzVGk1bFFkSkVyT3lX?=
 =?utf-8?B?Z0Z6WllnY3ZwcWkydmFYaUpSa1Z3aS9meUhUVkdtQUNWTHV0NzNmZ2w3c1o5?=
 =?utf-8?B?dCtNZzJUaDB4MXJoZHcxSEhvSW85Z1U1VW5FWnV6TmxEOFJJQWNrTGNWWWpQ?=
 =?utf-8?B?MWthY1p3Q3hHZHFJWVFYbk9rUy9XVWN3L1c0TnExVzNoRUkzUlB6RXBmVjhj?=
 =?utf-8?B?blVBR2xvR3dDclM1a0ZrRWFWM1FpWSszSXUrWjVLalducnluUzBibjF3Q0Nn?=
 =?utf-8?B?R0I0em96aG53bm9TajlISUJZR242VzJBRDNwYlZYTmYvUm53ZldoM1NTdm1j?=
 =?utf-8?B?d0tMbHpyNUd2Y0ZzQlpkWU9iSGg3ZUxIeWI4ZHQ2VldRWTJPb1AzZ2tWRmFP?=
 =?utf-8?B?SW1COFh4dXJBMVdTT3NJSWIrb0FWVUwxeGVZUS9yL25oS2NvOWtCNCtEYWx3?=
 =?utf-8?B?K215SmhvcGg2eHZnek8xbEEwRmV1MWV3bFpDdzZJeWxWMzRXeGg3dnc1em1C?=
 =?utf-8?B?UUxzd3N5R1BYc0tkVkYvd2VWcTVjSlFvd2wrRlFuS0JhZGYwYWo4eHBZT1hv?=
 =?utf-8?B?TElRL1JmQ2M1WkpYRzJHUE5GUGxtcHhxVGtya1piMzdtSW0ycG9HUTU0TVMr?=
 =?utf-8?B?OWxtVGFleVdlRExaR0QwS2NXWjV4cldlTFJCdmFaUjg2eUZWNDRzODRlcE16?=
 =?utf-8?B?cGlKVHNXMUI5Mkg5YkRrYXZ2UmlBVGtJd3VCK1dKZ1pnL3hMOGFLZTRGdGRJ?=
 =?utf-8?B?V0phdC84WlAzWHRhbnR4MFJVNTRROE4wTytCQmRyMGJ1ZHNKOXZvTVJNNmtS?=
 =?utf-8?B?RHBHOXBTNm81cStwTjF4WmdnQ1hIZEtrK2JWUDIvcHZvYkxjR21mMFNHWURh?=
 =?utf-8?B?Qnc2bWd0SVE2U0t6TWxDbUp1Y0twSTVlb05IZnRUb2VMMVRFMyt2QjlRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk01TWJKUytjWWFjdXd0anhHeEhzRlRxM3JzTEhJY1o2ZDB5SGRpUUFWWTlP?=
 =?utf-8?B?N05Oa2FLMFNYODIzeERmOGhqWVdXVUFDZ3UyTFljdDY5dGxqQkJ1ZitYNENW?=
 =?utf-8?B?VnJReUwxQllBdUVWeStaL1hrMUpKZGNlZSt2cUZjUWxHL2podXpZaFhkS0Vn?=
 =?utf-8?B?cTB1dGU0TEx5M3UrLzBsRHJSR1lKb1BwOFI2MlRlYXp4RkpnMTFPOHV0UU8y?=
 =?utf-8?B?T3hIbUMvYmRHUHF2LzgyTTlZVjBoaG92K0EzclppRWRjNzlhNlFTUjVOVlFx?=
 =?utf-8?B?NmQyN0JjWkJJcEVXblJRa3UxOGNhNmxGblp6byszVy9FdUpEc1NnS05jTkhn?=
 =?utf-8?B?a21ZRWw5VEZxeGxHeVV5QkpXSWJPazVwUG5UTDQ3MFQ5TEZYN200c2I4NDJ1?=
 =?utf-8?B?TW1mUmhWSlNiekJobGtNdi95c2JYRTRkTkQweWo2b21EbzlhMUR3MEE4Nmkz?=
 =?utf-8?B?WHVUSE5RVjcvOU9GUE40bXNCUzgzVXdWU0Noc0dUb2tNUlNEeHl4WG9wWURq?=
 =?utf-8?B?bDRUQXdmMzZ1VUc4a0JadzlRaDdXQy9NcVdSQlZpODhlak5VOVZRdFBjRXlQ?=
 =?utf-8?B?bHRlQ3k3cWJVL3ZnUFdVY3kwTzlIZUtuUTMyMUZSU0Y1b01iS0QrU1hMWnFQ?=
 =?utf-8?B?NTl6cER4YnlCdFJFWmNpMDgxUnphZ2ZVa0c0c2drZnBKZmRhZGJjY0p0Wjdi?=
 =?utf-8?B?a3M4bGxtOTBMdC9GVWtKZGhFbXRHdm1aSk41TkY3SG94cTNFUEZwd0plaE5T?=
 =?utf-8?B?amVoQXRRNnFRM2VrTVZ6ajZKQnBXWmk4bVNFaS92elNiaVoxRHdDNjdrcnZ3?=
 =?utf-8?B?L0JCalpsZG9uMUtNTnl4RkhndmFYZ0IySE95aTJKaUYxNlF3eUhocjlkQUti?=
 =?utf-8?B?QUJySjljeGtLS0w3OFU0OWhNUmg5Rmt4REwxa1FsM0dmbFdMREhlQnFxWnZF?=
 =?utf-8?B?SVB0RmFPQmREV1lEVzBCRDYyOUtDS0ZWSnlCSTBpdGZBM3YxbHkrV29ZQStX?=
 =?utf-8?B?YVU4T3VlNXJXc2M2YTEwVjFnL2NwWTUrbzBsNTFreE5DOXo1NXZidmVvb0ha?=
 =?utf-8?B?YzFaazI1TEMvVHIxeWNMTTdrek4rVER3SXVaRWkvTmJtSDdFVWRzamozaExH?=
 =?utf-8?B?LzBzVkJvdG80dU9qOHpxSXVpSTJ5R2tJVTlRd3NUYXlwRXFSQkN4TW16bEor?=
 =?utf-8?B?RWVYbWJTUjJZL1IyYkdIcDNIQXl3aUZFVTJhbDB4Ujl6Ry9TL1VhNURGL2FJ?=
 =?utf-8?B?cmxVMFd0ZmxIMkQ1Y2R5VW0rbkNBVWZUdUFMWStTdFpnT0hIYlNRVFM4SXh3?=
 =?utf-8?B?eEtnSFJ5ZGN3Z1pBYjQ4c2dyT1ZFSlgyOXgxVGFYbU1kTHh2Ymh5Z0JFbnZ2?=
 =?utf-8?B?QWJ4blRzSmN4MFhXWTZ0T0pvR211WVBZUERISDVKb3lSVXQ1cG5keHRXaURP?=
 =?utf-8?B?NkR5NlpxNHR5WEkremdyZFNSSVZaYkpvaDVvRlVDMjN6b2I0ZFpMMW9aZ3RI?=
 =?utf-8?B?eGZIV004cXdTQXBON0hWTm9yZVNQc1RjQkltNUk5TFZIa095U1k4VHltTlY3?=
 =?utf-8?B?YTJTVnNOMzh0Q1hHcXRXL3pxeXl1dUYvamhIdmE0NmEwMkZISGxPZmZ5VlhF?=
 =?utf-8?B?bGtpSEo5YVp3N0ExZmdSSXZYeEwvNEQzVzlvVGNrZ1BCd0txc1p1RVNYTGxG?=
 =?utf-8?B?VWlmVlZtQXZ1Q3hTeFlNSTBUVDV5YmlJeEpmWGtDbjBxd01oSzFyRVd5STds?=
 =?utf-8?Q?5o1RydGzBqI5fnPzCFRunyLInCOjYvRUhe30DgC?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2bc1f-48fe-4a71-6734-08de3e3bc1fe
X-MS-Exchange-CrossTenant-AuthSource: FRWPR03MB11065.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 13:45:51.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8726

On 2025-12-18 12:22, Jeff King wrote:

 > In t5563 we check the handling of WWW-Authenticate headers that have
 > been folded (i.e., where a continuation line starts with extra
 > whitespace). Traditionally curl handed each line to us individually, but
 > in the upcoming v8.18.0, it hands us full lines that have been unfolded.
 > But it doesn't produce exactly the same unfolding that we did!
 >
 > In particular, two of the tests send an extra blank continuation line.
 > Something like this:
 >
 >    printf 'WWW-Authenticate: foo param1="value1"\r\n'
 >    printf ' \r\n'
 >    printf ' param2="value2"\r\n"
 >
 > We unfold that into:
 >
 >    WWW-Authenticate: foo param1="value1" param2="value2"
 >
 > But curl will give us a string with an extra space:
 >
 >    WWW-Authenticate: foo param1="value1"  param2="value2"
 >
 > I think curl is actually correct here. RFC 7230 says:
 >
 >     A user agent that receives an obs-fold in a response message that is
 >     not within a message/http container MUST replace each received
 >     obs-fold with one or more SP octets prior to interpreting the field
 >     value.
 >
 > So each folded instance turns the initial whitespace into "one or more"
 > spaces, and the "blank" line becomes a single space. Whereas Git's
 > unfolding code explicitly avoids this, with the comment "Do not bother
 > appending the new value if this continuation header is itself empty." in
 > fwrite_wwwauth().
 >
 > I think it's mostly academic at this point. These folded continuations
 > have been deprecated entirely since RFC 7230 came out in 2014, and
 > there's very little reason for a server to add a blank continuation line
 > at all. And anybody parsing the unfolded header contents should skip
 > past the extra whitespace (which is allowed to be present according to
 > the RFC).
 >
 > But our tests do a byte-wise comparison, so they care about the
 > difference between the two outputs. We have two options here:
 >
 >    1. We can modify Git's unfolding code to behave like modern curl.
 >
 >    2. We can relax the tests to be happy with either output.
 >
 > I picked (2) here, just because it seemed less risky to touch only the
 > tests and not the code (though if any real-world systems _do_ care about
 > the distinction, they will eventually run into problems when libcurl is
 > upgraded).

I think that is a fair choice.

 > There is one further curiosity here. There's a second test which mixes
 > tabs and spaces for continuation, like this:
 >
 >    printf 'WWW-Authenticate: foo param1="value1"\r\n'
 >    printf '\t\r\n'
 >    printf ' param2="value2"\r\n"
 >
 >  From the snippet of RFC quoted above, I believe this should produce the
 > exact same output (the continuation whitespace is replaced with one or
 > more spaces, even though it is a tab here). But curl retains the tab
 > instead!

Header continuations are just a nightmare :-(

 > So to implement the "relaxed whitespace" mode in the test, we just
 > convert any run of multiple whitespace characters to a single space.
 > This is a bit hacky and over-zealous, but it's easy to do and good
 > enough for our purposes here. We only enable the relaxed mode for the
 > two tests which trigger this issue.
 >
 > Signed-off-by: Jeff King <peff@peff.net>
 > ---
 > Note that when built against this new version of curl, Git's unfolding
 > code should never trigger at all. In the long run we should be able to
 > rip it out, but we probably need to wait a decade or so before we can
 > bump the minimum libcurl version to 8.18.0.
 >
 > I guess we could make it a conditional in the code (which would help us
 > remember to eventually rip it out), but it felt weird to start adding
 > version conditionals for a version that isn't even released yet. ;)
 >
 >   t/t5563-simple-http-auth.sh | 11 +++++++++--
 >   1 file changed, 9 insertions(+), 2 deletions(-)
 >
 > diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
 > index c1febbae9d..0967cd501c 100755
 > --- a/t/t5563-simple-http-auth.sh
 > +++ b/t/t5563-simple-http-auth.sh
 > @@ -47,6 +47,13 @@ set_credential_reply () {
 >   expect_credential_query () {
 >   	local suffix="$(test -n "$2" && echo "-$2")"
 >   	cat >"$TRASH_DIRECTORY/$1-expect$suffix.cred" &&
 > +	if $(test "$3" = "--relax-whitespace")
 > +	then
 > +		HT='	' &&
 > +		sed "s/[ $HT][ $HT]*/ /g" \
 > +			<"$TRASH_DIRECTORY/$1-query$suffix.cred" >tmp &&
 > +		mv tmp "$TRASH_DIRECTORY/$1-query$suffix.cred"
 > +	fi &&
 >   	test_cmp "$TRASH_DIRECTORY/$1-expect$suffix.cred" \
 >   		 "$TRASH_DIRECTORY/$1-query$suffix.cred"
 >   }
 > @@ -451,7 +458,7 @@ test_expect_success 'access using basic auth with 
wwwauth header empty continuat
 >   	test_config_global credential.helper test-helper &&
 >   	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 >
 > -	expect_credential_query get <<-EOF &&
 > +	expect_credential_query get "" --relax-whitespace <<-EOF &&
 >   	capability[]=authtype
 >   	capability[]=state
 >   	protocol=http
 > @@ -495,7 +502,7 @@ test_expect_success 'access using basic auth with 
wwwauth header mixed continuat
 >   	test_config_global credential.helper test-helper &&
 >   	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
 >
 > -	expect_credential_query get <<-EOF &&
 > +	expect_credential_query get "" --relax-whitespace <<-EOF &&
 >   	capability[]=authtype
 >   	capability[]=state
 >   	protocol=http
