Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CD01F463
	for <e@80x24.org>; Mon, 16 Sep 2019 02:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfIPCFH (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 22:05:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41483 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfIPCFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 22:05:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id x4so9681165qtq.8
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 19:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wmnmb+9hiuLr4k+YCF2zXDImKUg/LFLA7DV5l99U2io=;
        b=d2TUaZuzGepVQJDK+NQkTTHstbCFqma9aSOS2SYbSpMetB1pbLcyZKrLKdB0uIaFam
         eYj51Cn7B5tV7KJ1mfzsptudnDRxcpQahb3o9ku+QWqm0B4QbJmL7RjtaWVvAgByT+Or
         5qDkJbKja0Wh0/xZ3L7yc62264cEQ8VX3iWf7PNm5JHyd5bloYTBf1LzkOb1Ldn3jq7s
         stp/p51IwSNYc8MnI14vzVAHiYgyfcblMl8ho3/m1mQ8rIqhWAxFplGUyhntL3ZZUeYz
         LN4HiA5idmeQe/qDulqeIfyS+ST6SaLUUqlvk/7dyvkTZ7YLC4qKow7sT1SoUcqo+n8t
         qwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wmnmb+9hiuLr4k+YCF2zXDImKUg/LFLA7DV5l99U2io=;
        b=QXKKO9MBIxpYMIwRkJf2vwRE+pGqMfg3wPQaYHmwe3oNFzIVJTQa8asLBn8LmIfJ7p
         qg4OS4+rjumfHnaOHfBMFOj1AswD+B6L2j5ziej7IxoRAmCi/a2zziZ+evxdxVLHJUD0
         Coa5sp85AOMJ9FzvG/j8198siSrmBFkTNZYuShrNOU0QaEh6mWTS5AHfB4YeTUuQzhZo
         dKrR6LdrSty5kp2vedw71FOM3zjvb/qM4L3FVmzn7dqiOnHHEYHXrMsVyxxiAsqJ0YAl
         GxSJKhR6jbLkeL+upSP/R41xMUylFiIJZilYRjxhkc9U8IzWOo0w/1XYh+eT2BH2ydUz
         7fAA==
X-Gm-Message-State: APjAAAVth1FWqGnQcg3bbO4OErE6cKSDok5391ThYOL4rWn0rCc0xWK3
        FmXO85B2cRBFyYlGg3vZFUU=
X-Google-Smtp-Source: APXvYqzlcpe8H/lz2uVO+z+NtGmpy84MMgh/Empn/oAjTfHTeuXDgsssbOM9FpXMH1JALbzDyWoEIg==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr11335612qvt.76.1568599506127;
        Sun, 15 Sep 2019 19:05:06 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t64sm4577901qkc.70.2019.09.15.19.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 19:05:05 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: use commit_list_count()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <1d28fb89-6ed6-b70f-762c-b65cffeb6705@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb0aeb20-4fa0-7898-c3c8-139526667f5d@gmail.com>
Date:   Sun, 15 Sep 2019 22:05:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <1d28fb89-6ed6-b70f-762c-b65cffeb6705@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/15/2019 1:07 PM, René Scharfe wrote:
> Let commit_list_count() count the number of parents instead of
> duplicating it.  Also store the result in an unsigned int, as that's
> what the function returns, and the count is never negative.

I was unfamiliar with this method, but it obviously removes some
redundant code. We would have many more problems before the signed-ness
of the int was important, but good to use the type matching the
method.

Thanks,
-Stolee

> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  commit-graph.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 9b02d2c426..5b0d6b5adc 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1279,7 +1279,6 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
>  static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
>  {
>  	uint32_t i;
> -	struct commit_list *parent;
> 
>  	ctx->num_extra_edges = 0;
>  	if (ctx->report_progress)
> @@ -1287,7 +1286,8 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
>  			_("Finding extra edges in commit graph"),
>  			ctx->oids.nr);
>  	for (i = 0; i < ctx->oids.nr; i++) {
> -		int num_parents = 0;
> +		unsigned int num_parents;
> +
>  		display_progress(ctx->progress, i + 1);
>  		if (i > 0 && oideq(&ctx->oids.list[i - 1], &ctx->oids.list[i]))
>  			continue;
> @@ -1301,10 +1301,7 @@ static void copy_oids_to_commits(struct write_commit_graph_context *ctx)
> 
>  		parse_commit_no_graph(ctx->commits.list[ctx->commits.nr]);
> 
> -		for (parent = ctx->commits.list[ctx->commits.nr]->parents;
> -		     parent; parent = parent->next)
> -			num_parents++;
> -
> +		num_parents = commit_list_count(ctx->commits.list[ctx->commits.nr]->parents);
>  		if (num_parents > 2)
>  			ctx->num_extra_edges += num_parents - 1;
> 
> @@ -1616,8 +1613,7 @@ static int commit_compare(const void *_a, const void *_b)
> 
>  static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  {
> -	uint32_t i, num_parents;
> -	struct commit_list *parent;
> +	uint32_t i;
> 
>  	if (ctx->report_progress)
>  		ctx->progress = start_delayed_progress(
> @@ -1635,10 +1631,9 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>  			die(_("unexpected duplicate commit id %s"),
>  			    oid_to_hex(&ctx->commits.list[i]->object.oid));
>  		} else {
> -			num_parents = 0;
> -			for (parent = ctx->commits.list[i]->parents; parent; parent = parent->next)
> -				num_parents++;
> +			unsigned int num_parents;
> 
> +			num_parents = commit_list_count(ctx->commits.list[i]->parents);
>  			if (num_parents > 2)
>  				ctx->num_extra_edges += num_parents - 1;
>  		}
> --
> 2.23.0
> 

