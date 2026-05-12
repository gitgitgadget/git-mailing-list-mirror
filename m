Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011030.outbound.protection.outlook.com [52.103.39.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235593B992C
	for <git@vger.kernel.org>; Tue, 12 May 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596715; cv=fail; b=sEfg5p8wLOycG68nNMwhc93ewxq7RaMkcOCGcoD8xBgwuyzlsQwUsi+Q906eGNeKyOWury6WQVkdK15u2GVl21L6JflCLBJpcPzW6+dI3zHW4yxYCM2/VyZbeXS7v8xQ5V6gnBVtU44fQnDKZjmx0GhNPAsdSd1N9IRLTTJ5L4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596715; c=relaxed/simple;
	bh=jOpbhDg6Ga/7fq+tCQC7AAjZUrzyJ8pH4Pu3dQqAQgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTtxL379afOKrS2gD4vfm/yh7Toia8EGgG3Kx8U+T9VvRa/opX5ZaHty/MO3M6TqcW2BykzIcNt7ayd8X939BO8402iQ8IAshrj5w73uCoUbpAM7Bdlr39Eebof5A6q6jPk9i1KgYygsKar8cXjIpLSdSdeom/TfcGsBQVQhmDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=a7D3orGi; arc=fail smtp.client-ip=52.103.39.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="a7D3orGi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFqN+j0pb7Q0AdEuR+bMabS25VCCrnwRG4xXx87JIe5dQqk8K8O4tQUzAV6lwjjOpqMtAjURSbWzWFYs8TxMCdnScQxisdY09b/ksrsO9PfDrjW3dwt4OUy4EDuiicIODsRnsdARaARk51P5MyncrrRBLVdf+x3FwW9Gz0WL40BvkofEZGnqt9pkn+0GN1Y3+jlHYJ3skuDzfc2RSwb6c4m7ypvaZdlOd7fdg4Lc5WYvzX79sh6lftdE37GyYZcD4fYNNBnUC347u4MRVHz9YHB26M/CLwHZv3as7u0dFisjLqYiAZCCfbTF/ExO0+icdagZhQM9WQLTwngdCpkBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzC1AeyDC4dBriIohWt9LBxwoLTZCc7j759X2LAcft4=;
 b=wlYdqQh3NgSyRfrRwzYvfrw7rCZNWaeOELsVudh//DyWC1aZvMHo3xE59MSG3wtAf2ZlSkNfeTPWlsgFZFVjYM1T98Xq5zQzXp5bgCra3L+Gf8OF/k72TN713SoQJyu+yoCQLMcUT3TzWWeUPOQUL5mzHBUQM19LP1hNidRTDAVF2o2QrQ37Ch4kqyU5I9HFwZcFbhioDgu8tVmFQ6nu7BT/g+YylN7FVRtDX09x7IMEIgh1hqY2qeDsfCvWwuERqO9YapBRUHVVS46/jtVcRaQ+BVVhJEdfpjx2CdxdoVjta1bFXzNLnccxmCcDCZLwVHKtW+XK/QoGL/Wl/ZFI+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzC1AeyDC4dBriIohWt9LBxwoLTZCc7j759X2LAcft4=;
 b=a7D3orGi8o7H4OzU6usB9SsPid+GPauxXwS92E2hLp0zNmM5ihB+utpE8ghwDWZeS4woseN2lBaLwahNpQ/CeOcIYwJQCixIGMHrp18pJhi1jFgxXTA5A3iRkjbXBS7iO2R8DIEtB46AqCuFIyxCqZobBVT9rLtkpIWZpgWBZcDQvHfnJOvGBJ9mVu6sdDzpOO6LszqKxX4jJP6B99EFBDv9t8OjApmWtCY1QMuue58mDu4ZnQHNxWjbpuZorCTFBF0T6H9mPCnGEJbg5PbFYNXDC5qT4mIWfBukCEjjgixT4ePIT+viIiNa+r9+j7NzHCZrbJ7sMQBWJ579aODQLQ==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by GV1PR03MB9872.eurprd03.prod.outlook.com
 (2603:10a6:150:8b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 14:38:29 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 14:38:29 +0000
Message-ID:
 <VI0PR03MB1163403743E62E0FDC4AFE52DC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 15:38:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] fetch: add --negotiation-include option for
 negotiation
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <ae81ef36a1b3ca04e39e891cce827fa55540b9bb.1776871546.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <ae81ef36a1b3ca04e39e891cce827fa55540b9bb.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::15) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <a7e094bf-c772-4eee-9e53-c9eeed549a8d@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|GV1PR03MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: 52bd0cab-f60e-4f49-d139-08deb034221d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|5072599009|6090799003|12121999013|37011999003|23021999003|15080799012|8060799015|41001999006|19110799012|56899033|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3hTZ3lkUStoN3NuYlQ2RHdCQzArd01jeVgzYlVHUVkrTjBRL01KNDNUeWVE?=
 =?utf-8?B?RmFOT1NDNWtuV1Qyb2dEWjNoYjN0cEpGK3NWU2l1T2kxR3BaWG16emZHcXVS?=
 =?utf-8?B?WndPZ1BHaWVYNXdnWmhna1VkaEkzREQwK1B5d0NvOHBnNmNycXR5S1FDNzQ4?=
 =?utf-8?B?dndFdzJCY3ZlOXN6Yk5jbjNLRk9JMHV1WlpLZTAyNFJwZmtIbDlwOUZ5a0RI?=
 =?utf-8?B?bUdrcHZWTnFvVzd5VzJUVEYyTlh0L21zd1BWUmIvOSt0ZENOUVNtdDBMaHE4?=
 =?utf-8?B?bW1IaklxazRSdUdvaytXL2dSUEJxaW1kcXVMclZVY0FIZXE0WlI1OEY0UkU0?=
 =?utf-8?B?bHd1RFBxS1FUTW15a3dEWlNOM0pjN1h0V1dPSndFVXowMDZYZXpYeTY3Tm4z?=
 =?utf-8?B?MWVVU1hzSGN5TjU3REJpKzM3RkMwRklYa3JaMzF2OW42UXJWZDBCeHIvZ0sx?=
 =?utf-8?B?NXp1NjIybEpkb0hubHZpYUpMQU1JM21Ua3BCdHJpdXg0SWVuci9WLzlyUndh?=
 =?utf-8?B?MDFGTlB2K2ZFNTJWWUtrZGFvNFdEOEFYWTN0d0VzUFZVZ0Y2ampWdEQ0WFpp?=
 =?utf-8?B?eG5ESGdPZE9TVlhBWGxqQXZyMkRlM0M1MVZvVkpPUjFHN0FrakdwemdndmRj?=
 =?utf-8?B?eTdGbkVadlp5clc3MmxxYmFaVUQ0allBOXEzV1pIbHVaOVMwWXlpQWRhNDY1?=
 =?utf-8?B?MDd4SmxqblR2dlBCNGV0c0ZrcmNjVVJRa3cvdlZJSEltYWpIeGpuQUlSdzVt?=
 =?utf-8?B?dHJNd3V2TEtaZjg5QTRXcTcvV3piZmV3Sjl4YmtLeVkxbDRvdnhNZTViZTRq?=
 =?utf-8?B?MExRRDRweFRtK254NldyVUk1ZWo1cThURWpoSHptWWl6Q2lYUCthZU4zU2pK?=
 =?utf-8?B?YkxQbVJGQjdUcHZiZzRNQ3phb1duWXNlTXpadU9GeFdrL01IVS9oS0pJUG1K?=
 =?utf-8?B?NWhnU0JabmU4dVBLQ2x1OG1wYmpuY0RBaXpIamZYZXhFTnJWT1pKaEdSUVBr?=
 =?utf-8?B?dFJVNDY2dzRWN3BHcGQwYmNwdGJqWWxyeUFEUnhQcitmUUpMdDZCK25lMkVZ?=
 =?utf-8?B?cVMwWTZBdlpZM3N3K2E3YWRoTFV3cFo3TFJELytiTW93RldQRFp2U0Fua1RR?=
 =?utf-8?B?ZVd1Ny9zTUVYMEJ1dkwrTzJNV0o4c3ptTzhHMW1OS0lPTWVGV2pxNVBQYy9s?=
 =?utf-8?B?RzAybm1OSVFkd082Y1JJNkZwWFFTZEFmZU5FMEg0Q25FQ0d1VnFacDMrTGEr?=
 =?utf-8?B?ckEwUFMyR1QyN0p1a25hV3pIUFE0RVBaKytRaXhLcTAzNkpwdEJsRWhqbkVX?=
 =?utf-8?B?aHRnb0ZBeGxlY1RFT0RPai9weVNySFNYWHlXM3Bnay9laTBxMHM3R0JsaDJ0?=
 =?utf-8?B?VUg0ZDUxSGtGWnRjc3RzaTc3MVg2SmdSdDM4YU85YWVCV2ZjeWlXZGZ3TkVk?=
 =?utf-8?B?MW1Nd2x0N2pGczdQU1FEbHo2U05lZHpITjVGQVRBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVNNRDRaUGZoaFhSR0FRemsyNnlHNUpOeGJEdGgxT0wzaHJHUUJidGRIUXJI?=
 =?utf-8?B?NlRPUmhwbHJycUplaVNqV3hTT1QyRHdpMkU2eFVHWEcvRDk5NEFxZjFkWkpG?=
 =?utf-8?B?WDNadmZZbGtmbUowUEkyZXZyS2FHTjhhS3lROVBCS25nckE5RVZlVUNwbm8v?=
 =?utf-8?B?OHkvNlIyT3VjZDZwajdZVlVmZVZtdjFNTFVPQkExWG5zcisvblgxbW5pbVFH?=
 =?utf-8?B?ZXhjaVNMRi90YlJ4QkZGRStBVWx6WUljUVZCdGZPajJhd1pNeGxweVFjUlpE?=
 =?utf-8?B?cTNvdExMNnl1by9mR2drRVJHb3lCeTd6MXZWclhZR3NIbm1xSHl0NTI3Mjh2?=
 =?utf-8?B?TmxOa1ZIK3lxM0pRSlRmRzdjSlF2b1l3UjJBNHdrNXFKZEhkSFpFUWkxMFRD?=
 =?utf-8?B?cWg3SC9ReGludjc2TDZ4UzMybTJhb2dBY29HNHc3eHFqZmtnVng0VzE0Y3FS?=
 =?utf-8?B?bUlPaDhaY0dDOGloWnZuRXJveTRpSldSVTg5Z2s4Qk1mTmFDWFJLMGFvUVJ6?=
 =?utf-8?B?NWNTc2NIZFhMYVpTRm1ZTEJZV3FKTWcybFUwMW1SL2oxRUN0eXA3dUV1NDgw?=
 =?utf-8?B?Q3d6WXlHVEZua25BQ01RQ2dIUFRSUWs2Sk1VZFhwWWN4ekpMT1gvcFhIeXY5?=
 =?utf-8?B?MWRzWCtRcUxnV2ZKOERibWdGZGo5dXM5cHhPTytQOE5SV2pwVzlxeG5DMnBs?=
 =?utf-8?B?eEI1cVJwZEtTWUIyNTdqdEtrTUdYUHhLc1dsVGNJbUZBZmc2MDVKZmszZ2VG?=
 =?utf-8?B?VVFHZ295ZFc4REg1VTZBcnJTTFZmM1JLNTVWU0xnNmZVd3JIMDlUYmg1UTVH?=
 =?utf-8?B?bjE1SGRtZFVnN2Rsb1VSWlJ0Tmt0OGFSdC9keXh4SFJKV0Z3V0VYK2VlZ0xG?=
 =?utf-8?B?K2lTTzNtNmpTV1gzdUwxSXBNSzJIRjMxZjFTL3FnSXBFZ3dMekRTK3ZwZ1RM?=
 =?utf-8?B?eHNlY3R2cXFFSFpnWHF2WVBpVS9BYTRNM0M4Vm8zVFVEeUQ2UVF5N3hldVVQ?=
 =?utf-8?B?OUlTR2F3dEZzRWg1WVRXSlFVOUhObkpOSDhhZ0xITmJHeW91eVQ3VmE5bGoz?=
 =?utf-8?B?VFRtcndKWE5iS2tKdmR2bUM5WWtUcFdSclV5VjZhVUtiT2pKa1ZDdEN6cFpO?=
 =?utf-8?B?b0lMM0srV3ZPd09BNFFSZ2xWWjZDZHdIWjV2K0FTRkFtVUhPaVJZYTEwT3pS?=
 =?utf-8?B?c0RydTVyZmN0T0RRK0R3V0dSam12SGxjZ3dyNTRIRjJWaUpaU1VENWJlaFRx?=
 =?utf-8?B?bFJuUEZlRnY3VWJKTWpNSDJkWENvQVlKOU9ZaFBzbTRsV3NRU2VLVDFteElP?=
 =?utf-8?B?dWU2OFQ3eS9OSkcxQmNoV2RPMEphWnBTeEI1YVpMODh2YjYxeDE0SnNJZTk2?=
 =?utf-8?B?QVBFSjFQZXZnUERleDlpL2duNmVVelVoL2xOcGJYYjNpVS91ODRDcUFZUzNi?=
 =?utf-8?B?STVXdFk2Z0ZxZVdQVXlNelRqNFJFb0RlNG1lQXBsek5zWUlVR3A1ZjBOeXRT?=
 =?utf-8?B?RzJrVUdZMGZ5UTZxSExoOE84bjYwaURFYUZqVi92NFdZSDM3NDdhTHFwT2hx?=
 =?utf-8?B?TnhMQmJFQ3RtdTJhME1SL3R6cjRMdlFrY2R6RXhOZW9nTktxSEF3ekNZWnky?=
 =?utf-8?B?N21zQWQwbEd1ellNVVhTMmtnbHNzV3ZZS1dYMXQ0UTlrbW5JSHRjSVBsRnYv?=
 =?utf-8?B?R2xLN2lVdm5zc1FBRFI2R2gydDRkRTc4Q0FHdjR6QzB1TFVlWldPa2N2TUVh?=
 =?utf-8?B?Ym02a0cvNC9naHprc2hjZ0JKL2ZkTklsZUpldVR1Yzh3MldDRGNLcmg3VTlS?=
 =?utf-8?B?cHpJN0hpcS93azJkS2dxSXVLT1FhZGtGUDVQRDhVN2xHZ2xyUlA3bjVEUDRu?=
 =?utf-8?Q?9ER9FHepNHWjW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52bd0cab-f60e-4f49-d139-08deb034221d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:38:29.3744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB9872

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> Add a new --negotiation-include option to 'git fetch', which ensures
> that certain ref tips are always sent as 'have' lines during fetch
> negotiation, regardless of what the negotiation algorithm selects.
> 
> This is useful when the repository has a large number of references, so
> the normal negotiation algorithm truncates the list. This is especially
> important in repositories with long parallel commit histories. For
> example, a repo could have a 'dev' branch for development and a
> 'release' branch for released versions. If the 'dev' branch isn't
> selected for negotiation, then it's not a big deal because there are
> many in-progress development branches with a shared history. However, if
> 'release' is not selected for negotiation, then the server may think
> that this is the first time the client has asked for that reference,
> causing a full download of its parallel commit history (and any extra
> data that may be unique to that branch). This is based on a real example
> where certain fetches would grow to 60+ GB when a release branch
> updated.
> 
> This option is a complement to --negotiation-restrict, which reduces the
> negotiation ref set to a specific list. In the earlier example, using
> --negotiation-restrict to focus the negotiation to 'dev' and 'release'
> would avoid those problematic downloads, but would still not allow
> advertising potentially-relevant user brances. In this way, the
> 'include' version solves the problem I mention while allowing
> negotiation to pick other references opportunistically. The two options
> can also be combined to allow the best of both worlds.

