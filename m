Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0AD21847
	for <e@80x24.org>; Wed,  2 May 2018 17:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750993AbeEBRor (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 13:44:47 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:39635 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBRoq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 13:44:46 -0400
Received: by mail-ot0-f169.google.com with SMTP id l12-v6so17585028oth.6
        for <git@vger.kernel.org>; Wed, 02 May 2018 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PNL4b1CdOBYgZJ6/HtP7zNnmDnVo2QLnOoEQEqMPg1Y=;
        b=WxcZQBMt0mdgKJAzgeRMd5uI/y0aloitje+X/YCe4EnwbwD7bGza96DYio3rUQ/PoB
         hL1O+SDZshiKK/6J4GMcfj56MKCvJdKBh48jvrFHQV4gfoABPas6s/KRkRjCEXAWwkcT
         TMOlwSgPNoZwg5WgpXMFXlmVBsprsqQv+L7QrZUCuclS9hR8IVb/EKFzuaihcfLVG/bW
         Kb2XTPCY7xHnOFK+IQ+/40YaTiZ4D+IZfIHWX1rxEMHqVs299rFVwGX5TRFYCsk/gqTI
         hbvTs6XgFgPQpdB5yn9+AVRPmrwk5qi1PpWYBkHx0DhCWLzw1atL1Lsh930rzB4VPIJ7
         dgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PNL4b1CdOBYgZJ6/HtP7zNnmDnVo2QLnOoEQEqMPg1Y=;
        b=Ec861imHZ+VuSr93FD8V1jmuqC8M/EH/4ygFLo9ggiY+LTNKhzwLITJc+munOwc6g4
         CWEej2bAeVcghWrFz/QGJ4t7CYck6rwDhUnqEPoAWbUs+BI8neMYGLqeB4K7jKvlJc8s
         5AiUud3p3uh0EEQ6hs8px1lPSwNIHbuJJS917hVpQjk7g3dRzn5Udeia7eqfWNoZv+Ic
         QuMCJFCbcHQkTfpM7mSIhZ5aiKCAOuouwK4CyAYK933HB8zGqpQQMviUzohGEKee7Kg7
         onuvHM0JkK7KWnKqxXZqzb5cn3RcyEhotGCWW7n4Z89oN4E9ZHC4uxVhHe3Hlr3ygWed
         AC8Q==
X-Gm-Message-State: ALQs6tCKqZs+5OzmPx//NJjY/I3XCxRNt469j/Wh7a6F3US4UreAcolE
        PBn4vGDIUOY8uzmQ8FKYxjBvR9F1MdBfeawPuCc=
X-Google-Smtp-Source: AB8JxZpF9R5bdZDGAZyxsJ/OvZd5rb+Vk1b9AGPIa0pRC2W3bunOMpW1BvmahyZqAsHg1kg5m+tT9S2LzwKLIwWmvXo=
X-Received: by 2002:a9d:49ad:: with SMTP id g45-v6mr1727283otf.65.1525283086144;
 Wed, 02 May 2018 10:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 10:44:15 -0700 (PDT)
In-Reply-To: <20180501213403.14643-14-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-14-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 19:44:15 +0200
Message-ID: <CACsJy8B=i_0EKGRLxS5N5tfz8666hm_aTns949eb9DAW1--XWg@mail.gmail.com>
Subject: Re: [PATCH 13/13] alloc: allow arbitrary repositories for alloc functions
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jamill@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 11:34 PM, Stefan Beller <sbeller@google.com> wrote:
>  #include "cache.h"
>  #include "object.h"
> @@ -30,8 +31,25 @@ struct alloc_state {
>         int count; /* total number of nodes allocated */
>         int nr;    /* number of nodes left in current allocation */
>         void *p;   /* first free node in current allocation */
> +
> +       /* bookkeeping of allocations */
> +       void **slabs;

Another way to manage this is linked list: you could reserve one
"object" in each slab to store the "next" (or "prev") pointer to
another slab, then you can just walk through all slabs and free. It's
a bit cheaper than reallocating slabs[], but I guess we reallocate so
few times that readability matters more (whichever way is chosen).

> +       int slab_nr, slab_alloc;
>  };
>
> +void *allocate_alloc_state(void)
> +{
> +       return xcalloc(1, sizeof(struct alloc_state));
> +}
> +
> +void clear_alloc_state(struct alloc_state *s)
> +{
> +       while (s->slab_nr > 0) {
> +               s->slab_nr--;
> +               free(s->slabs[s->slab_nr]);

I think you're leaking memory here. Commit and tree objects may have
more allocations in them (especially trees, but I think we have
commit_list in struct commit too). Those need to be freed as well.

> +       }
> +}
> +
>  static inline void *alloc_node(struct alloc_state *s, size_t node_size)
>  {
>         void *ret;
-- 
Duy
