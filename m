Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E8FC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEA2610A8
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 09:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhJDJke (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhJDJkc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 05:40:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B736CC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 02:38:43 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so29640884wrv.9
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 02:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3YJb3BHufiIkfX4YYzwBxkPzu0W02YpefRmquRWPaqQ=;
        b=K9TxdDOUc9jlXCGVqRElFGq5PpIpY+1r8AyRfkcLBlXV2jlmpRllY3fGy/A09EjsKI
         +kUJ2TD9QvLdFz+hXGeVsO/xSZsitQ+cj0RW+Yj3GgbLv2Md++Ajrp39wkhFUVXxuFJY
         E7VakiyV4qtCsOtmoyLjjkkTr2bx724T1aDf25Pt4BiGXHIEBIJXgw7ntu9KyUS6lHR5
         Ys2TdCKuvxDiE5qhpkhzmJMw1oEUG3w1t3sPhDAXAJ/nDxSWhfs9oQiihvutzqZT4++s
         mf/oS8rqoOKPFjXFo6t4532LrTJ7lcAkpaaxKazTI6Ig+0Yj6Guqy4mAU7hWyG+YgHJ5
         MZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3YJb3BHufiIkfX4YYzwBxkPzu0W02YpefRmquRWPaqQ=;
        b=mk0KNCHVbL11sogCqwZnBNIzrFHbagsZuPHYy4iXvBIspOMzXPl17OZDAItsETM6GZ
         2OqOBADAnflECqdtWFGwAIbFbDAElAuCYKXC0fwIR+oHP9srNM6EDyaSPT+oly03lrWj
         iktvuZClPq0fvW+rLUsVxQAD5j1FW6x/jXfimeZwE1GWkWjgIxosEs8gk09aGfZa5PC6
         p+++pxE34hhKlo8kUJB682sVB9CsdtqnbP/PT3FbqUSL/ARfgrWCgOa3k9xshy1mn6XG
         zkICNiLQ1TDU2m22Jpe/Tx52zyYnzMm0eyDamZJ0egPDrBNQrCPDsbrVen6jy9s6mYQh
         y24w==
X-Gm-Message-State: AOAM531pP3eZksXN6Q3kVRzZNzSwLM4/IAsF0mvv+9UsBAE66XfuuDtE
        BSZ6hmQJjDWZyGA5gsdRdvs=
X-Google-Smtp-Source: ABdhPJwWkQX7xTpnoL2NCJfSZLkZfUgvcXmJj3c+iByjfQ0d4MCORw3z91IB3m8d9uW59deovklqFg==
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr12767463wrz.369.1633340322358;
        Mon, 04 Oct 2021 02:38:42 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id f9sm2862115wrt.11.2021.10.04.02.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 02:38:42 -0700 (PDT)
Message-ID: <ebc72146-4431-c29c-ebab-37cf886cf28f@gmail.com>
Date:   Mon, 4 Oct 2021 10:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/10] unpack-trees API: rename
 clear_unpack_trees_porcelain()
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-07.10-646e610d8dd-20211004T002226Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-07.10-646e610d8dd-20211004T002226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 04/10/2021 01:46, Ævar Arnfjörð Bjarmason wrote:
> Since a preceding commit we've been using
> clear_unpack_trees_porcelain() to call dir_clear(). So it's no longer
> a function that corresponds to setup_unpack_trees_porcelain(), as it
> was when it was added in 1c41d2805e4 (unpack_trees_options: free
> messages when done, 2018-05-21).
> 
> Instead it's similar to strbuf_release() and other similar generic
> "free" functions. Let's rename it to avoid any future confusion on the
> topic.
> 
> Let's also update the API documentation for it to note this, and to
> cover e.g. the code added around update_sparsity() in
> 4ee5d50fc39 (sparse-checkout: use improved unpack_trees porcelain
> messages, 2020-03-27).
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/checkout.c        | 2 +-
>   builtin/sparse-checkout.c | 2 +-
>   merge-ort.c               | 2 +-
>   merge-recursive.c         | 2 +-
>   merge.c                   | 4 ++--
>   reset.c                   | 2 +-

I was expecting to see sequencer.c here, but it appears it does not call 
clear_unpack_trees_porcelain() to free the memory allocated with 
setup_unpack_trees_porcelain(). If you're interested in fixing memory 
leaks from unpack trees it might be worth checking that all the calls to 
setup_unpack_trees_porcelain() have a matching call to 
clear_unpack_trees_porcelain().