Nice explanation and motivation for the need of such as feature.

One small typo: s/brances/branches/

> The argument may be an exact ref name or a glob pattern. Non-existent
> refs are silently ignored. This behavior is also updated in the ref matching
> logic for the related --negotiation-restrict option to match.

Calling out the intent for the behaviour change (non-existent refs are
silently ignored). This is an important point.

> The implementation outputs the requested objects as haves before the
> negotiation algorithm kicks in and performs a priority-queue walk from the
> tip commits. In order to avoid duplicates, we mark the requested objects as
> COMMON so they (and their descendants) are not output by the negotiator. The
> negotiator still outputs at least one have before a round is flushed, when
> the server could ACK to stop the negotiation.
> 
> Also add --negotiation-include to 'git pull' passthrough options.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/fetch-options.adoc |  19 ++++++
>   builtin/fetch.c                  |  16 ++++-
>   builtin/pull.c                   |   3 +
>   fetch-pack.c                     | 112 +++++++++++++++++++++++++++++--
>   fetch-pack.h                     |  10 ++-
>   t/t5510-fetch.sh                 |  66 ++++++++++++++++++
>   transport.c                      |   4 +-
>   transport.h                      |   6 ++
>   8 files changed, 227 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index c07b85499f..decc7f6abd 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
>   configuration variables documented in linkgit:git-config[1], and the
>   `--negotiate-only` option below.
>   
> +`--negotiation-include=<revision>`::
> +	Ensure that the given ref tip is always sent as a "have" line
> +	during fetch negotiation, regardless of what the negotiation
> +	algorithm selects.  This is useful to guarantee that common
> +	history reachable from specific refs is always considered, even
> +	when `--negotiation-restrict` restricts the set of tips or when
> +	the negotiation algorithm would otherwise skip them.
> ++
> +This option may be specified more than once; if so, each ref is sent
> +unconditionally.
> ++
> +The argument may be an exact ref name (e.g. `refs/heads/release`) or a
> +glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
> +is the same as for `--negotiation-restrict`.
> ++
> +If `--negotiation-restrict` is used, the have set is first restricted by
> +that option and then increased to include the tips specified by
> +`--negotiation-include`.
> +

