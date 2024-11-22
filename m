Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8441DF251
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270124; cv=none; b=PEJUaYsoEU2SeGpEtYF8W634WKukpBSryD07wUoqOZBmd0QvdIFnnkumLWCDk8m4zbQI5n9+lriWHgaRWg06nzMWnZPISqqKTovYK0SjuiafwpHA9iKhWORFpDIxk7uheyTdyjGRjjzrkm5Au5UN16KL1Snw5kylAfLoyharL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270124; c=relaxed/simple;
	bh=GifmbOMCXu1DXhDalLiT8QK37QVvvECynMhCPERZ0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2A750taK0920mqx3AtCvTng+P2PFn8BnRihB830Vb8z0Xtx/HyBPfy7tooisc6+8P+vChj96pajXu0TDw/Hz9a7WUSOGoztt3p2/N18MMGDXo/rRjGAv820j30QVSg8BhX/jocHHHi6ym0xxiU4TYiEV1gRe6YGln5EbRGPIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz5wjRNg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz5wjRNg"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cef772621eso2451398a12.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270120; x=1732874920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSx2hZyXepjaEN2+2ltRoRef/8t5e4LgcGxjOb5tUTw=;
        b=Vz5wjRNgS0K1dWxhCUsLbnU7u2DvrbhXXY6HCgp6mG8OREDuQy2BJGQob4hTIEGY9u
         2iZehuWvSR2VJ4Af5SGQGZtE2QZF5JMtIodhgFMEz/2RKgCUfNdDJuXFDENmXp26lMDE
         umJ1YUW95ve0p8Ctn0wXAacPJm3o9UJQnainuRmnkE14hQft19DLZPS73bl5boJbA9/l
         1w/MSzFLpuOjMvDslSx9w4miCVBo+8gWPXmjJK0p75tfG//nSgnUZTsn0fHPbTOuJfil
         a+hpI3r9oiB06U4+Efg5IZlEmXBJeEzTE10P1lTQRxW9ut+g65r8mrkzhbkiP1TPcAer
         /6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270120; x=1732874920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSx2hZyXepjaEN2+2ltRoRef/8t5e4LgcGxjOb5tUTw=;
        b=KsypgF9rQIzRE7UC288J8G5Sa0N1vba3EL9ZAeXmLuG5gRA2Kv3w4iMLXdBEeeJM7h
         4BKDLfVW9DawA+6XzI+qVCSfoDZQYo+S1bUPJAbspvhYVNN8JSpzzaHvnaoLW1jwmI18
         E43JGy5sKiQB9QYFYGoSIvL2VU1p73iy6LOfJy4S8vMdaF9nJ6aJnl34tooFKHYCndxA
         VUYSGV4dy0TTpP+iRFsgYfTvOzKLK/ZklBfvmANJlwOXnMiT8hMrP7Y5bEbUzBzwxdZe
         CamARvU0s2o5+TlSXeU/SmEFC7Vdxyr0Nw7qS5E6FY7OfP9CUuwRVS/aarZaU2w38r1f
         yh0Q==
X-Gm-Message-State: AOJu0YzfLNH3zxciQKlFw3kF3A6Fx1FjwHSn0sYDR97stXfaIDZhSJc3
	DjCrDAZOhX8A49V3LecMkemMIZWa2D0moex5ewFgcSVRmLMrrSwK
X-Gm-Gg: ASbGncuAuLbUlxDt2bGsAAjQgbE54hqCzbqSrusGa3QmoO8+G3r3EnizJezjh9jAz+k
	kbYynaDTCoFVRF3h/++A14ng2R0zJbzsnt9psyKv2ShPIGVHK6qQfpXtJ/lljdvJXGbmTWBqZgT
	fnPgynwRxwc6mVga0nbgWpqEnpm7h5n09/+m0S6uFrDjABwahczL7qvwhT8jirMOikkZBZcu4rs
	6mqEBEai516caVlkE6FZNmOZydAnt6apinie2jeJB2ZI01d0w82/DztwJI4Y4E=
X-Google-Smtp-Source: AGHT+IF/Et6KzuTHD6TZmQqZL8ZN0gT4qO1F8Vv+Xvqwp8MqmE+YGjN5+7TXMQtlPNGsH2eWbmD6dg==
X-Received: by 2002:a05:6402:5286:b0:5cf:eaf4:bc98 with SMTP id 4fb4d7f45d1cf-5d02062975dmr1632948a12.18.1732270119809;
        Fri, 22 Nov 2024 02:08:39 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:39 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 08/10] config: make `packed_git_(limit|window_size)` non-global variables
Date: Fri, 22 Nov 2024 11:08:27 +0100
Message-ID: <30a52f192f07fcc45d692ed1a42d21571c5c53b9.1732269840.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732269840.git.karthik.188@gmail.com>
References: <cover.1732269840.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variables `packed_git_window_size` and `packed_git_limit` are global
config variables used in the `packfile.c` file. Since it is only used in
this file, let's change it from being a global config variable to a
local variable for the subsystem.

