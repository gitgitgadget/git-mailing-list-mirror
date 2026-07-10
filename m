Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314F435EE3
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701453; cv=none; b=u7TKnXDA45w2z2qORT8mHy47J6JvmAkzeKaxeeQEO5WwrYLg+N9mUUA8+/eMU0s97Cn94/Pyor7coYYZLqOFcfnf4yf9QpAjCZw8yhJ5l3UglstQEi7jvz3BS9zEepnUtMGCOG52t7uLQ6ojZF/NEWXVdtSvmO6+wpLgStv60oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701453; c=relaxed/simple;
	bh=8hTmgM/g3ErdRMecjsXI8ecFXOZySHY1ceeXwQutiVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxDpJGXp2HSZ7TtfxHAwOdk87MEaYisOcKv3rdeWBlSX3SxGhaeCmrXMmoI8MYpjDeOAVXCfXTDZpAUD2x5vksgvXtIg7J897nchXc2Ezc4ShBRdRrjSr4NixrKNSJLYhYBca95cJTFlk+hUhXd6LJiBjEsp1P37dMpEwuMJONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxlysqGg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxlysqGg"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso951331a34.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701450; x=1784306250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=05iZUJQy6xYWWR4IulMLSmywaWrpuQZWdHjU1YpMrYU=;
        b=MxlysqGgbHkr3fj6MqdzTT3+U2QhLvHEF7rpHT7x+pzxMfPdwS656YMmwvtmvB2EE7
         0FQbNXq2bQ48IGSi56s/UNa3hAyc9R+3u7spzXmAUxdKJ66zHf7aOSj8Qzkegv5W4dL3
         Ne+vJbYLVE83N+rKDnY6ApAmPrIs7pcV5igi4C6cvPXNOc5ZYxUSEzoBTB2HWBvBFBDf
         jdEAZzRoP1Ya2kWJo8dxrCFRIHs9c5xFtJTmZ1v4bNlxcGTHkkhE3HyqzTk0dEn6Enu5
         7Q+KByQjJnYCzqDHBaVPHTMyyZjErFjXMcT4vhgvbmEpskEOBudO5I/naSwmH9LJboYy
         Ur6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701450; x=1784306250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=05iZUJQy6xYWWR4IulMLSmywaWrpuQZWdHjU1YpMrYU=;
        b=J3/6aplFW1n4RcgN2o0opt8BXau5qxhMONTZEDx4hwIGmYrlekXa+6ZZM6PTlDTfPG
         JUzgDgRSl9uRU0+9K8bKH/OH/Vzj5dIdcWWe5rbeEZRiQZu9K2M0m5bCf4Czb1OmZc83
         oOyxqW5XJYCVeERQnl2qR+c2EagyrdSD4xPaVHz9VWb5nzqraPX6ACzYpj6K7ZX4f2CC
         iZFWAdZ+X3Jd+GpBKg9bLPPw6M3C5hWRZ0BvNHclhq4TMfiAj32ebfGjoSDiLQYycw0f
         4+iYa/q7tiVthqeaXoPu6Y3Xz6TQda+ZgWqN8rZokYILTiytnJEkbgu1D1s8YM/QQHKG
         UX7g==
X-Gm-Message-State: AOJu0YwyB+Wkk6H+lpcQ1gnSdbmkBxpPzZQrKjOrUwSUvYWSca1EHY0W
	hwtReJ7P2RLQazu7puYnGeldsjp9Ac2yXkKJwM00fJWamBkiPjhRwQkUFhpDZA==
X-Gm-Gg: AfdE7cl/QEU/VqYVxzc8RF1WOux7Tt5tMIWG3wW1A/g2opkuJZmoj0J64Pr8A/4at6N
	l7n34SLnzSSct9TdxAS/K5Yv4Vku8fsbFEYMuTzFK4ygMSKF0ZvXTO+ie0MqaLaTLJc3U+lML9g
	mIJGhS2xxdzNPCcOkTkXB32L+cKSSyHldK/bhzjiJbsKJ265MfIl4Atn855C4pN7VIY/eH9dRpS
	+P1pFzhdrNU/GlQVpIZu2b9tT2MlAuoqXVur1BiDXSgOqtrpJ3TXFDCBLYQLSqL1icROD2xaWfg
	6UI7QTuDT5UbjZ9zfaCdvhe8NXc0ET9p/wUcTh/VRTkdJ4dRhyxBZ2TiVWfV0iHbAHV3AtTOGOy
	I5WMwlMllpiudo8/+9lfWRcPj8x+RvMRRRUuIznwomETymbVJNQ4DT+o1id9jy7klb2xPO5JD15
	kJMIi3aWc15se9/pzKBav6
