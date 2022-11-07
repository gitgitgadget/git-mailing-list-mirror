Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D24C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiKGShT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiKGSgo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB872792F
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:25 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bs21so17580516wrb.4
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlu7Xg4pc6JmgPYy6uvF/YsQqtsrVJL4KfVD4FBTPDQ=;
        b=EBP4MuCCUL5SL4UTVKOr5xFd0SXhNna3l6guvBbQu2SK91htvXieERk+cVfoNaRBLC
         gHJ1MDhoRGuR/fxsfb918oT5wKor4jTISqIcy7O/M3Q0KCO4oLMhX/b+6rvxXagA9uAP
         8itoGhCysb8kFMRWjQygRZZNBcxekABxn/t1VYxZDNWApR8RdL1pNKW3P8lP3BgCbAkV
         O9a3K7l1V26/vT9nAJc4lv73AoP3Vx4kiY/rwYTqUM4f7S6CU7mWRnk0w8VWy9WekhPn
         wea2eeKIJk07ZLIznLpaqif7nBjOhzz55PfZVcNnxAMKK7m+6qVbfaUSb0QacOhN3Lgl
         iytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlu7Xg4pc6JmgPYy6uvF/YsQqtsrVJL4KfVD4FBTPDQ=;
        b=wysVrnjTEQvvu8eFn9Pm4Ofqh0ky2j7xPGG2ZuxjmHnKn6wxVijPU3Pb+55BjCFXUJ
         IZLEZ70Z2Ib/33ti/VMkiYNVnu8hmv/m72RlXHgu/fXB9IHG1qBFLrwf1DrX8d0JjcuE
         C+IYHf5iWHd5b7KmhF5qZZe9IzgNpWI4XshM3MS8GD1f422XHFoDI3k/5dtxC5TpfiCM
         yyoSTR0BTymRUpM/qLA90OypTqJuWlESWn2m3A5iqlPTmCUsLS9V7PJQPvQb44COQ3Hr
         7CQV8ADDcRq67HdylT7WHI0yyWL3xYW2M5HSbB+HOfNSFiZ5WiPEZcGUWMrvezQj+pAc
         yr1g==
X-Gm-Message-State: ACrzQf2112sbUKpJgTMCPYv3zzKK62siskliFUslzD4fpwwF2AQcdBnP
        DbBB/h+VPmCt2qLcTIRY+PyRQehSolU=
X-Google-Smtp-Source: AMsMyM7pojQaR3ohIF9GbQS2yND8Kjg4VvEXHlrErZ4iWGgvECCntPOkPtQqTYqp0AhKWUoH9UAvVA==
X-Received: by 2002:a5d:650c:0:b0:236:49d9:8e83 with SMTP id x12-20020a5d650c000000b0023649d98e83mr32522853wru.714.1667846183687;
        Mon, 07 Nov 2022 10:36:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c354200b003c71358a42dsm16405634wmq.18.2022.11.07.10.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:23 -0800 (PST)
Message-Id: <eb6152f1d39310b2e0527bbe199e25b941744753.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:51 +0000
Subject: [PATCH 17/30] packed-backend: create shell of v2 writes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Makefile                |  1 +
 refs/packed-backend.c   | 75 +++++++++++++++++++++++++++++++++++------
 refs/packed-backend.h   |  7 ++++
 refs/packed-format-v2.c | 38 +++++++++++++++++++++
 4 files changed, 110 insertions(+), 11 deletions(-)
 create mode 100644 refs/packed-format-v2.c

diff --git a/Makefile b/Makefile
index 3dc887941d4..16cd245e0ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1058,6 +1058,7 @@ LIB_OBJS += refs/files-backend.o
 LIB_OBJS += refs/iterator.o
 LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/packed-format-v1.o
+LIB_OBJS += refs/packed-format-v2.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += refspec.o
 LIB_OBJS += remote.o
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 655aab939be..09f7b74584f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -692,6 +692,45 @@ error:
 	return ok;
 }
 
