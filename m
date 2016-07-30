Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137901F955
	for <e@80x24.org>; Sat, 30 Jul 2016 17:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030AbcG3R2D (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:28:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35538 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbcG3R0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so20042410wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rlvvqs9smNmfQZMrtmeLKxX0w3+lKvMITw7BTAuqm2s=;
        b=L6kTDAQh3vg6q4Q0vq0vVrDLOmiJDBGxmsT7awzz7JTVyndCDAfhvEQ/T9ibN1F8pK
         zK/vYmHRZWGsXNKIE1CBerU42wq5pOSqw3g68iYqxpq7zClLETUKOZulBf2QdamjoQMS
         4FIw0yB+QoIqqTpyEtzpI2GN2QbD6rIaSK7R1Rz4mbgE5Z8qdmPr3rL+3IA9GwYl47eE
         WrM1SsB0UIxO3b1UI0Q0z7ZDP0TNwmXUk5tNNiHXuS9TXlAUjTtbgnFW4a7cx+ikOZHe
         4/2hrK5TIUnofR7kOBrckiUS9dSX9w75b8FU7IYMgjZwqcubgWeRgI8+j3FdW3Fy34tR
         T1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rlvvqs9smNmfQZMrtmeLKxX0w3+lKvMITw7BTAuqm2s=;
        b=b8gG1Zph6XKM2mxuMAOor98Z66M3d0FOMFolJahZhj0vDgT0fVVWEvDFvsKqbCslHJ
         8EtIW6P5kEJIb3PuY9xp4j0T8CaQ/nwnClCfdfYdTXNBLHWh4rK6juhgPMFE7rlp8L4R
         T5H1uaqX8ZFf65w3JWqn4u0Q0PK5Ce3Tn3frC74vL3R6fO+K5mGZFzB/MiIHOPitJwJ4
         GOL1Og1pyU6i66C3AdSV5kkze1/Y+shgiLO8fT758r6p9yk69Rg0rugfhYxGeg+6rkYB
         dEYG2MKqgJ4G4+BnBRk2biq5QD+2HCq63JdYBMT8WN0EeRtbzKusAc48Z4VWnLkPgrLA
         DQfw==
X-Gm-Message-State: AEkoouuGFo4t/+iI76npJd0+ExCeHxhdN0n5fN+O0fE1FjmW7kz3obIT+kOzMiJJf/vJ0w==
X-Received: by 10.195.18.170 with SMTP id gn10mr44335964wjd.46.1469899599967;
        Sat, 30 Jul 2016 10:26:39 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:39 -0700 (PDT)
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
Subject: [PATCH v9 41/41] builtin/am: use apply api in run_apply()
Date:	Sat, 30 Jul 2016 19:25:09 +0200
Message-Id: <20160730172509.22939-42-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
2.9.2.558.gf53e569

