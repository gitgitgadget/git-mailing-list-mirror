Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA310E5
	for <git@vger.kernel.org>; Sun,  9 Mar 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534416; cv=none; b=K6mX0aGWAHlH2KHLjro8dm3q5zmg5kJ7XbgsJx1FUaATckibsOftuUUQEQXONyKGgBQKHf1wPoewqMFeggR9vG+YbcxAoMnQIT/EE2R0w8myVn1L43Ws1fEasYXNj/buVTRcZvkg9w0q7MuH0/xodgrX8QvzEqMiI6M6bGVa4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534416; c=relaxed/simple;
	bh=uMjw8L4uBHQf9U6pHPWzUYb+1P+CGNxlLmMqF1F8jlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CeLiMmbebz/FrB5p3iuvSKFSLWmNqrydsbJC26UFojXSZrIWHA1Bz1PEWEWFY2IwtlxrU893+qH9i3ZGaDMBiYUvKjWEnHMq4NUpP7tmvC0is8gN6jhDuQAunYxhD/EjXg5ZEWvxIN26Ld6JOe2xGZ8H5jCUjJe741DgN/tD7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWpIif6Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWpIif6Q"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224100e9a5cso61304255ad.2
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 08:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741534413; x=1742139213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQ11vDyJat9LdaWNWEQPgSOf5t0Z1FCwZuFNVzgiWMo=;
        b=mWpIif6QlpypVb/aV9TfRsTw5YLeEsjM0Dlp6JfY5lueW7t5wjCPpKt+zymB+zXxsw
         w1Ya1EiPa0zyUA/kYCGoayuFV2m7deLgG7uOkOi/VOY2qtbecVsenZvKNSydmU2fDrOm
         CRmCe+AcGaPB/iGZfT4VL4xgkZPEVIUjQaj9/fSKsItgYwksPy90OIyFnc0CUvr2gSkw
         efx/QtdQgl/U8MfOKQqIjdHRKvz/hoFdBQPrGv5IKr8YHYevBpGEBJh10oavVcRvry0y
         avNCWAphQbBgwveqfAgqIbHsRMT0vqktb5f94rlUrR60VTRdkejk5+las+JWdzoD5/lU
         H3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741534413; x=1742139213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQ11vDyJat9LdaWNWEQPgSOf5t0Z1FCwZuFNVzgiWMo=;
        b=wETaICVQ8T4g8tAUV3OC9AXA4r10/9WQSsLACzyxih2x+xBLkX08DUAPnTuUNoC7e9
         xoUUnmmZebuLD0G+tHE0sHiblRUsHmZMalXOSwyeMQJEZfcHQVRzvGl/Prqm0b5KystP
         T/4XQ/uKG5G/ati1Jc1YHDs06EOZmEkOhqbEdO8Qt7x8N+5G/hNcyYMEowe7EQc/o/LV
         cj1mS3f4Rm/2dWR3Q3qUgpmOahxsEN7hPW6K9CkqISO9Un3oF0OM27BJRR3xvt0BgcJK
         aaGFG9Fok4yGuc04RMXsCj8WwRGyKDcK+zPKaqI8M4oVQ06xrFgZ5xD60NVgXLNu9H9d
         Gsog==
X-Gm-Message-State: AOJu0YzoOIDoD5fj7vziVNlbbZXhY2rZkelmgf7y6BJ1OSEaWrhdtEDU
	bwh+WZOGGzVRKpcErzLbfIQud2nG+NuonX1dgtPOPBe2H3BPcv2ObJvFY7619BE=
X-Gm-Gg: ASbGncvaosKR+87vGxHpNfJram9Rk/henFH750eVY7B2j9mETlLptFzQ5jZrbY0o9FT
	IyiU9f4bGXPPToRooeJ0JhGOd9fl1ILaofyiBqYo1uhY1qkTEkDjHNutj5Gy2LZ+jeIsBRBZC9p
	Fq5l/nibSwKz4CzBrqxjzHc3F8SNqDdJDPtyKi6acrMM17ugoyWnTnfaIfpBl2M/Gvqq5j6S64S
	xt7hFuqwBc9EeMnllzQSX8PxayUtLOOcKbGGu9lYUwZTf290DrVZau8qKCetNepuPvH57kbQnmk
	fxr916oRNIFseowb+zqzYWza88dBlet+K0/NOpaqiHtVqwRKNP5nhDP8qJWG9Q==
X-Google-Smtp-Source: AGHT+IH2oKjiEssjkoHKOQosteEJESE8wI2wYp5uCgUUWmSB+I3JRCq30bXWDz4HAm3RmgT8tTl9Pw==
X-Received: by 2002:a05:6a20:1594:b0:1f3:3538:6f6 with SMTP id adf61e73a8af0-1f544c3cfbbmr16190178637.9.1741534413340;
        Sun, 09 Mar 2025 08:33:33 -0700 (PDT)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b9232b72sm3745498b3a.95.2025.03.09.08.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 08:33:33 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH] environment: move access to "core.attributesfile" into repo settings
