Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DAB20248
	for <e@80x24.org>; Thu, 21 Mar 2019 00:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfCUAfx (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 20:35:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52417 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfCUAfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 20:35:53 -0400
Received: by mail-it1-f193.google.com with SMTP id g17so1871571ita.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 17:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EPaR8eQVjOdztGq/81zkVGaWqEPQIyHfILZ9bS0Ydaw=;
        b=mAAFU1+Vn88/En2LIxkT0yZ96yqvtfsza2y9UrY5DsA9bxQKmOFJ/Ye0ALsTkpca9s
         bZKJk9wuyr7pA7QVVt/HWMRBXD5QCFS4GjMfHn4ftpr82xRMqcZLKtEVt6RzCcOLjY4y
         Z4yPwFX/GyFgaQMcI3vopnEuOrFu61oNontYXNnCLOnyucgmnOiWiJ8mS2KF6rRsKvvf
         U/tIIo03cp1syqEjV78McMrguN4NYLM+CGnsI21ZN4jEBYKijrc8iE1Tah59uK0k0yqz
         YHCgNp57VQz4QclWq53RXI8kYswAVTC2YOWly9cG+CBRnjm14NnIB7CsIg+AFAe/8Xug
         eJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EPaR8eQVjOdztGq/81zkVGaWqEPQIyHfILZ9bS0Ydaw=;
        b=kddelLOGhN5UoKaY7EvqewWR01ZpcW7u1T6xeGVwHGBZFnNpbYWi35Yj8Sct0Vry5W
         N6WF+M9FaGoBJ21mKS4jYk20Zp1ScHCnw/PjxupcQQ2vbTE6lmScVKz9x3TdrNEhDjdL
         Xy3AsAlfPGWIY6OiJvkwGEck18PAHdEKUagrutFHkC0Bg9rh7V58Wrllh8FkkgyePTDU
         0DPFkiw/Au2TtlWl/knYKOpPe/KshLUfu//FtOri2TGDTGH/Bn+gsDAGwUbTBV3Z7qcl
         /WkOkEVE8IXwovAdII8AYMxnYIFvEhpHPqghc5fB1Fb1ZXVEkBxFgjhFCyflqwvqhwNv
         D7AQ==
X-Gm-Message-State: APjAAAV2BiudGHKCsBL2TFXVjJuR7JTlANQUIvcIVnYJiOfSXZ1PB1oi
        gbfNPi+TWVCyMTs9eiEGSoVRvbL9oAg63CIa3Bo=
X-Google-Smtp-Source: APXvYqyKCAWQnjEO1llYg6vYVpsgCa5ltiqilCB4kngM+ojd+ynoO6nx4qfEr+sLmPt6R6iyrsqNi3ePre9y6DcC/bc=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr750548ita.10.1553128551873;
 Wed, 20 Mar 2019 17:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190320114703.18659-1-pclouds@gmail.com> <20190320114703.18659-11-pclouds@gmail.com>
 <87zhppcfsq.fsf@evledraar.gmail.com>
In-Reply-To: <87zhppcfsq.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 21 Mar 2019 07:35:25 +0700
Message-ID: <CACsJy8CuTX5Yh_80cLuQViNRF8fH_PcMSv0w_OYAt2EB_WfrQw@mail.gmail.com>
Subject: Re: [PATCH 10/20] diff-parseopt: convert --[no-]abbrev
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 6:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Mar 20 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
> > [...]And the '40' change is self explanatory.
>
> Let me make an attempt at being dense anyway...
>
> > -             else if (v > 40)
> > -                     v =3D 40;
> > +             else if (v > the_hash_algo->hexsz)
> > +                     v =3D the_hash_algo->hexsz;
> >       }
>
> This is obviously not a regression, it's a hardcoded 40 *now*. So we
> should take this patch.
>
> But in general, I wonder how this is going to work once we get a few
> steps further into the SHA-256 migration. I.e. here we're still parsing
> the command-line, and the_hash_algo might be initialized early to SHA-1.

That would be wrong. the_hash_algo must be properly initialized by the
time any command parsing is done (except maybe "git <options> <cmd>").
While parse_options() most of the time is just a dumb "set this
variable, set that variable", it often can have callbacks to do more
complicated stuff and we can't just go with "pre-initialized to SHA-1"
assumption. That's as bad as "assume $CWD is worktree" until worktree
is discovered.

There is a corner case though. If some command takes hash algo as an
option (e.g. git hash-object should work without a repo) then yes we
might have a problem since the_hash_algo might not be initialized yet,
depending on option order.

> So if I set --abbrev=3D45 it'll be trimmed to --abbrev=3D40 by this code.
>
> But then shortly afterwards we pass my SHA-256 object down to some
> machinery, and will then want to abbreviate it.
>
> Isn't that part of the code something we're going to want to support
> looking up objects in either hash, even if we initially started out with
> SHA-1 in the_hash_algo? So we'll be over-abbreviating a SHA-256 object.
>
> Leaving aside the sillyness of wanting to abbreviate *anything* to 45
> characters, I wonder how those sorts of chicken & egg hash scenarios
> will go involving the_hash_algo.
--=20
Duy
