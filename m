Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F161F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 14:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfJJOpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 10:45:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39187 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfJJOpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 10:45:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id n7so9057398qtb.6
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+MjqY15jZqrRxALB2UzMoRt/GK+cPMpksMAbOjkc0Hc=;
        b=HBhd14ntSu3QdEJO/ulGcQ+IfR71igKO3PN27xXRRwvLedMyukPvociFluAF5CH6WP
         VUiD6I4olQiuxfVobN0z8AX2Kc5ziNXI7/V9Qh9WtvP1vmsDfkkaUQ2piVRlL4jPYWSw
         hxGujrYq3XEeH4UySjeF3ycE1nnjFxjnV80k+pqBTnKHWTEwYCAdpgDYHIQv7CQ2af7b
         HBdCTxks9UTfkUOg365PyN31wjpK8tgbrBrlwI/gN04OqrrbEEti21EfGjMaA6vY4SUQ
         TELv1YLhBjS9XIr6wqBD90m1fh2x2RUjWqRQ0E2k3Wv1z1CKHaFUwjeV2yZFsvcO3XyA
         0nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+MjqY15jZqrRxALB2UzMoRt/GK+cPMpksMAbOjkc0Hc=;
        b=f19bQ8FsA1O/WsHdz9pBBqRIaSN61U8Csp+loZdKEkzxMY9YPMMGy/dpVnqDm2Exyz
         rgSh+Y9tSjHU3gKreI8oxDZ6EbJFeP3/cbrUZCrZV3NBJWXAfxAuaAREzIsdm4v2FqlD
         lrQ83GTGx9eYJvAWwNgM6EBjf9vu3XrQeMnrg8bdkIbhfkkO6YASu/d9bFh278+ZQ35Y
         usKFgBy+foVOWLTDjDsTM3hRyj7IkgRthusy/qdCBbNDt3Ht0WPh9YxN5oLbtyNZ9Hah
         foYqAPQhVfw9JWq9KPMid2kKMmH8vY7QpXQIVYRgqvYqo0z1W4k/TupJknSalrQH6I3E
         dK9w==
X-Gm-Message-State: APjAAAWm5z0iMPwXLVap7h+ROyAlv0JOmV3hxHGyThCbrdRwiC6BPQM1
        BUId5O2fpaj7twc5BP4F7QVnyQpB358=
X-Google-Smtp-Source: APXvYqyEiNPNCUzH2egLsPgiNyuDKT4hjyLMKiJuqVjJkzwPRKl1nBIdj7NVUTHik6sBbrqPE9SIjQ==
X-Received: by 2002:ac8:1b54:: with SMTP id p20mr10486665qtk.8.1570718735356;
        Thu, 10 Oct 2019 07:45:35 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2da2:a6da:62ea:75d9? ([2001:4898:a800:1010:ded7:a6da:62ea:75d9])
        by smtp.gmail.com with ESMTPSA id z5sm2689308qtb.49.2019.10.10.07.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:45:34 -0700 (PDT)
Subject: Re: [PATCH 3/6] index-pack: remove redundant child field
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     peff@peff.net, mh@glandium.org
References: <cover.1570663470.git.jonathantanmy@google.com>
 <39740c6e58bd6cb6ea33e5abb4ab8542ff6eb7b7.1570663470.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <67ca2f70-361a-bebd-7590-37337959552c@gmail.com>
Date:   Thu, 10 Oct 2019 10:45:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <39740c6e58bd6cb6ea33e5abb4ab8542ff6eb7b7.1570663470.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2019 7:44 PM, Jonathan Tan wrote:
> Instead, recompute ancestry if we ever need to reclaim memory.

I find this message lacking in important details:

1. Where do we recompute ancestry?
2. What are the performance implications of this change?
3. Why is it important that you construct a stack of deltas in prune_base_data()?

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/index-pack.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 99f6e2957f..35f7f9e52b 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -34,7 +34,6 @@ struct object_stat {
>  
>  struct base_data {
>  	struct base_data *base;
> -	struct base_data *child;
>  	struct object_entry *obj;
>  	void *data;
>  	unsigned long size;
> @@ -44,7 +43,6 @@ struct base_data {
>  
>  struct thread_local {
>  	pthread_t thread;
> -	struct base_data *base_cache;
>  	size_t base_cache_used;
>  	int pack_fd;
>  };
> @@ -380,27 +378,37 @@ static void free_base_data(struct base_data *c)
>  	}
>  }
>  
> -static void prune_base_data(struct base_data *retain)
> +static void prune_base_data(struct base_data *youngest_child)
>  {
>  	struct base_data *b;
>  	struct thread_local *data = get_thread_data();
> -	for (b = data->base_cache;
> -	     data->base_cache_used > delta_base_cache_limit && b;
> -	     b = b->child) {
> -		if (b->data && b != retain)
> -			free_base_data(b);
> +	struct base_data **ancestry = NULL;
> +	int nr = 0, alloc = 0;
> +	int i;
> +
> +	if (data->base_cache_used <= delta_base_cache_limit)
> +		return;
> +
> +	/*
> +	 * Free all ancestors of youngest_child until we have enough space,
> +	 * starting with the oldest. (We cannot free youngest_child itself.)
> +	 */
> +	for (b = youngest_child->base; b != NULL; b = b->base) {
> +		ALLOC_GROW(ancestry, nr + 1, alloc);
> +		ancestry[nr++] = b;
> +	}
> +	for (i = nr - 1;
> +	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
> +	     i--) {
> +		if (ancestry[i]->data)
> +			free_base_data(ancestry[i]);
>  	}
> +	free(ancestry);
>  }
>  
>  static void link_base_data(struct base_data *base, struct base_data *c)
>  {
> -	if (base)
> -		base->child = c;
> -	else
> -		get_thread_data()->base_cache = c;
> -
>  	c->base = base;
> -	c->child = NULL;
>  	if (c->data)
>  		get_thread_data()->base_cache_used += c->size;
>  	prune_base_data(c);
> @@ -408,11 +416,6 @@ static void link_base_data(struct base_data *base, struct base_data *c)
>  
>  static void unlink_base_data(struct base_data *c)
>  {
> -	struct base_data *base = c->base;
> -	if (base)
> -		base->child = NULL;
> -	else
> -		get_thread_data()->base_cache = NULL;
>  	free_base_data(c);
>  }

Seems like this method should be removed and all callers should
call free_base_data() instead.

-Stolee

