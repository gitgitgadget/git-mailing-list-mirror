Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A2A220248
	for <e@80x24.org>; Wed, 10 Apr 2019 05:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfDJFJS (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 01:09:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38623 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfDJFJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 01:09:18 -0400
Received: by mail-io1-f68.google.com with SMTP id v4so992748ioj.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXKgP6ylp1uOlsOWxmnGjRne3Pns4//xkBHZ6W6uVfw=;
        b=acs3S8obTOOnL8ryJ3zdKEZ0zuCjo9E1ktJDn9XhhOrEHqc7JV/NS0cBwEfyuAypvG
         /fRqOTjdye8HH/yEJqQ0w2Guqow7w0VFxkHI5e4nHNYIeCo3e0T6mTvTbg0nyRChg2xD
         o8EYgA5vhrx2fCLNao3iFZqZSgLIgOZ0/Vc8FNhEaU4UAJUe8W9g3K+EmPRnOFVaNhFl
         qfCRcyZwnhclKxX+OUxvoRC2FZyFy3F0XMJ0PZLM18UmHeQxIG3DvcINKmDQxHYw8OYU
         l2GMvSuPkisnpE9A2Y1Vg3BUoT1oLWTfyVQqB9eowX/a/b/KaHKn6US7Kk6Xa+6fCrHi
         bR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXKgP6ylp1uOlsOWxmnGjRne3Pns4//xkBHZ6W6uVfw=;
        b=gb5DWzSFaxOLkmAzBN37lDT+dFBwMZToZC29A+K5YfjLeUSCnEA1wbJf0aUXjaxV5e
         DCpbEu3vw4UfoW5Odm1ZdpJkV4DoThLv3JHsf3mllhA11ZWsXfd5u9SfZUqIPfvuEuPS
         AEPi6dPtIFEOpDmYao8Vfqca8ZKl9fQgn2tI7HXNVCCT6MzoGIwBNjiM8wEyGuBOCFLb
         cH1cfBzuZWlLNhIYZGHXpOb1+EOdF2mKuIdlZvNhDqTLGk/5orK/A8pxRaSpBoXKPXnp
         dZ9pQXY7N8Kx8hfPQ98BZBNJ3Rh3R4gUJNodRK9eEwdrx5AIzMTVXdb560zF+aL84Rti
         yalQ==
X-Gm-Message-State: APjAAAUpGUMwjl+JqfBb9SVVwsH5ZgZsdADwoULsIlSR3QPmhI2eINfo
        EYIJtYXMf3atRfWlhDIJ2rQyoHet0RIhjctPkRI=
X-Google-Smtp-Source: APXvYqy9og9hgl2dHz5SYUPNovtncS5zaZAKKTWRRHgpA7Jp9R83+LpVbycbOqmMh97u8QUOHiUqlL32+8UnkwE6lmM=
X-Received: by 2002:a5e:9805:: with SMTP id s5mr28131406ioj.149.1554872957407;
 Tue, 09 Apr 2019 22:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190409214420.90898-1-jonathantanmy@google.com>
In-Reply-To: <20190409214420.90898-1-jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 10 Apr 2019 12:08:51 +0700
Message-ID: <CACsJy8CV-NxoapFcedNpCiahS3jrsWL00v2JfZkGzsrPNDmiaA@mail.gmail.com>
Subject: Re: [RFC PATCH] pack-objects: write objects packed to trace2
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 4:45 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is useful when investigating performance of pushes, and other times
> when no progress information is written (because the pack is written to
> stdout).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> We're trying to improve push performance, and it would be nice to be
> able to observe the number of objects sent over each push, both to
> correlate it with time taken (which is already traced) and to notice
> situations when significantly more objects are being sent than needed.
>
> Sending this as an RFC because this patch works but is somewhat ad-hoc -
> perhaps someone else has a more comprehensive solution.
> ---
>  builtin/pack-objects.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a154fc29f6..ac464d7d07 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -964,6 +964,7 @@ static void write_pack_file(void)
>         if (written != nr_result)
>                 die(_("wrote %"PRIu32" objects while expecting %"PRIu32),
>                     written, nr_result);
> +       trace2_printf("packed %d objects", nr_result);

The die() line right above uses %PRIu32 instead of %d

>  }
>
>  static int no_try_delta(const char *path)
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Duy
