Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F481F404
	for <e@80x24.org>; Thu, 28 Dec 2017 00:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbdL1AAR (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 19:00:17 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:36838 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752670AbdL1AAM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 19:00:12 -0500
Received: by mail-io0-f182.google.com with SMTP id i143so16676681ioa.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 16:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kT57hPF4Qntl+l7qjCuFO9G2+bTt2EDJFXHO7r6Bwhg=;
        b=EtzoyXG8iLOf68tuh/SlLBkDiEo2ICD3R/hP8liY9CyzJ2eqvPM+VYVhLjE/ysXCuj
         WKA0gjbplGTIYJpEr2fyC4iMCjE07F1KX3zHI1zIaOsBpzWNE2SDu0A8PCiAJfITbdRe
         Jd1fgmCO8KEKPNxFWVOnEC0cqM58+nJo13jBt2LGZWwfTqpIRUJPMJQv56Yci9WyGYu7
         qv25u12IfkVKOwr9v/JUi1CcD9bzALXNPZEA9aYhx026gj6tuciARtOpYuXS4o+MrDy/
         DMXPamMPdOMdPax5hwuiwtgfoUgPa99j8VbH+EsL04hdrnkfGaRue6NQADzFhwaoMNYP
         eVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kT57hPF4Qntl+l7qjCuFO9G2+bTt2EDJFXHO7r6Bwhg=;
        b=QD57PHiPQ23QtbUSQhEw1iE8NdxGB5gWKL/b9yTbvh9jEGR/JtJEWiF6O6oCsciCNv
         TVlGXDizh4Fv0UBqvz7ngGJC91/6K37bRvRKLCu9nTir9NFnBYe1lYy6/1lE821ePhjb
         HkmOwDJPmIYI3SvQrFfHG+4y7ZOMGbm0mkaJSr+BBO2zUha8AxN0JUcNsP2M/RDkK1Cg
         aVuE6puTuge6AKIBfpPo+gjzmYVqLOMwsraOrk2WOBS84PxbiNDGWBQ2v5c+8j0FdQgb
         bjbhlagJFyGWylqJD08LZu1AMsaAlGw8j4IbkMaWlNF3Y/OEtlN4Q2NPzUf4frb9WDP+
         IGxQ==
X-Gm-Message-State: AKGB3mJTiAlnIwViNu5m8EqmnxJHf6+G5lY5zCNWX6VWPLBWwyBrJia7
        0q8DDe4CrKlavOPGdvSvIMZ1hQSTux4=
X-Google-Smtp-Source: ACJfBovUhyunUDSPTWsuKl8FtwdVX6wxkZi5DbwhlgYg1xEM4UwNHDra4xIMQMtTlFWFW4O3+RqbSw==
X-Received: by 10.107.82.9 with SMTP id g9mr19287242iob.187.1514419211134;
        Wed, 27 Dec 2017 16:00:11 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g187sm11214723itb.29.2017.12.27.16.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 16:00:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/1] Add blob find pickaxe option
Date:   Wed, 27 Dec 2017 16:00:02 -0800
Message-Id: <20171228000003.34539-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend for sb/diff-blobfind, but now the option --find-object
is a native of the pickaxe family.

Stefan Beller (1):
  diffcore: add a pickaxe option to find a specific blob

 Documentation/diff-options.txt | 10 +++++++
 diff.c                         | 21 ++++++++++++-
 diff.h                         |  3 ++
 diffcore-pickaxe.c             | 14 +++++++--
 revision.c                     |  3 ++
 t/t4064-diff-oidfind.sh        | 68 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 115 insertions(+), 4 deletions(-)
 create mode 100755 t/t4064-diff-oidfind.sh

-- 
2.15.1.620.gb9897f4670-goog

diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
index 21d1776996..f9cf85db05 100644
--- c/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -492,6 +492,15 @@ occurrences of that string did not change).
 See the 'pickaxe' entry in linkgit:gitdiffcore[7] for more
 information.
 
+--find-object=<object-id>::
+	Look for differences that change the number of occurrences of
+	the specified object. Similar to `-S`, just the argument is different
+	in that it doesn't search for a specific string but for a specific
+	object id.
++
+The object can be a blob or a submodule commit. It implies the `-t` option in
+`git-log` to also find trees.
+
 --pickaxe-all::
 	When `-S` or `-G` finds a change, show all the changes in that
 	changeset, not just the files that contain the change
@@ -501,11 +510,6 @@ information.
 	Treat the <string> given to `-S` as an extended POSIX regular
 	expression to match.
 
---find-object=<object-id>::
-	Restrict the output such that one side of the diff
-	matches the given object id. The object can be a blob,
-	gitlink entry or tree (when `-t` is given).
-
 endif::git-format-patch[]
 
 -O<orderfile>::
diff --git c/Makefile w/Makefile
index c26596c30a..ee9d5eb11e 100644
--- c/Makefile
+++ w/Makefile
@@ -775,7 +775,6 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-objfind.o
 LIB_OBJS += diffcore-order.o
 LIB_OBJS += diffcore-pickaxe.o
 LIB_OBJS += diffcore-rename.o
