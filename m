Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30364140386
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593026; cv=none; b=nud3yt8/QT0AiIEG3mM0BJv1qdOgfaI0AJkcOebXYEDEcn160RWejlFyrdX2AQDSErW/Glbu38vmsHRihIvJieQ0amP/kzPKkyEauC37JcdohsRU6qiISPqTKg/6tFlZx3yAtLveOAHVGMcb96MVLniurUGNlX43m94YKbrQxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593026; c=relaxed/simple;
	bh=lDcTbEshzPX9Q9GzNBEIhQPLw45DqIjU2UzSFZAphCA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W2TYkDn1ssa2J/+c8MV8WxIl+3nsnL4/e42EEcGO/obbROToT9Qrw7pHevZSkcCIvpHkfu9TtAlqRyefjxkowa5SKpGszSdq80aJDG4ZgI1/Q1sqKncgK1LpQ8TkBnmG6DY6MBHN05arosE2U0eRVxkW0JYCFhHrqB1G0DaUQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI+lEhvV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI+lEhvV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-416511f13aaso10719885e9.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712593019; x=1713197819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haAH7RPGDGXrPMNWd5MpiDXlapJDFBYn8Gm0/3RlgVM=;
        b=bI+lEhvVOl8nIev58ju3Brn1MJ2Jt1+yPJAwE377VybFT4kn66XKlR44ftNB5r3evR
         vTn+pqVRPIsfV6WNUuIj4a9LfWoyBGR10/RMoPvm3rXRuwfjRMIfrlJJyqG2QAtAc2Ug
         C2+d75iASecU3ZLgPOycQx0Iz9Txrnk4WjPQzYNrBF8a2ndZcm9pSn8Dlg2TaYpzyQoZ
         vRb+fyqD7BPCYzoz7a7XRgJM9mX8vKRt3W4CnrUyHcka8wU8WDxiPrYiiQFmoB/WQUal
         KqhMbKpRoGfN0bVOf2fnNKzJ9uZeKMx+nJkT24QzrWm9bDlGMRBqfPUu8eN9BkgepGml
         qa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712593019; x=1713197819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haAH7RPGDGXrPMNWd5MpiDXlapJDFBYn8Gm0/3RlgVM=;
        b=Wk7ZOuwZNIICIQKQmGej7fWDoLdp902H4xdyUUFiv/wPyZQb8yDUt5Ef5ydDeLQda4
         MF1zF8JQvyI5WzaaZtJjVEMuHfr5sK0OnJTkltK+6/syqZUWmFX8ti8ht+oMt6ikLuHc
         YYJvlU/EwvfnTw84YG/F3DnbNQb/Uo20HxrEhG3ZK15KONjOJqYXvWFJlqaAl1IPKst3
         EtLAkN6DS8WzFEQZcGQ5/OuAiGHh5xeKiECK+lPYf8LYsCzUbwO1n4J0+ApXm1GK3+QF
         Vcq6NuPaF1vrFx4u1OaAo6BoaDiM3qxLe+q42pZj683C67rTkZi8zr3Z80i5GkcZf0mu
         IFBQ==
X-Gm-Message-State: AOJu0YxKZS5clVEaCCOaJQWKUEdLDiKsV4sb1TjuzIlKn09CKfI/rY4m
	YsS9iQLjazkWXb8xkswC6P2JQkWy4k04SlDfcLAeylT41L6CXxCjw0NXhrZ/
X-Google-Smtp-Source: AGHT+IGA+Rygk3rsm+Uiz8ovbAQZr4MdkK5g3A/e0Wv8vpBb6zLBD5AxP4ohrIY+CkPrwuMIbxV4fA==
X-Received: by 2002:a05:600c:4750:b0:416:3de5:133d with SMTP id w16-20020a05600c475000b004163de5133dmr5081966wmo.7.1712593018456;
        Mon, 08 Apr 2024 09:16:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i21-20020a05600c355500b0041665b6e111sm5159761wmq.12.2024.04.08.09.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:16:58 -0700 (PDT)
