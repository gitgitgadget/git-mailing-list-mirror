Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E91BC2A
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710926; cv=none; b=Y8KAKbjtTsx0qSRpn6eNRBfBTnhibgxPIQ2O2s6Cae/WC+YnsfWrdfcbg5D1IWabQs8UJY0OTYeTlOEBLD24jRS1TfFdZPskWYLwldzPqR8HHAK3rVSUL/ezunUnvtXNT1oobTIQ5cSH39XlV7KxEA10hOFBhsxUcQfVd7/Bi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710926; c=relaxed/simple;
	bh=gwZQkduQQdbJtwxGvQNHjFnXctkW/CGU3qhc3Pi9aCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN02ZmAZ8ZzWzAD9drJvps5KQoWPYmHNAbkp2OkRK1jP0HOVx99478gno7/pX1K3Iiz+htQ+nZ2RfR/deSPCpQeup+AvwZ0cZnpVEPJiEP/3yZShKGam+rVapDZBmmjNrrZSExGSwLfDmzb+aDxoh169vg9COQ2zwURNF4pYkcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKiL/kFP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKiL/kFP"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-836ccf53ef9so7932457b3.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 05:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786710923; x=1787315723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g0kcvNQcpGUcAZAzfwTt/dCZbzsQdWC6f63XpOsXaRc=;
        b=LKiL/kFP8cfTS/7WABFlX0MrKbWUbTIGkY0qw08CY60OuOhoTUz6D82Glbj8HwqU+d
         DL4cdNT3+ZjQWyxDTtEH13t95bFU66EX+vFP0bSXjVhdxuVEHLscb95UwDJfgWkdWVUL
         RBzdRb/kxSnNHZxXfGIvei5OjQEarS/61dCUehm3p0CTxOqsDrd4toY9zp/PtCoM7b2Z
         Jvy5JNXyI/OSO3PSSUX6BBqhdpC5cbOVSX4aD42Sj3/fOr2VtzmXehXvqmhrPwt/oPS4
         i7WnBhVwK2LNZ5Tr9zCuiTsVq1vl1Lml4Jbfi4h84P23GP+lsyijoGygLtKZ3VYz5ANy
         eDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786710923; x=1787315723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g0kcvNQcpGUcAZAzfwTt/dCZbzsQdWC6f63XpOsXaRc=;
        b=mnXyHdJ/jjhNJwOgKE33KP9zH+3fbJHsXAn/2RA7fTWRF4z+UIhDy0FyG3D8q3j3U0
         L9VEJhVaDmrYg+UVDZPcpUuH6lgpA17BvGkv8/d92TcEogXkHkN1jwgAq0aWXqMO6Cl6
         7niI4sAxDLQrgfjbk737BEy0Hnla86k/X37IOu+d+uRgXox2joe4l2/wNTbL8jDB8Anr
         5y1JdBJW5UvgHqUPQEebxKlE0gGvOsdx9AppEV0SRwb7OhWLccLkV+nNXIlmVcIlX0nU
         PXvenBpYnEyi5W1mt3mHuhdrr8vlF3aqaYB3sp286qk1B7OoTVrhyAR7G5opkD9CNn9O
         vkvQ==
X-Gm-Message-State: AOJu0YypeQJbZjWWNN35QF/PJ1QWvOi47DnXLiEE1JUmTns7dHddUiRX
	crFuHc2LIes6mCvrUTw0fyG7EBtALuFselo0h5zYkJsdJvvSzH5b92YiU0s+BQUZOxE=
X-Gm-Gg: AR+sD12OwW+aW1+0l94Qxc1ppKC4nrEv/RQZi+qGiF0yL5FCqC3mD15HtoHStdqeLjE
	JQtcWkVqfFoRnwLKqJb7h0FaMh22DP/NEO0FC+L1ndmI1MSOtm7D9xyv+o3in0ZCNU3BDk30KER
	YZtOWr/Id1G/mdaabiUYpRvdsd1dIUhXUpVu4BbFNn7iMXzao6NW/W9vT6zMHwp2NwAnYqGLU7V
	gVAAlWCL5+cV8hhA4GECtJMvbOtVYQiK/Q+jRiDlSrICKXAX+yR37pbSzZYd26/PNrFpR4CBJAy
	H9B4c1sklmO1xOCF20rhqtPR21ifjyUHkNmrXkRsin94QkTOic1VJtX2WuhqTPNxa5kQMYjkmu2
	Wd84GtjQRKtP31wxDr+OU1oE0LcBLpa7ZttEjUuO8Rriw1uWgYQu7OhJhp46lt4flTmJwwoTL6I
	gKOoXBwozF3tq3gYZ+aBLzQ9dHLjpRt0bPn3bdo/du4vWdf/jyl3sqh/KEah5CDPOWPYQ26DIG6
	2VX7+FkWeMpr0F8iD2BhQFqmr7QUnZf7WSoqfNRsIIi6QVDgzoyDF5I+eRPtx6EIhDuL/qSbw+u
	vnZnthoQcKI=
