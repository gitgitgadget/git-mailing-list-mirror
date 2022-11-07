Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AADEC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiKGShL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiKGSg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ADB26568
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p16so7428180wmc.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EEkPtnqoIpElJUZqBn68bySDmQakpDYN76PfJqN25I=;
        b=JhPh73n0fDv2qz/YbWonM644vKigr4NdnzWruf+kij4r0ZuLK+ReuJ+8sdyhOq0aKV
         aNwb4yZ0x06VqK/eYxNJTl0M4pIidUuiOsLiMBjGtrM9QPGk4QV5hcaWCGq+XF0JYvjr
         5H+IZWWxZmpJo27Ejy7e5/lj6ECyreSVlZnpovGaO8TtzzSGPfTI4tPsq4wilMIo+vB2
         NgRnBAwWZx05tb6Y0WP3sexvs4hz9SAe8hpCRvJV6D0ZMZ7eNNBQJOTg8tAysOQHVtmm
         /BTnKwRLZMP9HKYbJx/mSmw+NBj5+02mDVeA1ussWqyHzFCzx1AqnfvK2h0e73It58XP
         ZERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EEkPtnqoIpElJUZqBn68bySDmQakpDYN76PfJqN25I=;
        b=kcuYCH7ieCSkL0EK6k/duiP2GZeAhWoSXX4En5uBniya17Dp42fOleI8wwudWvc9I9
         FdB2aLH2ZKufH3UPh1sX72sMfJ9z9LoIgo09HcYbYfiRgNzJY29Wu7CU3B8+rdaV18o2
         KT7Yuf+OE9TNHfer37AG8f5Aalmmj54B566dcsfKQor7dwbUdmQu6opEO9+KxMZDtKHT
         Qe0jz7F6v1kX88OC4rjfgMBuHDwjlesB+qAwhOL6PcWMpG30jhvFyHhtsBQ065mxNGT/
         /Y1yuldIktv2WSjD8Y4DE5i45VCyMvfZpFHV4XMe10TFBodv9vcue1OAwgLHU7WFlmvl
         NEBw==
X-Gm-Message-State: ANoB5pndlp9A9YiJGphUJgWUtv8vSwVGQb4xjggI2FaJDR0S8BAylnfO
        pJTDFPpkAI5t9SKeCHMwWT9/crWLahQ=
X-Google-Smtp-Source: AA0mqf7tTDk5b/TBhjnix76Mvj9sdpgmk9B+2YU172pNN8CgY7xxf8arql1TWgx0O9xW6Z0NJfoCVQ==
X-Received: by 2002:a1c:3847:0:b0:3cf:a616:cc6f with SMTP id f68-20020a1c3847000000b003cfa616cc6fmr6603638wma.78.1667846180440;
        Mon, 07 Nov 2022 10:36:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25-20020adfa299000000b00236b2804d79sm8454951wra.2.2022.11.07.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:19 -0800 (PST)
Message-Id: <cca445cd7d8ae0ab891fcbe1e2087b3552ac3576.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:48 +0000
Subject: [PATCH 14/30] packed-backend: extract iterator/updates merge
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

TBD

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs/packed-backend.c | 117 +++++++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 53 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ef8060f2e08..0dff78f02c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -535,58 +535,13 @@ static void add_write_error(struct packed_ref_store *refs, struct strbuf *err)
 		    get_tempfile_path(refs->tempfile), strerror(errno));
 }
 
