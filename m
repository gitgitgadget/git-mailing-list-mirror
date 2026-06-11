Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23373644DB
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160293; cv=none; b=NAdtF8d4Er0UeZaGgHZ2BE3YYwk/U2SvWbadXrD7NnB4EbX0rN2+aFsoMhk8UhBImq6FpgkmLZ+n+MUmbrtxWkutDEBJws/MpLQUSwQ5ODIb6naFx6hxudkhP2YZE0Udo+11fPsBUlVfYGU+2gADf11WwXLZd1pFj0wM9H3c24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160293; c=relaxed/simple;
	bh=UNlSG75y363a5InmT0NOl5Kgha4u3nM/8x02gL9yPYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=is2BUDvq6uwMvIj2j1kdNSBI44Si8pBlmIq4po04hLLChmGy6YeY52PvdWBxI5TNOVNgQwSjoXWdggh61T6oZdDQF6S6TQvT1ayVgsBzDYR3Wa7Xsf0j/DUI7/Q2GJgu2AJxuN4IlJEwU0GwBWbHyagSbaL3YA6g9/8xl+sqhfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rOf3QSsq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4QNXMqu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rOf3QSsq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4QNXMqu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 047231D00110;
	Thu, 11 Jun 2026 02:44:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 02:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781160291;
	 x=1781246691; bh=oa3kwXe0uUAQErv5xnK+EiGjha/CbuknGbAPVewxYZU=; b=
	rOf3QSsqOIc8QEqF3W8Bi68mRo0nUC+DPJ9Jabyj0uYdFpq0HQE4ueLBeur2Izvt
	F71iVpG0Q6UhY2X+GAXxQeQCoWNSOTMyDgqKOxTslM890IzmLq966G8C2fF/LhvU
	i8x24vQyKl9pQ20+ttUrJI0pfp2PJibazx14Qw4C6AfkIdlWouXTZg8zk8DtgLL9
	kHfaDsgNoc0LpeDisNIxbxziwullkaOmP703QoLAEXmXcdTjA2zdRyQazyZx/3cP
	eSwN2UABiP+MGFZxJJ8fi3DSooispqXQB8x4gbbT48J/qeNuuaEJm4ZAo6srPCqB
	pTp4CLQSm/PRCXd87Pdr3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781160291; x=
	1781246691; bh=oa3kwXe0uUAQErv5xnK+EiGjha/CbuknGbAPVewxYZU=; b=C
	4QNXMquHgPgX0UlVZ8Yi32QD74S7Ymf3uSDksifF/aIM4JyTHSW51W+2JCDQW1y1
	Mc6QNRd8aEI7atOw7vC229tYxaqyng5abUsjP/5RJLuWPNvUIqixWoWi9qsZLANp
	EHwArXZl/ja1OZAFY9hIJSnCZdExllQ4cwnnkkooORobSYUiSjDMAJFSqpm/ydvd
	qKk9yhyBvbkRww5o15qnJTmndYnfiuYrCXiCoO8KHX/QCk2ZTVP8hV7/qxnEckwm
	GdpJCPOljpuH9Uua+wVtI4rxxK2iOebCNCEAgSDwrpT45PrGUDOPQo0brRIm6LwJ
	gJ+IH0gwyIk1hrXLzRlIQ==
X-ME-Sender: <xms:Y1kqapsmy0OKebHGf4RHKG5YiofrMwAsuRU7oFprjgH9o7iHgZcqLw>
    <xme:Y1kqaodRpju81olUR4Gs2cwfBH0oZhLhWs-P98nz3ZS4syRh3Uw6Avz2GgGRt9BgN
    1IDiphnTstjvgnoZJCE8EgeDUFU4Kd4fqiM3VkatmvQIUxeBdz2Qw>
X-ME-Received: <xmr:Y1kqaqb2zEEqducHmJx86xpr1UC859x4kfkjYQxg9y7Y86OPEFAhpOt3usHbHtsQlMIBb0rJqZzfptSZblykNj4lPsHOkVUbioRYGeeOCZlK>
X-ME-Proxy-Cause: dmFkZTFCyXCD6OjKtcsXuWUj1sAwMVK/fG6NosXZlI3sudgmNyYqAeR9UQNuHFYqeGwr8l
    MyWCUoqkM2JdySlbFv88VWNSdrPdVDSe0MJgKUHYRY9oPpYHvOFKzG/TVcAWnQnW5Rzqo3
    1nnLUU7uPmuOuN+xrA3VgVRZyuunO21GDK/0/A16BQmKHZgaP8oBrB8vNx1q2kOPepV+S6
    xjI+sdRVQ2IQbxC4O1vIeGvt3nKJAJ2rzrFO62MaBlI8YtHDFgqsA8YSRinnb1rMUhV52X
    4Ov2R3Dw9BtV8XFmsdQJeHSf0zI2fVj4naBVJSze9XJ0cHk1tYqhXuFqMsTx50nUN31/Qn
    ERAfDp4sOUJoYvea84M4wR3UDPWLZg2BEjCUMJYM11skevrcQWmAdovwIq9+QALNzgtj4c
    snf0BEMcmuGe6FCWvURwdmtwXiTDjkAjJF4yjbR/w1AJbOEtFW3e+WilHcZbldaRdWOIPY
    kmHp/1P1+ZGy5JK5SGd/SkLv9QufH7Ds3oui1ozLQ+dPwC6g9/OKHmDTE/J1iWn474Yle7
    QKJaXmNwM9WZweL1KZ4u5HgNg3ZtOoU+2saBWzZGkzChiEJMiIU/4G2ZI53XQhPztCFqfT
    RPYx/A0igPK3hPSEQQ+3pv7bhG5KB7ruAwqpLNpx/5ShnFnZz1X+j3p+0t3w
X-ME-Proxy: <xmx:Y1kqarVxwKZjWV1gnCx4_6FZqapC1bFtZkQTn492wi6u2o10Wwbq3g>
    <xmx:Y1kqasiFu5iBk2C76O4oCd1xp3ukEJzI6BnXE9wDPa8LvwEFNIC3BA>
    <xmx:Y1kqapWRAeSxgzoBtCCw27PiAbuZKSWhsmBvSTigCdw-eZSqIV8m5A>
    <xmx:Y1kqajONZ8QJwmXWZS9hpmJVGv6ZXhZpJjk-wtbg9XB90_v-M4ue7w>
    <xmx:Y1kqaste6nxEEvkSGuTEzK05r4DG54g4EC7eW4ZqVVL4VlQzPhHBgftz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 02:44:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2b90259 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 06:44:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 08:44:41 +0200
Subject: [PATCH v2 3/7] setup: remove global `git_work_tree_cfg` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-setup-drop-global-state-v2-3-a6f7269c841d@pks.im>
References: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
In-Reply-To: <20260611-b4-pks-setup-drop-global-state-v2-0-a6f7269c841d@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
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

Note that in `check_repository_format_gently()` we now have to free the
candidate work tree variable. This change is required to retain previous
semantics: before we essentially had an implicit `else` branch where we
set `git_work_tree_cfg = NULL`, but we were able to elide that branch
because we already knew that it would be `NULL` anyway. Now that we use
the candidate work tree directly to populate the repository's work tree
though we have to clear it to retain those semantics.

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

