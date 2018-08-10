Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48D51F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeHKAqS (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:18 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:40711 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKAqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:18 -0400
Received: by mail-pg1-f180.google.com with SMTP id x5-v6so4983708pgp.7
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MsiHElqo548hiUyk466A29eRKqCmW66NbvSF0V/NyHo=;
        b=LxzWvgyY0fxU2L4jxDMAqn8y1pe72ulyvp+PKR8BKWsiagZEh75CKeigy63GxPxe0E
         4T57k5UFKj+AhiFyg6d8n0kaNfDhyU+v6LMa880GLPdwkIQ/u6Xn7wPqUml8Qgfx3R70
         7e6SqNrhTYJKulzUERVwWKaf7S29Veyew3Fzrt/vnX1iEO8PXlrZtCJhyie5+wsQIYgj
         maalURVumygmuGJgGXC0ILxeIfZ7iYayK8YJDd/zWquEUnf24fAmV7DFE2WoeN2Dcb2j
         8GnREPrkAbY0+J9161+rsayZs+a7na8Fw4I9NgiTV/aMAnrv2tOXQW+6mbEXIw1Zb4gS
         ihcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MsiHElqo548hiUyk466A29eRKqCmW66NbvSF0V/NyHo=;
        b=OwhJT1/fkBxAnfazpiEChzbuzczsGa4z6f7KlZecFJA56IZXEKgdbI81oxdFMWJK4E
         GnTPxYiv0p1MRxW5DTZYuVM3KNwR6YrSfo/xLx2cs4KocQt7QOAwUwFZFVykdab/KTjs
         ejKBUzHxVDh/1Wj4CpRzWP1S+BAjomPB18ifo3AJw1gZ3xJjV0LxvybshKcbOpq1tCdP
         armd6Z6KXcbs+U/gu1JtmeUiuVxL+scC/8QqLDc870SpgF5vhqe8Yh+i4moEL2Kfoelm
         S7U7Vv0maXzxd3hr0kYWalA6EvdeaYS9L7E3ZYBtEJ3kyHSY2BKQ8r3+fDPu2SNPM3H9
         YjuA==
X-Gm-Message-State: AOUpUlFiK3tOu8Wdo7Os7TvtR3hk6qwYoODp/wycvP+ISZq5HhZ+8kYo
        b1MRfDdLBxw57sAvjySErH15d6bc
X-Google-Smtp-Source: AA+uWPwAMawACK3xXWV4bF03PD/MMG/jVc/d7ZGWBIjhvJmYBfSAfDDKZ/SBFUMWBypPSrUVVs2olg==
X-Received: by 2002:a63:844:: with SMTP id 65-v6mr8300439pgi.406.1533939270860;
        Fri, 10 Aug 2018 15:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id f67-v6sm22228143pfe.75.2018.08.10.15.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:30 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:30 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:05 GMT
Message-Id: <08b8c3fc45253737ef6ca860e6cbe3ee6211d7a6.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 03/21] range-diff: first rudimentary implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

At this stage, `git range-diff` can determine corresponding commits
of two related commit ranges. This makes use of the recently introduced
implementation of the linear assignment algorithm.

The core of this patch is a straight port of the ideas of tbdiff, the
apparently dormant project at https://github.com/trast/tbdiff.

The output does not at all match `tbdiff`'s output yet, as this patch
really concentrates on getting the patch matching part right.

Note: due to differences in the diff algorithm (`tbdiff` uses the Python
module `difflib`, Git uses its xdiff fork), the cost matrix calculated
by `range-diff` is different (but very similar) to the one calculated
by `tbdiff`. Therefore, it is possible that they find different matching
commits in corner cases (e.g. when a patch was split into two patches of
roughly equal length).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile             |   1 +
 builtin/range-diff.c |  45 ++++++-
 range-diff.c         | 311 +++++++++++++++++++++++++++++++++++++++++++
 range-diff.h         |   7 +
 4 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 range-diff.c
 create mode 100644 range-diff.h

