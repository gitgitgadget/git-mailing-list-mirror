Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B5E1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeC3UX6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:23:58 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39540 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeC3UX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:23:58 -0400
Received: by mail-qk0-f196.google.com with SMTP id j73so10056214qke.6
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0SZmALEBJ2Q1GobkGwXoBK8fVMXST0J3SFfVQq4rlSE=;
        b=fMEL+4SHvy5MK/IEyRNpDn7ohw/4079Qwtu26A2mOWrfIp/OMBIVltPjlDRTdXRTRM
         n3Uz4oUr5n5F7VAwQ07zmsCpvK8Bdvb/T6ZIecNN3RL9Pp8k32Ap7UPmWUuWrAPRQeTd
         WnBi5x5dhb9WcL3putl1LInb9QrDhbL9bLjVsovgozKuWFfzRA7Fa1TKCLUSZ/0ZcRI7
         z/A3XFPoFEGsAG5IXaQitgmi3yd290O9P15H8mopv1kCErzVcOCg4C0whaP1iNr0L4zn
         Lma+eR1+e8s1mbJ4+99J/L9PscrNSEHo6bu1ui7ymR0z4GOblpUhNm4O2N7cUT6vNlrZ
         sBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0SZmALEBJ2Q1GobkGwXoBK8fVMXST0J3SFfVQq4rlSE=;
        b=D0ZAGAlvzJybWVOUKczt/hKy5KnIgL0bZWJ7Uus6X3AqrWi0ppZ1e9VdvIoZIjZtRm
         nr1p6XImGwLLmX8ouVrVxdXyTCRGSBSoLaDU/d7yElkwKNXg+pyei3hgR4onbE5XcHaG
         kmqINaMlAB6SOMhBwu2p+xQZkxRcwaBjRjsJJoTOnUkpqinAMnEzyvM7CulHLi7RZWoZ
         B1wXRCSknmJAk4I4gYbnJrkERzQ7LkXICtBzQ4Jgtu9RYo3ZQ/Ia4ahYwfYmIBIPXuKl
         Gp1H7ucykn+uuqrFYiks17QWdw43Ga/AiRl+CyLiADVIgt3+5HIrKwakjUr6POjsG32H
         fnQA==
X-Gm-Message-State: ALQs6tAgfC2vQnuhXyuMqqcn9MQx8e2VmDa+trPT7GzxGar7OY41yXJs
        Akfon2iz44j4GxLIXDlwW3GM5OkZ24fvVDAaL+4=
X-Google-Smtp-Source: AIpwx499LtbYVSxkZIIE/Uv5bpYupbsUuto36WQlChP031cKqYCca93lGfpOnRo/sw+zch7i2LdGrIij3mb+Wa65jqw=
X-Received: by 10.55.198.217 with SMTP id s86mr567549qkl.153.1522441437265;
 Fri, 30 Mar 2018 13:23:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 30 Mar 2018 13:23:56 -0700 (PDT)
In-Reply-To: <20180329011634.68582-2-me@ttaylorr.com>
References: <20180324005556.8145-1-me@ttaylorr.com> <20180329011634.68582-1-me@ttaylorr.com>
 <20180329011634.68582-2-me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 30 Mar 2018 16:23:56 -0400
X-Google-Sender-Auth: feONHYhzBWtB-XVWXHtaSV1QSas
Message-ID: <CAPig+cSk_H-Dh585JsynNfp1GSuXSkKay0Vo3Jhda6-vPdi6Uw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 9:16 PM, Taylor Blau <me@ttaylorr.com> wrote:
> For some use cases, callers of the `git-config(1)` builtin would like to
> fallback to default values when the slot asked for does not exist. In
> addition, users would like to use existing type specifiers to ensure
> that values are parsed correctly when they do exist in the
> configuration.
>
> For example, to fetch a value without a type specifier and fallback to
> `$fallback`, the following is required:
>
>   $ git config core.foo || echo "$fallback"
>
> This is fine for most values, but can be tricky for difficult-to-express
> `$fallback`'s, like ANSI color codes.
>
> This motivates `--get-color`, which is a one-off exception to the normal
> type specifier rules wherein a user specifies both the configuration
> slot and an optional fallback. Both are formatted according to their
> type specifier, which eases the burden on the user to ensure that values
> are correctly formatted.
>
> This commit (and those following it in this series) aim to eventually
> replace `--get-color` with a consistent alternative. By introducing
> `--default`, we allow the `--get-color` action to be promoted to a
> `--color` type specifier, retaining the "fallback" behavior via the
> `--default` flag introduced in this commit.

I'm confused. The cover letter said that this iteration no longer
introduces a --color option (favoring instead --type=color), but this
commit message still talks about --color. Did you mean
s/--color/--type=color/ ?

> For example, we aim to replace:
>
>   $ git config --get-color slot [default] [...]
>
> with:
>
>   $ git config --default default --color slot [...]

Ditto: s/--color/--type=color/

> Values filled by `--default` behave exactly as if they were present in
> the affected configuration file; they will be parsed by type specifiers
> without the knowledge that they are not themselves present in the
> configuration.
>
> Specifically, this means that the following will work:
>
>   $ git config --int --default 1M does.not.exist
>   1048576
>
> In subsequent commits, we will offer `--color`, which (in conjunction
> with `--default`) will be sufficient to replace `--get-color`.

Ditto: s/--color/--type=color/

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
