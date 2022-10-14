Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BAEC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 08:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJNI4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJNI4u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 04:56:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E0514EC4B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b4so6574506wrs.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+3oD4ABK8mThUZZb7KS47LmXiju8tpEewQxyavHJFw=;
        b=pYA/3aqPSkKbdk/vPVAxFxLJnwdG9LVDoHdpCU1PoaxNC3zLjy4RBqcb0BIJpL4C4A
         qn4sKGUEhz5AxkE0oFkWAvT+0ZbC4vuqxxY0jY//6tMWDN7yJ5zBQrZ2UqC1iddVchVd
         n4X+wZlNTUiQA9jLypbT7LqEl/jPrFP6o5E/R3cVia3xeVOB8NYRtQUDGxiD50/Zs164
         sk/KxbFbfWQpJ+prySx4xrokqXkn10kVWHx0mqAB/jnhGFvedr+m4Tt1uJpMxXwRPy8o
         NXiWphyh2Jbn6kDaBuSdibxT8k2JVGWW8wvnnSrg4YgbYniBhMRM8Vuo1Ll577G2mi5/
         So9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+3oD4ABK8mThUZZb7KS47LmXiju8tpEewQxyavHJFw=;
        b=szzdWRDLe0KzBPlXpEhKSyM8nCGGyDkND1DyXkHJPHAVUTGwxK4RwsrIaTseA2FWuH
         5tTY/K24f5acuQz0eWTcCWl5edQhkocG9DHJCa+3D4CHkDAUdnObZor0GecEwpMhorUM
         z7Cdek2FFCkSbNqyR8OkTmUouOxQzrpECUoArMG0MMHlyEjApHOPftVXTG2Z+esNPDqC
         L9ZUvH4F9NFKxgYAewwijxxGNsaMuyjA2PCrGH62I/AJvcl1iX3eMmUsDzbI+jYt+LOd
         5QlM91xX1LH+4CVRNLQhdm/2278w0WxV/Y9Dmo8hrwtcSvox8gPFA59skwnXvm5gu4QZ
         MpGQ==
X-Gm-Message-State: ACrzQf3J03MFyjeCP6Mxq5j9nKUTsn/10jxFFNNL9gXuXvQzkPJKc5yQ
        3tfebpiYzDH9hFGYxhqeSxsXtTF1XVA=
X-Google-Smtp-Source: AMsMyM5M9xcaHYghzrt9AO8sX00qmYpi6xHscTpX+u47dJ1BIc5FUV+5r7RGrU3Uojvyjlyf5AKL3g==
X-Received: by 2002:a5d:674f:0:b0:22e:3d59:cf0f with SMTP id l15-20020a5d674f000000b0022e3d59cf0fmr2571109wrw.304.1665737807370;
        Fri, 14 Oct 2022 01:56:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c481400b003a6125562e1sm1467782wmo.46.2022.10.14.01.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 01:56:46 -0700 (PDT)
Message-Id: <7d4c2e91ce0c71610840168a157146f980b86497.1665737804.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 08:56:38 +0000
Subject: [PATCH v3 1/7] patch-id: fix stable patch id for binary / header-only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <jerry@skydio.com>

Previous logic here skipped flushing the hunks for binary
and header-only patch ids, which would always result in a
patch-id of 0000.

Reorder the logic to branch into 3 cases for populating the
patch body: header-only which populates nothing, binary which
populates the object ids, and normal which populates the text
diff. All branches will end up flushing the hunk.

Don't populate the ---a/ and +++b/ lines for binary diffs, to correspond
to those lines not being present in the "git diff" text output.
This is necessary because we advertise that the patch-id calculated
internally and used in format-patch is the same that what the
builtin "git patch-id" would produce when piped from a diff.

Update the test to run on both binary and normal files.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 diff.c                     | 58 +++++++++++++++++++-------------------
 t/t3419-rebase-patch-id.sh | 34 +++++++++++++++-------
 2 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/diff.c b/diff.c
index 648f6717a55..c15169e4b06 100644
--- a/diff.c
+++ b/diff.c
@@ -6253,46 +6253,46 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		if (p->one->mode == 0) {
 			patch_id_add_string(&ctx, "newfilemode");
 			patch_id_add_mode(&ctx, p->two->mode);
-			patch_id_add_string(&ctx, "---/dev/null");
-			patch_id_add_string(&ctx, "+++b/");
-			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		} else if (p->two->mode == 0) {
 			patch_id_add_string(&ctx, "deletedfilemode");
 			patch_id_add_mode(&ctx, p->one->mode);
-			patch_id_add_string(&ctx, "---a/");
-			the_hash_algo->update_fn(&ctx, p->one->path, len1);
-			patch_id_add_string(&ctx, "+++/dev/null");
-		} else {
-			patch_id_add_string(&ctx, "---a/");
-			the_hash_algo->update_fn(&ctx, p->one->path, len1);
-			patch_id_add_string(&ctx, "+++b/");
-			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		}
 
