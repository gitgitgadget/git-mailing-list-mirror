Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF31879
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641753; cv=none; b=HHGj6wEXdtX8p6VneS/MA01YrUl6UX0Hz5JX2MjTsl2IjkUwAsrmCs/twEuDmZjY+yg2kKRs+lBUs7OeBl0P4zqyuzs7KObcWJ5cVPiBF18oa2YdyksFOabMbc+fQseYAaSKPxvwka8rUV9/Yn6RoCr90FJfTyXbkwxmNMMKO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641753; c=relaxed/simple;
	bh=ndHAYbCsXEiuO50TsMd5qkNu0oOXEwqPMXammr+8Sy0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FCmaF+xTiJXICFobeUav0F8x3dMZBy7N2mAaL4sG8+WiMSv88gZDVRYcjoKrEP3P+DUC4Wgg8wo9NeLdXp/bj3aDjERkl3Z+sBeesY4PHSQglxnFwyo/Cza7uD8Q1wpsVEFIOHZIuZkOfTe8jE3ToTmo1dmefzrNsH6p6EKNJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOdURkTJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOdURkTJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530e22878cfso6056568e87.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723641749; x=1724246549; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TK/SRQYwpvsfATMvjMA3yVdzV1S8CKRYw7r2FVswZuY=;
        b=DOdURkTJi/xZz+y0MXGZA0hzyczhz6pVFg6M+2oRscuCN4kVYjbtIJORZFTz6Lziqw
         Vstu7OP21wjfsXSoBOT+WtgIdFRVDmsrpnfEirShfUJ7eGNdOEIDGIFQmn3j61SkOXoc
         MXSn+8lvQnUXiEFbPi1rhB04+IamI3KE0pFmZmOac6Gw+B+QN1tyaLw5hNAzvl+CXGKQ
         7Al6iRkmREFcAXU5oCmnH2/fssULXlH7oDyQFtmQzxA0QA1LIaRSHURucblXzHGDDmQH
         MjfjRW2d+7PfimAvKsbevtXbs2mrW3qUAZMRIL1HbaA2CLXlF5WDp+ipssrd+YtPMg24
         bZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723641749; x=1724246549;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TK/SRQYwpvsfATMvjMA3yVdzV1S8CKRYw7r2FVswZuY=;
        b=Wzvd1ha0ljZP6pivk6l0QVIGiuVOPfbHGPHb7klzr4XXtXaOfNWzgBFGbiMcJy6S0Y
         nJdc2BmCx6cWvLCtdgvHhD9ftUpCqBIRFSWW9Q0q0SYqZuY92sEsbui3yD6bzdlwfnAu
         J4Vx7fGd14clbbR6sqB1rSJc4HRWhRT33wMij86bbDGTEh2ib96HALYwQoQBU1WoaiZi
         cDqGK+iyDfaNNMsBTX8bMz/rLKw1KP4qLHvNKrFeGgUH8U1r3VQwi2P16cs385X1L8g9
         D4JmOa2IzA3maSNxeDvgZeLpa4OLbXdHzI5cB/ZB6Ukl8RBwyrLE/5E+nb0zqEjgo9PL
         gFwg==
X-Gm-Message-State: AOJu0YyXA8fizDUovgu3RMnQFNNXUaupphsX4NxVglt7G+k2KC/CUtZa
	On8xa7tvTnuNiPpPlST/NeM2fd/+Bi04Ty27NaLNYZB2mwEOIVaGa92vUw==
X-Google-Smtp-Source: AGHT+IHvRWm6CCcVEqpJuc+PpMSFymSs46EIEplaSDBGUotxF2llB23cDpUU77EexALZ9AeKgUVXSA==
X-Received: by 2002:a05:6512:3054:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-532eda658b6mr1955800e87.11.1723641748630;
        Wed, 14 Aug 2024 06:22:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfee31fsm12851173f8f.47.2024.08.14.06.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:22:28 -0700 (PDT)
Message-Id: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 13:22:27 +0000
Subject: [PATCH] rebase: apply and cleanup autostash when rebase fails to
 start
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If "git rebase" fails to start after stashing the user's uncommitted
changes then it forgets to restore the stashed changes and remove state
directory. To make matters worse running "git rebase --abort" to apply
the stashed changes and cleanup the state directory fails because the
state directory only contains the "autostash" file and is missing the
"head-name" and "onto" required by read_basic_state().

Fix this by applying the autostash and removing the state directory if
the pre-rebase hook or initial checkout fail. New tests are added to
check the autostash is applied and the state directory is removed if the
rebase fails to start. Checks are also added to some existing tests in
order to ensure there is no state directory left behind when a rebase
fails to start and no autostash has been created.

Reported-by: Brian Lyles <brianmlyles@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    rebase: apply and cleanup autostash when rebase fails to start
    
    Thanks to Brian for reporting this. This patch is based on maint.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1772%2Fphillipwood%2Frebase-fix-autostash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1772/phillipwood/rebase-fix-autostash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1772

 builtin/rebase.c            | 39 +++++++++++++++++++++++++++++-------
 t/t3400-rebase.sh           |  8 ++++++--
 t/t3413-rebase-hook.sh      |  4 +++-
 t/t3420-rebase-autostash.sh | 40 +++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc2..ac23c4ddbb0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -526,6 +526,23 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	return 0;
 }
 
