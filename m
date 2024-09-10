Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C184D17ADE8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935354; cv=none; b=nSHa6ZVXW2HdL0SpPjKOnUJ9izopBrVs5vKIbmjk1xxQru2d+IRC85y6U/yNa/pxbufVqwXpkf9keeuYuuEtACP3fCJJSos8DIcAY3VzAHYqjlZlgouCS8aGiKa1huYUEUVHwaPH5jX+eH0A+6fQCph3BHHJ0kqMwgtyaDzC1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935354; c=relaxed/simple;
	bh=dR+6m0q3rgJ+G1PzzrpqW1BFtdPGHsljCvzGk2DJqAk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oCCQyWE8d3w1k4W8IN5JwMitcICdhEsEiKnvC9SSyenPaq3P2fCsfh3YCm703WO7M5LEI7Q5YjqbwwR7RsKPEXmI9GCupjb3ej1W/mZfRSE2sO+nD7ovuwB0fYtmRcioN8AQWLKgPIRRjmdL0IFYO18UuvyjJyR/Qn6H0ulqbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbW2oBDL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbW2oBDL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so453284566b.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935350; x=1726540150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ZX/8mDjkErdUuE2YO4sefyn3ZqBWJZ6++TpOw+3Wc=;
        b=NbW2oBDL5alx91XgpLTELQRB/oe2zZ76y/Rf/fTpNCNCS9hQoHFR/oQ1+Yi2xaLBch
         cNBBhU3/i/9kd0vdd9dFqJgiAXiMJzJxjR1ZyLuKSfrqDo/I1/KOB2+mdnMxOc2+MFwK
         lVLPBAPBpApramVUn64iqnWlDM6xNcLL0DI7riX8j6vJ4BES5B3DIHXrg2QnGdvc+vM5
         9nexVDV1PSWxOOizo59iCpbDh/kL9djdQXUZ0IIWPoPg2sg4fO080pQ1rKDXKlEupIeq
         P4BIl0PjNBwBJK/+GmQUL8R9fn3W4WsbWKUgc5LoRETQPvHXK76HY0yCCt++L73QFAQL
         t9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935350; x=1726540150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8ZX/8mDjkErdUuE2YO4sefyn3ZqBWJZ6++TpOw+3Wc=;
        b=t/RpVmUmuXq5C6qrMu7Zg52kRMexsUm02uJIe+M9IQzEKNbkNC6LB8WwblKSu3v7HG
         Q6jEyZfIEtGN4rLrvmQQZJYaxJTXE7JzbCIIGSO6mTuvObAXDU/RWVMbD+6pHYWEqqmM
         NRP9Hzl10DpMVbh5rqgzE79w0TQcxitMhJkr1mL0/PHAw7xoaaI6ELTcrtkZXKC0IdiP
         z+2kKw+GfLeLLj18e32JYWS8yFF5LiiGQ+V1J52UkaKFPD4hchRHd3jClepGErg0ouqC
         x+Pb5SN8yTeUGeYS+mLxEMlb/ZlamsTZZCcjCeQWyUiQheYx8v7NQ3ol9xrKYCTnS8eh
         fbZQ==
X-Gm-Message-State: AOJu0YwtiJ1oXcXUoCEsOBX9MyJ74qn7W6lRHzelWpvqAiWmI/n/cXsw
	fr05seH6ymqR6Giqn4aUKgkEfswcwYpMrThhcxuUUjsg4kbHuhWuWpuqRw==
X-Google-Smtp-Source: AGHT+IE0yNhn5PW4ZCrbWWTkemth4kCFygGabZ2g7DyG0SMgjUu1HX9ucC+FJ7pK2dRaqB7ivdzTiw==
X-Received: by 2002:a17:907:1c85:b0:a8d:2b86:d761 with SMTP id a640c23a62f3a-a8d2b86d95fmr633254066b.54.1725935350367;
        Mon, 09 Sep 2024 19:29:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a2b281sm419679766b.92.2024.09.09.19.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:10 -0700 (PDT)
