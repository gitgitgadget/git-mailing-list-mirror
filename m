Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60281C2BA19
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E35820CC7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 00:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jiWYWi2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDXAxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:53:03 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34846 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgDXAxC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 20:53:02 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id RmaSjRvfbsCJiRmaTjx4iv; Fri, 24 Apr 2020 01:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587689581; bh=eBeXOtiSo9nZYvE9bwZouo5/VzsyKyM3cYJHuWHhNDs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jiWYWi2klaEdlf7B2cM2k9IHt423PwvHwy1O2zJkRtZNDK9F822kkddTFQbKqJWvg
         UJ7iInQ3z39NZjbtEBZ/GxKt9r1K9PM1hJ5Do5QSUSWUom1+7+LQYFSmEDmUgVo/3i
         mqR2Dj/XdMTLRVyFzZ33c/Kf95yERd4Masaz++KL08aEaXkmf71ImXk2upNzguVCQG
         LRg+MxSHfT9Y2FP3M7WrbfwU4YW6B8acU2sUCBon6O8rVt3LPTz5ZV9qAO4M7zlFNm
         7+8GYBe/kAB27gyB0oDKBgP508C5rp4A9GiFZOl6NW8hF44A2e7mxUeEhMfh3m8OFc
         r+rh44+MDZyuQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=BPIoUGYG c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=kkydRZ0R8FtR57HAyx0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/4] graph.c: limit linkage of internal variable
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <5bd7b929107c277e10a697bc874b702b85691558.1587648870.git.congdanhqx@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <351abde3-6ae4-dc65-a846-3b45202a07ec@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 01:52:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5bd7b929107c277e10a697bc874b702b85691558.1587648870.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfE1BSXS3EiEbGG26gKhdbnED8CVIXrEraAEiGE6ADUrZQJ0M0HwPZCamxvBh4hYgszCFv463YRUzPh4oQan1zZT/l4QOHLqqEESl4DQgZv564PzMOApa
 jgt64WwwTiLI1tMKIVngq6K7Lgoma+Tp+Wv08NvZNLju5JqV+gUGRfAVgAOBy4MhtyT6LNL55ElkvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/04/2020 14:47, Đoàn Trần Công Danh wrote:
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/graph.c b/graph.c
> index 4fb25ad464..4cd9915075 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1055,7 +1055,7 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
>  		graph_update_state(graph, GRAPH_COLLAPSING);
>  }
>  
> -const char merge_chars[] = {'/', '|', '\\'};
> +static const char merge_chars[] = {'/', '|', '\\'};
>  
>  static void graph_output_post_merge_line(struct git_graph *graph, struct graph_line *line)
>  {
> 

Yep, LGTM.

ATB,
Ramsay Jones

