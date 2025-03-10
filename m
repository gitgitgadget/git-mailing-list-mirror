Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA822DFA9
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619478; cv=none; b=p1r2gW6n9iNULQwzowCzvHTPdaWLwbVYpuPt0MqOp4Q3ZnbSFaWNn0X7VhaUNd2+PEIHBT53t9o1f541U/0MDyzn6IGoExD58Ft2PTmlj2eNC7bm4BWdiDDEbjOtF1pWB8m1IRGuz1B0jnWInm60xiwKZ0fnnMpTzE23ycIXiz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619478; c=relaxed/simple;
	bh=WEo4mxcdIigSyR+o/6PLgE0H1CeRSktYeKOH/3U2tUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4mAhvSSwKt0kalVqFm89IXaG+dX5hAorhz3+9JrJW3/gYF09ppPYQ5T5KiuNiqfLUvQU2ew7mNPxd/UrfnNMWYkRay4iFh4DYvyTh2Mq/RN+nivOQYIbCj8JKbysgD8ZsfeHeJOgmh0dxeunciTbz+H/PF78alLlr5+NlcP+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmVlXTKO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmVlXTKO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2232aead377so13708435ad.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741619474; x=1742224274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VixsNJLmWejyNtPg75SfrCyGIDEQzoVVSa7gAOblVvY=;
        b=BmVlXTKOi9zI6jCkzA5Y2KZh0kb/gyhTrAVmLxyaS0qL1I6myF8o+d0qWi/5/UFkU0
         Eph6VHEtmKSAbxzV9wvEdUON80PpK3d6jlwtL86Zk15T6q+Rpix+v0/I7sDTX7Ea9+Uy
         Cc3uxuVvrgCUoKPJC68Dk1SypzvTdTtlkenp4uYMbyyoPRC/Crymwu++azoUSFdxVrZV
         RoqyLTbKefR/2YRB5i7NLthu3QQ2y0iAtZrd3Xgf7DO4bb+rdK5DJARyU5Y7PFTCv+PQ
         IABrsV2z8QNg+7ErJ1sgRXz3yN6rwnrp49NEeBvoII2LG4SDGr7+IbpYKgBi+LwvEEsD
         NUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619474; x=1742224274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VixsNJLmWejyNtPg75SfrCyGIDEQzoVVSa7gAOblVvY=;
        b=v6RLnDeNH1Cvv3qpf8rm/pgRPES9MxpSIJPSESO83aWsszjlF382udgeG3W8BJcpNp
         wDj/I8BvKT/ULrR+PuuH5vpauHCkCH3hYfpdj4Xeq+mE6F3E9oa1qYr/Qg1w82hhHA3c
         I6r7rbWtGDUggJ026gj1CBPZnTdY9xrn2xXfB5BHAa8shDk2GtmO8mhyAvDyCdy0u+qi
         MtPbs6M0Zd90ulDmz2CdB6Q6tod8y/SOe65PoyghGQms3eEVYj/SP9npoDFIApym0V2V
         TTWVYFal09BlUax3lzSJXelxjLRWpapBRIyNOCf9bNBoPU0sXG+CEjkO1K/sRiAPmV7o
         zATA==
X-Gm-Message-State: AOJu0YxWWVTji61YpfmN0b+7E05UjBep6bx8W356aBzKl6jeTramRkmy
	n3bMylw8tC7GGqMOqmEhv7S0uPPe4uudEIiYyCdYxC/ekkcC/xsv