Message-Id: <fcc281ac2bfabb6d19e6be40c41157612c5a3f83.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:38 +0000
Subject: [PATCH 13/30] survey: add object count summary
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

At the moment, nothing is obvious about the reason for the use of the
path-walk API, but this will become more prevelant in future iterations. For
now, use the path-walk API to sum up the counts of each kind of object.

For example, this is the reachable object summary output for my local repo:

REACHABLE OBJECT SUMMARY
========================
Object Type |  Count
------------+-------
       Tags |      0
    Commits | 178573
      Trees | 312745
      Blobs | 183035

(Note: the "Tags" are zero right now because the path-walk API has not been
integrated to walk tags yet. This will be fixed in a later change.)

RFC TODO: make sure tags are walked before this change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c      | 196 ++++++++++++++++++++++++++++++++++++++++--
 t/t8100-git-survey.sh |  26 ++++--
 2 files changed, 209 insertions(+), 13 deletions(-)

diff --git a/builtin/survey.c b/builtin/survey.c
index b2104e84d61..504b4edafce 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -1,12 +1,19 @@
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
+#include "hex.h"
 #include "object.h"
+#include "object-name.h"
 #include "object-store-ll.h"
 #include "parse-options.h"
+#include "path-walk.h"
 #include "progress.h"
 #include "ref-filter.h"
+#include "refs.h"
+#include "revision.h"
 #include "strbuf.h"
 #include "strvec.h"
