Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783C0748F
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162330; cv=fail; b=DwmOzsYPVSyGXG0cPFQJzYwII3EDjtJoHE2qzjNESUseaPp9aZNsGofbAymxJQpBEQATc8wnhHasnV8V+y1nByjmbkQzIYUQpQPOJEjriQi8Ilop9P9BfdKu+8bi3brV2c7ptUl64ikZ6zDx36242ECNAIi0dMVLr8w3jb2km2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162330; c=relaxed/simple;
	bh=mfQCJfb5p6aHx23Bzo+lubeELKPU2CzWJSKC2Q4+G6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+2fFVV1BxUYXk4Jk04wdih8PxMQCWtS+Y7QgEOG5nDzueiTtMcA4On0y5qAUng+THNFEt1gi/63a3tokRDSn32UQusRUa0/LT2lfSqzeAONzRhsKSrnZkl+uZK/+wEyuSoF35llFSmd6eKepRpwR1cmoe9CWLqu9XDmcyhTt10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=V7nvYRa0; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="V7nvYRa0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydMHtPzYIfEjNjJ4t8EuNf4Omozagq6bPYVATPBU+B2P/HPZr4nE519kQL4mVyIm8y9r693rNsmoQRpteVsmWCgG8spChdl7cQPgerR1aJaXaNvd3JmavEwsoLKfU/1uYUsWJDRNrZVa6xfI9UTb3hLWP3lxvnMi5ZnTKvPHDKXbn173kXpBLUs8psDoT56GxsJIZwWKnt8KHl32eFw7DF3ILW7p6mgwmoX7BpOMU2deTsPMjAlD9Q1a/S7eW5ac4sEIcqRWq6PnjDe14WzzRrdX2TvRRpaddrd+30/VsC2lh58XY4M7AiXU6OGymCDPajvT3kqaxWy6avFcB57cCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Il0Te/IMd49vCO9rU/2u8lGBQgfz2gm6BEnjsfTaiE=;
 b=BYHH3mRgrLwPSCwTU66I1QTgdBVNuz+xqv3XNcZOQWh4S99YI3PZDiqLUtWvAGgqHqpg8XuiJYLJZwx8Af678I7dKPZXO9LJN/xdcRTlbZJVzaqFZKqDjzW4KQ7wzYRfy09feUt2kqN0UiOTPbrAlG/KGYdgbSezjeH3/U0y6Sgt0yx9iP6ZArAsoBsVyD7YZXmLkNChrsPrYpBYI7vke+WlfyuQo65o2+apiL4MVGHFQc5DF4y4QljGA+x5Qnk2dYQeDoX4vCiavRR8aVLb6EPoVk7tuwI06YzYoSFGFvviP5Ce5RdNUdwdSoBmFQANb1s+Sopn9OaNHWCvAKJ5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Il0Te/IMd49vCO9rU/2u8lGBQgfz2gm6BEnjsfTaiE=;
 b=V7nvYRa0s7uvDmO5BaxpwX8d7B6gLPsM+JsrDzfHvBXSePju2UVzW0VrrsCVajKnJTzLN3dXZ/1xSooROjxwSKkjXW4MHSm46oI7oeAM6FD6N8ssCdvN6QS3Vm+IdljJlr+qzo/XYFWDzJ2p4B9c20kvisB/oyBy4nqUvC1fjrKt86pASP7h0+9vxpfNVjvelJnkEUVur5d+TyJWKIlleU198PEhY0reLu4DBiyHhhp6edWTfQFf8dq4TjJKbFsRCr6enDvgKltVJSWykzcr+VA28hBtQ2uDY2cmEHZiSD7KrDRtZxtpn/KC1EOZ3nEyZ2ZCcg1EMlkU0ctK/fQ3vA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6988.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:52:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:52:00 +0000
