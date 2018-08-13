Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24A321F404
	for <e@80x24.org>; Mon, 13 Aug 2018 03:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeHMGOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 02:14:20 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:38046 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeHMGOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 02:14:20 -0400
Received: by mail-io0-f169.google.com with SMTP id v26-v6so13328790iog.5
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 20:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q+7WHJB4WdUstDfm8akABfpy/lxRrKSwS6KZMRkydms=;
        b=bedFM6xUMnRESPk/kgcIY5bz/6PFYqTNFvFJJGtjwT1+4BA9HbaOyX7/0DJMdo5oKe
         q5juQ8qVBGXu2MWVOBIkaU/LwA9DfeBNgst48/K8dIjdD5CrvtRk45VTbp21Y0wDGEoX
         WOHAa+9sVpxGc+RNJmvZPEVQcmZeRtCQ5dUIBVb3Sn8uT7H9LLOzazIZe1Rh/F9z2EZD
         KG6F9go2n5yKRIKR6oKWeFQfmpXPFqCJ5Ef3uAxwRlSoKOYHln4f6HdaavBjWV+9PGG+
         fOu2ZZctWAjJZL0VnZY6eewcdPxu4j0IKdIaqLiHnoqmTIKixmGPg16tlQz1r9kcRZFg
         1xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q+7WHJB4WdUstDfm8akABfpy/lxRrKSwS6KZMRkydms=;
        b=FYmlkStyPJW3UWyuNoQBNdozgnPRqyMpKO3qPRzqVrUzWD4lEpn8NomhN9rHEcdl/D
         tMbwabXgUnNBN7Xabv1RYagIj96n3MgRHOaMlQUxaHA5YFkShXVnwK1p/xKolYXQoiHA
         1azm2V/ALBwfTLF3B9TUCwmDFiAcVjHpiJspetMaaV0HBevvcWUjwxuC27tIQJaGDLLG
         SOkEXJm58YqKvGZ/ChX+tZHHSiOqpYTgpFzzZBZ6XXgdlQbGqPsjnbtOFOslEeHYg1Z8
         rbPYdMIBKKil3quFg4qwxppScnqQRZ3c2BXVFwIcqlgKciOhp+boXasSmvAmEDwVToX3
         vghQ==
X-Gm-Message-State: AOUpUlG+Z2ZLxx4SYvhWlkD6JvlAuiJ3etr+OksZBaSZ0U3PDbUlbuSw
        wEsHXSuYm4y0UrteCqRNwW4A76N6ReGv0bXnegM=
X-Google-Smtp-Source: AA+uWPzZOzqW31POeCBiqtRTfPZgFVCjvMAvmLiJ03v/wLg7dwaRxgFde/m8xwEBVYZOsZT/tIbGpcWVkUIROrm2wf8=
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr13355842iob.5.1534131240694;
 Sun, 12 Aug 2018 20:34:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sun, 12 Aug 2018 20:33:59
 -0700 (PDT)
In-Reply-To: <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
 <20180812051151.6425-2-chriscool@tuxfamily.org> <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 13 Aug 2018 05:33:59 +0200
Message-ID: <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] Add delta-islands.{c,h}
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER Gabor <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 3:14 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> On 12/08/18 06:11, Christian Couder wrote:

>> Because the inefficiency primarily arises when an
>> object is delitified against another object that does
>
> s/delitified/deltified/ ?

Ok, this will be in the next reroll if any.

>> not exist in the same fork, we partition objects into
>> sets that appear in the same fork, and define
>> "delta islands". When finding delta base, we do not
>> allow an object outside the same island to be
>> considered as its base.

>> --- /dev/null
>> +++ b/delta-islands.c
>> @@ -0,0 +1,493 @@
>> +#include "cache.h"
>> +#include "attr.h"
>> +#include "object.h"
>> +#include "blob.h"
>> +#include "commit.h"
>> +#include "tag.h"
>> +#include "tree.h"
>> +#include "delta.h"
>> +#include "pack.h"
>> +#include "tree-walk.h"
>> +#include "diff.h"
>> +#include "revision.h"
>> +#include "list-objects.h"
>> +#include "progress.h"
>> +#include "refs.h"
>> +#include "khash.h"
>
> I was wondering how many copies of the inline functions
> introduced by this header we had, so:
>
>   $ nm git | grep ' t ' | cut -d' ' -f3 | sort | uniq -c | sort -rn | grep kh_
>         3 kh_resize_sha1
>         3 kh_put_sha1
>         3 kh_init_sha1
>         3 kh_get_sha1
>         1 kh_resize_str
>         1 kh_resize_sha1_pos
>         1 kh_put_str
>         1 kh_put_sha1_pos
>         1 kh_init_str
>         1 kh_init_sha1_pos
>         1 kh_get_str
>         1 kh_get_sha1_pos
>         1 kh_destroy_sha1
>   $
>
> Looking at the individual object files, we see:
>
>   $ nm pack-bitmap-write.o | grep ' t ' | grep kh_
>   00000000000001cc t kh_get_sha1
>   00000000000001b7 t kh_init_sha1
>   000000000000085e t kh_put_sha1
>   0000000000000310 t kh_resize_sha1
>   $
>
> So, the two instances of the sha1 hash-map are never
> destroyed (kh_destroy_sha1 is not present in the object
> file).

