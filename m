Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010016.outbound.protection.outlook.com [52.103.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF4838887A
	for <git@vger.kernel.org>; Tue, 12 May 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588990; cv=fail; b=l9YdSr/5LvEWQ5zDjmmYIBY3aj3rqfXCfU8EtkFQUtovBXo0NFB24SCpCHFFCUwXkHg1A4DGDa7FaaUFKI441oaYtuwonQ8LFiYLyOLr4SvlGLMpRWIeSEyRQIlEI9l5+gObl4vwKGFsUn+qERZ676VEa+4y9GIsfi9GTeqJrHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588990; c=relaxed/simple;
	bh=YTEm5tQyPJ5cd7E1ZpcSud6gHvS1ooVQKG4h+ArzQ98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lPm8uuOmKW+V6aphWE5FZmZH270xCaNRiKFprEyiSQ1Jqzm64h4ATvoRhfVwacS7QAle/ox9N7BpuxZD46C6j8G2Htu5q6HJMiPkZIpl3yFlYnwu+ldc4tGI5+adAL6fEIcNpWjtfK0JBBhnEyH9DaXVmX/udafkseLq0iigWVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QmmM9X3W; arc=fail smtp.client-ip=52.103.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QmmM9X3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoFqucrFXG0qWUoBIgXm2XZ068VwH7yVlF6h1pVTTQcPA5xOdARvb5/BdYtkki3QkJAwRRs1bXZTfwxzmVWjsRUT1xJEqIRd8C1wMAxVpOFC16leCb6UReegnJXVNovyRkWQkOerxKabudxRjTy2uh2YPJYkRKNOXePsa5P+6sQJoKt6OhDeOJWmPa9JmU9kFWJtDv+YUJtHpgpxgZN09J3Q9G39a3nbLiYdaBZHWsTgd2f5BZ5cdyO++Bkg7iP9+50fFcIzzyJ4SQZqqEqHJqXazLyzx0yT0crk2ygMT+GrwXTeh5SXhNib5u21eQrab8zsIMxATdEpzYwBRCEElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkL9voR8zAb8Phs8AtnGK8UIxLLmQ4iYkpj2oIfK4Dc=;
 b=oxYHOe1dRBkTgpisfGIFIBcBOCh7HR9EkVCUTM2dAAqYZjJPejT8l/N6fqaN65gn0/DiUc9LE9uWjnoREufYJgUbdHKeVYsxcO3iSiuTsQ4EaTo+z4NT7qfl9JDZPjtN9ibP/Lqbu5UXhPjAaJuQ2yeUHOhC8wCR8fQ31vGIa51P7TG7ZMPDsaltXDIgufKqbM0MG+D7enuT3DmeRNcWlN/qM2EuUKJeKezylZpTu8hZ+K72tCr+Iq/YYBkxVTqVc1x9aXyQ4XBoDFdEqzjdaQiNaOf4b/0E8DI976aKr+6ZgFvxOf+gun8Pr3suB+5do/SPGqCYnN2woEkwcYJ7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkL9voR8zAb8Phs8AtnGK8UIxLLmQ4iYkpj2oIfK4Dc=;
 b=QmmM9X3Wt8qkdeRuBV23yf40V09/jC+P6RIH/FUSyZQP3tfaq7Nzhb7WVkuvK75StvcRHjvoNKonH/bRF3y0h4EvJB40jCUNH9o4Y7bZhj9zs+/RsMdw3b4sb3SHuCg8407DZp1PfOVWbu4mmFGYTMqd1MjxCX9Xvj0QeEvqkUe7+32nRIHkRFA+4dAhnP/jmZkENARDpHsHopoyK5JkAEGQij9ufTk6SurH8yBZV7iyijG2YOMsCbJWdJJSST+ErDdb73E5Q+Yp6Oh0tNtC6AfnQal55zSkLqJ7JjQ+mBOWoqZ1JJETUq6WjLqLe/X0d8Id6uWn1N8R0u03A+KnBA==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by PAWPR03MB10184.eurprd03.prod.outlook.com
 (2603:10a6:102:343::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 12:29:34 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 12:29:34 +0000
Message-ID:
 <VI0PR03MB11634BD90B47B89A7631F5DE5C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 13:29:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] remote: add remote.*.negotiationRestrict config
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <d2f48b78b5b4c63269b1129865d94fdab9dffd92.1776871546.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <d2f48b78b5b4c63269b1129865d94fdab9dffd92.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0088.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::13) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <add9632b-bf65-4f35-8235-f853abccf868@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|PAWPR03MB10184:EE_
X-MS-Office365-Filtering-Correlation-Id: af4c71f6-ff31-4b9f-3adb-08deb0221f9d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799015|19110799012|15080799012|23021999003|5072599009|37011999003|51005399006|41001999006|12121999013|24021099003|3412199025|440099028|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHBoZVN5NTBIb0hmZm9oWVFhbS9vVmx4Smt6N1pUMDhYQ1FNbnRldWxaN01a?=
 =?utf-8?B?cmJWZ3p0YVVqVzJsaXFVM3EybHZQdzc1SStWSW9Vdi8yeURTakpFaWdIc1FY?=
 =?utf-8?B?cUVKSkVYekZRbkVBVmtlVVM5TlZKdWZJYm9xdGY5SnVFM3pXNE11NmZDclFu?=
 =?utf-8?B?Um91aDFYRHlLVXErN3psVFpHbm9YQ0R0TU1WeDNrdE8wU1FvZ3NmTExhbGNX?=
 =?utf-8?B?dWtoQnJZb1Ywdk10U0g2c0NkakdnL0JHT0x6RmdaMjFjSko3T2U2YVRmdG1h?=
 =?utf-8?B?ais5czFaNy9ZRmVzRUZKbnJyU0duTEtTSldrRUREaE4wODcyYi9aVUhiZTdC?=
 =?utf-8?B?NVV6QkJuSlg5akcwUnc0ZDNWSzNiQUFQcndtRnc4dktQV1JGempwRE9UbUsx?=
 =?utf-8?B?S2s4V3VISTlDdVJseHhOYnhnTU96VUdyWTJ1TDlFOWhKSElyVlN2NTNLTkJY?=
 =?utf-8?B?NGhIbnZra1ZDNGZiVUZCODZHcWczVnRLOXdjOE9IRzVtanU0MDdNN2YweDlJ?=
 =?utf-8?B?VHVsTnRiQXAzazQrQXpTVXJneDkrS2dnaCsvaldHZ3FEb2J3YndYaTVCOHF5?=
 =?utf-8?B?dVFUK1NxUmpMSXc5MUhoNGRubTh0SVpGRzJ4a0ZzcWlyamtRVEJiR0F3MlhX?=
 =?utf-8?B?M0l0em5IalZSNnFKVGNXSlZsTTVTWTlaL0tNOHArTTRqcHYwWWp5Q3JvS1B3?=
 =?utf-8?B?MVhXVE44OFJXREJLWU1kTXJrM2RZZEhpd2dPSVpxejVGOUk5NWZLbFFDUDFX?=
 =?utf-8?B?RnlMSjJJOHo0N3YyUFdVRjRGUVF3L3NOeDQ5QlFhNlAvN0NpTEFSNXhTL0pS?=
 =?utf-8?B?WVhJVDA3a2RueG1pM2VPRTJ3eUgxKzc5TWFGTnBxeTE0NGM2VGc0a2Z3VnFP?=
 =?utf-8?B?b2Z2YUNkQldmQ21aVWU1cGllN3BDay9PQ1lVbDlTNTJYcVpaWDZCdXh1Yjln?=
 =?utf-8?B?YWxHRnRRemNISEFpSzhKZ3VUMXdZd3JEWmdGTFpXSXR6N25yVDJualVKa1NY?=
 =?utf-8?B?V1lsL21TTk5lekRBTUtsQlRxR1lQdjZZd245WFJELytaNlA1ek5VTjVMdXlw?=
 =?utf-8?B?bFhTQ2Z0Wm10UjZrdmtvTlF6dGxCVjBIUjNQZUhuZ0Z4Y0pRRG80N0RETlBh?=
 =?utf-8?B?aVFDUEF2NEFmNkx6TElOdmtIK2dnc0pQTFJaT05saWJianREVWtvSjh0WWlZ?=
 =?utf-8?B?RTUxdUNST2dFbFpueW8vNEE4dEdGZ2xUUEdoT3VIa3ExZ3dBNzkxMjUreHZi?=
 =?utf-8?B?YlREbURsd2hJbmlZMVlROUdXdnEzTjA3ZjlKQlhrZG11L1pmRi9obnB2TEln?=
 =?utf-8?B?UHdEa3p5MTh6SVg0OG5XVGUyMCtuTjBYRk04RWpDUFE4Q0RqVVNaK25EdEMx?=
 =?utf-8?B?NGZYVEVLUWZlRjlFTnBYQjlGVWVQLzhEazNNeldYbWpVQnJKVk4wOFRIQlNy?=
 =?utf-8?B?d3IvYnNpTUZPZ1FXNTFiOEtRTEdzRmZjMlRFTlBPUldPZDZ2Y1E2L1NpbHhT?=
 =?utf-8?Q?+a64b4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmJUM1gzNFQzM2RQa1FUazRjZzhseTNRNmI2UVZxOGthSGhKM3Y5WkpFU0Uz?=
 =?utf-8?B?dnRJNm1MeS93WUViN3o4UUd1aXcvUTZZYWphV0x6R2xVSzBCQzNLZEYwZ1VY?=
 =?utf-8?B?V3FWcjRMejZIZ2NxdGRFRTViVFQ1TktUZ3IwcWl5aWhQRzVWWHVuMXFiQytv?=
 =?utf-8?B?eUhUQm5TdDJrQ0xEYWFSM3JxdEdWalB6OVFzOTg0RVA2MWtPUEFDZjFQWTIw?=
 =?utf-8?B?MWRYTmZoZHJjazdVRE9wZFpNbmdTY3J6aWtUZHlPanNIRzBlcWRJWFhyQk1S?=
 =?utf-8?B?NGZvOEdpemlyWDhJVTJONEphd2xEVmdiY0t1TVZaM1lveU5EUnpjNXZ3S1BN?=
 =?utf-8?B?b3NNeHNMUTAwTElFRTVSVkxYVm9zdUhTS2NaZ1Y3Z0VBUDRRQUFLK2dZK01W?=
 =?utf-8?B?UU03TVN2M3hKNEx6OC91Mm03Q09KM2F5RW5rT0N1cExBdDI3ZDEwVzMwdFlW?=
 =?utf-8?B?bk1sN0tZZWZNYlo3RHN3Q1d0WGRlR3V4NitPc1ptL1Y2M1ZrZElqZHlNaGpv?=
 =?utf-8?B?WU8yS0hPZEpZajV1R2JSY3JyVVNSVkVUblNhZEJLQWs2Mkd1VEZyT3AyekxE?=
 =?utf-8?B?ejFMWURIZnlLa2VZQkpRYVA1eHh0dGRqTDRnZmo0Skp0NmZkc0pNVTZtRWw3?=
 =?utf-8?B?MGdhZ2NVekw4WisrY3BOeC93MmduS3lEVnBNaHovRGlwc0M3WXZUclVBc0k0?=
 =?utf-8?B?YzQzNmdXREJCSC8zZjJibHdBekpZc3F3QmhCN1JHcFZaME9JT1grei9xcWpN?=
 =?utf-8?B?MFdmVThrMkNtWWRoa0JYVktvVGxVaVIwcjdMZTVzb3E0VHdoaFJPZkZzM2Yv?=
 =?utf-8?B?R2FqT2F5cmdjRzRSdmU3Smdyc09WN1lkVHpJa3k0OThIWFZpUHNWS0xDeTlP?=
 =?utf-8?B?dVpVMEd6SU5Ua1I3cElRSzJUUzlyNTJLZC9Ga2l4S3VteVFyTXA3R0tYMGxY?=
 =?utf-8?B?N3I0MVFtaHR1RzJOWGN2NFhjMzJGbFdKVHlMWTkwbzdRZy9kZWpMcm42THpS?=
 =?utf-8?B?NVA3eStOR0xURGhtWVlSUE5XV0dPaDRBWFdsNjZwRXE0dzBEbndhaHJPQzl2?=
 =?utf-8?B?R21EclVVTkhKRlA4RGk4MlMweHBBckhnM0lVeWh5c09peW5WWlFGTGc3Nmhx?=
 =?utf-8?B?cUREY3Y4L3pFM0tsTW5RS3BYT2RvSnFnbUFhZi84ejhVTDlqNTBidDdaS0lM?=
 =?utf-8?B?aUxqZHlFYnZIMDVYd1FoTmIvNzdPYVNYNjBCTXo3NHJOYlhYS1BmVlpqeFZI?=
 =?utf-8?B?U3FPYk5QVHZQSVZkRmloSStFZEU2cHI1V25Sb1AxOGI3MjVyQy9zNkYwQVhP?=
 =?utf-8?B?U0g5b080dDBzdXhtbFpYLzZ2U2lGNzgrcWNuRDJEMnM3a0FLa0tCY2FwNk1R?=
 =?utf-8?B?WmFPNEZKNjdnM3pWbmRhL0lMYWN6QmdUUFo5Mk9XT2pDVVU1VVRaRFpUOEpx?=
 =?utf-8?B?b3NtSlJzMzJCdlpra3BqUHAxWG8weFQvaGhzYkV5MVJacENiTXpCd2dWVkhq?=
 =?utf-8?B?MzViTVZ4WTZzUHlOdWpTV3Jwd05aTzFCWWtDazlWTlpUWUNXZjhHNXFtdlRK?=
 =?utf-8?B?aFBkcTU5TFR2UGwzVmdTQjFLM3kxRExHTFp0aGpmcW44aUtDamNKaGtGWGJj?=
 =?utf-8?B?UWhDZW9rb01rdk9DcnFUUXRuc1lBZWJRUkFZaGFpYncySXVyUXJYVkpvcmY2?=
 =?utf-8?B?aVhTM0o3VHBWKzBpVkFidEdDK3ZwelVvTndmdTJFellMVE5DVWg5M2NHeGFr?=
 =?utf-8?B?NVZTWEtwTXo0L004czYzVFdTblEycFg1VkVYODdOLzRMU3B6ck4wNHhWZVJC?=
 =?utf-8?B?eUxpTXNyTGZMWlI1ZDkxNEN3eGVEZGdhK0Q2VVE5YzRMSlNCSlhJYkV6RW16?=
 =?utf-8?Q?J6BDJ4PWoedBY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4c71f6-ff31-4b9f-3adb-08deb0221f9d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 12:29:34.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10184

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee<stolee@gmail.com>
> 
> In a previous change, the --negotiation-restrict command-line option of
> 'git fetch' was added as a synonym of --negotiation-tips. Both of these
> options restrict the set of 'haves' the client can send as part of
> negotiation.

