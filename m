Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C671F404
	for <e@80x24.org>; Thu,  5 Apr 2018 22:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeDEW3U (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 18:29:20 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32801 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDEW3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 18:29:19 -0400
Received: by mail-qk0-f174.google.com with SMTP id d206so28123843qkb.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RLUDDDmzgJOAPdPckEl57breM0e8Y4ByPxIEQZHIb0U=;
        b=lt0KwfXGTs2QYeNqVVP11CqdHMt+cnbiOLVK4F22o5hds1Aqlafiktsgty5R7Nr4LE
         6rp9ZifU0NZGzwXrO/L/nWjbhJj5de1Q+yigKQ81O/v9XlAxfwrjwknwHYeQN/LpFKaX
         fn0fBliwFn1/3LFM9aOBfhztzLIjGmZVmrMqLyoyagRSkVVpnerhOtOT0NkrIuv0vcpr
         jplvJitCjXdXfhiRJw4LyJ6gz8V3nF6e5bB7PtDw8aVVS4Ic8pI6annin2ced3588RXp
         FEwVMmkivIvp4DpbJrmjvQBm+zSWLu5Ffp7yw5EYInE7HQkquv1iYySqIF54DywGgumO
         IwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RLUDDDmzgJOAPdPckEl57breM0e8Y4ByPxIEQZHIb0U=;
        b=fyBCjudgZCDSN7ienc9ZfAnPoEgBdL4ZcjBscoJKwmgNbO7VjvhevX+DseVpiK+xKw
         UAp35l7rUJDu1WvS0SZfAQhPOcgWapZXdXbvDKOK9UPqEN5H0seTDEv0mDxH5V0vd4ad
         8vBt42r9PLFPYm313SULhIMUkq21gH7sr7HFxT819ySzdnAHzYFqNmx8hC2fPcyA04ej
         PVPQLT/jl5wEeCc1G58xcOJi9DHXrOeF3cvwzA/Gwaw9+zfntCoe6TEZjavR4J55jvXH
         noff8cGoksTWTUFsGw64TWysCAHZQWedT+TajO/A4YxRQFiQx2QbeMtY/aUjB3sCnmCO
         N0/g==
X-Gm-Message-State: ALQs6tAgPMrdqLi85CQ2PHaOFeWM8iOGmtw0S9u3VCPOE42N3fqTwpLi
        efRHH4JXStmefVxz+CMf3fsQ34JXWGrbNMJhXhw=
X-Google-Smtp-Source: AIpwx48OvKgviOZuDIGJDOHEHr+vhrU9evEhapNC15fj9H54z+9DhPEJ7dr9qszAKI4Hn+NnpXdak3heRX4lrryS5NI=
X-Received: by 10.55.108.69 with SMTP id h66mr32315269qkc.42.1522967359117;
 Thu, 05 Apr 2018 15:29:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Thu, 5 Apr 2018 15:29:18 -0700 (PDT)
In-Reply-To: <20180405020040.GC8879@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com> <cover.1522893363.git.me@ttaylorr.com>
 <20180405020040.GC8879@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 5 Apr 2018 18:29:18 -0400
X-Google-Sender-Auth: W_-lDqi-Mg9Zx7XBY1c6zkxeP98
Message-ID: <CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 10:00 PM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
> `--int`, `--bool`, and etc. This allows the aforementioned upcoming
> patch to support querying a color value with a default via `--type=color
> --default=....`
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -38,12 +38,10 @@ existing values that match the regexp are updated or unset.  If
> +A type specifier may be given as an argument to `--type` to make 'git config'

In [1], you said that the argument to --type is required, so use of
"may be given" here is ambiguous; it makes it sound as if the argument
is optional. Perhaps rewrite something like:

    The --type option requests `git config` to ...

Not necessarily worth a re-roll, though. (But if you do need to
re-roll for some reason, it might make sense to combine this series
with the --default series to make it slightly easier to review them
together -- since the one depends upon the other -- and probably ease
the burden on Junio slightly.)

> +ensure that the variable(s) are of the given type and convert the value to the
> +canonical form. If no type specifier is passed, no checks or transformations are
> +performed on the value.
> @@ -160,30 +158,34 @@ See also <<FILES>>.
>  --list::
>         List all variables set in config file, along with their values.
>
> ---bool::
> -       'git config' will ensure that the output is "true" or "false"
> +--type <type>::
> +  'git config' will ensure that any input output is valid under the given type
> +  constraint(s), and will canonicalize outgoing values in `<type>`'s canonical
> +  form.

In response to my question[2] about whether the typesetting "[type]"
meant that it was optional, you responded[1] that it was not, thus
correctly changed the typesetting to "<type>". However...

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> @@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
> +test_expect_success '--no-type unsets type specifiers' '
> +       echo "10" > expect &&
> +       git config --type=bool --no-type core.number >actual &&
> +       test_cmp expect actual
> +'

What does --no-type mean and why is it being tested? If this is an
explicitly supported user-facing option, should it be documented? If
it's not meant to be user-facing, then why are we enforcing its
presence and behavior via a test?

[1]: https://public-inbox.org/git/20180405014758.GA4671@syl.local/
[2]: https://public-inbox.org/git/CAPig+cR4uFiC_gFsb2e9JR6SdP-wUQVz-E0MjRHR=vNHd+hvhA@mail.gmail.com/
