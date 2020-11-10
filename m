Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFAAC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC0420781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 22:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="epQDy8mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgKJWhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 17:37:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:49769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgKJWhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 17:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605047855;
        bh=HBZTqmV6gMTQ4OLWZ7kMSgEfC36EV8mfWbsK1cHE49c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=epQDy8mEpLGS91vJvZgGQX4OYsVZMHTF7aAY1NMUJBUPP/nQQq8m0UAvLCWejM488
         DNi96Si/7F8aAB5yRhmc12hytTZMRf6D1rcd/FnY5/zNdD+cL5S5nftLGFHTiLUUmD
         sa3JuBWbeZhC3ygpqhKtpeQVsPOMlkPiUTbBDgzc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1jw9ll3BqF-00pcTg; Tue, 10
 Nov 2020 23:37:34 +0100
Date:   Tue, 10 Nov 2020 23:37:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Daniel Gurney <dgurney99@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
In-Reply-To: <xmqqtutx6rwc.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011102333530.18437@tvgsbejvaqbjf.bet>
References: <20201107234751.10661-1-dgurney99@gmail.com> <20201108095739.23144-1-dgurney99@gmail.com> <20201110003127.GA1268480@coredump.intra.peff.net> <20201110023620.GH6252@camp.crustytoothpaste.net> <xmqqft5h92fm.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011101500370.18437@tvgsbejvaqbjf.bet> <f41271c0-973d-ee3f-9535-d7fbc5b073cf@gmail.com> <nycvar.QRO.7.76.6.2011101643460.18437@tvgsbejvaqbjf.bet> <xmqqy2j96sd4.fsf@gitster.c.googlers.com> <xmqqtutx6rwc.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rmNLBTxK8DtKdsfemBqbMvRtHTFZscwQDx7zP7K1cCVT9/tqO9C
 sAbxLYUUxxJ763G7X+G1MBw9d/ti5lkIjSPv91m0ncYKBC2QM4dCo138XDJdjJOHNbLqaDt
 kAe3fJfjYOHhM3Eu4Bzrj/k8RSHnC6stY1xjAN8fHnrJaEjlEJM1JfeDPV436sRlpNxYMkU
 BSUlRNz8m3KLQxy2pOGeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9QN2X0PXRDI=:f7MaW/OhMoVXgawx3vOKln
 mZJI5iX4dCiYW72UKU6xrBLpoGfNHa/C6n6i6yBA5j1Act1bZq2fzgsgPdaq6NJVjmj/35hlX
 Ecqvxo5IypqdvyrlbWDNf033rVHBn0Og91xooH8o3zM3eG9EO8iLAPTa5cM0EktYVp6qXLv6q
 Gb1tZ1jjJON8ey3zHXNaJL88SOP5mObTJv99OtYD3Dz1Gsjd5Tz/MRpGS1cQWJEA+Vt6w38sm
 7hg9/1UD7afDcpGhzrh10W+1KEtn7RUTMIa6KtIPjttsTxdgtD0JH0UfrP2FU0GZe7HcskiRw
 VND/nVbBq9ej5tYPKxBSu3guo3uf0SMMPTL3XsEkDifRXVY12PdEyGh7wso3v9LqSpaYmPFlN
 4a7pXDq6ZovcUwb+GN3VFeFKgq8MD7i5kwYxQlhlED7PoDsnqW02iXBZ/ccQK5F5pMgkutlUD
 ZgJYKrnN4GqSGIzlKehDnjrwkecDP2jLmDs1eVZcbnlAFdzgyu154Hs1DMHk9uXATCt276HeR
 piug2VFJ1sFAKX9AEAd4DTM1CFxC4kI5+6xta0uhqCkhf3cJ5KfZYotcwb/Z0o99qF/DRfPJA
 uVTzDV/P02Xgwx7S1qRhECGbFTDRVM6u6Ezt4eKZIrT2014EZw5ETU1L9/vWrJWRIzYxChnn7
 fHFIF8slIPXmMqH4+MIvKwupwe9eOmIYQXwJSy55t/fPQVUFCl7BmLFnQ2k3Rm0OTzTbFNqsE
 wCgSJrofBLSGZ3eIFcoMa1rzx23WK/6shjTh540CBQvK43VdxhQOxSWSxd0EYtcQO8pnaW8cb
 MqYMcxVRAuPuGdIbz5Wfl1GdwNxrZAIxwKejaVAVrpP8HNrJDIOGWnTHCQa0I0JquUekjjaNw
 S030+G+PgPqoz7KPVwfWVs5G57rl/22Z2BmXwkT2I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 10 Nov 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> As a maintainer, I am less concerned about the "result today" than I =
