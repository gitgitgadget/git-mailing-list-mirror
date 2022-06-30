Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD0C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiF3S4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiF3S4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:56:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3EA35240
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656615339;
        bh=si6r0w6hvNmxjElnCu4oxo9ITj3gC9P21EX8AVmKY7U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BTDCyNV+c8CaJHxvClzfXw56w+jFMlZrXoWO4PbAD7uzT8dJkEREXDcxqwasU0loz
         mhtkKnO8MXoaWr2Odj3f91vkFuiNcZGtySx4dGx4nNDWxxtFrNkdBu5295unkxHFj5
         vHXNEhWsD0sqASzSKk/KAADiQwBC0jZRDd0U1JLA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.204.148] ([213.196.212.94]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEUz4-1ns69B2IKg-00G2Wb; Thu, 30
 Jun 2022 20:55:39 +0200
Date:   Thu, 30 Jun 2022 20:55:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/5] Avoid spawning gzip in git archive
In-Reply-To: <0aa5c101-06bf-325c-efbc-6b4ef38616c5@web.de>
Message-ID: <ps52p06s-01nr-4ss2-r802-6nsp5nqq5199@tzk.qr>
References: <pull.145.git.gitgitgadget@gmail.com> <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de> <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet> <0aa5c101-06bf-325c-efbc-6b4ef38616c5@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-716461379-1656615340=:10220"
X-Provags-ID: V03:K1:e+PhbZjhtQvYiox5obT+Sqih59AkeR0UAojnVxpX3tLW5XI0c6H
 zpb+HlHj6bXNCKEE1fnX9RHdwv6aJeIbZP2+/znsWZOGVt/+/phDVkklQyIoKw2x9bm8Es9
 RlqA6QD3PL1v4SBix1cWSNX07AE7EsUfGB/g4Xo7PrJuHSct7iogej7hQ6zf7yZQzyvvdWX
 bUdwSAWS63z1P2r9CZkNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ApdXIwzS4zw=:AaX3D4oZY8+Ist186iUJHN
 meU9VIWz6Pfl/4WLTCFDXS2SASrXFR7i2lcv4aDhhe3SsD6fAkcjgHFrbtyO0UNUXaOAo8K/Q
 M2qUZW1DANfmQ8MR8oS1SBjoOthpdqMAJ0qhcCzmcpNuD3cZ3Ne4oWs1vGJ7nu+xV5wJrfunY
 pBjLOWA0oSSegsrvc34xycLtbz1a8eNAuI3dWOq5dJFBISY70LaT77fD4XZe7yu7pObcI2wtk
 SheymOQ0WUUCNjcuRl+giYMZ7oBjpY0rQklSyNnv08G+kc4QuKgfVRDFJKka7BjWqRiDhvWGy
 nDTggenDq8wMjjBoAdqnn2VPbahAOUlY7HUCuUoMMS8zG7oY9LN05sVWghiZYOZG/HEDEnqrR
 /rspXlJcVbDUW9xUv6m0kRjZwR3QGI7dvhDLdvwDK3lauk/WjVIKp4IVCjsp6I6AjmG/qurm+
 AmQbpHZ0dLpJsUL3fDUEkeu2UVfTCAJu9x3H9kFF4FyWhZ+RDwyoSNqfsPyCfpyVzRkAkI+M7
 cpX9PoaKi6jnIYVpUHUbWRJhahgGGoF67P44m4aPpv55OwePyZfgeWbQkYtxNqdaWGO1Ya1sm
 EU4psyLZeeTWnxeA++Bc5wKcg8uBjn6q2b1CZP398++f2qpHiop/sq7J0hLy6BiFanC1oMXqS
 c5b/WqejsCNn8ON4k4gJhlwz741ldJp/u1+OYaUbwM8VpFtpyPDxBs7g+x7FV+vvhg9WtxTU4
 4tFqxv+lOsWKygPk98chfZoatB4Pd26hFN7vGg2TN4R4IYFL7KebfZrGU8R5fY1zL7YFWTaN6
 LbFlzfQiiCIBdsbd8095OrXgGNluiBguBqhZblf3/K4EBDZt5ypI5mzxZu/dy5rlkBoLPSu58
 5mZ+4VUlMEw+mtV35Bc4v8z9xkP3lXYrpNJvR+fUlTEb9a5GihBVXtYLWTDD/Zq23hZsJnSNH
 BSb1qub8gCPUfkO5tciQOB7+9rxAlqEbqhzza00K068L2HnnUeKqliJ/1X8f74hqVM+2POtqR
 JJC0gh2QxXcsOJigpot8pf1VJEv6xHcyUG8YICpT4mi+F8GBBZ5yI+F+lgnY37k/+lcY7HbF+
 lo8Xo8qkmUHIP442v6s4brDRb+3EpPbqn6sWQ2gigzjBn7usSwkx5F87A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-716461379-1656615340=:10220
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 14 Jun 2022, Ren=C3=A9 Scharfe wrote:

