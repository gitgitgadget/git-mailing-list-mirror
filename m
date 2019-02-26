Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6082320248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBZMC1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:02:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40698 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfBZMC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:02:26 -0500
Received: by mail-it1-f194.google.com with SMTP id l139so1496475ita.5
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrQzpuir+Km+8uHaZrD5OKdPrKuFsurVMU8tcIvKdR4=;
        b=kQg69vM+McJ72XVjmBL24mA5YDHDOjIEUI4amh40SxWnG2K+zCbcLce+AK5v5SWEmG
         AbxVmbNxIPjzwPLOAVKmovmIH9TTLpjmYNSu3HMwlQ3Nn6OsZHCpYmojxPluzOBs+w/n
         BIsOg4naQbSO84e1D7kWszCK+7htZ56D4c+6Y0yqW2NY0dINHXn7tQHRFNOREYv33YsD
         2YmI7gy6E/KnFfUX6k+4A7bGuiq4mxwhiDMAVVFnHPG6pl4nee0BBlDzx5BpKFAhb0DN
         +CX3PVjhG/c2tS03S1M2sG/ZdjoQDEgwErOJeV25//fjeO7hG8ui8aFEOqcPnCmaTLp7
         Tklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrQzpuir+Km+8uHaZrD5OKdPrKuFsurVMU8tcIvKdR4=;
        b=odKb/jRPop+1fTUAPzaWvhdSr2aM5J5xWWSSfj9KlZSLiik1Dr1FHC4TtLq3o8r11w
         wXZu9pGQbn2RF1SePM2oSOpGEroAAk6b5G95i/OBbO0NT3BJeEmlJi6MtXGX4sIvWcf3
         J3FRNhCxM5yOp9s6J82OOKlSpfbP6lkiS6GisLbZjI53OXcNTaRF0y9gSK7yaHAqKV+F
         +b5QDTonZU7jQY9z4hSbw8gBgINMH4mF+8pmXAgdMH1qgebbgzDH6bKKCm+hwErC7yir
         ggMJ0svLc81dpIrT+Cgfpm+LR/4yxmJrcCI2mavPbuLTBnM0b16MGRHwXNIDlnxJBT85
         2fRw==
X-Gm-Message-State: APjAAAWbqnfTeKKwUGHisolI7KerdRwsB2J8Aan2J9L9XfGvOg+YvHuz
        cHnaTXvxumEyc4impMXL4ejafVIcXirCr67fGeg=
X-Google-Smtp-Source: AHgI3IZ4ZGGdDHuO/kdDDCl4XkR1YLz70S7lAzzu57ZkT5Jgz5+nQB0txLOPzbtNy2r1Iv4gi8lQDGKJtknNKkZblXU=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr2122905itf.123.1551182545290;
 Tue, 26 Feb 2019 04:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-2-matheus.bernardino@usp.br>
