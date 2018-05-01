Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C0921841
	for <e@80x24.org>; Tue,  1 May 2018 09:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbeEAJu3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 05:50:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54978 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeEAJu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 05:50:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id f6so17057402wmc.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0T+5GjeQO+nJduTdvXb98GhACHJdYqX1AQUlQ+CAAg=;
        b=JvlGDNWCyvU8Cpz3tt1c+Xe25Qs7nMPG5Pvzker5IC5QSRUWDtxUlWMs1Y8KlySn7P
         VBZWBpZjfI5m0+GH0zXjvqE0WOtjre8k+yu2WVmzZD50xzzbiPR5tNgvVwcD6t5raup2
         Qbc12im/4b3Acunyrlyw5aSKuN7blndnAZWEsxDMO/Ec8ATle2EWD+jnEVfS6mGdvR+Z
         P+E6VJWNBPUtrX7J/+4LPFX2d56OMyvMXTsOWZ8s5bTuCQ6LmqkVW9DwnBpCFpJB7cxx
         CPO8M/fKP2+mj6vhwFrFLRLMdSNXIXZkIm4WsOpjuLNblqEE4ITWlyKw8PH++QJjqYPg
         PSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0T+5GjeQO+nJduTdvXb98GhACHJdYqX1AQUlQ+CAAg=;
        b=Z5ITQOeacwJl0UgAG9MKrxwZ5visOj2LUajls25VNJxkKxFkkKwiAh44q3cmm76YtE
         zh6SB2PKXiWyFifwg5lk0r/vFqo6TgjARNp7TBUR9uY0UrxQ+lunPvW2bO2mNBWPy8zv
         TgBH6aMvGWrrariy2bmeHYbEnIUjglCkb58EXFURWzw36dagLJGNPGSH20XZUTECUiCc
         RGxviUxe9w5yA1HQc1CCb6Y6wNAFzhZXsVNB0YOY7UDYbL7HWfjigYGeVDCW3cCi1+GV
         bjC1rTEVoxWipFikc9dQz8FPhA3hCZ4JRg6789KOA5ZTYJfKD/zgH+Kgf4/RMOqDgtqA
         2EwQ==
X-Gm-Message-State: ALQs6tDuiq3ZBTMLwB9Y4PcgYUu/3enNwXvL740+Z44PEIAKutjo6zU7
        iZFgVqdpWJ32qA4Q+sfTX/zOgKCh
X-Google-Smtp-Source: AB8JxZr1v+MH4E+oGBKa+SWDMRH/06PtZ2Gmz1hB7wysX/OhqrW6od8DvRVSnxsePmSRo5Jdji98Xg==
X-Received: by 2002:a50:84e9:: with SMTP id 96-v6mr20639711edq.235.1525168226758;
        Tue, 01 May 2018 02:50:26 -0700 (PDT)
Received: from esm.hitronhub.home (ipbcc18eac.dynamic.kabel-deutschland.de. [188.193.142.172])
        by smtp.gmail.com with ESMTPSA id h13-v6sm5229905edi.91.2018.05.01.02.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 May 2018 02:50:26 -0700 (PDT)
From:   "=?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?=" 
        <eckhard.s.maass@googlemail.com>
X-Google-Original-From: =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Subject: [PATCH v2] wt-status: use rename settings from init_diff_ui_defaults
Date:   Tue,  1 May 2018 11:49:40 +0200
Message-Id: <20180501094940.17772-1-eckhard.s.maass@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
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
activated) accordingly to the diff.renames and diff.renameLimit setting.

With this commit the hard coded settings are dropped from the status
command.

Signed-off-by: Eckhard S. Maaß <eckhard.s.maass@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
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

