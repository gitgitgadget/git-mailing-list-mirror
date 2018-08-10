Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9219B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeHJVTu (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:19:50 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:32827 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeHJVTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:19:50 -0400
Received: by mail-ua1-f66.google.com with SMTP id i4-v6so2924907uak.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YRYmWwtR7rPjj5F604HZyNfPHtNJIS+2VGeSBukcTk=;
        b=EtajTh1132YZU8BQlZ/FEtYP4t5gdx4W9Wsh/GOtt+0xl81ywQUohyyjE1tWv4416K
         GDh4R9oJ5V1wR0EVCgdzQ7il254qdZwq2tass6yNu3XawcpRgEvPwu84+oebwWPzVIb+
         rp1BZX1ha3xqbPKBpYv+f85eaAc+BufDPBYT0nTryYtxN8gLa7K80g1RKOVZiAgv5pOK
         t3o3zBFW4S7+RyQzDIqD7Kahod75QXp8/LpEiGxoC77sZuyWLH5G2wbu/28YpHLf3Z6o
         R5JC/xRDXk8RSgSJ7Xo+iJ3zVu21D+2L29/9VF5KLaYEVEr/EYnzZ5n8C807wSBJ6DQs
         AoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YRYmWwtR7rPjj5F604HZyNfPHtNJIS+2VGeSBukcTk=;
        b=uh+SdLEB36sonqScn7gsU0T7GIFcz3xL9m7G3FyrxGQCpdi/6YXqF3rIdmcxRDHJSe
         ejURtbmndBz7cEIyovgWEeKt9+AYj9oXQV5g245RQkE2//LJuY1UT9AavgOSJaudvUQy
         1c93sM1Llxz3HnFksEgV5AHxiJ5e/pzHbwJ4zUSlZh1pczEJazXtzUN7cOArJkDV1Qmg
         ngOrr7nv6iZ6EBlAelpw9QKUebikKxhiuMggyZPMxm9bct84ysPZP6PYp4th4fm9zEB4
         qGS3SoW6lRCX/gc2zAJKL4roMovU2fNZOuYV3Nqbq9tUMvZqfAVV47sg8Lifxd57gnJq
         g8/g==
X-Gm-Message-State: AOUpUlHgM8Kw7GRW6eGVDEcsXc7g3Y2GLKPHkTMsrNySD3At+24x4ArO
        wYNj66gxYjlmFFawDMqjGZdpmyZJCJaHzsMta6o=
X-Google-Smtp-Source: AA+uWPxGWP+csQ4fWN2kBM/QuCMCFm3Ad0KQTpC1tZrBvML/shP0VEyoyAY0kF4LzBPmnQE30jCUkjE6f3Ujh7tVhOc=
X-Received: by 2002:a9f:3d1a:: with SMTP id l26-v6mr5169398uai.29.1533926924908;
 Fri, 10 Aug 2018 11:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180729103306.16403-1-pclouds@gmail.com> <20180804053723.4695-1-pclouds@gmail.com>
 <20180804053723.4695-3-pclouds@gmail.com> <CABPp-BGcPV0RA624_1UOXYkvaNhW4yR2ifhV_MVFZQOgBb_Ydg@mail.gmail.com>
 <CACsJy8BtgMSYqkD1EaFQ=S49BA-veyTO1qU0FaPMkHY-KeggfA@mail.gmail.com>
In-Reply-To: <CACsJy8BtgMSYqkD1EaFQ=S49BA-veyTO1qU0FaPMkHY-KeggfA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Aug 2018 11:48:33 -0700
Message-ID: <CABPp-BEOFSU2k+DKuTQZtz+c6eboiUo3RDzBZHkB6=V3SFAigQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] unpack-trees: optimize walking same trees with cache-tree
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 9:29 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Aug 8, 2018 at 8:23 PM Elijah Newren <newren@gmail.com> wrote:

> > > +        * cache-tree would be invalidated and we would never get here
> > > +        * in the first place.
> > > +        */
> > > +       for (i = 0; i < nr_entries; i++) {
> > > +               struct cache_entry *tree_ce;
> > > +               int len, rc;
> > > +
> > > +               src[0] = o->src_index->cache[pos + i];
> > > +
> > > +               len = ce_namelen(src[0]);
> > > +               tree_ce = xcalloc(1, cache_entry_size(len));
> > > +
> > > +               tree_ce->ce_mode = src[0]->ce_mode;
> > > +               tree_ce->ce_flags = create_ce_flags(0);
> > > +               tree_ce->ce_namelen = len;
> > > +               oidcpy(&tree_ce->oid, &src[0]->oid);
> > > +               memcpy(tree_ce->name, src[0]->name, len + 1);
> >
> > We do a bunch of work to setup tree_ce...
> >
> > > +               for (d = 1; d <= nr_names; d++)
> > > +                       src[d] = tree_ce;
> >
> > ...then we make nr_names copies of tree_ce (so that *way_merge or
> > bind_merge or oneway_diff or whatever will have the expected number of
> > entries).
> >
> > > +               rc = call_unpack_fn((const struct cache_entry * const *)src, o);
> >
> > ...then we call o->fn (via call_unpack_fn) to do various complicated
> > logic to figure out which tree_ce to use??  Isn't that just an
> > expensive way to recompute that what we currently have in the index is
> > what we want to keep there?
> >
> > Granted, a caller of this may have set o->fn to something other than
> > {one,two,three}way_merge (or bind_merge), and that function might have
> > important side effects...but it just seems annoying to have to do so
> > much work when for most uses we already know the entry in the index is
> > the one we already want.
>
> I'm not so sure about that. Which is why I keep it generic.
>
> > In fact, the only other thing in the
> > codebase that o->fn is now set to is oneway_diff, which I think is a
> > no-op when the two trees match.
> >
> > Would be nice if we could avoid all this, at least in the common cases
> > where o->fn is a function known to not have side effects.  Or did I
> > not read those functions closely enough and they do have important
> > side effects?
>
> In one of my earlier "how about this" attempts, I introduced fn_same
> [1] that can help achieve this without carving "known not to have side
> effects" in common code. Which I think is still a good direction to go
> if we want to optimize more aggressively. We could have something like
> this
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 1f11991a51..01b80389e0 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -699,6 +699,9 @@ static int traverse_by_cache_tree(int pos, int
> nr_entries, int nr_names,
>         int ce_len = 0;
>         int i, d;
>
> +       if (o->fn_cache_tree)
> +               return o->fn_cache_tree(pos, nr_entries, nr_names, names, info);
> +
>         if (!o->merge)
>                 BUG("We need cache-tree to do this optimization");
>
> then you can add, say threeway_cache_tree_merge(), that does what
> traverse_by_cache_tree() does but more efficient. This involves a lot
> more work (mostly staring and those n-merge functions and making sure
> you don't set the right conditions before going the fast path).
>
> I didn't do it because.. well.. it's more work and also riskier. I
> think we can leave that for later, unless you think we should do it
> now.
>
> [1] https://public-inbox.org/git/20180726163049.GA15572@duynguyen.home/

Yeah, from your other thread, I think I was missing some of the
intracacies of how the cache-tree works and the extra work that'd be
needed to bring it along. Deferring until later makes sense.
