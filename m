Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011036.outbound.protection.outlook.com [52.103.33.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99D382390
	for <git@vger.kernel.org>; Mon, 18 May 2026 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124887; cv=fail; b=po2G+yisyVceLuikJ4NEfS900WQafI4muU5YfCPBxstEqUEaz8z9JOXLFl35UdLx8AC/uf6tOJNW5SJyQGddxAA/EnseFckr5EhtaWpYuNneElh+vWkQiCoW+0uNCpgAaF5GFfzU/3Ku5FZdH5mHl3wwRSys5nAVvJIVphadfg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124887; c=relaxed/simple;
	bh=Y9+ZSL5HEDDWoQbXEXWstqEABOkQjuD6kgaijZEWUJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qb/iiJ+3FL95eVA6vVDtvWzbre88EeNA9Yn/iW7bw0TGK6R2X0YzmsWBkmNZi4yBS2YIzSXNK3PtyFepN7BuCsjm5sBnIq+eY3RaMp8TJdAf6TZvXEB0965KULEHHIJ8/CS2Lr4wWaAQf0gM6AlqKIynI4Oac1fDLY1e2b5aKj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C599DNSl; arc=fail smtp.client-ip=52.103.33.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C599DNSl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT1MW67LHn5hjzXEjEEV7mEPBjidomV3Memw7ok34L9XsVCXVQiLOU/zfamxKw7UvX3Kzw6POpqc7Nv+Q6mn1mpPDcu9/GWPCo3earWjLhJw4ZdyZR2rRe+0Oo/wtpxLKwMjpXG++TTiS9Z1QEipT6Ch5/lkSSs+yizOMowWe/en7WqCrUyIweqGvp8/qNfmelJhtssD+wXQxf0yeiq30JnX2TJLNtYW/ZyZo4ztl0g5l8ooWYyPQx/GXajSkFkaw0oDI/r4ODruB3LD/WH0Q0LSkwiMC8thaWuvV+WqW9wewuutW8dlP9fYAF7nDeKr8tTIQwdDSznfGFdCwiXjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t5Nh6KtbmfSo5xFT/FnKAUEDsnyYNOzrAQsVzLS7es=;
 b=Fayt7rtGyOQF/g9TfU2e5qliOFswAvX4uCgNbEOovjb8ZktYC7OzAjHhe8gOPRjn3zlz7czp2Mh98W9fkFFiFkgVTQip4XAv4GfLRZM7pt6cZl9mkv/MjR22QhEJsF2Y23aeNQ4ut3S5Sppi2YkvcA/8PxXo5KvOlo5TYSiY1V4rip/rYVe/PKHkT216FyzRqBTuCjCCHbTAy0azd7Mgx/p6Al+jKAaNOEKnJpJb9562H7ltpf/csT7iF7CAz90jygcrBXPgp47fyN5kpQ0ZDVYvbPIsC3KLdtJS9EvHdb6pnoR5ersDebjHxpg3ktwJnzl9hvS7w/52SR82ytq9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t5Nh6KtbmfSo5xFT/FnKAUEDsnyYNOzrAQsVzLS7es=;
 b=C599DNSl4KhJVITwp7jk8K06chrmoGSqWK0j1JRQvWo2xsHV6xaJ8eQkY/93YYdOCx2DJRZ9CVjEHOxklMYk5xS+yWYGtoCkDfhXaw/TchYRrR4FgtN1QD+xoFLxQjK48vyJy8T25Q6Gwy4eeQW1gGmoBXeeIu3+jEhaluMXOEQFG7rLKCqxzyQvnA9bMGmP8o30ha1henp0pFCXMVWvumT+iRYaXAscVd3BTDG9KqkKf8TOmfpm7C2tCdQNmyzRe4M38F1LSX3YyE/Z7Xicgzge/eVKwJQu+BOXI9StDARIe/6EGFrZnwHFKgMvNj187caq6bYGclye5RlJE3YYkA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by PAXPR03MB7530.eurprd03.prod.outlook.com
 (2603:10a6:102:1d9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 17:21:22 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 17:21:22 +0000
Message-ID:
 <VI0PR03MB1163480420F58717AE201B2F8C0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 18:21:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] send-pack: pass negotiation config in push
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <5b968245ebaf14c05233195f5c806c4e94fd3ff7.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <5b968245ebaf14c05233195f5c806c4e94fd3ff7.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0014.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::20) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <5b3ec0f0-3996-4d55-98b1-064467a7bc86@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|PAXPR03MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 0503fa6a-334c-4641-d06e-08deb501e218
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHqN2eQcSCpECO/IeCn63ddYTL7ermRxxyvUl3UOrhHtOaozGFh3UbwMu5F6z1kauxf3BU9MkSa5h0ucDJYrb90dZAgRr2v+kCb7fBRaIl/cugje4PCa0DSyVy5WMlS7XwkiDn3+ZlfbERBxayB1U9xKeGdj6zKapW1JH+O4+xVs9VqjaazouS4gvfVquExpxO1VW2ENYHpjrNl/wuJWYePg9Ubv/DG+cOEKk38TifEg3TV2HCknifftUeoWoVdKiMQQPWzK8SEQiN7Nt5PjxE00WzaHQ8aUgp1A5qJkG/kEdkq5YDNyAkqIyBRwuEywRwmYPR7Z6EmzZwuGXvxesDRCvqzrLHMHWjI3XvNU2EzXixLe+mW4pTU844DkPyF0pqbS3Gh9JgTnDI5SXSsYRYP7mbE4coBtzOMHD0M5qqUE56rydc4jkeNeu9uGvDtac0AtUZPRs6GjQP/tgABkUzPwjyzUEJTXvYgxPuOr9pzLfF6z5UHv3TBDKcPEYQHFeBF1X4c4VBy/5JBSZwcNh+/6nKEF+11/VOn4CSrv+Z8GyW11nQJJME1Q1fZ8HpQ3vfk9N53cHVwc208N4mmzxWYdAkEKBSquQjXFpFsAWEm3rt8CFuCuJVJFhHR1N5X0v3x/90BZlqqoj/pkw/2upSi5oJU4WN1+zLLfADwwQb4D6dMhQVOFCsrRLR13VkrxqkvY+aHIZvlwfiRImrSCIYIPvh3GCLqVSk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|15080799012|41001999006|5072599009|6090799003|37011999003|23021999003|19110799012|8060799015|19061999003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjhocWFMbUtJTm9QR3c2Z2pGNURTREV6aVcxRUFwREhIQ1JGeFZ4R0hKMUtI?=
 =?utf-8?B?cmdBZlNxZ0I4N09yN0lzelN0aGdpZzlQZUtIc0h3OThwdUd5ZThOaVZ4S1pU?=
 =?utf-8?B?MjRubk5hM1VPMUM1TkgvaE5RQVJJSUQxMHZ3MHV3UVE2ZVdOQ3l4ZXJkb1BC?=
 =?utf-8?B?R3ZCTWFuQlpjMy9hSVFKYlNZN0tqSzZRZnJGRHZIbTA4SHpHZDhoKzBBamhh?=
 =?utf-8?B?Q3FPVWR4eGFzNUtUdFcrd0tab1JSamprUlNRQ0tGQUxGR2tVTjZnM2ZETGY5?=
 =?utf-8?B?bm1aSTNxd1VRYnJkOFJLejBDUVltNjF1cWFhK0ordXhBaVFtczBzTDBnclcx?=
 =?utf-8?B?NE8xbUppM0lRdWZiS1lJa2hKKzllMWN1VzFZVkthK1ZWaWNvWGFZVzI0bzR3?=
 =?utf-8?B?bEZQYWxJM3Z6dWxUYm1oM0diTytHQjVmbEMyRXBWM2wrcnhQQ3hhai85Nkg2?=
 =?utf-8?B?RkhNbDJldXJZc0NsMTRMMHhlZ1BVa2FpRG43WXdMUHJYaTlORkkrMGljMitT?=
 =?utf-8?B?VGhmU0dKMDd1UHdRYmwzUlV3WU1jTjJKbW5sY01NdDRweGxnQ2J5UmJ5N3Q2?=
 =?utf-8?B?UTBTRkZ1NmNMeTNFeW4zTzRVTlVOVTFodDZIMWZHN2tMN2RpSzJGSWlJb3Iw?=
 =?utf-8?B?QlFRSTgycmhaY09Ga1JaYkpET1JCdGRoTTFvODVRUFROb0NKM1pnQmYvY3hX?=
 =?utf-8?B?aXB2Q0lFN2hnUXRzdHFIc2FmWmxtSkdDZ2JORCtBQ3Fod09LbnUyS2puVTFv?=
 =?utf-8?B?WFowMTVzYm1yRGNacElJZlFFKy9ZUTdhQ0UvcFFQRktzd1ZVeldsMWtpV2w1?=
 =?utf-8?B?Wk0xdGpDL041b2c4em4rbTNtQjVucG44TWQ0c2kzUzRHU0h4cDZ6K0x1U2x2?=
 =?utf-8?B?dWY4L01OdzRMSHkwTEVFTWhIU1NmZ2hLRnZkK3J1TEk3WHp0MkpSWVhOcjRJ?=
 =?utf-8?B?eXdQK0ZOWklrVjZFM1d1a2Z1Z2x5cHZNeDd2bHVMbUo5Q3lBdlFIUXVBN3pK?=
 =?utf-8?B?bkZ6Z3BvM25mcFUweGhJQTQxQkRUUzBTYU1GWUF3RVQ4VzF1cEhpTmJsZUo3?=
 =?utf-8?B?VXhnSjd4R0llRk9tWml0RzE2YmdtVDZmWmgrYlFVMUxlZ2ZSOVB5UDlYVjZV?=
 =?utf-8?B?UTFCWWRHWlRlS1RaK0Y3Q0JqT2VuUS9UOVdQblNQWFBGRkZkVzFUek9EV0FC?=
 =?utf-8?B?SVpCTmpoUmo5K2xCVk5aaWdtZVV3NWJmMmNManlJMmFDV09SYW82UzBHTFho?=
 =?utf-8?B?UytSZExoOXV6VG5hK3hEVCtyT3J2STFqOC85SUZXUFZycHdRM1Z5MWFHNlZY?=
 =?utf-8?B?UEJOWFQ0b0gwOUxtTGUvYm1yWUc1a3czTGVEOS9NUGJ2UTNqbC9DWC9UcGUr?=
 =?utf-8?B?WHIzaXlTNEFjSkpId2k0UjVxZmpLQ1IzQnZkb09BbWsrUHU1N2paSU1oQlJ0?=
 =?utf-8?Q?ijVme/p4?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW91azlNSVJoNDVsd3BhUUVIeGUyNmxlTEo1VmpYcE5PM1FJTjhNT0w1YStz?=
 =?utf-8?B?M3FJUzhHcnlDT2N6VWxva3JHYzZQMDB4b0F3SzBXeHQ4Sy9XQU9HRDFIYjFU?=
 =?utf-8?B?ay9oSGI5c3RJaVQxekVTYnNhdnd5ZU03UkJybGlNWVhmbFUwNk5LMzhIaTJP?=
 =?utf-8?B?MjFFRlJCZ2NyQ2k4Nmw2b0dUcEFzMi9GR0FtMmFlaU1FTU1rVFNoMU14NDJK?=
 =?utf-8?B?ZnB3T0pLSDZIL2ZJdDVUQ2dVaXhkdjE1eXlpdGxHcVhRTStvVmZuRVl0b2lR?=
 =?utf-8?B?ZHJoa011Q0ZLTDF6V1d3ZW9lZXhMTjdaZWFVSUdoUUpmaXJBYmpmQW9wd1Jh?=
 =?utf-8?B?NjdGb2UyYXl0aWgvUU5SZkdPUElFZ0hURDc0Q3I0Q1JIaWtsKzY0dnBIVGpZ?=
 =?utf-8?B?UnZCdFFLLzBiTmQ5RHczem0zMllHcjMwNSsxdFpKTnF1M0hISXhtaXA2Z21R?=
 =?utf-8?B?RVZOUjloaXF2YW90RVFkZU92anA3d1ZBa3N4aVF5Uzg1QmxYWm5GQXF6U1Zo?=
 =?utf-8?B?Sys4cXZLNTUwTVkzcEYwL3RTMEZ5U0cvQ1FCWXVkMnQwbmNTeHArMG9oTHFz?=
 =?utf-8?B?dUkyMERxNjV2MkFRWGh6QXRoSVNkelZzSllSbFdxL3d3YWxmbFNjSmpyQ1NM?=
 =?utf-8?B?VnFLMHl1WDNDZUFrQUNRK1V5YUFZR1BtNXNPelczNkQ1UlVyTC92Ni85NDdl?=
 =?utf-8?B?VStIWjNqczBKRm91aXJ5UlpUSGJ3ak9EdW1qb1EwckVzdHZxWTdkaWFaOGVv?=
 =?utf-8?B?YytBQnhsdjJxeVhWaDM0V09mZU8zNWdjNkw0TEROd1IzT3c3K2U5NG13SS9F?=
 =?utf-8?B?ckVPYUVsZDRJaDFWK2dDQ1MxZC9rczhXczdhbmIxS0prNDJqWEVtZFRhZGph?=
 =?utf-8?B?cDlCZ1ZLNVBYMFRUN21QbWMycXhTQ2lKZzhxZklGTDRCMDZodzV3VW91NUV5?=
 =?utf-8?B?ZFJhbWpkRnZKY2cyRVhRNmo1K3lZSVExTmsvL01ZTkM5czR3ZWs2STJEajJL?=
 =?utf-8?B?UDJmVm1zQnVWZlJNNmw1RElMbFI5UGJRU2RjWmllK2ZvaTBRVXZ2SVcvTHU2?=
 =?utf-8?B?Sk9EOEZ0Z3FLbk9uZTQ4Ly9xUGRFSU02TVpKS0orYmprOXUwMTFVNTBtaDJU?=
 =?utf-8?B?TUxQUDJldnpGWTAvVUhOU1ViT3NWeGowM205cjJsa0VURC9XZkduNGxkbEZI?=
 =?utf-8?B?QTZlQUltajF4MFE4M2xaSXpKdGZTVkdzWGxNUHFVSWluV3pENGFLOGUvMzRX?=
 =?utf-8?B?MGI2UkVkZ2JoVmtjUW9ScC9GMmFhSGl2RlpPVUtURnhYTWlYVHZSR3lMLzV5?=
 =?utf-8?B?dzRMbnUraWNaNHl3bGEvM2d5VVBZaWlvSHYvZmw5eVRBdmFuNDRZUHFyQlIw?=
 =?utf-8?B?cC96a3FteWNkekFNYUpWbDBRUUQ2Tis0bXFDck9FcWZOaFhUUERDVFNWQXcy?=
 =?utf-8?B?ajlsTFQzdE5vQm1kbk1rdWJVTXRmekJyeWhJYkNaZVVabTExaytlc1p1K2gz?=
 =?utf-8?B?VzltUU9pT1ZEVm5wWE9VbXFZR3lORy9IdVpyWVNXRDgvblFRak1uWHk4MkI4?=
 =?utf-8?B?ZXc5RjRMQUNsSDhYeWRXTmVnZXVhQzVNWVBkOUppWHo0b2ZJUlprTGVKdHZ0?=
 =?utf-8?B?NVdleUl6NldweGszOW5FVzlraTR2VlQxVlRGNjc3YWd4OEN4TGIvU0VmK1dn?=
 =?utf-8?B?YzNvSTBrRXJ5WXRsbUtiSUJyd1Zrc3pBL29Ha25iNHYzMm5LY1R6Q0JFOG1E?=
 =?utf-8?B?akdQY21nOU1lL0hFdk1jUnI1ZWJIMHVGUVhLZVlEZlRXTjZQVW9PSzN0ZDBB?=
 =?utf-8?B?QTM1NDhxcHh4TURCRWZUbFFpRnZabE5PSC9jZkV0d0xxdUJVVk0rZzU0OW1m?=
 =?utf-8?Q?hYi2TxaxufO3N?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0503fa6a-334c-4641-d06e-08deb501e218
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:21:22.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7530

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> When push.negotiate is enabled, 'git push' spawns a child 'git fetch
> --negotiate-only' process to find common commits.  Pass
> --negotiation-include and --negotiation-restrict options from the
> 'remote.<name>.negotiationInclude' and
> 'remote.<name>.negotiationRestrict' config keys to this child process.
> 
> When negotiationRestrict is configured, it replaces the default
> behavior of using all remote refs as negotiation tips. This allows
> the user to control which local refs are used for push negotiation.
> 
> When negotiationInclude is configured, the specified ref patterns
> are passed as --negotiation-include to ensure their tips are always
> sent as 'have' lines during push negotiation.
> 
> This change also updates the use of --negotiation-tip into
> --negotiation-restrict now that the new synonym exists.