+#include "tag.h"
 #include "trace2.h"
 
 static const char * const survey_usage[] = {
@@ -50,12 +57,20 @@ struct survey_report_ref_summary {
 	size_t unknown_nr;
 };
 
+struct survey_report_object_summary {
+	size_t commits_nr;
+	size_t tags_nr;
+	size_t trees_nr;
+	size_t blobs_nr;
+};
+
 /**
  * This struct contains all of the information that needs to be printed
  * at the end of the exploration of the repository and its references.
  */
 struct survey_report {
 	struct survey_report_ref_summary refs;
+	struct survey_report_object_summary reachable_objects;
 };
 
 struct survey_context {
@@ -78,10 +93,12 @@ struct survey_context {
 	size_t progress_total;
 
 	struct strvec refs;
+	struct ref_array ref_array;
 };
 
 static void clear_survey_context(struct survey_context *ctx)
 {
+	ref_array_clear(&ctx->ref_array);
 	strvec_clear(&ctx->refs);
 }
 
@@ -125,10 +142,12 @@ static void print_table_title(const char *name, size_t *widths, size_t nr)
 {
 	static struct strbuf lines = STRBUF_INIT;
 	size_t width = 0;
+	size_t min_width;
 	strbuf_setlen(&lines, 0);
 
-	strbuf_addch(&lines, ' ');
+	strbuf_addch(&lines, '\n');
 	strbuf_addstr(&lines, name);
+	min_width = lines.len - 1;
 	strbuf_addch(&lines, '\n');
 
 	for (size_t i = 0; i < nr; i++) {
@@ -136,6 +155,10 @@ static void print_table_title(const char *name, size_t *widths, size_t nr)
 			width += 3;
 		width += widths[i];
 	}
+
+	if (width < min_width)
+		width = min_width;
+
 	strbuf_addchars(&lines, '=', width);
 	printf("%s\n", lines.buf);
 }
@@ -228,11 +251,43 @@ static void survey_report_plaintext_refs(struct survey_context *ctx)
 	clear_table(&table);
 }
 
+static void survey_report_plaintext_reachable_object_summary(struct survey_context *ctx)
+{
+	struct survey_report_object_summary *objs = &ctx->report.reachable_objects;
+	struct survey_table table = SURVEY_TABLE_INIT;
+	char *fmt;
+
+	table.table_name = _("REACHABLE OBJECT SUMMARY");
+
+	strvec_push(&table.header, _("Object Type"));
+	strvec_push(&table.header, _("Count"));
+
+	fmt = xstrfmt("%"PRIuMAX"", objs->tags_nr);
+	insert_table_rowv(&table, _("Tags"), fmt, NULL);
+	free(fmt);
+
+	fmt = xstrfmt("%"PRIuMAX"", objs->commits_nr);
+	insert_table_rowv(&table, _("Commits"), fmt, NULL);
+	free(fmt);
+
+	fmt = xstrfmt("%"PRIuMAX"", objs->trees_nr);
+	insert_table_rowv(&table, _("Trees"), fmt, NULL);
+	free(fmt);
+
+	fmt = xstrfmt("%"PRIuMAX"", objs->blobs_nr);
+	insert_table_rowv(&table, _("Blobs"), fmt, NULL);
+	free(fmt);
+
+	print_table_plaintext(&table);
+	clear_table(&table);
+}
+
 static void survey_report_plaintext(struct survey_context *ctx)
 {
 	printf("GIT SURVEY for \"%s\"\n", ctx->repo->worktree);
 	printf("-----------------------------------------------------\n");
 	survey_report_plaintext_refs(ctx);
+	survey_report_plaintext_reachable_object_summary(ctx);
 }
 
 static void survey_report_json(struct survey_context *ctx)
@@ -384,15 +439,13 @@ static void do_load_refs(struct survey_context *ctx,
  */
 static void survey_phase_refs(struct survey_context *ctx)
 {
-	struct ref_array ref_array = { 0 };
-
 	trace2_region_enter("survey", "phase/refs", ctx->repo);
-	do_load_refs(ctx, &ref_array);
+	do_load_refs(ctx, &ctx->ref_array);
 
-	ctx->report.refs.refs_nr = ref_array.nr;
-	for (size_t i = 0; i < ref_array.nr; i++) {
+	ctx->report.refs.refs_nr = ctx->ref_array.nr;
+	for (size_t i = 0; i < ctx->ref_array.nr; i++) {
 		size_t size;
-		struct ref_array_item *item = ref_array.items[i];
+		struct ref_array_item *item = ctx->ref_array.items[i];
 
 		switch (item->kind) {
 		case FILTER_REFS_TAGS:
@@ -422,8 +475,133 @@ static void survey_phase_refs(struct survey_context *ctx)
 	}
 
 	trace2_region_leave("survey", "phase/refs", ctx->repo);
+}
+
+static void increment_object_counts(
+		struct survey_report_object_summary *summary,
+		enum object_type type,
+		size_t nr)
+{
+	switch (type) {
+	case OBJ_COMMIT:
+		summary->commits_nr += nr;
+		break;
+
+	case OBJ_TREE:
+		summary->trees_nr += nr;
+		break;
+
+	case OBJ_BLOB:
+		summary->blobs_nr += nr;
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int survey_objects_path_walk_fn(const char *path,
+				       struct oid_array *oids,
+				       enum object_type type,
+				       void *data)
+{
+	struct survey_context *ctx = data;
+
+	increment_object_counts(&ctx->report.reachable_objects,
+				type, oids->nr);
+
+	return 0;
+}
+
+static int iterate_tag_chain(struct survey_context *ctx,
+			     struct object_id *oid,
+			     struct object_id *peeled)
+{
+	struct object *o = lookup_unknown_object(ctx->repo, oid);
+	struct tag *t;
+
+	if (o->type != OBJ_TAG) {
+		oidcpy(peeled, &o->oid);
+		return o->type != OBJ_COMMIT;
+	}
+
+	t = lookup_tag(ctx->repo, oid);
+	while (t) {
+		parse_tag(t);
+		ctx->report.reachable_objects.tags_nr++;
+
+		if (!t->tagged)
+			break;
+
+		o = lookup_unknown_object(ctx->repo, &t->tagged->oid);
+		if (o && o->type == OBJ_TAG)
+			t = lookup_tag(ctx->repo, &t->tagged->oid);
+		else
+			break;
+	}
+
+	if (!t || !t->tagged)
+		return -1;
 
-	ref_array_clear(&ref_array);
+	oidcpy(peeled, &t->tagged->oid);
+	o = lookup_unknown_object(ctx->repo, peeled);
+	if (o && o->type == OBJ_COMMIT)
+		return 0;
+	return -1;
+}
+
+static void survey_phase_objects(struct survey_context *ctx)
+{
+	struct rev_info revs = REV_INFO_INIT;
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	unsigned int add_flags = 0;
+
+	trace2_region_enter("survey", "phase/objects", ctx->repo);
+
+	info.revs = &revs;
+	info.path_fn = survey_objects_path_walk_fn;
+	info.path_fn_data = ctx;
+
+	info.commits = 1;
+	info.trees = 1;
+	info.blobs = 1;
+	info.tags = 1;
+
+	repo_init_revisions(ctx->repo, &revs, "");
+
+	for (size_t i = 0; i < ctx->ref_array.nr; i++) {
+		struct ref_array_item *item = ctx->ref_array.items[i];
+		struct object_id peeled;
+
+		switch (item->kind) {
+		case FILTER_REFS_TAGS:
+			if (!iterate_tag_chain(ctx, &item->objectname, &peeled))
+				add_pending_oid(&revs, NULL, &peeled, add_flags);
+			break;
+		case FILTER_REFS_BRANCHES:
+			add_pending_oid(&revs, NULL, &item->objectname, add_flags);
+			break;
+		case FILTER_REFS_REMOTES:
+			add_pending_oid(&revs, NULL, &item->objectname, add_flags);
+			break;
+		case FILTER_REFS_OTHERS:
+			/*
+			 * This may be a note, stash, or custom namespace branch.
+			 */
+			add_pending_oid(&revs, NULL, &item->objectname, add_flags);
+			break;
+		case FILTER_REFS_DETACHED_HEAD:
+			add_pending_oid(&revs, NULL, &item->objectname, add_flags);
+			break;
+		default:
+			break;
+		}
+	}
+
+	walk_objects_by_path(&info);
+
+	release_revisions(&revs);
+	trace2_region_leave("survey", "phase/objects", ctx->repo);
 }
 
 int cmd_survey(int argc, const char **argv, const char *prefix)
@@ -474,6 +652,8 @@ int cmd_survey(int argc, const char **argv, const char *prefix)
 
 	survey_phase_refs(&ctx);
 
+	survey_phase_objects(&ctx);
+
 	switch (ctx.opts.format) {
 	case SURVEY_PLAINTEXT:
 		survey_report_plaintext(&ctx);
diff --git a/t/t8100-git-survey.sh b/t/t8100-git-survey.sh
index a57f6ca7a59..0da92eafa95 100755
--- a/t/t8100-git-survey.sh
+++ b/t/t8100-git-survey.sh
@@ -16,24 +16,40 @@ test_expect_success 'git survey -h shows experimental warning' '
 '
 
 test_expect_success 'creat a semi-interesting repo' '
-	test_commit_bulk 10
+	test_commit_bulk 10 &&
+	git tag -a -m one one HEAD~5 &&
+	git tag -a -m two two HEAD~3 &&
+	git tag -a -m three three two &&
+	git tag -a -m four four three &&
+	git update-ref -d refs/tags/three &&
+	git update-ref -d refs/tags/two
 '
 
 test_expect_success 'git survey (default)' '
-	git survey >out 2>err &&
+	git survey --all-refs >out 2>err &&
 	test_line_count = 0 err &&
 
 	cat >expect <<-EOF &&
 	GIT SURVEY for "$(pwd)"
 	-----------------------------------------------------
-	 REFERENCES SUMMARY
+
+	REFERENCES SUMMARY
 	========================
 	        Ref Type | Count
 	-----------------+------
 	        Branches |     1
 	     Remote refs |     0
-	      Tags (all) |     0
-	Tags (annotated) |     0
+	      Tags (all) |     2
+	Tags (annotated) |     2
+
+	REACHABLE OBJECT SUMMARY
+	========================
+	Object Type | Count
+	------------+------
+	       Tags |     0
+	    Commits |    10
+	      Trees |    10
+	      Blobs |    10
 	EOF
 
 	test_cmp expect out
-- 
gitgitgadget

