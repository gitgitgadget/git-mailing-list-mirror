Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC48C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E47235FD
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 20:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FGpIX7ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIZUcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 16:32:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:51677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIZUca (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 16:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601152347;
        bh=H5yFWVk3ji0lrv90NRFoipf5bwjxAz8lhNIMXfubtU4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FGpIX7ueSIkPUy/f6xDn0ouHTFwtFlYIoybM9aE4Ao5KTKIwFeBol85x2vctQZYfa
         A45Vj9mN318mtAcu+8Ngm7v5z5ZDD/FX8nMJ+aVclPJL0nZMklDlGsHOSBmjpZeaeZ
         5rRLn1NKcwNJP0EJY1ElSA3qHaxuUvXTRNl3jsGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1kmDpi0fWz-00iURA; Sat, 26
 Sep 2020 22:32:27 +0200
Date:   Sat, 26 Sep 2020 22:32:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 02/10] cmake: do find Git for Windows' shell
 interpreter
In-Reply-To: <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009260821260.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com> <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uKYei7XrC8UmAhysfb/Lw3TEFaWKIpDwUARIPYHa1JGm02iYagl
 q/YQB9uQ3ya7rmh+9v4jB9+t92IidlubyQdeVenLlzExkO3VVf68JQQRjUiBDJHKpUMVL/f
 oiC3uGsnX6oqU6EhTJwN4lBr2RxSCDD0zVlhVXcHsBZpg+W4/k6SyCfhEU9zon5LpRa+wR9
 EoWcuj/qr/xKn3CEzF4og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rdiGTPHmbSA=:DV5oCHOLgqw+YoEtB1FInf
 5R6WPLYpYILQ6tPXBS1C0jHSuvsIbwNPK8NDti4mP9xjpIHvIcbIREWo2V1SQIBe9TCZJFrtI
 ic2L1+mADtlwsOSoqKfjYP1JGVUIo9iwujxByxK20u0NMujvIreJ0U1ZT7qIWCWki9Fya6pX+
 8l16SFSmmkMRKeq3oMglDHLeYDGBC0OqaUSkDpXhSS2Frt5VO2m154mSBpj5Mql2CWRhIvelH
 ZUUYPYxgbEQJ6zeM3xO29QO4gubSEzl5oJ2qrF2AWVT9rliTJmj6HSh05Ck+xgTx1FlLbtr+/
 FWnVDv53xjl5nF9ts3+YfZVZfRQRk2fOl1ul0mhaFoK3N1moW/5U9Hjt7DbwXG2QiHoHN/Tct
 3lY3rPnNIWXzJ1fAhFDFOlE3YUNdKL66/qvmFY6Gvdjd67vAIAshN3RX6ePCZcb40oJt34Yey
 3/eQiWEOV0CtuNFr+3AhXWlWgxXUAh5Ciu1UsN0acgW/2xfV70YqjX82VewjtgNIE6tTCQpyJ
 tiFxcfBg/pqTu8lclmTEfa/FRiUZ6BIEKwusecZ/Qk1lh38bRzdBu21BFtMST1LcsMKNmHLpt
 +gT9uuH8SdqqKv/YUWUdu4RJIYck6N62vDPASm+AZnChB1raDajaixj4ds/NaEgMldHYdeRk3
 vUckES50fzp5eeN7+WnO5CfCmMwOlAVCH7alPugZ3esGnttgQGtila6l3N3td9DEE2UYS7Hep
 mRQUFz7NGPw+gpmyzzZaEtIxInxlPEI6iyi2g+WwSWnf3nJbpa9XOR5Z5LJ7iFGZ+ZYfD688M
 OwPTY9vItdFTlmV8ArpccNoQHMDCz49nGh75PK6cFqDZSb3uFsGsL4HRNM08O9hcWhmTDHDjz
 UTXYM8kJQuSttvGhCpiUHzfVrX3DP8dlYClwEfbkJ26NelfvcRYh5A5qiZoaOTavkW9l85Lsr
 oKjmEST1v4aMqIYSaGq1nZdkP45IMfsC4sDMTJ2Xkpa1LnlTSeKPr6L2jd5/ZlRiDM3bM7kcj
 oUZswKbl5CDi77ZhMnrFxs/8Hiq2rqf3aTe0HroptFX90RyxWYQAui1LHjcSpLNY9j0BIlPmT
 KB+0NsazbghxUNegc2N8op95yvE1XRiIjBs+c+OgWoPiuEQjh0eWZSTRIW9Fc0Oh1gX7Ouoc9
 FCEI0Tw0i8Q2fCYxiKIor0Ve+UJCIj1ymbh97bBZNYwJtuFN01LPSKFikJvSyQdTnZy3dJ2qJ
 ynLbRYROkk2pTVgT8IplB0v4N7MiSzqTIautK8w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sibi,

On Fri, 25 Sep 2020, Sibi Siddharthan wrote:

> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> > index 5007f173f1..d14fa4f3dc 100644
> > --- a/contrib/buildsystems/CMakeLists.txt
> > +++ b/contrib/buildsystems/CMakeLists.txt
> > @@ -43,8 +43,11 @@ set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
> >
> >  find_program(SH_EXE sh)
> >  if(NOT SH_EXE)
> > -       message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> > -                       "On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> > +       set(SH_EXE "C:/Program Files/Git/bin/sh.exe")
> > +       if(NOT EXISTS ${SH_EXE})
> > +               message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> > +                               "On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> > +       endif()
> >  endif()
> >
> Let's not point SH_EXE to the 'program files' directory.

It is not doing that, except as a fall-back in case the `sh` program
was not found in the `PATH`.

> find_program() searches 'PATH' for sh.

Right.

> Since the Git-for-windows installer does append
> 'your_installation_directory'/Git/bin to the PATH variable, it should
> be fine.

No, it does not. Quite purposefully so.

The `/bin/` directory is kind of a hack to reinstate _some_ level of
support for use cases that relied on Git for Windows v1.x installing its
binaries into that directory (v2.x distributes them between `/usr/bin/`
and `/mingw64/bin/`).

What _does_ get appended, at least by default, is the `/cmd/` directory
(which does _not_ contain `sh.exe`).

Now, there _is_ an option in the Git for Windows installer to append all
of its Unix tools to the `PATH`, but it is highly discouraged to do so.

> I personally don't install my dev tools(except Visual Studio) to
> Program Files(because of the _space_), it messes up the Makefiles.

Sure, and that's your prerogative. There's unfortunately no good way to
support your use case.

Luckily, the vast majority of Git for Windows' users do not change the
default location, and this patch is for them. (And "them" in this case
includes me, personally ;-))

Ciao,
Dscho
