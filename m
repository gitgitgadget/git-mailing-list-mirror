Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7E36405C
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012610; cv=none; b=cRkokBQxbd/pTlKGoQi9YXcjX3H0aDvzroQjk8YHU19K2D8NnGrAHQeUexta9/APFpE3El888PVenQhSPvznybD34cF3fmVb6y15v9bfRuLk3eiTRRCZ4zjaKK8kRDxLC1fTXgxDwTHu5jwvr5rCKeURLELS4AQ5dgIkhLAaw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012610; c=relaxed/simple;
	bh=dwRdYG78bnT8+ORtbHZm0KGbPDL0SEdI1iFv+JqnoqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5w1yeyFebf7ENe7eKNH9f41vGCDf4tFatKRedTVGhaQyvGoQP3/jeCdtGgpdU5VwEwSeSYqlAzwzZs/C/Du37AT66vPpW5roONF8PB4Fi3QZzViNlLq4QDLa7AlR41xzLNrUXxkMyTqC/nXigt6sKGYXloqCaCqcJ9NgGCoB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+pgVvDD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+pgVvDD"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d77b179b52so6009598a34.2
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012606; x=1775617406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMPiF2jIT9KtkOMWF+3VJehhiRFyl4sJW8BhCU+Kt5k=;
        b=m+pgVvDDGt/uJot7X3teTSQvrKX68BpqKiDx4m62Yx5KnxhmbGn4Fpx2e2Bxkv8hq3
         RapORmnzIPZj7P2vTtYuU5kPygEp08yl0E0ms9pF7DeNMXdvcs5sdkp9Sji43wB4gEf2
         +i+8KUUsIoanXNdoCaHoTO+cybmYayRyFaXE/3i1JisYpda3JMN3km1lhKu6fx9JBlwK
         xwJdvkP7iR+iF+huswCQVmk0ygRP6GNT3JLuvWQBfUv+F91raivc95JWdlPsK6Ys8zip
         8UWIIYllxtypve08JlOEo1DvEV0ingsEWCfCN1ubIyeXcYMSOs58QPgHyB5GStwm5qed
         z/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012606; x=1775617406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yMPiF2jIT9KtkOMWF+3VJehhiRFyl4sJW8BhCU+Kt5k=;
        b=W99jt2Sxv07KKLeNIa6Y6iJ3ugbVsTewl3F1cGbBlau5qP1qlmt7e3X+9xd6gUd9E8
         JCsMWGVCHuXfgh9FLEWXo2cVSc5pQTndZckQcPliG2zBIhxDs708X5pLFgMOszd3Lfh8
         jy8UHqinNEizOETcSaqgrJ3Bn8KG9OyrXigQQxaIfC1kcXGB7xsNoNg6CCzk62cK2kCL
         zDDHkZtxJeevuV984oIvK8FzqEaNbPlH2yBjynxCgjWAPgia2tWsYntA1uIOeLtV9/J2
         fWLk5gTdhNowSXr/areobTiN/1wCpzvf7b/+9S/G6E0O42ccEPiUrWFLO7N7nCcnKxKs
         PAMA==
X-Gm-Message-State: AOJu0YxA4LsHjLd0bcDzpjgw5baUV05ZqQ07FA+riX4Z3LIbBmJwIHEr
	/lWsuCBC/WB7MRlD+KD5nSF+HlX/1L53oapWt3+qVuWy032pLZOCGycaeHOQQg==
X-Gm-Gg: ATEYQzx7MmnSLzu7M/OB1IwCXNCwjxPLfDG8lmZVYW9rIkd/12CBtIlgp7IgrYnjRa4
	JH9sISqErPEd/wUTxlc7wiT2mDZeqsefMpD4QmjJrlrLYtWmINHZYx5iKpikk8r+VmsPVnCT332
	MkhCb5uSnsJdFEfcF+vBAxhNqL8ZuTSNU3NaIhij+M4XBkw8nxPOEzPqp0nBK+2qoadpTka0404
	wvCqbpcbZh9pq3oD52njgNBHDZeXlk7luy2pOZIrcnF8ZVW4vQhOPFh/xk7wbOqUkAM5p5D6RrF
	VyK3VtnEbHMWT0okQDl6p/LNx+miGLLhNIRj6cfiS9S86KxyZKCvBBLj5aFZUCtZWh7MSlXkGoy
	ZTc9wDdeQb/Myqs5sCGhpuyIBBfkfAZ2njTmxOCVWtM9fgruSlwfsvhW1Fgb+4YIXb/mzvzA5NL
	Gxks4hxMIxB24tB2B8P8nZjgx1oIxF7BQ=
