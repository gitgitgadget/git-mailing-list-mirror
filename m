Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5284132C24
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983583; cv=none; b=aaf3NjQ5qSsPP0gtTzm9ynMtgBtaUfiJP0DI9YmB8HPVLTIz35YJ0wE0VaLv6Cw6k0Kcuonvb1r1n8EsVhZMEax71J5qkjPCHq5wscFak8/y5KLsFPsmV8MFRsmN+4OniqLOOhUZkcVoD1jhP2EdvsKxt5n9PGKv2LbEivraONs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983583; c=relaxed/simple;
	bh=LmURq/fYc3o5iG3U/tc+DgQkLzHIhlECUf1ER4VnfOY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LHrv0Jnso0PHIWcEpZkZ5SLvmaAaiLJsUWR9lyjdnGZr3hWIajgGAygzz2i7pcfep4dzL3HOd69QWb2rOuVuRjJtwSxBgqO6ftoqTJihMkE7CQ5sGI4RAIw7KL/JTgiZs+BjSO7f+y4Vr/3iQ2bz8N/4QmcZ2klH2SVU/ZWAFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvBth2Rw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvBth2Rw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso2803982f8f.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983579; x=1709588379; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94by6VO7UCaTrwpJRPiFK1jluEdf+nYi5L2eeKTkkLo=;
        b=FvBth2RwP0NLyFZp2ozjzuFHAYtbmcrMMPVj2QX90/2fVNxkFOk4Spb8XqfdS0PVyd
         /YlMSs/1W/dT6Ql/sXjHOwZhqhJr51YUp61ASelkV3z/3Dc7oylF7Hbpg8eNj2ofMT+k
         MuPVg68/jpan1j1mRQhrxNzQ4XekwdZy/jO2aaNgWgFDrKr+8/axaJWBGcwglEN+w04k
         JREzFwfaOd2ZzuhdCuPlf3QzxuTH8m4YHulSEPEoR+YZBhgqffcuqaiMVUqD3aekL0HX
         vkLs2iKnmhWTUTYm5F9Ctohj8G81bTBxnxLVCMe/L6hEUk6jlpRqyWgq0rzn8fPVxuhz
         rMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983579; x=1709588379;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94by6VO7UCaTrwpJRPiFK1jluEdf+nYi5L2eeKTkkLo=;
        b=RWN5mhZtLagNvSAhAFM43ItoiIDyjhFDUOpvBWxwC2lrZAyLdVGG1Mrl4jveYSy2Le
         ov5Ey1MZZbYDOs5gWXSgwRoxiAS4g9qvjNuRdA0xMjS4zpPRrtmoZoKEmN/fW6EU+LAc
         MKgfEGKdbU6lfgubtdJf6F1UvV+Gb81plKq6byTgWmNtvfjrBrJdxfb7YsgQeT+tE6iH
         NQKTEa3P6DsziHAmTbF/Vf5cqPfvAcfgGCFrj3VGcbOQUG6TxohLMT7ZebPjwzzStMR/
         3G8kP0NYiJLlW2UHncL/+NyeLF0cnTFvePrKSY1C9Q3hD/nN0WhuW4IjU1adpB4py0SA
         00fA==
X-Gm-Message-State: AOJu0YwoGJsZ9Aug0ReB0ARMfUTP+0UA8DWgkZn7/F+y9e7im2W6xpwO
	hioof/YqBUGpmEkvQmzpEX6XJ/7Iz3vM+IpCqe3uUMwH3uOjgh77SAkcyBNK
X-Google-Smtp-Source: AGHT+IGeRCpzUcBcfxGrH1hAc2iRBQc+m/fNQ9cNS/hKo8yBgYdOmC+F7YHpoernm9mwRM8EisGUfw==
X-Received: by 2002:adf:ea81:0:b0:33d:74f2:820e with SMTP id s1-20020adfea81000000b0033d74f2820emr6662868wrm.30.1708983579534;
        Mon, 26 Feb 2024 13:39:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b0033db9383e70sm9502014wrb.81.2024.02.26.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:38 -0800 (PST)
Message-ID: <ec036c04d1b003385683f0ed1dec80cc3bbfb813.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:25 +0000
Subject: [PATCH v3 14/14] fsmonitor: support case-insensitive events
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Teach fsmonitor_refresh_callback() to handle case-insensitive
lookups if case-sensitive lookups fail on case-insensitive systems.
This can cause 'git status' to report stale status for files if there
are case issues/errors in the worktree.

