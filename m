Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39A61F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbeGTSKr (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:10:47 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37014 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTSKr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:10:47 -0400
Received: by mail-ua0-f195.google.com with SMTP id y10-v6so7937845uao.4
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=usoH1x2xy3Ec0Y/R8HITlyHSlFJIKX9VZ1d2qsSamjM=;
        b=TbD6yjyWcFV5R+B3REuQZq+RPRV8j+fB/efZ4eAow2BD52ITOyXTeqhVnTBV+YxC03
         2O4ybj0TkxLVvquggP3m1CuV4Va1pvY2EXdXtScOQyhQQzNpkR0UeE2ltBqlUagTehNB
         J+S5KYbjZ0/lykvhexUzB9dT9T5Wo0KPLuqthu6eUimvYpELZ7kjC6x2TuPWAG8BTEve
         RMZbqFARBR9zTcW5347jUj4E8uxhryqBq2vXe7ryylJu9+Z4w80mMhqafAYAKoHab+LG
         YjgtEHpifDS9Ufz8ylAaLG/XvtCOcpaIRGc5mE+wh99Uusm3p01+iqp1CVW9GAz5i+l9
         nJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=usoH1x2xy3Ec0Y/R8HITlyHSlFJIKX9VZ1d2qsSamjM=;
        b=srYNphqd3b5guNmUx2ZhD7hCSkE7Gj8gwCGAGfFesh2EW9kFcBk4JaObwtWJXtUrBx
         IH34stiAZEHqdouHM7mNexFQmgbfpDDuPQ2jbDBq97biyQM8YXR5pdWpShT7a1/IlUvh
         RN9nXFllAoQ5dSJdKUsAy3WAKsw69pBoiv9d0XJcKgpRUEQxeOy7KslQtnhFsibkUjVq
         hAdqVu6qz6bgHPGwlCruTaq6nx7gIL2u2/6qAqWsCu65oYCnHEvULgpzM2wSRbGS+Kdc
         nyIUmB8d/NYnKdWO8qYbZJkxw09SBvh5tBV5KFkgLRFapstcgzXOz1lx1q+Q4x7pm4Ho
         dbTA==
X-Gm-Message-State: AOUpUlEEmGL0/qArYORuTG2p0v+Vrx+lD1z9Vfb7/wb4W8Gqo9uRMWM/
        /hEpUlb6YMppiJemsC6YbpNAnQpM1hv4SZlWgWE=
X-Google-Smtp-Source: AAOMgpe1AfeTDFmtp72ia8ergf5rw6CvI1Jxk7aIpowPAiPVUHsb00t7nUytCdjzsyqZElsB1DR7Qhp5mP0n5RoKxl8=
X-Received: by 2002:a9f:3563:: with SMTP id o90-v6mr2007651uao.79.1532107293045;
 Fri, 20 Jul 2018 10:21:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 10:21:32
 -0700 (PDT)
In-Reply-To: <20180720052829.GA3852@sigill.intra.peff.net>
References: <20180718225110.17639-1-newren@gmail.com> <20180719054424.GB23884@sigill.intra.peff.net>
 <CACsJy8BNGboUb0F5NRR9tKj_P24j2ZgB48SCuLEphSHQAU2EUA@mail.gmail.com>
 <20180719151640.GA24997@duynguyen.home> <CABPp-BGE0yAgtOkSC0jUhq3M3ynX9pks5VnjVB_WMkYUVdirzA@mail.gmail.com>
 <20180719172358.GD4868@sigill.intra.peff.net> <20180719173135.GA24563@duynguyen.home>
 <20180719182442.GA5796@duynguyen.home> <CABPp-BEo1Ar17uwX=ib8iVYosdwhTXhdMWvi7kgqDb3iPQoj5Q@mail.gmail.com>
 <20180720052829.GA3852@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 10:21:32 -0700
Message-ID: <CABPp-BE3FWoVgogDJuvCrxAaEyZ-XMC0RprOuRrqei28pyhGLA@mail.gmail.com>
Subject: Re: 2.18.0 Regression: packing performance and effectiveness
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 10:28 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 19, 2018 at 04:11:01PM -0700, Elijah Newren wrote:
>
>> Looking at the output from Peff's instrumentation elsewhere in this
>> thread, I see a lot of lines like
>>    mismatched get: 32889efd307c7be376da9e3d45a78305f14ba73a =3D (, 28)
>> Does that mean it was reading the array when it wasn't ready?
>
> Yes, it looks like we saw a "get" without a "set". Though this could
> also be due to threading. The tracing isn't atomic with respect to the
> actual get/set operation, so it's possible that the ordering of the
> trace output does not match the ordering of the actual operations.
>
>> However, it's interesting to also look at the effect on packing
>> linux.git (on the same beefy hardware):
>>
>> Version  Pack (MB)  MaxRSS(kB)  Time (s)
>> -------  ---------  ----------  --------
>>  2.17.0     1279     11382932      632.24
>>  2.18.0     1279     10817568      621.97
>>  fiv-v4     1279     11484168     1193.67
>>
>> While the pack size is nice and small, the original memory savings
>> added in 2.18.0 are gone and the performance is much worse.  :-(
>
> Interesting. I can't reproduce here. The fix-v4 case is only slightly
> slower than 2.18.0. Can you double check that your compiler flags, etc,
> were the same? Many times I've accidentally compared -O0 to -O0. :)

Same build flags each time, but as Duy points out, this was on a
40-processor box.

> You might also try the patch below (on top of fix-v4), which moves the
> locking to its own dedicated mutex. That should reduce lock contention,
> and it fixes the remaining realloc where I think we're still racy. On my
> repack of linux.git, it dropped the runtime from 6m3s to 5m41s, almost
> entirely in system CPU.

I had to add an include of pthread.h to get it to compile, but
otherwise I'm trying it out.  Re-running a few times with each version
to see how big the run-to-run variance is.

> I didn't measure my max rss. However, I'd caution slightly against
> drawing too much conclusion from it, for two reasons:
>
>   1. RSS includes mmap'd packfiles, which is subject to whatever pages
>      the OS feels like keeping in RAM. So using more heap can sometimes
>      go unnoticed in that count, since you're just trading heap pages
>      for mmap pages. Although that implies some memory pressure, and it
>      sounds like your machine is sufficiently beefy to avoid that.
>
>   2. Peak heap is going to depend on the threading. You have one thread
>      per CPU working on a window of objects, each of which will be in
>      memory at once. So I'd expect a fair bit of fluctuation in the peak
>      just depending on how the threads line up with each other (some of
>      it random, and some of it maybe impacted by what the code does, but
>      in a way that just happens to fall out for this specific workload).
>
> Which isn't to say measuring it is useless. The trends may override the
> noise from those two things. I've just run into problems in the past
> trying to get consistent measurements.

Good to know.  I was actually measuring it due to commit 3b13a5f26387
("pack-objects: reorder members to shrink struct object_entry",
2018-04-14) referencing
https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/ as
being the measurement methodology to back up the results of the
original purpose of the change.  (I did miss out on the "run 3 times,
report the lowest value" that =C3=86var did, though.)  I figured that as
long as we were further tweaking things along the lines of that patch
series, it made sense to try to do similar measurements to see if we
were at least improving things relative to 2.17.0.

> Here's the lock patch.
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ba14a1bfbc..b76ce04cb9 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1926,12 +1926,12 @@ static unsigned long oe_delta_size(struct packing=
_data *pack,
>  {
>         unsigned long size;
>
> -       read_lock();     /* to protect access to pack->delta_size[] */
> +       pack_delta_lock(pack);
>         if (pack->delta_size)
>                 size =3D pack->delta_size[e - pack->objects];
>         else
>                 size =3D e->delta_size_;
> -       read_unlock();
> +       pack_delta_unlock(pack);
>         return size;
>  }
>
> @@ -1939,10 +1939,10 @@ static void oe_set_delta_size(struct packing_data=
 *pack,
>                               struct object_entry *e,
>                               unsigned long size)
>  {
> -       read_lock();     /* to protect access to pack->delta_size[] */
> +       pack_delta_lock(pack);
>         if (!pack->delta_size && size < pack->oe_delta_size_limit) {
>                 e->delta_size_ =3D size;
> -               read_unlock();
> +               pack_delta_unlock(pack);
>                 return;
>         }
>         /*
> @@ -1963,7 +1963,7 @@ static void oe_set_delta_size(struct packing_data *=
pack,
>                         pack->delta_size[i] =3D pack->objects[i].delta_si=
ze_;
>         }
>         pack->delta_size[e - pack->objects] =3D size;
> -       read_unlock();
> +       pack_delta_unlock(pack);
>  }
>
>  static int try_delta(struct unpacked *trg, struct unpacked *src,
> diff --git a/pack-objects.c b/pack-objects.c
> index e3c32bbfc2..8d9c2dfb82 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -148,6 +148,10 @@ void prepare_packing_data(struct packing_data *pdata=
)
>                                              1U << OE_SIZE_BITS);
>         pdata->oe_delta_size_limit =3D git_env_ulong("GIT_TEST_OE_DELTA_S=
IZE",
>                                                    1U << OE_DELTA_SIZE_BI=
TS);
> +
> +#ifndef NO_PTHREADS
> +       pthread_mutex_init(&pdata->delta_lock, NULL);
> +#endif
>  }
>
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
> @@ -162,8 +166,10 @@ struct object_entry *packlist_alloc(struct packing_d=
ata *pdata,
>
>                 if (!pdata->in_pack_by_idx)
>                         REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
> +               pack_delta_lock(pdata);
>                 if (pdata->delta_size)
>                         REALLOC_ARRAY(pdata->delta_size, pdata->nr_alloc)=
;
> +               pack_delta_unlock(pdata);
>         }
>
>         new_entry =3D pdata->objects + pdata->nr_objects++;
> diff --git a/pack-objects.h b/pack-objects.h
> index 730990c5d2..29b6006949 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -130,6 +130,9 @@ struct packing_data {
>
>         unsigned int *in_pack_pos;
>         uint32_t *delta_size;
> +#ifndef NO_PTHREADS
> +       pthread_mutex_t delta_lock;
> +#endif
>
>         /*
>          * Only one of these can be non-NULL and they have different
> @@ -144,6 +147,14 @@ struct packing_data {
>         uintmax_t oe_delta_size_limit;
>  };
>
> +#ifndef NO_PTHREADS
> +#define pack_delta_lock(pdata) pthread_mutex_lock(&pdata->delta_lock)
> +#define pack_delta_unlock(pdata) pthread_mutex_unlock(&pdata->delta_lock=
)
> +#else
> +#define pack_delta_lock(pdata)
> +#define pack_delta_unlock(pdata)
> +#endif
> +
>  void prepare_packing_data(struct packing_data *pdata);
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
>                                     const unsigned char *sha1,
