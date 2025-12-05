Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3E32FA37
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953756; cv=fail; b=Au8HehKG16itzJFRmfofjGXQIFd6s47FlmPdL8kvzBN8Tfeldv8YFl87heoZ78YZVAygbV8QR17zqHmyTVsztvlzwYKdtJ/2F9bcGvECkx8BsrRDNzK/z+MBIGeWWI/E8S2jKh+MZbLrd1q6QP7F5oj3XcKuYokeD1Jfvf5A4SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953756; c=relaxed/simple;
	bh=tmEfPXzYYB3+qKr8rHSqtHta0iR+5OV4TIH4rCgfafU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mXh7k8DB1QXsOlJjpiKk8YluBxeCHjCiPOQItMG9j91JJ6l7yvBjgr25dddZqDHKcAjfxFwNM1LQC35fDUkcz0aK5//fuoIv7+cPE7FAMHF93nPonQ6L6WUBvD0jW/YVQaggXKtGIVzJtQIKlAJ9k+VZMmjm8ImI9nWcIdt5JJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8U7+znw; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8U7+znw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLvhBamcOwaqVTDwDH9mfFVrs4AEWno6LQbWDCWTdCCjfF0pnWBBNSAcXg+rfAUHIOYKrK6S8pyHuMpQaqfdImBhqPPCFhgw3izylP74sEGlNLWdm/cvjbQoYWkuWxyPtnZpD4JMxZtQcu8gwzJbm9ZbN6nolIwNeMVfCAMqN+jqf2IFKQjy/w/ClAs3DGdLnHNh9bILICiGiEQDknUDg/NXXS095JBKpvfqoWpU7CHYZl/ylanJ0PGOQbPL6eNlI/1kxh/kNj2A2DHX+kM8PSEc7T7DuDYQ0EWbZQTNBSGYXozG2qF5bD4e+B0Z92ct1Kg3bCsnHdkCwQPzPrgZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw5HnPPjRBzDl3jemlHP7ahqMqjWT0NBEWMzk/SjqXk=;
 b=lVe/aPxfMCWmHhKKNc3p4CI8JIGV2qnVvyA5lGU2Aoj0Kx8cvTLlaqPTJf5q+5O+j/giT2iwbkibZtMh6ib3XwrzRJPyLiLftEGSChn1ODOrRduX4eu/zCtkGdYYYXUdcKxtaXq2cD8oXjHvUHr5nykjdkriblVk2F8l8XyUKgWtWefoFlk1+HyI6XtKqnCgouiXjObkf1WgXW8aG0R797QoJUw5+3A0b31BKQhLZxqAEFdzTotSoBEaycBiA4zzg+i+6Q6ymRShrQcO2qoTuJ1h9J6XM9np6BRN3Rbns1KcESOY2bwOKQOz89/BfC4YtHpccnvmKFLcnwagN/HAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw5HnPPjRBzDl3jemlHP7ahqMqjWT0NBEWMzk/SjqXk=;
 b=Z8U7+znwSUZ5m81IOGttKgBxZvXG7CKhVoqwWZYkyeZ/JctiBVknr5TvcM5HpVB1e981DOviN9EnORAR8LG6u6Klrywx5haiaXFXnX6l8Eu7Z7YV3MHYcYgzDONGPBE8P7tsdntHGOnqMKnwE6ushCh5n67Ng1iz9P6z+/vVRWP5vxZvSa7DhSxIY7HNMdEGxbzgWAC2X1pjh/M//x5F6i0/L+Qbw06s2D8TAUMFCFL0vp8mm89gwEhR7KKcPHor3jZc6tal9VcsE/lPQF5tprxQpVURV6k+/f2obGrCapdzXCbEUn9bIa5MVAm1Y9Tqj5CsCu2MqsTzJXwsAMVG8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 16:55:45 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 16:55:45 +0000
