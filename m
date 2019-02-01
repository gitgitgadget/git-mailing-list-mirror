Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A18D1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 07:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfBAH0E (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 02:26:04 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:39477 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfBAH0D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 02:26:03 -0500
Received: by mail-qt1-f177.google.com with SMTP id u47so6394245qtj.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 23:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZtK7i9tJCq165uQCtKTwQU+N/8/fiOJUzj7vOXjGiJ0=;
        b=jBUvWficPIwCP5VMaT7g1LjkzBr1E/qKzFjkyJyw0g01XrEkWONQVOGaJdR0MlRDaX
         SKnJR6IgGWlRols1ffxNjPBTfq+ngV3fmCeblxaqlWKo8ouiZO4jtrIrueUbou/FaBxi
         l1e+u/cqJ7ipBVejDEHi+5MSmAdFbQ4OgXs4U3K2sj/5M3g8GtwYpjGn7H41ZWqq+a0F
         ZTrnw/7r4Yi3tzH4pzD/HbPlukCkls/5YLu9K0Y2woBXi7ziz+eRxJVu+SBp/jee/ALO
         H/hS+m5Nltnlkf/QPXyZSZ4VYkgLOHKRFv532TprRHg3L0RHpIUeYNeTEhPZ0ohf6KbF
         tziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZtK7i9tJCq165uQCtKTwQU+N/8/fiOJUzj7vOXjGiJ0=;
        b=N4Qu1Fyu/KwlPHZSBnSoIrJpjKEHSolDlQ+7YViPtTs6+rzuCOA0dwyxbS+7c4A2le
         HPUF+iYUv84KgWVwBSQzDIgAfk7WLjJgmEoo29wMwDae0HwB5PFDyuqX3cbaSgMNG2hd
         RwJxQpnf+bMCZlejFysK8G9DhbwbWmCSIcvQsG1cnEtoymKAocZRN/hOmTZ5dHudQcEL
         P4jNPnx1AqdruyCQRj2besJt3RZ4feOBJqR3lAAn6TT8SrY70ZUaqxHRjLn4rGBDbr6P
         VvXqnjAXlql5OAeMZsQpQXpVp1R1m8TuzEkYU08x0944JPar5IH49YiGCUsTRjqJUP+r
         Ar4A==
X-Gm-Message-State: AJcUukd8+26vX1yHJ+wCdoETHvgg+hx56iptBHAXU6vKFOIVfo78Y6pI
        hwddXzqDT2nxP0KY/yruM9gTy7LkSsRICNG2Rnc=
X-Google-Smtp-Source: ALg8bN7vNhTQs1QNAp55d8v4fwep+vJSMmBE0TIT6sAFE3dja0+S0YdtL+4PwRX9ezp5X8P5R7m3E2cUBZRM9VKvFo8=
X-Received: by 2002:ac8:1102:: with SMTP id c2mr38059729qtj.195.1549005962578;
 Thu, 31 Jan 2019 23:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20190112091754.30985-1-worldhello.net@gmail.com>
 <20190130114736.30357-2-worldhello.net@gmail.com> <xmqq7eek1ozm.fsf@gitster-ct.c.googlers.com>
 <CANYiYbG5vbV1bqbHu-u19XFy7JTpcopg0s=JWAhJBRNGvP7j3g@mail.gmail.com>
 <CAPig+cS84BOPdrZ+e1Z9ystx6SDyON0MJxVySQyxYE=LYcNRdg@mail.gmail.com> <CANYiYbHK9Qozqzpnwu3y9Gq=ieMPUgXfZxr8Ofxwe6mJox9Ohg@mail.gmail.com>
In-Reply-To: <CANYiYbHK9Qozqzpnwu3y9Gq=ieMPUgXfZxr8Ofxwe6mJox9Ohg@mail.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Feb 2019 15:25:50 +0800
Message-ID: <CANYiYbGi+Hk6Hk=_ooQtPV=wrdHTJpzocctE-yEt4N8KKkvdGQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] t5323: test cases for git-pack-redundant
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=883:23=E5=86=99=E9=81=93=EF=BC=9A
>
> Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2019=E5=B9=B42=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:11=E5=86=99=E9=81=93=EF=BC=
=9A
> > > Nice chart, will edit test_description as follows:
> > >
> > >     test_description=3D'git pack-redundant test
> > >
> > >     In order to test git-pack-redundant, we will create a number of
> > > redundant
> > >     packs in the repository `master.git`. The relationship between
> > > packs (P1-P8)
> > >     and objects (T,A-R) is show in the following chart:
> > >
> > >            | T A B C D E F G H I J K L M N O P Q R
> > >         ---+--------------------------------------
> > >         P1 | x x x x x x x                       x
> > >         P2 |     x x x x   x x x
> > >         P3 |             x     x x x x x
> > >         P4 |                     x x x x     x
> > >         P5 |               x x           x x
> > >         P6 |                             x x   x
> > >         P7 |                                 x x
> > >         P8 |   x
> >
> > test_description should be a meaningful one-liner; it should not
> > contain this other information, but this information should appear as
> > comments in the test script.
>
> In 't/t0000-basic.sh', there is also a very long test_description.
> After read 't/test-lib.sh', the only usage of test_description
> is showing it as help, when runing:
>
>     sh ./t0000-basic.sh

sh ./t0000-basic.sh --help
