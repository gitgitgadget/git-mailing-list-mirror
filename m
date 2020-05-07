Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D54C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019BF20661
	for <git@archiver.kernel.org>; Thu,  7 May 2020 20:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="S1s3bx2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEGUyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 16:54:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:40425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgEGUyY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 16:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588884852;
        bh=u3fM6ozEafNFgMLcQpAi0Z4wFTrTLhji3hN5p8Ac51s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=S1s3bx2MGTM8SxTwdt4jIMftkRJmHMcwR1d8Jx0Hd9K755GLKOST7GCmweoP5WpCP
         lX/f7pNdJtyL4FiwfkvslGClkLheaAHIH5nQ/lfbAWZfWQMyVLdsDcTRSe1xuvF1ix
         0dI76S9tUvQW8Ab8wxziIG4TBmN73Km/XHDpjIYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.213.71]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAONX-1jQzy31Tyt-00BuDJ; Thu, 07
 May 2020 22:54:12 +0200
Date:   Thu, 7 May 2020 22:54:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Konstantin Tokarev <annulen@yandex.ru>
cc:     Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Jeff King <peff@peff.net>, Danh Doan <congdanhqx@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
In-Reply-To: <848941588629532@mail.yandex.ru>
Message-ID: <nycvar.QRO.7.76.6.2005072253000.56@tvgsbejvaqbjf.bet>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>         <xmqqv9lod85m.fsf@gitster.c.googlers.com>         <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>         <xmqq8sikblv2.fsf@gitster.c.googlers.com>         
 <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>         <20200427200852.GC1728884@coredump.intra.peff.net>         <20200427201228.GD1728884@coredump.intra.peff.net>         <20200428135222.GB31366@danh.dev>         <20200428210750.GE4000@coredump.intra.peff.net>
          <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com>         <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet>         <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>         <xmqq4ksyl4mz.fsf@gitster.c.googlers.com>
 <xmqqsgghhr32.fsf@gitster.c.googlers.com> <689741588534833@mail.yandex.ru> <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet> <848941588629532@mail.yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1507455830-1588884854=:56"
X-Provags-ID: V03:K1:4+y4nmuTi2LOY2Q8yeJsAFRwq4UVVHeIfmfBKHYpmCJglZpqC2m
 TKwalNtKI1Ry6Gi7aQ7m06bmd/xZl3jC8i++cd1AlSjeWNM3j2RhRg8RaWJmnvu1nVTT6R5
 zUPwQL9JBPFsnoOOXBqUX+GBGVlAbaPndMBs+LOU/ms4HI45MHqV5UUfjaAzG3pw9xmsEnW
 LIO6i9zxYYmKFAlLbTg4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BUtgKKQjRDI=:1pKB6V3mqM3u+sPJu8q5yf
 Lr6XWY1XF5Ev/D80RmG9N/NxCboUm8YkcvLIHtG7dWlOoujz/xmVhnC9U7dF8KTsKC9nrI3C8
 Vrm7ZruJGICVeZDK2N+r7ZCERYJUutGpEBDociorUuDeUf6lK/OjZmXi0Y237B8K4YvpPZCpj
 eyAM+y+9kB004hj/j5HCgU+1Vsps2KJ6pG0mRPU+gl18CMJ3zTIjRJhmD8I1E3/QAQGG3azlz
 5BGTnrfQh6xvOYKfEsKkNAKgZY54i3H+xZAoZyOUwIbrp0C9GSQ+JXVK86cQcsiEUFAMYXkhs
 kV8KHDbOUq6SaF0zDQTRvDhujSgA87F5GB10e/Rs0NLtcRLRbyjSt8HLByILCv+Z7ELCVwf5t
 Kf19NHJpeRo0hSAPc5aRGKSeqNFp5K66b/YomvuJgVXIoIu/zukOLgcMVDHNEuIKkhmEypkb6
 byQBNppv5QMftGsl7BBRILH7uaOxh9CPWyULQmNt1rfXVN6tv9eQ4v4Ep2pEu8qOOQwe1RIIA
 GGDl85tTOJMdwAi1udatdexqwtTFyes5SneedlYKyCTQPoQMRufu0Ei0r1Jb8gTZPRaTry4eX
 kxxJqZIeFquNWPmtu8EnwnemP7zlL62Ovp0bp0/K0ZpRMKwMLA7XQuD8s8lkQxJxqRI1QcB0u
 NuA16KAwADChnlMMrqgklDKOPHIOyfSRgUtouNheH2w5F0L4I2eAj2hX4FO69ERJQPJJrzOco
 1sX3c84J3G6cvy2emxaaaDJZERSN9Re1vaZoelKcgh3+AV73DAOqtQsqrVA7d7nyUxF3DXTEh
 SHCuYrKInW2qNAku8nBJm3LQHKLvT/7Dj8QR1SEgiukb+U0k4ZJpz6SGwF6j5rLh7eHQJgGQU
 sWB8K78zlnNmnTdVJDUIMZjBbXNsKWLPZWOs0ATaA/LKtdPCASxSkEJF+LbZBtsnSrgArMt89
 tE7IkaIdu6sGBiBjzOu4BYbLcs8ug1kdULH4DIL+2G4FMmZmVf7d63Pw0z/TQFS8HACfKQL5m
 S+HekZtLqfD74zMNDL6smhbI+CUy47lv/o/SRIAfMqlqHELy4cJ8xO+SjIsEHO5YdDvwWdwlQ
 +mdsjBQr69pjHFuRJCmGQdVwlIJf1E9/p5w18bX/Zb1qUC2vQLPHebc94lZtkiofmHmydTLSh
 ld5Tyvchi/fV2w57RdnuCijfWinDC+LJ3HrdOGF+4Ro8m+6IZmN5Ir7ETzF+i37+3584suzcT
 9cW6TqUf1YDWX8Bjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1507455830-1588884854=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Konst,

