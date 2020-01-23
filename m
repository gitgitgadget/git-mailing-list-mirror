Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D6C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD68520665
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AFU6621a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAWVjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:39:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:36917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgAWVjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 16:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579815569;
        bh=Y08dVgk+I/mtAL0q8EzYYTIx7Tv9V+uqEqc753Sc/e0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AFU6621aMb4VicdhH+FcteW0trMApUnQQne6N2disNXLofXLgVd+B8NWRW0KkRI6Z
         4Pj3+UeOBdG+TDwP6PsqCue038Ktof69zqyTovVCswJ530xkdHtO9Ob0ikFy0BCgdD
         O7esMpBmIisrG/H6qjSGXv8AFNDiESitef6vlCfo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McYCl-1jTGfc0OHF-00cukC; Thu, 23
 Jan 2020 22:39:29 +0100
Date:   Thu, 23 Jan 2020 22:39:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200123175645.GF6837@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2001232237590.46@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1744847927-1579815569=:46"
X-Provags-ID: V03:K1:L0zOA8RrVgHdIzyftKeHE5nkfZIrqvUhqwEvIEa5lIHfTVx3Phx
 UJy1COLWuaODT15iQ3rq5bXWLTKwQHGX2+aDCa8AfZjx/SxSWB4q52JzKm4bavHktY+V+7o
 4NwCU1S8Aexsk/eAzHFO73c9bCNC8CJ7uQ6JQD6I74gFKWZI7LiFszxSl4doFm/JP/oyylA
 fk5BMmM7XUcp7Dn9E8q5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CTgc/jTpDU0=:7mIl2TWJNiMfkSqJiXxqL8
 MQd971hmyuNXGeAZymAt25pZZRa5TM0wZyFrN9V5ozr03fpO1N5QnBtKAUUKnVbDE+tAShNjV
 oUrVXT0ZRHAXNAMzJf/rMIlb9GVj/R1aM93XtSl5nH6Zb04IDRDdOV+DTomo/mR2JUq+Q5zib
 qR6xAkGUHMj2V44vrt/cvD1gLXkypQXLS4C2I14J3XXrQQ9E2P2EuaNBjDHq8lbmvxVl6mo62
 G3acFUO3mEaOlgIGDh6/lEMxI5x05jJ6Y6sBs9axZfJsIZPEw2hc7I+ZMB0WZQmp/tX6kNyNo
 cNV45u10zNe5ttlmileNVDaDMDHQJNQENUmGQPP0rEbdAlQsTEar2x+JjQYZVDm+2AIukO9m6
 Au0Lb7wjUr0Rp1uW/cMxGeduXQbzu/LOlSwqLo6gCDzaUOVOAwLRbqtAOXaSLQMe7i/aDoR7Y
 fewzNigEAymYKgqrfb1alLKXpb2BDy4Z4zN7PVNFMm5TDTHqhKBI+apFcn3SaKaqelYgx1ucX
 FyLHT+sByMVicUZcDVHkKZnumgYgSmNlb5Y4H+yay85UHGE6TbNW83HSMl8zN3zuxgTktxUTh
 In6lr5m8n++ProGnszNc7yvz9zaQ9LJyTt7p8udDRjOAdrco+ojsgxELxt//s1uDeZkcAv7l2
 Zpy0bNmq0gJ0SCcTpTdpAXlt6j9WvFjHFQV04j1rxioWY7KZpSfvgUBYa86HAQoFdeZx1VEka
 blKntBZLYzPwDLox1gBLO/4+9X362CKixCkr1skbymaHf1s6Z/MmOzzpZ8FsZoQzuxCq0Yp1f
 yHuzPjnjQtivyQk87Zn/g4+dUZQ6NEPWUUXGYFD7/8pr8eg4Wg1R97wRgZZDDDra+ceb3uozO
 RJSML6FJLNjQjPju9bobaete/xXFDok80++DK34okR5lsvFC9cMrmB5n4u+ngFhO9LsDPFZmA
 JZVAeiqU5/r1d/276EboBWAbmQnYakz9bQ2/9LEgXSHADxw9OJjyUU5RXxWW2MfyMVmtgtyhU
 RZhQgKveFuK6AzeztLKxRk3uMCqvYMRmASE08arBowz291PZG59vzkx/xP5dc8a+XU34xKTuI
 5Yg/msb3ppeUL3VYumghBdcyahElUBgUFA/ro0jZyZLqrPpZnSJyRq1+BtlP3kLJWSKAMI2Wn
 EL/9dzz+8YO6XYFyMszFHwLrFdi8PHxBO2eocSwJPIkfssqpepFhaAFk3mGdZNPCsLH8Ybc8N
 cOaf81HpRto5prRfj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1744847927-1579815569=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Thu, 23 Jan 2020, SZEDER G=C3=A1bor wrote:

