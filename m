Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082311F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeKQFdt (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:33:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38424 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFdt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:33:49 -0500
Received: by mail-io1-f68.google.com with SMTP id e9-v6so2575440iob.5
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ie2/aj79Ny4Typ+8K+nOCOrihk4l0kYd2qO5WjpXHNg=;
        b=uxG9RxAvSZXknWIbsbDVDPRrrlYEZ+8aFShuz0imKQchFOIOxqL9ZR1KWLD9y/n1Uk
         249RWBZ+lgaHeuj3jC5R5O+qf0CEkmDGYiQSwYYHhSw0QwV0CicgqYVWCHP7pgFKiKUw
         54Nd14g2zUPoCuhYjNa5VoEHN1MCDubakCj++xZYa/1qoC2bwhMQG+GlPZbCpb794MLG
         VXjVYNwkr8V0+TlmFFuk1uZ4/kkP4KEJ7PR8PozzA52+0p5A10ILcWyHawYdoft0tCdq
         16ormca/DzLN06UL2RouzZQJd3L3LtEpPCSro7En+Hx5TWT2LzJ+sEZIpiGoNmQEWG5x
         cgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ie2/aj79Ny4Typ+8K+nOCOrihk4l0kYd2qO5WjpXHNg=;
        b=U0ik9kkvqNUT0fdWb36qG5ithjf9A7Jqt34DcZHZ6tT80K2AT320+5Zmz3+vk+DLtA
         asd95ti7W7frzYVt/4TDqAz8zwSq4UaICPEvfJ/P1D0HakZGwLVT5yxV4GnMJ5oYg0CH
         JjILFebO4HfN/6MTFJPzRpPUl04kF2FxPvO4p3Sifdg6lTBXejuc/5WvMLgLd+zcdkBJ
         uUisO4teIEfLmOGozydeEvda2lCbg7XTzbaTRnGs9tXl1Yh37jMAbiRF6CHiTprKe8Hl
         7PPS0lLm7GsP66mjxVcOGkmSAKb0gwziec4NamYqNXcGq9VVmio0GIt0PYoVOOFbjcg+
         PPaA==
X-Gm-Message-State: AA+aEWYBUtTnfuJSkFz5bjhHY9UvZFkctt7EU8Gm+hyIoAQ6sh3t1sff
        2fmf7OEsWd4i+z+iKT9E/UyMdfjwdXVQ6UsDk2k=
X-Google-Smtp-Source: AJdET5dpKAfkpzPvhpgpjEKxsRoO5rZVyGhiFWoAuFNM4GEwnC2rgoDOxqeBhTie0248BmbhHNmpoSTW4wCC0YYQqLA=
X-Received: by 2002:a6b:242:: with SMTP id 63mr9804585ioc.118.1542396009375;
 Fri, 16 Nov 2018 11:20:09 -0800 (PST)
MIME-Version: 1.0
References: <874lcl2e9t.fsf@evledraar.gmail.com> <20181113153235.25402-1-avarab@gmail.com>
 <CACsJy8CaAC0UP+VxYU7zbdQc6DtKYa-FzOnbpNf+_P2L3zfUvQ@mail.gmail.com>
 <8736s43mps.fsf@evledraar.gmail.com> <CAP8UFD1Nd657Afgk6s+uNXMW=26Fg-6Jnv6ngB1biUX2mGBkSw@mail.gmail.com>
 <20181116190716.GO30222@szeder.dev>
In-Reply-To: <20181116190716.GO30222@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Nov 2018 20:19:42 +0100
Message-ID: <CACsJy8DS1JyuRFyKhVRnVt+ax40+yyv-OVknfQ82OO9jtMeK8g@mail.gmail.com>
Subject: Re: [RFC/PATCH] read-cache: write all indexes with the same permissions
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 8:07 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Nov 16, 2018 at 06:41:43PM +0100, Christian Couder wrote:
> > On Tue, Nov 13, 2018 at 6:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
>
> > > I'm asking whether the bug in this patch isn't revealing an existing
> > > issue with us not having any tests for N number of sharedindex.*
> > > files. I.e. we have >1 of them, merge them and prune them, don't we?
>
> We don't merge shared index files, but write a new one.

True. They are immutable like git objects.

> With the default 20% threshold a new shared index is written rather
> frequently with our usual small test-repos:

Side note. Split index is definitely not meant for small repos. But
maybe we should have a lower limit (in terms of absolute number of
entries) that prevent splitting. This splitting seems excessive.

>   $ git init
>   $ git update-index --split-index
>   $ ls -1 .git/*index*
>   .git/index
>   .git/sharedindex.4370042739b31cd17a5c5cd6043a77c9a00df113
>   $ echo 1 >file
>   $ git add file
>   $ git commit -q -m 1
>   $ echo 2 >file
>   $ git commit -q -m 2 file
>   $ echo 3 >file
>   $ git commit -q -m 3 file
>   $ ls -1 .git/*index*
>   .git/index
>   .git/sharedindex.4370042739b31cd17a5c5cd6043a77c9a00df113
>   .git/sharedindex.6aedbf71b1a6bdc0018078ec7571e1b21ba4b954
>   .git/sharedindex.b9106e9b82a818a0e4e9148224fc44ea98f488a1
>   .git/sharedindex.bad0b75d270a431b9e961cfc15df6ec935a67be8
--=20
Duy
