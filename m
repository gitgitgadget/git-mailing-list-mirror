Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1832018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbcF0SZR (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34489 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbcF0SZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so26959183wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:24:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fi7NRhTC3OyeGpFGdV+rDM7WogCIWZWCvhzVAuyvFg0=;
        b=wt5Osf7FCMe9WSwJUgaCqX2IrjDxF0VkmgHzdQETi0VM8kleS0/J3ASD9RfEoERpzB
         whw3xvUeHTqV/WwlI41LuqXF3y4q57VqPW6fzQXIqWJxaq2F4X9LVb0L8GidOpxOhfQj
         c38KCTRa2SGUWoo+eqCsk77fw1zr3gYlYPUGwDBWPuTNhyqiwOGpoZNGE98Jbteh1zJG
         7wF3irG/u0g1lDYQbW5bpoSeBKPv76MawEIEAkaUamCy/kQB7CTSWuQUuzm5B/1taMii
         bZKx5aqOjIv9n3Y0kPx31xABnO5AMGPPzvq/+xe5dUC/yZubRQMw4BsK6TU/PgYVa3M4
         B6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fi7NRhTC3OyeGpFGdV+rDM7WogCIWZWCvhzVAuyvFg0=;
        b=SccdhniaNWz0zVq83IlJemCgCtdYyVzhPuAOET8ytD+1+UwiSnmqKE9L+zBRHEJ7qv
         pL5PnQerIHS6tVZ4iqgrY68M9cXT0vxV/r9b2mXURA58UlDudl7m90XdaVom5SsXB1cl
         VOvggW3Uz+69VbskcH0/MruPvhrYpuP4l5k1WgB0r6F0AjpNepiWQ08qIBkaCVbUkwDw
         mcQmutza51sFouptTukhFYqpkPZDTKHTKlyFqs2oMsovDZSoFQgJ1L6+GoPnnkGKUT30
         BXgZkjxrLJ8eVhdozvPqrzx9j7Fmm7WX3/qe+HmelDwbnWiLI65Mdrd0EVkHW5VTVHca
         O10g==
X-Gm-Message-State: ALyK8tLRRhgZ68L61h7gnresc+SBghnEAeNG8e6lpb7S+SK9glMuDut6mx0EJFToFTcjiA==
X-Received: by 10.194.175.231 with SMTP id cd7mr2145439wjc.19.1467051892851;
        Mon, 27 Jun 2016 11:24:52 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:24:51 -0700 (PDT)
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
Subject: [PATCH v8 02/41] apply: move 'struct apply_state' to apply.h
Date:	Mon, 27 Jun 2016 20:23:50 +0200
Message-Id: <20160627182429.31550-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index c4d9396..ad216d3 100644
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
2.9.0.172.gfb57a78