X-Received: by 2002:a05:6830:44a1:b0:7d7:fb8c:3c29 with SMTP id 46e09a7af769-7db9926a9c7mr1563205a34.14.1775012606218;
        Tue, 31 Mar 2026 20:03:26 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:25 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 7/7] odb/transaction: make `write_object_stream()` pluggable
Date: Tue, 31 Mar 2026 22:03:15 -0500
Message-ID: <20260401030316.1847362-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260401030316.1847362-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260401030316.1847362-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

How an ODB transaction handles writing objects is expected to vary
between implementations. Introduce a new `write_object_stream()`
callback in `struct odb_transaction` to make this function pluggable.
Wire up `index_blob_packfile_transaction()` for use with `struct
odb_transaction_files` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c     | 16 +++++++++-------
 odb/transaction.c |  7 +++++++
 odb/transaction.h | 25 ++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index f7e830c4ec..45ed87c4d9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1574,9 +1574,10 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_packfile_transaction(struct odb_transaction *base,
-					   struct odb_write_stream *stream,
-					   size_t size, struct object_id *result_oid)
+static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
+						     struct odb_write_stream *stream,
+						     size_t size,
+						     struct object_id *result_oid)
 {
 	struct odb_transaction_files *transaction = container_of(base,
 								 struct odb_transaction_files,
@@ -1660,10 +1661,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			struct object_database *odb = the_repository->objects;
 			struct odb_transaction *transaction = odb_transaction_begin(odb);
 
-			ret = index_blob_packfile_transaction(odb->transaction,
-							      &stream,
-							      xsize_t(st->st_size),
-							      oid);
+			ret = odb_transaction_write_object_stream(odb->transaction,
+								  &stream,
+								  xsize_t(st->st_size),
+								  oid);
 			odb_transaction_commit(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
@@ -2128,6 +2129,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
+	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
 
 	return &transaction->base;
 }
diff --git a/odb/transaction.c b/odb/transaction.c
index 592ac84075..b16e07aebf 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -26,3 +26,10 @@ void odb_transaction_commit(struct odb_transaction *transaction)
 	transaction->source->odb->transaction = NULL;
 	free(transaction);
 }
+
+int odb_transaction_write_object_stream(struct odb_transaction *transaction,
+					struct odb_write_stream *stream,
+					size_t len, struct object_id *oid)
+{
+	return transaction->write_object_stream(transaction, stream, len, oid);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
index a56e392f21..854fda06f5 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -12,14 +12,24 @@
  *
  * Each ODB source is expected to implement its own transaction handling.
  */
-struct odb_transaction;
-typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
 struct odb_transaction {
 	/* The ODB source the transaction is opened against. */
 	struct odb_source *source;
 
 	/* The ODB source specific callback invoked to commit a transaction. */
-	odb_transaction_commit_fn commit;
+	void (*commit)(struct odb_transaction *transaction);
+
+	/*
+	 * This callback is expected to write the given object stream into
+	 * the ODB transaction. Note that for now, only blobs support streaming.
+	 *
+	 * The resulting object ID shall be written into the out pointer. The
+	 * callback is expected to return 0 on success, a negative error code
+	 * otherwise.
+	 */
+	int (*write_object_stream)(struct odb_transaction *transaction,
+				   struct odb_write_stream *stream, size_t len,
+				   struct object_id *oid);
 };
 
 /*
@@ -35,4 +45,13 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb);
  */
 void odb_transaction_commit(struct odb_transaction *transaction);
 
+/*
+ * Writes the object in the provided stream into the transaction. The resulting
+ * object ID is written into the out pointer. Returns 0 on success, a negative
+ * error code otherwise.
+ */
+int odb_transaction_write_object_stream(struct odb_transaction *transaction,
+					struct odb_write_stream *stream,
+					size_t len, struct object_id *oid);
+
 #endif
-- 
2.53.0.381.g628a66ccf6

