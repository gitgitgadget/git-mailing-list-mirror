Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935383EBF3E
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771154652; cv=none; b=noYH3RMOe2HzDp2EdkjQLCLuWuKkkjtEh+WbxmgP5qisPpVUqtAw3O7Nj8S88stCQvZ0uNeLw5RI57+BYEoRZOQq5IU0yl8fIvsQURnR1Z+6VFuJRhtN/p9YC4RQYUFqdRWTwzI+MeQ86VxsWPT3x3W+667/PsobeHZZxaArQOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771154652; c=relaxed/simple;
	bh=zWIMb8ZynnCSthj3FVGtPt8BoML6PnU/MbnYJL2//g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu4/zcvwgCezfvuDZfUkfnjDMzNkqoj1nMejS7pE2ZntFazRuh7fhqkhja4y0V+ogU1UnokO+SxYzb5yR7JnNd5FSICyNUo0a7w7VD7ZmUB1+JXtmPCPIRnBdTTUoh5gonf4apCYHK+zaHy/Pjmp7L099vHI+DWGX29boDPKleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnpC7ftO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnpC7ftO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35691a231a7so1148365a91.3
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 03:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771154650; x=1771759450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPsV2B+CIEorFxyewmraCxR1JoYTh8eUNINgSarEaig=;
        b=MnpC7ftOsO3+Tr4P7iD6Bz3MztOD0ZYjEKU2wLw5naITyTGt8udLqQ9MqyMIwyGPoW
         YL1jQf7Is1OITn+1NmzenQ1onQZRw728WIzbNKFLYbzuTl4D1hkLMUuyE8em3zMo7SvD
         MqN3GaYCFsQXynx2CpngqHV8+YQu426jFOrmLhZRodTMi/bnmEfS6tBAyVsl3IaHRprz
         123feAV8r467bLFjTwkZiCWUdMErab5+jF10Uyz0/B+obVub61zdjIpxXpJx4TkPVGgR
         ym7+pRHU+hKD0FT39biYrnY1bDYN1rF5UzEUDqZO+WuF3cj9NMaBZ6wvQD5OREwb47TD
         8Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771154650; x=1771759450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPsV2B+CIEorFxyewmraCxR1JoYTh8eUNINgSarEaig=;
        b=EIyFgMlQPHWOg/ydOIHB3Bvda95g93Pbx4EInoKlqvjWNJ/ccKiQQ/d5eaIi5obCNC
         b0tugSeGbujmIkJwGVJbKmcSObcR1RmTB1pKf9A3x1Jza/GfVnzpFrUBOWgvPeQFa96Y
         VTtyTSL8S1VrEnp+oQMnc31FaCrMnNMWyZRwVS83BP2VwbYO+hKbvXqODhuMuo41qePW
         y2euhIolyE1YTyyZJniRJM+lgsgzZJmBxXy5YdnvlMKGfe/zV+OCKd2jGIecghwKx35Q
         4wBhRgVkAwUFMI4vMtwXkeKFwhnmWr7hhWqDKfU/Mc78hlAP93xdeWUgj+45onlz+oxA
         8u5g==
X-Gm-Message-State: AOJu0YyzN+QQareFzQvQKQSnX6aj6OrqYO4lgJXCyx6lruqwTQ7ZwhQt
	uWI3HqSCSXa/qbQozD7yYQllnMIKO4cKMlej9CK242k64t4b2nFZhtEaAWQEXuc7
X-Gm-Gg: AZuq6aJMQ+idP1xyYy+Z7c8EHrADg7pgk4V0SRp252RyV7fCfVntX7/qmchFUG9n/k6
	H8aaXXHKXEGlwBmFZt6DAiMJLgTPs6AohXCXCiK6xCqyqT/wzSoIhxhP5lYPGKA9r1LJd+sOBKu
	1iVGuF/fIV57sI+WvJFQKR/e2wDvR3rOHly6zR2+1d+TZF311KHJWo6teY8IHhjH4E1k94iFy5y
	f+f+LXj81LzRiybrHGMNFsfDkX1DY8t20r2tZkZo2ou9BKOZWQh+9S8GlBrekQnJXjqqG0RH+HD
	hXLnjLwGB6v2N2PncQLyG4CotQYDNfbL3mh+BqcZ+w9deuTga6slSiLl4Tg6gtiHYSIr587TY+C
	JQ6wAdTvclEQo/vkW16VkV0WKMXnBazT0tFiVB85t+P5QrQj5o61gsYdu+99sualWyIVY5luXNs
	VrQtI/BppzCcDyqz1cYRxllpIps/+RYEUsyfhiUA==
