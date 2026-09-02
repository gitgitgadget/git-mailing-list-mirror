Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA6478E3E
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348679; cv=none; b=UDJZvUW/AuslfOdy4swQc55RhHmA5bpgMXmsdvU/b63vnr27znKReT8VZEqAXCXcy7bIBL48UDud0GshfOJos+ysSBmzC0OoL4L1eNpkjY2bRpQ/iwR+65pWzUhMCeMwmaTdkz3TZoO/bzxX1AiygyGTiRBYMj9zWAQPx5O89Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348679; c=relaxed/simple;
	bh=2FANJA4i5Qf95zyStZ04dgwJgb0OOCCwnnm+EGfYL20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sYu3eOfXOUb0konFQwO75RGS6HGW3XCDZvXMvAeQPujLeZ87Fy/r+/38Y1QbjiLioW2YhYkOf5YS1oB85iHFEm+ZCf2F3Z4buBzeJUZezDzJkYPmxxK/lvAeQq/FsUCg8yFHT8ur9Q2tTLCjvtkdh/Cwopisc66h+AgxwR3gbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puH3/A2L; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puH3/A2L"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbee846deecso1226747a12.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 04:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348675; x=1788953475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXP73Wk0t90mmm1jt2AudJE1EYlAv7XhSL/1AlyS4VA=;
        b=puH3/A2L/SuvtonpA18xuBSOrkcvYVu+Nd2X2xIdFGx5iWgDAOvQE9xrtUm5KPhmw8
         IkZccZxXgLm5p1KYPh81PTfymOvZ42vgUlIerWIa97aZWbPzQOu0s6C71soCb8wduCx4
         YuDi6fh0kmXFwuFG+SiPSLZwPS8kbGNwqcfWv1pfKfZaFZZZdjRuvQqTVw2mVUE7a8CR
         /esdwNWp1Q+PxjQbDYWEh54PnZ+y9Ool/6T66Sjf0o/z/paPEFETUjfB9gVgFzRoQPoB
         yxYqdoTmHRK54lKU+wRIBTP33xM/SPA56E8iQEqHTlGBkYmWaQmAa+FwqspENNaYFu9/
         miXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348675; x=1788953475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GXP73Wk0t90mmm1jt2AudJE1EYlAv7XhSL/1AlyS4VA=;
        b=b9c0m2x0RLVoB/LSCdtl5c1aGSWttgJVkgJmL90Q5oxg01GFqEKZL5gHcGkA2VJml/
         Sjj94bfcConOyfE3Ol+RopYQtecewj20zTRXXELwFcg+gxyRFefZxO/o9y8eLEyqnY3K
         PB69dcGJ3ydawBsTr7oAmvZNhsVowQzNRcWWX6O06vMX5t+WDPFeyaZlMQAnSSy84k0Y
         O71bp+qKCjlCmyGtUzZlMMpyIeXxXLaEr3kbBk2zeeFSOT5y1nUAhITQVizfCv5QE9Nv
         kVhtAUQBvzwAloJE7UsoPTn+Cv+l2jo9ht4G1EokqkdE/NCQAm9fZN+Y+08i/U2UDIjp
         pA5A==
X-Gm-Message-State: AFuF++n/aiaoAN+PT9ZMzTqKWMkh08cN+CGVoEVYZKo4FWPEly7SMv1u
	MLLG31jc3VRTK8MPa4MjDyT6rRTmHwuc1CyQAxL7ZRoN2hIUHGDYillMKj6WWg==
X-Gm-Gg: AYBFou2g8aARRIA9ZdHn59r8FZyJ7+pS9L3icbaLnL5eplZ3vdLhQQb0NrXc2w/Xl+R
	Lw0pZFpytuLCZoXzoEW4cYSrCnoXLTMb5aC91yTYDIokhVyobV+KPzF6NMzhctFxfwAlpg/Z8x3
	yklYjJZrF0Ll+iXsNaS9VvrLJS7IvELAQDBPPZqR7atIACn4uBxa/2wjOa87D+L6D+xW+B58f0P
	+qSCUBDUTR5SMImaLM1uweL27VUmii9FauiMyJe46wj2wZ/Gx4rkh12QXVSb2XRbRI+aHUBB6Ui
	DH/DWC03mNVN5NgOSMzcCvDJ4CMv6xyXTJgM979bJy48J2BHzrZsoOvZQgv+xl6NlXBRvIGsZ0S
	14pHkRg/R4+b5ki0jQn8ZfTpHF/obI+W6VOXc0paNT1MR86RB3vLkZP+bs4v34re+97ahdAzfqp
	yRIuNEiaXyZwTIDr8ggLKrt4nkG1DDCBP/JJYblZG72O6TOpCv2x1r9184E9zC0n9DeK3/+j4i+
	JxLlnfhJBunfhi8mtxXPuMSxDMmWixow0YP1pP5jzIq3a4BxtdDvd4yttEF0f0ZBfoQbUfm4KIg
	QPNOm8FwFt6+BNk=