The placeholder `<revision>` and the description in the body of "ref
name or glob" slightly disagree with each other. The 
`--negotiation-restrict` docs use `(<commit>|<glob>)` in the syntax 
definition and
"a glob on ref names, a ref, or .. SHA-1 of a commit".

`resolve_negotiation_include()` calls `repo_get_oid()` for non-globs
so bare OIDs and abbreviated SHAs work too. Perhaps consider aligning 
the syntaxes, and mention that OIDs work too.

>   `--negotiate-only`::
>   	Do not fetch anything from the server, and instead print the
>   	ancestors of the provided `--negotiation-tip=` arguments,
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a1960e3e0c..ef50e2fbe9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -99,6 +99,7 @@ static struct transport *gsecondary;
>   static struct refspec refmap = REFSPEC_INIT_FETCH;
>   static struct string_list server_options = STRING_LIST_INIT_DUP;
>   static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
> +static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
>   
>   struct fetch_config {
>   	enum display_format display_format;
> @@ -1547,10 +1548,14 @@ static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
>   		int old_nr;
>   		if (!has_glob_specials(s)) {
>   			struct object_id oid;
> +
> +			/* Ignore missing reference. */
>   			if (repo_get_oid(the_repository, s, &oid))
> -				die(_("%s is not a valid object"), s);
> +				continue;
> +			/* Fail on missing object pointed by ref. */
>   			if (!odb_has_object(the_repository->objects, &oid, 0))
>   				die(_("the object %s does not exist"), s);
> +
>   			oid_array_append(oids, &oid);
>   			continue;
>   		}

This is the change in behaviour - unresolvable revs were a fatal error
and are now silently ignored.

Note that t5510 '--negotiation-tip rejects missing OIDs' still passes
because it uses an all-zero OID, which parses as a valid hex string,
and dies on the second check "object does not exist". Using something
like `--negotiation-tip=notreal` that previously would error will now
silently be ignored.

Is it worth another test? (invalid object vs not exists)?

> @@ -1615,6 +1620,13 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   			strbuf_release(&config_name);
>   		}
>   	}
> +	if (negotiation_include.nr) {
> +		if (transport->smart_options)
> +			transport->smart_options->negotiation_include = &negotiation_include;
> +		else
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				"--negotiation-include");
> +	}
>   	return transport;
>   }

