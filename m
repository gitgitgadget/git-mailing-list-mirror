Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C964C8301C
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E354822265
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PHBz8dgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKPL5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:57:16 -0500
Received: from mout.gmx.net ([212.227.15.19]:34503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgKPL5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 06:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605527827;
        bh=O/87KwgmwcXKn9HpeXE1TC4Ggf+LXy5uv8EpsjLjFwQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PHBz8dgmIeB0EruL0xcGCyJdsIpkB6dG2jyYCjsh4RA/q6Qds+8fr3puIGKpjvj9u
         A1DsXnlImqfpdUOFhfa5KgThtkeked1T9YVwpMu46YdCd/L6DnsJwv5hRqhskfCE6D
         hsfp642/AdN0ABgGEmLIeAw+C8ylBStDDppYZIxM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1keM9A1Phz-000xSE; Mon, 16
 Nov 2020 12:57:07 +0100
Date:   Mon, 16 Nov 2020 00:40:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 00/11] Fix color handling in git add -i
In-Reply-To: <20201112184026.GB701197@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011160036100.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <20201111184527.GD9902@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2011121504110.18437@tvgsbejvaqbjf.bet>
 <20201112184026.GB701197@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1833663111-1605483634=:18437"
X-Provags-ID: V03:K1:WClLO3ewcE04lXNemZbT2yWQyhcszXIlEt07G3EEHhXqMSZrTgN
 xxYD/He6qEiDVJm9fM8M1q9c+DwMkea6n2hsHaRTtLywgt8qumzdtJimM2mrjXneScDTP0W
 voRnPbdzJMarUE492dXkVKJHL6eW8fcuWN6lNiuB4vRet31URC/Ua0PXlwHJ+7pQJnMiFqq
 MMmBbrYDhfHuZX2V8jnyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eIr5WVt+FfU=:PrHGwnSA5R0Jj/6JQPtOEy
 yJfMbXcJJFdnwFRN5nUuffuA3yH1ZnHVMPBVaEnXhALuwsXnRNYZuntZSmOeagCd3lT9fymvm
 tx+DBZ9pMjFwTFHieStLztCro/dfyGX0ZcW3/OyfpVDgwMt/OD+prdXn2RCQM2tc/tni2NbSy
 FzRcEBcTzMSh4LBUJxJpmq5oneR5efMCDWM7wpOzFwuh0f0N/mimS0DlwfdpbPf+FjyGOE+P0
 FJVPXf3l45L62SKKZkAVPu0t4lLRKGhvFJY0N2Up1br2tEdPceGMr1WXoiGJPuT4rWb1GsQzf
 LNnu4QMchg8jshwKOPF8i6rJj/TQq/IwoZNuS4ZiDDvgeuBTQci2pSUrN1kHpVtZICFg8xZtg
 QhlSfmCHNlbVL0pzL3r+K/nuKssu44hS5z7bapa7hCuA+2wCS9fnCmT81hMFKfdWvums1gk8T
 y4h3T8ZNQ8JvO+jhj729UtXnZqEvqc4a7mKAVrkonUjz97wzCckmrr6sBmQdojz0KKLYwbkiz
 0TGWKf3zYcJnPA8Y958Ob4y+FLslMUAYqi0n88/MgsXiR42P1iBSWV803RnDnGi3QeztciNfZ
 som0fmRKS7mGWYkXEmUs3kjyzkkqxX9FwC4G/pa75jOZXR05JLJTYpGfjxdFrsHpSVDSJ1Gr/
 RtglIrW8+zRHIm2KwgHekdQokzBNUgMWsovpqpdMWYCQlACjg9srRH9aOUBKdhy3Z+KomgvE4
 BHzvNXe104WfJdNViR4wBPfG/OBxwjvqFdfrR2fauF0Va+vgCtGoZdMJ8XrC9hMbJLKfDi0tk
 NO9ryYo30fyUdVHGv9y+nfWaj9La23auFw2BKIOzxbRrD29gzwpesrcoVCkXWciz4eX03MUGC
 7bns6QJSgpmVx0R1FmazQAiqOtj3L9sNA0WgR1zQc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1833663111-1605483634=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Thu, 12 Nov 2020, Jeff King wrote:

