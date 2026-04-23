Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389BC37DE8B
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963348; cv=none; b=CbQrSBOC37h7Lr/ueUvRrpfhtaJOHQrz44vQohZ99EYyY9UB6JTNi7KA7YVN3j3+UvkmdeXg/DAducm7CZoWMl71zyJ3ZlcMrKggXX/XNXMKTdOE082R5q87YkrH2e4PfOAHUkjYHDJ863uoz9qrfp6OpCQ7H9wHl3pxITSl3+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963348; c=relaxed/simple;
	bh=2l7YoowQRxNRHfqKfY38obIFIl+0jy7o3e4Tdjjf4J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+Z3RsIRE1/V4D81yCzA2Sij2msZlbPGffuXl9rlkXk88LmfQ23qtMfkYxAJcWQRmx5FHV5XKqBKVKEpqHIOqmgsHEhbOWjhOpXYyfoHDoAmUXVhQJGtEQDLfmkdeg28aGeMjJuSPze8aPGdCiXYT2y6b/A8UrLKRub69xLVSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcEoqd3e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcEoqd3e"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so34195385e9.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963345; x=1777568145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm9hHKMhxwwsPVvH2XBgs1Mwm8VG9F0NC612plIz/eQ=;
        b=EcEoqd3epY0gy6yoeYACv4gXXnYHPxYXBSQfQNjaVyQR80mjBTXkv1onLL3mNVa1yl
         W3mIy/yv0eMDucBx6HbQXNohRr05pNI6qa7DCDRLTqlySEV4mnSIw/ivOglCrhUtfJTR
         Gzpq4nYS7CCKRwu4del46O5sdLc/rx5KL08T+rSgx/cXgvQCgQjq7ShLI43mberXUczF
         fW8uwyVYNvbGsi+KfxpCNOKgeo0xZnRUgEod8pXlFLwqyowZtW38I1mNe45XrDf/vmxh
         eIvymNyLcpsLc6YkoNH6nlxkDwdG+MRMrwT2N4Mcf3XR1qGC24qoEs2hskEx1HbojxPf
         X8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963345; x=1777568145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gm9hHKMhxwwsPVvH2XBgs1Mwm8VG9F0NC612plIz/eQ=;
        b=fo479hj5xqfmHBWBKwnfBzrXeUAnXZZt2xvZ2CfFF5hRroP5//9wU7KUMc8JZ1LxB5
         eOfCKMk+RU1YX9IKRDyOZVVFSzlDaD5DP9OKKVNZ+Dx1wryMX7WmCkylvxMxCqylhQ0d
         6/Nx/ZiRmqdnJd0gy6x3aGmQnVgpKdsIzdY5Ap4sOIHqsu8RXuBkmrzDxNCQeXrrh3ul
         kZqEuMGA1xAXT+4tdxgZTwnk2/2zaficU4XeFncl0fGwwBiHqMJqOOFw/trmyORqiJpH
         ne6ceQaa0q5I3BXqIox0728FdQFUyhRQX1wa2+l/ORaMZ8G6Sq8cgg9yOooWZV4aigSW
         9BPA==
X-Gm-Message-State: AOJu0YyIBOY9ngeHc5qMtIrpWd1qqlw4Vawz4nFN1MNd5RoT5Ix952Qh
	QN+C878VQ7+jLmrRJzGRcQmqXI4Rny/VzxH9mi95w0OnGSUSs+q3wWY2ZqD89xyb
X-Gm-Gg: AeBDietf4fEhoCIkzAQFaf1Hn+pq8g65OQOpNAsNRqvPdiRJivNrslWUSIoEqXw2re4
	h57fwy6MZzYkXaXnOSRzFYASQeiGu6JBBV1EC2fzj0cU7sCtQ2c7PhBuGSO7XWN9hEgtFp297c4
	yIPDEsIOImXtwYP3+a9o5fffVO6Njx0khrsTYYuliG+47a/XYFcpJkebNohp4L50+I89DcvGo1N
	v95x6+7ZzG5aFsC2pZ3qrNRKsE3VLjNpav1Aufxqu4YTJlx8yXh7sRQYoJAWqityalrMD0yn12V
	f2ByHOk68ixIXL76a4i+NqqYjcFz6bOmoaRvKYS1ermUAQprGsOzIFBUmM00EQVrufxQveKVHk8
	dM6iWv+LyiRHtttsf91kojW3S+W/TPUN08lx+RjEpd5Rdx80aSlWdF5UldkYE6I/OHpo5/KbVDZ
	UUbD7NZN3WnjkYjhxW3frwLa/u61+wo3mXfHyfgCxuWxlevAIByt51PRXFXyLjJJ3VdXVbrg==
X-Received: by 2002:a05:600c:3b04:b0:48a:5574:3a57 with SMTP id 5b1f17b1804b1-48a55743eb7mr166655095e9.29.1776963345081;
        Thu, 23 Apr 2026 09:55:45 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:44 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 4/8] environment: move "pack_compression_level" into `struct repo_config_values`
Date: Thu, 23 Apr 2026 17:54:28 +0100
Message-ID: <20260423165432.143598-5-belkid98@gmail.com>
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

The `pack_compression_level` configuration is currently stored in the
global variable `pack_compression_level`, which makes it shared across
repository instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `pack_compression_level` is parsed
eagerly because it influences packfile compression, a core operation
where a lazy parse could cause inconsistent behavior and hamper
libification. This preserves the existing eager‑parsing behavior while
tying the value to the repository from which it was read, avoiding
cross‑repository state leakage and continuing the effort to reduce
reliance on global configuration state.

The type remains `int` as it represents a numeric compression level,
not a boolean toggle.

