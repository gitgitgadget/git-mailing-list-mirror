Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF392018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbcF0S0H (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33826 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcF0SZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so26967197wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svU5JBEV4A7Y2x5fuwj9HWvmpBPOB6EwTrRIUOLH+2o=;
        b=rjyZZwF/NQkzpC78g8uvIB2a8ql2hJlWHCRMRLtlLCqUBLs46oHw5nWf6VpO1RNTYv
         6Whvd7Woj0HLiR/66EDCieMDI6CEtevfR6qVP+WFNkMUPaQIb6q2PaATrv381+bcfHz9
         4YU2XrZCIqAdSHtMflIR5yJQDhJM93vgaAat4QJAA0NwKX6vZE+/MJpGY+uEocl0/Rph
         00CLAi2CFNU/Hqc+d0Y7fTuHooo4X8ISl0Y03JccoFLDeTOfT1Ih3YtqPfZThcKKIVMw
         yNMxgvlRzhrSTqXEqfiexDzsjnS6rGoQQqZarND0v/UKE0nj0xHqJKIG7BCk+m3BpzB/
         KO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svU5JBEV4A7Y2x5fuwj9HWvmpBPOB6EwTrRIUOLH+2o=;
        b=NeTbpDRuOCUjihA4VcBJRCVGIrz42Hw7E0qwJSOO2FWI3c1yZYmgBm40H7iMADalnM
         84N1IM4Gz+RhmLC55FNFAQoQTP1VwFpaWZsNpjkbmSHvFNMrkr99yPbnWsRBjL4G799w
         dFJaWhya2EKbqwWR3vI0PsQ3md9+SEo+/4RkEx1hAW77ZBlRb1IbXOPEaZhOcQrLtOnq
         4HbWd33+zsQEGAbSUn9vyoKtnrpB6oaE4ZIcLLKappjZKnuiP1KUrodyWxSTgPNMITFI
         KP0v8m3/UfkVNLCeMbH7YvWNQRnd60Ij6ZQVjc331IST19Bd6iVawWIxUWL/B7Kf291i
         KQBw==
X-Gm-Message-State: ALyK8tIowM1yCeLJkvq9mCd9lpgPxvs7k5rc0Y2lDShXXty6ZIegoyf/88G7Bh9+fFacPQ==
X-Received: by 10.28.224.5 with SMTP id x5mr11333986wmg.11.1467051954527;
        Mon, 27 Jun 2016 11:25:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:53 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 40/41] builtin/am: use apply api in run_apply()
Date:	Mon, 27 Jun 2016 20:24:28 +0200
Message-Id: <20160627182429.31550-41-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This replaces run_apply() implementation with a new one that
uses the apply api that has been previously prepared in
apply.c and apply.h.

This shoud improve performance a lot in certain cases.

As the previous implementation was creating a new `git apply`
process to apply each patch, it could be slow on systems like
Windows where it is costly to create new processes.

Also the new `git apply` process had to read the index from
disk, and when the process was done the calling process
discarded its own index and read back from disk the new
index that had been created by the `git apply` process.

This could be very inefficient with big repositories that
have big index files, especially when the system decided
that it was a good idea to run the `git apply` processes on
a different processor core.

Also eliminating index reads enables further performance
improvements by using:

`git update-index --split-index`

For example here is a benchmark of a multi hundred commit
rebase on the Linux kernel on a Debian laptop with SSD:

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

(using branch "next" from mid April 2016.)

Benchmarked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/am.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..8647298 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "apply.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1521,39 +1522,93 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  */
 static int run_apply(const struct am_state *state, const char *index_file)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
+	struct argv_array apply_paths = ARGV_ARRAY_INIT;
+	struct argv_array apply_opts = ARGV_ARRAY_INIT;
+	struct apply_state apply_state;
+	int res, opts_left;
+	char *save_index_file;
+	static struct lock_file lock_file;
+
+	struct option am_apply_options[] = {
+		{ OPTION_CALLBACK, 0, "whitespace", &apply_state, N_("action"),
+			N_("detect new or modified lines that have whitespace errors"),
+			0, apply_option_parse_whitespace },
+		{ OPTION_CALLBACK, 0, "ignore-space-change", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "directory", &apply_state, N_("root"),
+			N_("prepend <root> to all filenames"),
+			0, apply_option_parse_directory },
+		{ OPTION_CALLBACK, 0, "exclude", &apply_state, N_("path"),
+			N_("don't apply changes matching the given path"),
+			0, apply_option_parse_exclude },
+		{ OPTION_CALLBACK, 0, "include", &apply_state, N_("path"),
+			N_("apply changes matching the given path"),
+			0, apply_option_parse_include },
+		OPT_INTEGER('C', NULL, &apply_state.p_context,
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 'p', NULL, &apply_state, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
+			0, apply_option_parse_p },
+		OPT_BOOL(0, "reject", &apply_state.apply_with_reject,
+			N_("leave the rejected hunks in corresponding *.rej files")),
+		OPT_END()
+	};
 
-	cp.git_cmd = 1;
+	if (index_file) {
+		save_index_file = get_index_file();
+		set_index_file((char *)index_file);
+	}
+
+	if (init_apply_state(&apply_state, NULL, &lock_file))
+		die("init_apply_state() failed");
+
+	argv_array_push(&apply_opts, "apply");
+	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
+
+	opts_left = parse_options(apply_opts.argc, apply_opts.argv,
+				  NULL, am_apply_options, NULL, 0);
+
+	if (opts_left != 0)
+		die("unknown option passed thru to git apply");
 
 	if (index_file)
-		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", index_file);
+		apply_state.cached = 1;
+	else
+		apply_state.check_index = 1;
 
 	/*
 	 * If we are allowed to fall back on 3-way merge, don't give false
 	 * errors during the initial attempt.
 	 */
-	if (state->threeway && !index_file) {
-		cp.no_stdout = 1;
-		cp.no_stderr = 1;
-	}
+	if (state->threeway && !index_file)
+		apply_state.be_silent = 1;
 
-	argv_array_push(&cp.args, "apply");
+	if (check_apply_state(&apply_state, 0))
+		die("check_apply_state() failed");
 
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+	argv_array_push(&apply_paths, am_path(state, "patch"));
+
+	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, 0);
 
 	if (index_file)
-		argv_array_push(&cp.args, "--cached");
-	else
-		argv_array_push(&cp.args, "--index");
+		set_index_file(save_index_file);
 
-	argv_array_push(&cp.args, am_path(state, "patch"));
+	argv_array_clear(&apply_paths);
+	argv_array_clear(&apply_opts);
+	clear_apply_state(&apply_state);
 
-	if (run_command(&cp))
-		return -1;
+	if (res)
+		return res;
 
-	/* Reload index as git-apply will have modified it. */
-	discard_cache();
-	read_cache_from(index_file ? index_file : get_index_file());
+	if (index_file) {
+		/* Reload index as apply_all_patches() will have modified it. */
+		discard_cache();
+		read_cache_from(index_file);
+	}
 
 	return 0;
 }
-- 
2.9.0.172.gfb57a78

