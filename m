Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32609C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82CE64F86
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 17:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhBBRlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 12:41:03 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49]:46140 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbhBBRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 12:38:00 -0500
Received: by mail-ej1-f49.google.com with SMTP id rv9so31208272ejb.13
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 09:37:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFUbIo0iI3CI6i5PezeBgSRkz3fLaZhCwyTgDIPbWo0=;
        b=YrFi2fHWZdQder4I7/qW62aRKGJ/5M/K04XO8kITIj/JaJx9S26p02sRlAq41a9x/i
         ig1KKj6Hafdtzt6yUbSq+Q270HL9sp8fJ4sbsIeINWsyazdlQ+jEQo+x7jD/xu82jyIK
         Tt7dKj00HujNlH4A0zwhQ7lUPcFLJFHYvHLLUjLZ9m1cF5YIHByAIdoEY7/4qIkv9erw
         eqn121Ztklv/07tNTbPDDA3Q7otUXIzNnLi0ZZrCruSBJAKYuZx6L7iA7LsTs3+AEVQp
         8upiFcq1hXKi7ijGlt1RLfWLDvvqdAlGKxpMkYh04DcS0LZsfIxjLekfTEp2l7WFe1cH
         g3Sw==
X-Gm-Message-State: AOAM531nhdwVJfafHgZ152eXtTmQ/9lGp37GbcpHT7/I4iqaCWIQlX/0
        7/C4V/kLPCiCTTqaoqFlxMyGHP83a0Z2Z3EN3XA=
X-Google-Smtp-Source: ABdhPJy3kEbWcH2X2FlL8R9pm3DGUw5L825eB8Qtmr+9xunatyYT3jDmtfemt6nDDPmQKkxBne5JtfMvxrMBNIpyra4=
X-Received: by 2002:a17:906:a1c2:: with SMTP id bx2mr23880950ejb.138.1612287438467;
 Tue, 02 Feb 2021 09:37:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612258145.git.liu.denton@gmail.com> <17675b9e4c0c50e6bfd5219c933b5ba1148ab86c.1612258145.git.liu.denton@gmail.com>
In-Reply-To: <17675b9e4c0c50e6bfd5219c933b5ba1148ab86c.1612258145.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Feb 2021 12:37:07 -0500
Message-ID: <CAPig+cRuD19xwfmkn2E4669n+0BPJg24NBOp-Zjv9uKDTXedFA@mail.gmail.com>
Subject: Re: [PATCH 1/9] git-stash.txt: be explicit about subcommand options
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 4:36 AM Denton Liu <liu.denton@gmail.com> wrote:
> Currently, the options for the `list` and `show` subcommands are just
> listed as `<options>`. This seems to imply, from a cursory glance at the
> summary, that they take the stash options listed below. However, reading
> more carefully, we see that they take log options and diff options
> respectively.
>
> Make it more obvious that they take log and diff options by explicitly
> stating this in the subcommand summary.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> @@ -67,7 +67,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
> -list [<options>]::
> +list [<log options>]::
>
> -show [<options>] [<stash>]::
> +show [<diff options>] [<stash>]::

I might suggest that it is more common to hyphenate these words than
to separate them with spaces:

    list [<log-options>]::
    show [<diff-options>] [<stash>]::
