Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767B31F42E
	for <e@80x24.org>; Fri,  4 May 2018 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEDLM1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 07:12:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40733 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeEDLMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 07:12:25 -0400
Received: by mail-wr0-f194.google.com with SMTP id v60-v6so20671885wrc.7
        for <git@vger.kernel.org>; Fri, 04 May 2018 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l6cYab/1n/WeFVHWMukINo4/vLLoPbIQSz+MDOgLyN8=;
        b=qKdsosuufo7EBq3bMGt4KUpsqRfFfK3527vzauyTgf3KZ/eiD4NZyYEt2N+Ahg6qdR
         dP77g5IX64F2komoPAEnPXnJ4PcLLfEzCgE89A9BHs43a1A+wbgr1IOp/vQeFsmjwdF0
         UgM6SffP31p/NS1CulIAEWE7P1/Xt7WvFSK33ODZeWU4rfpvBIteYgFC1pLeZddhFbv8
         I9mhLK0HTBatiQ0kWZVglE0YyhIi6YVjNzon30Bi9wZo/U8NzEpprD4D1vmxkFrbc2dj
         AzBl946HGRrWChb9XIrFQbzy/Bi+T5/2uJ9+IwFlPVYERc5l5urja98gQG7DaxGGWJ7H
         iI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6cYab/1n/WeFVHWMukINo4/vLLoPbIQSz+MDOgLyN8=;
        b=hsb/bYuPENmiI+RjWbKTovTWMJ0miADXzhoCg74jrZt88jv8/9ZNBsuuchfQWpS8hj
         VxNn0pRkXJDMtM4u9Fy7rzvPU18qA7ppvmVdcYYJR+bHWGwsrC2X0EJAwaiCWol1nOD6
         Vby10byrNFk+dvu0LG8ecTxaMjjOdb7iOQuqhheG2FzFgKzsTOc2zXeyz8TrUaEpBhjK
         UJ0GWG+87vfYTrVMcQYS8Xhr6vESf53Fn7qDs+QMucr5d9YHyBKASHQ+pySIgo4a+SOh
         CySLvQe2N/Lox4z19QJbSrQ7Wp9NbNC8+qvpsx/0taNxibhRS3YpMKmlrKvp9SygsAJg
         QHfQ==
X-Gm-Message-State: ALQs6tCxth0lVp4P963UHcQSn9F9UdJl/jfK2cs6U4VpHKG0Q/fLMarV
        N1++A65Ik0wv6xi3owPOM+z7eQ==
X-Google-Smtp-Source: AB8JxZqtLReF40hmg1DWP0ctscUjrvecOYgqPvRziOTufaQh4DlQEy08VEwdQgB2cHgdYnMa0ucgdw==
X-Received: by 2002:adf:db4f:: with SMTP id f15-v6mr20878071wrj.212.1525432344188;
        Fri, 04 May 2018 04:12:24 -0700 (PDT)
Received: from esm.tngtech.com (fire.tngtech.com. [212.204.93.100])
        by smtp.gmail.com with ESMTPSA id d83sm2617200wmh.16.2018.05.04.04.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 May 2018 04:12:23 -0700 (PDT)
From:   "=?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?=" 
        <eckhard.s.maass@googlemail.com>
X-Google-Original-From: =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        =?UTF-8?q?Eckhard=20S=2E=20Maa=C3=9F?= <eckhard.s.maass@gmail.com>
Subject: [PATCH v3] wt-status: use settings from git_diff_ui_config
Date:   Fri,  4 May 2018 13:12:15 +0200
Message-Id: <20180504111215.5975-1-eckhard.s.maass@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
References: <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you do something like

    - git add .
    - git status
    - git commit
    - git show (or git diff HEAD)

one would expect to have analogous output from git status and git show
(or similar diff-related programs). This is generally not the case, as
git status has hard coded values for diff related options.

With this commit the hard coded settings are dropped from the status
command in favour for values provided by git_diff_ui_config.

What follows are some remarks on the concrete options which were hard
coded in git status:

diffopt.detect_rename

Since the very beginning of git status in a3e870f2e2 ("Add "commit"
helper script", 2005-05-30), git status always used rename detection,
whereas with commands like show and log one had to activate it with a
command line option. After 5404c116aa ("diff: activate diff.renames by
default", 2016-02-25) the default behaves the same by coincidence, but
changing diff.renames to other values can break the consistency between
git status and other commands again. With this commit one control the
same default behaviour with diff.renames.

diffopt.rename_limit

Similarly one has the option diff.renamelimit to adjust this limit for
all commands but git status. With this commit git status will also honor
those.

diffopt.break_opt

Unlike the other two options this cannot be configured by a
configuration option yet. This commit will also change the default
behaviour to not use break rewrites. But as rename detection is most
likely on, this is dangerous to be activated anyway as one can see
here:

    https://public-inbox.org/git/xmqqegqaahnh.fsf@gitster.dls.corp.google.com/

Signed-off-by: Eckhard S. Maaß <eckhard.s.maass@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---

Hello,

Hopefully I have addressed all issues that have come up so far.

Greetings,
Eckhard

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

