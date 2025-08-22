Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142520F07C
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898508; cv=none; b=SbsivCj/t/yq7mFu7nnjBVdM5cVjEnaKbaN5j5kRucM4kwVqlFsmiQ7DQdid9CT5290HySx7+iGXJhkFf4mA6p4tlz67RfGjX4eWe4ZZb7Vp035Cuj0OukmaqF0oEZ0sAoDbknkdH+G7Bbc8yVa9L5CG+WlJdvChloKCLv936HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898508; c=relaxed/simple;
	bh=nfwPby8IYnOQlq5EwDOI+NupFHVwEaazYNlT1dB0ZRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4Sfc0TADE6ub1ghQUO1OP25gGklFeKH+SsVIVzLsr07dCeB0zlT1BjaHs9cUQ9y30JPuzlZeWmZBH1Qqby+iNUNP9IjrBf04ilQIQRtoE1dV4TsX2x9T9mYx5hyVlWidtiba2of/klDEbiBERLV3dSmIzrR500b0av0wcq1r/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFQPAy5o; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFQPAy5o"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61beb53bc95so946834eaf.0
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898505; x=1756503305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVRf4AaGTSLv2E7JTTHkupQWSMK8PvlA1x4nJcEARGs=;
        b=UFQPAy5oP1LQJvNliARQu3sF8Vcy45TopW7s6ibXOgdfyHXK1cpQgAzcwO3AB+d/y0
         2pLhkGSUO6bmh4pO33Dg4jt55Hua8BYJ358+bez9B2zy2mKOjQtEbsGM2+xN/qZNGnks
         xJqT4Sj/dTUXKpmwT7He3jqjGIm8YcLmOwqgw8VuJGKJVxl9tWWIjrkf4VuzNVr8SR6G
         Fdz6tkLKAjE1tgAXEK9wLyNLbey/6/maxL1YkpkYTy08Cw+e0sFFKqS1yzRlw+J+gLPj
         JKd7SgvBgPI15CxkAkq2Rhu8oEoCBm0OJ5HnGnoYvLHe5xIc/ogRAzk+jmhjOo0vFwX+
         qJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898505; x=1756503305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVRf4AaGTSLv2E7JTTHkupQWSMK8PvlA1x4nJcEARGs=;
        b=uUjrFyj8VQAdAulOCOViAH2ti0Cg2LHNg8/ATwYi+1PuhOcFHYMg6VNVhH6b+nPOCy
         a7kfGqUPwn0b0XaAQ7hSHcPX6hPeknwH0n1VmJQ4E9U8JVX4BM7zvibgCbPSy+7VL83u
         j7UUtKqC3TtxGmYp0XmeHhwbfaslM2PIT8wdfXdKqYKVXbo0k8FcjT9r6Y6/0ZIvHMd8
         a4wdLfC/gM7IN+VB+NV29nS/QihAK3vQOUHbirJX1YeQwv0TSBzurmetX2JbNSoU6lnH
         Gv52X1UxzQazj4/YrPnuEubmNqR2udAw6nbK+/DolJXiNWXimATdpACOWCY4vPTi/cTR
         fRmg==
X-Gm-Message-State: AOJu0Yxqj7nYtulLE4DMF7LtyWPsTkD6xZFVkRCpGZbGbmPE//7Q3Mgq
	9tSdgI12UTPFo/jDWyZtHT6nhYhLKAXhKmfAHmys/xw43tA2zcJ4LdNYIXq3PbA0
X-Gm-Gg: ASbGncsPilhx7aOZkHQ2cqSQ3A3DerQyVeuCSRtBtanEf2uYU0Kcvwj9rhqMjktTkFb
	um52JbbGvan+GL8VMzeBv/JBUvPfNuXsVAMT8WvGVUvMTB6d70nzJLQm+Vdd7j8qpOlZRd3fuCO
	aRw+SV7x/w3g2mcOl4QnAtJi8ZdwqBak59QGHxM2qpcwdPnGod1hDaIwCIThy1UglzjiuwBQ+o8
	gvqYXdy4XGV2UI4OFoOzQ54HDpIyPx3dp5c03SRFyzVmn6AjzaGIyvxQh1cq3xPDEBp+AOuQjL/
	V+kK5BIpHHCR3vAgM6abBGc5KL70O61f8zTA+oAdcKb74rC3RX/3LyCY90ssIRif6Mib3qD47OV
	oHvkPpQY3SulxuKeoM4e8zDRPZKjrecg=
X-Google-Smtp-Source: AGHT+IHvVaV4h6ATUnK6NuEsAAfOK/gYEFAEYoIr1qeZ1i9EQ/x+qeheDqvtERWTLFrrcq1OXqPfLg==
X-Received: by 2002:a05:6820:16aa:b0:61b:924a:b7ab with SMTP id 006d021491bc7-61db9e08c3amr1879645eaf.2.1755898505562;
        Fri, 22 Aug 2025 14:35:05 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61dc78c7814sm156497eaf.22.2025.08.22.14.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 14:35:05 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/4] bulk-checkin: introduce object database transaction structure
Date: Fri, 22 Aug 2025 16:34:57 -0500
Message-ID: <20250822213500.1488064-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250822213500.1488064-1-jltobler@gmail.com>
References: <20250821232249.319427-1-jltobler@gmail.com>
 <20250822213500.1488064-1-jltobler@gmail.com>
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