X-Received: by 2002:a05:6830:3747:b0:7dc:d967:63de with SMTP id 46e09a7af769-7ebcfe4264dmr9696375a34.3.1783701449924;
        Fri, 10 Jul 2026 09:37:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:29 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 03/11] object-file: embed transaction flush logic in commit function
Date: Fri, 10 Jul 2026 11:37:14 -0500
Message-ID: <20260710163722.2962278-4-jltobler@gmail.com>
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

When a "files" transaction is committed,
`flush_loose_object_transaction()` is invoked to handle performing a
hardware flush along with migrating the temporary object directory into
the primary and configuring the repository ODB source accordingly. The
function name here is a bit misleading because the helper is doing a bit
more than just "flushing" the transaction contents. Also, in a
subsequent commit, the transaction temporary directory is used to stage
packfiles and not just loose objects anymore.

Lift the helper function logic into `odb_transaction_files_commit()` to
more accurately signal to readers the operation being performed.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 64 ++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 36 deletions(-)

diff --git a/object-file.c b/object-file.c
index d68824bb44..33bd6c6810 100644
--- a/object-file.c
+++ b/object-file.c
@@ -543,41 +543,6 @@ static void odb_transaction_files_fsync(struct odb_transaction *base,
 	}
 }
 
-/*
- * Cleanup after batch-mode fsync_object_files.
- */
-static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
-{
-	struct strbuf temp_path = STRBUF_INIT;
-	struct tempfile *temp;
-
-	if (!transaction->objdir)
-		return;
-
-	/*
-	 * Issue a full hardware flush against a temporary file to ensure
-	 * that all objects are durable before any renames occur. The code in
-	 * odb_transaction_files_fsync has already issued a writeout
-	 * request, but it has not flushed any writeback cache in the storage
-	 * hardware or any filesystem logs. This fsync call acts as a barrier
-	 * to ensure that the data in each new object file is durable before
-	 * the final name is visible.
-	 */
-	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
-		    repo_get_object_directory(transaction->base.source->odb->repo));
-	temp = xmks_tempfile(temp_path.buf);
-	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
-	delete_tempfile(&temp);
-	strbuf_release(&temp_path);
-
-	/*
-	 * Make the object files visible in the primary ODB after their data is
-	 * fully durable.
-	 */
-	tmp_objdir_migrate(transaction->objdir);
-	transaction->objdir = NULL;
-}
-
 /* Finalize a file on disk, and close it. */
 static void close_loose_object(struct odb_source_loose *loose,
 			       int fd, const char *filename)
@@ -1679,7 +1644,34 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
 
-	flush_loose_object_transaction(transaction);
+	if (transaction->objdir) {
+		struct strbuf temp_path = STRBUF_INIT;
+		struct tempfile *temp;
+
+		/*
+		 * Issue a full hardware flush against a temporary file to ensure
+		 * that all objects are durable before any renames occur. The code in
+		 * odb_transaction_files_fsync has already issued a writeout
+		 * request, but it has not flushed any writeback cache in the storage
+		 * hardware or any filesystem logs. This fsync call acts as a barrier
+		 * to ensure that the data in each new object file is durable before
+		 * the final name is visible.
+		 */
+		strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
+			    repo_get_object_directory(transaction->base.source->odb->repo));
+		temp = xmks_tempfile(temp_path.buf);
+		fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
+		delete_tempfile(&temp);
+		strbuf_release(&temp_path);
+
+		/*
+		 * Make the object files visible in the primary ODB after their data is
+		 * fully durable.
+		 */
+		tmp_objdir_migrate(transaction->objdir);
+		transaction->objdir = NULL;
+	}
+
 	flush_packfile_transaction(transaction);
 }
 
-- 
2.55.0.122.gf85a7e6620

