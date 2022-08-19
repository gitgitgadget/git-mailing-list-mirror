Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02B7C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 06:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbiHSG5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 02:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346678AbiHSG5m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 02:57:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604EBDF081
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bs25so4111916wrb.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 23:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=0jNjk4dN/9JIw6xcGiAVLQioJPRreWy7xIvALrTCQL0=;
        b=GaptEPQNU0Dsv15+JIOmc8FtXEcpWkS/sgfS6SQeVj3BToOmORhGuFHjvqwdWAg4H3
         bfiY01aBlXGZjtjsQ9uZzUTxPDBRyiIFm82i4DtxJs4h9iLTUrlhhA/yS09rGPTmgmcp
         b+2ozxhjgtcMPs9w+RzDcMtJZfRSaVuHuC5c8qgv4miZ3Wvk0N7HmeIrvQPhQli65YwL
         IgBK3RYY526x8hSAyhGfnlCfScNhUE+4M4RXvykTA/kafCYfeC0jzfzxBgll8zKPq2xr
         +YSxT6F21pCVcHTpLR5Ce4jtcl50UJCCVeGwwVHaCqNo0dEJFLLW1fIEWEySh4EVhACv
         R5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=0jNjk4dN/9JIw6xcGiAVLQioJPRreWy7xIvALrTCQL0=;
        b=NZz6SvPIytNp7atcyXLt3R66h/zfyF+0gXz6ZwG/RDmOlYjujUBKhFd3ZfvyvyLGHU
         rFSAJ+DpXj74a9+flF2qEFBSBoC/oN3PKPb1HIb+jPLgmDhjpZOV9eKRTHAx6Pov5eXz
         rF8/a7KjGu3Zpmy/7o0dtSa15QnSFYpvdTg3ib+3eLD7q67J7PYTeIzMqQKgbPpCbReM
         HtE0drgQNjBWCofW1wRnAWMVG07wMOQHgJ3KC2J463gz1cEbWjTkRvqybemwwgWuC6lp
         YGbyk8N1BQoypW+ml+Isj+ZH7UbYfICntidFbz+SJ8erglHgImPqhaaPUJfvy8wIs2Cl
         5HEQ==
X-Gm-Message-State: ACgBeo0vMl20HCdE8scX5h8W3t6Cpqh1B263jelfqpXJflq9m4+/kDbu
        xk+tuGRbJ8BY0efpOZTH2SZn+lBSkNg=
X-Google-Smtp-Source: AA6agR7MFObRhFpcWfvgLIxSN0wW9C6liLMGEQxFMJgQQRZj0h248DEIHtnwfp7U4cUaJcWwc3cEzQ==
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id r11-20020a5d6c6b000000b002250ddeab40mr3319460wrz.690.1660892258567;
        Thu, 18 Aug 2022 23:57:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m128-20020a1c2686000000b003a5dbdea6a8sm9067930wmm.27.2022.08.18.23.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:57:37 -0700 (PDT)
Message-Id: <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 06:57:34 +0000
Subject: [PATCH 1/3] merge-tree -z: always show the original file name first
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When printing the messages in a machine-readable format (i.e. in `-z`
mode), the intention is to support third-party software that wants to
present the conflicts in a "pretty" way to human readers.

To that end, `git merge-tree -z` prefixes the conflict messages by a
variable-size list of paths and a conflict identifier. This list and
this identifier are intended to be machine-parseable, the conflict
message is sort of free-form and not intended to be parsed.

Keeping in mind that the intended use case is to have third-party
software use `git merge-tree` to perform worktree-less merges and then
present the conflicts (if any) to human readers, it makes much more
sense to show the original file names of the involved files instead of
the ones we internally munged to allow for creating a tree object that
contains entries for both sides of the conflict (which requires them to
have different names).

So let's mention the original file names prominently, as first item in
that variable-size list of paths.

Note: For the modify/delete conflict type, we used to mention _only_ the
munged name in that path list. To allow for tools to read the tree
object produced by `git merge-tree -z` into a Git index in order to
resolve the conflicts, it is necessary to list not only the original
name but _also_ the munged name so that the item with the munged file
name can be removed from that Git index. Therefore, this patch teaches
`git merge-tree` to show both the original _and_ the munged name in that
list.