There is a difference between the existing `--negotiation-restrict`
option and the new `--negotiation-include` option. Patch 3's commit
message says:

   "The 'tips' part is kept because this is an oid_array in the transport
   layer. This requires the builtin to handle parsing refs into
   collections of oids so the transport layer can handle this cleaner
   form of the data."

The new option passes the raw `string_list` to the transport layer and
lets it resolve it instead. If the transport layer now learns how to
resolve refs to oids, why not for tips/restrict?

Would it be easier for future readers for these complementary options
to resolve their inputs at the same layer? Or at least call out why:
"would prefer raw tips but for back-compat we resolve in the built-in"
for example.

> @@ -2582,6 +2594,8 @@ int cmd_fetch(int argc,
>   		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
>   				N_("report that we have only objects reachable from this object")),
>   		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
> +		OPT_STRING_LIST(0, "negotiation-include", &negotiation_include, N_("revision"),
> +				N_("ensure this ref is always sent as a negotiation have")),
>   		OPT_BOOL(0, "negotiate-only", &negotiate_only,
>   			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
>   		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 821cc6699a..86c85b60ef 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1002,6 +1002,9 @@ int cmd_pull(int argc,
>   		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
>   			N_("report that we have only objects reachable from this object"),
>   			0),
> +		OPT_PASSTHRU_ARGV(0, "negotiation-include", &opt_fetch, N_("revision"),
> +			N_("ensure this ref is always sent as a negotiation have"),
> +			0),
>   		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>   			 N_("check for forced-updates on all updated branches")),
>   		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
> diff --git a/fetch-pack.c b/fetch-pack.c
> index baf239adf9..8b080b0080 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -25,6 +25,7 @@
>   #include "oidset.h"
>   #include "packfile.h"
>   #include "odb.h"
> +#include "object-name.h"
>   #include "path.h"
>   #include "connected.h"
>   #include "fetch-negotiator.h"
> @@ -332,6 +333,48 @@ static void send_filter(struct fetch_pack_args *args,
>   	}
>   }
>   
> +static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
> +{
> +	struct oidset *set = cb_data;
> +	if (!odb_has_object(the_repository->objects, ref->oid, 0))
> +		die(_("the object %s does not exist"), oid_to_hex(ref->oid));
> +	oidset_insert(set, ref->oid);
> +	return 0;
> +}
> +
> +static void resolve_negotiation_include(const struct string_list *negotiation_include,
> +					struct oidset *result)
> +{
> +	struct string_list_item *item;
> +
> +	if (!negotiation_include || !negotiation_include->nr)
> +		return;
> +
> +	for_each_string_list_item(item, negotiation_include) {
> +		if (!has_glob_specials(item->string)) {
> +			struct object_id oid;
> +
> +			/* Ignore missing reference. */
> +			if (repo_get_oid(the_repository, item->string, &oid))
> +				continue;
> +
> +			/* Fail on missing object pointed by ref. */
> +			if (!odb_has_object(the_repository->objects, &oid, 0))
> +				die(_("the object %s does not exist"),
> +				    item->string);
> +
> +			oidset_insert(result, &oid);
> +		} else {
> +			struct refs_for_each_ref_options opts = {
> +				.pattern = item->string,
> +			};
> +			refs_for_each_ref_ext(
> +				get_main_ref_store(the_repository),
> +				add_oid_to_oidset, result, &opts);
> +		}
> +	}
> +}
> +

