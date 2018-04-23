Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086751F424
	for <e@80x24.org>; Mon, 23 Apr 2018 04:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeDWE1g (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 00:27:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33942 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDWE1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 00:27:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id a25-v6so16266448qtm.1
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9tFi4GIOha5Uxoi3WhDsqjD/6uDJbiOwrtHle20lrn8=;
        b=NW4VJTjlY3rjHXpOqkEDxNtMlzZhl0+Hvy1Kr6+hPMX1lUdqWQCj+B+8opleBu6/GI
         fzdRGq7hyMUXmdKF4Z4Y8q1uMJB1UZiiCmnC/lGsTOphmEiXVlMPJD4dXMnXtjbDl2Lv
         IwmmZKr+/Dkox1RSzKpa4ctTuWQHQkk02c/kOeodFV/GjtKugtZI5dgV4aOQsZQaityx
         jNKduCvpC2SileBjpX0QCK+sU1Nsc1fVHH6tvPiaWJ6VXJXaY5ur7oyxjzJF/1Rc2ull
         EnosIbXp9vgNfhIy965Hf/Rq/aF1AItUb6jtZWGqEuCzCAOdnMY7fggBtxgs/SLIWrol
         gHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9tFi4GIOha5Uxoi3WhDsqjD/6uDJbiOwrtHle20lrn8=;
        b=FyTjFOwRUJDlwWrwA4sn8hJ1zdNQVG7FQ+3kBTF1dQPfdxrRJSIPjLOMVFG7YMiC36
         t12OUZRIKcWyXlTJ9aXIqoEAw1Ifso//LKWXE6rgqZSNwtxCTP/Fk7Ru+CkZdRf57qbV
         AU8td6CFnpxLYV7tcCCNVugkRue4KyOHjEpuHRQEd+LnI4OubwZKIC2EospP648axIKL
         d7KrNqH6NCRiCC50zmfCyb4RR7G/fRAQQwm8LF2AeaQjkb001yGemyUZt/sXWWRCOaRv
         MQqs2FaAVnia4H8BrLD5MpCr1GuS8O6+gFtxcar8jI3FdycfEZ/sfBaiWWECX8HYeyVm
         72gQ==
X-Gm-Message-State: ALQs6tCvFq84YxrdzrMbcM8i9/Rgztwo5rtdLXgHCjEHG4cmzS4gKpEm
        HamO2YPyMsaSCjB0wjlaOCMYGZs8muUX7UYmxUYPvw==
X-Google-Smtp-Source: AB8JxZomviFDGpIG6bH3q0aBjnxEqOFMS3C0sTan/bk5p9Qc9nw6OL4JKyymlZ30LnIUwq/JAtzYOriaNYxYgRQ73uM=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr8359079qti.35.1524457655210;
 Sun, 22 Apr 2018 21:27:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 21:27:34 -0700 (PDT)
In-Reply-To: <20180415202917.4360-3-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com> <20180415202917.4360-1-t.gummerer@gmail.com>
 <20180415202917.4360-3-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 00:27:34 -0400
X-Google-Sender-Auth: n6xfoaBX7apwBgN5Mvl8Paj86nU
Message-ID: <CAPig+cQSgY3yqYtZwTCY7Mq1e66WczbV3vM7=KsKH4b7peDw+Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 4:29 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Currently 'git worktree add' produces output like the following:
>
>     Preparing ../foo (identifier foo)
>     HEAD is now at 26da330922 <title>
> [...]
> Instead of this message, print a message that gives the user a bit more
> detail of what exactly 'git worktree' is doing.  There are various dwim
> modes which are perform some magic under the hood, which should be
> helpful to users.  Just from the output of the command it is not always
> visible to users what exactly has happened.
>
> Help the users a bit more by modifying the "Preparing ..." message and
> adding some additional information of what 'git worktree add' did under
> the hood, while not displaying the identifier anymore.
>
> Currently this ends up in three different cases:
>
>   - 'git worktree add -b ...' or 'git worktree add <path>' [...]
>
>   - 'git worktree add -B ...', which may either create a new branch if
>     the branch with the given name does not exist yet, or resets an
>     existing branch to the current HEAD, or the commit-ish given.
>     Depending on which action is taken, we'll end up with the following
>     output:
>
>       Preparing worktree (resetting branch 'next' (was at caa68db14))
>       HEAD is now at 26da330922 <title>

The (...) embedded inside another (...) is ugly and hard to read.
Better perhaps:

    Preparing worktree (resetting branch 'next'; was at caa68db14)

Not necessarily worth a re-roll. It would be nice to see this series
land; perhaps this can be tweaked later.

>     or:
>
>       Preparing worktree (new branch '<branch>')
>       HEAD is now at 26da330922 <title>
>
>   - 'git worktree add --detach' or 'git worktree add <path> <branch>',
>     both of which create a new worktree with a detached HEAD, for which
>     we will print the following output:
>
>       Preparing worktree (detached HEAD 26da330922)
>       HEAD is now at 26da330922 <title>

This is inaccurate, isn't it? Certainly, specifying something like
"origin/floop" for <branch> ends up detached:

    % git worktree add w1 origin/floop
    ...
    % git worktree list
    /proj     fe0a9eaf31 [master]
    /proj/w1  b46fe60e1d (detached HEAD)

but specifying an existing local branch (say "wip") does not end up detached:

    % git worktree add w2 wip
    ...
    % git worktree list
    /proj     fe0a9eaf31 [master]
    /proj/w1  b46fe60e1d (detached HEAD)
    /proj/w2  820ed2a513 [wip]

> Additionally currently the "Preparing ..." line is printed to stderr,
> while the "HEAD is now at ..." line is printed to stdout by 'git reset
> --hard', which is used internally by 'git worktree add'.  Fix this
> inconsistency by printing the "Preparing ..." message to stdout as
> well.  As "Preparing ..." is not an error, stdout also seems like the
> more appropriate output stream.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
