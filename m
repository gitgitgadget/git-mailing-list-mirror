Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 343741F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeHJTA0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:00:26 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55086 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeHJTAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:00:24 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so3361898itb.4
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqnsFe5MaqiVUVsZAel12V8svRsLrKC8oHFSFJzPxfU=;
        b=lU02g2qIOE3GbQNUsUIE92v7M03PMWuJ2dJ4qLV+doU2IL7ABKAQnRhdEa4pgq4LGA
         vNSlOlh+JDH+XBvOP9KhSgsyY8pUunZNmjXdDEluNGY4jZc1XYQCsjKJGCrG7O95ZMMm
         lVgZ8AA9s/bhFmqC4weaH7y6DgpYf7Ud9tfXpz6mokVOQr6ke6ZFBM9wYWz/RTQ/BmDc
         9KNLoOB4lLzYUq/gLWhwBR+pHBsKSvjHy4wSz5ybttOF1mEugpGLGFh9GN7WWQ7A8Qex
         Plcxzj4UMEGJclpIQluh0CmiCeo/rHD+ouk0Nfv+h4Nzz/2P39DXMFiO+knn97k1pQ3g
         GB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqnsFe5MaqiVUVsZAel12V8svRsLrKC8oHFSFJzPxfU=;
        b=CamoebF4bVvYAhE+W3tDuFgdv6MuarVZ5SajpwCI4isQMU/vVoXz4fpXIES53o6v6U
         L3iPWC6w8l/SHl6BcEi55VtO1QsmZ0TdW0pCmL/TMdHvLPQFDY5f5oT3tx0k9jOMikD1
         uNuH59ELy5gCwoStPc6b7wijlBUEZzo4HfBcLAaBB44WRUTZMn6Bfm+SSHuEo0nqsRcM
         Vv7EFtxeP0A+8Puncl3BykhD3abb0/HulnQJATPF2oYSt6i1IsnC2y6Mncjy4ps8OcJR
         PCgoX3IwcP57YsjlKeQE8jZ4liX+xkAhmbz73unfolnAHQsXewVYruAiNGikgEMO9qk8
         mftA==
X-Gm-Message-State: AOUpUlHniYoV8u3v0dXLVRIAkUQCma9lHMmjUjd98E7W8Ejac1pPwvYS
        6NmtWh7bqpN4q0M+Pwr07h6TLvcZoLV+zWWu5pA=
X-Google-Smtp-Source: AA+uWPw98X4rVw+RpDNCk4C5v6xOme6GfeAVQth7CFah5bHz2BVDFL+WGPgnaG7npO3Wv+iPcpO/FcX+bMxXFO8F7Eg=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr2850341itc.68.1533918589799;
 Fri, 10 Aug 2018 09:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180729103306.16403-1-pclouds@gmail.com> <20180804053723.4695-1-pclouds@gmail.com>
 <20180804053723.4695-3-pclouds@gmail.com> <CABPp-BGcPV0RA624_1UOXYkvaNhW4yR2ifhV_MVFZQOgBb_Ydg@mail.gmail.com>
In-Reply-To: <CABPp-BGcPV0RA624_1UOXYkvaNhW4yR2ifhV_MVFZQOgBb_Ydg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 18:29:23 +0200
Message-ID: <CACsJy8BtgMSYqkD1EaFQ=S49BA-veyTO1qU0FaPMkHY-KeggfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] unpack-trees: optimize walking same trees with cache-tree
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 8:23 PM Elijah Newren <newren@gmail.com> wrote:
> > diff --git a/unpack-trees.c b/unpack-trees.c
> > index a32ddee159..ba3d2e947e 100644
> > --- a/unpack-trees.c
> > +++ b/unpack-trees.c
> > @@ -644,6 +644,102 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
> >         return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
> >  }
> >
> > +static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
> > +                                       struct name_entry *names,
> > +                                       struct traverse_info *info)
> > +{
> > +       struct unpack_trees_options *o = info->data;
> > +       int i;
> > +
> > +       if (!o->merge || dirmask != ((1 << n) - 1))
> > +               return 0;
> > +
> > +       for (i = 1; i < n; i++)
> > +               if (!are_same_oid(names, names + i))
> > +                       return 0;
> > +
> > +       return cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
> > +}
>
> I was curious whether this could also be extended in the case of a
> merge; as long as HEAD and MERGE have the same tree, even if the base
> commit doesn't match, we can still just use the tree from HEAD which
> should be in the current index/cache_tree.  However, it'd be a
> somewhat odd history for HEAD and MERGE to match on some significantly
> sized tree when the base commit doesn't also match.

