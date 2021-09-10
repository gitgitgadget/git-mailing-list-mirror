Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B135FC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87BA3610E9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 10:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhIJKrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 06:47:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:48571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232415AbhIJKru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631270792;
        bh=m5uQIwC02fmC064xgrGDdh5+5PiiPXwPxQ3dEnGfxdo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BeT3vwKZ23nqguRwYV6DV1sgs8To0FnFAgsfwc1Z+tZXTAcVndkJU43DK1L6k27Vw
         TSQAB3I5P4/GOv6/fDjXtejU2FysjSm8W/kpHvLiNRADt4nCG0llgfDWipfBunB1jO
         BI+WuLG3VBN07fXT9A9jZBZXFtRvbcnF+SH1w4I4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1minzj2zvD-00qnFN; Fri, 10
 Sep 2021 12:46:32 +0200
Date:   Fri, 10 Sep 2021 12:46:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 4/5] rebase -i: don't fork git checkout
In-Reply-To: <a4212a67-ba79-0976-db19-334812137e81@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109101245510.59@tvgsbejvaqbjf.bet>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com> <f05dc55f-a7e4-b8f7-7b0c-5000bf48f803@gmail.com> <nycvar.QRO.7.76.6.2109091250540.59@tvgsbejvaqbjf.bet>
 <a4212a67-ba79-0976-db19-334812137e81@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1649643482-1631270792=:59"
X-Provags-ID: V03:K1:hd3Ho5PNroHRWciIAQutQ8uHes6lF88HudJGK0OmmQxhnr0+OY5
 ObMEyZ/xhvG4Kwz8b1ooLjrs9kqIIrLegipQXMELYCSYCOKi5Eh7VlVR4+QZLjAr3lB1yv7
 av+GdGFwuY8XRKG2cqRty7DClB7s3hO0eIbZ7iBpWshlZvgkfV+G3MV1gJLQ29cm2IhDpV3
 mzFdGj487KLvlj3MAilRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2jQMfIAA764=:J9kvEeoEU8V91gCUQ+72XK
 5iKuytFUScSNjbP4Qd9dPFfCtgt7BIU22IJj5bllA8TgRHYviEdS/kV3oyuDp8JQ/YKvXKqNf
 /4dgLtbFfaqRn30BLp7ILEkCmvMk+CwZOIo/5a67OeH4g5ozWkzu6aKnNUbzFl/HRZfXZOG//
 CxL9hfPzB0yZim9FKuX5Xf+0B4az8LiH+jRfxl4w2K3B9IOX89iYulwQ788t5WXGCOMKpVvmg
 SpU7z3t56QMc00x2MR8x8TcZkxNitkv713KVzf33Ipb2pDI8cBjCcQ5OmiUWhvQIhQIpVcSqf
 ncmYwxy/J5sIQfMTAz4xNjnKyLgnxTpQgiq1aXM1gWxn9KYfm3ohwD62AShoL70QJM/R1l6hA
 npu2V0dsrBmWPlcTWnd4Un8g0CODZ5V/GG8gdWGFnHMdwQIjyEi1BJ/D6LwnZwTwUv04H/KeG
 CoRftnwJlnzhsVnqG0F6y5xJJkTuRskQNrDk88FmdA4Z8CTGa1qn5HwIQZCzdkw1Gn2iyIZYr
 R4fvzgb6/+s7gVKedwB+uo36JYU5KngmV4B7+efCi/BYS2PBZZFezrhOA3Dcf1YL9vlzmzmlr
 Jumb2wUkWInprXrOuGoVSVoPfJSwtNoPRdF5KK/pw43cINQu2oyOoE2rCprB9nEc80OnpW2TJ
 NY+oNn3T1gnl16uQD69H0W/E1hZu+1oUPpMA64snKBvp+AZM5QImPOIhHYuzKUPAN79FN15yv
 aNT0JEcIH6fF1I9AnaRQYz4MEfPDvMTTxeH/jUhyey6k6+A26ONEFiO1ajbCencVqoxe4miXp
 sfWo81Hrf3v2zwihvVxfszSQiVEhEX2gc5vp2b4wdSzPeOOh5Z/hLUcVn0i+O85Un2SO1Bzdl
 OUpBM/H1TLNN2FxUmhzCzKVQ4C70mPOfFsdCVJ0LRLXmueFycgiEI2ywx78opyt7ZkANIAzVK
 V8vdga1JjNBzP1VJ8oWRHh5qdMO8ZQJUgU4PYPKjRfixL7OU8pK9/2+IPb4iCt5MA6xaqMR3b
 I39jHOipDXT/+hGQ8sBfGJ2cHv0hBcrZCm8pms+Oja5eM0kKOxc1pkv8ATe2Go+fosSPCtMu/
 QtwkQBnDgYw/Ts=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1649643482-1631270792=:59
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Thu, 9 Sep 2021, Philippe Blain wrote:

> Le 2021-09-09 =C3=A0 06:53, Johannes Schindelin a =C3=A9crit=C2=A0:
> >
> > On Wed, 8 Sep 2021, Philippe Blain wrote:
> >
> > > Anyway, I'm not saying that we should not do what this patch is
> > > proposing, but I think caveats such as that should be documented in =
the
> > > commit message, and maybe an audit of other configs that might resul=
ts
> > > in behavioural differences should be done.
> >
> > Since this is already a bug in the `apply` backend, it would be even
> > better to follow-up with a fix, hint, hint, nudge, nudge ;-)
> >
>
> I'm not sure I understand what you are saying. The fact that 'rebase'
> does not pay attention to 'submodule.recurse' is not a bug in my opinion=
,
> it's just a limitation of the current code... Or do you mean something e=
lse?

I must have misunderstood you. I thought you were saying that Phillip's
patch introduces the regression where `submodule.recurse` is no longer
respected.

Ciao,
Dscho

--8323328-1649643482-1631270792=:59--
