Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF12D9786
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730549; cv=none; b=L7kcEkBimPQ8+rXAwKfCCtyh1BTglBAmiztbVQzER43iDyatXpz4x/nFGqE8LWgYMASwhoYExS5lfNHCfEhVb9rMFg/lCY976Rgh9XNOnSEJhVdk64qzOoXsHgOcqnLS3M+S1KWfUgJlYnYzFK4Ls8OU+omw5uiT+n2OjrQTOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730549; c=relaxed/simple;
	bh=nfwPby8IYnOQlq5EwDOI+NupFHVwEaazYNlT1dB0ZRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJcZaXWu9XTqMV4fGtFUAIO9GP/B1Moh3G+VzKdqB+Q5x00He9kuM8kB3EtSUkLbBfZ3W1mWsHX6nTY6mru5CG3Zvgz2JS6+4TeS2U6j2OiSAscyF9ilaANKa+UXkE6Y2Bc6HcnExz9IodAxbT2LEpwIw/aJssKGhPwPPDjtOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqvDsESo; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqvDsESo"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cceaaecd8so223098fac.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730547; x=1756335347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVRf4AaGTSLv2E7JTTHkupQWSMK8PvlA1x4nJcEARGs=;
        b=aqvDsESovFMCtGhYARTB0ODI87s41pm2G218CFbrTK+vhIYF0l+3lxg19V/YgF39g3
         JMHWk+lu0rJvMQnnWazkoCWx5noS8CB3AnJBpAvW20+l1v6m4I0IfvoXRfKMRmyyI4/x
         DHmbQFTvySTIc6SJzEvKoOkV1DyGYAVd+NH97YQEJ/p2toxyq/0c4R63rEaR2ZCC0CKF
         BKT9njpFoEnagrTo4ILJjNI2pF82mwUIIwP4uJzShOM7KjgcINpgy8Dik87Zh2SDGE3K
         QdIs2iAiZNo1Wy/jV9lnYyKPMeC0vlZ2TsfPaBBWbqaueRtn4i5myeTwtlmPkPkbvaL0
         u+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730547; x=1756335347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVRf4AaGTSLv2E7JTTHkupQWSMK8PvlA1x4nJcEARGs=;
        b=HlYbguMKRTxDWhGAS0C9+HC7R/CxmNkx22AKx0qcgj7b1TYgkI6PK62XmM95yxpkqU
         JWI/0Um4dFysZm1Z+MoJ7mVIVzn/Qr+pCrSbf5yLZ6ynjxP/ukTf6Xu9XY0MjjYKpXlw
         k6S4seSJR7Rfd1dhbbJf4WOZp40qQjTcnrdHbhLd4QBoR8PixB5GYPmChAlL4ZXbvHNr
         Tv45PPRDohfniBIyUuEJ9HO+dwVWtrU4L2GICfFBa3Z5Py6S1Z4y1XM66gYyuTCPJmWm
         pv9zyCgVbrdXD5JW8s9rCQu3gBEn4GGtDFb9nFhcnyNZNk04atqB5ABi6Kl9OMaSvlyn
         ctew==
X-Gm-Message-State: AOJu0YzMo2h50T7puGf1RI9aTVtTQBbj0qmaRSZvo4NT2GC/dp4S2Ude
	fu3RuujE37NZT+Sd9RZ0j9fe0lP3s89Uoz+QkZ6zisfsqSDFyAsYquIBkAUI8Fsz
X-Gm-Gg: ASbGncuS24YFoxf3d8/e4GcNFy9j6AZp9Mg3Qn8tmbYlEtYSUqNx0xyss7P4XsrO6uY
	R3S2/MQ8zgMIZFgPIN8Q3mPaAwIymAYFUY5v0W2IzQBni6FDVhrlq3HQm0xX5k4uE6pfkEhDXMS
	NCqftw8I+M4ZpVIL8pVxv3S8PVc0xfE5Urf8mm4npwnri5PonnWWilDBBb7V4bg60ekPTt2aVyu
	/pX7T0pDNFP/gDQRnaFJ1CMr4yMdMp+KJFAniRvkzBFlbKZ7IJhl2lkpEwv+reL6PEaehf10Zju
	QUjO5D6JsvxOAnzLzI3MYNUNAH9BquHbroJxHWPS+O5ZMIaq74abtXcZhqt8u8Ah+FnC6KNypaC
	spxXhuz30E9tJBZdRFzQ1/nsWenuttvU=
