Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F661F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 16:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfJHQOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 12:14:40 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:45201 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJHQOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 12:14:40 -0400
Received: by mail-vs1-f43.google.com with SMTP id d204so11647520vsc.12
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AS/Ip0m2h5s9umGymoylB46ObxcxspNgfFQzD2Wul2Q=;
        b=It4FDO2wmACK3cd3eRs4UYoQgFYZlb3iNg8rSVsEtCQGl8Ca3mvZOwcBMffgJuo9+y
         vwpYA1vq3jKKxv1oi+Rt/HzzdEfRXdm4h6cOKXF8e6+1OyZ5EMH5cSJzHEjChG+Cm4Mg
         ldKO8GJHvdrjRgl/3Pqui3ax9YHabMEfhTe0tW7atpnIwYc2yPNEWfeAFnuRascJMb3X
         J3I4BHpLboK5vTjwfgDAbexv+DS/w0o6xBCrTdAQxBKC0BLhucuazG8xupkFZP/oTWj8
         nQPCwdwVUb0qDTqsWKP4DAW9iJj4LP7tcWtdDTFF8jvpkqYFqWof534ZFHTf6l6NTX2d
         /ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AS/Ip0m2h5s9umGymoylB46ObxcxspNgfFQzD2Wul2Q=;
        b=rWJRlf5ZaS75nfX7wzacrQntZRjfKexkB34FN8ZDqP2L31bnPZ/D01GDV/gW372QWL
         cyPKy3FeViAlCd9U7uW0Temo9b+hBrSyLHA7yAm7MM06GVHStzd2qsXe5voZqOS+Yo8R
         wHyE9uMPAOTVhG2kxFdqsXz6oB8hT7ggcGbEqrlzs03id+xXk2mAza9PqrmvtvLBopwV
         a+tnsaAgrNbKbKwoHJdQ4My5eDlCY1Nc2ad0xb4dlFRvl5GpXhAv/DycmbaZp5akr31Z
         QJj6dMLAKuH6BSnD+wru6hsKcqKRFvllX1AITpP6S4F5hEC+W8cNh5B80zpnVA+fC8O8
         uGKw==
X-Gm-Message-State: APjAAAWaog3UglT3MarNZzAxEbc75mnjEV7ETEofb17l1cEZdpoQ1DTU
        dCPws3mes82p/p1+K9joKwn88T+zZeAHKuMrJ1JJGd4d0HI=
X-Google-Smtp-Source: APXvYqx0pE8vlVOuXKge8kPfZH5+b+pMA1LrQ9Ebx7umbNwlaaaFTIQlsl4xa6thLuiBJDT53GLr/0vBEjRYymyvSFI=
X-Received: by 2002:a67:e8ca:: with SMTP id y10mr18191052vsn.136.1570551278478;
 Tue, 08 Oct 2019 09:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191008064538.GB30443@raven.inka.de>
In-Reply-To: <20191008064538.GB30443@raven.inka.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Oct 2019 09:14:27 -0700
Message-ID: <CABPp-BE8YmVTS=4UWy5jvxBwr3EOcqzbnpWf2Wc78Kv6YScKgQ@mail.gmail.com>
Subject: Re: Why is "Sparse checkout leaves no entry on working directory" a
 fatal error?
To:     Josef Wolf <jw@raven.inka.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 11:52 PM Josef Wolf <jw@raven.inka.de> wrote:
>
> Hello,
>
> This is a repost, since the original message seems to have been lost somehow.
>
>
> I am trying to add a file to an arbitrary branch without touching the current
> worktree with as little overhead as possible. This should work no matter in
> which state the current worktree is in. And it should not touch the current WT
> in any way.
>
> For this, the sparse-checkout feature in conjuntion with the "shared
> repository" feature seems to be perfect.

I can see the logical progression that a sparse worktree would be less
overhead than a full worktree, and that a bare worktree would be even
better.  But you're still dealing with unnecessary overhead; you don't
need a worktree at all to achieve what you want.

Traditionally, if you wanted to modify another branch without touching
the worktree at all, you would use a combination of hash-object,
mktree, commit-tree, and update-ref.  That would be a better solution
to your problem than trying to approximate it with a sparse checkout.
However, that's at least four invocations of git, and you said as
little overhead as possible, so I'd recommend you use fast-import.

But, since you asked some other questions about sparse checkouts...

> The basic idea goes like this:
>
>
>    TMP=`mktemp -d /var/tmp/test-XXXXXXXXX`
>    GD=$TMP/git
>    WD=$TMP/wd
>
>    git --work-tree $WD --git-dir $GD clone -qns -n . $GD
>    git --work-tree $WD --git-dir $GD config core.sparsecheckout true
>    echo path/of/file/which/I/want/to/create >>$GD/info/sparse-checkout
>
>    git --work-tree $WD --git-dir $GD checkout -b some-branch remotes/origin/some-branch  # !!!
>
>    ( cd $WD
>      mkdir -p path/of/file/which/I/want/to
>      echo huhuh >path/of/file/which/I/want/to/create
>      git --work-tree $WD --git-dir $GD add path/of/file/which/I/want/to/create
>      git --work-tree $WD --git-dir $GD commit
>      git --work-tree $WD --git-dir $GD push
>    )
>
>    rm -rf $TMP
>
>
> Unfortunately, the marked command errors out with
>
>    "error: Sparse checkout leaves no entry on working directory"
>
> and won't create/switch to the branch that is to be modified.
>
> Why is this an error? Since there are no matching files, an empty worktree
> is EXACTLY what I wanted. Why will the "git checkout -b" command error out?

It is very easy to mess up the sparse specifications.  We can't check
for all errors, but a pretty obvious one is when people specify
restrictions that match no path.  We can at least give an error in
that case.  There are times when folks might intentionally specify
paths that don't match anything, but they are quite rare.  The ones I
can think of:

1) When they are doing something exotic where they are just trying to
approximate something else rather than actual use sparse checkouts as
intended.
2) When they've learned about sparse checkouts and just want to test
what things are like in extreme situations.

Case 1 consists of stuff like what you are doing here, for which there
are better solutions, or when I was attempting to simulate the
performance issues microsoft folks were having with a really large
repo and knowing they used sparse checkouts as part of VFS-for-git (I
created a very large index and had no entries checked out at first,
but then ran into these errors, and added one file to the index and
had a sparse specification match it.)

For case 2, people learn that an empty working tree is a too extreme
situation that we'll throw an error at and so they adjust and make
sure to match at least one path.

> Strange enough, I have some repositories at this machine where the
> .git/info/sparse-checkout file contains only non-existing files and git
> happily executes this "git checkout -b XXX remotes/origin/XXX" command leaving
> the working tree totally empty all the time.

I can't reproduce:

$ git config core.sparseCheckout true
$ echo 'non-existent' > .git/info/sparse-checkout
$ git checkout -b next origin/next
error: Sparse checkout leaves no entry on working directory

Can you provide any more details about how you get into this state?

> Someone understands this inconsistent behaviour?

No, but I wouldn't be surprised if there are bugs and edge cases.  I
think I ran into one or two when testing things out, didn't take good
enough notes, and had trouble reproducing later.  The sparse checkout
stuff has been under-tested and not well documented, something Stolee
is trying to fix right now.
