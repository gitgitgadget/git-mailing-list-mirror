Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B922C4708C
	for <git@archiver.kernel.org>; Sun, 30 May 2021 05:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D8261108
	for <git@archiver.kernel.org>; Sun, 30 May 2021 05:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhE3Fdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 01:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhE3Fdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 01:33:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD35C061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 22:32:10 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j30so7127141ila.5
        for <git@vger.kernel.org>; Sat, 29 May 2021 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lbBTkZGpcgPdovmpcSK1HeLhNwLUZrdJjm+Xv5k248=;
        b=L6VZj4jzhUswMNu+eFpFwZcj4sviHRkTYKRiMt1fYanWJjg8ps0pb6z2Wff31gzgTQ
         VNhetasA8bsXd/fb2d/fVEXFbORttCk7PObZNgrbCgvCKm6cotMuLRwky8S8i5zPwocB
         /7L6Flmk6rRy5jcOYk+84B6FboA0A8rRZoOinGQ1g3ocZI8CZ9uoEc7Q1k/rA99bYaJN
         Lon6c5MdK1SzZpLDcm+7U1yMvo2qoVhdzNCNXbwN5GOlLMuZatsW/3WENDZfSUMTevE+
         sqMknmke7kdttqa0xxHy0UJ3laPPJ8QZyXXKwLoeKRHg+pRXgmwnbXtn9GE9u7aWNW+7
         w2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lbBTkZGpcgPdovmpcSK1HeLhNwLUZrdJjm+Xv5k248=;
        b=avWBAmhUTss6OP1oP/bvGaqliV7GJAQZifhdv+hUUoKZuXvjUole5rcRpRg1IIdD8c
         x/4xJ+P5cis5pqD7mqXHdTQUaUyxl4zwsoJNl9yU3mBIBMlqjHupiH0Bz17Yv49p2XM+
         D/sWimafPpLQZM8Tzh71eKzaUbZqIlrZPFqZS8O6Ucqz6mVXHQVHzSbGAxcpCgX2tjRy
         YbF1uTCHoCaJ4kZO0AszeNK/bwWEJNoo7fJC9T0JxNYaNpU6j5r64eu/p03RbF/XtW08
         yI1lugImkMyq89Cj+pLJyaROLLVBfRYXmk4KXEf41H5HkEA2qnzHTTbChOrQBYegMNRb
         FnEQ==
X-Gm-Message-State: AOAM531jk3ggvWhEZPJTYwWSWcylpkqEjQEwoU+IxB4Zh5i6oh0YE+K6
        6JDZNgKI+67z0gs3Q6Whol8BEXG6EffRM670tLU=
X-Google-Smtp-Source: ABdhPJxF4ZIl6LhKwMNXMdNkwH797gXRi7saFYzmcZfS4ZtZxn5zj5FknXEfWr+BJxuOGUTkJWJ19Lkdu7m6+CD400Q=
X-Received: by 2002:a92:6804:: with SMTP id d4mr13043241ilc.5.1622352729536;
 Sat, 29 May 2021 22:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org> <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <e02cabf0-adb6-49bb-b379-b12f37ca6e1a@iee.email> <20210524150653.Horde.3GnmG8mUdIOZDFHiOKtoxAe@webmail.th-koeln.de>
 <9e6772ba-fee6-7a7f-2ff3-246e82f96ee3@iee.email>
In-Reply-To: <9e6772ba-fee6-7a7f-2ff3-246e82f96ee3@iee.email>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 29 May 2021 22:31:33 -0700
Message-ID: <CAJDDKr4GFcV4MSUP+Ku=B1JjZieKwwwuGgsb8yssc0vg0thFQA@mail.gmail.com>
Subject: Re: fast forward merge overwriting my code
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <pratiy0100@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 11:51 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> adding Pratyush for the Git Gui stash suggestion..
> [...]
> >>> So my Question is: is there any possibility, to be able to view (and
> >>> even edit, if necessary) the changed notebook in the merging process
> >>> (as in my example with the 3way merge)?
> >>
> >> I'm not aware of such a mechanism (as simply described) but I'm sure
> >> there are ways to use the "staging area" view (e.g. via the Git-gui) to
> >> selectively pick out hunks and lines that are staged (and non-selected
> >> hunk/lines stashed) to give a testable worktree during the 'merge'.
> >
> > Ah ok, this could be an idea (it would requiere some more research, as
> > I haven't used the git gui before (I want to learn everything from the
> > scratch using the command line))
>
> I commonly use the Gui when picking apart a large commit into smaller
> ones when I'm happy that there's no overlaps. Small patches make for
> easier merging and fault finding, and better commit messages (good
> thesis practice)
>
> > But to be honest, I think even this approach might already be too
> > cumbersome (as this selectively picking and stashing sounds like a lot
> > of work itself).
>
> Unfortunately the Git Gui doesn't have a menu for stashing remaining
> changes, but it's simple to flip over to the terminal to stash from
> there to do the testing, and un-stash the remainder afterwards - I'll
> maybe suggest the gui could include that capability for these types of
> workflows (cc Pratyush Yadav <pratiy0100@gmail.com>).

Tangential, and doesn't apply in this use case, but I should mention
that Git Cola[1] has had this feature for a while now.

Cola's Stash dialog allows you to do a regular stash and the "keep
index" stash alluded to here. "keep index" retains whatever has
already been staged.

One feature unique to cola is its "stash the index" feature, which
will only stash stuff that you've selectively staged. That's for the
cases where you just want to stash away a small bit, and selectively
choosing the inverse is a lot of work, so instead you can select just
the bits you want to be stashed away and stash 'em.

There's no shame in using a GUI for interactive editing. Cola is
designed to be driven through keyboard interactions so it's easy to
interactively edit the index without having to use a mouse.

Cola also has affordances that can make learning core Git easier
(enable its GIT_COLA_TRACE=1 mode in the environment and it'll print
out every git command it runs).

[1] https://git-cola.github.io/
[1] https://github.com/git-cola/git-cola

cheers,
-- 
David
