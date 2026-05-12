Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010003.outbound.protection.outlook.com [52.103.33.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A93839A9
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584285; cv=fail; b=MeHcFyB+8pbSa6d0NEN/8cvZJU4lKlI5t1RVNZ0AaEAeTzdX7ZWwdezKEmZTu9kkH1kQkZziBWzgZjCOPXv6CzDWKX9315KaA2ebo50WsX65awDNTHGmbZovAcuDpPjkDSCHwfbQbUlhPptl+bLdh+pmM2dTnDo9SfllPELE89M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584285; c=relaxed/simple;
	bh=1UYLXIjM6kaLC9GB+7uO9cOOZwbnm9oHSfxcABvQsQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cXcFSOVeTaadxkdCAL3kyXXKyt862CZel7AxUORJLdxO4blzHFFZ/pHetUVpVNk97uoRJyjH/eLgoRv67zZi1zOK4qbYcIsTho+AHLwU2ZlfB+j71ZHsKlNJDwk07w3+hkq3WXsVCMCUzXjtqcvsUpdSdoiwlycVa7NPJLkqR7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=slwkGFhs; arc=fail smtp.client-ip=52.103.33.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="slwkGFhs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upNuX42xoMRG5recBJUMOW13wa7I58Q/plTqX6/pi6k+G+MY84vbhLrKpA+o6nK4nxfEPto9O6Mm54KCY79cGOfjm0Dhr5pEbyEp40VIWpGRnJi1d4G15WAeWNp3Ot4YXLl0xd0toZbUsQLSjN7+N6hvmZKxlW3WQ860wGioDlLIl6ZCmZ/wbbv2kfR2MbthqSIy0qBjtLzbgekGu3XEPkNwP/HOrK/Nz31/5IfHOOgq0SRDPVU1e7+HgWWt0qRAToOh+y4ICI5gEsa9GJJQT3LMlqr55ShxoiysPNV/avlbfFHJAezT4ZUxUnkbS68CAYPlg7vnT+9VaywGJiZuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBDwT6WIq7+Q/ayaZ0Fbr85yyUyC04zhUnaB9GD7VeA=;
 b=gRknSd5OaWOauHHxggL6ccoU5kxwMrcnRmWxKm7XV/ebo3eyqr6JehVs75NKbUp/iW9MAPS5uaFTpInolC/qbHvrxYi4ZHDVr70TCrSkQ67gxpN/yNWv+1Gic+QAl6uAvpRrJflrwRBlzmgNKc52SjvhlC1qdcE9SOZNID5AE9n+24W0A984zlhR8ZLoLxQRRZjBDxCcmN9mH+FRtxien4/nkAhzY7PXWWEqXarVdSvTdn/vEvUmcQqnrbsehQwY0q6GZNH1PVnuXscGFUWtDD62azYhmuJzJ54W5qMhijRu9S+Jd29Ax0zC+HZd1Pkn0aFhzE8IKVnibVcLXVWvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBDwT6WIq7+Q/ayaZ0Fbr85yyUyC04zhUnaB9GD7VeA=;
 b=slwkGFhsH9f1uDkYcaztLvZAhTTCMkFalqrgycmhgHPVxp/LTrZC4e6fo7rWvJh6HpH1E69Uly59txhMxkP2lH3dN712ENMHlffxvuLa6FypIsLkJ2jvOXDEq+57mLUsqj0fnl8rg0+iCKpnVL1vgHoZTVcCrSsbrCpjNQu8estFb4ADrqrK58NJCfSkT3I8MGGdOT56N9xqLjeKQ+CR/rnv3Bn8JiR27KiYUgvM1cs6XT3/A/4EhAH1dScu0ZVMGv1eUAmjUHk8sZllc20QjjNKOW4NeC+tghhk9VO7SiQ+jZVQg8o2h8y3qUKXO4881WBqCuIde1YkwrtiWkTtow==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AS8PR03MB9462.eurprd03.prod.outlook.com
 (2603:10a6:20b:5a2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 11:11:20 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 11:11:19 +0000
Message-ID:
 <VI0PR03MB116340D42554FA1D08E51910BC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 12:11:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] fetch: add --negotiation-restrict option
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <fe875399a851ba27ab193463cb6a1faf62aa6835.1776871546.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <fe875399a851ba27ab193463cb6a1faf62aa6835.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <0f58f93f-3ca9-46fb-a34f-734f37c6ecd9@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AS8PR03MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: aac6b5bc-5b49-4607-3538-08deb017313c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|24021099003|5072599009|12121999013|23021999003|37011999003|6090799003|8060799015|19110799012|51005399006|41001999006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnMzMnlmTFJRRlVjZFlnNHlPb29lY0R0UHRQM0ZpZFlkd0FPZ0dqUE5JMUhZ?=
 =?utf-8?B?N1dBcTB6THI1OVZZNE9wNkN3empSR0tkTmRzaWRXQmpVSW9kbGpuT3R6S0NR?=
 =?utf-8?B?a1Z1RDcyaFJ3WmIwZVZVc0hVMFJiTXJHNGlVcGN4VWZHQTdJQjJJelMrTWIw?=
 =?utf-8?B?ZFQvR3BZVkpqTkttQnNDNGdteW5XNmdXTURxM3lZV1VoZTIrMlZ4c1I3S1Ns?=
 =?utf-8?B?SGFSbWhVN28xbzNiNnlodzkwcmZRUXoyU0V3Wk16cGc0Tk1STHlrUWw0YnFk?=
 =?utf-8?B?Rm5vYTB1aGJzYWFjUzBKNDBsb01LTVVtM1lZVE9STW9PYU8wamdSaXd3cG13?=
 =?utf-8?B?OTlheTN4eEdMa1R4TUhybzZTdWZRRDdnd3M5TER0T3pzTXpPVWUyRUpWN1Aw?=
 =?utf-8?B?NVlwb3BHb0plRllINWFuSjcxNnhwUWlTMmN4L01tM3NNZk5QWnNpRVdjQkti?=
 =?utf-8?B?a3RYRWlhTkFmMEwvaXBIZ21RUENUcytvb1NZcnk2TnN0NUZkMTU4TmdVc1ZU?=
 =?utf-8?B?M0kveHJuVVE5V3J4WVM1SDJHZXQyaGZwdk9iNTVGS2ZxRC9SYWF1b09kSzRD?=
 =?utf-8?B?dXZPQjQzaDF3QTJXVG9kL3R5ODczbWNoWm9hdU5KVVc1a1RVL01lSHRyY3lP?=
 =?utf-8?B?RXNhM2l5WmdFL1FUWG9DdTdKdzdYaDJQNnJDc2dhYkNvSjRsNTBSY0t3TVRT?=
 =?utf-8?B?M2IrdUZRM3BLeGxQSjRRenZvQnNzbHJBcmZMeWVqTTN1Z0ozTXNqeXpXc3lv?=
 =?utf-8?B?RGsveGhmV0dENVVJVGdzOTZ3QmNzVlVCR3JWWkVuMkFwOEx4aEJGRnZrWlFY?=
 =?utf-8?B?UmVBcE9qL1lENWpjdlJsWHdRNDNEUGVuaTJTQ0JnOGdiWmN0WThtVEwwU05w?=
 =?utf-8?B?dkZuRmwxRkVyQy9IUnRtaXJhNnMwVVNQZlJ4MDJrNlY5cVpXYjJFOWtLbWlT?=
 =?utf-8?B?L2tJd0ZjRzNUV0VuMFBDV2VWVzFRaThseExFSDBwMG5VUENaMk1XbWYrcFdO?=
 =?utf-8?B?UlpMek1vQTJvM2kvdFFtWFlJTFdoU3JHVk9hbmNqSUFka1ltZ3llcDI0MTI3?=
 =?utf-8?B?M1FZTjlDTEw1d1JIK0tCNURhb3pXY2lMK1dxSXAvTm1aam5RTHNrdWcwTEpa?=
 =?utf-8?B?S0Fla09zbmdrZmd1cmtoSmUrZzF3Qlp1Z0pUKzltUkZidjNQeW56ZUZZTUda?=
 =?utf-8?B?dEV1ZWQyN3h3K0ZCdm9rODdPcndZUlNLbStJWXBOY1BCWXpkZ0NINEh4dTEw?=
 =?utf-8?B?cHpHVnlyM3NtUnljckpZZUhVVTdSbXVoSmVoZy81K05GN2xzdW4wREpjcW5F?=
 =?utf-8?B?MjRDVU0yZUpmcUxvQjFBTDRkbHJlR2hDaVJDZGhmVFVrbGF1cEUrS082VUVF?=
 =?utf-8?B?bENJR1lyaHhHQXpMOTFGMUJSMVg3ck5SdXoxdHlHRG9DTVlDcUt0UUhweFNs?=
 =?utf-8?Q?y1YMi2lM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHNIaGJxeWRnbTErb1FMMTNiRS8wQWJVam5tUEcrbXdsWWt5UHJQSHkyV0w0?=
 =?utf-8?B?SW5uNFdmaTNkOFBrajAxcWwrNDdDY0JkUWlwZVZzazl1Z2Z6MXp6MU5sTGRn?=
 =?utf-8?B?YktwUDdwQmthUWp2L05wSXMwQjI1NlZBdXYwdmgyNzBXbWc2T3RRTWVnTDZP?=
 =?utf-8?B?RDFYTUJycjNMMlJBdFNPT2xYbkRmTm9vSWFuVXFrUzF6bzMxZ0Y4RnpIWldx?=
 =?utf-8?B?WTFCVVZUY255c3J6blA1MXB0UFNmaVJGWCtQRzVRNEZEZC9ZaEtMVUFtazd3?=
 =?utf-8?B?bFdiU0V1QTJDV28vcXAzekgvdk9PcXl3cCtrQ2RKUFB1RWowUnhkVzZ4dUdM?=
 =?utf-8?B?ZTVrekgwZEc3Mm5iUjJ3Zmg0dExZNm00M3NwVG90bmJSWlA5b2xvRzk2S21Y?=
 =?utf-8?B?MVh2NXROVEUzVm5lZEk4WWlVM0w2TDIrN00xUGhPcyt5bXlydWZrTVB6MERJ?=
 =?utf-8?B?djUyRkpBdXhOZGFOMVAzYjZpTHdRWXVmTVU5VERhV2NYVFNNeUZ3UHVjNkwz?=
 =?utf-8?B?N2RqL014RW5WazNxVFZtRVBVNUIrR2FsKy9zTGo5WTFjOWtzS0M4VnNMb1Z5?=
 =?utf-8?B?TVg2d1p4eHZOUjdYVU0rSVN5Qzc5STllVXVBaFNHdmUrZkJIMXgvWXlHK1Rk?=
 =?utf-8?B?VWtOSXFSV0VXZkhrSm1UUklhL0RuclFiMm93RGdnTnJkYXFDK3dIOEJNUHMv?=
 =?utf-8?B?Kzd1cEZxaWxhY0tONmlvQkk4ckZqUUlQaytpMy9OZnlqaTh6OVFIUFNZaDhj?=
 =?utf-8?B?VVkrMmdwd1ErVVBOc0F6UWtSL1RMRGM5by9hZkdBUEsySy83U1ZHeGNkQ2dP?=
 =?utf-8?B?R3IwQzRHUWk2WDhNYUJpNUFvc2FaQXJ1YXB5alBuL3ZJbkJPRnV6ODRzUlJ3?=
 =?utf-8?B?WVNsekYyeVZ3SkFTcTJNbHUyT1NSaXVUeUc3cUZja2dwbG5ieitLaHZkSlZM?=
 =?utf-8?B?RmxINGNQVkdFdTFFWnJLbkZaTFBHL25rNE5wQXgwamFtb0tvcXVyTGI4Q2F1?=
 =?utf-8?B?bHczRGtjZkpPT295NUtkRkJsemtxeGVSaXlKaFRJbndRamlQSldZQkJkdDRv?=
 =?utf-8?B?STZtUGQyUTZqSFlDcXpHNzE5VVZ1RmhKbUhVMWxaWklmSWtYdCsrVDF6SFNQ?=
 =?utf-8?B?WUNObmZEYzhDbVBBcDV2NjlYbnI2ZnNObUs0UFA5NUgwREt1L3RUUWVHSDI1?=
 =?utf-8?B?eUoxcEFid09iUlg0RTJ2NEt2cGV0YmJ5d3drTndDdlk2aTdDS0p1VURLTFNX?=
 =?utf-8?B?eUYwVWpNUFJvUWNMY0hPWTY1SlRjZEFwMlBHYVR1ZUx3OXRDejF6TEF4N3Bx?=
 =?utf-8?B?aXhkdS9MVEF6cWFJSXlEVUd5TE1KUUUzc3FNdDdwelZKR0tUMzlndXExNldQ?=
 =?utf-8?B?UkNYL1V3azdFOWpsU1d5OWpremxvZEI1M1ZIYVRyazFkRm5DYVpWQlJtQmpP?=
 =?utf-8?B?aCtpcU41T2tLSmE1ZTBpWnhDRmZlUlltb0hGNTBxRWpqeHlRYlppZW5kZEE1?=
 =?utf-8?B?R3JpdWhyNDBwOWpuL3F4SytlbmZWQzZmZVpaVzdLY3Z4ZUNwUXVibFBGa1Jt?=
 =?utf-8?B?dFJPdEhSQUdFc1lVWmd2dlZRV2FpQXVTWG9lSW9sd2ZLWk9QWGw1ZWRwdnVh?=
 =?utf-8?B?eUs4akVaczdJMmxVT21jdXVDRmRHUm4vTDhzMUFnN0w1UDQ2Y282TmsrZm80?=
 =?utf-8?B?Y050NTdpeTMzNDQyRU00c0EwSFppeEdHRHIvdGM0TTZxZFFjaVBxKzgzaXV0?=
 =?utf-8?B?SWxsaXpqeWh5bWJZTWlHM092NGJRbVZCMjdoejFnTXhFbXFXczBnNjRLc2Q5?=
 =?utf-8?B?bXdXYTdRdklRNnliWXJ6K29OeHRSTXYrd3c5RHhvLzIxbU16a1N6RkZjdGc3?=
 =?utf-8?Q?bxmABwQvGL34T?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac6b5bc-5b49-4607-3538-08deb017313c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 11:11:19.2214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9462

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

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

This motivation reads well. Preparing the new naming convention before
introducing the new, complementary option, is the right order to do this 
in, IMO.

> Update a few warning messages with the new option, but also make them
> translatable with the option name inserted by formatting. At least one
> of these messages will be reused later for a new option.

Nice extra win!

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   Documentation/fetch-options.adoc |  4 ++++
>   builtin/fetch.c                  | 13 ++++++++-----
>   builtin/pull.c                   |  3 +++
>   t/t5510-fetch.sh                 | 25 +++++++++++++++++++++++++
>   t/t5702-protocol-v2.sh           |  4 ++--
>   5 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 81a9d7f9bb..c07b85499f 100644
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

By my eyes it looks like two other references to the old name remain and
could also be updated for consistency (since --negotiation-restrict is
now the preferred name):

  1. Documentation/fetch-options.adoc, under `--negotiate-only`:
       "ancestors of the provided `--negotiation-tip=` arguments"

  2. Documentation/config/fetch.adoc:
       "See also the `--negotiate-only` and `--negotiation-tip` options"

Of course the old name will still work, so this is more a nit-pick :-)

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

Keeping the option name out of the translation string prevents
accidental translation of a fixed symbol - good.

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

Same as above - good.

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

Good. Makes the --negotiate-restrict name the primary and the 'tip' the
alias, matching the docs' preference.

Keeping the variable named `negotiate_tip` helps reduce churn in this
patch (and has no outwardly visible impact anyway). I see a future patch
renames the variable - nice choice for reviewability.

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

Much love for i18n!

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 7e67fdce97..821cc6699a 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -999,6 +999,9 @@ int cmd_pull(int argc,
>   		OPT_PASSTHRU_ARGV(0, "negotiation-tip", &opt_fetch, N_("revision"),
>   			N_("report that we have only objects reachable from this object"),
>   			0),
> +		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
> +			N_("report that we have only objects reachable from this object"),
> +			0),
>   		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
>   			 N_("check for forced-updates on all updated branches")),
>   		OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,

It's a shame we don't have a nice way to combine the `OPT_ALIAS` and
`OPT_PASSTHRU_ARGV` functionality, but it's only a small duplication
cost of the repeated definition.

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

Looks like this test is the only place asserting the '--negotiate-tip'
string literal in the tree - good, no others to update.

Except the two doc cross-references above (nits) this looks good to me.

Thanks,
Matthew

