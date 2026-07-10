Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608443C07E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701457; cv=none; b=fVTf4s1hfrrqfzGuQ5o/M9WTiUrtcD2f0UhhzDMy4frjAFXApk3hunB6H011LKOtyS+y7GElGAkCa4wy6qcXEeeCRXmIAsh+34xckOSBFSEtT26Je/frJ4FDRMQCcz343PwmZ4yao3Q493nLH0mOQ60L+7LTlywuBJDajIS6m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701457; c=relaxed/simple;
	bh=zwzTybfhOFAob4s5FNA7ms7jQBF5wUEq8A59VxJrHOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH4Rgvrq8nogQHnZ+tUwqyN1eqM8iqp/Tlgv/90nv6M2srr102qhMrGIPRy0nxVL59rHJ5P08VXqK16aQCPGHXjpzBbp85hj2kKNJqTBgugSbmmP8IAapjgjH52trnBWYJBqOTSpQpPD+brad5CxrNwxEHjMS4EF2eVND+TMKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZeCw8lv; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZeCw8lv"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9f829d75aso830991a34.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701454; x=1784306254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tNxTobqg5f04SpCxWIL+W87/yic9KMJhDeXw3f8Gp5E=;
        b=NZeCw8lvb642vtyYFyYw522RGqxCx4tuE/61TBQEEibXQxY+oYr5Lvcjn6dz5flLut
         GC2KlRyud3dq41y59tNLK3SV7Wdvv5H0IMtJJUZmP8eBX0rTe1Mw2xjJlgTZSR4FJG9y
         VYev0WGDBWhjQkejWoCHT33ITmG3n2Vc72kEUBfQe6fjs16ztdkBCt4nt0+H60PPDrh4
         x2r3OD2HZ0v/wiLLIVH0r/xclmRNGlM3YsyeV/sN3ZH22QIjWbfRuLp/E2pZL0MkUT40
         SVyLn3PrRXknXpxmtLsD4p3uAuMfQePs4+W9G3343rvRUeZkS2269tCaBLsRQ9wpUuo7
         FVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701454; x=1784306254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tNxTobqg5f04SpCxWIL+W87/yic9KMJhDeXw3f8Gp5E=;
        b=o+o/K+BVTZiFA0t++P+l34LCQ2NPam86vt7Czf5RAsqaWEAH0rRGhKEsfSiFh1tzAO
         RHiD4JOOBPsm/5OURyibxNQ1MR9OjpO1vttTER9+TskX+V/1oqLv3LM0DJH7BZdnkdio
         0nl6VPNyu6uiymNvnRoWrzaefmiD2a0jnTqPnXBthYJwWX84oCsFDjLD7hTynQCx5sC1
         cE2lHu3RDAhKk7fPi9geR9vXNZjllMEr1/VkSwIXXsAH4J5Xau46IzrWNjqQCOut2ktd
         R7Kxcv5/Pz8oAKWsal0Rd/LMX5GBJIl5K5K/Cn8hTMYt9glgaSQ34pc73nL2TphprBYC
         yUCg==
X-Gm-Message-State: AOJu0YyT/ph4NaHElMyD272j0fzRba47jaiN3PGNUHnrgop1Neukw0G0
	sKYDj1p+Y14jmb0smWaDfQ6VmOR3gSrTfrcL/MEPCOb0prGmd1JspMD080/BRQ==
X-Gm-Gg: AfdE7cnj/CdIopCmEZIkTA3kYm5kBwtoinYpf6lKHm+K8/v3R1g+JPhUq6PH+kOZ4qw
	7rFU2mSQy23NlhWVqNqKd8lIOd6OltwSTF8+kibIth09EzSxlMSDWIPD3WMI3xZqjo4qxjjI3KZ
	rsAzsYqHvuWveDHZv5yNc3x+pFrCarlxaAhJzGmn9Dhia9gqhnd2BaCRv5ORUBJma6yAP2wwgam
	we7NaUKnjW7mlY3SLKOG8ljfo+KXvsa/BTcmIJZCunPKTVJdxk2x4aBQeSsO8qgYdart75Uu2jr
	rrTppvfRUNsxbGYWT4WvLTRLIk5GX/IW8xnzyRjjOsPZByVmoudxdFpX3iBEloon/RdiGfgfcyn
	JVoitxk+PNb8+v+7HJlg0/JAyfbPRZDh+rVdBKFFaWwXDtx9ZGomUONO+GSP9MUyoXla3SrQeoX
	Q7fSI2FYKNcuUxdbCDHeO+
X-Received: by 2002:a05:6830:6814:b0:7e9:f8e8:d900 with SMTP id 46e09a7af769-7ebcffd741amr8733228a34.26.1783701454490;
        Fri, 10 Jul 2026 09:37:34 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 09/11] odb/transaction: introduce ODB transaction flags
Date: Fri, 10 Jul 2026 11:37:20 -0500
Message-ID: <20260710163722.2962278-10-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temporary directory used by git-receive-pack(1) to write objects is
managed slightly differently than how it is done via ODB transactions:

  - The temporary directory is eagerly created upfront, instead of
    waiting for the first object write.

  - The prefix name of the temporary directory is "incoming" instead of
    "bulk-fsync".

