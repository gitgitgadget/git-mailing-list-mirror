Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350AC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbhL3Xg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242355AbhL3XgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:19 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4CC06173F
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:18 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso14242621wmc.3
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 15:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m2SwJoZOsYB5a22/NLlhSdCWqPW4PY+N6wfBVaY+WEY=;
        b=DkNwvcLKfGV2qNzk+NMOx73tkyHxz0b52+zEsXNxu4ttZYd89gcDEyK8LT+ctgodcp
         6q7cMih6N8ecUBp3p87F8DexHdiurKqzSp+HsOEYjUM6I3QmJaq2nzf7aKfMw1s6nwbE
         jPzzIBLXKJVqKcb7y2LlYp6D503j1JPUDVDKw+fArW7ui2cyKM66b4H7EbEhlSF/k2fr
         xWMnw5OwzS7Hq3kpQHA0pAlwfU9LBJAtlk9GbSl5v48H/0AP1GWOGKmMZQq5Aa6Yjylg
         8wRZdFkPA3CwOYV88pIZjeHXCrZra1XWCeAsyZ1IjhmIV2Pdm3jD94YgXmAhNVgGQiw5
         BmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m2SwJoZOsYB5a22/NLlhSdCWqPW4PY+N6wfBVaY+WEY=;
        b=4nzhehPz97SQSZpX1yioLwmZv7ZIJBGFQRXIZAcU+4Kzs2M+Pi+//5hqxv/q23qrkm
         mV9srsTSF32DaDzJUZJ6VOOQKAEUMXySnSHkZncFIhyfVI4ZC0FPrjRHgpP+os7g6VLq
         U3ZQVXUB2FNJEDtMHFSIzoxHJ/z8bujfv82RJFMv63v61RgOm5dOJYkr2bveEInCBYrp
         G1scihqk4immGf2jnq+ZVSrZ5RsI+KxlC2GXxDxGeaB5fgrWrzKkPZKSeLNzl9wPW+8K
         t8ZH46IAgAahnM/qPWS2jTrzjyOYocBBSwA3SX49/vq+eWXZiagkHKbkvJiUd4LOEpUC
         gOSw==
X-Gm-Message-State: AOAM532CZuePdIr3pjAu/6SoWwk0bj4hG3GUluZ5MK/VFYB3DEjWOvIO
        5Rp37X4sGFzHBij3PvQBjWEaqrgUWq8=
X-Google-Smtp-Source: ABdhPJxXZ/EjMMyt0udEvb7zJeMEpzi2AwM+wnJYtGRPOrmD0WJXHUTIgCva4k55L4bnumBPO4U1+w==
X-Received: by 2002:a7b:c243:: with SMTP id b3mr27847381wmj.61.1640907377129;
        Thu, 30 Dec 2021 15:36:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j13sm30177049wmq.11.2021.12.30.15.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:36:16 -0800 (PST)
Message-Id: <78ec1f44e4eacdb05c9da749a2160f4748565ad3.1640907369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 23:36:08 +0000
Subject: [PATCH v3 8/9] show, log: include conflict/warning messages in
 --remerge-diff headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Conflicts such as modify/delete, rename/rename, or file/directory are
not representable via content conflict markers, and the normal output
messages notifying users about these were dropped with --remerge-diff.
While we don't want these messages randomly shown before the commit
and diff headers, we do want them to still be shown; include them as
part of the diff headers instead.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 log-tree.c              |  4 ++
 merge-ort.c             |  1 +
 merge-ort.h             | 10 +++++
 t/t4069-remerge-diff.sh | 86 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 33c28f537a6..a04172d2908 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -922,6 +922,8 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Setup merge options */
 	init_merge_options(&o, the_repository);
 	o.show_rename_progress = 0;
+	o.record_conflict_msgs_as_headers = 1;
+	o.msg_header_prefix = "remerge";
 
 	ctx.abbrev = DEFAULT_ABBREV;
 	format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
