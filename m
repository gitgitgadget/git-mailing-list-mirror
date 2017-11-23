Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305DD202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 19:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbdKWTYY (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 14:24:24 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:39658 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbdKWTYY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 14:24:24 -0500
Received: by mail-qk0-f182.google.com with SMTP id w125so22110736qkb.6
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LXUhrgikMCat4ghrDl9Cu6wSn49+8pTnvjtyfGFeQQI=;
        b=gEZcsxUH1szQHzIYvW/n3vMWo19q+vM/M4NdVNUGf3bvUa0Wn9DW0tMp2F9BTbU259
         FMlGAWYpNRdHccOMzlcyri6L94jQTYgYfzg/mTgTltwBNindieQW6pVY92FRKqEiErG/
         2/OE5+V+WtAcqydDrhtg4INX1LO+cmL8ZC/1g3MNgKGPSo85VdeRSVM+xOnLQj3hfVEK
         UqaK7F3cv7VTa1cWIjH3tUjT0awusyfcc5uBjYDVo9E9HWtDeG10p9RGzYkAOfesjOPX
         Zsd+3TeQm22qSN10hzs6kJxcRlZPhALk+lx+XM5xylc7Up8yToWzj1ULoKkA4f2jg42B
         HZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LXUhrgikMCat4ghrDl9Cu6wSn49+8pTnvjtyfGFeQQI=;
        b=M5dR6effnGausY6BVJF2TCYQTWwP5ZScXls+PZDQYrucFZIuY7vZX9rV4qN7zqZ9B/
         +eeX0wWQB+27glS7GqTXRzQe2oBy/4vqVel5Z923Sneh4bUubHRyQ/rt+xM8+6PkuZCO
         H2ltCrDqWCv+lQnBRVzBG7+cWVrJ2ZFSzh2SNdEIaTRyyeb/m8Cn+wCj2iw5hnAqlqb+
         b+LXMHkpoMzWQwjXxurFXNe4lTsV+LcF0tm2gzbCqtKm6sVMVzfSuEzCekhM1X90TNzu
         FM5pdiQ26p1AovmEtnNh8RpO6ML35MiF2OX+ENM+ubTq/afGTAsksRlAmaexlIAkdOXe
         voCA==
X-Gm-Message-State: AJaThX5Z+otEmAYajv8PZ+gqldLGRM82TI63EWaHJXMdfLIoGZRaeyfa
        TjmAWxgVlf/h/nCZN2Ef+mwAJQeqI76A4gNP34L5EA==
X-Google-Smtp-Source: AGs4zMboKSG37LI1DTzmRgcIJNlFCsJVT3rpgYM/aPi1JqPMb6aMXV5tHjNht6c9pqg6nQQ6JSZeDPUw05y9w7leLkA=
X-Received: by 10.55.97.209 with SMTP id v200mr41270440qkb.71.1511465063274;
 Thu, 23 Nov 2017 11:24:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Thu, 23 Nov 2017 11:24:22 -0800 (PST)
In-Reply-To: <20171123154159.17408-1-maruel@chromium.org>
References: <20171123154159.17408-1-maruel@chromium.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Nov 2017 14:24:22 -0500
X-Google-Sender-Auth: WKuTilfOA06elDcdVH56C1TBvUI
Message-ID: <CAPig+cS1TFsLtmQFhHVg9U5_FrFzbfDX5N7ZrM=aXjaz1VTAgw@mail.gmail.com>
Subject: Re: [PATCH] grep: Add option --max-line-len
To:     Marc-Antoine Ruel <maruel@chromium.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 10:41 AM, Marc-Antoine Ruel <maruel@chromium.org> wrote:
> This tells git grep to skip files longer than a specified length,

s/files/lines/

> which is often the result of generators and not actual source files.
>
> Signed-off-by: Marc-Antoine Ruel <maruel@chromium.org>
> ---
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> @@ -127,6 +128,10 @@ OPTIONS
> +-M<num>::
> +--max-line-len<num>::
> +       Match the pattern only for line shorter or equal to this length.

This documentation doesn't explain what it means by a line's length.
This implementation seems to take into consideration only the line's
byte count, however, given that displayed lines are normally
tab-expanded, people might intuitively expect that expansion to count
toward the length. A similar question arises for Unicode characters.

Should this option take tab-expansion and Unicode into account?
Regardless of the answer to that question, the documentation should
make it clear what "line length" means.

> diff --git a/builtin/grep.c b/builtin/grep.c
> @@ -796,6 +796,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                         N_("case insensitive matching")),
>                 OPT_BOOL('w', "word-regexp", &opt.word_regexp,
>                         N_("match patterns only at word boundaries")),
> +               OPT_INTEGER('M', "max-line-len", &opt.max_line_length,
> +                       N_("ignore lines longer than <n>")),

On this project, it is typical to have only the long form of an option
name when the option is first implemented so as not to squat on one of
the relatively limited number of short option names. Only after it is
seen that an option is popular, does it get a short name. Whether this
actually matters in this case, I don't know, but is something to take
into consideration.

Why the choice of 'M'? Is there precedence in other Git or Unix
commands for that name over, say, 'N' or
<choose-your-favorite-letter>? Is 'M' is for "max"? If so, what would
a short name for --max-depth be (if it ever got one)? (These are
somewhat rhetorical questions, but I'm interested in the answers if
you have any.)

> diff --git a/grep.c b/grep.c
> @@ -1273,6 +1275,8 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
> +       if (opt->max_line_length > 0 && eol-bol > opt->max_line_length)
> +               return 0;

If the user specifies "-M0", should that error out or at least warn
the user that the value is non-sensical? What about -1, etc.? (These
are UX-related questions; the implementation obviously doesn't care
one way or the other.)

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> @@ -766,6 +766,11 @@ test_expect_success 'grep -W shows no trailing empty lines' '
> +test_expect_success 'grep skips long lines' '
> +       git grep -M18 -W include >actual &&
> +       test_cmp expected actual
> +'

Meh, what is this actually testing? The output of "git grep -M18 -W
include" is no different that the output of "git grep -W include" in
the test just above this one. And, why is -W in this test at all? Its
presence confuses the reader into thinking that it is somehow
significant. I would have expected this test to look like this:

    cat >expected <<-\EOF
    hello.c:#include <stdio.h>
    EOF

    test_expect_success 'grep -M skips long lines' '
        git grep -M18 include >actual &&
        test_cmp expected actual
    '