-/*
- * Write the packed refs from the current snapshot to the packed-refs
- * tempfile, incorporating any changes from `updates`. `updates` must
- * be a sorted string list whose keys are the refnames and whose util
- * values are `struct ref_update *`. On error, rollback the tempfile,
- * write an error message to `err`, and return a nonzero value.
- *
- * The packfile must be locked before calling this function and will
- * remain locked when it is done.
- */
-static int write_with_updates(struct packed_ref_store *refs,
-			      struct string_list *updates,
-			      struct strbuf *err)
+static int merge_iterator_and_updates(struct packed_ref_store *refs,
+				      struct string_list *updates,
+				      struct strbuf *err,
+				      FILE *out)
 {
 	struct ref_iterator *iter = NULL;
-	size_t i;
-	int ok;
-	FILE *out;
-	struct strbuf sb = STRBUF_INIT;
-	char *packed_refs_path;
-
-	if (!is_lock_file_locked(&refs->lock))
-		BUG("write_with_updates() called while unlocked");
-
-	/*
-	 * If packed-refs is a symlink, we want to overwrite the
-	 * symlinked-to file, not the symlink itself. Also, put the
-	 * staging file next to it:
-	 */
-	packed_refs_path = get_locked_file_path(&refs->lock);
-	strbuf_addf(&sb, "%s.new", packed_refs_path);
-	free(packed_refs_path);
-	refs->tempfile = create_tempfile(sb.buf);
-	if (!refs->tempfile) {
-		strbuf_addf(err, "unable to create file %s: %s",
-			    sb.buf, strerror(errno));
-		strbuf_release(&sb);
-		return -1;
-	}
-	strbuf_release(&sb);
-
-	out = fdopen_tempfile(refs->tempfile, "w");
-	if (!out) {
-		strbuf_addf(err, "unable to fdopen packed-refs tempfile: %s",
-			    strerror(errno));
-		goto error;
-	}
-
-	if (write_packed_file_header_v1(out) < 0) {
-		add_write_error(refs, err);
-		goto error;
-	}
+	int ok, i;
 
 	/*
 	 * We iterate in parallel through the current list of refs and
@@ -713,6 +668,65 @@ static int write_with_updates(struct packed_ref_store *refs,
 		}
 	}
 
+error:
+	if (iter)
+		ref_iterator_abort(iter);
+	return ok;
+}
+
+/*
+ * Write the packed refs from the current snapshot to the packed-refs
+ * tempfile, incorporating any changes from `updates`. `updates` must
+ * be a sorted string list whose keys are the refnames and whose util
+ * values are `struct ref_update *`. On error, rollback the tempfile,
+ * write an error message to `err`, and return a nonzero value.
+ *
+ * The packfile must be locked before calling this function and will
+ * remain locked when it is done.
+ */
+static int write_with_updates(struct packed_ref_store *refs,
+			      struct string_list *updates,
+			      struct strbuf *err)
+{
+	int ok;
+	FILE *out;
+	struct strbuf sb = STRBUF_INIT;
+	char *packed_refs_path;
+
+	if (!is_lock_file_locked(&refs->lock))
+		BUG("write_with_updates() called while unlocked");
+
+	/*
+	 * If packed-refs is a symlink, we want to overwrite the
+	 * symlinked-to file, not the symlink itself. Also, put the
+	 * staging file next to it:
+	 */
+	packed_refs_path = get_locked_file_path(&refs->lock);
+	strbuf_addf(&sb, "%s.new", packed_refs_path);
+	free(packed_refs_path);
+	refs->tempfile = create_tempfile(sb.buf);
+	if (!refs->tempfile) {
+		strbuf_addf(err, "unable to create file %s: %s",
+			    sb.buf, strerror(errno));
+		strbuf_release(&sb);
+		return -1;
+	}
+	strbuf_release(&sb);
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
+	ok = merge_iterator_and_updates(refs, updates, err, out);
+
 	if (ok != ITER_DONE) {
 		strbuf_addstr(err, "unable to write packed-refs file: "
 			      "error iterating over old contents");
@@ -732,9 +746,6 @@ static int write_with_updates(struct packed_ref_store *refs,
 	return 0;
 
 error:
-	if (iter)
-		ref_iterator_abort(iter);
-
 	delete_tempfile(&refs->tempfile);
 	return -1;
 }
-- 
gitgitgadget

