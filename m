Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C02EBB89
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768683738; cv=none; b=D0AlT7bxE4lvc3uMlauVwYwEN2flfJVny9dnIOEG5jVsAI0GKHKQ+bxJ9RoxXtaWtvlqtCLOUIfcYTMq/XICJQs5ufwyTt+5GpWb67iC9COqQMDIrfaXPnlibman4qmux7QNwfJudEx5gchgXcjpYicbXZF6c1jTzwx+jEM6f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768683738; c=relaxed/simple;
	bh=0QsHI7b154Ambk549cd9FhqgAaRbS6RZH4RYYAvRgRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QToFYGyF0q+r2sp6F6khVlv93hM+XmWRoHNTqsdwurXNhJXNyKn8RNDQ+MuEeTXHD29IhcUC1e1JXpEJyL0YJhReweeL5PkUjjLwK+yzLRZBvkGgxucvxNaMYZcEmDn35+2vUi5cNJYiMPxprQjy9zC1y5JFCtEoIiXwpd1ujuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa/3ykRe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa/3ykRe"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so28922045e9.2
        for <git@vger.kernel.org>; Sat, 17 Jan 2026 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768683734; x=1769288534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaYXELnMX5M+jSOhBh/ZXqD80KWndZWotgmbLWrFqig=;
        b=Xa/3ykRemPsj4ql7SKi4mSQeaCuAOGChNkuh1unFckB2ZqaPhiGTbmiq4czt9G+u68
         vEznXtrkv6cJ4fUnWtknZu43uMmIi8fqXfWN7xHO6PtYmA0R8MbKRm3BzIQOcAOD4O3I
         W++rNeWXGzCq4CUh5IHJj1i3UgB4b4AoQLG9XyopzGQoVFMUmOR1fF6MsgZYH7Bt4Spd
         qCLHAtNZprw6au2uheA/crTvvsEHNCpRFpezICXoawitvgIIinoQifIyUhld9S/aIpCe
         RMzXbFblAbr8BJdbOVYiJhupU6omhGkT82UoRsWKrghMGc9Tkhe7uMvWD5L5fg+yKN+a
         fZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768683734; x=1769288534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UaYXELnMX5M+jSOhBh/ZXqD80KWndZWotgmbLWrFqig=;
        b=KGO6PG0aGhXLpbKq+/0EZNGusBxhL/0dc2AHZVrBlHh2GY3jkLwZt/dcXRus0Uv+5A
         NvlhUTGaur1rekO0ze1/7DhFV1YKsThcpgNiDgas6M4Hkxki1Ajxeh3wdsOwZRSeXkC0
         3lMOU9BKeVcc5cKF0ZuIM2sF2x2MQleYUVnvyGWw17l8tA2gEGF4mOWq5z5SKRkEFA+N
         LlPu09UVvVxMQPHBBpMN9NLjlwrTcqZQlfqWZXvs2/eVblCRNKvn8Cz/sZLcdFH4z0cm
         KFZOtGWdTaWNqCSSFw6NhXVsP3+FGG3TzNonpt2o/JIw4kVRihjv2JbDZHsud7dMdzxZ
         unLw==
X-Gm-Message-State: AOJu0YzOCwFzcgW6KHMc4dniaNV4xh819yfQckuwH13FGB6SzbUmjA4f
	r9RAC3kuJsQTnSuM14o2qsaCXS1Rs44PFSrLrC69lY+cZswMsX6EmJuw
X-Gm-Gg: AY/fxX5r22LHnFuWM3EPdMOs46aC4FWvSaobMJfx23a/yWu48DhsqVQu5pp804cVCZM
	Y2lRVPGdwWG9wRK42f5KXTW6w4m5YYqR52rJbVYhYof1EUeurojBMhHUp3vwOJK8naRDF+V1ckI
	0BIXhwVE3jROP5SPI8h4plmA6Dwm1o9QvBF6gUJFsO6q+2Ea3c9TQQ2e6Z2mLc5h8C4FFGFm9Tw
	NXEurmihiObwdzNXhmwj7epcRJgGot+EjooUz/01eXJJ3iAPW1+1Izf7CGhJMHtxeTTJFZr9kGl
	5Vdcel0ynP/Hcy8CeCF5xR+IaiCxRKkCPwdZ8sV5EOWzDiXeC+tAWIwJtaBH/IqLONrOx9oDb68
	aJovnf37dcB1F1W9kQaBQuGx2L6nf4n9XcKDW0/sBl9a8nVHj1YhhcluxIt2nzZVodlDrwWPrZ0
	WD9g==
