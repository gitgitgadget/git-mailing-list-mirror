Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310F3DB329
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328639; cv=none; b=U17rTTLt/N1ytjLy9jSyT9+2tNZRlHbUEJnigcnKH3prJpiZX/fsrCWeWe17kB6PplRQQNo5OLp9yPq7D4KFZgcMg+zxLGtXniVjWFHS4U5ArcfdAt1BwfCMxiOZk7VAJXvpigCOTER6nVCYmTl1R+Sl/L0i0Rplkq2oa7DHXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328639; c=relaxed/simple;
	bh=2l7YoowQRxNRHfqKfY38obIFIl+0jy7o3e4Tdjjf4J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxE8fzplK8zQTJY/S/NVK71k6jgY8TUbU+6mVnI6WKaOqw9NzDRHt2RoZrBVECS1u4hbCQkVmm8SKCO7RV++2YHavYaYjOacMz81tsjK49YrowqBWNx2qaYQhlc055mPe0O38Hl5U+J9fl/fQFuP9bFpAKhRVQEwVnKy2wTvB4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wwx12+H0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwx12+H0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490a7678b2dso13773105e9.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328636; x=1780933436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm9hHKMhxwwsPVvH2XBgs1Mwm8VG9F0NC612plIz/eQ=;
        b=Wwx12+H0h574RT5V7x1ssKV39KtKp6KyW1PQBXt7jPrSTlVFtel5qnywxW9XMCWIZ0
         xzA8ZbkAy7Vf31cGDeoESZgR6X00rAiAPZJNlEkuqMf9ii+f/VvQ3eaQuZShQmuyXoWQ
         S2C+YkQ95twWQthC+7Qjivc2nIa75RBxzykr1nM+Rrgfjx3Y2HI9GgSKHbJUlErAfP5S
         VEvQ0OF8ejm06eTz/zJ2hhpHpimihXuOw35lEUmyacg5/btbe+UhzGM668Np8MXLHUjN
         iXnbRAdM1ybwsnKHCSCXbBXs2lPPMhPE25VQYkhWy3pVYeox2k56gJ4bftb05hi6+fSD
         m0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328636; x=1780933436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gm9hHKMhxwwsPVvH2XBgs1Mwm8VG9F0NC612plIz/eQ=;
        b=NYJWo+BZSP0qU5YpVLRO1jN6ofXg7fbp6QlcgfPsn26kwk7kGban3d5NSZqUwWp0vh
         rAMH+Q1k5sdv1MUSx6klR5WFSYgddeSlGHBkccUBXEI/RWlRgc5C5SPxvf+3mlBaHPze
         S6JMrGSf5/rRF2cW8iAEAaBAB6H8QvmDSDWZf3XBHwps9wsOpu82oXhqXDCb7XQmEHUU
         XzpParTvIFZi+WLd+eWsB31z9o2Q+LzakWzreF7nZpvKUekr2GiE1hcznKghrTThTZ+K
         7XN0l2rggOmfbdnF9lFw5nplWAafOfZu+1TWCq9wNdFsOXHqAzKd9fSUZjF+SlihD3yU
         qoOA==
X-Gm-Message-State: AOJu0Yy0mnTC8TddUeaqae6E3zTg9i4GACLe8ERZD0uBs2e9Vs182dgJ
	cX69CBy/OmxAfSYngdZULfoqyfnJVdNjYabNxFbhdHo2CaNY0BF7iPsQzejcBcoz
X-Gm-Gg: Acq92OHgF2PL7Vch/vMsiGvMN3eEs0sycsj3vHz3dKFNS6Iv3yIQw74Aoa5aDWxEhmt
	LmdoDtiXK+Ktt+Ertb1SReDc1w59Bh1kOEweAx7hLEnUx1RgRa1cTBTs3AzdZ34/80OyetYxD9G
	2JopSR7wrcwg+Iq68wabtS1mJimVd7cVisWjQUyMRe50F9x1RPf45ioX5C2E1Ekiwh0yagJ1lbb
	XUtrCiR0TWurcDKMkoakOxNb+xHwVcdAP+tTeUvUhalZBk/Bd9XOKrw+3djKSj1DHKIo+HtyB8G
	SWcY9ThfqS2tyYPEb4bpPOXbHV9guXyfPel1rp/lZFDvfBdBniOTquP253r6NsKf7BvYDhYw3cj
	Pw25jmD3mc0BQz4LZJ9piOBdv1Hrae/hdOdNCvC5h8kfpGucsU4xtKQ6TKPs7jnc1mQmWOrGUJD
	WiH31BfD0IDTEYvjfKn3OhFfjfrCwnYsUzTQW7x0q70/77k9y7OSAbJzIP7vVDhHRrUQ==
X-Received: by 2002:a05:600c:1d86:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-490a28aa789mr226654495e9.0.1780328636086;
        Mon, 01 Jun 2026 08:43:56 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e07:e310:19bb:fe0b:a332:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e81ef4sm350485e9.12.2026.06.01.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:43:55 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 4/8] environment: move "pack_compression_level" into `struct repo_config_values`
Date: Mon,  1 Jun 2026 16:42:07 +0100
Message-ID: <20260601154211.82370-5-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260601154211.82370-1-belkid98@gmail.com>
References: <20260423160832.114816-1-belkid98@gmail.com>
 <20260601154211.82370-1-belkid98@gmail.com>
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

