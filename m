Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011072.outbound.protection.outlook.com [52.103.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5C3EF673
	for <git@vger.kernel.org>; Tue, 12 May 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585436; cv=fail; b=aUFt+rCxb+rbU5L/oaxWxICVoW0b8LxtVw4lk98cqoUzru2PsQK/zzZc2V5PmUig0/p/ApZ5RrVnlo5PlzOsd/G62pTZe+qIU1MoAmHtEdcDvAuM5aStkR7FU+DE8v7B/9Sx4mNTtzqaJL4F+zNRAxrHJy6YHx+jel/mmbQ6/gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585436; c=relaxed/simple;
	bh=ZXHenkolLWazzOPkVAGg0XXV4Rsvl5a9mHhDN9oa2Es=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kMylN4YRp4bmtcXVmU0JuXnS8KjQb/HHGpGixTcuwe4f40Aq3Rsr/4TPbS/C6RK4dXd7nqmA/hFA/94AkXoPlptQX4UPORNYSwEgqB5jf3lWtFCb+BihJnv87wSpgCnW9cauNL4KqN00fyyad/tahnXnth9ZTpK6QA4inNHEMMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZQKNm4ye; arc=fail smtp.client-ip=52.103.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZQKNm4ye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yb72VwFFVkQfjmf4oUrEMNaxyM2+mfkvI74r6TdUlzdSkvpOglHzzwl0z6ucYcHyTHC0pGPLaR+ScSS6KKy3V4ZAB//z4CM9UVGZbAJFnyQyEtnCgEWYtuxZKh5RaEU5j706Mqh9Ys59Gu5sJEl6a7b/obsxE5cVPrseEQ3eg1zjbm/Oj/DEb2/Xf3lN9lhMMWEPddLYq85hkfuPPcjhgUbmJ1s2cAwmZXGM/d+pOcfIaz1fBIPZhavdJgCogvAitpkf3woj7kf+JVQCQfdoiJ1fExzYAB8ZWT1luRf3vf204n7Ojs93/jKf1b9jrJf546UXevGXuqdGwH1XD1StfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoWacGVVd8/Z/qEBoh5nA6M3WoRrtz+HoEG9r4+M4Ng=;
 b=hlSxxvq/OX8yyoX9qF/4NQNhCkkd3/5rXm3oZyVe70UIj8VAKlByW2KyAzKPJhpnu4ijBTcY7omeW0gT6zuVqjZGAJZsdJ+SX67qFR3yM7bbNXYlPmtMzySO6VmrfzlkCHskUzJ3XhrSA3jLXMnDsvCfSkKX/aTByJb4cEE1FsHhaKc+0Z0MDK/bZ7nOIgIKJI5g2mCFQqnHK/Q4eXer/fmw96PDNqftCY9abUjs+gAyuxoh9th7H6cqhAXx/aFjTXfqNCxpvQxIXW5xJ4mLJw5p8O2E3VrEqTop2qol8Ip0ES4wX5hQYXUVywKCkHRo8/pd7GmWy+j5B6s34V17BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoWacGVVd8/Z/qEBoh5nA6M3WoRrtz+HoEG9r4+M4Ng=;
 b=ZQKNm4yet7m0mI4ZXNBtB6qYOJyXMpKI1BRcim9Nea/RvjfH7nDD6M4zhaaga0PWUcx+UTgUn6g2lmnsjUV/TH6zbsvngicplbNLHhoDnxNRfuX8+1Q9R506pMc8mK3hd9cbz9WoREBYmIIPCB+QKFV9Kxd+9JamOVuxjQMygXdwptXiDetWy+/TYGGoTs0s6M2Fdl3tUnd842BNSBPxxEzQ5NpK1NRVMLktn1xrP9cnu1Ep5y3H3vKBQ+LGXWUqWeGQAaxbJOdi2zExr/edBFupemVrPdQARXlg0exvHOW+kONjJJ/EhG+uDb5iPZiB7QN2thCxI+f1FwHdjduyXw==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by GVXPR03MB11070.eurprd03.prod.outlook.com
 (2603:10a6:150:2ab::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 11:30:31 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 11:30:31 +0000
Message-ID:
 <VI0PR03MB116342F99CAA8959D2D8638E0C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 12:30:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] transport: rename negotiation_tips
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <4332cbf26631516030da32fd6de6ae134f8a6645.1776871546.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <4332cbf26631516030da32fd6de6ae134f8a6645.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0073.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::20) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <a60046ff-b1a7-4504-ac6a-26c792fe212f@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|GVXPR03MB11070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bce2694-472d-409b-2dea-08deb019e006
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|24021099003|5072599009|37011999003|41001999006|10092599007|8060799015|17081999003|6090799003|23021999003|19110799012|15080799012|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkE4bTU1dW9qb24rSTkvOCtLNHBYTzFQaSs5endiUDBKdkt5QVZOdlp1MXdp?=
 =?utf-8?B?TlFWcFgvUUtuc0FsWW1JMkRkaE1zc2VhSjJOTmdRM2lobmFRN2xFL2s3TWV6?=
 =?utf-8?B?MGhpb01RQituME95LzdmOUxVcW8yYVBwUk1tOHduaFBxMnE2M3dmMUNBOVl6?=
 =?utf-8?B?UTR6MVRQb1RaUHhXL0RwR2dkYXc0aitUSjd3MVBQY1NHRTBXdGczR1dCSDRa?=
 =?utf-8?B?OFRzcXVqSnB2cDZwMzZtZjFBSHdrQmh5U3A5OUwxTFoyS1htRStkV3ZNV2N0?=
 =?utf-8?B?TWhKZmhDcUhiODJjR3FnL2RlYUc3bHVIV3QyZXhGdmROTUxtN09RQWFWUVRN?=
 =?utf-8?B?VFNpbFNnd2J0OHRSRStmL0R0NThHR1BKRFFFTGJFUGIzVm00aTBQOEtzYXFE?=
 =?utf-8?B?RUF1b2haS3RacmNmZHZENlYwakhjZzVwbkVzajFGZU9nTmhPaTRvNEE2dVMw?=
 =?utf-8?B?azNmSVJmc2xvMnRlK1N6ZmNsS1R6UDMyOWU3RWQwRnpQa2ZkM2g0OFZUeWww?=
 =?utf-8?B?MmtvV0dtUWpCYXlZVFErVzlXcmNnOEw5SlpYbnpFSGdaL0lKK0xYN2xVZlNV?=
 =?utf-8?B?bVg2VnhqYXZJVHVWYnJtb2lEMG1zd083bW1xQXdGbWNjNkRUN1R0RmlFbGtn?=
 =?utf-8?B?cElDTlFrdHhHbHAvMURDelp6YWZZRHd2UEhmSzI2QVdLbCtzazNYZUNoRlBz?=
 =?utf-8?B?OVZsZG9HZTZxQTN1OUIxdmhVSnp1T203NFlIdm9VeXhiazZhUy9KUlQ1bDlt?=
 =?utf-8?B?Y3lNRWRSNXJ6dDE5ZmlGb2pUSE0yQnkxeUczVnhvRE5HTS9SbnZLOFVRLzQx?=
 =?utf-8?B?WG5HdjhWSmlGSXh6bk5wZkgycWgvaFEwbzJ3ZlZJc1JBUmw2ODlmMnF1ZTJI?=
 =?utf-8?B?TXVOTDl0RUllbXVueHBjNDdFa1RZY3dVL1ovdkF2QlRLdVJHWnZzcG9kZFhH?=
 =?utf-8?B?c0FmSE44RVVUL1hoQ3JGcWZnYnVRRmdCanpCVU9kOHlCMG5jNEFIY1I4blMr?=
 =?utf-8?B?STR1NFU1VW1WN3FOT0thanJOMGFoMUJEa3FDZ1ZnT0hWSVpiRk1SZTRsNmhE?=
 =?utf-8?B?SFdkazUvVjlhSVVXN1NpZzJ5dmNDQW8xNXowTnpXN3dlU3ZwaUI4TGFRWTB2?=
 =?utf-8?B?U3ZHOGozZjc5VGt0dXdFeVk3MjkzcUlZVEo5NDFmdDl5bFk4SlF6TlQrREQx?=
 =?utf-8?B?Q0RlSjVOeGkzYjVidDBGRm42M1dQL3BxVUkyMlJJZld0SHVWV25SL0Vra3Jt?=
 =?utf-8?B?S21BS001RzF4dG9pOE5LbFJ6b1FWYm5oSHMxdjZDdXhOR2hHOGJQRWJlZ01R?=
 =?utf-8?B?WEZBMnVRVm5ML25tUjRqT1lmMGt6cjlMbG91L3hJY0JBWkVINHQ2M2Z4L3hF?=
 =?utf-8?B?ZzF0bTNHZEJuMDl6SUw1Q2Z1NFA2L1c5dE1TL3JVTEs1cnh0NHZnNEhBN1pw?=
 =?utf-8?B?RndXSENRaXkwMWhqUm1FWDFnMEE4c0ZEMkRxS3hhSWJaUmJIMjNmZmVtWDFS?=
 =?utf-8?Q?k+v0ojsLBJ9s9f4a3UlDXJ68h2m?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0dWSXlmK3VBeUFwZEE3TFRDNElIK2xYd0J0OWJGWXA2T0ZxaGs5Q1NoUTVJ?=
 =?utf-8?B?b1k3cDBBWVlPQ25HNmZjeitUV3ZGY1JlNHFmQ3FubXlxN0FSa1JYZ0htdkFC?=
 =?utf-8?B?cC9uZ0w3SDZYSG51YXp0VjQ4TkZVWER6aTdrcjVBS3Z4eGY2eTZuVmI3UUZa?=
 =?utf-8?B?R09xWDFDTUJyeVdLREQ2clErU2RIbERCWlJMb0pNTjVGSFpPYlNDNzZnUmJG?=
 =?utf-8?B?WGx3WDRPZXpoaDJ3L2RxQy83MldXcUp3aDBOUzRDZFNwaDMyL3A4OC9KS0Ez?=
 =?utf-8?B?WWdEVVZUV20wcjF4TzRYdDRoVlRLeVVNcE5LNE8zMFUzblJ3Qk9YZytYTWRY?=
 =?utf-8?B?c09tUkozV2xQYTYzc1ZPWDlYTVhYVW9xZFJVU0VCSFFQRWU3VnppdjNqcURH?=
 =?utf-8?B?VTU4T2UrK21rSHAyenZLSVJ6S0dVdC9hajl3bG54RnkvU1loQzVKQjQvL1Nl?=
 =?utf-8?B?VXM1dWZPQ1ZYL3orOVgrNHJPNDdNSlp5VmpFckFsbEJ0YndjNndmZ0t1cEc2?=
 =?utf-8?B?aS82VGd5SUpXSTNQbi83M1hvZjlNeCtuRjRLMUdiQ2JxTHhidzA5d0NDdU5C?=
 =?utf-8?B?bGo4bTNJSFN2bWJRUk5GV3ZEamNIeGpDUEExSkY2WDhiK2ZKcmdjVlRoNXl1?=
 =?utf-8?B?Mm1YUHdZM2F1eHg4QU8wS05aZDdpTUNNbVA3bjFPM0hHdG0zZm51M0dpUHQx?=
 =?utf-8?B?QnIzTTZJT0wycEppUGF2TFBUQVQzeE1oVHF3azJVbDBOZFRuSkNSSlFJcElw?=
 =?utf-8?B?OFFsaXlBZmZhVDVlazNGZ09RZnpCdzlWcjBnZ0NTcy9hZk5EckwvZHBrUzZt?=
 =?utf-8?B?L3RZSGUxRjRyNUJqWVhuVlVSTDdQRVZrUnRPckUvR2tmNThOZm9aQmNoeFMv?=
 =?utf-8?B?RjNMSE4vTW9Pc0RTMU81TDFZTzg5bnBhQnBqK0ExMnYzdjdzYTQwa0pjTW5S?=
 =?utf-8?B?Smc5NUVlUjdibFdjY3BJNmlldFNLWkJwcnBCbTROeFJpVy9CbEpyRE80V3B2?=
 =?utf-8?B?eW1JUVRLMlFGclVuRFpmb3NjZjJMY21wNzZTcDJmakcvVksrT2YxcFdvY3V5?=
 =?utf-8?B?UGIydkRYU3BOaXRBbzNPTzBTTHRPZGhwVWlDTVBpRXMweGtiWlc3RGdRTUFn?=
 =?utf-8?B?NTB4OUNZWkQzRitjcVJCNFVvb1d4Mk9UNkd1QjM2OHgwQ2d2ZGtUOGovUWFh?=
 =?utf-8?B?TnNYUjdxVjZ3YUp3WVZVTnR6OWdOaXUvaDBNVDM1UEovV1VtZ3hhdm5FMWp3?=
 =?utf-8?B?c3Z1UHJEOWxpTjZqNm1xUFpoWm04ajdVcnN0eTFXMzU5YVNpK1FTK2gxbzRa?=
 =?utf-8?B?NzVLN3NwMVAwQnByUFhVUjczM3RidDZZcmhaT1MrNm1wZ2IxL3lnMWE0U01a?=
 =?utf-8?B?OTJ1MldjbjFKL3RQNk9veEQ3Kys5UUw2QmZyT2JrUHV2ZzljaDdqbnIxQUZj?=
 =?utf-8?B?N2QrdTdxL1RJQjU2M2hBbzd1bHZnQ09iV3dvSkg4NEVPWTlFanQ0SUMyZGM2?=
 =?utf-8?B?YWlXWkFqM20zZkl4K0FNVjAvSXZ3TEtxUC9KemErbmRrMmV2dFZaL3dsUTVa?=
 =?utf-8?B?bUpWem5SK0lTQ3M1VUM4TzdsUVUrOWkwNG1kaU8vVUlyQ1YvYjhEL1EwaE5L?=
 =?utf-8?B?SStTRk5pZTBua29NNlIxS1ZaRzVycDVtV254K0pva2JlajlOT3k5d0ZqRUJF?=
 =?utf-8?B?UlhTR3g2RXBsMGdUNUJuRjRYRXNSRTZhUUtucUVKQWt6cHZ2MXF3eGJvdzhu?=
 =?utf-8?B?LzY1a2tGdThRMEZSa2xkeEdHSzBobXJSNEFCRVp3OUp2Wkl0eGxGYlBubUIx?=
 =?utf-8?B?bnZINVdWdzltdzdFYlFCZ0VqVTd5emhsZkwyeXNYSndXc2FwRzg5eW9XV1Ns?=
 =?utf-8?Q?WZph+3VxHyPU3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bce2694-472d-409b-2dea-08deb019e006
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 11:30:31.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB11070

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> The previous change added the --negotiation-restrict synonym for the
> --negotiation-tips option for 'git fetch'. In anticipation of adding a
> new option that behaves similarly but with distinct changes to its
> behavior, rename the internal representation of this data from
> 'negotiation_tips' to 'negotiation_restrict_tips'.