Best Wishes

Phillip

>   unpack-trees.c            | 2 +-
>   unpack-trees.h            | 8 +++++---
>   8 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index d4b88affba7..482d17676a0 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -757,7 +757,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>   		init_tree_desc(&trees[1], tree->buffer, tree->size);
>   
>   		ret = unpack_trees(2, trees, &topts);
> -		clear_unpack_trees_porcelain(&topts);
> +		unpack_trees_options_release(&topts);
>   		if (ret == -1) {
>   			/*
>   			 * Unpack couldn't do a trivial merge; either
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 4c3c29fb580..b1221fd01d3 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -219,7 +219,7 @@ static int update_working_directory(struct pattern_list *pl)
>   
>   	setup_unpack_trees_porcelain(&o, "sparse-checkout");
>   	result = update_sparsity(&o);
> -	clear_unpack_trees_porcelain(&o);
> +	unpack_trees_options_release(&o);
>   
>   	if (result == UPDATE_SPARSITY_WARNINGS)
>   		/*
> diff --git a/merge-ort.c b/merge-ort.c
> index e526b78b88d..0a5937364c9 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4054,7 +4054,7 @@ static int checkout(struct merge_options *opt,
>   	init_tree_desc(&trees[1], next->buffer, next->size);
>   
>   	ret = unpack_trees(2, trees, &unpack_opts);
> -	clear_unpack_trees_porcelain(&unpack_opts);
> +	unpack_trees_options_release(&unpack_opts);
>   	return ret;
>   }
>   
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a77f66b006c..316cb2ca907 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -441,7 +441,7 @@ static int unpack_trees_start(struct merge_options *opt,
>   static void unpack_trees_finish(struct merge_options *opt)
>   {
>   	discard_index(&opt->priv->orig_index);
> -	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
> +	unpack_trees_options_release(&opt->priv->unpack_opts);
>   	unpack_trees_options_init(&opt->priv->unpack_opts);
>   }
>   
> diff --git a/merge.c b/merge.c
> index 9cb32990dd9..2f618425aff 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -95,10 +95,10 @@ int checkout_fast_forward(struct repository *r,
>   
>   	if (unpack_trees(nr_trees, t, &opts)) {
>   		rollback_lock_file(&lock_file);
> -		clear_unpack_trees_porcelain(&opts);
> +		unpack_trees_options_release(&opts);
>   		return -1;
>   	}
> -	clear_unpack_trees_porcelain(&opts);
> +	unpack_trees_options_release(&opts);
>   
>   	if (write_locked_index(r->index, &lock_file, COMMIT_LOCK))
>   		return error(_("unable to write new index file"));
> diff --git a/reset.c b/reset.c
> index d13984ab781..f4bf3fbfac0 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -133,7 +133,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>   leave_reset_head:
>   	strbuf_release(&msg);
>   	rollback_lock_file(&lock);
> -	clear_unpack_trees_porcelain(&unpack_tree_opts);
> +	unpack_trees_options_release(&unpack_tree_opts);
>   	while (nr)
>   		free((void *)desc[--nr].buffer);
>   	return ret;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e7365322e82..bea598c9ece 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -193,7 +193,7 @@ void unpack_trees_options_init(struct unpack_trees_options *o)
>   	memcpy(o, &blank, sizeof(*o));
>   }
>   
> -void clear_unpack_trees_porcelain(struct unpack_trees_options *opts)
> +void unpack_trees_options_release(struct unpack_trees_options *opts)
>   {
>   	strvec_clear(&opts->msgs_to_free);
>   	dir_clear(&opts->dir);
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 40c4841748d..a8d1f083b33 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -41,10 +41,12 @@ enum unpack_trees_error_types {
>   void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>   				  const char *cmd);
>   
> -/*
> - * Frees resources allocated by setup_unpack_trees_porcelain().
> +/**
> + * Frees resources allocated by function that take the "struct
> + * unpack_trees_options". Always call this after using unpack_trees(),
> + * update_sparsity() etc.
>    */
> -void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
> +void unpack_trees_options_release(struct unpack_trees_options *opts);
>   
>   struct unpack_trees_options {
>   	unsigned int reset,
> 
