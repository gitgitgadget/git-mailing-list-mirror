Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40EB1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 16:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934373AbeCSQbT (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 12:31:19 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:37936 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965040AbeCSQam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 12:30:42 -0400
Received: by mail-ot0-f182.google.com with SMTP id 95-v6so18010556ote.5
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JF6x8iI5xpFPaD/QjH6hO8aREEGBZKjSKUBQsJdP+xA=;
        b=iqH4304nrVOePkjAv86N5LfRBzOm95YNvWhhQhrO86KASr+iAh6PG+jinr4ICrZvT1
         qlmS2Y+GDrBqM+cpccq57r/Gc1oKPnTuL1+HN3xFAurpNqKS/QKgT71ohHKtjitYIXF0
         QmdINNinP1mnc9inqj/ZyrF0QxPOigrOxmRfM5a/gLP3RbkrxNgGWgngkESdesdxSOSh
         Afe0cpv2po8ZMUqpFZFh3Jm0DiMc2IrCHytPToudOfL54hxTqwYoo1k5Eu/PQp6l2GZe
         qrRRKT5myKiNe1KNNG1MWa5HoT4OrSBu0r5cCHERqzVM3+LDJHV+biA1x9AJlUYn17Au
         MJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JF6x8iI5xpFPaD/QjH6hO8aREEGBZKjSKUBQsJdP+xA=;
        b=toVMxWx8VlXhPJtQc0SKXbF9ynvmBgh0WGR7tXuiAmJGLWrDy1zPJ7Dg5GrI93iFCY
         7+1ILjC819Uzrnhvhh5G8ZtUKB5LI1ojwtSJ1SX5ayLySktjnBYOLx4wm/j1FcVaIZEV
         5AGlvc6s/xZnPe3Y8kmH5rZfNSnOMDySFZf9mRDqV3GaGhshWvCqq0Xjb30GdzsjQ/b5
         JCT11VOBgeG1mPOVllWYYPm+4GZUhBf9xapTGj24WPW4MxcOI9haUJeoKAHvsgHnNQ4G
         AMdUOcGJXLH4/uYCdTS7tqY3w2+hCYhNvp1TX3b8VY+7kZIq59LwUlVYNNuiwkDP2Muc
         TmDg==
X-Gm-Message-State: AElRT7GZRGKousIgqSioqLtKS9aVfA+8C87h9fgnvo0Q26s0qqj7UrvG
        w45lGPeFf2v9qCuX63rTi6o4tDy7lnDjANCrwuo=
X-Google-Smtp-Source: AG47ELsauFGjXTk2EcdB8T4HaIE0bo5KjKAa2wnLjaIOqRWf/o3oowfwIMXRvGh+6T/+iLUd/CjoFe3xnjh9ksZB1DQ=
X-Received: by 2002:a9d:ec5:: with SMTP id 63-v6mr5162836otj.14.1521477041914;
 Mon, 19 Mar 2018 09:30:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Mon, 19 Mar 2018 09:30:11 -0700 (PDT)
In-Reply-To: <d30d131e-1cfe-fedb-4a45-7628615a7876@ramsayjones.plus.com>
References: <20180317160832.GB15772@sigill.intra.peff.net> <20180318081834.16081-1-pclouds@gmail.com>
 <CACsJy8BOCpHiMxJ0K=_-WPf9b4yh0W0i3m9sAo5-Sk5fY9x1+A@mail.gmail.com> <d30d131e-1cfe-fedb-4a45-7628615a7876@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 19 Mar 2018 17:30:11 +0100
Message-ID: <CACsJy8D4QdjncLdX83Xo4g5e-ZbCBqMfN9qaybXx5R3xC9d1gA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 18, 2018 at 7:56 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 18/03/18 15:55, Duy Nguyen wrote:
>> On Sun, Mar 18, 2018 at 9:18 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> +ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMP=
ILER_FEATURES))),)
>>> +CFLAGS +=3D -Wextra
>>
>> Another thing we can add here is -Og instead of standard -O2 (or -O0
>> in my build), which is supported since gcc 4.8. clang seems to support
>> it too (mapped to -O1 at least for clang5) but I don't know what
>> version added that flag.
>
> I've been doing a lot of compiling recently, using 10 'different'
> versions of clang and gcc ('different' if you count 64-bit and 32-bit
> compilers with the same version number as different!)
>
> However, I can tell you that clang version 3.4 and 3.8.0 don't
> support -Og, but clang version 5.0.1 does.

Yeah. I checked clang git mirror and this -Og is in 4.x release branch
(couldn't nail down exact release) so 5.x should be a safe bet.
--=20
Duy
