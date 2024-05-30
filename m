Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1F6183062
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072101; cv=none; b=tTLms/HFwu1sgqoyJnLmfL2d4QuqDckZUxg5vP1XnzvlWgjjuZMK/ur0+n6hhIbN7b9vFk4aopjJfZcHUPq1a1/pStiyuRhJGbdo1ssIzamZGq35mIrPwOJE+7KPtuDHcginXb6hHVggXMoyjN9THYwFcWZbJfowaYFY6QO998M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072101; c=relaxed/simple;
	bh=3IQ5QjcoQXV1xxd56njYvp7nx/L1vq71397Z3aPykCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORAF4gvzTLs/SqMnNyZfNPmI92rgojSQblsuURcQPgIrNNZVzcJi1LyzFuAf78CadMteihiNOSDBOSzf22o22nOh1rtVGlu0SLeZRzqdso48YKHj4Y5SH1cfEvTCjezL1V9NQMLHNbHyxty7mDsN1JYHA6Ys5yW9AsF3K7pL7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsUAGHAS; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsUAGHAS"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70232305fecso543828b3a.2
        for <git@vger.kernel.org>; Thu, 30 May 2024 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717072099; x=1717676899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG7FXd6XlaQQmMM9rQTt4+h9QkcItEY7gaip3pSGvwk=;
        b=gsUAGHASQSBBaK+T7IKzs7f/BSc3eqbPf09mq+p3oZqatUIo5EN26OZ2Tk7EPG8W5g
         SpX6dwJTPnw90458KxX2s+0LTw3h0RBugwEcdQDvGYBCBngKhiqIYGozJRXT9ftKeauu
         hcxYu6WuXRZVTjFKNA7RE9lNHqkUtEwajtfnPTCfRf2obRXdCAn1cuaBDsT79tS6/3Zh
         kXX38ECF9HXTiexbmGtkktG5xHCteG53jBcjq7pJ4RBaPIWEEoyj1VswhAZGbMqvPAc1
         iMQ/jfj0XHUvpjEzo5N3rwhFt6zdogk8d/n2X18v6B1whj26z3JXOTcpQIhHCQlWHCp6
         2mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717072099; x=1717676899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG7FXd6XlaQQmMM9rQTt4+h9QkcItEY7gaip3pSGvwk=;
        b=FSh7P0LT3i3l0axsgFibnwzV15J7F/sUmM9IOyhSsZPSsLzduZBVlsfrz2DSBlZR3p
         92laFbKVbDvDengCPvX4ihReoUEFRGaqC8diPfiylvXGaP8ZJdg/pQPLUwwOytYEvB3c
         eCp5aunA7dDXKUuLuSW1ilAMcXZ0/IqitCpNFA1YUTI0sr8V2WtcVuXZx+VISUca+unG
         uQs4fDgxI1DNCAyK4R4115eAgtG2PtikQUDv0JddgjdAh7hEXDqMV1pez71NtPaKHZQV
         MJ/DyBaziwm/ELBteoadL9BkkYmulggI6OIQ3XW2GNc0b/V38EfnFZEcxoo0fRkhPDOJ
         BcRQ==
X-Gm-Message-State: AOJu0YwytLRe8Fd8lRGnjahqastEKc63j9+CqtV6ARInh6VFKbcgbbJS
	hHDeygdqcMBe1iq/4WNxf8SHdGjQDtL1LcLMFKU5idEELSfaVHf4FlwPmUBg
X-Google-Smtp-Source: AGHT+IFCjvQgSwcu2/0Q+uG8auTAT5VbKiVtw6gPXv1RKeDlnRI3/l7z9WK3iEMSh1QZp2S+OIyafw==
X-Received: by 2002:a05:6a20:432a:b0:1af:dc83:75bc with SMTP id adf61e73a8af0-1b26452edcdmr2481545637.3.1717072098743;
        Thu, 30 May 2024 05:28:18 -0700 (PDT)
