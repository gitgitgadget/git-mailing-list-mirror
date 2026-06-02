Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1A3F5BEF
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420261; cv=none; b=mApi9y0I/PV17EBjIYVaI2slPPYxnOCXDtzKvXj/M4uf6OvhRViVt5IjH6YqYBPEdrhffkKc6fZllJg6TQPTPvr6DKnr4OizWpZgc3o9TmYn32GwAzRulp3zRaOh3Uhj2RgjPAM2mVS8hWNtyNnSwHe3ozcGdRgpxP8VvHD+GrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420261; c=relaxed/simple;
	bh=JrEjBXahUGJzjWZQfUf3Y4tuat9rteeXG7ywSEpu4EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgocfk3NW9YM1xqBHz7rRKivLdBqVmi0YrsxY27VykbNX4pJcXNmvWUXhVn4zQoFcqbjPPflLVjKQ/8aLetum1gcrtkgMhtgSVH2F3EtEtWqw9aZKXe8tpK9gF2pktztYhkNNHLry4s/3Xr2m2t60kPvhRKKNjJFkAUpwY6YF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdnztQwz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdnztQwz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso9359065e9.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420258; x=1781025058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtcsazlIjBq/JVO+JdysopsCsILHEXZFRRCmUBSHna8=;
        b=EdnztQwz/MMSHHJNAHGMF9lsbnfLy3as8KA4PNsfoFHlRigU0hEItjGZ8KqgvmABb5
         Uu46mFTd9p+GkbPWNBP019XVxY3Sox9QWOR+oS+vhXb3g6ey8nX0PGlNBPu7ystM82vn
         GKxYOlNN/yLD8O9ScLZj68pZpzavdoLWtEQn1iVzfzqaH0BLNs9tQGhpOU2ohBfC0gnM
         QLAMY//e4h1/1cLdKAZDXtNA1snw+kQTbr4j8VdKtwReEwBMtBHTuxe6zKve8jq8NDbo
         22CSgD0fGLZrcAKrcdcmyfS5nekhaRfPcva8V9wOTt9FRGzkyrJWEVQuuTga5XVPfYpw
         iI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420258; x=1781025058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtcsazlIjBq/JVO+JdysopsCsILHEXZFRRCmUBSHna8=;
        b=SXVUjVG4DuXHo1FaZa5YX1TZQBz60Y4Mdf35Y/IWuyd+whDLhxwnI4P8Dxf3v7yrpw
         Is0PNBNRS38ReYHvufxjKAYtyLyjcJRVdDnbYTEJanXGFQoL5e5DWr9fw5luc0AOG5Pu
         go2vxCdmj0L5kZ72osJaKcs8D09sL1FdT4T1FkQFAgTLGeOR1xHaGDJ01gc/eIxIcLwf
         ZyV+fyZd6X90E+KWqplesZmKaLDC+XXpRhDJJsyTCcv2bHEPZgsG9/kg09PPndW0QKl/
         CWcOjRsv8Z+pbSrKId8Ftu5L1yD2nfFsuADCn8EWmVtTz2KcBM9joFT8w5tmr4UHkEW4
         Eizg==
X-Gm-Message-State: AOJu0YyJKu2HrPlqBt9I47yiDJZqoYUk5ITyHy8zzP+H6/BhOafl8ou4
	R9c2McA7bGMeTd07Q+8on9NBrSu704WFifANyKj72pz4R2J7LgRca3+3sSIWZUuz
X-Gm-Gg: Acq92OG4EihU8beQVo4eh/JAVLB2cYK5YrrCi4oq5bxVoEU/m95aOmA9LWM0JZTsjkd
	s25VqE0u2l+AsDuI2NswKFCe7rAZYLJh+3BSH/EUEm3clyDrzC2rUiugqf/Be9OTDgvF4rNUnJl
	CO7N74Ykr+7dn8Iwm/pfmm1OnxWZHLLK0PBTX0lcNflBiD5SDBj4F6Qt40vl2H63gU7S3dunVpk
	AgcN4sxPcL9YIrKN6IZ6q6y+3jcqxgRvNZW5AbygUriOwrWyp/io3PSRB8I+OTDwNsODFWc/5ds
	rwrBgleKanORWFqataJB1LMktqKm4Z93g17dbLs4yheiH67OYqFUuU1OSu3jwePxuloiPNaBgAj
	7fLltX9Nv+tybV64SghfhgGiXSNoY3Xlk/mBLP/Iai4ocj/unOtgjsoSTC1Vvawp7m/1nWM1Q39
	TlMlCK0DBY3iM8WOnOpPaP85IAktmJcaD8EHGTMksVrIvNL0mmf+JAjCW6AXGkYi3OTdURthY=
