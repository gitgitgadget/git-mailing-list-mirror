Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6C61F406
	for <e@80x24.org>; Thu, 18 Jan 2018 06:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752588AbeARGW7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 01:22:59 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35095 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeARGW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 01:22:58 -0500
Received: by mail-qt0-f193.google.com with SMTP id u10so27709961qtg.2
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 22:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ydB4cQulH61G8PHZSZO2jeTG3w9/qgaJq9lmCv/Yqv8=;
        b=HOe8yJTXcHczc58E8JYnxDp4vcOk14i3I4GvmhUH4FCy3P1fvBawW5n0Jc1OtfK4cD
         BXO1McjM/tKU8juxpRLuEvsBDt3mWcURoWpKi0lJGzqGKwMVyAM6+eGlYKnwN+xFp5Pa
         jF578G3ngaECsnsLhyoWevTls4StB35bhRa+X6R2Mpnz4CH/CXFLDBtvAYBFyDAWqJme
         Mq4XyGSHI/3b++9c+SrRhNfEYnmWUf45MKKde02sTKJfOjXi2MkT6Eek1H0EqYePq2tX
         8MqUI691uKK+8j/sCo/IXLO7rPbZ9HOq8+vtInD9GA8UrStjqefAeuaKATViQ717LDQl
         z8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ydB4cQulH61G8PHZSZO2jeTG3w9/qgaJq9lmCv/Yqv8=;
        b=bPKU5ATlzxBeG8yZmqjMM74KzC75KgVeidK6jJP+CDaeQr4q21KOg9yuSbTBANLG9t
         nPHD9nkHLWLXfnoYiHJsnHS8ujQm1hLZOw0dRwlClXgLxe9iDrR6Cgv/OGyP3JmtkA9S
         NRoaecH2WvlIFh78UPje/mWQF+A/BZ268kv7lD5ZtZ08z99gNME0dVRjIvG9g+sPuCXF
         7lYfPlz2J+xp+XTwBMSuakN0jAdtw/S3zFpRCkQVib/Ed1JTv0QX69hco0z/8bhRwJSo
         OM5+RRXTWq9PQO1pBCWtlxPJqJm7gWgftxocVOFqXQ4QwlHefxtaXS6YkoXh59k9eayN
         8yZg==
X-Gm-Message-State: AKwxytd8aZ4V3VvOZTcO6EJOQYrL/aR1aT3AVG1c3sB8hHRv75028rao
        iebjJ2q4UIOeMpmORJ85J6XWux2k51vk5sUfXYk=
X-Google-Smtp-Source: ACJfBos1lFKj6KqmZa0HgRuEehff3zRfJEktb170Q+zoi1sgHjI1JaFYlYrhX+gu6AyAUjZSynPelr//2qmG+cK1VD8=
X-Received: by 10.55.104.17 with SMTP id d17mr19499928qkc.306.1516256577879;
 Wed, 17 Jan 2018 22:22:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.16.146 with HTTP; Wed, 17 Jan 2018 22:22:57 -0800 (PST)
In-Reply-To: <CAP8UFD1hnP3yab-qDKPkNcj5VadUD_HW5+V1e2nwPAB8r31zoQ@mail.gmail.com>
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
 <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <20180115213335.GB4778@sigill.intra.peff.net> <20180115220946.GF4778@sigill.intra.peff.net>
 <CAL21BmmmX5-uisj+_=sDHwJO=fpXc41Wriw+uuxtR=gOio-HZQ@mail.gmail.com>
 <20180117214906.GC13128@sigill.intra.peff.net> <CAP8UFD1hnP3yab-qDKPkNcj5VadUD_HW5+V1e2nwPAB8r31zoQ@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 18 Jan 2018 09:22:57 +0300
Message-ID: <CAL21Bmm9P7p90GRRk4y9N5R6Gd3prEx53KyD3Cu1si6FHZAvkQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] cat-file: split expand_atom into 2 functions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-18 2:04 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> On Wed, Jan 17, 2018 at 10:49 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Jan 16, 2018 at 10:22:23AM +0300, =D0=9E=D0=BB=D1=8F =D0=A2=D0=
=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F wrote:
>>
>>> >> In other words, I think the endgame is that expand_atom() isn't ther=
e at
>>> >> all, and we're calling the equivalent of format_ref_item() for each
>>> >> object (except that in a unified formatting world, it probably doesn=
't
>>> >> have the word "ref" in it, since that's just one of the items a call=
er
>>> >> might pass in).
>>>
>>> Agree! I want to merge current edits, then create format.h file and
>>> make some renames, then finish migrating process to new format.h and
>>> support all new meaningful tags.
>>
>> I think we have a little bit of chicken and egg there, though. I'm
>> having trouble reviewing the current work, because it's hard to evaluate
>> whether it's doing the right thing without seeing the end state.
>
> Yeah, to me it feels like you are at a middle point and there are many
> ways to go forward.

OK. Maybe I misunderstood you and Jeff in our call, I thought that was
your idea to make a merge now, sorry. I will continue my work here.

>
> As I wrote in another email though, I think it might be a good time to
> consolidate new functionality by adding tests (and perhaps
> documentation at the same time) for each new atom that is added to
> ref-filter or cat-file. It will help you refactor the code and your
> patch series later without breaking the new functionality.
>
>> So what
>> I was suggesting in my earlier mails was that we actually _not_ try to
>> merge this series, but use its components and ideas to build a new
>> series that does things in a bit different order.
>
> Yeah, I think you will have to do that, but the tests that you can add
> now for the new features will help you when you will build the new
> series.
>
> And hopefully it will not be too much work to create this new series
> as you will perhaps be able to just use the interactive rebase to
> build it.
>
> I also don't think it's a big problem if the current patch series gets
> quite long before you start creating a new series.
