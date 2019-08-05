Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712D91F731
	for <e@80x24.org>; Mon,  5 Aug 2019 16:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfHEQTg (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 12:19:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45982 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfHEQTg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 12:19:36 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so168524159ioc.12
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4NoUy5ckN+8KNF2OZ8NJ8VJQnTeeJ48yBN9fWHJOEE=;
        b=uQi39vd//CCqzUmJJ4PAi65fFoHdTUm0m9WVGrLlwVOB51esZ2OR38mSb8U5OL9Te0
         fr0FVRhHzMagkLM+9OiwYevzC7wKytQ+jZratKeOS5EurNiDhgP6jJrmIK5y2kPeqlAq
         OyAis+5eD3Do9JfhsTwOtZ95lykk1v6SPKJyLkl3a346898g1b/Iprb0fltnLRWQVgev
         ZF4oFJVoTiIZ20dfHzEwZ6z3dbTc/DY9iYWX7ZWJdhpX4Ex6Uqr6i5N9zZqeG1x7Uzl5
         60JQRqscSmTdd14R1YAVwQoFlDBIWnloz5E5BakwnA+gOQVvRlIDq8oV18ct7UXkLze3
         pdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4NoUy5ckN+8KNF2OZ8NJ8VJQnTeeJ48yBN9fWHJOEE=;
        b=DpLWh26/3i46K7f24WnCuXnTr/q5FLDB8ZjvCd6yONj4CZjYuFbwUAL5Q7KEAloC67
         Yt+aWNSPP5Kd7hRaEtRirVSEr/i6sSAx3shQmBRgm30JCovHE507Xoq2Cn96OQsPwXSZ
         8+DDyRqdZMq82esQiTG3gRkT8MAy8t5uH+TocAzPEP78Ejs5nywITeXa1Qmh1KPsHSl+
         8Bg7Wq3N9QnOXNrbW4M2puq74xIA+HuRnhYrafjs4iIk6+zrd0vfW7KElXv89evybgyf
         fgThfIilGGN9dA2b7A9GcMpA1gvDJfEMJW4nSHJcwaEzNCcZecOM8m/VkrLxHrZ3KGUw
         5T7A==
X-Gm-Message-State: APjAAAUef7VizuOeaFZUCRWtAsI1v5QuUGgQfDKq5sjJJ/VUJp0f1N3h
        G8iEfBn/otXZt3eOTWEs9I/QRVlOahKNHlfAMSI=
X-Google-Smtp-Source: APXvYqyF0WiUaV57oBXN1TN4G7i6aeWZyEbaJbs4EfsR7zcp4cUWHedLKnfNMcIE0sPXxMoMLsvbPjvGYu17v9f/kbY=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr12659929iok.252.1565021975249;
 Mon, 05 Aug 2019 09:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.306.git.gitgitgadget@gmail.com> <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com>
In-Reply-To: <3397e6797f872aedd18c6d795f4976e1c579514b.1565005867.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 5 Aug 2019 09:19:24 -0700
Message-ID: <CAPUEspgH1v1zo7smzQWCV4rX9pKVKLV84gDSfCPdT7LffQxUWw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pcre2: allow overriding the system allocator
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 5, 2019 at 4:51 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Since 7d3bf769994 (grep: avoid leak of chartables in PCRE2, 2019-08-01),
> we try to release the UTF-8 tables obtained via `pcre2_maketables()`. To
> do that, we use the function `free()`. That is all fine and dandy as
> long as that refers to the system allocator.

Sorry; I should have thought of this, but assumed was safe since it
would be broken
the same way with PCRE1.

Presume git in windows only builds against PCRE2?

LGTM except from the suggestion below that might make the code more "standard"
and probably be a good base for a similar PCRE1 fix
>
> +static pcre2_general_context *get_pcre2_context(void)
> +{
> +       static pcre2_general_context *context;
> +
> +       if (!context)
> +               context = pcre2_general_context_create(pcre2_malloc,
> +                                                      pcre2_free, NULL);
> +
> +       return context;
> +}

instead of using a static variable inside this helper function it
might be better to use
one extra field inside the (struct grep_pat *p), where all other
variables are kept

Additionally to being more consistent will avoid creating the global
context for the
most common case (when the locale is either C/POSIX or UTF-8) and therefore
have a smaller impact on performance.

Carlo
