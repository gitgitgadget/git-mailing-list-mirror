Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785806;
	b=3cuAqSad1iEmnCkk5C79+OOOKV5Q8dQv3xiR+VGVV0nen0aZNR1CniHQbfSV0us2SOYG
	 bX0tGaR7BhHnsa2GYjRCcvRdfkf3v26g5EzOPRhc5niFML0WvYqgtCXtj28TLC0tbgDvj
	 DfP7GFJYoD+m5CvD53ZaaVf9hYGit2Phzi49sar9Fkl5Po85oTezEGIlgTU66/gCeKKaO
	 sJn0VtpGhMk8Nli0i3ZAcG3XQ7eMLvnI6sdWl/8nngvatKiB2inRmKvzHXUvN2MpvKJ1J
	 3dTSAYaeuAKdZhUvHQVD5UdkVAi72c4BX4//Xn3F2ePg55eSU00DaYp7eT+7XhluuDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=seOcNg/fERzNYYFOQqOuC+CC+i541xeT//n8PzyPibY=;
	b=n8oMmsA35oZKp2TNWnqj2l4Ts12eXUOC0lQhRSigxBxv/S34kSf8YGHe2hAjfPco6Gds
	 Xiug3xy5nCF1jid4lD7O5RzmKwAPtLtDql/cCIjrOBE0edLlfmcue/cpWjomSglRJ2GIZ
	 K2un+Y8V833cl9eVg1o0U9EqwnpelqZii6R4yAcOKS3ymqgIPMHTfsEm80LgF6dZRf4MG
	 gVjJEFWyZHEZl40/ftqKsJFLW0YFHD0/cgoSTBpTBwq7wS37WtL70Y3OyKm6MmelDi8/4
	 b710JOd/CrTZ9wyHdimBPw5H2f/FDm4lvtkOi5gnrrhY6I89KnY20hjKynJv6Qw5Kqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IyMoKfVm;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341C60A261C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 20:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3341C60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IyMoKfVm
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f1e5d7450so113960285a.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785805; x=1793390605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seOcNg/fERzNYYFOQqOuC+CC+i541xeT//n8PzyPibY=;
        b=IyMoKfVm3R/Y6Vs7fYw5fwZnUGf2WaPJhlZ+i9A7gTS5aGGsvLzbJzl79K7u03lwcx
         PKkT8mIbrceoPirU5UbbVI9RrIZEx54MOOftYZnFFXrthRpq42LSCslzXMhRIf51Oy1/
         bx0MB75sVFtTJzYjXLU1atcBqUa1GKUygEwRjTTqkIJxrXHPdRiF6BKF1XKxM0LUWpOa
         uxbC2yQX2eBVwPUz0Euk7R2LdGVZLDNkB79AaLYC6/K72e6qe88F/HCEp1grf8LE+sWD
         F1kY3riTQ9bJngVzxW3ZBAimZ8nRwwQNa+QMiIa+7POZc6YeFaCE97QgvhhIksvpRfqq
         +AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785805; x=1793390605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seOcNg/fERzNYYFOQqOuC+CC+i541xeT//n8PzyPibY=;
        b=ljViNsfruJBgvyM08Op3f6U1TVW52jzRYVllVq8lMehGTtfBWzz+frlep4pElRKQxo
         +EaGDfB5RJWhUPxownXyClT0g/dk40Rx6QZWkjkSIzM9nOBsVpfhZ3rc6vvpF7AFCxxg
         SZp56GpNEJWJvr+MQsvvsRustUonF2JH7UbhyaPOxMlfD/fkoZMHyUekjYzjNNOMUYN/
         VZ1fbA8olKecOv4IdP+s81O1OS7Zy+we2MTl1hwuTKBhhp4zV+RASO4qLFivSGiIHJx4
         MDwclDbG+mst1FN02JKjKfKfELSvse79T9Jz7Ad3lcGfdEJSGxl3uYp5jUJ6Rw2Ih13P
         yKpg==
X-Gm-Message-State: AFq9FYJnMTThbiTjNCCpzSCsGY85fDpGWAr9gEuCHLNBhJadHXn00teF
	wASQx+kcdv0EbVla8LizcwFpf5bzli9pxAWvA/KeUMYKe0gSGOzDkn+R9A/GTg==
