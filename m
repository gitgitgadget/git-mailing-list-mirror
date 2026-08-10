Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E064400987
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374476; cv=none; b=iX4cKJt0swverlqO8GaKmiYnWjcb/sSMoiqlAEWLAFrRbt07va0/JOISnf4lzKT4FoeNMAfeIcNGds2/71qgfI9wzdT0gyrSIapQphNEJsJUdcEEI5s727QDaklKjQkt5ggDo2OhMssvyKHvl9tVQrF4Agz77w07tkw/RKfTjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374476; c=relaxed/simple;
	bh=nVgb4jRIrgM3rKuFLLblkBhrB3WBco/QFeLEa0gWMYY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=INro4r9CxgBIvLw6wWCTA/1qUByXkxNne7J+LNCGqn7kwV8zlGcheIKYFA0bf7pe+Cqu0DRvQnhyhkR5rBqnPURTnpztBJgQWB18z3biDRD8/Z2BbwbM0vPqnNr1De277Nr23ol4PRLpH2JtPNNanqRzKmtsiOGv0xCXi6YYvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM+dOyPq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM+dOyPq"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c8e2e39easo21067171cf.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786374473; x=1786979273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PW15QIPmH/zyk+qy3Vvaukv10i6SR7mk/kGUDSI7Nh8=;
        b=QM+dOyPqS4uEnTN2fPmVQHM81P59gg0RpC1q17F7M2Sy1wQeVqjHmcT5C8T6AUco7N
         FmpDBwSCZ8GeCRtV8lXDtYDoCEG5txPkRNE53ECaqlwNuTvTiQTZpm78kkNVz1aH7jJW
         GJ5mRi4yXll+B3q5uD9ssHBMxTiKjmKVPbWysNg1T8DUCaNJ1Rfb6biJquJvSSb86dAj
         oldWWFDL0akAZFw5LKmdVHyW6SSMoVdZ5kvHlV8UVF3X41QBeg4GF93aq2MJ9LEoBmeT
         pxRH+HwLBH49+V+5cT8R2gKuifp9AK1mRgRthcYg4g0HPgVfGAddxYLWCqyZO8fvqZ+l
         vcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786374473; x=1786979273;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PW15QIPmH/zyk+qy3Vvaukv10i6SR7mk/kGUDSI7Nh8=;
        b=tDDU3VQV8IUxxVt2+VUPkbt8cp9p2zkt8e6HDTBgOZZZha3Kl17t3C/iIBBuiF3I6B
         7uOLfULCABxOGnciYe+0NU25y9AxrL/84WikxRQMQ0e1h5z/vTevCIxj9n0nWE1AxpEk
         EgezTaeYUtTDphycLoVy5jP5Qqu9mqR9WsB5qB4BoAhMayBsYeuWtnAkZwy3W6JeqlqH
         dNMqEMUE2D9sSEUsAqXSylbEqNLs57xw83I9XTXA0u6li3jlFKeUzXRZ1KNIk1HnLbkq
         PTpwdLguElii+0MqbEP+DT6dOr/WgixsOlvfwDIoCnHSUABJgsvIkHBtO8CRPXQeKCAJ
         n2mw==
X-Gm-Message-State: AOJu0Yw2vXNKftga1oDgQzPtEFQSTV86laDsRkpxTpw2p67WdG+wzJWO
	Dk8sV+SW+xGcmDKP6bCPfp+nJQxA5JfKqObxiMEsDodvuxwwYJoaQjrmb9WokA==
