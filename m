Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4ED1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 07:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfKQH4W (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 02:56:22 -0500
Received: from mout.web.de ([217.72.192.78]:53883 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfKQH4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 02:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573977378;
        bh=pjdX1/J/PgKErQ477fzsksPc/c/THDNXmDRf2+cKdJI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gzvsQPK32Mbc1+bJ0IQgoROVQgT/lF6kJUPeXWMOeEVEpplRJ5c4As9qV0fjDH/os
         kuBzjmwNLXzofEinDI7OiMO1bO+J2PH/hz1ocxlmyYqgy0sKDqtQU3NI/vMnwClvAV
         OkI9Gd987raojIutXRfMt8isLe0kWDYyX6v9t4Ao=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8ko-1hzeky23y6-00cA1m; Sun, 17
 Nov 2019 08:56:18 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
 <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <57b5d1c9-72c1-6fff-a242-90f5f24f0972@web.de>
Date:   Sun, 17 Nov 2019 08:56:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XHClz8uYd06qTNVBtgGdE0fKkIucvbpd/kUCRakvyMEKxxAgjDG
 phpKFtQUT/ZXRrGAxUs5iIhQSyHPaok7TpRaX8E6HM0ZmY0j4xa5Fodj5Baejyuo8jr+dL/
 QufZCcJLDYXIB1yRXbjUOcMzjT5TNvbGhLVLy81Mc9h8zpqwzmng/E8QVtG1UcPyFshoXu8
 eS07z3o2ZA7uR/1oTNlFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jRCJtkzOCyg=:qE002SZ5eSg0Ka6GZSxe5x
 hevQ5QTP1BEJ7VHb3wGAD1K/3rs2nWeoSoUOkxJ9NsrXui4ZZEJmmdUyJFFUVvqx2xH2hlLym
 yK4unHbZoRf2GXxeSgwr5r+yH9PTXHlpdysalZASn5gXS1wHxipQpuLyOizABTo04fmpVMDgi
 X6sxnTyGZ9tRkhmfLmvPE7VVzuePEbJFLuRqdXcCzlzUyGmLVos8Vw84KMouCDSaQKmAYjZAZ
 ZNVR926wf82dDqnUi1ZPXQNGY4xM0oqDcyxEzI5GLz0oGPev4C+vfROHUwt3sqTAUe7mtqStY
 z6XaVKPo/QJGVXlIbyWkQ0pET+2e48IjItTiAB9t0dH9+JdGOw1OWw8r3GcJONPRsgkdQpMqH
 0TqhhVqFF/PmQ4cSVGOn/3WTfjXLyvuugqczrJRRJYcCZvz21NpJtxIc3j3FPty/hnjuPJj87
 edXGqDwH36YOFDuNaiN4T6x0XdQY9gnLMmKvJIwFrcA6cjMDdvYBqj4bHTXQ4oVMt/eUdhNQq
 0ha9cNtDMf0/QSN6GjPyd39Qri1G174i4sVh7L0348ol25eKKIzPQMSn4hvWExcqzKF+/zpZj
 z96tqm0GgMLBzhvQFsZobFK2yFpDUaNtEM502VIBPrE8ImLmwkynwuyviDhzRjvnP4m+MFutq
 e+3pwCCFKU5S8Nf80vQQGk5aR5Kj2JTfRXv1tp5o/HmJ0w/wnT9slTInkRS+OJMJ9s8r5awcN
 Z4rHRXcmI8ca/hYKGSgaejyVI/9DVlHUqGnkmdC9FW4+g2iPxPQyxmrsyhdaOodGpiipXC5cq
 4YGsZHHXBuR9J4MKIBmXIxiArbdhQhQLPTDUFg5vuz7TZkLuyRw7ZzgpPu5/dw3ZMUZBu8n02
 LGkz4c5J/lRDsqYwky6BaY5qw0K56Q4zvIpYR3ZzN1RyRE2nIAxrdgWTzT0pLMBToYbBGEHXx
 T6ZWcG35v4iMCmYA9o5/XSG9IMMCzZZj3Lm0dHhrEE1wGVQno4HduaT2VeolWpaMd2JBNfSJy
 ovS7HFGOitwWCRqOYQqachHnkWJfuQtR8Itx1JDasI/h1lPVQtYvC9gt9dmuY/EFy0sbHeWN/
 pSDhYPnsgMlJEppws9lnlYrIaJvIl7tw+RIRZJMqGQNwxtXxg47Btq9uyGjaw3CUWa5tpTiq8
 1gQE89wZp5Hw5vAY/adkL9YqgMYinJ8qR0VQDysAGoLzZ4a2l8LcyXyQt6H2/9XoTiCQsEuUI
 1uNx7UW7L8jPEUdVnyhW1ak8FyLPKzT+6GQ8/gIIndw5xc+lo5s3hbLZbD4M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> @@
>> expression dst, src, n, E;
>> @@
>>  memcpy(dst, src, sizeof(
>> +                        *(
>>                            E
>> -                           [...]
>> +                         )
>>                          ) * n
>>        )
>
> That's longer and looks more complicated to me

I point another possibility out to express a change specification
by the means of the semantic patch language.
How would you think about such SmPL code if the indentation
will be reduced?


> than what we currently have:
>   @@
>   expression dst, src, n, E;
>   @@
>     memcpy(dst, src, n * sizeof(
>   - E[...]
>   + *(E)
>     ))
>
> Avoiding to duplicate E doesn't seem to be worth it.

I show other development preferences occasionally.


> I can see that indenting the sizeof parameter and parentheses could
> improve readability, though.

Thanks that you can follow such coding style aspects.


>> @@
>> type T;
>> T *ptr;
>> T[] arr;
>> expression E, n;
>> @@
>>  memcpy(
>> (       ptr, E, sizeof(
>> -                      *(ptr)
>> +                      T
>>                       ) * n
>> |       arr, E, sizeof(
>> -                      *(arr)
>> +                      T
>>                       ) * n
>> |       E, ptr, sizeof(
>> -                      *(ptr)
>> +                      T
>>                       ) * n
>> |       E, arr, sizeof(
>> -                      *(arr)
>> +                      T
>>                       ) * n
>> )
>>        )
>
> This still fails to regenerate two of the changes from 921d49be86
> (use COPY_ARRAY for copying arrays, 2019-06-15), at least with for me
> (and Coccinelle 1.0.4).

Would you become keen to find the reasons out for unexpected data processi=
ng
results (also by the software combination =E2=80=9CCoccinelle 1.0.8-00004-=
g842075f7=E2=80=9D)
at this place?

But this transformation rule can probably be omitted if the usage
of SmPL disjunctions will be increased in a subsequent rule, can't it?


>> @@
>> type T;
>> T* dst_ptr, src_ptr;
>> T[] dst_arr, src_arr;
>> expression n, x;
>> @@
>> -memcpy
>> +COPY_ARRAY
>>        (
>> (       dst_ptr
>> |       dst_arr
>> )
>>        ,
>> (       src_ptr
>> |       src_arr
>> )
>> -      , (n) * \( sizeof(T) \| sizeof(*(x)) \)
>> +      , n
>>        )
>
> That x could be anything -- it's not tied to the element size of source
> or destination.  Such a transformation might change the meaning of the
> code, as COPY_ARRAY will use the element size of the destination behind
> the scenes.  So that doesn't look safe to me.

Would you like to use the SmPL code =E2=80=9C*( \( src_ptr \| src_arr \) )=
=E2=80=9D instead?


>> @@
>> type T;
>> T* dst, src, ptr;
>> expression n;
>> @@
>> (
>> -memmove
>> +MOVE_ARRAY
>>         (dst, src
>> -                , (n) * \( sizeof(* \( dst \| src \) ) \| sizeof(T) \)
>> +                , n
>>         )
>> |
>> -ptr =3D xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
>> +ALLOC_ARRAY(ptr, n)
>> );
>
> memmove/MOVE_ARRAY and xmalloc/ALLOC_ARRAY are quite different;

These functions provide another programming interface.


> why would we want to jam transformations for them into the same rule
> like this?

Possible nicer run time characteristics by the Coccinelle software.


> The only overlap seems to be n.

These case distinctions can share also the metavariable =E2=80=9CT=E2=80=
=9D for the
desired source code deletion.


> Handling memmove/MOVE_ARRAY and memcpy/COPY_ARRAY together would make
> more sense, as they take the same kinds of parameters.

Would you like to adjust the SmPL code in such a design direction?


> I didn't know that disjunctions can be specified inline using \(, \|
> and \), though.  Rules can be much more compact that way.

I hope that more corresponding software improvements can be achieved.


> Mixing languages like that can also be quite confusing.

I agree to this development concern.


>> Now I observe that the placement of space characters can be a coding st=
yle
>> concern at four places for adjusted lines by the generated patch.
>> Would you like to clarify remaining issues for pretty-printing
>> in such use cases?
>
> Ideally, generated code should adhere to Documentation/CodingGuidelines,
> so that it can be accepted without requiring hand-editing.

But how does the software situation look like if the original source code
would contain coding style issues?

It seems to be possible to specify SmPL code in a way so that even questio=
nable
code layout would be preserved by an automatic transformation.

Regards,
Markus
