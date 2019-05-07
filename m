Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6C141F45F
	for <e@80x24.org>; Tue,  7 May 2019 10:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEGKhX (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 06:37:23 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34874 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfEGKhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 06:37:23 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so24924044itb.0
        for <git@vger.kernel.org>; Tue, 07 May 2019 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpDeQdpqQEf5POncCxIkYJej0iPeRcZYFQX1GJrHsh0=;
        b=cUngAVfL0a7BJxDBQkk73qKwdBagnHRqJUX1mmrNVIlljydN8dN5J9iU+xFnqzU6wl
         5QR2gZSgkb4042YH7luehfo78ttHA+WyHRTU2M5F8QBAK0mdLefx0PKhfhkocDZZJC3U
         PntRVO+IFxVMPiqr9Z1ueaBpQIew8ha8S5Ncy6M0ZLQC6G99I9VRIGUJg5y7tcSNhow/
         ehmf84rRTwukairoXX2D8pRCYGXQbVxQEt74V/nRz+Wa37TsvyeDC7FOUeb2vGJYrNEk
         HRppj0eosFgh8o+QSYzpmUmyu80XckNYEttGsu3Hz2XtQv42wc1gcMFG101n/xTKBMoQ
         jPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpDeQdpqQEf5POncCxIkYJej0iPeRcZYFQX1GJrHsh0=;
        b=DUiQXfIeFF2EXxpM3E/rFBJSv0r1wHuZpq0rTg/vEniCou9gvBjjwxN9jyHx0V75B1
         u72vjfyCZPTXB339RmfmP7Exhc5M4HRG+NSDPsSsaUEDFluMLeVYiQrrzV4qlB3LnZvd
         jjZo1C8idB9Agpd/eEIzEvHngxTcWMRJtCu2uDlMBOdOTFtp7KnXxw+tXushGBzwT2MJ
         PlbF88ZcYfqNRCebDF79LeTB1ls/nI6QUCh4hZb/4yxUaoaUKNweMv5ewSndMzeS64qj
         T6i6aBjUoMWP4X+d+C5BVxCh+HOeDkbfwqkZS2Sd+/K1gZnJLB0OjZSn1WAsAZBDmiHN
         +YKA==
X-Gm-Message-State: APjAAAV9AC9JyzHyKdAnNi5BIRoFGHFtea9v0KTGgxwqekpRm+tYOiea
        5LV27wyQ2m6nKjbm0zFCVd0yMO+AAmiYZu9Y2BI=
X-Google-Smtp-Source: APXvYqx8HBidvAT5f5NUMWxbFgxRdW3L6kNFMe2H6ikJBbGBtZf42VI3kE8Cgt+NpvgjcJhNZY6G0BM8KayNOQaKQew=
X-Received: by 2002:a05:660c:34e:: with SMTP id b14mr1112550itl.10.1557225442619;
 Tue, 07 May 2019 03:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190411131218.19195-1-pclouds@gmail.com> <20190425094600.15673-1-pclouds@gmail.com>
 <20190507022127.GA220818@google.com>
In-Reply-To: <20190507022127.GA220818@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 7 May 2019 17:36:56 +0700
Message-ID: <CACsJy8DSVJuwNWfEcA1pv1vdoCn=EKTmhBncRtKLZedQiEj0AA@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Add new command 'restore'
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 9:21 AM Emily Shaffer <emilyshaffer@google.com> wrote:
> I've got a usability comment, as we're giving restore a try within
> Google for now.

Thanks. I thought I was the only guinea pig :D and obviously not a
good one since I know too much (which is not a good thing as a
tester).

> I found myself in a situation where I had accidentally
> staged all my changes to tracked files (I think resulting from a stash
> pop which generated a merge conflict?) and didn't see a good way to
> unstage everything using restore.
>
> I tried out `git restore --staged *` and it tried to restore every build
> artifact in my working tree, all of which should be ignored, made a lot of
> noisy errors, and left me with my changes still staged.

For the record, "git restore --staged :/" should do the trick and it
is documented as an example (but without --staged).

Either way. I think you raise a good point about "*" (or patterns
matching more than expected in general). I need to sleep on it and see
if the old way of handling pattern matching failure is still a good
way to go.

> Finally explicitly naming each file which I needed to restore worked,
> but I have very little interest in doing this for more than a handful of
> files, especially since the output of `git status` is not easy to paste
> into the command line (due to the "modified:" etc marker).

For just a couple files, you could also use "-p" to go through them
and either "a" to restore all or "d" to skip the file. Maybe adding
"-i/--interactive" to git-restore too, just like "git add". Hmm...
-- 
Duyh
