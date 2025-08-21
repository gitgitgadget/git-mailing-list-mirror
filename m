Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AF296BDD
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818578; cv=none; b=BCX8BqO3SJ+nCfhd38uXZ+okWgDwSDJchJLdFonukqFBgkQ7mMy5lbkqi2QDc9qm11ZuaRs+U7DogatQlqgATH0k4b7iMVxQERZ6oPvg1EVthM9muqIdrHEBri3WKklweolkHWxTPGOU7sFh1tK9PUuRBZydOIR03yIC7F0XGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818578; c=relaxed/simple;
	bh=nfwPby8IYnOQlq5EwDOI+NupFHVwEaazYNlT1dB0ZRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ive+zi1wnWfaWJpzgaw8plE0l7dJJvvep6Bj8HoIxWd5S+SFMPol+vJajZZmWlBHbNsBFDkHUeqDlKVmO7tFqawXGoFRE+hfF1z1RWniZJwmPifqaLbbfdk+MySKR1yS9GmWdyviMdCf/eNp0ZlfBYpWSRFRul9wnQBLIx0ovlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAZqUYf8; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAZqUYf8"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61bd4ff762eso766089eaf.3
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818575; x=1756423375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVRf4AaGTSLv2E7JTTHkupQWSMK8PvlA1x4nJcEARGs=;
        b=jAZqUYf8yY5ghYIFyv9j5sYwysBjsLnRBA3z3Stu5rWY5h3LEUIOSScSD1y069tHHy
         /W5Ta29GUpFEqWHos2jNBrwc+UjiJ2m1jRcEFpHuQgfWiG3FNHu8SDiqm0S2UcVfKZAR
         g4iBB7nn6gVPzDawlQ/h8fSaHaz9gChy8pVICt1o5hhrGwZUGfQ7LAKLSZqghNXYN044
         GdmFNSnF5qiIsPVUfTeylzPCHiix/5VZ16t9KgJP6jd/1nhQDv2ezXIuD1zsF6wn8wyI
         BErIkbEPMo6UVtU2zGti8d+2q64o0Ows0OO3fdBT6u03PRLrMqS/oIyrhxcQU3MRFTj2
         fMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818575; x=1756423375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVRf4AaGTSLv2E7JTTHkupQWSMK8PvlA1x4nJcEARGs=;
        b=TRJknquNlJMrsN9GzIXm8vapLZvOe18vHsP7Kl2qwqD5W9T2l6Jtk7yuwhwzMSB6ML
         LV2INGjxXwmD8YPBj8ddMhphmy/BAz2j+pa5d22i9ibE/Zm15oyBsHLXPGUy3kCQ39Zs
         LC2Xmd28ctCS8F/MuVdziRMxu5u0ikbbhZwt3ph4tA4zzp1ogdTSY035KhY2+531akfL
         gVHrGxD00XdZ1kCzqCiIcCuCQZBt69w0BYewQOZ8ivwd8nTi/s5OnGVmHLE12Ikbikig
         eQU+es9UJumZvx7/ie6ElEl/g7i8H9bZyEnCpD2z6ag5KQYa/aMyGEKDL0GpV6F5Aqvz
         bUQQ==
X-Gm-Message-State: AOJu0YyMVclvkBTZq6UWLXl6mhmdtS7c1nrjU5EgkfdB2BezN/aiEONB
	sPcWwgeIyw6ot3aIfGTRv1U2BxUeQEyHBDeBW6Dbsl83VNQNYEZvxF7tjkd7lr6G
X-Gm-Gg: ASbGncuwgn6Dzsnh+5k6UK3+WkOrj4AslK32T7NgJ6xiTE6B9Nf4MFiH0eBFRNgNkc0
	2AWz92Qr4TJDVh//4zRSa8yYWKvmnyDZwcJD8WxDb9t+Z5htjEDI8JZrN8E2oDrP+uil/aA7zy4
	tAFxc3NnBd9kKWRFTf/xQcKoYyJxsb3h6UhcZa5Jsik7Fu1RR1byugbPatxgMsP/DsdmjxwaQov
	GwwGUthSw3bFHLWXsuA5qhPUrKjhayQRoV7DbEA+RC/w174ZLTNzMUxfe/vnNsjmRr260BHyqAv
	vE2UtpHYNxqEd0RU9rEMXLs65FimHimEnuDUp+39m6vPyHQQ9o3EZDlU/oD1TuFOczYYfhp5o/g
	fOAd57QDDSIykjB1rxaBlxn1YqcxgFO70KlRqJZ58bA==
X-Google-Smtp-Source: AGHT+IEvCyNHrIfVn+5XA6GBxunotbLzdBAWLizUpJ6xwRsDxxfYlFAGTW0AB2zw1eZAFOccTnkOXQ==
X-Received: by 2002:a05:6870:ab1b:b0:30b:beb3:5424 with SMTP id 586e51a60fabf-314dcbc281emr418495fac.19.1755818575268;
        Thu, 21 Aug 2025 16:22:55 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204d621sm3759747a34.40.2025.08.21.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 16:22:54 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 1/4] bulk-checkin: introduce object database transaction structure
Date: Thu, 21 Aug 2025 18:22:46 -0500
Message-ID: <20250821232249.319427-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250821232249.319427-1-jltobler@gmail.com>
References: <20250820225531.1212935-1-jltobler@gmail.com>
 <20250821232249.319427-1-jltobler@gmail.com>
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

