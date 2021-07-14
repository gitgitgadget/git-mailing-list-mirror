Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B910C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F012613A9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbhGNWGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:06:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:58115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGNWGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626300233;
        bh=PO75DxdAULe3nB53GAaUwnlyJl7Zj5U5Vo7rDnadmZ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eXTkBgWbVW6z1bwPuuwIW68C+Yayb/OfhUOVrqwU2OQfGjqZol6YCtz2t0ZdWz0uq
         wD26qHGFCLhdYV424i5vxzUeoeXB72O8xC2Sv8eKJc5GhsV4IhvKMoqmDvbX8kYsXV
         hs9n0ND2RYp6i09UNyVFkTkKhybMRVp/e8xTn48Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1lTtvv3Qg7-00aAQf; Thu, 15
 Jul 2021 00:03:52 +0200
Date:   Thu, 15 Jul 2021 00:03:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
In-Reply-To: <xmqqa6movcly.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2107142350570.59@tvgsbejvaqbjf.bet>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>        <xmqqbl7525w7.fsf@gitster.g>        <nycvar.QRO.7.76.6.2107141124530.76@tvgsbejvaqbjf.bet>        <xmqq35sgzy0d.fsf@gitster.g>        <nycvar.QRO.7.76.6.2107142252060.59@tvgsbejvaqbjf.bet>
 <xmqqa6movcly.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tYzVPZpZRd5mwuzNoX+YJofAqRcT8OdpqMOujq+d8agePv1OKgU
 duM4DZDYqcTZJh2BJf7SIJA7jf5YOBlnk/7k9tdgGQh2f4q0sbrHzNMt0PHFIunKgT/vWQK
 LhlP++gumsy2O/N5aX5whBfwjDtef1lJDVUKXBl1XFXtvVioJN3YYfjMr9VocibB1NNtNqv
 N3G3fzsGEn7B+z4wqY/Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dTHzFqiklFA=:dMmiuclA/QxIzYKqprTzFS
 uqsNTwQhU5cF1R2Ib2Pq+VjMZD5tsgkx2JzpUkYPrPz00eQ5FQoM3CQSABRT2IRWNMPro0KfP
 mz1V7ZaxO4EdZxdKdLJl73tI2hjy4Ctq/5Tz2wjF+DAv0jLWFfKYOwhQHw04H4bA0hUl8wlZl
 h2ZQTW3oXzeFSxf3Zq1wXx2nRMjvbaE3/jJVK8DSqcZC5S8nCmBlNRv76o2df2FEH9TNkN3HN
 oYstBK3KymZEAXZ0DJVsiZXAvUpI1+P0/UXRMBXG5xucxXQRwV5X1Is/fC6G5Gs8JHfFTLIOq
 9GRX/byxfpJ76GP8vHWmkk57E2WU3bYnpyFuTSBRBiFA72KDIZttIWx0oT8Gu6ssTikN7dJZ5
 AMBSvj/oQnvJ6G5xf17O+qdJw0IjKaLLS9Bp95uVGJgd9PDFXQxP+YTRk2KpgvBn9XrHK+zOu
 BeWPjEv0t/L8RjUEXIBYf6Gy+pkp6DK5yIPgPXnv4LnoxRp2scnU7pMWgaKBW596+UVJn4DBm
 M0tmbJVLQcZwD/ICZbUVLujo121hp5tUPaRH1C+PbSlcqOxAv1lxx6aYgrwGLKV68V2GzBwIs
 KBxxP1xxIW5I+DjkG/aG9ZpMU59qVLMlYme3zdnChhRSSubDxD1l1lKkU5fqGjEHhKkfG6JtT
 iWbKt2Mj1u2vWLODP4NRx3mOsGrpQ/iYP8CbBWbAPlkV7pa4Suf2tqYu9ZedqsIYRKzabJa0E
 3X0/6UWpx+C6bPPKeyXfV/sPPFyyW5f8/1T0q8tncZorYu3lj3gDlJ1jrQG5iMidYYG1ww8Ov
 J8JRK7tCGcPT6+GhDaealUHfL5cct9bbhi4erksHWlrxW/iKsMBgGbuQbWyKw+irlZEWpEFGB
 tzuPzn3sDxxFiK7+SKGLIkyXy4A6juAbbdvQYdFmEpkSlr7xiVTH3cSwlzbcKWk9798ZNyQd1
 wHOZhDoQ4v7Ef4FfqYg3NzLWu/QyEKZ4bpbgl05HwYEINHxFwnjJ7mV7h4GTO8SWsjkAFugR+
 ubaIVnOuKqJwkVtR0koVDiYvlUMo/arahla1JLm6SSt+t7rLufNgPWhZ+yZmv/CJKdHzgKlPM
 HQoLxFEzlhC7c4a9+ixPuWvM7IbtQMe62Vx1PMHnBX9pIoU7+n0kqm1Ow==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Jul 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 14 Jul 2021, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > Which means that the likelihood of a run to fail increases with the=
 number
> >> > of jobs in said run (even innocuous problems such as transient fail=
ures to
> >> > download an Ubuntu package), and it also makes it much more painful=
 to
> >> > re-run the entire thing because you may well end up wasting a grand=
 total
> >> > of ~370 minutes even if only a 30-second-job would need to be re-ru=
n.
> >> >
> >> > Having said that, I think you're right and the upside of keeping th=
ings
> >> > together may outweigh that downside.
> >>
> >> I wasn't make a request or a demand to change or not to change
> >> anything, so in this particular exchange there was no point where I
> >> was right (or wrong, for that matter ;-).  I was asking if there was
> >> a solid reasoning behind the split, and if there is, I am perfectly
> >> happy to see it done as a separate workflow with the log message
> >> that explains why it is separate.  I am also perfectly fine with
> >> this rolled into the primary one, with clear reasoning behind the
> >> choice recorded in the log message.
> >
> > I do not think that it would be an improvement to defend the default
> > choice (i.e. to add this new job to `.github/workflows/main.yml`) in t=
he
> > commit message. It is the default for new CI stuff to go, after all, a=
nd
> > we do not need to clutter the message by stating the obvious.
>
> It wasn't quite obvious why we justify spending 370 minutes one more
> time only to rerun 30-second job, though.

True.

And this is not a new problem. Every time anything happens in those
`osx-gcc` or `osx-clang` jobs (e.g. that transient problem with the broken
pipes in t5516 [*1*], that's a fun one), a full re-run is necessary, or
else the commit and/or PR will remain marked as broken.

In other words, while it is totally appropriate for me to explain this to
you in this here thread because it came up as a tangent, it would be
inappropriate to stick that explanation into this patch's commit message.
We do not make a habit of adding tangents that came up during patch
reviews into commit messages, and I do not intend to start such a habit
here, either.

Ciao,
Dscho

Footnote *1*: See
https://lore.kernel.org/git/20190829143805.GB1746@sigill.intra.peff.net/
(I don't think this is fixed as of now)
