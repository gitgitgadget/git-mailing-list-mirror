Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012042.outbound.protection.outlook.com [52.103.32.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE45481FC3
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122564; cv=fail; b=lWtk6ZLweMmsr0Lvf0iAmIpu3tN+oXw/xqU45tZTQlceRmq6EvALj6rBaQXVFoqXGEf86u+5Xc+LhujoLijAaboYXdqlU8lGiYgBswQhbmldAHN1QD2V2gRfSexsci37o0nex47hK67wym3HRK5dXTJUSBZp85TJYtnT9DKcmEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122564; c=relaxed/simple;
	bh=bkkgB3r3S/h6u7k+rAnWoLXjzbUM3wISAurd3Gq2kZ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=npEnAd/Lfmnaz1BwkCJl30ezCze3Ww6XHet/bLpKu/clt3TMdeTvXEGOlG3j2/zMKDt5EHFKv/VB3oIEFB1TCol09FDHhFypHUVg30HOj5SQraTb+P6c1qiDzpmh1TmQsyGz2blLDwfl11a6XYMTSnRd+GRV+coNIJDnR6lizGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nYcNh1eB; arc=fail smtp.client-ip=52.103.32.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nYcNh1eB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noYy9NYry4/udJpHtpRdzjgTLdXI/C+xsfHbCrTD18d+vLL9HbKG1VGWE52bU2v+nqeRn8J4eoZyNlqtN2TBpO8A0fFzxtlBX0meSaM9p3cDxjlZsQTtaY2EjniiifLmfzKdgdyEuVqkllWHJ3ETN5VmXYru+HzLAI3lO44yLYuXfZYvGh68MzDDuC4edqRDCxVL5h/xPL2hDCcfJrkefLAaOygUxFHSvoiEqd9GtDGkL6Y5tQR59DG9oyCC4PSIF9WvqBNX3hm5nurWscnFCXy3Eod5POoNrJDHlSPEjNyQMy5m7y6ItfMSnpBXEriq0T01sKuaWsNqzGlRwG4ZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPx7IaLvkaldTWXtw6+i+GXXb+OvPJEvVEZjLskdsaw=;
 b=e+3TLagB/IgrLHJ36ZB9d9Zs0IpjiPvAVRekPfqDmz54kvDJKK8uY4a/oHzKGRqdlFVMpEz1lMRwn7ivTQ4lzJ5dkPr6artn2gZu7bXccI4DFqFy8lio5j9pBJozfHRyaratb9mBk1SNLtXuru2S+7d6Jq/No9Urbbiw35zBxSRpNMvjpKstM007vz2Q6u50MGhnyjbBv6muMEV69RPJHYJq2ey+fNNqNyO7cCduCO81siymjPpLIS7zc7i2GE4ZNMW0dIEYZyrmH1/BYZKq2NnMnPkGX9+q0Ix84OVdjiQYhFBctJA10Cl0pUV/ZsSSqP+KkMW/JM0TQtzGO+ZhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPx7IaLvkaldTWXtw6+i+GXXb+OvPJEvVEZjLskdsaw=;
 b=nYcNh1eBGNKDxU8hiH1FdldV468yOwVx8ypfRHM6pN9llCtHydt5JM7KkSto533SjLPxiPhz1XBf9dqNSrmTdUqpdC5G4UC0m477vOGnXUapBKXGHNJC2WCIELnYySRS100dfue+wjOloWnXbP/z4yFyufK4k7Tx6V7yyBrrwx49mlU4boop3/rS4lVnijHtjajbrO7ux3UcmVQfGQhGsEEPcsX0zO7I8kNmmptrRixdVhftdg9EUuHvFl6/PQn4rz6BVyTvS6Uyq4qjhEmL+pHayTufEIkX34BZ7hg/kYcXOuSGQilvZrIJX/z350sLNCmfdJTitaqOql931KAKZA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AS8PR03MB6887.eurprd03.prod.outlook.com
 (2603:10a6:20b:29f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:42:40 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 16:42:40 +0000
Message-ID:
 <VI0PR03MB1163408D3F34F247906D23DA4C0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 17:42:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] transport: rename negotiation_tips
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <401bdaff7c88e18204cb66feb6f8f895c26aedfa.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <401bdaff7c88e18204cb66feb6f8f895c26aedfa.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0294.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::7) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <3aa9ee05-3866-4e66-920e-d86ccd7b63e8@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AS8PR03MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aae8453-4922-4b67-6520-08deb4fc7988
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHqN2eQcSCpECO/IeCn63ddYTL7ermRxxzSMk/xGpe16zigOuqf5JLK3VuoMcVV2ihDI4WROCDY2cNGlKesPaI2R+NTS2mBm6yT+xdlTXsw7dcl87wLU/s/nlRODRAAhfIhxKslV6qhN7GMpCZz7S6T7CxWCqJiz2L3aRZG9iE7w0TyW4NuMNkOBmn031+40hdaroqghxQrcQe+OgNxiu6ghmUktR75HLu9oVpd932QjAIFNlrjygZE7lop4/33/NBc4NrGyB8NbGeIcXMDIIXpnMJqlxWsEkyIJU4+xVXijHDXV0LykHM5By3HeYH8kIoZ1GzRUNht0htzoXKAXCXI5mWb3W5FO4DwnrcX/3yCI9O3ka50SFezKrmcfk+alB4+AoQNF4EmeMynhG2RQfig51myDFXPZqVyHEqcWlOLMkqVZ2KICdwQv7k7ssmbayWpkB5nzwFqowAtntNvPqtAt13KFMaq1zn8mN9JzstqZswxtB98VZ/q3lN0sqEAk/YmsCamamrImRkbEutWBZ7yemSXSgyAnrB6c/imzQMgTkGT7jj/46rbvXfR8uqonpaDk/WtuB1Rh9wcqFM2VXvLmRb7xAsRxePAMuoZjJskcd15VCohf80fgwZFV92oZss89c6+RLfeILAbsbuAFV66zRW5xLe30erZupn7i14U6eOFbtIPacsgOqfEba7vJUh8T2XqUTTOX2MYXsiUdkyxVIahdyynxng=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|8060799015|19110799012|15080799012|51005399006|24021099003|6090799003|37011999003|41001999006|5072599009|440099028|3412199025|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWFZUTZjWlVMU0Z5NUl3NDh4L29qdndmU1JmdTgrNDR6YlZtaFhyVlY0V09a?=
 =?utf-8?B?dzdjRTRSL1A5VUpaZ3lYUlhrdWU1QUtCbDlIaDl2UjRFaTVySmd1ZWdnYXdn?=
 =?utf-8?B?QXEyZVpEK0dFM0xjdkpGckpsd3A4QWpNamFrd1FJTjlIOGRYL2JYVEpMYVNo?=
 =?utf-8?B?a2c1R1o2WCtFOC9BYmhmeEMvdUo5YmRuUDJmV20yUzdIc1U1UlUzanpkR3B2?=
 =?utf-8?B?V2RpQnQ3WDBEejZzL3hHQXhINWJDVTlrS2pJMHMxOXEzKzNLZWFHK2ZsUGFr?=
 =?utf-8?B?OVR6cUxnaFlqWE9qSEhacWxQVERrQzgvK0F4VGRDaTFjLzZnNFgxbTZaY0xY?=
 =?utf-8?B?UFR6ZXNSYnljNlp1M05nd3d4RjVkSUM2TkhPRXFUUHgvcnlHNEh5QTZvTlJJ?=
 =?utf-8?B?U2lsK2p4bjVOTW9zVE9SY2UxM1k2WFVvVUlGNzhPZG4vVUxMcTNac1FZd1Fq?=
 =?utf-8?B?VWhkQ3JIeVFxZFk3QXRTa3h1ZGd2QnhJUndUMS9XTHJPL3E2ZjY3NUhsTEo3?=
 =?utf-8?B?eFV3dURZUHhEVkMyTU9GemUzQXhnVklCaGJIeXBJRnNjU01JMHhRRFgweFdm?=
 =?utf-8?B?WkdXdEhoVU9UMHBvczJEZG1LWFpOY2srOG91bXg3NnQ0Yi8zNEZKZzV0endT?=
 =?utf-8?B?dEZEUUJscFR5b3huYTBDOTdDQjgvaGFDQi9McWNpL1V3S05tcDNNdjdLOTN0?=
 =?utf-8?B?K3J4SFNuYlNYd1hpUUZ2eWJOVGJnUnFyRGdLaFhXUytrQU1DSVJ2ZFlqaWxQ?=
 =?utf-8?B?YmMwdjJQcG05WFRyNWdjalhWZ2srSVpieFJ4V05SYzJKeWJ0K3hXay9rNnhh?=
 =?utf-8?B?dXY3aTVla1ptUytJREdWQVVvdHo2bXEyczc4NXVKRExwSUhaYVAvYlc1N2N4?=
 =?utf-8?B?c1RnTUJBZHpZaVM3d09ydWhUS0YwNEU1WDNNdlB6cDNFN3VGZ0w3Wi9vMFZv?=
 =?utf-8?B?Ym9HejFSOWgrMGoyQjUrMGJTNjVod3hNeWQzRkEreTBKcmp5RGhWdGlMcWxL?=
 =?utf-8?B?bzkrbnlwRzdMNjZlMk1wNE9NYm5GaTBuVzZvTzBKNkpaOGozUEdWYmhEYjYy?=
 =?utf-8?B?V2JrdTZxVUZqcnFXNWg5akJSZkpMOFdKTzYwMldLN2VnNlh6VTd5MXlxczBS?=
 =?utf-8?B?Wk81RThjMEpyVzdYQXUwdVg0Qy9jbWRnNVc4SjczSldpWERHYTBvTUdIWm9E?=
 =?utf-8?B?TEx5bTJRMHd2Q0dIMCtuaVhmeWRRR0xxLzJwWnNLQjk0L0RtZkZiRDVUYXBZ?=
 =?utf-8?B?em1hZmxOVnRGVFpKNHRmZmFFOXVWdEtyMTVDVDJVaGxFNW9Dem1iYmZUZFN0?=
 =?utf-8?B?bWdIQm5BQmVVZmIzQXA0M2htMlVGdHFXNEFrNVZrRlA2dFBaL3IyV0syalpE?=
 =?utf-8?B?Vll4d1dpOVFHQmZSWUY5NXdISjEvWEkvUXhkSXZMMGgvMjFkMmsyY1FaM0Mr?=
 =?utf-8?Q?9YaC/XUD?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVQwemwvZlhUOGhHTUxLK2sxQnNGdGpTR0dZcVJ2dyt5aDViR084czJBcE13?=
 =?utf-8?B?dnM0SGZFaFFHckRKWnV4UHR3d2x0dmVWQjRIQm11TmoyK3VDOU81VVh1WFl3?=
 =?utf-8?B?TDhqT252d2k3dTlZRDQ4cmxUbWt5MVdkY25vYk9oZ0pka09QaVp2RWJMaDdQ?=
 =?utf-8?B?U2x0SHdMRUpCTjdYMitNbVJPSFg0anB6V0hNWVc0YTBmTElZeUMzOWZMMHlm?=
 =?utf-8?B?SDFGV1A3d1NseUtXb29wWTlBWHZqajdvS2JkTmNrSTNqeWtxYlJDWlNDMEx0?=
 =?utf-8?B?VXJMRzJnQjFjVnNBUE80cE94aU1VK3NRelJPR0s0WmJERVEyWE9MdFRSVHFN?=
 =?utf-8?B?RnR1Qyt2Z0U3SmhOUXpDOERZaFlFTWROL1VJTll6VkllMUF4aU1YTzEvbkF0?=
 =?utf-8?B?a1c4QXdTU0NVWlRkeW9RME4xd2VSbGpMTlV2NG40dGJBd1dZUjJYS3pBeVBw?=
 =?utf-8?B?blJadGhPeHljdW9UK0h0eGd3NVB3d3FERDJvMHUxRGs3ZUo2akt4bnR0QXNU?=
 =?utf-8?B?dGgzZXFyUDJhQVVaOCtkQW5IRWZLRERjYmJsUGZNZERRd2VtaHF3MnBmMDNX?=
 =?utf-8?B?bzJTaFd4aHRuMWZjc3AxTEdpcmI4MEUzMUdCRDFxUGJueGovT1g2ZElnNUtY?=
 =?utf-8?B?RkZWNTVRVGZPdW1KN3dLNzk4WWtlNW05RW8yUmdFNUNIaTNRNG0vVVdQbTVC?=
 =?utf-8?B?NERuSEd1OExjT1M2aUUzVHd5VE9IVjRLdy90QjRZd3ZhUzhJd3NVSUVVbm1G?=
 =?utf-8?B?ejY2cyt3bzNJVEF3czZuTURkRW0zMUExOGJKUHE4NmxVZGhOL1ByV3V4QitN?=
 =?utf-8?B?NDBoZmFDUFVNRHlVeTIwL3IydFR0d3pWUDVDQUlnMXczbWY1NityS2w5L25t?=
 =?utf-8?B?aHVFM0hXS0pjL3RSeW9zbGFLN3ZCNkFydGFKNklPVWEyWWJPelIwWThBRkta?=
 =?utf-8?B?UG1ZOUdTcXBuZ3ovMGZkWmpIVXY4WXJBNHpKSTByaUlFMEZIYU54aW5zeVlv?=
 =?utf-8?B?VUFwUTJxWFAwTk9BTlVFVHFLbldMb0t4bWFZZGExNmtpU21OUmxhVlo0WVNV?=
 =?utf-8?B?KzBIUkxzQzVPQkhtSDB4bFJ4UVN6UUZWaG9HZGlqcGV4OXFNUjVZWXdpS0o5?=
 =?utf-8?B?VkVxSkZKMTlPWlBCTFYvNTFOcnJTM2lXQlRsRkI5OEp1RktTakJrT0VBSEp5?=
 =?utf-8?B?ZU5mM0FaTDJJZEgyZmtnV2dwTUZyc1lYdmFaeDI2VktKN1krTUl0MDhHQ0sy?=
 =?utf-8?B?K1ZwTVpVQzBpa1JwdzRjWkxDT1NZU3RIS0twMVh4bitaQlYwaUV1K1ZsVzZG?=
 =?utf-8?B?S0ZNQjR5SkxWQWJKQzRhUmJ5N0FNc3Z6M0h1MHZKc0owNmpCN29jZ3lOM0hG?=
 =?utf-8?B?aEQ0VkI1K0tTOWNNS3hnakRlN1loVktTbnFlY3ZIdjRzMUQwa0hOK0hpUlZz?=
 =?utf-8?B?Uk9sa2h1RW5LazFVWjJOOThXZVAxNGszY1d3Q3dxcGNWQlZBT21reGxIUlJq?=
 =?utf-8?B?WmtLWkpnbXovTXllUUZ2NDh0R3BRVGFETGNJT3FCRTR6RURxMGVkUmRydXov?=
 =?utf-8?B?MkxEWVdsdDN2RVNyYnNVVFZBbVFrR2N3MU5vRXpISy9TbFcyeVYxUTdRMkVN?=
 =?utf-8?B?SGFqNkVGaUxWQ1FWNmtScnljeVBBM1o4SXM4L2NTTHJVcVIzQnlocndpMW9a?=
 =?utf-8?B?NXlTcG1WNDZ2R2FJbE8zZEV4RUdTM0toK1Btc2ZkMG5HR2FvM2dyQ3FvNWkx?=
 =?utf-8?B?Yms5RkVXMnFIQ09qUEVoMmkydUxyYXZ4ZWVyYU1ibCtEQWtGQy94TUtiZnVL?=
 =?utf-8?B?N21Zai9zMFdpVmNHOHBNbExhZXJWRU1tMEJYZXZtQjlvbXljSU9zOWQzS0ZV?=
 =?utf-8?Q?vYXAftmYx7uMF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aae8453-4922-4b67-6520-08deb4fc7988
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:42:39.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6887

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> The previous change added the --negotiation-restrict synonym for the
> --negotiation-tip option for 'git fetch'. In anticipation of adding a new
> option that behaves similarly but with distinct changes to its behavior,
> rename the internal representation of this data from 'negotiation_tips' to
> 'negotiation_restrict_tips'.

