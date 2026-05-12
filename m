Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010007.outbound.protection.outlook.com [52.103.33.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0F3B8BCB
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598898; cv=fail; b=sGf2hkN+CWQHga+LVmrbGcSGScseYG1QSqEZhVNd/mRnS9XnCc40whV2t8WSRQ/85aLg2tSuYZnGLCtWmAaV7NVicNtfeJvSyw7qtufPBYOHaIW2zKktdX3/7IQAyViVumNX4iwCBGJcdnwhPpJpmxP4sYnzP9u4eIQsREdLa/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598898; c=relaxed/simple;
	bh=WXMrLdQJLuiFyJNdRL1Z0FcuPWb4Bj0STCoJZG9iiqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Er1WnhQhoRfCm1R8UK8TBZH22Ey0WofhMQVyxwpg+htD4mlaU/j67G3bPE7ftljp9fyLtzl94QLSKLcMxNBTyZynj9C9KmQy1tr12okwwPte5sIjT3x94AkdoDdKjkSS/WLfwHA9dW0BORQ0/RRrQYwNgQkUpfrKUmcYR/tDFSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=o6artLrf; arc=fail smtp.client-ip=52.103.33.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o6artLrf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzPTcChS6R6Y/KFqGM2dsJmORfVIw+oNta9EUP+H8VDtPFm1BeyUakL1B6jCwchhYFWybkKL4hGOmNUPGncvX9ea5zTIWrnJ8yEBGaOqmFlPLd6Y4DmdBOnUubA2juX8DW3Mu43s3CEctXuZ6Qpx7nZ+EF013abdNmgPR7zG7YpSTCVodkfhTnKOwmZcAj5IG61+vPWyqPCREt4dQVhC6mA+VSDsv3Ds6WS3p87An73doStGr1zyflVZE5ORLZ8GqqkLd9BIBWHszOLx/1DtodFeE2Ge/cqSeQPSuuf0ZS7/rGBFEjGI7aRGgG0m0UNtxk3gaRnCMJ4UY4avOUl74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJLQVMWgArDu7SKrZAF/y4qgmjTYMfqfylx5DgiW1i8=;
 b=uTPHzpiIUA52PR7JUfSiRDchkwGdjY9rYtXbhzeBCBAMilHpEGob/4eAAPOqXW0tOhjiQJ/G1o8mKdtuUGv35bv2g+p5jQ+CqtaOsWDsAZ/omnpApeJKUeVfKikKzzuvCsXq2NiBMxXm4xQ8sbq4HOD56BrY4+d1ikxSuvDxXiAaeMQUVSbjkZPPK4MvlR/jzpPBzj6gzsecBDtKUKpTtIy2sEOIExmBCugN761kqo33MFvAdj0arXvn0indRnZKU83KZbW+5yC59O+NNHLREpZSkPTGDC5DvBSuCbUFBgye9J28aBiF4ZkZdgtE5wJMXMM/eXTSgCQqb7vAOaB2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJLQVMWgArDu7SKrZAF/y4qgmjTYMfqfylx5DgiW1i8=;
 b=o6artLrf3w1/PT9OkYsVUl/ixBac57Hy8G7JIJmPXHzpkmMzpquvLq0OzHjeU+N88qvIz63eiZIA8Gsi7Lx+MjE2RB8cf69ShhKmVHFyHU/zf+xH5XXZjVMkHTVUfpDuBkO+DfB3GijlAZRnCR/f9sTEP6hwn0DamP403VF2obzaekXsH/dXfcThZjVoRyh5959BvNz/4YxOKiMpRSyXpd83lrkbeb5Jrwzg72C2GgM74Ms2Pv0DqcjaYDZcOvKMANUaQpxrvUySoSC4wv94mg2aWie41JVsx5pSHBDaC0+uMa9yBRQDsu3vNHlA9Jg2uPWuBBN2IWb37y2eBrDgqg==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by PAWPR03MB9978.eurprd03.prod.outlook.com
 (2603:10a6:102:361::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 15:14:51 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 15:14:51 +0000
Message-ID:
 <VI0PR03MB1163435C53EEC99C686E3FE53C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 12 May 2026 16:14:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] send-pack: pass negotiation config in push
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <e6c79f0661b97d0081ae36b17be8ccb3b9ec64e4.1776871546.git.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <e6c79f0661b97d0081ae36b17be8ccb3b9ec64e4.1776871546.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0304.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::20) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <d32068e8-00a3-4b74-9803-94f247a2b38a@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|PAWPR03MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: 883a758a-a61b-42b1-8c9e-08deb03936d7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|37011999003|15080799012|6090799003|5072599009|24021099003|19110799012|23021999003|8060799015|41001999006|3412199025|440099028|19061999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFVwYTJiRGV2Yko0OHI4TlJBWTV3YjRZV0psbyt0VHdpSTdBU2ZHdXVnVVVo?=
 =?utf-8?B?OGUxNW96WEZuQ1RWQnp1ZVFEbGwzRG00SjFCY3pKdDRvRGQxVkljaHVDWW5X?=
 =?utf-8?B?TVBUUWgzeUJlV2ZzL2svUmJpaStsWmJrWTdqdHRMUVluTjBra1JobmlzVGFo?=
 =?utf-8?B?NjhLckkyOWYrL0lYVjVJOUNyMVkyamd6NnMzeGo3ZjA1VjJoOE1EMzFFVCtm?=
 =?utf-8?B?bUxnS2g1U3Z2b3NWNnIza0R5d0FPczQ3WTRFd3NSTVROTWFXVG9LYkJmWHYv?=
 =?utf-8?B?YjBwRHhvam9KU295WjVheTBsUlFXWHphaTlkdlMxMnVGaGxaeGdjVHhaQ1Ux?=
 =?utf-8?B?MzdwWTQ5Wm9HMkNvN25LUDJjNHdUQ2s4Uk1jUE9MeXJKc2tEbEE4dVd1bDFC?=
 =?utf-8?B?Sk5rZ0lxU0VVY0lNcGxSU0F4cEF5bm0xSW1IeEFUaXhVZUF4M25ibjNnVTNO?=
 =?utf-8?B?a25lN1dVRzluVUloQmZyYlFMKzFYWS92NFJpaEROSnJFVlFHYTd6dTFlN0ov?=
 =?utf-8?B?aTFUMEVCMyt6N01SOWpoUlViNUc4Y2FNNFJheU5xZXBxcW0vdlc1L1BHYlRT?=
 =?utf-8?B?Z2txd0RaN05EVDRXeEs1eGtmaUtKb01GWVhicnpJQklUWXUvdjQwaUpUTnp2?=
 =?utf-8?B?MUJVdTRETXpId1dYL093dUdBNzRXSG9BTnlQNVNKQitIZU54bWpkOWpOUGdY?=
 =?utf-8?B?dkJidzVkT3BRQTdUdFRyeFNCZnNWSGF2TEhON2JyTm1WKytyd2xnRUlVc09j?=
 =?utf-8?B?MHFwV2Q4R25TeldMSS9EL3IxMDIwYTJRU0tXT2JuYmowZUM4OHpydWt0Ni9Q?=
 =?utf-8?B?MkNQMWpqdHl6ZC9vc1QzUCtwTStjRUJHRU9kWlMveEdlSkdaWWdiTThDakow?=
 =?utf-8?B?aGkzUjJYV0Jmc1Q0MnB5RzNLMVR4Zk5JMndlUEwrNXB6ekFDMzJUWUltZEpm?=
 =?utf-8?B?WnFwSjVMZU9TdzhDZnZuTUlueE05UkpXbHhCZUxoUms4YmI3QVU4MTYwTjFN?=
 =?utf-8?B?M0N6NUNOM243RFRlOThFV205cFozN0hoMDRjWjVaOGlLQW1wdUpvWklsT0xl?=
 =?utf-8?B?dWhGYXRwZEZybW1ST0JTdHM1VTUySG93NFFScXhteXVFTmdlQzFPbjZoV3gr?=
 =?utf-8?B?bXY2WWVBWENJRk9TR0lReUZ2ZEtXTjJqR0kyU0tVRFpnbnZQQXQyRWdzUW14?=
 =?utf-8?B?YVBSazJMTzJTUmMrU3JDTzVaOEd0Uk5YVDdSRlBIMEd5VkRpMVc2VFNEVzZV?=
 =?utf-8?B?VnBjc0hkMlRLWjJVbDRlYlFLWGVZNUhFYXlRa1QwNlhwcDVDK2NQUkxrdzFJ?=
 =?utf-8?B?cmJaQkFEVE9jcHJJb1EyUUUzQ0taTytxdFd5U01sS1ptWVR2RW43Q2c1b2tj?=
 =?utf-8?B?blBDNDd5Uk1lRXZXaFM1Vm1iY2JkZHNtaSt5TzM0RFVpcVJjdXBjZVB5SlFa?=
 =?utf-8?Q?RLEulcfO?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmZudTN3MWJkYi9MVU4xZ2F4L2xaT3Q3YXRCS0N1MmlUK1dUL0U0Uys2bk9x?=
 =?utf-8?B?TnZSUHJXTFl6Q0VmNElhSnVlVUlPQlkxSStnUFV1WU1YVTAwd1JnV2kvRUE1?=
 =?utf-8?B?M1BnYzZSZHdHaTJ6TXNkYk14bm50cTVRbHJreTUyL1k1VVc4eWZZdThrMEN6?=
 =?utf-8?B?ejN1TkxDVnNLTnRDRENQTldES2NmT2RRUkN6dURvYW10ZTRPN04ySTdxNGRi?=
 =?utf-8?B?SGhhc3Z1Vmx2OUVpKzR0YVo3c3RtVEpuRzdKdUpabldPWVU5UVRvWVVZT2FE?=
 =?utf-8?B?SW5wVWNlTDVGSnNkaVc1KzFJQ05xRXN0NWY4UnZTejhHMVhSbDJ3Yk1QYjFs?=
 =?utf-8?B?S21VYUxSRml0TTZwRS9yeVk3bGhKdmR1SEdrdThHSWhvWkVaVnNXalZqVTVy?=
 =?utf-8?B?OEp0NWlkNlJjVEJhbWZPNFVlTC9rRDM0L1JHQnVERHVzZTdJUUxnQk0rY2Nq?=
 =?utf-8?B?L0paTmtDcks5blBDaWVmQUZ3OXlRbE9MV2xHby9oUGttTVJ4NWdSNVZLTGhn?=
 =?utf-8?B?Qkc1anRJdEhhS0xVc2p1VGhlOENCYjdMdW5ETm5yK0JWakwrZndNdXkxVjRF?=
 =?utf-8?B?OFlDWGV4NEIvN052QjNWTFB4MFhEWGhldUY0ZnpsY3lBV0ZxcG9pMWk1b05P?=
 =?utf-8?B?ZURFR0VtUit4NHF2VCtkbC9ybmZwZWFJU2VXVkQwMnlRTkFZVFdTWm9Ob3Fr?=
 =?utf-8?B?S1ZER3l4b0I3RTdnRWFLVFdQS3dJYzdKVW5adkt0WVJHVGFSdlZGZnMrZ2Ix?=
 =?utf-8?B?NVpsK1lWaG1WSHRsNlVCT05KRWx1dTVOUFpBQ25LVEswQy9BQ1IwUkkzUlo2?=
 =?utf-8?B?UVA4SExJTEh3UTloMzcvNTZZSWVBMkhROUJZMFV0aVZaTnRXSFBMV1luU3FK?=
 =?utf-8?B?c01EV1NOU1g4TG12b2tyMXVPc3NNcGJqU1FWRWd3MWV5SUNSNTNMMno0NXlH?=
 =?utf-8?B?enBFWWY4WmpNZENQRG0xWEZ0LzZaZzZ4bjZSZWV5cFJBZTJpNTArdWk0RmpG?=
 =?utf-8?B?bU1Rb3FzQTF2MmdsQXh0RTR2U3MreC8xYUFMTk1obE1nTTJOcGNybnYySW1m?=
 =?utf-8?B?L3BMMlduQlk0N3JIbTlqdkltUEc4RythaVRLWmpnR09ZQzlsdUFYQ00yWEIx?=
 =?utf-8?B?VTlkZjhjYXQ2VE8vcVNwZUxqcFphb2YrckM1bXZ6UDIzV2pwU2ZXeG1QeG9F?=
 =?utf-8?B?MmNDbDRqdXl6T0xFOEduTTM5ZXZkdEJWK2lKNnprVC85RHQzZ2RHVTNvRVp6?=
 =?utf-8?B?cERFa3pXSDRiczNLeXNrbTY5WTkxbjFsaUswRGNIZWpaVW9SZk5SQW8yMUZs?=
 =?utf-8?B?Vm16MC9XdHJiL1VnZG1oNE1iak9vTllVb1RJbXlBNjNQdEc1aU9wT0w1alkw?=
 =?utf-8?B?RXQ0dXVnVzE5aVlJVnBCOVdxaTM3VndCc0JmQ0IzRmFOMDVNcWk1SUlxVVJV?=
 =?utf-8?B?ZEQyVWlGaEdCWnc5Y2xWV3NZWTlkc0x5MHVOSzl4cEo0YldoZnpLUFNKeFRX?=
 =?utf-8?B?am0xbE1TRXRXL245eEYvR0VZdmdjcWtiT0taS1dHTkhlcUlXd3RqOFJJODlx?=
 =?utf-8?B?clhucnVwTlp2aUtpRE5ud3pyWkZydTc2bXp6cHdLbVRyWmNSMFhWSlhtSW13?=
 =?utf-8?B?U1BxM29KeXBZR2hlVXZWckNSdmZENU14UmIza1B1ak1XWXNneVVxbVBONEhE?=
 =?utf-8?B?ZGozUW5JQVlTekJuNkRyOUFZVEdxNXZ6M2lwdHJIQ3NOR0RYZ2R6YVF4SCtB?=
 =?utf-8?B?b1Y2RDIzbis4aHhBSUZXb00wYXlDQUlXeGNFQmZFYWNob0NhME9GeEdhT1Z2?=
 =?utf-8?B?Q2JZY2ZUR0tvSmZ6RDdWWk9pb1JGR1BRb1ZxdjJURVJiWVFNWjhoZ1laZThX?=
 =?utf-8?Q?pXzcEPOwms71b?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883a758a-a61b-42b1-8c9e-08deb03936d7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:14:51.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9978

