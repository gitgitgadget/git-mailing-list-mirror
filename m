Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481A171C9
	for <git@vger.kernel.org>; Wed, 28 May 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427033; cv=fail; b=XscLTMbGcsBisfDl/ccGqZ6rF9VqZWOdT/fmp2wUzc+pUss7dOzLdIk9brV8oai+DkEJwcYAS71YufPLt3n4ju9IpI0M9a+kfYGR9a2hr7TAKS4/8PKi5RY9zPW51NR97QEBco6RkLyMAWb9sfgF0mflasiYBqnXeCwKiwqgOXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427033; c=relaxed/simple;
	bh=6d/Y8k3VybgEsGGFqzFp4Q5uQ1JnyFZmw0MpgFn5D/I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hfdxl6S9wpBU94gmYuP1Uu76pYYEIQhsxPoDM1YWo1Zv2cZXkWMevF3XrZGigmE8HMdZG/u83HCSjkpoQtVxTHF31IXkH34uYSC/6NW+3/Bz7YJ5VyrNJLvTJimvslvRKt0vcoOjsS6EPShDX6IwR2+OFxtFHyo6ACOuFV1PgLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uxyjtZiM; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uxyjtZiM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPhXT8OKZnBThpYM7XxrXHnRtSnP2qvCXpg1SV785nOSIwYOtVYh003xUvghwHFOGTiR0Ds41Y9hl3ZV7ArG7kc3jbNEHDDfSYw1SlaUyzk5qJWW/lqhZGf8ndrZszV+oOMcjDX4Q/UmdGi54sSEbsPoMgRWIVy1spThlLP/YmG696sBo4UpNJlV0SFFRnB2MRujR7zT0+vzYiiAxEJUf5i/4xuIDH7J+sy6K0slO8ltwBeAl/Qs8BO3m7qf0SlCeKdHdcl7rvd8Ic11UDvD6mM5VJUyK8oXfJ54IDgB79OYDsQxR6TFI6J8kx2wUKmbMGysNjLrHcDEI1kwshFrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpBvzi4Pf29DQodZtDNiDRBK3pvUiMSiCsrcN1dNKcU=;
 b=fDOIkRg4MwmTQfxMc6QK1xGT9ByaVHrQAb/HbPO3ROp7M/rEd+hJl9POyUW8b6A3u7JWPbkDWuRSw9xlCwd7w9MuDyr6mHnbArvmq+UWajpYd5FyW4asyO7Okq+tUSvOodB1+YK+ghSb9VEfPPyQ9AcCA50yK+03rihmlmyxUfd0WVgYqRfw6WAxsTqSZ188X1E9ROQxh4XSrLxQkOdIg7WY/gwY977ohAYK9DTH7TswKsO1ileLjHyGHmSEhK4pir7AMkHLGveLiQLuM3GxT3HrkQqi6tKoSvhRgHYs8UVso5EFmpU9V78LgH3rGCxVk+PSVM8RFCwGl8E3CJ5XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpBvzi4Pf29DQodZtDNiDRBK3pvUiMSiCsrcN1dNKcU=;
 b=uxyjtZiMUxZrNmINFvIrVPygglHo6BDhMMIuTiuSw7VSXlHNEvY2Dr6zEa3H1nqE6amzH7tv9feObxdhdy4/m6hkEpNk3E9V3ZNwhdUSIx6h+vPOb9I9YJOXku+PNN7A1H5tsB1/bakVWF7Y9t+PRA4vYpMqYyAjiptcN8HbdST17OF3nEkwm4fFG1/BNstcgvQ3bbgRPov0jsIywqjei/iZ0/sP0h0fsNiMoB29BcUi/V3xUZkESW+pNaRpOjywiUpLD9E50lGlFRmXyG43L1lqkwtfpWyttPv2thZvuE20Udp13wCVXxjWdZR39eFD2SVlBBLZGN5nIBS6ejMzhA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9852.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 10:10:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 10:10:24 +0000
Message-ID:
 <PN3PR01MB9597E129D2F97A2AE598C1D5B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 28 May 2025 15:40:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] docs: update email credential helpers and improve
 formatting
From: Aditya Garg <gargaditya08@live.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
 <CAPig+cTs0+AUPp1euxqKkX0iFTdw9zGuMU-Qnp+ywhcyP8gxfA@mail.gmail.com>
 <PN3PR01MB9597EBE360893FA638B17952B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597EBE360893FA638B17952B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <75249dc8-2764-439c-b571-db781bf9b5b6@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB9852:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0dda26-7c2b-4442-0d2c-08dd9dcfdca4