Is this paragraph stale? Didn't we rename the option in patch 2?

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/config/remote.adoc |  6 ++++++
>   send-pack.c                      | 37 ++++++++++++++++++++++++++------
>   send-pack.h                      |  2 ++
>   t/t5516-fetch-push.sh            | 30 ++++++++++++++++++++++++++
>   transport.c                      |  2 ++
>   5 files changed, 70 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index 9ae20e4379..460b4e7952 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -122,6 +122,9 @@ command-line option.  If `--negotiation-restrict` (or its synonym
>   `--negotiation-tip`) is specified on the command line, then the config
>   values are not used.
>   +
> +These values also influence negotiation during `git push` if
> +`push.negotiate` is enabled.
> ++
>   Blank values signal to ignore all previous values, allowing a reset of
>   the list from broader config scenarios.
>   

Nice. We're now only mentioning `git push` behaviour once we've wired
it up in this patch.

> @@ -149,6 +152,9 @@ unconditionally on top of those heuristically selected commits.  This
>   option is also used during push negotiation when `push.negotiate` is
>   enabled.
>   +
> +These values also influence negotiation during `git push` if
> +`push.negotiate` is enabled.
> ++
>   Blank values signal to ignore all previous values, allowing a reset of
>   the list from broader config scenarios.
>   
> diff --git a/send-pack.c b/send-pack.c
> index 3d5d36ba3b..d18e030ce8 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -433,28 +433,48 @@ static void reject_invalid_nonce(const char *nonce, int len)
>   
>   static void get_commons_through_negotiation(struct repository *r,
>   					    const char *url,
> +					    const struct string_list *negotiation_include,
> +					    const struct string_list *negotiation_restrict,
>   					    const struct ref *remote_refs,
>   					    struct oid_array *commons)
>   {
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	const struct ref *ref;
>   	int len = r->hash_algo->hexsz + 1; /* hash + NL */
> -	int nr_negotiation_tip = 0;
> +	int nr_negotiation = 0;
>   
>   	child.git_cmd = 1;
>   	child.no_stdin = 1;
>   	child.out = -1;
>   	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> -	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!is_null_oid(&ref->new_oid)) {
> +
> +	if (negotiation_restrict && negotiation_restrict->nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, negotiation_restrict)
>   			strvec_pushf(&child.args, "--negotiation-restrict=%s",
> -				     oid_to_hex(&ref->new_oid));
> -			nr_negotiation_tip++;
> +				     item->string);
> +		nr_negotiation = negotiation_restrict->nr;
> +	} else {
> +		for (ref = remote_refs; ref; ref = ref->next) {
> +			if (!is_null_oid(&ref->new_oid)) {
> +				strvec_pushf(&child.args, "--negotiation-restrict=%s",
> +					     oid_to_hex(&ref->new_oid));
> +				nr_negotiation++;
> +			}
>   		}
>   	}
> +
> +	if (negotiation_include && negotiation_include->nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, negotiation_include)
> +			strvec_pushf(&child.args, "--negotiation-include=%s",
> +				     item->string);
> +		nr_negotiation += negotiation_include->nr;
> +	}
> +
>   	strvec_push(&child.args, url);
>   
> -	if (!nr_negotiation_tip) {
> +	if (!nr_negotiation) {
>   		child_process_clear(&child);
>   		return;
>   	}
> @@ -528,7 +548,10 @@ int send_pack(struct repository *r,
>   	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
>   	if (push_negotiate) {
>   		trace2_region_enter("send_pack", "push_negotiate", r);
> -		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
> +		get_commons_through_negotiation(r, args->url,
> +					       args->negotiation_include,
> +					       args->negotiation_restrict,
> +					       remote_refs, &commons);
>   		trace2_region_leave("send_pack", "push_negotiate", r);
>   	}
>   
> diff --git a/send-pack.h b/send-pack.h
> index c5ded2d200..13850c98bb 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -18,6 +18,8 @@ struct repository;
>   
>   struct send_pack_args {
>   	const char *url;
> +	const struct string_list *negotiation_include;
> +	const struct string_list *negotiation_restrict;
>   	unsigned verbose:1,
>   		quiet:1,
>   		porcelain:1,
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index ac8447f21e..177cbc6c75 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -254,6 +254,36 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
>   	! grep "Fetching submodule" err
>   '
>   
> +test_expect_success 'push with negotiation and remote.<name>.negotiationInclude' '
> +	test_when_finished rm -rf negotiation_include &&
> +	mk_empty negotiation_include &&
> +	git push negotiation_include $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C negotiation_include unrelated_commit &&
> +	git -C negotiation_include config receive.hideRefs refs/remotes/origin/first_commit &&
> +	test_when_finished "rm event" &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" \
> +		git -c protocol.version=2 -c push.negotiate=1 \
> +		-c remote.negotiation_include.negotiationInclude=refs/heads/main \
> +		push negotiation_include refs/heads/main:refs/remotes/origin/main &&
> +	test_grep \"key\":\"total_rounds\" event &&
> +	grep_wrote 2 event # 1 commit, 1 tree
> +'
> +
> +test_expect_success 'push with negotiation and remote.<name>.negotiationRestrict' '
> +	test_when_finished rm -rf negotiation_restrict &&
> +	mk_empty negotiation_restrict &&
> +	git push negotiation_restrict $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C negotiation_restrict unrelated_commit &&
> +	git -C negotiation_restrict config receive.hideRefs refs/remotes/origin/first_commit &&
> +	test_when_finished "rm event" &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" \
> +		git -c protocol.version=2 -c push.negotiate=1 \
> +		-c remote.negotiation_restrict.negotiationRestrict=refs/heads/main \
> +		push negotiation_restrict refs/heads/main:refs/remotes/origin/main &&
> +	test_grep \"key\":\"total_rounds\" event &&
> +	grep_wrote 2 event # 1 commit, 1 tree
> +'
> +
>   test_expect_success 'push without wildcard' '
>   	mk_empty testrepo &&
>   
> diff --git a/transport.c b/transport.c
> index fa54928966..a2d8958cb8 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -921,6 +921,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>   	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
>   	args.push_options = transport->push_options;
>   	args.url = transport->url;
> +	args.negotiation_include = &transport->remote->negotiation_include;
> +	args.negotiation_restrict = &transport->remote->negotiation_restrict;
>   
>   	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
>   		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;

Again v4 of this patch LGTM.

Thanks,
Matthew

