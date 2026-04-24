Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343C3D170D
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050582; cv=none; b=YIVRZpxhATb8N5eJsfiRC7aB0e0z/opMev70JNES++EuCEZNTqmSkTbK6jFUKra8eBM66Vx5xE/tzUvY5zUBQKF9PSdGIACQZGTuaWUCypE1PVsqDlEJochRFFAAp97YJExz2eScuRJsoSIdT+VHsOYod8SGouddZR/h6yI7P6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050582; c=relaxed/simple;
	bh=s/NaYgh7ecx94tSAHhpgpMR27gP4RpVzUwNvpOvE+/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gChipxJBsSZOlkvlawj7OFcUWBnl9phnLdktkXWb0rOEULfn0QyZll4nVeqEfxLGZg2S6XHcn6zwyb3LPp4DodalTNi/6pA1eK8Y5vp4QNU2hII8NTKGDTdGYRKf6b+lcy/xgjzs8mzuanixCO2bXASKcDu5vsq2c+KANxgQnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJM6eIqs; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJM6eIqs"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7b186dfc1d0so117734657b3.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050578; x=1777655378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nuT7ul/A1Isiv/NlZcHYB+10D/Zi6ammRrkqfWM66kQ=;
        b=AJM6eIqs4tH67+YoGrdl6FpzMF+K84nknJgKnT+YbopbQ/5fst4awrrOiFrUD5xY3g
         OGZ9W/yp/CpIuOG+onI4gLDl3AVbtgbEauFzCPLzz5+eThhcgV++GgRAnjufXsRJVUNL
         GByM1YF8KEBBYgX2648zfUXQmLi5/EbCBlsgtSWM2Ig7RSMHx1Dy+8Q09rejIIz7EXnM
         DlfY8ht/hELWhCXQPbUX21/3YI+B9gyYjgcvjsMUrqX8Pf+ZSTc5wJcY5fJo/IXc7omK
         QSHnEUbNHJEI96V9xf9YQ58OSwFORFMXCyLg2hK+R3pvou/cM2nCIjxl8oIdVEKEex7T
         4JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050578; x=1777655378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuT7ul/A1Isiv/NlZcHYB+10D/Zi6ammRrkqfWM66kQ=;
        b=WgIEJnqSomwAXd5EruTr7DTpTL7d1ngE8IqWTa8Cr8A9RgJ58paQA3p2SRmR0NRmvC
         SxRj0LjgLq0h5E55lZj/EnxXt4R6tV+gz49LiHJxWIaBkJuUS5bbLcKR3Aguu4aVXTd4
         JgS/jq7OY0ZX5/4NoqfSUD+2+VpMnXtaN9ACDRxnigWTitPwHEnmJlB4WQ8imUPFFceq
         //XwS+wUXz+mUvHi/twuqVFo6VQLm2KlwQuZJz2+7zRtQTvzVXYexF7M9OWYPD0OCJc+
         tg/RzniKFKfSp02awC1YSZa/Q8pNGCeNtlCdj2WV5dd58koFjIoZoyoeC/Ci/4H9uCen
         o3Yw==
X-Gm-Message-State: AOJu0Yzi2LKdf7p9u66uJr6AuHFTxQiWPm0FUb4oW88cEgGzpKF8X+wl
	fewrYoAUdL4FTrvYrdwh26Be8t6GxdcwOD0b4bRLeRnxsYwWK0rqj/BoJ5z8XCAN
X-Gm-Gg: AeBDiev145XmEPd8gbEEF1/O2uCufOx5dfaYJ/1Xl58ssVk/CGYqORPZ6cRHXkIYq9e
	0C23HAbLPUQBOtu62qqt4XJENGjBIAgHRhDIe/kHpaW81opDVVg8GwBiBPK3zNAFwjjOLRiZ6TB
	e7OBpBUNbd0uHvFFWiMRyDnpg/d8hdlxZh0M1Ndh/oMrDoVe0P2kcpDhX3QjHyBE7g1xRUbTAB4
	s3+4ZlMt2pECZj5YzZ7CuobLVgFm7tufavJYqK5VypnyQ7ID9QCr+L9evCpyMFmJovpPxPGjE4t
	pCSkhasC4DJ7YNRl8nyULejw0gZeYYsV0cT3I/e2AYOLck6TzaksZJwcfFciaNrdx6QVGoanuio
	82jLyRoClJFeIrGUKlk5MEphQqSz2wWnFYUgTqVkeK/QeT9l9btvHynQm5xW8BcZAs8zDLnfExh
	O7wYrN8EqIxOVG2Gp93LMWlshfSgpJC0+UziKZZxcp8on1Lw6Rl+QL23yt5AWMLTJlMilx1mAh9
	0deHG/8nZRVQGf0uIIFFF8Ar9sn