In a subsequent commit, git-receive-pack(1) will use ODB transactions
instead of `tmp_objdir` directly. To provide a means to configure the
same transaction behavior, introduce `enum odb_transaction_flags` and
the ODB_TRANSACTION_RECEIVE flag intended as a signal for ODB
transactions using the "files" backend to be set up for
git-receive-pack(1). Transaction call sites are updated accordingly to
provide the required flag parameter.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/add.c            |  2 +-
 builtin/unpack-objects.c |  2 +-
 builtin/update-index.c   |  2 +-
 cache-tree.c             |  2 +-
 object-file.c            | 29 ++++++++++++++++++++++++++---
 object-file.h            |  4 +++-
 odb/source-files.c       |  5 +++--
 odb/source-inmemory.c    |  3 ++-
 odb/source-loose.c       |  3 ++-
 odb/source.h             |  9 ++++++---
 odb/transaction.c        |  5 +++--
 odb/transaction.h        | 15 +++++++++++----
 read-cache.c             |  2 +-
 13 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 3d5d9cfdb9..60ffbede2b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -581,7 +581,7 @@ int cmd_add(int argc,
 		string_list_clear(&only_match_skip_worktree, 0);
 	}
 
-	odb_transaction_begin_or_die(repo->objects, &transaction);
+	odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 
 	ps_matched = xcalloc(pathspec.nr, 1);
 	if (add_renormalize)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index d0136cdd99..c3d0fc7507 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -598,7 +598,7 @@ static void unpack_all(void)
 		progress = start_progress(the_repository,
 					  _("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 17f3ea284c..bf6ea60ef4 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1124,7 +1124,7 @@ int cmd_update_index(int argc,
 	 * Allow the object layer to optimize adding multiple objects in
 	 * a batch.
 	 */
-	odb_transaction_begin_or_die(the_repository->objects, &transaction);
+	odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	while (ctx.argc) {
 		if (parseopt_state != PARSE_OPT_DONE)
 			parseopt_state = parse_options_step(&ctx, options,
diff --git a/cache-tree.c b/cache-tree.c
index 8eec1d4d52..99c6a0a7d0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -492,7 +492,7 @@ int cache_tree_update(struct index_state *istate, int flags)
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", istate->repo);
 	if (!inflight)
-		odb_transaction_begin_or_die(the_repository->objects, &transaction);
+		odb_transaction_begin_or_die(the_repository->objects, &transaction, 0);
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
 	if (!inflight)
diff --git a/object-file.c b/object-file.c
index 39b92e275c..0640a22009 100644
--- a/object-file.c
+++ b/object-file.c
@@ -498,6 +498,7 @@ struct odb_transaction_files {
 
 	struct tmp_objdir *objdir;
 	struct transaction_packfile packfile;
+	const char *prefix;
 };
 
 static int odb_transaction_files_prepare(struct odb_transaction *base)
@@ -514,7 +515,7 @@ static int odb_transaction_files_prepare(struct odb_transaction *base)
 	if (!transaction || transaction->objdir)
 		return 0;
 
-	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
+	transaction->objdir = tmp_objdir_create(base->source->odb->repo, transaction->prefix);
 	if (!transaction->objdir)
 		return error(_("unable to create temporary object directory"));
 
@@ -1359,7 +1360,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			int inflight = !!transaction;
 
 			if (!inflight)
-				odb_transaction_begin_or_die(odb, &transaction);
+				odb_transaction_begin_or_die(odb, &transaction, 0);
 			ret = odb_transaction_write_object_stream(transaction,
 								  &stream,
 								  xsize_t(st->st_size),
@@ -1703,7 +1704,8 @@ static int odb_transaction_files_env(struct odb_transaction *base,
 }
 
 int odb_transaction_files_begin(struct odb_source *source,
-				struct odb_transaction **out)
+				struct odb_transaction **out,
+				enum odb_transaction_flags flags)
 {
 	struct odb_transaction_files *transaction;
 
@@ -1712,6 +1714,27 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
 	transaction->base.env = odb_transaction_files_env;
+
+	transaction->prefix = "bulk-fsync";
+	if (flags & ODB_TRANSACTION_RECEIVE) {
+		/*
+		 * ODB transactions for git-receive-pack(1) eagerly create a
+		 * temporary directory and use a different temporary directory
+		 * prefix.
+		 *
+		 * NEEDSWORK: This transaction flag is only used by the "files"
+		 * backend to special case temporary directory set up and
+		 * handling. Ideally transaction users should not have to care
+		 * though. To avoid this, we could eagerly create the temporary
+		 * directory and use the same prefix name for all transactions.
+		 */
+		transaction->prefix = "incoming";
+		if (odb_transaction_files_prepare(&transaction->base)) {
+			free(transaction);
+			return -1;
+		}
+	}
+
 	*out = &transaction->base;
 
 	return 0;
diff --git a/object-file.h b/object-file.h
index 1a023226ac..bdd2d67a2e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "odb.h"
 #include "odb/source-loose.h"
+#include "odb/transaction.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
@@ -197,6 +198,7 @@ struct odb_transaction;
  * to make new objects visible.
  */
 int odb_transaction_files_begin(struct odb_source *source,
-				struct odb_transaction **out);
+				struct odb_transaction **out,
+				enum odb_transaction_flags flags);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb/source-files.c b/odb/source-files.c
index 2545bd81d4..534f48aad9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -180,9 +180,10 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
-					      struct odb_transaction **out)
+					      struct odb_transaction **out,
+					      enum odb_transaction_flags flags)
 {
-	return odb_transaction_files_begin(source, out);
+	return odb_transaction_files_begin(source, out, flags);
 }
 
 static int odb_source_files_read_alternates(struct odb_source *source,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index e004566d76..9644d9d474 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -304,7 +304,8 @@ static int odb_source_inmemory_freshen_object(struct odb_source *source,
 }
 
 static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSED,
-						 struct odb_transaction **out UNUSED)
+						 struct odb_transaction **out UNUSED,
+						 enum odb_transaction_flags flags UNUSED)
 {
 	return error("in-memory source does not support transactions");
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 66e6bb8d3f..57c91986b4 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -638,7 +638,8 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 }
 
 static int odb_source_loose_begin_transaction(struct odb_source *source UNUSED,
-					      struct odb_transaction **out UNUSED)
+					      struct odb_transaction **out UNUSED,
+					      enum odb_transaction_flags flags UNUSED)
 {
 	/* TODO: this is a known omission that we'll want to address eventually. */
 	return error("loose source does not support transactions");
diff --git a/odb/source.h b/odb/source.h
index 2192a101b8..3790d03ff2 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -3,6 +3,7 @@
 
 #include "object.h"
 #include "odb.h"
+#include "odb/transaction.h"
 
 enum odb_source_type {
 	/*
@@ -228,7 +229,8 @@ struct odb_source {
 	 * negative error code otherwise.
 	 */
 	int (*begin_transaction)(struct odb_source *source,
-				 struct odb_transaction **out);
+				 struct odb_transaction **out,
+				 enum odb_transaction_flags flags);
 
 	/*
 	 * This callback is expected to read the list of alternate object
@@ -467,9 +469,10 @@ static inline int odb_source_write_alternate(struct odb_source *source,
  * Returns 0 on success, a negative error code otherwise.
  */
 static inline int odb_source_begin_transaction(struct odb_source *source,
-					       struct odb_transaction **out)
+					       struct odb_transaction **out,
+					       enum odb_transaction_flags flags)
 {
-	return source->begin_transaction(source, out);
+	return source->begin_transaction(source, out, flags);
 }
 
 #endif