+static int cleanup_autostash(struct rebase_options *opts)
+{
+	int ret;
+	struct strbuf dir = STRBUF_INIT;
+	const char *path = state_dir_path("autostash", opts);
+
+	if (!file_exists(path))
+		return 0;
+	ret = apply_autostash(path);
+	strbuf_addstr(&dir, opts->state_dir);
+	if (remove_dir_recursively(&dir, 0))
+		ret = error_errno(_("could not remove '%s'"), opts->state_dir);
+	strbuf_release(&dir);
+
+	return ret;
+}
+
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -1726,7 +1743,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (require_clean_work_tree(the_repository, "rebase",
 				    _("Please commit or stash them."), 1, 1)) {
 		ret = -1;
-		goto cleanup;
+		goto cleanup_autostash;
 	}
 
 	/*
@@ -1749,7 +1766,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			if (options.switch_to) {
 				ret = checkout_up_to_date(&options);
 				if (ret)
-					goto cleanup;
+					goto cleanup_autostash;
 			}
 
 			if (!(options.flags & REBASE_NO_QUIET))
@@ -1775,8 +1792,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	/* If a hook exists, give it a chance to interrupt*/
 	if (!ok_to_skip_pre_rebase &&
 	    run_hooks_l("pre-rebase", options.upstream_arg,
-			argc ? argv[0] : NULL, NULL))
-		die(_("The pre-rebase hook refused to rebase."));
+			argc ? argv[0] : NULL, NULL)) {
+		ret = error(_("The pre-rebase hook refused to rebase."));
+		goto cleanup_autostash;
+	}
 
 	if (options.flags & REBASE_DIFFSTAT) {
 		struct diff_options opts;
@@ -1821,9 +1840,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	ropts.head_msg = msg.buf;
 	ropts.default_reflog_action = options.reflog_action;
-	if (reset_head(the_repository, &ropts))
-		die(_("Could not detach HEAD"));
-	strbuf_release(&msg);
+	if (reset_head(the_repository, &ropts)) {
+		ret = error(_("Could not detach HEAD"));
+		goto cleanup_autostash;
+	}
 
 	/*
 	 * If the onto is a proper descendant of the tip of the branch, then
@@ -1851,9 +1871,14 @@ run_rebase:
 
 cleanup:
 	strbuf_release(&buf);
+	strbuf_release(&msg);
 	strbuf_release(&revisions);
 	rebase_options_release(&options);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
 	return !!ret;
+
+cleanup_autostash:
+	ret |= !!cleanup_autostash(&options);
+	goto cleanup;
 }
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ae34bfad607..972ea85febc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -145,7 +145,9 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
 	test_when_finished "rm -f B" &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
 	test_grep "The following untracked working tree files would be overwritten by checkout:" output.err &&
-	test_grep B output.err
+	test_grep B output.err &&
+	test_must_fail git rebase --quit 2>err &&
+	test_grep "no rebase in progress" err
 '
 
 test_expect_success 'fail when upstream arg is missing and not on branch' '
@@ -422,7 +424,9 @@ test_expect_success 'refuse to switch to branch checked out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
 	test_must_fail git -C wt rebase main main 2>err &&
-	test_grep "already used by worktree at" err
+	test_grep "already used by worktree at" err &&
+	test_must_fail git -C wt rebase --quit 2>err &&
+	test_grep "no rebase in progress" err
 '
 
 test_expect_success 'rebase when inside worktree subdirectory' '
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index e8456831e8b..426ff098e1d 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -110,7 +110,9 @@ test_expect_success 'pre-rebase hook stops rebase (1)' '
 	git reset --hard side &&
 	test_must_fail git rebase main &&
 	test "z$(git symbolic-ref HEAD)" = zrefs/heads/test &&
-	test 0 = $(git rev-list HEAD...side | wc -l)
+	test 0 = $(git rev-list HEAD...side | wc -l) &&
+	test_must_fail git rebase --quit 2>err &&
+	test_grep "no rebase in progress" err
 '
 
 test_expect_success 'pre-rebase hook stops rebase (2)' '
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 63e400b89f2..b43046b3b0d 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -82,6 +82,46 @@ testrebase () {
 	type=$1
 	dotest=$2
 
+	test_expect_success "rebase$type: restore autostash when pre-rebase hook fails" '
+		git checkout -f feature-branch &&
+		test_hook pre-rebase <<-\EOF &&
+		exit 1
+		EOF
+
+		echo changed >file0 &&
+		test_must_fail git rebase $type --autostash -f HEAD^ &&
+		test_must_fail git rebase --quit 2>err &&
+		test_grep "no rebase in progress" err &&
+		echo changed >expect &&
+		test_cmp expect file0
+	'
+
+	test_expect_success "rebase$type: restore autostash when checkout onto fails" '
+		git checkout -f --detach feature-branch &&
+		echo uncommitted-content >file0 &&
+		echo untracked >file4 &&
+		test_when_finished "rm file4" &&
+		test_must_fail git rebase $type --autostash \
+							unrelated-onto-branch &&
+		test_must_fail git rebase --quit 2>err &&
+		test_grep "no rebase in progress" err &&
+		echo uncommitted-content >expect &&
+		test_cmp expect file0
+	'
+
+	test_expect_success "rebase$type: restore autostash when branch checkout fails" '
+		git checkout -f unrelated-onto-branch^ &&
+		echo uncommitted-content >file0 &&
+		echo untracked >file4 &&
+		test_when_finished "rm file4" &&
+		test_must_fail git rebase $type --autostash HEAD \
+							unrelated-onto-branch &&
+		test_must_fail git rebase --quit 2>err &&
+		test_grep "no rebase in progress" err &&
+		echo uncommitted-content >expect &&
+		test_cmp expect file0
+	'
+
 	test_expect_success "rebase$type: dirty worktree, --no-autostash" '
 		test_config rebase.autostash true &&
 		git reset --hard &&

base-commit: 39bf06adf96da25b87c9aa7d35a32ef3683eb4a4
-- 
gitgitgadget
