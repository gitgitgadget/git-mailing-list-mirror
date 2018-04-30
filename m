Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E0F215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 21:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeD3VmM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 17:42:12 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41985 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750986AbeD3VmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 17:42:11 -0400
Received: by mail-yb0-f196.google.com with SMTP id 140-v6so3573026ybc.9
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 14:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AwJhZ265VJ+LrdzxXRFFfDNknjuODr3fPu5mTvjc7Ok=;
        b=R2uYZEL+/Tvnni6kKFG2uou+UjRA9ZYR0PE3I1vbVF9K14eM/2Cjh5+q1GNNg03hL/
         gom36R9lWxSO9HptsjtOD1bfX0+z6d/ZmmHca4R7pGJXRU/fPL9hw67XLsHUKZSfGAws
         j+eoN5Wab+ygHmriiteYnyd3cyT7spPqdc/hg6tjPfWQW67hOWZ/mYD05VUzXCnivt7W
         nNzlD9ISN7dUtw5GV9MtDf/+wnsBZLAR5Ldoid+LR0vwqwcllbQ0BE9ADAQ7K+qvaFfV
         5bcueMlIAkDOCZNMdUkSUtbcK2mq6Xo+ZBxrUef6ANwt4QIVX6U7sOT3KwlMOqfkBgbf
         01oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AwJhZ265VJ+LrdzxXRFFfDNknjuODr3fPu5mTvjc7Ok=;
        b=TUrs7BCoiRK0sjjXpFfYOnmUwNBAK/GR4unP/7A+ARRVesZYgyjtDoPFftX1sjTxGU
         qtpp2gRbVoJi33r+EgB5/iFfzOWvA1DjjANb4CFs8PIqkqMgP//2/yxxHWPQ93zFYNnE
         zgHV/w+NHRZDOln7jRiIM4pCGnbLVOWZhdGoqiU3gAJp0KZl4/zeCvWAQUXgHXHVi8kV
         ZpQIBhA9JyQCnf6NRwq5a3aIOjHEofhNJnWM/gTSx/9FUUw0ilAazAIq+pVZMdZtyZ7z
         ry8ci6PMumKzezOD+5wIWCzZJY/ojFH0MT00nTj0j/HYglmcdI9nyTp+DFAfd4GZIs7E
         474Q==
X-Gm-Message-State: ALQs6tCGdD8/jCwH750T3Vpl8Vgd0jiKVTMkIRwiCSen+3WyOi9lgNjh
        0GogO0zmEn0TwKuH8uocIl1sIkZKl2PcEpDpyFxJEA==
X-Google-Smtp-Source: AB8JxZpHOdgOe5RdME03IMNjiCPJ8xs7wCVWsjmevkBtHhaO0LUqJiRk66CHnOWelSzDBUzIjMOksaoEd16tfhy0Ve4=
X-Received: by 2002:a25:500e:: with SMTP id e14-v6mr8321041ybb.334.1525124530093;
 Mon, 30 Apr 2018 14:42:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 14:42:09
 -0700 (PDT)
In-Reply-To: <20180430153122.243976-4-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
 <20180430153122.243976-4-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 14:42:09 -0700
Message-ID: <CAGZ79katqnSvQzqiXdQ_SjGWUUF19_kwFBrq+Z9Vihv7xR792w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mem-pool: fill out functionality
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 8:31 AM, Jameson Miller <jamill@microsoft.com> wrote:
> Adds the following functionality to memory pools:
>
>  - Lifecycle management functions (init, discard)
>
>  - Test whether a memory location is part of the managed pool
>
>  - Function to combine 2 pools
>
> This also adds logic to track all memory allocations made by a memory
> pool.
>
> These functions will be used in a future commit in this commit series.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  mem-pool.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  mem-pool.h |  32 +++++++++++++++++

> diff --git a/mem-pool.h b/mem-pool.h
> index 829ad58ecf..34df4fa709 100644
> --- a/mem-pool.h
> +++ b/mem-pool.h
> @@ -19,8 +19,27 @@ struct mem_pool {
>
>         /* The total amount of memory allocated by the pool. */
>         size_t pool_alloc;
> +
> +       /*
> +        * Array of pointers to "custom size" memory allocations.
> +        * This is used for "large" memory allocations.
> +        * The *_end variables are used to track the range of memory
> +        * allocated.
> +        */
> +       void **custom, **custom_end;
> +       int nr, nr_end, alloc, alloc_end;
>  };

What is the design goal of this mem pool?
What is it really good at, which patterns of use should we avoid?

It looks like internally the mem-pool can either use mp_blocks
that are stored as a linked list, or it can have custom allocations
stored in an array.

Is the linked list or the custom part sorted by some key?
Does it need to be sorted?

I am currently looking at alloc.c, which is really good for
allocating memory for equally sized parts, i.e. it is very efficient
at providing memory for fixed sized structs. And on top of that
it is not tracking any memory as it relies on program termination
for cleanup.

This memory pool seems to be optimized for allocations of
varying sizes, some of them huge (to be stored in the custom
part) and most of them rather small as they go into the mp_blocks?

Thanks,
Stefan
