Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA931F404
	for <e@80x24.org>; Sun, 25 Feb 2018 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeBYUAg (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 15:00:36 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35278 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeBYUAf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 15:00:35 -0500
Received: by mail-qk0-f180.google.com with SMTP id s188so16755577qkb.2
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 12:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=K0w1h18Ssp5lVEfHXV38zz4mSToExvoSK5sl9zOSlFg=;
        b=fLUxMp7c2+KO6hUFQkDEMNVWscImy7KIw2UISywyqSG4N+VF+juJ2IcHz16vQXS3vn
         d8pAwm3zf1UQ/keQBipSsiaO/pO1a7j16wtedhnKL1Qvsm5+LVqzGF0uGTSCgd+8nZ8y
         AFL8/LBbCDbgyEv/qLUzJf01iHmWhEElUDr0a0F921pCZMBbdodRKuinDhrnhSR4k+G3
         2D9XS8J0VEnojZw4x2DOb+N5wvbUAQ+deABu3N7Jcnnud5dzTrzJJBL73QsvTfBEvgCD
         gDOUtLoZYTC4O2NnQmCncuZxboS6duBWkMSZZ4IhDmUT0GFON8K0VeAf+BvGRdj8in8b
         q3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=K0w1h18Ssp5lVEfHXV38zz4mSToExvoSK5sl9zOSlFg=;
        b=oFs7+r4SkCeBMKGr7RN+abTvxg+C1ZS6MQTY/cP9x5S7i0HBfi/s/N6iW4ekbsEOMx
         B+qiv0BwL8fPOdQ645EtmITKk5Vg5Lmvm3n79tt2cG6xi6rEOh6xF4B/dNZlIhsS+UuX
         LaMt0yTWEsxMTJqvEzl5qFpmdlUkjwlj9IOi2AGKkmtmVAG7/6oKHiCuwGrVwxtf6thQ
         LHdO/N6HQfaeqYvQMsbX8RUTe+sDhsha6Pio1NHQJy7oxLlqH/y8xiQAB8wxzOIcCXH7
         iSgE/bj5lTxeD2e+CDYsexOLelRNjl0ObrP8FUOSNS5RyUtwaLVwvuiqsTyqLijIm5qR
         f92A==
X-Gm-Message-State: APf1xPB2j1sc9llzVoiFtBw5Rw1Ttv+67FBbDvu3KfZ+MYzHFlmT3GxQ
        BvGA9444zCPn+BHL+iflgie54qfzZ6iYMB/UUKU=
X-Google-Smtp-Source: AG47ELu38LBHpTNueRHSyHBPfhYwR7e7LUM/oGuCfQUVyLiKvxzYX5Ndkf1coQ/1gSdY8FCc7khFTuVMv3GDCFMEJ2g=
X-Received: by 10.55.32.2 with SMTP id g2mr4348111qkg.176.1519588834339; Sun,
 25 Feb 2018 12:00:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sun, 25 Feb 2018 12:00:33 -0800 (PST)
In-Reply-To: <20180225194637.18630-5-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com> <20180225194637.18630-1-avarab@gmail.com>
 <20180225194637.18630-5-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Feb 2018 15:00:33 -0500
X-Google-Sender-Auth: 8MMMBEujH5zfl8SixJe4PAJzBLQ
Message-ID: <CAPig+cRg+DeGVwPLed4qMdRCqDDcB0b=Zsrf1i0L+aTRsqjRgg@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] gitweb: hard-depend on the Digest::MD5 5.8 module
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 25, 2018 at 2:46 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Since my d48b284183 ("perl: bump the required Perl version to 5.8 from
> 5.6.[21]", 2010-09-24), we've depended on 5.8, so there's no reason to
> conditionally require Digest::MD5 anymore. It was released with perl
> v5.7.3[1]
>
> The initial introduction of the dependency in
> e9fdd74e53 ("gitweb: (gr)avatar support", 2009-06-30) says as much,
> this also undoes part of the later 2e9c8789b7 ("gitweb: Mention
> optional Perl modules in INSTALL", 2011-02-04) since gitweb will
> always be run on at least 5.8, so there's no need to mention
> Digest::MD5 as a required module in the documentation, let's instead
> say that we require perl 5.8.
>
> As with the preceding Net::{SMTP,Domain} change we now unconditionally
> "use" the module instead.

This is patch 4/13 but the Net::{SMTP,Domain} change doesn't come
until 6/13, so saying "preceding" is confusing.

> 1. $ corelist Digest::MD5
>    Data for 2015-02-14
>    Digest::MD5 was first released with perl v5.7.3
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
