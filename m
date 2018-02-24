Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3BA1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 05:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbeBXFnP (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 00:43:15 -0500
Received: from mout.web.de ([212.227.15.4]:58849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeBXFnP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 00:43:15 -0500
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpQjF-1eD5Sb0djJ-00f7l6; Sat, 24
 Feb 2018 06:43:08 +0100
Subject: Re: [PATCH] commit-graph: fix some "plain integer as NULL pointer"
 warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, stolee@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <e0bc5fe0-3b32-bebf-11cd-e335a8cf4e1c@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <93d2329a-1963-dca8-2f9e-ba225ead9d0b@web.de>
Date:   Sat, 24 Feb 2018 06:42:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e0bc5fe0-3b32-bebf-11cd-e335a8cf4e1c@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zs6K23s4IDFgOC+ieHmZ8hIrRRRGn7PfHB2xj90XW3G03lxeLLR
 26+WN24qz912S46VQ9CvyICl1LpeananF0BBpTns4/sFBvqu716cp3L3EXReVaDQzdS6Xus
 vXU8zklqJa965i07St3EtL947rEa8heebzPDW8x3tw7Pu7bQ62qeRvJ33/43jQd96NBAE3W
 NP3tadOCeAPU7GbYOf6Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FRXixK6bBe8=:mipEbwD6dEoU/1ApwAhNHv
 4uMhqwKfr/GjnBEUYNBf5EJgoK6WL8bSfDvFMNLRCWA2WVcz9eCiDrPk5NJmVEoGtX49Yi4VK
 zE+jWC4M/w1BSvj/coDzvA4HORraJOynvipQ8Zj2y9P6zMMF9s+RmwO09tetM96OBuLEfLbbe
 Wb6Vx2Om7ajacYlwQjfe6SMCujdgMoHBcLQOxrbQ75WbH1bEM/Xu8BIUBR6t5iudu0UQOaiVT
 kpXho1ul0kavqZJXg5OsmDDl3kaW1qtrHNJ7EyET75knqTLnture991z9qqBXDUZegHUW6cLG
 YE2isilcjLj7/eVeZ64vXeU4rVo+veqW+yhhs+VG+aoiW1B/DodzynQpnAL6G3f/+xDfqqOl+
 NKcNtLGBx0clQzaFgK8YtcxoIAmS+gxNroHedepka/wsRmdizul6RMeYbPp3oLIHRHwk9wK1L
 R2G+rvpRBam4cR+zy3GoXQ8XXT2ebhsxHnUqK9gXvgx9miNvQSAFQUwsdsKwBWwZbzsxSa1F/
 8c/Jd27sxz7aAN1+8utik0kURjMKhSztq4JnZGaMRLhPNtBoNtExliIuhK0YGop96YT/9t6MA
 KLZHtCaNgB8c4BsS+664lvIpK4IXLaII8C79FqzXsFcVfpoB82+qKWcU7KQ0/bLadXDxm+1jc
 V2dkpqW6si8p9bKCAaoZ2fCQTV8IFCEkQ7Z65s5QuefIocZxl1a2cZID4u8gXPsKekFqRJJT2
 TAKNndmk+uXl2To1BkIDv30o14kIf0fSck2ZmS+TSsxvM6Znizv0vaRUY4LvdWaRmImwf68te
 r1vMh59DQQJspxlyQfLoo/BrWm7o07YklrVZsFFR2gT1kHLqvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.02.2018 um 03:24 schrieb Ramsay Jones:
> diff --git a/commit-graph.c b/commit-graph.c
> index fc5ee7e99..c2f443436 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,7 @@ char *get_graph_latest_filename(const char *obj_dir)
>   {
>   	struct strbuf fname = STRBUF_INIT;
>   	strbuf_addf(&fname, "%s/info/graph-latest", obj_dir);
> -	return strbuf_detach(&fname, 0);
> +	return strbuf_detach(&fname, NULL);
>   }

You could also replace that function body with:

	return xstrfmt("%s/info/graph-latest", obj_dir);

René