X-Google-Smtp-Source: AGHT+IE3Q2+dBBxtNHkpJ7pL2DYyubKhzNdaFc3mBNnhc2b/oDOIpHQw7JK6DRr1AhXBXHthvP7YMA==
X-Received: by 2002:a05:6870:169b:b0:30b:cb15:28b1 with SMTP id 586e51a60fabf-314c63a5e37mr178483fac.7.1755730546969;
        Wed, 20 Aug 2025 15:55:46 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3111d32f9e8sm1175860fac.21.2025.08.20.15.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:55:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/3] bulk-checkin: introduce object database transaction structure
Date: Wed, 20 Aug 2025 17:55:29 -0500
Message-ID: <20250820225531.1212935-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250820225531.1212935-1-jltobler@gmail.com>
References: <20250820225531.1212935-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Object database transaction state is stored across several global
variables in the bulk-checkin subsystem. Consolidate this state into a
single `struct odb_transaction` global. In a subsequent commit, the
transactional interfaces will be updated to wire this structure instead
of relying on a global variable.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b2809ab0398..82a73da79e8 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -19,11 +19,7 @@
 #include "object-file.h"
 #include "odb.h"
 
-static int odb_transaction_nesting;
-
-static struct tmp_objdir *bulk_fsync_objdir;
-
-static struct bulk_checkin_packfile {
+struct bulk_checkin_packfile {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -32,7 +28,13 @@ static struct bulk_checkin_packfile {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} bulk_checkin_packfile;
+};
+
+static struct odb_transaction {
+	int nesting;
+	struct tmp_objdir *objdir;
+	struct bulk_checkin_packfile packfile;
+} transaction;
 
 static void finish_tmp_packfile(struct strbuf *basename,
 				const char *pack_tmp_name,
@@ -101,7 +103,7 @@ static void flush_batch_fsync(void)
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
 
-	if (!bulk_fsync_objdir)
+	if (!transaction.objdir)
 		return;
 
 	/*
@@ -123,8 +125,8 @@ static void flush_batch_fsync(void)
 	 * Make the object files visible in the primary ODB after their data is
 	 * fully durable.
 	 */
-	tmp_objdir_migrate(bulk_fsync_objdir);
-	bulk_fsync_objdir = NULL;
+	tmp_objdir_migrate(transaction.objdir);
+	transaction.objdir = NULL;
 }
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
@@ -331,12 +333,12 @@ void prepare_loose_object_bulk_checkin(void)
 	 * callers may not know whether any objects will be
 	 * added at the time they call begin_odb_transaction.
 	 */
-	if (!odb_transaction_nesting || bulk_fsync_objdir)
+	if (!transaction.nesting || transaction.objdir)
 		return;
 
-	bulk_fsync_objdir = tmp_objdir_create(the_repository, "bulk-fsync");
-	if (bulk_fsync_objdir)
-		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
+	transaction.objdir = tmp_objdir_create(the_repository, "bulk-fsync");
+	if (transaction.objdir)
+		tmp_objdir_replace_primary_odb(transaction.objdir, 0);
 }
 
 void fsync_loose_object_bulk_checkin(int fd, const char *filename)
@@ -348,7 +350,7 @@ void fsync_loose_object_bulk_checkin(int fd, const char *filename)
 	 * before renaming the objects to their final names as part of
 	 * flush_batch_fsync.
 	 */
-	if (!bulk_fsync_objdir ||
+	if (!transaction.objdir ||
 	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
 		if (errno == ENOSYS)
 			warning(_("core.fsyncMethod = batch is unsupported on this platform"));
@@ -360,31 +362,31 @@ int index_blob_bulk_checkin(struct object_id *oid,
 			    int fd, size_t size,
 			    const char *path, unsigned flags)
 {
-	int status = deflate_blob_to_pack(&bulk_checkin_packfile, oid, fd, size,
+	int status = deflate_blob_to_pack(&transaction.packfile, oid, fd, size,
 					  path, flags);
-	if (!odb_transaction_nesting)
-		flush_bulk_checkin_packfile(&bulk_checkin_packfile);
+	if (!transaction.nesting)
+		flush_bulk_checkin_packfile(&transaction.packfile);
 	return status;
 }
 
 void begin_odb_transaction(void)
 {
-	odb_transaction_nesting += 1;
+	transaction.nesting += 1;
 }
 
 void flush_odb_transaction(void)
 {
 	flush_batch_fsync();
-	flush_bulk_checkin_packfile(&bulk_checkin_packfile);
+	flush_bulk_checkin_packfile(&transaction.packfile);
 }
 
 void end_odb_transaction(void)
 {
-	odb_transaction_nesting -= 1;
-	if (odb_transaction_nesting < 0)
+	transaction.nesting -= 1;
+	if (transaction.nesting < 0)
 		BUG("Unbalanced ODB transaction nesting");
 
-	if (odb_transaction_nesting)
+	if (transaction.nesting)
 		return;
 
 	flush_odb_transaction();
-- 
2.51.0

