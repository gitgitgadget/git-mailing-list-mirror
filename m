Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013083.outbound.protection.outlook.com [52.103.46.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025E382395
	for <git@vger.kernel.org>; Mon, 18 May 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124710; cv=fail; b=Q03C/MCELxMmzZ/3VM4LHjsW2V6kbo1fbQpBwIjDnfIjwufuMICdvynb3LsOWGLxTx/uHIUXvoshAsJtMfNWJa6o1bmSQQC1uxnpcvmRVYecrQYPPHL84w/KtWv+qGaXMPImgxEphpnemqEs9LuhF7cDoDPwXcE960KHkD7f2nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124710; c=relaxed/simple;
	bh=s8WGcRtuZj7n4pfVbGW26ycwfNPRkDwiwmXJRMon3Lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPwroPciQdObS6sr3uge3Sy/VFpfkfeVRVbTit7jAfG2GIuIv8X4SSWNRLxLCPsGhxprAF0b4wW0Ndt0056MDuD7rFwSLGf9LXQnq/XZ8sbUw7QgoF9kqpmgu0Gh7RGPbEjF+Q22mQnlteSrhd8WdfK9K7zT4fR+fdJzsRPk3aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eVA8k0+k; arc=fail smtp.client-ip=52.103.46.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eVA8k0+k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iuar+6f/UPggXVDaZRf7BJS4pILK9skDNB3cYEKo5PopuAVzWQ7S+51acmzf9tl7UcR2ayXhNd45k9MikYMc2wRELM1x1J51mQA6o4es/IvIRNl03tUMh6l2HAzkgVc+UdO2323sCWVAmjl3R1e125fj0/UFyY39PqBgnFRV9H/Sew397GGtR2xOKv73pSytqqy1jTCiSQ/OhSqMfFNDxtMaUkSM29nErWzV5VEKYRHrMeo3Eqjtlbd14+hoK9Ipvgf9levg7TSfmKBwaIAAguHh/1UqX193lhgNI3NSPnI3mj6qPqvx6lHQBHb93CMDtPXrfwnc6RkfK1vTZZBHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMsDBwb1LYnfAbFE3vM8Fob4IxicARgryFdtAsILznQ=;
 b=WNyeux2WqIB5Z7Q95em1/gZBJHqmpfbdDV1wSDbr3MsHc8VbLkSNjZfgaXivWzuB/9mEGj5kmsqJ3lTCNExrjhLb8FMcXfkLO5iHq3qi0orBvInXA79hM3zyPvJWiFCL/Y8ACQS2Dt6BSXh26d9vMO3OQBLmqsC0FhXUtWCI7JpVrElxC+drxN5Ivck3kKRPK1+maS9gCBtK1ZzY/O9SGfyRVW7q+ADTEtQIiz+6vY5eQZMHVSY08D0TfZWUuIfvWAGjhmZG8zB4wJ+T4ntIpUKnuMC3PkwlpjBM/Uunmr7VifNtFDIneNXOVOywklj/M69wZ38+omvB525IRlgpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMsDBwb1LYnfAbFE3vM8Fob4IxicARgryFdtAsILznQ=;
 b=eVA8k0+kUd0PYdXg/xtMuxSXdEHitFLTo0sVrvhNF1k2mAVKCmiN2jPQzCaUCWkRKJLYey1TaSs/9QLL3bR1x3eSoaFiCpFwOJ+vWxcDOLlIJVnOXJFf846KU0WhRjfbDJJ446aLwpNAOLQ1QN59qlcfKAPDDGbqmV3bn861L2yRU7cMxutyUZgYYhZFwol4PS59enUssO7X+SXqBDNLz8bdarcnaw8xEkrv/XSO+mRza4yzcxLzLNlajQTBmiQhPIr6Rnr/oBbjQYPdV3nM9KlnCIrWhn4RiepxYZRUCjUYX8QxpxYb6mm1KkNvXJ0lV1a20MmJYkUYWbLRd0TOCA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by DU0PR03MB9199.eurprd03.prod.outlook.com
 (2603:10a6:10:470::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 17:18:25 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 17:18:25 +0000
Message-ID:
 <VI0PR03MB11634CB9DA2A4F91553EBF4DBC0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 18:18:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] remote: add remote.*.negotiationInclude config
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <7bd70a970b819c2d856bf8663e26797498526399.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <7bd70a970b819c2d856bf8663e26797498526399.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0105.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::18) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <7e2cb2ad-a5f5-4e8d-a3ed-7fcfc2454aa2@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|DU0PR03MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: a4878605-469c-40a2-d478-08deb501785c
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLQ65JHxOKBAnHTP2G7hs4ROKy9IhQOLqxUxRUWwjQ6nArCQqZBBJKUfGZEPrZR0jhYMLAF5tn3aoCBkF8YL6MJwvseuoDrzb5PB4xxC0ERdTaX0dV2ygUcKFMdz9JwfDtJqDqRfwEs0QVFfRDgpKfK79l6IrJf/h0vVJRRzWNqySjBylyVieEihQHOTQ4ROt9VX5JOxbSDmheg+lSnSfT3WXFOIyzMcyULLTuXN38RNIn5DJfFvTiYR9z3ZIFGuL7Z3j0SsPl/AxgsAcdgbNY0EBg9YZE7shx6X+c23pbjkLQ1OeQByDjnzkkRG3igTVUXV3LYbNfA2J8BfqnE2KO4yoii85OUVLuVlPVqn10l3e4ZDIGHBY63asuiva5wjphEBRjXoeo2nBxuUg7pJ5XsRl8yMPqMr6t6QtilKszNdHeJB5Gs2tMc8eODzzdrvtzO2EE34Md5XfOjRNKMdeh2TtFgkFA97qT3WZkif8bOBxCLQPmt/9Ika2DNT+TaAXYSSNT1Man8yexty4DqS3lg99dDPK2JzDSLTy68POWDKKCYwlBqq9HH/vtmK2ZFkD8bUafQ748TMSmcFKflaLqBqFowtbbny291/4LMJ+CiVl/GiTXUgOsuLxpv9LQbJZNIL00eU+Y67c/1GPOlRbh5hEpcAHPFp7JUJ5SxSkr5gHDd2+a5f/2yVjcnI+T3txceQHv/VMBMerr1Y3bkeoxuOD30nVhrt+0A7UIBfcZlpICDwEGtqcQjTLmoi7o6qyRHKtZslZBaF15nISvhIkSF9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|37011999003|41001999006|24021099003|51005399006|8060799015|19110799012|6090799003|15080799012|23021999003|5072599009|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXErREVsZGcvSTBMV0Q0Qmx4aDZLUFZOYzU5QUh3WVVwRzBvOHBCVVU1RFZt?=
 =?utf-8?B?N0tMRzFJQ3VJSmRzQzB0YUZvSWdhRE5OOUdlcWg4SHl0NDBnVjYzNWdlalht?=
 =?utf-8?B?bFZ4QVppMWRzUzlCR1paNndDQmlLc1k1WkowaHhISUlPZjNDaTBWbXIyZVZD?=
 =?utf-8?B?R2pYclkwNm5veGR4ajd6WHA1bkxFSUN0Yy9pYUxqY3UvY1hFTnl3M2JPS1h1?=
 =?utf-8?B?aVVjQjlnWmJvM1YyOHN1dkFDdkk3dnRWd0RLcXQzWjdtZGtHc0xaak9oVlFR?=
 =?utf-8?B?N1JvcngvNW9rUCs0Y051WTFUaG1kSmxteCtqcE91MElvd1BUWnBiaU9UZCtR?=
 =?utf-8?B?V24zN29JNHl1TW5UZEsybnVFeDA2dVd0cFdiN1hhRkxVejNmTUpmOVJsK0V3?=
 =?utf-8?B?d25Ub2EwdkpVMTRxMFR5a00xTjJHVjJNQnoyOWVieTZFNVZFUjhwU2Nmc2dN?=
 =?utf-8?B?U2l2TjVQR015VTUrZE5FUzNLU21UL2FScnQvWUZmQ0dCSFZWOUlYR0FBYmJF?=
 =?utf-8?B?OVJBQWthMUNVVnRKbm4vS3RtSzc1clVZYTRoMHN0K1ltcExLcmRDQU44OExS?=
 =?utf-8?B?Y2tNZ0grYWRzVFhkNUFaQUdGNUZzMWpkN2liMVI1bnFETDIwZHRPUDBrd1kz?=
 =?utf-8?B?Y0tCa3U2WCthbDZZdDJ0cSs4ZzU3R2NreTIwR0JxZGVDM2VHOFNzck9kQTNC?=
 =?utf-8?B?dDZrVWN3aU5Yc3U2SWJ6RVlGRHZFdU44M0ZKcGxieVpJVHpNUGxqOUh5N0JM?=
 =?utf-8?B?MVZmWjU1akkyb1BBNlplZ242SjloMXhsZnAwTUhJbjhYbXFheFphWXhSQTdm?=
 =?utf-8?B?NFd5TElZelJnR1luQzBIS2srQXY0TGlQeXBrVkVGcXRteGhQeXh1TEtUV3V0?=
 =?utf-8?B?KzZEdWtvZEl6cW1tSytVOWxLLyt0djlLcjNJeFhUTGtJS0FHaFk3RWprNFBa?=
 =?utf-8?B?RGFhK29wY3IvQWNoKy8vbGVXV2pmUmRZTGVxdEY4NWdDU2ZQLzh4bkhTZVNR?=
 =?utf-8?B?QmNUcTRXSVQrWThIczJCRnJYVlJPOWJsL0tYT21jbnA0ZnhTUDZFQjVRdHhn?=
 =?utf-8?B?R1htVGtNKytNNk4wUWs2ZXFmS3lIWklSZ0RwZjFQbnFQbnVwR1RHUVdnNXJE?=
 =?utf-8?B?OFpscE1MUXBmVUhVME1COEhFc3BwSGtWY2VteVJxM0Rka0V0S3pkTkl4cjV0?=
 =?utf-8?B?SzJvTm8wOHUzYkpTc09JcTZpcHF4bEFXc3dQdlZMb01LR1ZBVyswaWVGYWdR?=
 =?utf-8?B?Zzh2RFNGWm44Qjgvb0tqNGZkWGI4ODVFQmhyZ3FMU3JOMUtEQldjeDNlMTAz?=
 =?utf-8?B?TlFtb05PNno0ZGU4REF3bkxxdE1rcDUveWlhUnY5em4wM1pLNEMwTmFhYnEx?=
 =?utf-8?B?aGZDMGNYdXR4c1lYaDZJZkU4bm5RekpucGY3Y0hMdEM3RlpBZWdEbUlDVE5v?=
 =?utf-8?Q?eEGuZ8IW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTVtWS9NNy91eWR4REJzYVMzT0ttYUtsVU9QQ0hpczdDMUlySG8zSFdwOEtI?=
 =?utf-8?B?MldUWWpEZEJoVHgxUFdlNFJkQlRVVXBXMWgzT3pOc3JBWnNGTHBVd1pWdERP?=
 =?utf-8?B?bGhRdmRlV2lkWDZRMFdQczI0SWo1Mkh4bHgyUlc2bitLdS9uTHlVblZETHZV?=
 =?utf-8?B?MTdycm5GQmNwL24zMDlaR0VGN0llTFkvUWwrTklhYVhBSEczblYxVVhjOTdQ?=
 =?utf-8?B?Q3pURng1VHRFL3UvV3E1YUk1VlZEYWJzSEx4ZzhGTFhCY2V2RVhMRDZocGhC?=
 =?utf-8?B?TC81eFY0VjNEWkN2a3A3bmVBSkUzUTNMdVB6K1FuSVcrVTFHRDZmWWFJOVNR?=
 =?utf-8?B?NGJVUXZYUWUvN0R2azFoS1MvbWFhK2lLNjF4R1A5OUtqRzhCVGJEQWFINTIr?=
 =?utf-8?B?anBrWkwxZDAyb0RQQlZqSVNXbGlEWjlXVnd2STJ3RmJkWVVwdkRkRzkveGty?=
 =?utf-8?B?WkEwSnVYbTJxQXJvcTlTWDBiNzdCbXIzby9YSWtxNjU5UXE1OXFQbWJVUDFD?=
 =?utf-8?B?eHM4Ym81azBEUjUzVEVhd0RHb3RBdmFSZnB3ZjltMnltV1VVVnRqcWc3OTFQ?=
 =?utf-8?B?OXhsdi9pTXdvdkhIdzRDN2Ixdk1Dd2lpWGRwbkVTNFM4UzdZZzJicU5vWU5n?=
 =?utf-8?B?N2lEaUlKajNiT2EwMFJmOVVVeGFXcDFvNnNlcmFoU2QvRlJPU1VLYTVMMEww?=
 =?utf-8?B?cUx2T1ZPRHB2ZW5DNDBudW1ZRitTOVNZTEZhb1p4V28vVUFrc1ZQdkMvS0RE?=
 =?utf-8?B?Sm54RnViVVlwVHpjL3ZOOWpKNEYzQ2xNTUJOaFpjZGZsNGlSQ3Z3NmVFc0lv?=
 =?utf-8?B?UmVVWWp1MkFqRlNOOWdlaVhudnZoK1B5L0FXYVpxTXJrMXpKTllTMnQ5RUNJ?=
 =?utf-8?B?amNxU3lYc013ekJ4THJsS3BrazFSNjdpc0lvQ216WkFVTk50ZlVabmlzSS8v?=
 =?utf-8?B?QUxMNnMrRUpZb2l1UDhSSG5oMXllTGlhUUovSUFXaHIzQzYrSXB6UzVTSVIx?=
 =?utf-8?B?eFZkbGxBV2RUaEw0ZndidDc4WU1aallQbnBoWUhabUJCazM0c3VvMktkS2tZ?=
 =?utf-8?B?U3BXbDRhaGxzREthZzY4enU0R3VxazJCSU5XTVphMG5iTXFtTnJKYjFOSEFU?=
 =?utf-8?B?cHZuTVh0bDg3Uko3T3lGZjlNNmROMkhONTVIR0wwVnhoZytnRHJ3V2tDYkN5?=
 =?utf-8?B?T0w2dXdGWXpsY0szcStSc3FTcHdhMkJzak9HOXAvM2QvTVQxaFdkZ3djN1FV?=
 =?utf-8?B?MUNPL3ZzREhlaFovc2ZCazBVNEhRQ0FqQXJnUEJoZU5TSU1CaEhES21FYjhn?=
 =?utf-8?B?TVRCL0FrQ2dUbGQwV0UzMTJocUpxem1OOXVkdmlRSE11NVNFYlRFdVFVMjZK?=
 =?utf-8?B?TWRTOGRXWlF1WkluOFpwdHJSNExUenJYZ2NibGIweXVWcm5COHBNQ1F4dC8z?=
 =?utf-8?B?dDJtVVZzSDVVNVNKTXFDS2VVVUxSbWs1MlNXcUMrMnErTVVLYkpwdzN4VU9k?=
 =?utf-8?B?QmMzdkRpV290S3MxcU83ZnV3akZvN2I5MTQ0TUp1ZGswV1RoVEtjRjNkbkZU?=
 =?utf-8?B?cDhGNlpHZGk0akRsQW80czhBN0xlMm42bmY4aTVEK2RjNlNoc3p1ekZHbkJu?=
 =?utf-8?B?emhpWU1kTjJIQUNjbkRNOENjRTZYM2JBZm9ZVE8rSHRvR2d3ZFdTRVNyUFk4?=
 =?utf-8?B?UU1od1lMZ3FhTHpjeG9tbXpkN1c2TElwZ3YxbG9kMEhEc3gwUGd6bEhzdERu?=
 =?utf-8?B?K0tFZFVqeUoxOXJrY2hZSnFXUnNqdSs1UEp3U1RvNzlIZzdoY3JHbkFuQkRM?=
 =?utf-8?B?K1JXVmxNZllhdjZ6VWM4dXJnVmcwS24vVWZsZEtwd3llVWhsYWxFVU9RREdn?=
 =?utf-8?Q?9oxVhrI2GVxZB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4878605-469c-40a2-d478-08deb501785c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:18:25.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9199

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> Add a new 'remote.<name>.negotiationInclude' multi-valued config option that
> provides default values for --negotiation-include when no
> --negotiation-include arguments are specified over the command line.  This
> is a mirror of how 'remote.<name>.negotiationRestrict' specifies defaults
> for the --negotiation-restrict arguments.
> 
> Each value is either an exact ref name or a glob pattern whose tips should
> always be sent as 'have' lines during negotiation. The config values are
> resolved through the same resolve_negotiation_include() codepath as the CLI
> options.
> 
> This option is additive with the normal negotiation process: the negotiation
> algorithm still runs and advertises its own selected commits, but the refs
> matching the config are sent unconditionally on top of those heuristically
> selected commits.
> 
> Similar to the negotiationRestrict config, an empty value resets the value
> list to allow ignoring earlier config values, such as those that might be
> set in system or global config.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/config/remote.adoc | 27 ++++++++++++++++++
>   Documentation/fetch-options.adoc |  4 +++
>   builtin/fetch.c                  | 11 +++++++
>   remote.c                         |  5 ++++
>   remote.h                         |  1 +
>   t/t5510-fetch.sh                 | 49 ++++++++++++++++++++++++++++++++
>   6 files changed, 97 insertions(+)
> 
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index 4dcf81fbce..9ae20e4379 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -125,6 +125,33 @@ values are not used.
>   Blank values signal to ignore all previous values, allowing a reset of
>   the list from broader config scenarios.
>   
> +remote.<name>.negotiationInclude::
> +	When negotiating with this remote during `git fetch`, the client
> +	advertises a list of commits that exist locally.  In repos with
> +	many references, this list of "haves" can be truncated. Depending
> +	on data shape, dropping certain references may be expensive. This
> +	multi-valued config option specifies references, commit hashes,
> +	or ref pattern globs whose tips should always be sent as "have"
> +	commits during fetch negotiation with this remote.
> ++
> +Each value is either an exact ref name (e.g. `refs/heads/release`), a
> +commit hash, or a glob pattern (e.g. `refs/heads/release/*`).  The
> +pattern syntax is the same as for `--negotiation-include`.

