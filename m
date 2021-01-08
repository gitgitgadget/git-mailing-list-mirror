Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B3C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9823323998
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbhAHPIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:08:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:41941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbhAHPIl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 10:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610118424;
        bh=2R7a2ZLw78p5jP1ls+QTfqmijNz7j4is3reuV5VwvmE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B/8FD70mW1GkbIPnvvurocbuN5Z5Fy2Y4f8S98oqMVSBqNA7TOYq4XzvplJxWIxbQ
         NKsfnXy4HuhvDzzhy4wCtTB+uu+f1mBpUcWIuj1a2VQNr2fOebALu+a+wqLg0WUOD9
         4Jmk+9/wGdTTa/Ju/5fCRXnf90I5RR+FhUK5yoV8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1kxtM0318a-0000i7; Fri, 08
 Jan 2021 16:07:04 +0100
Date:   Fri, 8 Jan 2021 16:07:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: Patchwork instance "Submitter" attribution and GitGitGadget
In-Reply-To: <20210107223755.6fg77xjdbqiscwb2@chatter.i7.local>
Message-ID: <nycvar.QRO.7.76.6.2101081604470.2213@tvgsbejvaqbjf.bet>
References: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com> <nycvar.QRO.7.76.6.2001201314580.46@tvgsbejvaqbjf.bet> <xmqqiml4bsra.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2101071534440.2213@tvgsbejvaqbjf.bet>
 <20210107223755.6fg77xjdbqiscwb2@chatter.i7.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YlsjOx5fxshAy9jUPmAegoSHV6TfIo7ZWDqABJbStoqdz/7eVod
 iPNvpQodSuV50/z6hFJb1Hx5Bu6mGO1U9d6USislQfpnn0JHkYKi9nrZd5l3u2bOet23uBo
 ApoELPW9wz2947V5AQQn7+qMaQEAcOOYCaGyKBULVBHNR/4Q6EQMJiKJr46GzRShVZyMYNP
 9vzC9O9VPLVSsfxM7dyHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B9TQcQBWXr4=:tT+6h6ab06RPXnoy0ox4VU
 u5iM+k5LGTum6+hgb7ZcTQAWuv571sMujDY5antg9/H4S/Qop+roSHxwUk3Kub0upMaI7U7NI
 cxOhe4ZnlXyXiTsSocPh77xrfQqf+M3OiA8tCsBrLnnEfYMPYPz5ZXTmSKL+m833PCgulg/dW
 lIEh2qWwAg4ODWf3CN/mVT4hBYu4Hzxf/bUFRN1cpegmb9+YTtrl0XPGAQmIrj7RsyFivpREn
 JuLGOsq2rem6J01VK/fgaVMP+/eCsFPsyx6glElPZvLK6L9933rJmBxjkpTczuqeYWKBCu2CI
 DrYtv7I5Q6yM8ZIxHCJiITYPjwrCE8P/IRATbhMnkUgByEtAboiGXv8S/G5XvZI75wEaeYz6Q
 vac7B7xioa9+owH/GAJSWDn+g2JJ+H1o79co186rVWkZ2+QIuPFQL1qVrxlrAWrJN3p6I1ydg
 +bzjxZ0m7RYUBMGDa76Pa2oS58PFB9VEnm0oH01GoIL0SxHag0u9za+F8S8NodPIBLhmEj68r
 vMt65+R2JoeNkPYVRuxdOJRC1OhLsmunFCulmF2yNP4u7MCPbsNpvVf3BkeP6/AkOrTRZKFND
 E047Qux2EmdOuER8AKfAW0X/Dp9R3xtmk4kJuDY55PFdPIrLD95//YREbaiFXyMzzIGifhp4Z
 A6jUjG/nPRGKoa5A8w1TLghEZFZT2pUseG1J9REYYp84r/qLeAELmxI/vDxVgrkrqXalw4PYS
 kzffpSDD+GpkCYo0kA+24h9gO9X31IhzCphgoEP8a3QNKS/ra4sdK/q77oasZ2MJNmi+FmcUk
 POswnV0x+GisuCY7S+J55OLFKgovINja2k9ORQ+JqFc0tKliRtAPr6ZBsFPHFG9wsitkWBc3C
 hBEKiG1/jRkv/Ze3vP/qjI+sP2L3vliCPIEZfAK1s=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konst,

On Thu, 7 Jan 2021, Konstantin Ryabitsev wrote:

> On Thu, Jan 07, 2021 at 03:35:54PM +0100, Johannes Schindelin wrote:
> > > Would it help to use the "Sender:" header?  IIUC right now GGG
> > > records its name on "From:" with its e-mail and a human-readable
> > > name derived from the author of the ptach, but if it can record the
> > > true author on "From:" and leave GGG's name on the "Sender:", would
> > > patchwork use the "From:" side of the identity instead?
> >
> > To tie up that loose end: GMail seemed to insist in my tests on replac=
ing
> > the `From:` header, therefore we cannot implement this `Sender:` idea,=
 not
> > using GMail to deliver the GitGitGadget patch series at least.
>
> Can you possibly set X-Original-From: in the header?

Potentially. But unfortunately, I am too short on time to perform such
experiments right now. And it is always subject to the question what GMail
does with this header in the future. `Sender:` used to work IIRC, but now
it doesn't.

> Patchwork almost does the right thing with it, though right now it
> expects that the From: will be set to the list's email address (which is
> only correct for google groups).
>
> We have a workaround for the current situation on patchwork.kernel.org [=
1],
> but it requires parsing the body of the message instead of just relying =
on the
> headers.
>
> > > If that works, it would have an additional benefit of not having to
> > > add the in-body "From:" to override the mail-header "From:", to avoi=
d
> > > attributing the authorship to GGG.
>
> Using the in-body From: is both good and proper for such service. Trying=
 to
> put the author's email into the actual From will run afoul of SPF.

Indeed.

Therefore, I would prefer to keep doing that in GitGitGadget: send from
its regular email address, and add the contributor's info in-body.

Ciao,
Johannes

>
> -K
>
> [1] https://git.kernel.org/pub/scm/infra/patchwork/procmail.git/tree/git=
.rc
>
