Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F42D1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 05:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeI2MDQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 08:03:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34312 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeI2MDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 08:03:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so6493441lfj.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 22:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yBt6MbWlNkL5fD6Vg0qcqb+8HYcp5hOKxkMjctqConM=;
        b=UL6jkTJgJeoHtcEyNPlJyjG3CKXWWzABmB2SvIbylGsVn6RE5Pbd/bvV5K7lHF9Qvu
         HlqyAXWv4c4+fVbjUhwN1fzwo25cJRltyQWGn0DN7o5WkDcQFwKJ/xHVG+ffg0akYSGg
         zwWsKYB0nni0Gh7yrSvgv/NFZxtopQVd73XVYjDn36+ByepExcSF/Bc6I7H7YqJHybDK
         rnIcGpBKAQl7fzJ1QWz/WnCkVBHo13BEiPBNlWw+17n1KVdAIY7SrGbmEXwMzt69pX5g
         B3Oy1IN3YNlNxOLadFyYAt8YFSgJ/LPho3WZVmbEPJBPA34isZPxlcySdlYD9GytxLDL
         v82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yBt6MbWlNkL5fD6Vg0qcqb+8HYcp5hOKxkMjctqConM=;
        b=a1hBmvnnT5rlp8Utzyuy0akF+kbUWwMygBB84WmCihp80R0AGFxRsXpQhrFZoWvv84
         EicIBCNC+G6aqca6NGhCu61VHp0PepepOhtr7E3znKbNK+xQBVZDQZQRfspXSSYnGdgU
         9qreeQYysD0EjovU/I7Xxq+OWGm7domreJ4PB2uxvWomOiA5w4nxtCu5Izvu8dylPZpC
         GYKgn6SoE2oq01VuPz63oK8JUuIvIwP0qH8kYjXsyfSpi/uv/TtuKSW8Zv9VpGDBaCU4
         CzBGwHmWgSv4cQFq0whFPTdJjudWjk+Qc6u51+FHjwoRyXpE3bakYYDrujAcCcUrKQQa
         AEuA==
X-Gm-Message-State: ABuFfogGD35Jw5deKCXtVVV1EuS/6B6GSBqBAWtiL72qb9EQWgvr9Juu
        aFg32Jo6d6/Dh3Ej1jXQ4rTokDBN
X-Google-Smtp-Source: ACcGV60+FHKYTWJxsEwNS3DP3EU1uyzB2OW7UyBFUWlrsRUqUjJ8MamtMtO3CeVQ7X73Hl3gTETOpA==
X-Received: by 2002:a19:6381:: with SMTP id v1-v6mr728836lfi.136.1538199371568;
        Fri, 28 Sep 2018 22:36:11 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1343607lfi.23.2018.09.28.22.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 22:36:10 -0700 (PDT)
Date:   Sat, 29 Sep 2018 07:36:08 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] split-index: don't compare stat data of entries
 already marked for split index
Message-ID: <20180929053608.GB20349@duynguyen.home>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
 <20180928162459.17138-6-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928162459.17138-6-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 06:24:58PM +0200, SZEDER Gábor wrote:
> When unpack_trees() constructs a new index, it copies cache entries
> from the original index [1].  prepare_to_write_split_index() has to
> deal with this, and it has a dedicated code path for copied entries
> that are present in the shared index, where it compares the cached
> data in the corresponding copied and original entries.  If the cached
> data matches, then they are considered the same; if it differs, then
> the copied entry will be marked for inclusion as a replacement entry
> in the just about to be written split index by setting the
> CE_UPDATE_IN_BASE flag.
> 
> However, a cache entry already has its CE_UPDATE_IN_BASE flag set upon
> reading the split index, if the entry already has a replacement entry
> there, or upon refreshing the cached stat data, if the corresponding
> file was modified.  The state of this flag is then preserved when
> unpack_trees() copies a cache entry from the shared index.
> 
> So modify prepare_to_write_split_index() to check the copied cache
> entries' CE_UPDATE_IN_BASE flag first, and skip the thorough
> comparison of cached data if the flag is already set.

OK so this is an optimization, not a bug fix. Right?

> Note that comparing the cached data in copied and original entries in

s/cached data/cached stat data/ ? I was confused for a bit.

> the shared index might actually be entirely unnecessary.  In theory
> all code paths refreshing the cached stat data of an entry in the
> shared index should set the CE_UPDATE_IN_BASE flag in that entry, and
> unpack_trees() should preserve this flag when copying cache entries.
> This means that the cached data is only ever changed if the
> CE_UPDATE_IN_BASE flag is set as well.  Our test suite seems to
> confirm this: instrumenting the conditions in question and running the
> test suite repeatedly with 'GIT_TEST_SPLIT_INDEX=yes' showed that the
> cached data in a copied entry differs from the data in the shared
> entry only if its CE_UPDATE_IN_BASE flag is indeed set.

Yes I was probably just being paranoid (or sticking to simpler
checks). I was told that split index is computation expensive and not
doing unnecesary/expensive checks may help. But let's leave it for
later.

> +			} else {
> +				/*
> +				 * Thoroughly compare the cached data to see
> +				 * whether it should be marked for inclusion
> +				 * in the split index.
> +				 *
> +				 * This comparison might be unnecessary, as
> +				 * code paths modifying the cached data do
> +				 * set CE_UPDATE_IN_BASE as well.
> +				 */
> +				const unsigned int ondisk_flags =
> +					CE_STAGEMASK | CE_VALID |
> +					CE_EXTENDED_FLAGS;
> +				unsigned int ce_flags, base_flags, ret;
> +				ce_flags = ce->ce_flags;
> +				base_flags = base->ce_flags;
> +				/* only on-disk flags matter */
> +				ce->ce_flags   &= ondisk_flags;
> +				base->ce_flags &= ondisk_flags;
> +				ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
> +					     offsetof(struct cache_entry, name) -
> +					     offsetof(struct cache_entry, ce_stat_data));
> +				ce->ce_flags = ce_flags;
> +				base->ce_flags = base_flags;

Maybe make this block a separate function (compare_ce_content or
something). The amount of indentation is getting too high.

> +				if (ret)
> +					ce->ce_flags |= CE_UPDATE_IN_BASE;
> +			}
>  			discard_cache_entry(base);
>  			si->base->cache[ce->index - 1] = ce;
>  		}
> -- 
> 2.19.0.361.gafc87ffe72
> 
