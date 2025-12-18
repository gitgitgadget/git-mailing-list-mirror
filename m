Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D9B330654
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046612; cv=none; b=iCFPTR41a02sN33yxLUiuhtr263YMhDqpU8CYYVKilOsbnxuxYXZcXzMYXOyt8tceJXtFOpqm7uc6ihEqF4yH1HXFNdh7P4dMJWJZ4Fsi7pkPIx4rvAh6qygt0RpzwSBpViiJCK9MtCDtfKHiHMMD9RvPorIUAOCg9jBl6oGmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046612; c=relaxed/simple;
	bh=wrVjjrHQeIfUWg6eFywLkWUp0XHeEx5XIhs7lUbS5yU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uv8XL1MjzDP4jGczKNT3fVziHVB91eYYJkBUOxYTz9tlyYq8DspE3O83y9jKPoteqHE236cPW2FqayNl5bPOyyxlsTRuJCetHI6/Kiq4tyDHzg5Qey05PyE0AgfBISsC9vdn2bt0Q/sRjQJV+iRSthYveuGZugvu95/uqVgtwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOiwDKcY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOiwDKcY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so2106225e9.3
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766046608; x=1766651408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXIjsU+JLF5x3niTqo+Qivzeu6dZlBylJU48Y+wl3QU=;
        b=XOiwDKcYDQj0CqWcor6dBAxK171S1Wxg7C914GL2lvfPCI3AwSrwUyZ+1BVSoiJbNZ
         0c/BpJQSnMSKg5ox0peM17KNzH2kFsBLczPmSjxll2w/XCVy2qiksxdrlzPo/xLo6oH6
         BzrXS0o/JolPrPtlpA4Nrl1aqmE07nz+SWJzcXogOafVwFeo9d4IsUKdg8MEjI/EYomH
         3zLZCSRf7Eg8dqXjYcYRdS3BxPvKCdiu6Q51tPQNaJ2BWh7ur2r8fmngDLayoMixM7OQ
         rSRbLdEqC2EIdv1fy1FgLjT89Ve/CTVZBem5WYNurDXpuUiD8m53Zu4YoEyTUkFruvL7
         gz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766046608; x=1766651408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXIjsU+JLF5x3niTqo+Qivzeu6dZlBylJU48Y+wl3QU=;
        b=AsLkcngoRxesbNdiiZ/vAHKXtkdxUl6STHLW5na2ixjPp3IYjT/1Xng1McQBSbPAul
         4IkKXxlfB49Ow8dp42gKqTKxMZzM0+aZNCKBf+vBVJ+RJCQjWzQAWFuJmj7fDVkKpx6g
         sFT80oJa8MdDUodQsNuUtdyYldh0GKTaxjX7IP5iZRzphJvlZe268LHbrnMRGf/QvSbN
         12JTLGhQhlIOBoCV9mkRpe6b3Ay93zYdBvEV09fCQw5kPeKQDpLpQeiAG7VL3q1tpUOv
         +cCzwOZ893irfAduVONBBgzfhlPVjpSWOJl2ku+BW//DFZegSMGpesPKcnBpacajj2ya
         r1Hg==
X-Gm-Message-State: AOJu0Yy/SsqGG0+6Dprn8z/cwzeGhh2ao3MoHmZ9JY9gbBeOg/Vy8J9M
	j9gxyvyi0dzIWmZ4RdA5xSeuHp6uIcFDGL2cJrGFac2Q4TPAdRPpYG5+
X-Gm-Gg: AY/fxX6u3SRxrEsocxTyzOJjFo8bkkSmhowfRx/Hx/ZykMRz5yrVo8n9PAZiK/AL4ua
	04VOEytU1C93WJ9eJC24ttFtgzxpkuNw0dWsn2XY41LvNdB13uWoK62rY0GHuUaqo2IN4yLqizY
	LeOaMa+sUxICjpbGWq2wcqoYLG/DAxwM7RoaDwI/ZmLiDIE5z0duYFpa+4rkWODwWj9bnRscMBP
	KIN/e9bzLIFqw5VeX23YTRnM71XeBtEh38vm7mLpEIRzAhAK2L/ktBpslJgkJFf8monKicS66wn
	rW+YipFGf24qiVxOnjn5jnqjsVTZyNmKSIXGIpm5EdM4IW3f3KbeEF5b6WxhGrk7pjR/DJR8QgN
	X6b49Bqj0pw9KJx7KSWj0u6EFROzOir3Qsce+GafTb98uZOjiTKP1fGriuWHLvjTersaVpmUyuI
	HzlLI=
X-Google-Smtp-Source: AGHT+IF7qINaXEqqt2blt30Abk/lQyk+X+zxDTysmc3m8ve1SAanmoTTxT0z8LFFP63pTmCuPWtT4w==
X-Received: by 2002:a05:600c:37cf:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-47bd74aec30mr74469085e9.29.1766046607813;
        Thu, 18 Dec 2025 00:30:07 -0800 (PST)
