Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9511F404
	for <e@80x24.org>; Fri, 10 Aug 2018 18:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbeHJVLB (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:11:01 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35379 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeHJVLB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:11:01 -0400
Received: by mail-ua1-f67.google.com with SMTP id q12-v6so2897758ual.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yl6U9tHaW3zBIlG5xU40NiUO+fL662lxt7wtySEf33U=;
        b=VKMaJ1K4MwhoXfLdBsv1CUfT6zAlirngcYIiHBE2cFIt7RPsiC0hBvv8wHl5CY3oSZ
         E+vGKaesmWjwEgXzdxbUFHJCFdh2+OfhKnSmqYiCPX8OJVjl98PdWcpPwMXOywQJnJGI
         Cv/6n3id2YzYKjs3sXDhViYjy5wShM2nAv4X9NrWcybIUHvY5vhQRS0X+9wIZc/AYvxd
         4UEIl8Pz2R95P/xjsNSai0YbfvUphrqgIs+m0P+8FOway1XFwX2DrNtW3xQVj4+5nv+B
         CTGBevAFE4LYUmQjD+cIqgZGUi+ugtaDGREGaGIfBTUUBgL1ercpNViD4vXvlbbD8LgM
         /67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yl6U9tHaW3zBIlG5xU40NiUO+fL662lxt7wtySEf33U=;
        b=WO3ao0o+xsiYPNTVQdQSZN+4zwXo6xeLoK7dDw28gTEpeMbEZileoV/9C1N76f1LBO
         /PmlWZ6Dn+iUyFmuIK/5uwnnkSsCwmQ1jt3GEoUC2HGVkYH6pfPYgKhOwcuPqgxw2zde
         YgZA4FOz3/qLAIHi0alxseO5qdCq3DCAySu+xlkkK/rEeJmiqO0Q0ZikVN66ijsMAAa8
         QXauV8jNUt2boyXWU+s0Mh+ytWt/6tt/pz3wgHjENooJpTOrqrAypusgPD53XkL88QEb
         1HyPTVnt8Ga2oRzOsVAErXAnD5aQadMDOuhj/Eo4qz7p3UU6qItxY6Koh+EGk6Po/1cC
         1bNw==
X-Gm-Message-State: AOUpUlEv/CHF0Ct82lr6xr/LLIZAhB3OyVC8XdhWpuKtH8LGLSi3JDqy
        aPVvYyU11hKOQdawc/NJoKrNO/dpmrvpcVk1Rh1et1Oe
X-Google-Smtp-Source: AA+uWPy1RerG28Gq7EwG3bS1b1DqEOXgEA1qePpq5cLQSCeS4urXbx9cUFTdmTImd+LICGJYx+McvArHSUuMClscZB0=
X-Received: by 2002:a1f:f284:: with SMTP id q126-v6mr4806636vkh.38.1533926397232;
 Fri, 10 Aug 2018 11:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <20180729103306.16403-5-pclouds@gmail.com> <CABPp-BGF+GZjm-DiveLjFOESKwPz2F0Y7X4_kXyem2xFo2odUw@mail.gmail.com>
 <CACsJy8DF5XLf-RF3SwTpRynYALJUPO_VTK=fpx1oabwB80ZpPw@mail.gmail.com>
In-Reply-To: <CACsJy8DF5XLf-RF3SwTpRynYALJUPO_VTK=fpx1oabwB80ZpPw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Aug 2018 11:39:45 -0700
Message-ID: <CABPp-BGU6QnUwQgkhwx6vLBc3ozoEScQ4DaZd-9ZZfQhXfxPww@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] unpack-trees: cheaper index update when walking by cache-tree
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

On Fri, Aug 10, 2018 at 9:39 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Aug 8, 2018 at 8:46 PM Elijah Newren <newren@gmail.com> wrote:
> > > @@ -701,6 +702,24 @@ static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,

> > If we're going to go this route, I think we should first check that
> > o->fn is one of those known safe functions.  And if we're going that
> > route, the comments I bring up on patch 2 about possibly avoiding
> > call_unpack_fn() altogether might even obviate this patch while
> > speeding things up more.
>
> Yes I do need to check o->fn. I might have to think more about
> avoiding call_unpack_fn(). Even if we avoid it though, we still go
> through add_index_entry() and suffer the same checks every time unless
> we do somethine like this (but then of course it's safer because
> you're doing it in a specific x-way merge, not generic code like
> this).

Why do we still need to go through add_index_entry()?  I thought that
the whole point was that you already checked that at the current path,
the trees being unpacked were all equal and matched both the index and
the cache_tree.  If so, why is there any need for an update at all?
(Did I read your all_trees_same_as_cache_tree() function wrong, and
you don't actually know these all match in some important way?)


> > > @@ -1561,6 +1581,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> > >                 if (!ret) {
> > >                         if (!o->result.cache_tree)
> > >                                 o->result.cache_tree = cache_tree();
> > > +                       /*
> > > +                        * TODO: Walk o.src_index->cache_tree, quickly check
> > > +                        * if o->result.cache has the exact same content for
> > > +                        * any valid cache-tree in o.src_index, then we can
> > > +                        * just copy the cache-tree over instead of hashing a
> > > +                        * new tree object.
> > > +                        */
> >
> > Interesting.  I really don't know how cache_tree works...but if we
> > avoided calling call_unpack_fn, and thus left the original index entry
> > in place instead of replacing it with an equal one, would that as a
> > side effect speed up the cache_tree_valid/cache_tree_update calls for
> > us?  Or is there still work here?
>
> Naah. Notice that we don't care at all about the source's cache-tree
> when we update o->result one (and we never ever do anything about
> o->result's cache-tree during the merge). Whether you invalidate or
> not, o->result's cache-tree is always empty and you still have to
> recreate all cache-tree in o->result. You essentially play full cost
> of "git write-tree" here if I'm not mistaken.

Oh...perhaps that answers my question above.  So we have to call
add_index_entry() for the side effect of populating the new
cache_tree?
