Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DDFCCA47A
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 19:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbiFNT1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiFNT1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 15:27:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8EBDFF3
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id z17so5207862wmi.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4k6d7Lt2WBi3GOPApoM/jn2bT82xIJh1tXyG8Vad2OE=;
        b=gWHHGR1njZjaoI01g3Tdpf6YQpyjObvy0+7til/+Z6k1F46/v1VD53ljkgmz1MjawK
         K7ZMy16qw74iSOPwjYa9NkcYhTtHPZn3yI6H64RlK5x64KugwGuDGRU7r0kJo7b5n4Tz
         ovdOSaKZbOrhIPvgpEOUISOW5vQOER7/1wtk4r4ATbJCj4PhLdKgTIJ7Y6dkEDN1qMaP
         kZj4wVikIBUe4LhkbT1GAKRIVe6Ba4aYkCFgqNeIpkvlT8TFOXRClJdP3RymprMfq23h
         AOD8krjjPeUZQq6gtEQCvhC9hLtwly69YGCBsehIN1vDno1458WNo+EZaJV5FC+lWJ+U
         gbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4k6d7Lt2WBi3GOPApoM/jn2bT82xIJh1tXyG8Vad2OE=;
        b=DRPrczN2bSA6ErINSJbG75pJ6ij7PAEIOHFLRUFaGyajymcvkQHhKhrFbW+3WiwOYi
         jp31KwTQRDaslDLbCovXz969u78PtT9rZnUW6veCkFAw2jzdurDe2z1PubG/adfvkibS
         fNXVYTLUbMBbrdcm554FQGOgdUvSmJZcSPldpnBUajss7U2HQH2omK4qmbKJ0DJkybup
         9lmipU2Nh0dnEKQOYi0mZGqf1rO2XvL898WiGx1XAKQoVtVwHHj/RZSwKGJmW0wk3egY
         /oTbP9eWwUeuOp8+mBK5FEv80ALW697xQHbQEP2sNHC2/l/FSef3720mXePmPtIm2Hp7
         e5bQ==
X-Gm-Message-State: AOAM533NmQl5T8m4r1Rli4ECCs+PRd7tTEv/kTUW+i/UicHxzqDuiXp6
        s8OUbl26HDDquHPyLgO6FNyAhTxOy3/IZQ==
X-Google-Smtp-Source: ABdhPJxHDc2yyEHFbnr92le3emB1BBXehAsAw6U8PlsroGhWGfrUiALr8KIgMWrC3Vo3zvaMYYzbaA==
X-Received: by 2002:a7b:c4d8:0:b0:39c:97ed:baa3 with SMTP id g24-20020a7bc4d8000000b0039c97edbaa3mr5825163wmk.58.1655234857456;
        Tue, 14 Jun 2022 12:27:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m127-20020a1ca385000000b0039c95b31e66sm7274233wme.31.2022.06.14.12.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 12:27:36 -0700 (PDT)
Message-Id: <9347303db8911187f1d257e0336dc9ca523d713c.1655234853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
        <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 19:27:30 +0000
Subject: [PATCH v2 2/5] branch: check for bisects and rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The branch_checked_out() helper was added by the previous change, but it
used an over-simplified view to check if a branch is checked out. It
only focused on the HEAD symref, but ignored whether a bisect or rebase
was happening.

Teach branch_checked_out() to check for these things, and also add tests
to ensure that we do not lose this functionality in the future.

Now that this test coverage exists, we can safely refactor
validate_new_branchname() to use branch_checked_out().

Note that we need to prepend "refs/heads/" to the 'state.branch' after
calling wt_status_check_*(). We also need to duplicate wt->path so the
value is not freed at the end of the call.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 branch.c                  | 35 +++++++++++++++++++++++++++--------
 t/t2407-worktree-heads.sh | 22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/branch.c b/branch.c
index 42ba60b7cb5..d4ddec6f4e5 100644
--- a/branch.c
+++ b/branch.c
@@ -385,6 +385,7 @@ static void prepare_checked_out_branches(void)
 	worktrees = get_worktrees();
 
 	while (worktrees[i]) {
+		struct wt_status_state state = { 0 };
 		struct worktree *wt = worktrees[i++];
 
 		if (wt->is_bare)
@@ -394,6 +395,29 @@ static void prepare_checked_out_branches(void)
 			strmap_put(&current_checked_out_branches,
 				   wt->head_ref,
 				   xstrdup(wt->path));
+
+		if (wt_status_check_rebase(wt, &state) &&
+		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
+		    state.branch) {
+			struct strbuf ref = STRBUF_INIT;
+			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			strmap_put(&current_checked_out_branches,
+				   ref.buf,
+				   xstrdup(wt->path));
+			strbuf_release(&ref);
+		}
+		wt_status_state_free_buffers(&state);
+
+		if (wt_status_check_bisect(wt, &state) &&
+		    state.branch) {
+			struct strbuf ref = STRBUF_INIT;
+			strbuf_addf(&ref, "refs/heads/%s", state.branch);
+			strmap_put(&current_checked_out_branches,
+				   ref.buf,
+				   xstrdup(wt->path));
+			strbuf_release(&ref);
+		}
+		wt_status_state_free_buffers(&state);
 	}
 
 	free_worktrees(worktrees);
@@ -413,9 +437,7 @@ const char *branch_checked_out(const char *refname)
  */
 int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 {
-	struct worktree **worktrees;
-	const struct worktree *wt;
-
+	const char *path;
 	if (!validate_branchname(name, ref))
 		return 0;
 
@@ -423,13 +445,10 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 		die(_("a branch named '%s' already exists"),
 		    ref->buf + strlen("refs/heads/"));
 
-	worktrees = get_worktrees();
-	wt = find_shared_symref(worktrees, "HEAD", ref->buf);
-	if (wt && !wt->is_bare)
+	if ((path = branch_checked_out(ref->buf)))
 		die(_("cannot force update the branch '%s' "
 		      "checked out at '%s'"),
-		    ref->buf + strlen("refs/heads/"), wt->path);
-	free_worktrees(worktrees);
+		    ref->buf + strlen("refs/heads/"), path);
 
 	return 1;
 }
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 305ab46e38e..a838f2be474 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -26,4 +26,26 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
+test_expect_success 'refuse to overwrite: worktree in bisect' '
+	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+
+	touch .git/worktrees/wt-4/BISECT_LOG &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+
+	test_must_fail git branch -f fake-2 HEAD 2>err &&
+	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
+'
+
+test_expect_success 'refuse to overwrite: worktree in rebase' '
+	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+
+	mkdir -p .git/worktrees/wt-3/rebase-merge &&
+	touch .git/worktrees/wt-3/rebase-merge/interactive &&
+	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
+
+	test_must_fail git branch -f fake-1 HEAD 2>err &&
+	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
+'
+
 test_done
-- 
gitgitgadget

