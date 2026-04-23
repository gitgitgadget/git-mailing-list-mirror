Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185438735A
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963356; cv=none; b=V1ulhkgv+WYwCnz517aIajaL71VCS9IxyPEVdaqnkPCtqgSZgIa+Lxg0evKXUTFSvtCM/2txUud0Qd/xYfY/0eSjmQuPAt1dwUmrAlNrG6cI0FORJ1chWGTKSacky3z3rITTC8NgIf4QDzjAMNAlFeWa5Mm+NOd2vntOZNuCgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963356; c=relaxed/simple;
	bh=tf8XiYNvW3xfKV8FctG7UVk1Kf7uZV8HLTCIyxQ6gP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azj4k1l7WHmHUUlV3ctKZL99B9+q11RZcJK79ITveWFj0KW18uO2A9oVgui4wAR0hsvZXDTr/eVpCmtjUKGyIxUcQbFSLwHF+Vj/QBs5cjrEyKtlX8uTo7JkwwiaPzFNbbMm0rML2HyMmNVp3jXy2bs5SwYHEch7oYln9HA68WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAhtiH6F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAhtiH6F"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so54314755e9.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776963353; x=1777568153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITUfnTpQJhScuzx0WJslvdLIqgGFtd6IeMFAYHTtAJc=;
        b=mAhtiH6Fq7A+nVSMZqdpUQlHgbWu6DVwktrUZNvbmYvckga8IfoMRxnjLSvTRbCAgn
         cuLThunuvYcp3DT9JnB6u9XeKf0usiwDSBXEMfJX7kHATUa52wHqVEk4X1/lclKDCVB2
         x4slC7L1iEKvq7Ey89SjzIGRgAnB8WIUE3+J0B4I/zESQiFer1lL3XxdBofWtcE+9S6c
         PxGnJrOeVqGndAofQ6XsGW55Fp1mY1XBauPqTEMmJzS5IozpltW0HdcTKF/9RIIz0XnQ
         baNSHBLet3uFIFH+mSZazyqcxe/47geHHfwO6K+fTDBKg9U9wlxEm8Gb/SGAkBiHqQmx
         JCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776963353; x=1777568153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITUfnTpQJhScuzx0WJslvdLIqgGFtd6IeMFAYHTtAJc=;
        b=iJhwCG9BDcgDI6/jemVXAz22DYVrSFAIM3UfaSugLECzGTHkFQbuV7kAhip6aNkS8i
         tkDozKTXatec3z/ALjyHSC4V55s5i+XZaG+yl8CV16/y2J9YElAI4hhYoo7DzchClQEh
         65++HqTX0RJou79nhfzbJxbvWcs09r1kalwGZxNkcJcqSSPDlg1qDSTdlAq9Piw63A1K
         Vn/Av5MNUUgW7ZP7XD9KsbZ0TL/zyZcd1UxPNGbt/eQntcAUBVb+/ao8leowWmqjQTRE
         41YZdT6LA9ANcz+7jE/TjI/hGuQ1Nl2JOXSj2Ax1zWxOmv/flV3B/sicYftxSrQ4tBNt
         ZSfA==
X-Gm-Message-State: AOJu0YwYIVACVxLRb+ZX2Kw46LRpl5KR8scuDYLvnGAHo8ZF6B4pf4h2
	Z/YmB1a70w6QfUow/1F+eeAg1qiQW4r87M9F3mvA1a5xu6+0t8l6ByEFF5y9s0M1
