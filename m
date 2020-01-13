Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215DC33CAE
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 06:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E2A21569
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 06:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CD0AgohY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgAMGra (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:47:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:55963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMGr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 01:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578898044;
        bh=pCHCuDrwk88j+s7fmn47MvROdAkID6xPM9fdga5mdyI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CD0AgohYTxWK7wdML9SLGY4Jy2YvSDO5b+6+Yf9Qcr5ekRdcKl6oX+IYWuHjz/D0H
         9pda+aKXtUwrQfchoGbb1UJiX79MW9L47yXMbC/gjJAYMUmHNNPutvi3w9vpW9/kuV
         cWDFdBXUPdVp6JHDhYE7Q9HSBXBR0BU4daG7KG64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1jM5aX1VwH-00e8wo; Mon, 13
 Jan 2020 07:47:24 +0100
Date:   Mon, 13 Jan 2020 07:47:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] built-in add -p: support interactive.diffFilter
In-Reply-To: <20200107225749.GD32750@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2001130740240.46@tvgsbejvaqbjf.bet>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com> <pull.175.v2.git.1577275020.gitgitgadget@gmail.com> <f45ff08bd0a0a2e2aba9ae929b6e5ecb3bdd4e07.1577275020.git.gitgitgadget@gmail.com> <20200107225749.GD32750@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-618752088-1578898044=:46"
X-Provags-ID: V03:K1:LJ1rOb2fKwSAuKgx58YcZGWbiCUo17l/7dK6jLBML3cMhMO6k70
 V6g92cdpJGFHITAlwVOurFR8t+oVVyjmklHsd1ofK0EVdK9jDX3TBUp/MaQ4KIyzhsRwop0
 z2Mc0rU0Y+/84Qwl7rjvO/wiSVdTt1GrdwvcANXcw0AzzD+Af82c9SW1flK6b3xkNmD+EdD
 lMe/qMjnmIYjY+ms7Fj+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zdjJFxm09Bw=:VO28QAtKphL74fuqU4bxpa
 uQ3nku0WLtSfwDpCo9mxmMXyIKXLNGdDbOIX/4wdnlCTLVCpKmszfyaTQKsMQYi+PuyVlJCOn
 oVw0FDTf5zsxW8OqGrlSlFoqm01g2FoLO4JwXvxl54hAqUJPx5fwjrUg3LOWyGQTtKMF2U/Mg
 1jhnpZYBRfepFOK8txGQG3NHDclIXTCpA47WhL4gb6eRKDyh6YTo6nLmNTYb0KGjSQqwi4Gqf
 x+3fBqn39b4yVYWta9fVaRdDDdp1gJodxRplvWPtN/q0gpnmBTPpULTIOUZgH4VapOuKYG4qX
 V/KdTOtiyvCH7AWgOueB2icM57GC05gd2/tAPRapAoMmcRfEZs+9q6OFR6kaLjWJ0KJaNthky
 i5+G45UHU6Hlgbn+DFdZYlwu6epybWUygxS46TZEl7pxeLSa8LyuHBn7nI/rEnp9HRoDWVtpm
 srMa51kEiSlR2Kg+Ez3fuK7N8Un2uxkBqGZqBgvyikdlcHrgSER6uZSeHZy4KnpzrTu7rrxMy
 s93nFVzMiloRbwRjPmXcqg7+HOatUfPpWSOeg1uALe3dnhUXMbB+bTl94VDNDeVJyVvenD6Fi
 Ksy10XuRCNwvFPvabE3gpt/j+hfrwiQby921D9utU1UHHYixgUkN72/zV1zQW7DGdLGS1dNjg
 oIaOy849DstxkUVnhJJmzZu2TedtDar1/SPjTctZIMxD10jWdDmHVWpJLTCwFx74rM7ssAMLv
 6NwoxutwkV7U2vNmzTuxuseUkQtxu/XWHdzUZ32HombGvxYnkRDGw5EpSwL17FDi9oFww90sc
 Dbf73PRgf+axD8/w7bzloiLG81RL0M4mejKUvuotOMQHTi2GB5yboDzvqGq3rVov/H9tKc2zl
 SPRFYd25GnCiokE17hHbkUCdm8a5AIlIw3021qfR+arDcvNt0tVNGkcbfurgofFsPoDQa2lDe
 1fRJKQ3QL70++p1uBfl2qLIZe944gqNAFLqA/Xrl/3U8v8m39DCg0Fv+ThuMvDXafNgBp9JeL
 Ts4Gan6n7KExPpKQ/pnFBk2CSfSAE1S53DEIkzBt41oCU5PfdBAR+DSl/NqETv3OFyPR3A2zD
 dBuN+wApmn1lE1S/V8MS3Tl6cam6JaUDI+g/wKXpFJSOnRzyQn9oVhl+leg+5RGhhC+xogoVt
 tfnFl2OAnvxkAqvEFnKUnWmUhC0qRN8dwGTFS/TXKWIWxI6y/ZpfVxRpcWstDUNTYw0k0WB/T
 RaVGeNEy8UCxA/4ew4NFanK+c5za12K+283fpHfvN9+jPVSive0RZObv8rn0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-618752088-1578898044=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Tue, 7 Jan 2020, SZEDER G=C3=A1bor wrote:

> On Wed, Dec 25, 2019 at 11:56:52AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > The Perl version supports post-processing the colored diff (that is
> > generated in addition to the uncolored diff, intended to offer a
> > prettier user experience) by a command configured via that config
> > setting, and now the built-in version does that, too.
>
> So this patch makes the test 'detect bogus diffFilter output' in
> 't3701-add-interactive.sh' succeed with the builtin interactive add,
> but I stumbled upon a test failure caused by SIGPIPE in an
> experimental Travis CI s390x build:
>
>   expecting success of 3701.49 'detect bogus diffFilter output':
>           git reset --hard &&
>
>           echo content >test &&
>           test_config interactive.diffFilter "echo too-short" &&
>           printf y >y &&
>           test_must_fail force_color git add -p <y
>
>   + git reset --hard
>   HEAD is now at 6ee5ee5 test
>   + echo content
>   + test_config interactive.diffFilter echo too-short
>   + printf y
>   + test_must_fail force_color git add -p
>   test_must_fail: died by signal 13: force_color git add -p
>   error: last command exited with $?=3D1
>
> Turns out it's a general issue, and
>
>   GIT_TEST_ADD_I_USE_BUILTIN=3D1 ./t3701-add-interactive.sh -r 39,49 --s=
tress
>
> fails within 10 seconds on my Linux box, whereas the scripted 'add -p'
> managed to survive a couple hundred repetitions.

You're right, of course. And I had let that slip for too long, as I saw it
sporadically happen in the Azure Pipeline, too.

This took quite a while to figure out, and I won't claim that I understand
_all_ the details: I _think_ that `stdin` being so short "breaks the pipe"
and interferes with `add -p`'s normal operation, so I needed to explicitly
use the `sigchain` feature to ignore `SIGPIPE` during `add -p`'s main
loop.

Thanks,
Dscho

--8323328-618752088-1578898044=:46--
