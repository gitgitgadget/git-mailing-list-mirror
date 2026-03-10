Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9B9391E58
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144475; cv=none; b=ci4QGwPzBQKS4kd9yC/eplEBpSXc/CnSRB3ju/rqk07rJUw3Enzrwd/aSbLn1I2rwHQTKAoBxWSGl3yZggQA94FqIqHButeRg/5RY0dTtH87ICx+oAlEADBcmHTO+SJEx4cMpWjByXLl2mqUzuTbcKbMaUccRyddDDHhyGTVDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144475; c=relaxed/simple;
	bh=ci0Lk3CzqsE19Nzs14YbEXzImrvyQqLcU503tWrhon8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ay2sh56j1XRGBLEuV9kCmm4iQZertValt4WjgG7MHDEnzpM6F1u10PL3iHETAKEM3UA4ZXT8lnOQfq6mwqoezzxrbyJveGfy8GQaTnKayJSoDH2PQk/PVCw7L1Cd2dxWFPliVen3/+p80ggdIQc3l+1uE3QAVcpT16tb8AD9Us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJKB82mu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJKB82mu"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7986fb839f5so112218987b3.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144473; x=1773749273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9VCTDb59i4xUByEkU4q/QiVGJ9e6dqRb88+lDFK4P0=;
        b=AJKB82muLyDEkOslS0CKA7Tck0tE9zZHMGjx3Jg8h6FFK82pbi1S8kL95ber0IDtZ9
         a4Dc3z44Z3YA0UYE5AMkA58kGwW1+Uwqmyw/pZuD/oURNLICHD2Ge08rCvsNMxH9o+EU
         NGBSalqi1yKSlHfPJxf1LV7BjSHy/Uwq5EkdZBOJjeeIj7pijhBddxucD9jRcPP9ylYr
         gm9PBrw7QpT5i5L2CLV6HrnwTUNQMw5zP7Dk8mGq5GejkLy//tZYQoPReF29VKknp6k2
         js6WNxoA5Kq9xzXWUkKk/5IARHGVLAOGQiyvwlfQqPJa+m4GwAL3HJ+3OnF9A/3NJuhS
         lYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144473; x=1773749273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9VCTDb59i4xUByEkU4q/QiVGJ9e6dqRb88+lDFK4P0=;
        b=fQypPOKnv8QQTTG6DiuWCGJTAC2gBHWXkREJmwWUQf9vgv7VigyEL3t3UfT2d+Z73Q
         /5wTVYknfzJ6dndqKAJqPiCdqVlvooP3RgAP8dgGP+FT/DPpUwLVrWFQEhzYhYsrJozO
         lpYkKVzQtS0Qqka/hATNevhE3D3FXkO9ixx9Ye9j3MRKryc31TD838pTDSYJI+2spB9Z
         u79WY5fgK9Ru6ppmWlNsTFjRLj6+epToaAC1q0BRshEKl7nd945/aCcwZGbCRfIByuZy
         Tqo55OOprBR/CSvI+6vfjB3bDQ2jJwW7Zx0/Nwj0eENLpRx13mONsCWkJQU39/SfVJs3
         3DqA==
X-Gm-Message-State: AOJu0Yw38Zu5HZASO94AfQsMhajQMokbVz3GPxUT1hhyz4gRLafKVIrz
	fUvkyILG0boZa2W7BzW9d74Ral7Q8EPysc1Nh4MiKpZNNyR99BeFC9/LNbrtmLpd
X-Gm-Gg: ATEYQzwmaRc6zzQeam1Q55R46XpRqn+oPvw+lbZ4Wit3TsMR57IKPZrggdnSS1M+AFO
	EYy/JZUl4OJVxt9c0rtuuPyW+/g2rJhU47TOMVAdX3YA6FD2cgdKZIgPta2dSh0VFtGPH1HFqDu
	Ugm+IBCRXxZlLRAsobNQIUfVhnlFfU+xgJSB1Lh9PahY+xTiRnHGjfh+ckoQWlP0OUcZOgN2M4n
	PGISo79qW06B9WftsBL5kNxPYYYczHSPorQ558Ba3+jrHMHRUxj0rEyZHdZtXq7WTeKEswsrhaj
	dLnsIAJnkkid1toGqhhf/5muRsia0t5eb+pxvclr8jSlLyxFVMpUV7puEbWC6QbcDjYdAmpjjNC
	zScZx/l4066fk55nDdr3x3sZy2uytA0eDBGZo49Fmh1dOj8SGQQdA0/rmM/wTCG0eQZl88cFEbI
	AP6wyki43rXoMqrkP+qpWZGNtDZ4kmpONT7scCUg==
X-Received: by 2002:a05:690c:3392:b0:799:182:17d1 with SMTP id 00721157ae682-79901821c3fmr49921807b3.45.1773144472723;
        Tue, 10 Mar 2026 05:07:52 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:07:52 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 5/8] environment: move "precomposed_unicode" into `struct repo_config_values`
Date: Tue, 10 Mar 2026 13:06:26 +0100
Message-ID: <48af23a0d6ea26659d0c51ffe3d1835c12627a02.1773127785.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
References: <cover.1773127785.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `core.precomposeunicode` configuration is currently stored in the
global variable `precomposed_unicode`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values` so the value is associated
with the repository from which it was read. This preserves existing
behavior while avoiding cross-repository state leakage and is another
step toward eliminating repository-dependent global state.

Update all references to use repo_config_values().

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
index 88dac1b65c..afa3ef7655 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1288,6 +1288,7 @@ static int upload_pack_config(const char *var, const char *value,
 			      void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1318,7 +1319,7 @@ static int upload_pack_config(const char *var, const char *value,
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

