Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5013AF2
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772391633; cv=none; b=qm4gCOcggFaUGVw/UcNQsAP0YKPnIUGoSOhlzXnnQozZBSl7lVvH2zD05HnewrqNdNZzzQ/3q2xp7T156swn75FWPZ3zqklhllnXX7I01qTzextOhCCQ7SqcOa2SSSczZdHxutgggexybTNy/7cSL4vxbhzhp4qatLqYDqB/ttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772391633; c=relaxed/simple;
	bh=j2oJhEHWN3PQL4XJvTN7aIp5mYukKygJ+LdYPWg3GZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNQfqsxEwRk+Kk8CyVa1tCzqnq6IGAr6Br2cZ/8E60fZgbFO0bjoLRH9d2jOIt119uLx59k01RXa4H8wzGRJ9MVc03lUu4LDvLYz1KDMefr+A3tsjJ5YPIYPxDsO0OWKOVpDvXB305tcVel+hoehleE+hwMslm2IZkDZGpnz9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRXEe/Qa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRXEe/Qa"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81df6a302b1so4106467b3a.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772391631; x=1772996431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1eDa+gW7Vmvo2kU59wMjklwSiirzX8YRGDs+Bnnhwac=;
        b=eRXEe/Qa5lfk9Z1loZogO86N9MgJAvD4DG34Mjgw1rbUSIjuH4WBaQSkQfplLoNiwl
         ReiX4j7mX/basgVA85etQeycMYWL8tBDNidLSmFjF/EF9m3Aan3KN/PDHJKfcuzqhlFA
         N9P/r2RVHy7qItS1mUdsJV7aOjQI0Q6mVdmlN4/cIaY9BlpTW7UJcOZ1f6QEfBv3rIQ4
         E80w9lmLxBUG7WK6iDvkjll4+e8PDJs+yYAa+Ta7ajKuJ3kWx8fKvtha8uW6yBrO2fiY
         WWZL2U0z25kJwykgJzMsOHwWNX4pVvPApL+itnrKcT5F3HlaWdj+8bypI+hSBobvaVuG
         CSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772391631; x=1772996431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eDa+gW7Vmvo2kU59wMjklwSiirzX8YRGDs+Bnnhwac=;
        b=BlPXoE3eJsJRQqlYBJhFgmCoxVuwPu2wiqlbz7n7yp9LZU4bWcG3Mf97Ya4dKL2yvA
         jsbJCvkuwHgJ1TB8fq5Glc/SMjzpvyaoikIQtR/dvZtTA8zCqD+l+UMr2Ycisli20CWV
         ZBTKXZT6Tv/HanSj71GkLm6GgEvQoQ53esa++A4fptRtZal3AXGC+zejZUxP00vxgHkF
         avnKHAOoQNn+cMJ6amLgNfGUED0NDYUn22Yc6ob3N+sWFrDVAC+SV643o9kRP5BF1zKV
         ti+c32FlwJrHtcVJDE3jTmlnR/wE6XNaDbR/9svEHIhfBtncBvTIKJ93X9cTV57PT7Ok
         GZ4w==
X-Gm-Message-State: AOJu0YzBH5YKWP5Ny8tsi5gfp2bL+uz4IkXPrq9YW/oiY78NJAdfrqa1
	qh7qEZGnS0lBvGUWR2w30ns5IN+HW+mD6PxO1UkTaSIsocoCVBGPrgzBvqb5nQ==
X-Gm-Gg: ATEYQzzR1LgBzi1LZHwMmhnHJpFHc0QtG6OZeSsp/5F7zSMkVwMfCGaqFHU4qOMJNyC
	PWtBZrnyjsu679Ffu8yNVX6+GMH1joXdOoVzYVlhKJBoddYiLXcdRWgMV1AP8TIjh7td5p7v1xm
	0y1KZEk0JkwhFpgzC8rRYStLZDUBqhizt7qBA0CsNCS+nPSCD2pJrj5PcC9or0dkXhcMh3YEPq9
	gmJOzUxuTnck0QnP4/lP9pV5dWMEcd2M7fGUJUw9OBUXI4AuKm0Oc99futaXnZcnHiG8bTmOtgM
	JHqwKvFOPqUpY1/OoGnrrXmg26RVlLaL5Du1wMu1a1+dlSjwCLMPC4HIVdje2GHjRXJaHlBsRmn
	CwO5RnN9+bFRXKm0j5IuuHagUmwWHOqXozCPiZYyLM3oalGkFgEotaAfCH0xUSlZRG4kAzkaajH
	8NBWzcOk3oEIqlJPU1c+CrtI62r7dWxC//dOQ=
X-Received: by 2002:a05:6a20:94cf:b0:394:f780:a18f with SMTP id adf61e73a8af0-395c3b0f767mr9291195637.56.1772391630971;
        Sun, 01 Mar 2026 11:00:30 -0800 (PST)
Received: from dorna-OEM.. ([103.152.144.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f25esm120150775ad.47.2026.03.01.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 11:00:30 -0800 (PST)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH] Refactor 'trust_executable_bit' to repository-scoped setting
Date: Mon,  2 Mar 2026 00:44:49 +0545
Message-ID: <20260301190017.53539-1-dronarajgyawali@gmail.com>
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