diff --git c/builtin/log.c w/builtin/log.c
index 08ea82d69f..6c1fa896ad 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    rev->diffopt.flags.follow_renames || rev->diffopt.objfind)
+	    rev->diffopt.flags.follow_renames)
 		rev->always_show_header = 0;
 
 	if (source)
diff --git c/diff.c w/diff.c
index e13b8229d3..7acddaaee7 100644
--- c/diff.c
+++ w/diff.c
@@ -4497,6 +4497,10 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 
 	if (!opt->objfind)
 		opt->objfind = xcalloc(1, sizeof(*opt->objfind));
+
+	opt->pickaxe = ""; /* trigger pickaxe */
+	opt->flags.recursive = 1;
+	opt->flags.tree_in_recursive = 1;
 	oidset_insert(opt->objfind, &oid);
 	return 1;
 }
@@ -5785,9 +5789,6 @@ void diffcore_std(struct diff_options *options)
 		diffcore_skip_stat_unmatch(options);
 	if (!options->found_follow) {
 		/* See try_to_follow_renames() in tree-diff.c */
-
-		if (options->objfind)
-			diffcore_objfind(options);
 		if (options->break_opt != -1)
 			diffcore_break(options->break_opt);
 		if (options->detect_rename)
diff --git c/diffcore-objfind.c w/diffcore-objfind.c
deleted file mode 100644
index 676bbfff00..0000000000
--- c/diffcore-objfind.c
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (c) 2017 Google Inc.
- */
-#include "cache.h"
-#include "diff.h"
-#include "diffcore.h"
-
-static void diffcore_filter_blobs(struct diff_queue_struct *q,
-				  struct diff_options *options)
-{
-	int src, dst;
-
-	if (!options->objfind)
-		BUG("objfind oidset not initialized???");
-
-	for (src = dst = 0; src < q->nr; src++) {
-		struct diff_filepair *p = q->queue[src];
-
-		if (!DIFF_PAIR_UNMERGED(p) &&
-		    ((DIFF_FILE_VALID(p->one) &&
-		     oidset_contains(options->objfind, &p->one->oid)) ||
-		    (DIFF_FILE_VALID(p->two) &&
-		     oidset_contains(options->objfind, &p->two->oid)))) {
-			q->queue[dst] = p;
-			dst++;
-		} else {
-			diff_free_filepair(p);
-		}
-	}
-
-	if (!dst) {
-		free(q->queue);
-		DIFF_QUEUE_CLEAR(q);
-	} else {
-		q->nr = dst;
-	}
-}
-
-void diffcore_objfind(struct diff_options *options)
-{
-	diffcore_filter_blobs(&diff_queued_diff, options);
-}
diff --git c/diffcore-pickaxe.c w/diffcore-pickaxe.c
index 9476bd2108..0d0c697ae7 100644
--- c/diffcore-pickaxe.c
+++ w/diffcore-pickaxe.c
@@ -124,13 +124,21 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mmfile_t mf1, mf2;
 	int ret;
 
-	if (!o->pickaxe[0])
-		return 0;
-
 	/* ignore unmerged */
 	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
 		return 0;
 
+	if (o->objfind) {
+		if ((DIFF_FILE_VALID(p->one) &&
+		     oidset_contains(o->objfind, &p->one->oid)) ||
+		    (DIFF_FILE_VALID(p->two) &&
+		     oidset_contains(o->objfind, &p->two->oid)))
+			return 1;
+	}
+
+	if (!o->pickaxe[0])
+		return 0;
+
 	if (o->flags.allow_textconv) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
diff --git c/diffcore.h w/diffcore.h
index cbde777bdd..a30da161da 100644
--- c/diffcore.h
+++ w/diffcore.h
@@ -107,7 +107,6 @@ extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
 					struct diff_filespec *);
 extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
 
-extern void diffcore_objfind(struct diff_options *);
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
 extern void diffcore_merge_broken(void);
diff --git c/revision.c w/revision.c
index 0a797bdfc7..43bb6265cd 100644
--- c/revision.c
+++ w/revision.c
@@ -2409,10 +2409,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
-	    revs->diffopt.flags.follow_renames ||
-	    revs->diffopt.objfind)
+	    revs->diffopt.flags.follow_renames)
 		revs->diff = 1;
 
+	if (revs->diffopt.objfind)
+		revs->simplify_history = 0;
+
 	if (revs->topo_order)
 		revs->limited = 1;
 
@@ -2884,8 +2886,6 @@ int prepare_revision_walk(struct rev_info *revs)
 		simplify_merges(revs);
 	if (revs->children.name)
 		set_children(revs);
-	if (revs->diffopt.objfind)
-		revs->simplify_history = 0;
 	return 0;
 }
 
diff --git c/t/helper/test-lazy-init-name-hash.c w/t/helper/test-lazy-init-name-hash.c
index 6368a89345..297fb01d61 100644
--- c/t/helper/test-lazy-init-name-hash.c
+++ w/t/helper/test-lazy-init-name-hash.c
@@ -112,7 +112,7 @@ static void analyze_run(void)
 {
 	uint64_t t1s, t1m, t2s, t2m;
 	int cache_nr_limit;
-	int nr_threads_used;
+	int nr_threads_used = 0;
 	int i;
 	int nr;
 
