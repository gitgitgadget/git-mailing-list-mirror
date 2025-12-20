Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B842307AF2
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225771; cv=pass; b=Vo/S9k6mqPLyFWckSyCb3CiMUaThC03o91lgOr8iOJAnEEk+rMoOJOx/wSpVmmTlOAyw4bH/g0cNO/zQrfndl5lwBDb7ZCzrDAtaGGWKNVdyN3qq7KQ9DMpxEmoCN0+nHfPLTPUVOknhlqEo9c6yWlf/MdlCTIKifRjMPyyiQT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225771; c=relaxed/simple;
	bh=u5feBEqlEcgvbNz+KJnO80jB3CiMRihm5u3fvy6cCUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMoBxWzVp5LU/RnHugPWGYysR/b3ZOhfUB1KG0+VYtz85s0sU2l8WgrRk0jrSp8MEmIvFArlqTElBmheKXuh+u2EXkcPgHdd640/GY3q+Q9DVw2HxvViGMNFE/ZFai295PzjKiFDCOK5n+mIKkYooUKlQoHQj1+s8UhZeZ1hlE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NIxeORbw; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NIxeORbw"
ARC-Seal: i=1; a=rsa-sha256; t=1766225753; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eHI+F4RB+TvKAli/NqmlJH/5ZbFOKUg5F5TTDLrC0bUOHQzpRgAWQ5wJIdoYGOGhNMPZyXenkOskkLCr0fWyt065uMdUA6z923WLM4jv1UqInGqnsNzbD+E2RKbnG8VsZ7OJugcOjUr7E5zKfyigmr3GaOCaxQpKqWMkNzhalTc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766225753; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=spoBC+T/1BHjti/FhJgnBYjbgSlOzZjhjyTweSQpE28=; 
	b=Bf3UWkHKhQG9GhfU93hL/GHHoXc/LmUcR1ih2dawN3FPo6KwDTGmX9vYR+DqsCFnu7FRsFu0/++nk8MYCPCBMo1hE+JVaSKr314kVlL6y2YSdik/VCQC8zK9qlUouDdl8bz74f1//Yc6G7CP90Hv8iH14sgWg4tN193RSvMKuCU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766225753;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=spoBC+T/1BHjti/FhJgnBYjbgSlOzZjhjyTweSQpE28=;
	b=NIxeORbwWL63x3Gd/4lak8iHzQWNVnD2yvNUxIxrHBGnPGFwte2TfS8KAJZzWpwu
	R3bPW326RCW09lQt/f2t8ReQVpaFVUUA+bAF1hRlg+yXr1zl/x3MGWRfvuG+ZwdGezb
	lukW/yt+TnTIz++E6i2aQ3jgEe1T7T5T8HMl4Ltc=
Received: by mx.zohomail.com with SMTPS id 1766225750744613.8952647431661;
	Sat, 20 Dec 2025 02:15:50 -0800 (PST)
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
Subject: [PATCH v7 02/11] submodule: always validate gitdirs inside submodule_name_to_gitdir
Date: Sat, 20 Dec 2025 12:15:19 +0200
Message-ID: <20251220101528.1227487-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251220101528.1227487-1-adrian.ratiu@collabora.com>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
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
index 13b5e4ed68..f1fc098614 100644
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

