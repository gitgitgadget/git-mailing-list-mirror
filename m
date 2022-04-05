Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B98C4707E
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384113AbiDEVqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572906AbiDERQu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 13:16:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC725DA
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649178888;
        bh=G5LEFhLRJBV4CgiNT3358un+9yp4AUCaMg1wcyUunXo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=U+OkSAqcwUP+qE7O1HW1CfXwek3oRKXXF4U70Ys38Ww+yBUGx8BSAZeetCUzFuknu
         Tk1j0H9eyDhQ54dtlo5E38QXBr85WHJd/LXG52pEbVVnEypwKmDt0RSorgRhsPcw8C
         PgjCxGItevzNOJ6nhIRNmSrnUS/STDSj8I4uv28M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az196-296.m3u5ga3utehe1jm44gvey0miob.gx.internal.cloudapp.net
 ([52.176.40.144]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MAfUe-1niLHU1nE8-00B0f1; Tue, 05 Apr 2022 19:14:48 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.36.0-rc0
Date:   Tue,  5 Apr 2022 17:14:45 +0000
Message-Id: <20220405171445.4177-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:/7rMyOT+GBzB2rfzcjbWX0GlZSDIYwT71uoLumhJOU5njrcZlsH
 TNOBuZze3Se5+Le+0wceWP5Ix8+yzRWfXoTBJdte5gP6j3r2U3yh+/AA3eIjyyMpGjHuLve
 8ymNXHADmDwO1w082pi/wDa3NgA93M/sc4hKS21ihYv8G+wgEkmTYo2Nhnt8t6pNzn/Or2i
 0ghcTvEnfs02AOWm67X/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d9PvU7cKogE=:fqsoaq6nU7kI109YJ+4do8
 AkvWTkZB3qir2qEl9PxBF5oXLKZxrteRaJ8/qRfazWz27whpQxaPxxEjM8YsmmgbpBRsKDaV6
 ZYsvIOant6XIWPILvGZyQpMjsxZ4IGkibAGl93muNJP2tryFb9zHK2niyc3v7I/5S2y6SaDVs
 oFFkOAO0+Pw7YikDs6/BjV/s9plXQrUgtrJtrVGORMxnQBPGr3W8aKz7vvGGe85eVo2BuIkzt
 UvnElNRYtY7anlYmmIFEXtPRKslj5zbx6VAIeNUz3q9iNQ3BWbU70oaQvrdZFBz/vjz8vpeHj
 uy9uR/xtNwucsqynIQsfjYTS6hGKUxONyUjIhm0/JEmHp7lVFFuHaezyrFQTKf3dI+QYXXurC
 6nYXy3PfJj88ftG/0PK8cpjCqOagJ+6BmpLB+XNw6EPJOi6bwVo7vYMJnYgmBCc5SUb/GSr8Z
 W7WljBXbGNkhe/BuAa/KloDCsKm2cn84ue3xH3KyQxsH28789EkAcZWfETw6qUAw2I7+gQpMC
 qSJRA0Kpkz6ebCGZz6uWNKxbbvvllepany6opa0e45cp51MmO84AkZAZDQ9jo14rPTxQ2De/q
 U1KwJ/pu40SNsxWoZB+CUEIeFAag7jODObWjTL0leKZAJyGttv5IZeTAhP9MxwNHApVAj1Qsy
 1CzD0fXhonnLhRr50BdngPpUHXvT/C2tYevjO3hapFm39Ky4G9KeKUNe2zfFVCTO+sS1Bi/KY
 bNMdQAfYeUk1RBQq2Lvr4sgfe+AlUnUgymj5fQkcR/pygZ9c3jjsnU24EFHrPnbHRF4IM+tA/
 F0tr4VsDOku+w8zTR2Ua1paAG66ohH7gYLa3MMnI343KXUFR/Kbh2pz6XmIvTDvrR/z3+lVv/
 9JjU/qhtMVTn+SrYMsJAc4RDoi2daXBBiyrwRXmoDn4mA3TX+TdWyHzBDuS4KdpIf4KKEL6uw
 hp7grH0TKe60viMw3OVq1CrikJqF2MYI2ZVFM9ypnmKpqcb08YBda6Flm+IYsGCVvIyTf/qr/
 Ia574Qzj0rgte5Iu6gfAPq/KrbH4fMj4+jxNzVT3rVFwaxV4gM4mWr0LELMXuKJvjypIPshKh
 FyjxozZml/7iTw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.36.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.36.0-rc0.windows.1

Changes since Git for Windows v2.35.1(2) (February 1st 2022)

New Features

  * Comes with Git v2.36.0-rc0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.3.4.
  * Comes with Git LFS v3.1.2.
  * Comes with OpenSSH v8.9p1.
  * Comes with cURL v7.82.0.
  * Comes with OpenSSL v1.1.1n.
  * Comes with GNU TLS v3.7.4.

Git-2.36.0-rc0-64-bit.exe | 4895e6873773cc3501251399af3de3793bdb3024b0e1a509ff25aaea7b4c6e45
Git-2.36.0-rc0-32-bit.exe | f60f00b376ef437e770b13dfc7bbf54ec2b131d5aad99e3c1e133bb5359aa07d
PortableGit-2.36.0-rc0-64-bit.7z.exe | 2a31582c86835288fea5a7c6cb9ddcfbe61b272cd5a2514ad1a98417fccbfebb
PortableGit-2.36.0-rc0-32-bit.7z.exe | 7cb3f5f691859201f48f9e659cebd51c99876f1bd8b50772783feaeaff589e54
MinGit-2.36.0-rc0-64-bit.zip | 9975e4d55e931ee2a402eeb942e1cecf4df22e8e0ebebdafb977aeb0a59dc5c2
MinGit-2.36.0-rc0-32-bit.zip | ab8baf9061622610f494ecdbdb148ef3e333ae991a4e6ef890db3074881b9536
MinGit-2.36.0-rc0-busybox-64-bit.zip | aaad29348eeae17b0d5cd29ea05cfdef0358208d709e835d0317b3f87977b3c1
MinGit-2.36.0-rc0-busybox-32-bit.zip | 4c62bbf36ec870ad5354754597fc16d3816d0bce53826bcf88ae69b7674d999f
Git-2.36.0-rc0-64-bit.tar.bz2 | 7e8528a5b22444afaa631d793421c4b248c4453215f9c60ee0cde250e60a1600
Git-2.36.0-rc0-32-bit.tar.bz2 | 3d1c927c69cef6c134bf4b15318e3fb374e2f151ce95ff62acbca4357d05b3ba

Ciao,
Johannes
