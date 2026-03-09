Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039C3E8C7A
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075431; cv=none; b=d5g6wrMWKoAF7aypxZq8Sz5cUJWi+4frQmy4roHdp6cL3gDRgIyjiTrn8RfFmV1GF9bLLlrCZUtAGky73FQaS0cWsID2TpNCvdEbMNch2kxNczU1x0nkK6xZG5y9/taHTRe0fdc9hEms8wpN0+TREvTF+k3uXEAUgHheLOH7luM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075431; c=relaxed/simple;
	bh=j2oJhEHWN3PQL4XJvTN7aIp5mYukKygJ+LdYPWg3GZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXnTqQfWoCj6NfXOvgTmUtiAFYKXMs2sUCCP1VfjjzZrWjXwiEOaLZkIHC++WhZVvnKBLzY31oKkRqLKOWTRMjBWB0SkeAxWYFpOSw98mNYwGogohAzff7QnL6qU3XAfX6xL7Vs1zKUcoXs4UPasUCJbHnjkzseXqsRnItdGot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI2DvLkA; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI2DvLkA"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab39b111b9so53767365ad.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075427; x=1773680227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1eDa+gW7Vmvo2kU59wMjklwSiirzX8YRGDs+Bnnhwac=;
        b=DI2DvLkAoqKaJXPcbgT1ewsTAfUn3+b4adfSb4cE4+IrfA25LZM0cSOArLS+lalnsJ
         tP2QH0pXVgTXeUAYW7/4jvf6OC+NpclkkioIVpNyMJIXlpCs1ovbOS2asdL91HZ330ZY
         tX8vjp75JHKE+13qmCfWi06D7ObZTy8lTtxqXgNKq+M4zgc9H40lpva/gjxnptet6XwX
         Z0OTaDJsp6SUybRCt4zWiNmtVw1/07ex4MZHB2WSXYa+7zwiVHCBzw7a92V3vkrHtxFi
         qTs73PZPzH6fBXtDnoOzPfrqXxr7BLMb63moFkYQY6xAn8q5271BDID+AsMR0Q2fh8nZ
         a3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075427; x=1773680227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eDa+gW7Vmvo2kU59wMjklwSiirzX8YRGDs+Bnnhwac=;
        b=fLhpw6yPiRRd6QZTMQrEclIh0Ffqc/T9uR+cocRKpfcNYnldAgS7P+7PpYZOx30Dyl
         Z2+BjxlNyCJuLxj381GGezGzO6PyJqqjqj4+Q/tf8sm6N3tZ7tCCpR4BViaX6h+7a+or
         tpU1tdlkeSKk7CzF4Q5VcWJNrQcZGmBExZqzhsV5DHVaemzazt3NkOuU3B/LJIXckhVi
         NyKPoGh7u/ULto/iDkZK2KLc3RBTujhJcfa0dSRWrAZmWAnukIjEarSDKFiFybI3tiDX
         73r9J5ab4a1y/LWlTvdPdWVPj5hX0AKDhTsGT2rClAG4sjk4rr/uFraDRaLaJ0P3dsRL
         mnwA==
X-Gm-Message-State: AOJu0YxvmEDrDNYI8BFbyEqgQY0ldbmIJs77mvIkZEcY/++/PiZkPiWL
	t2nMHe3cky/yc40a8f9DuKYJWejLH8NoF/eC+ndEDzfwT+pkrSdLeItacxfLzFmS
X-Gm-Gg: ATEYQzw7r1Dm6MKp7k92lG+1u7OdNCiOpf4qFaUzZ1Vt095oaiVbrTqBS1CcKL914NR
	lhQ/oAUMCkBVMO76vXi0QgWPVtyqO2Mx7hrXlh+DfkD19mwSc4be5yG7l9FXXQBtKiu0hHIKy8L
	jIRtOTaFvwQSJx+OJczlzX0VUVKVhMzkprHstlWNl538naQzykfVYXkZ/cwI+RelOlv9CVnEC8m
	jaQzvVH8jq5smlzApJX4dw6H0Fn+k3znpYEbMf/QHi3CVKECzDL1frvObdLaqhFMh7AAOm8ZvYX
	W3xFVS5BQq266B1rzMvv0XYvLEx7Hd8BHRjfAzhROZZYXFtogERQyPbZvzd7JQcJLqy+XmzawUn
	8HaZcF/h33yJydoDsGAYh2rOhhksYA5GKdjsjTJZQmeBygedvmATRJEmcaZY2gbUrdlqQOhUp/x
	lly5nxouzzSftQh9Y58zOV/oSAFJSCug==
