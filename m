Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1DDC25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 09:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348152AbiHSJZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348144AbiHSJZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 05:25:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80572F2D44
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 02:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660901100;
        bh=QPoqGpub338iJv/HDeB6idr9ji1WmJbnqyNuEmSQt5k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dUWBv6CMhTJ2wVQP/kcgrlviR0AKFNQlLp8EIXse44HJ1IUr5eepqYm0OOIa2rMLr
         qYmHAwTey7T19uDKZmtDYERT9I/uU0d87sAY4hpeOlOYtLSmO6ESFCC6EVTdf5z0tI
         c/Uiw1X5DhpBN9i0vv8eBliF3SvUGD9ft4eYA+7g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1nmc9n2Z0G-00cdvv; Fri, 19
 Aug 2022 11:24:59 +0200
Date:   Fri, 19 Aug 2022 11:25:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
In-Reply-To: <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
Message-ID: <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr> <cover.1660828108.git.git@grubix.eu> <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu> <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-558495070-1660901107=:241"
X-Provags-ID: V03:K1:1MywBM62/Id0eQHhkvaYLYABO1VyniWpbsUC4jZG+qszTJEIeu4
 AGYkCj/znByX0Houztf81linbpnkW7tA5NtQNhafW3Ekw5W23QUmBH1DXMV9OCoU9AFE7dW
 afGMYJfSKdQHpIlaKDlEbw9fM0+A46tfd1D36Ct3hch3e+46NCjG0hME0VOSB8KllatHIvS
 cqrtkYB3wmRMbs9ZzDKZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UzjXw92W9t0=:BxN4aNfYrBQDWKXpiPk8Kr
 9JPKlXk4orVklxTOMXW/830908Pb/FOuCFKuJyjbICl1Q4FKSqw46D9d+beDvM8rM7PGHVTEe
 P+gs6zrFSTu0YmlvNml/b7G9m2HeRfEZWKidUuhQ4un8qu36jY7j8wPxfr1DTmC3wtoKpTCG7
 oHPNvx+nmgxKmQ/5BqDsICR4CM3Yg2d8EMcYAtGJtIqwYrP0IL5p9SSIX7hobVGMi15AuMe5+
 qqZE/DzmA2GskMCrJuVJrK5GbIZwWtHHlyrf1DUIUbEVEcDTzr5/Vuu6Rv4wWzZZFAouBy1hp
 H8znPEt/20vtpDibp5aQrm6P3ER+ms/fgxC4C9cwmHoVtEDXOfAfnlxqlgnhxzSIeT7TVvQ0+
 gEJ+QVtzG6oe4DdLALrvVR54e55FhETqVZImhzEfgIu1zRXObiSVzOV/CBbLtNgcR/CAVdIE/
 L3DpyjrhplQUWIGEeBGheP5qXz3DIz223LaVsdsAllVtW8zjrTDlELmbIsKEFW2XkWnikc9bx
 3qDRVcc1ICbJ8SOgcWe017kFucgx3PgRNMZln4bFpywubu57tEBz5diAclMTOlriR3+ko2XUH
 vLj5RZQAL7ckil/p5Z//neyN8DMhN6cNGk67tbWpf+T+GDZhPIS44IdbDhcV/OsLVj1Iz+ids
 WnogucFpjMTqwdxmuLXF8QXjkvFxzerzo/u4ZBT8rEEm86aooTQwSGkWiiRQ74/L/YLtU4sLE
 IxN87zGvQhadpVJeOoJ+yycVEOxZlC8LmKR6cojCzNe4k116pNXsmEYjk8F/yH4KOXYezg7SA
 v2bEO4Z29x/3+Zv5jPRYtUh0NjT2YIl+3nw8maLcqGGXS8kBW2LN3FibmdTz6nRmwBm7Wqk8m
 px7ey/hakORKb96niGCsmLqfC9SI2/H/KMwJ4e/IPnSva1/ge3rFl66SbXpukjM5+E9dOgMeq
 v5iTO9Gsk/xBZMDkqzp0RkXvxX6YSAydKjFDJNdm6hrfFomkst5n255n0RbzPY6ZrAEI898et
 qLooUGXoJNRcIx28QYGEUn9b0XryLFTS64UiXX30mbF5c6iVQkZWyor5fWRQfYN9QkksGRVgc
 r1Ob/1aLXlJxOrdiuZryIVMg8ldaFJwjASxKf9MwngqD5fVU0CvEgcSVA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-558495070-1660901107=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 18 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Aug 18 2022, Michael J Gruber wrote:
>
> > Traditionally, reflog messages were never translated, in particular no=
t
> > on storage.
> >
> > Due to the switch of more parts of git to the sequencer, old changes i=
n
> > the sequencer code may lead to recent changes in git's behaviour. E.g.=
:
> > c28cbc5ea6 ("sequencer: mark action_name() for translation", 2016-10-2=
1)
> > marked several uses of `action_name()` for translation. Recently, this
> > lead to a partially translated reflog:
> >
> > `rebase: fast-forward` is translated (e.g. in de to `Rebase: Vorspulen=
`)
> > whereas other reflog entries such as `rebase (pick):` remain
> > untranslated as they should be.
> >
> > Change the relevant line in the sequencer so that this reflog entry
> > remains untranslated, as well.
> >
> > Signed-off-by: Michael J Gruber <git@grubix.eu>
> > ---
> >  sequencer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 5f22b7cd37..51d75dfbe1 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -575,7 +575,7 @@ static int fast_forward_to(struct repository *r,
> >  	if (checkout_fast_forward(r, from, to, 1))
> >  		return -1; /* the callee should have complained already */
> >
> > -	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
> > +	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
> >
> >  	transaction =3D ref_transaction_begin(&err);
> >  	if (!transaction ||
>
> I 95% agree with this direction, but the other 5% of me is thinking
> "isn't this fine then? Let's keep it?".

No, it's not fine, we mustn't keep it, because we expect Git itself to
parse the reflog.

Ciao,
Johannes

--8323328-558495070-1660901107=:241--
