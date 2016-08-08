Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424E32018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbcHHVFW (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34159 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbcHHVE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so17869204wma.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uVJrEDOUsR9BG8j7cJ9MCnxx76jNuiYBeIHR6Qmcno=;
        b=p33KptHLCVAooKS7mf1/uQOIOt0s0dMTeRAK5aMoofdPfQ8wSKyeavLVnqOQgM8kn+
         an4YYnUl/YsKNdmzomWHXqb5HVCeBubstuiyvDGFDiJv5Hz4noRNbS1B1/2PBGTZkGL5
         qAA31JfahW+CUbwxlXFkEfHgtXgo25DzSNduBoEme87oHbDOowocljDQiCLB9XUOTiZP
         /01EiYrD0mbGHjImt9dyrXflzQrR6rwmImWAny3epIbsi5tQtdgnTRsNURshCQUSnEcF
         65Qz8cPb+e9smzOlrdLRX095fgQol+3fbF6KoM8eHrzBf5PkIXkwmLDoBQM1mtPW0IAE
         JXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uVJrEDOUsR9BG8j7cJ9MCnxx76jNuiYBeIHR6Qmcno=;
        b=eEYtxTVovWiKrLJVQipttNO9oP1Cf3FX4GFkEUfF6HkknbFOJWY3MntBO9ToLutPGJ
         xBAdzaileMV2NdJ1dLsVdVi5i5Cnv9/GIk7yWV8NoLXlzpZtGyXO+UU0XooCOSmRFKHw
         TAsKO1Legep5ELgqye7bEbPVM7uUP1X7kCEh5HHr4ve6FtHAGDn7qdGvXxmBPA+5W/lt
         QJEb85jnCfB9NmuGcOmaeNbmGGu0JA0G8cZjXARwd4MLTTusPMlM42/eAdWfXzWubjZy
         QTWKChU4napW0tEbGNJon1fk6ww3Bk9RNKGfqY+b+2aHXt3mpa+gOjSv3U5Tsd5CT2w1
         6OZw==
X-Gm-Message-State: AEkoousGTaRewY1QeNnKyJH0gKEvR4uBohsfSIXU/8xchsbznT5OKmYr8koIeIURBB1WJg==
X-Received: by 10.28.32.77 with SMTP id g74mr16900593wmg.45.1470690296257;
        Mon, 08 Aug 2016 14:04:56 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:55 -0700 (PDT)
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
Subject: [PATCH v10 40/40] builtin/am: use apply api in run_apply()
Date:	Mon,  8 Aug 2016 23:03:37 +0200
Message-Id: <20160808210337.5038-41-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
 builtin/am.c | 65 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index b77bf11..54c5728 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "apply.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1522,39 +1523,67 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
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
+	int force_apply = 0;
+	int options = 0;
+
+	if (index_file) {
+		save_index_file = get_index_file();
+		set_index_file((char *)index_file);
+	}
 
-	cp.git_cmd = 1;
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
+		apply_state.apply_verbosity = verbosity_silent;
 
-	argv_array_push(&cp.args, "apply");
+	if (check_apply_state(&apply_state, force_apply))
+		die("BUG: check_apply_state() failed");
 
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+	argv_array_push(&apply_paths, am_path(state, "patch"));
+
+	res = apply_all_patches(&apply_state, apply_paths.argc, apply_paths.argv, options);
 
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
2.9.2.614.g4980f51