Message-Id: <9c8f6b336ecea50b1c0476cd274481560aa79740.1712593016.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
References: <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
	<pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 16:16:53 +0000
Subject: [PATCH v6 1/3] reftable/stack: expose option to disable
 auto-compaction
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Han-Wen Nienhuys <hanwenn@gmail.com>,
    Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

The reftable stack already has a variable to configure whether or not to
run auto-compaction, but it is inaccessible to users of the library.
There exist use cases where a caller may want to have more control over
auto-compaction.

Move the `disable_auto_compact` option into `reftable_write_options` to
allow external callers to disable auto-compaction. This will be used in
a subsequent commit.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 reftable/reftable-writer.h |  3 +++
 reftable/stack.c           |  2 +-
 reftable/stack.h           |  1 -
 reftable/stack_test.c      | 11 ++++++-----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 7c7cae5f99b..155bf0bbe2a 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -46,6 +46,9 @@ struct reftable_write_options {
 	 *   is a single line, and add '\n' if missing.
 	 */
 	unsigned exact_log_message : 1;
+
+	/* boolean: Prevent auto-compaction of tables. */
+	unsigned disable_auto_compact : 1;
 };
 
 /* reftable_block_stats holds statistics for a single block type */
diff --git a/reftable/stack.c b/reftable/stack.c
index dde50b61d69..1a7cdad12c9 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -680,7 +680,7 @@ int reftable_addition_commit(struct reftable_addition *add)
 	if (err)
 		goto done;
 
-	if (!add->stack->disable_auto_compact) {
+	if (!add->stack->config.disable_auto_compact) {
 		/*
 		 * Auto-compact the stack to keep the number of tables in
 		 * control. It is possible that a concurrent writer is already
diff --git a/reftable/stack.h b/reftable/stack.h
index d919455669e..c862053025f 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -19,7 +19,6 @@ struct reftable_stack {
 	int list_fd;
 
 	char *reftable_dir;
-	int disable_auto_compact;
 
 	struct reftable_write_options config;
 
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 351e35bd86d..4fec823f14f 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -325,7 +325,7 @@ static void test_reftable_stack_transaction_api_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->disable_auto_compact = i != n;
+		st->config.disable_auto_compact = i != n;
 
 		err = reftable_stack_new_addition(&add, st);
 		EXPECT_ERR(err);
@@ -497,6 +497,7 @@ static void test_reftable_stack_add(void)
 	struct reftable_write_options cfg = {
 		.exact_log_message = 1,
 		.default_permissions = 0660,
+		.disable_auto_compact = 1,
 	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
@@ -508,7 +509,6 @@ static void test_reftable_stack_add(void)
 
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
-	st->disable_auto_compact = 1;
 
 	for (i = 0; i < N; i++) {
 		char buf[256];
@@ -935,7 +935,9 @@ static void test_empty_add(void)
 
 static void test_reftable_stack_auto_compaction(void)
 {
-	struct reftable_write_options cfg = { 0 };
+	struct reftable_write_options cfg = {
+		.disable_auto_compact = 1,
+	};
 	struct reftable_stack *st = NULL;
 	char *dir = get_tmp_dir(__LINE__);
 
@@ -945,7 +947,6 @@ static void test_reftable_stack_auto_compaction(void)
 	err = reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
 
-	st->disable_auto_compact = 1; /* call manually below for coverage. */
 	for (i = 0; i < N; i++) {
 		char name[100];
 		struct reftable_ref_record ref = {
@@ -994,7 +995,7 @@ static void test_reftable_stack_add_performs_auto_compaction(void)
 		 * we can ensure that we indeed honor this setting and have
 		 * better control over when exactly auto compaction runs.
 		 */
-		st->disable_auto_compact = i != n;
+		st->config.disable_auto_compact = i != n;
 
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "branch-%04d", i);
-- 
gitgitgadget

