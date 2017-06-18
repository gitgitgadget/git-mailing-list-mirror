Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32BE220D0C
	for <e@80x24.org>; Sun, 18 Jun 2017 08:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdFRIfE (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 04:35:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36135 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdFRIfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 04:35:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id d17so11855624wme.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5ovQBRzrpVL1/3qVFdFK9SIsu229icUjGpn4HlBiPP8=;
        b=dvNGUhP9sB0MhSmQGzE7P97AughtJBIkvqX3gbqzXO7ZXbKvPFxNgoG2hz/DG8tz6K
         OzHG2taJEuaBMhcCcZE/9UEeD1Brlju7UyozZOQ67Ng22GE8L7BbK9gk5TukPlgfWkUJ
         VFuL5a186MOckxTpUkCorpMQNcSamRJu1C8YB7MBkF/2AR8eK7l3vBEziWHpNpIJH5jJ
         SI9VcYkBKx4xxezQmdyr8O5NoICK83NHPBTpoDFicFDqEjxQ7tQeyeXGPpXafeT7UMB2
         VjmQzUWL2IxNUNx2/ji9wmmcF38f5fpkQasnJrOliZtzUOlqhxHRqrKgSAWYwVSgWZLF
         1/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5ovQBRzrpVL1/3qVFdFK9SIsu229icUjGpn4HlBiPP8=;
        b=Nj+4AbVGtkKeo094dL0tuPFWKOgj2W8MNkg/lC21Nmtrdcq+/at7fjUfJ5IllbwmwA
         DID4Y2weO6Um0OBKzeQ7p9rCkcvWjbzGdDTGYs7lbxbDUG/u70T1OfaZpHoY0r1vunO/
         eQQpggIjMze5ahKozt3mw0aS3W9gHZ1RRQYX9Mn11ohfHCEPUyNNX1647E97p+ELjXDV
         zO7zhTWJX4CABtdfQM8EjZLBi8rLosIqX2Lgit7FOb/RoFcRXQPs06AhSg8JN6MhYm9M
         2/bleQ0PbYvExVeA4gh4ywjZeE+H0F6f83oJ8clVuu9vp80Z7ABRv88CuiZ5rQcdUxrW
         36FA==
X-Gm-Message-State: AKS2vOz+qHan23eEraQPECjKL3wjTJITRuE1tiH60kVw6oZgeACIh3nT
        rm5r89aBkLh5iQ==
X-Received: by 10.80.131.6 with SMTP id 6mr12985497edh.178.1497774900975;
        Sun, 18 Jun 2017 01:35:00 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id x18sm3852039eda.39.2017.06.18.01.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 01:34:59 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dMVff-0000vb-Du; Sun, 18 Jun 2017 10:34:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH/ALMOST FINAL] Contextually notify user about an initial commit
References: <1497771338.1689.4.camel@gmail.com> <20170618075301.6431-1-kaarticsivaraam91196@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170618075301.6431-1-kaarticsivaraam91196@gmail.com>
Date:   Sun, 18 Jun 2017 10:34:59 +0200
Message-ID: <87shix8zik.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 18 2017, Kaartic Sivaraam jotted:

> "git status" indicated "Initial commit" when HEAD points at
> an unborn branch.  This message is shared with the commit
> log template "git commit" prepares for the user when
> creating a commit (i.e. "You are about to create the initial
> commit"), and is OK as long as the reader is aware of the
> nature of the message (i.e. it guides the user working
> toward the next commit), but was confusing to new users,
> especially the ones who do "git commit -m message" without
> having a chance to pay attention to the commit log template.
>
> The "Initial commit" indication wasn't an issue in the commit
> template. Taking that into consideration, a good solution would
> be to contextually use different messages to indicate the user
> that there were no commits in this branch.
>
> A few alternatives considered were,
>
> * Waiting for initial commit
> * Your current branch does not have any commits
> * Current branch waiting for initial commit
>
> Patch-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  builtin/commit.c | 1 +
>  wt-status.c      | 5 ++++-
>  wt-status.h      | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 1d805f5da..0f36d2ac3 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1648,6 +1648,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_commit_usage, builtin_commit_options);
>
>  	status_init_config(&s, git_commit_config);
> +	s.commit_template = 1;
>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>  	s.colopts = 0;
>
> diff --git a/wt-status.c b/wt-status.c
> index 037548496..34aa1af66 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1576,7 +1576,10 @@ static void wt_longstatus_print(struct wt_status *s)
>
>  	if (s->is_initial) {
>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
> -		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
> +		status_printf_ln(s, color(WT_STATUS_HEADER, s),
> +				 s->commit_template
> +				 ? _("Initial commit")
> +				 : _("No commits yet on the branch"));

Why not simply "No commits yet", saying "on the branch" is needlessy
duplicating information in the context of the status output in which
this is printed, i.e. now you have:

    $ ~/g/git/git-status
    On branch master

    No commits yet on the branch

    nothing to commit (create/copy files and use "git add" to track)

But we can just more succinctly say:

    $ ~/g/git/git-status
    On branch master

    No commits yet

    nothing to commit (create/copy files and use "git add" to track)

Since we've already pointed out that the user is on a branch.

Also, if something is worth fixing it's worth testing for, so you can
fix this test into the patch:

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 79427840a4..b9532d201d 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1608,4 +1608,15 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
        git config -f .gitmodules  --remove-section submodule.subname
 '
 
+test_expect_success 'No commits yet should be noted in status output' '
+       git init initial &&
+       cd initial &&
+       git status >output &&
+       test_i18ngrep "No commits yet" output &&
+       test_commit initial &&
+       git status >output &&
+       test_i18ngrep ! "No commits yet" output &&
+       test_i18ngrep "nothing.*to commit" output
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index 7991fd1098..f324ea20a6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1582,7 +1582,7 @@ static void wt_longstatus_print(struct wt_status *s)
                status_printf_ln(s, color(WT_STATUS_HEADER, s),
                                 s->commit_template
                                 ? _("Initial commit")
-                                : _("No commits yet on the branch"));
+                                : _("No commits yet"));
                status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
        }


>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
>  	}
>
> diff --git a/wt-status.h b/wt-status.h
> index 6018c627b..782b2997f 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -76,6 +76,7 @@ struct wt_status {
>  	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
>  	unsigned colopts;
>  	int null_termination;
> +	int commit_template;
>  	int show_branch;
>  	int hints;
