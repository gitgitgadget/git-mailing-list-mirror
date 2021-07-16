Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE42C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A78B613F1
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhGPP2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:28:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:51081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237326AbhGPP2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626449140;
        bh=lTnEqbLGJ8wZIM08xh6/kiOyph9Kv0ngp0EJ36mQm0k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OmxtA3M6ta4aaPLCPHroMo43Ev68IwLVZu0zadLmjd6jPidsi0i1ao4BO1TbBNPbd
         K/KPITj1h4WXJ5qQrG1sWS8tWjjdEyQdjIoNbQX0DDpniqrCI6EKpdLWbCY3ATwyTn
         4ynPP70oHL7iq/TC/mvTgiRbHErdzHiVZ5au8a9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU4s-1lWApU0fvI-00aTUs; Fri, 16
 Jul 2021 17:25:40 +0200
Date:   Fri, 16 Jul 2021 17:25:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <xmqqsg0gttt5.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2107161714290.59@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com> <xmqqbl7525w7.fsf@gitster.g> <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet> <xmqq35sgzy0d.fsf@gitster.g> <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet> <xmqqa6movcly.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2107142350570.59@tvgsbejvaqbjf.bet> <xmqqsg0gttt5.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JtrEsw2QGw4qgItnAfxa2wWLaaGAt4tGdYCTPlS4407vvIoe/Rl
 EDX8zYr6SQigZbjARlx6jwBWVzd0ZkOtuM2Tfo5PaqJPI9M8ipuGiyRsdp3eSnmAbNoqp4C
 ZECf61kXl+gTpNWuMx7ua90HWRBnG02ZH1ha6DJFlRE5xApO56NOp9I3DV+lDgy6T8+yiLl
 gMYDCFLXLY0MHkzKhLdCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pIj2IEGQReo=:UdgIYHUJIeuvylhepwogRe
 I2wXYo0tmO4UJ9uh/uv9Que5bq5Yq679gzZATda+la/iBWn/JqVZeeyH7e9lzWb+0jYjprDrh
 wfBO0CResebf5T76XhLjMtb1RZbd+FtT0KQQfGuY6F3fxb4Fi2+yBAKkKyYBrz/gqrWdi/8nL
 gSrQrlwpxj059s4k8xWPNvi5U+HcjqXXA09UGEn1gwsY6gArv0WYoy9rJJMrRE4GTHpV71rlh
 RhOaxqd94p7/kK52yMT0JkbY38+TLqiqa8BxH1ZX7HUBPFGSN+zL+dTPUVoP6XKPWi/gg45ES
 M5lUmnmhj+m8EpX/5iTm+Nwp0inzZBjl0SUVm5+xPDw4Y/PadIFgx5DHVwP5/UUkxyoxg5LcG
 wASOYNzpeNtFbm1aDWBrYwW1oW/hP+C9AF+tEU6tK3VuzL4jmArUBH0AFuSczb3clkkb2XM9L
 gIjA2JJB6d/Fghm1RlLQz+1IW7CV0LpIQxOTuhktAtK6vApOjgc8wrBFbkyoBU2TFqj/EOInB
 DFDuJXmsFPqBsEI66sIY/PvAM+pnXEjtllLt6DWurB2wVaafWF1VfWystnuwjf/ppK6rY+Lye
 A/Dx4zhFh7cfFnUvx9vC4Jk3Wmq0MP/gGfhyT9l4lX+doknPegKYeVF+z1xEcancFugKaKWuG
 N4tSiCkInef9/LYB7ZN8TMUAc5Yo2wuKwOh4rgqtPMMV9me4Z2EwN+vCjl2nNTWOcoLTbl5Yo
 TIhR6/f6vNzM9GMQn2Y89xUbE9m+hSJXrClR8mCPej71rV0SaecdZPVXmPeFLQGtqzfDgYdj4
 26oIidyi427bzst+4SLDZ6VK7m86NdThcSdHGU58/FtAGhYyTd9CnU2DeMMRr4HRoS5Aw5Ze3
 m7GgTWJSryrcVeYhRjfsKTxAppCEYSX5PqRTndAlL/R464aBXHmOs/73I5Y1DqZTMYPScto8C
 mfissqgDY6BPGbu2L2AwzlSKyHkCBTUT02VX2BUbq680F3GunIeyVFAUulql9jpuFuQ8U81vs
 nfknep8MSYRUQ5c4hlOsM3jDjs+c3Zd+PkW0N18iq+0m9Yjw+ebTLBaaSOMNywhIWYN1vheNk
 Wu1wGDX18kYPVAuXnBBqmWfnr6KOB1jwV6YNhEd0jXj51la/mWDmXHoPg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Jul 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> It wasn't quite obvious why we justify spending 370 minutes one more
> >> time only to rerun 30-second job, though.
> >
> > True.
> >
> > And this is not a new problem. Every time anything happens in those
> > `osx-gcc` or `osx-clang` jobs (e.g. that transient problem with the br=
oken
> > pipes in t5516 [*1*], that's a fun one), a full re-run is necessary, o=
r
> > else the commit and/or PR will remain marked as broken.
> >
> > In other words, while it is totally appropriate for me to explain this=
 to
> > you in this here thread because it came up as a tangent, it would be
> > inappropriate to stick that explanation into this patch's commit messa=
ge.
> > We do not make a habit of adding tangents that came up during patch
> > reviews into commit messages, and I do not intend to start such a habi=
t
> > here, either.
>
> I do not agree; a brief mention "even though piling more and more on
> the primary workflow would make it even less convenient to re-run,
> it is already so bad that another one would not hurt too much more"
> would be a clue good enough to motivate others to do something about
> it if they feel like it.

By that rationale recent additions to `.github/workflows/`, which have a
much much much much bigger impact on the runtime (such as the change that
lets `linux-clang` run the test suite with SHA-1 and then again with
SHA-256, almost doubling its runtime), should have added that apology to
the commit message.

But that did not happen.

Besides, for all we know the problem might go away at any stage because
pretty much all other main CI systems have a way to re-run only failed
jobs. GitHub Actions will probably get it at some stage, too, I vaguely
remember seeing it on some public roadmap somewhere.

So I really do not appreciate this pushing for including an explanation in
the commit message for something that is only relevant (if at all)
in the context of an utter tangent (don't we have many of those over
here!) during the review of the patch. It's just some curiosity that will
eventually be an exclusively historical curiosity, of no interest except
to a few CI nerds. The issue has everything to do with a currently
missing feature in GitHub Actions, and it has nothing to do at all with
what the patch is about, which is: to add a `sparse` job to our CI runs.

Ciao,
Dscho
