Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0065C200B9
	for <e@80x24.org>; Tue,  8 May 2018 15:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932981AbeEHPBI (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 11:01:08 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:38228 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932828AbeEHPBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 11:01:05 -0400
Received: by mail-oi0-f49.google.com with SMTP id k17-v6so28608361oih.5
        for <git@vger.kernel.org>; Tue, 08 May 2018 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I0+3NAvZ0XgSFO0qqBT7Lmus+IlnYZK/MHe3dsrEiew=;
        b=dI1iE9CrYUYPftCkqtaIxDTzThoVoYLdwgjycK/yaruItTTWXXOXdoEVEXTZGiSOom
         ZLX86/tDKzyWINgrxT7RzSma61j+23SJkp/Oio9inbVJxvyc6T44SPrSIzRT/+FBCNTZ
         y4J72xQsMO3uth92Zx3/FEZ+F+91+jgbKpxRPmFsLEwsS6uhnZBI5tlswYb91rkoxfEB
         B34+rpgJlAfaec+q/bSL7eVl/b+YKO0cmTdhn/xRa2+zZgpIJN2tQKWZW3QbHTG3hYoX
         sQl+Psa/8fXCC0LCVD4FOk3grXqk7izcpIazMW5lnbwD6s2rJ0j7XevJZkBN0op13vwF
         Rt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I0+3NAvZ0XgSFO0qqBT7Lmus+IlnYZK/MHe3dsrEiew=;
        b=jj10obVIr+SEIW6kpsfA6LDSZUHtMu6nsT9C26mAZfhMaLJGYnizC6VBF9VcuQnTrX
         Xkl11HTu513bqFKFnMEWQVnK/3OjFcyJk1A8TP3Zrh+pPLnxVctESOye6ec4i9ybxH3M
         nlOazJmB7rszH10o4VyDGHePGt8U4REBl2sGbuPL6xhEPsw1t1XwB0TRrEsTjcGbhscB
         4dCMlW3/opJvq3F4wgMjyaqvysHNrCCcIch9lyLJn4SwAzuI2gJSZunjevqD03HR1pjt
         4C5iMbP85fDdErU3zHvOxKyLL9vYSBfybL/asbD2kqUoUjxwuRt7q/icEttKtWaIZE4H
         KEfw==
X-Gm-Message-State: ALQs6tAKKU5m1Zq99Er5V00oBOrY+YDRalQFadKYH8OEc4sFjR7MZjCZ
        IWW8ADR7J0EEcqnpMkfi1sHgU6DS6ksPFBarp8k=
X-Google-Smtp-Source: AB8JxZp9W2SsQAprTHAwP95vI8VHYUEfyar7PHnc9CpnQIIdbrHsUrIcYul9cnd5xLCIl7fUgCfS+QZWKcyj/kajLEM=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr27279410oib.32.1525791664513;
 Tue, 08 May 2018 08:01:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 8 May 2018 08:00:33 -0700 (PDT)
In-Reply-To: <20180507225916.155236-14-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180507225916.155236-1-sbeller@google.com>
 <20180507225916.155236-14-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 May 2018 17:00:33 +0200
Message-ID: <CACsJy8D-e-bff3S+LQAMfwB-w8OpkjrfFrV9O5S3ku+M5aAjQA@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 12:59 AM, Stefan Beller <sbeller@google.com> wrote:
> @@ -501,9 +509,31 @@ void raw_object_store_clear(struct raw_object_store *o)
>  void parsed_object_pool_clear(struct parsed_object_pool *o)
>  {
>         /*
> -        * TOOD free objects in o->obj_hash.
> -        *
>          * As objects are allocated in slabs (see alloc.c), we do
>          * not need to free each object, but each slab instead.
> +        *
> +        * Before doing so, we need to free any additional memory
> +        * the objects may hold.
>          */
> +       unsigned i;
> +
> +       for (i = 0; i < o->obj_hash_size; i++) {
> +               struct object *obj = o->obj_hash[i];
> +
> +               if (!obj)
> +                       continue;
> +
> +               if (obj->type == OBJ_TREE) {
> +                       free(((struct tree*)obj)->buffer);

It would be nicer to keep this in separate functions, e.g.
release_tree_node() and release_commit_node() to go with
alloc_xxx_node().

> +               } else if (obj->type == OBJ_COMMIT) {
> +                       free_commit_list(((struct commit*)obj)->parents);
> +                       free(&((struct commit*)obj)->util);
> +               }
> +       }

I still don't see who frees obj_hash[] (or at least clears it if not
freed). If I'm going to use this to free memory in pack-objects then
I'd really prefer obj_hash[] freed because it's a big _big_ array.

Just to be clear, what I mean is

FREE_AND_NULL(o->obj_hash);
o->obj_hash_size = 0;

> +
> +       clear_alloc_state(o->blob_state);
> +       clear_alloc_state(o->tree_state);
> +       clear_alloc_state(o->commit_state);
> +       clear_alloc_state(o->tag_state);
> +       clear_alloc_state(o->object_state);
>  }
-- 
Duy
