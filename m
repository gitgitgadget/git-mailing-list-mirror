Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65AAC1F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750991AbeEMFwR (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34595 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeEMFwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id r25-v6so13380002lfd.1
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbH9U8wSb0Psxlr53KDprrjVX6u/qkWGfXpRoEdzWtQ=;
        b=nVcXr3/khZwoslTzF9aZWMmWORDW7dDs7s/RUheRKOuluOyetQFBw3cyUev26HRC5x
         ySyJjPYGPbrac/akmwDyFwccubDU1pMfsNnSee4nd6vvywyHM3m1IH2tPFk1sp7hYjdz
         fqb14mluwRWKKdAd+Kxd2/CiDCoNmKfOX58c5HdAvUDIGidjMgzpp1xwp2U84yxMvM1k
         A3p2ZaluTLrUBw+9fEcYx9ypordtS3gAQFJBOCm3mKJxwS4iNWPA1w+7rRJkrpGZuAwN
         NQkqmSNPKpT0+XcUimKF3KpjTGmDB3I7n+Rx7Mmo6VYUrM4yY/PIutYeOy0NC5YaCTKf
         4rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbH9U8wSb0Psxlr53KDprrjVX6u/qkWGfXpRoEdzWtQ=;
        b=cM9sA8PfKPa/dRZrFBZJwI7RC6LBLdUbaRUAhb3nU1HdSADf2fXBJ608K9+Uo5P19n
         8NGfr+a82Yqo/8IMf2ChCVKSCVWjUSMK1rf5Dp2pDT91pk1O07BRf2fe6Ga863hcYVzx
         KHPCf2iOC0kA83XTI2RQonp3B92o84qee/jXKjbXKrOBYjjXTyKDxyp+fCPfVXwgeosf
         L9v7n7qpAa/N+wlLJBAWBPboITrFdFrLkCLwfBdiFfr8QIsa+xFr0S7jUB+nbyzRjEnk
         HvjORpqHAyVHGmqE9rSYQ86AWk3zlRbngXYvWK2GxV+psPzWhHCJdKYRfAfGO6nDkUfW
         j6Zg==
X-Gm-Message-State: ALKqPweD6VeaJYSmneW2/n50UGh4V6EtEOjDlN5zJ5H1E/SV2ln/w03V
        48hUEXezWNnx6aSSwQIaH8j/sw==
X-Google-Smtp-Source: AB8JxZq9T1hl3ByNRVTCbHwTNEmjHWfqZ/L+eHpX3g+wAuDX23b6KjTOTGY/c3QHR+gjSS1BrekaHA==
X-Received: by 2002:a19:910c:: with SMTP id t12-v6mr5258985lfd.29.1526190734064;
        Sat, 12 May 2018 22:52:14 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:13 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 00/14] Die commit->util, die!
Date:   Sun, 13 May 2018 07:51:54 +0200
Message-Id: <20180513055208.17952-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180512080028.29611-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 is mostly refinements with a big change: commit-slab.h is
restructured to allow sharing commit slabs. Other changes are

- rename struct source_slab to revision_sources
- keep revision_sources_* functinons (and one static variable) to
  revision.c instead of duplicating them whenver revision.h is
  included.
- reduce elemtype in commit_seen in sequencer.c from 4 bytes to 1.
- avoid dereferencing _peek in sequencer.c

Interdiff

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 092e29583e..b08e5ea0e3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -39,7 +39,7 @@ static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct refspec *refspecs;
 static int refspecs_nr;
 static int anonymize;
-static struct source_slab source_slab;
+static struct revision_sources revision_sources;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -592,7 +592,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
 			export_blob(&diff_queued_diff.queue[i]->two->oid);
 
-	refname = *source_slab_peek(&source_slab, commit);
+	refname = *revision_sources_peek(&revision_sources, commit);
 	if (anonymize) {
 		refname = anonymize_refname(refname);
 		anonymize_ident_line(&committer, &committer_end);
@@ -864,11 +864,11 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 		 * This ref will not be updated through a commit, lets make
 		 * sure it gets properly updated eventually.
 		 */
-		if (*source_slab_at(&source_slab, commit) ||
+		if (*revision_sources_at(&revision_sources, commit) ||
 		    commit->object.flags & SHOWN)
 			string_list_append(&extra_refs, full_name)->util = commit;
-		if (!*source_slab_at(&source_slab, commit))
-			*source_slab_at(&source_slab, commit) = full_name;
+		if (!*revision_sources_at(&revision_sources, commit))
+			*revision_sources_at(&revision_sources, commit) = full_name;
 	}
 }
 