diff --git a/Makefile b/Makefile
index 7ff7eba42..72f16882e 100644
--- a/Makefile
+++ b/Makefile
@@ -925,6 +925,7 @@ LIB_OBJS += progress.o
 LIB_OBJS += prompt.o
 LIB_OBJS += protocol.o
 LIB_OBJS += quote.o
+LIB_OBJS += range-diff.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 36788ea4f..94c1f362c 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "range-diff.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -17,9 +18,51 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 			    N_("Percentage by which creation is weighted")),
 		OPT_END()
 	};
+	int res = 0;
+	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     builtin_range_diff_usage, 0);
 
-	return 0;
+	if (argc == 2) {
+		if (!strstr(argv[0], ".."))
+			die(_("no .. in range: '%s'"), argv[0]);
+		strbuf_addstr(&range1, argv[0]);
+
+		if (!strstr(argv[1], ".."))
+			die(_("no .. in range: '%s'"), argv[1]);
+		strbuf_addstr(&range2, argv[1]);
+	} else if (argc == 3) {
+		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
+		strbuf_addf(&range2, "%s..%s", argv[0], argv[2]);
+	} else if (argc == 1) {
+		const char *b = strstr(argv[0], "..."), *a = argv[0];
+		int a_len;
+
+		if (!b) {
+			error(_("single arg format must be symmetric range"));
+			usage_with_options(builtin_range_diff_usage, options);
+		}
+
+		a_len = (int)(b - a);
+		if (!a_len) {
+			a = "HEAD";
+			a_len = strlen(a);
+		}
+		b += 3;
+		if (!*b)
+			b = "HEAD";
+		strbuf_addf(&range1, "%s..%.*s", b, a_len, a);
+		strbuf_addf(&range2, "%.*s..%s", a_len, a, b);
+	} else {
+		error(_("need two commit ranges"));
+		usage_with_options(builtin_range_diff_usage, options);
+	}
+
+	res = show_range_diff(range1.buf, range2.buf, creation_factor);
+
+	strbuf_release(&range1);
+	strbuf_release(&range2);
+
+	return res;
 }
