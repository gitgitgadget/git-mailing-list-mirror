Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7517D354
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734063982; cv=none; b=kwVVdWWpOaSlCicrS6hL2M95A7DKbygNRcrSfRZIczcMDCkEMUodzpFFjnf5DUs2EskvP1ezJWlov0cnimDn0BfP9J4gyuSnkvNeUyK4vVNEFhaN4ODVP8XwoSPUu+GfAFa528lAYrTVSn3ek75vdFHw0/7+Ib3ywrb8Og566Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734063982; c=relaxed/simple;
	bh=573bKO2REi3VoKQVFJplx+2CaqCysWJc97/q9bDDDVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoSRrZ1JKeXF05LGhUIHG2eOgqA2rIbQnJ4vfvod8xW5MaPGPdadMSYxpzxZxmVxnbphYwcZ98Z4dFesNkpmtEyaLqozU3wK5QFpV31UJuJjTTaIM5SlLlk2hX7JCGaePfc2cyzEerO4t4KSeXSHHQDvU5ALGcSRWa06rWkKXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGWSQoRS; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGWSQoRS"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e19fee3b3so1327725a34.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2024 20:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734063978; x=1734668778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s3xBCRRs8858Gjcl2hldTuTtDrLnDh3ESFa4dkcFKc=;
        b=ZGWSQoRSLjJPFoc79sn+GaY7/edStY3fBVFGMydmBZRtbMLQmOT16kzSayL9LNmHvO
         WIltW7cioZpANrv7g6ui16EqgoPhTOuTBHCyN4KtCCYQ/AnPpDNB18ITyg0Afe0E39Ha
         Wqj6AdjSb+5V+6/1kEhTWVKF/Yju6WyFeCenkfAoL3bJvCGXTKOLOPPdi2rniVBhymOR
         2ZgnXqg2JLOGAmOxWEqf/u71DohZLOeqX4LHJNK66lIjro44g8b8jkW/Chrg5OTtexJk
         S8VAWnfdexQrK5nCooGo0hqaMRC17wP0h1gLbeq3dZYcDGSV8x5YAHLfVM4w4rCAJPCw
         HSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734063978; x=1734668778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s3xBCRRs8858Gjcl2hldTuTtDrLnDh3ESFa4dkcFKc=;
        b=pjt7LyHIHpc8RnzpER0ifU6uEzrrP8gm/NsJ+ElQ25oKlai0fWp2lffQ8n5vu2X9m4
         zki+FYOgTWYZIs/13NKDtQVEoTVxewA50LcneXqRL8RmQOtO5KNleoTrpRj6DWGn/JvP
         osQQvZKQuLNHF02S2FpdTKYkfvMXmYCjkJLKq6UM7qT1VY66ju71ArHCp0Cw9AL//oYf
         dmO51EsGgXmxTUQbSD2C7V0rZ6q4r/iPGIViwYfTER+HVMw5V/I/Hjdy7vugIYSwHRRT
         fr4lX2VFkJyFHsSGH0kMuJL7EeIMSf93i03eD/7dihkiqH0iMn/34q6ng5O1KGYSYs2x
         KNBg==
X-Gm-Message-State: AOJu0YykLNSZoKCA+f92r8LX4M3izaJzD5EMgawD2CGDuToIV569Pp/I
	h0X8nc7cQYYVh16V3gD36yaOEyv55HOVhQ57JXpgNbm84Mn93xE2cf6h+A==
X-Gm-Gg: ASbGncu7YgMzRp31J8X+Eybr+ZzzgJUak+q+FI02yHRN368CzPzvWix4g89FwOOhsaF
	x2fpEvNN9sDkJQB6SylFNiJbjwXmbJ6ewdA52KIYlWmaNPHNuDjDAHCUo7WMgFIPnNEyYCgOZzQ
	dB5x79bxYruuEpGChqCnqb9KacGeeR6ZGxTdTBHDl+cphFCtfV2qv8B3plVPWMFqWSX9WRI7D+3
	MePaMrGcX+eR12+zlYL8Oz9Htfr+KA6oH7FoiJKDn+O0yl3YfWu3f4jvqYKVj+6
X-Google-Smtp-Source: AGHT+IFCMpcoTFeV5OT5JV+6tGlkF9LXn+jvDGq1IkgIzj0gDkenDiRmuBXuO56eX3hp65b4ztAm0w==
X-Received: by 2002:a05:6830:348d:b0:71e:1511:5d7 with SMTP id 46e09a7af769-71e3bd43923mr465438a34.5.1734063977865;
        Thu, 12 Dec 2024 20:26:17 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e37410edfsm342736a34.67.2024.12.12.20.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:26:17 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/3] builtin: introduce diff-blob command
