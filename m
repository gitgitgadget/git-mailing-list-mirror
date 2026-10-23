Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785805;
	b=qTZh3ArEBhugI5reAEB9gRDPDdzwOk/IZWhifYl3/o8+oKxgHG09SjVenkhcmG5+QQ8K
	 2tNAhpZFlROJIcZ29F6JomW37btR3v7VzMrNlP8e1EBBTP1xJd9py0tIBuiSTyE/dMLm/
	 IjpcGJ+NFQxssIxU9SwElC1SgLqvddVbANGJayPeqx0SrtGC22ml4vWg6vbBwMw5l0eTN
	 qPPVE1Ykyr38I91AmiATczGo5phX+U6xSS/poB08eEp3B5mm+RpSuC4eu2UEeSBAKLVxD
	 EdefpbdHOJVQOWmJdqzkB2rokag/StNqlO8d+dCqtP/vdOp6gaNygKKXiMcOEd5URHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=iLAEjdZe9lehc2iTiNWP2TikAl8AsPZZRAwaLscCKms=;
	b=C1NgW0i4VAk1xSuC37KxT5mymwugz/1y7fdpBM3zJNGO5mkz/72AXx4Orx8F1vJqWF5e
	 tv2GMUcfqYha82MLFmVYezCBfb4v/lLt8d+/+pIB+qdfkcF4DJi845sYLRLcQQDqPEcWO
	 HwCuBWDkvu96ON94RtWre6kf8vNcNljzAd1y0AwFmrFuuRddP3UIidt84UEQIlPzmstr7
	 P5muyvgzj27vCEWJ1eeBJOsqBnMx8FGCAfK05JwwShWiOPw8RG4oLnPxc+6HwkYuyrd/w
	 bAkFe7v+NM/YamZX8KzakxAUKHIzv2teKl8osBgQSm4UPJoYuRpQ29EwC7309VGvK3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g5lcNsdq;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAD606A32C
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 20:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDAD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g5lcNsdq
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-533861a59b8so12937941cf.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792785803; x=1793390603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLAEjdZe9lehc2iTiNWP2TikAl8AsPZZRAwaLscCKms=;
        b=g5lcNsdqhAj1AlnsH4yVjdZAsjMmf2HULx79HSYFxD4kjmgTKxwlfyNA4bgoQi9cax
         sWLzfjA7bXhTs3lG7+QynhHROT8nrOXEa+IJZQRVh/y7Wx/h0u8iakn8VhVjBTb04XvH
         k/JT8AITBmwC/rDcq5zLfaw7e6tZ4Iil8mW4pBXmZY8y5EbPKbrBOgUaJM0nwwc5OWBC
         VBVm/GemHGdaiXkPtDI+DQLLet8xhNDcycoKHCvyCUdrKIupbpZ4oI1U4Qp0cfjtg621
         buQ8LAZSyUwcB34vSGjp/lLhbEIdWEnSPnwXIsxrIEKwTI4dEl3mEvEalCARZM31ZDLN
         T5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792785803; x=1793390603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iLAEjdZe9lehc2iTiNWP2TikAl8AsPZZRAwaLscCKms=;
        b=I8SPLu9l5LKmcS7J3CmM7UfTjAMa8J/Js78zUkxGcfE1Pgj17ofRV5tMfWy8EGou3T
         3SwdH0Dc7PnNsclJ0Crz5l42h7+0YoDTJQOR53q7pBALKXx/fm/gqYYrwjtMKky2CR2X
         bZvjXIQuywqaa83o0GFGA0JK5UO00I8f5vTyoo6kO99FzRMn87XL2qMFOa366cAqZSUz
         Ot+fSGfPDDob+3KzZ8uIHmuwyDQyQ5qCn0yFgg/s1SNelHu8lQJAQrZ+0Y0HHsFT8+7Q
         vmfCf1AGQOL3hauavm+/lIqrB9MYO3HyYUViTdjRYrjdYTygEffGUzPv5AQA1Qj4W3WL
         No3A==
X-Gm-Message-State: AFq9FYJGzlcH6iGklHP9sggQzZ3V9TlgxHeMl9XpCa6lcm/7+gcdlNZ+
	6M5f43rsQusJukNZ0NSNFDJUSDCV44gL2kO25owLnefdDoiW4eksyB0GIlGoRw==
