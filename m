Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C968CCA47F
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGVFPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 01:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVFPt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 01:15:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0A8237F9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so4480833wmb.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 22:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oJKU0DYK+KWZ02t/kXg5ErC65dSKzBhSfDLskTnhx64=;
        b=SHBSwsJkAxMrtOhwHHW/sfMMBjCefE37AKVyssPKxA8o7VWDBnol4whd2F8I2JhHDX
         zrOTa8rkOVr4vqjnT2A768J8c33Uo2p0vBJ7X/6I7LE70yk2fMgbTA2atc+7Sly4OjON
         7fjW12SJHS49khCYropBQC3eX101gcWV1JaDNjipnx85+W4ezllnRIt0mEZeHp+05ypt
         6VKjRh/Ae1ooCely3DGhcTW+Idf74mfP+lDb/eLcHPdiuLzVyDwV01EOCSi0ptZQz42K
         hAwYvP/f/3918fWNpfQuBFFanxv6GQ2RUnmiE5db8sOIUhZuhTgtd2DMxvIdZ/9ox75v
         7mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oJKU0DYK+KWZ02t/kXg5ErC65dSKzBhSfDLskTnhx64=;
        b=dmWflHMkp7HeHUGiKLOE2pFvqSaAt4O9ARnydvttpILgsUgMrV2ab7+R2x2zTgoZ1/
         BoT18rUTz/LW2ROYdvtx5FmWc4Y29Tenayt6hZkCNBkZhyOgNMukLgk5ZugmFqWXh51G
         c9wF+Vtq1wBp/R56WbfJJT0feh1o0tz39+AQlOJbNW7GuDqsJMQ+4r7nkRRxTizl/nu6
         uJJXJKA7c7J6IX1Mz61Gg7ne077EpijniZhkHJQOrmRYe6lAquNgNEwE84REiWZJAMDj
         2wh8SaMydWWiKrp45QYwF14yhu4UAlu/TwX5jggeOy9lmzYCdCCp4IIeg4jWhlbTY1Fr
         +c2w==
X-Gm-Message-State: AJIora+6zbH4bbjFfknYZqh2camrzkg232/x2MDPFjX+2WR845atkeKX
        FVWhEYDSbJCl2BZfzKzAYnv4ez/lbnM=
X-Google-Smtp-Source: AGRyM1uqGxeraCf4ZfJAl0WgZ06dS43KL+BwURV13PvppG1/Jd4d6n8Z6x5RGJOVDNZfUPITZkc1zQ==
X-Received: by 2002:a1c:4487:0:b0:3a2:fb76:7981 with SMTP id r129-20020a1c4487000000b003a2fb767981mr10667881wma.98.1658466946359;
        Thu, 21 Jul 2022 22:15:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c205500b003a2eacc8179sm3693135wmg.27.2022.07.21.22.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 22:15:45 -0700 (PDT)
Message-Id: <b79f44e54b9611fa2b10a4e1cb666992d006951c.1658466942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
References: <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jul 2022 05:15:37 +0000
Subject: [PATCH v4 2/7] merge-resolve: abort if index does not match HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
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