Message-ID: <da52d3d8-f70e-4ab9-8752-0ddb7ad145f1@nvidia.com>
Date: Fri, 5 Dec 2025 08:55:19 -0800
User-Agent: Mozilla Thunderbird
From: Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <aTLR0YXqRO63GkJu@pks.im>
Content-Language: en-US
In-Reply-To: <aTLR0YXqRO63GkJu@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:a03:331::9) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a93e6da-29d8-449c-eef3-08de341f221f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0FldzZKaGxOTzl1b0tZK2pjbW1uem04N2Y3WitYOXRvcU5KSThyaXpUQ2pZ?=
 =?utf-8?B?YUtmWnZwUWpmaW1YQmtVRFFDMGpwWWZ5NUM3dFN5Sm9DeE05bkU5WUN6K01u?=
 =?utf-8?B?ZmlCQk9RbWFjZ3p1WDcvaDNCMkx6M25KWGlwd1RjNmhNaW16bEZlK3kydzM5?=
 =?utf-8?B?YWZOWkpSR1ZTNE55T0t0bUtWL0pJMVFTOXVHb1JCQTJTMmJWcWlMTmhjdXNp?=
 =?utf-8?B?K0tJUkVWU1ROMmFOZ0pteUczdzR0RC8xZm4rUVF5WVA1VjFQVGZ0U3Rad2R2?=
 =?utf-8?B?SEo0ejRWajd6U1FxTGVrei9McnRYZHIvV1h5clloT3hrN2Z1ajFiNWFBSlFM?=
 =?utf-8?B?SWxGQ3VzaE01Q1FIYWYyUmV6S0pWM3h2ZkpCWnFReDJlNXJtQm53K3Q5aUlK?=
 =?utf-8?B?TTk1SXZXOXNKNkxDSmZFVHptRDZuZGVPNk5SZ0xZYWZTSE1aV1NzSmRzelJU?=
 =?utf-8?B?aDZ5Ynl2OGlzY0x5M1duRnZzSmd2OXNwMDBweUpTMGVVcVVqdm52WW5HLzJh?=
 =?utf-8?B?cHpueityd09jMjNEb0JyV3RDLzFpYkdtYVBIK1N3YUQxQjhkaFpQTnF2OE5V?=
 =?utf-8?B?Nms5WjRxcDZFYy9DUVdRcmpxVEp3U0k4eXl3aEE2YVA5ZlYyVEVTRUpLN2xp?=
 =?utf-8?B?ZXA5dDVHRXRkLzVWNEVGUm1yM2FSNXVlOFNvME1XTEp5bWV1dkFOOTZFaHdL?=
 =?utf-8?B?a09RNnl1VXZjWWo3bnBiYlgvVGhWNHh2WnNydmwycWw2RDlYZlFnMDN3VkE5?=
 =?utf-8?B?YWNFcUQ2ODZhcFBxZUxaWDVWRWt1eHU5dEJKUDRKemdHUjhNSUt6RDE5Tjlq?=
 =?utf-8?B?VEhRejMxN3E2QzZpbmtKaW83bkhaanpRUzFzNHNzSUd6citZVWpHY2pGZ1VQ?=
 =?utf-8?B?R3BVM0xieGxXajhVeWZWVmt0Wkk5TXlUaEpPSXdMMi9XRU9vT3k3WE9Xcmly?=
 =?utf-8?B?VnNJbnI3TVdORWhQZHRtdVR4YkZXQXJubXdVd2ZWV2taUzZJRjlnNlREdHhr?=
 =?utf-8?B?bDE3ZHFERjByL0FwWTFKMTE1WGhLYmpVeGVGRjJwMzdJUTd6M29nRzlDMDdy?=
 =?utf-8?B?QjZCTllxcXNRbW1NRDUyTTJkWnZ2WmN4NGtGMXQ3SVErdUc2ejhkeFRFUUNM?=
 =?utf-8?B?TUpTK1VuNnFxdWtTcEw0c3pKbEZvZUZ5a2I2NHVTVi9mMWZhbnlhNkxKSC93?=
 =?utf-8?B?L25DNytaSkZCdmN2THpMbHlQZ1VTQ05CSFd2eE9ML0pXTlRFWG1EWGJlYVlZ?=
 =?utf-8?B?ejNiWDBZc0lZS0RkdHh6KzBoZjJ0REE2bnQxdWYvZGdnZE50cGtTTCsvbFRH?=
 =?utf-8?B?UmNKejdTVEtieHRLYmdCTFFzSUpXN0dMdE91clA4SGtkbFhUaHh1MUpLK1c3?=
 =?utf-8?B?SjNlOTEwUnlWSFNXYThweXJTcWMvODQvejliRzVMazMvS3BIQ1hJa2psTDZM?=
 =?utf-8?B?ZkF5cFlxSUh4Wi9nWUp4SzQ4NDgvSXNiNTgwMWlTaDhobklrV3Y2WjJNK29P?=
 =?utf-8?B?a0dKN1hIZUEyTTZkSW5xNDdRcE5YR2ZsU0RSSGRmdDd0YjBaT0FYMlBxOUxm?=
 =?utf-8?B?M3k4aUN3MFhwZWhnYWUrNXpaY0xRa0RDMUlsencveElDZWJZMURtUW5obkwy?=
 =?utf-8?B?UUJOT2hzVGRsbThOUnAra3NKL2ZRUkVuUzNOOFhkeXA5bDF6RkFhYXJMV2R6?=
 =?utf-8?B?R2RFL0R1SXo3cENEZHdtbEJSa1AxNkFwOUZXbnF6eFlTNFZ1SS9ick93MGNz?=
 =?utf-8?B?ZGVXK0VHUGFob1MxQmNObVpHWWNmYU5IbHp6TEFVYk03SGg1eXVFV3o0VFVh?=
 =?utf-8?B?dUpBVmM5cWhwcXdDUXVoaXEwN2hqbU9QV1NFaS8zaXZFVVpzRGtna2pmZnBh?=
 =?utf-8?B?TnRpcGpNRVhIM0ptZDlhWEkweUJBTGw1QjBMMXROWTdEUS9DYXA5STlXaS9Z?=
 =?utf-8?Q?szT1lTngKErsQPy9A5K/wTbmYNHJQ5U2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjJiNGhQVURBQm9mQUhaclhhdVFUaG4yRmhoeGg3Q1VZZjh1MGhoYUtXaG5J?=
 =?utf-8?B?NGpMSFN2WkVjU2RJL2RGN1VVazNPWXJNUkZhamIwVG4wa0NXeTlaeURGQzlP?=
 =?utf-8?B?blQxejIvTkZLUnBjbnB4ZWRCKzdNL2pseXJON2RGWW5oT3B1eDlyUkozZEdj?=
 =?utf-8?B?Um5yVDZIQWFpdGpkcXQ0ZmJGOTZGRUh0MG81V3J1MmpmSmhwT24zNFJDZWtt?=
 =?utf-8?B?Z3RxSkJMNTlucDh2dVZ4ZFcvNFArbjRLbXlpVHU1R2RyOG9oK3JYQXM3cDF2?=
 =?utf-8?B?bmtNZ0M5cjFuRVRIRHFERHRRcmtqZ0tScjdINjdkQmVDTlVlUnpySVM0ZE53?=
 =?utf-8?B?UWg4NkFqcFJ3RllHM3l0MTNoSkFTVEdzWHNzcmtGRjUyVDZDaWpublVuZzVV?=
 =?utf-8?B?c2ZJNEpCcHVXbWlkcThCeGFVSCtuSUN4R0hPYjFZcTEwdktkODh5OUo2NXIz?=
 =?utf-8?B?Vm5qTnJZK0pUWDJvMEFrbXlVUXhIeHJlTGZ0OTRXb0FPOU1EWTZRdjJFVFBk?=
 =?utf-8?B?RVd6bVdQZHpWSVdXb1NkTVpCSERHNkFkVXdseDZWeU5hMmdPTlNxb08wVVpN?=
 =?utf-8?B?eXFnZ2N4VUM2Nlkza0FoVS9KOUdNOTR3MXF2VjY1QVkvY1FCbkZqcEc4dVFN?=
 =?utf-8?B?c1A4eEdIQ0wxdy9JRzhQNkZlMEpWamlaUlZjTmpDTTlaZEtzS0VobDAzUmlG?=
 =?utf-8?B?OEI3VEFHSVgvUVFsRlVZUFFHMngzVVFPaUNPY3NHaGxvbGZUV3BzSkFFY05p?=
 =?utf-8?B?amUxcHpnYTVTWWVvZjIxV2IxTDVMTlVFc1NDZVNoZi9GWnFvRWtpSVdEQ2tX?=
 =?utf-8?B?cW9HWnkxNWZmZHJCNS9VUUh1d0JQZ0hCUGxQUzV0UlJRSWpObTVvOVlnVWYr?=
 =?utf-8?B?aWl4eFB2d29DK3N5dVVKakdLY3ZYd01ac2pBbnkyQVVINEtZNVdoRVo2ZDdS?=
 =?utf-8?B?SDVpLzgzUGxPVWxEcVl4azEyQTNxN3huOHlVSEp3cWFva041ZlVEZHZkeEtj?=
 =?utf-8?B?Tis5dTdzNUU4WC8vZExLVmk4bVpTR2JXZUhFcW1qUVJ1VkFmblc0b0hlSkl6?=
 =?utf-8?B?ejBQVWdYRkszYTlJcXdLT05LM3RBNkVVYSticXFQc3pIN3g5aGZ3YU1tR3Zr?=
 =?utf-8?B?Tm9pTUt1YXRDS0NVMjVRMzQxNm5MNDVydk5jcWdnOUxGbUxTNW1ITHk0RlJG?=
 =?utf-8?B?UGdsRFpNNnk2aDdGQi85NEh2S0N2VnRETFgzT2tMTW00MVJmdFhObkZLZVNU?=
 =?utf-8?B?ejV0VVc4V2laUEh2VjBZWGpwY2JRNVFRQjRMeDU0bU9rZXY4YjlBZVQ3Q25j?=
 =?utf-8?B?Mk5QbnJ1WURZWThucUtUZS8zTWZ1cTM3NXRGZ3RPODExK3pweHdoY0t0Y2VF?=
 =?utf-8?B?dm9lc2g1QTFyd2NBRGl0VHRuUS9iNFd5Nm4vN1RhUysrMFpLMXRlbHo5ejd3?=
 =?utf-8?B?NWcrWTR3bU1SRk43MGo1bFRxampqZkVNL29VNHJMQm0xLzF3Y2l2dnNjUWdG?=
 =?utf-8?B?WEFpNlRWTk05Q1h4NEZXRmtva1pvMW1EQ1gzMWdsRDIzbC80V0djYVZhS0lk?=
 =?utf-8?B?cURkcXVGeDY4YlFBcU44STE0OWZHUlZJRmpQUFlCNkhCZ1NLSUQvWkpnc1M5?=
 =?utf-8?B?TTJkS2gvK21YS0tzbXdHQlhkS1lZQWV5dFYrbVZFcldHVXFxa05HeVdIb2NL?=
 =?utf-8?B?QnFMMFloVlJpZkhPQm1xd3Q3bVRRRnloYi81SE1JSW96ZWtwaGczVGtBQWZ6?=
 =?utf-8?B?VTQ5VHBkTHFJcXl0emZ1R1hhajM5N0I5bFlPRkZFYzZsaEhMRDRGMWFsRHcz?=
 =?utf-8?B?Sks2ZUxEa3RMUzhwalA4WTZBUkxxdTRkRnRkb1JSWXRJVFdiTEE5L1lPek9F?=
 =?utf-8?B?emlQb280S0lGN0k0cVFWSnNsWHp2NFl3QzlXSjJhUVJpaDZ2QU53dTRHZUVF?=
 =?utf-8?B?aEt1cUd3eUJkVUZBKzNrK0psNVpwVW5rL2ZlYlFJNGNSVzVkS2lLSE5tNGtU?=
 =?utf-8?B?YldmcmpMV0pxRlM3dnRPNEs4T1dGbDdiZnhIYnNQM3JMUmp6TXo3aFRmN2Iw?=
 =?utf-8?B?dERRa2t2NTBzWENVM3FLMEVkNHVhazgrZm5sVTJDY2Q5c3pIM0k5bHd2VHhq?=
 =?utf-8?B?T1RKMnN5Q1dVS21wSHU2TG5MSlNwUXgwZUlOYTJFdnUyNEQrSkVsQ0JpZFY2?=
 =?utf-8?Q?hmFN8ZbjoP0+Cho8alkX+C0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a93e6da-29d8-449c-eef3-08de341f221f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 16:55:45.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y+AZeDbefB8UT18UJ7X2LEs5d2vuVg3enGcUJeTzcApoyb5uBcZMMEcj1yHBqP6kZRBPE4co4QeVoZnyVkALg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

