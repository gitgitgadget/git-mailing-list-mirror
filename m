Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022121.outbound.protection.outlook.com [40.107.193.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C686155342
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414831; cv=fail; b=QWYwB1HiJL2ZQsY4Kf3Ygb82vKGNHNTfbt5OgDJesz5TDgqK9PXajYD3g/K1tX3UynRH7d2L+ONYoLZ6hp0IN9DgY468CCELvE31iGmYUqA+p8Etqi6/pJCJF6iuCFLEOe81WUXfHxNQxtAbyPMhvuL9nBe6EaQGb4qOxJDnX6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414831; c=relaxed/simple;
	bh=R+WsOXkDeFwqE6HnJVmqto4JU9Nh8M0x56InsCSK06g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sxouvV8snxo/Cvlwf2mdYZkFViQebxePYuhoRs7G9MQ78SYkeTTmUDlbWodlcwnxvRy0tLzW+h0fD+ZPi5dbPZ8GvTB0j8P7isgcUMo0LTZoraXO9UJJUsOp+klrBekq3Q8MK/zb9ZgnKCzbkymxuoVE23gnqwFhkhI7kmU34ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=OxK0LI1n; arc=fail smtp.client-ip=40.107.193.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="OxK0LI1n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAtm6Ae68qFYY+43uzPHJNXjzEn4orgncphXdxCe/gnIBIaZw67lLKRpV8iqvrxxGZ2OWk4rl/8NvpqNTSqW6AShLaqwacOyozuCheZNABKHqpfoxMIdfiPdI8uQQjdEatmdpbqLrv3fS1H476vUKFGAJkuirv2oo7+CnpvrjPhqVHHTY/ADM7aLXRaaXsdDK3PdXAHpKLmDskCgKI4xs3jmJ+7YsC/Vez9VEm/8dJC3H2NJto+UZkfKFurLWmIe3nTNeOQqRzMqkeEZuaLzwTwi6uUhqEBwCuzVAGeeedzymxRwP6k25EHUTGUlttpMXkzi7QUzzbv3jyjlNg/FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awM0MYuven/XogwUowxmkXnsmAc1k8aTulZddu34Nwg=;
 b=tZLyLOiMY+J2R6tTHVxVzkyN6QKE07aCk6+47X5GZqxBraGy5RXiM+uffpCfWKuBfzT9Y2CL5asrQamknQCBmM9jO9AQKdVucnVJtomMK3f91Oi7epZ6rQhZc7ynTM2rDFJ6hH/1Zg9+37p7cAR2gcsA3/sFOwdLQQIyOeo/VWAJogNlPVHSZCLaon1GBmENmJ+bmnnc9HhPXiGMvzUFfr3obACI+Bvot8uFG/XUcYIVP/I6hD9RJ3xt3dh2dTJlCMhA3IBJxLSMBLeXbMHrlBdQJM1HiXN7e6gvTrBCQH3RUqC+QhZdctowJuBQegCDh+oYgxbLqTMBkOEKzYwqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awM0MYuven/XogwUowxmkXnsmAc1k8aTulZddu34Nwg=;
 b=OxK0LI1n8d1FSNPditmFvkYJhOaRR6JYJZQ+N+PxaL5eOcnW2iBAmkcxoXdWUYBgDs/9U4Tl1tnK0IvaeSpQw2LrPSazss56a3grbYZSPtJctElWy8iXQhfRcFBjah9cpkkfjjamSIq3ZpCEHgWUVsPrwYy6mtQRjyOkhtgrrecTAraWKhfTFLLfitAMuZfVF+cBBDvnkx6x7XEz4uXKrYeFkck0DuCyytAju7CsIfoPh2Sni2o9E6RlaJYId6hlcZhByYiku+GzMxO8ZIGG12RcDg4tETLgVPuajpigfthZVvvTFdn02W1YKzCd0Bp7T7jGctAU4hxDUwLvTWWtNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:107::20) by YT3PR01MB11258.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:13f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 13:27:01 +0000