Received: from ArchLinux.localdomain ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c1f2548c7dsm321176a12.20.2024.05.30.05.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:28:18 -0700 (PDT)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH 1/2] refs: setup ref consistency check infrastructure
Date: Thu, 30 May 2024 20:27:52 +0800
Message-ID: <20240530122753.1114818-2-shejialuo@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530122753.1114818-1-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new interface `fsck_refs_fn` for the `ref_storage_be`. Implement
dummy method for files and reftable backends.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c          | 5 +++++
 refs.c                  | 5 +++++
 refs.h                  | 5 +++++
 refs/files-backend.c    | 9 ++++++++-
 refs/packed-backend.c   | 7 +++++++
 refs/refs-internal.h    | 4 ++++
 refs/reftable-backend.c | 7 +++++++
 7 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..65a26e2d1b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1065,6 +1065,11 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	if (refs_fsck(get_main_ref_store(the_repository))) {
+		error("ref database is corrupt");
+		errors_found |= ERROR_REFS;
+	}
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
diff --git a/refs.c b/refs.c
index 8260c27cde..5ac61d551c 100644
--- a/refs.c
+++ b/refs.c
@@ -316,6 +316,11 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck(struct ref_store *refs)
+{
+	return refs->be->fsck(refs);
+}
+
 void sanitize_refname_component(const char *refname, struct strbuf *out)
 {
 	if (check_or_sanitize_refname(refname, REFNAME_ALLOW_ONELEVEL, out))
diff --git a/refs.h b/refs.h
index 34568ee1fb..2799820c40 100644
--- a/refs.h
+++ b/refs.h
@@ -544,6 +544,11 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
  */
 int check_refname_format(const char *refname, int flags);
 
+/*
+  * Return 0 iff all refs in filesystem are consistent.
+*/
+int refs_fsck(struct ref_store *refs);
+
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
  * is acceptable, and place the result in "out".
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5f3089d947..b6147c588b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3299,6 +3299,11 @@ static int files_init_db(struct ref_store *ref_store,
 	return 0;
 }
 
+static int files_fsck(struct ref_store *ref_store)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_files = {
 	.name = "files",
 	.init = files_ref_store_create,
@@ -3322,5 +3327,7 @@ struct ref_storage_be refs_be_files = {
 	.reflog_exists = files_reflog_exists,
 	.create_reflog = files_create_reflog,
 	.delete_reflog = files_delete_reflog,
-	.reflog_expire = files_reflog_expire
+	.reflog_expire = files_reflog_expire,
+
+	.fsck = files_fsck,
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a937e7dbfc..0617321634 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1704,6 +1704,11 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck(struct ref_store *ref_store)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_packed = {
 	.name = "packed",
 	.init = packed_ref_store_create,
@@ -1728,4 +1733,6 @@ struct ref_storage_be refs_be_packed = {
 	.create_reflog = NULL,
 	.delete_reflog = NULL,
 	.reflog_expire = NULL,
+
+	.fsck = packed_fsck,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 53a6c5d842..ef697bf3bf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -675,6 +675,8 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
 typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refname,
 				 struct strbuf *referent);
 
+typedef int fsck_fn(struct ref_store *ref_store);
+
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
@@ -700,6 +702,8 @@ struct ref_storage_be {
 	create_reflog_fn *create_reflog;
 	delete_reflog_fn *delete_reflog;
 	reflog_expire_fn *reflog_expire;
+
+	fsck_fn *fsck;
 };
 
 extern struct ref_storage_be refs_be_files;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..f3f85cd2f0 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2167,6 +2167,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_fsck(struct ref_store *ref_store)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_reftable = {
 	.name = "reftable",
 	.init = reftable_be_init,
@@ -2191,4 +2196,6 @@ struct ref_storage_be refs_be_reftable = {
 	.create_reflog = reftable_be_create_reflog,
 	.delete_reflog = reftable_be_delete_reflog,
 	.reflog_expire = reftable_be_reflog_expire,
+
+	.fsck = reftable_be_fsck,
 };
-- 
2.45.1

