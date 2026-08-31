Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209F9381EAA
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206527; cv=none; b=dFKSUMPtuSchCEOrB3M+rw+kfrUCTjZ3E4XtPBrwmLqPC4hOLYX8Tx3wK3KcqDoV9RQGJ8B7i1jVjjgfQnu1N8O4Rii9rmHuzpWXSn4NFBHxAF+VK7qS7c8HCMpxHE7V5LsC3TD+PokSpq0m2Hq4ytlrQdSG9iu8eNtBeNGcK5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206527; c=relaxed/simple;
	bh=n3gtKps4QVtNdmRE6mXhaZel54jQ9kG1e7zA1WXR+N0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avWjFWds78MW1WCR/k9AzRZ2EhkQNRuiyWJRJY//0UsolAqPT3LAVSQwQqTeJ/5D5H+oGwgM1zFYuqmF+Sip5qSuqewaHVgapjRbuqN/bmorVjnnKKFy5JiVLcq2NZe6lb3Rtc8U1PdLUaw0QdNFbiQ7QtJMtuE5HdvliUAnQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/wf57rp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/wf57rp"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-867a943b149so15090197b3.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788206525; x=1788811325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zRq+rxAdN2cM9Z9Rq0FbrwUky1PAN3GIejFVHJuugiQ=;
        b=m/wf57rprztg9Qw2BtULw3XnukDLU/Iox2L4Lp37WFqCxR5GsB9cfNRhQTz6ZY/A77
         9/Uq9D4KLtj5PIR373ZorPSvFVz3gQTjknRPStOBpNYvE6fQY33UXOpch8DQpOOhDhlo
         1zWWqoQHz28qJ0IcIlOngQq47m74aClMfyfVrah4ACz88SXDy8RxZmpnaRYvIqK2MeDM
         1D3w4UP8jo/R312VhKsfljpr2ZM8B/mSqEBPaYFuYh4akUGeXVFT2/sBKoI69NtSpgOH
         Eiv8VGAZ4lWkJQ4oAQ8xfxSQyWmZNKRE2WQSdgcvbbxEcmAyB+rLLcajKCRFUJmdbYiN
         On7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788206525; x=1788811325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zRq+rxAdN2cM9Z9Rq0FbrwUky1PAN3GIejFVHJuugiQ=;
        b=I6IWq2PqoaheCrm6JpTZjWnzOvci6gje1dp4fhxn3QAEOYfYPMHx7K/ghJelQ/IxEl
         6IetiucYLPwsCghU1MSVg2l0Mf2CowiUX7/LgPvG6o4ZtnvPQ0+MXTfmtLKCpUv3Pt4G
         jlOP96bUwZ8Ao2y5YZ5r0Puvwi3gwCKE5iHsLwQJe8FBlvTwLT87q/u28ThbbRGshCQK
         EEOjDAodMCgmfQzXG9ipkx4HKXeQHtLQ8MYTaZSPSnX3kV5xj/9eOBtE9z0i3T1JcCmz
         /EmDzKvVrfQis1cGIuH2UJ81jXR/ZSX5O69y7LvgnUi1uzA+O8wpteJ3VYeQaq0zxST3
         h2Fw==
X-Gm-Message-State: AFuF++nFl55ze+D6XITR0+k4+BA9/+qYPLP5/hEIdMwl6UwLQUsrdDN3
	XKroVAmi2Kq06BCPljGaA9LjpXl6nLaDV/iOapVDg/jZs3sy2vR8tLhQsK/x1g7uc/c=