Also note: This patch changes the output of the remerge diff slightly:
whereas before, we printed the notice about a file/directory conflict
under the diff header mentioning the munged file name, we now print it
under a separate diff header that mentions the original file name.
That is the explanation why t4301 is touched by this patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c                      | 14 +++++++-------
 t/t4069-remerge-diff.sh          |  8 ++++----
 t/t4301-merge-tree-write-tree.sh |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 01f150ef3b5..211f6823e1d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3741,6 +3741,7 @@ static void process_entry(struct merge_options *opt,
 			  struct conflict_info *ci,
 			  struct directory_versions *dir_metadata)
 {
+	const char *orig_path = path;
 	int df_file_index = 0;
 
 	VERIFY_CI(ci);
@@ -3787,7 +3788,6 @@ static void process_entry(struct merge_options *opt,
 		 */
 		struct conflict_info *new_ci;
 		const char *branch;
-		const char *old_path = path;
 		int i;
 
 		assert(ci->merged.result.mode == S_IFDIR);
@@ -3838,10 +3838,10 @@ static void process_entry(struct merge_options *opt,
 		strmap_put(&opt->priv->paths, path, new_ci);
 
 		path_msg(opt, CONFLICT_FILE_DIRECTORY, 0,
-			 path, old_path, NULL, NULL,
+			 orig_path, path, NULL, NULL,
 			 _("CONFLICT (file/directory): directory in the way "
 			   "of %s from %s; moving it to %s instead."),
-			 old_path, branch, path);
+			 orig_path, branch, path);
 
 		/*
 		 * Zero out the filemask for the old ci.  At this point, ci
@@ -3921,7 +3921,7 @@ static void process_entry(struct merge_options *opt,
 
 			if (rename_a && rename_b) {
 				path_msg(opt, CONFLICT_DISTINCT_MODES, 0,
-					 path, a_path, b_path, NULL,
+					 orig_path, a_path, b_path, NULL,
 					 _("CONFLICT (distinct types): %s had "
 					   "different types on each side; "
 					   "renamed both of them so each can "
@@ -3929,7 +3929,7 @@ static void process_entry(struct merge_options *opt,
 					 path);
 			} else {
 				path_msg(opt, CONFLICT_DISTINCT_MODES, 0,
-					 path, rename_a ? a_path : b_path,
+					 orig_path, rename_a ? a_path : b_path,
 					 NULL, NULL,
 					 _("CONFLICT (distinct types): %s had "
 					   "different types on each side; "
@@ -4022,7 +4022,7 @@ static void process_entry(struct merge_options *opt,
 			if (S_ISGITLINK(merged_file.mode))
 				reason = _("submodule");
 			path_msg(opt, CONFLICT_CONTENTS, 0,
-				 path, NULL, NULL, NULL,
+				 orig_path, NULL, NULL, NULL,
 				 _("CONFLICT (%s): Merge conflict in %s"),
 				 reason, path);
 		}
@@ -4067,7 +4067,7 @@ static void process_entry(struct merge_options *opt,
 			 */
 		} else {
 			path_msg(opt, CONFLICT_MODIFY_DELETE, 0,
-				 path, NULL, NULL, NULL,
+				 orig_path, path, NULL, NULL,
 				 _("CONFLICT (modify/delete): %s deleted in %s "
 				   "and modified in %s.  Version %s of %s left "
 				   "in tree."),
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 35f94957fce..bc580a242ac 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -131,11 +131,12 @@ test_expect_success 'setup non-content conflicts' '
 test_expect_success 'remerge-diff with non-content conflicts' '
 	git log -1 --oneline resolution >tmp &&
 	cat <<-EOF >>tmp &&
+	diff --git a/file_or_directory b/file_or_directory
+	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
 	diff --git a/file_or_directory~HASH (side1) b/wanted_content
 	similarity index 100%
 	rename from file_or_directory~HASH (side1)
 	rename to wanted_content
-	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
 	diff --git a/letters b/letters
 	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
 	diff --git a/letters_side2 b/letters_side2
@@ -168,7 +169,7 @@ test_expect_success 'remerge-diff with non-content conflicts' '
 test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no diff content' '
 	git log -1 --oneline resolution >tmp &&
 	cat <<-EOF >>tmp &&
-	diff --git a/file_or_directory~HASH (side1) b/file_or_directory~HASH (side1)
+	diff --git a/file_or_directory b/file_or_directory
 	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
 	diff --git a/letters b/letters
 	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
@@ -184,14 +185,13 @@ test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no dif
 	test_cmp expect actual
 '
 
-test_expect_success 'remerge-diff w/ diff-filter=R: relevant file + conflict header' '
+test_expect_success 'remerge-diff w/ diff-filter=R: relevant file' '
 	git log -1 --oneline resolution >tmp &&
 	cat <<-EOF >>tmp &&
 	diff --git a/file_or_directory~HASH (side1) b/wanted_content
 	similarity index 100%
 	rename from file_or_directory~HASH (side1)
 	rename to wanted_content
-	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
 	EOF
 	# We still have some sha1 hashes above; rip them out so test works
 	# with sha256
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f091259a55e..e0ef9724b2b 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -211,8 +211,8 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	q_to_nul <<-EOF >>expect &&
 	1QgreetingQAuto-mergingQAuto-merging greeting
 	Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge conflict in greeting
-	Q2Qwhatever~tweak1QwhateverQCONFLICT (file/directory)QCONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
-	Q1Qwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
+	Q2QwhateverQwhatever~tweak1QCONFLICT (file/directory)QCONFLICT (file/directory): directory in the way of whatever from tweak1; moving it to whatever~tweak1 instead.
+	Q2QwhateverQwhatever~tweak1QCONFLICT (modify/delete)QCONFLICT (modify/delete): whatever~tweak1 deleted in side2 and modified in tweak1.  Version tweak1 of whatever~tweak1 left in tree.
 	Q1QΑυτά μου φαίνονται κινέζικαQAuto-mergingQAuto-merging Αυτά μου φαίνονται κινέζικα
 	Q1QΑυτά μου φαίνονται κινέζικαQCONFLICT (contents)QCONFLICT (content): Merge conflict in Αυτά μου φαίνονται κινέζικα
 	Q
-- 
gitgitgadget