@@ -1032,9 +1032,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	init_revisions(&revs, prefix);
-	init_source_slab(&source_slab);
+	init_revision_sources(&revision_sources);
 	revs.topo_order = 1;
-	revs.source_slab = &source_slab;
+	revs.sources = &revision_sources;
 	revs.rewrite_parents = 1;
 	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
 			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
diff --git a/builtin/log.c b/builtin/log.c
index b771d27164..967fbc5caa 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -149,7 +149,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 	struct decoration_filter decoration_filter = {&decorate_refs_include,
 						      &decorate_refs_exclude};
-	static struct source_slab source_slab;
+	static struct revision_sources revision_sources;
 
 	const struct option builtin_log_options[] = {
 		OPT__QUIET(&quiet, N_("suppress diff output")),
@@ -197,8 +197,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		rev->always_show_header = 0;
 
 	if (source) {
-		init_source_slab(&source_slab);
-		rev->source_slab = &source_slab;
+		init_revision_sources(&revision_sources);
+		rev->sources = &revision_sources;
 	}
 
 	if (mailmap) {
diff --git a/commit-slab-hdr.h b/commit-slab-hdr.h
new file mode 100644
index 0000000000..adc7b46c83
--- /dev/null
+++ b/commit-slab-hdr.h
@@ -0,0 +1,43 @@
+#ifndef COMMIT_SLAB_HDR_H
+#define COMMIT_SLAB_HDR_H
+
+/* allocate ~512kB at once, allowing for malloc overhead */
+#ifndef COMMIT_SLAB_SIZE
+#define COMMIT_SLAB_SIZE (512*1024-32)
+#endif
+
+#define declare_commit_slab(slabname, elemtype) 			\
+									\
+struct slabname {							\
+	unsigned slab_size;						\
+	unsigned stride;						\
+	unsigned slab_count;						\
+	elemtype **slab;						\
+}
+
+/*
+ * Statically initialize a commit slab named "var". Note that this
+ * evaluates "stride" multiple times! Example:
+ *
+ *   struct indegree indegrees = COMMIT_SLAB_INIT(1, indegrees);
+ *
+ */
+#define COMMIT_SLAB_INIT(stride, var) { \
+	COMMIT_SLAB_SIZE / sizeof(**((var).slab)) / (stride), \
+	(stride), 0, NULL \
+}
+
+#define declare_commit_slab_prototypes(slabname, elemtype)		\
+									\
+void init_ ##slabname## _with_stride(struct slabname *s, unsigned stride); \
+void init_ ##slabname(struct slabname *s);				\
+void clear_ ##slabname(struct slabname *s);				\
+elemtype *slabname## _at_peek(struct slabname *s, const struct commit *c, int add_if_missing); \
+elemtype *slabname## _at(struct slabname *s, const struct commit *c);	\
+elemtype *slabname## _peek(struct slabname *s, const struct commit *c)
+
+#define define_shared_commit_slab(slabname, elemtype) \
+	declare_commit_slab(slabname, elemtype); \
+	declare_commit_slab_prototypes(slabname, elemtype)
+
+#endif /* COMMIT_SLAB_HDR_H */
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
new file mode 100644
index 0000000000..19a88d7d8f
--- /dev/null
+++ b/commit-slab-impl.h
@@ -0,0 +1,97 @@
+#ifndef COMMIT_SLAB_IMPL_H
+#define COMMIT_SLAB_IMPL_H
+
+#define MAYBE_UNUSED __attribute__((__unused__))
+
+#define implement_static_commit_slab(slabname, elemtype) \
+	implement_commit_slab(slabname, elemtype, static MAYBE_UNUSED)
+
+#define implement_shared_commit_slab(slabname, elemtype) \
+	implement_commit_slab(slabname, elemtype, )
+
+#define implement_commit_slab(slabname, elemtype, scope)		\
+									\
+static int stat_ ##slabname## realloc;					\
+									\
+scope void init_ ##slabname## _with_stride(struct slabname *s,		\
+						   unsigned stride)	\
+{									\
+	unsigned int elem_size;						\
+	if (!stride)							\
+		stride = 1;						\
+	s->stride = stride;						\
+	elem_size = sizeof(elemtype) * stride;				\
+	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
+	s->slab_count = 0;						\
+	s->slab = NULL;							\
+}									\
+									\
+scope void init_ ##slabname(struct slabname *s)				\
+{									\
+	init_ ##slabname## _with_stride(s, 1);				\
+}									\
+									\
+scope void clear_ ##slabname(struct slabname *s)			\
+{									\
+	unsigned int i;							\
+	for (i = 0; i < s->slab_count; i++)				\
+		free(s->slab[i]);					\
+	s->slab_count = 0;						\
+	FREE_AND_NULL(s->slab);						\
+}									\
+									\
+scope elemtype *slabname## _at_peek(struct slabname *s,			\
+						  const struct commit *c, \
+						  int add_if_missing)   \
+{									\
+	unsigned int nth_slab, nth_slot;				\
+									\
+	nth_slab = c->index / s->slab_size;				\
+	nth_slot = c->index % s->slab_size;				\
+									\
+	if (s->slab_count <= nth_slab) {				\
+		unsigned int i;						\
+		if (!add_if_missing)					\
+			return NULL;					\
+		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
+		stat_ ##slabname## realloc++;				\
+		for (i = s->slab_count; i <= nth_slab; i++)		\
+			s->slab[i] = NULL;				\
+		s->slab_count = nth_slab + 1;				\
+	}								\
+	if (!s->slab[nth_slab]) {					\
+		if (!add_if_missing)					\
+			return NULL;					\
+		s->slab[nth_slab] = xcalloc(s->slab_size,		\
+					    sizeof(**s->slab) * s->stride);		\
+	}								\
+	return &s->slab[nth_slab][nth_slot * s->stride];		\
+}									\
+									\
+scope elemtype *slabname## _at(struct slabname *s,			\
+					     const struct commit *c)	\
+{									\
+	return slabname##_at_peek(s, c, 1);				\
+}									\
+									\
+scope elemtype *slabname## _peek(struct slabname *s,			\
+					     const struct commit *c)	\
+{									\
+	return slabname##_at_peek(s, c, 0);				\
+}									\
+									\
+struct slabname
+
+/*
+ * Note that this redundant forward declaration is required
+ * to allow a terminating semicolon, which makes instantiations look
+ * like function declarations.  I.e., the expansion of
+ *
+ *    implement_commit_slab(indegree, int);
+ *
+ * ends in 'struct indegree;'.  This would otherwise
+ * be a syntax error according (at least) to ISO C.  It's hard to
+ * catch because GCC silently parses it by default.
+ */
+
+#endif	/* COMMIT_SLAB_IMPL_H */
diff --git a/commit-slab.h b/commit-slab.h
index dcaab8ca04..dc029acc66 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -1,6 +1,9 @@
 #ifndef COMMIT_SLAB_H
 #define COMMIT_SLAB_H
 
