Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A830CDBA
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340175; cv=pass; b=k9aQziz6m3vVkbobEMfvDOcQd1BB6bqYtuiBxAaeI2946l2kX3a71xz0ctLodG7Y5xKdMoEfaaDnBOKvsuKymMz9+r4lmlr1toUHDJc7FSsEaYH/L2h+hn0PLPbFud+jhpoFNodhPsFT/kq8m+H/FUQwRl7ypuL/7dGXUVsYMlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340175; c=relaxed/simple;
	bh=G9yTS/JyGDY9/2XvXMlt2L0I8VxcKtckXWVDy4vkAB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0oWERdb2slPPtW++mvFvo+8/pi4PjeuDPHU4uWU1SHYbSH1CQW/Q4F5H8XpUCInH9NY2nz9npCESja4JSerEO8IetO9PsypL/uM5LhKZs88FtmRsc0OtkXS+H0fzolCX2h62/C7S6uW7rHtBfc3ST69H5aKzCy8BaNekU11M+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=f31wUTrL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="f31wUTrL"
ARC-Seal: i=1; a=rsa-sha256; t=1757340152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UxK9mT+Et5lgkYYEL+21D8h+sHoF95E9wAGfULQcqruzEUL5gd2ydyMbUa8SF/0hzueHHL52Ni8mB+xH+LbYFBdhWqruwwTvGPOYkpgHKZELG9FWzy2slv/N1hJ/hJ/ZxEwLIMNZAoJ7aPrpwmTJQPfowjY0YgFX/bJsM1lRp2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757340152; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kX+mBdVj/0+EjTSfaCI/u90NzNkU6vJRY40PuST9+Ig=; 
	b=BnKgCD//fxuM03R8N4V9Siupeo67Pvl8GCBWnNRwd4xNvvEqt/zFrh+e/le80wlka61LsuOFV+JxMzSzJEhSQVG+GFL7LbDiNBBRJKEaIo+EhZ7CKotTS+nUW226OLVE5UKbHDsOhNDXWWXNIJD1/C8NRj9kYwPPAkeK7mjgGh8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757340152;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kX+mBdVj/0+EjTSfaCI/u90NzNkU6vJRY40PuST9+Ig=;
	b=f31wUTrL3bx67eJNVBxaV0hqA4rO+FrO9IG6IMlDW/f1dDZdhTo1uSf90Y7SaNID
	WdQWA2oDJDEe+E9iu3YcU9Zd3loV/3OQU47GxOEbNAOFByy4g0iCvDoKP5QCdjQ1mak
	rIRWLduuzxiTJtfosD1B+SbAoPFbjVcsZJbYoM5c=
Received: by mx.zohomail.com with SMTPS id 1757340147353379.6569607675377;
	Mon, 8 Sep 2025 07:02:27 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 08/10] submodule: remove validate_submodule_git_dir()
Date: Mon,  8 Sep 2025 17:01:15 +0300
Message-ID: <20250908140117.262205-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.GIT
In-Reply-To: <20250908140117.262205-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20250908140117.262205-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The validate_submodule_git_dir test is not very useful anymore, after
submodule names are encoded to resolve gitdir path conflicts.

In other words, the purpouse of gitdir path encoding is precisely to
avoid such conflicts as this function tries to also prevent.

The first test from the function can be kept though, because it just
verifies invariants which should always be true and raise a BUG if:

  - no "/" separator is between dirs/names.
  - len(full_gitdir) < len(name).
  - name does not match the gitdir path suffix.

Thus we move the invariant checks to submodule_name_to_gitdir() and
clean up the rest of validate_submodule_git_dir() and its uses.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c | 21 -----------
 submodule.c                 | 74 ++++---------------------------------
 submodule.h                 |  5 ---
 3 files changed, 7 insertions(+), 93 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 564f7aadf8..8af7062ff2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1725,10 +1725,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
 						    clone_data->path);
 
-	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), sm_gitdir);
-
 	if (!file_exists(sm_gitdir)) {
 		if (clone_data->require_init && !stat(clone_data_path, &st) &&
 		    !is_empty_dir(clone_data_path))
@@ -1802,23 +1798,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		free(path);
 	}
 
-	/*
-	 * We already performed this check at the beginning of this function,
-	 * before cloning the objects. This tries to detect racy behavior e.g.
-	 * in parallel clones, where another process could easily have made the
-	 * gitdir nested _after_ it was created.
-	 *
-	 * To prevent further harm coming from this unintentionally-nested
-	 * gitdir, let's disable it by deleting the `HEAD` file.
-	 */
-	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0) {
-		char *head = xstrfmt("%s/HEAD", sm_gitdir);
-		unlink(head);
-		free(head);
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), sm_gitdir);
-	}
-
 	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
 
 	p = repo_submodule_path(the_repository, clone_data_path, "config");
