Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D4367F5E
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841726; cv=none; b=ZT6T10rIZCR9dog8Yttx50dxgAznCRLVFJkfFey2ZS2DGKQc668UYeCPG8CLRXvPOuEMa13w4/q1ZRNaiwaHzh1cKs3//hFqbTbrlc3KhT0mqgkK3HrbeDq6FjC7YLCYVndDZi/xKWLqis1OWn+1/8EaZ1ha/UyRj4i4VnSwVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841726; c=relaxed/simple;
	bh=5P5HwovBzB824qtal9Oy8kV4jgptR4lDi9AP7mtGnKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FqcAptr9/1Xk0kcDfePwiyKnE1xQX0r8Y8elaY+enDA460Iy7hu9qfGHhQMaS0cxPb2/JbR4z1xKhFegiPg+yknvyqlJPgVAhAPLMxtSqAuesfV2mbaxvl1c0Ql6k0GqeTK/nWOP30WzXjwmIAxYR5aa88VesDXzmf7LuQqbT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icgD6izq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icgD6izq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-938cd95b06eso70642485a.1
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787841723; x=1788446523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pgPOLThxsyUvFkp7Uko/wm2Bra7A6zsnyci9hWVHhIM=;
        b=icgD6izqDVT4iUq1LaZN9cU2T9d9vMcbyDZTs19iZgdUMJ+2f81/WQxRr3/uUTTCn9
         Sj/lZxR44AMStmjpKSLwEM9krpi2YVJFKUqI4sg+hs9+wNLZr5bsdM3bkUe1v7irSKQS
         cMs/3MT7I87kAmZvWl7aYmQlFwom24sFwr0yCCikNlPLw/xZG1PmEikyNXh/8AFYQbGG
         qQLTcixxTp/tsq38fnIxSDiuupm5w9QPktbIgjbJf+hXVZ+agUgomnD34PKBRBNyl1kD
         RsKFLWyX3XwE0V8JE6jtyLIL4nICMR9eAn8iBs7piS9lht/KJ3h1wCn4p6eNGb/jXphg
         auYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787841723; x=1788446523;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgPOLThxsyUvFkp7Uko/wm2Bra7A6zsnyci9hWVHhIM=;
        b=AFBHYtAH/2D8Zp8QU3cLulrFA3Tx1b63jKKee2wOQcXAelEWCMwryZqAWNMD1NgN6F
         in62LBfqAjWfIc+3YVocItN6orf/m7rvaOJldRCgRnLASBv5p+2H7ccZlT7b9eRghXWh
         e+vQPHGneYvedroNBid09gbbg0JjQIYeN7wiKz6GnrQEExlvclGdDFKwUt5mRUliDBe+
         rUNvhfvQKPZBfdENwTJxCU49goFDLOu6PJcktact40LjCItz6JwMVrrjE5PL1d9ZSo/N
         rx0G2xHyHtmDpacWyosS2jfSABjawCT/1lMI3o4muYwq4q305/1YTpN6mYx7KizHRfjl
         CddA==
X-Gm-Message-State: AFuF++kB8in3hqYgoIGniHgJ36CzlxX9CwnU3N+PmGjW8SupuPTV8kEE
	5Hwak7zJcGLt5JMSJhDWzYRZ956iM1qFWefmQVaz6gqFpG5Zz8mixZ5CxZTxTw==
X-Gm-Gg: AR+sD111fgJuO4hiXwR8XBeyErogYQvGJgC34na7td70Lk+NrTHRo2UmVBunfw4nvyH
	KxmR38Y1PmY+r6025xzFwZF6b/DvPGUkl1cX2Mxh0dSJz0fDYjqLnLeVSFb3D2iYtm8QFdqTs4N
	c3lWri64MehJxqobmC/dZgtcrm/Q6IAgC6P3l28kyDA9z9hwC+rN2QsEeWzoCwvlMmQ8bXtn6RU
	szZscYzRuwm8l37+OOTG6eO85jnz05ZXrOdWgmoTKbNlAaxgKP0ZoGanDFVE59H9jdBCdpxskDd
	f/E6Ny97LY+ee/kUr4jVgIEnFUcg2bG2xH3ZEA57uDBLzY98m4XwysKgkOl07let4IgEAvNZrOc
	J0dybjN7XMBfCig6oiWqFko/852SqVuS5Mm3n/K9SGE/3TcOZQzz0Eh+1bPP9mK3nFwFTQyM5e1
	gkilmFJ/XPF1GXBHNK/nXTIL/WWNw2/5b9xRrTmoxnpRVvH6hc+yT8tBekFG1N5ed7
X-Received: by 2002:a05:620a:6486:b0:936:cf9c:a994 with SMTP id af79cd13be357-93900458887mr732535185a.19.1787841723418;
        Thu, 27 Aug 2026 07:42:03 -0700 (PDT)
