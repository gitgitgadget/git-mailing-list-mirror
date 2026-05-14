Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D428391833
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783880; cv=none; b=tEs6mRdbEJd0Tt+ETnenYKS6nm7v/hirdFnN1OevMTw9ViVj5gsrm7fDhMZ8dQZfgc8VlnEryZj1xJtMSQtPPTGuiVALhkToyO268a18JIPQAckGOBiiradBU5o2F5oHYtsAUp0EwLFMl+CoSBeiw6x3XNnO5PgrYvWmiJ8nS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783880; c=relaxed/simple;
	bh=8mWT1wQmuSsIYjiPUtjKdAKavT0938F4rmrJBiecsJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trTlLYcXTL86FR9f3LRzB47jOkmprHHmzjgZBaHMFzG+POneZxMQ4hfAPFtR7Q/ZMwaGV4c2qWIFQWNp+WSIX4LwJ/Y+ZZX2y8LLLlI7f9uUOSmhRrrC9IjKA1VhNNq4SkQJmDUnbmssa+ri9NsbiCLqITSsSIRZem9KNNv5A2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlXNalTl; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlXNalTl"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-439e43d16bdso1300619fac.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783878; x=1779388678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0w1B/WNpdAA+EnL5S0R/CNh9VLkXDvlbSwyd7Tzc5VE=;
        b=NlXNalTly+Ty8hhZUwhwViaIn3qOx0NBx7SciqNk5VgeLWZKmQhKiR8kY0dlNesiP8
         F057bxlz4OjdO31Dg2eECux64orIH4Hu6JYU5arcOjcWogRi5NoHgRyaUdnrR59Os9Nj
         KNPGDR2R949KARjWErrA5lMq7PaOuihl2NFVkmLKoS73s65LWe2kkpaaoR14cT1kYSgl
         /2e3meH3LhebqFLGVBWskY3Fg7vFNulyzpEU3RddnCwGtL3Ds/+YFhnpaHGWgoZZ+79r
         y2JgWJYpcK4DUvBaxF0zvgrvKDmDddajsflU2cG+jofl7LuHLQR9qT7cDAacuIpP9Nj/
         g/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783878; x=1779388678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0w1B/WNpdAA+EnL5S0R/CNh9VLkXDvlbSwyd7Tzc5VE=;
        b=tBVR+uZDegbkIFYxEydYigeLh/NsSRD78QZ3dCt/MbD/32uX5PJBZ8U9kfL1QtaS75
         jyilxg6uupuVV5rIBrD1hP9k9cW4WmywaZQxEYJLp3jZIbppYPJkfPjoPqBQmzFOCnGL
         yK4gLS7XBDKAJVbaAejz//vIFzXr9lnntudHkKOqAK7NR8Rs8QfQcVXsLe0LOe2W7fQI
         5l82XVNp9zaDjO26bc0hB2CGSBJS9cOw18VNakKsE/wcm4qdywxSej9S4WYORsOX6rt5
         saUPjkmahV5ybEoX37Rd3KTZeY9Jv8C8qg980DRVBZ4pHQh1pqdmgZVWdfdxJu/B0vE1
         KDzg==
X-Gm-Message-State: AOJu0YyUFrnf7Zs018Z6ai3q04j8JzedWL2z7Ae/eOrBylsEWjn0jpVP
	V1Aj8KCAU/2HtPgVH9KACPxR5jB/IKl5Yv7wga1KEK8kV0iTDSWmH+hVthuodg==
X-Gm-Gg: Acq92OHUSiJOVox4/PgjZm5YKlsSxAc456ubZTta2qMBUsY9kItfyqE49HbyqRnq27w
	ElorI8gRCySPqr2e9njnOqJ/9KTN4j1ayr3yHPNUAf1uycFFh/Mp2ZLGlERo4znvRYg/Ro/u6O1
	JLXOzraVtA/CGKkv69ax2xBoEiZ8CjNe9LWwJYpRlUvL/xJ+cPMkdvImDafGx3F+bQa/jB8UNcI
	AiDXh/EOwj36bVXRrkoop2Z81Sc0kHPavVbF0hLcLx4CcmNrKRTl4ZUybWNLdtLOaVmiixH1x1o
	o1E2PUegejvaggINQicOJA+0NkFh8pnrvr3kVdbN1xvH1VKEQuTtZbEj50L2uv06o4wKnLLJYpL
	fdLZ/l4dZ07UfqWWlfks5sodp+ruYxfPz1IxivOZ6f9idvw8q0kxdLyq7lwwUmeVw0EweLe1/f0
	QE8Zgu6kxUtfq6ipQHO2iWqDSGWXUApSdGYx19Vs55Hw==
X-Received: by 2002:a05:6870:9d88:b0:439:bae3:50b5 with SMTP id 586e51a60fabf-43a2de9cd16mr556790fac.34.1778783877899;
        Thu, 14 May 2026 11:37:57 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:37:57 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/7] odb: split `struct odb_transaction` into separate header
Date: Thu, 14 May 2026 13:37:34 -0500
Message-ID: <20260514183740.1505171-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260514183740.1505171-1-jltobler@gmail.com>
References: <20260402213220.2651523-1-jltobler@gmail.com>
 <20260514183740.1505171-1-jltobler@gmail.com>
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
2.54.0.105.g59ff4886a5

