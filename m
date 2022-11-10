Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF7C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 12:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiKJMug (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 07:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKJMud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 07:50:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517A6C701
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 04:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668084617; bh=oaZ/rc3anoqUOH/gFEc2R6xN83/fVA4KjyF4O7I6is8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jeJgwYzq6Er6uzqHWXwO/K1QGZKRqFaTlPKQMhIJTsPyPeI3c+DB9TMK32rkbvASs
         cMGBmFboVUyuViNgEHjwYs3CPsN8DA/kUnLJPLNWYYGfAo3bg9cbl67MEOtsX7cX9j
         Mo59t0aj0VI/beWmHRmRbdyOgoLC76RJkMSKWJ4voMevITAb/hEmS4cWINsb/OTbJS
         LdOXriwdX6jhMGp/3cgdnPYOllhxlWP1VeDT8pGVbVcYOYCZFXG5aBR9oumsCFzJ53
         P2USjgUeY5yjnoUFtcnW51g7JLfar+oFXjKwhXzxEwI/NeHzwPAD1Sf28KHyB/QveT
         x6hsjaQlYqfgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.167.171] ([213.196.213.188]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1pPQt52Mog-00dEYI; Thu, 10
 Nov 2022 13:50:17 +0100
Date:   Thu, 10 Nov 2022 13:50:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Luk=C3=A1=C5=A1_Doktor?= <ldoktor@redhat.com>
Subject: Re: [PATCH 00/13] bisect: v2.30.0 "run" regressions + make it
 built-in
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
Message-ID: <2477861r-9363-75sn-q415-o19206q70p90@tzk.qr>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-739220130-1668084617=:16139"
X-Provags-ID: V03:K1:l+Ez7drc2AUROQq4mO50A/VULKDJL+Oy7LVVfz/7K6uTawyYR/O
 XrLH7YB78RI1Er9aDpnjpFmXtqHl4NIZBbKNqgmWZxQ9Gd018+NV4RZMT1v7XSk8WJUYngW
 lf2DiFEIRjQ98UMQm7mx5iEzT1kctGEiIAjqh/RPVaN4lLmvFqFle/6ddhIiacl1oMu+quc
 UjNC0WYm7hiW0mMR5gMiA==
UI-OutboundReport: notjunk:1;M01:P0:VfS5KpQI1XM=;x4azzovXk/ShyeDbER+N4nlQL6H
 1oa2GQroN7yRnK4y5FBytN0yYhI2QoBYbf2/6uF4T7qBlYtm2QjZZeM4oB0S4ZM9rPuFk0x7o
 NCo1MMbC0oRkvttbCDdXlctJcvbuSADnIJT/pp+0NRPNocceUN87Br1FVlAb2K9zj+EDZEtoU
 NSlNfrbIGYvOxaLlegtZSwqCzy3vA2nq7ZKth+TGP5VMNsVvrElS7ogZYyedZB+lsBfi5KO7B
 Qp7Psy01RqtHhL83WzBA3dIK+LcmL+8uFsfI1B22/ZtG0bUCs9od3iyRQL71jwuKxN0Zw+ftC
 dVwP0ruYo0EHb3F/KsEf1AWKPBK4R12llQnxE5qyTXHIuvuOB4LOPPCv5kJG9IqZwT9NJ6Qc5
 wp1dDrZgl8aB7DXbqtGPkUObVU++G2mTnMpy3DjAM7nLDVkmqSdtEnMnlp5CNHUKVKOqbRJwT
 yH15Nx7r7hqsUDvT7FY0d8JUgb4y70pNhficDroZ7tzvapxtZq3DJiWpb9+rNEh0fJgdeu6sP
 6kM0tX3DMdHF+VY+2FYydb8fwKUvIvPKVYN2teEEr4TbdZ7sDpl2r/z3+KJuZOT8NyjIjIIWK
 k8JbPcrMoerzATf6wUO/8JdwqWU7069+IpDyskQDfhzC4s4DXzs8HLkqg3Cz/o9ToZVjaV9RT
 KrOF0r+WFQTNhmkbFRgrJLCh4qlKcWXDYX8GhYN0O6wkg8ZdNRK33qwWaiaXg0y9GsNqF1nyQ
 DDqmsFoRKUVJhtBux7ohSQyYLhy6i0ecnmUyEuH12t4JTqKasU3AHwQSjSb+P+mxbABjHwRqy
 fc4PhxBPIEaa23zGmMPW2smImTKDOo8zB97hZGZux5W20JBBTgQr3YkXt+9RRIApMmcNHUBiU
 Urt8ssKVfNVHJFnIWkubB8HOnU66zhFEEx40zkZAii3bD2Rt9QnTn28fC8DHE3iw7eP6SCJyt
 mFVTovaCdfaeLmtD/IOlWRPKzcc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-739220130-1668084617=:16139
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

I see you Cc:ed me on this, but I have to admit that I am not motivated to
review this patch series because it seems to be designed to interfere with
`js/bisect-in-c` instead of being an honest effort to help me get that
patch series over the finish line.

I'd much rather see you assist me in the most efficient/minimal way
possible to get `js/bisect-in-c` into a shape that can be integrated.

Ciao,
Johannes

On Fri, 4 Nov 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This fixes the regression Luk=C3=A1=C5=A1 Doktor reported in [1], and al=
so gets
> us the full way to a builtin/bisect.c and "git rm git-bisect.sh".
>
> Only 1-4/13 here are needed to fix the "git bisect run <cmd> [...]
> --log" regression Luk=C3=A1=C5=A1 reported, but as Jeff points out we'd =
still
> conflate "--bisect-*" with the user arguments. That's fixed in 11/13
> here.
>
> The 1-4/13 here also fixes other but probably more minor "git bisect
> run" regressions in v2.30.0, we changed the output in a few ways
> without intending it. 4/13 gets us mostly back to v2.29.0 behavior,
> 5/13 keeps the best of it and the current output.
>
> I think for the v2.30.0 regressions we're better off with just
> something like 1-4/13 here for now, and possibly 5/13 too.
>
> But getting to the point of fixing the root cause of "--bisect-*"
> being conflated is going to take quite a bit of churn. In the
> side-thread =C4=90o=C3=A0n's diffstat is on the order of 1/2 of the size=
 of this
> series, and this gives us built-in "bisect".
>
> The 6-13 here is something I had already for a couple of days, I was
> seeing if I could distill Johannes's [2] down to something much
> smaller, to just make a beeline towards a built-in bisect.
>
> Johannes's refactors the "term" passing in [3], and =C4=90o=C3=A0n ends =
up
> needing to do much the same in [4].
>
> Here in 9/13 I instead just extend the OPT_SUBCOMMAND() API so it's
> able to accept function callbacks with custom signatures, which
> eliminates the need for most of that refactoring. 11/13 then makes use
> of it.
>
> 1. https://lore.kernel.org/git/1cb1c033-0525-7e62-8c09-81019bf26060@redh=
at.com/
> 2. https://lore.kernel.org/git/pull.1132.v6.git.1661885419.gitgitgadget@=
gmail.com/
> 3. https://lore.kernel.org/git/92b3b116ef8f879192d9deb94d68b73e29d5dcd6.=
1661885419.git.gitgitgadget@gmail.com/
> 4. https://lore.kernel.org/git/081f3f7f9501012404fb9e59ab6d94f632180b53.=
1667561761.git.congdanhqx@gmail.com/
>
> Johannes Schindelin (3):
>   bisect--helper: remove dead --bisect-{next-check,autostart} code
>   bisect--helper: make `state` optional
>   Turn `git bisect` into a full built-in
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (10):
>   bisect tests: test for v2.30.0 "bisect run" regressions
>   bisect: refactor bisect_run() to match CodingGuidelines
>   bisect: fix output regressions in v2.30.0
>   bisect run: fix "--log" eating regression in v2.30.0
>   bisect run: keep some of the post-v2.30.0 output
>   bisect test: test exit codes on bad usage
>   bisect--helper: emit usage for "git bisect"
>   bisect--helper: have all functions take state, argc, argv, prefix
>   parse-options API: don't restrict OPT_SUBCOMMAND() to one *_fn  type
>   bisect--helper: convert to OPT_SUBCOMMAND_CB()
>
>  Makefile                               |   3 +-
>  builtin.h                              |   2 +-
>  builtin/{bisect--helper.c =3D> bisect.c} | 250 +++++++++++++-----------=
-
>  git-bisect.sh                          |  84 ---------
>  git.c                                  |   2 +-
>  parse-options.c                        |   9 +-
>  parse-options.h                        |  31 ++-
>  t/t6030-bisect-porcelain.sh            | 109 +++++++++++
>  8 files changed, 277 insertions(+), 213 deletions(-)
>  rename builtin/{bisect--helper.c =3D> bisect.c} (86%)
>  delete mode 100755 git-bisect.sh
>
> --
> 2.38.0.1452.g710f45c7951
>
>

--8323328-739220130-1668084617=:16139--
