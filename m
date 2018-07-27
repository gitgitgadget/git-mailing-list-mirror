Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E70E1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 17:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbeG0TQB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 15:16:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39702 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388739AbeG0TQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 15:16:00 -0400
Received: by mail-io0-f193.google.com with SMTP id o22-v6so4804346ioh.6
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 10:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIv7jHC95FqAb+7flLGW0uxIaskvsLBhLGAECxDKAYA=;
        b=GwuUaAYLsuUeffrKtravGP3HWO8Hyrg/EaotpMSue0/VeVgVpUfY3kS/lRCJz0hodF
         7BgUqwQraD6cnhcHcFsPuPmdncvSaWqvxz7CIhI1eK1Wl6e/kiHTXZnNBCYh4IaCpNkK
         O895251EA56Wx74YTy+EiiwXvav/+M64ssJMozJMKDdXWNnUsw4jV/uzjx6MS3kYuAoT
         fSvq9xFVvTXS8mYzOiK1q2RO7O/jj24ryFjK6IaAovJ0LAQDDkf7YRoT90EvSBkY7JAd
         2a891BClQk7x9/zQFzpgNA7+meTUzfyc+3ms2S0Nf5ZUKBqcC4T7UAxEB97RkFFw47uC
         S0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIv7jHC95FqAb+7flLGW0uxIaskvsLBhLGAECxDKAYA=;
        b=JI4KbnMzmwZhTI4aSIiFt6/4GBAZvH7z6ZlTodQVNVSOX7veyoTZoAHXv248UgSmPc
         r+87fpuxo8pMlIr7p2/+g0ZrqelTb7eXaeEMgWTn4h3npL0uW/nV+xdY5HJ5xE/s8Mrm
         aEqCXJ/NC+V4/uzYuazYa15zWLNeKWB2worleWfvKOiupgkNkd/B0+iUXP3HvQDx7GX5
         hFrL0dLjsJ2DFYYXbEbgE0a7dT1KiYuFl0K/b0a04arG0cNoTrpNc9XSSUmbjyC5Bb2M
         ffHSLbHyb3TRm5YCkZzjPNjw09a3sZ4OT2fI+7LZyn+T1nTDHLWy+yj0Vq3RBmUkkIJw
         d/cQ==
X-Gm-Message-State: AOUpUlGP/sAYAWqwbx8TL1qEhARzWKZjYNXBTQy+IL1OoYT6PUd1ETQn
        0YhtSg6ove5lHDZ3l5GlPbM+qfBTuVQQ3yksi70=
X-Google-Smtp-Source: AAOMgpfGCHGfiUpbeWzSF4fgTTYmwm6HelombfgrpMG+Z9uNA54VUztJ3e9cTFKW8yHzTkQ2NUetU9fkJsCfPuBnFLY=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr5499929ioe.282.1532713981603;
 Fri, 27 Jul 2018 10:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180718213420.GA17291@sigill.intra.peff.net> <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com> <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com> <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
 <20180726163049.GA15572@duynguyen.home> <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
 <20180727154241.GA21288@duynguyen.home> <xmqqpnz8ob2x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnz8ob2x.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 27 Jul 2018 19:52:33 +0200
Message-ID: <CACsJy8CeF53pA8jfVcY+50-Y_HLm0KkzWvDcTgGV0692hsTHZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase, etc)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 7:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index 66741130ae..9c791b55b2 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -642,6 +642,110 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
> >       return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
> >  }
> >
> > +static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
> > +                                     struct name_entry *names,
> > +                                     struct traverse_info *info)
> > +{
> > +     struct unpack_trees_options *o = info->data;
> > +     int i;
> > +
> > +     if (dirmask != ((1 << n) - 1) || !S_ISDIR(names->mode) || !o->merge)
> > +             return 0;
>
> In other words, punt if (1) not all are directories, (2) the first
> name entry given by the caller in names[] is not ISDIR(), or (3) we
> are not merging i.e. not "Are we supposed to look at the index too?"
> in unpack_callback().
>
> I am not sure if the second one is doing us any good.  When
> S_ISDIR(names->mode) is not true, then the bit in dirmask that
> corresponds to the one in the entry[] traverse_trees() filled and
> passed to us must be zero, so the dirmask check would reject such a
> case anyway, no?

You're right. This code kinda evolved from the diff_index_cached and I
forgot about this.

> > +     for (i = 0; i < nr_entries; i++) {
> > +             struct cache_entry *tree_ce;
> > +             int len, rc;
> > +
> > +             src[0] = o->src_index->cache[pos + i];
> > +
> > +             /* Do what unpack_nondirectories() normally does */
> > +             len = ce_namelen(src[0]);
> > +             tree_ce = xcalloc(1, cache_entry_size(len));
>
> unpack_nondirectories() uses create_ce_entry() here.  Any reason why
> we shouldn't use it and tell it to make a transient one?

That one takes a struct name_entry to recreate the path, which will
not be correct since we will go deep in subdirs in this loop as well.

Side note. I notice that I allocate/free (and memcpy even) more than I
should. The directory part in ce->name for example will never change.
And if the old tree_ce is large enough, we could avoid reallocation
too.

> > +             tree_ce->ce_mode = src[0]->ce_mode;
> > +             tree_ce->ce_flags = create_ce_flags(0);
> > +             tree_ce->ce_namelen = len;
> > +             oidcpy(&tree_ce->oid, &src[0]->oid);
> > +             memcpy(tree_ce->name, src[0]->name, len + 1);
> > +
> > +             for (d = 1; d <= nr_names; d++)
> > +                     src[d] = tree_ce;
> > +
> > +             rc = call_unpack_fn((const struct cache_entry * const *)src, o);
> > +             free(tree_ce);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             mark_ce_used(src[0], o);
> > +     }
> > +     trace_printf("Quick traverse over %d entries from %s to %s\n",
> > +                  nr_entries,
> > +                  o->src_index->cache[pos]->name,
> > +                  o->src_index->cache[pos + nr_entries - 1]->name);
> > +     return 0;
> > +}
>
> When I invented the cache-tree originally, primarily to speed up
> writing of deeply nested trees, I had the "diff-index --cached"
> optimization where a subtree with contents known to be the same as
> the corresponding span in the index is entirely skipped without
> getting even looked at.  I didn't realize this (now obvious)
> optimization that scanning the index is faster than opening and
> traversing trees (I was more focused on not even scanning, which
> is what "diff-index --cached" optimization was about).
>
> Nice.

