Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF40C33FE15
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012607; cv=none; b=nVIQI8M35RaDA9vRQi/iRChqzmykojk9gJh6VJ+PQLeI7iYXXRKFfxapRXcRS1BTtl63Zl0D3CdMwDd4ruVkV+qMCLT78ALIqcaguNxPFy0M6c9h3Z126J917LgoBfmQwWg03dVkEUPyIKeQNgf78XriIuylGwUUFDvMpyRClN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012607; c=relaxed/simple;
	bh=3Y4nVz7UEqV/klX4sTq/p6zGFGBost1iOz0jTc00xDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVcD9V2ZBiV01vpLuyO3RU8SlWoSTeedMTy+i/7W5DxI2+4JnQPqAKsqWOpVPHVcXuvh58bRLqh0LtmgfnSpNS4V61KZhmb3W1d1xY2bGtbX7hQtzCezHM0yh9FtKVfel5ITxg/TN18XaODycm9/qIc+q2rVRa9+yDxpnH3h3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYHMrwR6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYHMrwR6"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7eb85fb81so6277861a34.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775012602; x=1775617402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNWtCRg3aewWBjpXfivGKuDClGxWq2kP67IJGdCFxL0=;
        b=YYHMrwR6bm+KiIYSIeLkrPPpcovHfWZNLDtMCzjxiadEdYwxoIsEYfqUZsaai6hMoa
         /MZNJbrGy4C1H+xirhMpxCZAt+EG0OIyZ6Jb3PpuV+dL2vnyd5gzdOonl36nnyVcebcq
         quIVZoO4hapSuOCI6tzQs2JRrHc9fqHtd48fpp9B9/kR66xSnPuncjPeE6nHw5UghZLR
         l+9jayh/GkarPzmjgwmpq/vmxL9tLd04b6LYnXK2IiEkgt19w4RQPbZf6a9WS04eMvfo
         QNzRklArobY4QrNiMo+R4ArDxs8GdivGfrhgTzuKxKFd8T2luIBwwOApoVtSQwMer+fQ
         95hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775012602; x=1775617402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNWtCRg3aewWBjpXfivGKuDClGxWq2kP67IJGdCFxL0=;
        b=dLeoEj/rkF+FiodDXP5ecXmfpUHgCkdFeWXNeEddCQ6SKvO0tjCE98NEyMYPFBshBe
         f4hKR5uQFYVUZE6Ogd86df3gZ1d4tWBu3+nAh+U/h7bY4jXTDzh8+rTq0Tf+z7/c4JZ4
         IZdU4fS61/dVldC1yVcyf9PnKmC5CNwLXll+dAzcxuWkX2Vo2QOxc4Z1p3QX1/mUGfgk
         ynDpLBT/Bq7TXrZpFQdFbO+B/5K3m8vdFGjpmPOhfEW1zUzSU7kxHIwDvMPhKuxtDDS/
         NPyNsTgbJUjxJGJ+r3QqO+pBWK6fUNO3TdtRdfXEN2LjEowPMcZsjs54Ht23o6VKed15
         ctTA==
X-Gm-Message-State: AOJu0Ywt7hpZw6BdKpuOqLezYYf9rwKHxU++YzN/D6EZfT0zjtunwsE7
	nQGXZZiTIUReR26Q5i0aTh/mXBD9VxkxkYWuJ5EWFAdoYWC3YN/W5Yfr20z8qw==
X-Gm-Gg: ATEYQzwzg+5gv0Y0gxvhB2LqPzvCk92vEITmrkjBEIMuWAU3jTyYl42cMR19HorOc1b
	7QiuREQ9riRPnshWjef/bezk8/Ccizg9rYXvfk1+hLkrwQKtWa8T+IA7dtQncjozkZotEidhbbO
	UWg5gZ2Fsvr6jX/k+V5nH60fhlYsRkE2+zEnHASR5RroIKBAOGnhUEBv50O7X2yWa544cpihDT5
	U07gguLl9P0cC/o5Q17AEPGLIVOwJ0/8oBBH1j5OOZpx9JIMy1p3ns9olelcNVKKmssXcg1iav7
	0tVjSxTmfzhdHAd95TkUi3kK797oAo3iXXapPhTZ0ODO1O9VkerwW8Z1afZ7MNxf1x4rvmxxH+d
	f+JOw2bVMzI00EoHTPYCdKxBysvJZbTk1bVht57qvZPobjgXcDB7KwROwoM2pzEtD7iP06tgxuX
	Gaj9ENcA+mwZ4v8EhXZiYYgfHyKLjL5Po=