> On Thu, Jan 23, 2020 at 03:16:26PM +0100, SZEDER G=C3=A1bor wrote:
> > > What's the ideal endgame wrt the tests?
>
> > Running the 'linux-clang' job with Python 2 and the 'linux-gcc' job
> > with Python 3 would be the simplest and cheapest, I'd think.  We'd
> > only need to add the appropriate 'PYTHON_PATH=3D...' to out MAKEFLAGS.
> > As far as Travis CI is concerned, their Xenial image (i.e. the Linux
> > image we're using) comes with both 'python2' and 'python3' in PATH, at
> > versions v2.7 and v3.5, with the former being the default.
> >
> > Perhaps we could do the same with the OSX Clang and GCC jobs as well,
> > dunno.  Travis CI's OSX image, too, comes with both 'python2' and
> > 'python3' in PATH, though Python 3 is already at v3.7, but still v2.7
> > is the default.
>
> Replacing that last patch of the series with the diff below works both
> on Linux and macOS and both on Travis CI and Azure Pipelines.
>
> linux-clang with Python 2:
>   https://travis-ci.org/szeder/git/jobs/640912453#L499
>   https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D27690&=
view=3Dlogs&j=3D8f20da19-31b7-5cef-4813-95b8788bd086&t=3D56027f08-fde3-50a=
d-0c9a-5ec7df432ed0&l=3D615
>
> linux-gcc with Python 3:
>   https://travis-ci.org/szeder/git/jobs/640912454#L606
>   https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D27690&=
view=3Dlogs&j=3D275f1d19-1bd8-5591-b06b-07d489ea915a&t=3D33e5d3ec-87e7-5f8=
0-0281-074c6962cb44&l=3D652
>
> osx-clang with Python 2:
>   https://travis-ci.org/szeder/git/jobs/640912455#L272
>   https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D27690&=
view=3Dlogs&j=3Db80c90c8-f62d-51c1-0986-3bb8359d9b6f&t=3Df8b92b00-54c3-55a=
a-48a6-84ec793cfb94&l=3D365
>
> osx-gcc with Python 3:
>   https://travis-ci.org/szeder/git/jobs/640912456#L283
>   https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D27690&=
view=3Dlogs&j=3Dcfa20e98-6997-523c-4233-f0a7302c929f&t=3D3de1ae02-4adb-513=
8-54da-65cec5dd3141&l=3D394
>
>
>  --- >8 ---
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index a90d0dc0fd..c3a8cd2104 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -162,6 +162,9 @@ linux-clang|linux-gcc)
>  	if [ "$jobname" =3D linux-gcc ]
>  	then
>  		export CC=3Dgcc-8
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> +	else
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
>  	fi
>
>  	export GIT_TEST_HTTPD=3Dtrue
> @@ -182,6 +185,9 @@ osx-clang|osx-gcc)
>  	if [ "$jobname" =3D osx-gcc ]
>  	then
>  		export CC=3Dgcc-9
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python3)"
> +	else
> +		MAKEFLAGS=3D"$MAKEFLAGS PYTHON_PATH=3D$(which python2)"
>  	fi
>
>  	# t9810 occasionally fails on Travis CI OS X

My only worry is that this makes it even more obscure what purpose which
job has. Nothing in the name `osx-gcc` shouts loudly "I want to use Python
3.x!" to me.

Other than that, it is sensible.

Ciao,
Dscho

--8323328-1744847927-1579815569=:46--
