Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A0C1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 13:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeI0UBu (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 16:01:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51597 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeI0UBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 16:01:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id y25-v6so5965662wmi.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XC/907d5gviuyIfzNfUifVifxb9F2+sitWoMbWEwsN8=;
        b=TaZW8L5CRMxOb9hV/Da24kj14BpoQd0OrC3Gq8CiQytPK+cyhJljIHfmS01i2TCijb
         im1pBAlry8pLOZGY8CQ1uv7r92P51SE44xhKH/5UikhSEJQg7UgJ3/wLyM4NHkUaUD8P
         +sB5cHfSkhXeOVOH7/WMllYyURFULlVcb+UxldMQbVGc3X52WkW7JEJKfTfZt++p3iGq
         2ZF2szxBL1uib8dNV+OOLUcC1g2bjGYrEqNqvO2BthaYg3R9JZXh06LOOQL7CVio5aJu
         4Zkg6ez430TN//i4IhfwiHXvymgpWIKpbWD2ZQbxvCyxvKzhIWuxCXTtVc1A/DetlFh1
         mpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XC/907d5gviuyIfzNfUifVifxb9F2+sitWoMbWEwsN8=;
        b=jXnNH/ue0D6snVicv/BSCq6R0ay2K9XoFlJDhJ3Uw7SHMl8jeTNM0EOqzBnDk0atlw
         EOip7FRAPD3kQNemM2d3KGc7zu1iuFiPipG7Vno/g3vGH6KvAU5fIfK2vwcaRVX61yG7
         XYIm4Sz3qy++DkTRW2K7DkC8jkS9OGbE7WfFiGwG7hCad76HW52NKUk4nLNhkUXrn7Ie
         JQrWLne5qqW6WxRWFWnL++799WV435R4dIo/ZEK2LL1AkGsGrcH+U1cez096EZ7LYbKo
         e9z49Q63LdCM/fZ/RJj/yxfF+WAyFIlDH8rf9R2t3upo57ctK2s/hfXFPmMR3b6yDNOS
         AOhg==
X-Gm-Message-State: ABuFfoinJRCxvzYO8aGwUURPwxcMHP9IZ3QWOZfU0v0XiysvPeqMb3XM
        CQxc2+q7OE8aXSXRdGuv+NMft9OI
X-Google-Smtp-Source: ACcGV61C6HEg0EWB/5zYy5rRZEObikeK39kj9Knb+fO5mzVevjfu5zB+c/Z8aGwudWXOqrmdSXOz4g==
X-Received: by 2002:a1c:b4d:: with SMTP id 74-v6mr7458545wml.15.1538055808089;
        Thu, 27 Sep 2018 06:43:28 -0700 (PDT)
Received: from localhost (x4dbd8656.dyn.telefonica.de. [77.189.134.86])
        by smtp.gmail.com with ESMTPSA id l8-v6sm2314739wrs.63.2018.09.27.06.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 06:43:27 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:43:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 4/5] split-index: don't compare stat data of entries
 already marked for split index
Message-ID: <20180927134324.GI27036@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180927124434.30835-5-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927124434.30835-5-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 02:44:33PM +0200, SZEDER Gábor wrote:
>  split-index.c | 79 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 17 deletions(-)

I generated this patch with more context lines than usual, so the two
conditions that I didn't add any comments to in this or in the next
patch are fully visible.

