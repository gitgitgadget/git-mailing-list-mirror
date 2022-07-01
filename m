Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB4C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 16:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiGAQGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiGAQGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 12:06:31 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4E31372
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656691561;
        bh=6nuxgjV/HSQpwInx3q9niVHK5WswrfhgiOm/kweecQE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f8RS0OK9Pm2b0eOnAWliTC1HKdqN409Dy+aQDLe3ZYBmFBOMHMy5i6FP2b0ams9iT
         mJ3vG/EJGIpxdwdeMpeiuApreVmH5S3WZWDy0nqluSHk3sxEH9lQ1eMgqQlgQ5cnpS
         mVz9niDmXID4X1WQHBfASkzDIQqyqctxdRWjqH80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.204.148] ([213.196.212.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1oOQId1bFK-00IBo8; Fri, 01
 Jul 2022 18:06:01 +0200
Date:   Fri, 1 Jul 2022 18:05:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/5] Avoid spawning gzip in git archive
In-Reply-To: <ps52p06s-01nr-4ss2-r802-6nsp5nqq5199@tzk.qr>
Message-ID: <038r075o-5s5r-9sop-5o02-8s84428o0r54@tzk.qr>
References: <pull.145.git.gitgitgadget@gmail.com> <217a2f4d-4fc2-aaed-f5c2-1b7e134b046d@web.de> <nycvar.QRO.7.76.6.2206141043150.353@tvgsbejvaqbjf.bet> <0aa5c101-06bf-325c-efbc-6b4ef38616c5@web.de> <ps52p06s-01nr-4ss2-r802-6nsp5nqq5199@tzk.qr>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1720950453-1656690323=:10220"
Content-ID: <8p2qp3r0-7068-4p73-s654-pr55o26r110q@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:0TDf/Xi6H0OG+ZD3W6GxjgE44MDhAU9IDSLniqhMdAznjEOSVQX
 z8h0uWd55aXQjeSfFvAfuMAr1Weid7HbyAghYyTwQpRBooBfze1aI6P6t7Sgmrdk2XorkOv
 2MRTKL5IUnoChJ1k7037enuJNPjTvUcaBXAKBj9udS+wspz2D6OJ4YD60JWSBM04tcQrYAy
 17r5RDRBVeeq1qGwylAsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:foEilXiikbY=:n6divYfe625PQElxorex+c
 qz6g/kIigzDKv9b9HOIZAKzTTVhWOqJt2/djoBtpp5hQW9uB9tIw0lMBEgqWHevM0Kp3+W8mq
 HshAZrc2sv5aI4l+xRta0/5uz5AT3A4j6MLrv0G7sOV0bhIiG/jt2irZ/b0OChTUPaz1rUc0q
 ow4HNq5JtoicGNXrPsVIzm6iiRIw9fzmfJQcL3/EKMTAJGHa+8qCYfuysA6vwiZUu3RZFrWvs
 MWxs0w1eZw5R+hgrQSioa/XJzTqBsdYzNjuw9vx4787z7mvbdQKH/PMLLhaKIVv8YL8Th1LDL
 fP0WMZMwPprAOQL0wlV0NtQIE1wTPAVJhlz71Lb+PFB6ujzl5WIOKFGwBZpEkh8SXtBAHOauv
 nulT9N7qJzfG9h1z59hBPH9yDtfqf15kDMOrsQ3RLG4Udx+e/SKqit79lYkUSa2Fn4QM82XIo
 8kY3Xy5JtxpEKZ/1tPZtErNCXwaWIjMZmdkd7Krdo9cbalYA5nMzFgr1ns4Cfjahy38L0X4JK
 h2DlQDaSG27qpUGy3DRdaSStrn2BUCPcGtSxZtiHmbXHF74jAp8BThniGGUxnjJh6SMu2OavM
 eH0JCEhSVgVzz0QxvrEyNuzJ3LPue0iMnKMa5gF11taXrYufNfRs39pHUUM45HZObeijH+Nk0
 x8R0U/3D/jlbD8SM1khD3nZZpovBB6PE357opMlhOcuePBo64XSsAkWoPdDdhggi+hVqh1mB5
 BVgPGS+N8Wvrc/l+ew/wvBPlGwbaKw2f4wyV5oQiTwVI+y7uryI3R20G1gggEsB23fcCPlMxZ
 eYoyy8aAkQJwK0Zq35uoRS7QdezX1P36pnbFSnLlN8I9fX1wUSkA9CzpYa92sbXv9S5UuqRhF
 C7tp7hnoR8CoQJ8GuqiC9/Vdyrf82eGfXFW2gC9kSmjV80slsYV5yfFpkW3qM4pT2zMStTFXv
 7sqEEsY7Wq38Ps13AF7N/zLMm+8Fo2FLjGY5BOw1Pf9g2B6WGxtDk6FTfMFCrGbiB35MBmUPH
 nLlAyhJPpPWCRvbCLbn9PPk1ngdUmkPddW2v/KOhnDF6wh3uA3T1OlPugNbtm6DwMJJ+vLDYC
 xYFnXTg4OKSCrj+qjbcK9gVglfVtdTjUEqo9d1S6lWR72AsvNF7xfOZZA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1720950453-1656690323=:10220
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <70n192o2-2pn0-0618-69op-o9o6s36o7780@tvgsbejvaqbjf.bet>

Me again,

On Thu, 30 Jun 2022, Johannes Schindelin wrote:

> I finally managed to play around with building and packaging zlib-ng
> [*1*] (since I want to use it as a drop-in replacement for zlib, I think
> it is best to configure it with `--zlib-compat`, that way I do not have
> to fiddle with any equivalent of `LD_PRELOAD`). Here are my numbers:
>
> 	zlib-ng: 14.409 s =C2=B1 0.209 s
> 	zlib:    26.843 s =C2=B1 0.636 s
>
> These are pretty good, which made me think that they might actually even
> help regular Git operations (because we zlib every loose object).
>
> So I tried to `fast-import` some 2500 commits from linux.git into a fres=
h
> repository, and the zlib-ng version takes ~51s and the zlib version take=
s
> ~58s. At first I thought that it might be noise, but the trend seems to =
be
> steady. It's not a huge improvement, of course, but I think that might b=
e
> because most of the time is spent parsing.
>
> I then tried to test the performance focusing on writing loose object, b=
y
> using p0008 (increasing the number of files from 50 to 1500 and
> restricting it to fsyncMethod=3Dnone).
>
> Unfortunately, the numbers are not really conclusive. I do see minor
> speed-ups with zlib-ng, mostly, in the single digit percentages, though
> occasionally in the other direction. In other words, there is no clear-c=
ut
> change, just a vague tendency. My guess: Git writes too small files (the=
ir
> contents are of the form "$basedir$test_tick.$counter") and zlib-ng's
> superior performance does not come to bear.
>
> Still, for larger workloads, zlib-ng seems to offer a quite nice and
> substantial performance improvement over zlib.

Stolee pointed out to me that objects inside pack files are also
zlib-compressed, and that measuring the speed of `git rev-list --objects
=2D-all --count` might therefore be a better test.

And this is where things get a little messy: in the context of Git for
Windows, my local measurements indicate that zlib is better, with ~41
seconds using zlib vs ~52 seconds using zlib-ng (but the latter has a
rather large variance).

These measurements were done with a relatively straight-forward build of
zlib-ng v2.0.6, and on a hunch I then tried to build the tip of zlib-ng's
`develop` branch (which was much less straight-forward) and now get
virtually the same speed with that `rev-list` command.

But then I repeated the `archive` measurement with the `develop` version
of zlib-ng, and while it was still substantially faster than zlib, it was
slightly slower than zlib-ng v2.0.6 (zlib: ~26 seconds, zlib-ng v2.0.6:
~14 seconds, zlib-ng develop: ~16 seconds). Still, much, much faster than
using `-c tar.tgz.command=3D"gzip -cn"` at ~24 seconds.

So: the picture is messy. The latest official release of zlib-ng seems to
offer performance wins using `archive` but slight losses using `rev-list.
Upgrading to the latest revision of zlib-ng offers slightly smaller
performance wins using `archive` and equivalent performance using
`rev-list`. Both blow `gzip -cn` out of the water, thanks to using MMX or
whatever my laptop's CPU offers.

The take-away as far as Git for Windows is concerned: It seems not _quite_
the time yet to switch from zlib to zlib-ng, I want to wait until there is
an official zlib-ng release with favorable speed.

Ciao,
Dscho

P.S.: I pushed a WIP update to this branch:

> Footnote *1*: https://github.com/msys2/MINGW-packages/compare/master...d=
scho:zlib-ng

--8323328-1720950453-1656690323=:10220--