Received: from ubuntu ([105.117.2.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244940113sm3776557f8f.18.2025.12.18.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 00:30:07 -0800 (PST)
Date: Thu, 18 Dec 2025 08:30:05 +0000
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [Outreachy PATCH] environment: move "core.attributesFile" into
 repo-setting
Message-ID: <aUO7jQQAERTe5xYc@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When handling multiple repositories within the same process, relying on
global state for accessing the "core.attributesFile" configuration can
lead to incorrect values being used. It also makes it harder to isolate
repositories and hinders the libification of git.
The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
retrieve "core.attributesFile" via `git_attr_global_file()`
which reads from global state `git_attributes_file`.

Move the "core.attributesFile" configuration into the
`struct repo_settings` instead of relying on the global state.
A new function `repo_settings_get_attributesfile_path()` is added
and used to retrieve this setting in a repository-scoped manner.
The functions to retrieve "core.attributesFile" are replaced with
the new accessor function `repo_settings_get_attributesfile_path()`
This improves multi-repository behaviour and aligns with the goal of
libifying of Git.

Note that in `bootstrap_attr_stack()`, the `index_state` is used only
if it exists, else we default to `the_repository`.

Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
The link to the GitHub CI is provided below
https://github.com/cloobTech/git/actions/runs/20284228144

 attr.c          | 20 +++++++++-----------
 attr.h          |  3 ---
 builtin/var.c   |  2 +-
 environment.c   |  6 ------
 environment.h   |  1 -
 repo-settings.c | 10 ++++++++++
 repo-settings.h |  8 ++++++++
 7 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..9e51f8e70b 100644
--- a/attr.c
+++ b/attr.c
@@ -879,14 +879,6 @@ const char *git_attr_system_file(void)
 	return system_wide;
 }
 
-const char *git_attr_global_file(void)
-{
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
-
-	return git_attributes_file;
-}
-
 int git_attr_system_is_enabled(void)
 {
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
@@ -912,6 +904,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
 {
 	struct attr_stack *e;
 	unsigned flags = READ_ATTR_MACRO_OK;
+	const char *attributes_file_path;
+	struct repository *repo;
 
 	if (*stack)
 		return;
@@ -926,9 +920,13 @@ static void bootstrap_attr_stack(struct index_state *istate,
 		push_stack(stack, e, NULL, 0);
 	}
 
-	/* home directory */
-	if (git_attr_global_file()) {
-		e = read_attr_from_file(git_attr_global_file(), flags);
+	if (istate && istate->repo)
+		repo = istate->repo;
+	else
+		repo = the_repository;
+	attributes_file_path = repo_settings_get_attributesfile_path(repo);
+	if (attributes_file_path) {
+		e = read_attr_from_file(attributes_file_path, flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
diff --git a/attr.h b/attr.h
index a04a521092..956ce6ba62 100644
--- a/attr.h
+++ b/attr.h
@@ -232,9 +232,6 @@ void attr_start(void);
 /* Return the system gitattributes file. */
 const char *git_attr_system_file(void);
 
-/* Return the global gitattributes file, if any. */
-const char *git_attr_global_file(void);
-
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
 
diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..fd577f2930 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -72,7 +72,7 @@ static char *git_attr_val_system(int ident_flag UNUSED)
 
 static char *git_attr_val_global(int ident_flag UNUSED)
 {
-	char *file = xstrdup_or_null(git_attr_global_file());
+	char *file = xstrdup_or_null(repo_settings_get_attributesfile_path(the_repository));
 	if (file) {
 		normalize_path_copy(file, file);
 		return file;
diff --git a/environment.c b/environment.c
index a770b5921d..ed7d8f42d9 100644
--- a/environment.c
+++ b/environment.c
@@ -53,7 +53,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-char *git_attributes_file;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
@@ -363,11 +362,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
-	}
-
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/environment.h b/environment.h
index 51898c99cd..3512a7072e 100644
--- a/environment.h
+++ b/environment.h
@@ -152,7 +152,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
diff --git a/repo-settings.c b/repo-settings.c
index 195c24e9c0..396cf79f20 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -5,6 +5,7 @@
 #include "midx.h"
 #include "pack-objects.h"
 #include "setup.h"
+#include "path.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
@@ -158,6 +159,7 @@ void repo_settings_clear(struct repository *r)
 	struct repo_settings empty = REPO_SETTINGS_INIT;
 	FREE_AND_NULL(r->settings.fsmonitor);
 	FREE_AND_NULL(r->settings.hooks_path);
+	FREE_AND_NULL(r->settings.git_attributes_file);
 	r->settings = empty;
 }
 
@@ -230,3 +232,11 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+const char *repo_settings_get_attributesfile_path(struct repository *repo)
+{
+	if (!repo->settings.git_attributes_file) {
+		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file))
+			repo->settings.git_attributes_file = xdg_config_home("attributes");
+	}
+	return repo->settings.git_attributes_file;
+}
diff --git a/repo-settings.h b/repo-settings.h
index d477885561..362f355267 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -68,6 +68,7 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+	char *git_attributes_file;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
@@ -99,4 +100,11 @@ int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
 
+/*
+ * Read the value for "core.attributesfile".
+ * Defaults to xdg_config_home("attributes") if the core.attributesfile
+ * isn't available.
+ */
+const char *repo_settings_get_attributesfile_path(struct repository *repo);
+
 #endif /* REPO_SETTINGS_H */
-- 
2.34.1

