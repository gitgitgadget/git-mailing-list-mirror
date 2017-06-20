Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94A7B20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbdFTH02 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:26:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33429 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTH00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:26:26 -0400
Received: by mail-wm0-f67.google.com with SMTP id f90so21131269wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=N7DuIZoGWVeupE12upkqVs77DG6xbqNgu/u7/g7Ougg=;
        b=e8Zm3aL+02+QskDIxlqTWN9WZHuvDi77TJaLO3Zb4c/CpqX6y+lGgREUm8nJzUjLqA
         dbYMh4I6eCPwnBfLhNkC+bqoKYsPeKqKc0PGqKv4iaG3QIPwmXoMH8Eltf2FRHagHSlu
         3evkQ83pntcSL0EK/QLFTZeLRpKxuiM73kvUHKhJ2kNOroKugJpeDGwaRQcm6fXdxdcU
         giZ1V3u3+e5Qky/8fHIaNyKvq5X8h7I7itFKervdfW1yfVDA0Ohyr/6nQE0E+uSYBbaZ
         +UtUlU/ybO0624MyeF3NVqWWdygpzxtVzuR6CUu3zP6U6n2FaLoFQ2sIyL2qKuCDnk5T
         EBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=N7DuIZoGWVeupE12upkqVs77DG6xbqNgu/u7/g7Ougg=;
        b=HrlG0KC4QLmB0c7OfIZnDYo3dNgVyjx2++4glVRqBRHfZynTfZ+QRIIuwVOORk3NbW
         PeFVHov/AcUSn0N76DS/EvnNlmWoljHUJvlzP/NQy+5f0pGqmfr0VJxxpHuO/7v8kln3
         dP9OC4/iCUzISXZ1zZumcNRJJXxC+u0X9n6ZAV04qz+9HrNviaK5S0y7UCh278Wjv08J
         dnZaaziQu0AJqHxDAdinGeKZ2WtOAIS7H/LHfHzakGCcQlHCjqR3o2AACftZKUC1wlAz
         GcCBVHkLTnf+emCb12OdYdkr/qWnkIBXZYED1RNb0oETHdoUBURFoz1wl9dlOFmBT0ZU
         uYKA==
X-Gm-Message-State: AKS2vOyiZMxPJlcUNOdhy0Yd7pQbflUzHuTPCY6KOuq4TGz934YgPECJ
        1PoatY32M2BDeHIrUz8=
X-Received: by 10.28.132.11 with SMTP id g11mr1522054wmd.57.1497943585234;
        Tue, 20 Jun 2017 00:26:25 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id n2sm19830878wrn.30.2017.06.20.00.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 00:26:24 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNDYN-0007D5-6m; Tue, 20 Jun 2017 09:26:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 1/3] Contextually notify user about an initial commit
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com> <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170620030220.7323-1-kaarticsivaraam91196@gmail.com>
Date:   Tue, 20 Jun 2017 09:26:23 +0200
Message-ID: <87o9tj86hs.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 20 2017, Kaartic Sivaraam jotted:

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
> The most succint one, "No commits yet", among the alternatives
> was chosen.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>

There's a few issues with these 3 patches I think should be fixed:

 * Let's do that spacing fix (unrelated fix) in its own commit.

 * You should add tests along with the code being changed, and
   especially change tests that would fail with your new code, otherwise
   you break bisection.

 * I think the commit message here could be shorter & clearer at the
   same time.

 * The commit message doesn't follow our usual format.

Other than that this looks good to me.

I've pushed a fixed version with those fixes to
help-kaartic-with-no-commits-yet on github.com/avar/git
(https://github.com/avar/git/tree/help-kaartic-with-no-commits-yet). You
could just submit that as a v2 pending any comments others might have.

That yields a 2 patch series, here pasted below for on-list review:

commit 23d792d8d3
Author: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Date:   Tue Jun 20 08:32:20 2017 +0530

    status tests: fix a minor indenting issue

    Change the indentation from "\t " to "\t". This indenting issue was
    introduced when the test was added in commit
    1d2f393ac9 ("status/commit: show staged submodules regardless of
    ignore config", 2014-04-05).

    Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 79427840a4..ebad377d68 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1603,7 +1603,7 @@ EOF
 test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=dirty >output &&
-	 test_i18ngrep ! "^M. sm" output &&
+	test_i18ngrep ! "^M. sm" output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '

commit d2eed0491c (HEAD -> help-kaartic-with-no-commits-yet, avar/help-kaartic-with-no-commits-yet)
Author: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Date:   Tue Jun 20 08:32:18 2017 +0530

    status: contextually notify user about an initial commit

    Change the output of "status" to say "No commits yet" when "git
    status" is run on a fresh repo (or orphan branch), while retaining the
    current "Initial commit" message displayed in the template that's
    displayed in the editor when the initial commit is being authored.

    The existing "Initial commit" message makes sense for the commit
    template where we're making the initial commit, but is confusing when
    merely checking the status of a fresh repository without having any
    commits yet.

    Helped-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

diff --git a/builtin/commit.c b/builtin/commit.c
index e3c9e190b0..8d075c15a3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1652,6 +1652,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);

 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 0b6da7ae1f..fa61b1a4ee 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -18,7 +18,7 @@ test_expect_success 'initial status' '
 	echo bongo bongo >file &&
 	git add file &&
 	git status >actual &&
-	test_i18ngrep "Initial commit" actual
+	test_i18ngrep "No commits yet" actual
 '

 test_expect_success 'fail initial amend' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index ebad377d68..57a37f88a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1608,4 +1608,34 @@ test_expect_success 'git commit -m will commit a staged but ignored submodule' '
 	git config -f .gitmodules  --remove-section submodule.subname
 '

+test_expect_success '"No commits yet" should be noted in status output' '
+	git checkout --orphan empty-branch-1 &&
+	git status >output &&
+	test_i18ngrep "No commits yet" output
+'
+
+test_expect_success '"No commits yet" should not be noted in status output' '
+	git checkout --orphan empty-branch-2 &&
+	test_commit test-commit-1 &&
+	git status >output &&
+	test_i18ngrep ! "No commits yet" output
+'
+
+test_expect_success '"Initial commit" should be noted in commit template' '
+	git checkout --orphan empty-branch-3 &&
+	touch to_be_committed_1 &&
+	git add to_be_committed_1 &&
+	git commit --dry-run >output &&
+	test_i18ngrep "Initial commit" output
+'
+
+test_expect_success '"Initial commit" should not be noted in commit template' '
+	git checkout --orphan empty-branch-4 &&
+	test_commit test-commit-2 &&
+	touch to_be_committed_2 &&
+	git add to_be_committed_2 &&
+	git commit --dry-run >output &&
+	test_i18ngrep ! "Initial commit" output
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index bf651f16fa..f324ea20a6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1579,7 +1579,10 @@ static void wt_longstatus_print(struct wt_status *s)

 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}

diff --git a/wt-status.h b/wt-status.h
index 8a3864783b..2389f08390 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int commit_template;
 	int show_branch;
 	int hints;