In-Reply-To: <20190226051804.10631-2-matheus.bernardino@usp.br>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Feb 2019 19:01:58 +0700
Message-ID: <CACsJy8DCpA3yvSjWiNDPtqMxSo9wNUobCkBHXOnJsG-+6C2Eew@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 1/5] dir-iterator: add flags parameter to dir_iterator_begin
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>  int dir_iterator_advance(struct dir_iterator *dir_iterator)
>  {
>         struct dir_iterator_int *iter =
>                 (struct dir_iterator_int *)dir_iterator;
> +       int ret;
>
>         while (1) {
>                 struct dir_iterator_level *level =
> @@ -71,6 +75,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>
>                         level->dir = opendir(iter->base.path.buf);
>                         if (!level->dir && errno != ENOENT) {
> +                               if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +                                       goto error_out;
>                                 warning("error opening directory %s: %s",
>                                         iter->base.path.buf, strerror(errno));
>                                 /* Popping the level is handled below */
> @@ -122,6 +128,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>                         if (!de) {
>                                 /* This level is exhausted; pop up a level. */
>                                 if (errno) {
> +                                       if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +                                               goto error_out;
>                                         warning("error reading directory %s: %s",
>                                                 iter->base.path.buf, strerror(errno));
>                                 } else if (closedir(level->dir))
> @@ -138,11 +146,20 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>                                 continue;
>
>                         strbuf_addstr(&iter->base.path, de->d_name);
> -                       if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
> -                               if (errno != ENOENT)
> +
> +                       if (iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS)
> +                               ret = stat(iter->base.path.buf, &iter->base.st);
> +                       else
> +                               ret = lstat(iter->base.path.buf, &iter->base.st);
> +
> +                       if (ret < 0) {
> +                               if (errno != ENOENT) {
> +                                       if (iter->flags & DIR_ITERATOR_PEDANTIC)
> +                                               goto error_out;
>                                         warning("error reading path '%s': %s",
>                                                 iter->base.path.buf,
>                                                 strerror(errno));
> +                               }
>                                 continue;
>                         }
>
> @@ -159,6 +176,10 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
>                         return ITER_OK;
>                 }
>         }
> +
> +error_out:
> +       dir_iterator_abort(dir_iterator);

Should this function call this or leaveit to the caller? The
description says "free resources" which to me sounds like something
the caller should be aware of. Although if double dir_iterator_abort()
has no bad side effects then I guess we can even leave it here.

PS. files-backend.c does call dir_iterator_abort() unconditionally.
Which sounds like this double-abort pattern should be dealt with even
if that call site does not use the pedantic flag (it could later on,
who knows; don't leave traps behind).

> +       return ITER_ERROR;
>  }
>
> diff --git a/dir-iterator.h b/dir-iterator.h
> index 970793d07a..fe9eb9a04b 100644
> --- a/dir-iterator.h
> +++ b/dir-iterator.h
> @@ -6,9 +6,10 @@
>  /*
>   * Iterate over a directory tree.
>   *
> - * Iterate over a directory tree, recursively, including paths of all
> - * types and hidden paths. Skip "." and ".." entries and don't follow
> - * symlinks except for the original path.
> + * With no flags to modify behaviour, iterate over a directory tree,

Nit but I think we can just skip "With no flags to modify behavior". It's given.

> + * recursively, including paths of all types and hidden paths. Skip
> + * "." and ".." entries and don't follow symlinks except for the
> + * original path.
>   *
>   * Every time dir_iterator_advance() is called, update the members of
>   * the dir_iterator structure to reflect the next path in the
> @@ -19,7 +20,7 @@
>   * A typical iteration looks like this:
>   *
>   *     int ok;
> - *     struct iterator *iter = dir_iterator_begin(path);
> + *     struct iterator *iter = dir_iterator_begin(path, 0);
>   *
>   *     while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
>   *             if (want_to_stop_iteration()) {
> @@ -40,6 +41,20 @@
>   * dir_iterator_advance() again.
>   */
>
> +/*
> + * Flags for dir_iterator_begin:
> + *
> + * - DIR_ITERATOR_PEDANTIC: override dir-iterator's default behavior
> + *   in case of an error while trying to fetch the next entry, which is
> + *   to emit a warning and keep going. With this flag, resouces are
> + *   freed and ITER_ERROR is return immediately.
> + *
> + * - DIR_ITERATOR_FOLLOW_SYMLINKS: make dir-iterator follow symlinks to
> + *   directories, i.e., iterate over linked directories' contents.

Do we really need this flag? If dir-iterator does not follow symlinks,
the caller _can_ check stat data to detect symlinks and look inside
anyway. So this flag is more about convenience (_if_ it has more than
one call site, convenience for one call site is just not worth it).

Or is there something else I'm missing?

> + */
> +#define DIR_ITERATOR_PEDANTIC (1 << 0)
> +#define DIR_ITERATOR_FOLLOW_SYMLINKS (1 << 1)
> +
-- 
Duy