X-Gm-Gg: AR+sD10ntg+hLxEqTFVQgKtLHthL4Q5tyFAiwkK6HEh4INVHGXt/MqzVEEYl6CAgqxK
	v2/VZKDmD/7x1gfLoTl8+mQETJcoaF+3fonPHpZo5++141EY99UhTu8ykCQauHkde7BAJ6X5+27
	+Avh/5J3/aEzmeVOzL17MGztKqlSd9iFU8EAjtH1PvwZJ9We+XXDri07bmGFzovSD1T0XTUj6aN
	hCY6pGa6vst4wVrfImfkEcu6Z1JJEEbe5PXsxAKKkwaVt+Oz9tpO7N4rhEweJNXSnIqjJ90Tlvu
	AwYEHN0xgKfY9a0n8vAr6k4KuvwYSh/NK/IRpoxuxmYwuslxGU4YZwBzUKWXP+hke/sW6ag4J1R
	v5IkwT/xEHhuP165Gu77Egxi6DJgalKdQmN09nRDxlbS0AP60ts68tZmWJS57LClWxswWeGuzh3
	uj8rsVcytF84ub1MRIHAxNBbQThwkbKWVAzmGZjxR6cFHgOgIoSIHdkb0uIgpYZf89jtKftsRyu
	qE=
X-Received: by 2002:a05:622a:3c8:b0:516:e249:e30f with SMTP id d75a77b69052e-52d20a9a717mr234389921cf.42.1786374473118;
        Mon, 10 Aug 2026 08:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.210.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a930056csm73498876d6.27.2026.08.10.08.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:07:51 -0700 (PDT)