On Tue, 5 May 2020, Konstantin Tokarev wrote:

> 05.05.2020, 00:32, "Johannes Schindelin" <johannes.schindelin@gmx.de>:
> > Hi Konst,
> >
> > On Sun, 3 May 2020, Konstantin Tokarev wrote:
> >
> >> =C2=A003.05.2020, 20:21, "Junio C Hamano" <gitster@pobox.com>:
> >> =C2=A0> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
> >> =C2=A0>
> >> =C2=A0>>> =C2=A0As you say, an extra instruction in INSTALL file to t=
ell users to
> >> =C2=A0>>> =C2=A0copy from contrib/cmake may workable, though it is un=
satisfactory.
> >> =C2=A0>>> =C2=A0But the other one will not simply work. If we need to=
 have a new
> >> =C2=A0>>> =C2=A0file with string "CMake" in its name at the top-level=
 *anyway*, we
> >> =C2=A0>>> =C2=A0should have the real thing to reduce one step from th=
ose who want to
> >> =C2=A0>>> =C2=A0use it. Those who do not want to see "CMake" at the t=
oplevel are
> >> =C2=A0>>> =C2=A0already harmed either way, if is a dummy or if it is =
the real thing.
> >> =C2=A0>>
> >> =C2=A0>> =C2=A0In your opinion, what would be the best way to communi=
cate with users, there is
> >> =C2=A0>> =C2=A0an optional CMake build system for git?
> >> =C2=A0>
> >> =C2=A0> You do not want to hear my opinion, as my priorities would be
> >> =C2=A0> different from yours ;-)
> >> =C2=A0>
> >> =C2=A0> Given that we all agreed that the only reason we contemplate =
use of
> >> =C2=A0> CMake in our project is strictly to help Windows build, i.e. =
due to
> >> =C2=A0> the same reason why we have contrib/buildsystems/, it is not =
one of
> >> =C2=A0> my goals to communicate with general users about optional CMa=
ke
> >> =C2=A0> support in the first place. It has lower priority than keepin=
g the
> >> =C2=A0> project tree and the project history less cluttered.
> >> =C2=A0>
> >> =C2=A0> So my first preference would be an instruction somewhere in i=
nstall
> >> =C2=A0> or readme that tells those who want to build for windows to c=
opy
> >> =C2=A0> from (or perhaps update cmake to offer the "-f" option and te=
ll it
> >> =C2=A0> to read from) contrib/cmake/CMakeLists.txt to the toplevel be=
fore
> >> =C2=A0> doing anything [*1*].
> >>
> >> =C2=A0FWIW, CMakeLists.txt doesn't have to be in the root of source t=
ree in
> >> =C2=A0order to work. It can perfectly work from contrib/cmake after n=
ecessary
> >> =C2=A0changes in relative paths.
> >
> > Would you have an example handy, or a link to an article describing th=
is?
>
> It's so trivial that I'm not sure what such an article would have to des=
cribe.
>
> https://github.com/annulen/cmake-example

It is trivial all right, but I had hoped for a more elegant solution along
the lines of `set_top_level_directory(../..)` or some such. I mistook your
mail for having an elegant version of this, and I was curious.

Ciao,
Johannes

> --
> Regards,
> Konstantin
>
>

--8323328-1507455830-1588884854=:56--