X-Received: by 2002:a05:600c:3b84:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-4801e34cf73mr88813155e9.32.1768683734268;
        Sat, 17 Jan 2026 13:02:14 -0800 (PST)
Received: from ubuntu ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f42907141sm166425235e9.9.2026.01.17.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 13:02:13 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v3 1/3] environment: stop storing `core.attributesFile` globally
Date: Sat, 17 Jan 2026 21:59:26 +0100
Message-Id: <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768681947.git.belkid98@gmail.com>
References: <cover.1768681947.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value is parsed in git_default_core_config(), loaded eagerly
and stored in the global variable `git_attributes_file`.
Storing this value in a global variable can lead to unexpected
behaviours when more than one Git repository run in the same Git process.

Create a new struct `repo_config_values` to hold this value and
other repository dependent values parsed by `git_default_config()` and
can be accessed per repository via `git_default_config()`.
This will ensure the current behaviour remains the same while also
enabling the libification of Git.

It is important to note that `git_default_config()` is a wrapper to other
`git_default_*_config()` such as `git_default_core_config()`.
Therefore to access and modify this global variable,
the change has to be made in the function which parses and
stores the value in the global variable.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 attr.c        |  7 ++++---
 environment.c | 12 +++++++++---
 environment.h |  9 ++++++++-
 repository.c  |  1 +
 repository.h  |  4 ++++
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..fbb9eaffaf 100644
--- a/attr.c
+++ b/attr.c
@@ -881,10 +881,11 @@ const char *git_attr_system_file(void)
 
 const char *git_attr_global_file(void)
 {
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
+	struct repo_config_values *cfg = &the_repository->config_values;
+	if (!cfg->attributes_file_path)
+		cfg->attributes_file_path = xdg_config_home("attributes");
 
-	return git_attributes_file;
+	return cfg->attributes_file_path;
 }
 
 int git_attr_system_is_enabled(void)
diff --git a/environment.c b/environment.c
index a770b5921d..283db0a1a0 100644
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
@@ -327,6 +326,8 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 static int git_default_core_config(const char *var, const char *value,
 				   const struct config_context *ctx, void *cb)
 {
+	struct repo_config_values *cfg = &the_repository->config_values;
+
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
 		trust_executable_bit = git_config_bool(var, value);
@@ -364,8 +365,8 @@ static int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
+		FREE_AND_NULL(cfg->attributes_file_path);
+		return git_config_pathname(&cfg->attributes_file_path, var, value);
 	}
 
 	if (!strcmp(var, "core.bare")) {
@@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
+
+void repo_config_values_init(struct repo_config_values *cfg)
+{
+	cfg->attributes_file_path = NULL;
+}
diff --git a/environment.h b/environment.h
index 51898c99cd..aea73ff25b 100644
--- a/environment.h
+++ b/environment.h
@@ -84,6 +84,12 @@ extern const char * const local_repo_env[];
 
 struct strvec;
 
+/* Config values parsed by git_default_config() */
+struct repo_config_values {
+	/* core config values */
+	char *attributes_file_path;
+};
+
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
@@ -107,6 +113,8 @@ const char *strip_namespace(const char *namespaced_ref);
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
 
+void repo_config_values_init(struct repo_config_values *cfg);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -152,7 +160,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
diff --git a/repository.c b/repository.c
index c7e75215ac..d308cd78bf 100644
--- a/repository.c
+++ b/repository.c
@@ -57,6 +57,7 @@ void initialize_repository(struct repository *repo)
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
 	repo->check_deprecated_config = true;
+	repo_config_values_init(&repo->config_values);
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git a/repository.h b/repository.h
index 6063c4b846..638a142577 100644
--- a/repository.h
+++ b/repository.h
@@ -3,6 +3,7 @@
 
 #include "strmap.h"
 #include "repo-settings.h"
+#include "environment.h"
 
 struct config_set;
 struct git_hash_algo;
@@ -148,6 +149,9 @@ struct repository {
 	/* Repository's compatibility hash algorithm. */
 	const struct git_hash_algo *compat_hash_algo;
 
+	/* Repository's config values parsed by git_default_config() */
+	struct repo_config_values config_values;
+
 	/* Repository's reference storage format, as serialized on disk. */
 	enum ref_storage_format ref_storage_format;
 
-- 
2.34.1