X-Gm-Gg: AYBFou1GnLbB0bCcKBeFipTnLS0yN5rDdu4zH74naWgOjPoLJ1M4p9mcRof5+V2TNGb
	XFX8U78CbAerxw6fiOu/mwyAVA2DeJ380z31b59P6yCNDyyXG93tQjoiyWC1g1GakNaodPD+hhY
	PDp4LuhkYmKtrw6t4uHiNHwP5V17SnmfCasuIvRh73QFlQeDKl8q3c4oTIBLvr+oQ3TuA2Stumw
	0BzqxvStfk9e/7/B4nkAoyA26NYm9VJOBnYzKgXrFZy7GtjPhaltMNxJkqwTMQYhhOf/NMSEXyn
	2IEt3iKXcbK0SjxhVtlR/zd2U1GB/aoOOIECOx+bkG7n3SzAhMWlNbEdOzb1t+hQugWfeGpPFok
	ye0C9ZqE6j6RG/l54SeM/0bgEXw7FG2WoNngqNOsUPZA7Fd0OTxcdWaDwzqhAMxB1FKdKaLFRGH
	W3Uyz+Jtex4laTwO7uei1M3mVK6VymrIxFFKe/mgNw9kE0j28y8K3LuzmTc7e2DQG68evk/KCaB
	wmWzfOOAuZnxhCwr/zjncycEf1gHUdo5Cyb/5B4xbkK7+ZXnxdfejUGdRWATiW+QE6hj0D8DvWM
	gIi+rT3dTRdPeEYIS9UXrDdyt1lkouGOT4zWylSujwd2XsWZN6lkTfzAwg6lmVTpPnJenHGIjvV
	wEzIG69QaycYXOZChIhizktIdPXTf2m1UnF6p8/uuOWjkSTFEbQVun6ZmkOw3GeCisaTMfBVg5C
	eaUo9F5YdmyqzDgseNbvXi/xWTDeFMfJXh9Hw3RQ==
X-Received: by 2002:a05:620a:6088:b0:93e:795c:9d07 with SMTP id af79cd13be357-940ef92b335mr16197585a.35.1792785802827;
        Fri, 23 Oct 2026 13:03:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9402ee2cbffsm104288785a.2.2026.10.23.13.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:03:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 23 Oct 2026 16:03:05 -0400
Subject: [PATCH v3 2/3] dir: share untracked caches across output modes
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
Message-Id: <20261023-ls-files-untracked-cache-v3-2-292260e95f53@gmail.com>
References: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
In-Reply-To: <20261023-ls-files-untracked-cache-v3-0-292260e95f53@gmail.com>
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1792785794; l=30687;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=jDsmUHOb05BnAyVsIHcuL8Rh6O81/DeaJ5tgf7frWgo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOiAThzVw7o7EdrTcGclj3c1Z4A254jI5DyzzLk/GhULHfhAc6Xl2sA4b3RcyjCBAFMCRyz5rS/
 lZ0yWjctlDws=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The untracked cache stores different directory listings for
--untracked-files=normal and --untracked-files=all. Switching modes
bypasses the cache or rebuilds it, even when complete listings could be
used for either mode.

Use each directory's check_only bit to record an incomplete scan. Rescan
it when all untracked files are requested, and retain complete listings
when a later 'git status -unormal' stops early. If a partial listing loses
its cached untracked entry, rescan the directory to find any remaining
untracked files.

Call treat_directory() for cached directories as well. For wildcard
pathspecs without a fixed prefix, cache complete listings and apply the
pathspec afterward; retain traversal pruning for fixed-prefix, attribute
and exclude pathspecs. This follows the cache reuse proposed in [1] while
preserving the early exit for large untracked trees [2].

Use a new value for dir_flags so older versions of Git rebuild the cache
before using it to list untracked files. Retain DIR_SHOW_OTHER_DIRECTORIES
so commands such as 'git add' in those versions still invalidate parent
directories when updating the index. Reuse caches written for either
'normal' or 'all' mode.

[1]: https://lore.kernel.org/git/xmqqtucmag00.fsf@gitster.g/
[2]: https://lore.kernel.org/git/CAPMMpoixi3x1PHrSHJPV1GRBzMpuOQ4meMr-fipXuDvz-96MEA@mail.gmail.com/

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 Documentation/gitformat-index.adoc |  13 ++-
 dir.c                              | 217 ++++++++++++++++++++-----------------
 dir.h                              |  16 +--
 t/t7063-status-untracked-cache.sh  | 167 ++++++++++++++++++----------
 4 files changed, 245 insertions(+), 168 deletions(-)

