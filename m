Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CDD3AB28F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555182; cv=none; b=NDD74ZwGF6bd1BJlSVE9DzdhSJJ/5VYGLzdCIpyLqaTAdwHeEbDTpNWsGQ/YDGW0qf1I/IofQZ+SxxpbM0cK6iYEUIyKyrhbBSr+inOLXSCmLisLC9s7NELbEhmFh/loWywtEQmv2I5nwOfnurITu5WLtUrYVkkwqXLjgtoxrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555182; c=relaxed/simple;
	bh=VOsyazLUhcKmTAqvXtw+OerI3v+NbjC26/T1tIrvn+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o49bOvH7Njau1iT1rVrxeyKkT7OCUd+A/NWpWp9lcYw58t9y4F5A0+APuFTqM8fXBRbEBA9pyJmY9Xbssa5SSo3OWaefeyC5JKsujwE2l/CJXj29aDPhDhY3NKR4v1j4uNtPSIfpgZJLzE9ecv9YMGuwyo/HI4t4jjMayPWmI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfPmN7GU; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfPmN7GU"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-44cd990a94dso693321fac.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555178; x=1784159978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LvrNPyI3Uofen8xm9oHrIgUepdjI+RwtMw7Q/08A7ug=;
        b=nfPmN7GUZbHmvT5IoEjxGLVekXIjMB5aLNQP6MThgPVIpE//G4pqTUTe/cZ2M0uRkU
         9ZgTj21xq/hO28iGtHeo5limf5mzi6d3EXphzSAkzKHmo6UzO9mHcmc/qho55g0T0SMe
         AkGfsUC68xTLCkSAFf+RTa1zEmZ0qZqTKrU/4Oq7dJQ0Y9kcw89BrpKEyqWbvfYqgi2P
         A9GuV3RaiUa+a7yONQ3gNtM10H22Dc9yK993pt7wCp/dM2GrhuR4p7OPx7rESjDjdb+F
         bYN19W0EiPRcc8ceouDiugR6HfHQG5z/mg0wzoPael3I4+iHN3azhabS9HKtZGohC68R
         fIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555178; x=1784159978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LvrNPyI3Uofen8xm9oHrIgUepdjI+RwtMw7Q/08A7ug=;
        b=jQFE4g6OYR0s6OPhxzNYdDOiMpZpgC6lg+WKVnVMN3Y7XVAhjyTpmE8REmKk2ugygb
         V0yQIEBdJJQA9gaEj3nHuN3czvEwpZwpkMEbZ+5/218D+Rn6W9QGTuH9QQJ6XhimE+KL
         gOxZtzvTp0lCQbdfzFQXCl0xPGIW/vdonIgDEyknev0J1LPAgFM9gNr9qMAzHHpLtBng
         QwddpDcF//NnMzHPdXFSHjop3dTZskrLLm6RQKADVg8FKk5baOQAYlcKb1NiWf5m6yPf
         SCpzyXEnkHgwXqkuPrAKjR45x5glbey4W1UX7WIXM/Eykf8B+2xOVVbRGaEeDbYinSaL
         r5ow==
X-Gm-Message-State: AOJu0Yzzms3JKe+UARtp5dHeaMif9x1BYBHLkqrUGZglvVVXQyo4pa5/
	19SV5PPSEy44YtDThhs69hZ/vrclnyhn5ZOjadgWpCjcPZ4o0euriDaZinEJkg==
X-Gm-Gg: AfdE7cngcAD6NLB6Rj0Cpg0seM7+8TFjlzKofNVpVf9gTcsd9JwkoFGR7DrrIEcDTDm
	M/ydJ11zucqYq0CP7+K4QUXWvEKxbogGWB3bAK/P/TP0EKYJ+Ev0Pl7P7ABkFH2D+ZtTFZCLdVg
	gB9cQ/l1b+Rj8HM1bJIuAr3GfAzE3bksZ2fhO9lyFIbg4WewrLdwNRYv5TzRKlOhKbwEiVGylDy
	HcD3KHWoNBpniPTDxgI6E6IoBAULo6LDJZ+m44IbWZBdv/BlAZipT/fpk/6/4W0PVRU0jzXlXDx
	G1jsJaPBYizx9YDp53YTt5C/0+3WlMjhfjyVpxWdtZObJItvZxjjilByT6Wrjn1+UbGoOYsALiV
	0m+CN3aedm21LOIrZMoYbSHceTGm7ePCTavQZyeuWPsInYTs4gIiKLXHEpBi7QrHBL6jVMCZcbv
	sl+1Dh/4VA4n1yIPZ43B5u
X-Received: by 2002:a05:6871:c8ea:b0:447:1dd3:19bc with SMTP id 586e51a60fabf-451637acb1dmr2296719fac.2.1783555178303;
        Wed, 08 Jul 2026 16:59:38 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 08/11] odb/transaction: add transaction env interface
Date: Wed,  8 Jul 2026 18:59:22 -0500
Message-ID: <20260708235925.3992097-9-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ODB transaction backend is responsible for creating/managing its own
staging area for writing objects. Other child processes spawned by Git
may need access to uncommitted objects or write new objects in the
staging area though.

Introduce `odb_transaction_env()` which is expected to provide the set
of environment variables needed by a child process to access the
transaction's staging area.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c     | 14 ++++++++++++++
 odb/transaction.c |  8 ++++++++
 odb/transaction.h | 17 +++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/object-file.c b/object-file.c
index 358684beae..f0b066798a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -27,6 +27,7 @@
 #include "path.h"
 #include "read-cache-ll.h"
 #include "setup.h"
+#include "strvec.h"
 #include "tempfile.h"
 #include "tmp-objdir.h"
 
@@ -1687,6 +1688,18 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	return 0;
 }
 
+static int odb_transaction_files_env(struct odb_transaction *base,
+				     struct strvec *env)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+
+	odb_transaction_files_prepare(&transaction->base);
+	strvec_pushv(env, tmp_objdir_env(transaction->objdir));
+
+	return 0;
+}
+
 int odb_transaction_files_begin(struct odb_source *source,
 				struct odb_transaction **out)
 {
@@ -1696,6 +1709,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.env = odb_transaction_files_env;
 	*out = &transaction->base;
 
 	return 0;
diff --git a/odb/transaction.c b/odb/transaction.c
index 0a924e73f7..7f1b30945d 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -42,3 +42,11 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 {
 	return transaction->write_object_stream(transaction, stream, len, oid);
 }
+
+int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env)
+{
+	if (!transaction)
+		return 0;
+
+	return transaction->env(transaction, env);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
index 3b0a5a78e5..5e51ce5ca4 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -34,6 +34,14 @@ struct odb_transaction {
 	int (*write_object_stream)(struct odb_transaction *transaction,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+
+	/*
+	 * This callback is expected to populate the provided strvec with the
+	 * environment variables that a child process should inherit so that its
+	 * object writes participate in the transaction. Returns 0 on success, a
+	 * negative error code otherwise.
+	 */
+	int (*env)(struct odb_transaction *transaction, struct strvec *env);
 };
 
 /*
@@ -69,4 +77,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
 					size_t len, struct object_id *oid);
 
+/*
+ * Populates the provided strvec with the environment variables that a child
+ * process should inherit so that its object writes participate in the
+ * transaction, suitable for using via child_process.env. Returns 0 on success,
+ * a negative error code otherwise. Note that, if the specified transaction is
+ * NULL, the function is a no-op and no error is returned.
+ */
+int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env);
+
 #endif
-- 
2.55.0.122.gf85a7e6620