X-Gm-Gg: AYBFou0Jo4Q+/pI2rplU0y6x8ZtcT56O11RPr/DzQfhdF0MI3va/TWWSwohueAvbsax
	3QMIvywLq1oWWdRdJWtKcGDSGhhcFJaq8Os/Qiy5MJKOO4B4DrOMDmN8QujDwiuvLFWri7R4HEO
	FAnNvU4ONem2rsAdFsQzz0ijorUM5u8CC44P3KQCpaIgxrqLGiDnE4ogACSIFDoltCq9vJpJj8Y
	avoMGJdwIVAlh6eH8phzuAxpTTIV0X69W0ICaJYMkGw0sI+lF7sBzyRXIZiuZbO+ROwez5fhJoG
	rBjFkUkHsBgJtT+4kyZ4fBi1ujqNxp2lSAnweZIc5pkY33Iz683JFb8l2GwuGh5QT3fkZu87dUR
	sLto8A5G89jsKbdQ3XoCldv6NNJKuvzWjpfb9Oc67hKdVBAi49ny9T5GxUDTbb8g4U3u/3UflTr
	4yQTj4QSI/lDd+lhwCfNsJduBFXQLOFy/+7nf//Muk5Zm4+7PFQeH2UEq6Ayo6T063SxKFbaniU
	KNNFtTJVmLHafQf1yn6wB+hLcaZ4dk6q9s9uDGFWJZEaFwg+vYdguuYBv+2RvNrOxCK5bec90wT
	tEPCogx2KTfnlryDjZK+hygIcc31elvVdRcwqMIWpz9QdbTzu34kknVnR7BNPZqnmg7ItPsiqm6
	e6hICfCEC8RT1ftkUpuew7y9kGGSy+3Sb3rZEktCHpY1eT7Sx8vQs3SOJ4PqapJ5UNYVTeFTNhX
	E9pVjAGGHBm7hRuZJpfrpVabQ0tEUF5KUNrZw5
X-Received: by 2002:a05:620a:2b4e:b0:939:6de9:4cff with SMTP id af79cd13be357-940ef946394mr15293485a.45.1792785804961;
        Fri, 23 Oct 2026 13:03:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9402ee2cbffsm104288785a.2.2026.10.23.13.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:03:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 23 Oct 2026 16:03:06 -0400
Subject: [PATCH v3 3/3] ls-files: use and update the untracked cache
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-ls-files-untracked-cache-v3-3-292260e95f53@gmail.com>
References: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
In-Reply-To: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1792785794; l=18305;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=IGjRCUv78q6MGHEKQJM2fdFccSZBc/bLr5SyN1/6GdA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJEztEDEh3IUFqsDp/YLQrGz/8PxFoeKEyvF3BS36GJ/Zgn68DodHjIRn/DZgOICw1fkAlfWu+8
 RxMuUJXULKQc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Repeated 'git ls-files --cached --others --exclude-standard' calls scan
the working tree even when 'git status' has populated an untracked cache.
Reuse those listings and write pending untracked cache and fsmonitor
updates back to the index when optional locking is enabled, so later
commands can reuse the work.

Parse options before reading the index so eligible calls can take the
optional lock first. With index.skipHash, the index checksum cannot be
used to detect concurrent index changes. Record the object IDs of the
standard exclude files before assigning dir->untracked, so the exclude
options can be processed in the same order before reading the index.

A pathspec prefix can prune the in-memory index, and --with-tree can add
entries to it. Do not write the index in those cases or with --debug,
which prints stat data that an index write can change. Respect
--no-optional-locks and continue without writing when the lock is busy.

Finish the optional update after the directory walk and before printing
paths, so a slow reader cannot block another index writer.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/git-ls-files.adoc    |   4 ++
 builtin/ls-files.c                 |  59 +++++++++++++------
 dir.c                              |  28 +++++----
 t/perf/p3010-ls-files.sh           |  15 +++++
 t/t3001-ls-files-others-exclude.sh |  20 +++++++
 t/t7063-status-untracked-cache.sh  | 113 +++++++++++++++++++++++++++++++++++++
 t/t7519-status-fsmonitor.sh        |  44 +++++++++++++++
 7 files changed, 252 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-ls-files.adoc b/Documentation/git-ls-files.adoc
