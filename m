Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06C0620248
	for <e@80x24.org>; Sat,  6 Apr 2019 04:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfDFESO (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 00:18:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39864 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfDFESN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 00:18:13 -0400
Received: by mail-it1-f193.google.com with SMTP id 139so12942885ita.4
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 21:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulsSWqm6lQxbu4fDli9APKkTm9YGY0FS57TdW6QWjl0=;
        b=R7zihBCjSLaIqvZwXCpqe5KdNQI3T3WZxRUQTkdyT+85t5Id+Ls8HmsiZs/AP1LMD0
         ffp2prX9OXEzawOQ9teXCQ8JF0iXIEyykILuLbdRatpfsHF2NtLzi+Zm9CQBuiRwVL/t
         bjzfxBTeLVFAyMHNnhJxL6vRD23arh8AiLDmxaSO0E2SY31pFpvGEqbJR9rpWLIhlOAA
         stTCtsanDoCbEOVHCUc7yZTJ/tc6EhSQ++ELdHMExlvHBrhQ37mKjtGUveBKg6uMd9Yp
         7dWl+SPEpieRIMonKmejYgH08GEAPKdqYlx30MOfht74Zb7SHSOKuvwwLHrUXh/QOMkx
         /EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulsSWqm6lQxbu4fDli9APKkTm9YGY0FS57TdW6QWjl0=;
        b=RguYk9ylf+wUF+xw2c/Aoe8OpQyblmLFAiPqxSMe2SV9jov3fXrxIP0SFAaoS8oQ0Z
         CEDO4yLeLVpuH/fWNtiE3+hYPft+9jL4Jlhd1Xvq7zbqgxIxgduQ5+xcfd8TeDKIS742
         8GCvc6Tl+BMWAV/9IzB+KZC2OdEQv5wFyPqHIyay5ThkL8UjLNngfuBgg8KzzR0NcndJ
         cG8Tz+yanW0RgA5+gCMnY0kyUzt2Vr82zHprN11mKdBBtzjChqpME0DyDqWCW3IDM7DW
         iwh/RT70JwRop3UWKsVueGDRpInvQX+gegtsogywOQ7znWp3eBJxzz6WZ2mgOv8u5WR6
         VIvw==
X-Gm-Message-State: APjAAAXt0SpSA4hcy2zKz3xwmp0PSMhu5Y4YlipCSfu5umjeQaQCp9zr
        4sEA7pzlJkZLQuy/9Y1DEqPuIqC7RD5yPgXvukI=
X-Google-Smtp-Source: APXvYqy2GRKR9xrlWUfpmWpQPAluj5BWkd9UPxHmFJMQzMGgeocsUrrgc9sDqWZLb3p2cHhcm7AvFIFktCzxYwWksUs=
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr4658231ith.72.1554524293022;
 Fri, 05 Apr 2019 21:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
 <20190405170934.20441-1-jonathantanmy@google.com>
In-Reply-To: <20190405170934.20441-1-jonathantanmy@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 6 Apr 2019 11:17:46 +0700
Message-ID: <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
Subject: Re: [PATCH] fixup! diff: batch fetching of missing blobs
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 6, 2019 at 12:09 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> This is a fixup on the tip of jt/batch-fetch-blobs-in-diff (571debe1d9).
>
> I don't know if Junio has already merged this branch to next (he marked
> this as "Will merge to 'next'" in the "What's Cooking" email, but when I
> fetched, it hasn't been merged yet). If he has, we can use this commit
> message:
>
> diff: propagate options->repo to add_if_missing
>
> Avoid a usage of the_repository by propagating the configured repository
> to add_if_missing(). Also, prefetch only if the repository being diffed
> is the_repository (because we do not support lazy fetching for any other
> repository anyway).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks, Duy, for noticing this.
> ---
>  diff.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 1eccefb4ef..811afbdfb1 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6367,18 +6367,19 @@ void diffcore_fix_diff_index(void)
>         QSORT(q->queue, q->nr, diffnamecmp);
>  }
>
> -static void add_if_missing(struct oid_array *to_fetch,
> +static void add_if_missing(struct oid_array *to_fetch, struct repository *r,

One last nit. "struct repository *r" is often the first argument. See
https://public-inbox.org/git/xmqqsh2p6l43.fsf@gitster-ct.c.googlers.com/

>                            const struct diff_filespec *filespec)
>  {
>         if (filespec && filespec->oid_valid &&
> -           oid_object_info_extended(the_repository, &filespec->oid, NULL,
> +           oid_object_info_extended(r, &filespec->oid, NULL,
>                                      OBJECT_INFO_FOR_PREFETCH))
>                 oid_array_append(to_fetch, &filespec->oid);
>  }
>
>  void diffcore_std(struct diff_options *options)
>  {
> -       if (repository_format_partial_clone) {
> +       if (options->repo == the_repository &&
> +           repository_format_partial_clone) {
>                 /*
>                  * Prefetch the diff pairs that are about to be flushed.
>                  */
> @@ -6388,8 +6389,8 @@ void diffcore_std(struct diff_options *options)
>
>                 for (i = 0; i < q->nr; i++) {
>                         struct diff_filepair *p = q->queue[i];
> -                       add_if_missing(&to_fetch, p->one);
> -                       add_if_missing(&to_fetch, p->two);
> +                       add_if_missing(&to_fetch, options->repo, p->one);
> +                       add_if_missing(&to_fetch, options->repo, p->two);
>                 }
>                 if (to_fetch.nr)
>                         /*
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Duy
