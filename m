Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2CE3168FC
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445111; cv=none; b=FHyhzPbcSJ/lHJEai2oIxdCB0IHro5Pr5/K7qqNUKVtYWdEML3JQGKdyh1YJ7p4HOiWYOM/07vDdITW+ierT+MxjtJi7O5DyJBc2uCLGcXqpH41Y1b+bwMB4i98FTgXWdsmiZoDHo8QcmnH9xT9KRp381iaY3s73E79o/xHoujY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445111; c=relaxed/simple;
	bh=HC7qw+aPlnI7diELmpCiKtwZDkELNWh4b/MpqgwNX5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coxPzqndLd4DnnESlKjVlwziDNFVrPHY/B4GeEavTeii/ifize4wnSrotLpIIIwTT1CC8NjOAJ/EEbRZkYJr7MSCGHA9jV99Tcpr1fn6ZdeY0pu3VSvFINXBWvNPNxKwHOoJMfQzxyx6vhquxXR0wG/+7rhZYkDRr1E3UE4B1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD9gCPgu; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD9gCPgu"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74542b1b2bcso4924156a34.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445108; x=1758049908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9B1LWw7+a0llPOFnlhYf1EGMGU7MtzBEeIB5Kn7xOs=;
        b=mD9gCPgu4bIquN3dbQmkc8tVeL2CEBixpLc3MYaT5/HVdhuh4H8b2Mrd9hLNn3vD2H
         ThfDQdSADKke3+Z1qgwNN1c5AdQeoZAbe77+9fopH52C2xIGRHngJ6utHuqv2DYJAqeI
         LGjzR0Urb9Jcn1XzpEeiQEFKGXF4GcVqercnZPVzDbvOR8TUqxZvyQitKaLcDf5XVtLp
         5sm0UArWGcKXNqF7fF/CAAq/cp3h6H9wpvO1TtJy+iqww3lb/m6mb9Tcw+bpQRdhFPGD
         Isn2dX/WSIQKrCvrxj2Aq2Z94wVsTByqTXSN3A+dvMMjRpA17AjUllMigOcjwEPgeH5h
         +MTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445108; x=1758049908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9B1LWw7+a0llPOFnlhYf1EGMGU7MtzBEeIB5Kn7xOs=;
        b=h6cl5JrvP/Aurvi8Dik2D7rUj7Um1VMSm5sgDz+XNuR4ICXqT7fy3JPduN+5pyb473
         P3IAP5nHrFEajJ06QHaySw9qih3TGC2dugAv+J2wQY5V5eiGZD6j9sAGnVGPWLCJF1WW
         +9JRKK58J9DVOXF6krimv2fPCSlYBiwJyBegicGCyxM4wGfhDzg3LFOJ+/K1axxafwtK
         slZKz8uVPvdBcH/XjxPrtyfQDZYoftwDU/4EVUZsl3fViInaBb67RPFnG1H6xkHHHlzI
         5tWUzVleQu+KKMhXhW/xp3+CRTXpZkULnH9pThlhXyM/Dw8JON4QtJj42VpOSrA3ku6V
         Bg/w==
X-Gm-Message-State: AOJu0YxzvlL3nLoYE6fmtDfAyKdPZisWDgWugI+bOvrlOZFTm6780vEi
	flyvnLUVcfchaamPHhUhRY44H+ksRIKERx36NKNeAajpzi3q4yd8eNauEA2StQ==
X-Gm-Gg: ASbGncvGd5eUyrIpKZjj9+Y9pmeeHedjqDtYnwS8p3krbNOZCf4Bw420XQVs0bMwvT1
	HfRAef+HP12A6objujC5RurcQ+bV2vLbmkzLi8/t2Mwb2xDkz8JQTHjQ+JCnaEZV69csfsFssHE
	0dU/YCk/UQ/kG44DIDjuBSfqeAIcCasLqRx+9DJLjNWkMIC+G2Oc1A0fxckTme+tTgdxdjzfwqr
	kGx4G612GQp08BV9sLa9gyt+YDXRKmaBc0Q4wqDAHT65oxw1MTeZEmLDO7+gT0CNBYC5H+9HhSR
	300e8TUiWFJgncL/cjJTDo2lrTG8CqTumGALvVYdjUNOncuHiRY7frz0pM+mgJ1kG/WvTBEre7E
	vpqSArGAAOCU/7JT1UTGBQv+RNPlTqGgyTTMd1AfOSg==