X-MS-Exchange-SLBlob-MailProps:
	WcKQPEuhm/uvlEVs3zy/duofypRrmGdNL6NoI9Hbe4YgXOuWFYXDidm/Ongk1659IH8PO29N5tXc8Q4a1jIwI5pTiR720AYmMSGB059UWX6LlP6FKpNqZNZocD4/5bOy1NEWnMBCivInx0B30MPs9Rc3a8qfZPtANBRNtgzW+c+RwldDanROR8FrQw4VPS2sOGHacXA4fCKGmsCxyjZMM3mz2fVnFvvkoseBrG0WdbJutdaP1Y8bQT9+8mnDS9ULY1Wxxbrk2Nv11+sW6gWCSXmfB+eOBWq3susLHQeMRNoZg02iSZFqn3CDx+5oEF77V+eewJveEiBvg1ridGJIP/TalY61z1c1t1QwoTv9F4U3bojxp9n5tL9+suX342J37d3RLV7BubVGbpWh0YEXhZokI3Qkt4vzeQ4I1877RTpA1PPrrbX0QbYiRplI8C4WwhQwsR4HuAAlJSJQtR4SLjpUMf9iKljvIE6v8k68w5mZ/sCTV0VcpErem+s+14WnPbWS2ClHJKqB7jaMbcPq2gXEQo84T+K61ilp5Ivkt+Coe2hro7do4CjJprZaXrMUVOwsnDr29apcuOoxPPuKHywfwEja8xnscMNejlbLjxVYkUpAKf9nn+GgK9KA3QVfALHlJJqBcIPOu3LX70G4v1wnlza3FAMQ+ODCsRi/aagx0fDZUnpU+8WtIDB7yocej//vd6RvW/Fi9MATHZWDt9M8mtWEBUbUoUjXfgsfbjRKvE79N29TUrXwYheN5ZowPaOJT50gf+lGmsPzKgSrRcNbX++shP2as9T7HG5UvOL7dqNABpakAOWp8O6sKRStT3gpA7XcBePu79f2H2s1OQsx5Z9RTRWAodA2TFHYcsA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|7092599006|15080799009|5072599009|461199028|41001999006|21061999006|8060799009|12121999007|19110799006|3412199025|440099028|10035399007|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmlQcDBoSk5IRHJIb2swdzA4UjlmS3FocmxjQU0yUWZ4WUhiNFVpVHlCUDdN?=
 =?utf-8?B?UWkrcFhYMGlDRUdPeUhGRUtqZFlhbHlKOFNBSTMycFJUbzZxRGJlRnpOays3?=
 =?utf-8?B?WnFnYXRja3RvRTlBWFhmUSt2eDQ5U1FtbDcwNGtuamJBR3JWbDRlNXhrN1pz?=
 =?utf-8?B?aHRBQkNTVUhxMlhQcnA1d3hlMnh1U2d5NjFqS241NnBaVVBkSDNvL0Q4ZEZL?=
 =?utf-8?B?MzEwVlJRS1QrNStWWFBRNmF4T2kxVkhVYURQRk9CYTloNHdvTVVnYldBVGln?=
 =?utf-8?B?c2lDcXR2anVmUEIvV2NDcFBncGkwZ0hTT1RlanZPM0lWMFN2K2tpMGc3ejk0?=
 =?utf-8?B?ek1pc0VjUGtoNkZaTStXcGFiRXh2L2pMZDFQQjc4cXYwK3FYMmRmVURCcVlS?=
 =?utf-8?B?TUhCcmNjMFVVd2ZLdzBCU1MrN2NvV2hnNkJZbVVJMnFvcFU5a3ZNTFdveHZo?=
 =?utf-8?B?UHpYYkZVMmVMNlg1N01vVmw2UUNXRldpVjA1MTRGVlhpVXpIUVRSditqSDQ3?=
 =?utf-8?B?WGdHQnhEQjFCdmhBRDJmNmM0SmNJLzM2VDhkaVFDbjRZN3F5VU9FS0ZPZTRz?=
 =?utf-8?B?M21uZHNCR1pZZzlqZ2hvYkVMZDNsUThOSDNPWXRtSmZEbVBueXQyb1Z5ZDFM?=
 =?utf-8?B?VjFxbXBpUWlEZFh6Q1VaaFpQbm9PNExTWnc3T1hKWGZYNzJCYWZPNVpwVm90?=
 =?utf-8?B?V0YzTyt5dElBc29SamRnTGdLc0hsSjRWQzNWV3pTbHVmMEtUdnBTdUtpSUE5?=
 =?utf-8?B?eWhOTXk4Uy9iYXlhVGlxTUpPOW9KLzdnaTdvdGprWkhyc0J6dEpsK2ZlRHZI?=
 =?utf-8?B?WHFzaWN1MW9lMXRZQ0pSSnBCN0F5UkpUeTlYTkkydklIKzRuTjhldTdjc0dW?=
 =?utf-8?B?QmJ6eTl0MUZHZ2dVQzFzdXlxblJheTZrQk96eVlPNGRNcm5EZ2pIbnJjaDlY?=
 =?utf-8?B?Qkl1SzZUWHdNcUxjSEFoTjVicFBORStxWWRBWG05MUJMRERYREFjVElhNUNU?=
 =?utf-8?B?MWdCT1lzWHovcVExTXlxQ3k3ZTZ4V3Bncy9BVk82UEQ1VkZsUHlBQllKUzZ4?=
 =?utf-8?B?TWdWS29SS2VPam8yNkxoVnM2TWlISDhhcURGcTk1cXhzcHdWTVF2Wi9Sa2RM?=
 =?utf-8?B?T0dxbVYwaWZUZ3J3U2N4dDhEcHlZTUdRWllNWlRmeHZFS1FpQVNWU3RsSFRP?=
 =?utf-8?B?N0pWODdkd2hEYXlQN0FWMnRHeFRwZkdqRGR4ZUpGOFRzTVhtYmxVRFZvNzNm?=
 =?utf-8?B?amtsYmpGcHFkeHIyVzhvYlpkai9PQnZRcXd3WmdQZkFwRW15WHBPQUI1UmNk?=
 =?utf-8?B?MU5neWlMbmszSERpeGU2WDV4TDFpU2xpbTlUWkU1NG1tNW1hdDJHOWNxVW9a?=
 =?utf-8?B?QnlTUTJuUVZoV1dJc1VOc0xhWTNmMk5PQU9lb1c1NS9peXpTTnpST2g0alM5?=
 =?utf-8?B?aVNNM1B0T3NVKzYza0VCNG90WG1CUUY0M0tkNDJtcHZ0VFg5cTdndW1udmEw?=
 =?utf-8?B?eDRnK28yWkJiYXlRWXlWODhJMzBPbXYxVExMai9wbGljU1A5U2UxUTlWQjgr?=
 =?utf-8?B?THlIRFVVZ0o3QWM0aURjbzludjR4UndOVklRUVlQbENqbUFabVNUU2t6bEZF?=
 =?utf-8?B?TkJjZzVvWGhsUS9VdmxYOXRCcW5odHlsVXBHQi9sTnFtaXZ6YU1jZ1dTNWo0?=
 =?utf-8?B?bTY0emFVbXBaMWVrQkc5RzQ5MWlyZzFUVk16cjdQUHIxTjJHalhBTGlFT0lM?=
 =?utf-8?B?QjhnTFQyUkhUQnZ4N2M2SlFLOGc4TzdKZnN1cCtPOVBuTkhOUmNRRDc0T1Jx?=
 =?utf-8?B?TDdpN2c5YnVLajdaS29pdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFc2eStFKyt0Ym5vKzNlUEVvc2w5OC81SlFJK1d6T0tUbTVKUkhOeXgvMUJR?=
 =?utf-8?B?M1RyRVhLMktUMExuNkh2bS9HUUNUL0hveldCcVpKT3NybXBTSkVlenlueU0v?=
 =?utf-8?B?djZBQmFrL2xtbFNWbS9DUEhQc3A4Y1BpYk1vY3dKQkoxSUN5ZTZEMTdia0xw?=
 =?utf-8?B?bGJ3VHFPUVFrWjZ1RUVkemVFeVVuRWd6L3lPOGdSbUpoa1RBMEFmdXcwdjR4?=
 =?utf-8?B?RXFlMXRNYWp2NlNaOTJvdlhoSERXWGRNOXRMQktxUFJ2WHd2SjRUMFkzQnE3?=
 =?utf-8?B?RlFpL1pIZlNsUy9LalNIN09BSEpLSTROU1JUOGNsQ0hiTXVQUmJzMnF2Z3JO?=
 =?utf-8?B?K3dyb3lMa1MydjNhZHcrZENka2dQMW52a09Sanh1ZWRJWld0LzNjdGdWMzJx?=
 =?utf-8?B?TkVEdTMwT1p5NDlyNlNrT0FuUElpcm1USzFyVkZxR0ovN1BuVGF0QldOUjA3?=
 =?utf-8?B?dEw2SjQ3a2NlR0ZVMzl3dnBzbEU4cmkwdjRLZ2lGbjF1Y2JYVVZwcVMzaGY2?=
 =?utf-8?B?cERqSi9VbnJRSk5FZ3MwV0hwSHRMR2dxMXoxTFZmNU00SStsdUNNeU1IOXFs?=
 =?utf-8?B?N2pTOStkME84c1pJTDJ4a2VYa3lGUFJVNmw2WE9JMzdvWjBwYmtLVnVvQ2pB?=
 =?utf-8?B?N3FxY0JFNFltUGx5Mkh3S3kxaDNIaHdEYm5XQVVIRWxFL3U5RXJNUWN4VXJO?=
 =?utf-8?B?UHVPUGxkWG5HS2l0RXdxTDNPeG92L0hXZ3RNQ2d1S3lDTlpjTlhPU3hxbDFO?=
 =?utf-8?B?encyWXo2NmRuOStsZTU2RkpjcnFENDRvMEd2dlM2TmVFUGgzWTVZOVEwZndN?=
 =?utf-8?B?bFRneEFYMm90NG9YRzBQL25aRTIwZGNMdlpYeTh4MFU1anJQMEpMb1hId3I5?=
 =?utf-8?B?R0ROVE1QUW80OUI1UmVFczdYKzlUbGV4OUhYSlZGZ3BYZ2NrT1NpdkpmTXBw?=
 =?utf-8?B?R1oySVkvck9KVjVaazduNkJnSW02Y2NEMk5ubGxPZjNxQVdNV1BvbVUxcUUy?=
 =?utf-8?B?aWNhSGZhVGFtU2lRR3docENLOWtCdE5kdnhHM0Q1ZTZXUE1xcCtVbnNsNkts?=
 =?utf-8?B?ZWdxSnVpYW0yTHJVVGZxdm5GTnZwRE5aMFJJZWh4S1p0OU5vNWJQWXZyenlL?=
 =?utf-8?B?dWpoUEdPZUdVSFRhSW9vWlZmY3BaaVJLcDFyK1Rxd1lKdFBtU3RrS1J4Zkhp?=
 =?utf-8?B?MWhQVXU3RlQyemlzRWlKd3loMEQxdVFOZHA0V3I5N1ZuL0hvaXNOQXZhMXF4?=
 =?utf-8?B?SXlUWEthYjRZeUZ6VVBNSmltTis4QmQvMVgyNjBCQVQ5SEZVeWVnRUxUMlV5?=
 =?utf-8?B?cEpFRFZIZk9xYUs2bzFXc3ZyRWp6RnkwWFNUbnVOVDhHV3ZBQW45Nk1uaFNh?=
 =?utf-8?B?cVY1b3FHRENqalFTaGpRZTN6TXBsTkRPalNnSSswZlN2NlFHUkd0R3NYeWhG?=
 =?utf-8?B?V3dNemtzb0tNTDMxUUNDSzIwbHdQYmFqa3IzT0dtY2o3SU9kRzJ4VUluU2lW?=
 =?utf-8?B?b0ZPbXFZTmNvQ3dWRVVORGxLT050TDh3RFY5U0V0Ymh3eXBvQ2s5bVMvS0VG?=
 =?utf-8?B?QmpxZmdlK3V1MXBLUmYySnQ4UjI4UHMrZSt0MGwyT2hEZjdoeGFuS3lyR1lD?=
 =?utf-8?B?c1RYbGZGYTJMR1l6cWxXSkwrSEdTUzduLzNSMlpNVHpuUzBYajV6aG5mSjFm?=
 =?utf-8?B?U1didFBqb251NlBlZDROd21NRzJONkxLWDdQMXJaQ0REcDB6bnZvMEtqS015?=
 =?utf-8?Q?1aONeac4i07ChBlhTA=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0dda26-7c2b-4442-0d2c-08dd9dcfdca4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 10:10:24.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9852



