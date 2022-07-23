Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D61CCA47C
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiGWBxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiGWBxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E0373928
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b26so8663633wrc.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yYPAijwQFOoTdhdS8fGV4HlbUPk99D9N/ORJVdpJBz4=;
        b=CsEa12xcNpcmxoRM7SKcklq9Rc570kt7AbjOxuYHcVkLUulaUIBCUYVcVyVEG4iBdd
         ue345rrRLlRlWNejNCSbg2taqIEJWujBf+3ukBtNtibtU9i3qIHtve9ZDYkzrT9gToWR
         VXVr9M/udAsLTUZ8DGeYFppods24D+jrHnewIii8IiCwpMDpwlUKa0FzsgFAFW43MGMa
         VUxxXKAg1i9iMimNQKkC50PmoByNVD//K7zYpdv5qhKR9WpXWVT0vwl2lWG7iQ1ImQZN
         f0zEBzTHiSrW1pEJ24jx30bHPyvg7j7kwgG007P+pAqtt3oAKFHad3sGeZaGs29NHyrS
         86aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yYPAijwQFOoTdhdS8fGV4HlbUPk99D9N/ORJVdpJBz4=;
        b=OvGyUc8tTiCQY+P28ZMsPdjzjI9KbxXD/hAfbqa1WHC36n9E76yki/XPdfPPFNOpWC
         JtqPNTs576AAz7sFYvHQ4hqETnzf0+wpLVtu1pyLSPlAEAvQ73WzCHujxa9YZgDYfs8l
         Ok41Uks0o+L1fvy244p+mLxMPt1iP7ntWdK67xJra7nx+/1jAkON8ZbnN9eb9rWYFzet
         gW4iGrJANHrvlSLhvMwb0i4NFYisq5WhZG25Kz6l29tiB97VYvyBPSMgCJ0FtLRBPUrn
         eVhS9YPW7y7dZM4Prg4pHm+VgGDTuCjNFcxUh5ogOONtle9wSFKQKNey7b6PjnnE5Ghm
         B7eQ==
X-Gm-Message-State: AJIora/7EvQpObk+X9ewkpxGueAjFySxc/vgvA5jt7nEP8ZaIAioC7aK
        q+Fwzwo/Hc35vggv56nwrdu0rkCUjUw=
X-Google-Smtp-Source: AGRyM1tvlbz5r4CzTl6VyEkRKK8m2hmlNxgMSS8XYgYmNgw7F4MS8AOzyid317dxRX9vqBKGnx+8rQ==
X-Received: by 2002:adf:d089:0:b0:21e:52a6:98a7 with SMTP id y9-20020adfd089000000b0021e52a698a7mr1426196wrh.232.1658541202814;
        Fri, 22 Jul 2022 18:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003976fbfbf00sm7130279wmq.30.2022.07.22.18.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:22 -0700 (PDT)
Message-Id: <3adfd9219954109d9d002459599aac4e0b96a04f.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:13 +0000
Subject: [PATCH v5 3/8] merge: abort if index does not match HEAD for trivial
 merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

As noted in the last commit and the links therein (especially commit
9822175d2b ("Ensure index matches head before invoking merge machinery,
round N", 2019-08-17), we have had a very long history of problems with
failing to enforce the requirement that index matches HEAD when starting
a merge.

The "trivial merge" logic in builtin/merge.c is yet another such case
we previously missed.  Add a check for it to ensure it aborts if the
index does not match HEAD, and add a testcase where this fix is needed.

Note that the fix here would also incidentally be an alternative fix
for the testcase added in the last patch, but the fix in the last patch
is still needed when multiple merge strategies are in use, so tweak the
testcase from the previous commit so that it continues to exercise the
codepath added in the last commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c                          | 15 +++++++++++++++
 t/t6424-merge-unrelated-index-changes.sh | 22 +++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 23170f2d2a6..b43876f68e4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1599,6 +1599,21 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
+				error(_("Your local changes to the following files would be overwritten by merge:\n  %s"),
+				      sb.buf);
+				strbuf_release(&sb);
+				return 2;
+			}
+
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_STRICT);
 			printf(_("Trying really trivial in-index merge...\n"));
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index eabe6bda832..187c761ad84 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -114,6 +114,19 @@ test_expect_success 'resolve, non-trivial' '
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
 test_expect_success 'resolve, non-trivial, related file removed' '
 	git reset --hard &&
 	git checkout B^0 &&
@@ -121,7 +134,14 @@ test_expect_success 'resolve, non-trivial, related file removed' '
 	git rm a &&
 	test_path_is_missing a &&
 
-	test_must_fail git merge -s resolve D^0 &&
+	# We also ask for recursive in order to turn off the "allow_trivial"
+	# setting in builtin/merge.c, and ensure that resolve really does
+	# correctly fail the merge (I guess this also tests that recursive
+	# correctly fails the merge, but the main thing we are attempting
+	# to test here is resolve and are just using the side effect of
+	# adding recursive to ensure that resolve is actually tested rather
+	# than the trivial merge codepath)
+	test_must_fail git merge -s resolve -s recursive D^0 &&
 
 	test_path_is_missing a &&
 	test_path_is_missing .git/MERGE_HEAD
-- 
gitgitgadget

