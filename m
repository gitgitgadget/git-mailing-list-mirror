Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD3C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiHVSsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHVSrx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:47:53 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CE474DD
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:47:30 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id l7so11899392vsc.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=somuoiuB6LTMXm5YVryhiDQ+mvciybXtm0srNp9RInA=;
        b=gbhz2n6KB5qb5pT/LeA94kf1B9RZNqmuQ79I2wIoUPPaWA2IWVvwuVP3/hiWLMh8Nk
         8jiDpMH6VdPjLTz5jpnE4g43/oNt5vvaKxZIpUJnFQSmYQCCjHUSXfsv0GtmDAqyY4Lp
         wnR9g/qyPZHxLJN4D27EQ7MdLj4VonD5oRf8iZ+ud31TPocFqgVsqIs7AGISEJE1ejzI
         gO1489cgUbZBBQKduUWDzqcD+iwPxxjNr87bstXfQcdc9q+K3746NCrgG7Ag5JATguKf
         Dt21e3/rgrq+BBzlq22c9VDxsRk5gNoltp+CWy50PUlAex1D0i0iC+GHyDanDNKwrjHk
         J3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=somuoiuB6LTMXm5YVryhiDQ+mvciybXtm0srNp9RInA=;
        b=uzlRf015Y57EeXdgoA5vI1zRR9Mp8KncvBApXHhn57t3kfdCH0vt4ZrV8OdLq50utt
         Aem7QwCqznN5LpEKcTJswRKP0GHPXxUa9ecKgxsmLuU5hSd4V3b0psl9vhaur9EGDXnS
         7JR+to3oUNGwxc3h5M1y9nR6QL2qJ83GV/pEpkbSYGXksEN8270utxZWNjlTA1kvZ3dG
         dhYXeqUyqdKlsoiqmBDpqJfTBGp0fESyPJ1pvq0BJDzMGZ328ir1oUSjQLLaVtbP6NUS
         0rNVBqeU9RjUv3gVm271waz/bEs8bGkrvK5hotn0xVCwlQgpV1RPVH4kuh6E+xWfX3oO
         GsHw==
X-Gm-Message-State: ACgBeo3sVJyhBAopD7wXyTsWSefv5ohE0OVUef/E7cH11ROizLmCFqWk
        PdacAe/Fey8t1W1gn52niRMxtGCcF2hKSHVtiBtXqJ4rBK1A4Q==
X-Google-Smtp-Source: AA6agR7xK0TrNqzMNUs7XPcOWT3SYZmn2a4eHvNLrxHfBHN60sE72i7N5LqGVn8ei8tsBKgSapp3HPI0BvMwo2t54/0=
X-Received: by 2002:a05:6102:3bd7:b0:390:6de3:785d with SMTP id
 a23-20020a0561023bd700b003906de3785dmr1476837vsv.68.1661194049553; Mon, 22
 Aug 2022 11:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAAsFbAtu0vYhwa-Kb6dfpNBZ7jSLriVODi1s7H=-Deq9J6L0ww@mail.gmail.com>
 <252qppor-o3pp-s13o-q59r-9166478no04r@tzk.qr>
In-Reply-To: <252qppor-o3pp-s13o-q59r-9166478no04r@tzk.qr>
From:   squirrel <jatjasjem@gmail.com>
Date:   Mon, 22 Aug 2022 19:47:02 +0100
Message-ID: <CAAsFbAsD_AwyO1KM2G10Gs8fWzErsXQUx2My2RdfmN6WefU4EA@mail.gmail.com>
Subject: Re: `git range-diff` lists chunks with uninteresting changes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh boy I messed up. There's a mistake in my reproduction example. Sorry!

I was saying that the uninteresting chunks pop if the changes from upstream
appear close to changes in feature branch. To demonstrate the case when they
are not close, I said to add a few lines, `1\n2\n3\n`, to the initial file.
Somehow I managed to include this `1\n2\n3\n` in the main example that was
supposed to demonstrate the issue. The correct, copy-pasteable, example:

    git init
    git branch -m main
    echo -e "a\nb\nc\nd\ne\nf" > file
    git add file
    git commit -am "a b c d e f"
    git checkout -b foo
    echo -e "a\nb\nc\nd\ne\nfoo" > file
    git commit -am "f -> foo"
    git checkout main
    git checkout -b cat
    echo -e "a\nb\ncat\nd\ne\nf" > file
    git commit -am "c -> cat"
    git rebase foo
    git range-diff foo cat@{1} cat

