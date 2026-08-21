Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A24BCAA9
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787322212; cv=none; b=LUisQ4csSYmGeRNRHGn66KIOIowwX2s2wmbcvhQ1eKb8W6s+XLdQQZviQR3Vj/UAQBXNZ4Rx3M/b8rbMYkvNZVbz2k7rhieGEpSKs2kwT9kKBKfN5IdJ/Na0tXM4DQHR+AQAYm1BnVdWyTidx9/pSfhU16G0Iz4HfgFFwDOTAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787322212; c=relaxed/simple;
	bh=gTh0TdRXw9oDz9fjJerhA890XOVXYJF0oOi764JWyfo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EGPU/0iaYnUwN6kAuU8FFdHZa1sbxBzrDiCMZsl4uU3vC5gQ+aDgpnZFbCkloLghvJ3ZavzYDxMLVJNLBs0dzHkF2tQ0aqA8sspCEnvvyFcOIAi71iSNDdwWIbbNtzFp6CZsqnG7tmr/qBiCZUBS+tl4JZXu48rodc2mtan31tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUXy/eza; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUXy/eza"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so15670395ad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787322207; x=1787927007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/+qSf79b2CCF1OfIIfXrCoxvTbYH7HDYNAbwDNVVJpI=;
        b=TUXy/ezaP3ixPdj4VW51hts57kbJGLg0rrSSQS02C4aa64FktpbIL7idJZOaCoWfky
         9NpOerpGYM0qzCiSWmbXxqcu+oOk/oeyuFUmfpYcpGmr7V9MuX0z973zSip8bnnT4CZJ
         KeLNToxUI3a+xjEEEe6jdYF75p5GWnrw0U16bZPeVMaDFWbJLCiJqcfOueEW938/l4QQ
         6du0NXZcQ7wHVw5qu1cEQvGaXCR6SOgCPU8yEUiFVkvQMekH2zf2eNsU+uwOlLFp24FD
         q3NYVYwlRcsAjWN9LKZygNrQYbV3dda5f5ZalzA1Iq8zilxnNa7YC4CdDCUiT0jNdKzz
         fr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787322207; x=1787927007;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+qSf79b2CCF1OfIIfXrCoxvTbYH7HDYNAbwDNVVJpI=;
        b=LP0XIrOz1HpGZzTiOJdePGjz1Rh4wtC2s7QaV5c3BpIdfQvAok1HX3lppjDZ7eMjDz
         nXzdP8VmlE9K3XFoiWCYPWd5vaxak/S82sv7gMoY1CJSBHIkjwxFCU+hmx4zQHL9VqKP
         nMZ9tMr68v8WE7T+WHQZBOYbZppPAP17YsW3T/wUC4ervx2fayXA7y3CPf6xU0BOTlz+
         plqToyBsWzTFRtGZd0YDh3QGUzQYY8M67w3nAtbj16UV6dIQpJLvlh6t6/9n7M1hH80C
         WIERYmQJfpu/quzUJVFzl5scjs0B6PnF/YsTkUZrnaPFA5GGFifDsjvmGuh5uPlZ7Kbe
         oBKg==
X-Gm-Message-State: AFuF++n4v/XhF5Yisf+HYk0IZNPJU6ucWQlnlMeDKaqz2PmMoEm8upE0
	+Xvp7kPQ8ljq5lvcRltLddGlMi21yIkc3tOWoll/ezA0fPHO1GRU1SoyIcVYQ3Hb
X-Gm-Gg: AR+sD10m7wiS0tGSD2fVx/Sdr0138lO+Yr3Rnssgl7el48IXfuA80+ufrk6FgT23QUb
	Dfx1HJaJ0JNYRx9EvsM0YgM1tvLGUepIA9n5ZbruE0AwnbsHNXjOlr1YXjrd9S3SJcUscOKspCt
	8FjxWM/RODHN+Btv8R2Pc+EN6xAmY98RTnWYKQnobBUpGlp2MvQBoKDkYFvccs46CVw2bCnwJen
	HQH6u95udeQWSItw7bKhL14CGdacl7bmQ4jmjvLaYX+n+OEodaY2mfTqdyIDgVgEA1tHywgG0o9
	GtPEE93v/C+yMGg+sTdA0AEueHIlf5a6R01WzfwgljwZdZgmXIz9xzTOi/Ui1p9Rw0yRFQQBBxX
	kwlaG3zEdm7VnUq9bC9NHN2/XtkZWscGUVWeZFvBLiSzHQ0s3SWijKBrCi/PlcL7dMImIEbXOPh
	ke2uDcb0x85JTxkTNJa2xvKnULfQWucX86jQDVoJqRvsspKL6pXdCWROSozotDXkzq7T0=
X-Received: by 2002:a17:903:1a84:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2d64ce3544cmr76955675ad.0.1787322207096;
        Fri, 21 Aug 2026 07:23:27 -0700 (PDT)