diff --git a/submodule.c b/submodule.c
index 016509806e..dbe1a7b091 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2163,27 +2163,10 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			if (!submodule_uses_gitfile(path))
 				absorb_git_dir_into_superproject(path,
 								 super_prefix);
-			else {
-				char *dotgit = xstrfmt("%s/.git", path);
-				char *git_dir = xstrdup(read_gitfile(dotgit));
-
-				free(dotgit);
-				if (validate_submodule_git_dir(git_dir,
-							       sub->name) < 0)
-					die(_("refusing to create/use '%s' in "
-					      "another submodule's git dir"),
-					    git_dir);
-				free(git_dir);
-			}
 		} else {
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
 						 sub->name);
-			if (validate_submodule_git_dir(gitdir.buf,
-						       sub->name) < 0)
-				die(_("refusing to create/use '%s' in another "
-				      "submodule's git dir"),
-				    gitdir.buf);
 			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
 			strbuf_release(&gitdir);
 
@@ -2263,52 +2246,6 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	return ret;
 }
 
-int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
-{
-	size_t len = strlen(git_dir), suffix_len = strlen(submodule_name);
-	char *p;
-	int ret = 0;
-
-	if (len <= suffix_len || (p = git_dir + len - suffix_len)[-1] != '/' ||
-	    strcmp(p, submodule_name))
-		/*
-		 * TODO: revisit and cleanup this test short-circuit, because
-		 * submodules with encoded names are expected to take this path.
-		 * Likely just move the invariants to submodule_name_to_gitdir()
-		 * and delete this entire function in a future commit.
-		 */
-		return 0;
-
-	/*
-	 * We prevent the contents of sibling submodules' git directories to
-	 * clash.
-	 *
-	 * Example: having a submodule named `hippo` and another one named
-	 * `hippo/hooks` would result in the git directories
-	 * `.git/submodules/hippo/` and `.git/submodules/hippo/hooks/`, respectively,
-	 * but the latter directory is already designated to contain the hooks
-	 * of the former.
-	 */
-	for (; *p; p++) {
-		if (is_dir_sep(*p)) {
-			char c = *p;
-
-			*p = '\0';
-			if (is_git_directory(git_dir))
-				ret = -1;
-			*p = c;
-
-			if (ret < 0)
-				return error(_("submodule git dir '%s' is "
-					       "inside git dir '%.*s'"),
-					     git_dir,
-					     (int)(p - git_dir), git_dir);
-		}
-	}
-
-	return 0;
-}
-
 int validate_submodule_path(const char *path)
 {
 	char *p = xstrdup(path);
@@ -2367,9 +2304,6 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 		die(_("could not lookup name for submodule '%s'"), path);
 
 	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
-	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
-		die(_("refusing to move '%s' into an existing git dir"),
-		    real_old_git_dir);
 	if (safe_create_leading_directories_const(the_repository, new_gitdir.buf) < 0)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
@@ -2611,7 +2545,7 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 {
 	struct strbuf encoded_sub_name = STRBUF_INIT, tmp = STRBUF_INIT;
 	size_t base_len, encoded_len;
-	char *gitdir_path, *key;
+	char *gitdir_path, *key, *p;
 	long name_max;
 
 	/* Allow config override. */
@@ -2655,5 +2589,11 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 		die(_("encoded submodule name '%s' is too long (%"PRIuMAX" bytes, limit %"PRIuMAX")"),
 		    encoded_sub_name.buf, (uintmax_t)encoded_len, (uintmax_t)name_max);
 
+	/* Trigger a BUG if these invariants do not hold */
+	p = buf->buf + buf->len - encoded_len;
+	if (buf->len <= encoded_len || p[-1] != '/' || strcmp(p, encoded_sub_name.buf))
+		BUG("encoded submodule name '%s' is not a suffix of git dir '%s'",
+		    encoded_sub_name.buf, buf->buf);
+
 	strbuf_release(&encoded_sub_name);
 }
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..0b7692bc20 100644
--- a/submodule.h
+++ b/submodule.h
@@ -137,11 +137,6 @@ int submodule_to_gitdir(struct repository *repo,
 void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 			      const char *submodule_name);
 
-/*
- * Make sure that no submodule's git dir is nested in a sibling submodule's.
- */
-int validate_submodule_git_dir(char *git_dir, const char *submodule_name);
-
 /*
  * Make sure that the given submodule path does not follow symlinks.
  */
-- 
2.51.GIT