Date: Sun,  9 Mar 2025 21:03:21 +0530
Message-ID: <20250309153321.254844-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop relying on global state to access the "core.attributesfile"
configuration. Instead, store the value in `struct repo_settings` and
retrieve it via `repo_settings_get_attributes_file_path()`.

This prevents incorrect values from being used when a user or tool is
handling multiple repositories in the same process, each with different
attribute configurations. It also improves repository isolation and helps
progress towards libification by avoiding unnecessary global state.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 attr.c               | 27 ++++++++++++---------------
 attr.h               |  7 +++++--
 builtin/check-attr.c |  2 +-
 builtin/var.c        |  9 +++++++--
 config.c             |  5 -----
 environment.c        |  1 -
 environment.h        |  1 -
 repo-settings.c      | 11 +++++++++++
 repo-settings.h      |  3 +++
 9 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/attr.c b/attr.c
index 0bd2750528..aec4b42245 100644
--- a/attr.c
+++ b/attr.c
@@ -879,12 +879,9 @@ const char *git_attr_system_file(void)
 	return system_wide;
 }
 
-const char *git_attr_global_file(void)
+const char *git_attr_global_file(struct repository *repo)
 {
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
-
-	return git_attributes_file;
+	return repo_settings_get_attributesfile_path(repo);
 }
 
 int git_attr_system_is_enabled(void)
@@ -906,7 +903,7 @@ static void push_stack(struct attr_stack **attr_stack_p,
 	}
 }
 