The typo (plural vs singular 'tips') is fixed - thanks!

> The 'tips' part is kept because this is an oid_array in the transport layer.
> This requires the builtin to handle parsing refs into collections of oids so
> the transport layer can handle this cleaner form of the data.
> 
> Also update the string_list used to store the inputs from command-line
> options.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   builtin/fetch.c    | 18 +++++++++---------
>   fetch-pack.c       | 18 +++++++++---------
>   fetch-pack.h       |  4 ++--
>   transport-helper.c |  2 +-
>   transport.c        | 10 +++++-----
>   transport.h        |  4 ++--
>   6 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fc950fe35b..2ba0051d52 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -98,7 +98,7 @@ static struct transport *gtransport;
>   static struct transport *gsecondary;
>   static struct refspec refmap = REFSPEC_INIT_FETCH;
>   static struct string_list server_options = STRING_LIST_INIT_DUP;
> -static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
> +static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
>   
>   struct fetch_config {
>   	enum display_format display_format;
> @@ -1534,13 +1534,13 @@ static int add_oid(const struct reference *ref, void *cb_data)
>   	return 0;
>   }
>   
> -static void add_negotiation_tips(struct git_transport_options *smart_options)
> +static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
>   {
>   	struct oid_array *oids = xcalloc(1, sizeof(*oids));
>   	int i;
>   
> -	for (i = 0; i < negotiation_tip.nr; i++) {
> -		const char *s = negotiation_tip.items[i].string;
> +	for (i = 0; i < negotiation_restrict.nr; i++) {
> +		const char *s = negotiation_restrict.items[i].string;
>   		struct refs_for_each_ref_options opts = {
>   			.pattern = s,
>   		};
> @@ -1561,7 +1561,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
>   			warning(_("ignoring %s=%s because it does not match any refs"),
>   				"--negotiation-restrict", s);
>   	}
> -	smart_options->negotiation_tips = oids;
> +	smart_options->negotiation_restrict_tips = oids;
>   }

Same as in v3, this function will be refactored in a later patch, so
just doing the rename now keeps things reviewable - thanks!

>   static struct transport *prepare_transport(struct remote *remote, int deepen,
> @@ -1595,9 +1595,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
>   		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
>   	}
> -	if (negotiation_tip.nr) {
> +	if (negotiation_restrict.nr) {
>   		if (transport->smart_options)
> -			add_negotiation_tips(transport->smart_options);
> +			add_negotiation_restrict_tips(transport->smart_options);
>   		else
>   			warning(_("ignoring %s because the protocol does not support it"),
>   				"--negotiation-restrict");
> @@ -2566,7 +2566,7 @@ int cmd_fetch(int argc,
>   			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
>   		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
>   		OPT_IPVERSION(&family),
> -		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
>   				N_("report that we have only objects reachable from this object")),
>   		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
>   		OPT_BOOL(0, "negotiate-only", &negotiate_only,
> @@ -2658,7 +2658,7 @@ int cmd_fetch(int argc,
>   		config.display_format = DISPLAY_FORMAT_PORCELAIN;
>   	}
>   
> -	if (negotiate_only && !negotiation_tip.nr)
> +	if (negotiate_only && !negotiation_restrict.nr)
>   		die(_("%s needs one or more %s"), "--negotiate-only",
>   		    "--negotiation-restrict=*");

Simple rename - looks good!

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6ecd468ef7..baf239adf9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -291,21 +291,21 @@ static int next_flush(int stateless_rpc, int count)
>   }
>   
>   static void mark_tips(struct fetch_negotiator *negotiator,
> -		      const struct oid_array *negotiation_tips)
> +		      const struct oid_array *negotiation_restrict_tips)
>   {
>   	struct refs_for_each_ref_options opts = {
>   		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
>   	};
>   	int i;
>   
> -	if (!negotiation_tips) {
> +	if (!negotiation_restrict_tips) {
>   		refs_for_each_ref_ext(get_main_ref_store(the_repository),
>   				      rev_list_insert_ref_oid, negotiator, &opts);
>   		return;
>   	}
>   
> -	for (i = 0; i < negotiation_tips->nr; i++)
> -		rev_list_insert_ref(negotiator, &negotiation_tips->oid[i]);
> +	for (i = 0; i < negotiation_restrict_tips->nr; i++)
> +		rev_list_insert_ref(negotiator, &negotiation_restrict_tips->oid[i]);
>   	return;
>   }
>   
> @@ -355,7 +355,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>   			   PACKET_READ_CHOMP_NEWLINE |
>   			   PACKET_READ_DIE_ON_ERR_PACKET);
>   
> -	mark_tips(negotiator, args->negotiation_tips);
> +	mark_tips(negotiator, args->negotiation_restrict_tips);
>   	for_each_cached_alternate(negotiator, insert_one_alternate_object);
>   
>   	fetching = 0;
> @@ -1728,7 +1728,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>   			else
>   				state = FETCH_SEND_REQUEST;
>   
> -			mark_tips(negotiator, args->negotiation_tips);
> +			mark_tips(negotiator, args->negotiation_restrict_tips);
>   			for_each_cached_alternate(negotiator,
>   						  insert_one_alternate_object);
>   			break;
> @@ -2177,7 +2177,7 @@ static void clear_common_flag(struct oidset *s)
>   	}
>   }
>   
> -void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   			   const struct string_list *server_options,
>   			   int stateless_rpc,
>   			   int fd[],
> @@ -2195,13 +2195,13 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
>   	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
>   
>   	fetch_negotiator_init(the_repository, &negotiator);
> -	mark_tips(&negotiator, negotiation_tips);
> +	mark_tips(&negotiator, negotiation_restrict_tips);
>   
>   	packet_reader_init(&reader, fd[0], NULL, 0,
>   			   PACKET_READ_CHOMP_NEWLINE |
>   			   PACKET_READ_DIE_ON_ERR_PACKET);
>   
> -	oid_array_for_each((struct oid_array *) negotiation_tips,
> +	oid_array_for_each((struct oid_array *) negotiation_restrict_tips,
>   			   add_to_object_array,
>   			   &nt_object_array);
>   
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 9d3470366f..6c70c942c2 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -21,7 +21,7 @@ struct fetch_pack_args {
>   	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
>   	 * lines only with these tips and their ancestors.
>   	 */
> -	const struct oid_array *negotiation_tips;
> +	const struct oid_array *negotiation_restrict_tips;
>   
>   	unsigned deepen_relative:1;
>   	unsigned quiet:1;
> @@ -89,7 +89,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>    * In the capability advertisement that has happened prior to invoking this
>    * function, the "wait-for-done" capability must be present.
>    */
> -void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   			   const struct string_list *server_options,
>   			   int stateless_rpc,
>   			   int fd[],
> diff --git a/transport-helper.c b/transport-helper.c
> index dd78d40668..f4388da766 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -754,7 +754,7 @@ static int fetch_refs(struct transport *transport,
>   		set_helper_option(transport, "filter", spec);
>   	}
>   
> -	if (data->transport_options.negotiation_tips)
> +	if (data->transport_options.negotiation_restrict_tips)
>   		warning(_("ignoring %s because the protocol does not support it."),
>   			"--negotiation-restrict");
>   
> diff --git a/transport.c b/transport.c
> index 107f4fa5dc..a3051f6733 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -463,7 +463,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>   	args.refetch = data->options.refetch;
>   	args.stateless_rpc = transport->stateless_rpc;
>   	args.server_options = transport->server_options;
> -	args.negotiation_tips = data->options.negotiation_tips;
> +	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
>   	args.reject_shallow_remote = transport->smart_options->reject_shallow;
>   
>   	if (!data->finished_handshake) {
> @@ -491,7 +491,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>   			warning(_("server does not support wait-for-done"));
>   			ret = -1;
>   		} else {
> -			negotiate_using_fetch(data->options.negotiation_tips,
> +			negotiate_using_fetch(data->options.negotiation_restrict_tips,
>   					      transport->server_options,
>   					      transport->stateless_rpc,
>   					      data->fd,
> @@ -979,9 +979,9 @@ static int disconnect_git(struct transport *transport)
>   		finish_connect(data->conn);
>   	}
>   
> -	if (data->options.negotiation_tips) {
> -		oid_array_clear(data->options.negotiation_tips);
> -		free(data->options.negotiation_tips);
> +	if (data->options.negotiation_restrict_tips) {
> +		oid_array_clear(data->options.negotiation_restrict_tips);
> +		free(data->options.negotiation_restrict_tips);
>   	}
>   	list_objects_filter_release(&data->options.filter_options);
>   	oid_array_clear(&data->extra_have);
> diff --git a/transport.h b/transport.h
> index 892f19454a..cdeb33c16f 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -40,13 +40,13 @@ struct git_transport_options {
>   
>   	/*
>   	 * This is only used during fetch. See the documentation of
> -	 * negotiation_tips in struct fetch_pack_args.
> +	 * negotiation_restrict_tips in struct fetch_pack_args.
>   	 *
>   	 * This field is only supported by transports that support connect or
>   	 * stateless_connect. Set this field directly instead of using
>   	 * transport_set_option().
>   	 */
> -	struct oid_array *negotiation_tips;
> +	struct oid_array *negotiation_restrict_tips;
>   
>   	/*
>   	 * If allocated, whenever transport_fetch_refs() is called, add known

All just simple renames - looks good to me! This patch is good.

Thanks,
Matthew


