Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBC3C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35A62077C
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Tf/fKUg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgAPKsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:48:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:55085 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgAPKsv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 05:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579171723;
        bh=canp/lk5MgUEVqAg4LYRBnr2c1Jx2b6d9v2ITggxCwc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Tf/fKUg2xur3PeCRrO3xvCtkozx7VFr9BQk5NJe4w3Al1cdP5G+d9me1+PqLP7Re8
         eZjjdX9Uxo8/xWwrNkECGK0GDfBQqf3lGEix0hAUa6E1mXm/a7yJr4A5tXJQM3nFDA
         W/KGkHK1U1Zbr5qs/sy4NkuC9xtMguyPbI/XhaCw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfYLa-1jXx223UXw-00fx6F; Thu, 16
 Jan 2020 11:48:42 +0100
Date:   Thu, 16 Jan 2020 11:48:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am"
 to "merge"
In-Reply-To: <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001161146460.46@tvgsbejvaqbjf.bet>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com> <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com> <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com> <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet> <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:57gwE3pjjLf2j/VpX+uBqlW7GdrDqD3s7DCbYi54pQva1st+hHJ
 5QOvGvk0sGVZR+FdZfUfHQg5XDuTZwBjZaWyTxl87wsuJ8EnYoiGXk1JfAKr17KE4/OvKU4
 IUDLHk+PZ4sF70RoahjFACnCwiT7kPjUP3cz4jH+gFleje2dy+wABB2PJPLluaQ2GojiwNB
 K5haEsBXDwmerMFQpergw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I8FZSdYxCqA=:pkxFmdt8N4bhEyoLnI6UOn
 V9i/c3PrKlaZKtG/Bts4Vwa89FIIGBY29pFQ1VmBwFTGw8OChd2jJBhdWPeKOYUMGqnXlSaoR
 8M0ijFBM5/EydTbq2WyDtXgxHzouY+VmaO/WXyHAeSRTguUgox3ChUEMSYWI7NQ1+I7UKHKtG
 xeDa6WltubLP93m9+v1snwDgc7HGZ8Ug5Fcyu6+i+FoBe+LOZCcFGZHPE+Z4adK2Th6Zl21a3
 QRA/pnKL7Y3+YjfucUWzEtgAu1gJMctqo8Qeg5PRNgAtY0IhptPsV5REYX0CNfqxLKUx/Qwqv
 y8O0hjvbwfOEbt38AvKFxwaM2u8NX74o75neRdGLw6oyr5uUHFUFjvyssI7Zwl24jpKjkY5ph
 ziW2UHsdUxzPqXNPuQTXaNIKmXfkOF3lSmRB8M5E521TjZgitcU3O+OHRLUpq92PDlRqi8bZL
 rgQwlIzFe0lVm2DTJalJgbN5Z2biU3O//UFcemzaIhvOOD3cEZi0WK2VuYUs+mvs2gQn5iTes
 QliX+l8aVfPr4eyHawtQSIzYYuyq/K8NMhP92Ge7PvF8UbZVCTZryGl8rtxCbxrRBbSdxEz0m
 G1NAE3zCwfxEDCqDa2ANBbtLnmuwM6gKHWei/OOe86fGAiMF00IObBv1xW3AaQCNqI3jcCVLN
 KQ5DzgrbXCGHLau/9unj2uh08HMqaq/fRVlHRnJ8jMhrwGGHDn/tsTSQSWOZ0PWmPWTjEKeAZ
 J37klO+gv1l9nKPXO+PzjJho6MyhjVBmx5G+8sSPKvg1tc9ZwrMkLxOv2mTmZqZPTr6SAr7qF
 mzs2UQXTWKgSEZw5/r62INhmp1e49zzCD9x2Yezc9LYuoTdgbVgos+AXuDgsqnDI7q/EJxRLs
 SS8hI/GgQE1WdYq3FZJIeOykcLhUKlGXqEjaAoQd94bWlF2Z7jJtmlkQ7pzIRWSUZKo80QvEJ
 QV5HAjgXbHaSlVUd5HIa6R/uQ6DZyuxuZNOkBYmWXciPc3/e8Eh496VSVctAcqzAXiAep23Jh
 t4yKk9b8NaSF5+3wbX9oEKSAT63VRfA6SH/4vulZC8kfEbLbxLzBCGhHtBGmCm3rAQf9seqMo
 yEStahVgUwlifbZVVBYLPvqYrr88StuTNalu6feGZQ2Fv0H/+qOd/yHZxlt9swIGWo2g3SeJ1
 LYfUTlpnBphLg7Ox0ndoPs4ohr6/FdW7168NyoOeoAPJik/uZlBFq0Z9nGltr2yz4Iw8L0reS
 WcdG0AJG9VR+/950pqAGDXbCUYuYhq4a14wtiYXqnsSwP+nW2ksunRENlV+k=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 15 Jan 2020, Elijah Newren wrote:

> On Sun, Jan 12, 2020 at 9:59 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sat, 11 Jan 2020, Phillip Wood wrote:
> >
> > > On 11/01/2020 01:16, Elijah Newren wrote:
> > > >
> > > > On Fri, Jan 10, 2020 at 3:14 PM Jonathan Nieder
> > > > <jrnieder@gmail.com> wrote:
> >
> > > > >   4. I suspect the exit status in the "you need to resolve confl=
icts"
> > > > >      case has changed.  With rebase --am, [3] would automaticall=
y
> > > > >      invoke rebase --abort when conflicts are present, but with =
rebase
> > > > >      --merge it does not.
> > > > >
> > > > > Known?
> > > >
> > > > Nope, but I would certainly hope that "you need to resolve
> > > > conflicts" would result in a non-zero exit status.  If it doesn't,
> > > > that sounds like a bug in the interactive backend that we need to
> > > > fix.  I'll dig in.
> >
> > Yes, exiting with status 0 would be a major bug, and I think it might
> > even be a bug that was introduced by me when I re-implemented the core
> > loop of the interactive rebase in C.
>
> Ooh, that sounds interesting.  Do you have any more details?  My simple
> testing here shows that we exit with status 1, so we shouldn't have that
> problem unless perhaps there was something else in next
> (ra/rebase-i-more-options??) or some other special conditions that was
> causing it.

Oh, I did not mean to say that it exits with status 0. I meant to say that
_if_ it does, it would be terrible, and that my suspicion would be that
the re-implementation in C introduced that bug. But as you say, there is
no bug, so for once, the re-implementation in C is not at fault! ;-)

Ciao,
Dscho
