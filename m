Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19F81F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbeDFGxr (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:53:47 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:40020 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeDFGxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:53:46 -0400
Received: by mail-qt0-f175.google.com with SMTP id g5so139095qth.7
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Iwhaz0Y/39D59hnAEol7yfY3ObaKACfrl7fTN54AkTk=;
        b=Kx0fyCXJAOI6Q4Ly0klHm1zosxxoQxxkmpBM87mell3Xi389+tmSi2VmdmKgnsNJRs
         u11DQOrpWmONbdsru/pXcXaihRNnTgaVld6v52Q/ERER02Mvto8+PEty9xkcSzKC7iLo
         prtWLYqte67wGUsGTGPuFffEDNMmTBOCOu9/9czdmtcnBE4LDQZpvsMph/a3BCfP/wWI
         2NQnbwTglis++NHSykqHAlSx1plzm793M5hrNLSknAfHv13N+TKkCFNdojLO13EeMuzg
         oNncJIWFG0RllrFvqtUA0qpc9EXmZh4JsU3hl9pdqjIICUEJIhzCYInbBLZ7pSZFbTXY
         6HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Iwhaz0Y/39D59hnAEol7yfY3ObaKACfrl7fTN54AkTk=;
        b=VRTb7TuASelI6rYJjQ4nDXmyZC/lR608qJV+T6+OxJB4pjiPv1SZJc7AaRZF5bc+UD
         f4un19WuJYJwsOcRH21nAuKjYcWA7UJ47QGZkmuQ6oxYiHOt03UqswUgpPE1xw/AH3xo
         F57yeXwdzopJH321ucoaajAty/pD/iIzM9IikLjQXj8pVt+9GH6mD7NS908JLTvJcb8e
         NGOg32wdjYeK+Mey2ieMn9/QsbpelBe+HAcvLJ90Vr/L1gjmbgkSoVppMWSraCbPCeFw
         48G6RWEhEYrCyx6Hwh8cBQLnownaszWgdmPhWiDCoAhkJDe5EEjRIvRmsxdidSU1BPv2
         W5Bw==
X-Gm-Message-State: ALQs6tCTYOuKMA2GZvygJVRVQ+MediGD84jhQHEiS9few6P+bzA+2pyf
        ljkufZTwPoUUJkiuV5JdvKtpa3UrJc0gMKLoYYnUBA==
X-Google-Smtp-Source: AIpwx49wsxnK1CdBT79vpZbk5b/tiKV+gIeqBjyHjAeDvN6OlM9UhFF/xE5Ne9SDoSxjq5Hd8uVe20btqVrOBn7aOb4=
X-Received: by 10.237.49.195 with SMTP id 61mr36103336qth.77.1522997625423;
 Thu, 05 Apr 2018 23:53:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 23:53:45 -0700 (PDT)
In-Reply-To: <20180406063013.GB662@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com> <cover.1522996150.git.me@ttaylorr.com>
 <20180406063013.GB662@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 02:53:45 -0400
X-Google-Sender-Auth: RWq_ELo4z1_DfcgaXNPuxy96nLc
Message-ID: <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> This commit (and those following it in this series) aim to eventually
> replace `--get-color` with a consistent alternative. By introducing
> `--default`, we allow the `--get-color` action to be promoted to a
> `--type=color` type specifier, retaining the "fallback" behavior via the
> `--default` flag introduced in this commit.
>
> For example, we aim to replace:
>
>   $ git config --get-color variable [default] [...]
>
> with:
>
>   $ git config --default default --type=color variable [...]
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/builtin/config.c b/builtin/config.c
> @@ -286,6 +288,16 @@ static int get_value(const char *key_, const char *regex_)
> +       if (!values.nr && default_value) {
> +               struct strbuf *item;
> +               ALLOC_GROW(values.items, values.nr + 1, values.alloc);
> +               item = &values.items[values.nr++];
> +               strbuf_init(item, 0);
> +               if (format_config(item, key_, default_value) < 0) {
> +                       die(_("failed to format default config value"));
> +               }

Unnecessary braces.

Also, an error message such as this is typically more helpful when it
shows the item which caused the problem:

    die(_("failed to format default config value: %s"), default_value);

However, since the message already says "default", it's pretty easy to
understand that it's talking about the argument to --default, so it's
perhaps not such a big deal in this case.

Anyhow, neither point is worth a re-roll.

> +       }
> @@ -624,6 +636,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                 usage_with_options(builtin_config_usage, builtin_config_options);
>         }
>
> +

Unnecessary new blank line.

> +       if (default_value && !(actions & ACTION_GET)) {
> +               error("--default is only applicable to --get");
> +               usage_with_options(builtin_config_usage,
> +                       builtin_config_options);
> +       }
> diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
> @@ -0,0 +1,38 @@
> +test_expect_success 'uses --default when missing entry' '
> +       echo quux >expect &&
> +       git config -f config --default quux core.foo >actual &&
> +       test_cmp expect actual
> +'
>
> +test_expect_success 'canonicalizes --default with appropriate type' '
> +       echo true >expect &&
> +       git config -f config --default=true --bool core.foo >actual &&
> +       test_cmp expect actual
> +'

I would trust this canonicalization test a lot more if it used one of
the aliases for "true" since it doesn't presently prove that
canonicalization is taking place. For instance:

    git config -f config --default=yes --bool core.foo >actual &&

> +test_expect_success 'uses entry when available' '
> +       echo bar >expect &&
> +       git config --add core.foo bar &&
> +       git config --default baz core.foo >actual &&
> +       git config --unset core.foo &&
> +       test_cmp expect actual
> +'

If you happen to re-roll, can we move this test so it immediately
follows the "uses --default when missing entry" test? That's where I
had expected to find it and had even written a review comment saying
so (but deleted the comment once I got down to this spot in the
patch). Also, perhaps rename the test to make it clearer that it
complements the "uses --default when missing entry" test; perhaps
"does not fallback to --default when entry present" or something.

> +test_expect_success 'dies when --default cannot be parsed' '
> +       test_must_fail git config -f config --type=expiry-date --default=x --get \
> +               not.a.section 2>error &&
> +       test_i18ngrep "failed to format default config value" error
> +'
> +
> +test_expect_success 'does not allow --default without --get' '
> +       test_must_fail git config --default=quux --unset a.section >output 2>&1 &&
> +       test_i18ngrep "\-\-default is only applicable to" output
> +'
