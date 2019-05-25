Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3831F462
	for <e@80x24.org>; Sat, 25 May 2019 10:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfEYKoW (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 06:44:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35259 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfEYKoW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 06:44:22 -0400
Received: by mail-io1-f67.google.com with SMTP id p2so9753433iol.2
        for <git@vger.kernel.org>; Sat, 25 May 2019 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynnlHOzj3fMLezkHFs0hQWPbdfOaVjG8khQvBfIXvYs=;
        b=O1y736dQSBBx7nSZx4Srg0PTX1xlz92bzzOKMDr9l9TfYmSrPxNqbL6zw5WCm9RBbs
         8acJL/X/bUs4FUqLZY9VWeKrqM/RqGV97Bk/OfET3EbBORwrmYbyXizP3/4CoyOYWpOY
         i1zpJgGT8AfzBwYoHjABQdexvSdXsfa3Pz2lQFwUFvwNUvgNMPZoEbi5/3I+pLU2VS1a
         hWE1kWDYUw7birb3Z2tEcZPWA6t4/YB+jExpif9I1/FhU09zMRn0za/vykbD3JjFfZ/C
         HSy9KPmT7ihl4bMH1XkwGMgHUvOUOKsjITkesaTbTkJIk3Ouou5ZgQJwY0XRpvRynGnV
         e5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynnlHOzj3fMLezkHFs0hQWPbdfOaVjG8khQvBfIXvYs=;
        b=l6va6W6TfwRjVfsFrdWB8v3aBpRSUrnJTU2dA0hiwkLuoa6jdWGFFptSxoGOiHVug9
         PBXk87PvhYHiS9W+F/Eayhv9R1H568p8eWuUatOEQgvfFEfLjKxl6Tq4DkZ/EYkHDFVZ
         VWXvjFplVn3YonEGsritUFiyzviPCOE9dU17Xw/8KZjB1YsATRGkd81/F0iTunZR8edE
         hwAMNloRvQo5LOo7+4lBvjwDC5d/kLUrjSDrDBeP/ID2XrR33IIOfd8VofYTYox6ekfj
         D45UZzI59So+lhUxaChvwAo6fWzIrvvkfp/7iW7gMgLQx6ifHAR9M1cBnS+8rzdLhzeP
         1fHA==
X-Gm-Message-State: APjAAAUKU3vYFDK/c8TF1B7i6QH0773ahrKgTDXgKpKd1KBf/+MNTSXX
        lk6L2RLacKrYK5VAr/S48eeY2LaC8MOylj4LMYM=
X-Google-Smtp-Source: APXvYqzYMyNFpsT5dLvYJQeW/UfvgymvwT5G1HNQDYB8z1hQ/7mASV6H35lVTCzhuARC7RvzOBCuP31zPC7iwAXIoUQ=
X-Received: by 2002:a6b:b907:: with SMTP id j7mr39428666iof.17.1558781061871;
 Sat, 25 May 2019 03:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.222.git.gitgitgadget@gmail.com> <20190521212744.GC14807@sigill.intra.peff.net>
 <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com> <20190523055108.GA20871@sigill.intra.peff.net>
In-Reply-To: <20190523055108.GA20871@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 May 2019 17:43:55 +0700
Message-ID: <CACsJy8D7w4sC_tchx-Q80PCiu+2hYfkZo22_Vb3vgJ+xvgUAAA@mail.gmail.com>
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 12:51 PM Jeff King <peff@peff.net> wrote:
> For fun, here's a constant-time zero-allocation implementation that I
> came up with. It passes t0211 with NO_PTHREADS, but I didn't test it
> beyond that.
>
> diff --git a/thread-utils.h b/thread-utils.h
> index 4961487ed9..f466215742 100644
> --- a/thread-utils.h
> +++ b/thread-utils.h
> @@ -18,7 +18,7 @@
>  #define pthread_t int
>  #define pthread_mutex_t int
>  #define pthread_cond_t int
> -#define pthread_key_t int
> +#define pthread_key_t git_pthread_key_t
>
>  #define pthread_mutex_init(mutex, attr) dummy_pthread_init(mutex)
>  #define pthread_mutex_lock(mutex)
> @@ -31,16 +31,49 @@
>  #define pthread_cond_broadcast(cond)
>  #define pthread_cond_destroy(cond)
>
> -#define pthread_key_create(key, attr) dummy_pthread_init(key)
> -#define pthread_key_delete(key)
> +#define pthread_key_create(key, destroy) git_pthread_key_create(key, destroy)
> +#define pthread_key_delete(key) git_pthread_key_delete(key)
>
>  #define pthread_create(thread, attr, fn, data) \
>         dummy_pthread_create(thread, attr, fn, data)
>  #define pthread_join(thread, retval) \
>         dummy_pthread_join(thread, retval)
>
> -#define pthread_setspecific(key, data)
> -#define pthread_getspecific(key) NULL
> +#define pthread_setspecific(key, data) git_pthread_setspecific(key, data)
> +#define pthread_getspecific(key) git_pthread_getspecific(key)
> +
> +typedef struct {
> +       void *data;
> +       /* extra indirection because setspecific is passed key by value */
> +       void **vdata;

Ha! I was thinking a separate key->value mapping which is complicated
in C. But this works pretty well for a single thread, and it even
supports multiple keys.

> +} git_pthread_key_t;
> +
> +static inline int git_pthread_key_create(git_pthread_key_t *key,
> +                                        void (*destroy)(void *))
> +{
> +       key->data = NULL;
> +       key->vdata = &key->data;
> +       /* We don't use this; alternatively we could all via atexit(). */
> +       if (destroy)
> +               BUG("NO_PTHREADS does not support pthread key destructors");
> +       return 0;
> +}
> +
> +static inline int git_pthread_key_delete(git_pthread_key_t key)
> +{
> +       /* noop */
> +       return 0;
> +}
> +
> +static inline void git_pthread_setspecific(git_pthread_key_t key, void *data)
> +{
> +       *(key.vdata) = data;
> +}
> +
> +static inline void *git_pthread_getspecific(git_pthread_key_t key)
> +{
> +       return key.data;
> +}
>
>  int dummy_pthread_create(pthread_t *pthread, const void *attr,
>                          void *(*fn)(void *), void *data);
-- 
Duy
