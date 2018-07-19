Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 835671F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeGSR0B (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:26:01 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46662 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbeGSR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:26:00 -0400
Received: by mail-vk0-f66.google.com with SMTP id b14-v6so4704441vke.13
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D1f6zaR2f4KdjFUuyZrYr5VFVq41V+n2K62LUALdT2Q=;
        b=LkurDVpfjqQvCvsx4anGFkqdNiKu0csaSLWzbx9BxjiUyl9zouFYDkBh96RdMIhbT4
         rLg3g7ky6Aa62/pQKfXYg5MgOTL+AZndfavNlSWjlRjksDTEFIL2YnbN0AQ70RjhRbN6
         ntpybxinH3aZKBOzCCVsR2VZld5p07Ec8Cnvwx8O8NbJ0nzScXhdCj3iJYvnq2jfb8Y9
         1jxJOXimXXcPMhGkC1ukEqUD0WOZjoWnbbFV9tfbH/6dvG5vWGn1OzMiaKvGOcOZb1mK
         dwpS1dlkCtgCDk/8exqDKWZA0JFpPbEsVgQz6zJgoFHwHnjDX4yxmAKiI8Z6ucXZxcA2
         sbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D1f6zaR2f4KdjFUuyZrYr5VFVq41V+n2K62LUALdT2Q=;
        b=Wlafp2ZTGCZQr+f2eLYmzY/4EChTQjd/0964X81U07doEatzUnwGmw6YLaK4tT09Wx
         cH0RIihBhEQBfe1ZlZo89LtU8a2WP/BsyvD4wWvW7/TVpTU6hkjiO+jJJP3tvMGV2Pbq
         Su6MzNzO51HXPYQBXZF+5PRVFMNkedIHtC/Z8l0/b1wQPeTO3m//sofFNZdtYBtAR53w
         6U2+DyFm5E72NWIf11TsMPa8u+hbKij+KLlSDYE5y7dMEXYcKHXtYP+FaI6pIXU/hzI/
         xUCM09UJvPhbXn/IfApbMQsL4wGj7X1oxRAd+nWsZ7bN72st+ZtlShIeXfB2UKWD1y0B
         G4vQ==
X-Gm-Message-State: AOUpUlHwA4NdfRGFFgFoGP1GdzrKEladaAnRM5oRiYi/cgkLP2tf/dYT
        o4bCwW0d2H9fEzU30XYjIqqS3VYJEIJIZ9I3gzs=
X-Google-Smtp-Source: AAOMgpdVcdm7tREuJRv9fEWtI3H756uZ36hfTgKsilEd57pQcH68iXV67s+fnAmhfVmwqhqr70rBlbCaClIuryHPpXs=
X-Received: by 2002:a1f:5043:: with SMTP id e64-v6mr6521758vkb.47.1532018520694;
 Thu, 19 Jul 2018 09:42:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 09:42:00
 -0700 (PDT)
In-Reply-To: <20180719151640.GA24997@duynguyen.home>
References: <20180718225110.17639-1-newren@gmail.com> <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com> <20180719151640.GA24997@duynguyen.home>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Jul 2018 09:42:00 -0700
Message-ID: <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 8:16 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 19, 2018 at 07:57:37AM +0200, Duy Nguyen wrote:
>> I thought 2M was generous but I was obviously wrong. I'd like to see
>> the biggest delta size in this pack and whether it's still reasonable
>> to increase OE_DELTA_SIZE_BITS. But if it's very close to 4GB limit
>> then we could just store 64-bit delta size in a separate array.
>
> I realize now that these two options don't have to be mutually
> exclusive and I should provide a good fallback in terms of performance
> anyway.
>
> So Elijah, could you try this patch and see if performance and pack
> size go back to 1.7.0? I can write proper commit message and test
> support later if it proves a good improvement.

Thanks for the quick turnaround.  Unfortunately, I have some bad news.
With this patch, I get the following:

$ /usr/bin/time -f 'MaxRSS:%M Time:%e' git gc --aggressive
Enumerating objects: 4460703, done.
Counting objects: 100% (4460703/4460703), done.
Delta compression using up to 40 threads.
Compressing objects: 100% (3807140/3807140), done.
Writing objects: 100% (4460703/4460703), done.
Total 4460703 (delta 2831383), reused 1587071 (delta 0)
error: failed to unpack compressed delta at offset 183854150 from
.git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack
fatal: packed object 20ce811e53dabbb8ef9368c108cbbdfa65639c03 (stored
in .git/objects/pack/pack-30d4f0b0e5a03dc91a658a0586f4e74cdf4a94d6.pack)
is corrupt
error: failed to run prune
MaxRSS:40025196 Time:2531.52


It looks like this comes after it deleted the old packs, so running
git fsck afterwards prints lots of errors.  Just in case they're
helpful at all, there are 26 "error: failed to unpack compressed delta
at offset..." messages, 26 "error: cannot unpack ... from ... at
offset ..." messages, 17 "error: failed to read delta base object..."
messages, 7 "broken link from ... to ..." messages, four missing
blobs, and three missing trees.

(This was run on a copy of the repo, so no harm done; I can still use
the original.)


> -- 8< --
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ebc8cefb53..7f3546057d 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2023,10 +2023,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>         delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
>         if (!delta_buf)
>                 return 0;
> -       if (delta_size >= (1U << OE_DELTA_SIZE_BITS)) {
> -               free(delta_buf);
> -               return 0;
> -       }
>
>         if (DELTA(trg_entry)) {
>                 /* Prefer only shallower same-sized deltas. */
> diff --git a/pack-objects.c b/pack-objects.c
> index 92708522e7..191ed45faf 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -160,6 +160,8 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
>
>                 if (!pdata->in_pack_by_idx)
>                         REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
> +               if (pdata->delta_size)
> +                       REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc);
>         }
>
>         new_entry = pdata->objects + pdata->nr_objects++;
> @@ -177,3 +179,17 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
>
>         return new_entry;
>  }
> +
> +void oe_prepare_delta_size_array(struct packing_data *pack)
> +{
> +       int i;
> +
> +       /*
> +        * nr_alloc, not nr_objects to align with realloc() strategy in
> +        * packlist_alloc()
> +        */
> +       ALLOC_ARRAY(pack->delta_size, pack->nr_alloc);
> +
> +       for (i = 0; i < pack->nr_objects; i++)
> +               pack->delta_size[i] = pack->objects[i].delta_size_;
> +}
> diff --git a/pack-objects.h b/pack-objects.h
> index edf74dabdd..978500e474 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -14,7 +14,7 @@
>   * above this limit. Don't lower it too much.
>   */
>  #define OE_SIZE_BITS           31
> -#define OE_DELTA_SIZE_BITS     20
> +#define OE_DELTA_SIZE_BITS     21
>
>  /*
>   * State flags for depth-first search used for analyzing delta cycles.
> @@ -93,7 +93,6 @@ struct object_entry {
>                                      * uses the same base as me
>                                      */
>         unsigned delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
> -       unsigned delta_size_valid:1;
>         unsigned in_pack_idx:OE_IN_PACK_BITS;   /* already in pack */
>         unsigned z_delta_size:OE_Z_DELTA_BITS;
>         unsigned type_valid:1;
> @@ -130,6 +129,7 @@ struct packing_data {
>         uint32_t index_size;
>
>         unsigned int *in_pack_pos;
> +       unsigned long *delta_size;
>
>         /*
>          * Only one of these can be non-NULL and they have different
> @@ -330,20 +330,27 @@ static inline void oe_set_size(struct packing_data *pack,
>  static inline unsigned long oe_delta_size(struct packing_data *pack,
>                                           const struct object_entry *e)
>  {
> -       if (e->delta_size_valid)
> +       if (!pack->delta_size)
>                 return e->delta_size_;
> -       return oe_size(pack, e);
> +       return pack->delta_size[e - pack->objects];
>  }
>
> +void oe_prepare_delta_size_array(struct packing_data *pack);
>  static inline void oe_set_delta_size(struct packing_data *pack,
>                                      struct object_entry *e,
>                                      unsigned long size)
>  {
>         e->delta_size_ = size;
> -       e->delta_size_valid = e->delta_size_ == size;
> -       if (!e->delta_size_valid && size != oe_size(pack, e))
> -               BUG("this can only happen in check_object() "
> -                   "where delta size is the same as entry size");
> +       if (!pack->delta_size && e->delta_size_ == size)
> +               return;
> +       /*
> +        * We have had at least one delta size exceeding OE_DELTA_SIZE_BITS
> +        * limit. delta_size_ will not be used anymore. All delta sizes are now
> +        * from the delta_size[] array.
> +        */
> +       if (!pack->delta_size)
> +               oe_prepare_delta_size_array(pack);
> +       pack->delta_size[e - pack->objects] = size;
>  }
>
>  #endif
> -- 8< --
>
>
> --
> Duy
