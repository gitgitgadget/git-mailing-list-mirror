Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010023.outbound.protection.outlook.com [52.103.33.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3F2E1F02
	for <git@vger.kernel.org>; Mon, 18 May 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122237; cv=fail; b=kBXBDDyfRG3tT20b8M50Y2LQs9xprAhdBBwovKDFGs4ssxwXme4GEzeN001BIbtUPad9jpCJrIqaL9z6+N53GQJWaVXYCoqYWL3gvWE2plpyOjO8xrG5tFFf8whcvwvA6MRdg5j+k7InGrGqGmmGJdfEfu28myi+hEgrkn25Sbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122237; c=relaxed/simple;
	bh=efdqn2vhqLjvLo9zPnkxPO1lGU3+NL59uBtIoffQcJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=deuui/NtJqN0Z60zyLUX5aRSO7JEv17dxc38rr0ACBSHUFb9bOZrsBXceIxuJ5qhLNY+tAczO0tYcaPwZgH8Bp6kO6zV5r4DsHCLy9Eb2dbn8HGQYbbYemI8X2uIjDbhidBsaIEE+9hApSI1Nm5M8n3Ivpcafq/LQKuWbY9Xa+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rCw4iUCx; arc=fail smtp.client-ip=52.103.33.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rCw4iUCx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0P3OPo0U4yPOisBzHrtrEHVuxMyzDzFhGHxv1jATaAKzaJhpLDg7tu3n/uYBgLAz3df9UTxXXfNX2rP7l8DaIGilY07mXi/2hUJGYhhT5R8M9bMTcBAb21OG+yxCaY3hl4hYA3lbYfjzeWnJSnQCfJvExL6nrqp6daNybwR7W8zQKYV52Z2XN/ZBaQsXJVqsD5Xild64cSDr2IMktNbTJDL35TVZTTApjYKF3nttzi9a3ur86EhvmT2tp24pYdCt+CiT3Hy2eFDSDmL+3/YkIYQ8n0hFpdLGl//H517Zsv92klHO7Km+jFxMbg6JLaUKH66720K/T+qvT6b6wjAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+ygldZYmNOuEI6KOVjbOsopGUQkwaJgRczOQSNG0lU=;
 b=B/wIHEApB76DieVnNnaBflAEx8wtK3CSfhR5GI9zX0Gt7iBpHr80lmbwRRES+fVchRTw+HYiZzxTHfeKGyAhIkpJlvzOguzcajR+9R1d1Zj3/rSqRa4J8j922KFRUdPbsyEH2e28u8W5H6T8wZVFmIf+sfLHZjbg+jbLtsVBWtAtZlvrGPPhKVcR1RaM17G5OTFTKAtUy24+3vt9hTTJLyU1qXt595OUgf7SFefMM6nDNxxc3a0uNvgzVZ+NPi7zTeYGrgEADk1DgxPnSbgwKkhJ/k1JNgI92onw/iPRD1CEicUSmmkcP1FteE/LyHw1LVz87XOIgZAEF9+heA2wqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+ygldZYmNOuEI6KOVjbOsopGUQkwaJgRczOQSNG0lU=;
 b=rCw4iUCxWDeBhQQeZ0RH0mVHOO9kVTZOk1Vrs1h05t91njKDTe96ikY0llWBLLwAl7N2+gtIbie2B4s0SvIUn9OFSQ3dZQRejWAvJfzs7/KC1vdJAojFkrdntzHOExgubOg01+Iima54kSd0Gnogz3zzQ3PPqtEBSv9NuuTA8dH3kHM4hkQk3LqItAQcRmNr1St2yt7LXyqaPKP81wDcz+9MUpOFmGoSdiz5eJ4PGsWoA9xx8m3vUx5vpojisD4WnJ9oiqvHCQDMLilYaFKIOEorYW5xecofpffAIhtk4YHjD35UR8ZhNFFtZweGDDiVoAriY341Z+nc3FAmHyZBJQ==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by VI0PR03MB11918.eurprd03.prod.outlook.com
 (2603:10a6:800:343::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:37:12 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 16:37:12 +0000
Message-ID:
 <VI0PR03MB11634EBA78136AEC14CF4AF8BC0032@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Mon, 18 May 2026 17:37:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] fetch: add --negotiation-restrict option
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
 <7836a2d6a537cdee419625e4eb43b94d599590c2.1778762495.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <7836a2d6a537cdee419625e4eb43b94d599590c2.1778762495.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <ef467aee-60e9-49f8-8f4f-5e54c8e26dc5@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|VI0PR03MB11918:EE_
X-MS-Office365-Filtering-Correlation-Id: ec17a765-7e52-48fe-e07e-08deb4fbb680
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLQ65JHxOKBAnHTP2G7hs4ROKy9IhQOLqxW35FIjCgK6jt2kNTz1EtBkEfQLKStxbYT9FBs8xS/9d/M131k2AEPEUhfounqGs2UI3QjAV9FAm7B5fBtGQfLdpdriHNOMywwT6v7n6b7U6J+ooEIYb5YQqAr0xgB61ODbKDw3HrNNU7yR2BTz5PfHH0uXz4d5BoaznahKc9VPtNmjqLpWWt3JViCC9d329kWQ70kZl3rLQB7Fz5xgouZD+K6EUSugvdKFj7iNFOU5ejpgEitHZ8KWOfLHluB4L6q8lQsi2OrYuWQqPF5frHeNPtfvxln75Z7NKkI5Lf/don3EDfx4wpWXnFtf/yQFUcFEsl708PwFBULY0tZ1JaKY8ACNFnQG9JHAGnbitUfI4Hq1AGwLleyYdRUDOyuyVyK85E5+WiG9Q7dwz/lxhYMftJMTH5hJVVaEBtU8pTsNmls3zMxdGK6tj1qgtuDHxSNfb5LwkWOkki7trdAaz2n9u0zcpgAPoWEpKrbF3uCzv4acQv6VOlg3iBb2StFBucJjBUoiIHPyVKhrFbmxJ5sm4Z/tPGZRt+BNUFpkhuSNKhrR2hnj/tXj9224EaRSY3mhEWTQFZHoVdWGZeG1xx5jmU9bbcaF8W2Ao3dcvEQ9tnJ9QS0Ino4TOXU95Eku3xoqC1VOQQ1qWNI3YbffFHk6dPV3GZI7dTsN8QJN21wctxQTqt4fXOQLQzI2DqYo7GpqSErC+hdzR6hnYsRqf7a54uczbwG4lL8OsZ4ndkyXqcNOXvpft4mR
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|41001999006|23021999003|5072599009|24021099003|51005399006|37011999003|12121999013|8060799015|19110799012|15080799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEJKcmNUK1VnS01HM3B3eFpQb0lsVzVkYWU3a3BLNG1ZdXpZOFVySEg4U0lh?=
 =?utf-8?B?T0JoUUpTK0haZG91UnA4Y3NVb0hhUWt0RGxnSHpEM1dxNlFTK2pKKzNWOXBO?=
 =?utf-8?B?L1pYK2JzY0FSSG9MTTNWczFMcG9kMjdhNlhCWjdpeTFISHIzQVQwcm5PamM5?=
 =?utf-8?B?NitObVh6OGVNdmZCenFDMFpFMndTMUpBK0RUMGVLWEJwaWlDcjUvbEJINTRl?=
 =?utf-8?B?cWd3c2pZVnhiclpmUW5YT05ib2g2aU1HcEVGRGtOYTQveGN4dW5pQ0xOT1pY?=
 =?utf-8?B?K3F4czZKQURwbTA3R2t5VzJzdSt3cFkxeFVYWHY4VVJva3ZnaThrWnlyZ1Nm?=
 =?utf-8?B?RkNkU0FoK3FURDhUbWlTdzR0S1k1Mkd0SXpiMWhnaG5TdEo1TjYrY1h2L1Zs?=
 =?utf-8?B?cTU1Y0drWmlxUHRGUTdBelpxK3J4L3lJZzg2RXpmcENtZFVBTmRoLy9KQklW?=
 =?utf-8?B?ajJPZmhzM1hSZi9uZDV1ZnZWUzVtdWR3dzZMRm1pbU5FMHNDMUpXZGVDbTIz?=
 =?utf-8?B?TGprMHdwWU5pSDVBeEpoeVVQVGRYbXg5U2grNGNaUEN3OHFzanFyMnpMd1NW?=
 =?utf-8?B?eEtxMXp4aFlWNDlUdE11UncvekQwZ1M3NjJDZk5FNEFQZS9UemgyQmxuUWxn?=
 =?utf-8?B?MUwvMDVXQnk3S0VudEhiSXpZM2ErVHNHREdmejhoYjhZVGtyS29WUzVaYjR3?=
 =?utf-8?B?KzRuM2Q2Vy8vQXZPQ3lOSExPNGNTSHZtZjJLRkFGK1FjbkFqUTJaenhTY3Bo?=
 =?utf-8?B?cEI3MEJEQWVOZ2hFTWlxaHA5dDZLWi9Jekk2eHgwN3kyN1BNMnBtMGN0WmJO?=
 =?utf-8?B?OHovNVMranNTcDRQWnVoNXp2bXAzb3lYL1hmL0VOTmxWZVVjMGtRQ2FMWE1x?=
 =?utf-8?B?WFpWNmd2TVpVY1g0S2F2dzB5MTlITitLS3BCSVF5SG5mcmZreUJFWkwydDUz?=
 =?utf-8?B?YnMrYTRkd0s3VWEwTXNhc0x2QjJtK2pFVERZajVKK0Y2ZjlmZXZERGY0R0t4?=
 =?utf-8?B?WHlFdUNMbmt0WkRmWGtSNGMxQ01jR3M1OXA3eDA5Z1Q1aVZtTHRXb28vdDFy?=
 =?utf-8?B?Nm5NM0lWTmRTdW93MVZ3dURNclh2b2RPdUp4aHBVNElsV2wvVEFXdkRNNVRU?=
 =?utf-8?B?NTAxOVhwWnpDSmNZRlR0MHoxTEFldUJFeWpRaDAzTlFWQjVPc1d5SkYwS0Uv?=
 =?utf-8?B?aWdVMVVFamJ2NWY2aytnR0c3WlVFNWdUUlJxL1JVTnJYdEpnamFjNWU4ZkVE?=
 =?utf-8?B?cU5MYWNaZEkvQmU2THFZR2cvV21XK0dZUUVnREJ0THFOUjFMRDhHb3BCdXEv?=
 =?utf-8?B?alZvOFloVGZKYytCeVkvbWptbnFhaFdhbnIxRXV0Z1hhUzZrUnF1RHh3TGRa?=
 =?utf-8?B?aytGYlQ2SUk3OHJ1TUdsNTdGbDd6OWQ2K0RoVmNQc3hoam5QeThJOEhQQzJP?=
 =?utf-8?Q?SK7gBjMc?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0l1b0ZpakJmSkVOL2JEb2hEQXBXdThTM014YjFCcHR2QTA0YmlqMlFrZ1Br?=
 =?utf-8?B?YUc1R1NLNEFaSU1IZHNuc01JdFlxMUpGOVlaN3pTWDl6OXRrSkVyVUpDaUxD?=
 =?utf-8?B?UDlJVnFpVmhwbWNRM3BzZEZLTzlFSThHNW85R1JKc2dWZk5PT1p2WE50QmRN?=
 =?utf-8?B?eGpGQWZUd0NvcUNqTkhtc1htc1ZNYXk2cXRUd0gvTmJFcENLQ2RNeEhLc1Bs?=
 =?utf-8?B?bmIvWk55SUd1dmJxTmM1OGtvSmlLWjVLdWhucDduUUFNVVZ4Tk1RVUFiZjNx?=
 =?utf-8?B?UlBVQmozMlBiemo4U1h2dXhmYmdENVVBMEVoUVdjTUJLdTVBd2JNVlM4dVBn?=
 =?utf-8?B?QkRnYjdDclg4Y0YzOWkwMjRDZVZDS2Z2YjJwbVVoem5GQmtDL3U2V0RhVHBh?=
 =?utf-8?B?a2J3WHhjbitGenM5T2lNV1dwZ2dLcmJmQzlmTGQ4YnFtZzRwYVF4anhIQ21U?=
 =?utf-8?B?eTdwQmd6YmdLNmhQNThPbUEzTXJKK2ZGMytmTG02THZYUHp6eFZ6QU02ZnVu?=
 =?utf-8?B?dWgwV1ZzK3owYlNiTm4zNFRLNDRwT2Rlak9MZzN5YkdvdUI2bW5rV3MwTXlW?=
 =?utf-8?B?UWlMbGxqNHNoTUd2eG1PbW9GWGZvRFc3ajN1WElJM2oxRTQvWnlJRXZVUmNL?=
 =?utf-8?B?cnlwUG5iVVVhU29aVkdqenVRSWtmTGNKejBNVzN2dDF4M2hnRDBBRVZ0RW5X?=
 =?utf-8?B?TWpicXRmRTlwUExrKzQ0T3RQZng4Y3dGbnkvNHNGcXE0dFRNRStpakpzcFIr?=
 =?utf-8?B?R2dEWXZwRUp0M0k4RUxNZmRaL1UzaXg1ZFdLcjZsMGM2eDRwRC9UbkdidERV?=
 =?utf-8?B?RjhuRlE2eEJVcDJpVkFzdjBQZTYvb0F6NkdvZUd6YWRlaEZpR1pwQUl5cEN3?=
 =?utf-8?B?YlpoUWJiNmIxU09UTk9rNVBrMzFzdGZxOExnbkZIbnY3aUMxRjIxeGlqOXZs?=
 =?utf-8?B?OFZjZ09GYTBja2pqK2RvV1RWRGJreHhPUGdGczQvQ3VJc3RzR1U1RmE0ankw?=
 =?utf-8?B?SnVKeWRPU092dUdWQ1Iyb05UOUM4LzBLTmhNL1lKOXhMd2xnaStxWUZjaGRI?=
 =?utf-8?B?dzl0bkFGOWJmQWZsbXZucHFhWFora1BPMG1MbGFBc0x4U3I0bEZMdG1QSEsv?=
 =?utf-8?B?ODRZRjkwenFJZDc1SlIya3craVNXMTQ1TFFFVCtWK1psQkw5NjVxZkN1WStF?=
 =?utf-8?B?aDVHZTJTdXdaNmNWTlZjT0lRbjdPWXkyTWl1YjBWKzA4Y2dYSUgxa25vSURP?=
 =?utf-8?B?L3VBM0MxRk5ERzJ5Z3JGbkFUMis1MDhKaWNEZ2ppUmV2S2lFSmFLV1F2UXJz?=
 =?utf-8?B?S0JBL1QreDBkN2xoOEtOQVRVWUZZTGI2c3BvQ3NiWE9BeXUvaWVlZWpxSHBu?=
 =?utf-8?B?TVJ6NUxyV28xbU9keDd0YjdWQ3h5bi9IMzQ5MnQ2UEVYS1FxL3VQK0tNZnZl?=
 =?utf-8?B?aE5xd0E2czJHYU1hSGVaZEVqQnhJWW1OeHlTUVRISnFxSnlQSjFYd0dhdzI4?=
 =?utf-8?B?Qk4zcnVVUmZJUTNiaTVRS3hNZStvbmx2SnhFR1Q4TzNLa2VLclFGdUxtTnBJ?=
 =?utf-8?B?cDJZUXdtQ2tYTW1lSFVQMVZWR2dwS1hGaldjQnZuV2pETkMySmpySmx2NE02?=
 =?utf-8?B?aHBaakRlWEhxRTNja2NUMjlIQ2ZURnFETlRLQTZWczNrQ0hvUkpScC82U1Vu?=
 =?utf-8?B?RWFVa01BeUNBTTdkL2krRXZVczM1N1FPRVhEODlEN1k4ckxLaGkyem1GVnU2?=
 =?utf-8?B?Qmhvend3dHFBeEgvSWFBM2kya1ozU1hoUE5WYXZaNkR4TDFIZjJKYmF3VTM2?=
 =?utf-8?B?QzREQUhKNVhHZ3pvKyszenFFTmJ0QnhuYW9SUHlxU2l3ZHFXa3FyMzhsUDNn?=
 =?utf-8?Q?ZBunrLHBXhLwR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec17a765-7e52-48fe-e07e-08deb4fbb680
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:37:12.7594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11918

On 2026-05-14 13:41, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> The --negotiation-tip option to 'git fetch' and 'git pull' allows users
> to specify that they want to focus negotiation on a small set of
> references. This is a _restriction_ on the negotiation set, helping to
> focus the negotiation when the ref count is high. However, it doesn't
> allow for the ability to opportunistically select references beyond that
> list.
> 
> This subtle detail that this is a 'maximum set' and not a 'minimum set'
> is not immediately clear from the option name. This makes it more
> complicated to add a new option that provides the complementary behavior
> of a minimum set.
> 
> For now, create a new synonym option, --negotiation-restrict, that
> behaves identically to --negotiation-tip. Update the documentation to
> make it clear that this new name is the preferred option, but we keep
> the old name for compatibility. Mark --negotiation-tip as an alias of the
> new, preferred option.
> 
> Update a few warning messages with the new option, but also make them
> translatable with the option name inserted by formatting. At least one
> of these messages will be reused later for a new option.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/config/fetch.adoc  |  2 +-
>   Documentation/fetch-options.adoc |  6 +++++-
>   builtin/fetch.c                  | 13 ++++++++-----
>   builtin/pull.c                   |  3 ++-
>   send-pack.c                      |  2 +-
>   t/t5510-fetch.sh                 | 25 +++++++++++++++++++++++++
>   t/t5702-protocol-v2.sh           |  4 ++--
>   transport-helper.c               |  3 ++-
>   8 files changed, 46 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
> index cd40db0cad..04ac90912d 100644
> --- a/Documentation/config/fetch.adoc
> +++ b/Documentation/config/fetch.adoc
> @@ -76,7 +76,7 @@
>   	default is `skipping`.  Unknown values will cause `git fetch` to
>   	error out.
>   +
> -See also the `--negotiate-only` and `--negotiation-tip` options to
> +See also the `--negotiate-only` and `--negotiation-restrict` options to
>   linkgit:git-fetch[1].

Good - this addressed my nit in v4 about mentioning the old name here.

>   `fetch.showForcedUpdates`::
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 81a9d7f9bb..d39cecb446 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -49,6 +49,7 @@ the current repository has the same history as the source repository.
>   	`.git/shallow`. This option updates `.git/shallow` and accepts such
>   	refs.
>   
> +`--negotiation-restrict=(<commit>|<glob>)`::
>   `--negotiation-tip=(<commit>|<glob>)`::
>   	By default, Git will report, to the server, commits reachable
>   	from all local refs to find common commits in an attempt to
> @@ -58,6 +59,9 @@ the current repository has the same history as the source repository.
>   	local ref is likely to have commits in common with the
>   	upstream ref being fetched.
>   +
> +`--negotiation-restrict` is the preferred name for this option;
> +`--negotiation-tip` is accepted as a synonym.
> ++
>   This option may be specified more than once; if so, Git will report
>   commits reachable from any of the given commits.
>   +
> @@ -71,7 +75,7 @@ configuration variables documented in linkgit:git-config[1], and the
>   
>   `--negotiate-only`::
>   	Do not fetch anything from the server, and instead print the
> -	ancestors of the provided `--negotiation-tip=` arguments,
> +	ancestors of the provided `--negotiation-restrict=` arguments,
>   	which we have in common with the server.
>   +
>   This is incompatible with `--recurse-submodules=(yes|on-demand)`.

Good! The --negotiate-only paragraph now uses --negotiate-restrict too.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4795b2a13c..fc950fe35b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1558,8 +1558,8 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
>   		refs_for_each_ref_ext(get_main_ref_store(the_repository),
>   				      add_oid, oids, &opts);
>   		if (old_nr == oids->nr)
> -			warning("ignoring --negotiation-tip=%s because it does not match any refs",
> -				s);
> +			warning(_("ignoring %s=%s because it does not match any refs"),
> +				"--negotiation-restrict", s);
>   	}
>   	smart_options->negotiation_tips = oids;
>   }
> @@ -1599,7 +1599,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		if (transport->smart_options)
>   			add_negotiation_tips(transport->smart_options);
>   		else
> -			warning("ignoring --negotiation-tip because the protocol does not support it");
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				"--negotiation-restrict");
>   	}
>   	return transport;
>   }
> @@ -2565,8 +2566,9 @@ int cmd_fetch(int argc,
>   			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
>   		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
>   		OPT_IPVERSION(&family),
> -		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
>   				N_("report that we have only objects reachable from this object")),
> +		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
>   		OPT_BOOL(0, "negotiate-only", &negotiate_only,
>   			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
>   		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> @@ -2657,7 +2659,8 @@ int cmd_fetch(int argc,
>   	}
>   
>   	if (negotiate_only && !negotiation_tip.nr)
> -		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
> +		die(_("%s needs one or more %s"), "--negotiate-only",
> +		    "--negotiation-restrict=*");
>   
>   	if (deepen_relative) {
>   		if (deepen_relative < 0)

Unchanged from v3: OPT_ALIAS keeps back-compat and messages are i18n
friendly. Nice.

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 7e67fdce97..cc6ce485fc 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -996,9 +996,10 @@ int cmd_pull(int argc,
>   		OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
>   			N_("use IPv6 addresses only"),
>   			PARSE_OPT_NOARG),
> -		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
> +		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
>   			N_("report that we have only objects reachable from this object"),
>   			0),
> +		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
>   		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>   			 N_("check for forced-updates on all updated branches")),
>   		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,

