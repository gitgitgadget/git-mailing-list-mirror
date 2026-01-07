Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA722C1593
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826978; cv=pass; b=K1qz3XEhFkYB0i9LU5sBznryK7FuGc9emEqbryBJLg3G+s2z/sWYeA3YKbmv2MnwTBybsh8wWUr4tk/N7ypFCHCL1UtI10xZTROPrd7pHwXWojIZIX9p6+uoBceWpPyKF/BhJVxS5Vu49D+6AgGL8vstszTPbWQeb4VgGFFfNdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826978; c=relaxed/simple;
	bh=ejE1ZbQbaPmYYif1hYYQDc8CJR9stC6AOJ96O5noUtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/mgl/7tiREWiG3bYTh8fbSLNydmLcUhD8mKrQT/Hxumtr1qP2BuCudsfOnJ6Fr38KIEUYEmNSyFFZJYb4q6LhR4MAiVLBSiya6gGyQQ/wTk7MVegHjnCq7NYIUkOtHPu/kGX7NdYynNk9EAq5OPa+dFRh5MaXqQXsmzwcMsYpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YiID/v4C; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YiID/v4C"
ARC-Seal: i=1; a=rsa-sha256; t=1767826962; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CkUW5D0ng+0w5d2W1Hy7zzFtAtblBSsYWyGs/I8pkh+3JEOfk8uO1Pk4R7UUVmzb6RZq9NPD5JKKSjfPhPYBzb0YjNPlvOAU1u0P3VwVXZZjCajU93rVNWO6azaIUwqBZ0Vfb1qkahrZ71eWMD/uQK3ygt+iuFM4sBeR4CR04qk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767826962; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QCOJ5AGyT4yKf8b5wzKxTcePx8/c0WPr1iXuuJ0VYns=; 
	b=ZPQsACsKSjq8HF5TeWBlii1dCt4Zqy9r+tcZgbbs9lhZMlXWyeP3duWdKTcDZfbpIO8EY7v9NACg56Nq6vuhkxM5Y00qN/9TPhpIm5TYFWTbvbyi+fePatnVVZWRhPUu6BHc6qSx4WKR/QZg1JDt5jcze8z4hmxiDOoCucgKm8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767826962;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QCOJ5AGyT4yKf8b5wzKxTcePx8/c0WPr1iXuuJ0VYns=;
	b=YiID/v4CtndQ4ulLjA+/x9DD14b/ODBn3CoyIqOBJ516LvCM+T7MzXBAA4D5qepA
	zkM5IMZg+srTvtBZ6NwUboFaibN6iV16CRbtf6Cs5eUm+C5wK232n/SkpTX+7qzUzTh
	wN9SLNAuAbdwAV/Ea5+MFDkZ91+z90RFMG7o4qBA=
Received: by mx.zohomail.com with SMTPS id 1767826961529575.8136012766864;
	Wed, 7 Jan 2026 15:02:41 -0800 (PST)
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
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 02/11] submodule: always validate gitdirs inside submodule_name_to_gitdir
Date: Thu,  8 Jan 2026 01:01:36 +0200
Message-ID: <20260107230145.517562-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Move the ad-hoc validation checks sprinkled across the source tree,
after calling submodule_name_to_gitdir() into the function proper,
which now always validates the gitdir before returning it.

This simplifies the API and helps to:
1. Avoid redundant validation calls after submodule_name_to_gitdir().
2. Avoid the risk of callers forgetting to validate.
3. Ensure gitdir paths provided by users via configs are always valid
   (config gitdir paths are added in a subsequent commit).

The validation function can still be called as many times as needed
outside submodule_name_to_gitdir(), for example we keep two calls
which are still required, to avoid parallel clone races by re-running
the validation in builtin/submodule-helper.c.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/submodule--helper.c |  4 ----
 submodule.c                 | 12 ++++--------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6686714e56..aff3f9135e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1699,10 +1699,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		clone_data_path = to_free = xstrfmt("%s/%s", repo_get_work_tree(the_repository),
 						    clone_data->path);
 
-	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
-		die(_("refusing to create/use '%s' in another submodule's "
-		      "git dir"), sm_gitdir);
-
 	if (!file_exists(sm_gitdir)) {
 		if (clone_data->require_init && !stat(clone_data_path, &st) &&
 		    !is_empty_dir(clone_data_path))
diff --git a/submodule.c b/submodule.c
index 40a5c6fb9d..f645372a18 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2166,11 +2166,6 @@ int submodule_move_head(const char *path, const char *super_prefix,
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
 
@@ -2349,9 +2344,6 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 		die(_("could not lookup name for submodule '%s'"), path);
 
 	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
-	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
-		die(_("refusing to move '%s' into an existing git dir"),
-		    real_old_git_dir);
 	if (safe_create_leading_directories_const(the_repository, new_gitdir.buf) < 0)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
@@ -2600,4 +2592,8 @@ void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
 	 */
 	repo_git_path_append(r, buf, "modules/");
 	strbuf_addstr(buf, submodule_name);
+
+	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
+		die(_("refusing to create/use '%s' in another submodule's "
+		      "git dir"), buf->buf);
 }
-- 
2.51.2

