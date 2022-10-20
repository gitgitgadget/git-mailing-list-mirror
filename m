Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11845C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJTXRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJTXRC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:17:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205322E0FB
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a3so2126023wrt.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp9Tg5X1RJCYKhvef62590LNA9REDWAdl/Lhvjci9/c=;
        b=bvCN3tF5KZWOcsucy5Wcyxx7JOYra/AVGfd/NlC+iZ6SeKyatNmZqaApzsFZfESEq6
         rdslwmWF+XrMWRfdqRchWr8SPPZQpeT8U3uSEmxGvJu9EXFKdupGVTPFrKmu8BwFdYRb
         P5uJb5W/Lyu/1wYhxEhD7oMxjpTVD9ixZ0KbzHt/nPGgcsCywOuE343on5LbckF8096Y
         KF85VlugsWGacqjkNSlbw1+iPUbu8tFwEPNwOUhm7zuyuDUpgzYF5V1FJXHa2p1rzW+S
         rxVvybtOgabfozl35vGF17RjWo+r178xtYGVW4NnMDnWFSo9qXUnhAdpcJUUB232We0B
         gVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp9Tg5X1RJCYKhvef62590LNA9REDWAdl/Lhvjci9/c=;
        b=4u0kjm4nO5CuDdtHxpJfS7iTDzo8+cCO6bOFFiwEzj5JxmRhdpzk2puM0z3/xMmfHw
         jtciYQCJK1nSC5WcVh/W+oum7KH4/ojdtRihG28EIKUs6HJychW1U1sqascFFy8XX3pG
         UqlG0lQNdRb0goUzRmTQL0zBP1GrkOEpxTdadmfMObvqBEMkQQLuSOCP+3OsVApifU9X
         /Xdd+/JOiO/s26MiTj4N4AOOPYgCkmPYUb3qSn9hqZR4deyjL4jEi+sD7xL89mWl+PKr
         XYD8hJHuBn9WcWRBU7now+YLMg8FOQJzobmwYT69waCxIkngkx74MeeA03pksl9xBuEq
         dm+A==
X-Gm-Message-State: ACrzQf3uqM1PqUWzjQfNJdPiPKFgocQAEL1+yT5Pko+emZcdcUu5w2Vl
        c8O9SYWA8OvobgQCqOJggHO9UL6i/jc=
X-Google-Smtp-Source: AMsMyM4/Ot+CZqxPOcMmSJrDg5zoIiGhi+X4OtbkdEN7g+tqedFGdvZERgzQZHYxJU/AvZdRlamFVg==
X-Received: by 2002:a5d:4a4d:0:b0:22d:c8cb:8687 with SMTP id v13-20020a5d4a4d000000b0022dc8cb8687mr10067452wrs.554.1666307818572;
        Thu, 20 Oct 2022 16:16:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d6190000000b00226dedf1ab7sm4753513wru.76.2022.10.20.16.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 16:16:57 -0700 (PDT)
Message-Id: <321757ef919bc75e58108d6e6bef4aaeeb4b326a.1666307815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
References: <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 23:16:50 +0000
Subject: [PATCH v4 1/6] patch-id: fix stable patch id for binary / header-only
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

Patch-ids for binary patches are found by hashing the object
ids of the before and after objects in succession. However in
the --stable case, there is a bug where hunks are not flushed
for binary and header-only patch ids, which would always result
in a patch-id of 0000. The --unstable case is currently correct.

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