Oh nice! v3 had two OPT_PASSTHRU_ARGV (one for each name). Now we're
using OPT_ALIAS here too for the old name which avoids duplicated
description strings - yay!

I had to convince myself this works (does OPT_ALIAS forward to the
passthru option?). Looking at parse-options.c, preprocess_options()
substitutes the alias with a copy of the source option keeping only
the alias's long_name. So really the child proc will get the old
--negotiate-tip name but the child has an alias anyway.. works fine.

> diff --git a/send-pack.c b/send-pack.c
> index 67d6987b1c..3d5d36ba3b 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -447,7 +447,7 @@ static void get_commons_through_negotiation(struct repository *r,
>   	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
>   	for (ref = remote_refs; ref; ref = ref->next) {
>   		if (!is_null_oid(&ref->new_oid)) {
> -			strvec_pushf(&child.args, "--negotiation-tip=%s",
> +			strvec_pushf(&child.args, "--negotiation-restrict=%s",
>   				     oid_to_hex(&ref->new_oid));
>   			nr_negotiation_tip++;
>   		}

Good. v3 was using the old name when shelling out (just a nit), but
nicer to have the rename fully consistent.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 5dcb4b51a4..dc3ce56d84 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1460,6 +1460,31 @@ EOF
>   	test_cmp fatal-expect fatal-actual
>   '
>   
> +test_expect_success '--negotiation-restrict limits "have" lines sent' '
> +	setup_negotiation_tip server server 0 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 --negotiation-restrict=beta_1 \
> +		origin alpha_s beta_s &&
> +	check_negotiation_tip
> +'
> +
> +test_expect_success '--negotiation-restrict understands globs' '
> +	setup_negotiation_tip server server 0 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=*_1 \
> +		origin alpha_s beta_s &&
> +	check_negotiation_tip
> +'
> +
> +test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed' '
> +	setup_negotiation_tip server server 0 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		--negotiation-tip=beta_1 \
> +		origin alpha_s beta_s &&
> +	check_negotiation_tip
> +'
> +
>   test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
>   	git init df-conflict &&
>   	(
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index f826ac46a5..9f6cf4142d 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -869,14 +869,14 @@ setup_negotiate_only () {
>   	test_commit -C client three
>   }
>   
> -test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
> +test_expect_success 'usage: --negotiate-only without --negotiation-restrict' '
>   	SERVER="server" &&
>   	URI="file://$(pwd)/server" &&
>   
>   	setup_negotiate_only "$SERVER" "$URI" &&
>   
>   	cat >err.expect <<-\EOF &&
> -	fatal: --negotiate-only needs one or more --negotiation-tip=*
> +	fatal: --negotiate-only needs one or more --negotiation-restrict=*
>   	EOF
>   
>   	test_must_fail git -c protocol.version=2 -C client fetch \

Unchanged from v3 - still good!

> diff --git a/transport-helper.c b/transport-helper.c
> index 4d95d84f9e..dd78d40668 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -755,7 +755,8 @@ static int fetch_refs(struct transport *transport,
>   	}
>   
>   	if (data->transport_options.negotiation_tips)
> -		warning("Ignoring --negotiation-tip because the protocol does not support it.");
> +		warning(_("ignoring %s because the protocol does not support it."),
> +			"--negotiation-restrict");

Good - picks up a missed rename from v3.

>   	if (data->fetch)
>   		return fetch_with_fetch(transport, nr_heads, to_fetch);

Overall this patch LGTM! All my v3 issues were addressed.

Thanks,
Matthew

