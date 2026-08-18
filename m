Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F071DA60D
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065239; cv=none; b=kBB7WWrH94SVDo5F1/bONsTGWe/T/EUstU7+MzbHO5+HoAciLSzM7GUSOnvSBNkhaZtC0h5L55bD/vY888vFeXISxib8Bnhgyc8FExbndnVlyqVwCPoOFUx2V6ArcNWdhbTa7EhrmLX/EXAK1bKh2GDzRGP8AxtW5OLl0Z73OJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065239; c=relaxed/simple;
	bh=ngRJCFJiHvZ/Ge7e6vmFX9L3U4P3yvDXZxQVjO4cfJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9uLmMNNB0x4gq2QStGM4IrwMcdqQWhTYIyQ3fR2Ly++y7HlcUMRBqBVQMnHD6UUKx5kpiG3E8agAdaaeLEmenaNLpz0tjuwlwDkd3VuPoKw23Ro2n0Il5i18OzEXkG2FE4Cgh0U6ivyS2PXzU1vS+MPlL6QI194Sgqp1dlgJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDH2L+vl; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDH2L+vl"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66c4e9769bdso42018d50.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065236; x=1787670036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9KY6uPLP9YXErC+Vg9cUplvX6gK6xXgjBEhiuNXkRw=;
        b=IDH2L+vloxhGpkAI6wGr7GEpgAuGhOCyknQipB0nVNGBilyCTMDhvdKOKuNI4voZnp
         7gV0S+orI/NlBs7OrmKtRsjQBnqdDanUsOKYIEpLm9t7B4rs8MlAsXAopCjksfPBJRjz
         7ylnpSYEo/vS8QsFtSGSB8dYfeasq6eM5nPjsQotWHKx1vvqnEdAjtUi4IAqE0jVCW3a
         3z/hgCLtBl5uL5RJb6Kh7sDXSHpCvrXT4cwourq2VRDs7494vtANud0dUo5TbJOOiLk2
         fYaDSt/YhLdDnN51iyfhqJ8/t9IKSXVX4cIajMxcCpo2wBMoPRJ8C/fPcAHWRcePlTH/
         oqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065236; x=1787670036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j9KY6uPLP9YXErC+Vg9cUplvX6gK6xXgjBEhiuNXkRw=;
        b=SD3Y6kga1GksRmCTltIx6Rjic9hNLkgh8sj9Y8nAkd5TqQ3fx+E4wAEXvYW/lJjTjm
         7R6eZXT7B0n5E4Ks/nSvoEwNy19yZ/2KW9VhPzcp1BLk6CaUHOFejCGplpHV3EL39D2f
         l+Kks9XTlVgm6+6W02WevsBx85KVjvRv/785JeAyv5NFrgXZl6+FRgIK5yxBTJ5bQ/7C
         KWrAJuFMimxEHxKPxgppsOTW6bElDXNv/q5p8fq45H9p7tDmSa1KqNldzsDeoeg8mdK+
         jMAZIrlbZe97n+BlvMRUHdR9Iq0BZ0e0G0D8/Qdx9BL2IHMFtDe7Feq+d5Rod1LOTUgQ
         2MgQ==
X-Gm-Message-State: AOJu0Yw4pyS190309rDsg6sch32UY8i17SguJULs9qnEr7DDprrQQnbJ
	L8xfClkE6Dq49fHMt11PeRGPCG0uUC3m44wSEYXAhJhy+Pl3x0JJ4IqrfLh5KeSlUbc=
X-Gm-Gg: AR+sD11iogSuk5stwPCcu1awxaG764Xs1oH93TVHRvoxf6mNpCY9qercvgd2QP5UA3k
	EREi6S3oM4GDsVVMb42wWB+rIYuaajy54mBX4SyD2AVuMzhVaKEnyn3sFxQbOnW1H1W1sYsH7VI
	xFIyUWRURgKN3wF7z2T9g3JWT+OdsHtH3PsnLY12yW7cpinLxniw+M5XVZIVK4OUVKRv8hVV7hR
	eY5KraQsYOdSRXCXWyciSlXDsWJYgkCzgk1NM0Qnp2ht+vgPNMWzJrM8RYXvGF/wo2mDGd9yLYZ
	BsyzbWmsD3OPRPau3F57quBQb5a2ZrrYoLzuJkJzNw/wUuyhNP/QbW+5jyQ/Dh1wsWZgwCIuzUJ
	Oo47qk2OS3QXFxuBtWeh/1jvkl0IqRT0lmbR6aVlccI9za4S/XaWfcS+Oa2QZu17qi3+E0HLrXO
	n0TtE6pjTgiT8jMK4VPdknZPb5QOYQle5wyO0cE4GzBtt0vG3o0AESLjO7z68O/YGdm51DnfMpE
	BTfVwwboXhIK3/R4zgHuywG2PQENqCDLFmhKSXKreXadsiD7UgowcjgtScxTpmJ1rWvMi5/MOcC
	qnNO+LS0qpA=
