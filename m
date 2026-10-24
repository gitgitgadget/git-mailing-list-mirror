Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879233;
	b=ZQX96aBw5lojt78N+NKELt38kOcrMM5KWg9+7jqC1nlY6HZx6GlIyxaN5/42ioHZDuT9
	 gnYzEwcfeDS7OjOFZmntzSgE45CuM78gB8qtFXm3e7l4KlivBzAAoq99AflqbSbYTGgTO
	 sb//VOB9U8hP78dtqSCw0n050d7S2vDuDP/Y21veAp1uAbBG41L91Lp8R7Tm2Npy5H5RB
	 a6SS7/7YLiOEyOJ1aR5LkBkJmYnOtEyPMIgsTWYV/Qpn3ogAJdtWmeV77cogOe5aYkkPw
	 a6f9Q2ZjmznKv39Lo1qkxjabYnrcx8Dc0+d11WR99K3zu6ZNME+qOtTXTmfmD+OuWrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F2WpylZO8DZ4AjkEeHI08TI3uQLXPEUr6DCTZqm7O6s=;
	b=DlVpgSrsSfqzv4HTL94UxKEyiu9r8Ve9QruH+xObEk6MnDn3R5GG8zxCH6r3/bHyzJ+s
	 5t+quNNzL6M+jx+5qBkTl5S0xMYH/xnefhXUew1K/O/hFSFeNFiav/dbQkvd9aDczlBp0
	 mW+SJ2siV7nIOGbnIQCDJqmToFNutMG1qzsXdexOCKeFVBnBSpKet9gzMvDopjR3YtRtQ
	 7UG3uZwjOlWJ2+8cnw2gORBSOIYl1kL1xsyPRwqk/HaUkbjdpkfqQllYd12kqNwfTffQe
	 KbeiyJb099jS42xP7QEJqMRczIqtBed4oWxPcc/PhuJCetEMBGAIDDO0AJoUX6nvCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rwg4ZEE/";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D122E606A31B
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D122E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rwg4ZEE/
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so3224152c88.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879232; x=1793484032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F2WpylZO8DZ4AjkEeHI08TI3uQLXPEUr6DCTZqm7O6s=;
        b=rwg4ZEE/PaGTc0rRisA9FGqxNrptapTvboxNosv9BXzd2UGHCtRUAssjdlapb2Qmj5
         VizbnSnLBV0hdO1a6PGQboqU55ii90SZ9U3fKc8yY79q4IwyMEa0kTNrBYROZlG6QEG1
         ozIz5FwNeKCFUDalkQn5vc6sDiAUs7csu3ZqQkDGNeLLaMYF4pjgoJF76dyKDLUwicp3
         F6Or0E2HCVyG35uYCR6vLlfHoxf7FLUbA9FqHaGtNBWsaq/2HgakAKtM6oeISLY9erXC
         +ar3xA3KkXlyBIm70PRatBCiDBwaVH5iaFIVhIyE+umB9AU6jCIy0C3LPjbvyA8vA1T9
         ZioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879232; x=1793484032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F2WpylZO8DZ4AjkEeHI08TI3uQLXPEUr6DCTZqm7O6s=;
        b=U/1jKD+Qlo65uT2H4zVaqcmu9WQUs2axkannEVVJhriWZRjIKYv+zoMWjHqUVWNTfy
         8ND2NtW9155AfJu/o1Vs5hfuUi+HN5SwAYNWQUlGY5MdRmhYXua+iHfmEOMp9xZjguvD
         eLTIimDJUInlXtekyYDWmEWkfX+87pPtqHX/nVgag931XkfCcr6MB4DlCoexX2AM8QJ0
         u6aLW0whB9fJs1of41l/bYOeJS99JrxxPUFHShxspMRnH6getG6XxZtFFW2OabWncwSJ
         QhpmMkBOsoOySGbwLRy4XqD8lJNyD6vpMZPzHlutadP030LspKjEB37E32TKzkkvu0ka
         m83Q==
X-Gm-Message-State: AFq9FYIr4lOLtWwL62H3u4O4VEZZc/rlVUsfuwkeuGecjaYDJ2UYyf4k
	swL5iqV/MvDv8OvO5K823+QkNUu98U/e1mcxi/7R2+lC5i0MGQEp5m5sXjBMQYAc8RI=