diff --git a/Documentation/gitformat-index.adoc b/Documentation/gitformat-index.adoc
index f6a427cb49..d7596eb430 100644
--- a/Documentation/gitformat-index.adoc
+++ b/Documentation/gitformat-index.adoc
@@ -296,7 +296,13 @@ Git index format
 
   - Stat data of core.excludesFile
 
-  - 32-bit dir_flags (see struct dir_struct)
+  - 32-bit dir_flags. The values 0 and 6 store the flags from
+    `struct dir_struct` for `--untracked-files=all` and
+    `--untracked-files=normal`, respectively. The value 0x80000006 allows
+    the same cache to be used for both modes. Older versions of Git
+    rebuild this cache before using it to list untracked files. Its
+    `DIR_SHOW_OTHER_DIRECTORIES` bit ensures that they still invalidate
+    parent directories when updating the index.
 
   - Hash of $GIT_COMMON_DIR/info/exclude. A null hash means the file
     does not exist.
@@ -327,8 +333,9 @@ The remaining data of each directory block is grouped by type:
   - An ewah bitmap, the n-th bit marks whether the n-th directory has
     valid untracked cache entries.
 
-  - An ewah bitmap, the n-th bit records "check-only" bit of
-    read_directory_recursive() for the n-th directory.
+  - An ewah bitmap, the n-th bit records the "check-only" bit for the
+    n-th directory. With dir_flags 0x80000006, a set bit marks a directory
+    listing that may be incomplete.
 
   - An ewah bitmap, the n-th bit indicates whether hash and stat data
     is valid for the n-th directory and exists in the next data.
diff --git a/dir.c b/dir.c
index 5484eb1562..425fe2af67 100644
--- a/dir.c
+++ b/dir.c
@@ -43,6 +43,15 @@
   */
 #define PATTERN_MAX_FILE_SIZE (100 * 1024 * 1024)
 
+/*
+ * Use the same cache for --untracked-files=normal and --untracked-files=all.
+ * The high bit makes older versions of Git rebuild the cache before using
+ * it to list untracked files. Keep DIR_SHOW_OTHER_DIRECTORIES so their
+ * index updates still invalidate parent directories.
+ */
+#define UNTRACKED_CACHE_LAZY ((1U << 31) | DIR_SHOW_OTHER_DIRECTORIES | \
+			      DIR_HIDE_EMPTY_DIRECTORIES)
+
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
  * Values are ordered by significance, e.g. if a directory contains both
@@ -1057,7 +1066,7 @@ static void trim_trailing_spaces(char *buf)
 /*
  * Given a subdirectory name and "dir" of the current directory,
  * search the subdir in "dir" and return it, or create a new one if it
- * does not exist in "dir".
+ * does not exist in "dir". If "uc" is NULL, do not create a new entry.
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
@@ -1088,6 +1097,8 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 		first = next+1;
 	}
 
+	if (!uc)
+		return NULL;
 	uc->dir_created++;
 	FLEX_ALLOC_MEM(d, name, name, len);
 
@@ -2410,26 +2421,19 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
 	strbuf_setlen(path, baselen);
 	if (!cdir->ucd) {
 		strbuf_addstr(path, cdir->file);
-		return path_untracked;
+		if (!ends_with(cdir->file, "/"))
+			return path_untracked;
+	} else {
+		strbuf_addstr(path, cdir->ucd->name);
+		/* treat_directory() expects a trailing slash. */
+		strbuf_complete(path, '/');
 	}
-	strbuf_addstr(path, cdir->ucd->name);
-	/* treat_one_path() does this before it calls treat_directory() */
-	strbuf_complete(path, '/');
-	if (cdir->ucd->check_only)
-		/*
-		 * check_only is set as a result of treat_directory() getting
-		 * to its bottom. Verify again the same set of directories
-		 * with check_only set.
-		 */
-		return read_directory_recursive(dir, istate, path->buf, path->len,
-						cdir->ucd, 1, 0, pathspec);
 	/*
-	 * We get path_recurse in the first run when
-	 * directory_exists_in_index() returns index_nonexistent. We
-	 * are sure that new changes in the index does not impact the
-	 * outcome. Return now.
+	 * The output mode may have changed since this directory was cached,
+	 * and a nested repository may have been created or removed.
 	 */
