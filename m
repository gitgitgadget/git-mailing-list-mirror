Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E571F453
	for <e@80x24.org>; Mon, 29 Oct 2018 01:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeJ2J76 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 05:59:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46058 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ2J75 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 05:59:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so6824164wrw.12
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 18:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JqId3w4NuuuOBtwuqjnfxelrzKvPzpueX+wUjV9wvcE=;
        b=HMQG1s1OGhthZ7iC0sB0kquF1XZwGSHBfzZ/wZ4N85u4JhcCAKgXiSXfTq1ynNRpW/
         cKqrkLl+2GZxEUX56SOU/886hoRwvNdsC27VF7g+DQgbZnEUkRxwa3u8V4Wb1Zepr0j/
         O87RKmSiaXKE46sE2SRl1UVGLJRdyrwpvOhhqsHjx/EzjXu1ebh/rBX0c1Q6zCPgAaaH
         VLE5bbZjzUdhD8Uvj7KxQ7/OjuYGb0hYVSXzaVfb8Nn5Nt1pH39WnRhrfHCPn6kSk/lh
         M3oSEZP8Q91TP3RKU79W89KPiRX1byt5SlTbBooAOoEnfejmh6wo6NNgJxDVbHbKdIfN
         hMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JqId3w4NuuuOBtwuqjnfxelrzKvPzpueX+wUjV9wvcE=;
        b=l1R+7Z/l5/rsgxewOeRsFOedjEcWd9WT5B++U4VElQue8WqONARItvEPASk671vh5S
         VDhJKaPlWqf4prSHY7wwgpP23sUFjfIewiyxurgS9LO3ac/rnwGXWBAUIlXo9qv0Tg4k
         vJnG/pFXOWY8SMivkXhErdZQHWkpt/DbTfS4iJnczWwCnHZbneA2rFMtXT6uaAqReeUK
         nsxw4v8ZvZa7HpuaAdjeLKd4BP4PnDWF7nGcoXIXORktM1kOxeokioh13p79E1R1VLk2
         oabDFGKTBLIPubt/Wmd24/YqEJyeTnCAUAbXemldBWh8TnQMhfZRU8ctiSsSfbIUvz+/
         PEIA==
X-Gm-Message-State: AGRZ1gKzEJpoKyGdjimdEJSoLBYPqD5ZprTxLfyIYM20Hn19sRvkPt0o
        TPNh2WimtrRJEucRTLjr09wYwM5cvxg=
X-Google-Smtp-Source: AJdET5cyG9bzR0dwaALLfJxZqA7mm/wc/M5KbKTym0QfbPRkZzgH3cyqh5g1ZoTLDz2VrdW4pkARXQ==
X-Received: by 2002:adf:a14c:: with SMTP id r12-v6mr6059205wrr.169.1540775614901;
        Sun, 28 Oct 2018 18:13:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g8-v6sm22151530wri.58.2018.10.28.18.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:13:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] commit-reach.h: add missing declarations (hdr-check)
References: <88102e3a-8a02-fca4-4daf-ab428008afc7@ramsayjones.plus.com>
Date:   Mon, 29 Oct 2018 10:13:33 +0900
In-Reply-To: <88102e3a-8a02-fca4-4daf-ab428008afc7@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 27 Oct 2018 02:53:57 +0100")
Message-ID: <xmqq1s89a72a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> ...
>        24 clear_contains_cache
>   $
>
> you will find 24 copies of the commit-slab routines for the contains_cache.
> Of course, when you enable optimizations again, these duplicate static
> functions (mostly) disappear. Compiling with gcc at -O2, leaves two static
> functions, thus:
>
>   $ nm commit-reach.o | grep contains_cache
>   0000000000000870 t contains_cache_at_peek.isra.1.constprop.6
>   $ nm ref-filter.o | grep contains_cache
>   00000000000002b0 t clear_contains_cache.isra.14
>   $
>
> However, using a shared 'contains_cache' would result in all six of the
> above functions as external public functions in the git binary.

Sorry, but you lost me here.  Where does the 6 in above 'all six'
come from?  I saw 24 (from unoptimized), and I saw 2 (from
optimized), but...

Ah, OK, the slab system gives us a familiy of 6 helper functions to
deal with the "contains_cache" slab, and we call only 3 of them
(i.e. the implementation of other three are left unused).  Makes
sense.

> At present,
> only three of these functions are actually called, so the trade-off
> seems to favour letting the compiler inline the commit-slab functions.

OK.  I vaguely recall using a linker that can excise the
implementation an unused public function out of the resulting
executable in the past, which may tip the balance in the opposite
direction, but the above reasonong certainly makes sense to me.

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  commit-reach.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-reach.h b/commit-reach.h
> index 7d313e2975..f41d8f6ba3 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -1,12 +1,13 @@
>  #ifndef __COMMIT_REACH_H__
>  #define __COMMIT_REACH_H__
>  
> +#include "commit.h"
>  #include "commit-slab.h"
>  
> -struct commit;
>  struct commit_list;
> -struct contains_cache;
>  struct ref_filter;
> +struct object_id;
> +struct object_array;
>  
>  struct commit_list *get_merge_bases_many(struct commit *one,
>  					 int n,
