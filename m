Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0F81F453
	for <e@80x24.org>; Sat, 29 Sep 2018 09:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeI2PmP (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 11:42:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33768 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeI2PmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 11:42:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10-v6so8742119wrs.0
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EjwLaoJgeuA5dJ4jsEnf809B12zGnGu1VopMi4b7P4w=;
        b=kEediQM/rdiuVkVpY3YPkLC70/eDypydjKKACE9nQly9SqzjAVkVhr+9d+Of4wJFGQ
         vdbldXrr6yPluPbYaanKlEyMFd1GjexvID+RyfDRW5T4fji9jaObwYp9sQpnAih4i7XB
         2Zhv8OIhzgsAzvoy8dfRfyZ/gXKFjDEwqKJmjXZizsikwoXddv/a2yT6mQaKv4Kdf3OX
         nEe1F6io9GmmKvV05vKHAETAKAEjzXEDVGLxu+SSb0N0zC5WJPKDiPgFF4+pF2fNuLtu
         VJSeKSidVYy7DlbDmFHDkNomUmlLvnGQcDAkOwPWuvFXzNM1yKNpktimrB5T3z2MKskm
         6WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EjwLaoJgeuA5dJ4jsEnf809B12zGnGu1VopMi4b7P4w=;
        b=ipl6YOrv47bCFBqxGHX09zA+UAyjBe3T/F12O0/4KGCzkonVif49v4J9Ukud/tlwpe
         nxeNzcQB7y8OBmrqJVa3dAxdm9EKbc9NNhYRFOCOLkyFjt7ZuObU9VEVmLhpTG0fObVt
         qTnTzrnC+kf04GELGXk9o7vwbEg0Ne9O3TKuCGUhg1Kp+mNrL6HIj/Z+u4Bjhj8NIKSc
         RoV5sbndWW9SyR0Ojbcr6n8uigNnUosuB/D7Vx/mH+lkjzJykcGh04aMWhLpvvi3WIJH
         r+YYTrlaLNMxBMRwTbxasnqrV7jjCQXTDVYZ10vlZHJ9QprH+74f19ryxiVqV1m2p2K0
         oL8Q==
X-Gm-Message-State: ABuFfoh1k9DjYoMU/ADbo08CXs5Erc675bQD+T81lDzc7RA6fWcYZ1a8
        A+Wc7JQnbKeEkbnIHy3nuBQ=
X-Google-Smtp-Source: ACcGV61FGF9BwxWqno3uAEs+YFg/l/rS1iixdp31G+yyhFINJkDISfWMhc3ZKs8sxFHubE1tAyn+Lg==
X-Received: by 2002:adf:9101:: with SMTP id j1-v6mr1516862wrj.3.1538212472261;
        Sat, 29 Sep 2018 02:14:32 -0700 (PDT)
Received: from localhost (x4db14438.dyn.telefonica.de. [77.177.68.56])
        by smtp.gmail.com with ESMTPSA id z16-v6sm4522204wrq.78.2018.09.29.02.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 02:14:31 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:14:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] split-index: don't compare stat data of entries
 already marked for split index
Message-ID: <20180929091429.GF23446@localhost>
References: <20180927124434.30835-1-szeder.dev@gmail.com>
 <20180928162459.17138-1-szeder.dev@gmail.com>
 <20180928162459.17138-6-szeder.dev@gmail.com>
 <20180929053608.GB20349@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180929053608.GB20349@duynguyen.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 07:36:08AM +0200, Duy Nguyen wrote:
> On Fri, Sep 28, 2018 at 06:24:58PM +0200, SZEDER Gábor wrote:
> > When unpack_trees() constructs a new index, it copies cache entries
> > from the original index [1].  prepare_to_write_split_index() has to
> > deal with this, and it has a dedicated code path for copied entries
> > that are present in the shared index, where it compares the cached
> > data in the corresponding copied and original entries.  If the cached
> > data matches, then they are considered the same; if it differs, then
> > the copied entry will be marked for inclusion as a replacement entry
> > in the just about to be written split index by setting the
> > CE_UPDATE_IN_BASE flag.
> > 
> > However, a cache entry already has its CE_UPDATE_IN_BASE flag set upon
> > reading the split index, if the entry already has a replacement entry
> > there, or upon refreshing the cached stat data, if the corresponding
> > file was modified.  The state of this flag is then preserved when
> > unpack_trees() copies a cache entry from the shared index.
> > 
> > So modify prepare_to_write_split_index() to check the copied cache
> > entries' CE_UPDATE_IN_BASE flag first, and skip the thorough
> > comparison of cached data if the flag is already set.
> 
> OK so this is an optimization, not a bug fix. Right?