X-Received: by 2002:a17:902:db09:b0:2ae:5723:afa9 with SMTP id d9443c01a7336-2ae8253c933mr129420905ad.53.1773075426504;
        Mon, 09 Mar 2026 09:57:06 -0700 (PDT)
Received: from dorna-OEM.. ([111.119.49.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fa81d5sm122279095ad.71.2026.03.09.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:57:06 -0700 (PDT)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH 1/3] Refactor 'trust_executable_bit' to repository-scoped setting
Date: Mon,  9 Mar 2026 22:35:49 +0545
Message-ID: <20260309165052.13002-1-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

Currently, 'trust_executable_bit' is a global variable in environment.c,
which controls how executable bits are interpreted when creating/updating
cache entries.

This patch moves 'trust_executable_bit' into 'struct repo_settings', making
it a repository-scoped configuration. All references in files have been updated to use
'the_repository->settings.trust_executable_bit'.

Why this is a good candidate:
- It's a self-contained global variable that only affects file mode logic.
- Low risk: changes only impact mode calculations and related apply/update
  operations.
- Makes Git codebase more maintainable and prepares for future multi-repo
  support.

- Manual sanity check with a test repo confirms executable bits behave correctly.

Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 apply.c                |  4 ++--
 builtin/update-index.c |  2 +-
 diff-lib.c             | 10 +++++-----
 environment.c          |  3 +--
 environment.h          |  1 -
 read-cache.c           | 10 +++++-----
 read-cache.h           | 11 +++++++----
 repo-settings.h        |  6 +++++-
 8 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index d044c95d50..2bcb22a4bc 100644
--- a/apply.c
+++ b/apply.c
@@ -3838,8 +3838,8 @@ static int check_preimage(struct apply_state *state,
 		if (*ce && !(*ce)->ce_mode)
 			BUG("ce_mode == 0 for path '%s'", old_name);
 
-		if (trust_executable_bit || !S_ISREG(st->st_mode))
-			st_mode = ce_mode_from_stat(*ce, st->st_mode);
+		if (the_repository->settings.trust_executable_bit  || !S_ISREG(st->st_mode))
+			st_mode = ce_mode_from_stat(the_repository, *ce, st->st_mode);
 		else if (*ce)
 			st_mode = (*ce)->ce_mode;
 		else
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..7917bd286f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -293,7 +293,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
 	fill_stat_cache_info(the_repository->index, ce, st);
-	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
+	ce->ce_mode = ce_mode_from_stat(the_repository, old, st->st_mode);
 
 	if (index_path(the_repository->index, &ce->oid, path, st,
 		       info_only ? 0 : INDEX_WRITE_OBJECT)) {
diff --git a/diff-lib.c b/diff-lib.c
index ae91027a02..894358c8b0 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -160,7 +160,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 
 			changed = check_removed(ce, &st);
 			if (!changed)
-				wt_mode = ce_mode_from_stat(ce, st.st_mode);
+				wt_mode = ce_mode_from_stat(the_repository, ce, st.st_mode);
 			else {
 				if (changed < 0) {
 					perror(ce->name);
@@ -193,7 +193,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 					num_compare_stages++;
 					oidcpy(&dpath->parent[stage - 2].oid,
 					       &nce->oid);
-					dpath->parent[stage-2].mode = ce_mode_from_stat(nce, mode);
+					dpath->parent[stage-2].mode = ce_mode_from_stat(the_repository,nce, mode);
 					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
 				}
@@ -262,7 +262,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
-				newmode = ce_mode_from_stat(ce, st.st_mode);
+				newmode = ce_mode_from_stat(the_repository, ce, st.st_mode);
 				diff_addremove(&revs->diffopt, '+', newmode,
 					       null_oid(the_hash_algo), 0, ce->name, 0);
 				continue;
@@ -270,7 +270,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
 
 			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
 							    ce_option, &dirty_submodule);
-			newmode = ce_mode_from_stat(ce, st.st_mode);
+			newmode = ce_mode_from_stat(the_repository, ce, st.st_mode);
 		}
 
 		if (!changed && !dirty_submodule) {
@@ -338,7 +338,7 @@ static int get_stat_data(const struct cache_entry *ce,
 		changed = match_stat_with_submodule(diffopt, ce, &st,
 						    0, dirty_submodule);
 		if (changed) {
-			mode = ce_mode_from_stat(ce, st.st_mode);
+			mode = ce_mode_from_stat(the_repository, ce, st.st_mode);
 			oid = null_oid(the_hash_algo);
 		}
 	}
diff --git a/environment.c b/environment.c
index 0026eb2274..861ef084dc 100644
--- a/environment.c
+++ b/environment.c
@@ -41,7 +41,6 @@
 static int pack_compression_seen;
 static int zlib_compression_seen;
 
-int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
@@ -306,7 +305,7 @@ int git_default_core_config(const char *var, const char *value,
 {
 	/* This needs a better name */
 	if (!strcmp(var, "core.filemode")) {
-		trust_executable_bit = git_config_bool(var, value);
+		the_repository->settings.trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "core.trustctime")) {
diff --git a/environment.h b/environment.h
index 27f657af04..7f3437f369 100644
--- a/environment.h
+++ b/environment.h
@@ -144,7 +144,6 @@ int is_bare_repository(void);
 extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
-extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
diff --git a/read-cache.c b/read-cache.c
index 0c07c3aef7..b1fcb9e1a0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -201,13 +201,13 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 
 static unsigned int st_mode_from_ce(const struct cache_entry *ce)
 {
-	extern int trust_executable_bit, has_symlinks;
+	extern int has_symlinks;
 
 	switch (ce->ce_mode & S_IFMT) {
 	case S_IFLNK:
 		return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
 	case S_IFREG:
-		return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_IFREG;
+		return (ce->ce_mode & (the_repository->settings.trust_executable_bit ? 0755 : 0644)) | S_IFREG;
 	case S_IFGITLINK:
 		return S_IFDIR | 0755;
 	case S_IFDIR:
@@ -317,7 +317,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 		/* We consider only the owner x bit to be relevant for
 		 * "mode changes"
 		 */
-		if (trust_executable_bit &&
+		if (the_repository->settings.trust_executable_bit &&
 		    (0100 & (ce->ce_mode ^ st->st_mode)))
 			changed |= MODE_CHANGED;
 		break;
@@ -738,7 +738,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		ce->ce_flags |= CE_INTENT_TO_ADD;
 
 
-	if (trust_executable_bit && has_symlinks) {
+	if (the_repository->settings.trust_executable_bit && has_symlinks) {
 		ce->ce_mode = create_ce_mode(st_mode);
 	} else {
 		/* If there is an existing entry, pick the mode bits and type
@@ -748,7 +748,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		int pos = index_name_pos_also_unmerged(istate, path, namelen);
 
 		ent = (0 <= pos) ? istate->cache[pos] : NULL;
-		ce->ce_mode = ce_mode_from_stat(ent, st_mode);
+		ce->ce_mode = ce_mode_from_stat(the_repository, ent, st_mode);
 	}
 
 	/* When core.ignorecase=true, determine if a directory of the same name but differing
diff --git a/read-cache.h b/read-cache.h
index 043da1f1aa..4e88d476aa 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -4,15 +4,18 @@
 #include "read-cache-ll.h"
 #include "object.h"
 #include "pathspec.h"
+#include "repository.h"
 
-static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
-					     unsigned int mode)
+static inline unsigned int ce_mode_from_stat(
+						struct repository *repo,
+						const struct cache_entry *ce,
+					    unsigned int mode)
 {
-	extern int trust_executable_bit, has_symlinks;
+	extern int has_symlinks;
 	if (!has_symlinks && S_ISREG(mode) &&
 	    ce && S_ISLNK(ce->ce_mode))
 		return ce->ce_mode;
-	if (!trust_executable_bit && S_ISREG(mode)) {
+	if (!repo->settings.trust_executable_bit && S_ISREG(mode)) {
 		if (ce && S_ISREG(ce->ce_mode))
 			return ce->ce_mode;
 		return create_ce_mode(0666);
diff --git a/repo-settings.h b/repo-settings.h
index cad9c3f0cc..a12e763f4f 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -48,7 +48,10 @@ struct repo_settings {
 	 * replace_refs_enabled() for more details.
 	 */
 	int read_replace_refs;
-
+	
+	/* Whether to trust executable bit on filesystem (core.filemode) */
+	int trust_executable_bit;
+	
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
@@ -74,6 +77,7 @@ struct repo_settings {
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
 	.index_version = -1, \
+	.trust_executable_bit = 1, \
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
-- 
2.43.0

