Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3811F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754546AbcIDUSv (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:18:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33732 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754481AbcIDUSt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so10454954wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bG0PDsqzLau+VEJH9vZp2BFh8OUe479xi3TgbM1/0Kc=;
        b=XjnVQEstWnmbSU51SZF83ocvo718RQdAiZJPa5UhiCprytO3ZxHRx2cS8GCT81w7NA
         BrSZE91PrU+jgL3D1N1g1O3vRz000GLq4QJMwG0vdETunznV9HWlfQSyQQToVmgezaGY
         QmkNV4rw5s7WQHqRSmIXymQeq9gpkL4kfBdNJjctTXWEXd0P/f3FyOAcFDgbItM0e2Bt
         Ci5hVgmUHtj61SfFFzy7NmytRd8s5GFFdyQV8XiOZCJDptYtvCe7m4DKABpJwfOfGBj8
         KhJTRjXbUzpb3k/Z3aM0sYLDf+TDGxVXH/uLjZwbf82j6JCDerbrqSqrsJQvknsmh3d9
         /BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bG0PDsqzLau+VEJH9vZp2BFh8OUe479xi3TgbM1/0Kc=;
        b=VwQeKgmuiv1X4R7++TdPQNIJ7TbrUcAzAno7c/RdamIvMY3gXUPR7m/2s0Ba11RWQM
         y3E+WwKNdY73/mpLYfXD7TMWH9Z9foxPbhtUE+wgDSPwf0J5HumFyfnAEpizZxUQP4yD
         c1tINToSm2ZwW39C/HC0prxVurdFkDu9bMuqZ0NU9D1/zLoWAZZnPvZQYqAQGGNrSOY8
         tecn15BC4mWYOgrKKRPChzB1m65MbdMzeFAOp47QMc5JXZvK4CpgdPnXxDg3opx2BXaQ
         Gutmu1net3LYcP0GdDdJASo3bVvUPa+aGU8LJYJOkCgVdy5M/t+TmuAc7F2ckRx8uxUN
         QuvQ==
X-Gm-Message-State: AE9vXwN2TkTTXoZzteCnZhQfDgVCs8ZgY86I77pkpHJnlQUv0k1Npjtvu+CksiFhBBr4og==
X-Received: by 10.28.50.199 with SMTP id y190mr12863003wmy.61.1473020327269;
        Sun, 04 Sep 2016 13:18:47 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:46 -0700 (PDT)
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
Subject: [PATCH v14 02/41] apply: move 'struct apply_state' to apply.h
Date:   Sun,  4 Sep 2016 22:17:54 +0200
Message-Id: <20160904201833.21676-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we must make 'struct apply_state'
usable outside "builtin/apply.c".

Let's do that by creating a new "apply.h" and moving
'struct apply_state' there.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/apply.c |  98 +-----------------------------------------------------
 2 files changed, 101 insertions(+), 97 deletions(-)
 create mode 100644 apply.h

diff --git a/apply.h b/apply.h
new file mode 100644
index 0000000..7493a40
--- /dev/null
+++ b/apply.h
@@ -0,0 +1,100 @@
+#ifndef APPLY_H
+#define APPLY_H
+
+enum apply_ws_error_action {
+	nowarn_ws_error,
+	warn_on_ws_error,
+	die_on_ws_error,
+	correct_ws_error
+};
+
+enum apply_ws_ignore {
+	ignore_ws_none,
+	ignore_ws_change
+};
+
+/*
+ * We need to keep track of how symlinks in the preimage are
+ * manipulated by the patches.  A patch to add a/b/c where a/b
+ * is a symlink should not be allowed to affect the directory
+ * the symlink points at, but if the same patch removes a/b,
+ * it is perfectly fine, as the patch removes a/b to make room
+ * to create a directory a/b so that a/b/c can be created.
+ *
+ * See also "struct string_list symlink_changes" in "struct
+ * apply_state".
+ */
+#define APPLY_SYMLINK_GOES_AWAY 01
+#define APPLY_SYMLINK_IN_RESULT 02
+
+struct apply_state {
+	const char *prefix;
+	int prefix_length;
+
+	/* These are lock_file related */
+	struct lock_file *lock_file;
+	int newfd;
+
+	/* These control what gets looked at and modified */
+	int apply; /* this is not a dry-run */
+	int cached; /* apply to the index only */
+	int check; /* preimage must match working tree, don't actually apply */
+	int check_index; /* preimage must match the indexed version */
+	int update_index; /* check_index && apply */
+
+	/* These control cosmetic aspect of the output */
+	int diffstat; /* just show a diffstat, and don't actually apply */
+	int numstat; /* just show a numeric diffstat, and don't actually apply */
+	int summary; /* just report creation, deletion, etc, and don't actually apply */
+
+	/* These boolean parameters control how the apply is done */
+	int allow_overlap;
+	int apply_in_reverse;
+	int apply_with_reject;
+	int apply_verbosely;
+	int no_add;
+	int threeway;
+	int unidiff_zero;
+	int unsafe_paths;
+
+	/* Other non boolean parameters */
+	const char *fake_ancestor;
+	const char *patch_input_file;
+	int line_termination;
+	struct strbuf root;
+	int p_value;
+	int p_value_known;
+	unsigned int p_context;
+
+	/* Exclude and include path parameters */
+	struct string_list limit_by_name;
+	int has_include;
+
+	/* Various "current state" */
+	int linenr; /* current line number */
+	struct string_list symlink_changes; /* we have to track symlinks */
+
+	/*
+	 * For "diff-stat" like behaviour, we keep track of the biggest change
+	 * we've seen, and the longest filename. That allows us to do simple
+	 * scaling.
+	 */
+	int max_change;
+	int max_len;
+
+	/*
+	 * Records filenames that have been touched, in order to handle
+	 * the case where more than one patches touch the same file.
+	 */
+	struct string_list fn_table;
+
+	/* These control whitespace errors */
+	enum apply_ws_error_action ws_error_action;
+	enum apply_ws_ignore ws_ignore_action;
+	const char *whitespace_option;
+	int whitespace_error;
+	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
+};
+
+#endif
diff --git a/builtin/apply.c b/builtin/apply.c
index ab8f0bd..ed923ca 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -20,103 +20,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "rerere.h"
-
-enum apply_ws_error_action {
-	nowarn_ws_error,
-	warn_on_ws_error,
-	die_on_ws_error,
-	correct_ws_error
-};
-
-
-enum apply_ws_ignore {
-	ignore_ws_none,
-	ignore_ws_change
-};
-
-/*
- * We need to keep track of how symlinks in the preimage are
- * manipulated by the patches.  A patch to add a/b/c where a/b
- * is a symlink should not be allowed to affect the directory
- * the symlink points at, but if the same patch removes a/b,
- * it is perfectly fine, as the patch removes a/b to make room
- * to create a directory a/b so that a/b/c can be created.
- *
- * See also "struct string_list symlink_changes" in "struct
- * apply_state".
- */
-#define APPLY_SYMLINK_GOES_AWAY 01
-#define APPLY_SYMLINK_IN_RESULT 02
-
-struct apply_state {
-	const char *prefix;
-	int prefix_length;
-
-	/* These are lock_file related */
-	struct lock_file *lock_file;
-	int newfd;
-
-	/* These control what gets looked at and modified */
-	int apply; /* this is not a dry-run */
-	int cached; /* apply to the index only */
-	int check; /* preimage must match working tree, don't actually apply */
-	int check_index; /* preimage must match the indexed version */
-	int update_index; /* check_index && apply */
-
-	/* These control cosmetic aspect of the output */
-	int diffstat; /* just show a diffstat, and don't actually apply */
-	int numstat; /* just show a numeric diffstat, and don't actually apply */
-	int summary; /* just report creation, deletion, etc, and don't actually apply */
-
-	/* These boolean parameters control how the apply is done */
-	int allow_overlap;
-	int apply_in_reverse;
-	int apply_with_reject;
-	int apply_verbosely;
-	int no_add;
-	int threeway;
-	int unidiff_zero;
-	int unsafe_paths;
-
-	/* Other non boolean parameters */
-	const char *fake_ancestor;
-	const char *patch_input_file;
-	int line_termination;
-	struct strbuf root;
-	int p_value;
-	int p_value_known;
-	unsigned int p_context;
-
-	/* Exclude and include path parameters */
-	struct string_list limit_by_name;
-	int has_include;
-
-	/* Various "current state" */
-	int linenr; /* current line number */
-	struct string_list symlink_changes; /* we have to track symlinks */
-
-	/*
-	 * For "diff-stat" like behaviour, we keep track of the biggest change
-	 * we've seen, and the longest filename. That allows us to do simple
-	 * scaling.
-	 */
-	int max_change;
-	int max_len;
-
-	/*
-	 * Records filenames that have been touched, in order to handle
-	 * the case where more than one patches touch the same file.
-	 */
-	struct string_list fn_table;
-
-	/* These control whitespace errors */
-	enum apply_ws_error_action ws_error_action;
-	enum apply_ws_ignore ws_ignore_action;
-	const char *whitespace_option;
-	int whitespace_error;
-	int squelch_whitespace_errors;
-	int applied_after_fixing_ws;
-};
+#include "apply.h"
 
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
-- 
2.10.0.41.g9df52c3

