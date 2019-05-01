Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15D91F453
	for <e@80x24.org>; Wed,  1 May 2019 10:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEAKTZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:19:25 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50877 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:19:25 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so9150188itk.0
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkQ6uWr09q9aeP8HAN/eMVO5Loeh24djGClUMlKdg0E=;
        b=ovm+hUDNrAA5fI59nDodl9DNOpvZi+fCH/aIolzjn4JoDQonXfGFGA47DOEbTM3kic
         LYcDrFm92WzaesQwgqRp6xP8VhGVJ9N1ez0fGpux80OUfykddLrTh3bTzdXjHOI4eM+i
         WTnOZ8nAb+UajaYcBo+Lo0GDRijQNvDicIpk0KKOGZ09gh/RIAUPcv418vCIP4HI/TmC
         /EzlqBEgkdMQjzFewGYemMtp/vboso+geoVuN1BMAoelUF8iMfNBjjz25KAVCgBgl6dM
         xscYZJB6r/9tbQKE4bsMtkzHpjFH1v0+u1OHqrKQNwNjhSku2NvX1tnic5N9AzYGlmCW
         pGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkQ6uWr09q9aeP8HAN/eMVO5Loeh24djGClUMlKdg0E=;
        b=hAKrIlV60BIJL4ldT9png49nm/h34Cu0eqXZUv/Zn3vhdnc0sskFYlp1oh0/vOBqfi
         pN9V5AweAzBNWhqLW5rfyjpculD2R0t/6+oAQYFBPmhy6cXolDky5YVKYpNwPv6ErJNw
         3SjKrbDVbuc5qxVnk/+wViqpdTeeE7hQguhl/jpE8f/9S7ZHkqXatFfxTG+so4vbTvCs
         ItMZmZXceFjk4X2OI7Pd6dnm99PpHYp6xC1cU9oMvZmZMPpRS3t3pgjPPDEdJ58I/zd/
         4vitgXSaE+gFzNRGNtA3GqdK8Hrm4BBIiiskiVfXJFC3JkbSIXyywst18fZ9RBZmGrGG
         47aQ==
X-Gm-Message-State: APjAAAXb+YWhgogUBB7ZnxEAL44t4ec5Ww7iYcDkieW/O5dW/0P/P4NF
        wZ2aQ8t3mWeTwsKigj4iRX9J0+FKkbi6zmkMvkg=
X-Google-Smtp-Source: APXvYqwDiaJjex5/i1aQOcFt7ujxKaZkOCF0JgEMseYhDFXZr0cWn2pXobsCl5kNXdMjLZ1BJVw/FL1Wvys1K4SkQ70=
X-Received: by 2002:a24:478a:: with SMTP id t132mr7321494itb.123.1556705964569;
 Wed, 01 May 2019 03:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190501101403.20294-1-phillip.wood123@gmail.com> <20190501101403.20294-2-phillip.wood123@gmail.com>
In-Reply-To: <20190501101403.20294-2-phillip.wood123@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 17:18:58 +0700
Message-ID: <CACsJy8AeOWEMVcDiJky1SbSitkyBxSWu9CeDf8aspyLA1VDe8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] read-tree --reset: add --protect-untracked
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 5:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> diff --git a/unpack-trees.h b/unpack-trees.h
> index d344d7d296..732b262c4d 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -41,9 +41,15 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>   */
>  void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
>
> +enum unpack_trees_reset_type {
> +       UNPACK_NO_RESET = 0,
> +       UNPACK_RESET_OVERWRITE_UNTRACKED,
> +       UNPACK_RESET_PROTECT_UNTRACKED
> +};
> +
>  struct unpack_trees_options {
> -       unsigned int reset,
> -                    merge,
> +       enum unpack_trees_reset_type reset;

Can we add protected_untracked that can be used in combination with
the current "reset"?

This opens up (or raises the question about) the opportunity to
protect untracked changes on non-reset updates.

> +       unsigned int merge,
>                      update,
>                      clone,
>                      index_only,
> --
> 2.21.0
>


-- 
Duy
