Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE581F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 14:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAEOeD (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 09:34:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45984 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAEOeD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 09:34:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so34654357ljd.12
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hGarkT3calWYR1kNMuopOIyFldC0VSJNZCvkfjPPeqI=;
        b=IEaxu49p5nWlMsp7h6fXbvwb/hsOJ9lJBRV8A4Z6hjW8QOTVc+9fQt04O2/kZorcks
         aglV3rzPIM991SAFD6StJ5Oee8pEC3jiT0wxyN0U8Kh9v0U+VzLtn3LSf5c/AnAVM4Ic
         slZ3auq16KatAcBpL6Z+TjswwoLDBUzPYpvkVyKrINIC3YsWzWYzAW6VZSg2jjwlAiKB
         jd72uv6N3Da2eAe9qtSTDdy+zrg8PpWqj9ajg7FMcO5+EZnOwYJwy5xmdG/4bOPoWP8L
         6VtNTYufGUUmOtrjZxGd3OZSdymjFVJ/w++5fOnj5GLk0dW5XzheDFD141cHXbGdAr1c
         EoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hGarkT3calWYR1kNMuopOIyFldC0VSJNZCvkfjPPeqI=;
        b=BHxICjeOURBF8e82CDvylpjH28VQc1xthKC3yB+WrYTtuvfW57b27+AY1VZ0SKgFVJ
         48UV5WgRB+WYGHUH+3iNv1b63vyDTxDxjdNQ1qHisC+ELS8Njhyf6/cs+3EDJb8LeKJg
         DLToZRz7qaMOS5HLZ+KiTkB/mbs2YvR9m7eT2TG1ZjaLUpoHK+/CATiMgsff9yuAyf/m
         iPP9MrHRk/6SrInx71m41+khZO4oy9MEYxw9LkM8HMtJSQYWpyXOJKD9j3Dg/IkLgrDe
         AhUlE2L9k5IZirOeCSNTJwpQIQlWv/J41cHeybthCs3zlGYG2EPnPkc0CP8YkEFMC1Fy
         UcUQ==
X-Gm-Message-State: AJcUukdPsUVb7jy/8MlhwJIv0j0oqlR2dOZnP7CiX0hAZduxzkwDEo93
        dCYbivCbz3830jeo8LeDcFuzoUm0gOLmLXmLNiA=
X-Google-Smtp-Source: ALg8bN6gu1Zp5JFIK9lPHxtyjW24/ZnJ7f9UuBxEjp+MAzGzgcQeAKpqMSFzR6hYI++PnsCPC211ECU0XmAr+HXHpfw=
X-Received: by 2002:a2e:9ad0:: with SMTP id p16-v6mr20257389ljj.102.1546698840837;
 Sat, 05 Jan 2019 06:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20190105055153.3256-1-pclouds@gmail.com> <20190105055153.3256-3-pclouds@gmail.com>
In-Reply-To: <20190105055153.3256-3-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 5 Jan 2019 15:33:49 +0100
Message-ID: <CAN0heSoRSgZVZ=NE6eof4dusEhfdz-eSiht06rGKb=GELvm86Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] repository.c: replace hold_locked_index() with repo_hold_locked_index()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 5 Jan 2019 at 07:07, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pcl=
ouds@gmail.com> wrote:
>
> hold_locked_index() assumes the index path at $GIT_DIR/index. This is
> not good for places that take an arbitrary index_state instead of
> the_index, which is basically everywhere except builtin/.
>
> Replace it with repo_hold_locked_index(). hold_locked_index() remains
> as a wrapper around repo_hold_locked_index() to reduce changes in builtin=
/

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 7c7f98c72c..ddb3230d21 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -8,6 +8,7 @@
>   * Clone a repository into a different directory that does not yet exist=
.
>   */
>
> +#define USE_THE_INDEX_COMPATIBILITY_MACROS

I think this should be in patch 10/10.

> diff --git a/cache.h b/cache.h
> index ca36b44ee0..634c9ce325 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -433,6 +433,7 @@ void validate_cache_entries(const struct index_state =
*istate);
>  #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at=
)
>  #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
>  #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&t=
he_index, (path), (sz))
> +#define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_r=
epository, (lock_file), (flags))
>  #endif
>
>  #define TYPE_BITS 3
> @@ -833,7 +834,6 @@ extern struct cache_entry *refresh_cache_entry(struct=
 index_state *, struct cach
>   */
>  extern void update_index_if_able(struct index_state *, struct lock_file =
*);
>
> -extern int hold_locked_index(struct lock_file *, int);

The reason this moves is it gets protected with "#ifndef
NO_THE_INDEX_COMPATIBILITY_MACROS". Ok.

> -int hold_locked_index(struct lock_file *lk, int lock_flags)
> -{
> -       return hold_lock_file_for_update(lk, get_index_file(), lock_flags=
);
> -}

> +int repo_hold_locked_index(struct repository *repo,
> +                          struct lock_file *lf,
> +                          int flags)
> +{
> +       return hold_lock_file_for_update(lf, repo->index_file, flags);
> +}

`get_index_file()` BUGs if `the_repository->index_file` is NULL, but
other than that, this looks like a faithful conversion. Do we want to
keep that check here?


Martin