-	return path_recurse;
+	return treat_directory(dir, istate, cdir->untracked, path->buf,
+			       path->len, baselen, 0, pathspec);
 }
 
 static enum path_treatment treat_path(struct dir_struct *dir,
@@ -2556,7 +2560,8 @@ static int valid_cached_dir(struct dir_struct *dir,
 		}
 	}
 
-	if (untracked->check_only != !!check_only)
+	/* A complete listing can also answer a check_only request. */
+	if (untracked->check_only && !check_only)
 		return 0;
 
 	/*
@@ -2618,7 +2623,12 @@ static int read_cached_dir(struct cached_dir *cdir)
 		cdir->d_type = DTYPE(de);
 		return 0;
 	}
-	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
+	/*
+	 * If a cached entry is no longer a nested repository, recursing into
+	 * it can add it to dirs while we iterate over untracked. Do not visit
+	 * it twice.
+	 */
+	while (!cdir->nr_files && cdir->nr_dirs < cdir->untracked->dirs_nr) {
 		struct untracked_cache_dir *d = cdir->untracked->dirs[cdir->nr_dirs];
 		if (!d->recurse) {
 			cdir->nr_dirs++;
@@ -2629,9 +2639,17 @@ static int read_cached_dir(struct cached_dir *cdir)
 		return 0;
 	}
 	cdir->ucd = NULL;
-	if (cdir->nr_files < cdir->untracked->untracked_nr) {
+	while (cdir->nr_files < cdir->untracked->untracked_nr) {
 		struct untracked_cache_dir *d = cdir->untracked;
 		cdir->file = d->untracked[cdir->nr_files++];
+		/* A directory may occur in both dirs and untracked. Return it once. */
+		if (ends_with(cdir->file, "/")) {
+			struct untracked_cache_dir *child =
+				lookup_untracked(NULL, d, cdir->file,
+						 strlen(cdir->file));
+			if (child && child->recurse)
+				continue;
+		}
 		return 0;
 	}
 	return -1;
@@ -2641,10 +2659,7 @@ static void close_cached_dir(struct cached_dir *cdir)
 {
 	if (cdir->fdir)
 		closedir(cdir->fdir);
-	/*
-	 * We have gone through this directory and found no untracked
-	 * entries. Mark it valid.
-	 */
+	/* The listing is valid even if check_only marks it as incomplete. */
 	if (cdir->untracked) {
 		cdir->untracked->valid = 1;
 		cdir->untracked->recurse = 1;
@@ -2717,6 +2732,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state = path_none;
 	struct strbuf path = STRBUF_INIT;
+	int incomplete = 0;
 
 	strbuf_add(&path, base, baselen);
 
@@ -2724,9 +2740,6 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		goto out;
 	dir->internal.visited_directories++;
 
-	if (untracked)
-		untracked->check_only = !!check_only;
-
 	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
 		state = treat_path(dir, untracked, &cdir, istate, &path,
@@ -2776,6 +2789,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				 */
 				if (dir_state >= path_excluded) {
 					dir_state = path_excluded;
+					incomplete = 1;
 					break;
 				}
 			}
@@ -2784,6 +2798,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			if (dir_state == path_untracked) {
 				if (cdir.fdir)
 					add_untracked(untracked, path.buf + baselen);
+				incomplete = 1;
 				break;
 			}
 			/* skip the add_path_to_appropriate_result_list() */
@@ -2794,7 +2809,27 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 						    istate, &path, baselen,
 						    pathspec, state);
 	}
-	close_cached_dir(&cdir);
+	/*
+	 * Only a filesystem scan replaces the saved completeness. Stopping
+	 * early while reading a complete cache must not make it partial.
+	 */
+	if (cdir.fdir && untracked)
+		untracked->check_only = incomplete;
+	if (!cdir.fdir && untracked->check_only &&
+	    dir_state != path_untracked) {
+		/*
+		 * Removing the last untracked file in a cached child need not
+		 * change this directory's mtime. Other children may still have
+		 * untracked files, so rescan the directory before returning.
+		 */
+		close_cached_dir(&cdir);
+		invalidate_directory(dir->untracked, untracked);
+		dir_state = read_directory_recursive(dir, istate, base, baselen,
+						     untracked, check_only,
+						     stop_at_first_file, pathspec);
+	} else {
+		close_cached_dir(&cdir);
+	}
  out:
 	strbuf_release(&path);
 
@@ -2925,33 +2960,12 @@ static void set_untracked_ident(struct untracked_cache *uc)
 	strbuf_addch(&uc->ident, 0);
 }
 
-static unsigned new_untracked_cache_flags(struct index_state *istate)
-{
-	struct repository *repo = istate->repo;
-	const char *val;
-
-	/*
-	 * This logic is coordinated with the setting of these flags in
-	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
-	 * of the config setting in commit.c#git_status_config()
-	 */
-	if (!repo_config_get_string_tmp(repo, "status.showuntrackedfiles", &val) &&
-	    !strcmp(val, "all"))
-		return 0;
-
-	/*
-	 * The default, if "all" is not set, is "normal" - leading us here.
-	 * If the value is "none" then it really doesn't matter.
-	 */
-	return DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-}
-
-static void new_untracked_cache(struct index_state *istate, int flags)
+static void new_untracked_cache(struct index_state *istate)
 {
 	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
 	uc->exclude_per_dir = ".gitignore";
-	uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);
+	uc->dir_flags = UNTRACKED_CACHE_LAZY;
 	set_untracked_ident(uc);
 	istate->untracked = uc;
 	istate->cache_changed |= UNTRACKED_CHANGED;
@@ -2960,11 +2974,11 @@ static void new_untracked_cache(struct index_state *istate, int flags)
 void add_untracked_cache(struct index_state *istate)
 {
 	if (!istate->untracked) {
-		new_untracked_cache(istate, -1);
+		new_untracked_cache(istate);
 	} else {
 		if (!ident_in_untracked(istate->untracked)) {
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate, -1);
+			new_untracked_cache(istate);
 		}
 	}
 }