> On Thu, Nov 12, 2020 at 03:20:38PM +0100, Johannes Schindelin wrote:
>
> > >   $ git -c interactive.difffilter=3D'diff-so-fancy' add -p
> > >   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > >   modified: file
> > >   =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
> > >   @ file:1 @
> > >   old
> > >   new
> > >   (1/1) Stage this hunk [y,n,q,a,d,e,?]?
> >
> > It might _seem_ that it works. But try to split a hunk. I did this wit=
h
> > the test case (interrupting it just before running `add -p`):
>
> Yes, there are definitely problems with how diff-so-fancy represents
> things (because they don't maintain a 1-to-1 correspondence). You should
> generally get a complaint like:
>
>   $ git -c interactive.difffilter=3D'diff-so-fancy' add -p
>   fatal: mismatched output from interactive.diffFilter
>   hint: Your filter must maintain a one-to-one correspondence
>   hint: between its input and output lines.
>
> The diff-so-fancy folks have asked me about this, and I've made clear
> the problem to them, and that the solution is to have a mode which
> maintains the line correspondence. AFAIK there's no fix yet. I don't
> know how many people are actually using it in practice in its current
> buggy state.
>
> There's a big thread here:
>
>   https://github.com/so-fancy/diff-so-fancy/issues/35
>
> I don't really recommend reading the whole thing. Beyond what I just
> said, the interesting bits are:
>
>   - people recommend using the "delta" tool; it has a "--color-only"
>     option which does just diff-highlight-style coloring, but doesn't
>     break line correspondence
>
>   - somebody suggested instead of using interactive.difffilter, to add
>     an option to show each hunk in an individual pager command. So
>     add-interactive would never see the "fancy" version at all, but it
>     would be generated on the fly when the user sees it (and that filter
>     would have to be able to handle seeing individual hunks without the
>     diff header).
>
> All of which is to say that the current state is a bit of a mess, and I
> don't consider it completely necessary to fix it before the builtin
> version becomes the default. But:
>
>   - I think we should expect some possible complaints / bug reports
>     from fringe users of the already-somewhat-broken state
>
>   - IMHO the parsing of the filtered version done by the builtin is
>     going in the wrong direction (see my other mail for an elaboration)

It's a little bit of a surprise that this is the first time I hear about
this.

The way _I_ would go about fixing this is to look for a tell-tale that
we're looking at a `diff-so-fancy` style output, e.g. by looking for that
horizontal line, then adding special code to handle that.

This is not a minor undertaking, and it would currently require _two_
implementations: the Perl version and the built-in version. They would
look _very_ different from one another. Therefore, I would probably either
wait until the Perl version is retired, or selectively only adjust the
built-in version, if _I_ was to implement this.

But given that it does not work right now, and given that it has not been
working for a long time, I think it does not hurt so much if it is left in
the current state for a bit longer. I would love to focus on the patch
series that kicked off this discussion first, getting it done, before I
think about other `add -p` aspects.

Ciao,
Dscho

>
> > > While it may touch on some of the coloring code, it's otherwise
> > > orthogonal to the fixes here. And while the fix is likely to be to m=
ake
> > > render_hunk() stop re-coloring in the non-edit cases, your more-robu=
st
> > > test here will still be checking what you expect (because it really =
is
> > > triggering the edit case, not relying on the extra coloring to see t=
he
> > > effect of in-process color config).
> >
> > I don't actually think that we _can_ stop re-coloring the hunk header =
in
> > the general case because we need to keep this working even for split
> > hunks. It would be a very bad idea to make it work for non-split cases=
 and
> > then something like `die()` only when the hunk is split. Better re-col=
or
> > all of them, then, to not even risk that situation.
>
> Yeah, obviously calling die() in the split case is bad. And the fact
> that newly-created split hunk headers are not filtered the same way as
> the original hunk headers isn't ideal. But it's a pretty easy fix in the
> perl version, and not in the builtin version.
>
> -Peff
>

--8323328-1833663111-1605483634=:18437--
