Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BF251F461
	for <e@80x24.org>; Thu, 27 Jun 2019 18:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfF0SsB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 14:48:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:33461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbfF0SsB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 14:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561661263;
        bh=btvZiE9HGAOd9BzifK1w4Ro1opxa6hocWCaguoowlfI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NigWZCa6zo5dzd6rpJGEVOyScqqobUAy17cKbfRhuFxvA5z894+vpLe8zA3aNv4BZ
         j1YBti/eUdtuLR+Q0XkRh5I/2Mbly058MR6gaCfPXjxifGI48TrJur5GFKnSVFSyNK
         lkpxVosepMMcoo3XJ7uys6YxfuQfN8s6N6k+FUhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRXVc-1i9GMw3fei-00Sil9; Thu, 27
 Jun 2019 20:47:43 +0200
Date:   Thu, 27 Jun 2019 20:48:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Daniel Ferreira <bnmvco@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [GSoC][PATCH v7 06/10] dir-iterator: add flags parameter to
 dir_iterator_begin
In-Reply-To: <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet>
References: <cover.1560898723.git.matheus.bernardino@usp.br> <5a678ee74de42f1373deeed718fa24d368347d13.1560898723.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.1906261528360.44@tvgsbejvaqbjf.bet> <xmqqwoh8cjeg.fsf@gitster-ct.c.googlers.com>
 <CAHd-oW5zea9wzobAQG4FzN-KSS5BsRoM5vf_x_F83=yqGRfUQw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TZfMDt3WJXMB65XNZWw2lrhYsCp6YX4Fyt6mAXPaMwbUc0NMnv8
 DPenROvD2WFSn4txVYpwyoD9s2Tzk01RSVEhy3rOw6Q8Gqmvv2fIzZx6HFFXX6AP8OqQS7I
 rf0un7iYQ1kaxxEmVRhDAhZlcqo0m5Yer0767M4hX5RZLaKgTmwAg5FMSddVIHJzCWQOSRx
 /6Ig/TLEqYuLn6gzlCX1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HapV3cZLKgA=:1YwGmtMjXhzKEqWdMfu+/G
 a2Hgmw6bHyo1qQWX1AvgPWhXyzlrqiLcd82kwIElIKGIB12RHyZ3syYUsB2OIpBl6evKVSeOn
 mADqTZLg1cZnM1rCHTV+5m65etnQj1Vc8fZs7m1/+XOEgX19PGlI15YXVbik0sAksmfnw+Ek/
 kLW1utnwL8mjCVbA6G6DqCoAyCY4qQO6C4b+scah4QPEyl4gQ8D0HWEuA0J2r/grnes4oTDoV
 ceehjHFMlIabrF8w/e40e3aPqnDCI7s7WAsE+jXvR1/6/M2flI8OX4/Gvt+ytxUECn4jVlPGY
 o596sbXFwwdPdyQLmD2sRjGH4MTrw6IPDMhXUeiDHC6XN9LvWu/TjrJOowsUgJ3tBAnzJwf7W
 RsdZt3bI/pWzkk04Zs96pTyvbjA+EAZfXAQMnkgABFg8i0rVe0nvHFZCricHH2bg36CL8jjge
 39/WR0ss/5NXddo2BWeaiPwEUpvhpVjiQOIi2ARUIMb7pcUeKESLyXzWFH+dD1qVEcjocZlFO
 f7K2PqIMcv1meAk3MxXN+C7dKc9PCOIYELUqhcRaBWtVoQw27YE8lyWUsA8a/0IYfSpGVTVA+
 +WlzbTWjywnDaR3/QY6BTE1ei9CccCMmBQ+bOvMw0UXt7RJzQIQPvpglNb3t+2x86zvgBtNsL
 QoajNMJn89Mujxp13zUZVcPUxMrxnEqsU4vXIxK2W7r64/+ptwyIJCdH0a77RauCdzfhVCfEt
 L/ziFFlobR7/qicL7x3T4slWYl2S2dwWQCGq2HsQ6ZbrAMAVEmEdtC5LdAvO1OD4H49at9jfD
 xgciIJBaqlYJfJTah4r3NQNXsmUji8MsalbqzeIicAAmqnDWW2dr0HbvAzrCinwZmAwd4TVLW
 lHFGGkQIpTprbb5/HcurTef1EFQYSkQ+ZI4AyB+o5zMVlXJvWjQzhnzLd9dYeEA5RkTdO6c5A
 OFjvB8yxIDGSUI35SXmVBpOX1SrFEPrkvEVNxHdvD9uSZPI5bq707YkuHo+VK6dG6nVKk4TnC
 9m7xH2h4o8QVciurKa4jwks0vEq9QiIh00Z1fpwMU7Yw6Pzm+X7IARGkPFOUhdvTJGu/D2fdN
 B403K/7LG/HLexmCbrCU1Qs3mmXR/dVJt0b
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, 27 Jun 2019, Matheus Tavares Bernardino wrote:

> On Wed, Jun 26, 2019 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > Hi Matheus,
> > >
> > > On Tue, 18 Jun 2019, Matheus Tavares wrote:
> > >
> > >>[...]
> > >> +/*
> > >> + * Look for a recursive symlink at iter->base.path pointing to any=
 directory on
> > >> + * the previous stack levels. If it is found, return 1. If not, re=
turn 0.
> > >> + */
> > >> +static int find_recursive_symlinks(struct dir_iterator_int *iter)
> > >> +{
> > >> +    int i;
> > >> +
> > >> +    if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
> > >> +        !S_ISDIR(iter->base.st.st_mode))
> > >> +            return 0;
> > >>
> > >> +    for (i =3D 0; i < iter->levels_nr; ++i)
> > >> +            if (iter->base.st.st_ino =3D=3D iter->levels[i].ino)
> > >
> > > This does not work on Windows. [[ Windows port does not have
> > > usable st_ino field ]]]
> >
> > And if you cross mountpoint, st_ino alone does not guarantee
> > uniqueness; you'd need to combine it with st_dev, I would think,
> > even on POSIX systems.
>
> Ok, thanks for letting me know. I'm trying to think of another
> approach to test for recursive symlinks that does not rely on inode:
> Given any symlink, we could get its real_path() and compare it with
> the path of the directory current being iterated. If the first is a
> prefix of the second, than we mark it as a recursive symlink.
>
> What do you think of this idea?

I think this would be pretty expensive. Too expensive.

A better method might be to rely on st_ino/st_dev when we can, and just
not bother looking for recursive symlinks when we cannot, like I did in
https://github.com/git-for-windows/git/commit/979b00ccf44ec31cff4686e24adf=
27474923c33a

Ciao,
Johannes
