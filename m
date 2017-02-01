Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 594391F6BD
	for <e@80x24.org>; Wed,  1 Feb 2017 01:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdBABTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 20:19:25 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35145 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdBABTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 20:19:24 -0500
Received: by mail-lf0-f67.google.com with SMTP id v186so35280971lfa.2
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 17:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PbBpt6lu8T44xirw72JnJrQAg11AOOav9u7OD6ur4nE=;
        b=Sp3ax2uL85vG49j0fP1lcflzORLuMCbjgHXA1b48YFiH1XAGAO+SR7plhwqBfZcL6+
         BbNUk6l6cgSqkSm40Aj6JYsAETZIAG8Mut6/OrdR9yG18bAtN7hGloBfYVfPYw9Rytja
         t4sAV4xJ7RodwKxmqs/i+sYL4wLXJqlyJ9G3zVmc8LupXd+YuKEu7YOgUzPyLLQkRW6x
         u229lcGnmzWfzBzJSZfMEnX2UqwMadWgpawqOUsGNlv9Ws7V94v2vB0irZQmTM6eo3AO
         YAUKqRUufGq7FP6IB4NNEA/k5KwK1iyXhJ3TN4lgBrTIXM1aA2qhYnUhbm1zWqpdgTPF
         Wz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PbBpt6lu8T44xirw72JnJrQAg11AOOav9u7OD6ur4nE=;
        b=Eg94qCN+4ySIvQMqJoPFJthQh09oPYTwhRvQ0gXeZAYciKUc84/+kfQf2thfJ0WXVD
         H3ogIaDheB3dDW1MvmieqXI3KL6S2JDrUvwv0oPCB4VMJip9dqeHFbtleOuLu65xgZ/L
         yicIXflyjV/6sqhEDhb+ycUqCZqaHtjO5KVXNGpkhXGLL7iToREAmUewPZHPVGa6Y+ea
         BdtRFtIAe18+ZUFp2vsUtA+zUK5OWssY/rkyPnjhV189mINnaveA8YBHmD4sPG//vxXt
         0zG+EJhciohqnQeMJUPwEsifcrL9TGoXkDoxZTOdUKeVv603QphfflqzG1uPna9UAwP0
         9++g==
X-Gm-Message-State: AIkVDXICjkWeYsYca53alDSv8Y8CG5YhMwNJLXIm3g+A98iaJEytuUOBy7jXV+vgv5zMFlDHLGMumbwaxlv8ng==
X-Received: by 10.46.69.215 with SMTP id s206mr104797lja.26.1485911962677;
 Tue, 31 Jan 2017 17:19:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Tue, 31 Jan 2017 17:19:02 -0800 (PST)
In-Reply-To: <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com> <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 31 Jan 2017 17:19:02 -0800
Message-ID: <CA+P7+xqT-3_quCwtTya++Zew6y8pSGL2WTTvpGMwKM257w4Vng@mail.gmail.com>
Subject: Re: [PATCH] color_parse_mem: allow empty color spec
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 31, 2017 at 4:21 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 31, 2017 at 02:45:40PM -0800, Junio C Hamano wrote:
>
>> * nd/log-graph-configurable-colors (2017-01-23) 3 commits
>>   (merged to 'next' on 2017-01-23 at c369982ad8)
>>  + log --graph: customize the graph lines with config log.graphColors
>>  + color.c: trim leading spaces in color_parse_mem()
>>  + color.c: fix color_parse_mem() with value_len == 0
>>
>>  Some people feel the default set of colors used by "git log --graph"
>>  rather limiting.  A mechanism to customize the set of colors has
>>  been introduced.
>>
>>  Reported to break "add -p".
>>  cf. <20170128040709.tqx4u45ktgpkbfm4@sigill.intra.peff.net>
>
> I hadn't heard anything back, so I wrapped up my fix with a commit
> message and tests (it needs to go on top anyway, since the breakage is
> in 'next').
>

I was just about to report this breakage... It definitely breaks usage
of git-add-interactive..