X-Gm-Gg: AYBFou0HrjeGqZH8tdTwXWPzzKnd8YIAd6/MiCG6L8u1R4RvH2iRk3xz2r9b8I3/myY
	Fim8qHm+i0w7Mu7Hyo9x/HIHHQq7nlW5DyNl6T8W00NZwBTFo04AawfsiM6DcCWMCIC/9UgKoNS
	INTGC86WTlkgZHwltI2ifJeiuES0j2QiIwEuWtcraUp/cFbDTtpMzzpTHj6kmy6iKN616hMfv0M
	AkfhGEvUHTVNxIjdPJ+KLac1v/fzKlW3D+nqu3NDMcNLG+shOybv43PbbuC1kTOm16qA2mzJEyZ
	OMBxyJVilX1dI6tVWpRZ+mk2nUfYS5VxMdfucsokYUzgmrFQohKZKf5o4VUv8qcrrzercJaxPBo
	qschCDfjw01imWq/epQMHLvnLCUmYjdU6cnrM98bCcsjRqP5QMCHfHPmpr8nWZx4xveLhsUfPij
	JsbnlaPAJJBxhv+8RkH2sSLDUKTKpprQQ0FFWX4cTt20E/oChpIA54Na3VAr08kOC0ZYslrxZAS
	Jb2l58QwhIwVs0KfNdDclmQSxTwhJIlCkE+lCQ4LXdnp4a1HgoI21oVc9fIYdmstk61evVtTwlj
	jhS2s+QUdYXv
X-Received: by 2002:a05:690c:dc9:b0:868:505e:b96d with SMTP id 00721157ae682-8686e1b713emr16185037b3.2.1788206524586;
        Mon, 31 Aug 2026 13:02:04 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1e4fcsm60286997b3.18.2026.08.31.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 13:02:04 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Todd Zullinger <tmz@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Mon, 31 Aug 2026 16:01:37 -0400
Message-ID: <0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1788206466.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788206466.git.ben.knoble@gmail.com>
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
but most builds we know about don't use it. In part, that's because
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
    CI: <https://github.com/benknoble/git/actions/runs/32365602564>

 Documentation/config/core.adoc        |  7 +++++++
 Documentation/technical/racy-git.adoc | 11 ++++++-----
 Makefile                              | 12 +-----------
 builtin/update-index.c                |  2 +-
 compat/posix.h                        |  1 -
 configure.ac                          |  6 ------
 environment.c                         |  8 ++++++++
 environment.h                         |  1 +
 read-cache.c                          | 15 ++++++---------
 statinfo.c                            | 14 +++++++-------
 10 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 340329edc3..b793f62e42 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -118,6 +118,13 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.useNanosec::
+	If true, use nanosecond precision for ctime and mtime
+	comparisions between the index and the working tree (if Git
+	was compiled to respect this option).
+	This is unsafe on some platforms;
+	see link:technical/racy-git.html[Racy Git]. False by default.
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
index 241abd4332..a10c07b636 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -130,7 +130,7 @@ static void xrmdir(const char *path)
 static void avoid_racy(void)
 {
 	/*
-	 * not use if we could usleep(10) if USE_NSEC is defined. The
+	 * not use if we could usleep(10) if core.useNanosec is enabled. The
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
index 6676e6f5ae..c83cf44839 100644
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
@@ -769,6 +776,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
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
index 6c449f393d..b32cfd0ef1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -354,15 +354,12 @@ static int is_racy_stat(const struct index_state *istate,
 			const struct stat_data *sd)
 {
 	return (istate->timestamp.sec &&
-#ifdef USE_NSEC
-		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < sd->sd_mtime.sec ||
-		 (istate->timestamp.sec == sd->sd_mtime.sec &&
-		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
-#else
-		istate->timestamp.sec <= sd->sd_mtime.sec
-#endif
-		);
+		/* nanosecond timestamped files can also be racy! */
+		(repo_config_values(istate->repo)->use_nanosec
+		 ? (istate->timestamp.sec < sd->sd_mtime.sec ||
+		    (istate->timestamp.sec == sd->sd_mtime.sec &&
+		     istate->timestamp.nsec <= sd->sd_mtime.nsec))
+		 : istate->timestamp.sec <= sd->sd_mtime.sec));
 }
 
 int is_racy_timestamp(const struct index_state *istate,
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
2.55.0.860.g4b6b3295ed.dirty

