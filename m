Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCA1E8826
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504705; cv=none; b=SkKthg4cSG1Ejtw1bLm0gUZCCdxp3ZnrI9qUIzyBxGtLBky4dlLWY9KbkbUEchaI8TwRP7Pp1eWHK5i3M1qcklR6zhSVVMx9dZ4lfVdkJaJZNOoXIpr7jTiPLchQU7eUTrfsargKB8LdugZHJIbtmkTAuiinSTtdlcqtdxPeoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504705; c=relaxed/simple;
	bh=OCg36hFeewasaQEA3iNtJ44ENuPFSBxeOSlB721BK9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcchBa8VnPdeKl73qM+XC/HmoceXm1jvAjIHe7L1aVISHQ1RskTrtkhGdrnr5wvunKfC5t5TyJDGV7pQS1jbi+BMUrSYjcHzrrHfTjV5yf9qOjhtbQnxqUhamdTNGRamLSZ11C4W7kTUlflR6EJrHg+s+kwEFaDnWOiWC3KlzYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3BUNCgt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3BUNCgt"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso632677066b.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504701; x=1730109501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWnn1wOSbxo76WjiRnaI5PmbDdmzTaf644Y7ccr05N8=;
        b=A3BUNCgta3oLQBNzrzaQ+0Tmm1G0g3e4RRT/k0r7Ba2NTfreshvuvkwmxt7R+qqb8B
         Mig2CmSFBt8a18qsuVe0uah3luT3OiPOqJ/fCFLm2wooVdAklYRy+nUw0DQUFrModudm
         +1kdsWmpJAvzqtIfUFeTpDHz93QHhTTWHKbf8px9Brr5MUIyXC0wv3D0SN6tLXuXz179
         4wdBZAv2dt67GZrWfczPNpWKLdE5pi7zw+pcQValZZqt3K1qhRTNrfLs6LeXJhKodSel
         MOiR2I9AkStpc77zhp3w8hfsQFrdpoyq7NuVLg6e7rGg+yZCDY5znwR+3PKxUKNF7Co/
         6rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504701; x=1730109501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWnn1wOSbxo76WjiRnaI5PmbDdmzTaf644Y7ccr05N8=;
        b=sh87oRihrh/phNEZcX32DFl2Qjje0L+qCIHCpTuUeXW+en9uTKJvhbRigqBeQPhfIj
         JEsdiZCulnY48cXA6hlk1KfdClHkeQ4niFca4PGypOP2ofUMFerqS+xYahcY1AWOdWLY
         qc8g9ubHd4vTquCqMx8dKBGwL5SobATdXrXEiMx+99eiN9HpM5WSu6cbLKTHzfs8rqfy
         owCNxyyrY13cCWaHZJoLtLVyYzfO8/Aheyyz9R7uQYb+6p5YBsC9yzuZtkwMwFtKInC9
         oSJBu1/fBEDNWVXL/IsJXMKQVms5VFfghkz0EbshGQiw7cowKe3rOz3rIBZH8s2V70Vu
         CM7Q==
X-Gm-Message-State: AOJu0YyOqiTAuAyQBUnclR1RVS27UbWoSSXMvy+h+jL2iXmirBIB/X2h
	xbeUOdN23xtDe36m2huL2IXyzjkOr664+95LNSaQfAxmUFbwvx7eBVAEaghW
X-Google-Smtp-Source: AGHT+IHsIFifYWznAC8umUIRZ+MUOZir++rdR2qo2TcZwMWdHhyZm1MdLVNoHdxTj4jAkO1t7+c+aw==
X-Received: by 2002:a17:906:c102:b0:a9a:33c:f6e1 with SMTP id a640c23a62f3a-a9a69a639a3mr1032571466b.5.1729504700853;
        Mon, 21 Oct 2024 02:58:20 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:20 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 19/20] config: make `delta_base_cache_limit` a non-global variable
Date: Mon, 21 Oct 2024 11:58:02 +0200
Message-ID: <dd86a7ebc3f1345ee375aa041b1f7a33d69400af.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `delta_base_cache_limit` variable is a global config variable used
by multiple subsystems. Let's make this non-global, by adding this
variable to the stack of each of the subsystems where it is used.

In `gc.c` we add it to the `gc_config` struct and also the constructor
function. In `index-pack.c` we add it to the `pack_idx_option` struct
and its constructor. Finally, in `packfile.c` we dynamically retrieve
this value from the repository config, since the value is only used once
in the entire subsystem.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/gc.c         |  5 ++++-
 builtin/index-pack.c | 10 +++++++---
 config.c             |  5 -----
 environment.c        |  1 -
 environment.h        |  1 -
 pack-objects.h       |  3 ++-
 pack-write.c         |  1 +
 pack.h               |  1 +
 packfile.c           | 13 +++++++++++--
 9 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c..9a10eb58bc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -138,6 +138,7 @@ struct gc_config {
 	char *repack_filter_to;
 	unsigned long big_pack_threshold;
 	unsigned long max_delta_cache_size;
+	unsigned long delta_base_cache_limit;
 };
 
 #define GC_CONFIG_INIT { \
@@ -153,6 +154,7 @@ struct gc_config {
 	.prune_expire = xstrdup("2.weeks.ago"), \
 	.prune_worktrees_expire = xstrdup("3.months.ago"), \
 	.max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE, \
+	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 }
 
 static void gc_config_release(struct gc_config *cfg)
