Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE5C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiFHUJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiFHUJM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:09:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288ADDE8
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:09:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so29721000wrg.12
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p7+AIWYTu3atPQftovOCI7nQNMiowZwBtLWmOsZeL0o=;
        b=Ly1q1K8mEBiEDCP5WgRVkOVWiDWDYuk5YqNaT0Kyiiy3qPa1AjQIgpURHx5w2FN5o4
         N0yY7TU4nOw5xflni/5lW6LNCujvR4+H9ayywWXPZBWMiM8uUl33uAzXlI2Caai5i1vT
         nNkFM2JD9KaVtNfqI+SkCN0B0qcccLbBCuM/jj0D/NM2AwFJ+UtRlj1j7q+CRWcg1ZHf
         xYhEL3R0Htm+2O1u1YOiibRuk0jOPsbto/qZ9ZsrAW6kaYvwXx3HfrnxeNH18Ld9dm2k
         QccKLVh5wnuG80/03ZtE+PQMBKvaVWeHSXLW9klbRhJAa2lkYGkToocqI1pUgpOKj3at
         /EzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p7+AIWYTu3atPQftovOCI7nQNMiowZwBtLWmOsZeL0o=;
        b=pP4+Z1zqAgJl2CPRF0MDv8mCSTorqZANaomFjmvH2xQsLgCDuJ2XcFHKw2aZNWCR1A
         +moz+JNQyj20yjOyrXGq8cDs8Jlx+XWBpHyI6wHHkprcsTUFvroo8wzOC/8z8ZOVbArI
         N7+iruzQ54vRNVWzgIZbDNHGHhFyXIxu4vYZQUkH8Khl9hDaCFNVqi4FpZjKXpwzmdkQ
         VD5K2tHZn7Ki2pLcXQIjNw5q5lp7gKmdFuLoCRQZ6DqAYKrfHa1+QkEsMz8nhTzrc6Wt
         P2IxA44GsVtvlIZuTO2axLRJnHPaqyyEuiICRtMAQld4oCz7Y3RdUXfqAOoDE0DnCMRn
         NPIA==
X-Gm-Message-State: AOAM533rl000N6XAJle0SQlFtd4U1vXMqLycB/IHdU9eUuc+N+mzNp+S
        cYOzjAsM+vAzFj6e+0CYZPzw3k3TksFaRSSk
X-Google-Smtp-Source: ABdhPJxUL/0JqY2hyHbIJDq7wc0pzqziTvO5aDtazeDM2eRFJ/tcPkTea4zbhkdXKAzZ/Q3fZFVbzw==
X-Received: by 2002:adf:d0c3:0:b0:218:4f53:5823 with SMTP id z3-20020adfd0c3000000b002184f535823mr10804488wrh.132.1654718949320;
        Wed, 08 Jun 2022 13:09:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg30-20020a05600c3c9e00b0039c5497deccsm371408wmb.1.2022.06.08.13.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 13:09:08 -0700 (PDT)
Message-Id: <af645b43032e8b138da3aae1732047208b3b2890.1654718942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 20:09:02 +0000
Subject: [PATCH 4/4] branch: use branch_checked_out() when deleting refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

This is the last current use of find_shared_symref() that can easily be
replaced by branch_checked_out(). The benefit of this switch is that the
code is a bit simpler, but also it is faster on repeated calls.

The remaining uses of find_shared_symref() are non-trivial to remove, so
we probably should not continue in that direction:

* builtin/notes.c uses find_shared_symref() with "NOTES_MERGE_REF"
  instead of "HEAD", so it doesn't have an immediate analogue with
  branch_checked_out(). Perhaps we should consider extending it to
  include that symref in addition to HEAD, BISECT_HEAD, and
  REBASE_HEAD.

* receive-pack.c checks to see if a worktree has a checkout for the ref
  that is being updated. The tricky part is that it can actually decide
  to update the worktree directly instead of just skipping the update.
  This all depends on the receive.denyCurrentBranch config option. The
  implementation currenty cares about receiving the worktree in the
  result, so the current branch_checked_out() prototype is insufficient
  currently. This is something to investigate later, though, since a
  large number of refs could be updated at the same time and using the
  strmap implementation of branch_checked_out() could be beneficial.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/branch.c          | 8 ++++----
 t/t2407-worktree-heads.sh | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5d00d0b8d32..8e11e433840 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -253,12 +253,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		name = mkpathdup(fmt, bname.buf);
 
 		if (kinds == FILTER_REFS_BRANCHES) {
-			const struct worktree *wt =
-				find_shared_symref(worktrees, "HEAD", name);
-			if (wt) {
+			char *path;
+			if (branch_checked_out(name, &path)) {
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
-				      bname.buf, wt->path);
+				      bname.buf, path);
+				free(path);
 				ret = 1;
 				continue;
 			}
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index f3f8b0b2b79..6dcc0d39a2d 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -26,7 +26,10 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	for i in 1 2 3 4
 	do
 		test_must_fail git branch -f wt-$i HEAD 2>err
-		grep "cannot force update the branch" err || return 1
+		grep "cannot force update the branch" err &&
+
+		test_must_fail git branch -D wt-$i 2>err
+		grep "Cannot delete branch" err || return 1
 	done
 '
 
-- 
gitgitgadget
