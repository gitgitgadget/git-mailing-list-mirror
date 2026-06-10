Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC1372EE4
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074625; cv=none; b=jAwP/SXz9d1tmVpGRsng4ldwGw66PkrwmRfeEL5ksLTt9eMf/TZnbpN/0c0YIVblDcWI23vOik1FNnqk6IGAdrEqWRyAsS7t0HSBO7L9QaCjbPYC57uG2EX+BCE2fLLwwDHZd3xaYn6mZelJPWGAlVrnozqhEsS8VJMZrvF9vpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074625; c=relaxed/simple;
	bh=a2hsVmjFUaxtAuy9Uz0SOsUdQwZQ1QrlRLU1YUCyl6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlK0kLm6aas6TT42Rw6Wti0x2QvtAsBGZasWYbqp2hjXyTLzACpCHVKl8Tl2oJa4gp/w4ivax3coVEzwb6sH/rGxYtzKH0zO44g6zJjPn3xUZLY4aKlOz6jZVWf9zirx3Gisf0ZTNB8vLNpHXUkyBd+0gxU6TIeCWjEE/B+FzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YNVNnqjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kI0Rf2hB; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YNVNnqjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kI0Rf2hB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C88E07A0115
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 02:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781074623;
	 x=1781161023; bh=B3MPMRZlGBJIsQD2umrqmC2DgzFzeypUCGfSWCKPsrw=; b=
	YNVNnqjxd3390d+5Y1VyLLhJTQ7Z8FxUq8Yks5v1Es/yMd2MQLjjpKik4IOPIhcB
	GgiHhJ6PmF3BJFewaJd0FQgM3n33Yr+9m1JfOl4zoG0A9W5bTIRyk+ceqo4Rcldi
	bTAcVIx/SitOHl+qwm+jzOzeh6uITn+jWExJK4gzQUfNHTBl85hcfYN1aKpnRLl9
	LWo/zj6hHWYx3L4b5SruOU+jjl8Z2TzAD13hsUTHnURILijBggW4Y40K8DzaZQI2
	mFUVLy6bpdCQCaeF5sXVybTJunfnBUsttdQVOPAFwxdMLfLgwCSrFsCm1fY0tTyg
	biccMFu3KjAc8kW2Dj3tIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781074623; x=
	1781161023; bh=B3MPMRZlGBJIsQD2umrqmC2DgzFzeypUCGfSWCKPsrw=; b=k
	I0Rf2hBJjGZNDGK7q0T2NjS+3DqASBjD/oD8uotwYc39NWyAq6hBNWH3nT58MBGT
	4IVOiZjXlTyJsuDOfy8W0wJN+cxzXjb8gHLAVuGvXUArQ6NAN0iZjE7BR2jTCizY
	ln1JpXwAmJQ70BJ1SOL7aX/umnG/LpH3MFe6Eeu21dUyBhWxB1bLAdU94QiOv+sG
	AdAiEYc6nSWZBRInJgNz+gvMSSfJfQBwmyLyITCWJeVPtx6BGy/lNISdWdXHJEGg
	pB5AZmK/M4EnJSW7Be6cmev1TvEz/3HNJAzhEKOEylh8DpoLEdx/wl7oM8BLZ0Kq
	naltyYlVTuzMxUweResvA==
X-ME-Sender: <xms:vwopannCE-F7U5vGajO9Vx6RSplhnxqNF-tm4hvFGj1iHDm-Vqa5vg>
    <xme:vwopahyYTnIuJU2UZNkMpC_1Soynp8ViVv9cfknp_Uvv4aHmpjNY5HYjPwmgmETAM
    ak435A1bWNGEiiGCQefFuahE2BsYJ31e1wLGvDRwD2uzZB9e7K30Q>
X-ME-Received: <xmr:vwopajRXEkZ2sLDw-uaA-RisYfJdMGn_Rw1KC21mQ9MI8CQeuK_-1YJJlNezKgFgs1RJazl7MjP1igtw7O6dqgG69oWTEybwdk5QYPzYVQ>
X-ME-Proxy-Cause: dmFkZTGuoiHhVxWTZKRZT6EKun2tCJoLJSgrQ5pY3JeKAdZWMQmP/rtNtPmztBLoop8BF4
    Ku0yBHC549cKxvC4lqSxgP2eFLOf89D1KzXy93yK+/Ol56Ad6mbMgZH1i9XzBdZhGvu8iW
    rhtIWPp03f9PoEkUZl+vuihOUge6aM77MChqqJE9I1pluwduw2ddwIBI6G5Lu41lUELGR7
    tscU1AeFOOP5v+XksXc2WtGMmtLXJn2arnrm0HSk+Hmx+PWkOCP4OhQDkP+ogXA3kFXRqz
    R0VHPAKvWDdiPC+JbJGhkJXD5tRbVmo6gPrPyNqn3O3FLfdErbHk5GiPlH7yBdP98zZXgR
    GBq3FdFH4Uhm/izYZQNKsZYOP6DTWxz0oLfTBHRPmIndw+YSx9gWBSemylMY2G/flPjoLD
    oM3O2Szt7KhXnoEtcAbSFBM3wx/3IwqUCwTQDlYBN8CJmqfWPo1/r5XJGIhBfi/zHc5UKk
    oqRxmuSXbIGuvrp4E8omHVcvW755ivqJ6Ob47mVZz/AFF/kbzWK6J3jvT5jJ/1f+RbpVBn
    uSqxy4JqN4mr1xhlm3vSThdm6EZrAOIoDQwZus0zA0n2XuyoQy9SaSEuCXgm+ldxhC+lOQ
    6BBLGgwRGtdnrjp6XQOyWhT9rshTsDQ1gNuMGdcbXBBlqaPuHN9j1vHpuV/g
