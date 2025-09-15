Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4D296BBE
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968211; cv=none; b=IV44fu3isKE/tacyUZsItlt9iPuWa6RCa6HgjfrWw+tFDtLnjcb6Hw9UuEBVui9ZFp+IdXqQ1yI5npz7jG8skr1IEUccy4+Y37seGa6RtAq6iL3mTr6qsMMERFUqMGO87z+CXX6acUmPHMFNA4q/XUOQjoNfdr4NUtD1nD6/DEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968211; c=relaxed/simple;
	bh=TThAJu3H6Gf5EwQRlN19oDqsvtXGoaoLTokrpjyWj+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idiscR6ZSgj9oowR8iHMJEJ5fkuo5u0IZL3/GJhTvxhCzqhH2URCO+1Y/jePcNVrcv6T+OEZ91YmS/Cyu8wpwbE+De6Fw/nOdSusBMVt1HluL6djyDozaGHWy82V+wrwsREbntisRof4oRhRc14Sid5hcHTNZBOWO2QV97LHd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS+PMIgE; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS+PMIgE"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3197f534179so3344853fac.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757968208; x=1758573008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZCG5JoTkoyAI+FQnC1Ln7s3i3t0vtVhJ1gNA4suVmY=;
        b=YS+PMIgEdQxHdk6C1sYR8wtFCMVKxGZCi5WMQfQywXEB8kITjAsME8ZbeEnYUdpTcl
         4xlvJu/9wDGxQ2AJHYmDddR8g5TctWKMszcgmtYscHd8KEq8eUdrteH2HzJ1Q1Fgm+2v
         jsyVEJ/jPFanB0SS76PGAKW35/Ve3wea7+WMtaiuCJr9uuz77qz9iFBkQ9Vqi5RjR7ih
         1BASFatkqCyhTWkirymhGAzPrd+7UkwnRWWlhf/4faQeIhQI8ydbkKv0hUlZX29mOWvj
         7KJCCRNf42LEAyuUoYyqCamA3m2Z4xpMQrb5pNaLhMyityTPW8RCT/qamOOA6X4hG2eE
         N2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757968208; x=1758573008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZCG5JoTkoyAI+FQnC1Ln7s3i3t0vtVhJ1gNA4suVmY=;
        b=E/nZI8xSiZb2TwBEubnB7xPWTMCxUQvAB6C6VSH2Pu3qs8uJSTam0/KRIVtl+A0Fj1
         C2Mud8MYPW78uMlT4UsPMr6tbme0m/InGWEn5k6vvZ64jBaWqgciI+qs1h6JN8tTdUwq
         a+rjF5csmMbgHBlNwXhGGv1L/3kns77poYkWw5Vk7Kaffmjg1Y79wflJd4KusGVMTjIP
         Kdw0yRZbx9D9JLs10VoJrD+dUdu3ribFviLoo+JV6OGIC+Il+3ahgAP8DeXkAK5Yws0h
         y2CZ7ZQaNNmnTkfGCqwProMpyhAshIy5Ep5b1zwRzBxE7eoBg0peuaUfHGdyAPgnTc3p
         xvGw==
X-Gm-Message-State: AOJu0Yy2XflvjO5I1JMMYyVan8OKtGeDasJiKCgAfhZxNyBdfEBnKtGP
	H/EQlMxoar/k8uZxg2jIxSMFKC9oyUfB93887ai7auLBURK5G+Rccx+qpmfn/w==
X-Gm-Gg: ASbGncv/oc3baG2NdXSDQd3f+nqeyOVXmhVjiiuqg/k2NYVSWSp1z0i8UMGRPIADs2+
	HozDE7hFaJ6fQjnbohAC0g4NVv/8vWLzSGXEYsl6EumDzP4NcFGljY0WwGRwozBw/US23rKo+iQ
	hGrkKxpMwh8jYhDAIfzbTKw72KHOWgsZkP8K/5hFe9+uBGPW2LaCyKbLMCqTuDqtnRFRjg3vpcX
	02qflHOCgLs+gCXi8imC5apS6c3TqRWOiG3zKs+kdVyt9jdis/u6W8BWW7KySbdc3V/j4zlEbDV
	4e3LN3kkbW0cBp9HCIxSH7+fePQE4bzsf9C21vinJuOFCOMRUDCDvYg36kY+EYczfyLNVtybUuT
	oCGNTEln9bVYxC9Zd+HZrqYydXBfvUxtGwoQ1DWMO2Q==
X-Google-Smtp-Source: AGHT+IGs8zXqbq1ykh4H9CWTehbVwWgT4OFO2LbW94VSnHxAa2aOqYPR43Neu2qr3NtcXaDUuQJNUA==
X-Received: by 2002:a05:6870:d88f:b0:32a:a799:675e with SMTP id 586e51a60fabf-32e560cce41mr6830883fac.1.1757968208378;
        Mon, 15 Sep 2025 13:30:08 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524c260735sm3114325a34.39.2025.09.15.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:30:08 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/6] bulk-checkin: remove ODB transaction nesting