Thanks - references the correct cross-referenced option I raised in v3.
Commit hashes are also explicitly mentioned - good.

> +These config values are used as defaults for the `--negotiation-include`
> +command-line option.  If `--negotiation-include` is specified on the
> +command line, then the config values are not used.
> ++
> +This option is additive with the normal negotiation process: the
> +negotiation algorithm still runs and advertises its own selected commits,
> +but the refs matching `remote.<name>.negotiationInclude` are sent
> +unconditionally on top of those heuristically selected commits.  This
> +option is also used during push negotiation when `push.negotiate` is
> +enabled.

One thing to mention: the "also used during push negotiation" sentence
is added here, and then I see in the next patch (patch 8) we're adding
another sentence "these values also influence negotiation during git
push" to this same block.

Perhaps consider dropping the additional 'push' sentence here (patch 7)
and let patch 8 add just its own sentence about push? Not too pressing.

> ++
> +Blank values signal to ignore all previous values, allowing a reset of
> +the list from broader config scenarios.
> +
>   remote.<name>.followRemoteHEAD::
>   	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
>   	when fetching using the configured refspecs of a remote.
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 7b897a7202..8074004377 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -91,6 +91,10 @@ The pattern syntax is the same as for `--negotiation-restrict`.
>   If `--negotiation-restrict` is used, the have set is first restricted by
>   that option and then increased to include the tips specified by
>   `--negotiation-include`.
> ++
> +If this option is not specified on the command line, then any
> +`remote.<name>.negotiationInclude` config values for the current remote
> +are used instead.
>   
>   `--negotiate-only`::
>   	Do not fetch anything from the server, and instead print the
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 6b456b3689..2308cab377 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1630,6 +1630,17 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		else
>   			warning(_("ignoring %s because the protocol does not support it"),
>   				"--negotiation-include");
> +	} else if (remote->negotiation_include.nr) {
> +		if (transport->smart_options) {
> +			add_negotiation_tips(&remote->negotiation_include,
> +					     &transport->smart_options->negotiation_include_tips);
> +		} else {
> +			struct strbuf config_name = STRBUF_INIT;
> +			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				config_name.buf);
> +			strbuf_release(&config_name);
> +		}
>   	}
>   	return transport;
>   }
> diff --git a/remote.c b/remote.c
> index 620086e16e..6fb5758820 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -153,6 +153,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>   	refspec_init_fetch(&ret->fetch);
>   	string_list_init_dup(&ret->server_options);
>   	string_list_init_dup(&ret->negotiation_restrict);
> +	string_list_init_dup(&ret->negotiation_include);
>   
>   	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
>   		   remote_state->remotes_alloc);
> @@ -181,6 +182,7 @@ static void remote_clear(struct remote *remote)
>   	FREE_AND_NULL(remote->http_proxy_authmethod);
>   	string_list_clear(&remote->server_options, 0);
>   	string_list_clear(&remote->negotiation_restrict, 0);
> +	string_list_clear(&remote->negotiation_include, 0);
>   }
>   
>   static void add_merge(struct branch *branch, const char *name)
> @@ -567,6 +569,9 @@ static int handle_config(const char *key, const char *value,
>   	} else if (!strcmp(subkey, "negotiationrestrict")) {
>   		return parse_transport_option(key, value,
>   					      &remote->negotiation_restrict);
> +	} else if (!strcmp(subkey, "negotiationinclude")) {
> +		return parse_transport_option(key, value,
> +					      &remote->negotiation_include);
>   	} else if (!strcmp(subkey, "followremotehead")) {
>   		const char *no_warn_branch;
>   		if (!strcmp(value, "never"))

Good - uses the parse_transport_options() like with the earlier patch.

> diff --git a/remote.h b/remote.h
> index e6ec37c393..d8809b6991 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -118,6 +118,7 @@ struct remote {
>   
>   	struct string_list server_options;
>   	struct string_list negotiation_restrict;
> +	struct string_list negotiation_include;
>   
>   	enum follow_remote_head_settings follow_remote_head;
>   	const char *no_warn_branch;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index bc2e2af959..33f61ac12a 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1587,6 +1587,55 @@ test_expect_success '--negotiation-include avoids duplicates with negotiator' '
>   	test_line_count = 1 matches
>   '
>   
> +test_expect_success 'remote.<name>.negotiationInclude used as default for --negotiation-include' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	# test the reset of the list on an empty value
> +	git -C client config --add remote.origin.negotiationInclude refs/tags/alpha_1 &&
> +	git -C client config --add remote.origin.negotiationInclude "" &&
> +	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_1 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=beta_2 \
> +		origin alpha_s beta_s &&
> +
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	test_grep ! "fetch> have $ALPHA_1" trace &&
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace
> +'

Great! Now this test will catch failures to the reset-list behaviour
by using a different CLI option ref name than is in the config list.

> +
> +test_expect_success 'remote.<name>.negotiationInclude works with glob patterns' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	git -C client config --add remote.origin.negotiationInclude "refs/tags/beta_*" &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		origin alpha_s beta_s &&
> +
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace &&
> +	BETA_2=$(git -C client rev-parse beta_2) &&
> +	test_grep "fetch> have $BETA_2" trace
> +'
> +
> +test_expect_success 'CLI --negotiation-include overrides remote.<name>.negotiationInclude' '
> +	test_when_finished rm -f trace &&
> +	setup_negotiation_tip server server 0 &&
> +
> +	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_2 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-include=refs/tags/beta_1 \
> +		origin alpha_s beta_s &&
> +
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace &&
> +	BETA_2=$(git -C client rev-parse beta_2) &&
> +	test_grep ! "fetch> have $BETA_2" trace
> +'
> +
>   test_expect_success '--negotiation-include avoids duplicates with v0' '
>   	test_when_finished rm -f trace &&
>   	setup_negotiation_tip server server 0 &&

Overall this patch addresses my comments from v3's review. Just the
minor issue with forward reference to 'git push' behaviour in the docs.

Thanks,
Matthew
