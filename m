Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3F91F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfEHL12 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:27:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:38167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEHL12 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557314830;
        bh=NMg4xJ/F1EKFLIKXriEacXsS2AAO8+ksl7cDyWWL6JQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TZK2fGDKPopuHlyHo44GH//ZOVmruisqdYdttYSnXPWs3dwbPG1GBwp50/cf0LLo1
         YyEHcp3Yh9dSzCVLnjFSJoeaEmwcT9uNa68lwzlARyd6/SMdGufZhtbjuzMNWpF1l2
         ni4Z5CXL/mLpTY/KfPApc+L6/uesjKuALMFd4IF0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJV6-1gl85z332c-00fPCH; Wed, 08
 May 2019 13:27:09 +0200
Date:   Wed, 8 May 2019 13:27:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez?= <ismail@i10z.com>,
        =?UTF-8?Q?=C4=B0smail_D=C3=B6nmez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mingw: enable DEP and ASLR
In-Reply-To: <20190501220219.GA42435@google.com>
Message-ID: <nycvar.QRO.7.76.6.1905081319570.44@tvgsbejvaqbjf.bet>
References: <pull.134.git.gitgitgadget@gmail.com> <e142c1396ec3541486317819e885cf42be24af34.1556575015.git.gitgitgadget@gmail.com> <8e59dbf6-a339-74f3-4e60-e56b3817aea5@kdbg.org> <nycvar.QRO.7.76.6.1904301838400.45@tvgsbejvaqbjf.bet>
 <20190501204631.GB13372@sigill.intra.peff.net> <20190501220219.GA42435@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:59qD0tZ/7sKpHDFrzVCa3ByyZr9xr+Z+mjItWh+PRivHn96uV9J
 YBNaJktbpygHW7AmPI4PQpF7dVXAIwej/9JFcHo7JJv3kcmVOD1fKGXt8dwk/9MZlry5BRl
 4QV7t9RJqp+pUcaGOL2GVO2p0MvWS2554EOruFFDYO3W6Z05ysSmuEAIqwBzgn/jo6lUHM6
 gAtjZR6Lz1q9lfRsxGejg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WYox6IAcwJ8=:l5/4YqANdWYDIQq/4ART/+
 /qFszudX/QrCDabhV3Y3GvAM6SpbvjkfAF4MXT2XXx2C1dCVX21jjzJgWZfyz4BHdZSN1K9O/
 Ver38iYSK5XUghS3zKie5habYNr4Kk+nsShSwejQZ9SvsQW0QURStaP7RGok/1+sNQ5wjbQPh
 DfT5PqCYDJ29QDZye4xpQoOEaw2xNEJ4qdz5yZ9AahxsahD1S3S13WrjCbt9kgf295Cfy9w/P
 eWLvVB+3qIVYdD29a7AISkZQkOrO+SZcM22F9SxreTWSG4H6Tb19enVV06csUcXXCLC5UO9ON
 c4sQ39GqOkAuugj366v7HIOZq6irshfsgkfoJEAQPc2lbM+GjE6SsVlmzi7aqZIHfDDFpBwOT
 g/s/7BEpBd72ed3Q1ranalZ/PmvdFs+dGdpY4/yx4liOeDCM6sjndrctJEUPriwOFjSXBhQjE
 OR7CKtLx6JP3Mg4xQEk97E7hlC05dAFmubREAHzI4gq2C9CT1EYw/ocpgyiYRiLA4MFmr+1/t
 58lTvkus8H54Qs9uM+6ohSInDl6ajWg/Iwlzp6d8IzpFdvbmNiHmQIuCyAb7Zsrh72kvso92J
 e/3vO0Hhyf9XnmecqAUSh8s189vAlZAuX3Jb8QteAPscdTtPHqgHc08aooIBY5Q/N7cw2FXeB
 wEAZ8iZ1XMaUWeQRc6hO0a5ddHdnnWzjvOJhen+kPozOSOTUeCa7WxjGtZ0AovuZSyFhEwXRw
 VgJD6neM+nzM8voVV6TY4T/arMPbFC7EicuNSoo1wUEyBS+QptGtNBORLrF0/q7L9axGpvr1S
 RakRnzGzjqA3CmM3KFR9JZsh6Py5WTBZgIV6ZHs0OxXhMDSW1A3cKRK4+at1Q6oASGQ6zRwar
 S3E2kLUEkCwxn4F1e+U0255F97xnSBIY3W4ZyZRPVq8loWlZXdUFNOwRdEXZ/+10WYANpgKzY
 yjCQCcPuE7Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan & Peff,

On Wed, 1 May 2019, Jonathan Nieder wrote:

> Jeff King wrote:
>
> > I wonder if this points to this patch touching the wrong level. These
> > compiler flags are a thing that _some_ builds want (i.e., production
> > builds where people care most about security and not about debugging),
> > but not necessarily all.
> >
> > I'd have expected this to be tweakable by a Makefile knob (either a
> > specific knob, or just the caller setting the right CFLAGS etc), and
> > then for the builds of Git for Windows to turn those knobs when making=
 a
> > package to distribute.
> >
> > Our internal package builds at GitHub all have this in their config.ma=
k
> > (for Linux, of course):
> >
> >   CFLAGS +=3D -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D1
> >   CFLAGS +=3D -fstack-protector-strong
> >
> >   CFLAGS +=3D -fpie
> >   LDFLAGS +=3D -z relro -z now
> >   LDFLAGS +=3D -pie
> >
> > and I wouldn't be surprised if other binary distributors (like the
> > Debian package) do something similar.
>
> Yes, the Debian package uses
>
> 	CFLAGS :=3D -Wall \
> 		$(shell dpkg-buildflags --get CFLAGS) \
> 		$(shell dpkg-buildflags --get CPPFLAGS)
>
> and then passes CFLAGS=3D'$(CFLAGS)' to "make".
>
> That means we're using
>
> 	-g -O2 -fstack-protector-strong -Wformat -Werror=3Dformat-security
> 	-Wdate-time -D_FORTIFY_SOURCE=3D2
>
> Dscho's suggestion for the Windows build sounds fine to me (if
> checking for -Og, too).  Maybe it would make sense to factor out a
> makefile variable for this, that could be used for builds on other
> platforms, too.  That way, the autodetection can be in one place, and
> there is a standard way to override it when the user wants something
> else.

Indeed, if I was to add a generic "are we building for production?"
function, this would be incorrect.

But this is not the case here, we are doing something very specific,
Windows-only here, and for the sole reason to keep debuggability (for
which the presence of the `-g` option indeed would not be a good
indicator: in Git for Windows, we build `.pdb` files so that stackdumps
can be more meaningful, but we do not want to have full debug information
in those executables).

In the long run, I think we need to become more explicit about this, by
adding a "FOR_PRODUCTION" flag. It's really no good if we use
implementation details such as CFLAGS to deduce intent.

That's for another patch series, though, as it is pretty clear-cut here:
If you build with optimization flags using Git for Windows' SDK, you
cannot use gdb for single-stepping, likewise if you use ASLR, so we can
totally piggyback the latter onto the former.

Ciao,
Dscho