`resolve_negotiation_include()` is basically doing the same as
`add_negotiation_restrict_tips()` except outputting to an `oidset`
vs `oid_array`. This is a result of the difference in ref resolution
layer between `--negotiation-restrict/tip` and `-include`.

>   static int find_common(struct fetch_negotiator *negotiator,
>   		       struct fetch_pack_args *args,
>   		       int fd[2], struct object_id *result_oid,
> @@ -347,6 +390,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>   	struct strbuf req_buf = STRBUF_INIT;
>   	size_t state_len = 0;
>   	struct packet_reader reader;
> +	struct oidset negotiation_include_oids = OIDSET_INIT;
>   
>   	if (args->stateless_rpc && multi_ack == 1)
>   		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
> @@ -474,6 +518,33 @@ static int find_common(struct fetch_negotiator *negotiator,
>   	trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
>   	flushes = 0;
>   	retval = -1;
> +
> +	/* Send unconditional haves from --negotiation-include */
> +	resolve_negotiation_include(args->negotiation_include,
> +				    &negotiation_include_oids);
> +	if (oidset_size(&negotiation_include_oids)) {
> +		struct oidset_iter iter;
> +		oidset_iter_init(&negotiation_include_oids, &iter);
> +
> +		while ((oid = oidset_iter_next(&iter))) {
> +			struct commit *commit;
> +			packet_buf_write(&req_buf, "have %s\n",
> +					 oid_to_hex(oid));
> +			print_verbose(args, "have %s", oid_to_hex(oid));
> +			count++;
> +
> +			/*
> +			 * If this is a commit, then mark as COMMON to
> +			 * avoid the negotiator also outputting it as
> +			 * a have.
> +			 */
> +			commit = lookup_commit(the_repository, oid);
> +			if (commit &&
> +			    !repo_parse_commit(the_repository, commit))
> +				commit->object.flags |= COMMON;
> +		}
> +	}
> +

I want to make sure I understand the COMMON pre-marking before
commenting further on this patch. My understanding is there are actually
two different COMMON bits in the tree, one defined in fetch-pack.c
(bit 6) and one in negotiator/default.c (bit 2):

- fetch-pack.c's COMMON (bit 6) is set after a server ACK confirms an
   OID is common with us and is read to decide when we've established
   enough common ground to terminate negotiation. This is not consulted
   in find_common().

- negotiator/default.c's COMMON (bit 2) is a book-keeping flag used by
   `get_rev()` to decide if we skip emitting a commit as a 'have'.

Since we're in fetch-pack.c here, the `commit->object.flags |= COMMON`
line is setting bit 6. The `get_rev()` call in negotiator/default.c
never checks bit 6, only bit 2. As far as I can tell, this mark won't
suppress the negotiator from emitting another 'have' line in the
protocol v0/v1 paths in `find_common()`.

The v2 path doesn't touch the flags.. `add_haves` dedups via 
`oidset_contains()`:

   while ((oid = negotiator->next(negotiator))) {
       if (negotiation_include_oids &&
           oidset_contains(negotiation_include_oids, oid))
           continue;
       packet_buf_write(req_buf, "have %s\n", ...);
   }

This works, and is what the new 'avoids duplicates with negotiator' test
runs against, on protocol v2. If we run on protocol v0/v1, and if my
assessment is correct, then we'd see a duplicate I think?

Sorry if I've not understood correctly or am missing something, which is
entirely possible :-)

Thanks,
Matthew