+static int write_with_updates_v1(struct packed_ref_store *refs,
+				 struct string_list *updates,
+				 struct strbuf *err)
+{
+	FILE *out;
+
+	out = fdopen_tempfile(refs->tempfile, "w");
+	if (!out) {
+		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
+			    strerror(errno));
+		goto error;
+	}
+
+	if (write_packed_file_header_v1(out) < 0) {
+		add_write_error(refs, err);
+		goto error;
+	}
+
+	return merge_iterator_and_updates(refs, updates, err,
+					  write_packed_entry_v1, out);
+
+error:
+	return -1;
+}
+
+static int write_with_updates_v2(struct packed_ref_store *refs,
+				 struct string_list *updates,
+				 struct strbuf *err)
+{
+	struct write_packed_refs_v2_context *ctx = create_v2_context(refs, updates, err);
+	int ok = -1;
+
+	if ((ok = write_packed_refs_v2(ctx)) < 0)
+		add_write_error(refs, err);
+
+	free_v2_context(ctx);
+	return ok;
+}
+
 /*
  * Write the packed refs from the current snapshot to the packed-refs
  * tempfile, incorporating any changes from `updates`. `updates` must
@@ -707,9 +746,9 @@ static int write_with_updates(struct packed_ref_store *refs,
 			      struct strbuf *err)
 {
 	int ok;
-	FILE *out;
 	struct strbuf sb = STRBUF_INIT;
 	char *packed_refs_path;
+	int version;
 
 	if (!is_lock_file_locked(&refs->lock))
 		BUG("write_with_updates() called while unlocked");
@@ -731,21 +770,35 @@ static int write_with_updates(struct packed_ref_store *refs,
 	}
 	strbuf_release(&sb);
 
-	out = fdopen_tempfile(refs->tempfile, "w");
-	if (!out) {
-		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
-			    strerror(errno));
-		goto error;
+	if (git_config_get_int("refs.packedrefsversion", &version)) {
+		/*
+		 * Set the default depending on the current extension
+		 * list. Default to version 1 if available, but allow a
+		 * default of 2 if only "packed-v2" exists.
+		 */
+		if (refs->store_flags & REF_STORE_FORMAT_PACKED)
+			version = 1;
+		else if (refs->store_flags & REF_STORE_FORMAT_PACKED_V2)
+			version = 2;
+		else
+			BUG("writing a packed-refs file without an extension");
 	}
 
-	if (write_packed_file_header_v1(out) < 0) {
-		add_write_error(refs, err);
+	switch (version) {
+	case 1:
+		ok = write_with_updates_v1(refs, updates, err);
+		break;
+
+	case 2:
+		ok = write_with_updates_v2(refs, updates, err);
+		break;
+
+	default:
+		strbuf_addf(err, "unknown packed-refs version: %d",
+			    version);
 		goto error;
 	}
 
-	ok = merge_iterator_and_updates(refs, updates, err,
-					write_packed_entry_v1, out);
-
 	if (ok != ITER_DONE) {
 		strbuf_addstr(err, "unable to write packed-refs file: "
 			      "error iterating over old contents");
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index b6908bb002c..e76f26bfc46 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -243,4 +243,11 @@ int write_packed_entry_v1(const char *refname,
 			  const struct object_id *peeled,
 			  void *write_data);
 
+struct write_packed_refs_v2_context;
+struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *refs,
+						       struct string_list *updates,
+						       struct strbuf *err);
+int write_packed_refs_v2(struct write_packed_refs_v2_context *ctx);
+void free_v2_context(struct write_packed_refs_v2_context *ctx);
+
 #endif /* REFS_PACKED_BACKEND_H */
diff --git a/refs/packed-format-v2.c b/refs/packed-format-v2.c
new file mode 100644
index 00000000000..ecf3cc93694
--- /dev/null
+++ b/refs/packed-format-v2.c
@@ -0,0 +1,38 @@
+#include "../cache.h"
+#include "../config.h"
+#include "../refs.h"
+#include "refs-internal.h"
+#include "packed-backend.h"
+#include "../iterator.h"
+#include "../lockfile.h"
+#include "../chdir-notify.h"
+
+struct write_packed_refs_v2_context {
+	struct packed_ref_store *refs;
+	struct string_list *updates;
+	struct strbuf *err;
+};
+
+struct write_packed_refs_v2_context *create_v2_context(struct packed_ref_store *refs,
+						       struct string_list *updates,
+						       struct strbuf *err)
+{
+	struct write_packed_refs_v2_context *ctx;
+	CALLOC_ARRAY(ctx, 1);
+
+	ctx->refs = refs;
+	ctx->updates = updates;
+	ctx->err = err;
+
+	return ctx;
+}
+
+int write_packed_refs_v2(struct write_packed_refs_v2_context *ctx)
+{
+	return 0;
+}
+
+void free_v2_context(struct write_packed_refs_v2_context *ctx)
+{
+	free(ctx);
+}
-- 
gitgitgadget