> -- >8 --
> Subject: [PATCH] color_parse_mem: allow empty color spec
>
> Prior to c2f41bf52 (color.c: fix color_parse_mem() with
> value_len == 0, 2017-01-19), the empty string was
> interpreted as a color "reset". This was an accidental
> outcome, and that commit turned it into an error.
>
> However, scripts may pass the empty string as a default
> value to "git config --get-color" to disable color when the
> value is not defined. The git-add--interactive script does
> this. As a result, the script is unusable since c2f41bf52
> unless you have color.diff.plain defined (if it is defined,
> then we don't parse the empty default at all).
>
> Our test scripts didn't notice the recent breakage because
> they run without a terminal, and thus without color. They
> never hit this code path at all. And nobody noticed the
> original buggy "reset" behavior, because it was effectively
> a noop.
>
> Let's fix the code to have an empty color name produce an
> empty sequence of color codes. The tests need a few fixups:
>
>   - we'll add a new test in t4026 to cover this case. But
>     note that we need to tweak the color() helper. While
>     we're there, let's factor out the literal ANSI ESC
>     character. Otherwise it makes the diff quite hard to
>     read.
>
>   - we'll add a basic sanity-check in t4026 that "git add
>     -p" works at all when color is enabled. That would have
>     caught this bug, as well as any others that are specific
>     to the color code paths.
>
>   - 73c727d69 (log --graph: customize the graph lines with
>     config log.graphColors, 2017-01-19) added a test to
>     t4202 that checks some "invalid" graph color config.
>     Since ",, blue" before yielded only "blue" as valid, and
>     now yields "empty, empty, blue", we don't match the
>     expected output.
>
>     One way to fix this would be to change the expectation
>     to the empty color strings. But that makes the test much
>     less interesting, since we show only two graph lines,
>     both of which would be colorless.
>
>     Since the empty-string case is now covered by t4026,
>     let's remove them entirely here. They're just in the way
>     of the primary thing the test is supposed to be
>     checking.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

The patch looks good to me. Very nice to have a detailed explanation
of why we didn't catch it before, and how to ensure we don't have this
happen again.

Thanks,
Jake

>  color.c                    |  6 ++++--
>  t/t3701-add-interactive.sh | 14 ++++++++++++++
>  t/t4026-color.sh           |  7 ++++++-
>  t/t4202-log.sh             |  2 +-
>  4 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/color.c b/color.c
> index 7bb4a96f8..2925a819b 100644
> --- a/color.c
> +++ b/color.c
> @@ -212,8 +212,10 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>                 len--;
>         }
>
> -       if (!len)
> -               return -1;
> +       if (!len) {
> +               dst[0] = '\0';
> +               return 0;
> +       }
>
>         if (!strncasecmp(ptr, "reset", len)) {
>                 xsnprintf(dst, end - dst, GIT_COLOR_RESET);
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index deae948c7..5ffe78e92 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -380,4 +380,18 @@ test_expect_success 'patch mode ignores unmerged entries' '
>         test_cmp expected diff
>  '
>
> +test_expect_success 'diffs can be colorized' '
> +       git reset --hard &&
> +
> +       # force color even though the test script has no terminal
> +       test_config color.ui always &&
> +
> +       echo content >test &&
> +       printf y | git add -p >output 2>&1 &&
> +
> +       # We do not want to depend on the exact coloring scheme
> +       # git uses for diffs, so just check that we saw some kind of color.
> +       grep "$(printf "\\033")" output
> +'
> +
>  test_done
> diff --git a/t/t4026-color.sh b/t/t4026-color.sh
> index ec78c5e3a..671e951ee 100755
> --- a/t/t4026-color.sh
> +++ b/t/t4026-color.sh
> @@ -6,10 +6,11 @@
>  test_description='Test diff/status color escape codes'
>  . ./test-lib.sh
>
> +ESC=$(printf '\033')
>  color()
>  {
>         actual=$(git config --get-color no.such.slot "$1") &&
> -       test "$actual" = " $2"
> +       test "$actual" = "${2:+$ESC}$2"
>  }
>
>  invalid_color()
> @@ -21,6 +22,10 @@ test_expect_success 'reset' '
>         color "reset" "[m"
>  '
>
> +test_expect_success 'empty color is empty' '
> +       color "" ""
> +'
> +
>  test_expect_success 'attribute before color name' '
>         color "bold red" "[1;31m"
>  '
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 0aeabed96..1edbb1e7f 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -329,7 +329,7 @@ cat > expect.colors <<\EOF
>  EOF
>
>  test_expect_success 'log --graph with merge with log.graphColors' '
> -       test_config log.graphColors ",, blue,invalid-color, cyan, red  , " &&
> +       test_config log.graphColors " blue,invalid-color, cyan, red  , " &&
>         git log --color=always --graph --date-order --pretty=tformat:%s |
>                 test_decode_color | sed "s/ *\$//" >actual &&
>         test_cmp expect.colors actual
> --
> 2.11.0.948.gca97da533
>