Date: Mon, 15 Sep 2025 15:29:51 -0500
Message-ID: <20250915202956.3784935-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250915202956.3784935-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250915202956.3784935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ODB transactions support being nested. Only the outermost
{begin,end}_odb_transaction() start and finish a transaction. This is
done so that certain object write codepaths that occur internally can be
optimized via ODB transactions without having to worry if a transaction
has already been started or not. This can make the interface a bit
awkward to use, as calling {begin,end}_odb_transaction() does not
guarantee that a transaction is actually started or ended. Thus, in
situations where a transaction must be explicitly flushed,
flush_odb_transaction() must be used.

To better clarify ownership sematics around a transaction and further
remove the need for flush_odb_transaction() as part of the transaction
interface, instead be more explicit and require callers who use ODB
transactions internally to ensure there is not already a pending
transaction before beginning or ending a transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 22 ++++++++++------------
 bulk-checkin.h |  9 ++++-----
 cache-tree.c   |  9 +++++++--
 object-file.c  |  9 ++++++---
 read-cache.c   |  7 +++++--
 5 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 124c493067..6299d1c9b3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -33,7 +33,6 @@ struct bulk_checkin_packfile {
 struct odb_transaction {
 	struct object_database *odb;
 
-	int nesting;
 	struct tmp_objdir *objdir;
 	struct bulk_checkin_packfile packfile;
 };
@@ -368,12 +367,11 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 
 struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 {
-	if (!odb->transaction) {
-		CALLOC_ARRAY(odb->transaction, 1);
-		odb->transaction->odb = odb;
-	}
+	if (odb->transaction)
+		BUG("ODB transaction already started");
 
-	odb->transaction->nesting += 1;
+	CALLOC_ARRAY(odb->transaction, 1);
+	odb->transaction->odb = odb;
 
 	return odb->transaction;
 }
@@ -389,14 +387,14 @@ void flush_odb_transaction(struct odb_transaction *transaction)
 
 void end_odb_transaction(struct odb_transaction *transaction)
 {
-	if (!transaction || transaction->nesting == 0)
-		BUG("Unbalanced ODB transaction nesting");
-
-	transaction->nesting -= 1;
-
-	if (transaction->nesting)
+	if (!transaction)
 		return;
 
+	/*
+	 * Ensure the transaction ending matches the pending transaction.
+	 */
+	ASSERT(transaction == transaction->odb->transaction);
+
 	flush_odb_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
diff --git a/bulk-checkin.h b/bulk-checkin.h
index ac8887f476..b4536d81fc 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -38,9 +38,9 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
 /*
  * Tell the object database to optimize for adding
  * multiple objects. end_odb_transaction must be called
- * to make new objects visible. Transactions can be nested,
- * and objects are only visible after the outermost transaction
- * is complete or the transaction is flushed.
+ * to make new objects visible. Only a single transaction
+ * can be pending at a time and must be ended before
+ * beginning another.
  */
 struct odb_transaction *begin_odb_transaction(struct object_database *odb);
 
@@ -53,8 +53,7 @@ void flush_odb_transaction(struct odb_transaction *transaction);
 
 /*
  * Tell the object database to make any objects from the
- * current transaction visible if this is the final nested
- * transaction.
+ * current transaction visible.
  */
 void end_odb_transaction(struct odb_transaction *transaction);
 
diff --git a/cache-tree.c b/cache-tree.c
index d225554eed..f88555a773 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -474,7 +474,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 	int skip, i;
 
 	i = verify_cache(istate, flags);
@@ -490,10 +490,15 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
-	transaction = begin_odb_transaction(the_repository->objects);
+
+	if (!the_repository->objects->transaction)
+		transaction = begin_odb_transaction(the_repository->objects);
+
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
+
 	end_odb_transaction(transaction);
+
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index bc15af4245..c2db58d62e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1264,12 +1264,15 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
 				 type, path, flags);
 	} else {
-		struct odb_transaction *transaction;
+		struct odb_transaction *transaction = NULL;
 
-		transaction = begin_odb_transaction(the_repository->objects);
-		ret = index_blob_bulk_checkin(transaction,
+		if (!the_repository->objects->transaction)
+			transaction = begin_odb_transaction(the_repository->objects);
+
+		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
 					      oid, fd, xsize_t(st->st_size),
 					      path, flags);
+
 		end_odb_transaction(transaction);
 	}
 
diff --git a/read-cache.c b/read-cache.c
index 229b8ef11c..6d2ff487f6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3947,7 +3947,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, char *ps_matched,
 		       int include_sparse, int flags)
 {
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 	struct update_callback_data data;
 	struct rev_info rev;
 
@@ -3973,8 +3973,11 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	transaction = begin_odb_transaction(repo->objects);
+	if (!repo->objects->transaction)
+		transaction = begin_odb_transaction(repo->objects);
+
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+
 	end_odb_transaction(transaction);
 
 	release_revisions(&rev);
-- 
2.51.0.193.g4975ec3473b

