Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C6C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiGUIQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiGUIQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 04:16:39 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539E7D78D
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2798181wma.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 01:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oJKU0DYK+KWZ02t/kXg5ErC65dSKzBhSfDLskTnhx64=;
        b=qk886gVq5kF39R4ZFKtJUm5MEklKRNvMFGZNNABvdHrWxQAlLWW8rcQ/8GYUx5aAXp
         TqnlEYvR26evzmsuZLYUMNUaZZLuQRi+T1yIxjCTvldgLU9IlxTOJyv2XlIB4XrSnrzm
         1UZ6LX/NW6zpXaDGX9cagym8dk0nYv05yNVZbp5pzzz3TUmTTxErH6F7pMCswHJwfe/C
         EY0dD7+2hrecUXh8eff4kOiPMIz/O/EQf55YVTvHFx+UjqBp1ePZVac+Rd7Ec2xq3Sm7
         7HkiABxP9EniK/Vu3MSndV9gsYc+jZDdMfvzYZywzrwyZSOGZvhMukin9asMRQ1Z3pF0
         zQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oJKU0DYK+KWZ02t/kXg5ErC65dSKzBhSfDLskTnhx64=;
        b=gNLvRMx3QrVe1YnBb2J+6J/rcM9hibOtU4rmfuTgVA/WmJfdqx0LelEVdgJyX3rYVq
         icguHI1P07xAqOAT5QkDWKVNY9Sgt2aGuEW1DZCsj7XGmEMig8L8vKgb9gTEEddbVl0r
         /MtQFZBMFPA07zB5u3b/uNA+pCub/XhlGzKTrRjxLfZI9pcllocTQJhrFh0SmBPBnDI6
         SGrkjQ3SOprICoEIcipKqFqhSdXIXdGaqKZREsXTxoCa0dub4XMsA+HZMUxQbO5hIfb6
         6J0KkKJXYHGabDYN9cHyh35VqHGpX2yxqRVOey5T4YD1hgLSyRPRKYjm0GKbSIAhjI2B
         eYYw==
X-Gm-Message-State: AJIora/UDJJuczV07dLF3lDKlLj3XUMFEqx0+xres8B5i0JSybEzZCKq
        vB2xe2tv8oBKk5V8LFgNBwqOU65R72I=
X-Google-Smtp-Source: AGRyM1vGbXEW0PoYPfnGESaB6T4RNKv+i2pWcah5V+a0H2dLuKMavcbHax8OesR13I3c2mYnRYXKbQ==
X-Received: by 2002:a7b:c30d:0:b0:3a1:861a:b9bc with SMTP id k13-20020a7bc30d000000b003a1861ab9bcmr7164084wmj.97.1658391396152;
        Thu, 21 Jul 2022 01:16:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adfe2c1000000b0021e491fd250sm1135162wrj.89.2022.07.21.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:16:35 -0700 (PDT)
Message-Id: <2810dec7608d68a5a7906e70f88278c5ab9aa0e2.1658391391.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 08:16:26 +0000
Subject: [PATCH v3 2/7] merge-resolve: abort if index does not match HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in commit 9822175d2b ("Ensure index matches head before
invoking merge machinery, round N", 2019-08-17), we have had a very
long history of problems with failing to enforce the requirement that
index matches HEAD when starting a merge.  One of the commits
referenced in the long tale of issues arising from lax enforcement of
this requirement was commit 55f39cf755 ("merge: fix misleading
pre-merge check documentation", 2018-06-30), which tried to document
the requirement and noted there were some exceptions.  As mentioned in
that commit message, the `resolve` strategy was the one strategy that
did not have an explicit index matching HEAD check, and the reason it
didn't was that I wasn't able to discover any cases where the
implementation would fail to catch the problem and abort, and didn't
want to introduce unnecessary performance overhead of adding another
check.

Well, today I discovered a testcase where the implementation does not
catch the problem and so an explicit check is needed.  Add a testcase
that previously would have failed, and update git-merge-resolve.sh to
have an explicit check.  Note that the code is copied from 3ec62ad9ff
("merge-octopus: abort if index does not match HEAD", 2016-04-09), so
that we reuse the same message and avoid making translators need to
translate some new message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          | 20 ++++++++++++++++++
 git-merge-resolve.sh                     | 10 +++++++++
 t/t6424-merge-unrelated-index-changes.sh | 26 ++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 23170f2d2a6..13884b8e836 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1599,6 +1599,26 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 */
 		refresh_cache(REFRESH_QUIET);
 		if (allow_trivial && fast_forward != FF_ONLY) {
+			/*
+			 * Must first ensure that index matches HEAD before
+			 * attempting a trivial merge.
+			 */
+			struct tree *head_tree = get_commit_tree(head_commit);
+			struct strbuf sb = STRBUF_INIT;
+
+			if (repo_index_has_changes(the_repository, head_tree,
+						   &sb)) {
+				struct strbuf err = STRBUF_INIT;
+				strbuf_addstr(&err, "error: ");
+				strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
+					    sb.buf);
+				strbuf_addch(&err, '\n');
+				fputs(err.buf, stderr);
+				strbuf_release(&err);
+				strbuf_release(&sb);
+				return -1;
+			}
+
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index 343fe7bccd0..77e93121bf8 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -5,6 +5,16 @@
 #
 # Resolve two trees, using enhanced multi-base read-tree.
 
+. git-sh-setup
+
+# Abort if index does not match HEAD
+if ! git diff-index --quiet --cached HEAD --
+then
+    gettextln "Error: Your local changes to the following files would be overwritten by merge"
+    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
+    exit 2
+fi
+
 # The first parameters up to -- are merge bases; the rest are heads.
 bases= head= remotes= sep_seen=
 for arg
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index b6e424a427b..f35d3182b86 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -114,6 +114,32 @@ test_expect_success 'resolve, non-trivial' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success 'resolve, trivial, related file removed' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git rm a &&
+	test_path_is_missing a &&
+
+	test_must_fail git merge -s resolve C^0 &&
+
+	test_path_is_missing a &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
+test_expect_success 'resolve, non-trivial, related file removed' '
+	git reset --hard &&
+	git checkout B^0 &&
+
+	git rm a &&
+	test_path_is_missing a &&
+
+	test_must_fail git merge -s resolve D^0 &&
+
+	test_path_is_missing a &&
+	test_path_is_missing .git/MERGE_HEAD
+'
+
 test_expect_success 'recursive' '
 	git reset --hard &&
 	git checkout B^0 &&
-- 
gitgitgadget