X-Google-Smtp-Source: AGHT+IGjJhRgMBnvHOcC+6iRgctwBSuJr9Tu06knpVL3VouR0pgrpFLVgiIPIq3LHJcQpdWxZO4kog==
X-Received: by 2002:a05:6830:3492:b0:744:f0db:a1b0 with SMTP id 46e09a7af769-74c7831db78mr5143478a34.32.1757445107643;
        Tue, 09 Sep 2025 12:11:47 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74cc5a69b95sm3062627a34.39.2025.09.09.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 12:11:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
Date: Tue,  9 Sep 2025 14:11:29 -0500
Message-ID: <20250909191134.555689-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250909191134.555689-1-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com>
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
guarantee that a transaction is actually started or ended.

Instead, be more explicit and require callers who use ODB transactions
internally to ensure there is not already a pending transaction before
beginning or ending a transaction.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 18 ++++--------------
 bulk-checkin.h |  9 ++++-----
 cache-tree.c   | 12 +++++++++---
 object-file.c  | 12 ++++++++----
 read-cache.c   | 10 +++++++---
 5 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 124c4930676..0da5783090d 100644
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
@@ -389,14 +387,6 @@ void flush_odb_transaction(struct odb_transaction *transaction)
 
 void end_odb_transaction(struct odb_transaction *transaction)
 {
-	if (!transaction || transaction->nesting == 0)
-		BUG("Unbalanced ODB transaction nesting");
-
-	transaction->nesting -= 1;
-
-	if (transaction->nesting)
-		return;
-
 	flush_odb_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
diff --git a/bulk-checkin.h b/bulk-checkin.h
index ac8887f476b..b4536d81fc2 100644
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
index d225554eedd..5041639f99f 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -474,7 +474,7 @@ static int update_one(struct cache_tree *it,
 
 int cache_tree_update(struct index_state *istate, int flags)
 {
-	struct odb_transaction *transaction;
+	struct odb_transaction *transaction = NULL;
 	int skip, i;
 
 	i = verify_cache(istate, flags);
@@ -490,10 +490,16 @@ int cache_tree_update(struct index_state *istate, int flags)
 
 	trace_performance_enter();
 	trace2_region_enter("cache_tree", "update", the_repository);
-	transaction = begin_odb_transaction(the_repository->objects);
+
+	if (!the_repository->objects->transaction)
+		transaction = begin_odb_transaction(the_repository->objects);
+
 	i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
 		       "", 0, &skip, flags);
-	end_odb_transaction(transaction);
+
+	if (transaction)
+		end_odb_transaction(transaction);
+
 	trace2_region_leave("cache_tree", "update", the_repository);
 	trace_performance_leave("cache_tree_update");
 	if (i < 0)
diff --git a/object-file.c b/object-file.c
index bc15af42450..45f17a53a98 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1264,13 +1264,17 @@ int index_fd(struct index_state *istate, struct object_id *oid,
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
-		end_odb_transaction(transaction);
+
+		if (transaction)
+			end_odb_transaction(transaction);
 	}
 
 	close(fd);
diff --git a/read-cache.c b/read-cache.c
index 229b8ef11c9..7e5501f0839 100644
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
 
@@ -3973,9 +3973,13 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	 * This function is invoked from commands other than 'add', which
 	 * may not have their own transaction active.
 	 */
-	transaction = begin_odb_transaction(repo->objects);
+	if (!repo->objects->transaction)
+		transaction = begin_odb_transaction(repo->objects);
+
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	end_odb_transaction(transaction);
+
+	if (transaction)
+		end_odb_transaction(transaction);
 
 	release_revisions(&rev);
 	return !!data.add_errors;
-- 
2.51.0.193.g4975ec3473b