Message-Id: <pull.2197.v2.git.1786374470383.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 15:07:49 +0000
Subject: [PATCH v2] worktree add: improve message for ambiguous remote branch
 name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Display a hint and a descriptive error message when DWIM fails.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: improve message for ambiguous remote branch name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v1:

 1:  00b814fe09 ! 1:  1bc57ce497 worktree add: improve message for ambiguous remote branch name
     @@ Metadata
       ## Commit message ##
          worktree add: improve message for ambiguous remote branch name
      
     -    Display a descriptive message when DWIM fails.
     -
     -    Add advice on how to work around this by specifying the fully
     -    qualified name or by setting checkout.defaultRemote.
     +    Display a hint and a descriptive error message when DWIM fails.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      
       ## builtin/worktree.c ##
     -@@ builtin/worktree.c: static const char * const git_worktree_unlock_usage[] = {
     - 	NULL
     - };
     +@@
     + 	"\n" \
     + 	"    git worktree add --orphan %s\n")
       
     -+static const char message_advice_ambiguous_remote_tracking_branch[] =
     -+	N_("If you meant to create a worktree from a remote tracking branch on,\n"
     -+	   "e.g. 'origin', you can do so by fully qualifying the name:\n"
     -+	   "\n"
     -+	   "    git worktree add <path> origin/<name>\n"
     -+	   "\n"
     -+	   "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
     -+	   "one remote, e.g. the 'origin' remote, consider setting\n"
     -+	   "checkout.defaultRemote=origin in your config.");
     ++#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
     ++	_("Matched multiple remote tracking branches, you can list them by:\n" \
     ++	"\n" \
     ++	"    git branch -r --list \"*/%s\"\n" \
     ++	"\n" \
     ++	"If you meant to create a worktree from a remote tracking branch on,\n" \
     ++	"e.g. 'origin', you can do so by:\n" \
     ++	"\n" \
     ++	"    git worktree add -b %s %s origin/%s\n" \
     ++	"\n" \
     ++	"If you'd like to always prefer some remote, e.g. 'origin',\n" \
     ++	"consider setting checkout.defaultRemote=origin in your config.")
      +
     - struct add_opts {
     - 	int force;
     - 	int detach;
     -@@ builtin/worktree.c: static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
     - 	return 1;
     - }
     - 
     --static char *dwim_branch(const char *path, char **new_branch)
     -+static char *dwim_branch(const struct add_opts *opts, const char *path, char **new_branch)
     - {
     - 	int n;
     - 	int branch_exists;
     -@@ builtin/worktree.c: static char *dwim_branch(const char *path, char **new_branch)
     - 
     - 	*new_branch = branchname;
     - 	if (guess_remote) {
     -+		int num_matches = 0;
     - 		struct object_id oid;
     --		char *remote = unique_tracking_name(*new_branch, &oid, NULL);
     -+		char *remote = unique_tracking_name(*new_branch, &oid, &num_matches);
     -+		if (!opts->quiet && !remote && num_matches > 1) {
     -+			if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
     -+				advise(_(message_advice_ambiguous_remote_tracking_branch));
     -+			warning(_("'%s' matched multiple (%d) remote tracking branches\n"), branchname, num_matches);
     -+		}
     - 		return remote;
     - 	}
     - 	return NULL;
     -@@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
     - 		opts.orphan = dwim_orphan(&opts, !!opt_track, 0);
     - 	} else if (ac < 2) {
     - 		/* DWIM: Guess branch name from path. */
     --		char *s = dwim_branch(path, &new_branch_to_free);
     -+		char *s = dwim_branch(&opts, path, &new_branch_to_free);
     - 		if (s)
     - 			branch = branch_to_free = s;
     - 		new_branch = new_branch_to_free;
     + static const char * const git_worktree_usage[] = {
     + 	BUILTIN_WORKTREE_ADD_USAGE,
     + 	BUILTIN_WORKTREE_LIST_USAGE,
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
       
       		commit = lookup_commit_reference_by_name(branch);
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix,
       				new_branch = branch;
       				branch = new_branch_to_free = remote;
      +			} else if (num_matches > 1) {
     -+				if (!opts.quiet && advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
     -+					advise(_(message_advice_ambiguous_remote_tracking_branch));
     -+				}
     -+				die(_("'%s' matched multiple (%d) remote tracking branches"), branch, num_matches);
     ++				if (!opts.quiet)
     ++					advise_if_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
     ++							  WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT,
     ++							  branch, branch, path, branch);
     ++				die(_("'%s' matched multiple (%d) remote tracking branches"),
     ++				    branch, num_matches);
       			}
       		}
       
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" <path> <branch> dwims' '
       		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
       		git status -uno --porcelain >status.actual &&
       		test_must_be_empty status.actual
     -@@ t/t2400-worktree-add.sh: test_expect_success 'git worktree add --guess-remote sets up tracking' '
     - 		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
     - 	)
     - '
     -+test_expect_success 'git worktree add --guess-remote with ambiguous name' '
     -+	test_when_finished rm -rf repo_a repo_b foo &&
     -+	setup_remote_repo repo_a repo_b &&
     -+	(
     -+		cd repo_b &&
     -+		git remote add upstream2 ../repo_a &&
     -+		git fetch upstream2 &&
     -+		git worktree add --guess-remote ../foo 2>actual &&
     -+		test_grep "matched multiple (2) remote tracking branches" actual
     -+	) &&
     -+	(
     -+		cd foo &&
     -+		test_must_fail git config "branch.foo.remote" &&
     -+		test_must_fail git config "branch.foo.merge" &&
     -+		test_cmp_rev refs/heads/main refs/heads/foo
     -+	)
     -+'
     - test_expect_success 'git worktree add --guess-remote sets up tracking (quiet)' '
     - 	test_when_finished rm -rf repo_a repo_b foo &&
     - 	setup_remote_repo repo_a repo_b &&


 builtin/worktree.c      | 23 ++++++++++++++++++++++-
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..b29c3a3755 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -64,6 +64,19 @@
 	"\n" \
 	"    git worktree add --orphan %s\n")
 
+#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
+	_("Matched multiple remote tracking branches, you can list them by:\n" \
+	"\n" \
+	"    git branch -r --list \"*/%s\"\n" \
+	"\n" \
+	"If you meant to create a worktree from a remote tracking branch on,\n" \
+	"e.g. 'origin', you can do so by:\n" \
+	"\n" \
+	"    git worktree add -b %s %s origin/%s\n" \
+	"\n" \
+	"If you'd like to always prefer some remote, e.g. 'origin',\n" \
+	"consider setting checkout.defaultRemote=origin in your config.")
+
 static const char * const git_worktree_usage[] = {
 	BUILTIN_WORKTREE_ADD_USAGE,
 	BUILTIN_WORKTREE_LIST_USAGE,
@@ -904,10 +917,18 @@ static int add(int ac, const char **av, const char *prefix,
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
+			int num_matches = 0;
+			remote = unique_tracking_name(branch, &oid, &num_matches);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet)
+					advise_if_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+							  WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT,
+							  branch, branch, path, branch);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
 		}
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