On 28-05-2025 03:06 pm, Aditya Garg wrote:
> 
> 
> On 28-05-2025 12:53 pm, Eric Sunshine wrote:
>> On Wed, May 28, 2025 at 3:05 AM Aditya Garg <gargaditya08@live.com> wrote:
>>> v5: Added a patch to make the purpose of using app password for Gmail
>>>     more clear in `send-email` documentation.
>>>
>>> Range-diff:
>>> -:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and link Google's sendgmail tool
>>> -:  ---------- > 2:  bc1d0471ca docs: improve formatting in git-send-email documentation
>>> -:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for emails from gitcredentials
>>> -:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app password for Gmail more clear in send-email
>>
>> Strange range-diff.
> 
> I think because I used git version 2.43. When I compiled my branch with changes, git format-patch over there
> had a very different range-diff from this.

This is the one from Git 2.49

Range-diff:
2:  72b3cd1bfb ! 1:  2c47cc5396 send-email: show the new message id assigned by outlook in the logs
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    send-email: show the new message id assigned by outlook in the logs
    +    docs: add credential helper for yahoo and link Google's sendgmail tool
     
    -    Whenever an email is sent, send-email shows a log at last, which
    -    contains all the headers of the email that were received by the
    -    receipients.
    -
    -    In case outlook changes the Message-ID, a log for the same is shown to
    -    the user, but that change is not reflected when the log containing all
    -    the headers is displayed. Here is an example of the log that is shown
    -    when outlook changes the Message-ID:
    -
    -    Outlook reassigned Message-ID to: <PN3PR01MB95973E5ACD7CCFADCB4E298CB865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
    -    OK. Log says:
    -    Server: smtp.office365.com
    -    MAIL FROM:<gargaditya08@live.com>
    -    RCPT TO:<negahe7142@nomrista.com>
    -    From: Aditya Garg <gargaditya08@live.com>
    -    To: negahe7142@nomrista.com
    -    Subject: [PATCH] send-email: show the new message id assigned by outlook in the logs
    -    Date: Mon, 26 May 2025 20:28:36 +0530
    -    Message-ID: <20250526145836.4825-1-gargaditya08@live.com>
    -    X-Mailer: git-send-email @GIT_VERSION@
    -    MIME-Version: 1.0
    -    Content-Transfer-Encoding: 8bit
    -
    -    Result: 250
    -
    -    This patch fixes this by modifying the $header variable, which is
    -    responsible for showing the logs at the end. Also, the log which states
    -    that the Message-ID has been changed will now be shown only when
    -    smtp-debug is enabled, since the main log having all of the headers is
    -    anyways displaying the new Message-ID. It should look like this after
    -    this patch:
    -
    -    OK. Log says:
    -    Server: smtp.office365.com
    -    MAIL FROM:<gargaditya08@live.com>
    -    RCPT TO:<negahe7142@nomrista.com>
    -    From: Aditya Garg <gargaditya08@live.com>
    -    To: negahe7142@nomrista.com
    -    Subject: [PATCH] send-email: show the new message id assigned by outlook in the logs
    -    Date: Mon, 26 May 2025 20:29:22 +0530
    -    Message-ID: <PN3PR01MB95977486061BD2542BD09B67B865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
    -    X-Mailer: git-send-email @GIT_VERSION@
    -    MIME-Version: 1.0
    -    Content-Transfer-Encoding: 8bit
    -
    -    Result: 250
    +    This commit links `git-credential-yahoo` as a credential helper for
    +    Yahoo accounts. Also, Google's `sendgmail` tool has been linked as an
    +    alternative method for sending emails through Gmail.
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
    - ## git-send-email.perl ##
    -@@ git-send-email.perl: sub send_message {
    - 		if (is_outlook($smtp_server)) {
    - 			if ($smtp->message =~ /<([^>]+)>/) {
    - 				$message_id = "<$1>";
    --				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
    -+				# Replace the original Message-ID in $header with the new one
    -+				$header =~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;
    -+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id if $smtp->debug;
    - 			} else {
    - 				warn __("Warning: Could not retrieve Message-ID from server response.\n");
    - 			}
    + ## Documentation/git-send-email.adoc ##
    +@@ Documentation/git-send-email.adoc: settings:
    + 	smtpAuth = OAUTHBEARER
    + ----
    + 
    ++Alternatively, you can use a tool developed by Google known as
    ++https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail[sendgmail]
    ++to send emails using `git send-email`.
    ++
    + Use Microsoft Outlook as the SMTP Server
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
    +@@ Documentation/git-send-email.adoc: next time.
    + 
    + If you are using OAuth2.0 authentication, you need to use an access token in
    + place of a password when prompted. Various OAuth2.0 token generators are
    +-available online. Community maintained credential helpers for Gmail and Outlook
    +-are also available:
    ++available online. Community maintained credential helpers are also available:
    + 
    + 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail]
    + 	  (cross platform, dedicated helper for authenticating Gmail accounts)
    +@@ Documentation/git-send-email.adoc: are also available:
    + 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
    + 	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
    + 
    ++	- https://github.com/AdityaGarg8/git-credential-email[git-credential-yahoo]
    ++	  (cross platform, dedicated helper for authenticating Yahoo accounts)
    ++
    + You can also see linkgit:gitcredentials[7] for more OAuth based authentication
    + helpers.
    + 
1:  63addf9d9b ! 2:  bc1d0471ca send-email: fix bug resulting in increased message number if a message is edited
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    send-email: fix bug resulting in increased message number if a message is edited
    +    docs: improve formatting in git-send-email documentation
     
    -    Whenever we send a thread of emails using send-email, a message number
    -    is internally assigned to each email. This number is used to track the
    -    order of the emails in the thread. Whenever a new message is processed
    -    in a thread, the current script logic increases the message number by
    -    one, which is intended.
    +    The current documentation for git-send-email had an inconsistent use of
    +    "", ``, and '' for quoting. This commit improves the formatting by
    +    using the same style throughout the documentation.
     
    -    But, if a message is edited and then resent, its message number again
    -    gets increased. This is because the script uses the same logic to
    -    process the edited message, which is uses the send the next message.
    +    Also, at some places, minor grammatical errors were fixed, and some
    +    non existent links were removed.
     
    -    This minor bug is usually harmless unless some special situations arise.
    -    One such situation is when the first message in a thread is edited
    -    and resent, and an `--in-reply-to` argument is also passed to send-email.
    -    In this case if the user has chosen shallow threading, the threading
    -    does not work as expected, and all messaged become as replies to the
    -    Message-ID specified in the `--in-reply-to` argument.
    -
    -    The reason for this bug is hidden in the code for threading itself.
    -
    -    if ($thread) {
    -            if ($message_was_sent &&
    -              ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) == 0 ||
    -              $message_num == 1)) {
    -                    $in_reply_to = $message_id;
    -                    if (length $references > 0) {
    -                            $references .= "\n $message_id";
    -                    } else {
    -                            $references = "$message_id";
    -                    }
    -            }
    -    }
    -
    -    Here $message_num is the current message number, and $in_reply_to is
    -    the Message-ID of the message to which the current message is a reply.
    -    In case `--in-reply-to` is specified, the `$in_reply_to` variable
    -    is set to the value of the `--in-reply-to` argument.
    -
    -    Whenever this whole set of conditions is true, the script sets the
    -    `$in_reply_to` variable to the current message's ID. This is done to
    -    ensure that the next message in the thread is a reply to this message.
    -
    -    In case we specify an `--in-reply-to` argument, and have shallow
    -    threading, the only condition that can make this true is
    -    `$message_num == 1`, which is true for the first message in a thread.
    -    Thus the $in_reply_to variable gets set to the first message's ID.
    -    For subsequent messages, the `$message_num` variable is always
    -    greater than 1, and the whole set of conditions is false, and thus the
    -    $in_reply_to variable remains as the first message's ID. This is what
    -    we expect in shallow threading. But, in case the user edits the first
    -    message and resends it, the `$message_num` variable gets increased by 1,
    -    and thus the condition `$message_num == 1` becomes false. This means
    -    that the `$in_reply_to` variable is not set to the first message's ID,
    -    and thus the next message in the thread is not a reply to the first
    -    message, but to the `--in-reply-to` argument, effectively breaking
    -    the threading.
    -
    -    In case the user does not specify an `--in-reply-to` argument, the
    -    !defined $in_reply_to condition is true, and thus the `$in_reply_to`
    -    variable is set to the first message's ID, and the threading works
    -    as expected, irrespective of what the message number is.
    -
    -    Just like $message_num, $message_id_serial variable also increases by 1
    -    whenever a new message is sent. This variable displays the message
    -    number is the Message-ID of the email.
    -
    -    So, in order to fix this bug, we need to ensure that the $message_num
    -    variable is not increased by 1 when a message is edited and resent.
    -    We do this by decreasing the $message_num and $message_id_serial
    -    variable by 1 whenever the request to edit a message is received. This
    -    way, the next message in the thread will have the same message number as
    -    the edited message, and thus the threading will work as expected.
    -
    -    The same logic has also been applied in case the user drops a single
    -    message from the thread by choosing the "[n]o" option during
    -    confirmation. By doing this, the next message in the thread is assigned
    -    the message number of the dropped message, and thus the threading
    -    works as expected.
    +    Finally, the cpan links of necessary perl modules have been added to
    +    make their installation easier.
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
    - ## git-send-email.perl ##
    -@@ git-send-email.perl: sub send_message {
    - 		         default => $ask_default);
    - 		die __("Send this email reply required") unless defined $_;
    - 		if (/^n/i) {
    -+			# If we are skipping a message, we should make sure that
    -+			# the next message is treated as the successor to the
    -+			# previously sent message, and not the skipped message.
    -+			$message_num--;
    -+			$message_id_serial--;
    - 			return 0;
    - 		} elsif (/^e/i) {
    -+			# Since the same message will be sent again, we need to
    -+			# decrement the message number to the previous message.
    -+			# Otherwise, the edited message will be treated as a
    -+			# different message sent after the original non-edited
    -+			# message.
    -+			$message_num--;
    -+			$message_id_serial--;
    - 			return -1;
    - 		} elsif (/^q/i) {
    - 			cleanup_compose_files();
    + ## Documentation/config/sendemail.adoc ##
    +@@ Documentation/config/sendemail.adoc: sendemail.<identity>.*::
    + 	`sendemail.identity`.
    + 
    + sendemail.multiEdit::
    +-	If true (default), a single editor instance will be spawned to edit
    ++	If `true` (default), a single editor instance will be spawned to edit
    + 	files you have to edit (patches when `--annotate` is used, and the
    +-	summary when `--compose` is used). If false, files will be edited one
    ++	summary when `--compose` is used). If `false`, files will be edited one
    + 	after the other, spawning a new editor each time.
    + 
    + sendemail.confirm::
    +@@ Documentation/config/sendemail.adoc: sendemail.signedOffCc (deprecated)::
    + 
    + sendemail.smtpBatchSize::
    + 	Number of messages to be sent per connection, after that a relogin
    +-	will happen.  If the value is 0 or undefined, send all messages in
    ++	will happen.  If the value is `0` or undefined, send all messages in
    + 	one connection.
    + 	See also the `--batch-size` option of linkgit:git-send-email[1].
    + 
    +@@ Documentation/config/sendemail.adoc: sendemail.smtpReloginDelay::
    + 
    + sendemail.forbidSendmailVariables::
    + 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
    +-	will abort with a warning if any configuration options for "sendmail"
    ++	will abort with a warning if any configuration options for `sendmail`
    + 	exist. Set this variable to bypass the check.
    +
    + ## Documentation/git-send-email.adoc ##
    +@@ Documentation/git-send-email.adoc: Takes the patches given on the command line and emails them out.
    + Patches can be specified as files, directories (which will send all
    + files in the directory), or directly as a revision list.  In the
    + last case, any format accepted by linkgit:git-format-patch[1] can
    +-be passed to git send-email, as well as options understood by
    ++be passed to `git send-email`, as well as options understood by
    + linkgit:git-format-patch[1].
    + 
    + The header of the email is configurable via command-line options.  If not
    +@@ Documentation/git-send-email.adoc: There are two formats accepted for patch files:
    + This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
    + formatting are ignored.
    + 
    +-2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl'
    ++2. The original format used by Greg Kroah-Hartman's `send_lots_of_email.pl`
    +    script
    + +
    +-This format expects the first line of the file to contain the "Cc:" value
    +-and the "Subject:" of the message as the second line.
    ++This format expects the first line of the file to contain the 'Cc:' value
    ++and the 'Subject:' of the message as the second line.
    + 
    + 
    + OPTIONS
    +@@ Documentation/git-send-email.adoc: Composing
    + 	`sendemail.multiEdit`.
    + 
    + --bcc=<address>,...::
    +-	Specify a "Bcc:" value for each email. Default is the value of
    ++	Specify a 'Bcc:' value for each email. Default is the value of
    + 	`sendemail.bcc`.
    + +
    + This option may be specified multiple times.
    + 
    + --cc=<address>,...::
    +-	Specify a starting "Cc:" value for each email.
    ++	Specify a starting 'Cc:' value for each email.
    + 	Default is the value of `sendemail.cc`.
    + +
    + This option may be specified multiple times.
    +@@ Documentation/git-send-email.adoc: This option may be specified multiple times.
    + 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
    + 	to edit an introductory message for the patch series.
    + +
    +-When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
    +-Subject, Reply-To, and In-Reply-To headers specified in the message. If
    +-the body of the message (what you type after the headers and a blank
    +-line) only contains blank (or Git: prefixed) lines, the summary won't be
    ++When `--compose` is used, `git send-email` will use the 'From', 'To', 'Cc',
    ++'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in the
    ++message. If the body of the message (what you type after the headers and a
    ++blank line) only contains blank (or Git: prefixed) lines, the summary won't be
    + sent, but the headers mentioned above will be used unless they are
    + removed.
    + +
    +-Missing From or In-Reply-To headers will be prompted for.
    ++Missing 'From' or 'In-Reply-To' headers will be prompted for.
    + +
    + See the CONFIGURATION section for `sendemail.multiEdit`.
    + 
    +@@ Documentation/git-send-email.adoc: See the CONFIGURATION section for `sendemail.multiEdit`.
    + 	the value of the `sendemail.from` configuration option is used.  If
    + 	neither the command-line option nor `sendemail.from` are set, then the
    + 	user will be prompted for the value.  The default for the prompt will be
    +-	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
    +-	set, as returned by "git var -l".
    ++	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
    ++	set, as returned by `git var -l`.
    + 
    + --reply-to=<address>::
    + 	Specify the address where replies from recipients should go to.
    + 	Use this if replies to messages should go to another address than what
    +-	is specified with the --from parameter.
    ++	is specified with the `--from` parameter.
    + 
    + --in-reply-to=<identifier>::
    + 	Make the first mail (or all the mails with `--no-thread`) appear as a
    +@@ Documentation/git-send-email.adoc: illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
    +       [PATCH v2 2/3] New tests
    +       [PATCH v2 3/3] Implementation
    + +
    +-Only necessary if --compose is also set.  If --compose
    ++Only necessary if `--compose` is also set.  If `--compose`
    + is not set, this will be prompted for.
    + 
    + --[no-]outlook-id-fix::
    + 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
    + 	assign a new random Message-ID, thus breaking threads.
    + +
    +-With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
    ++With `--outlook-id-fix`, `git send-email` uses a mechanism specific to
    + Outlook servers to learn the Message-ID the server assigned to fix the
    + threading. Use it only when you know that the server reports the
    + rewritten Message-ID the same way as Outlook servers do.
    +@@ Documentation/git-send-email.adoc: to 'smtp.office365.com' or 'smtp-mail.outlook.com'. Use
    + 
    + --subject=<string>::
    + 	Specify the initial subject of the email thread.
    +-	Only necessary if --compose is also set.  If --compose
    ++	Only necessary if `--compose` is also set.  If `--compose`
    + 	is not set, this will be prompted for.
    + 
    + --to=<address>,...::
    + 	Specify the primary recipient of the emails generated. Generally, this
    + 	will be the upstream maintainer of the project involved. Default is the
    + 	value of the `sendemail.to` configuration value; if that is unspecified,
    +-	and --to-cmd is not specified, this will be prompted for.
    ++	and `--to-cmd` is not specified, this will be prompted for.
    + +
    + This option may be specified multiple times.
    + 
    +@@ Documentation/git-send-email.adoc: This option may be specified multiple times.
    + 	When encountering a non-ASCII message or subject that does not
    + 	declare its encoding, add headers/quoting to indicate it is
    + 	encoded in <encoding>.  Default is the value of the
    +-	'sendemail.assume8bitEncoding'; if that is unspecified, this
    ++	`sendemail.assume8bitEncoding`; if that is unspecified, this
    + 	will be prompted for if any non-ASCII files are encountered.
    + +
    + Note that no attempts whatsoever are made to validate the encoding.
    + 
    + --compose-encoding=<encoding>::
    + 	Specify encoding of compose message. Default is the value of the
    +-	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.
    ++	`sendemail.composeEncoding`; if that is unspecified, UTF-8 is assumed.
    + 
    + --transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)::
    + 	Specify the transfer encoding to be used to send the message over SMTP.
    +-	7bit will fail upon encountering a non-ASCII message.  quoted-printable
    ++	'7bit' will fail upon encountering a non-ASCII message. 'quoted-printable'
    + 	can be useful when the repository contains files that contain carriage
    +-	returns, but makes the raw patch email file (as saved from a MUA) much
    +-	harder to inspect manually.  base64 is even more fool proof, but also
    +-	even more opaque.  auto will use 8bit when possible, and quoted-printable
    +-	otherwise.
    ++	returns, but makes the raw patch email file (as saved from an MUA) much
    ++	harder to inspect manually. 'base64' is even more fool proof, but also
    ++	even more opaque. 'auto' will use '8bit' when possible, and
    ++	'quoted-printable' otherwise.
    + +
    + Default is the value of the `sendemail.transferEncoding` configuration
    +-value; if that is unspecified, default to `auto`.
    ++value; if that is unspecified, default to 'auto'.
    + 
    + --xmailer::
    + --no-xmailer::
    +-	Add (or prevent adding) the "X-Mailer:" header.  By default,
    ++	Add (or prevent adding) the 'X-Mailer:' header.  By default,
    + 	the header is added, but it can be turned off by setting the
    + 	`sendemail.xmailer` configuration variable to `false`.
    + 
    +@@ Documentation/git-send-email.adoc: Sending
    + 	Specify the envelope sender used to send the emails.
    + 	This is useful if your default address is not the address that is
    + 	subscribed to a list. In order to use the 'From' address, set the
    +-	value to "auto". If you use the sendmail binary, you must have
    +-	suitable privileges for the -f parameter.  Default is the value of the
    ++	value to `auto`. If you use the `sendmail` binary, you must have
    ++	suitable privileges for the `-f` parameter.  Default is the value of the
    + 	`sendemail.envelopeSender` configuration variable; if that is
    + 	unspecified, choosing the envelope sender is left to your MTA.
    + 
    +@@ Documentation/git-send-email.adoc: Sending
    + 	be sendmail-like; specifically, it must support the `-i` option.
    + 	The command will be executed in the shell if necessary.  Default
    + 	is the value of `sendemail.sendmailCmd`.  If unspecified, and if
    +-	--smtp-server is also unspecified, git-send-email will search
    +-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
    ++	`--smtp-server` is also unspecified, `git send-email` will search
    ++	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH`.
    + 
    + --smtp-encryption=<encryption>::
    + 	Specify in what way encrypting begins for the SMTP connection.
    +@@ Documentation/git-send-email.adoc: Sending
    + --smtp-domain=<FQDN>::
    + 	Specifies the Fully Qualified Domain Name (FQDN) used in the
    + 	HELO/EHLO command to the SMTP server.  Some servers require the
    +-	FQDN to match your IP address.  If not set, git send-email attempts
    ++	FQDN to match your IP address.  If not set, `git send-email` attempts
    + 	to determine your FQDN automatically.  Default is the value of
    + 	`sendemail.smtpDomain`.
    + 
    +@@ Documentation/git-send-email.adoc: $ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
    + +
    + If at least one of the specified mechanisms matches the ones advertised by the
    + SMTP server and if it is supported by the utilized SASL library, the mechanism
    +-is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
    ++is used for authentication. If neither `sendemail.smtpAuth` nor `--smtp-auth`
    + is specified, all mechanisms supported by the SASL library can be used. The
    +-special value 'none' maybe specified to completely disable authentication
    +-independently of `--smtp-user`
    ++special value `none` maybe specified to completely disable authentication
    ++independently of `--smtp-user`.
    + 
    + --smtp-pass[=<password>]::
    + 	Password for SMTP-AUTH. The argument is optional: If no
    +@@ Documentation/git-send-email.adoc: Furthermore, passwords need not be specified in configuration files
    + or on the command line. If a username has been specified (with
    + `--smtp-user` or a `sendemail.smtpUser`), but no password has been
    + specified (with `--smtp-pass` or `sendemail.smtpPass`), then
    +-a password is obtained using 'git-credential'.
    ++a password is obtained using linkgit:git-credential[1].
    + 
    + --no-smtp-auth::
    +-	Disable SMTP authentication. Short hand for `--smtp-auth=none`
    ++	Disable SMTP authentication. Short hand for `--smtp-auth=none`.
    + 
    + --smtp-server=<host>::
    + 	If set, specifies the outgoing SMTP server to use (e.g.
    + 	`smtp.example.com` or a raw IP address).  If unspecified, and if
    + 	`--sendmail-cmd` is also unspecified, the default is to search
    +-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
    ++	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
    + 	program is available, falling back to `localhost` otherwise.
    + +
    + For backward compatibility, this option can also specify a full pathname
    +@@ Documentation/git-send-email.adoc: instead.
    + 	Specifies a port different from the default port (SMTP
    + 	servers typically listen to smtp port 25, but may also listen to
    + 	submission port 587, or the common SSL smtp port 465);
    +-	symbolic port names (e.g. "submission" instead of 587)
    ++	symbolic port names (e.g. `submission` instead of 587)
    + 	are also accepted. The port can also be set with the
    + 	`sendemail.smtpServerPort` configuration variable.
    + 
    +@@ Documentation/git-send-email.adoc: instead.
    + 	Default value can be specified by the `sendemail.smtpServerOption`
    + 	configuration option.
    + +
    +-The --smtp-server-option option must be repeated for each option you want
    ++The `--smtp-server-option` option must be repeated for each option you want
    + to pass to the server. Likewise, different lines in the configuration files
    + must be used for each option.
    + 
    +@@ Documentation/git-send-email.adoc: must be used for each option.
    + --smtp-ssl-cert-path::
    + 	Path to a store of trusted CA certificates for SMTP SSL/TLS
    + 	certificate validation (either a directory that has been processed
    +-	by 'c_rehash', or a single file containing one or more PEM format
    +-	certificates concatenated together: see verify(1) -CAfile and
    +-	-CApath for more information on these). Set it to an empty string
    ++	by `c_rehash`, or a single file containing one or more PEM format
    ++	certificates concatenated together). Set it to an empty string
    + 	to disable certificate verification. Defaults to the value of the
    + 	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
    + 	backing SSL library's compiled-in default otherwise (which should
    +@@ Documentation/git-send-email.adoc: must be used for each option.
    + 	connection and authentication problems.
    + 
    + --batch-size=<num>::
    +-	Some email servers (e.g. smtp.163.com) limit the number emails to be
    ++	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
    + 	sent per session (connection) and this will lead to a failure when
    + 	sending many messages.  With this option, send-email will disconnect after
    +-	sending $<num> messages and wait for a few seconds (see --relogin-delay)
    +-	and reconnect, to work around such a limit.  You may want to
    +-	use some form of credential helper to avoid having to retype
    +-	your password every time this happens.  Defaults to the
    ++	sending `$<num>` messages and wait for a few seconds
    ++	(see `--relogin-delay`) and reconnect, to work around such a limit.
    ++	You may want to use some form of credential helper to avoid having to
    ++	retype your password every time this happens.  Defaults to the
    + 	`sendemail.smtpBatchSize` configuration variable.
    + 
    + --relogin-delay=<int>::
    +-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
    +-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
    ++	Waiting `$<int>` seconds before reconnecting to SMTP server. Used together
    ++	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
    + 	configuration variable.
    + 
    + Automating
    +@@ Documentation/git-send-email.adoc: Automating
    + --no-to::
    + --no-cc::
    + --no-bcc::
    +-	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
    ++	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
    + 	set via config.
    + 
    + --no-identity::
    +@@ Documentation/git-send-email.adoc: Automating
    + 
    + --to-cmd=<command>::
    + 	Specify a command to execute once per patch file which
    +-	should generate patch file specific "To:" entries.
    ++	should generate patch file specific 'To:' entries.
    + 	Output of this command must be single email address per line.
    +-	Default is the value of 'sendemail.toCmd' configuration value.
    ++	Default is the value of `sendemail.toCmd` configuration value.
    + 
    + --cc-cmd=<command>::
    + 	Specify a command to execute once per patch file which
    +-	should generate patch file specific "Cc:" entries.
    ++	should generate patch file specific 'Cc:' entries.
    + 	Output of this command must be single email address per line.
    + 	Default is the value of `sendemail.ccCmd` configuration value.
    + 
    +@@ Documentation/git-send-email.adoc: Automating
    + 	Specify a command that is executed once per outgoing message
    + 	and output RFC 2822 style header lines to be inserted into
    + 	them. When the `sendemail.headerCmd` configuration variable is
    +-	set, its value is always used. When --header-cmd is provided
    ++	set, its value is always used. When `--header-cmd` is provided
    + 	at the command line, its value takes precedence over the
    + 	`sendemail.headerCmd` configuration variable.
    + 
    +@@ Documentation/git-send-email.adoc: Automating
    + 
    + --[no-]chain-reply-to::
    + 	If this is set, each email will be sent as a reply to the previous
    +-	email sent.  If disabled with "--no-chain-reply-to", all emails after
    ++	email sent.  If disabled with `--no-chain-reply-to`, all emails after
    + 	the first will be sent as replies to the first email sent.  When using
    + 	this, it is recommended that the first file given be an overview of the
    + 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo`
    +@@ Documentation/git-send-email.adoc: Automating
    + 	the value of `sendemail.identity`.
    + 
    + --[no-]signed-off-by-cc::
    +-	If this is set, add emails found in the `Signed-off-by` trailer or Cc: lines to the
    +-	cc list. Default is the value of `sendemail.signedOffByCc` configuration
    +-	value; if that is unspecified, default to --signed-off-by-cc.
    ++	If this is set, add emails found in the `Signed-off-by` trailer or 'Cc:'
    ++	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
    ++	configuration value; if that is unspecified, default to
    ++	`--signed-off-by-cc`.
    + 
    + --[no-]cc-cover::
    +-	If this is set, emails found in Cc: headers in the first patch of
    ++	If this is set, emails found in 'Cc:' headers in the first patch of
    + 	the series (typically the cover letter) are added to the cc list
    +-	for each email set. Default is the value of 'sendemail.ccCover'
    +-	configuration value; if that is unspecified, default to --no-cc-cover.
    ++	for each email set. Default is the value of `sendemail.ccCover`
    ++	configuration value; if that is unspecified, default to `--no-cc-cover`.
    + 
    + --[no-]to-cover::
    +-	If this is set, emails found in To: headers in the first patch of
    ++	If this is set, emails found in 'To:' headers in the first patch of
    + 	the series (typically the cover letter) are added to the to list
    +-	for each email set. Default is the value of 'sendemail.toCover'
    +-	configuration value; if that is unspecified, default to --no-to-cover.
    ++	for each email set. Default is the value of `sendemail.toCover`
    ++	configuration value; if that is unspecified, default to `--no-to-cover`.
    + 
    + --suppress-cc=<category>::
    + 	Specify an additional category of recipients to suppress the
    +@@ Documentation/git-send-email.adoc: Automating
    + --
    + +
    + Default is the value of `sendemail.suppressCc` configuration value; if
    +-that is unspecified, default to 'self' if --suppress-from is
    +-specified, as well as 'body' if --no-signed-off-cc is specified.
    ++that is unspecified, default to 'self' if `--suppress-from` is
    ++specified, as well as 'body' if `--no-signed-off-cc` is specified.
    + 
    + --[no-]suppress-from::
    +-	If this is set, do not add the From: address to the cc: list.
    ++	If this is set, do not add the 'From:' address to the 'Cc:' list.
    + 	Default is the value of `sendemail.suppressFrom` configuration
    +-	value; if that is unspecified, default to --no-suppress-from.
    ++	value; if that is unspecified, default to `--no-suppress-from`.
    + 
    + --[no-]thread::
    +-	If this is set, the In-Reply-To and References headers will be
    ++	If this is set, the 'In-Reply-To' and 'References' headers will be
    + 	added to each email sent.  Whether each mail refers to the
    +-	previous email (`deep` threading per 'git format-patch'
    ++	previous email (`deep` threading per `git format-patch`
    + 	wording) or to the first email (`shallow` threading) is
    +-	governed by "--[no-]chain-reply-to".
    ++	governed by `--[no-]chain-reply-to`.
    + +
    +-If disabled with "--no-thread", those headers will not be added
    +-(unless specified with --in-reply-to).  Default is the value of the
    ++If disabled with `--no-thread`, those headers will not be added
    ++(unless specified with `--in-reply-to`).  Default is the value of the
    + `sendemail.thread` configuration value; if that is unspecified,
    +-default to --thread.
    ++default to `--thread`.
    + +
    + It is up to the user to ensure that no In-Reply-To header already
    +-exists when 'git send-email' is asked to add it (especially note that
    +-'git format-patch' can be configured to do the threading itself).
    ++exists when `git send-email` is asked to add it (especially note that
    ++`git format-patch` can be configured to do the threading itself).
    + Failure to do so may not produce the expected result in the
    + recipient's MUA.
    + 
    + --[no-]mailmap::
    + 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
    + 	addresses to their canonical real name and email address. Additional
    +-	mailmap data specific to git-send-email may be provided using the
    ++	mailmap data specific to `git send-email` may be provided using the
    + 	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
    + 	values. Defaults to `sendemail.mailmap`.
    + 
    +@@ Documentation/git-send-email.adoc: Administering
    + 	Confirm just before sending:
    + +
    + --
    +-- 'always' will always confirm before sending
    +-- 'never' will never confirm before sending
    ++- 'always' will always confirm before sending.
    ++- 'never' will never confirm before sending.
    + - 'cc' will confirm before sending when send-email has automatically
    +-  added addresses from the patch to the Cc list
    ++  added addresses from the patch to the Cc list.
    + - 'compose' will confirm before sending the first message when using --compose.
    +-- 'auto' is equivalent to 'cc' + 'compose'
    ++- 'auto' is equivalent to 'cc' + 'compose'.
    + --
    + +
    + Default is the value of `sendemail.confirm` configuration value; if that
    +@@ Documentation/git-send-email.adoc: have been specified, in which case default to 'compose'.
    + 	When an argument may be understood either as a reference or as a file name,
    + 	choose to understand it as a format-patch argument (`--format-patch`)
    + 	or as a file name (`--no-format-patch`). By default, when such a conflict
    +-	occurs, git send-email will fail.
    ++	occurs, `git send-email` will fail.
    + 
    + --quiet::
    +-	Make git-send-email less verbose.  One line per email should be
    ++	Make `git send-email` less verbose.  One line per email should be
    + 	all that is output.
    + 
    + --[no-]validate::
    +@@ Documentation/git-send-email.adoc: edit `~/.gitconfig` to specify your account settings:
    + ----
    + 
    + If you have multi-factor authentication set up on your Gmail account, you can
    +-generate an app-specific password for use with 'git send-email'. Visit
    ++generate an app-specific password for use with `git send-email`. Visit
    + https://security.google.com/settings/security/apppasswords to create it.
    + 
    + You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
    +@@ Documentation/git-send-email.adoc: helpers.
    + 
    + Note: the following core Perl modules that may be installed with your
    + distribution of Perl are required:
    +-MIME::Base64, MIME::QuotedPrint, Net::Domain and Net::SMTP.
    ++
    ++https://metacpan.org/pod/MIME::Base64[MIME::Base64],
    ++https://metacpan.org/pod/MIME::QuotedPrint[MIME::QuotedPrint],
    ++https://metacpan.org/pod/Net::Domain[Net::Domain] and
    ++https://metacpan.org/pod/Net::SMTP[Net::SMTP].
    ++
    + These additional Perl modules are also required:
    +-Authen::SASL and Mail::Address.
    ++
    ++https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
    ++https://metacpan.org/pod/Mail::Address[Mail::Address].
    + 
    + 
    + SEE ALSO
-:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for emails from gitcredentials
-:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app password for Gmail more clear in send-email
-- 
2.49.0.windows.1