+#include "commit-slab-hdr.h"
+#include "commit-slab-impl.h"
+
 /*
  * define_commit_slab(slabname, elemtype) creates boilerplate code to define
  * a new struct (struct slabname) that is used to associate a piece of data
@@ -41,114 +44,8 @@
  *   leaking memory.
  */
 
-/* allocate ~512kB at once, allowing for malloc overhead */
-#ifndef COMMIT_SLAB_SIZE
-#define COMMIT_SLAB_SIZE (512*1024-32)
-#endif
-
-#define MAYBE_UNUSED __attribute__((__unused__))
-
-#define define_commit_slab(slabname, elemtype) 				\
-									\
-struct slabname {							\
-	unsigned slab_size;						\
-	unsigned stride;						\
-	unsigned slab_count;						\
-	elemtype **slab;						\
-};									\
-static int stat_ ##slabname## realloc;					\
-									\
-static MAYBE_UNUSED void init_ ##slabname## _with_stride(struct slabname *s, \
-						   unsigned stride)	\
-{									\
-	unsigned int elem_size;						\
-	if (!stride)							\
-		stride = 1;						\
-	s->stride = stride;						\
-	elem_size = sizeof(elemtype) * stride;				\
-	s->slab_size = COMMIT_SLAB_SIZE / elem_size;			\
-	s->slab_count = 0;						\
-	s->slab = NULL;							\
-}									\
-									\
-static MAYBE_UNUSED void init_ ##slabname(struct slabname *s)		\
-{									\
-	init_ ##slabname## _with_stride(s, 1);				\
-}									\
-									\
-static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
-{									\
-	unsigned int i;							\
-	for (i = 0; i < s->slab_count; i++)				\
-		free(s->slab[i]);					\
-	s->slab_count = 0;						\
-	FREE_AND_NULL(s->slab);						\
-}									\
-									\
-static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
-						  const struct commit *c, \
-						  int add_if_missing)   \
-{									\
-	unsigned int nth_slab, nth_slot;				\
-									\
-	nth_slab = c->index / s->slab_size;				\
-	nth_slot = c->index % s->slab_size;				\
-									\
-	if (s->slab_count <= nth_slab) {				\
-		unsigned int i;						\
-		if (!add_if_missing)					\
-			return NULL;					\
-		REALLOC_ARRAY(s->slab, nth_slab + 1);			\
-		stat_ ##slabname## realloc++;				\
-		for (i = s->slab_count; i <= nth_slab; i++)		\
-			s->slab[i] = NULL;				\
-		s->slab_count = nth_slab + 1;				\
-	}								\
-	if (!s->slab[nth_slab]) {					\
-		if (!add_if_missing)					\
-			return NULL;					\
-		s->slab[nth_slab] = xcalloc(s->slab_size,		\
-					    sizeof(**s->slab) * s->stride);		\
-	}								\
-	return &s->slab[nth_slab][nth_slot * s->stride];		\
-}									\
-									\
-static MAYBE_UNUSED elemtype *slabname## _at(struct slabname *s,	\
-					     const struct commit *c)	\
-{									\
-	return slabname##_at_peek(s, c, 1);				\
-}									\
-									\
-static MAYBE_UNUSED elemtype *slabname## _peek(struct slabname *s,	\
-					     const struct commit *c)	\
-{									\
-	return slabname##_at_peek(s, c, 0);				\
-}									\
-									\
-struct slabname
-
-/*
- * Note that this redundant forward declaration is required
- * to allow a terminating semicolon, which makes instantiations look
- * like function declarations.  I.e., the expansion of
- *
- *    define_commit_slab(indegree, int);
- *
- * ends in 'struct indegree;'.  This would otherwise
- * be a syntax error according (at least) to ISO C.  It's hard to
- * catch because GCC silently parses it by default.
- */
-
-/*
- * Statically initialize a commit slab named "var". Note that this
- * evaluates "stride" multiple times! Example:
- *
- *   struct indegree indegrees = COMMIT_SLAB_INIT(1, indegrees);
- *
- */
-#define COMMIT_SLAB_INIT(stride, var) { \
-	COMMIT_SLAB_SIZE / sizeof(**((var).slab)) / (stride), \
-	(stride), 0, NULL \
-}
+#define define_commit_slab(slabname, elemtype) \
+	declare_commit_slab(slabname, elemtype); \
+	implement_static_commit_slab(slabname, elemtype)
 
 #endif /* COMMIT_SLAB_H */
