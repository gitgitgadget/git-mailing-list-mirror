Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A594C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6E20872
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 13:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZZtVnLx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgIRNYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 09:24:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:44135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIRNYL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 09:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600435449;
        bh=pY7YyBk9Sjq/PzGAw8HwA96hq3w4+9fo+vUYG1pKMgA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZZtVnLx9upReaqdjoQI3aYyLWuwZpikIYKdKKi8w14zKJWHEA8vNaItlVWnpShd3u
         qean7aglgswuXSs8/TXQXC6RNrIEla41zuCJz52En4SJ9AbeFFH3GFPqSrdwKzpm75
         pT+V5Kn/tiLzrl1JefadtJychS6A+AfILMIhotvs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.213.8]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1jtAYt0RCD-00QgIR; Fri, 18
 Sep 2020 15:11:14 +0200
Date:   Fri, 18 Sep 2020 15:11:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com> <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:riAOLMD1El3vRnbHyNm0G6Se7h9zYARWs1fWUlvtwqpoLNVw7fh
 cLmN06U0L7/88LNb4YM049w/hyPzWjU8bP0WCzR+g7MutNxzRPP+AHEPUDW5nSGkjbu9C/+
 xhKYB4ZIofIv+JqP0aL1RfjA/tSiHMYFmkdKgsD3uE9+xtqKODjuK0e0mwpYmGmdlgJMR5K
 0BlF04XvFBgwcFtaPng2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XtiODZCTtVw=:EbHRq1BhmPGqytUsbuMbbd
 bCi9SP0Cwiyu9EfrjeV3/KXJ9U1euofA6BrYRnUicF7lyr6ndHcl3Xx3ApXT29ZFvHvjtW8fM
 a/K6UCjkKBtFLrsqqM1ChHrfuSad2ItdFprXwo6Ez47uTX8nqGAFqrnnGAUTQjWVRhtQi63m/
 ftsz8Twl2GaUYFU0GEkkLEdm4B+QqePeBLKV0N8HpO2m0+eEIJRqnUuFCx+6O1ZJlEv26YjYD
 9RdnQ1hrWrvGYRwgfUTWbaMiLifjO//oYOHW2XYhQM/W7R0G84YSHJ8pmTTzmpf0tneZecrOq
 0/N9T9xtbSssG+egzM4/GOQXg6lfDdTUFmAo46aq5npKinjud++OEdqxTwe/jzcyFd/OOw/l1
 7lwtkztzs+wT4Everu8uKWwOkzTQr/ZOwptpw4mCd68ZVgeu4Oas+J647IUjAfu90q2WjpeZo
 AkIZPlpzPa65amoNAgDeWdS9l9NFehGRgP+5av5ObB+DO5O3YHkpLdxPOXG5+/8Namojw4KfA
 10PPwlIw9IolkldCPbZlcky2DkgWjIqOPSqSy0V05QOny+DQVKpegAqLq375gx9jEnuSdigIM
 lJ9buwlhfAMpLRjFcRqe9Jbo+xpguWieIrX1iEMinGdYmg/mZWAl82e9R9AVwxgrOzGIb9NTF
 8teUAGdXhqLpf9wDh/3x6G+Idd8Lr+HQWpXkP87B+75+hybBib88+vED97GJkERyYDhaLDdtB
 1OjpxV0OtnF03TqBnSh4jmopLjbjulrYGamci1uDj15KpR9ECHKW4uieUMgtQkXrStoNiNLLW
 Md20c9fLT51RPT6qVek4dqwZLeLwEVwTmNGPCMdEJnJJyRlkhOeQRZhH6f/wmJ80ckPF9KPJt
 wMYwzbJMEC9WU/IssdwCUBBGTzbszvrGwh68CduQK4GBEgnIC+HI/C7SscL5wWCLiNmgrbtCr
 YDinUQvOoDNmZyfxgdqncLWTr3dtYktrN0ipbKo/orMpG6kzwno3pVFkVAUcsVVb3GsDtjbnr
 b8R3we5BEbL2eph4Q/V0oHsANOjDVUjpkpzGSU09bVH7CW01UgCkQbQ3sSs0d17bXiTUgIHzb
 daQDP+uhNDS2+yiz4Z7Qwhxy7/wDSC2G30eKR+z29J1RwIzlYKIulgTxkXn3LWrakskcNFJhs
 TuHcf3mpKA745y3EgqKDDxrht4T2EHtizOYvvsFY/ikDibp3X8ezA2wc45X/0KtXlJJaNNRS0
 u/sKaiArj799TVVJTmljFN9koqllR5BGuV5uEyw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 17 Sep 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When using CMake to generate the files required to build Git in Visual
> > Studio, a bunch of files are generated. We will want to prevent them
> > from being tracked in Git.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     Ignore files generated by CMake
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-735%=
2Fdscho%2Fignore-generated-cmake-files-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-735/dsc=
ho/ignore-generated-cmake-files-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/735
> >
> >  .gitignore | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 9673e792db..36f5ac4138 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -239,3 +239,9 @@ Release/
> >  /git.VC.VC.opendb
> >  /git.VC.db
> >  *.dSYM
> > +*.vcxproj
> > +*.vcxproj.filters
> > +/CMakeCache.txt
> > +/CMakeFiles/
> > +/*.cmake
> > +/DartConfiguration.tcl
>
> Good to catch these cruft.
>
> Does the equivalent of "make distclean" need to be updated to clean
> them as well, or is it sufficient to ignore the build procedure and
> just rely on "git clean -f -x"?

Since CMake in conjunction with Visual Studio completely side-steps
`make`, I think it would make most sense to ignore `make distclean` in
this context and go for `git clean -dfx` instead.

Ciao,
Dscho