X-Received: by 2002:a05:690c:12:b0:79a:da8f:d26b with SMTP id 00721157ae682-7b9ed3d246cmr251077017b3.18.1777050578071;
        Fri, 24 Apr 2026 10:09:38 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90fb:c300::5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee89d76dsm94615057b3.4.2026.04.24.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:09:37 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Caleb White <cdwhite3@pm.me>,
	Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Andrew Berry <andrew@furrypaws.ca>,
	Jeff King <peff@peff.net>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH] dir: use per-worktree repository ignore patterns upon request
Date: Fri, 24 Apr 2026 13:09:19 -0400
Message-ID: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Today we have $GIT_DIR/info/exclude for the main worktree, but $(git
rev-parse --git-dir)/info/exclude for secondary worktrees does not
actually contribute to ignore specs; instead, secondary worktrees also
use $GIT_COMMON_DIR/info/exclude.

Some users may prefer each worktree use its own ignore file; some may
prefer both; some may prefer the current behavior.

Add, test, and document extensions.worktreeIgnore that controls which
set of ignore files to use for worktrees.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    Discussed briefly at https://lore.kernel.org/git/CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com/T

    This is based on next (4f69b47b94 (Merge branch 'ps/test-set-e-clean' into
    next, 2026-04-23)) but cleanly applies to master (94f057755b (Git 2.54,
    2026-04-19)) and seen (50541634cb (Merge branch
    'js/parseopt-subcommand-autocorrection' into seen, 2026-04-23)).

 Documentation/config/extensions.adoc |  7 ++++
 Documentation/git-worktree.adoc      |  3 ++
 Documentation/gitignore.adoc         |  6 ++--
 dir.c                                | 48 +++++++++++++++++++++++---
 t/meson.build                        |  1 +
 t/t2408-worktree-ignore.sh           | 50 ++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 6 deletions(-)
 create mode 100755 t/t2408-worktree-ignore.sh

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index be6678bb5b..5bfb06a54b 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -148,3 +148,10 @@ details.
 +
 For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
+
+worktreeIgnore:::
+	If enabled, then worktrees will load per-repository ignore files from
+	`$GIT_DIR/info/exclude` (that is,
+	`$GIT_COMMON_DIR/worktrees/<id>/info/exclude`). If set to `merge`, then
+	both `$GIT_COMMON_DIR/info/exclude` and `$GIT_DIR/info/exclude` are
+	used.
diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index fbf8426cd9..611c1e06b0 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -412,6 +412,9 @@ linkgit:gitrepository-layout[5] for details.
 When `extensions.worktreeConfig` is enabled, the config file
 `.git/worktrees/<id>/config.worktree` is read after `.git/config` is.
 
+See `extensions.worktreeIgnore` in linkgit:git-config[1] to control how
+per-repository ignore files are found in worktrees.
+
 LIST OUTPUT FORMAT
 ------------------
 The `worktree list` command has two output formats. The default format shows the
diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
index a3d24e5c34..d6976a44e4 100644
--- a/Documentation/gitignore.adoc
+++ b/Documentation/gitignore.adoc
@@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
 
 SYNOPSIS
 --------
-$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
+$XDG_CONFIG_HOME/git/ignore, $GIT_COMMON_DIR/info/exclude, .gitignore
 
 DESCRIPTION
 -----------
@@ -34,7 +34,9 @@ precedence, the last matching pattern decides the outcome):
    includes such `.gitignore` files in its repository, containing patterns for
    files generated as part of the project build.
 
- * Patterns read from `$GIT_DIR/info/exclude`.
+ * Patterns read from `$GIT_COMMON_DIR/info/exclude`. (See
+   `extensions.worktreeIgnore` in linkgit:git-config[1] to change how this
+   applies to worktrees.)
 
  * Patterns read from the file specified by the configuration
    variable `core.excludesFile`.
diff --git a/dir.c b/dir.c
index fcb8f6dd2a..9592eb0062 100644
--- a/dir.c
+++ b/dir.c
@@ -36,6 +36,7 @@
 #include "trace2.h"
 #include "tree.h"
 #include "hex.h"