X-Received: by 2002:a05:6830:6ad3:b0:7d7:58b0:8e72 with SMTP id 46e09a7af769-7db991d5f66mr1347916a34.4.1775012602015;
        Tue, 31 Mar 2026 20:03:22 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm10266001a34.24.2026.03.31.20.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:03:21 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/7] odb: split `struct odb_transaction` into separate header
Date: Tue, 31 Mar 2026 22:03:09 -0500
Message-ID: <20260401030316.1847362-2-jltobler@gmail.com>
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

The current ODB transaction interface is colocated with other ODB
interfaces in "odb.{c,h}". Subsequent commits will expand `struct
odb_transaction` to support write operations on the transaction
directly. To keep things organized and prevent "odb.{c,h}" from becoming
more unwieldy, split out `struct odb_transaction` into a separate
header.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Makefile                 |  1 +
 builtin/add.c            |  1 +
 builtin/unpack-objects.c |  1 +
 builtin/update-index.c   |  1 +
 cache-tree.c             |  1 +
 meson.build              |  1 +
 object-file.c            |  1 +
 odb.c                    | 25 -------------------------
 odb.h                    | 31 -------------------------------
 odb/transaction.c        | 28 ++++++++++++++++++++++++++++
 odb/transaction.h        | 38 ++++++++++++++++++++++++++++++++++++++
 read-cache.c             |  1 +
 12 files changed, 74 insertions(+), 56 deletions(-)
 create mode 100644 odb/transaction.c
 create mode 100644 odb/transaction.h

diff --git a/Makefile b/Makefile
index dbf0022054..6342db13e5 100644
--- a/Makefile
+++ b/Makefile
@@ -1219,6 +1219,7 @@ LIB_OBJS += odb.o
 LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
 LIB_OBJS += odb/streaming.o
+LIB_OBJS += odb/transaction.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
diff --git a/builtin/add.c b/builtin/add.c
index 7737ab878b..c859f66519 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -16,6 +16,7 @@
 #include "run-command.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6fc64e9e4b..bc9b1e047e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..bcc43852ef 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -19,6 +19,7 @@
 #include "tree-walk.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "refs.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
diff --git a/cache-tree.c b/cache-tree.c
index 60bcc07c3b..f056869cfd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -10,6 +10,7 @@
 #include "cache-tree.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "repository.h"
diff --git a/meson.build b/meson.build
index 8309942d18..6dc23b3af2 100644
--- a/meson.build
+++ b/meson.build
@@ -405,6 +405,7 @@ libgit_sources = [
   'odb/source.c',
   'odb/source-files.c',
   'odb/streaming.c',
+  'odb/transaction.c',
   'oid-array.c',
   'oidmap.c',
   'oidset.c',
diff --git a/object-file.c b/object-file.c
index f0b029ff0b..bfbb632cf8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -21,6 +21,7 @@
 #include "object-file.h"
 #include "odb.h"
 #include "odb/streaming.h"
+#include "odb/transaction.h"
 #include "oidtree.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/odb.c b/odb.c
index 350e23f3c0..8c3cbc1b53 100644
--- a/odb.c
+++ b/odb.c
@@ -1069,28 +1069,3 @@ void odb_reprepare(struct object_database *o)
 
 	obj_read_unlock();
 }
-
-struct odb_transaction *odb_transaction_begin(struct object_database *odb)
-{
-	if (odb->transaction)
-		return NULL;
-
-	odb->transaction = odb_transaction_files_begin(odb->sources);
-
-	return odb->transaction;
-}
-
-void odb_transaction_commit(struct odb_transaction *transaction)
-{
-	if (!transaction)
-		return;
-
-	/*
-	 * Ensure the transaction ending matches the pending transaction.
-	 */
-	ASSERT(transaction == transaction->source->odb->transaction);
-
-	transaction->commit(transaction);
-	transaction->source->odb->transaction = NULL;
-	free(transaction);
-}
diff --git a/odb.h b/odb.h
index 9aee260105..ec5367b13e 100644
--- a/odb.h
+++ b/odb.h
@@ -35,24 +35,6 @@ struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
 