Date: Thu, 12 Dec 2024 22:23:10 -0600
Message-ID: <20241213042312.2890841-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213042312.2890841-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1), a single diff can be generated from a pair of blob
revisions directly. This is useful when more explicit control over the
set of diffs to compute is desired. Expanding on this, it would be
useful to also support generating multiple diffs for blob pairs provided
on stdin to faciliate batch processing in a single process. Batch blob
diff processing is likely considered more of a plumbing feature so,
instead of further extending the porcelain git-diff(1), a diff plumbing
command should be used.

As there is not an existing diff plumbing command that handles blob
diffs, introduce git-diff-blob(1) which generates a single diff between
a specified pair of blobs following how the same operation is done in
git-diff(1). While git-diff-blob(1) functionality is a direct subset of
git-diff(1), a subsequent patch extends it to provide a new plumbing
related feature.

The surrounding setup required for the new builtin is also added. An
existing test for blob diffs through git-diff(1) is also modified to
reuse its test cases for git-diff-blob(1).

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 .gitignore                      |   1 +
 Documentation/git-diff-blob.txt |  29 ++++++++
 Documentation/meson.build       |   1 +
 Makefile                        |   1 +
 builtin.h                       |   1 +
 builtin/diff-blob.c             | 117 ++++++++++++++++++++++++++++++++
 command-list.txt                |   1 +
 git.c                           |   1 +
 meson.build                     |   1 +
 t/t4063-diff-blobs.sh           | 100 ++++++++++++++-------------
 10 files changed, 205 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/git-diff-blob.txt
 create mode 100644 builtin/diff-blob.c

diff --git a/.gitignore b/.gitignore
index e82aa19df0..e7487072bd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@
 /git-daemon
 /git-diagnose
 /git-diff
+/git-diff-blob
 /git-diff-files
 /git-diff-index
 /git-diff-tree