X-Received: by 2002:a17:90b:1641:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-39aee162847mr5720475a91.12.1788348674931;
        Wed, 02 Sep 2026 04:31:14 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6.. ([59.89.50.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0f2a315sm6179992a91.8.2026.09.02.04.31.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:31:14 -0700 (PDT)
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] environment: move grafts_keep_true_parents into repo_config_values
Date: Wed,  2 Sep 2026 17:00:45 +0530
Message-ID: <20260902113109.686014-1-ysinghcin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the global 'grafts_keep_true_parents' configuration variable into
the repository-specific 'repo_config_values' struct.

Introduce the getter function 'repo_grafts_keep_true_parents(repo)'
which checks whether 'repo->initialized' is set, falling back to 0
when uninitialized.

Update call sites in commit.c to use 'repo_grafts_keep_true_parents(r)'
with the existing repository context 'r'. In builtin/pack-objects.c,
bind the '--keep-true-parents' option directly to
'cfg->grafts_keep_true_parents'.

When accessing 'repo_config_values' in cmd_pack_objects, use a NULL
guard 'repo ? repo : the_repository'. This ensures that invocations
without a repository context (e.g. 'git pack-objects -h' outside a repo)
do not dereference a NULL pointer.

Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
---
 builtin/pack-objects.c | 6 +++---
 commit.c               | 2 +-
 environment.c          | 9 ++++++++-
 environment.h          | 5 +++--
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 65c2ad9a86..0d213dead1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5120,7 +5120,7 @@ static int parse_stdin_packs_mode(const struct option *opt, const char *arg,
 int cmd_pack_objects(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	int use_internal_rev_list = 0;
 	int all_progress_implied = 0;
@@ -5131,7 +5131,7 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
-	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct repo_config_values *cfg = repo_config_values(repo ? repo : the_repository);
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
@@ -5215,7 +5215,7 @@ int cmd_pack_objects(int argc,
 				N_("ignore this pack")),
 		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
-		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
+		OPT_BOOL(0, "keep-true-parents", &cfg->grafts_keep_true_parents,
 			 N_("do not hide commits by grafts")),
 		OPT_BOOL(0, "use-bitmap-index", &use_bitmap_index,
 			 N_("use a bitmap index if available to speed up counting objects")),
diff --git a/commit.c b/commit.c
index ad26f0b40a..5a7ae0696c 100644
--- a/commit.c
+++ b/commit.c
@@ -566,7 +566,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 		 * The clone is shallow if nr_parent < 0, and we must
 		 * not traverse its real parents even when we unhide them.
 		 */
-		if (graft && (graft->nr_parent < 0 || !grafts_keep_true_parents))
+		if (graft && (graft->nr_parent < 0 || !repo_grafts_keep_true_parents(r)))
 			continue;
 		new_parent = lookup_commit(r, &parent);
 		if (!new_parent)
diff --git a/environment.c b/environment.c
index 76ee65e62b..53e8ab1255 100644
--- a/environment.c
+++ b/environment.c
@@ -56,7 +56,6 @@ char *check_roundtrip_encoding;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-int grafts_keep_true_parents;
 unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
@@ -152,6 +151,13 @@ int repo_has_symlinks(struct repository *repo)
 		: platform_has_symlinks();
 }
 
+int repo_grafts_keep_true_parents(struct repository *repo)
+{
+	return repo->initialized
+		? repo_config_values(repo)->grafts_keep_true_parents
+		: 0;
+}
+
 const char *repo_excludes_file(struct repository *repo)
 {
 	struct repo_config_values *cfg = repo_config_values(repo);
@@ -770,6 +776,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->core_sparse_checkout_cone = 0;
 	cfg->sparse_expect_files_outside_of_patterns = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
+	cfg->grafts_keep_true_parents = 0;
 }
 
 void repo_config_values_clear(struct repo_config_values *cfg)
diff --git a/environment.h b/environment.h
index e7ec5b0437..b9f31a0aef 100644
--- a/environment.h
+++ b/environment.h
@@ -139,6 +139,7 @@ struct repo_config_values {
 	int ignore_case;
 	int trust_executable_bit;
 	int has_symlinks;
+	int grafts_keep_true_parents;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
@@ -193,6 +194,8 @@ int repo_trust_executable_bit(struct repository *repo);
 
 int repo_has_symlinks(struct repository *repo);
 
+int repo_grafts_keep_true_parents(struct repository *repo);
+
 const char *repo_excludes_file(struct repository *repo);
 
 void repo_config_values_init(struct repo_config_values *cfg);
@@ -235,8 +238,6 @@ extern int minimum_abbrev, default_abbrev;
 extern int assume_unchanged;
 extern unsigned long pack_size_limit_cfg;
 
-extern int grafts_keep_true_parents;
-
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
-- 
2.43.0
