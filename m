Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240D24B28
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769255733; cv=none; b=Oc6KaiskZTNfgFQMiW5zRqp6e9mTy+CT65oRYkaF3Y/O9JxEbqFe6Zn7ABeRtCOqGozcY5YhkTt6EcNQrtvO7F9ZGk3iD3XrIlV9P93ak44mCZgxnpM/7LieSYyXKYNPHmiyAeFMLk5HFw8v7ac7MV7rIQrTLf/JsttLT5kF/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769255733; c=relaxed/simple;
	bh=UR73UeSpEcBz1+DWLtuStQRx6/F6Sm28Ub/EIYu6II8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIRXQnb5gS9cY7oqCNYvXuBbuXZeaXQOdEeMhRTRDlO4L5ZZWBLE3tzRDgx0d9e1fwHi4K3kXz8gqyGW4sbC8uiyNouHbsaaDYV9WoY+9TO1/gLT2JAF3aZWW+Tso/GzP1bgo5QRMxIaXAQS6FdeqkB576aqWsSflPj5GDQO85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH3EKlkZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH3EKlkZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so31532835e9.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769255730; x=1769860530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJiaJKf2xERWUn1ePAo5r2aLr0YUfSomHUl7p8mGBFw=;
        b=VH3EKlkZB73b2dryIYcmXnWg85+a2ObBL9rWxiShVwz9+WHjIqTSyywiIbMjiqC7Ir
         dkD+2HZ26slOEAEe8rAOlN26CQbQOPzvHj+hM27Nb77FFXszfGkQ4Qyv6nyNjTowIM2M
         lESgRltqkKOWrlhp+Vnp5D2K7cV+dKfRDqyFbvx7F9dT2X6ECq0fDkz31yFV2t3W7Az1
         A1+GAAtM5PmdAmnllXkempp92yQ4C73/xrzaJZeJREh9cau/GGkr/Vc/XTteKGKFRxvC
         jXMNmDRtPueAuYaBlfQOLPQAxJoN1hIx8dj6nQqPqtrX8CMDhKDzqmCHPizy33Ah75pR
         loNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769255730; x=1769860530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJiaJKf2xERWUn1ePAo5r2aLr0YUfSomHUl7p8mGBFw=;
        b=HKDal5kTe537hcBbIvjgik87lIWT/bbLqIyyLmbHcxFmfv6MetL7ti2rumt/uqdTNL
         yO+Ebh1ivVqC0ibfZSKhBc01Qh64amtcXF5yQReO3weDHYKOJ4W5rooLd2Bqd/e5kXXG
         OuwocmCIlSMQ06EaAQvdtd/CTRNEBkJqqLDvCGwjBjq13pIWb25e7u9MVckEn7mk036H
         H1MsCeBkm80vOCFzWhze6YFfhF4TER2pQRFKVhapuFnODMx/c10By3XQYxXZwI4l0ZIn
         9s8YWVB2AO17IHd7/atlnaUlgBOgnzV+33ePNv4JIyCD6v3oqfSVpn7LkSqxQklrqYZZ
         PnKw==
X-Gm-Message-State: AOJu0YzAQPCrXlvBQu2gp+oQCGLgrYRHocuIvINdgt/tULSHXLL/EP9J
	FH61E3/pZiYQ/CVGzCiu4zM6JAmfKXcCL42SYtqXAz42C5GTAgkSyajO