@@ -205,6 +207,7 @@ static void gc_config(struct gc_config *cfg)
 
 	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
+	git_config_get_ulong("core.deltabasecachelimit", &cfg->delta_base_cache_limit);
 
 	if (!git_config_get_string("gc.repackfilter", &owned)) {
 		free(cfg->repack_filter);
@@ -416,7 +419,7 @@ static uint64_t estimate_repack_memory(struct gc_config *cfg,
 	 * read_sha1_file() (either at delta calculation phase, or
 	 * writing phase) also fills up the delta base cache
 	 */
-	heap += delta_base_cache_limit;
+	heap += cfg->delta_base_cache_limit;
 	/* and of course pack-objects has its own delta cache */
 	heap += cfg->max_delta_cache_size;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1898dc37a6..f1edf7068d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1238,7 +1238,7 @@ static void parse_pack_objects(unsigned char *hash)
  *   recursively checking if the resulting object is used as a base
  *   for some more deltas.
  */
-static void resolve_deltas(void)
+static void resolve_deltas(struct pack_idx_option *opts)
 {
 	int i;
 
@@ -1254,7 +1254,7 @@ static void resolve_deltas(void)
 					  nr_ref_deltas + nr_ofs_deltas);
 
 	nr_dispatched = 0;
-	base_cache_limit = delta_base_cache_limit * nr_threads;
+	base_cache_limit = opts->delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
 		work_lock();
@@ -1604,6 +1604,10 @@ static int git_index_pack_config(const char *k, const char *v,
 		else
 			opts->flags &= ~WRITE_REV;
 	}
+	if (!strcmp(k, "core.deltabasecachelimit")) {
+		opts->delta_base_cache_limit = git_config_ulong(k, v, ctx->kvi);
+		return 0;
+	}
 	return git_default_config(k, v, ctx, cb);
 }
 
@@ -1930,7 +1934,7 @@ int cmd_index_pack(int argc,
 	parse_pack_objects(pack_hash);
 	if (report_end_of_input)
 		write_in_full(2, "\0", 1);
-	resolve_deltas();
+	resolve_deltas(&opts);
 	conclude_pack(fix_thin_pack, curr_pack, pack_hash);
 	free(ofs_deltas);
 	free(ref_deltas);
diff --git a/config.c b/config.c
index a11bb85da3..728ef98e42 100644
--- a/config.c
+++ b/config.c
@@ -1515,11 +1515,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = AUTO_CRLF_INPUT;
diff --git a/environment.c b/environment.c
index a2ce998081..8e5022c282 100644
--- a/environment.c
+++ b/environment.c
@@ -51,7 +51,6 @@ enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
-size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 char *editor_program;
 char *askpass_program;
diff --git a/environment.h b/environment.h
index 923e12661e..2f43340f0b 100644
--- a/environment.h
+++ b/environment.h
@@ -165,7 +165,6 @@ extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
-extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
diff --git a/pack-objects.h b/pack-objects.h
index b9898a4e64..3f6f504203 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -7,7 +7,8 @@
 
 struct repository;
 
-#define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
+#define DEFAULT_DELTA_CACHE_SIZE       (256 * 1024 * 1024)
+#define DEFAULT_DELTA_BASE_CACHE_LIMIT (96 * 1024 * 1024)
 
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
diff --git a/pack-write.c b/pack-write.c
index 8c7dfddc5a..98a8c0e785 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -21,6 +21,7 @@ void reset_pack_idx_option(struct pack_idx_option *opts)
 	memset(opts, 0, sizeof(*opts));
 	opts->version = 2;
 	opts->off32_limit = 0x7fffffff;
+	opts->delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
 }
 
 static int sha1_compare(const void *_a, const void *_b)
diff --git a/pack.h b/pack.h
index 02bbdfb19c..1a33751565 100644
--- a/pack.h
+++ b/pack.h
@@ -58,6 +58,7 @@ struct pack_idx_option {
 	 */
 	int anomaly_alloc, anomaly_nr;
 	uint32_t *anomaly;
+	unsigned long delta_base_cache_limit;
 };
 
 void reset_pack_idx_option(struct pack_idx_option *);
diff --git a/packfile.c b/packfile.c
index 1415df38e9..c9812eedad 100644
--- a/packfile.c
+++ b/packfile.c
@@ -24,6 +24,8 @@
 #include "commit-graph.h"
 #include "pack-revindex.h"
 #include "promisor-remote.h"
+#include "config.h"
+#include "pack-objects.h"
 
 char *odb_pack_name(struct repository *repo, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext)
@@ -1494,7 +1496,9 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
+				 void *base, unsigned long base_size,
+				 unsigned long delta_base_cache_limit,
+				 enum object_type type)
 {
 	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
@@ -1697,6 +1701,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
 	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
 	int base_from_cache = 0;
+	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
+
+	repo_config_get_ulong(r, "core.deltabasecachelimit", &delta_base_cache_limit);
 
 	write_pack_access_log(p, obj_offset);
 
@@ -1881,7 +1888,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		 * before we are done using it.
 		 */
 		if (!external_base)
-			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
+			add_delta_base_cache(p, base_obj_offset, base,
+					     base_size, delta_base_cache_limit,
+					     type);
 
 		free(delta_data);
 		free(external_base);
-- 
2.47.0

