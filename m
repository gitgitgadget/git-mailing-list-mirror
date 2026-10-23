Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792755092;
	b=g390xJRaoAheYiji/HGTbjLH+P7pAlIeMO7RQaUJ7rOLjYht6WiS9vCuSUY7HwbKYz97
	 z5eTBNq6+6e+UcamuxO7+/3mNPfSeXdMIQ/8koPuyDD2XRNSSxxeczU1XEGcqdiBjdmtM
	 njhSRLslv2U0JTlsKrb9Wrt8j5JAePd+lhRYnFxlv/r4A1s4AE2w2Ahd+bj4POTdiKfyL
	 00ld4QKo1T8u8R2Ts8GgupubJyf/44HYvF58EwbEHyU+AE5XIRZZFa4ZDzhT6SkZ4/jdT
	 oRG9462auFieypnKDyQrHLUEWRtdTk3Q8wCDOXgb7ouC/PQ5yiJ0b81+z4jp708NczA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792755092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=c/EiaANs4IvFjE0IaFMKdO6CwcShtyxXwGjk3x9n3Fk=;
	b=jwuChGD2tPSlXgnmBR9zmPQ3/Z4ewl57wNLv/adC/A1DoipIXBDzZYZCClvFN3lxTSFE
	 +AtFE6vtrEEBgU19sRc4atboO/x/ctZdP6YGwdUu3VvSRPNgywHYxAl5QG9ogUwcStOOI
	 VcFSjH1+mqsGXPvGp6IxcWf8SRQh7nCce6lAF0/ZtwfTMUPpFGsJ55rQ2jvbV3xPFP6KB
	 3xIK3Gwdc5cBB1LYA8qboHAnejnd50cvyOvmTK00H9vWjcb15Mzpy0YuUEo0zOa4lb5+3
	 JID9Ytus3PqS02q55XNBr/RKEDJJ2lREJAn+Ojaxo4zgwQ7e+nLXHRHKXRj+eACtXUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jVppls4Y;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEBD606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCEBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jVppls4Y
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab41538192so581460a91.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792755091; x=1793359891; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c/EiaANs4IvFjE0IaFMKdO6CwcShtyxXwGjk3x9n3Fk=;
        b=jVppls4Y1prTau1MyND773Lc8P1e9mBaX3hXl6ZAPsGu4z6K5nX0+T7OnfeRUNnEZR
         xN6b/gGj+caFeW/wSOSxk+kfEr1fscz3fKrsdQEI56qIUTbhGFYwzKYUphAt6dG9CqwO
         +s9kOBGDPx3O5F9ahsKN9pyG7JS9P0qDhaORfVWsnn35XIpaqQ6W94bFnTp8XGasMovw
         SguIJ2COy/axgbcdYmLw+lfQ6lTjFeHppBAEtAoAyGDsejFtR6KsPH3TCCwEpHjEfX/7
         oYaJFWTLy1ujREoEvcKN/R0SjsQluLOXg01L9eb553F3kaNXx6pz/EERLsYONrJEp2Ht
         RyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792755091; x=1793359891;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c/EiaANs4IvFjE0IaFMKdO6CwcShtyxXwGjk3x9n3Fk=;
        b=GoHihCPaFxqQoTNM34PBGF2vHEHpsiHAIViUH0YbS2ZuNjGIcZtdIlYNB2ZmrXyX1N
         ACF/121dhIbesuPxHRAEM7wLR+atCBF9aKQYukqrFBszBoFgnWmgU1ExBszzKxikha+/
         nhN6Wy/nuorMgo3Pd+l99FyWLtfGrWsfmxcxg7SOgWwcOSez2wY4mQo6+SnI8dnGbDdn
         E+4svnqasdrUki79EwR9N8GacwirS1FkcrpsON0F60E7Mbl2tQPLsc5s+ffX5prr10JC
         JOp0rGPKIs5YPB4lYKkVJejj7SW0vaJsWGQJlsz+YY8FGZaL+DPuZ/t62eECFPKFhrmp
         /fEQ==
X-Gm-Message-State: AFq9FYIKVqfuhKmBE6lInEDPIxIxsBArlqATbdZcY4KQ5itR2n+laTgn
	P3UuwonW2sIcLmXVonKbBmIJv8fWGpvN/yUVfsYzTSxph2qF/6iZivNqm3JOGSW6
X-Gm-Gg: AYBFou0Q5I19VxmdCMxfKAn7sqgOMl3dH2kh0UzAQv6aZoP1b4opJV2NdPq2EYwj3VI
	xp8DW8kAmW1cmfR7+7cK63Yng/3VF2hkvqZKY/BhDHlMjzHBCxB7xzZMvd61m0KBWsf3j96hoG8
	nF/Kesjfg/2s9tS+PkmtjQSzjU1juAhKf2htizUzwKByN7Karm3pqrNd9qrngcfztyvuXs6qxXp
	NR8JDwUcU7B2F4x2fCQib0wl93/Tns7xVzCeJfy2NlCQGoHRr3uavOCPl13Dj/IwVkAVk1kzAGb
	6yE8hJXCNXbk26aHGYuLZwdmw2HF+sXnPhGlK8dvZifXcmrPvDd5SsFpewsBCuiUHE9ePzhldGs
	JghFD9sF29/wGkTx6LV5m8Pxs3lQMqqCHuQAUtKXkvNsfnVs+LoWzdMCd0NB24orRf3VF7BdTZV
	6mhIlZ2PwNuHRXygnh3+iklBf/c37Ojj3WJT8maRapjrW6SXJPFqy+Ye4f11sArXuyWlQcvPN/u
	F70NexLPS7klymx8+qMuCtAue1SWUUX0PtjPbsJrI+dIQp6p6rbV5WvvvGL1FJaLzElteVwkwsw
	nS8=
