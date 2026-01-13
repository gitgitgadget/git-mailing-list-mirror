Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150034DB4A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325150; cv=none; b=F2eNpCRWdw5Dz5scmiZ4rdxnr/jZ+ewG75sw4FinPSDD3MTWQEi+mcJsFyeU/6HhWUWMuE0rpk8WXtTpgI5zjwdAy5dH5u9UROeHdqHZ8X6YoRK5/F3BPEsXOno7hyeIvZSaQeUnQyjHuv14IyS0DhhJCaSLRbp55KMwi9KB3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325150; c=relaxed/simple;
	bh=/cTCetDGULEQLT+PglBDhfEoFnyKBJn++YPT03LaQjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jf8GVZzTOCTVUA5412abv8yiD/goloXL4D8ay4zqrQQvxcQNDJCCVawrD/ApyHUMIJzHccfpV2KUDpoiGYrrPL3dY3w4tkzcd8AawzBbMZ/k42jTdh2w0CWZ4ocFRGiO0yr5AZ+k8Tqxqaq7Cb8eFjS1Y5v5agkr2lHfTVYZVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbmDrFse; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbmDrFse"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47774d3536dso498465e9.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325147; x=1768929947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhLX3oV+zlHzsezFKzu0SutNr2LxkuijfHrNd867b3A=;
        b=PbmDrFsexc9qsHTybZS2FFxZtAdiJ/P7mLYaEinFZcSvRkHA8x7ViQYZnFwnxjNG2M
         ZXvNEOsqqvKTcaYLZf/CJLJlwR1LMY4/8jmch9YUC4SlcQNRX6C8gE1f4V8CbQidevK+
         DhJp6D/FbEfdrdzWcCncEMcO0Pdm4dOe9T8MsHIqTCBKNUanrgdM6W/qzed5DKiKBRVo
         JFgq8V+PAELJmtSd8vYCCC3cuwrP3G4L0dG/0BVyKLM4G8icYOvUTMsi/c2qRehqHOLC
         86nwTXFcUKD8k71AUklsjNk1SK6REUv9IeM6Kaq5PCLDm3iQYjjMWYdFbhnYwkqrmI9e
         kArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325147; x=1768929947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhLX3oV+zlHzsezFKzu0SutNr2LxkuijfHrNd867b3A=;
        b=kJuL4YZWBsYhPYOjWX4CaTuo1zC1CstWwmxzQc4ZhfsVtLGW1s8WwMvJUy8DTfbW/P
         7jMDZkuExi6aTl7jLAEMX9JP3Jh6NMZdz83yw/ox2Kw5KpwiIzw1IhU/XEC3XfT/HVN4
         xRox623hzIvWQo11juynbQyPQ1oIEubPlP/omssRuPliDrJJVfD4gUkemuUWYd6eiIF+
         iqPH/eyk71OQiM+eZhTTUMtL6QnRc1+Vla/SwGzfj8lF+aDN4V3jSGn2jJhU3g5RTz2T
         iKQBp7b+2OpinUcNSZdFWxcvV1q2ysCeYVXyo9fCS9GZsO0lIYVAMhE+z9smD5QrSp2y
         e+wQ==
X-Gm-Message-State: AOJu0YxQlr777JucSL8ZYPKNdlMX1/COmIBQLqopNif6HE0cpC2u8nN3
	AJe094E0ux+WcPZ17KAWD+d/zCSTe9FBudmixRddfrFRBAM+ziacyFy06pL6dcon
X-Gm-Gg: AY/fxX6V2jpZeH9tDX/AK+oPVV61vSS1rSZ8A55zc/0lwdNmYlvl0rFc7eED5WlXdK5
	+Ec9XcdYMCHPsbFnptREJhdRCZJwAg68vdbq4VpJMfgQilXhv1836k9GsUTIRd0vsfG2UhNbptE
	5C2bgeZRFkdAw/MCJuzmn9tL31AYTezccp/qkSowPVrKwdVub9TYcnfMeL3Ji8rIYFS0nNkwC2W
	gZTuMYPI/1IEiFS27Nk+3TN4mkldCV2qFCZsyLK4IT0oJqt2i6FXRWpXzI6P2t5+N5OYMkFTYQT
	B/LoCto5EBOUcFfTfr7yn70sSpf1CpG9RmsUT6g8o+jpO6aUymXT0K+MFh248V+lRVyJincw2x7
	E1tOOn9eAMGsvErT3ldLtki/uAxIJ13aDYtv6BCJFdDa1R5rF179pG2NjBAjg1F9qs/EogTOWti
	fnRL//
X-Google-Smtp-Source: AGHT+IExUZAs19P4cxql5dLEV/OkMbyqPytSNv25W//xVTVggrT80yFwXgcKDML0lKzorCcVLn8FRg==
X-Received: by 2002:a05:600c:a43:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47ed7bfd405mr49599315e9.2.1768325147067;
        Tue, 13 Jan 2026 09:25:47 -0800 (PST)
Received: from ubuntu ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47edc05b267sm39598915e9.15.2026.01.13.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:25:46 -0800 (PST)
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
Subject: [Outreachy PATCH v2 1/3] environment: stop storing `core.attributesFile` globally
Date: Tue, 13 Jan 2026 17:44:00 +0100
Message-Id: <b6f8deaa405a59812265160fe1d41ad515a9f388.1768318762.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768318762.git.belkid98@gmail.com>
References: <cover.1768318762.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config value parsed in git_default_core_config() is loaded eagerly
and stored in the global variable `git_attributes_file`.
Storing this value in a global variable can lead to unexpected
behaviours when more than one Git repository run in the same Git process.

Move this value into a `struct repo_config_values` which holds all the
values parsed by `git_default_config()` and can be accessed per
repository via `git_default_config()`. This will ensure the current
behaviour remains the same while also enabling the libification of Git.

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
 attr.c        | 7 ++++---
 environment.c | 7 ++++---
 environment.h | 7 ++++++-
 repository.h  | 4 ++++
 4 files changed, 18 insertions(+), 7 deletions(-)

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
index a770b5921d..2789c3514a 100644
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
diff --git a/environment.h b/environment.h
index 51898c99cd..8c7803425e 100644
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
@@ -152,7 +158,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
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