Received: from YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c72a:2984:a92a:134a]) by YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c72a:2984:a92a:134a%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 13:27:01 +0000
Message-ID: <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
Date: Wed, 23 Apr 2025 09:26:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::36) To YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:107::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT4PR01MB10530:EE_|YT3PR01MB11258:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ff700a-42d1-4193-85cf-08dd826a87a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW9Udy9pVHlBVHpPT3hjU1hlNks0T1lXNlFMRkM2Z1hOTFQ0YlN5ZE9zZWtF?=
 =?utf-8?B?bkd4MkdaUGt1VWEzQU14R01PbDl2VGFXNHdRVGdKYXcvbEcwOHZTc1lQUVlR?=
 =?utf-8?B?UmlTK2JuaXNFWGJVQXNFWURZL3FnQ0xTd2UwM1BNV2UyMHdwY0lWUnkxWWxr?=
 =?utf-8?B?VCt5b3ZFUUJqaDlOUUxzVzYxbUpzYUxwZHZ1OXNJeDZuS1IxTFlueklieVlL?=
 =?utf-8?B?N1NRbDVtaXFFQjA0MUlRb3dyek1UdHB5WUVvdEQ5VVUvNTM5NndFdFphNVha?=
 =?utf-8?B?cVZpRFJqRlpVamkyUU92TEwyVk9DZGlvdEZDUTNRS1UvMkVjMGJOc3Z4UmRC?=
 =?utf-8?B?NHc2bExjT0xUbmltOUZkZzVrMUgxRVVvVXdnNDd0VUxQUEw2Y052OGNnVWdw?=
 =?utf-8?B?RHRSd0k5aWVWajhQNmRBKyt1cDdjRUZvMDRNS3Q1Wk1tY0JTL3hobzRzSGhW?=
 =?utf-8?B?MWcxYmtEamlVa01kZEtWL0N6ZFEzVWIrU3BIV09NTlYvYnBDWnkyaXE1YkFm?=
 =?utf-8?B?TlEzZitON0Y4UXdoTmpnS3VMaUVONElZYzA3ZWFsNDlnUGUzNnZTMXN5L0k2?=
 =?utf-8?B?OTN0U2w4RitmWTAzdFVKV0hybUdhOHJ3Tjd5M0txbHNkWDlNTy84b0NMcXk3?=
 =?utf-8?B?bFdDUnQwNE53dE9zQVR5Qm53dkZiS1VGNTcrWmVEQmNQN2FUYk5BQ0FyUFRw?=
 =?utf-8?B?VUt2TE9oS1hXWklTQiswV3FDcnA5bTkyYzJ2K1ZSYXkzTkVhcmN2ak50VmVa?=
 =?utf-8?B?YnU2M2JaaUFDKzd2MmJxV2RnODdTQ3ZLSGtDc3FmVTdxR0FyM2YzS3M1MG14?=
 =?utf-8?B?VHNLVVpab3VMUEYwQzQyQlYvekJjV21vVVZ3KzF0YzVqTnIrS09YMDZBUzZy?=
 =?utf-8?B?MXlxTlMyOVBiT3gyZ04yeXNiZndBbEd6ZWlUeCtsanN6Y3gvN3l6Znd5dXB0?=
 =?utf-8?B?b1ArSmZlcTBZN0x0NE1iMi9BZXkrYWpxeURaMFh3U0dGb0dJT3I4QW8zNW5n?=
 =?utf-8?B?UXYwM1pWYnZLVXQ5NlM2dnZVay9QbThLUmxQL1I0YWZMLzJOZmZOR0NJSzBL?=
 =?utf-8?B?ZThhS1poU0M2V3hHemUxZ2pXbG1JR1hMZ1QvbzNLSExQTHpqbWRSRGp1R1VO?=
 =?utf-8?B?TTBCdmFpTUpBNEVPK1lJQTAvMmQ5WGFId2tYUkpkTDBsbldrOTBZdHFram9y?=
 =?utf-8?B?bWhZSDJvaGhzM0ppSVZYKytCQ0NWSFBMSTlDN3laN290eUZ6bzRLckIvV1l5?=
 =?utf-8?B?TjVJcEVIZWc2NkMrcGNoUzlVNnlud0Y4Z2ZHdXY4SFZUN05qVkw1MWtBR1pl?=
 =?utf-8?B?UUFLZ0EzaDdwazlUMi9xd1JTMjFoNmExZk5SaVZURFA5WHN6RmdUVnNSUnVQ?=
 =?utf-8?B?Z0dnWUIzbnE0UzBCa1J5UCsvU2xvRllPUm51eDh5YXVEWkZobTRYZWNiQ1Rt?=
 =?utf-8?B?VHVEQllMSmJnREMrSXRGME5id2gwc3F3UzQwdG1UQklvdTBXOWlyQWJDTEFl?=
 =?utf-8?B?TnQyRTRQMTdtVjM1eWlZeWtjSU9oOXQrUUN1Z3NtT3NCbVpkaWRHR3pKb3ZB?=
 =?utf-8?B?eEtUOW4rdXZtcnBiUXpUeElZVytGZ0FUT1MyTjhxTUF2T092c3hubHZuMmR2?=
 =?utf-8?B?WWVrUUtpWHp4OE9zMkNNZ2w5NnJEd29NdFJYTWt3MWRWNldHQWdTdFdZc1RF?=
 =?utf-8?B?aEZZR0w4YTBFdkhnYmg5YnFhZkpUVG1rVlFZbkdmc1BZdHBWMTVqa2VjWnpt?=
 =?utf-8?B?ZGNTVHRKdHpVR2hmUjliNk0yUjVQcWxWNlFweW13dzdhb3ZZUnRjVXBGUjVx?=
 =?utf-8?B?dlM3dXB2Z3Ywc0xIS1l6NWNaVTl4VTM0WGN6WjRmcXJ2RDI2aVRiL2xQSFFo?=
 =?utf-8?B?dmExUUVLRkRFTUE0UHVUcFhXRHNXYW90NGNERnBISTg5NkNxRzB2djdYNmxt?=
 =?utf-8?Q?TFC1iMr4efw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVpBV3I5WVVnVnR4SG9YdmRpODFmK1hKRmpLQzFhSHg2TU8wZ3FYME51MHdj?=
 =?utf-8?B?V2hhUzJ1MVFhWUpmRUNoUG5DNUpZbzVOMlptZy8zcnZxcGVwamsrMkorKzl1?=
 =?utf-8?B?eFBVbUNXd1lKL0oxME1jYmp5VVpKemhOSWhKN1pNdUhLVVE1Kzc5OVV3VVNj?=
 =?utf-8?B?NlZ5bmtGenFXcktTazhKUTgwWjl6L1lLN0ZRVTVzbUVYNnRCeWlWTXhrWjNv?=
 =?utf-8?B?QXRHQW5EeUVVOXowbldPSXJDYjVzaFkvTTZQVEpPLzFSbWFjd3FUWG1NQ1do?=
 =?utf-8?B?cXpBS3ZDVmFscU01WTlIdzU3WkRXQzU5TXpTdzJoQVlBK1YwUjFiTVRMRG5j?=
 =?utf-8?B?OERwM3pKUC9EYkxXNC9JclZmQnQ2eEdQbE96WWw3dlhlZG5jenpGRXY4VWVv?=
 =?utf-8?B?OEs1Q2FhZkpoMkIxeHdWc2ZPcDQyR2tpb3BlblJtMUhnNDgrUU5PMm90U0Zw?=
 =?utf-8?B?TEN0cElMdzZzWTRaTmc4ZnNnS3B0UWcxSzd4MU1lUHdZZmZ5REIxZ3FxU0V2?=
 =?utf-8?B?ZWlBLzVjUEp2anJBUFhBSUJpV1ZKVktpM0NqM3J4dXhNMW5lZVdiSkZhRmR4?=
 =?utf-8?B?VjdHb1ljay93VE01Mzh4YVJKOEl5Uzh2QWpOZjl6bkZTTUZaSEFFY0NJc2dM?=
 =?utf-8?B?TklKWTdHRWp2ajNkMzV2ODFYQy95TWMxSGJtbE1haE9RT1dvVjB6emVHRjMr?=
 =?utf-8?B?SDBRUktkaWdSOC85NkJvK0pEUU45cGVkWnhmRW9wdklFY2xiMGk3ZEZRT0xt?=
 =?utf-8?B?WDVaR3pUdGNWYlJJTms0VEQ3TEM5akZjd3R3cEdCa3FidVFPWFN1UmUvYnAx?=
 =?utf-8?B?bnR4ZSs4RzhaeFQzY2ZCYS9BdVlXQjVxRy80dUVyczRVL2xCN3g2TzdRRFM2?=
 =?utf-8?B?RUNvOW94cTJPMFlXSjdpUVoxRGR6RS9rT0FMQmd2Q3R5a3U0TlJHZVl5UGd3?=
 =?utf-8?B?dmFDNE1qTnl4cldyL0dvSllqYllDWGhiTXFTS3RyNTN5T3NpN2dCdm4wQm8w?=
 =?utf-8?B?T0NPTytabk50eXRYNGhZQTRSa0VXRVRrRTJkOFJPTUFOeU5FeElUNFgwbURQ?=
 =?utf-8?B?Ym5nL3I0M09oT0JCbDJzZEw0R3VReUFpcWVSdy9sZEdvVWx2MkI1djVSSS9v?=
 =?utf-8?B?N01CenhMQXRIcFJSTmhBeVMvcXltVEZCWk9UMlJHNkU3RHV2MERoVUV1cVZt?=
 =?utf-8?B?SlFGWCszSWloSDhCRHdmWDBMd1RUR1l6R0szLy9kSzRzTndxZFQ0MXViZU01?=
 =?utf-8?B?dUZ4dHVoR0hWYk9Eb2drOWtiZm9sTEgvN29ubWJMRkJXVTRzVGJjT2crQjBj?=
 =?utf-8?B?VHVjT1Q2UHRWT1NWMVZMVVBVcllpVnI1WWtJSVVtaWF2MDByWmlpdzJnVXVB?=
 =?utf-8?B?OXJ4MXpHR3VlTTRYb0w3Vlp0dWxxT1l3U0RkcVRjaDlyMktiUG84NWVkeU4w?=
 =?utf-8?B?WnBRK2d5eVQ2U0R1ckVlb1hldFRNZ3dhUkNpQ0ZrNitpV1NOQ28xZ0I2d0tK?=
 =?utf-8?B?aXBtNCtpaTgzVG9tUnNnd2ptcFRpMnpOSHMxZkhGelNXS0JCWUpyNEQ2UFJ4?=
 =?utf-8?B?K2JMNFlVRm5rR05uQ1NhMS9OY0U3SWtJR0JFTlFEdkdEMi83MnlFUEZqMVNU?=
 =?utf-8?B?b3NxT0dKZEJyWVhZOFFRekRGQVBCbk1IZ3NEL0NMQ0hjWmVUYjhJSkg3V3dM?=
 =?utf-8?B?L1FoT0RkeUxtRzZ2UVk3VTQrTFJ2Z1ZHMW81WjJNdFlqd3JTVmZka0h1SGZy?=
 =?utf-8?B?Uk15clk2SzBDQVJvRGtFcmJpNnlZY3c3TVBpZkhVa2tUVjJjS0xiNmdnZXVh?=
 =?utf-8?B?Zmt6QXJaeEtrVmJGeVdvSmNtTllyQU9yU2JQUW5KV2JBMDNBclRKOHNWSHZK?=
 =?utf-8?B?TVFCMjJPVzgwT3FXMmZZUUhaNE5pVHQxcHJLWldYU0FoL08vL2Naci90VFl3?=
 =?utf-8?B?RTF1eGlDemIrVHJpeGFMdXk1eXRkMTQzcVlpaXIvMHgvN0FaMXIyUE1VMnFN?=
 =?utf-8?B?cGU0eUl0YW9PZVJuVnEzWThyWnpPVjExOG1ja3ZHeDUvSzJEcGRPUDd3UEM0?=
 =?utf-8?B?Wnl2UlFFTHlpTkM0c2tmaEE0NDdEL3QrNGxsdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ff700a-42d1-4193-85cf-08dd826a87a1
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB10530.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:27:01.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVLve0rxemVX77WHx4KCZynUNctA0KLScShUMPH9slqCvrksoIo5i+bmk7SE8F44fjFZMFAwggqYuLoqlIwksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11258


