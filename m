Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1001F404
	for <e@80x24.org>; Fri,  6 Apr 2018 06:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDFGOg (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:14:36 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33687 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeDFGOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:14:35 -0400
Received: by mail-qk0-f169.google.com with SMTP id d206so80527qkb.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OGAc3C2VoJDSqVPLjap1YhJ085J4DTQbzVoY5FzRrew=;
        b=QRwYLhWcPZFTKa5ZS9CKrLXNCh+rzyAVtnigBuCY0b7bViHS2Z831DLhWqQ7Lhy/sV
         pDCOZw3CYGX3lhA3hsorXQnaF54rxDZgW0XeopDY3o/6iTDjPcFpVju3wyzvcDMKbDsR
         1Q+Fy57dgfmhwLbj9RcvT0blZNxY6e3OhtPIS20UKXmdAgnEvUQI5obEhtw2LOJxOPIi
         XGCQNq/xJbX/9+Q8VQeTigb2WNUntqXsgUCs8EhfQjFrSbfNdKLo/MIg2afcUyNj3W00
         S3uXpYHMdebuDcYjtmgMw/li1ZUFrF4pxtfCghlIWLkQ8Ojm8hDp6+2kjrlaowfP0X1U
         8vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OGAc3C2VoJDSqVPLjap1YhJ085J4DTQbzVoY5FzRrew=;
        b=gZ086JbINESljKgtf0hqXEf7fW/HfNSghlFbwLrman1w9dIl3cSIaBTlYBpXccf4jR
         neLEX4o+TyEm12rU6N13St3YcSJO/WNXtdktJ352PI9K6kvOY7aS3G+0+oHuLSiaem+/
         WGXVyWRjqsTrtmME8OWKhDDrydIZ+HAndyLl/LOCJoiuoMiqcje1IjJ6eQAvLiAFhdDI
         4OGqPg2dYdt19C+AZCv3ZRlsPMi8AErGjsTCIv+KJOeSKs3nmq4tjLsCP1VAyx/86WEP
         8zAlYKvf0cUL3/nxFWt2is0sJ401jmYS3F5PiIf52h85TzViQLSqNN1LdzJRn0bTqbhm
         7L/Q==
X-Gm-Message-State: ALQs6tBJhJ4ZvkxzfvKqX6obqqqb4c7aY8c7f4Rj8hIK4uu4YCthgd6G
        kv7rZEWHpP8QLZy0YSjcE/oj7HNbfc5TXVQyKuI3CA==
X-Google-Smtp-Source: AIpwx49gSisYyllMbLWbLCB41OMj+M5d44nXnj8nl99PJr2RgQTylA7pjyCoqiinKkNP6JIkaapxUD3Ih8ZZK9pLLIE=
X-Received: by 10.55.159.140 with SMTP id i134mr33322277qke.220.1522995274649;
 Thu, 05 Apr 2018 23:14:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 23:14:34 -0700 (PDT)
In-Reply-To: <20180406052907.GD60769@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com> <cover.1522992443.git.me@ttaylorr.com>
 <20180406052907.GD60769@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 02:14:34 -0400
X-Google-Sender-Auth: Q7osrq3fQIakeWy4fHmK0gdaTck
Message-ID: <CAPig+cSYuWReTFfnN8Wg2VGKcOk5SPHHWpTdW6yks67mkOjY0Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 1:29 AM, Taylor Blau <me@ttaylorr.com> wrote:
> builtin/config.c: prefer `--type=bool` over `--bool`, etc.

This patch isn't just preferring --type; it's actually introducing the
functionality. Perhaps:

    builtin/config.c: support --type=<type> as preferred alias for --<type>

(Not worth a re-roll.)

> `git config` has long allowed the ability for callers to provide a 'type
> specifier', which instructs `git config` to (1) ensure that incoming
> values are satisfiable under that type, and (2) that outgoing values are
> canonicalized under that type.
>
> In another series, we propose to add extend this functionality with

"add extend"?

> `--type=color` and `--default` to replace `--get-color`.
>
> However, we traditionally use `--color` to mean "colorize this output",
> instead of "this value should be treated as a color".
>
> Currently, `git config` does not support this kind of colorization, but
> we should be careful to avoid inhabiting this option too soon, so that
> `git config` can support `--type=color` (in the traditional sense) in
> the future, if that is desired.
>
> In this patch, we prefer `--type=<int|bool|bool-or-int|...>` over
> `--int`, `--bool`, and etc. This allows the aforementioned upcoming
> patch to support querying a color value with a default via `--type=color
> --default=....`, without squandering `--color`.

Drop one of the periods in "...." if you happen to re-roll for some reason.

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -9,13 +9,13 @@ git-config - Get and set repository or global options
>  SYNOPSIS
>  --------
>  [verse]
> -'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
> +'git config' [<file-option>] [--type] [--show-origin] [-z|--null] name [value [value_regex]]

It's pretty confusing to see bare "--type" like this which makes it
seem as if it doesn't take an argument at all. Better would be
"[--type=<type>]".

> @@ -38,12 +38,13 @@ existing values that match the regexp are updated or unset.  If
> +The `--type` option requests 'git config' to ensure that the configured values
> +assosciated with the given variable(s) are of the given type. When given

s/assosciated/associated/

> +`--type`, 'git config' will convert the value to that type's canonical form.
> +ensure that the variable(s) are of the given type and convert the value to the
> +canonical form.

Meh, looks like some sort of editing botch here. I doubt you meant to
repeat "canonical form" like this.

> If no type specifier is passed, no checks or transformations are
> +performed on the value. Callers may unset any pre-existing type specifiers with
> +`--no-type`.
>
> +--no-type::
> +  Un-sets the previously set type specifier (if one was previously set). This
> +  option requests that 'git config' not canonicalize the retrieved variable.
> +  `--no-type` has no effect without `--type=<type>` or `--<type>`.

The final sentence doesn't really add value; I'd probably drop it as
extraneous. (Subjective, and not worth a re-roll.)

> diff --git a/builtin/config.c b/builtin/config.c
> @@ -61,6 +61,33 @@ static int show_origin;
> +static int option_parse_type(const struct option *opt, const char *arg,
> +                            int unset)
> +{
> +       [...]
> +       if (!strcmp(arg, "bool"))
> +               *type = TYPE_BOOL;
> +       else if (!strcmp(arg, "int"))
> +               *type = TYPE_INT;
> +       else if (!strcmp(arg, "bool-or-int"))
> +               *type = TYPE_BOOL_OR_INT;
> +       else if (!strcmp(arg, "path"))
> +               *type = TYPE_PATH;
> +       else if (!strcmp(arg, "expiry-date"))
> +               *type = TYPE_EXPIRY_DATE;
> +       else {
> +               die(_("unrecognized --type argument, %s"), arg);
> +               return 1;

Pointless unreachable 'return'.

> +       }
> +       return 0;
> +}
