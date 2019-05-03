Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B8E1F453
	for <e@80x24.org>; Fri,  3 May 2019 08:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfECIlK (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 04:41:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:35805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfECIlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 04:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556872862;
        bh=Uj3hF0JRKTWT5w0a1DGxOwxHz0QcxamTkCOkbW1keUA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ir3cTFMCQMDQaDmlbzlINrmEanxVQJydVjz2VBY8fDfZl9aPxJ/Mbp9qQYQO9aA2Z
         nXwtOSAaWTKFIAo0lkMGCHUAn7NRZc++P2RcxKMWPLDOzbzGRPAaF+cUTc0Tsj2xmp
         Xm8CVZaTLuoLqIJ1pdRNRS7HOR/b3g3io20oKvN8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.49.123.157] ([95.208.58.119]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1gaxCM2O28-00wXuj; Fri, 03
 May 2019 10:41:02 +0200
Date:   Fri, 3 May 2019 10:41:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase: fix garbled progress display with '-x'
In-Reply-To: <20190501231640.GD14763@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1905031034400.45@tvgsbejvaqbjf.bet>
References: <20190430142556.20921-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.1904301819540.45@tvgsbejvaqbjf.bet> <20190501231640.GD14763@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-495428198-1556872863=:45"
X-Provags-ID: V03:K1:fBmimfbHe7zkWQNL/am8y+qrLJLCon+/HUtD+HNSk+izBijxC70
 jR43rw1r7muKykB61Xx5Whai044z83zR8gJe/cYUlc1MKIbDAWZLfBdRCTyXCw+U6fzM0OF
 ymcBCi98pkALYXD2pzt3JYugdEVTZY2Yjk/yKoBxlOt6Dnipuub4MdQyS0t8cYdKlBr5dsJ
 gsVb8Fu5WR63iJQ2hIj6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r8UERSNRDMY=:HLiUnN+ktmLfiblmwLQNLI
 UPi2UG37ckR0NCS9G8YdBpwh6kUkbLQDoggGnQEBz7JkFINQobkBDaw7RBx9Q+D2/+FiBoLaQ
 bdAxVz8+YJiJWIV2OetYcoDQIyyiPqfZp3qsTmNz5+bjgvI8Ekfl7xYYwt4x3kjgf9b8b9vpD
 hX28FQfqEPTLsJRjq4iio3CXNKpQACSPhUiOjHKzcR8gIsxqjLpDgs9zBHigHxlXffVtz4z0A
 f1jY/8aB8ZXve/bdCf5NDJQzQSBu+1JGzhRSZxJC6OT+EPf6Jt4cE8v9mDVkav2ydHmeJ+b+T
 8IMISB7/IRMq7CDVSNWaRVxZlufEpF8EPbGtJX0C2xdIKJIfJSgr3cpyXbF5b6yesGL8SkoXN
 2fpHmXj4l1bY9mi/Yb5momW5sD10hDz3ydNYoNE52EflRP5wMb2mQd66mGil0U7q//rmNPOcr
 Vj1C9LTKeCxjj1zoZ1U8OI8cr6YjQQJFr2S7LcdS2AMZatVscQDjFQ8nguFz6cnEu1Lbu13jA
 lOePqu5mIeuSRRj5jiMWyAVP4C2WX+PVfJKZLGSMlXVdryN6tubgi0BaRjnH1s8a8N/tdox+Y
 GC2PxJR8AYPN4Ft8JRy7UQr2+CNw8rmgQf58q/G2r3+/A6aCXRgqrinZGxeoUrgET5iVm+yIn
 Suz1ttdDKfyoKxqs0WEhtNWRdMKahQMw8GYEAQtyDZEbCjKdWFmuv734cLbsdL2up0EVxObmN
 OgduHpoHK8Ng89v4wnqwZnz3urlaASfYQtdGhRE567nxGbxF71AVE3iQAYNr8ku7bOrsnU3IZ
 GBGzhVXVvx/sSI/prubygy+eN6fSd/vOHgK1Ue3t/colRtXOZC8To4LfRZ9SkyMEHgmrKDfA7
 26PEtUdW/+HL0SQcO52TSfBazrfXc8W9lTCuLI5K1/YUAcHCPaYVWBiP6UJ0sg/MY2aUxEX76
 cvK2uPvM/lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-495428198-1556872863=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2 May 2019, SZEDER G=C3=A1bor wrote:

> On Tue, Apr 30, 2019 at 06:25:35PM -0400, Johannes Schindelin wrote:
> >
> > On Tue, 30 Apr 2019, SZEDER G=C3=A1bor wrote:
> >
> > > diff --git a/sequencer.c b/sequencer.c
> > > index 546f281898..c2e4baa90e 100644
> > > --- a/sequencer.c
> > > +++ b/sequencer.c
> > > @@ -3631,6 +3631,12 @@ static int pick_commits(struct repository *r,
> > >  			int saved =3D *end_of_arg;
> > >  			struct stat st;
> > >
> > > +			if (!opts->verbose)
> > > +				/*
> > > +				 * Fully cover the previous "Rebasing (n/m)"
> > > +				 * progress line.
> > > +				 */
> > > +				fprintf(stderr, "%*s\r", term_columns(), "");
> >
> > IIRC there are terminals (`cmd.exe`?) that would advance to the next r=
ow
> > automatically when printing the exact number of columns in a row. So t=
his
> > would not work.
>
> Hrm, I though about using 'term_columns()-1', or moving the '\r' from
> the format string to the string to be printed, but in the end didn't
> do either, because it seemed to work well as it is in the two
> terminals that I tried (on Linux).
>
> > But isn't there an ANSI sequence that we can use?
> >
> > *clicketyclick*
> >
> > Yes: https://github.com/git/git/blob/v2.21.0/editor.c#L101 (introduced=
 in
> > https://github.com/git/git/commit/abfb04d0c7#diff-cdeec438beb851e450b9=
4a11db9ab7edR89)
> >
> > So maybe we should do the same here, i.e.
> >
> > 	fputs("\r\033[K", stderr);
>
> Oh, that would be nice (and not only here, but it could have made the
> changes in 'sg/overlong-progress-fix' a bit simpler as well).
> Unfortunately, however, it only works on non-dumb terminals (note the
> '!is_terminal_dumb()' call in the preceeding condition), while rebase
> hasn't had such a limitation on the terminal yet.

I think it would still be nice to have it in the common case of a capable
terminal.

Maybe this could even become a helper function, e.g.
`erase_terminal_line_remainder()`? This should also help other developers
discover and use it.

Ciao,
Dscho

--8323328-495428198-1556872863=:45--