Well, a microoptimization at most: with all what's going on in
unpack_trees() I seriously doubt that it's effect is measurable.

> > Note that comparing the cached data in copied and original entries in
> 
> s/cached data/cached stat data/ ? I was confused for a bit.

No, it's indeed cached data, but now that you mention it, the subject
line does need a s/stat //.

The comparison is done with this call:

  ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
               offsetof(struct cache_entry, name) -
               offsetof(struct cache_entry, ce_stat_data));

i.e. it starts at the stat data and ends just before the cache entry's
name, and 'struct cache_entry' has several other fields between these
two, including e.g. the cached oid:

  struct cache_entry {
          struct hashmap_entry ent;
          struct stat_data ce_stat_data;
          unsigned int ce_mode;
          unsigned int ce_flags;
          unsigned int mem_pool_allocated;
          unsigned int ce_namelen;
          unsigned int index;     /* for link extension */
          struct object_id oid;
          char name[FLEX_ARRAY]; /* more */
  };

However, to me it's mostly about clarity of the code, and about
documenting that CE_UPDATE_IN_BASE might have already been set at that
point and why, so the next dev diving in to debug the split index
doesn't have to figure this out himself.

> > the shared index might actually be entirely unnecessary.  In theory
> > all code paths refreshing the cached stat data of an entry in the
> > shared index should set the CE_UPDATE_IN_BASE flag in that entry, and
> > unpack_trees() should preserve this flag when copying cache entries.
> > This means that the cached data is only ever changed if the
> > CE_UPDATE_IN_BASE flag is set as well.  Our test suite seems to
> > confirm this: instrumenting the conditions in question and running the
> > test suite repeatedly with 'GIT_TEST_SPLIT_INDEX=yes' showed that the
> > cached data in a copied entry differs from the data in the shared
> > entry only if its CE_UPDATE_IN_BASE flag is indeed set.
> 
> Yes I was probably just being paranoid (or sticking to simpler
> checks). I was told that split index is computation expensive and not
> doing unnecesary/expensive checks may help. But let's leave it for
> later.
> 
> > +			} else {
> > +				/*
> > +				 * Thoroughly compare the cached data to see
> > +				 * whether it should be marked for inclusion
> > +				 * in the split index.
> > +				 *
> > +				 * This comparison might be unnecessary, as
> > +				 * code paths modifying the cached data do
> > +				 * set CE_UPDATE_IN_BASE as well.
> > +				 */
> > +				const unsigned int ondisk_flags =
> > +					CE_STAGEMASK | CE_VALID |
> > +					CE_EXTENDED_FLAGS;
> > +				unsigned int ce_flags, base_flags, ret;
> > +				ce_flags = ce->ce_flags;
> > +				base_flags = base->ce_flags;
> > +				/* only on-disk flags matter */
> > +				ce->ce_flags   &= ondisk_flags;
> > +				base->ce_flags &= ondisk_flags;
> > +				ret = memcmp(&ce->ce_stat_data, &base->ce_stat_data,
> > +					     offsetof(struct cache_entry, name) -
> > +					     offsetof(struct cache_entry, ce_stat_data));
> > +				ce->ce_flags = ce_flags;
> > +				base->ce_flags = base_flags;
> 
> Maybe make this block a separate function (compare_ce_content or
> something). The amount of indentation is getting too high.

Ah, I was secretly hoping for something along the lines of "your
analysis is correct, we can safely drop this comparison" :)

Btw, I thought about extracing this whole loop into a separate
function like mark_updated_entries_for_split_index() or something, but
there are other things going on in this loop as well, e.g. marking
with CE_MATCHED and deduplicating copied entries, not to mention the
conditions that set 'ce->index = 0', which I think should die() or
BUG() or are unnecessary, see my followup email to this patch in v4:

  https://public-inbox.org/git/20180927134324.GI27036@localhost/

> > +				if (ret)
> > +					ce->ce_flags |= CE_UPDATE_IN_BASE;
> > +			}
> >  			discard_cache_entry(base);
> >  			si->base->cache[ce->index - 1] = ce;
> >  		}
> > -- 
> > 2.19.0.361.gafc87ffe72
> > 
