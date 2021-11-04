Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B41AC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFFA611C7
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 00:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhKDAf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 20:35:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:54715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232957AbhKDAfR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 20:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635985924;
        bh=ui+L82fgBS4n7XvgN1PTo4kR47+UdyMQIJHy2+HLZsU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VYE7R8hEUvfdyUhxZZq2kgBemxLaST/mTeT8ZooP+O2PJ7SJQMk1etxC1LIKQUqbZ
         b+10gVdgt1KT04TuE1D4fDAeo4182CAJ1ZYI569wJkOz7qmgh7PZz+EU4puQudG4X1
         gZSFTfO3McE9tbqSVQHnkI0smzBxP3wk9fvXstIU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1n98lv2daZ-00SM29; Thu, 04
 Nov 2021 01:32:04 +0100
Date:   Thu, 4 Nov 2021 01:31:55 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: replace most hardcoded object lists with
 $(wildcard)
In-Reply-To: <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2111040124430.56@tvgsbejvaqbjf.bet>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com> <YX5T+wt0hSkxkLHA@coredump.intra.peff.net> <211031.86a6ip47ib.gmgdl@evledraar.gmail.com> <YYJy4BuX6JI6p+aV@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-683811759-1635985924=:56"
X-Provags-ID: V03:K1:fCfrA3ahqGqgRWEJomqXEz6uG+BmVVaSTi/X6adTxP1+JnwasXk
 Qpq6kCkAEGhZUwwte4aLcwBoRkbLBA6JcQoMNh5YLKOI34IfU4JiwNPqnXpuf/d99BCYn1/
 GTYy26xfok3AVyTdKPIq/NOArO/OVgdXhaNz8nN6Ddvy2aKwD3MS9/EfEERqHc1ozfnXY4T
 6QdU1u0G1NqX6dhBT+UrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+5Cc8ipbyaY=:8C1pFw/1T06WfU6CgvNzrr
 Oobyf02ZeJuKNje7bb8a/9B5iaRSrdcMm3KwsG/JbqL4MwnPVPru4/VX8csvjKUFZSbFARTMx
 XrfvrvdiVjjpvDdLlFYOQXUf1Olffi4Xb2mLH9yCY3qRaGzou9aDUuErE+Ue5ACpiNxIQIXZY
 AVJcUIPxk54ejBjJgrsmU38wVsVAKlSpuQG1feOfwS+b59oX+e+Rdu5vpxCHsab/IKDASeiul
 /fbt/9iFH6FOUhFVzxiOmRgMVqABL8SGRtS9NOY20OCkh2FZ8v3IezbCu5UyODCoOBvqIeqUy
 khSBliNSZpE3yVfiVNaOrJNDSh+r6fJRf0lKpb6S5jdTqY6+6HgqFIe0su0oUSNc/uA4nCyiu
 9S4A46PZzg3SvNYMDfKrg84euOCQ1+6GCJcLdwC+poUvg9x1bB5sG87tLUnT4lRudovcSfAdg
 zugPXxJgYuh7oI/HXwqURwPTpXTrAoj3hrUXQFMJTlSblcuDJRI9MwguHL9LJgyeR326B1Qif
 9fxtwOUU7tfhYZtQad0spLHTLMbHlX8OrNF7xhrTV+H6tzqh4Occ+G58Mb9gJb/OYEFIgpVVq
 d0QWRSsAK/tQiEMxX6W2ALDbR2e5WMerPjO1N95IFtkCsXuJIYtnb2c3QV2y5cCbKW7SOlpFh
 2LU68vg1/J2arzIAIPNeoOld4Hyj4Dy7OBfgdco7IL+ZAfNhKMpjioftVoduKYWnOBZSPGljc
 QdZvmPHv0AjZZhm19DM1fmA+MoLpuUmT2uLUxQvj8TmZxltM/cawb8yH/tBzlvv/g3Dwbbi74
 pk65I0w+nnNkWJwvRQzxQXCAd/RVYXyq9HHlBkUU9iffd84brJF+PE3dXsNeMJip6Mny6bm3M
 jwnPeofImuaCWjhMZlX+uqE5f7SvpHjtNEqGVkKAgEu2EwFmtY74QL3tmpqedEYO5FC2wtVUW
 dxG8z5qxpn71rY2jfsPIrLb5n5JXdsIi6NCwE5eUlgnI/DG9sxM7H7iVC3MHYeViOJDCXI4bJ
 IhhO4x0+hEIWeA4Z69LlLispAjx+roqooEJDwf79cKhotJUe7Mt9E9Z180rRT6iq4cWXW0w+B
 VOahIxOkD75ICw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-683811759-1635985924=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Wed, 3 Nov 2021, Jeff King wrote:

> On Sun, Oct 31, 2021 at 02:00:42PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>
> > I didn't notice before submitting this but this patch breaks the
> > vs-build job, because the cmake build in "contrib" is screen-scraping
> > the Makefile[1].
> >
> > What's the status of that code? It's rather tiresome to need to patch
> > two independent and incompatible build systems every time there's some
> > structural change in the Makefile.
>
> My opinion when we took in the cmake topic was that it would be OK for
> people working on the main Makefile to break cmake. It's an add-on and
> the people who care about cmake are the ones who will do the work to
> track the Makefile.

I do try to have a look at breakages in `seen` when I have the time, but
lately I didn't. That's why you may have felt more of these CMake
headaches.

> But since there's a CI job that will nag you if it fails, that kind of
> makes it everybody's problem in practice. That doesn't change my opinion
> on how things _should_ work, but I have done small fixups as necessary
> to stop the nagging.

One very simple solution is to leave the Makefile alone unless it really,
really needs to be changed. There are costs to refactoring, and quite
honestly, it might be a good thing that something like a failing vs-build
job discourages refactoring for refactoring's sake.

> > I hadn't looked in any detail at that recipe before, but it the
> > vs-build job has a hard dependency on GNU make anyway, since we use it
> > for "make artifacts-tar".
> >
> > So whatever cmake special-sauce is happening there I don't see why
> > vs-build couldn't call out "make" for most of the work it's doing,
> > isn't it just some replacement for what the "vcxproj" target in
> > config.mak.uname used to do?
>
> The big question for me is whether that really is a hard dependency.
> Obviously "make artifacts-tar" is for the CI job, but is the cmake stuff
> supposed to work for regular users without relying on having GNU make at
> all? I have no clue.

The entire point of the CMake configuration is to allow developers on
Windows to use the tools they are used to, to build Git. And believe it or
not, GNU make is not one of those tools! I know. Very hard to believe. :-)

So yeah, the vs-build/vs-test combo tries to pay attention to this
intended scenario, and avoids using GNU make or any other of those Unix
tools that much less ubiquitous than some might want to believe.

Ciao,
Dscho

--8323328-683811759-1635985924=:56--
