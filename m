Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3281F447
	for <e@80x24.org>; Mon, 13 Aug 2018 18:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeHMV2J (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:28:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41395 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeHMV2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:28:09 -0400
Received: by mail-qk0-f196.google.com with SMTP id n85-v6so11697015qke.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L0w/l5UrcRWB/5SX2x3acjvkTw8PyavC43BNntDfzFs=;
        b=r4CTyNotkgjjwqKKyF3aLumTuDitlpvwtHNCWSHIKtcc9VW5YKbkEC69wFRMr3q15l
         s3LDc//gYxc1YkNqZ9HECOkx7jzrXUJF+wBVHjGQT15h3HFTwR5+la9hpvhTl9PwsU5Y
         8+kxm4GpF7Ovgj8hEfvAlbViM4auiSM545/6c9WNKLxLsNSbuJvtWR7jZHpKxX4EZg93
         /6CWsB+37UHZYt8h8CZEdDUpQIRtbkUjPOG+v5MbqbEdUcSOQJuAuT7mIl8wiziPVs+d
         wrv3m7qM3l8SZ0RFK7IRF20vRMoV6fVfmmsLhYZFjitIFC3A8gtRmZ1JYEa3o1lyqpt4
         enlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L0w/l5UrcRWB/5SX2x3acjvkTw8PyavC43BNntDfzFs=;
        b=hcJnmpqEG9RZryx4DcqP5wkW9VykC534tZkGnfUo/v4ounXioer548FcvBZHo0DS3B
         g3+7QAD+gJXzkV2W6hmnE6i/uxTwVHmSHVZ91r09YUGqgzTxEScUdO3n/Ln2TmLuqb9g
         1qpSTutXa2hi8LQP4+2umI6RHywDnoG9cVGg5TxDteIYnz1dC9FN2K8jcuLnLho06TIr
         +Qe8smEexrOy35bPdmkuH89TFZihGs6mJm7ucQKGkiUi27xZmRj2H+PxpLcAfSGgVLJu
         uIuftL0/L7la6vMXq1YptS4NqmWp4pDJcchDyGPNNIgblbhdWNpjjNS3H3a7lwiq2Qs6
         1rQg==
X-Gm-Message-State: AOUpUlFxuDnX/33hdBbUpr4x+Y0x02cenka/Vp9xma8L586RZgadg5fW
        6Vu6dVut2mZ4S+rffuTx0GI=
X-Google-Smtp-Source: AA+uWPxU2pucEpTzA2OZuSkjzMW26APjo0bNslZ8m5amusjTkCqkirKf3wAuWqOV7jmqRFTHg+iMHg==
X-Received: by 2002:ae9:f401:: with SMTP id y1-v6mr17503069qkl.178.1534185882840;
        Mon, 13 Aug 2018 11:44:42 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id e1-v6sm11985208qkd.15.2018.08.13.11.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 11:44:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, Elijah Newren <newren@gmail.com>
References: <20180804053723.4695-1-pclouds@gmail.com>
 <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <34bbad06-4b19-6558-3004-58b0498a5166@gmail.com>
Date:   Mon, 13 Aug 2018 14:44:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180812081551.27927-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/12/2018 4:15 AM, Nguyễn Thái Ngọc Duy wrote:
> We're going to optimize unpack_trees() a bit in the following
> patches. Let's add some tracing to measure how long it takes before
> and after. This is the baseline ("git checkout -" on webkit.git, 275k
> files on worktree)
> 
>      performance: 0.056651714 s:  read cache .git/index
>      performance: 0.183101080 s:  preload index
>      performance: 0.008584433 s:  refresh index
>      performance: 0.633767589 s:   traverse_trees
>      performance: 0.340265448 s:   check_updates
>      performance: 0.381884638 s:   cache_tree_update
>      performance: 1.401562947 s:  unpack_trees
>      performance: 0.338687914 s:  write index, changed mask = 2e
>      performance: 0.411927922 s:    traverse_trees
>      performance: 0.000023335 s:    check_updates
>      performance: 0.423697246 s:   unpack_trees
>      performance: 0.423708360 s:  diff-index
>      performance: 2.559524127 s: git command: git checkout -
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   cache-tree.c   | 2 ++
>   unpack-trees.c | 9 ++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/cache-tree.c b/cache-tree.c
> index 6b46711996..105f13806f 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -433,7 +433,9 @@ int cache_tree_update(struct index_state *istate, int flags)
>   
>   	if (i)
>   		return i;
> +	trace_performance_enter();

This one is a little odd to me.  I think the either the 
trace_performance_enter() call should move up to include the 
verify_cache() call or the enter/leave should move into the update_one() 
call as that is all it is measuring/reporting on.

>   	i = update_one(it, cache, entries, "", 0, &skip, flags);
> +	trace_performance_leave("cache_tree_update");
>   	if (i < 0)
>   		return i;
>   	istate->cache_changed |= CACHE_TREE_CHANGED;
> diff --git a/unpack-trees.c b/unpack-trees.c
> index cd0680f11e..b237eaa0f2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -354,6 +354,7 @@ static int check_updates(struct unpack_trees_options *o)
>   	struct checkout state = CHECKOUT_INIT;
>   	int i;
>   
> +	trace_performance_enter();
>   	state.force = 1;
>   	state.quiet = 1;
>   	state.refresh_cache = 1;
> @@ -423,6 +424,7 @@ static int check_updates(struct unpack_trees_options *o)
>   	errs |= finish_delayed_checkout(&state);
>   	if (o->update)
>   		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
> +	trace_performance_leave("check_updates");
>   	return errs != 0;
>   }
>   
> @@ -1279,6 +1281,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	if (len > MAX_UNPACK_TREES)
>   		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>   
> +	trace_performance_enter();
>   	memset(&el, 0, sizeof(el));
>   	if (!core_apply_sparse_checkout || !o->update)
>   		o->skip_sparse_checkout = 1;
> @@ -1351,7 +1354,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   			}
>   		}
>   
> -		if (traverse_trees(len, t, &info) < 0)
> +		trace_performance_enter();
> +		ret = traverse_trees(len, t, &info);
> +		trace_performance_leave("traverse_trees");

Why not move this enter/leave pair into the traverse_trees() function 
itself?

> +		if (ret < 0)
>   			goto return_failed;
>   	}
>   
> @@ -1443,6 +1449,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   	o->src_index = NULL;
>   
>   done:
> +	trace_performance_leave("unpack_trees");
>   	clear_exclude_list(&el);
>   	return ret;
>   
> 