am
> >> about keeping things easy and effortless to maintain. One of your pat=
ches
> >> accomplishes that. The other one made it into `next`:
> >> https://github.com/git/git/commit/91a67b86f77
> >
> > I do not think reverting it and requeuing
> >
> > https://lore.kernel.org/git/20201107221916.1428757-1-dgurney99@gmail.c=
om/
> >
> > would help future folks why we ignore _MSC_VER as any sign usable to
> > detect endianness, so I'd prefer to see a patch *on top* of 1af265f0
> > (compat/bswap.h: simplify MSVC endianness detection, 2020-11-08),
> > which is 91a67b86f77^2, that explains why we prefer to list archs
> > explicitly in its log message, which would be the primary value of
> > that commit.
> >
> > Something along this line, perhaps?
> >
> > -- >8 --
> >
> > Subject: compat/bswap.h: do not assume MSVC is little-endian only
> >
> > Earlier, with 1af265f0 (compat/bswap.h: simplify MSVC endianness
> > detection, 2020-11-08), we tried to simplify endianness detection
> > used in compat/bswap.h by assuming that any version Git compiled by
> > MSVC (detected by _MSC_VER preprocessor macro) is meant to run on
> > little endian boxes, as the versions of old MSVC that support m68k
> > and MIPS do not support some C99 features used in the codebase
> > anyway.
> >
> > While it might hold true that modern versions of Windows are all
> > little-endian, MSVC is and/or can be ported to build for big-endian
> > boxes, so tying _MSC_VER with endianness is a bit too restrictive.
> >
> > Let's go back to the old way to use _MSC_VER to learn what
> > preprocessor macros compiler uses to tell us which arch we are
> > building for, and list these arches that are little-endian
> > explicitly.
> >
> > ... signed-off-by from you and helped-by from others ...
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >     diffstat
> >     patch
>
> Daniel's patch adds _M_ARM64 to the list, but do we need to do
> anything further to tell the endian on such a bi-endian arch, or
> does MSVC only support little-endian for that architecture?

Yes, MSVC only supports little-endian for that architecture. From
https://docs.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?v=
iew=3Dmsvc-160#endianness:

	Endianness

	As with the ARM32 version of Windows, on ARM64 Windows executes in
	little-endian mode. Switching endianness is difficult to achieve
	without kernel mode support in AArch64, so it's easier to enforce.

> Just double-checking as the "confusion" that started this thread
> came from an assumption that MSVC =3D=3D Windows =3D=3D big-endian, and =
you
> told us MSVC !=3D Windows.  Now the patch assumes ARM64-on-MSVC is
> little-endian only and we want to make sure that assumption is true.

I did not say that MSVC !=3D Windows, but Visual Studio !=3D Windows. But =
I
did say that I do not want to assume MSVC =3D=3D Windows for all eternity.

> And perhaps it is worth documenting in the log, perhaps
>
> 	... that are little-endian explicitly.  Note that ARM64 is
> 	bi-endian in nature but we treat it little-endian as MSVC
> 	does not treat the arch as bi-endian.
>
> or something like that at the end (I do not know what MSVC actually
> does---just illustrating the level of details I expect in the
> explanation).

Absolutely. If nobody beats me to the punch, I hope to get around to
prepare the patch that you suggested.

Thanks,
Dscho
