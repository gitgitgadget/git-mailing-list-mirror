Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E75F2018E
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbcH0SqW (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35496 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754841AbcH0SqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:15 -0400
Received: by mail-it0-f66.google.com with SMTP id f128so2936150ith.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBhqJcsyjrmaJ10chXERLrCChcmUX17YuvtedRNBf44=;
        b=m8FkpK7LdvuVJ+46w1KnUhZiyay6M+ZPJZpT8jpWP3rrXSOIBaznSm2hGCieJnU4Y9
         VQSr3xiJtArl3pyyeUzF0TMnGwLwrH38NTwBUUEgD0y/fC6q6GBoTe6phK/XpCoeL3mr
         Sxvlwa8MlCIBkMzFlOv0HklYWd3ZWSC1kcFMPuOqRBxwffZFWIi6PqaZgKQ1AHqBfHzc
         PcGq7b5DmejVdrBcC5246//YgITfuDxeKop+gKoov44sV58rvvIa3f9U9XHPZzKok0s6
         DJAgRsrU8KCsDHdTCVQ1Zy+4ZqABqVgj/DgsHX/8+qlYk7N4btaCIFTpi52COglGMDQe
         c0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBhqJcsyjrmaJ10chXERLrCChcmUX17YuvtedRNBf44=;
        b=dKtNa4mYNsHrT0uOz1Fw+Onm3MDfECUN3EQIR0pIsXJKFXcuCROBrMrU4ZrLBuwpSS
         7JNGEkNRdbRo1QwuOUPwnkVzhnIl21r0KdbmegIsT2Jl1M86isHBIhLlDS49HMGEyvUo
         gI2qSsFE41sqpKi14b0GSlj/giLj98LntlsTfXC4HfWcCDuk7IYT5QU+667r/aPBE+/v
         fCKiQblQ+D0P98/CihEy1zZRQONN9KrRWW7u0Fw3V+50bNzF5bwHZ784ApUUazJNLf1e
         Ru0mhvdSTWd9Y+52J5Wzs4hnwSrYUuHjgj+zs/QHM3jS5lHGcOkwYa+6GsWU6mhT2x9U
         Vs9g==
X-Gm-Message-State: AE9vXwN+3HM16yiDr3GfLAbiYKxX++aPFDc4REO5ItBdmQBtQQm/++3JIKQWVEtEIiSGiw==
X-Received: by 10.36.14.20 with SMTP id 20mr5762386ite.88.1472323575013;
        Sat, 27 Aug 2016 11:46:15 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:14 -0700 (PDT)
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
Subject: [PATCH v13 14/14] builtin/am: use apply API in run_apply()
Date:   Sat, 27 Aug 2016 20:45:47 +0200
Message-Id: <20160827184547.4365-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
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
index 739b34d..0e5d384 100644
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
+		die("unknown option passed thru to git apply");
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
2.9.2.770.g14ff7d2

