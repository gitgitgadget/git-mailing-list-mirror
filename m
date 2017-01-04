Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C2120798
	for <e@80x24.org>; Wed,  4 Jan 2017 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760409AbdADN5q (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 08:57:46 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34809 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760435AbdADN5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 08:57:00 -0500
Received: by mail-io0-f193.google.com with SMTP id n85so33463728ioi.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 05:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zTr+2DcvNx74ZDp+/wmprDDMTcLR/wFV6g0nI2wweMA=;
        b=H7ffhMSafLYOSVAwil7bSKspUF5I5jH5LGTyn/0eMtbQux3GHREkfFvr/PlsKAt/1c
         jgMh8u6n1yT/y3xVoh3Qi6NJt06Qs1B2aLl4YPfNetsce4k10yhdJrMF9MISskCRwlKr
         H1P6V/C1CiCWFUElroF8GDvT+7As51iqVtdgsvfFWT4AUH0SfjCXXrkCWfHXpGyqemXl
         7KqOuCDdV73vZSu9ZYairEvxkVdTGR6UAClH+P5tD6mHHrZdG9BzsZNHObg6/tlh78zj
         zdNF/7mxJs2ykObUqNADQVlJ6FkPj16GckOUMlG7uEwrXGHpq0teaAahjK6+ivVht8zQ
         zf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zTr+2DcvNx74ZDp+/wmprDDMTcLR/wFV6g0nI2wweMA=;
        b=Tx+7a/+5bwu93uPS05xioeAGTPnI7J917Zi11R33skoAqqiGqI9d5HFdTJnF/odEUZ
         M+j6EFhXOLu6YSmtsgZAQXbkc3Phowx30ERUjhqHfQajKyl5QP3XsRAyJGIjmqLhkUbv
         pV4ixJXW/hMNz3qZKNuu1ZdqArZS67qVFyVh3cnAfTZRWWjKJIKPesSxE3XV7oFvtome
         g2KcP/3d1fN983k/1CtUiNUdOfgct11Cl7d2c/n5YiMyRncp04H/TSvMYKoe+spboCcL
         iOFFxVhOTd8S9qAji0zRQboeSqoSX4HEnohlPKgPBkYzHuBFDBvYgq/s9rdyMszGaHDN
         B2Nw==
X-Gm-Message-State: AIkVDXJBbrQTjs9Yqu9szLkh/fhvkj9cmjd8JpuKmJb5Bp4RS3E9pp+emTu0/9gvoAYH3niKL/3f1p7+9XOjNg==
X-Received: by 10.107.44.137 with SMTP id s131mr49631743ios.212.1483538219175;
 Wed, 04 Jan 2017 05:56:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 4 Jan 2017 05:56:28 -0800 (PST)
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com> <20170103184241.128409-1-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 4 Jan 2017 20:56:28 +0700
Message-ID: <CACsJy8C=SC+gE1HQeGdE5z3+S8RHwiM-4ZXBzuwvN=+COUGNzg@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] pathspec cleanup
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 4, 2017 at 1:42 AM, Brandon Williams <bmwill@google.com> wrote:
> diff --git a/dir.c b/dir.c
> index 15f7c9993..e8ddd7f8a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1353,6 +1353,15 @@ static int simplify_away(const char *path, int pathlen,
>  {
>         int i;
>
> +       if (pathspec)
> +               guard_pathspec(pathspec,
> +                              pathspec_fromtop |
> +                              pathspec_maxdepth |
> +                              pathspec_literal |
> +                              pathspec_glob |
> +                              pathspec_icase |
> +                              pathspec_exclude);

You have done some magic (or your MTA/editor did) to lower case
GUARD_PATHSPEC and all the flags. The real patch looks good though, so
no problem.

> +
>         if (!pathspec || !pathspec->nr)
>                 return 0;


Super tiny nit, if GUARD_PATHSPEC is placed after this line, then we
don't have to check if pathspec is non-NULL. Probably not worth a
re-roll unless somebody else finds something else.

>                 if (m->mnemonic)
> -                       strbuf_addf(&sb, "'(%c)%s'", m->mnemonic, m->name);
> +                       strbuf_addf(&sb, "'%s' (mnemonic: '%c')",
> +                                   m->name, m->mnemonic);

.. and that somebody might be me :) we need to mark "mnemonic" for
translation. Putting _() around the string would do.

Ideally I would give the translators the whole sentence so they can
have good context (and good translation as a result). But since we
potentially concatenate multiple unsupported magic in the string,
there's no way to provide one (or a few) fixed string(s) at compile
time. So let's just _() it and leave it at that.
-- 
Duy
