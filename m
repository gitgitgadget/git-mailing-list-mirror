Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EA31F461
	for <e@80x24.org>; Mon,  2 Sep 2019 23:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfIBXBU (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 19:01:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:33907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfIBXBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 19:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567465275;
        bh=SrB+5Vlx4fLYXqJI+9dnjUcxvSOWAVQURH5O+ckFTGk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SKaa3PeiWzu4JEhCHP5Vuw9aa21XYDP+kJ6cPDXipf5eaWRZ+ld+RCRLMRB3cV/Tu
         ihAVeXUdnFf4jlTkeuywmYqVWGMG5YnBgXtqOuxKanJZyWW8CFy9DqNkt6p8MJ8mj2
         3m1VluCyIA+kIff50eGD31kCYZAwi01I015hi/XM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1iZ2rc3UHu-00oGhS; Tue, 03
 Sep 2019 01:01:14 +0200
Date:   Tue, 3 Sep 2019 01:01:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 08/24] Ensure index matches head before invoking merge
 machinery, round N
In-Reply-To: <20190817184144.32179-9-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909030043460.46@tvgsbejvaqbjf.bet>
References: <20190815214053.16594-1-newren@gmail.com> <20190817184144.32179-1-newren@gmail.com> <20190817184144.32179-9-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-628890981-1567465276=:46"
X-Provags-ID: V03:K1:9ywOA8eHJ/SjOQKeP2NOr5uFUm1ZF7B2ZQuvKmZaRoKcoIqThba
 aDHiWfbDixfzgcOnCW3rqY7tLotQYkjcTeYDSRXA3dp/vNv5neBDaF5qyIUmpt+DKnsA8ZD
 xtlH5anVR3FFlQ5LuiwtkYCecAc6tXV/6QlAlQJTBw834eAHtEjCAJBxzda4PIc4S+Cn5na
 oRmuG/wo6ZzOKoU73YrDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRpXk4Jd9yI=:6Tehu1bc1CNShcEkU2C04g
 8oZy0768AVA3j4nJxBaGCRgIw9xNXRGy9B6p0w16PG2ZjPQcoWWRJJJlmP5XqJb0UV5RqnJ7a
 ZGw109U7PPjVrYdG5WnZXn/x+Pl40qFOJf9xQjVYEoiNR5WOZpeWZsIUQxK587z6fGIM29xeX
 +91d5fpa95thA7IBE0krvhqLGq/SD8hOJ/oHoUXZroxc9EQj80c28R364sb3zBcrAcOEs15XV
 opK5lQe5oIPnsieBjrk5PSHS7n551QC0Ay7JsgYMJYTxUflOfu2RFvw9qdIIeotyI8AbTa7U3
 5b6zRQgWyS25cifJHWrKFJfWXC05DP3tKQvoHC/0+DICgK+XYPUq7HeG7/fexbVqdEXg0hMfT
 Z2F/FEw11WUgNNu5XhftfsSflbu95+qjxjdAr3fsN7SR89jMFmHO8GYlQZlTXGBySTdLG2/Hp
 o1tkm4z1Aojx9kEl4dQ6CHsrLkno+keAFS0/P6P6rtiYDWRHSchkcEVLpm2cOqPm5JzyeHgyS
 kGOja9DJUKMcTVgJ5ymyOe32ikcL4jjsNwiNte5812euowK1biYx95xDxc5HO9NOfAMUZjEUE
 j0hPDOib8v50gfkMzXfzs8OSea2YCuXqP6uh0QwodEuccTNAFhBULj8U5Cmkln71xtILMIYXv
 cXUa86o/3m8oCWpuGlDWqId83XIB37LtyavaNfFeNnOyLbxkFcPww+tbrdgmtJa3CTLno15z2
 n9YEwbFOC4T3P8s+5NeklKzNEFNURwidrkY6pRZp4ODev3KFYHPVOxpaQyELli/wE3kCo/oyJ
 b3dV/MdvSEDZ7Oe4ydli63Lm0DQE28oTDPkBzRiO1a8eFniB2aavCgA4xf+E7l3tlHL37fDVY
 sH5IbT2rb3cfk66znN/guf/Iw24AVPbFVZA4goGM7PJOKpVx5MYAn63AYZ6m/T5GM6TLBooOq
 PmyOGx68FnJH5w5DPo5GbHLZskPeBDVcb6Dxol1f1gBFeu8QGv79IbOa4wqJ3KlB5rE7SWtnu
 UZz6yDo5oQRijzclwmEAat0ek6ltFgS9INdJlEJtGc8IAcs2GK/NY1tpPSfTYK7rItIBHqF/Q
 bII7V3KTTO9L78miCiBgGAOIwuX2MvUR6n4MrscwqGyjAPQOv/fyF4MIlk+IP0iJ8MVguuW9t
 hDEmSC6wmzQk2ssMShd8SrK9MMC5ePu+I+TtKqqreZZYx3FSWTG1QJ69LqOUX0K41FZY8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-628890981-1567465276=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Sat, 17 Aug 2019, Elijah Newren wrote:

>   * t3030-merge-recursive.h: this test has always been broken in that it
>     didn't make sure to make index match head before running.  But, it
>     didn't care about the index or even the merge result, just the
>     verbose output while running.  While commit eddd1a411d93
>     ("merge-recursive: enforce rule that index matches head before
>     merging", 2018-06-30) should have uncovered this broken test, it
>     used a test_must_fail wrapper around the merge-recursive call
>     because it was known that the merge resulted in a rename/rename
>     conflict.  Thus, that fix only made this test fail for a different
>     reason, and since the index =3D=3D head check didn't happen until af=
ter
>     coming all the way back out of the recursion, the testcase had
>     enough information to pass the one check that it did perform.

I fear that this test is still broken, it is a Schr=C3=B6dinger bug. Where
`qsort()` is the cat, and the property "is it stable?" instead of death.

In particular, at some stage in the recursive merge, a diff is generated
with rename detection for the target file `a` that contains two lines `hel=
lo`
but has two equally valid source files: `e` and `a~Temporary merge
branch 2_0`, both containing just the line `hello`. And since their file
contents are identical, the solution to the problem "which is the
correct source file?" is ambiguous.

If the `qsort()` in use is stable, the file `e` comes first, and wins.
If the `qsort()` in use is not stable, all bets are off, and the file
`a~Temporary merge branch 2_0` might be sorted first (which is the case,
for example, when using the `qsort()` implementation of MS Visual C's
runtime).

Now, the _real_ problem is that t3030.35 expects the recursive merge to
fail, which it does when `qsort()` is stable. However, when the order of
`e` and `a~Temporary merge branch 2_0` is reversed, then that particular
merge does _not_ result in a `rename/rename` conflict. And the exit code
of the recursive merge is 0 for some reason!

I don't quite understand why: clearly, there are conflicts (otherwise we
would not have that funny suffix `~Temporary merge branch 2_0`.

The real problem, though, is that even if it would fail, the outcome of
that recursive merge is ambiguous, and that test case should not try to
verify the precise order of the generated intermediate trees.

Ciao,
Dscho

--8323328-628890981-1567465276=:46--
