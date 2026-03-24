Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBA386573
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355969; cv=none; b=ZFwC4bH0FPrtZFc+FFOBSC9v/V6adYlFZsxd+RHXwMEGM8tL7KSZn/YD9GScg9yGrLIffAJ9Q04jT7klkFUkVQ9rtge+V5FgWHnVEey9J/1p7jvuZ0+OG54cTLgX/JMqwcJsNGzJu3fpQZ5Os6VlJ1OeEPliWzQqP3P3sLhA+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355969; c=relaxed/simple;
	bh=cP0VTWoldZ81Yv3Gs+cFqMwqswCc+XXwYnRRPSVXJ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCFaKFdraCryey+2cvCOLb0OEuEdfD/b4GcwQ7EexiCTVOAUg6/4Z0RFKIzT10zrnV4CU8o33Oz8YWZzxEi+N+OXqD9wKvm4r4FtXzcVgr+5nqYOhmUKSRt37Zc655YfTgVluIOsE69a9xfIId0OtrZl4Gb+jAq7GSxIKhlklw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWs3S1K7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWs3S1K7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso11682815e9.2
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355966; x=1774960766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9PmDLeXLCPcHVnPpFGonkfcwy1eKnJg/xSA0LzpRaQ=;
        b=kWs3S1K7VGf5wmEJ2kl38rDTHvJ0mHkoa1zx8yq9z+wq27dWeN6jVA4ORYghOAoBoR
         KLm4wRjYSdmZb7WGXwTJ0ps9mcNz5u0pmBfcgAsgLV++AcF+h/FvTJm/nmyC55Fxccvg
         sFIihOfcO2EeQrdbkGVDEdlzcucIrsTzC1IcICohJI1jjresOGkgSU52lv1Bs/aB/7+j
         iBggocRZLPEAImqavrjQpsM4x6tCGBOpkG+VuRtQWJWYEzR0EC10lAyWMmO7oIPhxg3K
         beD5bSHZ65oTlb6YHRsee+FDhm3OHm/+45nhEMzsFI+Ib0UtKmIPWHsUjoMoSQ2OJgPH
         Y/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355966; x=1774960766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9PmDLeXLCPcHVnPpFGonkfcwy1eKnJg/xSA0LzpRaQ=;
        b=nn9ijbjARRmwIpOVSQxX+cJFXzC/tvq7ZTR9CxfA+kGnLfkuHeVonnErWXQaSxtR89
         RzQPq0EP292UnJOdybxGnKvPd3VYoGXz89gk+VNXttG5j7s+/uM1rW/6OaqS2TEh1Gbs
         DGLcLiC2JE8++/5OkH623h/nq7ITD/U30O3FSTUB5K9qhTYmoClSqfnquOzR3v3EE7vE
         AK7gZUxYROvhZzvKtF+cLc9EDXUasccdWbZpvGSrpDBHgq91uN+8MXJHhkS16fTSysJ3
         aKg7bYKhGRrzu6uyC8BJCZYXnxDLImekNuVXblpFpsQIkG7d2L52ixXZft5DRVe5VuAO
         kQqg==
X-Gm-Message-State: AOJu0YwAGiOfDAm5CFVMRVt+XE3U5rPJN6SwK3RGpsfp4v2NgDnnQl3q
	V1TimuRxyTJWh8cpP+OaZgOjgzMSTtrHmEe0429AA6mvt3qrZc9v4qyUUZ4IE/DP
X-Gm-Gg: ATEYQzyC2u30HoMkyp4FJakqOHv8+KSB+PGhdnxnShPXnprzFE7a0hbkycsdmAGZPr0
	EL0yUVxG4GlTcK1olyTwZdWIVKFYlxRdd7E7CO+T9kAo84WOVhy4AHYMkhqox31LF2oqoMz6EKc
	1JTIO2LcW/FPU2iWAq+i/S9AROgQzU3Zx7ZpEvZPoGLrOdKXmh/SqIrwbCrznd9WudjMotk0h46
	/e5ikVse6uJaHM6RvRiXH+Y0pqPg6mAEAYH/sjydsEa8Vnr4sEyxp9C6nV94TLroDiuEnlx/fic
	74DltWpbXaUhlVZHR8k5PL65CO/qC/3cDNYkDknBpupp1/jQtEHAWN5yvvMpGnkcbYBhH4G423L
	LV5S/yxxmx0KADlLgwpuM4RRaCNRvJR87AT5M+zqORC4SqBturshxBz7a1y3AYI/Xicbf/GQRx+
	DG+xYDtbE0nYj9NlSeRK5WqFI7gx6Da6JwRLKR/RnWovAJnCuCYVj63RHi0/eay9dM
X-Received: by 2002:a05:600c:5248:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-486feb5d845mr239279805e9.0.1774355965671;
        Tue, 24 Mar 2026 05:39:25 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:25 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 7/8] env: put "sparse_expect_files_outside_of_patterns" in `repo_config_values`
Date: Tue, 24 Mar 2026 13:37:49 +0100
Message-ID: <20260324123750.157143-8-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260324123750.157143-1-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `sparse_expect_files_outside_of_patterns` variable was previously
a global variable, which makes it shared across repository
instances within a single process.

Move it into `repo_config_values`, this makes the  value  tied to the
repository from which it was read. This preserves existing behavior
while avoiding cross-repository state leakage and is another step
toward eliminating repository-dependent global state.

Update all references to use repo_config_values().

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