X-Received: by 2002:a17:90a:d40c:b0:3ac:9c37:9418 with SMTP id 98e67ed59e1d1-3adcdfa9befmr1648326a91.19.1792755091081;
        Fri, 23 Oct 2026 04:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add246f308sm1134783a91.0.2026.10.23.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 04:31:30 -0700 (PDT)
Message-Id: <pull.2278.git.1792755089871.gitgitgadget@gmail.com>
From: "Joy via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 11:31:29 +0000
Subject: [PATCH] config: move core.ignorestat into repo config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Joy <soniqjjj@gmail.com>,
    Joy Gundu <soniqjjj@gmail.com>

From: Joy Gundu <soniqjjj@gmail.com>

The core.ignorestat setting is currently stored in the standalone
assume_unchanged global variable. This makes the configuration state
harder to encapsulate as Git moves towards being usable as a library.

Store the setting in struct repo_config_values instead and update its
consumers to read the value through repo_config_values(). This removes
another standalone global while preserving the existing behavior.

Add a test covering the effect of core.ignorestat on updated paths.

Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
---
    config: move core.ignorestat into repo config

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2278%2FJoiejoie1%2Foutreachy%2Fassume-unchanged-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2278/Joiejoie1/outreachy/assume-unchanged-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2278

 builtin/update-index.c                   | 2 +-
 environment.c                            | 3 +--
 environment.h                            | 3 +--
 read-cache.c                             | 8 +++++---
 t/t2106-update-index-assume-unchanged.sh | 9 +++++++++
 5 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 018b78d6bb..59412770ca 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -431,7 +431,7 @@ static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
-	if (assume_unchanged)
+	if (repo_config_values(the_repository)->assume_unchanged)
 		ce->ce_flags |= CE_VALID;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
diff --git a/environment.c b/environment.c
index c83cf44839..f19aa07f7e 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int minimum_abbrev = 4, default_abbrev = -1;
-int assume_unchanged;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 int fsync_object_files = -1;
@@ -371,7 +370,7 @@ int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.ignorestat")) {
-		assume_unchanged = git_config_bool(var, value);
+		cfg->assume_unchanged = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/environment.h b/environment.h
index 49c86e8879..443a962a6a 100644
--- a/environment.h
+++ b/environment.h
@@ -146,6 +146,7 @@ struct repo_config_values {
 	int protect_hfs;
 	int protect_ntfs;
 	int ignore_case;
+	int assume_unchanged;
 	int trust_executable_bit;
 	int has_symlinks;
 	int use_nanosec;
@@ -242,9 +243,7 @@ int have_git_dir(void);
 
 /* Environment bits from configuration mechanism */
 extern int minimum_abbrev, default_abbrev;
-extern int assume_unchanged;
 extern unsigned long pack_size_limit_cfg;
-
 extern int grafts_keep_true_parents;
 
 const char *get_log_output_encoding(void);
diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..a1430fc427 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -194,7 +194,7 @@ void fill_stat_cache_info(struct index_state *istate, struct cache_entry *ce, st
 {
 	fill_stat_data(&ce->ce_stat_data, st);
 
-	if (assume_unchanged)
+	if (repo_config_values(the_repository)->assume_unchanged)
 		ce->ce_flags |= CE_VALID;
 
 	if (S_ISREG(st->st_mode)) {
@@ -1415,7 +1415,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 		 * is not marked VALID, this is the place to mark it
 		 * valid again, under "assume unchanged" mode.
 		 */
-		if (ignore_valid && assume_unchanged &&
+		if (ignore_valid &&
+		    repo_config_values(the_repository)->assume_unchanged &&
 		    !(ce->ce_flags & CE_VALID))
 			; /* mark this one VALID again */
 		else {
@@ -1450,7 +1451,8 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	 * (i.e. things to be edited) will reacquire CE_VALID bit
 	 * automatically, which is not really what we want.
 	 */
-	if (!ignore_valid && assume_unchanged &&
+	if (!ignore_valid &&
+	    repo_config_values(the_repository)->assume_unchanged &&
 	    !(ce->ce_flags & CE_VALID))
 		updated->ce_flags &= ~CE_VALID;
 
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 6b2ccc21a9..9b83fe197c 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -24,4 +24,13 @@ test_expect_success 'do not switch branches with dirty file' '
 	test_grep overwritten err
 '
 
+test_expect_success 'core.ignorestat marks updated paths assume-unchanged' '
+	git reset --hard &&
+	git update-index --no-assume-unchanged file &&
+	test_config core.ignorestat true &&
+	echo changed >file &&
+	git update-index file &&
+	test "$(git ls-files -v file)" = "h file"
+'
+
 test_done

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