On 12/5/25 4:36 AM, Patrick Steinhardt wrote:
> On Thu, Dec 04, 2025 at 09:21:29AM -0800, Aaron Plattner wrote:
>> When is_promisor_object() is called for the first time, it lazily
>> initializes a set of all promisor objects by iterating through all
>> objects in promisor packs. For each object, add_promisor_object() calls
>> parse_object(), which decompresses and hashes the entire object.
>>
>> For repositories with large pack files, this can take an extremely long
>> time. For example, on a production repository with a 176 GB promisor
>> pack:
>>
>>   $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>>   ________________________________________________________
>>   Executed in   76.10 mins    fish           external
>>      usr time   72.10 mins    1.83 millis   72.10 mins
>>      sys time    3.56 mins    0.17 millis    3.56 mins
>>
>> add_promisor_object() needs the full object for trees, commits, and
>> tags. But blobs contain no references to other objects, so the function
>> can just insert their oids into the set and move on.
>>
>> For objects that weren't already parsed, use odb_read_object_info() to
>> query the object type. If it's a blob, just insert it into the oidset
>> without parsing it. This improves performance for very large pack files
>> significantly:
>>
>>   $ time ~/git/git/git-rev-list --objects --all --exclude-promisor-objects --quiet
>>   ________________________________________________________
>>   Executed in  118.76 secs    fish           external
>>      usr time   50.88 secs   11.02 millis   50.87 secs
>>      sys time   36.31 secs    0.08 millis   36.31 secs
>>
>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
>> ---
>>   packfile.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/packfile.c b/packfile.c
>> index 9cc11b6dc5..563fd14f0e 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -2309,6 +2309,17 @@ static int add_promisor_object(const struct object_id *oid,
>>   	if (obj && obj->parsed) {
>>   		we_parsed_object = 0;
>>   	} else {
>> +		/*
>> +		 * Blobs don't reference other objects, so skip parsing them
>> +		 * to save time.
>> +		 */
>> +		enum object_type type;
>> +		type = odb_read_object_info(pack->repo->objects, oid, NULL);
>> +		if (type == OBJ_BLOB) {
>> +			oidset_insert(set, oid);
>> +			return 0;
>> +		}
>> +
>>   		we_parsed_object = 1;
>>   		obj = parse_object(pack->repo, oid);
>>   	}
> 
> This looks like an obvious improvement to me. While looking at the
> function I noticed that we also free tree buffers here, which make
> sense to reduce memory usage. I was wondering whether we want to do
> the same for commit buffers, which may reduce memory usage even further.
> 
> See for example the below patch. Might be wort it to test in your large
> repository to see whether it has an effect on the maximum RSS.
> 
> Thanks!
> 
> Patrick
> 
> diff --git a/packfile.c b/packfile.c
> index 9cc11b6dc5..89227ada98 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2296,12 +2296,17 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
>   	return r ? r : pack_errors;
>   }
>   
> +struct add_promisor_object_data {
> +	struct repository *repo;
> +	struct oidset promisor_objects;
> +};
> +
>   static int add_promisor_object(const struct object_id *oid,
>   			       struct packed_git *pack,
>   			       uint32_t pos UNUSED,
> -			       void *set_)
> +			       void *cb_data)
>   {
> -	struct oidset *set = set_;
> +	struct add_promisor_object_data *data = cb_data;
>   	struct object *obj;
>   	int we_parsed_object;
>   
> @@ -2316,7 +2321,7 @@ static int add_promisor_object(const struct object_id *oid,
>   	if (!obj)
>   		return 1;
>   
> -	oidset_insert(set, oid);
> +	oidset_insert(&data->promisor_objects, oid);
>   
>   	/*
>   	 * If this is a tree, commit, or tag, the objects it refers
> @@ -2334,38 +2339,45 @@ static int add_promisor_object(const struct object_id *oid,
>   			 */
>   			return 0;
>   		while (tree_entry_gently(&desc, &entry))
> -			oidset_insert(set, &entry.oid);
> +			oidset_insert(&data->promisor_objects, &entry.oid);
>   		if (we_parsed_object)
>   			free_tree_buffer(tree);
>   	} else if (obj->type == OBJ_COMMIT) {
>   		struct commit *commit = (struct commit *) obj;
>   		struct commit_list *parents = commit->parents;
>   
> -		oidset_insert(set, get_commit_tree_oid(commit));
> +		oidset_insert(&data->promisor_objects, get_commit_tree_oid(commit));
>   		for (; parents; parents = parents->next)
> -			oidset_insert(set, &parents->item->object.oid);
> +			oidset_insert(&data->promisor_objects, &parents->item->object.oid);
> +
> +		if (we_parsed_object)
> +			free_commit_buffer(data->repo->parsed_objects, commit);

Isn't data->repo the same as pack->repo here? I think this patch can be 
simplified to just

diff --git a/packfile.c b/packfile.c
index 563fd14f0e..ac31077d0b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2355,6 +2355,9 @@ static int add_promisor_object(const struct 
object_id *oid,
                 oidset_insert(set, get_commit_tree_oid(commit));
                 for (; parents; parents = parents->next)
                         oidset_insert(set, &parents->item->object.oid);
+
+               if (we_parsed_object)
+                       free_commit_buffer(pack->repo->parsed_objects, 
commit);
         } else if (obj->type == OBJ_TAG) {
                 struct tag *tag = (struct tag *) obj;
                 oidset_insert(set, get_tagged_oid(tag));

--


That said, the memory footprint improvement seems pretty minimal with 
this change:

Without free_commit_buffer():

$ /usr/bin/time ~/git/git/git-rev-list --objects --all 
--exclude-promisor-objects --quiet
66.19user 38.97system 2:17.46elapsed 76%CPU (0avgtext+0avgdata 
8171072maxresident)k
307985728inputs+0outputs (151871major+1067727minor)pagefaults 0swaps

With free_commit_buffer():

$ /usr/bin/time ~/git/git/git-rev-list --objects --all 
--exclude-promisor-objects --quiet
66.47user 40.08system 2:18.72elapsed 76%CPU (0avgtext+0avgdata 
8135640maxresident)k
307820424inputs+0outputs (100432major+1065152minor)pagefaults 0swaps

I'm inclined not to worry about it for now.

-- Aaron

>   	} else if (obj->type == OBJ_TAG) {
>   		struct tag *tag = (struct tag *) obj;
> -		oidset_insert(set, get_tagged_oid(tag));
> +		oidset_insert(&data->promisor_objects, get_tagged_oid(tag));
>   	}
>   	return 0;
>   }
>   
>   int is_promisor_object(struct repository *r, const struct object_id *oid)
>   {
> -	static struct oidset promisor_objects;
> +	static struct add_promisor_object_data data = {
> +		.promisor_objects = OIDSET_INIT,
> +	};
>   	static int promisor_objects_prepared;
>   
>   	if (!promisor_objects_prepared) {
> +		data.repo = r;
>   		if (repo_has_promisor_remote(r)) {
>   			for_each_packed_object(r, add_promisor_object,
> -					       &promisor_objects,
> +					       &data,
>   					       FOR_EACH_OBJECT_PROMISOR_ONLY |
>   					       FOR_EACH_OBJECT_PACK_ORDER);
>   		}
>   		promisor_objects_prepared = 1;
> +		data.repo = NULL;
>   	}
> -	return oidset_contains(&promisor_objects, oid);
> +	return oidset_contains(&data.promisor_objects, oid);
>   }
>   
>   int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *len)