X-Gm-Gg: AeBDies72Xt6SbgCUZeo6cGcSrGAeY9yHYMwNngrwzpeB9YMTKCema3oXX+tpFBskZF
	TMiiMzsGyOTFky7Na+ingH9vJDzJa7gRY5R2LryZe5UBmyez/vCNf+Xao4VyjvDArqcBdgAQ4VX
	L0sr5p9Qi8LYMDr1cyhfhWEwC/spCHiRtt2IoHtvcc9SU7nxdPpgxwBdN7MD/26blGDRGDFTKnj
	2NX0KKDU+wOy0vHHqyX8sM7NuZuVUExJa7rn8LI1DBdbxbVZZvNa+fNNOgbIPY8pjckaOS1bXVX
	/NYWdoAs4l3g4BxK0K7WSEbwOeS4yf8YbJTKGHL6YvDhK5+JkQSspa1DADj3mPCDUXWwJhVzbUa
	Qz/THUn24fZc4h+EW0pEADAQbyWxojzJPfvOnuKdJpikkFXUt8DRC31D1Qvyvm+VyBS1aFNmZzf
	Z61VKIlYqZp7LDkw4mGCDRHkjBkX8BZ/TtZOsKOv1QbT5pdHZgZuoCH7djK6y6TrnJBKda4Q==
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr248146095e9.11.1776963352741;
        Thu, 23 Apr 2026 09:55:52 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:737e:f405:338f:9bbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm353431995e9.13.2026.04.23.09.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 09:55:52 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 7/8] env: move "sparse_expect_files_outside_of_patterns" into `repo_config_values`
Date: Thu, 23 Apr 2026 17:54:31 +0100
Message-ID: <20260423165432.143598-8-belkid98@gmail.com>
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

The `core.sparseCheckoutExpectFilesOutsideOfPatterns` configuration was
previously stored in a global `int` variable, making it shared across
repository instances and risking cross‑repository state leakage.

Store it instead in `repo_config_values`, where eagerly‑parsed
repository configuration lives. This option is parsed eagerly because
it controls how sparse‑checkout paths are interpreted – a fundamental
behavior that many commands rely on; a lazy parse could cause
inconsistent sparse‑checkout handling and complicate libification.
This preserves the existing behavior while tying the value to the
repository from which it was read, avoiding cross‑repository state
leakage and continuing the effort to reduce reliance on global
configuration state.

Update all references to use `repo_config_values()`.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 environment.c  | 6 ++++--
 environment.h  | 5 +++--
 sparse-index.c | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index b0e873e9f5..57587ede56 100644
--- a/environment.c
+++ b/environment.c
@@ -70,7 +70,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int sparse_expect_files_outside_of_patterns;
 unsigned long pack_size_limit_cfg;
 
 #ifndef PROTECT_HFS_DEFAULT
@@ -550,8 +549,10 @@ int git_default_core_config(const char *var, const char *value,
 
 static int git_default_sparse_config(const char *var, const char *value)
 {
+	struct repo_config_values *cfg = repo_config_values(the_repository);
+
 	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
-		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
+		cfg->sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -723,4 +724,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
+	cfg->sparse_expect_files_outside_of_patterns = 0;
 }
diff --git a/environment.h b/environment.h
index befad9a388..609cdaa07f 100644
--- a/environment.h
+++ b/environment.h
@@ -98,6 +98,9 @@ struct repo_config_values {
 	int precomposed_unicode;
 	int core_sparse_checkout_cone;
 
+	/* section "sparse" config values */
+	int sparse_expect_files_outside_of_patterns;
+
 	/* section "branch" config values */
 	enum branch_track branch_track;
 };
@@ -179,8 +182,6 @@ extern unsigned long pack_size_limit_cfg;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int sparse_expect_files_outside_of_patterns;
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
diff --git a/sparse-index.c b/sparse-index.c
index 53cb8d64fc..1ed769b78d 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -675,7 +675,7 @@ void clear_skip_worktree_from_present_files(struct index_state *istate)
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (!cfg->apply_sparse_checkout ||
-	    sparse_expect_files_outside_of_patterns)
+	    cfg->sparse_expect_files_outside_of_patterns)
 		return;
 
 	if (clear_skip_worktree_from_present_files_sparse(istate)) {
-- 
2.53.0.155.g9f36b15afa