index 2b175388e1..11323b4ba9 100644
--- a/Documentation/git-ls-files.adoc
+++ b/Documentation/git-ls-files.adoc
@@ -127,6 +127,10 @@ OPTIONS
 --exclude-standard::
 	Add the standard Git exclusions: .git/info/exclude, .gitignore
 	in each directory, and the user's global exclusion file.
++
+With `--others`, an enabled untracked cache can be updated in the index
+after a complete traversal. Use `--no-optional-locks` (see linkgit:git[1])
+to disable this optional index update.
 
 --error-unmatch::
 	If any <file> does not appear in the index, treat this as an
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b044520f9e..a32dd1d36f 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -15,6 +15,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "gettext.h"
+#include "lockfile.h"
 #include "object-name.h"
 #include "strbuf.h"
 #include "parse-options.h"
@@ -403,16 +404,10 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 	int i;
 	struct strbuf fullname = STRBUF_INIT;
 
-	/* For cached/deleted files we don't need to even do the readdir */
-	if (show_others || show_killed) {
-		if (!show_others)
-			dir->flags |= DIR_COLLECT_KILLED_ONLY;
-		fill_directory(dir, repo->index, &pathspec);
-		if (show_others)
-			show_other_files(repo->index, dir);
-		if (show_killed)
-			show_killed_files(repo->index, dir);
-	}
+	if (show_others)
+		show_other_files(repo->index, dir);
+	if (show_killed)
+		show_killed_files(repo->index, dir);
 
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
@@ -597,6 +592,8 @@ int cmd_ls_files(int argc,
 	struct dir_struct dir = DIR_INIT;
 	struct pattern_list *pl;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct lock_file index_lock = LOCK_INIT;
+	int index_fd = -1;
 	struct option builtin_ls_files_options[] = {
 		/* Think twice before adding "--nul" synonym to this */
 		OPT_SET_INT('z', NULL, &line_terminator,
@@ -678,14 +675,13 @@ int cmd_ls_files(int argc,
 		prefix_len = strlen(prefix);
 	repo_config(repo, git_default_config, NULL);
 
-	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
-	pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
-	for (i = 0; i < exclude_list.nr; i++) {
-		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
+	/* Even an empty command-line exclude list would disable the cache. */
+	if (exclude_list.nr) {
+		pl = add_pattern_list(&dir, EXC_CMDL, "--exclude option");
+		for (i = 0; i < exclude_list.nr; i++)
+			add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
 
 	if (format && (show_stage || show_others || show_killed ||
@@ -747,6 +743,26 @@ int cmd_ls_files(int argc,
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
+	/*
+	 * Do not save an index pruned by a pathspec or changed by --with-tree.
+	 * --debug shows stat data that writing the index can change.
+	 * With index.skipHash, the checksum cannot detect concurrent index
+	 * changes. Lock the index before reading it.
+	 */
+	if (show_others && !dir.flags && dir.exclude_per_dir &&
+	    !max_prefix && !with_tree && !debug_mode && use_optional_locks() &&
+	    !dir.internal.unmanaged_exclude_files && !exclude_list.nr &&
+	    repo->settings.core_untracked_cache != UNTRACKED_CACHE_REMOVE)
+		index_fd = repo_hold_locked_index(repo, &index_lock, 0);
+	if (repo_read_index(repo) < 0)
+		die("index file corrupt");
+	if (show_others && !dir.flags && dir.exclude_per_dir && !with_tree)
+		dir.untracked = repo->index->untracked;
+	if (index_fd >= 0 && !dir.untracked) {
+		rollback_lock_file(&index_lock);
+		index_fd = -1;
+	}
+
 	prune_index(repo->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
@@ -774,6 +790,17 @@ int cmd_ls_files(int argc,
 		overlay_tree_on_index(repo->index, with_tree, max_prefix);
 	}
 
+	if (show_others || show_killed) {
+		if (!show_others)
+			dir.flags |= DIR_COLLECT_KILLED_ONLY;
+		fill_directory(&dir, repo->index, &pathspec);
+	}
+
+	/* Don't hold the index lock while writing paths to stdout. */
+	if (index_fd >= 0 && dir.untracked)
+		repo_update_index_if_able(repo, &index_lock);
+	rollback_lock_file(&index_lock);
+
 	show_files(repo, &dir);
 
 	if (show_resolve_undo)
diff --git a/dir.c b/dir.c
index 425fe2af67..949f06c8f7 100644
--- a/dir.c
+++ b/dir.c
@@ -1209,7 +1209,8 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 		close(fd);
 		if (oid_stat) {
 			int pos;
-			if (oid_stat->valid &&
+			/* Racy stat checks need the index timestamp. */
+			if (istate && oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
 				; /* no content change, oid_stat->oid still good */
 			else if (istate &&
@@ -1321,18 +1322,15 @@ struct pattern_list *add_pattern_list(struct dir_struct *dir,
 }
 
 /*
- * Used to set up core.excludesfile and .git/info/exclude lists.
+ * Only the standard exclude files have object IDs saved in the untracked
+ * cache. Other files have no oid_stat and must disable use of the cache.
  */
 static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 				     struct oid_stat *oid_stat)
 {
 	struct pattern_list *pl;
-	/*
-	 * catch setup_standard_excludes() that's called before
-	 * dir->untracked is assigned. That function behaves
-	 * differently when dir->untracked is non-NULL.
-	 */
-	if (!dir->untracked)
+
+	if (!oid_stat)
 		dir->internal.unmanaged_exclude_files++;
 	pl = add_pattern_list(dir, EXC_FILE, fname);
 	if (add_patterns(fname, "", 0, pl, NULL, 0, oid_stat) < 0)
@@ -1341,7 +1339,6 @@ static void add_patterns_from_file_1(struct dir_struct *dir, const char *fname,
 
 void add_patterns_from_file(struct dir_struct *dir, const char *fname)
 {
-	dir->internal.unmanaged_exclude_files++; /* see validate_untracked_cache() */
 	add_patterns_from_file_1(dir, fname, NULL);
 }
 
@@ -3009,10 +3006,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/*
 	 * We only support $GIT_COMMON_DIR/info/exclude and core.excludesfile
-	 * as the global ignore rule files. Any other additions
-	 * (e.g. from command line) invalidate the cache. This
-	 * condition also catches running setup_standard_excludes()
-	 * before setting dir->untracked!
+	 * as the global ignore rule files. Other exclude files bypass the cache.
 	 */
 	if (dir->internal.unmanaged_exclude_files)
 		return NULL;
@@ -3511,17 +3505,21 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 	dir->exclude_per_dir = ".gitignore";
 
+	/*
+	 * Option parsing may precede reading the index. Record the object IDs
+	 * even before the untracked cache is available for validation.
+	 */
 	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 		add_patterns_from_file_1(dir, excludes_file,
-					 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
+					 &dir->internal.ss_excludes_file);
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
 		const char *path = git_path_info_exclude();
 		if (!access_or_warn(path, R_OK, 0))
 			add_patterns_from_file_1(dir, path,
-						 dir->untracked ? &dir->internal.ss_info_exclude : NULL);
+						 &dir->internal.ss_info_exclude);
 	}
 }
 
diff --git a/t/perf/p3010-ls-files.sh b/t/perf/p3010-ls-files.sh
index ae14449432..bdf398906f 100755
--- a/t/perf/p3010-ls-files.sh
+++ b/t/perf/p3010-ls-files.sh
@@ -28,4 +28,19 @@ test_perf 'ls-files --modified with pathspec' '
 		-- "$pathspec" >/dev/null
 '
 
+test_perf 'ls-files --others with pathspec and no untracked cache' '
+	git -c core.fsmonitor=false -c core.untrackedCache=false \
+		ls-files --cached --others --exclude-standard -- "$pathspec" >/dev/null
+'
+
+test_expect_success 'populate the untracked cache with ls-files' '
+	git config core.untrackedCache true &&
+	git -c core.fsmonitor=false ls-files --others --exclude-standard >/dev/null
+'
+
+test_perf 'ls-files --others with pathspec and untracked cache' '
+	git -c core.fsmonitor=false ls-files --cached --others \
+		--exclude-standard -- "$pathspec" >/dev/null
+'
+
 test_done
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 29a0a25b30..5ca80932ac 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -306,4 +306,24 @@ test_expect_success 'ls-files with "**" patterns and no slashes' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'ls-files preserves repeated and ordered exclude options' '
+	test_create_repo exclude-options &&
+	(
+		cd exclude-options &&
+		touch keep info-hidden global-hidden &&
+		echo info-hidden >.git/info/exclude &&
+		echo global-hidden >.git/global-ignore &&
+		git config core.excludesFile .git/global-ignore &&
+		echo "!info-hidden" >.git/custom-ignore &&
+		echo keep >../expect &&
+		git ls-files --others --exclude-from=.git/custom-ignore \
+			--exclude-standard --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		git ls-files --others --exclude-standard \
+			--exclude-from=.git/custom-ignore >../actual &&
+		printf "%s\n" info-hidden keep >../expect &&
+		test_cmp ../expect ../actual
+	)
+'
+
 test_done
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 2efbb93b71..1a0a77e265 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -1016,6 +1016,9 @@ test_expect_success 'untracked cache handles nested repository changes' '
 		echo "?? nested/" >../expect &&
 		test_cmp ../expect ../actual &&
 		rm -rf nested/.git &&
+		git ls-files --others --exclude-standard >../actual &&
+		echo nested/file >../expect &&
+		test_cmp ../expect ../actual &&
 		git status -uall --porcelain >../actual &&
 		echo "?? nested/file" >../expect &&
 		test_cmp ../expect ../actual &&
@@ -1048,4 +1051,114 @@ test_expect_success 'filtered status retains complete untracked listings' '
 	)
 '
 
+test_expect_success 'ls-files expands cached directories and filters wildcard results' '
+	test_create_repo ls-files-cache &&
+	(
+		cd ls-files-cache &&
+		git config core.untrackedCache true &&
+		mkdir tracked untracked empty ignored-only &&
+		touch tracked/pyproject.toml untracked/pyproject.toml &&
+		touch untracked/other ignored-only/file &&
+		echo ignored-only/file >.gitignore &&
+		echo "*.toml selected" >.gitattributes &&
+		git add .gitignore .gitattributes tracked &&
+		git init nested.git &&
+		test-tool chmtime =-300 . tracked untracked empty ignored-only &&
+		git status -unormal --porcelain >/dev/null &&
+		# Complete the partial listing, then reuse it without opening directories.
+		for opened in 1 0
+		do
+			: >"$TRASH_DIRECTORY/ls-files.trace" &&
+			GIT_TRACE2_PERF="$TRASH_DIRECTORY/ls-files.trace" \
+				git ls-files --cached --others --exclude-standard -z \
+				-- "**/pyproject.toml" >../actual &&
+			printf "%s\0" untracked/pyproject.toml tracked/pyproject.toml \
+				>../expect &&
+			test_cmp ../expect ../actual &&
+			test_grep "read_directo.*opendir:$opened\$" \
+				"$TRASH_DIRECTORY/ls-files.trace" &&
+			test_grep "read_directo.*gitignore-invalidation:0\$" \
+				"$TRASH_DIRECTORY/ls-files.trace" || return 1
+		done &&
+		for pathspec in "*.git/" ":(glob)**/*.toml" \
+			":(exclude)untracked/" ":(attr:selected)**/*.toml"
+		do
+			GIT_DISABLE_UNTRACKED_CACHE=1 git ls-files --others \
+				--exclude-standard -- "$pathspec" >../expect &&
+			git ls-files --others --exclude-standard \
+				-- "$pathspec" >../actual &&
+			test_cmp ../expect ../actual || return 1
+		done
+	)
+'
+
+test_expect_success 'ls-files cache is reused after status -unormal' '
+	test_create_repo persistent-cache &&
+	(
+		cd persistent-cache &&
+		mkdir tracked untracked &&
+		touch tracked/a tracked/b untracked/a untracked/b &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		test-tool chmtime =-300 . tracked untracked &&
+		git ls-files --others --exclude-standard >../actual &&
+		printf "%s\n" untracked/a untracked/b >../expect &&
+		test_cmp ../expect ../actual &&
+		git status --porcelain >../actual &&
+		echo "?? untracked/" >../status-expect &&
+		test_cmp ../status-expect ../actual &&
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/persistent.trace" \
+			git ls-files --others --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		test_grep "read_directo.*opendir:0\$" "$TRASH_DIRECTORY/persistent.trace"
+	)
+'
+
+test_expect_success 'ls-files respects optional locks and a busy index lock' '
+	test_when_finished "rm -f persistent-cache/.git/index.lock" &&
+	(
+		cd persistent-cache &&
+		touch untracked/new &&
+		cp .git/index ../saved-index &&
+		git --no-optional-locks ls-files --others --exclude-standard >../actual &&
+		test_cmp_bin ../saved-index .git/index &&
+		printf "%s\n" untracked/a untracked/b untracked/new >../expect &&
+		test_cmp ../expect ../actual &&
+		touch .git/index.lock &&
+		git ls-files --others --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		test_cmp_bin ../saved-index .git/index
+	)
+'
+
+test_expect_success 'ls-files does not write the index with a pathspec prefix or --with-tree' '
+	(
+		cd persistent-cache &&
+		cp .git/index ../saved-index &&
+		git ls-files --cached --others --exclude-standard -- tracked/a >../actual &&
+		test_cmp_bin ../saved-index .git/index &&
+		git rm --cached tracked/b &&
+		cp .git/index ../saved-index &&
+		git ls-files --cached --others --exclude-standard --with-tree=HEAD >../actual &&
+		test_cmp_bin ../saved-index .git/index
+	)
+'
+
+test_expect_success 'ls-files --debug shows the stat data read from the index' '
+	(
+		cd persistent-cache &&
+		git config core.trustctime false &&
+		printf one >tracked/racy &&
+		test-tool chmtime =1000000000 tracked/racy &&
+		git add tracked/racy &&
+		printf two >tracked/racy &&
+		test-tool chmtime =1000000000 tracked/racy .git/index &&
+
+		git --no-optional-locks ls-files -co --exclude-standard --debug >../expect &&
+		git ls-files -co --exclude-standard --debug >../actual &&
+		test_cmp ../expect ../actual
+	)
+'
+
 test_done
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 93973ed25a..8feca101ab 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -477,4 +477,48 @@ test_expect_success 'status succeeds with sparse index' '
 	)
 '
 
+test_expect_success UNTRACKED_CACHE 'ls-files saves the fsmonitor token with index.skipHash' '
+	test_create_repo ls-files-fsmonitor &&
+	(
+		# index.skipHash gives shared indexes a null OID, so they cannot
+		# be reloaded.
+		sane_unset GIT_TEST_SPLIT_INDEX &&
+		cd ls-files-fsmonitor &&
+		touch tracked &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		git config index.skipHash true &&
+		git config core.fsmonitor .git/hooks/fsmonitor-test &&
+		test_hook --setup fsmonitor-test <<-\EOF &&
+		printf "initial-token\0/\0"
+		EOF
+		mkdir untracked &&
+		touch untracked/first &&
+		git status --porcelain >/dev/null &&
+		test_hook --clobber fsmonitor-test <<-\EOF &&
+		test -f .git/index.lock || exit 1
+		printf "%s\n" "$2" >.git/query-token
+		printf "next-token\0"
+		if test "$2" != next-token
+		then
+			printf "untracked/second\0"
+		fi
+		EOF
+		touch untracked/second &&
+		git ls-files --others --exclude-standard >../actual &&
+		printf "%s\n" untracked/first untracked/second >../expect &&
+		test_cmp ../expect ../actual &&
+		echo initial-token >../token-expect &&
+		test_cmp ../token-expect .git/query-token &&
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/ls-files-fsmonitor.trace" \
+			git ls-files --others --exclude-standard >../actual &&
+		test_cmp ../expect ../actual &&
+		echo next-token >../token-expect &&
+		test_cmp ../token-expect .git/query-token &&
+		test_grep "read_directo.*opendir:0\$" \
+			"$TRASH_DIRECTORY/ls-files-fsmonitor.trace"
+	)
+'
+
 test_done

-- 
2.56.0.1134.g47ee84b154.frankengit

