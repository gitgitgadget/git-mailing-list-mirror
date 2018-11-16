Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34DC21F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 21:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeKQIBX (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 03:01:23 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36493 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQIBW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 03:01:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so11589524edb.3
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 13:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKgoQEbdkJSqnU+yjXkrFkXaSuksnO4k6lEV6hrP5NE=;
        b=gEma9/8282sWT4JG1xu1eqanJBU14NJU9domkZL2pdrTteVVV8R5jQzg3t8oZavwuP
         ePsbtFnEwK/Mlp++Dfy3bRNentP0+inB2pHEw723gSMYNVqZNchVPMNGiMFm4aAgn+yj
         TEUq5Gl2YYT2u0zEV8hjRm4cXUPWFn3WkM7I8mQWCWmqIXyBSeKP7Xb96iyp79LlTF9D
         BdmvqIe0+cx+Ck6cXFKSV/fgXh/4ek31Nt2zsV0cPR1HQWGPp8sGTo3fxBUems/EY2Ip
         t/7i8dygeFolrJG72U10HDKW0lteCgCsfQ9T2mR4aHfllaK50hMM2EighbEnhx7jYaNU
         jKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKgoQEbdkJSqnU+yjXkrFkXaSuksnO4k6lEV6hrP5NE=;
        b=JhhYO1N3/ovzaCheRrimgmZsNgBKNOHMSwggr8tLiu4nWyhmIg4GTG0jRWg42ShwS9
         iVntF+NoEdOCKKpC8a9GmuTPBMCpmqCD+9cXOy8HKATodoqMR0x8whfqdwUZEvduedjs
         hk+KEcuXZxmNaEOnyr2Y6nEVR+zH9DdxWtlig01/XknOXWqOM2O49pyKLaz5iZlVg69O
         OVgEGuo3B7CPcLuVe/4j8cRg+EXaKKF1eoaKWUoeLzYgPdfexypheq2qyZ/KZH83cbqk
         EEh7N+F4OSuK4jkc46oE86LBY1NLydYs+1DhqFC3FLe5xtq0+0vL9c/DcMBz0ShPidrH
         XLUA==
X-Gm-Message-State: AGRZ1gL3cJXqjeMSldSy5qKPAONB/qrRYOWYWdzDP+s1eyhdF+WqxMzt
        P9PwBFWj4g0paBdHQwC7XT4rgSx6UkRgkK4+lPsSl+PlG/Ll0w==
X-Google-Smtp-Source: AJdET5dwPfZK/LqK5tnU0UUjIn5nhHsUWc2QwGBd5pL/ER8nK7v4faQlEDECaNKBUhMZpby+LHb3ObnrxLbIeMWXwZM=
X-Received: by 2002:a50:adcf:: with SMTP id b15-v6mr10763605edd.215.1542404834583;
 Fri, 16 Nov 2018 13:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net> <20181116110356.12311-9-phillip.wood@talktalk.net>
In-Reply-To: <20181116110356.12311-9-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 16 Nov 2018 13:47:03 -0800
Message-ID: <CAGZ79kb2fY+6xg=B+t=gSEBQ+u-wKAff++z5A=KiN2u0yYFF6g@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] diff --color-moved-ws: modify allow-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 3:04 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Currently diff --color-moved-ws=allow-indentation-change does not
> support indentation that contains a mix of tabs and spaces. For
> example in commit 546f70f377 ("convert.h: drop 'extern' from function
> declaration", 2018-06-30) the function parameters in the following
> lines are not colored as moved [1].
>
> -extern int stream_filter(struct stream_filter *,
> -                        const char *input, size_t *isize_p,
> -                        char *output, size_t *osize_p);
> +int stream_filter(struct stream_filter *,
> +                 const char *input, size_t *isize_p,
> +                 char *output, size_t *osize_p);
>
> This commit changes the way the indentation is handled to track the
> visual size of the indentation rather than the characters in the
> indentation. This has they benefit that any whitespace errors do not

s/they/the/

> interfer with the move detection (the whitespace errors will still be
> highlighted according to --ws-error-highlight). During the discussion
> of this feature there were concerns about the correct detection of
> indentation for python. However those concerns apply whether or not
> we're detecting moved lines so no attempt is made to determine if the
> indentation is 'pythonic'.
>
> [1] Note that before the commit to fix the erroneous coloring of moved
>     lines each line was colored as a different block, since that commit
>     they are uncolored.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>
> Notes:
>     Changes since rfc:
>      - It now replaces the existing implementation rather than adding a new
>        mode.
>      - The indentation deltas are now calculated once for each line and
>        cached.
>      - Optimized the whitespace delta comparison to compare string lengths
>        before comparing the actual strings.
>      - Modified the calculation of tabs as suggested by Stefan.
>      - Split out the blank line handling into a separate commit as suggest
>        by Stefan.
>      - Fixed some comments pointed out by Stefan.
>
>  diff.c                     | 130 +++++++++++++++++++++----------------
>  t/t4015-diff-whitespace.sh |  56 ++++++++++++++++
>  2 files changed, 129 insertions(+), 57 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index c378ce3daf..89559293e7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -750,6 +750,8 @@ struct emitted_diff_symbol {
>         const char *line;
>         int len;
>         int flags;
> +       int indent_off;
> +       int indent_width;

So this is the trick how we compute the ws related
data only once per line. :-)

On the other hand, we do not save memory by disabling
the ws detection, but I guess that is not a problem for now.

Would it make sense to have the new variables be
unsigned? (Also a comment on what they are, I
needed to read the code to understand off to be
offset into the line, where the content starts, and
width to be the visual width, as I did not recall
the RFC.)

> +static void fill_es_indent_data(struct emitted_diff_symbol *es)
> [...]

> +               if (o->color_moved_ws_handling &
> +                   COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
> +                       fill_es_indent_data(&o->emitted_symbols->buf[n]);

Nice.

By reducing the information kept around to ints, we also do not need
to alloc/free
memory for each line.

> +++ b/t/t4015-diff-whitespace.sh
> @@ -1901,4 +1901,60 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
>         test_i18ngrep allow-indentation-change err
>  '
>
> +test_expect_success 'compare mixed whitespace delta across moved blocks' '

Looks good,

Thanks!
Stefan
