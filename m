Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CFDC4332F
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 15:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiBVP4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiBVP4L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 10:56:11 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BC95E160
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645545343;
        bh=vAl+cdz3mODaLbpYB2E0MmVwjomInNoVqBiCA6LrtOc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SEB++Tk4NmRVqvJQKeLZQV7T5xE3ZGvT8Ms+jejpKLFLyjWTnKnlUU/yGk+6tca2W
         fw2VBombq88CzvAh2QxdctkDl1M0ZeAmuqYwJZXLlQ05SXi5cjSk0lgz+rx+GDwKfc
         2ucjL49rbEyAMFS0t1lHCnepiQ89cf8PIjfgz+oI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1nOBw84B4A-003tpK; Tue, 22
 Feb 2022 16:55:43 +0100
Date:   Tue, 22 Feb 2022 16:55:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH 00/11] Finish converting git bisect into a built-in
In-Reply-To: <CABPp-BEyFmsqQiO8+1JRw3R=XFVOFNXxmEMphPhu-OXVwUxAXw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221655000.11118@tvgsbejvaqbjf.bet>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <CABPp-BHtki3WupjbeyoQu9Li0S0kQV5rXWC0RN8_Pt524iUZOw@mail.gmail.com> <CABPp-BEyFmsqQiO8+1JRw3R=XFVOFNXxmEMphPhu-OXVwUxAXw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qtzvI3nL81UwLSqMQzzGP3Oy8rMesj6vrWuGoq/5eV9kodFET8o
 SiJk/YjknxRsaQKz2NUXL3IQB6AFzWjn3iqfy4KUty8wtJDxlm5FEO0zzqNLj5wmP+aJPEj
 asAgMHgFo8BfdgWP3PT9aeKGPXEcRjf55fClJuxg27nngqZBhPKWxLaeCYfhn1oYVSJmbeP
 HjRE9vACTTJKXNGuw9Ypg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wbMILL6eyd0=:GvPi8DyyHkyKXVwaOGVrsQ
 iatVDHYtbjYmVVv2bYY6XX2/HfLyePnsU1oO6pXIePkPrPiGITe270n4pw6LtyWl4TSqf+8x4
 OuRqxt8YID8jRnRxjbvXU+aimQ2e9xMkXpwl6UdYO64SCNOpHhwhzvf2Bfjw/4l8c/bZz7maQ
 LTure6HhBuy/T3YgU/Ex2VzHD6MPrlZsyIvQUseRPPVetc2FwIJBQft4o14/3g/2FVOabBnNF
 qev9WtYlo08z78HVrykYElQVRiUz5s8BHGcnXwCNmjKfoRbZzN65CsT/ZlR9lU4PlmNm9c0uV
 Q11wMGRwJEH1JH+6x1poHBnFFpH/HypOQeOElYuSYpA4UEqo4q8ZeWYhp88CwpxLVy2Ziix2G
 QXgbTt/rQKUl7aTzQW7dmbtPXVgWBN4fxzbmQOj2tZdM3CzPd3UtCjhZY/AcF6M/IkbyguNtC
 KlIat83r8XWtTdePPrSG0Nhlp9xtDeKGBv36W3+UaOzE7qZmh5e7B9+wtuKIVTGKiG4RpI3Gv
 lKPuxDZ67uXN43kUMK/y10x64zkZZ6kgIcfxaliIjsUVw4YoOgyJH4N2zMTyHiAqQlEiWq815
 fgbco40YEcA1LjLd7Mqn4fLTCWH0q5FImkssJtCgEftOc2fPtydm0L8Mssg4SC4drtAc3Big7
 B33VC+TxonEg/6749y+4MnkQYafuar8ZbqPhEh+iJZP7JqezKI8GbsJlSueVuvAQ9MsX7wJ0f
 bbbr5ZaW3KDeiF/aBGCiEJc8p8f1ofmK9VeNferRc29XNaWy/Gmet+3YRaI0vRKOTE98W96gG
 u2RsA0EudqVaDdRw7oB77IZN2P6iE6EUAwJaukxy77wDmg034WoYMA92sl3SSyIKH4kvR5Kvi
 cyxAaElxtu2NdkQRw1GG9rSxdmEDvzEV/lR3rFPV07+N/RPTCAxg0W8tFIdtKdRynaN3sZD4e
 TAc/Ni/KUyy3LPJhpVi7RlXe/P4BCBHC/3a8gnk/axZYPjk2vS+nYqQpC2M5HbuwUQ9YC4LKB
 uS3M1fdURSi1jgxh0FLMTjSE5M526eJejLcEsFcRAs8lwdUkKgx3awFFwaqqFPmg22RNL+Prl
 2TR9XIHGmiJsYA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 8 Feb 2022, Elijah Newren wrote:

> On Sat, Jan 29, 2022 at 10:39 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 3:08 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > After three GSoC/Outreachy students spent an incredible effort on th=
is, it
> > > is finally time to put a neat little bow on it.
> > >
> > > Johannes Schindelin (11):
> > >   bisect run: fix the error message
> > >   bisect--helper: retire the --no-log option
> > >   bisect--helper: really retire --bisect-next-check
> > >   bisect--helper: really retire `--bisect-autostart`
> > >   bisect--helper: align the sub-command order with git-bisect.sh
> > >   bisect--helper: make `--bisect-state` optional
> > >   bisect: move even the option parsing to `bisect--helper`
> > >   bisect--helper: using `--bisect-state` without an argument is a bu=
g
> > >   Turn `git bisect` into a full built-in.
> > >   bisect: remove Cogito-related code
> > >   bisect: no longer try to clean up left-over `.git/head-name` files
> > >
> > >  Makefile                               |   3 +-
> > >  bisect.c                               |   3 -
> > >  builtin.h                              |   2 +-
> > >  builtin/{bisect--helper.c =3D> bisect.c} | 201 ++++++++++----------=
-----
> > >  git-bisect.sh                          |  84 -----------
> > >  git.c                                  |   2 +-
> > >  t/t6030-bisect-porcelain.sh            |   1 -
> > >  7 files changed, 84 insertions(+), 212 deletions(-)
> > >  rename builtin/{bisect--helper.c =3D> bisect.c} (87%)
> > >  delete mode 100755 git-bisect.sh
> >
> > I read through the series and couldn't spot any problems.
>
> I re-read the series, taking a closer look.  Spotted a few minor
> things (and left some comments) but the series looks pretty good to
> me.  I think Dscho's on vacation, so we'll resume the discussion when
> he gets back.

I took some time off, and then had to focus on other things, so I only got
back to this patch series today.

Thank you so much for your helpful feedback!

Ciao,
Dscho