Nitpick: s/tips/tip/ .. no trailing s for either the option name, nor
the (old) variable name. The function names do use the plural however.

> The 'tips' part is kept because this is an oid_array in the transport
> layer. This requires the builtin to handle parsing refs into collections
> of oids so the transport layer can handle this cleaner form of the data.
> 
> Also update the string_list used to store the inputs from command-line
> options.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   builtin/fetch.c    | 18 +++++++++---------
>   fetch-pack.c       | 18 +++++++++---------
>   fetch-pack.h       |  4 ++--
>   transport-helper.c |  2 +-
>   transport.c        | 10 +++++-----
>   transport.h        |  4 ++--
>   6 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fc950fe35b..2ba0051d52 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -98,7 +98,7 @@ static struct transport *gtransport;
>   static struct transport *gsecondary;
>   static struct refspec refmap = REFSPEC_INIT_FETCH;
>   static struct string_list server_options = STRING_LIST_INIT_DUP;
> -static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
> +static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;

Good - now mirrors the new, preferred, option name.

>   struct fetch_config {
>   	enum display_format display_format;
> @@ -1534,13 +1534,13 @@ static int add_oid(const struct reference *ref, void *cb_data)
>   	return 0;
>   }
>   
> -static void add_negotiation_tips(struct git_transport_options *smart_options)
> +static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
>   {
>   	struct oid_array *oids = xcalloc(1, sizeof(*oids));
>   	int i;
>   
> -	for (i = 0; i < negotiation_tip.nr; i++) {
> -		const char *s = negotiation_tip.items[i].string;
> +	for (i = 0; i < negotiation_restrict.nr; i++) {
> +		const char *s = negotiation_restrict.items[i].string;
>   		struct refs_for_each_ref_options opts = {
>   			.pattern = s,
>   		};

All callers and references are renamed to match consistency. Good.

> @@ -1561,7 +1561,7 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
>   			warning(_("ignoring %s=%s because it does not match any refs"),
>   				"--negotiation-restrict", s);
>   	}
> -	smart_options->negotiation_tips = oids;
> +	smart_options->negotiation_restrict_tips = oids;
>   }
>   
>   static struct transport *prepare_transport(struct remote *remote, int deepen,
> @@ -1595,9 +1595,9 @@ static struct transport *prepare_transport(struct remote *remote, int deepen,
>   		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
>   		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
>   	}
> -	if (negotiation_tip.nr) {
> +	if (negotiation_restrict.nr) {
>   		if (transport->smart_options)
> -			add_negotiation_tips(transport->smart_options);
> +			add_negotiation_restrict_tips(transport->smart_options);
>   		else
>   			warning(_("ignoring %s because the protocol does not support it"),
>   				"--negotiation-restrict");
> @@ -2566,7 +2566,7 @@ int cmd_fetch(int argc,
>   			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
>   		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
>   		OPT_IPVERSION(&family),
> -		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
>   				N_("report that we have only objects reachable from this object")),
>   		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
>   		OPT_BOOL(0, "negotiate-only", &negotiate_only,
> @@ -2658,7 +2658,7 @@ int cmd_fetch(int argc,
>   		config.display_format = DISPLAY_FORMAT_PORCELAIN;
>   	}
>   
> -	if (negotiate_only && !negotiation_tip.nr)
> +	if (negotiate_only && !negotiation_restrict.nr)
>   		die(_("%s needs one or more %s"), "--negotiate-only",
>   		    "--negotiation-restrict=*");
>   
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 6ecd468ef7..baf239adf9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -291,21 +291,21 @@ static int next_flush(int stateless_rpc, int count)
>   }
>   
>   static void mark_tips(struct fetch_negotiator *negotiator,
> -		      const struct oid_array *negotiation_tips)
> +		      const struct oid_array *negotiation_restrict_tips)
>   {
>   	struct refs_for_each_ref_options opts = {
>   		.flags = REFS_FOR_EACH_INCLUDE_BROKEN,
>   	};
>   	int i;
>   
> -	if (!negotiation_tips) {
> +	if (!negotiation_restrict_tips) {
>   		refs_for_each_ref_ext(get_main_ref_store(the_repository),
>   				      rev_list_insert_ref_oid, negotiator, &opts);
>   		return;
>   	}
>   
> -	for (i = 0; i < negotiation_tips->nr; i++)
> -		rev_list_insert_ref(negotiator, &negotiation_tips->oid[i]);
> +	for (i = 0; i < negotiation_restrict_tips->nr; i++)
> +		rev_list_insert_ref(negotiator, &negotiation_restrict_tips->oid[i]);
>   	return;
>   }
>   
> @@ -355,7 +355,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>   			   PACKET_READ_CHOMP_NEWLINE |
>   			   PACKET_READ_DIE_ON_ERR_PACKET);
>   
> -	mark_tips(negotiator, args->negotiation_tips);
> +	mark_tips(negotiator, args->negotiation_restrict_tips);
>   	for_each_cached_alternate(negotiator, insert_one_alternate_object);
>   
>   	fetching = 0;
> @@ -1728,7 +1728,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>   			else
>   				state = FETCH_SEND_REQUEST;
>   
> -			mark_tips(negotiator, args->negotiation_tips);
> +			mark_tips(negotiator, args->negotiation_restrict_tips);
>   			for_each_cached_alternate(negotiator,
>   						  insert_one_alternate_object);
>   			break;
> @@ -2177,7 +2177,7 @@ static void clear_common_flag(struct oidset *s)
>   	}
>   }
>   
> -void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   			   const struct string_list *server_options,
>   			   int stateless_rpc,
>   			   int fd[],
> @@ -2195,13 +2195,13 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
>   	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;
>   
>   	fetch_negotiator_init(the_repository, &negotiator);
> -	mark_tips(&negotiator, negotiation_tips);
> +	mark_tips(&negotiator, negotiation_restrict_tips);
>   
>   	packet_reader_init(&reader, fd[0], NULL, 0,
>   			   PACKET_READ_CHOMP_NEWLINE |
>   			   PACKET_READ_DIE_ON_ERR_PACKET);
>   
> -	oid_array_for_each((struct oid_array *) negotiation_tips,
> +	oid_array_for_each((struct oid_array *) negotiation_restrict_tips,
>   			   add_to_object_array,
>   			   &nt_object_array);
>   
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 9d3470366f..6c70c942c2 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -21,7 +21,7 @@ struct fetch_pack_args {
>   	 * If not NULL, during packfile negotiation, fetch-pack will send "have"
>   	 * lines only with these tips and their ancestors.
>   	 */
> -	const struct oid_array *negotiation_tips;
> +	const struct oid_array *negotiation_restrict_tips;
>   
>   	unsigned deepen_relative:1;
>   	unsigned quiet:1;
> @@ -89,7 +89,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>    * In the capability advertisement that has happened prior to invoking this
>    * function, the "wait-for-done" capability must be present.
>    */
> -void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
>   			   const struct string_list *server_options,
>   			   int stateless_rpc,
>   			   int fd[],

LGTM up to here.

> diff --git a/transport-helper.c b/transport-helper.c
> index 4d95d84f9e..0e5b3b7202 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -754,7 +754,7 @@ static int fetch_refs(struct transport *transport,
>   		set_helper_option(transport, "filter", spec);
>   	}
>   
> -	if (data->transport_options.negotiation_tips)
> +	if (data->transport_options.negotiation_restrict_tips)
>   		warning("Ignoring --negotiation-tip because the protocol does not support it.");
>   
>   	if (data->fetch)

Oh! Looks like a place was missed when renaming the preferred option 
name in strings. It probably makes sense to do this rename in this patch
(rather than in patch 1) since we're already updating the struct field
name here anyway, but up to you.

Also do we also want to make it translatable like the others?

> diff --git a/transport.c b/transport.c
> index 107f4fa5dc..a3051f6733 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -463,7 +463,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>   	args.refetch = data->options.refetch;
>   	args.stateless_rpc = transport->stateless_rpc;
>   	args.server_options = transport->server_options;
> -	args.negotiation_tips = data->options.negotiation_tips;
> +	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
>   	args.reject_shallow_remote = transport->smart_options->reject_shallow;
>   
>   	if (!data->finished_handshake) {
> @@ -491,7 +491,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>   			warning(_("server does not support wait-for-done"));
>   			ret = -1;
>   		} else {
> -			negotiate_using_fetch(data->options.negotiation_tips,
> +			negotiate_using_fetch(data->options.negotiation_restrict_tips,
>   					      transport->server_options,
>   					      transport->stateless_rpc,
>   					      data->fd,
> @@ -979,9 +979,9 @@ static int disconnect_git(struct transport *transport)
>   		finish_connect(data->conn);
>   	}
>   
> -	if (data->options.negotiation_tips) {
> -		oid_array_clear(data->options.negotiation_tips);
> -		free(data->options.negotiation_tips);
> +	if (data->options.negotiation_restrict_tips) {
> +		oid_array_clear(data->options.negotiation_restrict_tips);
> +		free(data->options.negotiation_restrict_tips);
>   	}
>   	list_objects_filter_release(&data->options.filter_options);
>   	oid_array_clear(&data->extra_have);
> diff --git a/transport.h b/transport.h
> index 892f19454a..cdeb33c16f 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -40,13 +40,13 @@ struct git_transport_options {
>   
>   	/*
>   	 * This is only used during fetch. See the documentation of
> -	 * negotiation_tips in struct fetch_pack_args.
> +	 * negotiation_restrict_tips in struct fetch_pack_args.
>   	 *
>   	 * This field is only supported by transports that support connect or
>   	 * stateless_connect. Set this field directly instead of using
>   	 * transport_set_option().
>   	 */
> -	struct oid_array *negotiation_tips;
> +	struct oid_array *negotiation_restrict_tips;
>   
>   	/*
>   	 * If allocated, whenever transport_fetch_refs() is called, add known

Just a missing string rename, and a nitpick typo in the commit message, 
but otherwise this patch looks functionally correct.


Aside: I just noticed another '--negotiation-tip' instance in the
`get_commons_through_negotiation` function in send-pack.c. It still uses
the 'tip' option name when forming the shell cmdline.


Thanks,
Matthew