X-Received: by 2002:a05:690c:e297:10b0:812:c9fa:9910 with SMTP id 00721157ae682-837128c0af6mr15117387b3.29.1786710922669;
        Fri, 14 Aug 2026 05:35:22 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c21409eesm12428357b3.33.2026.08.14.05.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:35:22 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Fri, 14 Aug 2026 08:34:02 -0400
Message-ID: <2d1424732af6af9c82c775e8256ea914204e8e43.1786710807.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f.dirty
In-Reply-To: <cover.1786710807.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1786710807.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Racy Git problems persist today, manifesting themselves in the
performance of commands like "git diff" in new worktrees [1]. We have
long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
precision when available, which mitigates most if not all racy issues,
but most builds we know about it don't use it. In part, that's because
someone distributing Git can't safely enable it at compile-time if they
don't know exactly what platforms their distribution will be used on.

[1]: https://lore.kernel.org/git/CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com

These days, most platforms are likely to be safe for the USE_NSEC code.
Regardless, we want to give users the ability to benefit from it. This
requires exposing the compile-time gated code as a runtime option.

In addition, update the Racy Git documentation and other mentions of
USE_NSEC in the code.

Due to the conversion from #ifdef to runtime check, using the flag
"--ignore-space-change" may be particularly helpful when viewing changes
from this patch.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---

Notes (benknoble/commits):
    Related benchmarks: <https://lore.kernel.org/git/CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com/>
    CI: <https://github.com/benknoble/git/actions/runs/31701945211>

 Documentation/config/core.adoc        |  6 ++++++
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         |  6 ++++++
 environment.h                         |  1 +
 read-cache.c                          | 16 ++++++++--------
 statinfo.c                            | 14 +++++++-------
 10 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 340329edc3..33104444ab 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -118,6 +118,12 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.useNanosec::
+	If true, use nanosecond precision for ctime and mtime
+	comparisions between the index and the working tree (if Git
+	was compiled to store it).
+	See link:technical/racy-git.html[Racy Git]. False by default.
+
 core.splitIndex::
 	If true, the split-index feature of the index will be used.
 	See linkgit:git-update-index[1]. False by default.
diff --git a/Documentation/technical/racy-git.adoc b/Documentation/technical/racy-git.adoc
index 59bea66c0f..499231585b 100644
--- a/Documentation/technical/racy-git.adoc
+++ b/Documentation/technical/racy-git.adoc
@@ -39,8 +39,8 @@ files) from `st_mode` member, `st_mtime` and `st_ctime`
 timestamps, `st_uid`, `st_gid`, `st_ino`, and `st_size` members.
 With a `USE_STDEV` compile-time option, `st_dev` is also
 compared, but this is not enabled by default because this member
-is not stable on network filesystems.  With `USE_NSEC`
-compile-time option, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
+is not stable on network filesystems.  With 'core.useNanosec'
+config setting, `st_mtim.tv_nsec` and `st_ctim.tv_nsec`
 members are also compared. On Linux, this is not enabled by default
 because in-core timestamps can have finer granularity than
 on-disk timestamps, resulting in meaningless changes when an
@@ -49,9 +49,10 @@ of git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
 ([PATCH] Sync in core time granularity with filesystems,
 2005-01-04). This patch is included in kernel 2.6.11 and newer, but
 only fixes the issue for file systems with exactly 1 ns or 1 s
-resolution. Other file systems are still broken in current Linux
-kernels (e.g. CEPH, CIFS, NTFS, UDF), see
-https://lore.kernel.org/lkml/5577240D.7020309@gmail.com/
+resolution.  As of kernel 4.3, other file systems (CEPH, CIFS, NTFS, UFS, FUSE)
+were fixed; see https://public-inbox.org/git/5605D88A.20104%40gmail.com/.  FAT
+has been fixed since 2015.  The usual suspects (ext2, ext4, XFS) are known to
+work, too.
 
 Racy Git
 --------