X-ME-Proxy: <xmx:vwopaktajTQeivsX1_k6RknDQTMDQhYLp3XGTtcA6OT2e0pC5oYQ6g>
    <xmx:vwopalvJl0fVxI3sC7uGHGo9u97VOhEij_aPbmNJn6LpIxf6GvpyVQ>
    <xmx:vwopaqxqFyZkc03vbiIhLVppXJ6QPUEgTE4miSKjevx2YkAPrEUo2w>
    <xmx:vwoparj8Xc_rOOuStF2QezP305eyErm0NjPdpdaGpOjPRQsj_QSaLg>
    <xmx:vwopan3SiN5S6K2LloMjHGUf4NU53v1ePSHHwaBSAKD48Gi6gqpEeoyj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 10 Jun 2026 02:57:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf53d699 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 10 Jun 2026 06:57:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 08:56:48 +0200
Subject: [PATCH 3/7] setup: remove global `git_work_tree_cfg` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-setup-drop-global-state-v1-3-5dff3eec8f06@pks.im>
References: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
In-Reply-To: <20260610-b4-pks-setup-drop-global-state-v1-0-5dff3eec8f06@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The global `git_work_tree_cfg` variable used to be modified by both
"setup.c" and by "builtin/init-db.c". We have refactored the latter user
to not use that variable at all anymore in a preceding commit, which
makes "setup.c" the only remaining user.

Even for "setup.c" it is unnecessary though, as we only ever set it to
the value we have stored in the discovered repository format. The
consequence is that we only ever set it in case we already have it set
to the same value in our discovered repository format, which makes it
redundant.

Refactor the code so that we instead use the worktree configuration as
discovered via the repository format. Drop the global variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/setup.c b/setup.c
index 52228b42a1..71fc6b33da 100644
--- a/setup.c
+++ b/setup.c
@@ -31,9 +31,6 @@ enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_ALL,
 };
 
-/* This is set by setup_git_directory_gently() and/or git_default_config() */
-static char *git_work_tree_cfg;
-
 static struct startup_info the_startup_info;
 struct startup_info *startup_info = &the_startup_info;
 const char *tmp_original_cwd;
@@ -799,13 +796,10 @@ static int check_repository_format_gently(const char *gitdir,
 	}
 
 	if (!has_common) {
-		if (candidate->is_bare != -1) {
+		if (candidate->is_bare != -1)
 			is_bare_repository_cfg = candidate->is_bare;
-		}
-		if (candidate->work_tree) {
-			free(git_work_tree_cfg);
-			git_work_tree_cfg = xstrdup(candidate->work_tree);
-		}
+	} else {
+		FREE_AND_NULL(candidate->work_tree);
 	}
 
 	return 0;
@@ -1145,7 +1139,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	if (work_tree_env)
 		set_git_work_tree(repo, work_tree_env);
 	else if (is_bare_repository_cfg > 0) {
-		if (git_work_tree_cfg) {
+		if (repo_fmt->work_tree) {
 			/* #22.2, #30 */
 			warning("core.bare and core.worktree do not make sense");
 			repo->worktree_config_is_bogus = true;
@@ -1156,15 +1150,15 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		free(gitfile);
 		return NULL;
 	}
-	else if (git_work_tree_cfg) { /* #6, #14 */
-		if (is_absolute_path(git_work_tree_cfg))
-			set_git_work_tree(repo, git_work_tree_cfg);
+	else if (repo_fmt->work_tree) { /* #6, #14 */
+		if (is_absolute_path(repo_fmt->work_tree))
+			set_git_work_tree(repo, repo_fmt->work_tree);
 		else {
 			char *core_worktree;
 			if (chdir(gitdirenv))
 				die_errno(_("cannot chdir to '%s'"), gitdirenv);
-			if (chdir(git_work_tree_cfg))
-				die_errno(_("cannot chdir to '%s'"), git_work_tree_cfg);
+			if (chdir(repo_fmt->work_tree))
+				die_errno(_("cannot chdir to '%s'"), repo_fmt->work_tree);
 			core_worktree = xgetcwd();
 			if (chdir(cwd->buf))
 				die_errno(_("cannot come back to cwd"));
@@ -1217,7 +1211,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 		return NULL;
 
 	/* --work-tree is set without --git-dir; use discovered one */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || repo_fmt->work_tree) {
 		char *to_free = NULL;
 		const char *ret;
 
@@ -1267,7 +1261,7 @@ static const char *setup_bare_git_dir(struct repository *repo,
 	setenv(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, "0", 1);
 
 	/* --work-tree is set without --git-dir; use discovered one */
-	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || repo_fmt->work_tree) {
 		static const char *gitdir;
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);

-- 
2.54.0.1189.g8c84645362.dirty