Now if I was to use the command that you give:

    $ git range-diff foo cat@{1} cat
    1:  5b1a2f5 ! 1:  16c4eea c -> cat
        @@ file
         +cat
          d
          e
        - f
        + foo

I think the command and the result are both correct. Indeed the change of
`f` to `foo` is a difference between the two ranges. However, this change
is just not interesting! I hope there's a way to not see it.

Sorry about the mess up.

On Mon, 22 Aug 2022 at 17:02, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi squirrel,
>
> On Sat, 20 Aug 2022, squirrel wrote:
>
> > When someone makes a PR, they may be asked to rebase their feature branch onto
> > main to resolve conflicts. It may be useful to quickly see what changed during
> > the rebase, that is how the new version of PR is different to the old one.
> >
> > If the PR branch has not been reparented, you may get away with `git diff`.
> > But if it has, `git diff` may contain a lot of changes from upstream. Instead,
> > `git range-diff` can be used.
> >
> > The problem with this is that in this case `git range-diff` can show chunks
> > with changes that have nothing to do with changes in the PR. Consider this
> > repository (commands are runnable):
> >
> >     git init
> >     git branch -m main
> >     echo -e "a\nb\nc\nd\ne\n1\n2\n3\nf" > file
> >     git add file
> >     git commit -am "a b c d e f"
> >
> >     git checkout -b foo
> >     echo -e "a\nb\nc\nd\ne\n1\n2\n3\nfoo" > file
> >     git commit -am "f -> foo"
> >
> >     git checkout main
> >     git checkout -b cat
> >     echo -e "a\nb\ncat\nd\ne\n1\n2\n3\nf" > file
> >     git commit -am "c -> cat"
> >
> > We got a few letters of alphabet on separate lines on main, and in branch
> > foo `f` is changed to `foo`, and in branch cat `c` is changed to `cat`.
> >
> >     $ git log --all --graph --pretty=oneline
> >     * 90e873e3 (HEAD -> cat) c -> cat
> >     | * 3d8c1baf (foo) f -> foo
> >     |/
> >     * 4d2337dd (main) a b c d e f
> >
> > Now, still on cat, let's combine the two changes.
> >
> >     $ git rebase foo
> >     Successfully rebased and updated refs/heads/cat
> >
> >     $ git log --all --graph --pretty=oneline
> >     * 98e554a0 (HEAD -> cat) c -> cat
> >     * 3d8c1baf (foo) f -> foo
> >     * 4d2337dd (main) a b c d e f
> >
> > Now, `git rebase foo` worked automatically, so *the change* of the last commit
> > on `cat` is the same as it was without rebase, which is changing `c` to `cat`.
> > But if we run `git range-diff`, we will see this:
> >
> >     $ git range-diff 90e873e3...cat
> >     -:  ------- > 1:  3d8c1ba f -> foo
> >     1:  90e873e ! 2:  98e554a c -> cat
> >         @@ file
> >          +cat
> >           d
> >           e
> >         - f
> >         + foo
> >
> > It seems that this chunk is included for the sole reason that the change from
> > `foo` is sort of close. If we try the same code, but put the lines `c` and `f`
> > further apart, for example by replacing `e\n` with `e\n1\n2\n3\n` in the
> > commands above, the output would be, as expected,
> >
> >     $ git range-diff f1e0a6cc3...cat
> >     -:  ------- > 1:  4db06be f -> foo
> >     1:  f1e0a6c = 2:  cc56db7 c -> cat
> >
> > I suggest not showing uninteresting chunks like that, or perhaps having a
> > command line option that controls how close together the changes must be in
> > order to be included in the output.
>
> In a generic tool like `range-diff`, it is virtually guaranteed that the
> default operation does not satisfy all use cases. This example
> demonstrates that ;-)
>
> In general, the `A...B` form does what users want, namely show you pairs
> between the "left" and the "right" commits in that symmetric range.
>
> However, you _can_ use `range-diff` in a way that it produces what you
> want. In the example you provided above, `git range-diff foo cat@{1} cat`
> should do it. That would be the `<upstream> <before> <after>` form.
>
> In general, you might need to play with `git merge-base --fork-point` (see
> *1* for more information). I could imagine that the following command
> might give you what you want in even more cases:
>
>         git range-diff \
>                 $(git merge-base --fork-point @{u} @{1})..@{1} \
>                 $(git merge-base --fork-point @{u} HEAD)..HEAD
>
> Ciao,
> Johagnnes
>
> Footnote *1*: https://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mode
