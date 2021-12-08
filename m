Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E934BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhLHMud (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:50:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:39211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhLHMud (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638967592;
        bh=JkHT8ovL6BNBpOurtFDONeXWRnU8nQsSyyyctjHqA3s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c55/pYjy5U0wLPR20IMeBHBYKTVv3LlDzb4DbizdRwQvdoGdTqNPUa4NXfNjLZ3MO
         w19heTJcJ4PNvTGK7igpLiImwG+OcWkfhOEqDm4k7J9Z4o53z7zwgKwuQ8cyTbFxm4
         +kQNyH3IcRfyz3Ll8USyfdpOd8ubHRgAlQTyoL4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([89.1.212.223]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1mlqSN2cRj-00HRH3; Wed, 08
 Dec 2021 13:46:32 +0100
Date:   Wed, 8 Dec 2021 13:46:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: en/keep-cwd (Was: Re: What's cooking in git.git (Dec 2021, #01;
 Fri, 3))
In-Reply-To: <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112081344290.90@tvgsbejvaqbjf.bet>
References: <xmqqh7bpqhf0.fsf@gitster.g> <CABPp-BGdvOhy_g8vtRogqL2vPkZEtP4+N_5x0rhAWrX9x43WWA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x4dZB1P7ESLQVRQwhr3RJGJavSSS1q2GBm+hQf1jEtXPnuA+qBq
 959PhwG9elT7o2wL5FyTMCncXsVD3g1il44iPYtG5SFalSL0k7wPXkL00WZPO1BlGAvYiil
 yyFivHP/95UxCdIvsRmmosm7ToTnJjsq/buE6m9OiUpvcOhdACrJyicf676ca42S+Mn4dUL
 7KbVsPO1Vfsu3yYCVsfkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xUK5S40cCnA=:HLapssCbPvaQ0H0UJcyy1c
 5ZTky9Yq7npK7+33LIhVroxmUYzSTbHdyJS3FnMAmgmI3eNWWfbsqcnBDBtrjnINygw4YMseo
 VttKtVB4GKA8f2Fcn1TcVfXlePnyxapaUcgbeOyDatHFM1m2zQ4n7RF3u1CZRpfVHma4KJC+P
 swpgkmfasTCK4KgM7sGd+1aKkQqVwUSPrMkWhKrwIUrG6030F79fXUTTpUZdUsyMH4g7cuXij
 KZGQ7XYt5/kUGaJiO1NuBj2LbdGr/fHQz9EFSUhuIKlI4dC1LbhWqUNLv1fqyluXFk1D1Df30
 c0MMoBHGIVr3zFw6faiwrj80L8kxNTkHNDpvX9jxBEDV4yxuzgIZND5xNqpDhVWrEkZbt6AGz
 ce//1OEpy6Bleni9qWN8cnxRz6YJFZT3BKlvyvkdG7IKanchYwpY/D/bIWi4b5N2lcull+GKD
 Fr92zKWfVtnMFJiwcbwkM4UWAyZqFUt+rgHVSIxUg9ZjgKv1+diD/cio+yO6OkIkztY2UHQ5L
 2cKSwCgJzLJE9lRfHibdQf5un40JWE7xRuevX1NuCYPLqw8mAPJir/HUsiQHDyyDvcJC+42LB
 vHm6X6hhFVi0Tj/dEoc3C8NEYVrXjYzAWYABtBiBvUgPg4IOnRfbPrEtB7OSh7TJs5O0QgR5U
 5gkKtu7VJP5GFfXVwHqVUjJEBRj0ONwZIKaOYcqDXZoykB99hdR8BpZBaG9jnc8qKCjgPO4Mr
 3AeByCp87zlmYsG+MMKecsOVxMGHn20pxRwf+M5CQiWQ4jMa37oWCezOJrRnstig3+KHFHSms
 MxEwCsxSCAorNmkvVhcN8qO0lmKPgsEfWvX7oPlshFB/cP6k20Qp82PdRz5SHAxXcEGY1Pb/p
 EsTCtHgPl5s8qdo9AVyX811nJHHGPdPALpyqrf/8Te2GEMd0d13/eCbPw1nAWcVn2ZOROtp/t
 C95MZONUuqEt47FnZvMz22NjrAjsTHfk4QCOX576xZ3BBdBRJHUFku0bGClWGuglBLGGNoNFk
 hcoE4eUZ1jh4HhR2fvCCRFy14ACQS3vgOnV/nb7Vmi5CEvD3oemhcqjzVJJsz9/qLNdaCHANf
 uXdSpYBeYxeKts=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 6 Dec 2021, Elijah Newren wrote:

> On Mon, Dec 6, 2021 at 5:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > * en/keep-cwd (2021-12-01) 11 commits
> >  - t2501: simplify the tests since we can now assume desired behavior
> >  - dir: new flag to remove_dir_recurse() to spare the original_cwd
> >  - dir: avoid incidentally removing the original_cwd in remove_path()
> >  - stash: do not attempt to remove startup_info->original_cwd
> >  - rebase: do not attempt to remove startup_info->original_cwd
> >  - clean: do not attempt to remove startup_info->original_cwd
> >  - symlinks: do not include startup_info->original_cwd in dir removal
> >  - unpack-trees: add special cwd handling
> >  - unpack-trees: refuse to remove startup_info->original_cwd
> >  - setup: introduce startup_info->original_cwd
> >  - t2501: add various tests for removing the current working directory
> >
> >  Many git commands that deal with working tree files try to remove a
> >  directory that becomes empty (i.e. "git switch" from a branch that
> >  has the directory to another branch that does not would attempt
> >  remove all files in the directory and the directory itself).  This
> >  drops users into an unfamiliar situation if the command was run in
> >  a subdirectory that becomes subject to removal due to the command.
> >  The commands have been taught to keep an empty directory if it is
> >  the directory they were started in to avoid surprising users.
>
> Very nicely written summary.
>
> >
> >  Needs review.
> >  There are some comments on earlier rounds; the latest one needs a
> >  serious review or at least Acks from past commentors.
> >  source: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
>
> If it helps, there are two parts to the review:
> - Do we want this feature?

Not that you need yet another "Yay" in favor of this, but... yes, I think
we very much want this feature. (I even went so far as to adopt the idea
into the Scalar patch series as of its fifth iteration.)

Ciao,
Dscho