@@ -938,10 +940,12 @@ static int do_remerge_diff(struct rev_info *opt,
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
 
 	/* Show the diff */
+	opt->diffopt.additional_path_headers = res.path_messages;
 	diff_tree_oid(&res.tree->object.oid, oid, "", &opt->diffopt);
 	log_tree_diff_flush(opt);
 
 	/* Cleanup */
+	opt->diffopt.additional_path_headers = NULL;
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
 	merge_finalize(&o, &res);
diff --git a/merge-ort.c b/merge-ort.c
index 481305d2bcf..43f980d2586 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4585,6 +4585,7 @@ redo:
 	trace2_region_leave("merge", "process_entries", opt->repo);
 
 	/* Set return values */
+	result->path_messages = &opt->priv->output;
 	result->tree = parse_tree_indirect(&working_tree_oid);
 	/* existence of conflicted entries implies unclean */
 	result->clean &= strmap_empty(&opt->priv->conflicted);
diff --git a/merge-ort.h b/merge-ort.h
index c011864ffeb..fe599b87868 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -5,6 +5,7 @@
 
 struct commit;
 struct tree;
+struct strmap;
 
 struct merge_result {
 	/*
@@ -23,6 +24,15 @@ struct merge_result {
 	 */
 	struct tree *tree;
 
+	/*
+	 * Special messages and conflict notices for various paths
+	 *
+	 * This is a map of pathnames to strbufs.  It contains various
+	 * warning/conflict/notice messages (possibly multiple per path)
+	 * that callers may want to use.
+	 */
+	struct strmap *path_messages;
+
 	/*
 	 * Additional metadata used by merge_switch_to_result() or future calls
 	 * to merge_incore_*().  Includes data needed to update the index (if
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 1b32028e897..c1b44138145 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -4,6 +4,15 @@ test_description='remerge-diff handling'
 
 . ./test-lib.sh
 
+# --remerge-diff uses ort under the hood regardless of setting.  However,
+# we set up a file/directory conflict beforehand, and the different backends
+# handle the conflict differently, which would require separate code paths
+# to resolve.  There's not much point in making the code uglier to do that,
+# though, when the real thing we are testing (--remerge-diff) will hardcode
+# calls directly into the merge-ort API anyway.  So just force the use of
+# ort on the setup too.
+GIT_TEST_MERGE_ALGORITHM=ort
+
 test_expect_success 'setup basic merges' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
 	git add numbers &&
@@ -53,6 +62,7 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	git log -1 --oneline ab_resolution >tmp &&
 	cat <<-EOF >>tmp &&
 	diff --git a/numbers b/numbers
+	remerge CONFLICT (content): Merge conflict in numbers
 	index a1fb731..6875544 100644
 	--- a/numbers
 	+++ b/numbers
@@ -81,4 +91,80 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	test_cmp expect actual
 '
 
+test_expect_success 'setup non-content conflicts' '
+	git switch --orphan base &&
+
+	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
+	test_write_lines a b c d e f g h i >letters &&
+	test_write_lines in the way >content &&
+	git add numbers letters content &&
+	git commit -m base &&
+
+	git branch side1 &&
+	git branch side2 &&
+
+	git checkout side1 &&
+	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
+	git mv letters letters_side1 &&
+	git mv content file_or_directory &&
+	git add numbers &&
+	git commit -m side1 &&
+
+	git checkout side2 &&
+	git rm numbers &&
+	git mv letters letters_side2 &&
+	mkdir file_or_directory &&
+	echo hello >file_or_directory/world &&
+	git add file_or_directory/world &&
+	git commit -m side2 &&
+
+	git checkout -b resolution side1 &&
+	test_must_fail git merge side2 &&
+	test_write_lines 1 2 three 4 5 6 7 8 9 >numbers &&
+	git add numbers &&
+	git add letters_side1 &&
+	git rm letters &&
+	git rm letters_side2 &&
+	git add file_or_directory~HEAD &&
+	git mv file_or_directory~HEAD wanted_content &&
+	git commit -m resolved
+'
+
+test_expect_success 'remerge-diff with non-content conflicts' '
+	git log -1 --oneline resolution >tmp &&
+	cat <<-EOF >>tmp &&
+	diff --git a/file_or_directory~HASH (side1) b/wanted_content
+	similarity index 100%
+	rename from file_or_directory~HASH (side1)
+	rename to wanted_content
+	remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
+	diff --git a/letters b/letters
+	remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
+	diff --git a/letters_side2 b/letters_side2
+	deleted file mode 100644
+	index b236ae5..0000000
+	--- a/letters_side2
+	+++ /dev/null
+	@@ -1,9 +0,0 @@
+	-a
+	-b
+	-c
+	-d
+	-e
+	-f
+	-g
+	-h
+	-i
+	diff --git a/numbers b/numbers
+	remerge CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
+	EOF
+	# We still have some sha1 hashes above; rip them out so test works
+	# with sha256
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
+
+	git show --oneline --remerge-diff resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

