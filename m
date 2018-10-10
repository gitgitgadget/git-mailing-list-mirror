Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C0B1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 13:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJUWM (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:22:12 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:52106 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJUWM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:22:12 -0400
Received: by mail-wm1-f41.google.com with SMTP id 143-v6so5350319wmf.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JhZ86nVGke+xnw5D6P5zwCfw1psb8Viha3S+DVvMWLs=;
        b=e8JtQLEZ6eNLg3XGa37P4BSbXkgqpnPLpT/99JdEBdtAXAGYJVGVpkY3GPYKsRXBTi
         jmD3L0aJ9knHMR3KH5pLEpbvks62MBbZvuta4SBkg283l0DUfuXxqrE6Wt3cXkeWGdfc
         0tZ7QZ3+SDhzf5cwGw7BvHRaFhRnSH3vzg9Fkh/YaQRhZww5Rgt6/thTqRxQHtiKApRd
         gupomxcgtrxk6dlF0j2LZwE4EScR4Bha/bjCGJAR+Htx2Q9zHbI3tOT2MBPh8RgUBDrL
         BnjIm+6Wo0/0SYeAW6coGrZDcZ8fTTcN25KEuBn75lSaq9ffNGfE5hBmAsQyfK/9sSMR
         ic5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JhZ86nVGke+xnw5D6P5zwCfw1psb8Viha3S+DVvMWLs=;
        b=LbO/6qpsQ5x9bZB9n1lTZEDTzvTwu3sHEQnJuTeOEYm2A4yHP73jKHhtZPIys8AKJh
         8iClM2/75+ezc/88+qW5U5YQ3x0XuzYvWjApZ+GiLKaoHh56amJHy98WxfeEI97W8dKP
         2tuTS6bb6NucCIGHvPQS4r0bCx1wEo3wtbpAUAsJi1oOpnWb839x283Mj4HcDENEt8c+
         wnZDCo5LmK4ws/8TxTUzlt/+vWanNeOTArFzyhWAIiqUqO5jHUVRkiWzXfVNcRqAGG7I
         eM3NqRzrfD7/bRGTpOTsFvFOcyYAOS74+be9BfgW664sTC2ysJy54GouSH0mmlZ5mS0e
         DJ7g==
X-Gm-Message-State: ABuFfogpxcxASZDVlRlUiRx8pWACx8Z/VUyNlD8xVM1PIBOmL1sn57t6
        Hg3xyXBHsMlL8Ji1HzcCncr9Ss+5zx7EUMYEkcM=
X-Google-Smtp-Source: ACcGV62+CISYlZO1sMbkQhgMiwxOiJLalKdEqhkisOTWmEzIppV7msiOjNphp1mH8TwBbdhClfhgoT8nc3NfDQS6Il8=
X-Received: by 2002:a1c:2846:: with SMTP id o67-v6mr832879wmo.60.1539176405949;
 Wed, 10 Oct 2018 06:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOO0rQKZ6rgH136oOhQ+LCgptv-RfKXMpTTrC86EUExABgg-Lg@mail.gmail.com>
 <87bm82fcmm.fsf@evledraar.gmail.com> <87a7nmf9zj.fsf@evledraar.gmail.com>
 <CAOO0rQ+3BPydQUaY67REd3-W9co-92DYa=TAUaGurN+QQUvSwg@mail.gmail.com> <CACBZZX5OvhzYS9SteA-PAqDA_WCDy-hfJmXJG8w5+brQfa8RyQ@mail.gmail.com>
In-Reply-To: <CACBZZX5OvhzYS9SteA-PAqDA_WCDy-hfJmXJG8w5+brQfa8RyQ@mail.gmail.com>
From:   Thiago Saife <tsaiferodrigues@gmail.com>
Date:   Wed, 10 Oct 2018 09:59:29 -0300
Message-ID: <CAOO0rQLA9d3DyNUAfdkN=aMu5o-AJ_Z+1ucnv0rk_PkFvC=A4g@mail.gmail.com>
Subject: Re: Translation to Portuguese
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, worldhello.net@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok, no problem.

Regards,
On Wed, Oct 10, 2018 at 9:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Oct 10, 2018 at 2:41 PM Thiago Saife <tsaiferodrigues@gmail.com> =
wrote:
> >
> > Hi Avar.
> >
> > What it means? I should not continue the translation? Because
> > Brazilian Portuguese states as Translations started for, but it's not
> > finished yet.
>
> I misunderstood and thought you meant the translation of the git program =
itself.
>
> I don't know what book you mean or how it's translated, sorry.
>
> > On Wed, Oct 10, 2018 at 6:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> > >
> > >
> > > On Wed, Oct 10 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> > >
> > > > On Mon, Oct 08 2018, Thiago Saife wrote:
> > > >
> > > >> Hello Git Team.
> > > >>
> > > >> I would like to help to continue the books' translation to Brazili=
an
> > > >> Portuguese and I don't know how to proceed. Thanks in advance for =
your
> > > >> help.
> > > >
> > > > That would be great. Have you seen
> > > > https://github.com/git/git/blob/master/po/README ? It describes how=
 to
> > > > create a new language. Also CC-ing the l10n coordinator, Jiang.
> > >
> > > It has been pointed out to me off-list (thanks) that I missed the par=
t
> > > where you mention a 'book', and we already have a Portugese translati=
on
> > > of Git. Sorry!
> >
> >
> >
> > --
> > Thiago Saife
> > (11) 97236-8742



--=20
Thiago Saife
(11) 97236-8742
