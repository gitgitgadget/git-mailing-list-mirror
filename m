Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897F31F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 12:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504210AbeKWXGW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 18:06:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43058 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388143AbeKWXGW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 18:06:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so3304791pfk.10
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DGv1VtdE2joEl5S2HIeINHwPeY3NJnG+ICYUDUcG9VM=;
        b=cmjIVwI5f/Yv5xZ/gVK/mkLphu5FxRQjn8qcM9tykp7ooZeHXF4OVodGCiduj8k377
         Ts5EJ2q56IEbX1d8Izq3R1BJ9qcNcbwsXCXlsAE4Wbs0BB3Wa7vJn0giSvRpbtpJrG2E
         snbaKdGGntqXImN6Xee0+pboYERv4wTSlbkXWSL5tsKlLl5CAD3eFUe2/jSHSXFLUlGv
         gywOylJgttGSYITQbz2SZmWfeY7p9+FM38GZpMwXcTktrg02ztwOzDS56i3zaNrGDF7w
         94AqVVDZ0vR4gTBsDKmK7qWay+G9amYlPI1neIMQ2RISgT5uoKGnTO7X5acZPmYn2lYH
         yElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DGv1VtdE2joEl5S2HIeINHwPeY3NJnG+ICYUDUcG9VM=;
        b=gthfXZVS8aKdQrRGIkMrShSB/uxfX7PFc9LtTDwbYM1m07lmeNJkRAVGgzHw3MM03d
         xqhobjSYfIZKBzh8Lcyk0hw/U5Fl7cqLg+jOZWArbOGGD8Jbx1ah/DjBwzvxD9+YKR7L
         H7Bk/eOTIILnqTzqc2WraGtX8h9rhVTYqiBNu6QDiOdkWQVAwxzKvxjQ8IZUphtUGPVh
         jFt8gCVFqhUS45rTGi16H3xej1h+lghkZZVzPRV6FcIRWpAz0nIZeXqpYotj4lyOWQQZ
         sbkDOPoTP8d/ouCaGcFpHUfOh9q1009myJX9lnJPMUKsI69P8TpyLfApBTN4A0kfd1tP
         TD1g==
X-Gm-Message-State: AGRZ1gIL5sV5jyUGGnTXm7XpcEFil/j817CmtBk/gQ8iPGvnoBCQ6w5G
        LUeuH05Dzr/iBnPmCFlW7qMTMvrgpS3nJth/q+M=
X-Google-Smtp-Source: AJdET5dmNDmbAygnbgqBhid8LtiiBgoyJbmZ2KX/3Z1QFnJFmKI1It7J832XSYwWQqJkP3L9jwicgKzVwDDvjXnZnig=
X-Received: by 2002:a62:5793:: with SMTP id i19mr15832084pfj.49.1542975741826;
 Fri, 23 Nov 2018 04:22:21 -0800 (PST)
MIME-Version: 1.0
References: <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
 <20171027172845.15437-1-martin.agren@gmail.com> <CAFZEwPP7dkWwRJD2ohDfnV_Phb0ga7YPZoVC920JPrQXLAGekw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1811231111030.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811231111030.41@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 23 Nov 2018 13:22:07 +0100
Message-ID: <CAN0heSpaW5C_dMh7gh0ezyzACBgZ2SYXP67E_3moeKNyTvu9xg@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>, tanushreetumane@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 23 Nov 2018 at 11:13, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 30 Oct 2017, Pranit Bauva wrote:
>
> > On Fri, Oct 27, 2017 at 10:58 PM, Martin =C3=85gren <martin.agren@gmail=
.com> wrote:
> > > On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wr=
ote:
> > >> +static void free_terms(struct bisect_terms *terms)
> > >> +{
> > >> +       if (!terms->term_good)
> > >> +               free((void *) terms->term_good);
> > >> +       if (!terms->term_bad)
> > >> +               free((void *) terms->term_bad);
> > >> +}

> > > You leave the pointers dangling, but you're ok for now since this is =
the
> > > last thing that happens in `cmd_bisect__helper()`. Your later patches
> > > add more users, but they're also ok, since they immediately assign ne=
w
> > > values.
> > >
> > > In case you (and others) find it useful, the below is a patch I've be=
en
> > > sitting on for a while as part of a series to plug various memory-lea=
ks.
> > > `FREE_AND_NULL_CONST()` would be useful in precisely these situations=
.
> >
> > Honestly, I wouldn't be the best person to judge this.
>
> Git's source code implicitly assumes that any `const` pointer refers to
> memory owned by another code path. It is therefore probably not a good
> idea to encourage `free()`ing a `const` pointer.

Yeah, I never submitted that patch as part of a real series. I remember
having a funky feeling about it, and whatever use-case I had for this
macro, I managed to solve the memory leak in some other way in a
rewrite.

Thanks for a sanity check.

Martin
