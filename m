Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E37ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiH3Orh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiH3Ore (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:47:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72637B514A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661870846;
        bh=taOB8JCgrBjBizR105LlgIuu0+Vi3qPpBqTs+wfTPEg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vvazu0kPiR7uSWSQ0xBg5yS8yqAV5bL2XIHL6s5K8kylbQaJR067GhwRdvqBAYI40
         wOPAHHyyStFpG7OJAXUycGVrx+JDi1NJRIZT+y9saNRElAAtDeerF3/n6cb+HSrHRG
         t5nf6LmjEsodEPa5hypvXfhdN5+O1wLPSv2XWgow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1os6HJ36Yh-00SN02; Tue, 30
 Aug 2022 16:47:26 +0200
Date:   Tue, 30 Aug 2022 16:47:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 11/16] bisect--helper: calling `bisect_state()` without
 an argument is a bug
In-Reply-To: <220829.86sflf2w57.gmgdl@evledraar.gmail.com>
Message-ID: <5594qo11-716s-61qn-2rn9-q114199sp3p0@tzk.qr>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com> <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com> <8a0adfe3867157102e75d53ed928603ad634b904.1661604264.git.gitgitgadget@gmail.com> <220829.86sflf2w57.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1794163750-1661870848=:189"
X-Provags-ID: V03:K1:LnIXYip4HDeroIEoR2WyfcoI8DfkQdGCtG2JMgnqyUYoB9CXJd2
 2UlKfU8kKtsDvMrSSOOqQqnXlJZKeMYb1Ar95SkElPLzp2hykRZGdixyL02Vrqanu59z//5
 HgWnOZvBl1+rzWx33HgMrRARyKQKSf++z5DA2fCy0ttPVZJBZYrLG260moa1s46giIbFuAW
 89wBJMVhj/t/1Y4EBkxcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WlavJGUPDOM=:sfULeRAMhIXGCrTolabMMx
 f6Pp/UMuwLy7DEjkqaR0nuWyP8yOPROw+Ys9e2PuF1pD0SyS8ZAzo5x4ldEUXpm+3yRh+R9zo
 Nq6VGleazkewQjbbEiZB+yYpXjFBwrrgBF5D71q0yTneRkdex1d+VDzhSp2R4aiRStCuLtztP
 GOxN0oMSGityXTR8LcHyD3OjeDRYUoqQ/VT2l5HwETxsbe+I0dSl1TBl6QD4JFAC17w0bDiTR
 fsp76P9CuorfewEWeCKwE/2y66MG1MsqkcvntLuhDi/FdVIqZq9dGzf5biTBAdyPiVTJkYdsY
 3gjITd+RYMbq7tsQ7NshRm1PhEQBMbCPngTZUjMVxtzCDrowoM+f+nuKWXzUNOwJ8i+StPJdL
 Shrxwi/pMCiBpJIntXLDji7hvT2H14TEJxDwuHBU8eKcq8w7WV8zq3gi6DRdOIVqmUlVbYJrZ
 YN5JA0zGrfGg48U+MRm4fy7mbO8R3tjZerSWjGzXcfOuqbtl8DzQOHjM6R5uqC4BDJFEsP6aV
 PJY1j5qIqes955vIXixY3qccCp3IWGdR9HZpnYmOiM8WWJE+qbLupl1p1ZzqIoY3WiYbOOKDQ
 0/RjFCocqhzBiemnXXDra0PnfjSBOXzYb/6I4vIuG91eLGrYIBt73cHfrgaHROMACMZ6tqwTb
 4BB0Onv9EB80ALP+FwaQnGdjM9GMCGLTtIXbzI0KpAJHWfAZbtIJftYMGWgRpjDKntQNnfNek
 Nx/3HtLBi9hdkwpNjle4W3QH1Lt4GK13jq/cgFpmZeOI9Ols3rw7Ei82MjgkDEPXhcgzEcVC9
 f4q9SeE1JM6Weew/SkJs20Kkg6yLG9mbZ5CFOBPutMNXlIzUdDhO0AifkIIgjajDGq6g3KF49
 zlcw2X+3PqSfGn0W7HZH0KCtrGEOX1kPl9hwuWOT+ukovNyNppqB2WoZAoXyX/lHhPu88PNDD
 Mav23x12UtN+3qkDCECv3I/M2wZgsbaH3nTHPN7LBL0H2xFFFwNjdaVPmM3jaGs7x4BcftwbM
 hPa9JnSIBYxVf1WHrjmN+1KQOeVBOVqYymCoG1UqD1gTVLHNXjOSzP8HEOC91IdlZ+1z3YPrB
 gy7a4jZR6Vtsg5PKK6mg3oA7VlAtWWixYW3paUp5DA1NPJ5EcnXNwtipbqIaq5d6QC56qrdFJ
 gs9WbGURBc0tmzWOxF++Jg3++0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1794163750-1661870848=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 29 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Sat, Aug 27 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `bisect_state()` function is now a purely internal function and mu=