X-Received: by 2002:a05:690e:1b4e:b0:667:c7ba:99ee with SMTP id 956f58d0204a3-66c72afdbb5mr8980071d50.2.1787065234502;
        Tue, 18 Aug 2026 08:00:34 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f3d1fb12sm20201097b3.48.2026.08.18.08.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:00:33 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <cat@malon.dev>,
	Patrick Steinhardt <ps@pks.im>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Tue, 18 Aug 2026 10:59:47 -0400
Message-ID: <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1787065125.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
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
    CI: <https://github.com/benknoble/git/actions/runs/32137191115>
    
    v3:
        We could perhaps be cute in read-cache.c:is_racy_stat() by writing
        the preprocessor directive like
    
    		return (istate->timestamp.sec &&
    	#ifndef NO_NSEC
    			/* nanosecond timestamped files can also be racy! */
    			use_nsec
    			? (istate->timestamp.sec < sd->sd_mtime.sec ||
    			   (istate->timestamp.sec == sd->sd_mtime.sec &&
    			    istate->timestamp.nsec <= sd->sd_mtime.nsec))
    			:
    	#endif
    			istate->timestamp.sec <= sd->sd_mtime.sec
    
        but that seemed maybe too clever?

 Documentation/config/core.adoc        |  6 ++++++
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         | 10 ++++++++++
 environment.h                         |  1 +
 read-cache.c                          | 16 +++++++++++-----
 statinfo.c                            | 14 ++++++++------
 10 files changed, 44 insertions(+), 35 deletions(-)

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
index 6676e6f5ae..c7f6b801f4 100644
--- a/environment.c
+++ b/environment.c
@@ -571,6 +571,13 @@ int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+#ifndef NO_NSEC
+	if (!strcmp(var, "core.usenanosec")) {
+		cfg->use_nanosec = git_config_bool(var, value);
+		return 0;
+	}
+#endif
+
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return platform_core_config(var, value, ctx, cb);
 }
@@ -769,6 +776,9 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->ignore_case = 0;
 	cfg->trust_executable_bit = 1;
 	cfg->has_symlinks = platform_has_symlinks();
+#ifndef NO_NSEC
+	cfg->use_nanosec = 0;
+#endif
 
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
index 6c449f393d..31888f77ee 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -353,12 +353,18 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 static int is_racy_stat(const struct index_state *istate,
 			const struct stat_data *sd)
 {
+#ifndef NO_NSEC
+	int use_nsec = repo_config_values(istate->repo)->use_nanosec;
+#endif
+
 	return (istate->timestamp.sec &&
-#ifdef USE_NSEC
-		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < sd->sd_mtime.sec ||
-		 (istate->timestamp.sec == sd->sd_mtime.sec &&
-		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
+#ifndef NO_NSEC
+		/* nanosecond timestamped files can also be racy! */
+		use_nsec
+		? (istate->timestamp.sec < sd->sd_mtime.sec ||
+		   (istate->timestamp.sec == sd->sd_mtime.sec &&
+		    istate->timestamp.nsec <= sd->sd_mtime.nsec))
+		: istate->timestamp.sec <= sd->sd_mtime.sec
 #else
 		istate->timestamp.sec <= sd->sd_mtime.sec
 #endif
diff --git a/statinfo.c b/statinfo.c
index 5e00af127d..2f2cec6282 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -72,12 +72,14 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
-#ifdef USE_NSEC
-	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && cfg->check_stat &&
-	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
+#ifndef NO_NSEC
+	if (cfg->use_nanosec) {
+		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+			changed |= MTIME_CHANGED;
+		if (cfg->trust_ctime && cfg->check_stat &&
+		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
+			changed |= CTIME_CHANGED;
+	}
 #endif
 
 	if (cfg->check_stat) {
-- 
2.55.0.860.g4b6b3295ed.dirty