s/tips/tip/ as per the previous patch comments. Not important either
way.

> This was previously not available via a configuration option. Add a new
> 'remote.<name>.negotiationRestrict' multi-valued config option that
> updates 'git fetch <name>' to use these restrictions by default.
> 
> If the user provides even one --negotiation-restrict argument, then the
> config is ignored.
> 
> An empty value resets the value list to allow ignoring earlier config
> values, such as those that might be set in system or global config.
> 
> Signed-off-by: Derrick Stolee<stolee@gmail.com>
> ---
>   Documentation/config/remote.adoc | 19 +++++++++++++++++++
>   builtin/fetch.c                  | 21 +++++++++++++++++----
>   remote.c                         |  8 ++++++++
>   remote.h                         |  1 +
>   t/t5510-fetch.sh                 | 26 ++++++++++++++++++++++++++
>   5 files changed, 71 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
> index 91e46f66f5..f1d889d03e 100644
> --- a/Documentation/config/remote.adoc
> +++ b/Documentation/config/remote.adoc
> @@ -107,6 +107,25 @@ priority configuration file (e.g. `.git/config` in a repository) to clear
>   the values inherited from a lower priority configuration files (e.g.
>   `$HOME/.gitconfig`).
>   
> +remote.<name>.negotiationRestrict::
> +	When negotiating with this remote during `git fetch` and `git push`,
> +	restrict the commits advertised as "have" lines to only those
> +	reachable from refs matching the given patterns.  This multi-valued
> +	config option behaves like `--negotiation-restrict` on the command
> +	line.
> ++
> +Each value is either an exact ref name (e.g. `refs/heads/release`) or a
> +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the
> +same as for `--negotiation-restrict`.
> ++
> +These config values are used as defaults for the `--negotiation-restrict`
> +command-line option.  If `--negotiation-restrict` (or its synonym
> +`--negotiation-tip`) is specified on the command line, then the config
> +values are not used.
> ++
> +Blank values signal to ignore all previous values, allowing a reset of
> +the list from broader config scenarios.
> +
>   remote.<name>.followRemoteHEAD::
>   	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
>   	when fetching using the configured refspecs of a remote.