st
> > be called with a valid state, everything else is a bug.
>
> I'm confused by the "is now purely an internal", when did that happen
> exactly? That wording is new in this v5.

Yes, it is new. It is part of that huge amount of work to not only convert
the script to a built-in but also "while at it" migrate the entire
`bisect--helper` on top of the subcommand API, as you specifically asked
for, and it was that ask that blocked the patch series which would
probably otherwise have been accepted as-is, with the subcommand migration
left as a follow-up patch series with a much narrower scope than the
current iteration.

As to when it happened exactly? In 07/16 of this patch series iteration,
as explained as part of the commit message:

	Note that a couple of `bisect_*()` functions are not converted into
	`cmd_bisect_*()` functions directly, as they have callers other than the
	`OPT_SUBCOMMAND()` one (and the original functions did not expect
	a subcommand name to be passed as `argv[0]`, unlike the convention for
	the `cmd_*()` functions. In those cases, we introduce wrapper functions
	`cmd_*()` that also call the original function.

I did not repeat in the commit message all details that the diff explains
much more eloquently, such as `cmd_bisect_state()` now being a wrapper
around `bisect_state()`.

> Before this series wasn't the only caller "internal" (git-bisect.sh) as
> well? From the CL:
>
>      -    bisect--helper: using `--bisect-state` without an argument is =
a bug
>      +    bisect--helper: calling `bisect_state()` without an argument i=
s a bug
>
>      -    The `bisect--helper` command is not expected to be used direct=
ly by the
>      -    user. Therefore, it is a bug if it receives no argument to the
>      -    `--bisect-state` command mode, not a user error. Which means t=
hat we
>      -    need to call `BUG()` instead of `die()`.
>      +    The `bisect_state()` function is now a purely internal functio=
n and must
>      +    be called with a valid state, everything else is a bug.
>
> Before the migration to OPT_SUBCOMMAND earlier in this series:
>
> 	$ ./git bisect--helper state
> 	usage: git bisect--helper --bisect-reset [<commit>]
> 	   or: git bisect--helper --bisect-terms [--term-good | --term-old | --=
term-bad | --term-new]
> 	   or: git bisect--helper --bisect-start [--term-{new,bad}=3D<term> --t=
erm-{old,good}=3D<term>] [--no-checkout] [--first-parent] [<bad> [<good>..=
.]] [--] [<paths>...]
> 	   or: git bisect--helper --bisect-next
> 	   or: git bisect--helper --bisect-state (bad|new) [<rev>]
> 	   or: git bisect--helper --bisect-state (good|old) [<rev>...]
> 	   or: git bisect--helper --bisect-replay <filename>
> 	   or: git bisect--helper --bisect-skip [(<rev>|<range>)...]
> 	   or: git bisect--helper --bisect-visualize
> 	   or: git bisect--helper --bisect-run <cmd>...
>
> 	    --bisect-reset        reset the bisection state
> 	    --bisect-terms        print out the bisect terms
> 	    --bisect-start        start the bisect session
> 	    --bisect-next         find the next bisection commit
> 	    --bisect-state        mark the state of ref (or refs)
> 	    --bisect-log          list the bisection steps so far
> 	    --bisect-replay       replay the bisection process from the given f=
ile
> 	    --bisect-skip         skip some commits for checkout
> 	    --bisect-visualize    visualize the bisection
> 	    --bisect-run          use <cmd>... to automatically bisect
>
> After that:
>
> 	$ ./git bisect--helper state
> 	fatal: need at least one argument
>
> 	usage: git bisect (good|bad) [<rev>...]
>
> So intra-series we were showing the wrong SYNOPSIS for this
> internal-only command. I don't think that matters per-se (and the
> end-state fixes it up), but doesn't it point to some ordering oddity
> here?
>
> AFAICT we couldn't call "state" without an argument from git-bisect.sh
> before, and that's the only (and internal) caller, so shouldn't this
> BUG() come earlier?

Yes, it could come earlier. Or later. It is part of some follow-up patches
that need to come after 07/16, in whatever order.

I appreciate that you want to help.

My concern is that by having to focus on answering such questions that I
consider a thorough review of the iteration to answer handily, I cannot
spend the same time and focus on preventing bugs I consider a lot more
critical. We saw some bug reports about the built-in `add -i` recently,
for example, that could have been prevented if the focus of the code
review was not so much on details that the end user won't ever see (such
as the order of patches or whether to broaden the scope and size of a
patch series instead of leaving follow-up work to subsequent patch
series), and more on unintentional changes that the users very much
experience, and not in a good way. I would appreciate it a lot if we could
focus first and foremost on preventing bugs cause problems to Git's users.

Thank you,
Johannes

--8323328-1794163750-1661870848=:189--