-/*
- * A transaction may be started for an object database prior to writing new
- * objects via odb_transaction_begin(). These objects are not committed until
- * odb_transaction_commit() is invoked. Only a single transaction may be pending
- * at a time.
- *
- * Each ODB source is expected to implement its own transaction handling.
- */
-struct odb_transaction;
-typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
-struct odb_transaction {
-	/* The ODB source the transaction is opened against. */
-	struct odb_source *source;
-
-	/* The ODB source specific callback invoked to commit a transaction. */
-	odb_transaction_commit_fn commit;
-};
-
 /*
  * The object database encapsulates access to objects in a repository. It
  * manages one or more sources that store the actual objects which are
@@ -154,19 +136,6 @@ void odb_close(struct object_database *o);
  */
 void odb_reprepare(struct object_database *o);
 
-/*
- * Starts an ODB transaction. Subsequent objects are written to the transaction
- * and not committed until odb_transaction_commit() is invoked on the
- * transaction. If the ODB already has a pending transaction, NULL is returned.
- */
-struct odb_transaction *odb_transaction_begin(struct object_database *odb);
-
-/*
- * Commits an ODB transaction making the written objects visible. If the
- * specified transaction is NULL, the function is a no-op.
- */
-void odb_transaction_commit(struct odb_transaction *transaction);
-
 /*
  * Find source by its object directory path. Returns a `NULL` pointer in case
  * the source could not be found.
diff --git a/odb/transaction.c b/odb/transaction.c
new file mode 100644
index 0000000000..9bf3f347dc
--- /dev/null
+++ b/odb/transaction.c
@@ -0,0 +1,28 @@
+#include "git-compat-util.h"
+#include "object-file.h"
+#include "odb/transaction.h"
+
+struct odb_transaction *odb_transaction_begin(struct object_database *odb)
+{
+	if (odb->transaction)
+		return NULL;
+
+	odb->transaction = odb_transaction_files_begin(odb->sources);
+
+	return odb->transaction;
+}
+
+void odb_transaction_commit(struct odb_transaction *transaction)
+{
+	if (!transaction)
+		return;
+
+	/*
+	 * Ensure the transaction ending matches the pending transaction.
+	 */
+	ASSERT(transaction == transaction->source->odb->transaction);
+
+	transaction->commit(transaction);
+	transaction->source->odb->transaction = NULL;
+	free(transaction);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
new file mode 100644
index 0000000000..a56e392f21
--- /dev/null
+++ b/odb/transaction.h
@@ -0,0 +1,38 @@
+#ifndef ODB_TRANSACTION_H
+#define ODB_TRANSACTION_H
+
+#include "odb.h"
+#include "odb/source.h"
+
+/*
+ * A transaction may be started for an object database prior to writing new
+ * objects via odb_transaction_begin(). These objects are not committed until
+ * odb_transaction_commit() is invoked. Only a single transaction may be pending
+ * at a time.
+ *
+ * Each ODB source is expected to implement its own transaction handling.
+ */
+struct odb_transaction;
+typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
+struct odb_transaction {
+	/* The ODB source the transaction is opened against. */
+	struct odb_source *source;
+
+	/* The ODB source specific callback invoked to commit a transaction. */
+	odb_transaction_commit_fn commit;
+};
+
+/*
+ * Starts an ODB transaction. Subsequent objects are written to the transaction
+ * and not committed until odb_transaction_commit() is invoked on the
+ * transaction. If the ODB already has a pending transaction, NULL is returned.
+ */
+struct odb_transaction *odb_transaction_begin(struct object_database *odb);
+
+/*
+ * Commits an ODB transaction making the written objects visible. If the
+ * specified transaction is NULL, the function is a no-op.
+ */
+void odb_transaction_commit(struct odb_transaction *transaction);
+
+#endif
diff --git a/read-cache.c b/read-cache.c
index 5049f9baca..8147c7e94a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,6 +20,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
-- 
2.53.0.381.g628a66ccf6