Received: from [127.0.0.1] ([52.186.174.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939046018f2sm161776285a.7.2026.08.27.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:42:02 -0700 (PDT)
Message-Id: <407c53b33c1b4fb2b1919b4552cf15a71deb7cb8.1787841717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 14:41:57 +0000
Subject: [PATCH v10 4/4] worktree add: treat multiple matches with
 --guess-remote as an error
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

When 'git worktree add <path>' is invoked without <commit-ish> and
with the --guess-remote option (or when worktree.guessRemote is set to
true), it tries to find a remote-tracking branch matching the basename
of <path>.

Currently, the behavior when multiple matches are found is the same as
when no match is found: it falls back to creating a branch from
HEAD. This has been the behavior since 71d6682d8c (worktree: add
--guess-remote option to add subcommand, 2017-11-29), when the option
was first introduced.

However, if the specified <path> matches any remote-tracking branch,
we infer that the user intended to use one of the remote-tracking
branches as the start-point rather than HEAD. So we abort the creation
of the branch and worktree when there are multiple matches, and
instruct the user to choose the start-point.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 Documentation/config/worktree.adoc |  5 +++--
 Documentation/git-worktree.adoc    |  4 +++-
 builtin/worktree.c                 | 20 +++++++++++++++++---
 t/t2400-worktree-add.sh            | 13 +++++++++++++
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/worktree.adoc b/Documentation/config/worktree.adoc
index a248076ea5..0930183b91 100644
--- a/Documentation/config/worktree.adoc
+++ b/Documentation/config/worktree.adoc
@@ -5,8 +5,9 @@
 	set to true, `worktree add` tries to find a remote-tracking
 	branch whose name uniquely matches the new branch name.  If
 	such a branch exists, it is checked out and set as "upstream"
-	for the new branch.  If no such match can be found, it falls
-	back to creating a new branch from the current `HEAD`.
+	for the new branch.  If multiple matches are found, the command
+	fails.  If no such match can be found, it falls back to
+	creating a new branch from the current `HEAD`.
 
 `worktree.useRelativePaths`::
 	Link worktrees using relative paths (when "`true`") or absolute
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index fbf8426cd9..32787eacc3 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -219,7 +219,9 @@ To remove a locked worktree, specify `--force` twice.
 	of creating a new branch from `HEAD`, if there exists a tracking
 	branch in exactly one remote matching the basename of _<path>_,
 	base the new branch on the remote-tracking branch, and mark
-	the remote-tracking branch as "upstream" from the new branch.
+	the remote-tracking branch as "upstream" from the new branch. If
+	there are multiple matches, the command fails. If there is no
+	match, the command falls back to creating a new branch from `HEAD`.
 +
 This can also be set up as the default behaviour by using the
 `worktree.guessRemote` config option.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index c745deddde..07163bf9b7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -783,7 +783,7 @@ static void advise_disambiguating_remotes(const char *path, const char *branch,
 	       branch, path, branch);
 }
 
-static char *dwim_branch(const char *path, char **new_branch)
+static char *dwim_branch(const struct add_opts *opts, const char *path, char **new_branch)
 {
 	int n;
 	int branch_exists;
@@ -801,7 +801,21 @@ static char *dwim_branch(const char *path, char **new_branch)
 	*new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
-		char *remote = unique_tracking_name(*new_branch, &oid, NULL, NULL);
+		char *remote;
+		int num_matches = 0;
+		struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+		remote = unique_tracking_name(*new_branch, &oid, &num_matches,
+					      &matched_remote_names);
+		if (!remote && num_matches > 1) {
+			if (!opts->quiet &&
+			    advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+				advise_disambiguating_remotes(path, *new_branch,
+							      &matched_remote_names);
+			die(_("'%s' matched multiple (%d) remote tracking branches"),
+			    *new_branch, num_matches);
+		}
+		string_list_clear(&matched_remote_names, 0);
 		return remote;
 	}
 	return NULL;
@@ -909,7 +923,7 @@ static int add(int ac, const char **av, const char *prefix,
 		opts.orphan = dwim_orphan(&opts, !!opt_track, 0);
 	} else if (ac < 2) {
 		/* DWIM: Guess branch name from path. */
-		char *s = dwim_branch(path, &new_branch_to_free);
+		char *s = dwim_branch(&opts, path, &new_branch_to_free);
 		if (s)
 			branch = branch_to_free = s;
 		new_branch = new_branch_to_free;
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 5c105cf252..a37137042d 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -669,6 +669,19 @@ test_expect_success 'git worktree add --guess-remote sets up tracking' '
 		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
+
+test_expect_success 'git worktree add --guess-remote fails if there are multiple matches' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git remote add repo_a2 ../repo_a &&
+		git fetch repo_a2 &&
+		test_must_fail git worktree add --guess-remote ../foo 2>actual &&
+		test_grep "matched multiple (2) remote tracking branches" actual
+	)
+'
+
 test_expect_success 'git worktree add --guess-remote sets up tracking (quiet)' '
 	test_when_finished rm -rf repo_a repo_b foo &&
 	setup_remote_repo repo_a repo_b &&
-- 
gitgitgadget
