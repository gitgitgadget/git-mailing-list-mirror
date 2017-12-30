Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866BE1F428
	for <e@80x24.org>; Sat, 30 Dec 2017 19:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbdL3TRX (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 14:17:23 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36520 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdL3TRW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 14:17:22 -0500
Received: by mail-wm0-f45.google.com with SMTP id b76so52691290wmg.1
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 11:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dUrE6ZM1vtBAJ2fKKJu6nIFwUj4HLPamcTaIQkjZey0=;
        b=vQBq0gn3SKeeAfPIOEj05Okk5c6YYfiqrf6O7TqzpdO7k1Bk6TdeLRiJUhnZ4jW/Cu
         8YtwSoWGOOUMAwyffh+PbdAJzQWPxmUO//c1Y+V7uNdVB1fC/hKgg79WN0622RmQNla8
         QTVWMxqXWuhdBbBVGT/aLPg5I/ThwfIz7i1otfaViANWQdRZ7ktaCzZyg11JxYR19u7Y
         4s0TCS8st5CBRwuQyTdiCjBo6aUhKikAiS80Vd02taxUL0hKo7AlLm5ZvCBRfLiqcLxT
         s5EQdqOAXaqBm8NtPn8bQ7GUEiOjvAQSBfDiJPi2MPbzLgnTftUWtotywNMgKQEjYRl4
         0m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dUrE6ZM1vtBAJ2fKKJu6nIFwUj4HLPamcTaIQkjZey0=;
        b=iiLmZzrsRbzUEjVvlXXOS3ImMgcSBocOwZ0r+F1mDqwYucKPK30WcKGfBoKaDVs6H+
         7NKjlVCgYzipDyJDz6npWNylNF4vMK5syHtzDgJEgDgF1ZoRiA83eRwjmO9acoylskxk
         CxD2LZc250FDwg+H623Zrxg4lOdU0vLRFgNoNWByuT64z2mhG+NK7Kv9VCRq7SPbznrW
         3jr9SIWuQQjhOlT9ouA7JqypubIOwCXfiwNCPiA+kCnaW5VqQAmOjn/swMrasxeiRoIg
         LGUimrqfn9ioixmfKg+O6O1qJ/rQLx/EeMR4cCgyI2h0RWYpkSWjj8XJzA0PDNZwoQxv
         QL1A==
X-Gm-Message-State: AKGB3mI2CptWIpjWdcuZn5jIJtSnpusK7vfqViyvCoLmc2KtYXvMPyDj
        ieJ6zc1TJL8C00d3uJGHH2E=
X-Google-Smtp-Source: ACJfBos1KfKU4bjAeERs0678JmCalWJdwfdKaBJK96dc3Ju9BghHuDD+cfmabBf2OkBmDjxcO18jRw==
X-Received: by 10.28.57.11 with SMTP id g11mr32561369wma.92.1514661441271;
        Sat, 30 Dec 2017 11:17:21 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6007.dip0.t-ipconnect.de. [93.219.96.7])
        by smtp.gmail.com with ESMTPSA id n74sm13822692wmi.1.2017.12.30.11.17.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Dec 2017 11:17:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKjkL4VtbxspGFuQHfzVbch5tR_vY8hzHv4r7pdB9xJ3LBQ@mail.gmail.com>
Date:   Sat, 30 Dec 2017 20:17:18 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CF879C0-021D-479C-AAA7-B9A61B126C83@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com> <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com> <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com> <EFD040CE-E88C-4893-A304-4514BF221AC5@gmail.com> <CAM0VKjk+LtW4dCuwsZ8ffXrN4HGL=ZC1budCOd53_w-20gwNag@mail.gmail.com> <CAM0VKjkL4VtbxspGFuQHfzVbch5tR_vY8hzHv4r7pdB9xJ3LBQ@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Dec 2017, at 21:16, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Fri, Dec 29, 2017 at 9:03 PM, SZEDER G=C3=A1bor =
<szeder.dev@gmail.com> wrote:
>=20
>>>>> Or print it in a different color? Maybe red?
>>>>>=20
>>>>> See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625
>>>>=20
>>>> I considered using color for the first line, but then didn't do it,
>>>> because I didn't want to decide the color :)
>>>> Anyway, red is the general error/failure color, but this is =
neither.  It
>>>> could either be green, to match the color of the build job's =
result, or
>>>> something neutral like blue or yellow.
>>>=20
>>> You are right about red. I think I like yellow to express "warning".
>>> But this is just a nit.
>>=20
>> OK, yellow it will be then.
>=20
> Oh, hang on!  Have a look:
>=20
>  https://travis-ci.org/szeder/git/jobs/322841285#L629
>=20
> That yellow is barely different from default text color.
> Bold stands out much better, but notice how Travis CI uses bold for =
all
> its messages.  Therefore I think we should not use bold and leave it
> exclusive to Travis CI's messages.
>=20
> Green looks good:
>=20
>  https://travis-ci.org/szeder/git/jobs/322372326#L629

Agreed. Green looks good! :-)

- Lars=