Update all references to use `repo_config_values()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 builtin/fast-import.c  |  8 +++++---
 builtin/pack-objects.c | 17 ++++++++++-------
 environment.c          |  8 +++++---
 environment.h          |  2 +-
 object-file.c          |  3 ++-
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 82bc6dcc00..070a5af3e4 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -965,6 +965,7 @@ static int store_object(
 	unsigned long hdrlen, deltalen;
 	struct git_hash_ctx c;
 	git_zstream s;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
 				      dat->len);
@@ -1005,7 +1006,7 @@ static int store_object(
 	} else
 		delta = NULL;
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 	if (delta) {
 		s.next_in = delta;
 		s.avail_in = deltalen;
@@ -1032,7 +1033,7 @@ static int store_object(
 		if (delta) {
 			FREE_AND_NULL(delta);
 
-			git_deflate_init(&s, pack_compression_level);
+			git_deflate_init(&s, cfg->pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
 			s.avail_out = git_deflate_bound(&s, s.avail_in);
@@ -1115,6 +1116,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	struct git_hash_ctx c;
 	git_zstream s;
 	struct hashfile_checkpoint checkpoint;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 	int status = Z_OK;
 
 	/* Determine if we should auto-checkpoint. */
@@ -1134,7 +1136,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	crc32_begin(pack_file);
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(out_buf, out_sz, OBJ_BLOB, len);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index dd2480a73d..8ccbe7e178 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -386,8 +386,9 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	git_zstream stream;
 	void *in, *out;
 	unsigned long maxsize;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, cfg->pack_compression_level);
 	maxsize = git_deflate_bound(&stream, size);
 
 	in = *pptr;
@@ -413,8 +414,9 @@ static unsigned long write_large_blob_data(struct odb_read_stream *st, struct ha
 	unsigned char ibuf[1024 * 16];
 	unsigned char obuf[1024 * 16];
 	unsigned long olen = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&stream, pack_compression_level);
+	git_deflate_init(&stream, cfg->pack_compression_level);
 
 	for (;;) {
 		ssize_t readlen;
@@ -5003,6 +5005,7 @@ int cmd_pack_objects(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct list_objects_filter_options filter_options =
 		LIST_OBJECTS_FILTER_INIT;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	struct option pack_objects_options[] = {
 		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
@@ -5084,7 +5087,7 @@ int cmd_pack_objects(int argc,
 			 N_("ignore packs that have companion .keep file")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("ignore this pack")),
-		OPT_INTEGER(0, "compression", &pack_compression_level,
+		OPT_INTEGER(0, "compression", &cfg->pack_compression_level,
 			    N_("pack compression level")),
 		OPT_BOOL(0, "keep-true-parents", &grafts_keep_true_parents,
 			 N_("do not hide commits by grafts")),
@@ -5243,10 +5246,10 @@ int cmd_pack_objects(int argc,
 
 	if (!reuse_object)
 		reuse_delta = 0;
-	if (pack_compression_level == -1)
-		pack_compression_level = Z_DEFAULT_COMPRESSION;
-	else if (pack_compression_level < 0 || pack_compression_level > Z_BEST_COMPRESSION)
-		die(_("bad pack compression level %d"), pack_compression_level);
+	if (cfg->pack_compression_level == -1)
+		cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
+	else if (cfg->pack_compression_level < 0 || cfg->pack_compression_level > Z_BEST_COMPRESSION)
+		die(_("bad pack compression level %d"), cfg->pack_compression_level);
 
 	if (!delta_search_threads)	/* --threads=0 means autodetect */
 		delta_search_threads = online_cpus();
diff --git a/environment.c b/environment.c
index 5b0e88b65c..d0d3a4b7d2 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,6 @@ char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
 char *apply_default_ignorewhitespace;
-int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
@@ -390,7 +389,7 @@ int git_default_core_config(const char *var, const char *value,
 		if (!zlib_compression_seen)
 			cfg->zlib_compression_level = level;
 		if (!pack_compression_seen)
-			pack_compression_level = level;
+			cfg->pack_compression_level = level;
 		return 0;
 	}
 
@@ -662,6 +661,8 @@ static int git_default_attr_config(const char *var, const char *value)
 int git_default_config(const char *var, const char *value,
 		       const struct config_context *ctx, void *cb)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (starts_with(var, "core."))
 		return git_default_core_config(var, value, ctx, cb);
 
@@ -701,7 +702,7 @@ int git_default_config(const char *var, const char *value,
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
 			die(_("bad pack compression level %d"), level);
-		pack_compression_level = level;
+		cfg->pack_compression_level = level;
 		pack_compression_seen = 1;
 		return 0;
 	}
@@ -721,4 +722,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
+	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 }
diff --git a/environment.h b/environment.h
index 93201620af..514576b67a 100644
--- a/environment.h
+++ b/environment.h
@@ -94,6 +94,7 @@ struct repo_config_values {
 	int trust_ctime;
 	int check_stat;
 	int zlib_compression_level;
+	int pack_compression_level;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -171,7 +172,6 @@ extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
-extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
 
 extern int precomposed_unicode;
diff --git a/object-file.c b/object-file.c
index 7c122ac419..37def5cc59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1437,8 +1437,9 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
 	int status = Z_OK;
 	int write_object = (flags & INDEX_WRITE_OBJECT);
 	off_t offset = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	git_deflate_init(&s, pack_compression_level);
+	git_deflate_init(&s, cfg->pack_compression_level);
 
 	hdrlen = encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_BLOB, size);
 	s.next_out = obuf + hdrlen;
-- 
2.53.0.155.g9f36b15afa