I would still love to take this further. We should have cache-tree for
like 90% of HEAD, and even if we do 2 or 3 merge where the other trees
are very different, we should be able to just "recreate" HEAD from the
index by using cache-tree.

This is hard though, much trickier than dealing with this case. And I
guess that the benefit will be much smaller so probably not worth the
complexity.

> > +static int index_pos_by_traverse_info(struct name_entry *names,
> > +                                   struct traverse_info *info)
> > +{
> > +     struct unpack_trees_options *o = info->data;
> > +     int len = traverse_path_len(info, names);
> > +     char *name = xmalloc(len + 1);
> > +     int pos;
> > +
> > +     make_traverse_path(name, info, names);
> > +     pos = index_name_pos(o->src_index, name, len);
> > +     if (pos >= 0)
> > +             BUG("This is so wrong. This is a directory and should not exist in index");
> > +     pos = -pos - 1;
> > +     /*
> > +      * There's no guarantee that pos points to the first entry of the
> > +      * directory. If the directory name is "letters" and there's another
> > +      * file named "letters.txt" in the index, pos will point to that file
> > +      * instead.
> > +      */
>
> Is this trying to address the issue o->cache_bottom,
> next_cache_entry(), etc. are trying to address?  i.e. an entry
> "letters" appears at a different place relative to other entries in
> a tree, depending on the type of the entry itself, so linear and
> parallel scan of the index and the trees may miss matching entries
> without backtracking?  If so, I am not sure if the loop below is
> sufficient.

No it's because index_name_pos does not necessarily give us the right
starting point. This is why t6020 fails, where the index has "letters"
and "letters/foo" when the cache-tree for "letters" is valid. -pos-1
would give me the position of "letters", not "letters/foo". Ideally we
should be able to get this starting index from cache-tree code since
we're searching for it in there anyway. Then this code could be gone.

The cache_bottom stuff still scares me though. I reuse mark_ce_used()
with hope that it deals with cache_bottom correctly. And as you note,
the lookahead code to deal with D/F conflicts could probably mess up
here too. You're probably the best one to check this ;-)

> > +     while (pos < o->src_index->cache_nr) {
> > +             const struct cache_entry *ce = o->src_index->cache[pos];
> > +             if (ce_namelen(ce) > len &&
> > +                 ce->name[len] == '/' &&
> > +                 !memcmp(ce->name, name, len))
> > +                     break;
> > +             pos++;
> > +     }
> > +     if (pos == o->src_index->cache_nr)
> > +             BUG("This is still wrong");
> > +     free(name);
> > +     return pos;
> > +}
> > +
>
> In anycase, nice progress.

Just FYI I'm still trying to reduce execution time further and this
change happens to half traverse_trees() time (which is a huge deal)

diff --git a/unpack-trees.c b/unpack-trees.c
index f0be9f298d..a2e63ad5bf 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -201,7 +201,7 @@ static int do_add_entry(struct
unpack_trees_options *o, struct cache_entry *ce,

        ce->ce_flags = (ce->ce_flags & ~clear) | set;
        return add_index_entry(&o->result, ce,
-                              ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+                              ADD_CACHE_JUST_APPEND |
ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 }

 static struct cache_entry *dup_entry(const struct cache_entry *ce)

It's probably not the right thing to do of course. But perhaps we
could do something in that direction (e.g. validate everything at the
end of traverse_by_cache_tree...)
-- 
Duy
