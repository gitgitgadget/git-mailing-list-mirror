Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCB3D47B2
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691887; cv=none; b=hda/XO5T6g3nExpi/Of5xV7OOINN6ncBBvTj9V1bD2l6wf2LVDFI1QIgpnrKYVoFRArkSgTncHxWJdMz5reM32E8A08BV4SN1Wg96ZCjF6AaEa7BFXuzXOlsQYcJ1Y5ZDU7nm/3XJK3ExlArgxHaZ/pmH2BdKaJndMd5MY84VNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691887; c=relaxed/simple;
	bh=YoFdl0+xJeLYWA8WGjysQsQUa76pfTy+Il1frhF0HPs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BlnBuKXZtxMk81qolJRd3jEqTjXvx49QlpWElfmlGc/gywi+BzWZngGQ8IW8erOIj5OxNTTYACBH6Kp/5mKYO576WyNX3O6ATXQ9ynvRXbX6yIqocTp1VRwuv3Z5pvR6fh9T9VBF0j3DqlmkIt3bhrWZGaY0eq9ben6BsaO1u7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai10Nvni; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai10Nvni"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-45837e52d8aso378381fac.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787691884; x=1788296684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2prjvmCA/0jrs1yAhSlWb24Nrr9WcWBqJwlz9UKcQs=;
        b=ai10NvniuPp8DdNwMnqtf2Kalx254oWK6ihiTquUKbZSMgPuBWbwHz2Zbbb5t2JA/h
         ocM9RksdnePm0+sBhGtKkbKl4AI5VRzmpnt6FaaLULVo+A1iCgV0stBSnevVOrRKa6p5
         a8GT0FrZWhWl+XhPMlKNeHZRxUzePncRGjbf74ByKUtj9CWFv/g/FyTN9PGI32xSW26A
         4enD9vYKoXuodz7izQ97jZU5GFfiKABB+puWZSRvt+y4tOuNtHkTC7K5iF6CJSGp6ZKw
         kS2mp/fwQgkMK1jb9n3fo1Drk/F+RUvn5dvbdBKGqOvJL+qn8TphDLStgfIQol+Kay8F
         YWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691884; x=1788296684;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2prjvmCA/0jrs1yAhSlWb24Nrr9WcWBqJwlz9UKcQs=;
        b=Rrb7J3dhiRV06Z2FOHSqeIprMkmz9vz7q7C23iDqQDbI5OmUqtrdGMa/Y3+nI0gpyU
         3tlftvZPHK8MLls8G05iiNTInE9LFeLCLjYDA3o/o/gLSMStyPItVwvdRlf+ydswpRZY
         WNJnomKAHQD85HdFmICQgxoXyf4FtlLZBHCrcL3OXGcJe3RT0DNPCGIwExfySLyTfKxk
         OcdfGZkeTNMJN9wda+Prc9+xNtJR5Csbse/VjJTuGXsiB4lbZcU+8qYkk64AVGoSFpuu
         CjnAEO4nsX3xFhywZa+u/G7k5g8+By7U1Z6Hu3jbMEn8ON1Ls+VbblxqsrFUvUH7zIzb
         l8mw==
X-Gm-Message-State: AFuF++k43OT6Mn8GglbW1vUCbTsPczPlec1VVsn79I0oUq+VGo7Vr1ax
	UnvzYb4TVXp1eHiBP6G5qQvIhxAEvR3UKxnRTb3lg1Jhew/bYh5p2hzWVHQpJg==
X-Gm-Gg: AR+sD13yLrJTLPJjf5MtQjtQ8o3LzW2R9jXE9PVhk4wDmSLE7CZA1gBcv+8D92W/OZQ
	BMNfOqLHwC4T/5BIUjqcycblDna/tHfy98HmR8lnjHYyBVzEDCHznSg1GWXWddQ698GtppXIS5M
	aCNAIb/JsZlLQtRX4lGtqotcEvRHrelLPQ9rVVlNhkaJ6mVcfXiCR1dNTAvztZ7Vc6XqmZn3IHa
	lZ0efsFdNxcxHOV67mX9h1DjmFWKPO3+ygSx5XZ6nxZO2Fvc8Bw0oydZiEVvEcuVl5mCHlp4tTN
	5QbRsaMQPaEMtHY2Ew+QYDU0QSFPIQ0VnawepOsc/+v2vMz/d7GZiJk/e6UunW10O1Y7lwKIWhg
	D5GAIsKNZfP7/TieqEQ1GbzWLIszoLcYKYfFFGbsEbSY8rXq/llhwd3mNeKKuuQcp8j71E+x6zM
	74WyEq5r55DZeTHgX2OoY7ioHwdnK3mc255+kdBFGlAjA3hEIDL2vxvHEpWROvnZCJBpGPS7SNb
	tWj
X-Received: by 2002:a05:6871:2b04:b0:456:4cd1:646b with SMTP id 586e51a60fabf-46599a1f054mr2569583fac.11.1787691884332;
        Tue, 25 Aug 2026 14:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.165.178])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-465ade707ecsm465626fac.5.2026.08.25.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:04:43 -0700 (PDT)
Message-Id: <927856e0a07cf6d9e7e1093a4fbf979584141224.1787691875.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v8.git.1787691875.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 21:04:35 +0000
Subject: [PATCH v8 4/4] worktree add: treat multiple matches with
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
 Documentation/config/worktree.adoc |  5 +--
 Documentation/git-worktree.adoc    |  4 ++-
 builtin/worktree.c                 | 58 ++++++++++++++++++------------
 t/t2400-worktree-add.sh            | 13 +++++++
 4 files changed, 55 insertions(+), 25 deletions(-)

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
index 320b18873d..07163bf9b7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -764,7 +764,26 @@ static int dwim_orphan(const struct add_opts *opts, int opt_track, int remote)
 	return 1;
 }
 
-static char *dwim_branch(const char *path, char **new_branch)
+static void advise_disambiguating_remotes(const char *path, const char *branch,
+					  const struct string_list *matched_remote_names)
+{
+	struct string_list_item *item;
+
+	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
+		 "<remote>, you can do so by:\n"
+		 "\n"
+		 "    git worktree add -b %s %s <remote>/%s\n"
+		 "\n"
+		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
+		 "consider setting checkout.defaultRemote=origin in your config."),
+	       branch, path, branch);
+}
+
+static char *dwim_branch(const struct add_opts *opts, const char *path, char **new_branch)
 {
 	int n;
 	int branch_exists;
@@ -782,31 +801,26 @@ static char *dwim_branch(const char *path, char **new_branch)
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
 }
 
-static void advise_disambiguating_remotes(const char *path, const char *branch,
-					  const struct string_list *matched_remote_names)
-{
-	struct string_list_item *item;
-
-	advise(_("Branch name '%s' appears in multiple remotes:"), branch);
-	for_each_string_list_item(item, matched_remote_names) {
-		advise(_("  %s"), item->string);
-	}
-	advise(_("If you meant to create a worktree from a remote tracking branch on\n"
-		 "<remote>, you can do so by:\n"
-		 "\n"
-		 "    git worktree add -b %s %s <remote>/%s\n"
-		 "\n"
-		 "If you'd like to always prefer some remote, e.g. 'origin',\n"
-		 "consider setting checkout.defaultRemote=origin in your config."),
-	       branch, path, branch);
-}
-
 static int add(int ac, const char **av, const char *prefix,
 	       struct repository *repo UNUSED)
 {
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