X-Received: by 2002:a17:90a:e188:b0:354:a57c:65db with SMTP id 98e67ed59e1d1-356aad701e0mr7894587a91.20.1771154650123;
        Sun, 15 Feb 2026 03:24:10 -0800 (PST)
Received: from AyushJha ([2409:40e4:1017:eab9:511e:c7bb:d731:d341])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567eba9b2esm13696213a91.9.2026.02.15.03.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 03:24:08 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [RFC GSoC PATCH] environment: move core.trustctime to repo_settings
Date: Sun, 15 Feb 2026 16:53:30 +0530
Message-ID: <20260215112331.22-1-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core.trustctime configuration variable is currently stored as a global in environment.c. This prevents it from being repository-specific, which is problematic when multiple repository instances are used within the same process.

This change continues the effort to move global configuration into struct repo_settings, as discussed in
<20260208062949.596-1-kumarayushjha123@gmail.com>.

Move trust_ctime into struct repo_settings so that it is associated with a repository instance.

Add repo_settings_get_trust_ctime() to lazily read the
core.trustctime configuration value, defaulting to true.

Update statinfo.c to use the new accessor instead of the global variable.

Signed-off-by: Ayush Jha <kumarayushjha123@gmail.com>
---
 environment.c   | 5 -----
 environment.h   | 1 -
 repo-settings.c | 7 +++++++
 repo-settings.h | 8 ++++++++
 statinfo.c      | 4 ++--
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/environment.c b/environment.c
index 8ffbf92d50..95bd0db63c 100644
--- a/environment.c
+++ b/environment.c
@@ -41,7 +41,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int trust_executable_bit = 1;
-int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
@@ -308,10 +307,6 @@ int git_default_core_config(const char *var, const char *value,
 		trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "core.checkstat")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.h b/environment.h
index 27f657af04..148103ea51 100644
--- a/environment.h
+++ b/environment.h
@@ -145,7 +145,6 @@ extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..bb7d983023 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -233,3 +233,10 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+
+int repo_settings_get_trust_ctime(struct repository *repo)
+{
+	if (repo->settings.trust_ctime < 0)
+		repo_cfg_bool(repo, "core.trustctime", &repo->settings.trust_ctime, 1);
+	return repo->settings.trust_ctime;
+}
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..709f86108b 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -70,6 +70,8 @@ struct repo_settings {
 	int max_allowed_tree_depth;
 
 	char *hooks_path;
+
+	int trust_ctime;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
@@ -81,6 +83,7 @@ struct repo_settings {
 	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
 	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
 	.max_allowed_tree_depth = DEFAULT_MAX_ALLOWED_TREE_DEPTH, \
+	.trust_ctime = -1, \
 }
 
 void prepare_repo_settings(struct repository *r);
@@ -90,6 +93,11 @@ void repo_settings_clear(struct repository *r);
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo);
 /* Read the value for "core.warnAmbiguousRefs". */
 int repo_settings_get_warn_ambiguous_refs(struct repository *repo);
+/* Read and set the value for "core.attributesfile". */
+const char *repo_settings_get_attributes_file(struct repository *repo);
+
+/* Read the value for "core.trustctime". */
+int repo_settings_get_trust_ctime(struct repository *repo);
 /* Read the value for "core.hooksPath". */
 const char *repo_settings_get_hooks_path(struct repository *repo);
 
diff --git a/statinfo.c b/statinfo.c
index 30a164b0e6..ebc8faef27 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -66,14 +66,14 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (repo_settings_get_trust_ctime(the_repository) && check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (repo_settings_get_trust_ctime(the_repository) && check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
-- 
2.53.0.windows.1

