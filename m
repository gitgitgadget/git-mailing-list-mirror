Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFEDC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CC960F90
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhKBNzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:55:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:42273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhKBNzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635861176;
        bh=KKyrS1wDOcZy0FMO8MJModcoxJ3t4HKCsuC1S5u0azo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hf6vpDTXspwpbfBgpKiMKlBAfjRnVM9QSTWoYTl9xdNzixNLYAbTPXGLRpsDzLTyW
         /+8nRhG2ByjjdV/poYBUPZlDuvuigg+/jSuGbQKJLuA5u2CtMcfTvh7aXfZ0pPgAW4
         vDpp5Kc4GQvoXyC0etQuBKuDyloA+wUsz8jHqGfY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1nCPeb0xAP-00V6Uk; Tue, 02
 Nov 2021 14:52:56 +0100
Date:   Tue, 2 Nov 2021 14:52:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     git@vger.kernel.org
Subject: Re: scripting speedups [was: [Summit topic] Crazy (and not so crazy)
 ideas]
In-Reply-To: <20211026201448.GA29480@dcvr>
Message-ID: <nycvar.QRO.7.76.6.2111021446140.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet> <20211026201448.GA29480@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1284903661-1635861176=:56"
X-Provags-ID: V03:K1:A2JHO+INeCRa+yS8b85Gv+MVmE+XUKQ2hSqvZAskcl2bTMuBdiK
 /ilOwECEmgvGGVj4cLEM2mzHuemDatO3eT9QT9blOX+Ky3tCMakrHoqY6FxIX4wgzCkqkVK
 Z0z4Ol8Oo/nrFqN7Dlt0wttfMjFIEIwGC/wqLo/34DY3zGAC7YX2Pj4ZYhgwWG7Vg6hO/03
 AFhX79CmHOpZqJCbn5GAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O2Dq+UxPxwI=:h/cUQqv4WrhQTB3f6CevhK
 zWPBkObJlLXDFLnmQuZEU+6nB0sI/boR7Lh42YSwIyV47lntJqZx3Q8RgTC+OqgIh809t6APi
 Eq/hLxHFOTOKkng5tZz3E7xiLEFpBTcgmVoQLL3sYNZV1gChR56+MbHOh/zkxG4hKiUH9+5MG
 UMaw883+pZm4NKHwmseo2ORM4yHbibucnxS7OtGGcC94djgLc9Ktv6g61iLThFxom15dopHGV
 YUXbuoOSdv4dUvHuGIDsdtp1EqSMVw+ZoZzKzAD4UWISquXVieT6fVALDrfDIigkeUscFkrIA
 c/6EK9gYKivdEtAOIzFyZ/74Qe7oEy4arQAAcAxegW8OUvBGc3ZZiXNv50yxa698jJ5bP9x+D
 pJ8gsyz0xQA8nztCC3/XO9yLemrD+luKFPpMnWqwOM3VXSb2APj9ALMqAR+qZ8DLmSLi1YrRa
 OI0sHtmM8QT0AxMuLQNK/KMnKFdSkiia5qHYgtK2HvhJ8hJhNosp2d1Nkmu6nw/FoalYIj7jK
 hQ7RZaIdPTtexH3QsZqu8aZroRrzWpV6Ivdf56yVedbKSejUBRQQZT/uXXi/NkHcekVJ9EUMh
 zWVKYxeWYaKUPpLMT/nSFmFEbBBw37b4dE/1nBQVoqzY/lc+QWPdClXw4c/GDYqSKUn9w1Nh6
 2jRGZtNWECiAHAhUdM7ODECcfU3i+n4JUdUbkhTcAdXPtXKcFxzfzJ7N/5JcT/0N1z/akbP1d
 ik+LiVbd7VX5NzYQVsJJ1tJcM5977wMYL2KJW6/Rpef+it7H/I06oYmnbDOeJv7/xLIZ+JusQ
 /lMpt5QlRufhNYBUT10X7GrXYGSOmbpsp7rxqAG3NFKczrzC6P1PHSP9TE84a340jtbvYor+h
 xUTKudCnwnsQ/6BdyTia2TS4agIyAVbjOTITr4LfJbfqO5uj1dtqsqinFcvGFKXhkl0CQwpdz
 mN+1uqIhYRQmmopn37MxlkglG0/oGfWPc/c2Ntkt2HmCWWEt1A3tn6mfPCo9Bn96xY7HDr/9B
 cUlFYQfymwmaFA+qrMdvkG8zSLREgdMQdzgoz41KWQf6K0A+A23MKaFdwsyp3Tb8m8mWiN18O
 lziuXGWaqHynho=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1284903661-1635861176=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 26 Oct 2021, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > * Test suite is slow. Shell scripts and process forking.
> >
> >    * What if we had a special shell that interpreted the commands in a
> >      single process?
> >
> >    * Even Git commands like rev-parse and hash-object, as long as that=
=E2=80=99s
> >      not the command you=E2=80=99re trying to test
>
> This is something I've wanted in a very long time as a scripter.
> fast-import has been great over the years, as is
> "cat-file --batch(-check)", but there's gaps should be filled
> (preferably without fragile linkage of shared libraries into a
> script process)

The conclusion reached at the Summit seemed to be that we don't want to
get into that rabbit hole. We might very well end up maintaining a
POSIX-compatible shell inside Git. Definitely out of scope.

> >    * Dscho wants to slip in a C-based solution
> >
> >    * Jonathan tan commented: going back to your custom shell for tests
> >      idea, one thing we could do is have a custom command that generat=
es
> >      the repo commits that we want (and that saves process spawns and
> >      might make the tests simpler too)
>
> Perhaps a not-seriously-proposed patch from 2006 could be
> modernized for our now-libified internals:
>
> https://yhbt.net/lore/git/Pine.LNX.4.64.0602232229340.3771@g5.osdl.org/

Thanks for digging that out. I had looked for it multiple times over the
years, but searched using the wrong search terms.

However, as you can see, it went nowhere. Probably the (implicit)
conclusion was the same as above.

> >       * We could replace several =E2=80=9Csetup repo=E2=80=9D steps wi=
th =E2=80=9Cgit fast-import=E2=80=9D
> >         instead.
> >
> >    * Dscho measured: 0.5 sec - 30 sec in setup steps. Can use fast-imp=
ort,
> >      or can make a new format that helps us set up the test scenario
>
> 0.5s - 30s across the whole suite or individual tests?

That was just vague recollection, but it was for setup steps, i.e. the
initial test cases that do not even test Git's functionality but merely
want to set up a repository/worktree for the subsequent test cases to play
with.

> Having a way to disable fsync globally should further improve
> things, especially for people on slower storage.  libeatmydata
> is available, but perhaps not widely available/known.

What was missing from the notes was the crucial fact that I did this on
Windows, i.e. a platform that is pretty darned good at multi-tasking
(something with which Linux has historically struggled a bit), but not so
good at spawning wholesale processes.

So the problem really is that calling, say, `git commit` in a `for
$(test_seq 100)` loop is ridiculously expensive.

Even rewriting those setup test cases to something as verbose as a
`fast-import` stream accelerates them like you wouldn't believe.

I even thought I threw out the idea of implementing a test helper that
could turn the output of `git log --graph --oneline` into a branch
replicating that structure, but it might have gotten lost in the noise.

I doubt that my test suite-centered commentary is very helpful for your
use cases, though.

Ciao,
Dscho

--8323328-1284903661-1635861176=:56--