+#include "worktree.h"
 
  /*
   * The maximum size of a pattern/exclude file. If the file exceeds this size
@@ -3478,6 +3479,23 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 }
 
 static GIT_PATH_FUNC(git_path_info_exclude, "info/exclude")
+static const char *git_worktree_info_exclude(void)
+{
+	static const char *ret;
+	if (!ret)
+	{
+		const struct worktree *wt = get_worktree_from_repository(the_repository);
+		ret = worktree_git_path(wt, "info/exclude");
+	}
+	return ret;
+}
+
+static void standard_exclude_from_info(const char *path, struct dir_struct *dir)
+{
+	struct oid_stat *oid_stat = dir->untracked ? &dir->internal.ss_info_exclude : NULL;
+	if (!access_or_warn(path, R_OK, 0))
+		add_patterns_from_file_1(dir, path, oid_stat);
+}
 
 void setup_standard_excludes(struct dir_struct *dir)
 {
@@ -3492,10 +3510,32 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 	/* per repository user preference */
 	if (startup_info->have_repository) {
-		const char *path = git_path_info_exclude();
-		if (!access_or_warn(path, R_OK, 0))
-			add_patterns_from_file_1(dir, path,
-						 dir->untracked ? &dir->internal.ss_info_exclude : NULL);
+		/* extensions.worktreeIgnore determines which includes we add */
+		const char *wt_ignore;
+		int do_wt_ignore;
+		if (repo_config_get_value(the_repository,
+					  "extensions.worktreeIgnore",
+					  &wt_ignore)) {
+			/* unset: use main/.git/info/exclude */
+			standard_exclude_from_info(git_path_info_exclude(), dir);
+			return;
+		}
+		do_wt_ignore = git_parse_maybe_bool(wt_ignore);
+		if (!do_wt_ignore) {
+			/* false: as above */
+			standard_exclude_from_info(git_path_info_exclude(), dir);
+		} else if (do_wt_ignore > 0 || !strcmp(wt_ignore, "worktree")) {
+			/* true/worktree: use worktree/.git‡/info/exclude
+			 * ‡: resolving .git */
+			standard_exclude_from_info(git_worktree_info_exclude(), dir);
+		} else if (!strcmp(wt_ignore, "merge")) {
+			/* merge both! worktree last */
+			standard_exclude_from_info(git_path_info_exclude(), dir);
+			standard_exclude_from_info(git_worktree_info_exclude(), dir);
+		} else {
+			die(_("invalid value for '%s': '%s'"),
+			      "extensions.worktreeIgnore", wt_ignore);
+		}
 	}
 }
 
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..30624b59e8 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -307,6 +307,7 @@ integration_tests = [
   't2405-worktree-submodule.sh',
   't2406-worktree-repair.sh',
   't2407-worktree-heads.sh',
+  't2408-worktree-ignore.sh',
   't2500-untracked-overwriting.sh',
   't2501-cwd-empty.sh',
   't3000-ls-files-others.sh',
diff --git a/t/t2408-worktree-ignore.sh b/t/t2408-worktree-ignore.sh
new file mode 100755
index 0000000000..67644ddd8d
--- /dev/null
+++ b/t/t2408-worktree-ignore.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='extensions.worktreeIgnore'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit init &&
+	git worktree add wt &&
+	echo main >.git/info/exclude &&
+	echo contents >main &&
+	echo contents >wt/main &&
+	wt_exclude="$(git -C wt rev-parse --git-dir)"/info/exclude &&
+	mkdir -p "$(dirname "$wt_exclude")" &&
+	echo worktree >"$wt_exclude" &&
+	echo contents >worktree &&
+	echo contents >wt/worktree
+'
+
+test_ignore_main() {
+	git check-ignore main &&
+	git -C wt check-ignore main
+}
+
+test_expect_success 'ignores main items by default' '
+	test_ignore_main
+'
+
+test_expect_success 'ignores main items with extensions.worktreeIgnore=no' '
+	test_config extensions.worktreeIgnore no &&
+	test_ignore_main
+'
+
+test_expect_success 'ignores worktree items with extensions.worktreeIgnore=worktree' '
+	test_config extensions.worktreeIgnore worktree &&
+	git check-ignore main &&
+	! git check-ignore worktree &&
+	! git -C wt check-ignore main &&
+	git -C wt check-ignore worktree
+'
+
+test_expect_success 'ignores all items with extensions.worktreeIgnore=merge' '
+	test_config extensions.worktreeIgnore merge &&
+	git check-ignore main &&
+	! git check-ignore worktree &&
+	git -C wt check-ignore main &&
+	git -C wt check-ignore worktree
+'
+
+test_done

base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2
-- 
2.54.0.rc2.544.gc7ae2d5bb8.dirty

