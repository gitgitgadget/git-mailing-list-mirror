Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD9221841
	for <e@80x24.org>; Tue,  1 May 2018 11:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeEALA7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:00:59 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36597 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeEALA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:00:57 -0400
Received: by mail-wm0-f50.google.com with SMTP id n10so18456370wmc.1
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Vn4sBhpN2NL0ARs8Y2+KKNOVBYvP7X9TWDQDFQ/QQaM=;
        b=KKPdOSBIQZxNQjygWlC1gy2CJpwcjBC1HSlIJNugE1BU8NoyJvNTPICbjVnCSKFwHI
         QXtRY39FlY2SG+1j1UzSoFuysasLHonCN38HwjgAR3+H6x4lZMpZ2KHmohEsuuVuuKGL
         4DXghFN3rEQYVHK7F0V8vZhTFy7d9F0aSxwiGBoI+ijn/VcU4mbf/9lda4H8dKQ77ZE/
         b8rmyjA296IqJo+sy3ngcLucPU4uJPUpbgoOkEpHT05VlNXLV7PKaEVKNpy8pGFuiTFB
         S1yAXEoxp5Skd75GBwl30IeykvHXwm/nqbV4wIHM2mo86JMtlQVuqKs7WrDmAUWDPRSd
         DsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Vn4sBhpN2NL0ARs8Y2+KKNOVBYvP7X9TWDQDFQ/QQaM=;
        b=DrzZbqmm4zT40uZkwIHe6zrQVa8crosl+Ef2JvmCFKFVVy5O+yYl7AP7OH1ZQJH1pa
         Uw5UyI23UrkUIW1VnHFaIWRBw49McWPK4H/yVWqNsxNCrF0rdmAa0xlRyXLHKKDt7pv9
         mjghoh9s8ZUvn6CWL8A3Ww5OHas6R0tIyw6+Wm7bPu+kvglrYrboMu53okG6d1QNQHHU
         cWUCO9So+zeYra+A0PQuKV+8Dp0eNWakLg04BDbHTx++r+NECePFo26yuPryRc1FvKO3
         TQ8bNT0rT/MIAF+7Qp3X1QxaAiCzjNuXYKBcA6YkZcH8GWGCIJ4bjUGkL2fwROm6CfUt
         utZw==
X-Gm-Message-State: ALQs6tDW5pSXoTJ+fENiCYeBIctFj1W44phLHk4ynR9waQLo4d+yzR6u
        Ry2pQQBJLMNqLlFBT2BerDo=
X-Google-Smtp-Source: AB8JxZo6JoSLW/HwRp9n7P9C0rRzRtR/O7mZ/XX8D8vZPx7z8jO+03dQwR2cfGG5Tn2VrQ3ul7PUHw==
X-Received: by 2002:a50:8f65:: with SMTP id 92-v6mr20556087edy.287.1525172456632;
        Tue, 01 May 2018 04:00:56 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id d18-v6sm5774720edb.97.2018.05.01.04.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 04:00:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Subject: Re: [PATCH v2] wt-status: use rename settings from init_diff_ui_defaults
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com> <20180501094940.17772-1-eckhard.s.maass@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180501094940.17772-1-eckhard.s.maass@gmail.com>
Date:   Tue, 01 May 2018 13:00:54 +0200
Message-ID: <87bmdzzlll.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Eckhard S. Maaß wrote:

> Since the very beginning, git status behaved differently for rename
> detection than other rename aware commands like git log or git show as
> it has the use of rename hard coded into it.


Can you elaborate on this? It seems initial rename detection was added
in 5c97558c9a ("[PATCH] Detect renames in diff family.", 2005-05-19) and
the first version of the status script added by Linus in a3e870f2e2
("Add "commit" helper script", 2005-05-30), and that one piggy-backs on
"diff" for rename detection.

So didn't we use diff heuristics to begin with, and then regressed? I've
only given this a skimming, but it's useful to have that sort of
historical context mentioned explicitly with commit ids.

> After 5404c116aa ("diff:
> activate diff.renames by default", 2016-02-25) the default behaves the
> same by coincidence, but a work flow like
>
>     - git add .
>     - git status
>     - git commit
>     - git show
>
> should give you the same information on renames (and/or copies if
> activated) accordingly to the diff.renames and diff.renameLimit setting.
>
> With this commit the hard coded settings are dropped from the status
> command.

It's unclear to me what this means, so the only difference between
"status" and "diff" is that the former had a hardcoded limit of 200? In
that case it was added at 100 (later adusted) in 0024a54923 ("Fix the
rename detection limit checking", 2007-09-14), so not since "the very
beginning...".

> Signed-off-by: Eckhard S. Maaß <eckhard.s.maass@gmail.com>
> Reviewed-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/commit.c       |  2 +-
>  t/t4001-diff-rename.sh | 12 ++++++++++++
>  wt-status.c            |  4 ----
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 5571d4a3e2..5240f11225 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -161,9 +161,9 @@ static void determine_whence(struct wt_status *s)
>  static void status_init_config(struct wt_status *s, config_fn_t fn)
>  {
>  	wt_status_prepare(s);
> +	init_diff_ui_defaults();
>  	git_config(fn, s);
>  	determine_whence(s);
> -	init_diff_ui_defaults();
>  	s->hints = advice_status_hints; /* must come after git_config() */
>  }
>
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index a07816d560..bf4030371a 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -138,6 +138,18 @@ test_expect_success 'favour same basenames over different ones' '
>  	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
>  '
>
> +test_expect_success 'test diff.renames=true for git status' '
> +	git -c diff.renames=true status >out &&
> +	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
> +'
> +
> +test_expect_success 'test diff.renames=false for git status' '
> +	git -c diff.renames=false status >out &&
> +	test_i18ngrep ! "renamed: .*path1 -> subdir/path1" out &&
> +	test_i18ngrep "new file: .*subdir/path1" out &&
> +	test_i18ngrep "deleted: .*[^/]path1" out
> +'
> +
>  test_expect_success 'favour same basenames even with minor differences' '
>  	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
>  	git status >out &&
> diff --git a/wt-status.c b/wt-status.c
> index 50815e5faf..32f3bcaebd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -625,9 +625,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>  	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>  	rev.diffopt.format_callback = wt_status_collect_updated_cb;
>  	rev.diffopt.format_callback_data = s;
> -	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
> -	rev.diffopt.rename_limit = 200;
> -	rev.diffopt.break_opt = 0;
>  	copy_pathspec(&rev.prune_data, &s->pathspec);
>  	run_diff_index(&rev, 1);
>  }
> @@ -985,7 +982,6 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>  	setup_revisions(0, NULL, &rev, &opt);
>
>  	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
> -	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
>  	rev.diffopt.file = s->fp;
>  	rev.diffopt.close_file = 0;
>  	/*