You say "during `git fetch` and `git push`", but does `push` actually
honour the new config?

When the `push.negotiate` config is on then
`get_commons_through_negotiation()` from send-pack.c shells out to
`git fetch --negotiate-only` with one `--negotiation-tip=<oid>` arg per
ref being pushed, then the URL. This means the CLI restrict list is
always non-empty in the subprocess so in `prepare_transport()` (in the
below hunk) the `if (negotiation_restrict.nr)` arm is always taken and 
the new `else if (remote->negotiation_restrict.nr)` arm is never taken.

BUT.. reading ahead I see that patch 7 actually wires up negotiation
config for push - so my commentary here will be moot! Do we want to drop
the "and `git push`" part from this until patch 7, when it is wired up
appropriately?

One other suggestion: perhaps we should clarify that `push.negotiate`
needs to be set for `remote.<name>.negotiationRestrict` to be honoured
during pushes?

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 2ba0051d52..a1960e3e0c 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1601,6 +1601,19 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		else
>   			warning(_("ignoring %s because the protocol does not support it"),
>   				"--negotiation-restrict");
> +	} else if (remote->negotiation_restrict.nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, &remote->negotiation_restrict)
> +			string_list_append(&negotiation_restrict, item->string);
> +		if (transport->smart_options)
> +			add_negotiation_restrict_tips(transport->smart_options);
> +		else {
> +			struct strbuf config_name = STRBUF_INIT;
> +			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				config_name.buf);
> +			strbuf_release(&config_name);
> +		}
>   	}
>   	return transport;
>   }


