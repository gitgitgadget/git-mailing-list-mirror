Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011038.outbound.protection.outlook.com [52.103.33.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B734A796
	for <git@vger.kernel.org>; Tue, 12 May 2026 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597687; cv=fail; b=I9LZKrpzXWXac5mT6n1nx+JedZAv17Wna7AFN+UDBWekkWgKCtzal7J731YkFt30qxVAg1siB9drLouAy8xCU+H5h1BJXQVfjFaVsRQFAXeusKwvUbJx6FJcBR5WK5MhFHXjJ+XK6wKWjkX6bVuKTC/hWyoIBRsRp+Mz6GZ/jrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597687; c=relaxed/simple;
	bh=kO520oBP+p5Uux1G1E1Zhd3n7CM/7kn9qI8h7h3Uvek=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b3FL7cF/kWle1BklaCUMmlgs1rkK9ojKnptFcw8d7gDFl6QT2fBmOgZQbmJw8oUkUoq2ftljQEEqGZXb/xClPFciIDzSvldQbiXMfp833Y63Cu6zPASkvWYYs6pyWxVIMY9G1xVDC3KUTPuhOQY8J/iAyAasgsaWyCCAIU40BHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kj98nqyc; arc=fail smtp.client-ip=52.103.33.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kj98nqyc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T98Dav6cUOp+epGnmNPBfS1Td6u9W5XGSjWG/CkVV4/nYOB+mkc12AsJ/rWoOCFWXp549nsqvuRGX43e0qmaZPi078yp9EtFaji/aP254d/vUkcwT+h2lGzh2PK1HbCqZza0n5a0/gtWVSe0cd0RaRfFc5HAQ3mwBDvQY4mdmeZBIOgTTxCj4MUfyE82D6E9mPB2yelqYqNu0sHwnZgBl0W6kXloWj1x/GgsZyZ5a0Pex26VDseBagBHjOYXaGqY4X2Zw8q0x1loLDHKqkQERi1OLN+ZbegqRhOA8Frud8boMjaXIOS/nrSNf+NSSXC0N6ozwQRdjpiVZxitmEcaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNMj5BFV/w2dkvtL+nBfsEE4VXD8mOoog2J4eAVjrrg=;
 b=I5LK4GZ4yoO2yd6u3r1DrUHnxmhTBGLI7WL4qel1AB9BKtFdaQ+93Rr2tkx0V2PSopDFWzAGpltDNV/86qhosMyCie67qzePpcryPmIm9U+5BrNDUJ5sofNk6/dXtcb7A5KWzb4ro72dU5cJmIFQSeecW7cnft7FbYi5UYV8iydFDGUJhpwh3igAcwaYLc9XtQyO0yFupUEGKO39tBGrOjjIqi+IW4qky7XG5AIK1k1rv5v/TcEl0uTVgDjVyfAjzB2GzwiT5j36sE0h9WPdjrYWjyUTOFZexHK3YseVCxq6yjZAVbl8zUpnaZMcPW1XP+062YLeogdoMyNdshyUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNMj5BFV/w2dkvtL+nBfsEE4VXD8mOoog2J4eAVjrrg=;
 b=kj98nqycbP3+8Ees+pCgCTN7cKxzsW8bbmY9QYQkiq7SEh+LGverccUb0NT2HfsmzWn1RNcE4ghgQg+pK1hDfGU5DIKxpHaIsU9f1aXvCuvIaZDPamAvUwuYJRUarW30Mu/axifULipXy30jh/3VN1Y3brzfblDWGWss7xb0Rs/YYZC7wU5DGZ0kIq21M2/X/t3LlNet1A+onkRJySzmZrJNryFshiNxnBf0h3wQ94JU62rJuS5Mt2kSzuxfBrXqSakY/df0ITFDcb6YGCw74Mhfly1RFvf+mV0jJXkVfUX7QZkwkINa6RRF9ixpQ0CJBUfN+9iTleN88HbEzHFj6Q==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by VI0PR03MB11442.eurprd03.prod.outlook.com
 (2603:10a6:800:341::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 12 May
 2026 14:54:43 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 14:54:42 +0000
Message-ID:
 <VI0PR03MB11634F3D6B345482BD992FDC9C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 15:54:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] remote: add remote.*.negotiationInclude config
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <a2d15fa12af70367ac6b289f69228cd33dd97d5e.1776871546.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <a2d15fa12af70367ac6b289f69228cd33dd97d5e.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0044.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::13) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <d3eeab42-c5b6-4a41-820f-0bf5185f70d9@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|VI0PR03MB11442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b437378-7aa1-4134-761c-08deb0366609
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|51005399006|8060799015|24021099003|15080799012|12121999013|23021999003|37011999003|6090799003|5072599009|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akZpMkM3OXBzOGhuTUJ3M3FHK2E5c2JZdExJTlNSZTVEdWo4aUNrTmZ3cW8x?=
 =?utf-8?B?S0tPSEUrdDQ2YUtLOVdLVjA0ek1QeTNpRnFHWG0xc2tXUGRkMHZoSWxTWS9w?=
 =?utf-8?B?Rkp1YUlhU1ZBZHgrbFNoOHRnM1RLRFQ0TkFwRlE3QWZFRUNLTGdjOE1LVGho?=
 =?utf-8?B?YmdXNmRTeFEzNEtDN0d6SHlwTEJvallxcEtJbGlOSVZXaTY2dytzempiSW8x?=
 =?utf-8?B?b2craVlWcVIzUzBoU1pyN3E0cy9hR0p3Nmdwend3ZFZxei9TSXYyVWdTazVy?=
 =?utf-8?B?TUNQS0pOZkVWSXY1bXd5MHphRXJveG52WjM5RnM2UTkvWi81aUJBMzJ6ZWM3?=
 =?utf-8?B?WDBqQ1pvZjgvbHp0OG9TUVdjV1I4UGdHOWxFWUl3OXhSNWYzbFZkcUxwWXFI?=
 =?utf-8?B?UW1OZ0FIQ3dESkE4MHAvMWJmMldFTUtMNG9mcWlLa295TzkxcjQzdVJxMjYz?=
 =?utf-8?B?ZUFTYVo5VHV1RFEraExuRXlVRUNhVlI1ZWtSZ1BmakRKTkRaTzdYZEh4NGZx?=
 =?utf-8?B?R2NhZHZLSjBOUmhDNDN4UDN6WEMrZlIxUjNzOGpmZ0t3N2ZZVW1xdzVJbW9t?=
 =?utf-8?B?T3FqMDhYMUp3WGlsK0Q0ZnMrTy9TUXZmeHlxVGpRM0pyaFpoZUg2TkdlaExB?=
 =?utf-8?B?Tk9OZEY0TDRJMmY5d0JSbDlDMXZESTh1NXZkYkNlU3lTb05ibThjQmpLb1Ey?=
 =?utf-8?B?Y0ZYb0dCY0dsK2ZDcTZFSWxycUlWSUdlUnEyMXV6WnhjMkFJUFlZM1JBYXJS?=
 =?utf-8?B?UnMvbHF0dmJyczZXRTlPSXJDU25FNWI2Y293WUV2WHFtcjViSVJWOXdXaUVz?=
 =?utf-8?B?YVVsSUUrU3pXNC9hb20wYWFwU1VPdElTa01jdE9icUhQQWNxa1ZEUms2di9s?=
 =?utf-8?B?Y3E0OXhwUjZiNHZWbUw3NGw4SVdJWG8vVElOck53VDNuSXJ1STVnV2JhaEJ6?=
 =?utf-8?B?RTE2M0lTcEwyUXY2SzNzbHp2cTEwdEZpcUlFcGYraU5qSjJRSlNZUERLc1M0?=
 =?utf-8?B?aUJxS0hvUkxTYmJ2YjltZ3ZPTGg5MU9Za0ZoNlF0ZVg1OGZna29NMjZoVU95?=
 =?utf-8?B?S0c5MldhWitmZytlV2gzM1g5aEtDZms1V3JlRTZKTGNRdDBpQXZBOFN3cVM3?=
 =?utf-8?B?OHVNTW40bG5RSWtXNVJsdHVaRURGSjB4aHpkYWdkRjFldWFDTTVORUd5Q3lU?=
 =?utf-8?B?b0dqdnpJelJ5dXZUaU1iRkJsTmpmbTdCbFZyL216ekR1SWtDY0xERkV0Ti9h?=
 =?utf-8?B?d01hTnNjVkUwMDVIdTVNeFg1UjFpZU52cUc1YjQycm82dklwbG1MV0h0ZVNV?=
 =?utf-8?B?RGh2OFlHUGRoZi9yN3hVcm5meFZlbzNHQ3BsNTBhWHYrVStOMTRJSHVxTU9i?=
 =?utf-8?Q?6ECPoXvQlcPYNvTB04EftplVdbfODoso=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2EzRmlRazFWRVhxbXVwZ295eVdlZFliak9zb29nMnRjOWVzc0ZLWHc4ZENU?=
 =?utf-8?B?T3ZWT0RLbDZqbVllVEU4UkhaSkRialZ6Q1UrTUlUUHJDY0IzTGJqR0RhaXJh?=
 =?utf-8?B?OWFYOVR5aU9kbWViVU5idVpyQ1d6SXB5enY4TWl6a1hKUGt2S05zUmcvUmYw?=
 =?utf-8?B?cUVrUEhueml6WWFsOTQ2STFYdXRDVjJzZlNNMnBaa1NnWWEyQ3paek5GQ2dv?=
 =?utf-8?B?ZkdzNGhYMis0OTNBdTIzU0JsM0Jlcll1M2NVVjRoWGR4OFRFbCtVWW91VE1M?=
 =?utf-8?B?MEZ1bDcwVU5Qd2ZWOGIvNWVETkI5M2JCZkdiazdjZDRYd3BseHRqV0pPN0hz?=
 =?utf-8?B?czdZVkJOTG9wUDQ0Y043My9veGJ5dmd4RFV1THBBZ2ZlbHk0NVZwR1dWR2xq?=
 =?utf-8?B?dzFtOTFHQzU2b1JzR1RHb3hpeWVVQ2pvaDYvMUNPQ0M3aWV0dnpYYXQzM2Fw?=
 =?utf-8?B?V0h5KzFJRmo5c3VtZGFlTDRsM0VOandtQThiaG80T2pmSVR1NHp2SGVNcUth?=
 =?utf-8?B?cXl3SWgzQUl4TzFFVCtFdVpTSDZJZDB0cktpQU9lOHVTaUttd2RFZDRqNXlp?=
 =?utf-8?B?SzgyZUFWMUVETkJKYWRqUXJ5c2V2S091ZDJvMXZhQ2FpTjE4ZHN6TWN3NHc3?=
 =?utf-8?B?SzZ4U1pHY2I5TWN2dDFuMSs5WXk0SkY0SzdkWjF1WVliYXhJRU9FSWo4SHp0?=
 =?utf-8?B?Ym04QzMrTm9zTEtzeWhKT2luU0ZEL2xZb3RnalVDOTF4dVBjcGRjaVBIekxO?=
 =?utf-8?B?TkVZWEduWm95R1IxR3NkODJjVHhnbmFKQ2o0SXdIN25uSjBMQVM1YUxpNi9y?=
 =?utf-8?B?ZndCRUQ4eGl6UXVtTU9SdWI0QlJocHc2YUV1cm1MeUZkeGgvdHdWaXVFMVVl?=
 =?utf-8?B?K0ZWanBQVm9rclhXZDhLSnVaS3dqY2plQlg1ci9OeERrR1MrTUlRZ2hOc05K?=
 =?utf-8?B?K09ZcWNzVzhuWW1kK2dkMjl5bGExSXVEdExKMXRUWUI2dkhGWW5LOU9IQ3JH?=
 =?utf-8?B?bzU0TTVSTGdmL2g2cU84eUFvZnMvcUk3VytGVmt4TERnR2I2ZGVlcTIyNTJX?=
 =?utf-8?B?b3kxazNLa1FkV3pRbUZIOWxMdmJOMHBEK0toeGVzQVdkWjJBQm03QVVOZmVB?=
 =?utf-8?B?SXFEeTVSeGQxSkY2OGJJMEhqWXFaRHBOS3RBNXNUeGowSG9tVVBpMWtYWk1L?=
 =?utf-8?B?aktDWko4YXNOUXoraUZodlZJeldlOGQ2KzhqbzhIV25DR0IxblJaRzlNT0wx?=
 =?utf-8?B?amdyblNwSlF1b0REcVhUL2V2ZHhRYXBrUFM0ZFQ2YlFnbVhrZzI3WGZSbmw3?=
 =?utf-8?B?WWxqS0dyOUdUMkRmTWdSQVNQRi9FMmtFcC9zUEF0ekVzNFdhdk5XVEIrZTAv?=
 =?utf-8?B?QnBEMyt1OG5peVEzTk9Bdkl3VXJkOFB5Zy9YRnpUeG9OaW50QVpBT3NrRHli?=
 =?utf-8?B?NWJLN0NDSVlhUGgvQW4reGJtREtMcTBuTDRNZDBxV3Yrb1hEUkhOSlBlZEJx?=
 =?utf-8?B?blJ0Z1VJZHpMaENKSU1vQjZLMGR3NHh1WFpCY2IwckJhWDBaSG0veHcrMEdQ?=
 =?utf-8?B?NkhCN0tnK3F6SWdUUmRBa1k5MkRDYTE1bDZDTXJHcWlQVVVYY0Yrb3FJdWl5?=
 =?utf-8?B?RWw2VjdSelZQRVBXSktUcUJEd041OFI0ZTFnYXAxdFpkdEF3UUF1NDhtaWlS?=
 =?utf-8?B?VWtua2duK2FTb2tKVkJ5MlBBZWtDak9WeWlIZ2liRnlnZ2RVUmQ3NFp1ci9C?=
 =?utf-8?B?TXlZWndBSS9mRXpyZXRBaG4zOU90RzJOQXRVSVZKVXk4N25xa1ZpSXN4NExl?=
 =?utf-8?B?MUVEUU9KRUlaWVF4U3hDWTZnekFOZWhzWUx6UU1XTE54bGFRdmlJUC9LUkdy?=
 =?utf-8?Q?A18/VrjH3oe4e?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b437378-7aa1-4134-761c-08deb0366609
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:54:42.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11442

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

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
>   builtin/fetch.c                  | 10 +++++++
>   remote.c                         |  8 ++++++
>   remote.h                         |  1 +
>   t/t5510-fetch.sh                 | 49 ++++++++++++++++++++++++++++++++
>   6 files changed, 99 insertions(+)

