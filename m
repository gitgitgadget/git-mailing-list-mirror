Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B21CEEB4
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618674; cv=none; b=JYYyqTAPMynFlR3DmcTRWb9+19XKVzJMx99YX647d6FSsWTYqMRLMTDvq/Owz4FFRZeyy5xocbyyEaLgYoz7mkttZRkQMGoTp3abD/wDGu5PVO47CYSZ1Qu7qyGBHCfO6jq7f7cz5o4t1JRFEyC1pApHshC2azg/Cw0hZwJZ2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618674; c=relaxed/simple;
	bh=GifmbOMCXu1DXhDalLiT8QK37QVvvECynMhCPERZ0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPNhLDpf+XNdPW8S47DSrsoVaWicBuPz6o6dunXwnlRkD1ehpAKicpBl4IRsiRR1G2gaN9V1ghOSWviB56hn4qEErDNpuMXyK6Gzu2ASWEQEwRHHjESaMyuNE+bjMUXoywhgVdEmi4qWIvbweUxq4s4BsqqYTwk9D4NiqSAaXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkUXgy88; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkUXgy88"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso892692566b.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618671; x=1733223471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSx2hZyXepjaEN2+2ltRoRef/8t5e4LgcGxjOb5tUTw=;
        b=QkUXgy88Yv7Q7KtEkcCLYI0brAJGipAr3P/gJ0V1vwOHAVJPWsmxqfp7JHZ6uk9Urb
         Z2mn/p8QQpceZ4AZSHPrF11NlJX/butzZxvOVVwExK74NxKGA1V2wp9nMhyx78b+/fvt
         QireJgyuB2+hrD/4bo1ho2Foi8gG2J5OD356On719apGFET3JGRk+HJywRDUJpSW9tr3
         4AHcQz+lL+00n2v96654U8SNuq292ujdMYdi7RU7oePJ0hZTB5flBhQ6zjWAWQbzLNne
         pXV60JgmUkwaIfaJF3uWCJUW0ZD/CU5USLphFIFYAc1oNpQd7/zQw9PK3Szq1AkZMFgc
         T8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618671; x=1733223471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSx2hZyXepjaEN2+2ltRoRef/8t5e4LgcGxjOb5tUTw=;
        b=U/o+zcyVghGEZMcd5AwOZSqf/tUrDRKPy6WBDr/N7l7ZqsVhQcXnfoQpUnKgVW4p8Z
         RMwTreQsZoRDOmV4wbnOlv3PPOlpeNFk5X9wwylVPJ10fqiGTeDlw65OppUE5SOv0FvV
         Qy3Z6KXwJoMfKgvhX7v/LxHYyNzM/4fuXLqQVS9+RRoVntM24kjgnDpwXH472ZhHLxb7
         jAw4sLtQZC2y4HpAzs7eEK1rRxyLiMlVxKmtzbNb3FFNJxOukdoWlikoNEua4j5da12P
         zOV3MW0RQZQr1L2j5QgwAW9qFgLxtHPTN0VivNyBGP3GI+DP3x5c3f0SQ0RAF9sweCHS
         RSzQ==
X-Gm-Message-State: AOJu0Yy4Atsms3ejLo+BURYbL3hLz+LSoVEm+LfrokofJ1R4nmLcP4fJ
	hGoKexl+hPEFdyHP5UO6hABqDohn7xYFci9vQhHbA8oEtAgDk2Ly
X-Gm-Gg: ASbGncsEj7hbSARwAgMCI/BGTHUbe/x8XAuPZ0Me70JxOmhFLqJpyubSYCeuFRKowLu
	kxBB+CCL+kKO+yS2VqL8z1gj0o0PzrSZ8RIi4i9o/DeDhqkzHKKBD4OgRWDiJrOwamhihaFD27S
	00+OKmcCqI3sm78TfsiNHwBTmaI1uw8ttep6YzT1xZp43WIIOSQrExHh7JIkUlV8F7B6ELL6RZu
	lKHJvsShDX9aQXjc1Mo9NBsWNLvc5CJ85n6boOn5zpKmtC50gyQUg48HyjZo2k=
X-Google-Smtp-Source: AGHT+IEd96l4p2ZSZWTaOwsRUW3sGv0hcwiHI/YPx7FADm1el/ruErQqv+eb0uru44lAthXgwcwiSA==
X-Received: by 2002:a17:906:4c2:b0:aa5:da4:3c0a with SMTP id a640c23a62f3a-aa50da43c96mr1050880166b.59.1732618671005;
        Tue, 26 Nov 2024 02:57:51 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm587461366b.187.2024.11.26.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:57:50 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v9 08/10] config: make `packed_git_(limit|window_size)` non-global variables
Date: Tue, 26 Nov 2024 11:57:39 +0100
Message-ID: <bce9196f6b7b1fca338aaac265def9072b07e7ca.1732618495.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
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