> diff --git a/split-index.c b/split-index.c
> index 548272ec33..7d8799f6b7 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -204,19 +204,34 @@ void prepare_to_write_split_index(struct index_state *istate)
>  		 * that are not marked with either CE_MATCHED or
>  		 * CE_UPDATE_IN_BASE. If istate->cache[i] is a
>  		 * duplicate, deduplicate it.
>  		 */
>  		for (i = 0; i < istate->cache_nr; i++) {
>  			struct cache_entry *base;
> -			/* namelen is checked separately */
> -			const unsigned int ondisk_flags =
> -				CE_STAGEMASK | CE_VALID | CE_EXTENDED_FLAGS;
> -			unsigned int ce_flags, base_flags, ret;
>  			ce = istate->cache[i];
> -			if (!ce->index)
> +			if (!ce->index) {
> +				/*
> +				 * During simple update index operations this
> +				 * is a cache entry that is not present in
> +				 * the shared index.  It will be added to the
> +				 * split index.
> +				 *
> +				 * However, it might also represent a file
> +				 * that already has a cache entry in the
> +				 * shared index, but a new index has just
> +				 * been constructed by unpack_trees(), and
> +				 * this entry now refers to different content
> +				 * than what was recorded in the original
> +				 * index, e.g. during 'read-tree -m HEAD^' or
> +				 * 'checkout HEAD^'.  In this case the
> +				 * original entry in the shared index will be
> +				 * marked as deleted, and this entry will be
> +				 * added to the split index.
> +				 */
>  				continue;
> +			}
>  			if (ce->index > si->base->cache_nr) {
>  				ce->index = 0;
>  				continue;
>  			}

This condition in the context above checks whether a cache entry
refers to a non-existing entry in the shared index.

I don't understand the role of this condition, for two reasons:

  - Under what circumstances can this condition be ever fulfilled?

    I instrumented it and run the test suite repeatedly with
    'GIT_TEST_SPLIT_INDEX=yes', but it has never been fulfilled.  I
    also tried to come up with all kinds of elaborate scenarios to
    trigger it, but no joy, and code inspection didn't bring anything
    either.

  - There are similar conditions in 'split-index.c' in the functions
    mark_entry_for_delete() and replace_entry(); here is the one from
    the latter, but they only differ in the error message:

      if (pos >= istate->cache_nr)
          die("position for replacement %d exceeds base index size %d",
              (int)pos, istate->cache_nr);

    (Note that this 'istate->cache_nr' here equals
    to 'si->base->cache_nr'; see their caller merge_base_index().)

    The die() clearly indicates that fulfilling this condition is a
    Bad Thing.  These two functions are invoked to create a unified
    view of the just read split and shared indexes, so the fulfillment
    of this condition could indicate a corrupt index file, and
    die()ing right away seems to be justified.

    Then why doesn't the condition in prepare_to_write_split_index()
    die() as well?!  After all if it were fulfilled, then it would
    indicate a corruption in the current index_state, and writing a
    new split index from corrupt data doesn't seem like a particularly
    good idea.


>  			ce->ce_flags |= CE_MATCHED; /* or "shared" */
>  			base = si->base->cache[ce->index - 1];
> @@ -224,24 +239,54 @@ void prepare_to_write_split_index(struct index_state *istate)
>  				continue;
>  			if (ce->ce_namelen != base->ce_namelen ||
>  			    strcmp(ce->name, base->name)) {
>  				ce->index = 0;
>  				continue;
>  			}

I don't understand the role of this condition either, and just like
the one discussed above, the test suite with
'GIT_TEST_SPLIT_INDEX=yes' seems to never fulfill it.

> -			ce_flags = ce->ce_flags;
> -			base_flags = base->ce_flags;
> -			/* only on-disk flags matter */
> -			ce->ce_flags   &= ondisk_flags;
> -			base->ce_flags &= ondisk_flags;
> -			ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
> -				     offsetof(struct cache_entry, name) -
> -				     offsetof(struct cache_entry, ce_stat_data));
> -			ce->ce_flags = ce_flags;
> -			base->ce_flags = base_flags;
> -			if (ret)
> -				ce->ce_flags |= CE_UPDATE_IN_BASE;
> +			/*
> +			 * This is the copy of a cache entry that is present
> +			 * in the shared index, created by unpack_trees()
> +			 * while it constructed a new index.
> +			 */
> +			if (ce->ce_flags & CE_UPDATE_IN_BASE) {
> +				/*
> +				 * Already marked for inclusion in the split
> +				 * index, either because the corresponding
> +				 * file was modified and the cached stat data
> +				 * was refreshed, or because the original
> +				 * entry already had a replacement entry in
> +				 * the split index.
> +				 * Nothing to do.
> +				 */
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
> +				if (ret)
> +					ce->ce_flags |= CE_UPDATE_IN_BASE;
> +			}
>  			discard_cache_entry(base);
>  			si->base->cache[ce->index - 1] = ce;
>  		}
>  		for (i = 0; i < si->base->cache_nr; i++) {
>  			ce = si->base->cache[i];
>  			if ((ce->ce_flags & CE_REMOVE) ||
> -- 
> 2.19.0.361.gafc87ffe72
> 