This is interesting (even though it seems related to more code than
the current patch series).

As those hash maps are in 'struct bitmap_writer' and a static instance is used:

  static struct bitmap_writer writer;

it maybe ok.

>   $ nm pack-bitmap.o | grep ' t ' | grep kh_
>   00000000000002d9 t kh_destroy_sha1
>   000000000000032b t kh_get_sha1
>   0000000000000daa t kh_get_sha1_pos
>   00000000000002c4 t kh_init_sha1
>   0000000000000d95 t kh_init_sha1_pos
>   00000000000009bd t kh_put_sha1
>   0000000000001432 t kh_put_sha1_pos
>   000000000000046f t kh_resize_sha1
>   0000000000000eee t kh_resize_sha1_pos
>   $
>
> The sha1_pos hash-map is not destroyed here.

Yeah, maybe a line like:

kh_destroy_pos(b->ext_index.positions);

is missing from free_bitmap_index()?

Adding that should be in a separate patch from this series though.

>   $ nm delta-islands.o | grep ' t ' | grep kh_
>   00000000000002be t kh_get_sha1
>   0000000000000e52 t kh_get_str
>   00000000000002a9 t kh_init_sha1
>   0000000000000e3d t kh_init_str
>   0000000000000950 t kh_put_sha1
>   00000000000014e4 t kh_put_str
>   0000000000000402 t kh_resize_sha1
>   0000000000000f96 t kh_resize_str
>   $
>
> And neither the sha1 or str hash-maps are destroyed here.
> (That is not necessarily a problem, of course! ;-) )

The instances are declared as static:

  static khash_sha1 *island_marks;

  static kh_str_t *remote_islands;

so it maybe ok.

>> +struct island_bitmap {
>> +     uint32_t refcount;
>> +     uint32_t bits[];
>
> Use FLEX_ARRAY here? We are slowly moving toward requiring
> certain C99 features, but I can't remember a flex array
> weather-balloon patch.

This was already discussed by Junio and Peff there:

https://public-inbox.org/git/20180727130229.GB18599@sigill.intra.peff.net/

>> +};

>> +int in_same_island(const struct object_id *trg_oid, const struct object_id *src_oid)
>
> Hmm, what does the trg_ prefix stand for?
>
>> +{
>> +     khiter_t trg_pos, src_pos;
>> +
>> +     /* If we aren't using islands, assume everything goes together. */
>> +     if (!island_marks)
>> +             return 1;
>> +
>> +     /*
>> +      * If we don't have a bitmap for the target, we can delta it
>
> ... Ah, OK, trg_ => target.

I am ok to replace "trg" with "target" (or maybe "dst"? or something
else) and "src" with "source" if you think it would make things
clearer.

>> +static void add_ref_to_island(const char *island_name, const struct object_id *oid)
>> +{
>> +     uint64_t sha_core;
>> +     struct remote_island *rl = NULL;
>> +
>> +     int hash_ret;
>> +     khiter_t pos = kh_put_str(remote_islands, island_name, &hash_ret);
>> +
>> +     if (hash_ret) {
>> +             kh_key(remote_islands, pos) = xstrdup(island_name);
>> +             kh_value(remote_islands, pos) = xcalloc(1, sizeof(struct remote_island));
>> +     }
>> +
>> +     rl = kh_value(remote_islands, pos);
>> +     oid_array_append(&rl->oids, oid);
>> +
>> +     memcpy(&sha_core, oid->hash, sizeof(uint64_t));
>> +     rl->hash += sha_core;
>
> Hmm, so the first 64-bits of the oid of each ref that is part of
> this island is added together as a 'hash' for the island. And this
> is used to de-duplicate the islands? Any false positives? (does it
> matter - it would only affect performance, not correctness, right?)

I would think that a false positive from pure chance is very unlikely.
We would need to approach billions of delta islands (as 2 to the power
64/2 is in the order of billions) for the probability to be
significant. GitHub has less than 50 millions users and it is very
unlikely that a significant proportion of these users will fork the
same repo.

Now if there is a false positive because two forks have exactly the
same refs, then it is not a problem if they are considered the same,
because they are actually the same.

>> +}

> Sorry, I spent so long reading this patch, I have run out of
> time tonight (and I am busy tomorrow) to read the rest of the
> series.

Thank you for your interesting review,
Christian.
