Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3963C1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 16:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfFSQt3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 12:49:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:59565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFSQt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 12:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560962958;
        bh=6ldD1wIIP3pElV690nMMe/kcvfc2O6kr4Rz/OySXJlM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MZDMc1Oky6V/w2ajfDEs0C7SQsJOs1dXDREq+A/IhJcFic8btVOtz8V1c38SVBGZp
         qWhrsD4lAogUiLYAgfeApOwkDJIdkDXg5N+UjsCvLjNvUBmHY97wbqEz9OhmOliCRn
         UflfcYpHJ8LdJr6zlMmd8krHYnkSSvKVpcJLYjks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1nOg-1iRlJf3nTO-00tkv8; Wed, 19
 Jun 2019 18:49:18 +0200
Date:   Wed, 19 Jun 2019 18:49:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 15/17] msvc: do not pretend to support all signals
In-Reply-To: <CAPig+cRW+1dEUe1=7=5G-HziJOA2UpYVKsnMdBpkpcU6D8O95A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906191848080.44@tvgsbejvaqbjf.bet>
References: <pull.149.git.gitgitgadget@gmail.com> <1491ea4140518d76d4619fa2da7ec20250da1404.1560860634.git.gitgitgadget@gmail.com> <CAPig+cRW+1dEUe1=7=5G-HziJOA2UpYVKsnMdBpkpcU6D8O95A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N/2D+5MFROYeQ1QON2+oPU6GN5bLAeOD5QxRReibJGFpHBivFg9
 89d18vuuBtwZPk/D0G0HIxJUIp5mr2gl/7lGez3NQInJSWFFqeMunBeAR2WyLsfJb+YrtV5
 oKwF3IO1L7sV5dFqEKruvT9ABlY7Gc/b7HW50EMsnsH6Vo3kdX3SRcc0V3IQxwFg7ONNOsB
 fNGEDg334TAwcalhNk94Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQLY8qZ/m6c=:kPOB2uPORXHmVWFXACLhmD
 U1y3JQ7sIFkUoTkyr/jMSejIMjeWD4rfeQtBd6nHXrXweAg1iYPLBcne8vPBuAPkn9FWn2Flp
 U2kzOiogwdGDUlssmMobJNpePfm2lQu0sml8izGw5+QnPdI4b8iLGsoAVUVsplzQd6ckwWxDx
 RqS3Ty2K5pV1rcnHGFuUf25Yx2Lr8tSmQ5z/O5rkg2TUkX1slvkZNT1WD4MTu2EUcykWSqacc
 70hKT+06H9g4/t66rLRowKzm3X5GgqFbqMmn8jxU+tWUc0e6duj4IgdqoOmrVNdfqOjYCI1DF
 SfSjkD8hBDwgDieCREmhUv99ewLZSQ9G9iIvXTi4dafQufKJMz8W9d+dmRpJJYB/7sa9VD8OO
 RgejbH7BDiVYjlNa76rLSXSUkt80Ip1IYbcxfCnAW/6rd0wbAZrjhVd79Rj/JbjXumOTRwtmR
 QkdTCcj6vI+YHlyIC/GPZ86SDG9zCJeCD+o3jIZ5k1909yakDKh5nChn3Q8+X3JwLm8Uj+URp
 6SOSe1R/CploznET6z0akR2ypXBolkzXLMIakuQUV7ZKpC1uslDktHNZ7c0YNLRSwvUCawM4K
 MWBP2ceVvktXx8xWPMqu1WAo821WNfQwROoVjricT7C4UcTlc4Ve8/pdm/jzCGgXhEaFcBCjT
 YDsZ9/2F/KlSlVjF3uhzNKQdphCPbOjUoRsqmdlfd1Hyl0OFYCC4WcqNWdm/OesDjB4bnNInX
 bBatGLKLRwL4DGnaZ6RhI7+5abru+UyeUDaYUTwZhChpcHndD6bG1puZUostMkKr0cTulqvXD
 mFRoszXROYz4S/eZ6Hd5LEDW3aXY/2Xvd3EJ41pMwKABM1BlazrODryms04HXYGnMXPAzrAXZ
 bOercbp70LdQn1Og9dwFVv/BvvsY7B9ZwKAmRXVh+Xfh7QindfC1AqzR3prD6OLnH+xMWRuoR
 R5s87VRjLs43Xx0VoIE/dK/cSlmJf8GF33RlSACqniATY5a3/pZIr
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 19 Jun 2019, Eric Sunshine wrote:

> On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This special-cases various signals that are not supported on Windows,
> > such as SIGPIPE. These cause the UCRT to throw asserts (at least in
> > debug mode).
> >
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > @@ -2119,8 +2119,34 @@ int mingw_raise(int sig)
> > +#if defined(_MSC_VER)
> > +               /*
> > +                * <signal.h> in the CRT defines 8 signals as being
> > +                * supported on the platform.  Anything else causes
> > +                * an "Invalid signal or error" (which in DEBUG builds
> > +                * causes the Abort/Retry/Ignore dialog).  We by-pass
> > +                * the CRT for things we already know will fail.
> > +                */
> > +               /*case SIGINT:*/
> > +       case SIGILL:
>
> Why is SIGINT commented out?

Whoops. The `case` before that already handles `SIGINT`, I think that's
why... I removed it.

> And, the comment block seems over-indented.

Not really, as the `case` statements are indented one level less than the
code (including the comments).

But I agree that it looks funny, and moved it within the `case` arm.

Thanks!
Dscho

>
> > +       case SIGFPE:
> > +       case SIGSEGV:
> > +       case SIGTERM:
> > +       case SIGBREAK:
> > +       case SIGABRT:
> > +       case SIGABRT_COMPAT:
> > +               return raise(sig);
> > +       default:
> > +               errno =3D EINVAL;
> > +               return -1;
>
