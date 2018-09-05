Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2031F404
	for <e@80x24.org>; Wed,  5 Sep 2018 15:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIEUTx (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 16:19:53 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54735 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIEUTx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 16:19:53 -0400
Received: by mail-it0-f67.google.com with SMTP id f14-v6so10547918ita.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwgVzAcukgjx0/Vcv+pQ1xObqWcif4xOm88XSC9Hi7I=;
        b=AMjxihMmJsLxLApmJYg1yzZkBMm2TVYsRFQMA+g6Z3wh+qhWkzNuNHSyt7WLjA1bNn
         94eDdB1KQx73BuFXeWpStfgAwS8gaQ1HIk/xaFzrbgCs3VkEf6yEgPepWSxOdWMFoMzh
         1v5+lzUimus8E4joUr3Cm2gtehyO1GfPOT+8Cg2qrRopTN2+CczZJOzK5DbcfR6l47dg
         gVGxPyEUuAhGKvX0BOlc4eoPbZD9CNaGcMSLESW4IIqwFcgaf3uYNfibihdbvl+SZcw7
         fCDl+l9Ky5Q+aEVgh1jUhq5kSekViHVeQ/dljdOEWEyKOH6m2MwRNPgUE43sgUWA6hw/
         gHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwgVzAcukgjx0/Vcv+pQ1xObqWcif4xOm88XSC9Hi7I=;
        b=aBMFVcoe1/tZC+RifdaFqKW5kJUJE/pAX6yiOLWK+zZWBYabrcwhPULNs+M9jhcuQv
         VC3uz2LtsFkrvECFQUhmfFiiLIJnyhZaYHcjrPpoEnKwTXl2aJ0fMCrBgG/8OxE3phga
         AN+apAYsJiLooBL+uWH/j04wMYJRiEwaQB6hM4u1KFQIFxzcHq1Cb4KdXGZeMEn+hPvA
         DHiu4CFHQOJ+QrqFPdKJcdVVQPBgHylQsy2M/BdbcMmzt+JiTJU1pSATNfl1zROcKvuG
         Jd0O4w1FQ42mzNks3BgwdPJo2nCvoRF01d9XouRd6F/iWOF/BWFPO8fZYvGs5VlQ5vL3
         NcLQ==
X-Gm-Message-State: APzg51B6hxKydjkfl/yfQa/QW4ERSV/MO+El4zDkE+PhPCNSla4jeTj7
        HPneE8/M80Ps0SN6uxeNYiIk6OPQoyo2veJ+WWw=
X-Google-Smtp-Source: ANB0VdY1oACs+fejBDliYzrJb/VAiQ8+XvmwP8s8koB9MONNA02cnO7hctLQwf0hE3piMA+cGJsHhSqxwUvNgoZqshg=
X-Received: by 2002:a02:b006:: with SMTP id p6-v6mr27305168jah.97.1536162546571;
 Wed, 05 Sep 2018 08:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180905085427.4099-1-timschumi@gmx.de>
In-Reply-To: <20180905085427.4099-1-timschumi@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Sep 2018 17:48:40 +0200
Message-ID: <CACsJy8BLEtBWyAuRBphv_PVisKao0YaBewKJXECEuCVzvk9qXg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Allow aliases that include other aliases
To:     timschumi@gmx.de
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 10:56 AM Tim Schumacher <timschumi@gmx.de> wrote:
>
> Aliases can only contain non-alias git commands and their
> arguments, not other user-defined aliases. Resolving further
> (nested) aliases is prevented by breaking the loop after the
> first alias was processed. Git then fails with a command-not-found
> error.
>
> Allow resolving nested aliases by not breaking the loop in
> run_argv() after the first alias was processed. Instead, continue
> incrementing `done_alias` until `handle_alias()` fails, which means that
> there are no further aliases that can be processed. Prevent looping
> aliases by storing substituted commands in `cmd_list` and checking if
> a command has been substituted previously.
> ---
>
> This is what I've come up with to prevent looping aliases. I'm not too
> happy with the number of indentations needed, but this seemed to be the
> easiest way to search an array for a value.

You can just make all the new code a separate function, which reduces
indentation.

There's another thing I wanted (but probably a wrong thing to want):
if I define alias 'foo' in ~/.gitconfig, then I'd like to modify it in
some project by redefining it as alias.foo='foo --something' in
$GIT_DIR/config. This results in alias loop, but the loop is broken by
looking up 'foo' from a higher level config file instead.

This is not easy to do, and as I mentioned, I'm not even sure if it's
a sane thing to do.

> +               /* Increase the array size and add the current
> +                * command to it.
> +                */

I think this is pretty clear from the code, you don't need to add a
comment to explain how the next few lines work. Same comment for the
next comment block.

> +               cmd_list_alloc += strlen(*argv[0]) + 1;
> +               REALLOC_ARRAY(cmd_list, cmd_list_alloc);
> +               cmd_list[done_alias] = *argv[0];
> +
> +               /* Search the array for occurrences of that command,
> +                * abort if something has been found.
> +                */
> +               for (int i = 0; i < done_alias; i++) {
> +                       if (!strcmp(cmd_list[i], *argv[0])) {
> +                               die("loop alias: %s is called twice",

Please wrap the string in _() so that it can be translated in
different languages.

> +                                   cmd_list[done_alias]);
> +                       }
> +               }
> +
-- 
Duy