diff --git a/range-diff.c b/range-diff.c
new file mode 100644
index 000000000..15d418afa
--- /dev/null
+++ b/range-diff.c
@@ -0,0 +1,311 @@
+#include "cache.h"
+#include "range-diff.h"
+#include "string-list.h"
+#include "run-command.h"
+#include "argv-array.h"
+#include "hashmap.h"
+#include "xdiff-interface.h"
+#include "linear-assignment.h"
+
+struct patch_util {
+	/* For the search for an exact match */
+	struct hashmap_entry e;
+	const char *diff, *patch;
+
+	int i;
+	int diffsize;
+	size_t diff_offset;
+	/* the index of the matching item in the other branch, or -1 */
+	int matching;
+	struct object_id oid;
+};
+
+/*
+ * Reads the patches into a string list, with the `util` field being populated
+ * as struct object_id (will need to be free()d).
+ */
+static int read_patches(const char *range, struct string_list *list)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	FILE *in;
+	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
+	struct patch_util *util = NULL;
+	int in_header = 1;
+
+	argv_array_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
+			"--reverse", "--date-order", "--decorate=no",
+			"--no-abbrev-commit", range,
+			NULL);
+	cp.out = -1;
+	cp.no_stdin = 1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		return error_errno(_("could not start `log`"));
+	in = fdopen(cp.out, "r");
+	if (!in) {
+		error_errno(_("could not read `log` output"));
+		finish_command(&cp);
+		return -1;
+	}
+
+	while (strbuf_getline(&line, in) != EOF) {
+		const char *p;
+
+		if (skip_prefix(line.buf, "commit ", &p)) {
+			if (util) {
+				string_list_append(list, buf.buf)->util = util;
+				strbuf_reset(&buf);
+			}
+			util = xcalloc(sizeof(*util), 1);
+			if (get_oid(p, &util->oid)) {
+				error(_("could not parse commit '%s'"), p);
+				free(util);
+				string_list_clear(list, 1);
+				strbuf_release(&buf);
+				strbuf_release(&line);
+				fclose(in);
+				finish_command(&cp);
+				return -1;
+			}
+			util->matching = -1;
+			in_header = 1;
+			continue;
+		}
+
+		if (starts_with(line.buf, "diff --git")) {
+			in_header = 0;
+			strbuf_addch(&buf, '\n');
+			if (!util->diff_offset)
+				util->diff_offset = buf.len;
+			strbuf_addbuf(&buf, &line);
+		} else if (in_header) {
+			if (starts_with(line.buf, "Author: ")) {
+				strbuf_addbuf(&buf, &line);
+				strbuf_addstr(&buf, "\n\n");
+			} else if (starts_with(line.buf, "    ")) {
+				strbuf_addbuf(&buf, &line);
+				strbuf_addch(&buf, '\n');
+			}
+			continue;
+		} else if (starts_with(line.buf, "@@ "))
+			strbuf_addstr(&buf, "@@");
+		else if (!line.buf[0] || starts_with(line.buf, "index "))
+			/*
+			 * A completely blank (not ' \n', which is context)
+			 * line is not valid in a diff.  We skip it
+			 * silently, because this neatly handles the blank
+			 * separator line between commits in git-log
+			 * output.
+			 *
+			 * We also want to ignore the diff's `index` lines
+			 * because they contain exact blob hashes in which
+			 * we are not interested.
+			 */
+			continue;
+		else
+			strbuf_addbuf(&buf, &line);
+
+		strbuf_addch(&buf, '\n');
+		util->diffsize++;
+	}
+	fclose(in);
+	strbuf_release(&line);
+
+	if (util)
+		string_list_append(list, buf.buf)->util = util;
+	strbuf_release(&buf);
+
+	if (finish_command(&cp))
+		return -1;
+
+	return 0;
+}
+
+static int patch_util_cmp(const void *dummy, const struct patch_util *a,
+		     const struct patch_util *b, const char *keydata)
+{
+	return strcmp(a->diff, keydata ? keydata : b->diff);
+}
+
+static void find_exact_matches(struct string_list *a, struct string_list *b)
+{
+	struct hashmap map;
+	int i;
+
+	hashmap_init(&map, (hashmap_cmp_fn)patch_util_cmp, NULL, 0);
+
+	/* First, add the patches of a to a hash map */
+	for (i = 0; i < a->nr; i++) {
+		struct patch_util *util = a->items[i].util;
+
+		util->i = i;
+		util->patch = a->items[i].string;
+		util->diff = util->patch + util->diff_offset;
+		hashmap_entry_init(util, strhash(util->diff));
+		hashmap_add(&map, util);
+	}
+
+	/* Now try to find exact matches in b */
+	for (i = 0; i < b->nr; i++) {
+		struct patch_util *util = b->items[i].util, *other;
+
+		util->i = i;
+		util->patch = b->items[i].string;
+		util->diff = util->patch + util->diff_offset;
+		hashmap_entry_init(util, strhash(util->diff));
+		other = hashmap_remove(&map, util, NULL);
+		if (other) {
+			if (other->matching >= 0)
+				BUG("already assigned!");
+
+			other->matching = i;
+			util->matching = other->i;
+		}
+	}
+
+	hashmap_free(&map, 0);
+}
+
+static void diffsize_consume(void *data, char *line, unsigned long len)
+{
+	(*(int *)data)++;
+}
+
+static int diffsize(const char *a, const char *b)
+{
+	xpparam_t pp = { 0 };
+	xdemitconf_t cfg = { 0 };
+	mmfile_t mf1, mf2;
+	int count = 0;
+
+	mf1.ptr = (char *)a;
+	mf1.size = strlen(a);
+	mf2.ptr = (char *)b;
+	mf2.size = strlen(b);
+
+	cfg.ctxlen = 3;
+	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
+		return count;
+
+	error(_("failed to generate diff"));
+	return COST_MAX;
+}
+
+static void get_correspondences(struct string_list *a, struct string_list *b,
+				int creation_factor)
+{
+	int n = a->nr + b->nr;
+	int *cost, c, *a2b, *b2a;
+	int i, j;
+
+	ALLOC_ARRAY(cost, st_mult(n, n));
+	ALLOC_ARRAY(a2b, n);
+	ALLOC_ARRAY(b2a, n);
+
+	for (i = 0; i < a->nr; i++) {
+		struct patch_util *a_util = a->items[i].util;
+
+		for (j = 0; j < b->nr; j++) {
+			struct patch_util *b_util = b->items[j].util;
+
+			if (a_util->matching == j)
+				c = 0;
+			else if (a_util->matching < 0 && b_util->matching < 0)
+				c = diffsize(a_util->diff, b_util->diff);
+			else
+				c = COST_MAX;
+			cost[i + n * j] = c;
+		}
+
+		c = a_util->matching < 0 ?
+			a_util->diffsize * creation_factor / 100 : COST_MAX;
+		for (j = b->nr; j < n; j++)
+			cost[i + n * j] = c;
+	}
+
+	for (j = 0; j < b->nr; j++) {
+		struct patch_util *util = b->items[j].util;
+
+		c = util->matching < 0 ?
+			util->diffsize * creation_factor / 100 : COST_MAX;
+		for (i = a->nr; i < n; i++)
+			cost[i + n * j] = c;
+	}
+
+	for (i = a->nr; i < n; i++)
+		for (j = b->nr; j < n; j++)
+			cost[i + n * j] = 0;
+
+	compute_assignment(n, n, cost, a2b, b2a);
+
+	for (i = 0; i < a->nr; i++)
+		if (a2b[i] >= 0 && a2b[i] < b->nr) {
+			struct patch_util *a_util = a->items[i].util;
+			struct patch_util *b_util = b->items[a2b[i]].util;
+
+			a_util->matching = a2b[i];
+			b_util->matching = i;
+		}
+
+	free(cost);
+	free(a2b);
+	free(b2a);
+}
+
+static const char *short_oid(struct patch_util *util)
+{
+	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+}
+
+static void output(struct string_list *a, struct string_list *b)
+{
+	int i;
+
+	for (i = 0; i < b->nr; i++) {
+		struct patch_util *util = b->items[i].util, *prev;
+
+		if (util->matching < 0)
+			printf("-: -------- > %d: %s\n",
+					i + 1, short_oid(util));
+		else {
+			prev = a->items[util->matching].util;
+			printf("%d: %s ! %d: %s\n",
+			       util->matching + 1, short_oid(prev),
+			       i + 1, short_oid(util));
+		}
+	}
+
+	for (i = 0; i < a->nr; i++) {
+		struct patch_util *util = a->items[i].util;
+
+		if (util->matching < 0)
+			printf("%d: %s < -: --------\n",
+			       i + 1, short_oid(util));
+	}
+}
+
+int show_range_diff(const char *range1, const char *range2,
+		    int creation_factor)
+{
+	int res = 0;
+
+	struct string_list branch1 = STRING_LIST_INIT_DUP;
+	struct string_list branch2 = STRING_LIST_INIT_DUP;
+
+	if (read_patches(range1, &branch1))
+		res = error(_("could not parse log for '%s'"), range1);
+	if (!res && read_patches(range2, &branch2))
+		res = error(_("could not parse log for '%s'"), range2);
+
+	if (!res) {
+		find_exact_matches(&branch1, &branch2);
+		get_correspondences(&branch1, &branch2, creation_factor);
+		output(&branch1, &branch2);
+	}
+
+	string_list_clear(&branch1, 1);
+	string_list_clear(&branch2, 1);
+
+	return res;
+}
diff --git a/range-diff.h b/range-diff.h
new file mode 100644
index 000000000..7b6eef303
--- /dev/null
+++ b/range-diff.h
@@ -0,0 +1,7 @@
+#ifndef RANGE_DIFF_H
+#define RANGE_DIFF_H
+
+int show_range_diff(const char *range1, const char *range2,
+		    int creation_factor);
+
+#endif
-- 
gitgitgadget

