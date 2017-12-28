Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83841F406
	for <e@80x24.org>; Thu, 28 Dec 2017 22:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdL1W3H (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 17:29:07 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32961 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1W3H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 17:29:07 -0500
Received: by mail-qk0-f173.google.com with SMTP id x7so33804547qkb.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 14:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=W+6eQWxj6+4FJkXpUWfbr/MYYAnBsdw+ALKcBgYdE0g=;
        b=epKmkfwMJPO3xIk1uySVQBVPA8rDuQa5AKfwMCIBLacOuqGj3ATrMXLcFArWSvWvlF
         +gE6EnBDa3bD2r1maanhZnnalfv6tG3uN0yVRewzeFCwXyleu+8gdGnaCejjeO9Pys8m
         /DAIo1ejaa8JdOJWTCd3WLZhvYpp1xgtBjMIOsX010WKnh6ZctFXIIJ1Tep0rw5BvY4W
         eZ1+PEwjedTzz99OreVkIuHg6EOeWBpcimO9VwVbFBbwTolGlRlEnNerkj3+NxU1i62o
         8XrcyqqqYxi5yILzUd7xl6B4Di2stoedPSa1eFfuHMJxGAFWiTNagFZSU0xZ2s4dCYkc
         +LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=W+6eQWxj6+4FJkXpUWfbr/MYYAnBsdw+ALKcBgYdE0g=;
        b=S+xhRCXrru09Uwbt6FvPZrjVDoayVme8AtcSjaTn/QrVmWkpYy0ZewvWCZjbgYiahS
         ROmLzJVqWn99OaedpJ1u3XAHrqtFJBtRB6vGZo/4TGCB3K0SvYhqAIgOSXinGVtL9+58
         26rJJkw/dODt7AzXB97lQszzvBQRb4/IqfoKIPACUAkZ6b/9lB4ljdBa+mqvyiDPTt/o
         ONcBKn3ZXm5hG/zQf5kwnU7qiW6lgdBKRVBPmKVEQYFXRLY2grhrwyv+qfFYfozEqolS
         8W1gcuOLRxqDkpG9PHtwtHlPvoCcGmvPNPPrsHjqJiYPaZCXMkJ37m2qO12K2a1gbhQc
         aqMw==
X-Gm-Message-State: AKGB3mIkAPiGtpl3O8UsecIU+AzXQQ7cxWA+4xh+aCYy4MuhNoRWHLb5
        xrlyuNnHs8U+JOJv0Vs16RawwncyhuCB3O9Oehg=
X-Google-Smtp-Source: ACJfBovvgkREpgGgBuO6ywOupKqVDMYC9BjSEWe2hJltmKFEbPDIkTB6+/wrcDqS8q4z+xcOeIsh1ng/Dl6TYNx0fqk=
X-Received: by 10.55.130.194 with SMTP id e185mr41366117qkd.357.1514500146273;
 Thu, 28 Dec 2017 14:29:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Thu, 28 Dec 2017 14:29:05 -0800 (PST)
In-Reply-To: <20171228210345.205300-3-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-3-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Dec 2017 17:29:05 -0500
X-Google-Sender-Auth: d37nBRYOCZW7RJqaToFXjWcTflw
Message-ID: <CAPig+cTkxmiJZwLqYhKhvApZubJLTLufv2Yo6D5nLMLmrUc2cg@mail.gmail.com>
Subject: Re: [PATCH 2/4] builtin/blame: dim uninteresting metadata
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
> When using git-blame lots of lines contain redundant information, for
> example in hunks that consist of multiple lines, the metadata (commit
> name, author, date) are repeated. A reader may not be interested in those,
> so offer an option to color the information that is repeated from the
> previous line differently.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/blame.c b/builtin/blame.c
> @@ -367,6 +370,28 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
> +static inline void colors_unset(const char **use_color, const char **reset_color)
> +{
> +       *use_color = "";
> +       *reset_color = "";
> +}
> +
> +static inline void colors_set(const char **use_color, const char **reset_color)
> +{
> +       *use_color = repeated_meta_color;
> +       *reset_color = GIT_COLOR_RESET;
> +}
> +
> +static void setup_line_color(int opt, int cnt,
> +                            const char **use_color,
> +                            const char **reset_color)
> +{
> +       colors_unset(use_color, reset_color);
> +
> +       if ((opt & OUTPUT_COLOR_LINE) && cnt > 0)
> +               colors_set(use_color, reset_color);
> +}

I'm not convinced that this colors_unset() / colors_set() /
setup_line_color() abstraction is buying much. With this abstraction,
I found the code more difficult to reason about than if the colors
were just set/unset manually in the code which needs the colors. I
*could* perhaps imagine setup_line_color() existing as a separate
function since it is slightly more complex than the other two, but as
it has only a single caller through all patches, even that may not be
sufficient to warrant its existence.

> @@ -383,6 +408,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>         for (cnt = 0; cnt < ent->num_lines; cnt++) {
>                 char ch;
>                 int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
> +               const char *col, *rcol;

I can't help but read these as "column" and "[r]column"; the former,
especially, is just too ingrained to interpret it any other way.
Perhaps call these "color" and "reset" instead?

> @@ -607,6 +636,12 @@ static int git_blame_config(const char *var, const char *value, void *cb)
> +       if (!strcmp(var, "color.blame.repeatedmeta")) {
> +               if (color_parse_mem(value, strlen(value), repeated_meta_color))
> +                       warning(_("ignore invalid color '%s' in color.blame.repeatedMeta"),
> +                               value);

Does this need to say "ignore"? If you drop that word, you still have
a valid warning message.

> +               return 0;
> +       }
> @@ -681,6 +716,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>                 OPT_BIT('s', NULL, &output_option, N_("Suppress author name and timestamp (Default: off)"), OUTPUT_NO_AUTHOR),
>                 OPT_BIT('e', "show-email", &output_option, N_("Show author email instead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
>                 OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), XDF_IGNORE_WHITESPACE),
> +               OPT_BIT(0, "color-lines", &output_option, N_("color redundant metadata from previous line"), OUTPUT_COLOR_LINE),

Not sure what this help message means. Do you mean "color redundant
... _differently_ ..."? Or "_dim_ redundant..."?

> diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh
> +
> +test_description='colored git blame'
> +. ./test-lib.sh
> +
> +PROG='git blame -c'
> +. "$TEST_DIRECTORY"/annotate-tests.sh
> +
> +test_expect_success 'colored blame colors continuous lines' '

What are "continuous lines"? Did you mean "contiguous"?

> +       git blame --abbrev=12 --color-lines hello.c >actual.raw &&
> +       test_decode_color <actual.raw >actual &&
> +       grep "<BOLD;BLACK>(F" actual > F.expect &&
> +       grep "<BOLD;BLACK>(H" actual > H.expect &&
> +       test_line_count = 2 F.expect &&
> +       test_line_count = 3 H.expect
> +'