On 2025-04-22 13:46, Toon Claes wrote:
> This is another attempt to upstream the git-blame-tree(1) subcommand.
> After the previous attempt[1] the people of GitHub shared their version
> of the subcommand, and this version integrates those changes.

This functionality is awesome -- thanks for pushing this forwards.

I feel the need to get some bike-shedding off my chest, though: 
"blame-tree" would be a terrible name for this command.  I think that if 
Git ends up with two blame-like commands it will merely solidify Git's 
reputation for obscurity.

If this is really a form of blaming, then just make it an extension of 
"git blame", like maybe "git blame --latest".

Otherwise, please come up with a new command name.  "git latest"?  "git 
"latest-revs"?  As long as it doesn't use the word "blame"...

FYI, here's Peff's original explanation[1] of how he came up with the name:

 > I wasn't sure at first what to call it or what the calling conventions
 > should be. The initial thought was to make it part of "ls-tree". But
 > that feels wrong, as ls-tree otherwise never cares about traversal.
 > The combination of traversal and diff made me think of blame, and
 > indeed, I think this is really just about blaming a whole tree at the
 > file-level, rather than at the content-level. Thus I called it blame-
 > tree, and I used the same calling conventions as blame:
 > "git blame-tree <path> <rev opts>".

To me that reads like an argument for folding this into "git blame".

		M.

[1] 
https://lore.kernel.org/git/20110302164031.GA18233@sigill.intra.peff.net/

