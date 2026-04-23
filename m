Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74681FB1
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963344; cv=none; b=e2AfPJNRUnr0ilx0PcFO9xC9lY6DvkAO9nTo3qkEo1F4WBRom/DDN04c7vHHi2UXTk7WaE3FTaH6VElnlMjoE8y7pREh8Y45d7xTnI5fvEcMqsZbclF7nZaBjEptGOmcsQDEko9R+aQFrilOkx4DU9DmNOwsxpUmm6ENmgekX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963344; c=relaxed/simple;
	bh=Ns7EVHYX96JTmi55Gb5fbHzY0yUltDOuoBy00KVd9+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSH/E8Cl+r8bzwJfhIueRpOOne/NM/3w91q7CJRfwE1zDfrsM5Cr0BZzc3O9dCPIpDoMgj2HD3iXOd0brHI70SsokSZCvacjkLKgCgdIZj3LD48Qr6n8RrL2kGZNO575eLNg7Mn+lpM5Ucfz6pG6symrtydneOAuuCE4qm7+/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPQ6g0eA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPQ6g0eA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so34194645e9.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963340; x=1777568140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UIpsItiFR+iUXIEX0r0lmV1Ig3n9ALonrgv+Rn+uWI=;
        b=lPQ6g0eAl5bz8dxJRJSCJVwiU9mt+FWxX3wQ3oIIU0M2aGvPKisL25Q3CH1aEVx7O0
         moL3sBai+VlNVxeUZbMQfD95/iCssYxLkYBCituJZxNEWonZRhcShjA3Naw3AAaZqyBt
         ygAZhFpMZcT7a3UREvJIBPBVJSf+rfwwyl2i/AlPUkvWqDTTl2kgESYJzT7t6cFuxYeH
         RqsAATVDI23zj7g22Bl3FZpRIJdASjlECeeqoBPUrN0YL9SCJBkVvcF7WOc4eCnXHyEs
         MdHCYky5TOR6KvLIzfPuqBEgiHjh1IWeislVGW5HF3oMXNBTgCZwqFJbsh9SUZMj9uIC
         hzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963340; x=1777568140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+UIpsItiFR+iUXIEX0r0lmV1Ig3n9ALonrgv+Rn+uWI=;
        b=VC4ymuA2gorpvLm99HKcUQjIAd1u5ECP+2yLLZQLMh+M1I2TK5NR0XyAE98/Ld7Mpm
         XsnV61Hx6+6QFhJA89/xomS1/FFji9B5DdJfMg2O8OtmDfseKtYSCOP8kwG91kkxXodt
         zr+ipEAfOEZjTE/do7NUDday6sT36j3e+rsayT0ILra+FQ6hBpuuhUmX67dZEyd6A3xc
         0lBCgaxSFubjoPMCn8NkJcKaKjdSc931bSXVL/gF+M2GnNTgo6Ts74Ym4cxPg+qDWp9c
         M4ZcUxeSbQYhi2S6DOfi3wDm+JTUDxf0GKK7sDx/NU1OmEOa0whUskD6caDaBrSmOrWl
         FukA==
X-Gm-Message-State: AOJu0Yx/nWRQjXHV+wIoNt4rzkHHlVEJsihVDMLsvjaY8n8yJ0IxFHPI
	sE3fCjxqwGvF0/0gXnrR4q6YvNaML7WckieTGUvk+95FiiMcA8qOAplZdLSGRVg0
X-Gm-Gg: AeBDieuw2cFI/CjRLQ46SO68j0enYKnTf/zmcCp2gduF6GmrNPaa1WPC5y+sBTdRPsg
	GbB1Ny4BmTLj7yNtIiIFId/bRVpAZzteVe+LFHF+lb8pn866j10oT6hGFtv58Bnir5cQHlcA0FJ
	ROrAc8RUodguToND8s8kcxHV/cRne09EwTtkYLaT6hg+GkcOtmpfD6dOFDhVl5XZ2xW+pHzl6YB
	2hX4BU0ylsThuV8rKcqRz/rKHOZUmyWYaIiP/37dV4neS7z5/bKm62u0S4hPmfE7lHh8dZFDmMd
	1dAyE7G9Cmf2SWetO2CXugJXiLj37j6OoYMU5Bxx+uIbZjCwDgRHa0359yHoQl3XZ/8dSM1Tr3h
	sNJJP5J7RlC/wGYdldUAVJ81OYzO5wbjtAmB2aKFoyUEhbA2AYl3EkCQrVWmgpg4PDnEKv0mmyZ
	ZdFTeuR3VoHADpDaeAzfwdfWZXbyUwtbY2rutTNcuaSmzOPqYDTS5+g55LPtQoexBov7URBw==