With this, we rid `packfile.c` from all global variable usage and this
means we can also remove the `USE_THE_REPOSITORY_VARIABLE` guard from
the file.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c |  4 ++--
 config.c              | 17 -----------------
 environment.c         |  2 --
 packfile.c            | 23 +++++++++++++++--------
 packfile.h            |  2 +-
 repo-settings.c       | 13 +++++++++++++
 repo-settings.h       |  4 ++++
 7 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3ccc4c5722..0ece070260 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3539,7 +3539,7 @@ static void parse_argv(void)
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
-		    struct repository *repo UNUSED)
+		    struct repository *repo)
 {
 	unsigned int i;
 
@@ -3660,7 +3660,7 @@ int cmd_fast_import(int argc,
 		fprintf(stderr, "       pools:    %10lu KiB\n", (unsigned long)((tree_entry_allocd + fi_mem_pool.pool_alloc) /1024));
 		fprintf(stderr, "     objects:    %10" PRIuMAX " KiB\n", (alloc_count*sizeof(struct object_entry))/1024);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
-		pack_report();
+		pack_report(repo);
 		fprintf(stderr, "---------------------------------------------------------------------\n");
 		fprintf(stderr, "\n");
 	}
diff --git a/config.c b/config.c
index 728ef98e42..2c295f7430 100644
--- a/config.c
+++ b/config.c
@@ -1493,28 +1493,11 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.packedgitwindowsize")) {
-		int pgsz_x2 = getpagesize() * 2;
-		packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
-
-		/* This value must be multiple of (pagesize * 2) */
-		packed_git_window_size /= pgsz_x2;
-		if (packed_git_window_size < 1)
-			packed_git_window_size = 1;
-		packed_git_window_size *= pgsz_x2;
-		return 0;
-	}
-
 	if (!strcmp(var, "core.bigfilethreshold")) {
 		big_file_threshold = git_config_ulong(var, value, ctx->kvi);
 		return 0;
 	}
 
-	if (!strcmp(var, "core.packedgitlimit")) {
-		packed_git_limit = git_config_ulong(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = AUTO_CRLF_INPUT;
diff --git a/environment.c b/environment.c
index 8e5022c282..8389a27270 100644
--- a/environment.c
+++ b/environment.c
@@ -49,8 +49,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
-size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 char *editor_program;
 char *askpass_program;
diff --git a/packfile.c b/packfile.c
index 64248ca664..2e0e28c7de 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -46,15 +45,15 @@ static size_t pack_mapped;
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-void pack_report(void)
+void pack_report(struct repository *repo)
 {
 	fprintf(stderr,
 		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
 		"pack_report: core.packedGitLimit      = %10" SZ_FMT "\n",
 		sz_fmt(getpagesize()),
-		sz_fmt(packed_git_window_size),
-		sz_fmt(packed_git_limit));
+		sz_fmt(repo->settings.packed_git_window_size),
+		sz_fmt(repo->settings.packed_git_limit));
 	fprintf(stderr,
 		"pack_report: pack_used_ctr            = %10u\n"
 		"pack_report: pack_mmap_calls          = %10u\n"
@@ -650,8 +649,15 @@ unsigned char *use_pack(struct packed_git *p,
 				break;
 		}
 		if (!win) {
-			size_t window_align = packed_git_window_size / 2;
+			size_t window_align;
 			off_t len;
+			struct repo_settings *settings;
+
+			/* lazy load the settings in case it hasn't been setup */
+			prepare_repo_settings(p->repo);
+			settings = &p->repo->settings;
+
+			window_align = settings->packed_git_window_size / 2;
 
 			if (p->pack_fd == -1 && open_packed_git(p))
 				die("packfile %s cannot be accessed", p->pack_name);
@@ -659,11 +665,12 @@ unsigned char *use_pack(struct packed_git *p,
 			CALLOC_ARRAY(win, 1);
 			win->offset = (offset / window_align) * window_align;
 			len = p->pack_size - win->offset;
-			if (len > packed_git_window_size)
-				len = packed_git_window_size;
+			if (len > settings->packed_git_window_size)
+				len = settings->packed_git_window_size;
 			win->len = (size_t)len;
 			pack_mapped += win->len;
-			while (packed_git_limit < pack_mapped
+
+			while (settings->packed_git_limit < pack_mapped
 				&& unuse_one_window(p))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
diff --git a/packfile.h b/packfile.h
index addb95b0c4..58104fa009 100644
--- a/packfile.h
+++ b/packfile.h
@@ -89,7 +89,7 @@ unsigned long repo_approximate_object_count(struct repository *r);
 struct packed_git *find_oid_pack(const struct object_id *oid,
 				 struct packed_git *packs);
 
-void pack_report(void);
+void pack_report(struct repository *repo);
 
 /*
  * mmap the index file for the specified packfile (if it is not
diff --git a/repo-settings.c b/repo-settings.c
index acc27eb8fe..9d16d5399e 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -128,6 +128,19 @@ void prepare_repo_settings(struct repository *r)
 
 	if (!repo_config_get_ulong(r, "core.deltabasecachelimit", &ulongval))
 		r->settings.delta_base_cache_limit = ulongval;
+
+	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &ulongval)) {
+		int pgsz_x2 = getpagesize() * 2;
+
+		/* This value must be multiple of (pagesize * 2) */
+		ulongval /= pgsz_x2;
+		if (ulongval < 1)
+			ulongval = 1;
+		r->settings.packed_git_window_size = ulongval * pgsz_x2;
+	}
+
+	if (!repo_config_get_ulong(r, "core.packedgitlimit", &ulongval))
+		r->settings.packed_git_limit = ulongval;
 }
 
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
diff --git a/repo-settings.h b/repo-settings.h
index 10a6f7ed64..93ea0c3274 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -59,6 +59,8 @@ struct repo_settings {
 	int warn_ambiguous_refs; /* lazily loaded via accessor */
 
 	size_t delta_base_cache_limit;
+	size_t packed_git_window_size;
+	size_t packed_git_limit;
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
@@ -66,6 +68,8 @@ struct repo_settings {
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
 	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
+	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
 }
 
 void prepare_repo_settings(struct repository *r);
-- 
2.47.0

