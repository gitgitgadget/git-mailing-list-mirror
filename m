Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B5320193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbcIDUUG (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35670 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932271AbcIDUT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id c133so10467851wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wnGGhmKpqghrE1GEF49ik8L5ftnlOEmwFeut9ZselgM=;
        b=iwevk/qD7LcD/HLtKfGAU4+edGVZClPIZB8m9R1QrH0ofkZ3oQrZCuG+S9+8C6Kc5v
         tATxNq0EOx/ga7a16forntZIXc10CIGJ3Zj/pEXU7r21uJkWYg2bZIO8pDo8vU7ChVF7
         /73BTJwoKhkAYhAbyGfqQjfgAhqmdJFUK/vy/fYTjEc5erStHsjB1pn+0zPEHU1fmvUp
         CEcPI237p6LBSWl13cW4R9tWHORiDHkrrGramblkA1h4zzdG1tE8xN6lhsn5kgOB+x0W
         t85v/BZN/8XCICIHIEbm8g559ewItmY/nrGh6VCzY8FhE2sXy8o2Aq8eVTcqykPPsSZ7
         JtcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wnGGhmKpqghrE1GEF49ik8L5ftnlOEmwFeut9ZselgM=;
        b=S9C32pCf1drvmjMNL6aJUHduJ+ZCYhruGrUh2BUMUIFPD2CfWrsoF3Xx8Qv2Vn9GIx
         t60xCE6heuTemR73khU77tQxdbEVvGxF2YSz/1mOo35stuEDjSPM06zBJBH1q1M7tOlE
         /lp6Bnvt35uPoQpRSTOFVMmmyE4FFX4vcG1/SXbZVjMbFuSSzmmfNQYk27TGDRdPGavQ
         UQeqCbuHYlHtFJGtq7SSnBl20IBk22VoHP39Qu1BF//tsxpWLJdllkG0hO6bD0+WFK22
         fdUu6o9alaWaLIo5XLYlOepE84jgoTsMCbLaBxlZPqyFu5eB5y+FABsq+z9yYqvNDZW8
         sadg==
X-Gm-Message-State: AE9vXwMbQZIGEgGLxr7mURAZAsvPI2p7PCdYt+4BMovGC+v4J7cZByfl0aJC9hIdPqVBfg==
X-Received: by 10.195.2.42 with SMTP id bl10mr28076736wjd.21.1473020396179;
        Sun, 04 Sep 2016 13:19:56 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 41/41] builtin/am: use apply API in run_apply()
Date:   Sun,  4 Sep 2016 22:18:33 +0200
Message-Id: <20160904201833.21676-42-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces run_apply() implementation with a new one that
uses the apply API that has been previously prepared in
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
 builtin/am.c | 65 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 739b34d..38d5d11 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "apply.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1522,39 +1523,59 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
  */
 static int run_apply(const struct am_state *state, const char *index_file)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-
-	cp.git_cmd = 1;
-
-	if (index_file)
-		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=%s", index_file);
+	struct argv_array apply_paths = ARGV_ARRAY_INIT;
+	struct argv_array apply_opts = ARGV_ARRAY_INIT;
+	struct apply_state apply_state;
+	int res, opts_left;
+	static struct lock_file lock_file;
+	int force_apply = 0;
+	int options = 0;
+
+	if (init_apply_state(&apply_state, NULL, &lock_file))
+		die("BUG: init_apply_state() failed");
+
+	argv_array_push(&apply_opts, "apply");
+	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
+
+	opts_left = apply_parse_options(apply_opts.argc, apply_opts.argv,
+					&apply_state, &force_apply, &options,
+					NULL);
+
+	if (opts_left != 0)
+		die("unknown option passed through to git apply");
+
+	if (index_file) {
+		apply_state.index_file = index_file;
+		apply_state.cached = 1;
+	} else
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
+		apply_state.apply_verbosity = verbosity_silent;
 
-	argv_array_push(&cp.args, "apply");
+	if (check_apply_state(&apply_state, force_apply))
+		die("BUG: check_apply_state() failed");
 
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+	argv_array_push(&apply_paths, am_path(state, "patch"));
 
-	if (index_file)
-		argv_array_push(&cp.args, "--cached");
-	else
-		argv_array_push(&cp.args, "--index");
+	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, options);
 
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
2.10.0.41.g9df52c3