X-Received: by 2002:a05:600c:5295:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488fb780463mr383909535e9.22.1776963339614;
        Thu, 23 Apr 2026 09:55:39 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:39 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 2/8] environment: move "check_stat" into `struct repo_config_values`
Date: Thu, 23 Apr 2026 17:54:26 +0100
Message-ID: <20260423165432.143598-3-belkid98@gmail.com>
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

The `core.checkstat` configuration is currently stored in the global
variable `check_stat`, which makes it shared across repository
instances within a single process.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. `core.checkstat` is parsed eagerly
because it controls how `match_stat_data()` and related functions
decide file freshness; a lazy parse could lead to unexpected
behavior or complicate libification. This preserves the existing
eager‑parsing behavior while tying the value to the repository it
was read from, avoiding cross‑repository state leakage, and
continuing the effort to reduce reliance on global configuration
state.

Update all references to use `repo_config_values()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 entry.c       |  3 ++-
 environment.c |  6 +++---
 environment.h |  2 +-
 statinfo.c    | 10 +++++-----
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/entry.c b/entry.c
index 7817aee362..c55e867d8a 100644
--- a/entry.c
+++ b/entry.c
@@ -443,7 +443,8 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 static void mark_colliding_entries(const struct checkout *state,
 				   struct cache_entry *ce, struct stat *st)
 {
-	int trust_ino = check_stat;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+	int trust_ino = cfg->check_stat;
 
 #if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	trust_ino = 0;
diff --git a/environment.c b/environment.c
index 0a9067729e..8542ac3141 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int trust_executable_bit = 1;
-int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
@@ -315,9 +314,9 @@ int git_default_core_config(const char *var, const char *value,
 		if (!value)
 			return config_error_nonbool(var);
 		if (!strcasecmp(value, "default"))
-			check_stat = 1;
+			cfg->check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
-			check_stat = 0;
+			cfg->check_stat = 0;
 		else
 			return error(_("invalid value for '%s': '%s'"),
 				     var, value);
@@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->apply_sparse_checkout = 0;
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
+	cfg->check_stat = 1;
 }
diff --git a/environment.h b/environment.h
index 64d537686e..1d3e2e4f23 100644
--- a/environment.h
+++ b/environment.h
@@ -92,6 +92,7 @@ struct repo_config_values {
 	char *attributes_file;
 	int apply_sparse_checkout;
 	int trust_ctime;
+	int check_stat;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -162,7 +163,6 @@ extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
diff --git a/statinfo.c b/statinfo.c
index 4fc12053f4..5e00af127d 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -68,19 +68,19 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && check_stat &&
+	if (cfg->trust_ctime && cfg->check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
-	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (cfg->trust_ctime && check_stat &&
+	if (cfg->trust_ctime && cfg->check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
 
-	if (check_stat) {
+	if (cfg->check_stat) {
 		if (sd->sd_uid != (unsigned int) st->st_uid ||
 			sd->sd_gid != (unsigned int) st->st_gid)
 			changed |= OWNER_CHANGED;
@@ -94,7 +94,7 @@ int match_stat_data(const struct stat_data *sd, struct stat *st)
 	 * clients will have different views of what "device"
 	 * the filesystem is on
 	 */
-	if (check_stat && sd->sd_dev != (unsigned int) st->st_dev)
+	if (cfg->check_stat && sd->sd_dev != (unsigned int) st->st_dev)
 			changed |= INODE_CHANGED;
 #endif
 
-- 
2.53.0.155.g9f36b15afa