> Am 14.06.22 um 13:28 schrieb Johannes Schindelin:
> >
> > By the way, the main reason why I did not work more is that in
> > http://madler.net/pipermail/zlib-devel_madler.net/2019-December/003308=
.html,
> > Mark Adler (the zlib maintainer) announced that...
> >
> >> [...] There are many well-tested performance improvements in zlib
> >> waiting in the wings that will be incorporated over the next several
> >> months. [...]
> >
> > This was in December 2019. And now it's June 2022 and I kind of wonder
> > whether those promised improvements will still come.
> >
> > In the meantime, however, a viable alternative seems to have cropped u=
p:
> > https://github.com/zlib-ng/zlib-ng. Essentially, it looks as if it is =
what
> > zlib should have become after above-quoted announcement.
> >
> > In particular the CPU intrinsics support (think MMX, SSE2/3, etc) seem=
 to
> > be very interesting and I would not be completely surprised if buildin=
g
> > Git with your patches and linking against zlib-ng would paint a very
> > favorable picture not only in terms of CPU time but also in terms of
> > wallclock time. Sadly, I have not been able to set aside time to look =
into
> > that angle, but maybe I can peak your interest?
> I was unable to preload zlib-ng using DYLD_INSERT_LIBRARIES on macOS
> 12.4 so far.  The included demo proggy looks impressive, though:
>
> $ hyperfine -w3 -L gzip gzip,../zlib-ng/minigzip "git -C ../linux archiv=
e --format=3Dtar HEAD | {gzip} -c"
> Benchmark #1: git -C ../linux archive --format=3Dtar HEAD | gzip -c
>   Time (mean =C2=B1 =CF=83):     20.424 s =C2=B1  0.006 s    [User: 23.9=
64 s, System: 0.432 s]
>   Range (min =E2=80=A6 max):   20.414 s =E2=80=A6 20.434 s    10 runs
>
> Benchmark #2: git -C ../linux archive --format=3Dtar HEAD | ../zlib-ng/m=
inigzip -c
>   Time (mean =C2=B1 =CF=83):     12.158 s =C2=B1  0.006 s    [User: 13.9=
08 s, System: 0.376 s]
>   Range (min =E2=80=A6 max):   12.145 s =E2=80=A6 12.166 s    10 runs
>
> Summary
>   'git -C ../linux archive --format=3Dtar HEAD | ../zlib-ng/minigzip -c'=
 ran
>     1.68 =C2=B1 0.00 times faster than 'git -C ../linux archive --format=
=3Dtar HEAD | gzip -c'

Intriguing.

I finally managed to play around with building and packaging zlib-ng [*1*]
(since I want to use it as a drop-in replacement for zlib, I think it is
best to configure it with `--zlib-compat`, that way I do not have to
fiddle with any equivalent of `LD_PRELOAD`). Here are my numbers:

	zlib-ng: 14.409 s =C2=B1 0.209 s
	zlib:    26.843 s =C2=B1 0.636 s

These are pretty good, which made me think that they might actually even
help regular Git operations (because we zlib every loose object).

So I tried to `fast-import` some 2500 commits from linux.git into a fresh
repository, and the zlib-ng version takes ~51s and the zlib version takes
~58s. At first I thought that it might be noise, but the trend seems to be
steady. It's not a huge improvement, of course, but I think that might be
because most of the time is spent parsing.

I then tried to test the performance focusing on writing loose object, by
using p0008 (increasing the number of files from 50 to 1500 and
restricting it to fsyncMethod=3Dnone).

Unfortunately, the numbers are not really conclusive. I do see minor
speed-ups with zlib-ng, mostly, in the single digit percentages, though
occasionally in the other direction. In other words, there is no clear-cut
change, just a vague tendency. My guess: Git writes too small files (their
contents are of the form "$basedir$test_tick.$counter") and zlib-ng's
superior performance does not come to bear.

Still, for larger workloads, zlib-ng seems to offer a quite nice and
substantial performance improvement over zlib.

Ciao,
Dscho

Footnote *1*: https://github.com/msys2/MINGW-packages/compare/master...dsc=
ho:zlib-ng

--8323328-716461379-1656615340=:10220--
