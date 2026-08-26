Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829863DAAA0
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741134; cv=none; b=BxFSK58akdTFbuiBfHSt2w3WPY67x6CyIkUbUat7RkpAQrBF1mdzO8mon3zP7c9rcJ8ayHAXIxRt6RwhSDYjQaTqKQzmbY0KUUA9g46pqvSzcvhdWU74PW8/a1gXisUp4dLWj/SM80/1+LCn/OkqzS9pFaodjegrZaR64dCywm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741134; c=relaxed/simple;
	bh=5P5HwovBzB824qtal9Oy8kV4jgptR4lDi9AP7mtGnKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iOrFakImRW1kC0kLozqw64Gn3Xy22ouaA33Tjuz+28fHxuMWY79iQd2o2jA/OMGdiQrp4+l4t42z8HOXrz/tD60Zr73CHzTHEJhbjySkgvCmxA3Cf5cYl5mHpQnXVnc0KSYl39RaWogiiVvxFvboykQ7gmCf/irb6BIvXmPFboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3ANNQNq; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3ANNQNq"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7f3faf2b081so895580a34.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787741123; x=1788345923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pgPOLThxsyUvFkp7Uko/wm2Bra7A6zsnyci9hWVHhIM=;
        b=N3ANNQNqDSQyXhoh7aoeYP75k70kEeqz+yJr2/uHTUKsUKQGEXXcM23fBe8T9Wg2RK
         kSeNt47UqYg3m0a0bZqtYQtWG+6rfXceeA/RIh6+oCS6rmIacMhcPJrodVvYn/jsCOBp
         tUEZczaenhwoEJaYOMSBVEyFMsOlf6qoT7S2C60JRFyJhbo3i5iZP9SSnHBfi14Z7D+1
         aQ58wHCHBvr5+s0UJ9DxT58zBLiHKKchQ9v7A8SIH0Bh67Tz69cNLbTI2ClwynrsWi/k
         pZImVeD9hore+5R4cLeaRYhWrlJfqXaVms5s55d/xJGEwmnuoN+pt0Gp7NPauDsh/r9a
         H7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741123; x=1788345923;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgPOLThxsyUvFkp7Uko/wm2Bra7A6zsnyci9hWVHhIM=;
        b=foyMHyGfIQslH+/8fgnmVqkG8ose/BtZSfPJG0NfTvyaGBmPumVzhaeQoGpK6ynw8a
         c0GBTY+paZ6hLm1x+d2cBSfLxiwvcPmb5Zm1UdUK0/tV8sTkcyNnHhAwh3yTKGWnIguP
         oyrPJjA8mpvqtVgaN327oMATQtNmceZJNnVupNOkUQ2JL/HPd5XYfMVyB4j5POKKExk6
         4+l6Ez+Ib3G1RuwEAtm0DFTqdzTS1VzdFPTMy1v+TyvIVHQ1hSVdLJQTgiBcA2bz/Aa7
         DniXqt0UAB0j/IzEwOyLmdmYz5XWLFJs0SQAq+NdiA7+6c4at/Zjc5LfXD8Q+JXMJIhe
         sbMw==
X-Gm-Message-State: AFuF++k5u38MB/YylSqEb5PS3jKly6YbgwrBQQOB/dv82jZ5iwvGPrDa
	gzvhlpor3ggpOzr/Sl9Zlke8CgCkZEviYYmtgiURyJoYedxQM28i+puSxTh2tA6D
X-Gm-Gg: AR+sD13wEKSVSMYzh9pYB4F9p/um4x2g9kygZd6TX/t0qqrF6WHREuGiocID/dcCJWZ
	DYn3bAIiRIs2GpTwT5xCX0SgsKyAdHibSDp2CWcyDkC+n8PzYRj6jym1+kCsD/Iem8yDeJPNyEi
	6Jp4L52+QY7xXxpLP/UNyVjcA2mm0mup3sIRwzIoCKFHj3JE7dQIlHCSjB9Y3VVfOESxQyiljxJ
	H2ibu2e4aOWiB3QJqulU7Ahxj9jJex2TCZmcr6Wy0TxFMdYP/QXq/MyOzmYo8yuNiX2A85sXO9J
	DFEnrd1ME7/Y/KAby8mDQsu6PKCnLVCrPP0X4CsUHVTxZT75v/AkX6hVQ6cFfOjW1Hqa+Ye6iyF
	YxVYB3bPuobtLsw8z7pl3wIZLPOW+BBkIhvBq6fuj1C/1tgHO4m339QzPbFyDEkqJ7P2cj0jc/B
	FAOmyUJ7twZFMdRPxY+QpmplE9VIUc/Gliifgv6O1/W/mQy+UqHJpxIl5rV5oGotM=
X-Received: by 2002:a05:6830:2696:b0:7eb:d848:c856 with SMTP id 46e09a7af769-7f4c50a23ebmr5601024a34.4.1787741123390;
        Wed, 26 Aug 2026 03:45:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.19.227])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c83d09d1sm1336489a34.14.2026.08.26.03.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:45:22 -0700 (PDT)
Message-Id: <edb88b658a748e812a6fe2850b8a0f92ffcbb629.1787741111.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v9.git.1787741111.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 10:45:10 +0000
Subject: [PATCH v9 4/4] worktree add: treat multiple matches with
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