X-Gm-Gg: ASbGncsKBIWOs2uorRtbVfyGHzCVMIjXTGhtlO85z0g8BfsTrzjlA+j47QODWaLqFsf
	YCWzSSpqzKtv3k/dgoM0aOpHNq18ULvD+489ufMtZc3mjsIXfMR7T4Tg9V5D/uGxX3KftDtqIn5
	abHQ9pg7K70hdtt54ZkKxe+8m+hHf5NlCF7+XPThvTegqylab/q6Ev4O50uLlhf7xWYq32DEbo3
	+mQWjLaXpOiSnUQQD4MU0HvP1R6i5hfLDaGLSvNWKr5mfsTVGZ2oRbWThyDVLLihK/79dkd8Hvt
	PH8eFv5wnCrupX/uYZgElMMR2+Hih1VHkFvP6Cpkemgz+VkC+2aJMjOnlWN/xg==
X-Google-Smtp-Source: AGHT+IHBEU8uyddlwWJUNZnQp1bi5BU/mg7njd+qHbcGPA7DKcu333Hm8Tle5akd9HRMi2MgePevSA==
X-Received: by 2002:a17:903:1b63:b0:220:e5be:29c8 with SMTP id d9443c01a7336-22428bdee3cmr240846325ad.32.1741619473862;
        Mon, 10 Mar 2025 08:11:13 -0700 (PDT)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e98adsm79528715ad.90.2025.03.10.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:11:13 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH v2 1/2] environment: move access to "core.attributesfile" into repo settings
Date: Mon, 10 Mar 2025 20:40:47 +0530
Message-ID: <20250310151048.69825-2-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
In-Reply-To: <20250310151048.69825-1-ayu.chandekar@gmail.com>
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
 <20250310151048.69825-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling multiple repositories within the same process, relying on
global state for accessing the "core.attributesfile" configuration can
lead to incorrect values being used. It also makes it harder to isolate
repositories and hinders the libification of git.

Store the "core.attributesfile" configuration in the `repo_settings`
instead of relying on the global state. Add a new function
`repo_settings_get_attributesfile_path()` to retrieve this setting in a
repository-scoped manner.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c        |  5 -----
 environment.c   |  1 -
 environment.h   |  1 -
 repo-settings.c | 11 +++++++++++
 repo-settings.h |  3 +++
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 658569af08..b52ad3e3ad 100644
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
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 9e4c7781be..d7bf911ec5 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-char *git_attributes_file;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
diff --git a/environment.h b/environment.h
index 45e690f203..b7860eed3a 100644
--- a/environment.h
+++ b/environment.h
@@ -149,7 +149,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern char *git_attributes_file;
 extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
diff --git a/repo-settings.c b/repo-settings.c
index 67e9cfd2e6..17e60aa0d6 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -5,6 +5,7 @@
 #include "midx.h"
 #include "pack-objects.h"
 #include "setup.h"
+#include "path.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
@@ -148,6 +149,7 @@ void repo_settings_clear(struct repository *r)
 	struct repo_settings empty = REPO_SETTINGS_INIT;
 	FREE_AND_NULL(r->settings.fsmonitor);
 	FREE_AND_NULL(r->settings.hooks_path);
+	FREE_AND_NULL(r->settings.git_attributes_file);
 	r->settings = empty;
 }
 
@@ -207,3 +209,12 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+
+const char *repo_settings_get_attributesfile_path(struct repository *repo)
+{
+	if (!repo->settings.git_attributes_file) {
+		if (repo_config_get_pathname(repo, "core.attributesfile", &repo->settings.git_attributes_file))
+			repo->settings.git_attributes_file = xdg_config_home("attributes");
+	}
+	return repo->settings.git_attributes_file;
+}
diff --git a/repo-settings.h b/repo-settings.h
index ddc11967e0..58dadd9dae 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -66,6 +66,7 @@ struct repo_settings {
 	size_t packed_git_limit;
 
 	char *hooks_path;
+	char *git_attributes_file;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
@@ -92,5 +93,7 @@ const char *repo_settings_get_hooks_path(struct repository *repo);
 int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
+/* Read the value for "core.attributesfile". */
+const char *repo_settings_get_attributesfile_path(struct repository *repo);
 
 #endif /* REPO_SETTINGS_H */
-- 
2.48.GIT

