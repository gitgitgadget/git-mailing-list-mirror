Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68D31F405
	for <e@80x24.org>; Thu, 20 Dec 2018 15:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbeLTPVc (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 10:21:32 -0500
Received: from mail-vs1-f52.google.com ([209.85.217.52]:36656 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbeLTPVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 10:21:31 -0500
Received: by mail-vs1-f52.google.com with SMTP id v205so1304006vsc.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 07:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFcmv0aF14KaWrAJojV5MfLj2QFsgwWYzUQMUnxflCI=;
        b=vIvrpBRqcN9qtecj4+Ko5pEjePVUqN6IScp2okr2pXA8tt+h7m8BKzul4rT6ZTIB9l
         IPirzYrLlSmS31aqx3AkbFV1EbbeAEAMNup8oxgK1TqjO5gOCYgXYD1KFgB/2TWlJKTf
         59ge+ABPhRb9N1esle6ZRCgCTUU1E+e4xAZrgKv2rgCALd6mn0qgrWxbPGmFqRpWa689
         It6HacO5vE+Ai5yyITj07dkPI+qjf2wvIIVmjThILHPtvTdRdnwNRWHnvQtUBxs0VKI0
         sy2CzfBtyncF7mwwdEMFevBGioItPgNkrA47J5jsrNlhAmG6fFnAiEXLccrdO0qSaRPR
         ribw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFcmv0aF14KaWrAJojV5MfLj2QFsgwWYzUQMUnxflCI=;
        b=THwVmJadcRLKeJ3KTqH1bbgza1UH+GltgNImYkSSsztb804kCf3t+yhuaADmZ0+VJ+
         4GSdOGOddW3b71lcyjwEfSNCle7DqWeIdcpgNbe2LoulPcA5GX+p0AcYHw5X/EqMGMSV
         qraplcnjcUuEX47JibH/ufz/+anPWCTSNlBN8IkUDccTir1+t0MuWaXr7k73OnQjrWCT
         86f2PxbfsOrMSeg1U5CBtzuv9aiN+6EpkaQwCv6NlhOCq50j1tyXGVDog2K+5dH+AoNO
         lSyNFYEjCWBwAp4Cj8+5R7JKf3AWDznmYN1podK61hcVo5XDY7bgA20MskqA6/xIABdu
         ZAcQ==
X-Gm-Message-State: AA+aEWY8CuR9CLbxarMlOkWga5RGpbC0+FuZC5KVp0O0wKNxZRu2AJjP
        EwNjpx5bNIQe0wKrETRgDA3SXi3HNdqYCdtL1IaI3w==
X-Google-Smtp-Source: AFSGD/VqAg7efSGbk76cqy6Uf6JO+hICNCjXH9mKqkCDBLbnsdIwP/mHaCAj7t7b379VGrNdFP8RlGjbLDQ57Jznrtk=
X-Received: by 2002:a67:334a:: with SMTP id z71mr12526933vsz.40.1545319289055;
 Thu, 20 Dec 2018 07:21:29 -0800 (PST)
MIME-Version: 1.0
References: <CAGHpTBKyBgPURYfuZgVwnskGSy9L1+3WMrYuPmziQ7VcGDkMcA@mail.gmail.com>
 <20181220151830.GD27361@sigill.intra.peff.net>
In-Reply-To: <20181220151830.GD27361@sigill.intra.peff.net>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Thu, 20 Dec 2018 17:21:14 +0200
Message-ID: <CAGHpTBKoH9aqKKNg9k=mY2_AZymiga5x8+5jNtetVZzzqsCEPg@mail.gmail.com>
Subject: Re: A bug in git-add with GIT_DIR?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 5:18 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Dec 20, 2018 at 10:37:21AM +0200, Orgad Shaneh wrote:
>
> > I played around with t5403-post-checkout-hook, and noticed that its
> > state is not exactly what I'd expect it to be.
> >
> > The test setup is:
> > echo Data for commit0. >a &&
> > echo Data for commit0. >b &&
> > git update-index --add a &&
> > git update-index --add b &&
> > tree0=$(git write-tree) &&
> > commit0=$(echo setup | git commit-tree $tree0) &&
> > git update-ref refs/heads/master $commit0 &&
> > git clone ./. clone1 &&
> > git clone ./. clone2 &&
> > GIT_DIR=clone2/.git git branch new2 &&
> > echo Data for commit1. >clone2/b &&
> > GIT_DIR=clone2/.git git add clone2/b &&
> > GIT_DIR=clone2/.git git commit -m new2
> >
> > Now, the line before the last one executes git add clone2/b with GIT_DIR set.
>
> When GIT_DIR is set but not GIT_WORK_TREE, the current directory is
> taken as the working tree.
>
> So that will find clone2/b (from the current directory, which is a real
> file), and add an index entry with that path "clone2/b" and the sha1 of
> that content.
>
> But when commands are run from inside "clone2", they will naturally
> treat "clone2" as the working tree. And since "clone2/b" does not exist
> inside there, they will say "oops, it looks like this file has been
> deleted".
>
> > I'd expect that to add b inside clone2, but instead it adds an
> > inexistent clone2/clone2/b, and if I stop at this line, then the
> > status shows:
>
> Sort of. It never sees the path "clone2/clone2/b", but the path in the
> index coupled with the working tree being inside clone2 means that it
> would look for such a file.
>
> > On branch master
> > Your branch is up to date with 'origin/master'.
> >
> > Changes to be committed:
> >   (use "git reset HEAD <file>..." to unstage)
> >
> >         new file:   clone2/b
> >
> > Changes not staged for commit:
> >   (use "git add/rm <file>..." to update what will be committed)
> >   (use "git checkout -- <file>..." to discard changes in working directory)
> >
> >         modified:   b
> >         deleted:    clone2/b
> >
> > Is this the intended behavior? It looks like that's not what the test
> > meant to do anyway...
>
> This is the expected behavior if you did "cd clone2 && git status".
> Looking at the test, I don't think it quite meant to do this. It looks
> like it predates "git -C", but for some reason did not want to "cd" in a
> subshell.
>
> I think it would be better written as:
>
>   git -C clone2 add b &&
>   git -C clone2 commit -m new2
>
> or:
>
>   (
>         cd clone2 &&
>         git add b &&
>         git commit -m new2
>   )
>
> And ditto for all of the other uses of $GIT_DIR in that script. E.g.,
> the ones that do:
>
>   GIT_DIR=clone1/.git git checkout master
>
> are likely writing the contents of clone1's master branch to the
> _current_ directory (not the working tree in clone1).
>
> > And if I change it to (cd clone2 && git add b), then the commits look
> > reasonable, but step 6 fails.
>
> You probably just need to update the other calls, too, so they all
> match.
>
> -Peff

Thanks. I'll refactor the tests and post a patch later.

- Orgad