See above - this new arm is not reachable on the push.negotiate=true
path until patch 7 wires send-pack up.

> @@ -2658,10 +2671,6 @@ int cmd_fetch(int argc,
>   		config.display_format = DISPLAY_FORMAT_PORCELAIN;
>   	}
>   
> -	if (negotiate_only && !negotiation_restrict.nr)
> -		die(_("%s needs one or more %s"), "--negotiate-only",
> -		    "--negotiation-restrict=*");
> -
>   	if (deepen_relative) {
>   		if (deepen_relative < 0)
>   			die(_("negative depth in --deepen is not supported"));
> @@ -2749,6 +2758,10 @@ int cmd_fetch(int argc,
>   		if (!remote)
>   			die(_("must supply remote when using --negotiate-only"));
>   		gtransport = prepare_transport(remote, 1, &filter_options);
> +		if (!gtransport->smart_options ||
> +		    !gtransport->smart_options->negotiation_restrict_tips)
> +			die(_("%s needs one or more %s"), "--negotiate-only",
> +			    "--negotiation-restrict=*");
>   		if (gtransport->smart_options) {
>   			gtransport->smart_options->acked_commits = &acked_commits;
>   		} else {


This new condition fires whenever `gtransport->smart_options` is NULL,
i.e. the transport doesn't support smart options. Before this case was
handled three lines after this hunk by:

   } else {
       warning(_("protocol does not support --negotiate-only, exiting"));
       result = 1;
       trace2_region_leave("fetch", "negotiate-only", the_repository);
       goto cleanup;
   }

What happens now if a user runs --negotiate-only against a non-smart
transport is they see an odd message:

   fatal: --negotiate-only needs one or more --negotiation-restrict=*

..but they may have specified --negotiation-restrict options.

Do we instead want &&?

      if (gtransport->smart_options &&
          !gtransport->smart_options->negotiation_restrict_tips)
          die(_("%s needs one or more %s"), "--negotiate-only",
              "--negotiation-restrict=*");

> diff --git a/remote.c b/remote.c
> index 7ca2a6501b..166a56408a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -152,6 +152,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>   	refspec_init_push(&ret->push);
>   	refspec_init_fetch(&ret->fetch);
>   	string_list_init_dup(&ret->server_options);
> +	string_list_init_dup(&ret->negotiation_restrict);
>   
>   	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
>   		   remote_state->remotes_alloc);
> @@ -179,6 +180,7 @@ static void remote_clear(struct remote *remote)
>   	FREE_AND_NULL(remote->http_proxy);
>   	FREE_AND_NULL(remote->http_proxy_authmethod);
>   	string_list_clear(&remote->server_options, 0);
> +	string_list_clear(&remote->negotiation_restrict, 0);
>   }
>   
>   static void add_merge(struct branch *branch, const char *name)
> @@ -562,6 +564,12 @@ static int handle_config(const char *key, const char *value,
>   	} else if (!strcmp(subkey, "serveroption")) {
>   		return parse_transport_option(key, value,
>   					      &remote->server_options);
> +	} else if (!strcmp(subkey, "negotiationrestrict")) {
> +		/* reset list on empty value. */
> +		if (!value || !*value)
> +			string_list_clear(&remote->negotiation_restrict, 0);
> +		else
> +			string_list_append(&remote->negotiation_restrict, value);
>   	} else if (!strcmp(subkey, "followremotehead")) {
>   		const char *no_warn_branch;
>   		if (!strcmp(value, "never"))


Here we use the 'empty value means reset the list' pattern, but I notice
that the `parse_transport_option()` function already supports this reset
pattern (and used by serveroption above), with a small difference:

   if (!value)
       return config_error_nonbool(var);
   if (!*value)
       string_list_clear(transport_options, 0);

So NULL is an error, but empty string is 'reset'. Is it worth being
consistent with other options that use `parse_transport_options`?

> diff --git a/remote.h b/remote.h
> index fc052945ee..e6ec37c393 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -117,6 +117,7 @@ struct remote {
>   	char *http_proxy_authmethod;
>   
>   	struct string_list server_options;
> +	struct string_list negotiation_restrict;
>   
>   	enum follow_remote_head_settings follow_remote_head;
>   	const char *no_warn_branch;
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index dc3ce56d84..eff3ce8e2d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1485,6 +1485,32 @@ test_expect_success '--negotiation-restrict and --negotiation-tip can be mixed'
>   	check_negotiation_tip
>   '
>   
> +test_expect_success 'remote.<name>.negotiationRestrict used as default' '
> +	setup_negotiation_tip server server 0 &&
> +
> +	# test the reset of the list on an empty value
> +	git -C client config --add remote.origin.negotiationRestrict alpha_2 &&
> +	git -C client config --add remote.origin.negotiationRestrict "" &&
> +	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
> +	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		origin alpha_s beta_s &&
> +	check_negotiation_tip
> +'
> +
> +test_expect_success 'CLI --negotiation-restrict overrides remote config' '
> +	setup_negotiation_tip server server 0 &&
> +	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
> +	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
> +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
> +		--negotiation-restrict=alpha_1 \
> +		origin alpha_s beta_s &&
> +	test_grep "fetch> have $ALPHA_1" trace &&
> +	BETA_1=$(git -C client rev-parse beta_1) &&
> +	test_grep ! "fetch> have $BETA_1" trace
> +'
> +
>   test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
>   	git init df-conflict &&
>   	(
> -- gitgitgadget
> 


General shape of this patch is good. The main thing that tripped me up
when reading this patch is the doc claim about push, which only becomes 
true after patch 7 lands.

Thanks,
Matthew