diff --git a/odb/transaction.c b/odb/transaction.c
index 92ec8786a1..dab7da6a9a 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -4,14 +4,15 @@
 #include "odb/transaction.h"
 
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out)
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags)
 {
 	int ret;
 
 	if (odb->transaction)
 		return error(_("object database transaction already pending"));
 
-	ret = odb_source_begin_transaction(odb->sources, out);
+	ret = odb_source_begin_transaction(odb->sources, out, flags);
 	if (!ret)
 		odb->transaction = *out;
 
diff --git a/odb/transaction.h b/odb/transaction.h
index 5e51ce5ca4..4cb2eafcbf 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -3,7 +3,6 @@
 
 #include "gettext.h"
 #include "odb.h"
-#include "odb/source.h"
 
 /*
  * A transaction may be started for an object database prior to writing new
@@ -44,6 +43,12 @@ struct odb_transaction {
 	int (*env)(struct odb_transaction *transaction, struct strvec *env);
 };
 
+/* Flags used to configure an ODB transaction. */
+enum odb_transaction_flags {
+	/* Configures the transaction for use with git-receive-pack(1). */
+	ODB_TRANSACTION_RECEIVE = (1 << 0),
+};
+
 /*
  * Starts an ODB transaction and returns it via `out`. Subsequent objects are
  * written to the transaction and not committed until odb_transaction_commit()
@@ -52,12 +57,14 @@ struct odb_transaction {
  * ODB already has an inflight transaction pending.
  */
 int odb_transaction_begin(struct object_database *odb,
-			  struct odb_transaction **out);
+			  struct odb_transaction **out,
+			  enum odb_transaction_flags flags);
 
 static inline void odb_transaction_begin_or_die(struct object_database *odb,
-						struct odb_transaction **out)
+						struct odb_transaction **out,
+						enum odb_transaction_flags flags)
 {
-	if (odb_transaction_begin(odb, out))
+	if (odb_transaction_begin(odb, out, flags))
 		die(_("failed to start ODB transaction"));
 }
 
diff --git a/read-cache.c b/read-cache.c
index d511d25834..50e2320c8d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4044,7 +4044,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * may not have their own transaction active.
 	 */
 	if (!inflight)
-		odb_transaction_begin_or_die(repo->objects, &transaction);
+		odb_transaction_begin_or_die(repo->objects, &transaction, 0);
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	if (!inflight)
 		odb_transaction_commit(transaction);
-- 
2.55.0.122.gf85a7e6620

