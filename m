Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6536A1F462
	for <e@80x24.org>; Tue, 28 May 2019 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfE1UyD (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:54:03 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38147 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfE1UyD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:54:03 -0400
Received: by mail-io1-f54.google.com with SMTP id x24so16969527ion.5
        for <git@vger.kernel.org>; Tue, 28 May 2019 13:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2melK0LmtA+mKSOSUAUHOVpQt1MjpFBJkBPZRba8Lbo=;
        b=Ajc+ydbCKdzrNqB4w+qi6Cx9KBBKWCRTjpuXFEM0j/m+iUFzuoD7OzJvO8l4t3hOwt
         6kgSsygPXb3EPUHbjox40V2b+PWq+X3cPfOYJdg6DZ2M9mlJ4CRCprRrT8vuluNK/Xj0
         LNIeB2KMTHgumHo6bIXXRoCFifRuUrqALNEwZeO5YHSloqzOVlt7KmppBX0dU6h0h5Hc
         6WzmYh079cCm193AIBIygXoysvHzOvgWi7GI7l97FqqL5R6pog2BRatjlGF6LEnWGzVu
         ojhtt1a/tOsHPrVA0aPIkUXGRk8u4q8Fllj4TMAXIBXKauD8704Esq5zkXv7Jwdpm8wd
         /7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2melK0LmtA+mKSOSUAUHOVpQt1MjpFBJkBPZRba8Lbo=;
        b=E1cty7NivkbKq4jH6JZAhXsBWeA383meR2IkH0SC2TgP3ah6htMHTN2LTI5LWV1bnW
         a8jlbigDRh4SiXpIyhrMVMaQKf9BWP5iQT0aCnCjQrxSk9Iu9PzvrHEs1qTyCv1r9Mrw
         +ttbgYVc6kcnDkrQhx1DC9eFBC7X9x7Rg0g5je8a2E6ovbOzJ0Tc1fzh6ef+rBM0+NWz
         SrTfbtZu0jJeDHhoPueWeHcorRI8RFEkrIvcmJrnNlTZrAExSMIeYVwLgxK7wzVRBwLU
         OpjT8mF1pTLpr2Ti5COalq+/luXm7W0jKCt/fOMVGyLXa02Wi9yaURypMI+XsJzVIKR2
         oKfg==
X-Gm-Message-State: APjAAAXB547enfxlQ/Jj3DnpAwVT0uvNxTc3CASyIVSjbqMGqJ1MAayT
        t5SGlwvcsOEGztzVapRMK1rLEo3n/VuNht2qM/5nc+wh
X-Google-Smtp-Source: APXvYqzixWs0Q+rZ4J+AEMJvXQ/bBnrX9cWZm/86uIH2JrQ7ziAPEFi9rIExJOwlWFiTjcfILPSV5FPJlSkzNsM8uxU=
X-Received: by 2002:a5d:87ce:: with SMTP id q14mr2575027ios.1.1559076842446;
 Tue, 28 May 2019 13:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkfZL2p8yFr3ecsQ63HzeZ+u-Jukf7YcYHk_8iBaKcA4WbEfg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905272046250.47@tvgsbejvaqbjf.bet> <20190528063451.GG7946@sigill.intra.peff.net>
 <CAKkfZL30QuBM6vT69OSS_keNuGi1U-bJ+jDiyDfhZmnr9L9xvA@mail.gmail.com> <20190528204051.GA24650@sigill.intra.peff.net>
In-Reply-To: <20190528204051.GA24650@sigill.intra.peff.net>
From:   Brendan Boerner <bboerner.biz@gmail.com>
Date:   Tue, 28 May 2019 15:53:51 -0500
Message-ID: <CAKkfZL3ZNgNFzxrYbjbhCF5BR12vQPy2sNuYdxmQgmuG+mo9Gw@mail.gmail.com>
Subject: Re: 'git stash list' => Segmentation fault
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Jeff,

Lot of good tips for debugging for me to work on - I'll work on that.

Both to avoid spamming the list and if sending large files e.g. strace
is it ok if I continue correspondence with you directly? (And
Johannes?)

Thanks!
Brendan

On Tue, May 28, 2019 at 3:40 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, May 28, 2019 at 02:56:13PM -0500, Brendan Boerner wrote:
>
> > Unfortunately not a lot in the stack trace.
> > [...]
> > (gdb) bt
> > #0  0x00007fd321805fdf in ?? ()
> > #1  0x0000000000000000 in ?? ()
>
> I'll say. :)
>
> I'd suspect either:
>
>   1. Your git isn't built with debugging symbols. Is it possible to
>      build from source? The default CFLAGS if you just run "make" should
>      be enough, then you can run it straight out of the build directory
>      as "$YOUR_BUILD_DIR/bin-wrappers/git".
>
>   2. It's not the main git binary that's segfaulting. Most commands are
>      built-ins of that binary these days, but a few are not. We should
>      be able to figure out which command is having a problem from the
>      trace output, but...
>
> > 14:52:22.633448 run-command.c:643       trace: run_command: git-stash list
> > Segmentation fault (core dumped)
> > Segmentation fault (core dumped)
> > Segmentation fault (core dumped)
>
> I'd have expected to see more sub-commands here. And it's weird that
> there are _three_ segfaults. Which version of Git is this? In the
> upcoming release stash is written in C, but from the trace output it
> looks like this is the old shell-script version (which is what I was
> assuming, but I just want to double check).
>
> Is it possible that your shell is segfaulting? Does "gdb /bin/sh core"
> reveal anything more useful (a long shot, I know; it probably doesn't
> have symbols either)?
>
> > Do you need the whole repo or would bits of it suffice e.g. index?
>
> Probably the whole thing. "stash list" wouldn't generally look at
> the index at all. It should just be doing a "git log" on the reflog
> entries found in .git/logs/refs/stash. But...
>
> > 14:52:25.040053 git.c:419               trace: built-in: git log
> > '--format=%gd: %gs' -g --first-parent -m refs/stash --
> > 14:52:26.436274 run-command.c:643       trace: run_command: unset
> > GIT_PAGER_IN_USE; LESS=FRX LV=-c less
> > stash@{0}: On devel: NYFL optimization
> > stash@{1}: On GL285: gl285
>
> We can see that the "log" command actually works! The segfaults seem not
> to derail the command from actually performing its task. So what
> processes are actually segfaulting?
>
> Maybe "strace -o trace.out -f git stash list" would be instructive. You
> should be able to find the segfaulting process in that trace, and then
> can grep for that PID to see what it was doing (especially what command
> was exec'd, and possibly what it was doing right before the segfault).
>
> I can also help picking through the strace output if you're comfortable
> sending it off-list (it's likely to be much too large to send on-list
> anyway).
>
> -Peff