X-Gm-Gg: AZuq6aK1BR/HRbbPJMD5v1G97nhYXl+gxJ1uQZ+jNHZfP05m9rpvGO6+kR/t14K2IyD
	+Ch/bPXCX1b6Pm3d7C4xwmtPZn0Sk7Ph5x/5W7qUxV+xm42TkKI7tRsCCpWUGdPRpbJa+qO0gYt
	EJ8+iND/JHa3moPzYPMNnwt2QOC3dnanQScs9Al4Jflu2QOQfITBC6Ql075uI1HJ8e190iwOfx4
	JtCJE3mIHxw4FutyqbpDBmNEYSVl3BvbnG5TFeNoy5HLEUrdiOVZJkqyVuGqRc6r8sslPKOHGrB
	PbudrBl8iVWgv2yjpzwAhybhtHJBLjT5YqmSfAXz3tqBiyrqiIKB70gUKRS13RYLGjZtP8TFKzJ
	cs03okcmHfAlSNE28XQajCy1CStYiIjOrGNiJZOGsPWFXzFg8ruLDn3VWE1Ehi2X/e3741bYfgf
	sNKvx/RgDTJUtCbg==
X-Received: by 2002:a05:600c:3e19:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4804c9b23bemr92416915e9.19.1769255729458;
        Sat, 24 Jan 2026 03:55:29 -0800 (PST)
Received: from ubuntu ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d845fc3sm114931115e9.1.2026.01.24.03.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 03:55:28 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v4 1/3] environment: stop storing `core.attributesFile` globally
Date: Sat, 24 Jan 2026 12:55:04 +0100
Message-Id: <d28850bcdb5677ad0c81cf4bfa51ae1c056aabd3.1769252118.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1769252118.git.belkid98@gmail.com>
References: <cover.1769252118.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core.attributeFile` config value is parsed in
git_default_core_config(), loaded eagerly and stored in the global
variable `git_attributes_file`. Storing this value in a global variable
can lead to it being overwritten by another repository when more than one
Git repository run in the same Git process.

Create a new struct `repo_config_values` to hold this value and
other repository dependent values parsed by `git_default_config()`.
For now the value can be accessed via the_repository in
`git_default_config()`.
This will ensure the current behaviour remains the same while also
enabling the libification of Git.

It is important to note that `git_default_config()` is a wrapper to other
`git_default_*_config()` functions such as `git_default_core_config()`.
Therefore to access and modify this global variable,
the change has to be made `git_default_core_config()`.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 attr.c        |  7 ++++---
 environment.c | 12 +++++++++---
 environment.h |  8 +++++++-
 repository.c  |  1 +
 repository.h  |  4 ++++
 5 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 4999b7e09d..b8b70e6dce 100644
--- a/attr.c
+++ b/attr.c
@@ -881,10 +881,11 @@ const char *git_attr_system_file(void)
 
 const char *git_attr_global_file(void)
 {
-	if (!git_attributes_file)
-		git_attributes_file = xdg_config_home("attributes");
+	struct repo_config_values *cfg = &the_repository->config_values;
+	if (!cfg->attributes_file)
+		cfg->attributes_file = xdg_config_home("attributes");
 
-	return git_attributes_file;
+	return cfg->attributes_file;
 }
 
 int git_attr_system_is_enabled(void)
diff --git a/environment.c b/environment.c
index a770b5921d..72735d9e4b 100644
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
+		FREE_AND_NULL(cfg->attributes_file);
+		return git_config_pathname(&cfg->attributes_file, var, value);
 	}
 
 	if (!strcmp(var, "core.bare")) {
@@ -756,3 +757,8 @@ int git_default_config(const char *var, const char *value,
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
+
+void repo_config_values_init(struct repo_config_values *cfg)
+{
+	cfg->attributes_file = NULL;
+}
diff --git a/environment.h b/environment.h
index 51898c99cd..0c0dcc6847 100644
--- a/environment.h
+++ b/environment.h
@@ -84,6 +84,11 @@ extern const char * const local_repo_env[];
 
 struct strvec;
 
+struct repo_config_values {
+	/* section "core" config values */
+	char *attributes_file;
+};
+
 /*
  * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
@@ -107,6 +112,8 @@ const char *strip_namespace(const char *namespaced_ref);
 int git_default_config(const char *, const char *,
 		       const struct config_context *, void *);
 
+void repo_config_values_init(struct repo_config_values *cfg);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -152,7 +159,6 @@ extern int assume_unchanged;
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

