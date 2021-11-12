Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC34AC433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEAF760EFD
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhKLVhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhKLVhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:37:16 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C4C0613F5
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:34:25 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y68so21899035ybe.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/gWl0zGQK5SsLnXepTGowN7Hujqh19FZghbduaEhLo=;
        b=LbUU03ic7KwawsUHniQzptqLiVSoaFwRMWvSmD0wNGjykPtQHuc/dnEEqlpwUY6u1V
         hUIn03oWeUNbq+4xpfJD3owpMNx61l5LO+6qx5VBFeV/p5KtAq4qr1RHhaJsnTn2OLGi
         582Oqzn/P4TH4JRc+dNNfuOUpLZxBlhQovXxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/gWl0zGQK5SsLnXepTGowN7Hujqh19FZghbduaEhLo=;
        b=zIBV4vF+XprwPPiorbdNNjgsrNTipdY5sQzgIxf3iumXQ5UKb8fhL2QwA/hSmPoKo7
         8KBiucsfpYZ+uj8t/n6YaVlx2yJyUWTqcwnLNQa9gF5waztYh/fvZFtNYuN3NVmxBbOq
         NHkFkMSQA39Z6eKWfktSf3Yayua8CvboBkZONN+yUbT0zXveSEgJIFQxGSUU3oydUaWd
         racjyQqcrtRuKIBMfObTQfKKx5tqw0tIGHJbSTvQa1Nf+fj+2wyJP5IJ4Zpl6Zlj3+U5
         sZOZWLtWmskchhRcASS7x47MV5xhkxdb01LQmXMiYFudQKpetiT1J5zEp+ih5CcPmw0N
         iMmQ==
X-Gm-Message-State: AOAM533BdRpxwY8rFLvoSMdIpAQCWeyQirN87bX2or4dTSnHe36WTFEU
        P6sCvN9OMZpLNERPaoGQtY0WiQQs3/65iKlCFHk38w==
X-Google-Smtp-Source: ABdhPJy0mONOPpiUunLw5DEfyiXIwZ8V0VQNQ7bEv/ZDsNgWgE/Yx4ZJQbKAcejdgTcVNSXOjMUohcWkynhqlKUwwpA=
X-Received: by 2002:a25:ae12:: with SMTP id a18mr19453927ybj.412.1636752864418;
 Fri, 12 Nov 2021 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org> <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet>
 <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> <xmqqee7ozyx4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet> <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com>
 <xmqqtughtlb9.fsf@gitster.g>
In-Reply-To: <xmqqtughtlb9.fsf@gitster.g>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 12 Nov 2021 21:33:53 +0000
Message-ID: <CA+kUOa=FBpzy4zNMXY1UZybc+13mwLnXrZRVN5HP+NF3h4PYow@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Nov 2021 at 16:01, Junio C Hamano <gitster@pobox.com> wrote:
>
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> > But yes, the (lack of) speed of running the Git test suite on Cygwin
> > is one of the reasons I run the tests on high-spec Azure VMs rather
> > than my own systems. Unfortunately the Cygwin compatibility layer plus
> > the overheads of NTFS mean things are unlikely to get significantly
> > quicker any time soon, and between WSL and Git for Windows, I expect
> > interest in improving Cygwin's performance is going to continue to
> > wane.
>
> Out of curiosity, are the use cases and user base of Cygwin waning,
> or are there still viable cases where Cygwin is a more preferred
> solution over WSL (the question is not limited to use of Git)?

No formal research here, just impressions as someone who has used
Cygwin for a long time and who hangs out on the Cygwin mailing list:
for a lot of use cases, WSL is at least as good, if not better, than
Cygwin. There are a few areas where Cygwin is still a better solution,
though:

- WSL requires essentially installing an entire operating system. Disk
space is relatively cheap, so that's not nearly the obstacle it used
to be, but it is an obstacle. This is more relevant for people who
want to distribute packaged installers to Windows users: most
non-technical users won't want to get WSL working, but if you've
written code for *nix and don't want to port it manually to Windows,
it's relatively straightforward to compile it using Cygwin and bundle
the cygwin1.dll file with the installer. That'll mostly get your code
working with a user experience that doesn't differ too much from a
fully native Windows application. (This is essentially what Git for
Windows is doing, albeit with an increasingly distant Cygwin fork.)

- There are some functions that Cygwin offers that WSL doesn't. The
key one for me is the ability to access Windows network file shares,
which WSL doesn't support (or at least didn't last time I checked). I
expect some of these gaps will disappear as WSL gets more features,
but I expect some of them are fairly fundamental restrictions: Cygwin
applications can have code specifically to handle the fact that
there's a Windows OS there, so they can -- with care -- interact with
the Windows OS directly to (say) use Windows file access APIs or the
Windows clipboard. WSL applications generally don't have that ability;
if I install something from apt on my Debian WSL installation, it'll
pull exactly the same binary as if I'd installed it on a normal Debian
system. I guess in theory people could write code to detect that
they're running in WSL and handle that specially, in the same way that
it's normally possible to detect and handle when you're running in a
VM versus running on bare metal. I expect that'll be much less common,
though, just as Git has code for handling Cygwin specially but doesn't
have code for handling Linux-within-WSL specially, even though both
could be used to access a Git repository stored in the same Windows
NTFS directory.

I expect some folk who historically have used Cygwin will shift over
to WSL, some will stick with Cygwin, and a small number (as I do) will
use both in parallel for slightly different jobs.

tl;dr IMO both is true: WSL is better than Cygwin for some use cases
so the user base is waning, but Cygwin is still a very viable
preference over WSL for other use cases.
