Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE8791F453
	for <e@80x24.org>; Wed, 24 Oct 2018 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeJXXKs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 19:10:48 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:34189 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeJXXKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 19:10:48 -0400
Received: by mail-it1-f196.google.com with SMTP id e81-v6so4338852itc.1
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MAgvMIDy1S+71b3DMwM5kYalImWzShoZvWfosguOvhE=;
        b=pHn9Swq3KEjyVHaX8bFzUmReI+VPesV4KC654F7H8h9VCbraXywRKs6Xr/aPMGDEQz
         ttG4X9CKubcA24N7pWCzg2xaJdcoHrkGptMSbBEQG2b2mfMsBkXpCMpyrUb/0S/gIXp6
         1QYKBfOeDP5MkDEA824pvFB1/Xx+oO2sUGIHyuXp9SZOGIAtb1KMoG/7E/iOvYQMPQPQ
         FVsehAIOif9zmZvpou9TbBhCL65KNYCT4zekasLV2g36LnJwVlaOJug8yJPt9R+GoOuV
         AfZbLifA5sKxNajYc57ilWrn2EjufxWSemu96QwGv3h7JdjHhtzj2maJJlHadWm9JiZw
         IKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAgvMIDy1S+71b3DMwM5kYalImWzShoZvWfosguOvhE=;
        b=hof6/DfamYBmeokukYfcxWVpCLLFwe6zudnlA1T1CExIFfWP2O+xotbZeprHkxHxHq
         mopqu4L8j+/b7W9wI7+GJv2WP8XH+Z+RWOB/t5JdmbdWRXx8uK38V44Mgy0Ae9p6fl/s
         lPHF87RcyC5gRSQFgKf4IA4IEkb2UX6rqrqwro8LrYAEnk4NEo2MyuAeKyok2bfFh7pH
         JogfBTIyC+KI8moYpv0Jp9lwwl+UszldX0YNiu/ZZNvQs9n3r0R4UeU9+xDdbYG8+gtH
         PNSBjiYeklNn42Npz/pxdDDCaN9DmymaWIv6qPNGSB9Wm5TOi5wNxhDfwGjP5XP1BY4+
         ORMw==
X-Gm-Message-State: AGRZ1gKFSGbwvOIQnMGeloBgYkVv7JuyiT5/5oZaJFikg5cW07eQypo9
        Qm2H8n85O+5zCm0YobRgSoo4vWe3rc5fF/K8Z1M=
X-Google-Smtp-Source: AJdET5dYWGc0x3sHx3MyT3YQ2Hds1c/IMWKP5YTRAwdGDft1LQlc9mCCFIIhwWjk5Kk9RPgM8RS9+QOJsm9UqNcqt4o=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr1687125itc.123.1540392144712;
 Wed, 24 Oct 2018 07:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet> <8736sxc6gt.fsf@evledraar.gmail.com>
 <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com> <871s8gd32p.fsf@evledraar.gmail.com>
In-Reply-To: <871s8gd32p.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 24 Oct 2018 16:41:57 +0200
Message-ID: <CACsJy8Dex3VYEXmvRZv5_ot1-cwjJtir=kvupzKe7-Z2qPZw+Q@mail.gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 6:45 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> The effect of what I'm suggesting here, and which my WIP patch in
> >> <875zxtd59e.fsf@evledraar.gmail.com> implements is that we'd do a
> >> one-time getenv() for each process that prints a _() message that we
> >> aren't doing now, and for each message call a function that would chec=
k
> >> a boolean "are we in poison mode" static global variable.
> >
> > Just don't do the getenv() inside _() even if you just do it one time.
> > getenv() may invalidate whatever value from the previous call. I would
> > not want to find out my code broke because of an getenv() inside some
> > innocent _()...
>
> How would any code break? We have various getenv("GIT_TEST_*...")
> already that work the same way. Unless you set that in the environment
> the function is idempotent, and I don't see how anyone would do that
> accidentally.

I didn't check those GIT_TEST_ but I think the difference is in
complexity. When you write

 var =3D getenv("foo");
 complexFunction();

you probably start to feel scary and wrap getenv() with a strdup()
because you usually don't know exactly what complexFunction() can call
(and even if you do, you can't be sure what it may call in the
future).

The person who writes

 printf(_("%s"), getenv("foo"));

may not go through the same thought process as with complexFunction().
If _() calls getenv(), because you the order of parameter evaluation
is unspecified, you cannot be sure if getenv("foo") will be called
before or after the one inside _(). One of them may screw up the
other.

> > And we should still respect NO_GETTEXT, not doing any extra work when
> > it's defined.
>
> This is not how any of our NO_* defines work. *Sometimes* defining them
> guarantees you do no extra work, but in other cases we've decided that
> bending over backwards with #ifdef in various places isn't worth it.

I guess it boils down to "worth it". For me #ifdef NO_GETTEXT would be
limited to gettext.h and it's not that much work. But you do the
actual work. You decide.
--=20
Duy
