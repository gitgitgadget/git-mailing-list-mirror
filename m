Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27CE38735A
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963351; cv=none; b=Lqf15sRHwM+AG8O/k4BrR6VIX/P886SzWtQ3MmT7M6BvTaXNUzeRqQAe1/JkgH6gv1QI2oZQ2hEiRk/eihH9u1y5sD7vim0NG7YPKGrWaRwTRE4+25WYQewqSHlsfQPxtS5GzlOqunSFhK3Ot0M79AC2LXdPzyjjH71cu3DwDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963351; c=relaxed/simple;
	bh=4yk9784iisuYZZFIEZZR/hHGPbWL2sKcxATm3h99+sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbtlQsG30Fcz2Lpk+Pwr3zVFhMDhH1HN0Jcyvdk1d7p+mHuI4f9ozFEf78VqFkkxu+0mQz785+6zLCTY54dV3hjd1d+2yLLF3m9mCFQzD6rXSRD4eGj0/niUfJuPO6qMVinkEmoNUP8JRfU5OujVRNUt6JDTNYwxpscii1sFR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJjtJI6X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJjtJI6X"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso94928985e9.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963348; x=1777568148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6O7lhc3upL87bhqDgebbAITXodlhenAoe1ugIKkD0qQ=;
        b=JJjtJI6XT1qyZDuZanK4JurZlI60gyG1LkBja8yVuttjrB/WOyGcDDDP04/UWVHmIG
         +TrYdqgG2Qs90/k/AzIBuqjDlXTtc2BXYRPf12HplaO7XyMakm0fdvIZ53/GZGSB0yTa
         kCK6wIXxZg8ahnqNe3mQ9el2NH7tYBQ2dnZXK7ux45VgW00uk55b1wC8fREATqy5ePfi
         KowxOyQfVHr2py/wo3dBQvguvDwh7KP3NV5cqDw0LVVWIzDPtSZvYj27HFaLtfRAV+n2
         6I+Ol4M9+yQqVguLDlshL87aUoJ3O5nTaeJ1mzAGh+QJMlfBBoIHyp7taqbVRoAWIdec
         8m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963348; x=1777568148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6O7lhc3upL87bhqDgebbAITXodlhenAoe1ugIKkD0qQ=;
        b=TaXM/FwsC+LHFGY+wPwkzMNxXAcp5xoAQOaq0WDsSjs+y8lTnzmozKl5AmL/O6o57D
         fo8OmDZxaLiJcKyIz8lS2WQEF8VMs6Ghh3z2/ZDWo1/0/eb5/FwHV4AcwWUwILU4FVDa
         q8hy+6nmHgHWfwVl31y8JlzwKS6IZXXVu1GQ2ZSGGMHY2jywTPleGYo81cyDoQgzWR5f
         qOQLElymaYH31rEaoYyNtSS3zEWA1NjWl6BvePuR7JQ+TJNvPtpEPJOeBjdDyznNeYtE
         E+2eQVYgUSzPnqcUhtf/Xkx0QhSp7mbXq+3kdQgB9GQDtAplG9u9Qirt3dG8mx8rA+kJ
         6+eA==
X-Gm-Message-State: AOJu0YyVqPlRb5t/WhENdli9fhS8m4rWikxcLWm92DedVr/t8Bf1BoWf
	hi4tga6lZjGcOUfbNblLJ+EoBhaT80yv799B+ghJIaY1kCTgjOSa72gKRRGJM04/
X-Gm-Gg: AeBDiesYUyPlLON9i12IfMBLBgSKxZzed/PSK1BnRBRcWccWftDziIcALu4YCHOwd9s
	mZ98Om/B/U428dZC2X79FUY0qv01ZeNYKcrxXHV+lfMisy9PBMpuRo14GHC92rUC1xY+cCvgI2g
	zwmq4Pysj6FVoXpcmUv9CmprgXCbzS2p0R4/miwjuE2SQ4KpTkhS5f89r7uITkLBuuEUm8L6twf
	1z06mRWK0ksztptI1nF6C3GSPoBdZVK/EzWYLD47whIL94hUKKLzM8VK8RHrpPjKDI95CC2maNX
	04UsIzxU5N/YwRQuQnAwzTNgCNX5FffGn37lFdE+bzx2ilhdBi5rtrfvTy52ahU+3D3JTGZ9LnV
	jxZZF/HLKbpIHKaAeCn9ubJ940ibaK2A72vSjJ3HBMNxNDm/fxxg5aNvspdYdF+ZNsLWb2rIztU
	eVzkGxqFRW943Gw5w1wLUtkgABBZyMmhkSFZuhrjIgGhKbrS43zuQHAFtQhQ1x4+8ZSrd9vg==
X-Received: by 2002:a05:600c:4fc7:b0:488:dbcb:ca08 with SMTP id 5b1f17b1804b1-488fb787a62mr387132685e9.30.1776963347715;
        Thu, 23 Apr 2026 09:55:47 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:47 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 5/8] environment: move "precomposed_unicode" into `struct repo_config_values`
Date: Thu, 23 Apr 2026 17:54:29 +0100
Message-ID: <20260423165432.143598-6-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260423165432.143598-1-belkid98@gmail.com>
References: <CAOLa=ZQDXn7181VfHpcWtNOSjTh9nzM3YnDTG_X1Vqh_v64bwg@mail.gmail.com>
 <20260423165432.143598-1-belkid98@gmail.com>
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

Change the type of the field from `int` to `bool` since it is parsed
as a boolean value.

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