-		if (diff_header_only)
-			continue;
-
-		if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
-		    fill_mmfile(options->repo, &mf2, p->two) < 0)
-			return error("unable to read files to diff");
-
-		if (diff_filespec_is_binary(options->repo, p->one) ||
+		if (diff_header_only) {
+			/* don't do anything since we're only populating header info */
+		} else if (diff_filespec_is_binary(options->repo, p->one) ||
 		    diff_filespec_is_binary(options->repo, p->two)) {
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
 					the_hash_algo->hexsz);
 			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
 					the_hash_algo->hexsz);
-			continue;
-		}
-
-		xpp.flags = 0;
-		xecfg.ctxlen = 3;
-		xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
-		if (xdi_diff_outf(&mf1, &mf2, NULL,
-				  patch_id_consume, &data, &xpp, &xecfg))
-			return error("unable to generate patch-id diff for %s",
-				     p->one->path);
+		} else {
+			if (p->one->mode == 0) {
+				patch_id_add_string(&ctx, "---/dev/null");
+				patch_id_add_string(&ctx, "+++b/");
+				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+			} else if (p->two->mode == 0) {
+				patch_id_add_string(&ctx, "---a/");
+				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				patch_id_add_string(&ctx, "+++/dev/null");
+			} else {
+				patch_id_add_string(&ctx, "---a/");
+				the_hash_algo->update_fn(&ctx, p->one->path, len1);
+				patch_id_add_string(&ctx, "+++b/");
+				the_hash_algo->update_fn(&ctx, p->two->path, len2);
+			}
 
+			if (fill_mmfile(options->repo, &mf1, p->one) < 0 ||
+			    fill_mmfile(options->repo, &mf2, p->two) < 0)
+				return error("unable to read files to diff");
+			xpp.flags = 0;
+			xecfg.ctxlen = 3;
+			xecfg.flags = XDL_EMIT_NO_HUNK_HDR;
+			if (xdi_diff_outf(&mf1, &mf2, NULL,
+					  patch_id_consume, &data, &xpp, &xecfg))
+				return error("unable to generate patch-id diff for %s",
+					     p->one->path);
+		}
 		if (stable)
 			flush_one_hunk(oid, &ctx);
 	}
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 295040f2fe3..d24e55aac8d 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -43,15 +43,16 @@ test_expect_success 'setup: 500 lines' '
 	git add newfile &&
 	git commit -q -m "add small file" &&
 
-	git cherry-pick main >/dev/null 2>&1
-'
+	git cherry-pick main >/dev/null 2>&1 &&
 
-test_expect_success 'setup attributes' '
-	echo "file binary" >.gitattributes
+	git branch -f squashed main &&
+	git checkout -q -f squashed &&
+	git reset -q --soft HEAD~2 &&
+	git commit -q -m squashed
 '
 
 test_expect_success 'detect upstream patch' '
-	git checkout -q main &&
+	git checkout -q main^{} &&
 	scramble file &&
 	git add file &&
 	git commit -q -m "change big file again" &&
@@ -61,14 +62,27 @@ test_expect_success 'detect upstream patch' '
 	test_must_be_empty revs
 '
 
+test_expect_success 'detect upstream patch binary' '
+	echo "file binary" >.gitattributes &&
+	git checkout -q other^{} &&
+	git rebase main &&
+	git rev-list main...HEAD~ >revs &&
+	test_must_be_empty revs &&
+	test_when_finished "rm .gitattributes"
+'
+
 test_expect_success 'do not drop patch' '
-	git branch -f squashed main &&
-	git checkout -q -f squashed &&
-	git reset -q --soft HEAD~2 &&
-	git commit -q -m squashed &&
 	git checkout -q other^{} &&
 	test_must_fail git rebase squashed &&
-	git rebase --quit
+	test_when_finished "git rebase --abort"
+'
+
+test_expect_success 'do not drop patch binary' '
+	echo "file binary" >.gitattributes &&
+	git checkout -q other^{} &&
+	test_must_fail git rebase squashed &&
+	test_when_finished "git rebase --abort" &&
+	test_when_finished "rm .gitattributes"
 '
 
 test_done
-- 
gitgitgadget

