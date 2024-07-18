Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2093.outbound.protection.outlook.com [40.107.101.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3443172
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332777; cv=fail; b=iTr4/4TquyShu6HFGzLsMlyAyMljx07eQe5TIQhzp+GiUiKlvfW0CSeOTp80h3JGh4WMfS41gn19T/WyYgGE1DOlsB7+MJ3JRCVG2OaXo6u30uh4Pv277Ri/afV+J44gmVj59cf8LWFPPXjJa2c33nwY8YHbHHstNVWELpIel6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332777; c=relaxed/simple;
	bh=TsrPpLiJpAF2BkctnjE243b/yZnXF+M6Q0YjcwNm2UI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=euMLUzVzi/bLpvwCNtkyaRSUlZu9vdLGnkJ14qW67bTU3fH0RTLTXLFZCNUBYiTtABJfoQLXETSJxE96SxEcojZ00hxsDQjNwfKGPInENvlJSvGdeF/mNWjeghtbrlW9LRvfYV5Fbgsb+ZTyqOvFtJOAIk08Fh6E0BkiHjQSagA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comqi.com; spf=pass smtp.mailfrom=comqi.com; dkim=pass (2048-bit key) header.d=comqi.com header.i=@comqi.com header.b=o0D748/o; arc=fail smtp.client-ip=40.107.101.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comqi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comqi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=comqi.com header.i=@comqi.com header.b="o0D748/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G71XACqCM8Di/IuF9qfvAiDoePgGEwsD+uD2S/wvi5Agnv1Z9fFmE5ZPvrElV/cV9Oo4yT6elKABnCohGkyZ/QPp43KDjGuM8yyPuFMESxXaMEHbfDcdFYIdJDvrLHHJtJLqiquwsGXhB3AI6RzxOFTsafg/BcAcCje5QbI9EIJNuhpDzKu/xmrLfE+FF8IMehIvkG4aQZCDthgMTG/iVemzxN4aBanD/YGrczGdxwUUS+y9+DWW+jdwtiYY5FwZekoyI1WcZoeZO1xLMspwHA0h+rmsFPA6VP6j9Kf1+G0qMwzi7zj/nsbz3o1+BrNMqBj+ak9ncAqBBQBZlwY6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmjnOYNi+OOaLuoUrMZaxyo4PpwzMRIJfnUWLQN63ME=;
 b=dcUsShS+usA1KkSYvjNgkxmyb6vWTOo121OnOayOnB5d3O/4a4pqyKkRJv8vcsuCf+EnClbz+mNsBOu5Cm956xTp7srdcfJplit5ZwF4h5PE4mohFW+05/X6aUhB0ycwxFZjNNv2uGmV52Mt+QsZ4IgvkDOOgHElV+7WKZyD7TWuwapncJMVz7dVJXNtRCRdGZSlf6Cyj5Dd610hEBMjJJCoAgzOIJbnUBX+fG8Xkuc5vbYntGCxJ4rGftBOzrqtYlnkSfkN2aee7mZJaieBp4lWKPSVflXGyl8k1LR2Bwai5jRNkX7LPSa2O9zJkLkvruzm45KdQ640PGGuq3brOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=comqi.com; dmarc=pass action=none header.from=comqi.com;
 dkim=pass header.d=comqi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comqi.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmjnOYNi+OOaLuoUrMZaxyo4PpwzMRIJfnUWLQN63ME=;
 b=o0D748/oKnOu7Z0ThM+M5DnGywe+5xDh3eQqXuwKn1roSnlm+PTL1geP03r+AJQ7VmQH63n+CZrACH45zpEBNRlphhhZaw9AjKV37q8+viASJulooyMHqYxRgw1HcEJQEJPd4rvkWsKTayc5G5yTTKYtQYx3ctouMqwY/SrnoFTS61afOVCPtAuZrAmwWd8oLkNzGY98b90uzdAiVBGHqZjhRakDMuzkrmtTEDs8KBH/fQxSDAoOb3C8OaKJbs8CfIppcGKgX2PZ5FhYoUd2OzsfiuSfBrdcoIxt60m2mbuf9TtM3QFGMizPx9zYpL4oHC5SK/cYzAlAjrHZzdIB6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=comqi.com;
Received: from LV8PR15MB6439.namprd15.prod.outlook.com (2603:10b6:408:1eb::16)
 by CH0PR15MB6295.namprd15.prod.outlook.com (2603:10b6:610:185::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 19:59:30 +0000
Received: from LV8PR15MB6439.namprd15.prod.outlook.com
 ([fe80::dc2f:9e60:2bba:e49]) by LV8PR15MB6439.namprd15.prod.outlook.com
 ([fe80::dc2f:9e60:2bba:e49%4]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 19:59:30 +0000
Message-ID: <ba217f0c-68db-4e66-9397-c8819589371e@comqi.com>
Date: Thu, 18 Jul 2024 15:59:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] git-svn: use svn:global-ignores when creating
 .gitignores
To: Junio C Hamano <gitster@pobox.com>,
 Alex Galvin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
 <xmqqed7r3fyv.fsf@gitster.g>
Content-Language: en-CA
From: Alex Galvin <agalvin@comqi.com>
In-Reply-To: <xmqqed7r3fyv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::9) To LV8PR15MB6439.namprd15.prod.outlook.com
 (2603:10b6:408:1eb::16)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR15MB6439:EE_|CH0PR15MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba2383a-0cc8-4fda-079d-08dca76422e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEVkUklPWGgxY3gyMHJrd3BvSVF1V1dkUUg3N0hGOTJIQ25TZkZzUENrY2lu?=
 =?utf-8?B?WTE4VkFvazBKUHBFY2NUUEl2eWFGaHV0aUFMNlBKUFNESXBIcXJYeVdsQTMx?=
 =?utf-8?B?SkQ2Y1ZUZW5DNXRYa0E2am9QRjJlcXdOUXVzUERlVzVmWDRyMk9UUE1YTG9S?=
 =?utf-8?B?ajhsLzRoQjN4VFJrQkNNbTJVVmVpU1JNU2ROWWZVVnYrN2RRcjFNNmViRWI2?=
 =?utf-8?B?T09qeTgzRzlQTlkwQ3UxUU9LeURHTUJWTnJrbWpJQmRmQXVFNlZJa2xmZEY0?=
 =?utf-8?B?ejBqNmhEUnE0N0lWWjRYWWtUdzBDRlVBWUFHS2tIRkxZekk0Q0lyZ2xQUHYw?=
 =?utf-8?B?NzQ1TFlxR21xUXdWQlVvakNuM1FzdlpSZWxBdFhQdzdtQXl5UnQraXR1Slhk?=
 =?utf-8?B?aWtseWowU2t4WFZ2WitWODY3UTExM09YK0Y5U3FLTVdLMlV1NXBLMjRXSVo0?=
 =?utf-8?B?eko4eFA0Y3VOcm1lbFhOdStSWkJNcElKbW85NlZNKzRMNmRNN2dyeXRUcGVl?=
 =?utf-8?B?NHpiYTJsMm15NTBrSHIvbUNrZWtCUzYyN2plRVVnaEZlTlZvK0xUS1MyUEFE?=
 =?utf-8?B?ZDJGK0hDVy9ScjR4S01HL1FveUZxTFJQOFJjT3hmMnp3NXFpM3JaUXFUOXBw?=
 =?utf-8?B?SGViRmdFTlNLRzgzTDJvQ2NvdnF6S0YvSEZmRlB5VmxDK1k1Uk1tV1BidTh6?=
 =?utf-8?B?aG1XRXpXWGZRRHk5SWxLU2pXWUlQc3k2cytqVVRhNHplakNmMTRlWWRBbERD?=
 =?utf-8?B?VThMYlNOWlcybzhtYlJVL1AraEZJSDlzaVBVL3RIc1I0dzNVUmpYYXk2ZDhM?=
 =?utf-8?B?UU80ZGdUL084YVVFL3hBODVhSEVleWhJYlJvUy9lMzBhSnFlYytoZ2ZpSVIr?=
 =?utf-8?B?Z3VMZDUrNFBtTk1TM3ZOdlBYc3BSTjQxTlk5RHpaaERyYWhsTGwvbVREMlJL?=
 =?utf-8?B?YnFGQVZiRGdYK2hDTFQzWTRtNEZhcGhxTkpOSEc0MnBaenlpRzZmQ29uZWJH?=
 =?utf-8?B?Z3RrQmNJOTIyRzd4Rm9hYjk0UFB5Qk1JVjJyUWlxdkRTNXlydkx5WEhhZCt1?=
 =?utf-8?B?NWgzWGdJSThYOHpTRG0xUkkrdkgzdVNaYjFMNWRzeTdEMnZKTEdvTUR2eERJ?=
 =?utf-8?B?LzVVdCt3dXIvUlBLdmY2QUczRmtieUlOYmdzb3MyTllDai9zVjV2RStDMFVx?=
 =?utf-8?B?M1EzeHQxeWdrWmlWTmx3UTQrZ1lQQ0RrS0s5MG50M1pJemZNWXZlTWE2THdI?=
 =?utf-8?B?dXo4MmJqL2RlQndkVVg4N3NUalMyZ0RuQkRMUElQZUpEUndBZ0kwdVd0NGVV?=
 =?utf-8?B?dnI1bjJPSHhBM2hnUnIwdjE3MzBHaDAzay9zVGExZ0xCSGpQRzBCamZSUkwv?=
 =?utf-8?B?SUdTMUpLVW5EMDZEMjJRSjZsL0J0ZkV6U1E3TDZIbU5ram93Q2JheENaTDRt?=
 =?utf-8?B?NHRXNWJIV3krcmowQzZBaGtzRFZYTzBxZ1YzNUhwak5wNjkyYXVrM25FSFhQ?=
 =?utf-8?B?YmsraGNwdVBPOUhqeWkwUGNvbjk2a3VnNVRxUHZ4ZnBUcHpFMitibzl3bGh5?=
 =?utf-8?B?SWxFUWJNbUQ4Y3VKSGFUaExCeTZCeDhTWnc3WXRNV1JGWnc2QzZtdjdkVTk5?=
 =?utf-8?B?eDU5cWpkRWQrb0xreXBremJCVHdXS3BZU2gzL1dySUQxaXJZM1lxQjA5TDRH?=
 =?utf-8?B?WHRjWG1ZZXMxTlpqVEY5OENiOXBUcVdSOTh5UUQwVFdNczdnMGZJN2xteXVk?=
 =?utf-8?B?ZzFveGlzNkZEcFVoSmxhOEZyL0VGZDN6ek9wQi9lNFRXVXRadXhQTzFGdXFC?=
 =?utf-8?B?QTVyTHQ5eDFIRElOTUZwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR15MB6439.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNrZkZIOFJzaW1ZUk01akNGWk9nbmpQN1Z5SDlEdkJQRlo0NklDZUp5K0d4?=
 =?utf-8?B?MjhxOFVSeHQ5cGhUVXFwaXhDMStSdmd4TUVUbVFVSmlUZkxXRXJFZnNXZlhq?=
 =?utf-8?B?ZitvbnBuR0ZyTG9tRU5HdWN4alljU29yNGNxMlNMUmloUk96RlZTREd2aGI2?=
 =?utf-8?B?M0JOaG5ucEJ4Q2xubWh6UE5RVFB0M2J6Sm1YYTdYMHR5TWJoblc1VWtNeVFp?=
 =?utf-8?B?dHVvc1RMenA4L2ZXSm1FWEs1QVpjVThXYitvek5rWWdsTFo0TzU4L003Rk43?=
 =?utf-8?B?eFVIOU1handWSUROcmdHUDFqc2swWVg0Y3FEZXV5M3NIT25hRmpMN0pRNDBK?=
 =?utf-8?B?SGJFcDNEVXJPcGNQZVRNekJsYjJOUGtQR1hDNytwOENPN1hxR0h2YmdDeTlH?=
 =?utf-8?B?bUdvN2VmK3dCNmtuL2w4YjJoc2wvN1JUUjF4SmN4dC9sd1drYzVzUUl6bm9Y?=
 =?utf-8?B?YU9ocUtNZ243TlptaUxONy9CdTh0c0RwM2twdE42am4yVGZTNVdpcjFWbWNs?=
 =?utf-8?B?ZFdDNXdkRjBFblVkN3lGZURDbDQ2VWhEN1NIQzBIWE14N2J4OUJ0ZzlMMWNV?=
 =?utf-8?B?dG43SDlzYVJzQkMwWUZ4Q0Z5V0NRTno3TzBEdCsyVmRidDhpUnc5ZXNEcDVs?=
 =?utf-8?B?QXlUTDkxQjZsdFZhbWVjM2NLNTNncUVOY1BwY2gvM2ZZZ3BaTzE3c1dMVDRj?=
 =?utf-8?B?cTZIbXRKSEV6bDhwQkpJMXZ5R2NCSTJrUWduM2VEMGF1VkpGMm0ydkp1UHpQ?=
 =?utf-8?B?K2NldHZWQXIwWmxPOHE4aWU2NFVyRlBjUzhYV0JZNnhNUGxwcTFPNGcrL1Nz?=
 =?utf-8?B?cHlUT294Qys5T3IxVGZFSHZpMS8vaTd3d1pUczgxS01kQUpSNkZLWENSbjJD?=
 =?utf-8?B?b1d5NG9jOUNLTXhQNzU3QUl4Q1R5RGRzNk1lYnRJWmdaclFBSjR1bUZBR2xL?=
 =?utf-8?B?bm82ajZwOFJoVTZtT05yVzFWSVlCNjlVUjlvZzdNQVl0VUcrYzZsTHozR0Zo?=
 =?utf-8?B?Uzl4QUVKdEZsNTNjKy81NkZpL1hIWDRzMkJIL2xLbkVheGdXcXpXOCs3bDht?=
 =?utf-8?B?UEFST3d2WUEwcE1rMnJRODRpa3J1K0hNV25wZ1FuUncwR1R4WUliM2NkMkhx?=
 =?utf-8?B?ZmhHUm5kb01CNS9oOVBmWXhlcHdtVHEyN3diQjhxSmEyU0JCY0d6MEhXdXkr?=
 =?utf-8?B?MFZCVkFJQ3FjVE50ME1nZ3FWaUREN1JBYUw0UkliTzdFS01xRVQ4eDU5MTI2?=
 =?utf-8?B?TmRmcmFieXR4T00vSHRCWmUrRkR5bGRPd1VtcG5ia1VjY0dXbUZBNVVSSWlH?=
 =?utf-8?B?RkZvU3UzMmh1SlRKeW14SWhadFo5N3U2L0ZVREREYlhaMEcyakJyOVY5QWZJ?=
 =?utf-8?B?V1gzd1M0ZURxVW15aTlObnhHZHVKWWxJaUVZekRueFZhRkg1eG04UFJMNGhz?=
 =?utf-8?B?SDlpQlF5Nk01Ky9ZV2JtMS9OWGVKTEZKYnc0emxObHgrNG5BNGg2dzdYOGVR?=
 =?utf-8?B?MFUyWFh6bjNoL0FwZFo1UWJFaFozdUYzS0NPQzQrRmNJL25OZXRxZmhWTkR4?=
 =?utf-8?B?dk5hT0FDQnEvSVJ3RW9CTHBGUjlUNDBnaUtzbUFIZHpHVnA1ckN5ajMzci8y?=
 =?utf-8?B?VHFZUXlBSkxQNGRncStqZSt0cnIzaTlEWlZpam9pa0FWUVE1NEhxR1VmTEZJ?=
 =?utf-8?B?cVZWRTJIdFZla3E5Tjd3aitSMC9nckdoVFRETWNSOVY4cHlHZkRsU2RSdThN?=
 =?utf-8?B?REpVR29FVkFZblZHa2paaENCU1NFMUU5NVBGZ0VBbXBiTEoycWtvM3IzaEVx?=
 =?utf-8?B?aTJodExXRHpSQnRCTzEzdFhPR09WT0JkY1hubE96U0tvclk5N1N5c2hrd1d2?=
 =?utf-8?B?UmxHaXJsL09KazVmaU5FWVFrRjRlQml4SEk5UkxOT05LMktkYVVDOTdPenhr?=
 =?utf-8?B?RmJVUTRPWXYvaXI3TmFHWjBIRkNUcGpnR1d3UDhldiszcGJuYUE5ajR1RlVr?=
 =?utf-8?B?b3ZKWjZQNnE0c2hoUkhEby8xczFFM3IydU44akJpbGRWYTh2TEx3ZlhBaUh2?=
 =?utf-8?B?YWh3ZmpNT0xCd2pRSUtzcURkRFdTVkFnV0lLZnpuUnBncThaV21MWHVKalFi?=
 =?utf-8?B?anlaZStnZ1pRNk13ZkRDV1FPMVNjamhDaVZVM3E1SW5SVkQ2Q1pzVGl3NGpE?=
 =?utf-8?Q?qLTJPHI0MCT1fIxGgSPTwZOKWgA51waC7dd5Wn2INLCO?=
X-OriginatorOrg: comqi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba2383a-0cc8-4fda-079d-08dca76422e6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR15MB6439.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 19:59:30.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e9102f64-4b7b-419e-b154-4a6930148e08
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2guIo34G/F2tVKhoHlBa0U+l9b/XWuAOgG73p3cs1lPSfLdWVCGTf3UtLQBkhD9S04xckPkUrY1oSN6xNvBhDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6295


On 2024-07-17 4:45 p.m., Junio C Hamano wrote:
> Paying attention to the new property and get it reflected to
> .gitignore on Git side may be a reasonable solution, especially if
> we ignore older version of Subversion.  But I have a naïve question.
> If a new version of git-svn starts to rely on the new property that
> is only available in SVN 1.8, would it create problems with folks
> whose SVN installation does not understand it?  Would it cause
> problems to them?

I don't believe so. Git doesn't do anything to set these properties,
it just reads and translates them into the format used by .gitignore.
So users on old versions of SVN should not be affected, their
servers will not have this property set anywhere.

> Anyway, in this project, explanation of the problem the patches
> address, with the outline of the solution, should be in the proposed
> commit log message of the patches themselves, not just written in
> the cover letter.  Can you redo the proposed log messages of these
> two patches, where you have none in this iteration?
>
> Thanks.
Sure thing. An amended patchset is incoming.

Thanks,
Alex
