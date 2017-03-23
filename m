Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB8720958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753132AbdCWTSg (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:18:36 -0400
Received: from mout.web.de ([212.227.15.4]:52905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751956AbdCWTSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:18:35 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCZfe-1d0Vv72oE6-009SuW; Thu, 23
 Mar 2017 20:18:27 +0100
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170323155012.6148-1-szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
Date:   Thu, 23 Mar 2017 20:18:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170323155012.6148-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Jcr4F4VqTEgfeapQYMCqmwGxkFs68RJxpvyZ8ew34XitxdOUOWN
 P/QxMgpul7TxMscDH/z4R5wam5OPdZVIPSHAyJtVF74qJDxKpyddxsRw6OkseJZSDTkwJMV
 Px1gBx++KnyFZH35FHLWVKSZWBBnnViDv8tYX6GR99h7T8c4WdwRfoi+ac5zDgwDjlWDpxN
 q51INdv1XFvXbImQnl/UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:s8h8dAwyI+I=:eHat8wGOuUi+XlYKbPwQLo
 Cm4aDCjvvc+EYLYKw+qfE/zUdqEC9jBBS7ilskEKdI/F2C3J62jBlllTuMVL7evh1W7fhodi+
 Gti8D44V2oYVA7/lNrkmnCM+KTqi5FuXnv6Y21puI7ZOXpRLrTxUJJE6DsWC6wJydMm+y4Zzl
 d5l1upTowhY/Q2P/IXmd4efzvC5Zh6qlesc5n9jEZ6J83NSxOFFp6mi7sBO7UzNLvHPTIAVit
 kicrRumm02Tq6TL9e4riablS49lx435U3VpWAsu1tcjjJ9NlmBBI1dC3nWBszG56igsa1Lah9
 3s6DPN9fm877aWyxz4CI04mI5Jn4UuSAr3/91Uab2bu15mv8C3R6DiSx3WUWiRLGyuMdZ6Dt1
 Z3tlLoXGMqFt4gklhgC3qFy2bzBPDvClbvYj+vMSiDvQ2Dpi84fAQthvG9Q0E/RPxASqB/Vg6
 vN/Vdg0rMcSto4TpX5c8XcFWBefY8pxTh26AixCts0z6Scbxjne6/p/DzxGd3LgTeypEArG06
 6mDOVzt/ClFpx5nWq2YIPXf8D++29UzV3xDrKSCOqx0FqicKNpFYCXn+SKWUCipK36cINB6VQ
 +yc3vEWEzMOdXrYDBvNP5K1bAxQVrqQw5yyocXkUi9TRH8owrBZG+tBwONZVfi51kgM3I5BTs
 l8epHjrgHiCGaAL/rW6Fk3HXSxW7TvQHxfNuo3UC6Tjb2x1XANHZWP/v7GInE2jNnsoWmjhi8
 AMjzRAL419C1poHDe3cxP1nQCMHGlJd60oQAIpiYdJwBweL1y2FeKTCffRIwBJvZz0Jp5l/85
 jdfhQgt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.03.2017 um 16:50 schrieb SZEDER Gábor:
> This eliminates three magic numbers.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  refs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index e7606716d..0272e332c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -366,11 +366,11 @@ int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data)
>
>  const char *prettify_refname(const char *name)
>  {
> -	return name + (
> -		starts_with(name, "refs/heads/") ? 11 :
> -		starts_with(name, "refs/tags/") ? 10 :
> -		starts_with(name, "refs/remotes/") ? 13 :
> -		0);
> +	if (skip_prefix(name, "refs/heads/", &name) ||
> +	    skip_prefix(name, "refs/tags/", &name) ||
> +	    skip_prefix(name, "refs/remotes/", &name))
> +		; /* nothing */
> +	return name;

Nice, but why add the "if" when it's doing nothing?

René