-static void bootstrap_attr_stack(struct index_state *istate,
+static void bootstrap_attr_stack(struct repository *repo, struct index_state *istate,
 				 const struct object_id *tree_oid,
 				 struct attr_stack **stack)
 {
@@ -927,8 +924,8 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	}
 
 	/* home directory */
-	if (git_attr_global_file()) {
-		e = read_attr_from_file(git_attr_global_file(), flags);
+	if (git_attr_global_file(repo)) {
+		e = read_attr_from_file(git_attr_global_file(repo), flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
@@ -946,7 +943,7 @@ static void bootstrap_attr_stack(struct index_state *istate,
 	push_stack(stack, e, NULL, 0);
 }
 
-static void prepare_attr_stack(struct index_state *istate,
+static void prepare_attr_stack(struct repository *repo, struct index_state *istate,
 			       const struct object_id *tree_oid,
 			       const char *path, int dirlen,
 			       struct attr_stack **stack)
@@ -969,7 +966,7 @@ static void prepare_attr_stack(struct index_state *istate,
 	 * .gitattributes in deeper directories to shallower ones,
 	 * and finally use the built-in set as the default.
 	 */
-	bootstrap_attr_stack(istate, tree_oid, stack);
+	bootstrap_attr_stack(repo, istate, tree_oid, stack);
 
 	/*
 	 * Pop the "info" one that is always at the top of the stack.
@@ -1143,7 +1140,7 @@ static void determine_macros(struct all_attrs_item *all_attrs,
  * If check->check_nr is non-zero, only attributes in check[] are collected.
  * Otherwise all attributes are collected.
  */
-static void collect_some_attrs(struct index_state *istate,
+static void collect_some_attrs(struct repository *repo, struct index_state *istate,
 			       const struct object_id *tree_oid,
 			       const char *path, struct attr_check *check)
 {
@@ -1164,7 +1161,7 @@ static void collect_some_attrs(struct index_state *istate,
 		dirlen = 0;
 	}
 
-	prepare_attr_stack(istate, tree_oid, path, dirlen, &check->stack);
+	prepare_attr_stack(repo, istate, tree_oid, path, dirlen, &check->stack);
 	all_attrs_init(&g_attr_hashmap, check);
 	determine_macros(check->all_attrs, check->stack);
 
@@ -1310,7 +1307,7 @@ void git_check_attr(struct index_state *istate,
 	int i;
 	const struct object_id *tree_oid = default_attr_source();
 
-	collect_some_attrs(istate, tree_oid, path, check);
+	collect_some_attrs(the_repository, istate, tree_oid, path, check);
 
 	for (i = 0; i < check->nr; i++) {
 		unsigned int n = check->items[i].attr->attr_nr;
@@ -1321,14 +1318,14 @@ void git_check_attr(struct index_state *istate,
 	}
 }
 
-void git_all_attrs(struct index_state *istate,
+void git_all_attrs(struct repository *repo, struct index_state *istate,
 		   const char *path, struct attr_check *check)
 {
 	int i;
 	const struct object_id *tree_oid = default_attr_source();
 
 	attr_check_reset(check);
-	collect_some_attrs(istate, tree_oid, path, check);
+	collect_some_attrs(repo, istate, tree_oid, path, check);
 
 	for (i = 0; i < check->all_attrs_nr; i++) {
 		const char *name = check->all_attrs[i].attr->name;
diff --git a/attr.h b/attr.h
index a04a521092..c4f26b8f58 100644
--- a/attr.h
+++ b/attr.h
@@ -213,11 +213,13 @@ void git_check_attr(struct index_state *istate,
 		    const char *path,
 		    struct attr_check *check);
 
+struct repository;
+
 /*
  * Retrieve all attributes that apply to the specified path.
  * check holds the attributes and their values.
  */
-void git_all_attrs(struct index_state *istate,
+void git_all_attrs(struct repository *repo, struct index_state *istate,
 		   const char *path, struct attr_check *check);
 
 enum git_attr_direction {
@@ -233,7 +235,7 @@ void attr_start(void);
 const char *git_attr_system_file(void);
 
 /* Return the global gitattributes file, if any. */
-const char *git_attr_global_file(void);
+const char *git_attr_global_file(struct repository *repo);
 
 /* Return whether the system gitattributes file is enabled and should be used. */
 int git_attr_system_is_enabled(void);
@@ -283,4 +285,5 @@ struct match_attr {
 struct match_attr *parse_attr_line(const char *line, const char *src,
 				   int lineno, unsigned flags);
 
+
 #endif /* ATTR_H */
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 7cf275b893..1b8a89dfb2 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -70,7 +70,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(the_repository->index, full_path, check);
+		git_all_attrs(the_repository, the_repository->index, full_path, check);
 	} else {
 		git_check_attr(the_repository->index, full_path, check);
 	}
diff --git a/builtin/var.c b/builtin/var.c
index ada642a9fe..3d635c235e 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -69,9 +69,9 @@ static char *git_attr_val_system(int ident_flag UNUSED)
 	return NULL;
 }
 
-static char *git_attr_val_global(int ident_flag UNUSED)
+static char *repo_git_attr_val_global(struct repository *repo, int ident_flag UNUSED)
 {
-	char *file = xstrdup_or_null(git_attr_global_file());
+	char *file = xstrdup_or_null(git_attr_global_file(repo));
 	if (file) {
 		normalize_path_copy(file, file);
 		return file;
@@ -79,6 +79,11 @@ static char *git_attr_val_global(int ident_flag UNUSED)
 	return NULL;
 }
 
+static char *git_attr_val_global(int ident_flag)
+{
+	return repo_git_attr_val_global(the_repository, ident_flag);
+}
+
 static char *git_config_val_system(int ident_flag UNUSED)
 {
 	if (git_config_system()) {
diff --git a/config.c b/config.c
index 36f76fafe5..d483f1418c 100644
--- a/config.c
+++ b/config.c
@@ -1432,11 +1432,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
-	}
-
 	if (!strcmp(var, "core.hookspath")) {
 		FREE_AND_NULL(git_hooks_path);
 		return git_config_pathname(&git_hooks_path, var, value);
diff --git a/environment.c b/environment.c
index e5b361bb5d..e1da5a69b7 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-char *git_attributes_file;
 char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
diff --git a/environment.h b/environment.h
index 2f43340f0b..9dc6bc0f3f 100644
--- a/environment.h
+++ b/environment.h
@@ -159,7 +159,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern char *git_hooks_path;
 extern int zlib_compression_level;
 extern int pack_compression_level;
diff --git a/repo-settings.c b/repo-settings.c
index 9d16d5399e..420ca72f5f 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -4,6 +4,7 @@
 #include "repository.h"
 #include "midx.h"
 #include "pack-objects.h"
+#include "path.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
@@ -167,3 +168,13 @@ int repo_settings_get_warn_ambiguous_refs(struct repository *repo)
 			      &repo->settings.warn_ambiguous_refs, 1);
 	return repo->settings.warn_ambiguous_refs;
 }
+
+const char *repo_settings_get_attributesfile_path(struct repository *repo)
+{
+	if (!repo->settings.git_attributes_file) {
+		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file)) {
+			repo->settings.git_attributes_file = xdg_config_home("attributes");
+		}
+	}
+	return repo->settings.git_attributes_file;
+}
\ No newline at end of file
diff --git a/repo-settings.h b/repo-settings.h
index 93ea0c3274..2a5ca5f07d 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -61,6 +61,7 @@ struct repo_settings {
 	size_t delta_base_cache_limit;
 	size_t packed_git_window_size;
 	size_t packed_git_limit;
+	char *git_attributes_file;
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
@@ -78,5 +79,7 @@ void prepare_repo_settings(struct repository *r);
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
 /* Read the value for "core.warnAmbiguousRefs". */
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
+/* Read the value for "core.attributesfile". */
+const char *repo_settings_get_attributesfile_path(struct repository *repo);
 
 #endif /* REPO_SETTINGS_H */
-- 
2.48.GIT

