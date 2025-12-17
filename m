Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CFA1D6AA
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765930176; cv=fail; b=Q9JxhrG3kEiiyKioXWNEqx5jGiuEDJTX+T7t8jvSdg0uzsbPU3HKnG7USNMBkdQK2WRmN/Me3ytSQzwDuA1cE69jYnoJt42itrUERdq2Ulo0IDDss8CPRgoto/RYdhYE0rWYzJIFGvd06c8x867nX98QKcpvxUP/Rk+kViqhUoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765930176; c=relaxed/simple;
	bh=T+mcnnt9ef2Hehosa0x21C4gj2TRsIjRwL9nu6EKW9Y=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwzW9HBA4mnQgDapBRarbS2aetF0xY2U3DvaGzf7Sg9RZptnj7sld3vsd4YBuRxUpunTGGq7s/s1EGYiqmFDD0UlhROLAQ+8BVdjTeYs0nyHjuDaguARIE4mSckUsnMrAkFEEsV6+OZk2SRIc2Y1zM8dluOZolv78CCoIm95znU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZWFAjrz7; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWFAjrz7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9ZEeGXfasuFldg0QF5H+fDn4XXcaeT6EDw7fkNtmLfgOoQSTNqBfcL8FUFZGF8TD7BErHFaNjE9mdLr+hb7DaKeLhyhQ17iqntQx26buGvKTWorP9dAowJArjaot2jkOS+AWU4WJtRtCZOivdspkMcO1vlDndqbzb/f1Ig3j1YWYekFjxbNSe3AFgyq+FvKp9OJx48lvZdLd3gQ+k8XxNb4fVcSEz1MzqC3Y39QqxREuKZqPvwrmwIkllkjINhIy/07BRY9Yx6JETfTvdZDM4q2+XKGKBgczVf11LpCFVUvJOMgUeRf3kVGDAdK8u7/F6qsYuLBETApbVX1GrQtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCKBm+ktlAHjWuApM4foUU5PJL6EcUd3hLBMCkV1JOA=;
 b=Ey7YkJKuY47oJt/CqrgGAD/nkR4LwRKTUOcUYfAZH0Ds8NuDbTaVmS3o09NHvgECSAeagvP6JItcCqvIVuadPqI3aZ7aNcpJhRVJTLdMi0aYQvp+tvzboS9N3hxBOlMMP9ULZ121W/L/HUOHIclLeCKXCejdeAutT6LlNk479iab5/bz9hl7jPCa5ykY1hheHyla411Xxf+2+gPjGEvGKTU2Lvn4iwA/1M5r0pHqqI44jQTDzj94cr7pJdj5PVe14CIi9hGh9QJF3uohrBQ2ZvpCw1l8UR9woRcH7tFHNTtfdCZvW2IQ4i80g+7KO9j7ZQP1ul6ICa64B8NdXssALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCKBm+ktlAHjWuApM4foUU5PJL6EcUd3hLBMCkV1JOA=;
 b=ZWFAjrz7YMdFByxZC1j6vDzXK5QcNqIk7DQgCCzURGfCA2nT7jHzaCn6JkqHNkXWZJSsBjoup07DW5+lQHOAZE+uUoCKYWdyBZxAxPrk65wOCZrK/1nS12bPeRxa34liNNwDJSLT1pRfwP7cXoXUY/ON0xEjfmxJExwWE7nIxibP8gOV6z540S9vyBSCwWgtc+0Py6nlCA+26WRXA/p0Qqhhikx3FRFeFtPjFnJoiwMUOFpGmr100SBIzBNBwzEoFU2L8ecLwDRe0/btYGsrnK1bDvqY+ddpx8wX3n1hiaD+zZ/cV699Gu4D1uk6oUcg1krZTWVVsPRmNFA0tpDTRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by CH8PR12MB9744.namprd12.prod.outlook.com (2603:10b6:610:27a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 00:09:33 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 00:09:32 +0000
Message-ID: <93afac3c-c532-4183-a1fd-7e2322ee912f@nvidia.com>
Date: Tue, 16 Dec 2025 16:09:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Dec 2025, #03)
To: Junio C Hamano <gitster@pobox.com>
References: <xmqq4ipwc7y2.fsf@gitster.g>
Content-Language: en-US
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <xmqq4ipwc7y2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a03:505::24) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|CH8PR12MB9744:EE_
X-MS-Office365-Filtering-Correlation-Id: cd281963-e423-4094-ed0f-08de3d008dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk5qTFVqMjZGbFRubFRrVndxZVhVeUFheFNxRVNwWGdWU1NkRk1VbW9wQklZ?=
 =?utf-8?B?eVU4SkZ1YUYrV3JWTzBOVml1TStlOWg3Wk8zVUt5aS8wWHJHdGtKN0ljRmxM?=
 =?utf-8?B?QXlMK1FNM01vYnVFM21IZDc0VFFjclB4eGJJY2hST3lYNUN0ekprcnFZRVdQ?=
 =?utf-8?B?TzBxMFZyOWJrMGpWQlBaWWkxMFIxUFFRU2hMTFpXT0IwSE5rMnlKaGl5eXJl?=
 =?utf-8?B?QkRMSTdDd0dwMWNWLzNZcklWdXNHVkgrMUVZNUFoSys4M3FGTFhYTTRNMmc1?=
 =?utf-8?B?VmtEVkVBa1c4TTJ3UkZDSWRMNmtJSGVSU0FmTHNuR2dFdUk2LzROOVVLU1hs?=
 =?utf-8?B?bER5Wm5LRk5WOGFnOWlBVktmRmV3VUVRMUJ5ZzRUU3Z3dk1GcGJzVjJxckVl?=
 =?utf-8?B?N3BPTHBsN0FLTTA2ZlBlUFYvOExBTkVjYTFNYnhldGRHSlppU243QnB6THhI?=
 =?utf-8?B?SXM1VzZVUGhkbXRrTDQwTkpFeGdpZDVyNU9CWE5KM1VUUG5HOXVZVGdDWmhx?=
 =?utf-8?B?eWUrSHdaRVFRRXJmV3g5ZVlQWFZkaEg5MXFKTTdxRm5uRnhhSExXSlJGUDEy?=
 =?utf-8?B?UFA0Mm9kWFpxS0ZNRzRGWVBkZXM4d0M3LytnbThLWUdOaGovQmZrSGU4MHJ3?=
 =?utf-8?B?b2hEUmt6aFFQYm0rckZkRzJKb0dGK1dHdU9PSWxELzQrYjhad2VTV0ZVQ0xp?=
 =?utf-8?B?WTdMT29nOWVNVE9zSEc0R0pyY2FGMm1TRVptaVV4azV2TlJOWDhrMG42dTlL?=
 =?utf-8?B?UlZibGp2Vy9wZUpkYjZjOXpMYmdHbHkvK1JKOWR6bGFrR2x2aS9na2NvK3Ba?=
 =?utf-8?B?SGFPZlJVL0liQ1QwV081N3ZmdGl0QjE4VTNOaGlVa3pEelZJQ2xkREtRQUQ1?=
 =?utf-8?B?WlE5U0JUZE5URWV4VnJQL0hUYXhOSnEzcUZkakVWSTlQWmFQUU1ZNnFHK0Vs?=
 =?utf-8?B?cEwrK0poMGdPVmdxWCtJS1U5a0orb1Z3WG0rcDFmdVFmSHdZWEVSWFFnRm1v?=
 =?utf-8?B?U1h2NFYrS3lIeGM3TEx3UTM0VVcvakgrQmZTV1VFWi95L2dzeHNQQzRkSlRF?=
 =?utf-8?B?SDNpVjd5ZXNsS1BIekt5RXU4L1VzVG1YejZZOVd5STdRTXVnQ2NJaDREWjlx?=
 =?utf-8?B?b2NCaitRWXk0b3IvbjFRTm9oMTRDMHlmVkUxWnBZWkdPUjJWZzU0TFNnMVlz?=
 =?utf-8?B?MmZJMS9BelZzUnNYUEhESGZxNS8zMDVvZytNRjZzY2NGbzNoVGI3VGdpWDA1?=
 =?utf-8?B?MGR1QU1QOG9WUVZCYk1YYld3N0VrUHBwZHhEMUozc2VkaVpqbEtGMFl2YlRS?=
 =?utf-8?B?eStOZ1hhZ1dDcFI4R0pYWlVid3Q0eFpUTUh5RDU4TFBZVXV2dElIaHkxT285?=
 =?utf-8?B?cVN4dmVtWndodjlkaDZydVZaWWhGQ3NrWmt4VTVaalpwaCtVNkIyemJUbXJO?=
 =?utf-8?B?K1lhZW9IK3ZaN3J3ck1RdG1xZXhvRmhvSVM5Sm1PcU14aEhEYVpvUFRNUXV4?=
 =?utf-8?B?eWRTQ0M5ZGNadHVWQmxWQ09qOVlMNlVOQ1E5bTl0aVZRUEUydTN1M251WnV2?=
 =?utf-8?B?RytpT2h6a2FZdVh4RnE2Y1B3ZWxpblNBYkl4bk5EaDUrM3hNNkt3UkFCLzF3?=
 =?utf-8?B?S1lVZ3I5QkdIQkNEMDNLL2xOcWpwSFpHM1NFNVA2cHpqbnVjSUdiYUNybXQ3?=
 =?utf-8?B?bk5JK0g5blVUZWtFZWl2bGJWTzNrNnF1NUNaUG5kUDErUDUyZTJoTXFhQnJ3?=
 =?utf-8?B?QWFnV3dMRFVnN1ZDSkJEc0RSVnhzdWs1b3hlOGJsMDI3b2lkQWRxZkdmandp?=
 =?utf-8?B?RFE5ZS9hLzc2WEhGbExoMlRxWGttMHQyd0VwZnROS2UwV1V6TnZyZ3lIbk0z?=
 =?utf-8?B?YlRPNWxHR25PVSt2bGpCWWlLUkRTd003eFVBaXdyRGpDY2R5TVFDQ3UzcmRZ?=
 =?utf-8?Q?9Z5AUxcfnirtUBIz/9h+EEdzinpLiCAj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWczSVRhN3h2bXFFQm93aDV4VWZiM1lhalFuQXNLbkN0cUJsVE5MKzVrMGow?=
 =?utf-8?B?V1pUbnJkVlhUaXJBQnVaMEpOd1pwd0MzelFtMDREYmlwUE5YTVU5WjlUbDdF?=
 =?utf-8?B?QVJOOU5wZTd2emFOTFpiQkFsMjBUQkFBMCtQYWE5ZkVnQkUrRFpBUTRKN3JR?=
 =?utf-8?B?K0dqMGF0SW4wS3oyQVY2QWFZNWQ4TW4xd2FYeVNEYzdRcnVwTXcvdkV3NG0y?=
 =?utf-8?B?Sk81TlNPeGU4dVF2SCthYURxN0JEMmRQR0ZWZTdIdXBqT3p3VkJBb1hCcGFt?=
 =?utf-8?B?ZlhaZnRZNVczU2kyTlh4T0FxY2oxZVlVVmc5MFdjUW5MSzdHZFlPSGxGTmR2?=
 =?utf-8?B?c1IxRWNMbTAvc3lzZUw0cWdJTHZUVmxDeGhoakdvZ0l4VTZrK0I0L0wyd2ll?=
 =?utf-8?B?c1FtZzFLL2VLZVhnbnhBdjlsQTFSWEFKVGw3Yzd3THorY0N1QzZ6WFpsZ3d5?=
 =?utf-8?B?TE1SNml3Y0FwSlBFZ00wZUJGQ01MQmRmQWR1QzJ2eGhXQ2xMbkNFZHdrU0tV?=
 =?utf-8?B?cXZsYysyTHl3L1BSUzc3aXFoNk1uTUkwcTNQOC9rekJkcFEzN3g1Y2t4SS9N?=
 =?utf-8?B?VkNQVjZ2MzJCVDgxdjNiRCtTWHBLQWJVUnlOUXp1ckRLZEFHRkhzdXptVGNU?=
 =?utf-8?B?VzNVVGlEc2oyeFJNcDdzTFV5ZEl3c2RFWmVXSEswUW53aW54K25HVFFzOUhm?=
 =?utf-8?B?MTBYaXhaWXNoMlRvWVYvNjBSRmYzRk5CcmZkeDZtNm9HY2VSUUZkdTJXUEhs?=
 =?utf-8?B?cS9MOVN4Z3hrbXZKYll3aUtFTkRTNDEvclVCYmxLRWIvY0RZODFtbDhhQWt1?=
 =?utf-8?B?dXMwZWYvYk01MWVNQmJqZVVZa1I4VXZUVS82dnA3Tyt0WEprOGZsWDZJL041?=
 =?utf-8?B?bnFWZUg0OHVYT2t6aTArMWFoVzhURWtsWGpQQ3Z2RHVmaUR5STQ5WXc1YzRs?=
 =?utf-8?B?NUU0UkNrdmJEN0d3Uzc2MUlTa2NrVDJTakZva2R2M0ZFVm5IOVBQbVBZYWFh?=
 =?utf-8?B?bDk2cGhobENjSXEvNDM5RndNZGlLckNIY1NJMmh0VnUrY2hLQkFGbG16bmNp?=
 =?utf-8?B?NkJJamZuSUthOXpOYVU3VTR6akorb3NlaGdWRjhsRndjU2FBSDZUeDhydVBu?=
 =?utf-8?B?SlZPVnM2cHpWUzhabzZScGE2SEVnVHlpSWh1TGVSN3JpaCtlZnhwQjlDcFdO?=
 =?utf-8?B?M2NBcEYzdjhpS3hIbEtiMXNGZEFUQTRtTUVrWjVwUWp2SkZSa1M5SHRvVFEw?=
 =?utf-8?B?WUpjcGRCbXNUQ2lpU1J6dTA2V1ZDMUlhNzdpMFN1VDRnN1RZRCtzS1dkRFNE?=
 =?utf-8?B?RERtN1dMT0xLS0xYZW1la2Q5TjdqL0ttODZXTEY5RTdmbGYvTDUyKzk5QkUz?=
 =?utf-8?B?NVRTY0tKTGdZYTdnN3JDVUFCTVpySXRvNFErYWlQOGNDNE96RDMwVXFOVFhC?=
 =?utf-8?B?RlpKcFN3MVdmWk1vZVdibEZXZEdNVFdMbUtmM1pVeTRSaThsQm5mZ1BieHZR?=
 =?utf-8?B?N3l6VmtEMjcyU3BJYWdQVGFobkdQTmp1Q3kxZmNwcDlHRVA1L0kzSWNyNG54?=
 =?utf-8?B?cVFFVy90Q25rZTYvRGh5eTgvQWNXZjFTWnZBZ1FmUjhKejlUQk5ZazhJbXNq?=
 =?utf-8?B?UUxWWUlNQkMvbFlRQkJUZCtvVXFWcjJSNlpubzRCNmFyNEwwWkc3bis2YzlN?=
 =?utf-8?B?Z0U1a3o5c2lpYWwrZkZFTDVVUnVXK3lrTEt5RU5hNndBbHpRUWdYQlJWQkRG?=
 =?utf-8?B?MGVjcEV2R3FGM1JBNmZRdmtQcStEL2xyK28vUHJuQlhELzhKQVZlMDcweDdy?=
 =?utf-8?B?WHBuUEYwWkpuUkpGVlBqamVJUUNDWWQxL0F3elFPV1o0V3FtUTlrdHBESWd3?=
 =?utf-8?B?RktWZkFoMU14bjdqYXJDN0txMWVQUW8xbWE3S3M3Z1Jjd01DOUlCSmhEeEtT?=
 =?utf-8?B?eEJGWis1dURRcDlGeEFWYWlidUViZjRlQW1wRGp6WUJqVkNpSllHYW5hVUxq?=
 =?utf-8?B?SmNTQVJtVkovcmYrWVpJOTZLL2MwcnlMd1RmZ250SGk3SzBOTTVLTU5EYjVl?=
 =?utf-8?B?azhkbHNocGdSVkZGODJwbHY4M0FIMTBqcGhSWTdhK1JqYXFGSzgzeEVWblNm?=
 =?utf-8?B?WDcrV3B6WVNOYXZmQnZoSkxUaDRlV21qVUhPamZZNlVCNyttZmRWWnZ4U0dn?=
 =?utf-8?Q?Nj5TkONwNicMch4oO7cfLm0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd281963-e423-4094-ed0f-08de3d008dc2
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 00:09:32.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jRr3P9UsIxIZQ+lYHVZlXFJ9il8gV3lVP/PoTpEFx4YhHKZieKobfWjtesQ38xjctV922JNhmleDbqQgmI+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9744

On 12/12/25 2:26 AM, Junio C Hamano wrote:
> * ap/packfile-promisor-object-optim (2025-12-08) 2 commits
>   - packfile: skip hash checks in add_promisor_object()
>   - object: apply skip_hash and discard_tree optimizations to unknown blobs too
> 
>   The code path that enumerates promisor objects have been optimized
>   to skip pointlessly parsing blob objects.
> 
>   Comments?
>   source: <20251209014900.402637-1-aplattner@nvidia.com>
Jeff King said v2 of the patch looked good to him but recommended 
splitting it into two changes. I don't know if he wanted to review v3 or 
if he was okay with it based on his comments on v2. The only differences 
in v3 are the commit count and descriptions.

-- Aaron