On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <stolee@gmail.com>
> 
> When push.negotiate is enabled, 'git push' spawns a child 'git fetch
> --negotiate-only' process to find common commits.  Pass
> --negotiation-include and --negotiation-restrict options from the
> 'remote.<name>.negotiationInclude' and
> 'remote.<name>.negotiationRestrict' config keys to this child process.
> 
> When negotiationRestrict is configured, it replaces the default
> behavior of using all remote refs as negotiation tips. This allows
> the user to control which local refs are used for push negotiation.
> 
> When negotiationInclude is configured, the specified ref patterns
> are passed as --negotiation-include to ensure their tips are always
> sent as 'have' lines during push negotiation.
> 
> This change also updates the use of --negotiation-tip into
> --negotiation-restrict now that the new synonym exists.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>   send-pack.c           | 39 +++++++++++++++++++++++++++++++--------
>   send-pack.h           |  2 ++
>   t/t5516-fetch-push.sh | 30 ++++++++++++++++++++++++++++++
>   transport.c           |  2 ++
>   4 files changed, 65 insertions(+), 8 deletions(-)

This patch wires up the negotiation behaviour with push, added in the
previous patches.

> diff --git a/send-pack.c b/send-pack.c
> index 67d6987b1c..d18e030ce8 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -433,28 +433,48 @@ static void reject_invalid_nonce(const char *nonce, int len)
>   
>   static void get_commons_through_negotiation(struct repository *r,
>   					    const char *url,
> +					    const struct string_list *negotiation_include,
> +					    const struct string_list *negotiation_restrict,
>   					    const struct ref *remote_refs,
>   					    struct oid_array *commons)
>   {
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	const struct ref *ref;
>   	int len = r->hash_algo->hexsz + 1; /* hash + NL */
> -	int nr_negotiation_tip = 0;
> +	int nr_negotiation = 0;
>   
>   	child.git_cmd = 1;
>   	child.no_stdin = 1;
>   	child.out = -1;
>   	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
> -	for (ref = remote_refs; ref; ref = ref->next) {
> -		if (!is_null_oid(&ref->new_oid)) {
> -			strvec_pushf(&child.args, "--negotiation-tip=%s",
> -				     oid_to_hex(&ref->new_oid));
> -			nr_negotiation_tip++;
> +
> +	if (negotiation_restrict && negotiation_restrict->nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, negotiation_restrict)
> +			strvec_pushf(&child.args, "--negotiation-restrict=%s",
> +				     item->string);
> +		nr_negotiation = negotiation_restrict->nr;
> +	} else {
> +		for (ref = remote_refs; ref; ref = ref->next) {
> +			if (!is_null_oid(&ref->new_oid)) {
> +				strvec_pushf(&child.args, "--negotiation-restrict=%s",
> +					     oid_to_hex(&ref->new_oid));
> +				nr_negotiation++;
> +			}
>   		}
>   	}
> +
> +	if (negotiation_include && negotiation_include->nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, negotiation_include)
> +			strvec_pushf(&child.args, "--negotiation-include=%s",
> +				     item->string);
> +		nr_negotiation += negotiation_include->nr;
> +	}
> +
>   	strvec_push(&child.args, url);
>   
> -	if (!nr_negotiation_tip) {
> +	if (!nr_negotiation) {
>   		child_process_clear(&child);
>   		return;
>   	}

Reads cleanly, and also updates the calls to fetch to use the new
preferred option name `restrict` vs the older `tip`. Nice!

> @@ -528,7 +548,10 @@ int send_pack(struct repository *r,
>   	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
>   	if (push_negotiate) {
>   		trace2_region_enter("send_pack", "push_negotiate", r);
> -		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
> +		get_commons_through_negotiation(r, args->url,
> +					       args->negotiation_include,
> +					       args->negotiation_restrict,
> +					       remote_refs, &commons);
>   		trace2_region_leave("send_pack", "push_negotiate", r);
>   	}
>   
> diff --git a/send-pack.h b/send-pack.h
> index c5ded2d200..13850c98bb 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -18,6 +18,8 @@ struct repository;
>   
>   struct send_pack_args {
>   	const char *url;
> +	const struct string_list *negotiation_include;
> +	const struct string_list *negotiation_restrict;
>   	unsigned verbose:1,
>   		quiet:1,
>   		porcelain:1,
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index ac8447f21e..177cbc6c75 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -254,6 +254,36 @@ test_expect_success 'push with negotiation does not attempt to fetch submodules'
>   	! grep "Fetching submodule" err
>   '
>   
> +test_expect_success 'push with negotiation and remote.<name>.negotiationInclude' '
> +	test_when_finished rm -rf negotiation_include &&
> +	mk_empty negotiation_include &&
> +	git push negotiation_include $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C negotiation_include unrelated_commit &&
> +	git -C negotiation_include config receive.hideRefs refs/remotes/origin/first_commit &&
> +	test_when_finished "rm event" &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" \
> +		git -c protocol.version=2 -c push.negotiate=1 \
> +		-c remote.negotiation_include.negotiationInclude=refs/heads/main \
> +		push negotiation_include refs/heads/main:refs/remotes/origin/main &&
> +	test_grep \"key\":\"total_rounds\" event &&
> +	grep_wrote 2 event # 1 commit, 1 tree
> +'
> +
> +test_expect_success 'push with negotiation and remote.<name>.negotiationRestrict' '
> +	test_when_finished rm -rf negotiation_restrict &&
> +	mk_empty negotiation_restrict &&
> +	git push negotiation_restrict $the_first_commit:refs/remotes/origin/first_commit &&
> +	test_commit -C negotiation_restrict unrelated_commit &&
> +	git -C negotiation_restrict config receive.hideRefs refs/remotes/origin/first_commit &&
> +	test_when_finished "rm event" &&
> +	GIT_TRACE2_EVENT="$(pwd)/event" \
> +		git -c protocol.version=2 -c push.negotiate=1 \
> +		-c remote.negotiation_restrict.negotiationRestrict=refs/heads/main \
> +		push negotiation_restrict refs/heads/main:refs/remotes/origin/main &&
> +	test_grep \"key\":\"total_rounds\" event &&
> +	grep_wrote 2 event # 1 commit, 1 tree
> +'
> +
>   test_expect_success 'push without wildcard' '
>   	mk_empty testrepo &&
>   
> diff --git a/transport.c b/transport.c
> index 8a2d8adffc..60b73feb34 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -921,6 +921,8 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>   	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
>   	args.push_options = transport->push_options;
>   	args.url = transport->url;
> +	args.negotiation_include = &transport->remote->negotiation_include;
> +	args.negotiation_restrict = &transport->remote->negotiation_restrict;
>   
>   	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
>   		args.push_cert = SEND_PACK_PUSH_CERT_ALWAYS;

I've got no other comments on this patch :-)

Thanks,
Matthew
