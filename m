Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C901F453
	for <e@80x24.org>; Tue, 29 Jan 2019 00:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfA2AoN (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 19:44:13 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36053 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfA2AoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 19:44:13 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so15160311ioh.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 16:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cvkPn8EX9+m6iq1GHHPUofgIvRHGOOPcX++T9ds9bTA=;
        b=dDkSs74qbWWN+RmLxUVlSGY4TMA5ZjLWdpjkQMEa+0/WSbP+4KP8uYJhiLuZlqiUuY
         AfLTyD1AYoEPrtfsQCK8An9o5tMqTdHwkJuuBr7Dhae7/2mQdNpEZdJEaCPBjubcSs+H
         JxaChQ2dXiiI0Aobz3csFDk2ZoMfDAcK+Wfa1nifdvImrQiku8fZLykZ5BaKojG59uB4
         oNrHYCFAKfSbQ/eIU5/jvosv+iutRC9eNkq2+DE2/tL2PUCyCx86sbuVllCwL6YEFjV6
         3qHmgcqLsnnrsR9g3WPhrD/pmZhxyoVdwWvc883jiSTEFfeKZ/Zt/y9PGviuAbZ53+Ww
         vdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cvkPn8EX9+m6iq1GHHPUofgIvRHGOOPcX++T9ds9bTA=;
        b=CLCJvKup2d+Q4ONjxCDZWurUgJF1+E/6nPU3DwF8UP3oqjXoxzE/920BV3K7k5hNaX
         EZ/FG9D8iui66KJL4DtWY8v/lrNOhEjQPpUNDNTQB9SR9IUUfHRCbEW0t2lpwVTKApZ/
         xRlZbAYtNBn6ZA9lGFHW6b7oqk1iGxcjz5ii965xw0aFdMd7FAw49mhSrgLW61J1f9dv
         4gCOLHfzVx/tYrFqtvYlIa/CKRrPr56t5MruZ/r/7YzeR5DKazNKYNEh64JeIB62qZru
         LCohPPazeT5TMtZFrcmAgQEjxpfo0fNBGgY5zHMYLmk9bVcu7Y6by6m6Bv9maApKkZjy
         HtGQ==
X-Gm-Message-State: AHQUAuYS4Asdm+OIt0u3rwSIeHwPFS9FewTh52HP6BKxe5dKV4D3YrdC
        YLgLIymZwTOnZ6QM63Pdf5sW90cvGc9LzISrgEA=
X-Google-Smtp-Source: AHgI3IbjzYk9yIThUvIPXWVHvv2NvZMBVg913NhRJ/IPNJQbdZl2kVaXi1siJ41ITHuJ8xukaWCckT3xM8xqZjzCuUM=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr11659211iol.236.1548722652270;
 Mon, 28 Jan 2019 16:44:12 -0800 (PST)
MIME-Version: 1.0
References: <20190128094155.2424-1-pclouds@gmail.com> <20190128143828.GJ6702@szeder.dev>
 <20190128172707.GA3050@sigill.intra.peff.net>
In-Reply-To: <20190128172707.GA3050@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 Jan 2019 07:43:45 +0700
Message-ID: <CACsJy8BXfY+bZKV6Jxa7-3VQyyE6hGrFS7ZAnToFwpGq_o1bpw@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete refs in multiple steps
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 12:27 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 28, 2019 at 03:38:28PM +0100, SZEDER G=C3=A1bor wrote:
>
> > > -   __gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" =
"$sfx")"
> > > +   __gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" =
"$sfx" | __git_collapse_refs "$cur_")"
> > >  }
> >
> > In general I think it would be much better to rely more on 'git
> > for-each-ref' to do the heavy lifting, extending it with new format
> > specifiers/options as necessary.
>
> FWIW, that was my first thought, too.

I was more concerned whether it's a good idea to begin with. But it
sounds like you two both think it's good otherwise would have
objected.

> > '%(refname:rstrip=3D-<N>)' already comes somewhat close to what we woul=
d
> > need for full ref completion (i.e. 'refs/b<TAB>' to complete
> > 'refs/bisec/bad'), we only have to figure out how many "ref path
> > components" to show based on the number of path components in the
> > current word to be completed.  Alas, it won't add the trailing '/' for
> > "ref directories".
>
> I think it also makes it hard to do one thing which (I think) people
> would want: if there is a single deep ref, complete the whole thing.
> E.g., given:
>
>   $ git for-each-ref --refname=3D'%(refname)'
>   refs/heads/foo/bar
>   refs/heads/foo/baz
>   refs/heads/another/deep/one
>
> we'd ideally complete "fo" to "foo/" and "ano" to "another/deep/one",
> rather than making the user tab through each level.

Ah ha, like github sometimes show nested submodule paths. Just one
small modification, when doing "refs/heads/<tab>" I would just show

refs/heads/foo/
refs/heads/another/

not refs/heads/another/deep/one to save space. But when you do
"refs/heads/a<tab>" then you get "refs/heads/another/deep/one"
immediately.

> Doing that requires actually understanding that the refs are in a list,
> and not formatting each one independently. So I kind of wonder if it
> would be easier to simply have a completion mode in for-each-mode.

That also allows more complicated logic. I think sometimes completion
code gets it wrong (I think it's often the case with rev/path
ambiguation, but maybe dwim stuff too). And we already have all this
logic in C.
--=20
Duy
