Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A1CC21841
	for <e@80x24.org>; Mon, 30 Apr 2018 09:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752099AbeD3Jeo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 05:34:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50957 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeD3Jen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 05:34:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id t11so12048489wmt.0
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 02:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U90WKYB5u1IDlyj3YbLoUwXZmMAQaDYjNIXuwtRDQyg=;
        b=H4txgeQvVNoJfQ/qDyhZB/viCxO+OVN3uEUlxN/qv2C/ZB0YnEk0f5CMs6PhZHPZGb
         Uo/ihuvoYES9tap9HYM3rLs5IMtFflR6tK1b25+RCNDRp7KXV5X4wk5pxKKIrFKxjlPF
         BWao29VRw6PUdHbcppDWapi5FwUuqNYOWZBMsWSWdyx1Dx8nY2H2jdOjIeFv0LMKpF6l
         Bzl+WXJ5qzrjLrNqeTUQGShq1KXivlMAJDpDzAfrQKDXhgMuKCHTyey14NTHp9dk+EhR
         x2SueZmcjYLu2+ze4Av24Cj2O5qQu0yB+kGIjSGDj6C5P72Z5JPGRFWRKcshKFfyD0hT
         r0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U90WKYB5u1IDlyj3YbLoUwXZmMAQaDYjNIXuwtRDQyg=;
        b=WTFK/OXaHXuTjBfwvqJ6LrkxCoMiTiszqDm1mYk5m0HjVjb1+80/57MojtAbSdmSA0
         yA5+hcrzna3Js2jidNDttHufd6QiBYz5Wi3uS1oyXSNYciW2st+dDdbLvf9iWqa/rs78
         wJw0DT89FSXh5Th5r0XnqItw6WU9KD+ieY53TlA0ipFml1N7Zz8ZzgAT1627s58Arhwe
         40HBcD+X2PsPEFwxQWc9Qx66C6/ObHA+P27rU3mxGlPHfN/a49xZAhquBhN+QQ1CAmkj
         WANRVv6XPkzCCbGcl9HEAiYk/ZDCKP5AGFsOfJjm0bPZgjgu4EjPOK/y4lpzhlm+7Q/N
         MAVQ==
X-Gm-Message-State: ALQs6tBscg3/wVV5V1VNHjGDCNabPmnA0pEP7n9D0Pxu7z155dODTtPr
        J3vZ9W1p0F0UAfqEr0H9T+nQoo0O
X-Google-Smtp-Source: AB8JxZo0f67wQ7V4kjwqjmHWeKXIPc0dTfUrFoVQwUSZMtjhLF1MYLrOeoe2RRLn2XF1hFDPPR8uwQ==
X-Received: by 2002:a50:a621:: with SMTP id d30-v6mr15600269edc.173.1525080882381;
        Mon, 30 Apr 2018 02:34:42 -0700 (PDT)
Received: from esm.hitronhub.home (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id w26-v6sm4104698edq.77.2018.04.30.02.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Apr 2018 02:34:41 -0700 (PDT)
From:   "=?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?=" 
        <eckhard.s.maass@googlemail.com>
X-Google-Original-From: =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Subject: [PATCH 1/1] wt-status: use rename settings from init_diff_ui_defaults
Date:   Mon, 30 Apr 2018 11:34:21 +0200
Message-Id: <20180430093421.27551-2-eckhard.s.maass@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <20180430093421.27551-1-eckhard.s.maass@gmail.com>
References: <20180430093421.27551-1-eckhard.s.maass@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the very beginning, git status behaved differently for rename
detection than other rename aware commands like git log or git show as
it has the use of rename hard coded into it.  After 5404c116aa ("diff:
activate diff.renames by default", 2016-02-25) the default behaves the
same by coincidence, but a work flow like

    - git add .
    - git status
    - git commit
    - git show

should give you the same information on renames (and/or copies if
activated) accordingly to the diff.renames setting.

With this commit the hard coded rename settings are dropped from the
status command.

Signed-off-by: Eckhard S. Maaß <eckhard.s.maass@gmail.com>
---
 builtin/commit.c       |  2 +-
 t/t4001-diff-rename.sh | 12 ++++++++++++
 wt-status.c            |  4 ----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5571d4a3e2..5240f11225 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -161,9 +161,9 @@ static void determine_whence(struct wt_status *s)
 static void status_init_config(struct wt_status *s, config_fn_t fn)
 {
 	wt_status_prepare(s);
+	init_diff_ui_defaults();
 	git_config(fn, s);
 	determine_whence(s);
-	init_diff_ui_defaults();
 	s->hints = advice_status_hints; /* must come after git_config() */
 }
 
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index a07816d560..bf4030371a 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -138,6 +138,18 @@ test_expect_success 'favour same basenames over different ones' '
 	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
 '
 
+test_expect_success 'test diff.renames=true for git status' '
+	git -c diff.renames=true status >out &&
+	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+'
+
+test_expect_success 'test diff.renames=false for git status' '
+	git -c diff.renames=false status >out &&
+	test_i18ngrep ! "renamed: .*path1 -> subdir/path1" out &&
+	test_i18ngrep "new file: .*subdir/path1" out &&
+	test_i18ngrep "deleted: .*[^/]path1" out
+'
+
 test_expect_success 'favour same basenames even with minor differences' '
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status >out &&
diff --git a/wt-status.c b/wt-status.c
index 50815e5faf..32f3bcaebd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -625,9 +625,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
 	rev.diffopt.format_callback_data = s;
-	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
-	rev.diffopt.rename_limit = 200;
-	rev.diffopt.break_opt = 0;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 }
@@ -985,7 +982,6 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
-	rev.diffopt.detect_rename = DIFF_DETECT_RENAME;
 	rev.diffopt.file = s->fp;
 	rev.diffopt.close_file = 0;
 	/*
-- 
2.17.0.252.gfe0a9eaf31