I did have 3-way merge in mind when I wrote this patch. Yes it's
unlikely except one case (I think). Consider a large "mono repo" that
contains stuff from many teams. When you branch out for your own team,
then most of your changes will be in a few directories, the rest of
the code base untouched. In that case we could have a lot of same
trees in subdirectories outside the stuff your team touches. This of
course assumes that your team keeps the same base static for some
time, not constantly rebasing/merging on top of 'master'.

> > +       /*
> > +        * Do what unpack_callback() and unpack_nondirectories() normally
> > +        * do. But we walk all paths recursively in just one loop instead.
> > +        *
> > +        * D/F conflicts and staged entries are not a concern because
>
> "staged entries"?  Do you mean "higher stage entries"?  I'm not sure
> the correct terminology here, but the former makes me think of changes
> the user has staged but not committed (i.e. stuff found at stage #0 in
> the index, but which isn't found in any tree yet) vs. the latter which
> I'd use to refer to entries at stages 1 or higher.

Yep stage 1 or higher (I was thinking ce_stage() when I wrote this).
Will clarify.


> > +        * cache-tree would be invalidated and we would never get here
> > +        * in the first place.
> > +        */
> > +       for (i = 0; i < nr_entries; i++) {
> > +               struct cache_entry *tree_ce;
> > +               int len, rc;
> > +
> > +               src[0] = o->src_index->cache[pos + i];
> > +
> > +               len = ce_namelen(src[0]);
> > +               tree_ce = xcalloc(1, cache_entry_size(len));
> > +
> > +               tree_ce->ce_mode = src[0]->ce_mode;
> > +               tree_ce->ce_flags = create_ce_flags(0);
> > +               tree_ce->ce_namelen = len;
> > +               oidcpy(&tree_ce->oid, &src[0]->oid);
> > +               memcpy(tree_ce->name, src[0]->name, len + 1);
>
> We do a bunch of work to setup tree_ce...
>
> > +               for (d = 1; d <= nr_names; d++)
> > +                       src[d] = tree_ce;
>
> ...then we make nr_names copies of tree_ce (so that *way_merge or
> bind_merge or oneway_diff or whatever will have the expected number of
> entries).
>
> > +               rc = call_unpack_fn((const struct cache_entry * const *)src, o);
>
> ...then we call o->fn (via call_unpack_fn) to do various complicated
> logic to figure out which tree_ce to use??  Isn't that just an
> expensive way to recompute that what we currently have in the index is
> what we want to keep there?
>
> Granted, a caller of this may have set o->fn to something other than
> {one,two,three}way_merge (or bind_merge), and that function might have
> important side effects...but it just seems annoying to have to do so
> much work when for most uses we already know the entry in the index is
> the one we already want.

I'm not so sure about that. Which is why I keep it generic.

> In fact, the only other thing in the
> codebase that o->fn is now set to is oneway_diff, which I think is a
> no-op when the two trees match.
>
> Would be nice if we could avoid all this, at least in the common cases
> where o->fn is a function known to not have side effects.  Or did I
> not read those functions closely enough and they do have important
> side effects?

In one of my earlier "how about this" attempts, I introduced fn_same
[1] that can help achieve this without carving "known not to have side
effects" in common code. Which I think is still a good direction to go
if we want to optimize more aggressively. We could have something like
this

diff --git a/unpack-trees.c b/unpack-trees.c
index 1f11991a51..01b80389e0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -699,6 +699,9 @@ static int traverse_by_cache_tree(int pos, int
nr_entries, int nr_names,
        int ce_len = 0;
        int i, d;

+       if (o->fn_cache_tree)
+               return o->fn_cache_tree(pos, nr_entries, nr_names, names, info);
+
        if (!o->merge)
                BUG("We need cache-tree to do this optimization");

then you can add, say threeway_cache_tree_merge(), that does what
traverse_by_cache_tree() does but more efficient. This involves a lot
more work (mostly staring and those n-merge functions and making sure
you don't set the right conditions before going the fast path).

I didn't do it because.. well.. it's more work and also riskier. I
think we can leave that for later, unless you think we should do it
now.

[1] https://public-inbox.org/git/20180726163049.GA15572@duynguyen.home/
-- 
Duy
