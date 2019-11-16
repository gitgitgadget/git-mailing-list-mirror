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
	by dcvr.yhbt.net (Postfix) with ESMTP id 649091F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 21:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfKPVNw (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 16:13:52 -0500
Received: from mout.web.de ([212.227.15.14]:56751 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfKPVNv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 16:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573938829;
        bh=qceHcb6wYhD7AUfuAo+4SXzGYfw9F0IceZI91mbMyWY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=OvGCEzLNnbcciAHQqaml0YvCcMMSdA5/GS2lAkFyOr3hOrYRHpzEo7b2sBCmiIOal
         tC7vQHvS1rU9UU1qsa2XZgu4xSVHRKg1sltntkNOBrtxIIQJFgAnE8PEwgSDZUMwyg
         PFlILLEYgkraLO8vYXifI7hT+I+bzCn18idTUV4U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgHau-1i2VHF2NtM-00nkUL; Sat, 16
 Nov 2019 22:13:49 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Message-ID: <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
Date:   Sat, 16 Nov 2019 22:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HLoOxM88PCd4u9YBPcHx4mTwB1KI8M+NRnqCwQmDVaanFHoLjPH
 CETHS28EDsKFzX3G3LByuzC8cdm6/Z4vUxa+sksLDmSkkiTf13apGcUQLeOUePS1GuQEALi
 A7pjF4cwWRKZyLJxlWH0ySolMndCRs9iApFJbfZ63XfqBsH3SMQywd9ER8a4ZPU5kk2zbCU
 1lTND+F2fKR8ft5na3Mtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RGtpoadMV2M=:H6ketVMNo4oTIOJ+fI8Z/J
 Z9/j3Si3uvobRk5Sb2Gdl4j53VQwshbzMHGier909Nz5xDg80sC98GvsyRocPW2Ey6F3KpSn4
 yPIdXfeRjvNnCHA0JvjGJSDJjh7TSk7kJV/WNPe9iB5PveelmIbTgfF2XcdBpGd+BuLBBkgaK
 I19sgba2prYKgZDBPybykFa5m6Q2xhkhzpp0eUFGx89fCJClJiVdHxYMYxR/2d+GRcRgUDd31
 PiaY8ol8aOy4rWa1CnxRIY6/G0IOX6aCRGiLhJbzBDGmJx/3UcInhS+q9ZCylhAjGtA/aPDJh
 RFrzLGLZurlteSiz6Q14kgG+OkFPq4+RsrVEXt9n2eLoR2GtJTPhZQyHOvSy7thwmBBS5MYos
 XmXRSklhhLuYqG1HX2qZ8SMGOGgcr4Up4eYVpDPJfrgTjKVHlw5QWJW6D5HERF+G6f7iZNiTb
 SLOGFDnBZ2YdkkpPYg9FWDvQZ4Pcp+l9F8lj5xTDmO3k7c/Ju5yhyiy+6lrvee14JXh/glg8a
 lMu5n0XjYh0agyt09HqlXdfly+6Vlr4WtLsiNEtGB1mY78NwlvOdFsCQlPggAKzdiyX8l/t93
 HAR685JeAxqM3WesA2G4iGIL9dvsB5j1cCAM2tws13YM4SCMT3HmE/5DeU47aoLtXPZwp5OKJ
 uzzWIiiOR//5REuf8bYHjWUII01470fyUfPJdDN9IitD/ZblO9IaRhO6sl+3HTrDKgOntJznV
 AKU1Hps6xPfjZul2EbvB6z/vK33iP61EoqqQ7eSLnLoXyGr8xq1iow0juxrUTWHGjXxns7uMW
 KF7RPI3afG8cCXmb4UOQvKebRUQHlm0Oder3NEHxEIvm1TkFfzTfZZAac6IYDoP5hhtmQeeZw
 WNxGJa8Vd6GxXQzlqbWZ2Svfpinaa6bXm9YItZBbT9UyOQvyTFxqEJCV7AJSHlUuUfdODZsdv
 5aY511QbaneCBRPBahNMW42zeILRhYMbpWBua8U4v2Iar/oQC5b6yuSrd212x8mG6ekZ1ChgW
 YeGSsvrA8fIpqNiofHoei6XI5hd+8Gcnm4PEVDcvWPEVJCABXGazmqlVBoeDnXkofe1l6fJ+t
 EN0wBtRBxanY5lZbBrT6KWz6xYdyHkr41dHHw5gv3GJBAewk0OqqNsgIAqjtBm/XdB5egi/0X
 gt0AsMr0NjhNJKsPFfbiuGt7v38Cq6RwtF7/AdCOv2j5uQXrwmZLHVwJfnYwGhN9TkvF7GgzL
 JIBPR/rC82kQxtt+nVXJn0oi+l4t6UP7fKkhp7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.11.19 um 21:37 schrieb Markus Elfring:
>> This eliminates duplication in the semantic patch, which is good.
>
> Thanks that you think in such a direction.
>
>
>> It messes up the indentation of n in some of the cases in 921d49be86 ("=
use
>> COPY_ARRAY for copying arrays", 2019-06-15), though.  Hmm, but that can
>> be cured by duplicating the comma:
>
> I have picked up further improvement possibilities for this SmPL script.
> Would you like to integrate any of these changes?

Not sure, could you please elaborate on the benefits of each proposed
change?

> @@
> expression dst, src, n, E;
> @@
>  memcpy(dst, src, sizeof(
> +                        *(
>                            E
> -                           [...]
> +                         )
>                          ) * n
>        )

That's longer and looks more complicated to me than what we currently have=
:

  @@
  expression dst, src, n, E;
  @@
    memcpy(dst, src, n * sizeof(
  - E[...]
  + *(E)
    ))

Avoiding to duplicate E doesn't seem to be worth it.  I can see that
indenting the sizeof parameter and parentheses could improve readability,
though.

> @@
> type T;
> T *ptr;
> T[] arr;
> expression E, n;
> @@
>  memcpy(
> (       ptr, E, sizeof(
> -                      *(ptr)
> +                      T
>                       ) * n
> |       arr, E, sizeof(
> -                      *(arr)
> +                      T
>                       ) * n
> |       E, ptr, sizeof(
> -                      *(ptr)
> +                      T
>                       ) * n
> |       E, arr, sizeof(
> -                      *(arr)
> +                      T
>                       ) * n
> )
>        )

This still fails to regenerate two of the changes from 921d49be86 (use
COPY_ARRAY for copying arrays, 2019-06-15), at least with for me (and
Coccinelle 1.0.4).

> @@
> type T;
> T* dst_ptr, src_ptr;
> T[] dst_arr, src_arr;
> expression n, x;
> @@
> -memcpy
> +COPY_ARRAY
>        (
> (       dst_ptr
> |       dst_arr
> )
>        ,
> (       src_ptr
> |       src_arr
> )
> -      , (n) * \( sizeof(T) \| sizeof(*(x)) \)
> +      , n
>        )

That x could be anything -- it's not tied to the element size of source
or destination.  Such a transformation might change the meaning of the
code, as COPY_ARRAY will use the element size of the destination behind
the scenes.  So that doesn't look safe to me.

> @@
> type T;
> T* dst, src, ptr;
> expression n;
> @@
> (
> -memmove
> +MOVE_ARRAY
>         (dst, src
> -                , (n) * \( sizeof(* \( dst \| src \) ) \| sizeof(T) \)
> +                , n
>         )
> |
> -ptr =3D xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
> +ALLOC_ARRAY(ptr, n)
> );

memmove/MOVE_ARRAY and xmalloc/ALLOC_ARRAY are quite different; why
would we want to jam transformations for them into the same rule like
this?  The only overlap seems to be n.  Handling memmove/MOVE_ARRAY and
memcpy/COPY_ARRAY together would make more sense, as they take the same
kinds of parameters.

I didn't know that disjunctions can be specified inline using \(, \|
and \), though.  Rules can be much more compact that way.  Mixing
languages like that can also be quite confusing.  Syntax highlighting
could help; https://github.com/ahf/cocci-syntax at least doesn't
show those any different from regular code, though.

> Now I observe that the placement of space characters can be a coding sty=
le
> concern at four places for adjusted lines by the generated patch.
> Would you like to clarify remaining issues for pretty-printing
> in such use cases?

Ideally, generated code should adhere to Documentation/CodingGuidelines,
so that it can be accepted without requiring hand-editing.

Ren=C3=A9