Received: from [127.0.0.1] ([128.85.45.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62ea8e193sm19676125ad.81.2026.08.21.07.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 07:23:26 -0700 (PDT)
Message-Id: <6f5bd13d8e41e02af92df0274dbd435a395d6835.1787322203.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
References: <pull.2209.git.1787322203.gitgitgadget@gmail.com>
From: "Alexey Samsonov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Aug 2026 14:23:22 +0000
Subject: [PATCH 2/3] treewide: use utimensat(2) instead of legacy utime(3p)
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alexey Samsonov <vonosmas@gmail.com>,
    Alexey Samsonov <vonosmas@gmail.com>

From: Alexey Samsonov <vonosmas@gmail.com>

Now that a compatibility wrapper for utimensat(2) has been introduced,
migrate all call sites across the codebase to use utimensat(2) instead of
the legacy utime(3p) interface:

- In `commit-graph.c`, use utimensat(2) with UTIME_OMIT and the computed
  timestamp `now` to bump the commit-graph modification time consistently
  across all files without needing an extra stat(2) call to preserve atime.
- In `copy.c`, use utimensat(2) to copy full sub-second access and
  modification timestamps from the source file.
- In `odb/source-packed.c`, `odb/source-loose.c`, and `object-file.c`,
  use utimensat(2) with `struct timespec` to freshen file timestamps.
- In `builtin/pack-objects.c`, update the pack timestamp with
  utimensat(2).
- In `rerere.c`, touch the postimage file with utimensat(2) passing NULL
  to set both atime and mtime to current time.
- In `t/helper/test-chmtime.c`, update file modification times using
  utimensat(2).

Signed-off-by: Alexey Samsonov <vonosmas@gmail.com>
---
 builtin/pack-objects.c  | 12 +++++++-----
 commit-graph.c          | 17 ++++++-----------
 copy.c                  | 10 ++++++----
 object-file.c           | 12 +++++++-----
 odb/source-loose.c      | 10 +++++-----
 odb/source-packed.c     | 12 +++++++-----
 rerere.c                |  4 ++--
 t/helper/test-chmtime.c | 19 ++++++++++++-------
 8 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..35bdbc2b6a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1438,11 +1438,13 @@ static void write_pack_file(void)
 			} else if (!last_mtime) {
 				last_mtime = st.st_mtime;
 			} else {
-				struct utimbuf utb;
-				utb.actime = st.st_atime;
-				utb.modtime = --last_mtime;
-				if (utime(pack_tmp_name, &utb) < 0)
-					warning_errno(_("failed utime() on %s"), pack_tmp_name);
+				struct timespec times[2];
+				times[0].tv_sec = st.st_atime;
+				times[0].tv_nsec = ST_ATIME_NSEC(st);
+				times[1].tv_sec = --last_mtime;
+				times[1].tv_nsec = 0;
+				if (utimensat(AT_FDCWD, pack_tmp_name, times, 0) < 0)
+					warning_errno(_("failed utimensat() on %s"), pack_tmp_name);
 			}
 
 			strbuf_addf(&tmpname, "%s-%s.", base_name,
diff --git a/commit-graph.c b/commit-graph.c
index 49e8f63930..08bbba3d98 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2484,18 +2484,13 @@ static void mark_commit_graphs(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
 	time_t now = time(NULL);
+	struct timespec times[2] = {
+		{ .tv_nsec = UTIME_OMIT },
+		{ .tv_sec = now, .tv_nsec = 0 },
+	};
 
-	for (i = ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs_before; i++) {
-		struct stat st;
-		struct utimbuf updated_time;
-
-		if (stat(ctx->commit_graph_filenames_before[i], &st) < 0)
-			continue;
-
-		updated_time.actime = st.st_atime;
-		updated_time.modtime = now;
-		utime(ctx->commit_graph_filenames_before[i], &updated_time);
-	}
+	for (i = ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs_before; i++)
+		utimensat(AT_FDCWD, ctx->commit_graph_filenames_before[i], times, 0);
 }
 
 static void expire_commit_graphs(struct write_commit_graph_context *ctx)
diff --git a/copy.c b/copy.c
index 6074132050..39673f7829 100644
--- a/copy.c
+++ b/copy.c
@@ -23,12 +23,14 @@ int copy_fd(int ifd, int ofd)
 static int copy_times(const char *dst, const char *src)
 {
 	struct stat st;
-	struct utimbuf times;
+	struct timespec times[2];
 	if (stat(src, &st) < 0)
 		return -1;
-	times.actime = st.st_atime;
-	times.modtime = st.st_mtime;
-	if (utime(dst, &times) < 0)
+	times[0].tv_sec = st.st_atime;
+	times[0].tv_nsec = ST_ATIME_NSEC(st);
+	times[1].tv_sec = st.st_mtime;
+	times[1].tv_nsec = ST_MTIME_NSEC(st);
+	if (utimensat(AT_FDCWD, dst, times, 0) < 0)
 		return -1;
 	return 0;
 }
diff --git a/object-file.c b/object-file.c
index ec35c318bc..5e4ccb36d5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -69,15 +69,17 @@ const char *odb_loose_path(struct odb_source_loose *loose,
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn, const time_t *mtime)
 {
-	struct utimbuf times, *timesp = NULL;
+	struct timespec times[2], *timesp = NULL;
 
 	if (mtime) {
-		times.actime = *mtime;
-		times.modtime = *mtime;
-		timesp = &times;
+		times[0].tv_sec = *mtime;
+		times[0].tv_nsec = 0;
+		times[1].tv_sec = *mtime;
+		times[1].tv_nsec = 0;
+		timesp = times;
 	}
 
-	return !utime(fn, timesp);
+	return !utimensat(AT_FDCWD, fn, timesp, 0);
 }
 
 /*
diff --git a/odb/source-loose.c b/odb/source-loose.c
index ef0e919277..1fdaa9f88f 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -807,14 +807,14 @@ static int write_loose_object(struct odb_source_loose *loose,
 	close_loose_object(loose, fd, tmp_file.buf);
 
 	if (mtime) {
-		struct utimbuf utb = {
-			.actime = *mtime,
-			.modtime = *mtime,
+		struct timespec times[2] = {
+			{ .tv_sec = *mtime },
+			{ .tv_sec = *mtime },
 		};
 
-		if (utime(tmp_file.buf, &utb) < 0 &&
+		if (utimensat(AT_FDCWD, tmp_file.buf, times, 0) < 0 &&
 		    !(flags & ODB_WRITE_OBJECT_SILENT))
-			warning_errno(_("failed utime() on %s"), tmp_file.buf);
+			warning_errno(_("failed utimensat() on %s"), tmp_file.buf);
 	}
 
 	return finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0890704e76..64871ff8da 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -574,13 +574,15 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 					    const time_t *mtime)
 {
 	struct odb_source_packed *packed = odb_source_packed_downcast(source);
-	struct utimbuf times, *timesp = NULL;
+	struct timespec times[2], *timesp = NULL;
 	struct pack_entry e;
 
 	if (mtime) {
-		times.actime = *mtime;
-		times.modtime = *mtime;
-		timesp = &times;
+		times[0].tv_sec = *mtime;
+		times[0].tv_nsec = 0;
+		times[1].tv_sec = *mtime;
+		times[1].tv_nsec = 0;
+		timesp = times;
 	}
 
 	if (!find_pack_entry(packed, oid, &e))
@@ -589,7 +591,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
 		return 0;
 	if (e.p->freshened)
 		return 1;
-	if (utime(e.p->pack_name, timesp))
+	if (utimensat(AT_FDCWD, e.p->pack_name, timesp, 0))
 		return 0;
 	e.p->freshened = 1;
 
diff --git a/rerere.c b/rerere.c
index 3d3bd0db16..b64771f57f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -658,8 +658,8 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 	 * A successful replay of recorded resolution.
 	 * Mark that "postimage" was used to help gc.
 	 */
-	if (utime(rerere_path(&buf, id, "postimage"), NULL) < 0)
-		warning_errno(_("failed utime() on '%s'"),
+	if (utimensat(AT_FDCWD, rerere_path(&buf, id, "postimage"), NULL, 0) < 0)
+		warning_errno(_("failed utimensat() on '%s'"),
 			      rerere_path(&buf, id, "postimage"));
 
 	/* Update "path" with the resolution */
diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index 0e5538833a..a9e6eb78b8 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -105,7 +105,8 @@ int cmd__chmtime(int argc, const char **argv)
 
 	for (; i < argc; i++) {
 		struct stat sb;
-		struct utimbuf utb;
+		struct timespec times[2];
+		int64_t mtime_sec;
 		uintmax_t mtime;
 
 		if (stat(argv[i], &sb) < 0) {
@@ -123,22 +124,26 @@ int cmd__chmtime(int argc, const char **argv)
 		}
 #endif
 
-		utb.actime = sb.st_atime;
-		utb.modtime = set_eq ? set_time : sb.st_mtime + set_time;
+		mtime_sec = set_eq ? set_time : sb.st_mtime + set_time;
 
-		mtime = utb.modtime < 0 ? 0: utb.modtime;
+		times[0].tv_sec = sb.st_atime;
+		times[0].tv_nsec = ST_ATIME_NSEC(sb);
+		times[1].tv_sec = mtime_sec;
+		times[1].tv_nsec = 0;
+
+		mtime = mtime_sec < 0 ? 0 : mtime_sec;
 		if (get) {
 			printf("%"PRIuMAX"\n", mtime);
 		} else if (verbose) {
 			printf("%"PRIuMAX"\t%s\n", mtime, argv[i]);
 		}
 
-		if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
+		if (mtime_sec != sb.st_mtime && utimensat(AT_FDCWD, argv[i], times, 0) < 0) {
 #ifdef GIT_WINDOWS_NATIVE
 			if (S_ISDIR(sb.st_mode)) {
 				/*
-				 * NEEDSWORK: The Windows version of `utime()`
-				 * (aka `mingw_utime()`) does not correctly
+				 * NEEDSWORK: The Windows version of `utimensat()`
+				 * (aka `mingw_utimensat()`) does not correctly
 				 * handle directory arguments, since it uses
 				 * `_wopen()`.  Ignore it for now since this
 				 * is just a test.
-- 
gitgitgadget

