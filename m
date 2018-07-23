Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA541F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbeGWXYL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 19:24:11 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:43533 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbeGWXYL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 19:24:11 -0400
Received: by mail-yb0-f195.google.com with SMTP id x10-v6so887633ybl.10
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2Z3ARlR2Xg7VTF614hBgB0z25E+aeGElHSsvoqXuB4=;
        b=GdfdQPvUA2e1zqxuhtnRe3A5Jdgs7GEyrNjG1o5vqWyzw3VYsztYj3x7ci0xK98TY7
         F47XMh0vPsDU8PHhbPUAdLm5jfw4o6L0yajVGqAajBaqFtKPMdHnoPovSSPlEOOoQPOt
         xKwfRR/6y8p/N0kwEyaFhHHElj6qV8GNBjONuW8gkEwtbVT7c67dRPYDuGtAHsucsIkU
         XzTNubQg9faMA4L4ZnDhLVpDcLTVhSv9XJxJHyAEbPsP2dudl/AaTw6zP1Tbq+XUgiK5
         1tQ/+z1gu0D7DvvXEDOPle1Haq014/JT85fdcxIpVDgcTWbMePog7EXkbEd/m2x2caoU
         l/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2Z3ARlR2Xg7VTF614hBgB0z25E+aeGElHSsvoqXuB4=;
        b=P5pPlmbFhCXEG85KvTLjDrWLzBj8W8wMUZzgMyZs6bxwrueV5XsbGfLRZ+p8+/tYa3
         ex8wgssUYTbmSzhfT6xoUSoUTzSAnc1C1D6Hcu/AyLxP5QSDOv2vrklDV7vwXSViBfta
         2+hh4AKbrV61LCXZXJB2ADTwBIhr2qLx3cWMVwUDdjnbPmXibDQjWCy1H1UY2hyW2Kak
         BhpN0OEKP75ix/oh50Q76jRZIQc6yzLBd7XvTxC0licQQ0TVj4LfHsyEo+WLtGPBXUxS
         uZMlmFt5CkvP2aw6g/57kOECXdptDV43dIWkbUW0wqg4HXRmQCkbgUrf3DFo2fORHhnv
         vf1w==
X-Gm-Message-State: AOUpUlG3NnQl6ZG98TSDaNEyMbiwL3E5ro39Vp7NzmdcAo6vILP2oyqY
        HObGbC1u2cG3BLKCQWCqMI9BXfN2RU1TJPSEI9l0d8H3IwWOyQ==
X-Google-Smtp-Source: AAOMgpe+zzOls3rl4FvXKE7nvabmpF+O+05CqTeOmBguckdiwVMyk6yUUEIOWqbQUQP71ZOrhmX+HHjhm2FV2DFojrU=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr8279400ybm.307.1532384450383;
 Mon, 23 Jul 2018 15:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 15:20:39 -0700
Message-ID: <CAGZ79kZRoN6DmKYPyvQ33yXqxz8ukfuXVROw9pzZBvob-vjHAQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/21] range-diff --dual-color: fix bogus white-space warning
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 3:05 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When displaying a diff of diffs, it is possible that there is an outer
> `+` before a context line. That happens when the context changed between
> old and new commit. When that context line starts with a tab (after the
> space that marks it as context line), our diff machinery spits out a
> white-space error (space before tab), but in this case, that is
> incorrect.
>
> Fix this by adding a specific whitespace flag that simply ignores the
> first space in the output.

That sounds like a simple (not easy) solution, which sounds acceptable
to me here.

I guess you dropped all ideas that I originally proposed for the cleanup
regarding ws. that is fine, I can roll the cleanup on top of your patches
here.

> Of course, this flag is *really* specific to the "diff of diffs" use
> case. The original idea was to simply skip the space from the output,
> but that workaround was rejected by the Git maintainer as causing
> headaches.

By that you mean
https://public-inbox.org/git/xmqqr2kb9jk2.fsf@gitster-ct.c.googlers.com/
?

> Note: as the original code did not leave any space in the bit mask
> before the WSEH_* bits, the diff of this commit looks unnecessarily
> involved: the diff is dominated by making room for one more bit to be
> used by the whitespace rules.

It took me some minutes, but I am reasonably convinced this patch
is correct (and doesn't collide with other series in flight, sb/diff-color-more
adds another flag to move detection in another bit field at (1<<23))

