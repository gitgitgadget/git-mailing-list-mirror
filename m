Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A6A1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 06:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756354AbeDXGVO (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 02:21:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36233 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756058AbeDXGVN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 02:21:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18-v6so19988106wrg.3
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 23:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1PuBOffSPXfadXxIu+gV4c+u5G43SUoXFZ1JXg9XR4=;
        b=Cf8mVQfpCx/kWn/YITsWnLfif8wPKAugu/DQi/+0jzbd8zkT+RYVborBYV0VkUnIu7
         nFNjPYCvCyfPS7gAbiZK3ckk/7JSz5sTpCR92ZD/fpEMkZNOb9+OKAtdZwqioL+6N7FS
         NINhHhMmpAoX3H1m25/o2iug3mEW3P/NcwOgYuDXnCZFV+kMqlY0njAvgGVVhTB5tHX1
         JojepBj7+xze2ear5Uefnq6BciwhpxVmmWmpKMQFJkIFs8vslWvgjBlXv3W4sXk6z24A
         NUgtklxVKCRcbzFmpgqrh7Xwl/VbvyIlt1EnqIyBp0wtNB/oy0scohkCsdd/PKWNOHID
         yELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1PuBOffSPXfadXxIu+gV4c+u5G43SUoXFZ1JXg9XR4=;
        b=csc8vK37EezJOP9cLeSMGbOCB3rtYeAY4utJAH23GMTzowNoeVGnFEOYxGMhDAz1oa
         96kYUmFQ928JVdkUhWiGtWgLRzHqzZS0mrxTkw8stEYKPKzHq7RBwZrJ0hA5U40b/7Vy
         qG2dnavGeti9I2APoblrJQzcbh8oU4o3n8aBzjZnBOEE+vMR1eT55kJLuwRRNyOQJ1nc
         mBts9QAG7DeR6u7wC/byROiQZcFzhe3BkSvtNZaSUIpwxw5xKIQgNUSE80sBLhfNUhNd
         aBN6s69+A66b3kjpHqYORGeN1OvkmH5OaoDasvwxhVv+MEYkHrBqyATSCvchjnAQsfxq
         TiOg==
X-Gm-Message-State: ALQs6tBFJ4VdJLVG1oWOncy2D9l3Lzb+XwCqiNOZN4TT+OaTLescdV4u
        s4GzAbMOc3059f8EVXi2VP4mjWOsoE6MO4TAMsYUBA==
X-Google-Smtp-Source: AIpwx4+M/u7KaR8h3ARdJkmQQ+X55Fl5ATqy7gAD+Y/HyxV84edn1qVwg9mAOqSg22nhGfWi8qgqsU2dd7C6TWzxPYo=
X-Received: by 10.80.192.145 with SMTP id k17mr31937380edf.303.1524550872016;
 Mon, 23 Apr 2018 23:21:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 23 Apr 2018 23:20:51 -0700 (PDT)
In-Reply-To: <f140d2795b9dce8b805cd2ebaf076742978ab8ae.1524545557.git.martin.agren@gmail.com>
References: <ec58f482-ffde-1959-ff4a-9b128905ccb0@talktalk.net>
 <cover.1524545557.git.martin.agren@gmail.com> <f140d2795b9dce8b805cd2ebaf076742978ab8ae.1524545557.git.martin.agren@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 23 Apr 2018 23:20:51 -0700
Message-ID: <CA+P7+xqP8b1i4-C242de2_P9dFsZ03pcRGo45scyfK2ohd-ykw@mail.gmail.com>
Subject: Re: [PATCH 1/2] merge: setup `opts` later in `checkout_fast_forward()`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 10:13 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> After we initialize the various fields in `opts` but before we actually
> use them, we might return early. Move the initialization further down,
> to immediately before we use `opts`.
>
> This limits the scope of `opts` and will help a subsequent commit fix a
> memory leak without having to worry about those early returns.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  merge.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/merge.c b/merge.c
> index f06a4773d4..f123658e58 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -94,8 +94,24 @@ int checkout_fast_forward(const struct object_id *head=
,
>                 return -1;
>
>         memset(&trees, 0, sizeof(trees));
> -       memset(&opts, 0, sizeof(opts));
>         memset(&t, 0, sizeof(t));
> +
> +       trees[nr_trees] =3D parse_tree_indirect(head);
> +       if (!trees[nr_trees++]) {
> +               rollback_lock_file(&lock_file);
> +               return -1;
> +       }
> +       trees[nr_trees] =3D parse_tree_indirect(remote);
> +       if (!trees[nr_trees++]) {
> +               rollback_lock_file(&lock_file);
> +               return -1;
> +       }
> +       for (i =3D 0; i < nr_trees; i++) {
> +               parse_tree(trees[i]);
> +               init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
> +       }
> +
> +       memset(&opts, 0, sizeof(opts));
>         if (overwrite_ignore) {
>                 memset(&dir, 0, sizeof(dir));

I'm guessing the diff algorithm simply found that this was a more
compact representation of the change? It's a bit confusing when your
description indicates you "moved" some code down, but it looks like
you moved code up.

Thanks,
Jake

>                 dir.flags |=3D DIR_SHOW_IGNORED;
> @@ -112,20 +128,6 @@ int checkout_fast_forward(const struct object_id *he=
ad,
>         opts.fn =3D twoway_merge;
>         setup_unpack_trees_porcelain(&opts, "merge");
>
> -       trees[nr_trees] =3D parse_tree_indirect(head);
> -       if (!trees[nr_trees++]) {
> -               rollback_lock_file(&lock_file);
> -               return -1;
> -       }
> -       trees[nr_trees] =3D parse_tree_indirect(remote);
> -       if (!trees[nr_trees++]) {
> -               rollback_lock_file(&lock_file);
> -               return -1;
> -       }
> -       for (i =3D 0; i < nr_trees; i++) {
> -               parse_tree(trees[i]);
> -               init_tree_desc(t+i, trees[i]->buffer, trees[i]->size);
> -       }
>         if (unpack_trees(nr_trees, t, &opts)) {
>                 rollback_lock_file(&lock_file);
>                 return -1;
> --
> 2.17.0
>