X-Received: by 2002:a05:600c:4508:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490b503f5d2mr10839745e9.1.1780420258271;
        Tue, 02 Jun 2026 10:10:58 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:10:57 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 5/8] environment: move "precomposed_unicode" into `struct repo_config_values`
Date: Tue,  2 Jun 2026 18:09:18 +0100
Message-ID: <20260602170921.35869-6-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260602170921.35869-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
 <20260602170921.35869-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `core.precomposeunicode` configuration is currently stored in the
global variable `precomposed_unicode`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `core.precomposeunicode` is parsed
eagerly because it controls Unicode path normalization on macOS,
a fundamental filesystem‑level behavior that many operations depend
on; a lazy parse could lead to inconsistent results and hamper
libification. This preserves the existing behavior while tying the
value to the repository from which it was read, avoiding cross‑
repository state leakage and continuing the effort to reduce reliance
on global configuration state.

Update all references to use `repo_config_values()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 compat/precompose_utf8.c | 20 +++++++++++++-------
 environment.c            |  4 ++--
 environment.h            |  2 +-
 upload-pack.c            |  3 ++-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 43b3be0114..0e94dbd862 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -48,16 +48,18 @@ void probe_utf8_pathname_composition(void)
 	static const char *auml_nfc = "\xc3\xa4";
 	static const char *auml_nfd = "\x61\xcc\x88";
 	int output_fd;
-	if (precomposed_unicode != -1)
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
+	if (cfg->precomposed_unicode != -1)
 		return; /* We found it defined in the global config, respect it */
 	repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 	output_fd = open(path.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
 	if (output_fd >= 0) {
 		close(output_fd);
 		repo_git_path_replace(the_repository, &path, "%s", auml_nfd);
-		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
+		cfg->precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
 		repo_config_set(the_repository, "core.precomposeunicode",
-				precomposed_unicode ? "true" : "false");
+				cfg->precomposed_unicode ? "true" : "false");
 		repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);
@@ -69,14 +71,16 @@ const char *precompose_string_if_needed(const char *in)
 {
 	size_t inlen;
 	size_t outlen;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!in)
 		return NULL;
 	if (has_non_ascii(in, (size_t)-1, &inlen)) {
 		iconv_t ic_prec;
 		char *out;
-		if (precomposed_unicode < 0)
-			repo_config_get_bool(the_repository, "core.precomposeunicode", &precomposed_unicode);
-		if (precomposed_unicode != 1)
+		if (cfg->precomposed_unicode < 0)
+			repo_config_get_bool(the_repository, "core.precomposeunicode", &cfg->precomposed_unicode);
+		if (cfg->precomposed_unicode != 1)
 			return in;
 		ic_prec = iconv_open(repo_encoding, path_encoding);
 		if (ic_prec == (iconv_t) -1)
@@ -130,7 +134,9 @@ PREC_DIR *precompose_utf8_opendir(const char *dirname)
 
 struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	struct dirent *res;
+
 	res = readdir(prec_dir->dirp);
 	if (res) {
 		size_t namelenz = strlen(res->d_name) + 1; /* \0 */
@@ -149,7 +155,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 		prec_dir->dirent_nfc->d_ino  = res->d_ino;
 		prec_dir->dirent_nfc->d_type = res->d_type;
 
-		if ((precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
+		if ((cfg->precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
diff --git a/environment.c b/environment.c
index d0d3a4b7d2..739b647ebe 100644
--- a/environment.c
+++ b/environment.c
@@ -72,7 +72,6 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
-int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
@@ -532,7 +531,7 @@ int git_default_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.precomposeunicode")) {
-		precomposed_unicode = git_config_bool(var, value);
+		cfg->precomposed_unicode = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -723,4 +722,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
+	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 }
diff --git a/environment.h b/environment.h
index 514576b67a..508cb1afbc 100644
--- a/environment.h
+++ b/environment.h
@@ -95,6 +95,7 @@ struct repo_config_values {
 	int check_stat;
 	int zlib_compression_level;
 	int pack_compression_level;
+	int precomposed_unicode;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -174,7 +175,6 @@ extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern unsigned long pack_size_limit_cfg;
 
-extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
diff --git a/upload-pack.c b/upload-pack.c
index 9f6d6fe48c..3a52237134 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1336,6 +1336,7 @@ static int upload_pack_config(const char *var, const char *value,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1366,7 +1367,7 @@ static int upload_pack_config(const char *var, const char *value,
 		if (value)
 			data->allow_packfile_uris = 1;
 	} else if (!strcmp("core.precomposeunicode", var)) {
-		precomposed_unicode = git_config_bool(var, value);
+		cfg->precomposed_unicode = git_config_bool(var, value);
 	} else if (!strcmp("transfer.advertisesid", var)) {
 		data->advertise_sid = git_config_bool(var, value);
 	}
-- 
2.53.0.155.g9f36b15afa

