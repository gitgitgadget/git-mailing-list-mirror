Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1211F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbcG3RZa (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35160 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbcG3RZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so20039167wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u80iq7/zsUkvRNVwbhTiaNXF1av6latHR3XSZMVOkzQ=;
        b=mWCK9YeY0aFRwRqKmrz3ExP+iDc6QC/j+MCQ6s4AUmW03rIVDZHcLFRCOYqopvDh8X
         YY32xqq86mGgNeXB7JIVEIVpu3XCJCM4mZg5/KCrfXffHQVwHgKj93Yx1ehWmVhW9WGv
         BBAPD/xjpnzHp2C1lzaAFjzgBS5ExB/vPTeCGCSkPe2ENlIxooIZdXmtOzNx/mwmMtpk
         5UgBKiZi7rVnlU98jNR58dj5PqUtQYuxW2YEtkS4B8LCobUvJ9YgBuW0fiBFi3oeIXoc
         8U9I/v2pN0pEVB/3+MLqmrccJT0o1sh5gnVRHI/03nyYU4YLbPm8BmtcU/eAR2zTLXwk
         U+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u80iq7/zsUkvRNVwbhTiaNXF1av6latHR3XSZMVOkzQ=;
        b=d+/47K+V4E3iDoQil/Iog5dmi2qi9NoiKueHflvQxdPC2ahcgP2tPtqk2ulXh1XX5v
         +ZRRxSTZEL9KSjfhLVhonBnVrjan5ujSp8pULSasKAW9E+YFW7fLTi1sWzBuKtda0i0A
         vAUYGQMukEtFjZFsi5hRCAMZBrr/gFlWka712SRebyYaJuGogL1Le+vVYFhzGMDNV7mt
         8C7fQvxa1wEni9NkA7q9JbO/Iam4F2rXzzXrouiaQUvs3M0Wk9jBXO/G4VmqPfaeD3RA
         MJX49geyaTT4QNh//5hXAbyazm0IFSLJHwcOFc7KgGMARrPp/cff96LO4VZr48YUZnw3
         7pSg==
X-Gm-Message-State: AEkoousSU01SBILGAdm/KfMGkzgrbJeY5hEQBIhG96UJwz5HsmDhQlUe0eXlaBikZ/vTWA==
X-Received: by 10.194.192.195 with SMTP id hi3mr42829895wjc.108.1469899523480;
        Sat, 30 Jul 2016 10:25:23 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:22 -0700 (PDT)
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
Subject: [PATCH v9 02/41] apply: move 'struct apply_state' to apply.h
Date:	Sat, 30 Jul 2016 19:24:30 +0200
Message-Id: <20160730172509.22939-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
2.9.2.558.gf53e569