diff --git a/log-tree.c b/log-tree.c
index d36a945fc4..0b41ee3235 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -295,8 +295,8 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (opt->source_slab) {
-		char **slot = source_slab_peek(opt->source_slab, commit);
+	if (opt->sources) {
+		char **slot = revision_sources_peek(opt->sources, commit);
 
 		if (slot && *slot)
 			fprintf(opt->diffopt.file, "\t%s", *slot);
diff --git a/revision.c b/revision.c
index 41b56f789d..be8fe7d67b 100644
--- a/revision.c
+++ b/revision.c
@@ -29,6 +29,8 @@ volatile show_early_output_fn_t show_early_output;
 static const char *term_bad;
 static const char *term_good;
 
+implement_shared_commit_slab(revision_sources, char *);
+
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	const char *p;
@@ -262,8 +264,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
-		if (revs->source_slab) {
-			char **slot = source_slab_at(revs->source_slab, commit);
+		if (revs->sources) {
+			char **slot = revision_sources_at(revs->sources, commit);
 
 			if (!*slot)
 				*slot = xstrdup(name);
@@ -819,11 +821,11 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			}
 			return -1;
 		}
-		if (revs->source_slab) {
-			char **slot = source_slab_at(revs->source_slab, p);
+		if (revs->sources) {
+			char **slot = revision_sources_at(revs->sources, p);
 
 			if (!*slot)
-				*slot = *source_slab_at(revs->source_slab, commit);
+				*slot = *revision_sources_at(revs->sources, commit);
 		}
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
diff --git a/revision.h b/revision.h
index 72404e2599..f3dc5f9740 100644
--- a/revision.h
+++ b/revision.h
@@ -6,7 +6,7 @@
 #include "notes.h"
 #include "pretty.h"
 #include "diff.h"
-#include "commit-slab.h"
+#include "commit-slab-hdr.h"
 
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
@@ -30,7 +30,7 @@ struct rev_info;
 struct log_info;
 struct string_list;
 struct saved_parents;
-define_commit_slab(source_slab, char *);
+define_shared_commit_slab(revision_sources, char *);
 
 struct rev_cmdline_info {
 	unsigned int nr;
@@ -226,7 +226,7 @@ struct rev_info {
 	struct commit_list *previous_parents;
 	const char *break_bar;
 
-	struct source_slab *source_slab;
+	struct revision_sources *sources;
 };
 
 extern int ref_excluded(struct string_list *, const char *path);
diff --git a/sequencer.c b/sequencer.c
index 1a0a6916e3..dd4993fd99 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3161,7 +3161,7 @@ static enum check_level get_missing_commit_check_level(void)
 	return CHECK_IGNORE;
 }
 
-define_commit_slab(commit_seen, int);
+define_commit_slab(commit_seen, uint8_t);
 /*
  * Check if the user dropped some commits by mistake
  * Behaviour determined by rebase.missingCommitsCheck.
@@ -3453,7 +3453,7 @@ int rearrange_squash(void)
 				  lookup_commit_reference_by_name(p)) &&
 				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
-				i2 = *commit_todo_item_peek(&commit_todo, commit2)
+				i2 = *commit_todo_item_at(&commit_todo, commit2)
 					- todo_list.items;
 			else {
 				/* copy can be a prefix of the commit subject */
diff --git a/shallow.c b/shallow.c
index 6ea411b0d2..daf60a9391 100644
--- a/shallow.c
+++ b/shallow.c
@@ -75,6 +75,10 @@ int is_repository_shallow(void)
 	return is_shallow;
 }
 
+/*
+ * TODO: use "int" elemtype instead of "int *" when/if commit-slab
+ * supports a "valid" flag.
+ */
 define_commit_slab(commit_depth, int *);
 struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		int shallow_flag, int not_shallow_flag)


Nguyễn Thái Ngọc Duy (14):
  commit-slab.h: code split
  commit-slab: support shared commit-slab
  blame: use commit-slab for blame suspects instead of commit->util
  describe: use commit-slab for commit names instead of commit->util
  shallow.c: use commit-slab for commit depth instead of commit->util
  sequencer.c: use commit-slab to mark seen commits
  sequencer.c: use commit-slab to associate todo items to commits
  revision.c: use commit-slab for show_source
  bisect.c: use commit-slab for commit weight instead of commit->util
  name-rev: use commit-slab for rev-name instead of commit->util
  show-branch: use commit-slab for commit-name instead of commit->util
  log: use commit-slab in prepare_bases() instead of commit->util
  merge: use commit-slab in merge remote desc instead of commit->util
  commit.h: delete 'util' field in struct commit

 bisect.c              |  12 +++--
 blame.c               |  42 +++++++++++----
 blame.h               |   2 +
 builtin/blame.c       |   2 +-
 builtin/describe.c    |  16 ++++--
 builtin/fast-export.c |  14 +++--
 builtin/log.c         |  17 +++++--
 builtin/merge.c       |  25 ++++-----
 builtin/name-rev.c    |  23 +++++++--
 builtin/show-branch.c |  39 +++++++++-----
 commit-slab-hdr.h     |  43 ++++++++++++++++
 commit-slab-impl.h    |  97 +++++++++++++++++++++++++++++++++++
 commit-slab.h         | 115 +++---------------------------------------
 commit.c              |  12 ++++-
 commit.h              |   8 ++-
 log-tree.c            |   8 ++-
 merge-recursive.c     |   8 +--
 revision.c            |  19 +++++--
 revision.h            |   5 +-
 sequencer.c           |  24 ++++++---
 shallow.c             |  41 ++++++++++-----
 21 files changed, 377 insertions(+), 195 deletions(-)
 create mode 100644 commit-slab-hdr.h
 create mode 100644 commit-slab-impl.h

-- 
2.17.0.705.g3525833791