@@ -3004,10 +3018,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 
 	/*
-	 * Optimize for the main use case only: whole-tree git
-	 * status. More work involved in treat_leading_path() if we
-	 * use cache on just a subset of the worktree. pathspec
-	 * support could make the matter even worse.
+	 * The cache needs a whole-tree scan without pathspec pruning.
+	 * read_directory() handles eligible pathspecs by filtering the results
+	 * after the scan and passing NULL here.
 	 */
 	if (base_len || (pathspec && pathspec->nr))
 		return NULL;
@@ -3037,47 +3050,22 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
-	/*
-	 * If the untracked structure we received does not have the same flags
-	 * as requested in this run, we're going to need to either discard the
-	 * existing structure (and potentially later recreate), or bypass the
-	 * untracked cache mechanism for this run.
-	 */
-	if (dir->flags != dir->untracked->dir_flags) {
-		/*
-		 * If the untracked structure we received does not have the same flags
-		 * as configured, then we need to reset / create a new "untracked"
-		 * structure to match the new config.
-		 *
-		 * Keeping the saved and used untracked cache consistent with the
-		 * configuration provides an opportunity for frequent users of
-		 * "git status -uall" to leverage the untracked cache by aligning their
-		 * configuration - setting "status.showuntrackedfiles" to "all" or
-		 * "normal" as appropriate.
-		 *
-		 * Previously using -uall (or setting "status.showuntrackedfiles" to
-		 * "all") was incompatible with untracked cache and *consistently*
-		 * caused surprisingly bad performance (with fscache and fsmonitor
-		 * enabled) on Windows.
-		 *
-		 * IMPROVEMENT OPPORTUNITY: If we reworked the untracked cache storage
-		 * to not be as bound up with the desired output in a given run,
-		 * and instead iterated through and stored enough information to
-		 * correctly serve both "modes", then users could get peak performance
-		 * with or without '-uall' regardless of their
-		 * "status.showuntrackedfiles" config.
-		 */
-		if (dir->untracked->dir_flags != new_untracked_cache_flags(istate)) {
+	/* Only --untracked-files=normal and --untracked-files=all are supported. */
+	if (dir->flags &&
+	    dir->flags != (DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES))
+		return NULL;
+
+	if (dir->untracked->dir_flags != UNTRACKED_CACHE_LAZY) {
+		/* Reuse caches written for either mode by older versions of Git. */
+		if (dir->untracked->dir_flags &&
+		    dir->untracked->dir_flags !=
+			    (DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES)) {
 			free_untracked_cache(istate->untracked);
-			new_untracked_cache(istate, dir->flags);
+			new_untracked_cache(istate);
 			dir->untracked = istate->untracked;
-		}
-		else {
-			/*
-			 * Current untracked cache data is consistent with config, but not
-			 * usable in this request/run; just bypass untracked cache.
-			 */
-			return NULL;
+		} else {
+			dir->untracked->dir_flags = UNTRACKED_CACHE_LAZY;
+			istate->cache_changed |= UNTRACKED_CHANGED;
 		}
 	}
 
@@ -3145,6 +3133,16 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		   const char *path, int len, const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
+	const struct pathspec *walk_pathspec = pathspec;
+	/* Attribute and exclude pathspecs can prune a directory by its own name. */
+	int filter = dir->untracked &&
+		     !len && !dir->flags && pathspec && pathspec->nr &&
+		     !(pathspec->magic & (PATHSPEC_ATTR | PATHSPEC_EXCLUDE));
+
+	/* Keep the usual pruning for pathspecs with a fixed prefix. */
+	for (int i = 0; filter && i < pathspec->nr; i++)
+		if (pathspec->items[i].nowildcard_len)
+			filter = 0;
 
 	trace2_region_enter("dir", "read_directory", istate->repo);
 	dir->internal.visited_paths = 0;
@@ -3155,15 +3153,34 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		return dir->nr;
 	}
 
-	untracked = validate_untracked_cache(dir, len, pathspec, istate);
+	untracked = validate_untracked_cache(dir, len,
+					     filter ? NULL : pathspec, istate);
 	if (!untracked)
 		/*
 		 * make sure untracked cache code path is disabled,
 		 * e.g. prep_exclude()
 		 */
 		dir->untracked = NULL;
-	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
-		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
+	else if (filter)
+		walk_pathspec = NULL;
+	if (!len || treat_leading_path(dir, istate, path, len, walk_pathspec))
+		read_directory_recursive(dir, istate, path, len, untracked, 0, 0,
+					 walk_pathspec);
+	if (filter && untracked) {
+		int dst = 0;
+
+		/* Keep complete listings in the cache for later pathspecs. */
+		for (int i = 0; i < dir->nr; i++) {
+			struct dir_entry *ent = dir->entries[i];
+
+			if (match_pathspec(istate, pathspec, ent->name, ent->len,
+					   0, NULL, 0))
+				dir->entries[dst++] = dir->entries[i];
+			else
+				free(dir->entries[i]);
+		}
+		dir->nr = dst;
+	}
 	QSORT(dir->entries, dir->nr, cmp_dir_entry);
 	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
 
diff --git a/dir.h b/dir.h
index 83e0f648a8..5cdad2bc45 100644
--- a/dir.h
+++ b/dir.h
@@ -152,13 +152,10 @@ struct oid_stat {
  *
  *   - The list of files and directories of the directory in question
  *   - The $GIT_DIR/index
- *   - dir_struct flags
  *   - The content of $GIT_COMMON_DIR/info/exclude
  *   - The content of core.excludesfile
  *   - The content (or the lack) of .gitignore of all parent directories
  *     from $GIT_WORK_TREE
- *   - The check_only flag in read_directory_recursive (for
- *     DIR_HIDE_EMPTY_DIRECTORIES)
  *
  *  The first input can be checked using directory mtime. In many
  *  filesystems, directory mtime (stat_data field) is updated when its
@@ -168,9 +165,10 @@ struct oid_stat {
  *  Whenever a file (or a submodule) is added or removed from a
  *  directory, we invalidate that directory.
  *
- *  The remaining inputs are easy, their SHA-1 could be used to verify
- *  their contents (exclude_sha1[], info_exclude_sha1[] and
- *  excludes_file_sha1[])
+ *  Normal and all mode share these listings; other directory flags bypass
+ *  the cache. Partial scans are marked check_only and completed when needed.
+ *
+ *  Ignore files are validated by their object IDs.
  */
 struct untracked_cache_dir {
 	struct untracked_cache_dir **dirs;
@@ -178,6 +176,7 @@ struct untracked_cache_dir {
 	struct stat_data stat_data;
 	unsigned int untracked_alloc, dirs_nr, dirs_alloc;
 	unsigned int untracked_nr;
+	/* The directory scan stopped early; the listing may be incomplete. */
 	unsigned int check_only : 1;
 	/* all data except 'dirs' in this struct are good */
 	unsigned int valid : 1;
@@ -193,10 +192,7 @@ struct untracked_cache {
 	const char *exclude_per_dir;
 	char *exclude_per_dir_to_free;
 	struct strbuf ident;
-	/*
-	 * dir_struct#flags must match dir_flags or the untracked
-	 * cache is ignored.
-	 */
+	/* UNTRACKED_CACHE_LAZY, or dir_struct.flags from older versions of Git. */
 	unsigned dir_flags;
 	struct untracked_cache_dir *root;
 	/* Statistics */
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 10d4850077..2efbb93b71 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -115,7 +115,7 @@ test_expect_success 'untracked cache is empty' '
 info/exclude $ZERO_OID
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 EOF
 	test_cmp ../expect-empty ../actual
 '
@@ -133,7 +133,7 @@ cat >../dump.expect <<EOF &&
 info/exclude $EMPTY_BLOB
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $ZERO_OID recurse valid
 dthree/
 dtwo/
@@ -200,11 +200,7 @@ A  two
 ?? three
 EOF
 
-# Bypassing the untracked cache here is not desirable from an
-# end-user perspective, but is expected in the current design.
-# The untracked cache data stored for a -unormal run cannot be
-# correctly used in a -uall run - it would yield incorrect output.
-test_expect_success 'untracked cache is bypassed with -uall' '
+test_expect_success 'untracked cache completes partial directory listings with -uall' '
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
 	git status -uall --porcelain >../actual &&
@@ -214,16 +210,21 @@ test_expect_success 'untracked cache is bypassed with -uall' '
 	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
  ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:2
+ ....opendir:2
 EOF
 	test_cmp ../trace.expect ../trace.relevant
 '
 
-test_expect_success 'untracked cache remains after bypass' '
+test_expect_success 'untracked cache retains completed listings' '
+	sed "s/check_only //" ../dump.expect >../dump_uall.expect &&
 	test-tool dump-untracked-cache >../actual &&
-	test_cmp ../dump.expect ../actual
+	test_cmp ../dump_uall.expect ../actual
 '
 
-test_expect_success 'if -uall is configured, untracked cache gets populated by default' '
+test_expect_success 'if -uall is configured, untracked cache is reused by default' '
 	test_config status.showuntrackedfiles all &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -234,28 +235,14 @@ test_expect_success 'if -uall is configured, untracked cache gets populated by d
 	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
  ....path:
- ....node-creation:3
- ....gitignore-invalidation:1
+ ....node-creation:0
+ ....gitignore-invalidation:0
  ....directory-invalidation:0
- ....opendir:4
+ ....opendir:0
 EOF
 	test_cmp ../trace.expect ../trace.relevant
 '
 
-cat >../dump_uall.expect <<EOF &&
-info/exclude $EMPTY_BLOB
-core.excludesfile $ZERO_OID
-exclude_per_dir .gitignore
-flags 00000000
-/ $ZERO_OID recurse valid
-three
-/done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse valid
-three
-/dtwo/ $ZERO_OID recurse valid
-two
-EOF
-
 test_expect_success 'if -uall was configured, untracked cache is populated' '
 	test-tool dump-untracked-cache >../actual &&
 	test_cmp ../dump_uall.expect ../actual
@@ -280,12 +267,7 @@ EOF
 	test_cmp ../trace.expect ../trace.relevant
 '
 
-# Bypassing the untracked cache here is not desirable from an
-# end-user perspective, but is expected in the current design.
-# The untracked cache data stored for a -all run cannot be
-# correctly used in a -unormal run - it would yield incorrect
-# output.
-test_expect_success 'if -uall is configured, untracked cache is bypassed with -unormal' '
+test_expect_success 'if -uall is configured, untracked cache is reused with -unormal' '
 	test_config status.showuntrackedfiles all &&
 	: >../trace.output &&
 	GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace.output" \
@@ -296,12 +278,18 @@ test_expect_success 'if -uall is configured, untracked cache is bypassed with -u
 	get_relevant_traces ../trace.output ../trace.relevant &&
 	cat >../trace.expect <<EOF &&
  ....path:
+ ....node-creation:0
+ ....gitignore-invalidation:0
+ ....directory-invalidation:0
+ ....opendir:0
 EOF
 	test_cmp ../trace.expect ../trace.relevant
 '
 
-test_expect_success 'repopulate untracked cache for -unormal' '
-	git status --porcelain
+test_expect_success 'normal status preserves completed untracked cache' '
+	git status --porcelain &&
+	test-tool dump-untracked-cache >../actual &&
+	test_cmp ../dump_uall.expect ../actual
 '
 
 test_expect_success 'modify in root directory, one dir invalidation' '
@@ -340,16 +328,16 @@ test_expect_success 'verify untracked cache dump' '
 info/exclude $EMPTY_BLOB
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $ZERO_OID recurse valid
 dthree/
 dtwo/
 four
 three
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 three
-/dtwo/ $ZERO_OID recurse check_only valid
+/dtwo/ $ZERO_OID recurse valid
 two
 EOF
 	test_cmp ../expect ../actual
@@ -390,7 +378,7 @@ test_expect_success 'verify untracked cache dump' '
 info/exclude $EMPTY_BLOB
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dthree/
@@ -437,12 +425,12 @@ test_expect_success 'verify untracked cache dump' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dtwo/
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -456,10 +444,10 @@ test_expect_success 'move two from tracked to untracked' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -497,13 +485,13 @@ test_expect_success 'verify untracked cache dump' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dtwo/
 two
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -517,10 +505,10 @@ test_expect_success 'move two from untracked to tracked' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -558,12 +546,12 @@ test_expect_success 'verify untracked cache dump' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dtwo/
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -606,12 +594,12 @@ test_expect_success 'untracked cache correct after commit' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dtwo/
 /done/ $ZERO_OID recurse valid
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -669,13 +657,13 @@ test_expect_success 'untracked cache correct after status' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dtwo/
 /done/ $(test_oid done) recurse valid
 five
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -744,7 +732,7 @@ test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
 info/exclude $(test_oid exclude)
 core.excludesfile $ZERO_OID
 exclude_per_dir .gitignore
-flags 00000006
+flags 80000006
 / $(test_oid root) recurse valid
 .gitignore
 dtwo/
@@ -755,7 +743,7 @@ sub/
 sub/
 /done/sub/sub/ $ZERO_OID recurse check_only valid
 file
-/dthree/ $ZERO_OID recurse check_only valid
+/dthree/ $ZERO_OID recurse valid
 /dtwo/ $ZERO_OID recurse check_only valid
 two
 EOF
@@ -991,4 +979,73 @@ test_expect_success 'empty repo (no index) and core.untrackedCache' '
 	git -C emptyrepo -c core.untrackedCache=true write-tree
 '
 
+test_expect_success 'rescan a partial listing after removing the cached untracked file' '
+	test_create_repo partial-cache &&
+	(
+		cd partial-cache &&
+		touch tracked &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		mkdir -p d/a d/z &&
+		touch d/a/file d/z/file &&
+		test-tool chmtime =-300 . d d/a d/z &&
+		git status --porcelain >../actual &&
+		test-tool dump-untracked-cache >../dump &&
+		cached_dir=$(sed -n "s|^/d/\([^/]*\)/ .*check_only valid$|\1|p" ../dump) &&
+		test -n "$cached_dir" &&
+		rm "d/$cached_dir/file" &&
+		git status --porcelain >../actual &&
+		echo "?? d/" >../expect &&
+		test_cmp ../expect ../actual
+	)
+'
+
+test_expect_success 'untracked cache handles nested repository changes' '
+	test_create_repo nested-cache &&
+	(
+		cd nested-cache &&
+		touch tracked &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		git init nested &&
+		touch nested/file &&
+		test-tool chmtime =-300 . nested &&
+		git status -uall --porcelain >../actual &&
+		echo "?? nested/" >../expect &&
+		test_cmp ../expect ../actual &&
+		rm -rf nested/.git &&
+		git status -uall --porcelain >../actual &&
+		echo "?? nested/file" >../expect &&
+		test_cmp ../expect ../actual &&
+		git init nested &&
+		git status -uall --porcelain >../actual &&
+		echo "?? nested/" >../expect &&
+		test_cmp ../expect ../actual
+	)
+'
+
+test_expect_success 'filtered status retains complete untracked listings' '
+	test_create_repo filtered-cache &&
+	(
+		cd filtered-cache &&
+		touch tracked &&
+		git add tracked &&
+		git commit -m initial &&
+		git config core.untrackedCache true &&
+		mkdir d &&
+		touch d/match.toml d/other &&
+		test-tool chmtime =-300 . d &&
+		git status -uall --porcelain -- "**/*.toml" >../actual &&
+		echo "?? d/match.toml" >../expect &&
+		test_cmp ../expect ../actual &&
+		GIT_TRACE2_PERF="$TRASH_DIRECTORY/filtered.trace" \
+			git status -uall --porcelain >../actual &&
+		printf "%s\n" "?? d/match.toml" "?? d/other" >../expect &&
+		test_cmp ../expect ../actual &&
+		test_grep "read_directo.*opendir:0\$" "$TRASH_DIRECTORY/filtered.trace"
+	)
+'
+
 test_done

-- 
2.56.0.1134.g47ee84b154.frankengit