diff --git a/Documentation/git-diff-blob.txt b/Documentation/git-diff-blob.txt
new file mode 100644
index 0000000000..732992d1d7
--- /dev/null
+++ b/Documentation/git-diff-blob.txt
@@ -0,0 +1,29 @@
+git-diff-blob(1)
+================
+
+NAME
+----
+git-diff-blob - Compares the content and mode of two specified blobs
+
+
+SYNOPSIS
+--------
+[verse]
+'git diff-blob' <blob> <blob>
+
+DESCRIPTION
+-----------
+Compare the content and mode of two specified blobs.
+
+OPTIONS
+-------
+<blob>::
+	The id of a blob object or path-scoped revision that resolves to a blob.
+
+include::pretty-formats.txt[]
+
+include::diff-format.txt[]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f2426ccaa3..1bf0a80419 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -39,6 +39,7 @@ manpages = {
   'git-daemon.txt' : 1,
   'git-describe.txt' : 1,
   'git-diagnose.txt' : 1,
+  'git-diff-blob.txt' : 1,
   'git-diff-files.txt' : 1,
   'git-diff-index.txt' : 1,
   'git-difftool.txt' : 1,
diff --git a/Makefile b/Makefile
index 06f01149ec..de2e43d4f6 100644
--- a/Makefile
+++ b/Makefile
@@ -1235,6 +1235,7 @@ BUILTIN_OBJS += builtin/credential-store.o
 BUILTIN_OBJS += builtin/credential.o
 BUILTIN_OBJS += builtin/describe.o
 BUILTIN_OBJS += builtin/diagnose.o
+BUILTIN_OBJS += builtin/diff-blob.o
 BUILTIN_OBJS += builtin/diff-files.o
 BUILTIN_OBJS += builtin/diff-index.o
 BUILTIN_OBJS += builtin/diff-tree.o
diff --git a/builtin.h b/builtin.h
index f7b166b334..383e78ca99 100644
--- a/builtin.h
+++ b/builtin.h
@@ -152,6 +152,7 @@ int cmd_diagnose(int argc, const char **argv, const char *prefix, struct reposit
 int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_diff_blob(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_env__helper(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/diff-blob.c b/builtin/diff-blob.c
new file mode 100644
index 0000000000..7cfa4eb436
--- /dev/null
+++ b/builtin/diff-blob.c
@@ -0,0 +1,117 @@
+#include "builtin.h"
+#include "config.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "gettext.h"
+#include "hash.h"
+#include "object.h"
+#include "parse-options.h"
+#include "revision.h"
+
+static void diff_blobs(struct object_array_entry *old_blob,
+		       struct object_array_entry *new_blob,
+		       struct diff_options *opts)
+{
+	const unsigned mode = canon_mode(S_IFREG | 0644);
+	struct object_id old_oid = old_blob->item->oid;
+	struct object_id new_oid = new_blob->item->oid;
+	unsigned old_mode = old_blob->mode;
+	unsigned new_mode = new_blob->mode;
+	char *old_path = old_blob->path;
+	char *new_path = new_blob->path;
+	struct diff_filespec *old, *new;
+
+	if (old_mode == S_IFINVALID)
+		old_mode = mode;
+
+	if (new_mode == S_IFINVALID)
+		new_mode = mode;
+
+	if (!old_path)
+		old_path = old_blob->name;
+
+	if (!new_path)
+		new_path = new_blob->name;
+
+	if (!is_null_oid(&old_oid) && !is_null_oid(&new_oid) &&
+	    oideq(&old_oid, &new_oid) && (old_mode == new_mode))
+		return;
+
+	if (opts->flags.reverse_diff) {
+		SWAP(old_oid, new_oid);
+		SWAP(old_mode, new_mode);
+		SWAP(old_path, new_path);
+	}
+
+	if (opts->prefix &&
+	    (strncmp(old_path, opts->prefix, opts->prefix_length) ||
+	     strncmp(new_path, opts->prefix, opts->prefix_length)))
+		return;
+
+	old = alloc_filespec(old_path);
+	new = alloc_filespec(new_path);
+
+	fill_filespec(old, &old_oid, 1, old_mode);
+	fill_filespec(new, &new_oid, 1, new_mode);
+
+	diff_queue(&diff_queued_diff, old, new);
+	diffcore_std(opts);
+	diff_flush(opts);
+}
+
+int cmd_diff_blob(int argc, const char **argv, const char *prefix,
+		  struct repository *repo)
+{
+	struct object_array_entry *old_blob, *new_blob;
+	struct rev_info revs;
+	int ret;
+
+	const char * const usage[] = {
+		N_("git diff-blob <blob> <blob>"),
+		NULL
+	};
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, usage,
+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
+
+	repo_config(repo, git_diff_basic_config, NULL);
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
+
+	repo_init_revisions(repo, &revs, prefix);
+	revs.abbrev = 0;
+	revs.diff = 1;
+	revs.disable_stdin = 1;
+
+	prefix = precompose_argv_prefix(argc, argv, prefix);
+	argc = setup_revisions(argc, argv, &revs, NULL);
+
+	if (!revs.diffopt.output_format)
+		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	switch (revs.pending.nr) {
+	case 2:
+		old_blob = &revs.pending.objects[0];
+		new_blob = &revs.pending.objects[1];
+
+		if (old_blob->item->type != OBJ_BLOB)
+			die("object %s is not a blob", old_blob->name);
+
+		if (new_blob->item->type != OBJ_BLOB)
+			die("object %s is not a blob", new_blob->name);
+
+		diff_blobs(old_blob, new_blob, &revs.diffopt);
+
+		break;
+	default:
+		usage_with_options(usage, options);
+	}
+
+	ret = diff_result_code(&revs);
+	release_revisions(&revs);
+
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index e0bb87b3b5..78d8308352 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -93,6 +93,7 @@ git-daemon                              synchingrepositories
 git-describe                            mainporcelain
 git-diagnose                            ancillaryinterrogators
 git-diff                                mainporcelain           info
+git-diff-blob                           plumbinginterrogators
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
diff --git a/git.c b/git.c
index 46b3c740c5..17c018ea36 100644
--- a/git.c
+++ b/git.c
@@ -540,6 +540,7 @@ static struct cmd_struct commands[] = {
 	{ "describe", cmd_describe, RUN_SETUP },
 	{ "diagnose", cmd_diagnose, RUN_SETUP_GENTLY },
 	{ "diff", cmd_diff, NO_PARSEOPT },
+	{ "diff-blob", cmd_diff_blob, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
diff --git a/meson.build b/meson.build
index 0dccebcdf1..fefb802c27 100644
--- a/meson.build
+++ b/meson.build
@@ -503,6 +503,7 @@ builtin_sources = [
   'builtin/credential.c',
   'builtin/describe.c',
   'builtin/diagnose.c',
+  'builtin/diff-blob.c',
   'builtin/diff-files.c',
   'builtin/diff-index.c',
   'builtin/diff-tree.c',
diff --git a/t/t4063-diff-blobs.sh b/t/t4063-diff-blobs.sh
index 50fdb5ea52..23615565fe 100755
--- a/t/t4063-diff-blobs.sh
+++ b/t/t4063-diff-blobs.sh
@@ -1,12 +1,14 @@
 #!/bin/sh
 
-test_description='test direct comparison of blobs via git-diff'
+test_description='test direct comparison of blobs via git-diff and git-diff-blob'
 
 . ./test-lib.sh
 
+commands="diff diff-blob"
+
 run_diff () {
 	# use full-index to make it easy to match the index line
-	git diff --full-index "$@" >diff
+	git $1 --full-index $2 $3 >diff
 }
 
 check_index () {
@@ -37,61 +39,63 @@ test_expect_success 'create some blobs' '
 	sha1_two=$(git rev-parse HEAD:two)
 '
 
-test_expect_success 'diff by sha1' '
-	run_diff $sha1_one $sha1_two
-'
-test_expect_success 'index of sha1 diff' '
-	check_index $sha1_one $sha1_two
-'
-test_expect_success 'sha1 diff uses arguments as paths' '
-	check_paths $sha1_one $sha1_two
-'
-test_expect_success 'sha1 diff has no mode change' '
-	! grep mode diff
-'
-
-test_expect_success 'diff by tree:path (run)' '
-	run_diff HEAD:one HEAD:two
-'
-test_expect_success 'index of tree:path diff' '
-	check_index $sha1_one $sha1_two
-'
-test_expect_success 'tree:path diff uses filenames as paths' '
-	check_paths one two
-'
-test_expect_success 'tree:path diff shows mode change' '
-	check_mode 100644 100755
-'
-
-test_expect_success 'diff by ranged tree:path' '
-	run_diff HEAD:one..HEAD:two
-'
-test_expect_success 'index of ranged tree:path diff' '
-	check_index $sha1_one $sha1_two
-'
-test_expect_success 'ranged tree:path diff uses filenames as paths' '
-	check_paths one two
-'
-test_expect_success 'ranged tree:path diff shows mode change' '
-	check_mode 100644 100755
-'
-
-test_expect_success 'diff blob against file' '
-	run_diff HEAD:one two
+test_expect_success 'diff blob against file (git-diff)' '
+	run_diff diff HEAD:one two
 '
-test_expect_success 'index of blob-file diff' '
+test_expect_success 'index of blob-file diff (git-diff)' '
 	check_index $sha1_one $sha1_two
 '
-test_expect_success 'blob-file diff uses filename as paths' '
+test_expect_success 'blob-file diff uses filename as paths (git-diff)' '
 	check_paths one two
 '
-test_expect_success FILEMODE 'blob-file diff shows mode change' '
+test_expect_success FILEMODE 'blob-file diff shows mode change (git-diff)' '
 	check_mode 100644 100755
 '
 
-test_expect_success 'blob-file diff prefers filename to sha1' '
-	run_diff $sha1_one two &&
+test_expect_success 'blob-file diff prefers filename to sha1 (git-diff)' '
+	run_diff diff $sha1_one two &&
 	check_paths two two
 '
 
+for cmd in $commands; do
+	test_expect_success "diff by sha1 (git-$cmd)" '
+		run_diff $cmd $sha1_one $sha1_two
+	'
+	test_expect_success "index of sha1 diff (git-$cmd)" '
+		check_index $sha1_one $sha1_two
+	'
+	test_expect_success "sha1 diff uses arguments as paths (git-$cmd)" '
+		check_paths $sha1_one $sha1_two
+	'
+	test_expect_success "sha1 diff has no mode change (git-$cmd)" '
+		! grep mode diff
+	'
+
+	test_expect_success "diff by tree:path (run) (git-$cmd)" '
+		run_diff $cmd HEAD:one HEAD:two
+	'
+	test_expect_success "index of tree:path diff (git-$cmd)" '
+		check_index $sha1_one $sha1_two
+	'
+	test_expect_success "tree:path diff uses filenames as paths (git-$cmd)" '
+		check_paths one two
+	'
+	test_expect_success "tree:path diff shows mode change (git-$cmd)" '
+		check_mode 100644 100755
+	'
+
+	test_expect_success "diff by ranged tree:path (git-$cmd)" '
+		run_diff $cmd HEAD:one..HEAD:two
+	'
+	test_expect_success "index of ranged tree:path diff (git-$cmd)" '
+		check_index $sha1_one $sha1_two
+	'
+	test_expect_success "ranged tree:path diff uses filenames as paths (git-$cmd)" '
+		check_paths one two
+	'
+	test_expect_success "ranged tree:path diff shows mode change (git-$cmd)" '
+		check_mode 100644 100755
+	'
+done
+
 test_done
-- 
2.47.1

