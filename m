Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5B21F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeDVXPB (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:15:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37382 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753647AbeDVXPA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:15:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id w12-v6so15734233qti.4
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GPIZTQz8rGOAynnI4z467M0DNrkLvLKQbWAIPgAvT88=;
        b=HXtJMGNqy4VCBpLhpZTTM2KLnEmFllo2edOt9UglZw1cgrpC5+UI+ilMqmjurdLaP0
         Fj0pQjHziDuTes6/q468Ad/+HsFmmk85YkUZpwNKiYQ3Gd7wsSPDip2CwAWZNBjFq1PZ
         OI5of5PduV+d7zEFyI9wLons5YtTjajbI9BXXwh1qzpNIhsjwIpYYzHuK5AcUKlnA95g
         pVwcc9LyJXg/yVa0456QMxpfQnlQX2mFNdq0psLWLeH2CRa1GlddEkj4+zHJ+t3UWL0M
         8tM3M5/J/8a5TY7NJ4RIAgmcxewca+4owLukXSV1Ul1i8HwmP9wW131sgTU4j3oXzf8R
         fd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GPIZTQz8rGOAynnI4z467M0DNrkLvLKQbWAIPgAvT88=;
        b=TuK9kKPM0XsejErMWYDViUYlUxyQq4axrmwAWtG+xPerFF81AFTz1gglUXjqAoe4f+
         UJSIivFkd99NgGT0k39m9BuVyEMk7VQMEDAT3DoRHOy464oXoDgdxrvyntiNS6/XuzVn
         D+rsNjn9h8eouZ3SIboxYmeFlYMrUNflYlP9Krz+IAFQTOyFzn2mQlRT2QkMQJF0u/XD
         sOlBIOS/DNClgvFleVkobUrHlu2jRipoWR1oD8CFytSyOpiGQOeMPBuQ4C9c+do6Xf0m
         DFV1kbV8wBChvg6kLp+4uFJ6E1r4lSaBObc51+tv6oYVWYayIduJM/EpDYeI3kcwBFwf
         gedQ==
X-Gm-Message-State: ALQs6tAV7TBbeLCfASoa1GMi8Ogx5gODUGtFnSSwNigbXHjMWvs3rxu3
        FLY723gOAh5vip9KgLnfzJXFxQ2uCFs5/4rQwdU=
X-Google-Smtp-Source: AB8JxZrrEbDyeN1vY8w9RguB1qa4+PlRt6p5ZgNTuP9ZSQJIqaioIwOQ8dw/zb45pY3ynCqdAwsKcHSn7kyDKQgxUBA=
X-Received: by 2002:ac8:17d1:: with SMTP id r17-v6mr20418292qtk.314.1524438899492;
 Sun, 22 Apr 2018 16:14:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 16:14:58 -0700 (PDT)
In-Reply-To: <73eb315b1f9daa518405c3ab1b28087c38f27ce5.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <73eb315b1f9daa518405c3ab1b28087c38f27ce5.1524429778.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 19:14:58 -0400
X-Google-Sender-Auth: NJMRrqUfwJsdGTDynpsqaVXYekA
Message-ID: <CAPig+cRfCZQ8aPvc6AVoojtpuiWgNS_9A+9m5mV2mOC1BwemQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] grep.c: take regmatch_t as argument in match_line()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 4:47 PM, Taylor Blau <me@ttaylorr.com> wrote:
> In a subsequent patch, we teach show_line() to optionally include the
> column number of the first match on each matched line.
>
> The regmatch_t involved in match_line() and match_one_pattern() both
> contain this information (via regmatch_t->rm_so), but their current
> implementation throws this stack variable away at the end of the call.
>
> Instead, let's teach match_line() to take in a 'regmatch_t *' so that
> callers can inspect the result of their calls. This will prove useful in
> a subsequent commit when a caller will forward on information from the
> regmatch_t into show_line (as described above).
>
> The return condition remains unchanged, therefore the only change
> required of callers is the addition of a single argument.

Is 'rm_so' the only piece of information which callers will ever want
to extract from 'regmatch_t'? If so, this patch's approach might be
overly broad, unnecessarily exposing too much of match_lines()'s
internal implementation. An alternative would be to narrow the
interface and limit exposure by passing in an 'int *matched_col' or
some such.

(Not necessarily a big deal, but something to consider.)

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/grep.c b/grep.c
> @@ -1299,17 +1299,17 @@ static int match_expr(struct grep_opt *opt, char *bol, char *eol,
>  static int match_line(struct grep_opt *opt, char *bol, char *eol,
> -                     enum grep_context ctx, int collect_hits)
> +                     regmatch_t *match, enum grep_context ctx,
> +                     int collect_hits)
>  {
>         struct grep_pat *p;
> -       regmatch_t match;
>
>         if (opt->extended)
>                 return match_expr(opt, bol, eol, ctx, collect_hits);

The new 'match' argument has no impact in the 'opt->extended' case.
Perhaps this deserves calling out in the commit message.

>         /* we do not call with collect_hits without being extended */
>         for (p = opt->pattern_list; p; p = p->next) {
> -               if (match_one_pattern(p, bol, eol, ctx, &match, 0))
> +               if (match_one_pattern(p, bol, eol, ctx, match, 0))
>                         return 1;
>         }
>         return 0;
