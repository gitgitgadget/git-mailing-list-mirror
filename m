Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED7601F405
	for <e@80x24.org>; Fri, 10 Aug 2018 19:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeHJWBq (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:01:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39252 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeHJWBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:01:45 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so4751534iok.6
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUUNINvLhV60G7XjkVZG+rR6aHdDpCsWuUMaZ8Si8xQ=;
        b=esqja767poL5NCV8rU+5SIO5JTU25mFhTDdafh3P5rLm/J8TSuXWOUJuq+DqzOdxUr
         LYBOof9i4X2fjL87YdefkfOTU+MRzt4APG3kkuSftQ6w+PIhOAVlQABQF8df/a7IRfVV
         vv80xbO6xZ/Ja8iABi12BtxhlxD0bOaWdiuU3Z/G+2aG29IvbfOFU/vY/1awv4SE+OhY
         O/bCtIuCTRwv49NY7ULDT1usaA76j5xZAGHqhut2vbD7uCSrVIgqY9dZ8MvKVuJADMU4
         ZLKFGP+kE3OsDhT+LnfNeb4loap8KC19UNcdxxYjShNwJbl3jIO0LIPI9gtk7ZkJ3qMY
         lIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUUNINvLhV60G7XjkVZG+rR6aHdDpCsWuUMaZ8Si8xQ=;
        b=nKnD6B1zyvvV+XWbdmNfkzup1oevYM06zqmuSrkxQI3z2haDovQVIm1Mdx5IC3Q0Y7
         mrxCFJFiFT+RtGgRnRH/GOTKk8cId3ZVmL8IwwUyg1kqm8t2pGMkFNKskFrKNUzY3CMq
         1UL8NyRVFYcIyLUPDxpmxeSoOfJL6oEYE1Zic2gjt+ltvJiIEU03RRa2gWL3xj7Ld7Gn
         5rjLnO1PkGbpss7GNijtNAiSwiDa2r6SA2vrWPyRhrPl3HImDBUcf/N66aC61kdKHxt/
         p2D0qIyDmEZtNmcW4e1h1YWgFNcSpg0HMnhQ5RCJsvBB4GgWzeeAtAHeBZSMmaAuwk/Z
         1bjA==
X-Gm-Message-State: AOUpUlGD9HEK1zeFkZ3XTeRZ13NyDaVzRmI4ViKA75Dp2TleOz2S9oJ8
        OpYRmFPRXQqJpqJCNhp1IXV0c5UBoxKyqBZrmTo=
X-Google-Smtp-Source: AA+uWPyG/xabUj1isAcJV6c4DONRJepVFLQawk6nGdvjbvFpDqKOm8Uet2183QV1uwSZ/Q6lDVt7NZ4rQ++OWNkVslg=
X-Received: by 2002:a6b:8f4b:: with SMTP id r72-v6mr6531719iod.118.1533929432196;
 Fri, 10 Aug 2018 12:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-5-pclouds@gmail.com> <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
 <CACsJy8DF5XLf-RF3SwTpRynYALJUPO_VTK=fpx1oabwB80ZpPw@mail.gmail.com> <CABPp-BGU6QnUwQgkhwx6vLBc3ozoEScQ4DaZd-9ZZfQhXfxPww@mail.gmail.com>
In-Reply-To: <CABPp-BGU6QnUwQgkhwx6vLBc3ozoEScQ4DaZd-9ZZfQhXfxPww@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 21:30:05 +0200
Message-ID: <CACsJy8AeptcqwRC+DOrdhvk69kEQT6+S6M=0OGWBFOE5gihGzA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] unpack-trees: cheaper index update when walking by cache-tree
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

On Fri, Aug 10, 2018 at 8:39 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Aug 10, 2018 at 9:39 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, Aug 8, 2018 at 8:46 PM Elijah Newren <newren@gmail.com> wrote:
> > > > @@ -701,6 +702,24 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
>
> > > If we're going to go this route, I think we should first check that
> > > o->fn is one of those known safe functions.  And if we're going that
> > > route, the comments I bring up on patch 2 about possibly avoiding
> > > call_unpack_fn() altogether might even obviate this patch while
> > > speeding things up more.
> >
> > Yes I do need to check o->fn. I might have to think more about
> > avoiding call_unpack_fn(). Even if we avoid it though, we still go
> > through add_index_entry() and suffer the same checks every time unless
> > we do somethine like this (but then of course it's safer because
> > you're doing it in a specific x-way merge, not generic code like
> > this).
>
> Why do we still need to go through add_index_entry()?  I thought that
> the whole point was that you already checked that at the current path,
> the trees being unpacked were all equal and matched both the index and
> the cache_tree.  If so, why is there any need for an update at all?
> (Did I read your all_trees_same_as_cache_tree() function wrong, and
> you don't actually know these all match in some important way?)

Unless fn is oneway_diff, we have to create a new index (in o->result)
based on o->src_index and some other trees. So we have to add entries
to o->result and add_index_entry() is the way to do that (granted if
we feel confident we could add ADD_CACHE_JUST_APPEND which makes it
super cheap). This is the outcome of n-way merge,

all_trees_same_as_cache_tree() only gurantees the input condition (all
trees the same, index also the same) but it can't affect what fn does.
I don't think we can just simply skip and not update anything (like
o->diff_index_cached case) because o->result would be empty in the
end. And we need to create (temporary) o->result before we can swap it
to o->dst_index as the result of a merge operation.

> > > > @@ -1561,6 +1581,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> > > >                 if (!ret) {
> > > >                         if (!o->result.cache_tree)
> > > >                                 o->result.cache_tree = cache_tree();
> > > > +                       /*
> > > > +                        * TODO: Walk o.src_index->cache_tree, quickly check
> > > > +                        * if o->result.cache has the exact same content for
> > > > +                        * any valid cache-tree in o.src_index, then we can
> > > > +                        * just copy the cache-tree over instead of hashing a
> > > > +                        * new tree object.
> > > > +                        */
> > >
> > > Interesting.  I really don't know how cache_tree works...but if we
> > > avoided calling call_unpack_fn, and thus left the original index entry
> > > in place instead of replacing it with an equal one, would that as a
> > > side effect speed up the cache_tree_valid/cache_tree_update calls for
> > > us?  Or is there still work here?
> >
> > Naah. Notice that we don't care at all about the source's cache-tree
> > when we update o->result one (and we never ever do anything about
> > o->result's cache-tree during the merge). Whether you invalidate or
> > not, o->result's cache-tree is always empty and you still have to
> > recreate all cache-tree in o->result. You essentially play full cost
> > of "git write-tree" here if I'm not mistaken.
>
> Oh...perhaps that answers my question above.  So we have to call
> add_index_entry() for the side effect of populating the new
> cache_tree?

I have a feeling that you're thinking we can swap o->src_index to
o->dst_index at the end? That might explain your confusion about
o->result (or I misread your replies horribly) and the original
index...
-- 
Duy
