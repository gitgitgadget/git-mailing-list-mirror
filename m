Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1528DC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 14:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbhLJOfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:35:04 -0500
Received: from mout.gmx.net ([212.227.17.20]:52755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234805AbhLJOfD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 09:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639146676;
        bh=d++epOr8wn0/Am1NtcrJBomDzL1LAxBx8s/wxQzN/eg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DeMwaSzDXOLrrnFa4++5S4YIZJtDP2u4xYLDk4i1oposYpRQ2evH5SebA4zMT5Ahq
         lbr6RQ8KTmR0hlPwQUQwallQuRpwxrE0OsAfCjaqyuZB6jwMRS8MQRrUfLXAz4BL89
         86AiVV6gBDiZI7sWC1rRfeZuF6zyME2+RE6dsZ9k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1n4f5f2xtv-00SMgW; Fri, 10
 Dec 2021 15:31:16 +0100
Date:   Fri, 10 Dec 2021 15:31:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 00/10] range-diff: fix segfault due to integer
 overflow
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1320529452-1639146676=:90"
X-Provags-ID: V03:K1:M6gQ+cFZIfEeNBoL+sWFKV47asqJpdCOViPrEQH5YDDzfsT78R5
 iga6L8kU8C3qRFp/qV9nGXFhH+mDzLtaKpLdTqRHovAn9Tz6RfR1thBnjl1MJLcUQJZNbyg
 ayNmZTrU+qhgyfFIFYEZrpKdyPZYai5VF0bbbWdBb2yYBI0cSKTf/pvDNVSMfGb0/kx1Gtv
 /hxwKRoc9ss1HW66alUKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zJl1NP+Sza8=:JReH/+xUmOq5YhA2v5JDB5
 Lngi3oACK+huiQ3XMrtNDWrWaVID41DxMNwRUkvOP91NRjqHi0a740na8hw3OdNNAi1S0z5Fk
 Wb0e7xxlhaGfyrtxxI7UAlmIM72OclydSpvCHtXHIdeUv5FO62OOE8y7zo0qf3RHcbdOgPyam
 sZBsfU1if/FGe7FliSNQb4JzFcCSeDw1amku1fvNyosuRnrGsaSE7AGZXStv2OOW81AaI/m8Z
 vL2LBDulZxrDttonkHczN1gmaADF7JrXSn2uQtOFo/0MMpxajm2QPN/BnD+xPKEM+g4rjVfwa
 3X955q0TFubaSdDIONoH2rl+xYc8yU8tqkr/9itK4uTiaIs1bMC4pATbA1kYrq012rLz8YD/u
 qDjhERqcuq75P4jyquF8b0lM/0/0OPB9KX2lMuZgXwO4PuedEMfmZnpkUW55TzDVwOpsbLfZy
 G8Hd3Ib9mUtrMBlC5MYQs9jbkUvR/Lyw9Rp+w9E94n+pTKGtWJ2+z+Q8DvF+3hjuBeVkFHpjJ
 MAx14DTO6TNu2CQPwgeaiHeM+ZbO9bYYqgLo7T5zhH/Cb3N7L1puLrcVvX553fMhn5/xN76Zr
 uarLsEjK0O668vmoSKzLdzLu/n4wEg2lxJu7wf4uKiAXN6Y+bgbSckEoPPq7ezvoS9xS/4lAQ
 I/H38RdEAH2yuzuJoqIF7llFk/V/jmMv6cMHFhRnym4gt19XX0p4H5xCimKlo48swGjj7Ssq7
 e9OTzEJ0wproUt8zzXs979T/Vqwb+EBbswfoXYgjHwwGX3l9K2REVnScAZGItv67D4OC6xSSG
 rXXLcuqnwTw2ZB4Po1Gwm1fkIGCN9IqAq1+Rnja1W/rd4T5qz5GdCALAUUThk5fXRrAclNuew
 nzZoo8eBelsZoiGxaY3RQVmsfxJZLKqW53G5jWG1jvQ3IVel579/+x9JFkfvMtjMz2SpK/OM0
 JfHzYD/5WG1+KOfD39QEQjXVZl+e6I5sPMVphb97P4SSHgNfpxmTQQvpsHNPmm5ZDQ8qYG0pt
 vKNsJO3/dUFc5+a+YYCpWkaVTnRUNXMoovwjKbiA7BhXWVQFyy6AFV8bCCZTyjdKgOmCwhm4d
 x9iw2dBCatobp8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1320529452-1639146676=:90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 9 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> The difference between "master" and "git-for-windows/main" is large
> enough that comparing the two will segfault on my system. This is
> because the range-diff code does some expensive calculations and will
> overflow the "int" type.

You are holding this thing wrong.

The `main` branch of Git for Windows uses merging rebases, therefore you
need to use a commit range like
`git-for-windows/main^{/^Start.the.merging}..git-for-windows/main` and
compare it to `git-for-windows/main..master`.

Failing that, you will receive only bogus results.

As to the patch series, it likely does the wrong thing. Just like we error
out on insanely large input in libxdiff, `range-diff` should do the same.

Ciao,
Johannes

--8323328-1320529452-1639146676=:90--
