Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F7B1F404
	for <e@80x24.org>; Sat, 31 Mar 2018 04:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750854AbeCaEvm (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 00:51:42 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35314 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeCaEvl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 00:51:41 -0400
Received: by mail-ot0-f193.google.com with SMTP id f47-v6so2239476oth.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iuYdlXCXV2XXZJFOuBhvieMqakT49ZUFElguOYdiBQ0=;
        b=M5lnZwS+RBH9tO6lD+MbyW7EFknLvEnrtNjsMUdIH9IrC2aDroNGuekp7OzVZNnIDY
         wz6eQbBAv+0voKsjFS8q3l6ufRjwcNqOdYUl82kn5pHc4hNQoNeU7N+PvZERdyGtWcbl
         MeFY5XSVdpCG3Yz4qszirTILpWvggv0UmsoXGNkXbdTJ5NuPrLfJQBnnfp7co/80RNhh
         E9LhECDd+NHMIsC0PguxXJzEDoER7cV44o8vC1c5Svu87sZKCMy23XUwIH8tPmB8qIav
         poJpM17G54zuleQkiZi0bD8izmhUHELqdXXB+HaW5IEY9BzAFKVUJ+v2pnu3HlyBkWGs
         aQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iuYdlXCXV2XXZJFOuBhvieMqakT49ZUFElguOYdiBQ0=;
        b=QDMQ5J9jEeLwae9kPXzkjljTxlYhm40fh0PJtCIaB61nLnxWwN4kFFUGPl6Oxcx1Df
         XKW2xQ1mtSwYwv/w6WSY4q8b+NwwT4y8RdjXNz0YtHSCP6lsUELV97GCnQxWfpLRTd+b
         0NChwAys6LsPUAsF0gJdfQkB/JTKEjaq258IqfDD1sM+dXYnFkS4stVcb8ur3bYSLqax
         EsZGVM24I9rGAgwpUP5vFHImCV/YZZ+w8mLbw3lQQ4xo6OhSGHMIgzBuc+JYAunn0tRj
         HeHnKqlpcHO2EyMiXfQyx5ccuJBhfaABDmGhtgNH4uf0t3Yrqc+Xy6KcZFstTQm2jf9m
         AqmA==
X-Gm-Message-State: ALQs6tCAScu+vi2i7sRFNEi/cM5OnoE9LxaZ3UaVTAOkpzqFo3c/CwMg
        0ReCg4OhrKJhaF8HgPZLSFSeUWjTbGLB1N85zpg=
X-Google-Smtp-Source: AIpwx4+R/dAgA7N0oS1fFBkuognv5P/JY2i1OuMVUVC7NP0Pgj5HO68NKnYNn4XVus+3D68Vne0Y40KmLA7jvbyy4nM=
X-Received: by 2002:a9d:e84:: with SMTP id 4-v6mr958044otj.14.1522471901295;
 Fri, 30 Mar 2018 21:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 21:51:10 -0700 (PDT)
In-Reply-To: <20180330204812.GE14782@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180324063353.24722-7-pclouds@gmail.com> <20180330204812.GE14782@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 06:51:10 +0200
Message-ID: <CACsJy8Dma-xrDcK1vQ-s4F+Dwt4oWOQ89yr33OPJdO1g0ryQWw@mail.gmail.com>
Subject: Re: [PATCH v7 06/13] pack-objects: move in_pack out of struct object_entry
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 10:48 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 24, 2018 at 07:33:46AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index e1244918a5..b41610569e 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -29,6 +29,8 @@
>>  #include "list.h"
>>  #include "packfile.h"
>>
>> +#define IN_PACK(obj) oe_in_pack(&to_pack, obj)
>
> How come this one gets a macro, but the earlier conversions don't?
>
> I guess the problem is that oe_in_pack() is defined in the generic
> pack-objects.h, but &to_pack is only in builtin/pack-objects.c?
>
> I wonder if it would be that bad to just say oe_in_pack(&to_pack, obj)
> everywhere. It's longer, but it makes the code slightly less magical to
> read.

Longer was exactly why I added these macros (with the hope that the
macro upper case names already ring a "it's magical" bell). Should I
drop all these macros? Some code becomes a lot more verbose though.

>> +static void prepare_in_pack_by_idx(struct packing_data *pdata)
>> +{
>> +     struct packed_git **mapping, *p;
>> +     int cnt =3D 0, nr =3D 1 << OE_IN_PACK_BITS;
>> +
>> +     if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
>> +             /*
>> +              * leave in_pack_by_idx NULL to force in_pack[] to be
>> +              * used instead
>> +              */
>> +             return;
>> +     }
>> +
>> +     ALLOC_ARRAY(mapping, nr);
>> +     mapping[cnt++] =3D NULL; /* zero index must be mapped to NULL */
>
> Why? I guess because index=3D=3D0 is a sentinel for "we're using the smal=
l
> index numbers?"

No because by default all values in object_entry is zero (or NULL). If
I remember correctly, some code will skip setting in_pack pointer to
leave it NULL. When we convert it to an index, it should also point to
NULL.

>> +     prepare_packed_git();
>> +     for (p =3D packed_git; p; p =3D p->next, cnt++) {
>> +             if (cnt =3D=3D nr) {
>> +                     free(mapping);
>> +                     return;
>> +             }
>> +             p->index =3D cnt;
>> +             mapping[cnt] =3D p;
>> +     }
>> +     pdata->in_pack_by_idx =3D mapping;
>> +}
>
> What happens if we later have to reprepare_packed_git() and end up with
> more packs? We only call this for the first pack.
>
> It may well be handled, but I'm having trouble following the code to see
> if it is. And I doubt that case is covered by our test suite (since it
> inherently involves a race).

I don't think I covered this case. But since "index" field in
packed_git should be zero for the new packs, we could check and either
add it to in_pack_by_idx[].

>>  /*
>> + * The size of struct nearly determines pack-objects's memory
>> + * consumption. This struct is packed tight for that reason. When you
>> + * add or reorder something in this struct, think a bit about this.
>> + *
>
> It's funny to see this warning come in the middle. Should it be part of
> the final struct reordering at the end?

It was at the end in some version, the I shuffled the patches and
forgot about this one :)
--=20
Duy
