Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5458200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeECQSs (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:18:48 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34462 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeECQSr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:18:47 -0400
Received: by mail-ot0-f194.google.com with SMTP id i5-v6so9602974otf.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uoL6C5yUgEu+hbr3sk6CeMJD2iu+yI/E+3AOAg9nP60=;
        b=rGEOTtHvVjx4jW69sZ+qgHw6P5hVQxXQwc6b0aCRcd/uBxzBeT25/4iZq4IFPvPHvR
         j36zhMWkHfK4K/kB0ItWNk4WPiAwhqL+ezY/5325RByiM0HFMCtbcGeP5TGhjvBG8v0Z
         6FGhHkUE7pqY+LOQ/VuJVgKP+Lb5nOrkQAenSuAWTleRE/VvEzpGB5kjq04aiRjlJdrC
         OC88LAP8cywvXEP20twzsl+0VdKCgXq83eYsTp8sH473M2MBXEo2HFWHpfHF75hJ2TaB
         7+NaGRsn12FeCDLPPE6MVmX75xrhQNn5U+LZWxdXk86UEDy+SDDdIfEjD/9+rZiB7Gh4
         2UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uoL6C5yUgEu+hbr3sk6CeMJD2iu+yI/E+3AOAg9nP60=;
        b=WSnIuOuoM1IPBgqmB/FBxqoYnbZcCAKuBblp88zPzUxqwoDfLYDIM42csfDsLqY6YX
         u91RKaRr34Cmw9ScP+Lb++OQ35SFUSEHDQHcAyCeqC9zx0qdntl3oqyDITM5Nev4XV4K
         YJ4FgbWekyCDz6z7sRXNLd6p0qjxXUtGqkhIJ4Omhl/SCtveUXDOTG1w7/td/CBZmIGj
         k02hthqFphm9n/yhx5CPMR7SN3kPqXx8HPkoS6uh3bNAT/xrtXH7EaCg90quOkEsZVOD
         x3pQOYu4Vq3c0+vBBd3dQ0SjuGzZbO7vh2kWN15Clql8lJ+hvHrLWmlIZ8RE1CvcXDoL
         sLZA==
X-Gm-Message-State: ALQs6tCnp1Oatvh3+TkCDRFXcBtaEINzNo7Wt/91B1g+mMYF8VyX5/Nq
        kRR3tc8YlYtAwWogp2ejjUYYR9kbvmBr4MLyDIA=
X-Google-Smtp-Source: AB8JxZq7jYM/+FNnMSJ0/vCK4z8mHUKAWLpbn3Xms61EUCfCrXW8G2RFpoCXy8aQCz3Ti4QvQYykLD3tZxd9tfCYxEw=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr18318634otb.356.1525364326735;
 Thu, 03 May 2018 09:18:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 09:18:16 -0700 (PDT)
In-Reply-To: <20180430153122.243976-4-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
 <20180430153122.243976-4-jamill@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 18:18:16 +0200
Message-ID: <CACsJy8DR4wNoucfL0++-k73EPnJL1YSsoB5prjG6YtDPzu9qRQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mem-pool: fill out functionality
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another I noticed in the jm/mem-pool series is this loop in mem_pool_alloc()

for (p = mem_pool->mp_block; p; p = p->next_block)
        if (p->end - p->next_free >= len)
                break;

You always go from the start (mp_block) but at some point those first
blocks are filled up and we don't really need to walk from the start
anymore. If we allow the mem-pool user to set a "minimum alloc" limit,
then we can determine if the remaining space in a block is not useful
for any future allocation, we can just skip it and start looking for
an available from a new pointer, avail_block or something.

I'm writing this with alloc.c in mind because we have a lot more
blocks to allocate there. Unlike read-cache, you can't really estimate
how many mp_blocks you're going to need. This linked list could become
long. And because alloc.c does fixed size allocation, we use up one
block after another and will never find free space in previous blocks.

On Mon, Apr 30, 2018 at 5:31 PM, Jameson Miller <jamill@microsoft.com> wrote:
> diff --git a/mem-pool.c b/mem-pool.c
> index 389d7af447..a495885c4b 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -5,6 +5,8 @@
>  #include "cache.h"
>  #include "mem-pool.h"
>
> +#define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);

#define BLOCK_GROWTH_SIZE (1024*1024 - sizeof(struct mp_block))

(wrapped in brackets and no trailing semicolon)

> +
>  static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t block_alloc)
>  {
>         struct mp_block *p;
> @@ -19,6 +21,60 @@ static struct mp_block *mem_pool_alloc_block(struct mem_pool *mem_pool, size_t b
>         return p;
>  }
>
> +static void *mem_pool_alloc_custom(struct mem_pool *mem_pool, size_t block_alloc)
> +{
> +       char *p;

An empty line between variable declaration and function body would be nice.

> +       ALLOC_GROW(mem_pool->custom, mem_pool->nr + 1, mem_pool->alloc);
> +       ALLOC_GROW(mem_pool->custom_end, mem_pool->nr_end + 1, mem_pool->alloc_end);
> +

If you put both custom and custom_end in a struct, then you can grow
just one array (of the new struct) and have fewer support variables
like nr_end and alloc_end

The only downside that I can see is the potential padding between
struct increasing memory consumption here. but since you don't care
about reallocation cost (i.e. large memory allocations should be
rare), it probably  does not matter either.

But wait, can we just reuse struct mp_block for this? You allocate a
new mp_block (for just one allocation) as usual, then you can can
maintain a linked list of custom alloc in "struct mp_block
*mp_custom_block" or something. This way we can walk both bulk and
custom allocation the same way.

> +       p = xmalloc(block_alloc);
> +       mem_pool->custom[mem_pool->nr++] = p;
> +       mem_pool->custom_end[mem_pool->nr_end++] = p + block_alloc;
> +
> +       mem_pool->pool_alloc += block_alloc;
> +
> +       return mem_pool->custom[mem_pool->nr];
> +}
> +
> +void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
> +{
> +       if (!(*mem_pool))

I think (!*mem_pool) should be enough, although you could avoid the
operator precedence headache by doing

if (*mem_pool)
        return;

> +       {
> +               *mem_pool = xmalloc(sizeof(struct mem_pool));

I think we tend to do *mem_pool = xmalloc(sizeof(**mem_pool));

> +               (*mem_pool)->pool_alloc = 0;

Eghh.. perhaps just declare

struct mem_pool *pool;

then allocate a new memory to this, initialize everything and only do

*mem_pool = pool;

at the end? It's much less of this (*mem_pool)->

> +               (*mem_pool)->mp_block = NULL;

Just memset() it once (or use xcallo) and only initialize
non-zero/null fields afterwards.

> +               (*mem_pool)->block_alloc = BLOCK_GROWTH_SIZE;
> +               (*mem_pool)->custom = NULL;
> +               (*mem_pool)->nr = 0;
> +               (*mem_pool)->alloc = 0;
> +               (*mem_pool)->custom_end = NULL;
> +               (*mem_pool)->nr_end = 0;
> +               (*mem_pool)->alloc_end = 0;
> +
> +               if (initial_size > 0)
> +                       mem_pool_alloc_block(*mem_pool, initial_size);
> +       }
> +}
> +
> +void mem_pool_discard(struct mem_pool *mem_pool)
> +{
> +       int i;
> +       struct mp_block *block, *block_to_free;
> +       for (block = mem_pool->mp_block; block;)
> +       {
> +               block_to_free = block;
> +               block = block->next_block;
> +               free(block_to_free);
> +       }
> +
> +       for (i = 0; i < mem_pool->nr; i++)
> +               free(mem_pool->custom[i]);
> +
> +       free(mem_pool->custom);
> +       free(mem_pool->custom_end);
> +       free(mem_pool);
> +}
> +
>  void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
>  {
>         struct mp_block *p;
> @@ -33,10 +89,8 @@ void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
>                         break;
>
>         if (!p) {
> -               if (len >= (mem_pool->block_alloc / 2)) {
> -                       mem_pool->pool_alloc += len;
> -                       return xmalloc(len);
> -               }
> +               if (len >= (mem_pool->block_alloc / 2))
> +                       return mem_pool_alloc_custom(mem_pool, len);
>
>                 p = mem_pool_alloc_block(mem_pool, mem_pool->block_alloc);
>         }
> @@ -53,3 +107,55 @@ void *mem_pool_calloc(struct mem_pool *mem_pool, size_t count, size_t size)
>         memset(r, 0, len);
>         return r;
>  }
> +
> +int mem_pool_contains(struct mem_pool *mem_pool, void *mem)
> +{
> +       int i;
> +       struct mp_block *p;
> +
> +       /* Check if memory is allocated in a block */
> +       for (p = mem_pool->mp_block; p; p = p->next_block)
> +               if ((mem >= ((void *)p->space)) &&
> +                   (mem < ((void *)p->end)))
> +                       return 1;
> +
> +       /* Check if memory is allocated in custom block */
> +       for (i = 0; i < mem_pool->nr; i++)
> +               if ((mem >= mem_pool->custom[i]) &&
> +                   (mem < mem_pool->custom_end[i]))
> +                       return 1;
> +
> +       return 0;
> +}
> +
> +void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
> +{
> +       int i;
> +       struct mp_block **tail = &dst->mp_block;
> +
> +       /* Find pointer of dst's last block (if any) */
> +       while (*tail)
> +               tail = &(*tail)->next_block;
> +
> +       /* Append the blocks from src to dst */
> +       *tail = src->mp_block;
> +
> +       /* Combine custom allocations */
> +       ALLOC_GROW(dst->custom, dst->nr + src->nr, dst->alloc);
> +       ALLOC_GROW(dst->custom_end, dst->nr_end + src->nr_end, dst->alloc_end);
> +
> +       for (i = 0; i < src->nr; i++) {
> +               dst->custom[dst->nr++] = src->custom[i];
> +               dst->custom_end[dst->nr_end++] = src->custom_end[i];
> +       }
> +
> +       dst->pool_alloc += src->pool_alloc;
> +       src->pool_alloc = 0;
> +       src->mp_block = NULL;
> +       src->custom = NULL;
> +       src->nr = 0;
> +       src->alloc = 0;
> +       src->custom_end = NULL;
> +       src->nr_end = 0;
> +       src->alloc_end = 0;
> +}
> diff --git a/mem-pool.h b/mem-pool.h
> index 829ad58ecf..34df4fa709 100644
> --- a/mem-pool.h
> +++ b/mem-pool.h
> @@ -19,8 +19,27 @@ struct mem_pool {
>
>         /* The total amount of memory allocated by the pool. */
>         size_t pool_alloc;
> +
> +       /*
> +        * Array of pointers to "custom size" memory allocations.
> +        * This is used for "large" memory allocations.
> +        * The *_end variables are used to track the range of memory
> +        * allocated.
> +        */
> +       void **custom, **custom_end;
> +       int nr, nr_end, alloc, alloc_end;
>  };
>
> +/*
> + * Initialize mem_pool specified initial.
> + */
> +void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size);
> +
> +/*
> + * Discard a memory pool and free all the memory it is responsible for.
> + */
> +void mem_pool_discard(struct mem_pool *mem_pool);
> +
>  /*
>   * Alloc memory from the mem_pool.
>   */
> @@ -31,4 +50,17 @@ void *mem_pool_alloc(struct mem_pool *pool, size_t len);
>   */
>  void *mem_pool_calloc(struct mem_pool *pool, size_t count, size_t size);
>
> +/*
> + * Move the memory associated with the 'src' pool to the 'dst' pool. The 'src'
> + * pool will be empty and not contain any memory. It still needs to be free'd
> + * with a call to `mem_pool_discard`.
> + */
> +void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
> +
> +/*
> + * Check if a memory pointed at by 'mem' is part of the range of
> + * memory managed by the specified mem_pool.
> + */
> +int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
> +
>  #endif
> --
> 2.14.3
>



-- 
Duy