diff --git a/Makefile b/Makefile
index fac3e8879c..b4ebcb9e83 100644
--- a/Makefile
+++ b/Makefile
@@ -197,18 +197,11 @@ include shared.mak
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
 #
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this. On
-# Linux, kernel 2.6.11 or newer is required for reliable sub-second file times
-# on file systems with exactly 1 ns or 1 s resolution. If you intend to use Git
-# on other file systems (e.g. CEPH, CIFS, NTFS, UDF), don't enable USE_NSEC. See
-# Documentation/technical/racy-git.adoc for details.
-#
 # Define USE_ST_TIMESPEC if your "struct stat" uses "st_ctimespec" instead of
 # "st_ctim"
 #
 # Define NO_NSEC if your "struct stat" does not have "st_ctim.tv_nsec"
-# available.  This automatically turns USE_NSEC off.
+# available.
 #
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
@@ -1935,9 +1928,6 @@ endif
 ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
 	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STRUCT_STAT
 endif
-ifdef USE_NSEC
-	BASIC_CFLAGS += -DUSE_NSEC
-endif
 ifdef USE_ST_TIMESPEC
 	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
 endif
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 241abd4332..8e0c25655f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -130,7 +130,7 @@ static void xrmdir(const char *path)
 static void avoid_racy(void)
 {
 	/*
-	 * not use if we could usleep(10) if USE_NSEC is defined. The
+	 * not use if we could usleep(10) if core.useNanosec is defined. The
 	 * field nsec could be there, but the OS could choose to
 	 * ignore it?
 	 */
diff --git a/compat/posix.h b/compat/posix.h
index e2e794cad7..51ee03233b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -487,7 +487,6 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 } while (0)
 
 #ifdef NO_NSEC
-#undef USE_NSEC
 #define ST_CTIME_NSEC(st) 0
 #define ST_MTIME_NSEC(st) 0
 #else
diff --git a/configure.ac b/configure.ac
index cfb50112bf..fc956776ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -351,12 +351,6 @@ GIT_PARSE_WITH(iconv))
 
 ## --enable-FEATURE[=ARG] and --disable-FEATURE
 #
-# Define USE_NSEC below if you want git to care about sub-second file mtimes
-# and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
-# it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
-# randomly break unless your underlying filesystem supports those sub-second
-# times (my ext3 doesn't).
-#
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-index perspective.
 
diff --git a/environment.c b/environment.c
index 6676e6f5ae..e6a50060e8 100644
--- a/environment.c
+++ b/environment.c
@@ -571,6 +571,11 @@ int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "core.usenanosec")) {
+		cfg->use_nanosec = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return platform_core_config(var, value, ctx, cb);
 }
@@ -769,6 +774,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->ignore_case = 0;
 	cfg->trust_executable_bit = 1;
 	cfg->has_symlinks = platform_has_symlinks();
+	cfg->use_nanosec = 0;
 
 	/* section "sparse" config values */
 	cfg->sparse_expect_files_outside_of_patterns = 0;
diff --git a/environment.h b/environment.h
index e7ec5b0437..a35534afe5 100644
--- a/environment.h
+++ b/environment.h
@@ -139,6 +139,7 @@ struct repo_config_values {
 	int ignore_case;
 	int trust_executable_bit;
 	int has_symlinks;
+	int use_nanosec;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
diff --git a/read-cache.c b/read-cache.c
index 6c449f393d..abecdf0342 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -353,15 +353,15 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 static int is_racy_stat(const struct index_state *istate,
 			const struct stat_data *sd)
 {
+	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
+
 	return (istate->timestamp.sec &&
-#ifdef USE_NSEC
-		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < sd->sd_mtime.sec ||
-		 (istate->timestamp.sec == sd->sd_mtime.sec &&
-		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
-#else
-		istate->timestamp.sec <= sd->sd_mtime.sec
-#endif
+		/* nanosecond timestamped files can also be racy! */
+		use_nsec
+		? (istate->timestamp.sec < sd->sd_mtime.sec ||
+		   (istate->timestamp.sec == sd->sd_mtime.sec &&
+		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
+		: istate->timestamp.sec <= sd->sd_mtime.sec
 		);
 }
 
diff --git a/statinfo.c b/statinfo.c
index 5e00af127d..d9ddcf9382 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -72,13 +72,13 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
-#ifdef USE_NSEC
-	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && cfg->check_stat &&
-	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
-#endif
+	if (cfg->use_nanosec) {
+		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+			changed |= MTIME_CHANGED;
+		if (cfg->trust_ctime && cfg->check_stat &&
+		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
+			changed |= CTIME_CHANGED;
+	}
 
 	if (cfg->check_stat) {
 		if (sd->sd_uid != (unsigned int) st->st_uid ||
-- 
2.55.0.699.gb54405d56f.dirty