Thanks for writing this patch instead of the other, though I'll leave
it to Junio to weigh in if this approach is the best design.

Stefan

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  cache.h |  3 ++-
>  diff.c  | 15 ++++++++-------
>  diff.h  |  6 +++---
>  ws.c    | 11 ++++++++++-
>  4 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 8b447652a..8abfbeb73 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1681,11 +1681,12 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
>  #define WS_CR_AT_EOL           01000
>  #define WS_BLANK_AT_EOF        02000
>  #define WS_TAB_IN_INDENT       04000
> +#define WS_IGNORE_FIRST_SPACE 010000
>  #define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>  #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
>  #define WS_TAB_WIDTH_MASK        077
>  /* All WS_* -- when extended, adapt diff.c emit_symbol */
> -#define WS_RULE_MASK           07777
> +#define WS_RULE_MASK           017777
>  extern unsigned whitespace_rule_cfg;
>  extern unsigned whitespace_rule(const char *);
>  extern unsigned parse_whitespace_rule(const char *);
> diff --git a/diff.c b/diff.c
> index e163bc8a3..03ed235c7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -650,14 +650,14 @@ enum diff_symbol {
>  };
>  /*
>   * Flags for content lines:
> - * 0..12 are whitespace rules
> - * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
> - * 16 is marking if the line is blank at EOF
> + * 0..14 are whitespace rules
> + * 14-16 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
> + * 17 is marking if the line is blank at EOF
>   */
> -#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF     (1<<16)
> -#define DIFF_SYMBOL_MOVED_LINE                 (1<<17)
> -#define DIFF_SYMBOL_MOVED_LINE_ALT             (1<<18)
> -#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING   (1<<19)
> +#define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF     (1<<17)
> +#define DIFF_SYMBOL_MOVED_LINE                 (1<<18)
> +#define DIFF_SYMBOL_MOVED_LINE_ALT             (1<<19)
> +#define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING   (1<<20)
>  #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
>
>  /*
> @@ -1094,6 +1094,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>                                 set = diff_get_color_opt(o, DIFF_FRAGINFO);
>                         else if (c != '+')
>                                 set = diff_get_color_opt(o, DIFF_CONTEXT);
> +                       flags |= WS_IGNORE_FIRST_SPACE;
>                 }
>                 emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
>                                     flags & DIFF_SYMBOL_CONTENT_WS_MASK,
> diff --git a/diff.h b/diff.h
> index 79beb6eea..892416a14 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -160,9 +160,9 @@ struct diff_options {
>         int abbrev;
>         int ita_invisible_in_index;
>  /* white-space error highlighting */
> -#define WSEH_NEW (1<<12)
> -#define WSEH_CONTEXT (1<<13)
> -#define WSEH_OLD (1<<14)
> +#define WSEH_NEW (1<<13)
> +#define WSEH_CONTEXT (1<<14)
> +#define WSEH_OLD (1<<15)
>         unsigned ws_error_highlight;
>         const char *prefix;
>         int prefix_length;
> diff --git a/ws.c b/ws.c
> index a07caedd5..e02365a6a 100644
> --- a/ws.c
> +++ b/ws.c
> @@ -20,6 +20,7 @@ static struct whitespace_rule {
>         { "blank-at-eol", WS_BLANK_AT_EOL, 0 },
>         { "blank-at-eof", WS_BLANK_AT_EOF, 0 },
>         { "tab-in-indent", WS_TAB_IN_INDENT, 0, 1 },
> +       { "ignore-first-space", WS_IGNORE_FIRST_SPACE, 0, 1 },
>  };
>
>  unsigned parse_whitespace_rule(const char *string)
> @@ -177,8 +178,16 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
>         if (trailing_whitespace == -1)
>                 trailing_whitespace = len;
>
> +       if ((ws_rule & WS_IGNORE_FIRST_SPACE) && len && line[0] == ' ') {
> +               if (stream)
> +                       fwrite(line, 1, 1, stream);
> +               written++;
> +               if (!trailing_whitespace)
> +                       trailing_whitespace++;
> +       }
> +
>         /* Check indentation */
> -       for (i = 0; i < trailing_whitespace; i++) {
> +       for (i = written; i < trailing_whitespace; i++) {
>                 if (line[i] == ' ')
>                         continue;
>                 if (line[i] != '\t')
> --
> gitgitgadget
>