X-Gm-Gg: AYBFou0vrKi5Ba+QO9MBqlF5NskELFywyfpwGdPGyQR28RsuFSv0LhMz9bebEvg26/9
	V8Q/U0l41kFcqJRQ9Hf26AvyhVDVSo8gifMz8J4rRbrZ6FgmzllGdtJnYSgtKxtiIuU5kOIQ5jm
	k6XWgLrW1gOZsNEZ7aD23QwcJXtcrgWBfw//3Sgl8RarkkAx8ADYbjJvxtcWzqgFdrgbgGzNzUn
	nMRQ6LbNOWxpr7ejBh8BkmmLVSVXXZh63LsxRHCDeqq9zEY4ONDShAy8YDGb2ozWWaXvCb/LqQg
	L2UV/U9bVJaBenQGq5w/CpuU9p1cfSWzhk5QBH+hyt44THLUnzcirh3HJJKPxfW3qjsWMENZsCW
	os+UK3jPZ4CMs+xo7CF4CNOckI0nNbhJ6HvR93E6wo/IY3xrgJSQfO/lWNmX/et3ZmGrZyBy1bt
	1gJkf6ujrNXukoHl3SJ9xaALPmkLPSzc9L0Y/9ipeghDSo5S7/92W7ejSsB9o6Vps3+y5B6QKxY
	tp8GsdIWjudLgQx6mp8746TOXzH2VRQqd/uz8JwMNF/4eUIDCTk4C0gXxb1SBSzhQ/2W7C8FaYc
	2FvZnNGzsC2MGlBG/QPnNuSAA1t4B9EKCRDpig3NwA==
X-Received: by 2002:a05:7022:5f09:b0:15e:6541:3099 with SMTP id a92af1059eb24-19933e10e21mr4470804c88.7.1792879231761;
        Sat, 24 Oct 2026 15:00:31 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm11578875c88.11.2026.10.24.15.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:00:30 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	cat@malon.dev,
	belkid98@gmail.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH 3/4] environment: move core_eol into repo_config_values
Date: Sat, 24 Oct 2026 22:00:11 +0000
Message-ID: <20261024220012.486-4-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.240.gf97865f162
In-Reply-To: <20261024220012.486-1-aniketgupta3001@gmail.com>
References: <20261024220012.486-1-aniketgupta3001@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'core_eol' holds the value of the 'core.eol'
configuration, which sets the line ending used for files that are
converted to the working tree format. Move it into 'struct
repo_config_values' to continue the libification effort.

As with 'enum auto_crlf', moving 'enum eol' to 'convert.h' would
introduce a circular dependency chain:

  convert.h -> hash.h -> repository.h -> environment.h.

Therefore, keep the enum definition in 'environment.h' next to the
other ones, under the existing NEEDSWORK comment. Initialize the
per-repository value to its default in 'repo_config_values_init()'.

Modify the configuration parsing in environment.c to update the
per-repository structure directly, and introduce the getter
'repo_core_eol()' to read the value in 'convert.c'.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 convert.c     |  6 +++---
 convert.h     | 12 ------------
 environment.c | 17 ++++++++++++-----
 environment.h | 14 ++++++++++++++
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/convert.c b/convert.c
index 7c7fdd4b2d..1d4e8a246b 100644
--- a/convert.c
+++ b/convert.c
@@ -164,9 +164,9 @@ static int text_eol_is_crlf(struct repository *repo)
 		return 1;
 	else if (repo_auto_crlf(repo) == AUTO_CRLF_INPUT)
 		return 0;
-	if (core_eol == EOL_CRLF)
+	if (repo_core_eol(repo) == EOL_CRLF)
 		return 1;
-	if (core_eol == EOL_UNSET && EOL_NATIVE == EOL_CRLF)
+	if (repo_core_eol(repo) == EOL_UNSET && EOL_NATIVE == EOL_CRLF)
 		return 1;
 	return 0;
 }
@@ -192,7 +192,7 @@ static enum eol output_eol(struct repository *repo,
 		return text_eol_is_crlf(repo) ? EOL_CRLF : EOL_LF;
 	}
 	warning(_("illegal crlf_action %d"), (int)crlf_action);