This patch is a mirror of patch 4 that added the remote config for
negotiateRestrict. Some of the same comments apply here too:

- reusing `parse_transport_option()` vs inline resetting the list

- values could be commit SHAs as well as refs/globs

> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index f1d889d03e..44de6d3c1f 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -126,6 +126,33 @@ values are not used.
>   Blank values signal to ignore all previous values, allowing a reset of
>   the list from broader config scenarios.
>   
> +remote.<name>.negotiationInclude::
> +	When negotiating with this remote during `git fetch` and `git push`,
> +	the client advertises a list of commits that exist locally.  In
> +	repos with many references, this list of "haves" can be truncated.
> +	Depending on data shape, dropping certain references may be
> +	expensive.  This multi-valued config option specifies ref patterns
> +	whose tips should always be sent as "have" commits during fetch
> +	negotiation with this remote.
> ++
> +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
> +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the same
> +as for `--negotiation-restrict`.

Should this say "..same as for `--negotiation-include`"?

This way each `remote.<name>.negotiationX` doc cross-references the
corresponding `--negotiation-X` command line option.

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4316f8d4ea..db73ed5379 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1577,6 +1577,55 @@ test_expect_success '--negotiation-include avoids duplicates with negotiator' '
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
> +		--negotiation-restrict=alpha_1 \
> +		origin alpha_s beta_s &&
> +
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	test_grep "fetch> have $ALPHA_1" trace &&
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep "fetch> have $BETA_1" trace
> +'

This test sets up the include list as [alpha_1, "", beta_1] which after
the reset should become [beta_1], but the assertions in the test only
check that alpha_1 (sent via the --negotiation-restrict option) and
beta_1 (sent via the include) appear. If the reset of the list didn't
work then the test still passes because alpha_1 is sent via the CLI
option.

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
>   test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
>   	git init df-conflict &&
>   	(

Thanks,
Matthew