Message-ID:
 <PN3PR01MB9597028D4430E9C2C2BB1E5FB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 14 May 2025 00:21:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add instructions to use Yahoo with send-mail
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 sandals@crustytoothpaste.net
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597AEC10C20F4B06C4BE254B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqzffgfj2m.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqzffgfj2m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0130.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <09ac015c-ebb4-4eb4-a925-1e84a1af9e6e@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bbf3e5-1bd5-47e5-fbf1-08dd924f3e10
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReFQO+5d6ofa7WPjBVpSbrYuZq4V89O4AxzYAOF7hxqH6LIDOnEvoLTHRFLQhUyk7uWvHNW05nJJtkxgKBLNdKEUBGC65btXcKABXYwlabQkJaowt0IriQvU3uqFhwxIdAEELVJ5VGPjPmXvlZzn/KaqeZ+9bPDKacY7VZVS0sVizrJZRgtzE8K8ukpcggbcGt0t7sVXaKTN6+YFL4auATLbgeGH06byuMk/D+L+rwd1940p53RSMFP2TiI4rP1lzprOXQVwIRWCSDj/GVfRTH8X0kYFtsLFaWLlGsYrwujoRvJl7U5kZGUPGdP0CLYFsrbJEMTciE0znOFk3t1UW3bhBTwAm7EKwk/IwrZdXKnYSwSImusAUr4ne7Ky5Be7ZIqBsIUM2KwMFFjpCGcAbDeqSiDjLQLPXY1fmy5Ga7r22rVhnwYttyFnwNGA7UMIYmrFB8BHC4ikB+UX4LCQTXtHbf+FeGbdeiSlzugoPdvw/PJ26E6hufKCeCmRmF9EAEBF5CGIFMzTKEQQ+omzQMexxxzfMhdFvvTcymemgpAFlUyasV78va/PPOl1ATTvzyTuEXb6rWyXmqcenZhUJ8AmBhDJgpGKj2qZe4YiLLX6Vfgs1ZMxQhmwLAYWrh/7FK2fRbC7ckyelrHDkh/q0nVME41kibRYZbCy+rO38CgeRgKywDIK8dkq4ESOc3x1HDfFnNxz/+Jq+ojyx6jlc4wiC6qboH7+j8zWwlJrqn0VihVdWYwoPNxYHYg/fY5C2ELCJZiatpJmvDVgCaOzV+jY96RHQXsUlP/aNkGYVHafwA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|19110799006|15080799009|7092599006|5072599009|461199028|6090799003|34005399003|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STFtY2F0VU85VHl1MmRxMGlyR29sMDNXdWJBd3R4VDk4cTA5dnFmUTdOUW9o?=
 =?utf-8?B?MkY4UmIzV1VCcmVaa2c5cUlQS2tDNFZ1emtoTVpFRm55SmZVS3lrYmtNK1dy?=
 =?utf-8?B?NjBIWFp3d2R1R3cyNk0vZk02VURySFZhalcralc2QldYZndYdU85bFczc2pn?=
 =?utf-8?B?b2NqZDFLbGNzWm9remVVYkowZWRSbjBwWU0rTHpIMDVCa2pKdFVyVklUL3V2?=
 =?utf-8?B?T01iQ0VSbUlBdDRMa3hMa2wyQWJJa1NNV0lwSDdIaFRZWTFXNUtjZEdEWXdr?=
 =?utf-8?B?QkdqSE5tQXFmcDR6WGRZVnltQ1NyakgxQ1BUMWRlM2xFZ3M4MWtEZnNKQXR3?=
 =?utf-8?B?ME9WTm52ajNSWndNVzN4N3dvZ2xiNjhsZnhrRFF5RnZuWmp5L0w2OERWTk44?=
 =?utf-8?B?YWZ4ODgzcjYwZWMzQWkwdFRQVVdSSjd1S3pzRkM5OWNYV28rNVhDc1ppOU45?=
 =?utf-8?B?c0VIa0ZBbDRFY0JXV21BQ2xYWFJqdXlGWVYrSVZScHdqekNreGRqbkJrdTFK?=
 =?utf-8?B?aGQ3aDhXZkRDa2NsbEhoRkk3czRWVkZtbHVRcXVtWFR6aUpYZnN3cnNTcThN?=
 =?utf-8?B?ajRtYituTUN4S1E4Z1Z3SnBXbksrOGh2WWVSdm0yRFQ5WXNZS0xKbXZkMmNH?=
 =?utf-8?B?SGNKcEx3c0t1RjY1VDFsOUJYSURlTUhXLzhTUEFHd2JTcWt1azZtam9TZGV6?=
 =?utf-8?B?QlgvbjgyOVJ6aG9BNytXY2FSU1d5ZURNblhaVC9yRmRmZDdGQ0JLOXBDTGRB?=
 =?utf-8?B?eGRiT2dtWmhNRmdxZkZYZFdWU3NTc0t4MkRySGFjYTJkVjJ3Yk84bTBhTUgz?=
 =?utf-8?B?cllMSTUrQ3Z6eWRMV2dLQ0JSWHFZS2xiUjhSMUhzSXdQd0wvWnZDa0NXOEM5?=
 =?utf-8?B?N2J3Q3M0eEcydTJUT1lRZHlZUkc5bDVKbW5rcEtFcFBKekltTnY1bFk0VWdK?=
 =?utf-8?B?VWk2ZWtTUWp6Y00rRlU1S2h5VEFCTHl1bW9xOWkvM251U2k1d2ZBSWF4K1Vm?=
 =?utf-8?B?SFYyRTNkMTljcEF4eGVMN3Jza2F1N3FtTDAyanJ3eGFZNGY2UFNwdXlxTlYy?=
 =?utf-8?B?T1JrUWxOeW45ZkE5ai82R2ZiZUJFeUtJZHJ2VWh5ZmtMMmVZWGRaeGJpd3dw?=
 =?utf-8?B?OGZDL2RjTFhSdUJoNlB2WW1keVo2UXZZNkVPK0xmb2ZLRnhrRStRSklTdGZy?=
 =?utf-8?B?a3FtRWtRNWN5WXlzdEkzSWlNY2hpNU90R05pbWtaZXFVQ1R2cHlsMUhNUmJh?=
 =?utf-8?B?eXlkTFBEOVRBVi9Fc1JHZGhyWWVGZmFlL2o0VHIrMEpwT21KZmUwTHBlK0I4?=
 =?utf-8?B?NHdDM1kzZVdhdDV1RVdYNjFzYmdOYk1uN2NsNlBRSUVrYjB4UmU1K1RWd1hk?=
 =?utf-8?B?RU5sZ3o0NWFBdXVKblZVK0ZPOC8vOVpmdzZ1MytKbjZldEJvZGtVdW1xbXVt?=
 =?utf-8?B?b2lwUTg3WTRRcEhEd21Tc0JFUWhxZVBESis2SHc0YUZqWXFqcnhLZysyMnBK?=
 =?utf-8?B?aWlFSGl1aTc3YUFMeHQ0UmVKYVliYjdjK2tMeXk3QkE5MktCTURKQS90UTl5?=
 =?utf-8?B?Q293MFd6K3owV09NRlF5VjVKamN0am43b01nSmlIN3RpS1ArdWZNTExqbnpt?=
 =?utf-8?Q?fKkUs1EsuXxbQeyhv8OZsWUW0lAf3/I09OJP32/itdLw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFFNQkZLeFkyQ1VzQS85bmtQSk1KWUZ0Vk9haDNsdkxYMFRRUlJ0ZTZlUzl3?=
 =?utf-8?B?cVlaSXRyTlZwc1ZLcTk5SHdrZlowTnlxa1A1bEc2Nk1FMndQT2pKYzhVdHhm?=
 =?utf-8?B?ZENYSUlkSndhOUNZYUswOEVVOENoQjBXTmMxb3dnTnBSak1VWFVvSjNkSmYr?=
 =?utf-8?B?NTArRnRZY3VFa2FYd2ZHcWpLbDlKU1N2OTRLaUxwVUxQYkJRRU9GOEpyV0Fq?=
 =?utf-8?B?NGdhVWpEUUM2TzF6ZWVSQldTbmx5K0I0RmJnbTQzMlBhKyt1d01CV3EzQjB3?=
 =?utf-8?B?RmZJMklwbmxURU9MbEVSM0czelB3NTI4cnlYU1RRMHo2K3lwaFFzMUdBclF1?=
 =?utf-8?B?VndqSE1CcFhoSitOay9FeElLM21KV2pFcERDNVVHMEZ5bXVubk56eDhwUHVZ?=
 =?utf-8?B?cUpNL2dCdUVWWG5XNGRWTTlkeVd5NmhpQWdhS0FORXIrZllhdS9Od0QwK012?=
 =?utf-8?B?VHRsc2pDbFh6SFhZMmx2anpicUdRVFh6NnJHbU04blJuZnBoSDg4YXVia1R0?=
 =?utf-8?B?M0d2bEw1MjM2ZGRTK2VGZmJRTzJhRkZNbUpOVktrRUhscnA4YU03QUVjamhx?=
 =?utf-8?B?VGg2QVBXOEFIakpJSGdmWGd5M094ZWY5enVRb05yczlWNW40UkFOT28yT0l4?=
 =?utf-8?B?Q2xBWGwxYWFiN1czL0xNczdWZlB3dS9ZMitESWp2NlJCMXdrL0JDVFltVXcz?=
 =?utf-8?B?Sit0Vk1IL1dPNURrenpseDY4WmlEdTRZSXVDSmMyQXBKYWJWaU9xd3pTcGJi?=
 =?utf-8?B?RU1nSURPeFZWN05BN1JzcGtIUjlhVHlGQThuU0tDdC9RWG9adVgzcmdhalN3?=
 =?utf-8?B?cytrQ2hOOHhLalZPbGd2eGlQV0J3UzRhVXpBSUNTQ2VZSC8xNElVT0hObEtt?=
 =?utf-8?B?YUdLbzY4L1U5OTBJSUZ6VnhzdEV3Z2tBYy9Ld2lkT2RzeEhJK3FVUWlZSHlJ?=
 =?utf-8?B?R2lPeEpQTnh3RWJaQ0MyaGpqZmhkSElNU2xWQzRUNDhHeENMaG1Dam83cEYz?=
 =?utf-8?B?R3hkQlFZNW9VYll1aTNCYnV3Vkd5S1dXRVgzaWQ3WXIxaG9ReGhsTUZ1a1Nq?=
 =?utf-8?B?WG9aNGRHZHF1aXlGbUQ4Z043aVZxN3BYVldnNDJUQ0QwZ2FxZ3JKamhCRlRD?=
 =?utf-8?B?Z0JIMkI5N2twSnF3NHhZSnpSc3UzRHhFaFpwS3RLYVlvWkQyQzlLdFhxU0hP?=
 =?utf-8?B?clNiQzdSVys3VWNJZ2J5V3VnVWEvc1JXUUtteC9tYzJsMVVUcm1LT2hMM0l1?=
 =?utf-8?B?bWJSU3k3aFlQOUNUb29sQ2NVaUFJUnRqWm9uc3Irc1R1V1ZoTTAwQW1KOHR5?=
 =?utf-8?B?MlpJT1hhakZRUFVPVENzSEsxZTJkVnc0ZVE2UnlHeWdKRUdFbGkyMGNJWE53?=
 =?utf-8?B?S1JzbVg5bEhrR3FqVUtQMllrQ09wM0dWL2hWeHJ6Tjh2Yk1qU1pheHA2djBl?=
 =?utf-8?B?cHZ2K0N0RVpuRmVXTStYbFhEYWIyU2ZtMGIrRFhzb0ZCQ1VKbXB3SUx0TXNX?=
 =?utf-8?B?ZlluWXdYK0JxZ3dncytVY0pjenBBSGRKMzRLd1FmVXNML0RwMW1uMmQ3WTMw?=
 =?utf-8?B?YmN6S3QxQWFQWmdVdW1IMGpRQmRYYWF3OS9wUW1INWFVVlp3VTYxR0RmWmhE?=
 =?utf-8?B?UElnbnBtMXI1cnNUSTZ5R0VLaGEzVUFRdElGbkRUc0lPajh2YTlDUnQ0YVRL?=
 =?utf-8?B?cUxEc1haeTZ5T2RJTjA1WGtJVHFSWG44bVJRR0xFNE1Lb3Ixamh0a2ZqUFJq?=
 =?utf-8?Q?6Yjqgddz8lhr/h6Ehg=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bbf3e5-1bd5-47e5-fbf1-08dd924f3e10
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:52:00.0287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6988



On 14/05/25 12:12 am, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> BTW, I could not get the source code for https://git-scm.com/doc/credential-helpers. It
>> seems to be a page for all credential helpers.
> 
> Probably
> 
> https://github.com/git/git-scm.com/blob/gh-pages/content/doc/credential-helpers.html
> 
> See https://github.com/git/git-scm.com?tab=readme-ov-file#git-homepage--
> for the general notes to get changes to that repository.

Thanks!