-	return core_eol;
+	return repo_core_eol(repo);
 }
 
 static void check_global_conv_flags_eol(const char *path,
diff --git a/convert.h b/convert.h
index dae11d372d..3c51130177 100644
--- a/convert.h
+++ b/convert.h
@@ -19,17 +19,6 @@ struct strbuf;
 
 extern int global_conv_flags_eol;
 
-enum eol {
-	EOL_UNSET,
-	EOL_CRLF,
-	EOL_LF,
-#ifdef NATIVE_CRLF
-	EOL_NATIVE = EOL_CRLF
-#else
-	EOL_NATIVE = EOL_LF
-#endif
-};
-
 enum ce_delay_state {
 	CE_NO_DELAY = 0,
 	CE_CAN_DELAY = 1,
@@ -84,7 +73,6 @@ struct conv_attrs {
 void convert_attrs(struct index_state *istate,
 		   struct conv_attrs *ca, const char *path);
 
-extern enum eol core_eol;
 extern char *check_roundtrip_encoding;
 const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path);
diff --git a/environment.c b/environment.c
index bbac8ed8c9..6445994986 100644
--- a/environment.c
+++ b/environment.c
@@ -49,7 +49,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding;
 #ifndef OBJECT_CREATION_MODE
@@ -158,6 +157,13 @@ enum auto_crlf repo_auto_crlf(struct repository *repo)
 		: AUTO_CRLF_FALSE;
 }
 
+enum eol repo_core_eol(struct repository *repo)
+{
+	return repo->initialized
+		? repo_config_values(repo)->core_eol
+		: EOL_UNSET;
+}
+
 const char *repo_excludes_file(struct repository *repo)
 {
 	struct repo_config_values *cfg = repo_config_values(repo);
@@ -447,13 +453,13 @@ int git_default_core_config(const char *var, const char *value,
 
 	if (!strcmp(var, "core.eol")) {
 		if (value && !strcasecmp(value, "lf"))
-			core_eol = EOL_LF;
+			cfg->core_eol = EOL_LF;
 		else if (value && !strcasecmp(value, "crlf"))
-			core_eol = EOL_CRLF;
+			cfg->core_eol = EOL_CRLF;
 		else if (value && !strcasecmp(value, "native"))
-			core_eol = EOL_NATIVE;
+			cfg->core_eol = EOL_NATIVE;
 		else
-			core_eol = EOL_UNSET;
+			cfg->core_eol = EOL_UNSET;
 		return 0;
 	}
 
@@ -784,6 +790,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->has_symlinks = platform_has_symlinks();
 	cfg->use_nanosec = 0;
 	cfg->auto_crlf = AUTO_CRLF_FALSE;
+	cfg->core_eol = EOL_UNSET;
 
 	/* section "sparse" config values */
 	cfg->sparse_expect_files_outside_of_patterns = 0;
diff --git a/environment.h b/environment.h
index 872da3576b..bf6701560d 100644
--- a/environment.h
+++ b/environment.h
@@ -129,6 +129,17 @@ enum auto_crlf {
 	AUTO_CRLF_INPUT = -1
 };
 
+enum eol {
+	EOL_UNSET,
+	EOL_CRLF,
+	EOL_LF,
+#ifdef NATIVE_CRLF
+	EOL_NATIVE = EOL_CRLF
+#else
+	EOL_NATIVE = EOL_LF
+#endif
+};
+
 struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
@@ -156,6 +167,7 @@ struct repo_config_values {
 	int has_symlinks;
 	int use_nanosec;
 	enum auto_crlf auto_crlf;
+	enum eol core_eol;
 
 	/* section "sparse" config values */
 	int sparse_expect_files_outside_of_patterns;
@@ -212,6 +224,8 @@ int repo_has_symlinks(struct repository *repo);
 
 enum auto_crlf repo_auto_crlf(struct repository *repo);
 
+enum eol repo_core_eol(struct repository *repo);
+
 const char *repo_excludes_file(struct repository *repo);
 
 void repo_config_values_init(struct repo_config_values *cfg);
-- 
2.43.0