The FSMonitor daemon sends FSEvents using the observed spelling
of each pathname.  On case-insensitive file systems this may be
different than the expected case spelling.

The existing code uses index_name_pos() to find the cache-entry for
the pathname in the FSEvent and clear the CE_FSMONITOR_VALID bit so
that the worktree scan/index refresh will revisit and revalidate the
path.

On a case-insensitive file system, the exact match lookup may fail
to find the associated cache-entry. This causes status to think that
the cached CE flags are correct and skip over the file.

Update event handling to optionally use the name-hash and dir-name-hash
if necessary.

Also update t7527 to convert the "test_expect_failure" to "_success"
now that we have fixed the bug.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c                  | 121 +++++++++++++++++++++++++++++++++++
 t/t7527-builtin-fsmonitor.sh |  26 +++++---
 2 files changed, 137 insertions(+), 10 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 3c87449be87..2b17d60bbbe 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -5,6 +5,7 @@
 #include "ewah/ewok.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
+#include "name-hash.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -202,6 +203,113 @@ static void invalidate_ce_fsm(struct cache_entry *ce)
 static size_t handle_path_with_trailing_slash(
 	struct index_state *istate, const char *name, int pos);
 
+/*
+ * Use the name-hash to do a case-insensitive cache-entry lookup with
+ * the pathname and invalidate the cache-entry.
+ *
+ * Returns the number of cache-entries that we invalidated.
+ */
+static size_t handle_using_name_hash_icase(
+	struct index_state *istate, const char *name)
+{
+	struct cache_entry *ce = NULL;
+
+	ce = index_file_exists(istate, name, strlen(name), 1);
+	if (!ce)
+		return 0;
+
+	/*
+	 * A case-insensitive search in the name-hash using the
+	 * observed pathname found a cache-entry, so the observed path
+	 * is case-incorrect.  Invalidate the cache-entry and use the
+	 * correct spelling from the cache-entry to invalidate the
+	 * untracked-cache.  Since we now have sparse-directories in
+	 * the index, the observed pathname may represent a regular
+	 * file or a sparse-index directory.
+	 *
+	 * Note that we should not have seen FSEvents for a
+	 * sparse-index directory, but we handle it just in case.
+	 *
+	 * Either way, we know that there are not any cache-entries for
+	 * children inside the cone of the directory, so we don't need to
+	 * do the usual scan.
+	 */
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
+			 name, ce->name);
+
+	/*
+	 * NEEDSWORK: We used the name-hash to find the correct
+	 * case-spelling of the pathname in the cache-entry[], so
+	 * technically this is a tracked file or a sparse-directory.
+	 * It should not have any entries in the untracked-cache, so
+	 * we should not need to use the case-corrected spelling to
+	 * invalidate the the untracked-cache.  So we may not need to
+	 * do this.  For now, I'm going to be conservative and always
+	 * do it; we can revisit this later.
+	 */
+	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
+
+	invalidate_ce_fsm(ce);
+	return 1;
+}
+
+/*
+ * Use the dir-name-hash to find the correct-case spelling of the
+ * directory.  Use the canonical spelling to invalidate all of the
+ * cache-entries within the matching cone.
+ *
+ * Returns the number of cache-entries that we invalidated.
+ */
+static size_t handle_using_dir_name_hash_icase(
+	struct index_state *istate, const char *name)
+{
+	struct strbuf canonical_path = STRBUF_INIT;
+	int pos;
+	size_t len = strlen(name);
+	size_t nr_in_cone;
+
+	if (name[len - 1] == '/')
+		len--;
+
+	if (!index_dir_find(istate, name, len, &canonical_path))
+		return 0; /* name is untracked */
+
+	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
+		strbuf_release(&canonical_path);
+		/*
+		 * NEEDSWORK: Our caller already tried an exact match
+		 * and failed to find one.  They called us to do an
+		 * ICASE match, so we should never get an exact match,
+		 * so we could promote this to a BUG() here if we
+		 * wanted to.  It doesn't hurt anything to just return
+		 * 0 and go on because we should never get here.  Or we
+		 * could just get rid of the memcmp() and this "if"
+		 * clause completely.
+		 */
+		BUG("handle_using_dir_name_hash_icase(%s) did not exact match",
+		    name);
+	}
+
+	trace_printf_key(&trace_fsmonitor,
+			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
+			 name, canonical_path.buf);
+
+	/*
+	 * The dir-name-hash only tells us the corrected spelling of
+	 * the prefix.  We have to use this canonical path to do a
+	 * lookup in the cache-entry array so that we repeat the
+	 * original search using the case-corrected spelling.
+	 */
+	strbuf_addch(&canonical_path, '/');
+	pos = index_name_pos(istate, canonical_path.buf,
+			     canonical_path.len);
+	nr_in_cone = handle_path_with_trailing_slash(
+		istate, canonical_path.buf, pos);
+	strbuf_release(&canonical_path);
+	return nr_in_cone;
+}
+
 /*
  * The daemon sent an observed pathname without a trailing slash.
  * (This is the normal case.)  We do not know if it is a tracked or
@@ -335,6 +443,19 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	else
 		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
 
+	/*
+	 * If we did not find an exact match for this pathname or any
+	 * cache-entries with this directory prefix and we're on a
+	 * case-insensitive file system, try again using the name-hash
+	 * and dir-name-hash.
+	 */
+	if (!nr_in_cone && ignore_case) {
+		nr_in_cone = handle_using_name_hash_icase(istate, name);
+		if (!nr_in_cone)
+			nr_in_cone = handle_using_dir_name_hash_icase(
+				istate, name);
+	}
+
 	if (nr_in_cone)
 		trace_printf_key(&trace_fsmonitor,
 				 "fsmonitor_refresh_callback CNT: %d",
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 830f2d9de33..730f3c7f810 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -1051,7 +1051,7 @@ test_expect_success 'split-index and FSMonitor work well together' '
 #
 # The setup is a little contrived.
 #
-test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
 
 	git init subdir_case_wrong &&
@@ -1116,19 +1116,19 @@ test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
 
 	grep -q "dir1/DIR2/dir3/file3.*pos -3" "$PWD/subdir_case_wrong.log1" &&
 
+	# Verify that we get a mapping event to correct the case.
+	grep -q "MAP:.*dir1/DIR2/dir3/file3.*dir1/dir2/dir3/file3" \
+		"$PWD/subdir_case_wrong.log1" &&
+
 	# The refresh-callbacks should have caused "git status" to clear
 	# the CE_FSMONITOR_VALID bit on each of those files and caused
 	# the worktree scan to visit them and mark them as modified.
 	grep -q " M AAA" "$PWD/subdir_case_wrong.out" &&
 	grep -q " M zzz" "$PWD/subdir_case_wrong.out" &&
-
-	# Expect Breakage: with the case confusion, the "(pos -3)" causes
-	# the client to not clear the CE_FSMONITOR_VALID bit and therefore
-	# status will not rescan the file and therefore not report it as dirty.
 	grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
 '
 
-test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
+test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
 
 	git init file_case_wrong &&
@@ -1242,14 +1242,20 @@ test_expect_failure CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
 	GIT_TRACE_FSMONITOR="$PWD/file_case_wrong-try3.log" \
 		git -C file_case_wrong --no-optional-locks status --short \
 			>"$PWD/file_case_wrong-try3.out" &&
+
+	# Verify that we get a mapping event to correct the case.
+	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir3/FILE-3-A.*dir1/dir2/dir3/file-3-a" \
+		"$PWD/file_case_wrong-try3.log" &&
+	grep -q "fsmonitor_refresh_callback MAP:.*dir1/dir2/dir4/file-4-a.*dir1/dir2/dir4/FILE-4-A" \
+		"$PWD/file_case_wrong-try3.log" &&
+
 	# FSEvents are in observed case.
 	grep -q "fsmonitor_refresh_callback.*FILE-3-A.*pos -3" "$PWD/file_case_wrong-try3.log" &&
 	grep -q "fsmonitor_refresh_callback.*file-4-a.*pos -9" "$PWD/file_case_wrong-try3.log" &&
 
-	# Expect Breakage: with the case confusion, the "(pos-3)" and
-	# "(pos -9)" causes the client to not clear the CE_FSMONITOR_VALID
-	# bit and therefore status will not rescan the files and therefore
-	# not report them as dirty.
+	# The refresh-callbacks should have caused "git status" to clear
+	# the CE_FSMONITOR_VALID bit on each of those files and caused
+	# the worktree scan to visit them and mark them as modified.
 	grep -q " M dir1/dir2/dir3/file-3-a" "$PWD/file_case_wrong-try3.out" &&
 	grep -q " M dir1/dir2/dir4/FILE-4-A" "$PWD/file_case_wrong-try3.out"
 '
-- 
gitgitgadget
