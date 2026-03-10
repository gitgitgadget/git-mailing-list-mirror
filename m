Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8D3859E3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144483; cv=none; b=prnSwKZN3ItZN01BBBjTMW5WV8Dh+S7STy+UE9H5My3ZSlTLnuxs/QNDOQqLhrv2IiNtjSVVuZpJ4gDRkq7Y7uOc9oM3rAL04QiAk0Dqh7i0a7VbeJQeQ15MWzmupUh0RnRKbFiiYXjWEy2DwcKswORKVa03kyeD8aA1tzn5w6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144483; c=relaxed/simple;
	bh=cP0VTWoldZ81Yv3Gs+cFqMwqswCc+XXwYnRRPSVXJ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NfN9Pyc7YCfFqVYuE39K4DF29RDbGmLnA6lW3dpg6UinIobRQw4TF4JTddIIopOPGkZu0cE8TApgwtc8HvxbndQ52VPRYdKjY/5eOovPkOk0Zwf6IS0Q3e6VscZlhBWMmen4WSpKmJL++eels7EJKHVtVZoUg6mgGzAy81dw7d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMfHUXEb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMfHUXEb"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79801df3e42so166497627b3.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773144481; x=1773749281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9PmDLeXLCPcHVnPpFGonkfcwy1eKnJg/xSA0LzpRaQ=;
        b=GMfHUXEb6HqQ3+Ej0I+VX4sSKP0Bkyp+c8fvso+Z+IJxAk8YCuZ9vvqwyv1NLBGasq
         7Vq8ZlbCptft1rt7vQkfc8NSVjkLBk01lxXv3q9Z3raWN0dH+e3AySZE3Tpm8Pqijv5i
         gnFpC5wZY2IX2AIWShwJwoNo4RWuE7aKo/HPDrOfcaR1imdgY7m7suhyGbY9QotKF3dk
         M2Ak5vEbioWW+RmYLEQhuMlPrkrwxL2ft3+M2SzIdn/Xc/4ctnK0e5ebNLygdVJ5JYSB
         TTfiznUE3BlAwWJAIVLDEJVUtj7MY12m7x+6Brg9kBMUQjU7fQt6/IL4ebxZxGDKbaLH
         YzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144481; x=1773749281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9PmDLeXLCPcHVnPpFGonkfcwy1eKnJg/xSA0LzpRaQ=;
        b=XamAus18GR0NNNkkoFtZj+rIwZJPKxq7/TJdp8DGfFJJMdWixOxFmfacSHdXXzci+V
         p8PEJ8dajxnaxY+CwwpBq0X85C6mPkmkSpYgbAid/D5JozHy8mD6X93ztsnYYEXhRxq5
         K3S0QbErRrb4a9fSn9OEfkju2O1CdNLgbV/IMJwfa6oq3lTCrNseHXnMDEV+62GjtcwB
         vcVxCpesiXaY8tAmpQpLb66KhzpsnCeWCxoxJwwUMg65rzvF8Y9BRfw1WmBxiLn+9Yw2
         ra4EzH8IYTSePAjp1PHzZA9bKZ3orxr50+pv3PQbzJQA1n9izstfIT0qUURqLEGq7qrk
         mmmg==
X-Gm-Message-State: AOJu0Yx+9ZqKr4rjw8Crqzf2Pxhc4cMqvjX8T/ogtuFCXV3HEhiBB16V
	9zcpfV2SZwIXml0xsXf8SPdvYhDDlMfinyjk6yy5GvK3ew6yUKIT9vw44ogskD0g
X-Gm-Gg: ATEYQzyfRUnt02l1HhMqjCQt6She+URwpkuPKw3tSbJIlVDZ53GtNQgkyWWWnjus4/l
	UHc41XY67iquCj8AssZErPRupotReGCt7llphLgCltR/OkSq09NS/uXQ9Z6rgft86SqR4fkyUlb
	nbGxoWLtKRIhJDMF00mkPt2r15vb2uqU3WVi0XJBNm74sPFv4G96dtOaZYedpMHFoDI0RzkLqGI
	ekcUJx4DW8GXvuJX2m8vtl+ONtEfp1rEVOJAbvVDghrjLh8gOmQdHCq0bxI+uizLUP5SfdPBftG
	2kUJGopsj/ZxaA34HMNr5JwHEYgXaZLb4d2tve9Sh5AUINVZaQ3l21uTCvZnT4h8AqtRqMOCJnm
	PfRq6CYEitqMRVugXRwB6q7KZQM24fP1yteTjUiNbzZP4tjvNlupK4Ihv0V7cT5HBAjZjwGt76T
	o5Meuu7PM1BvWu+MQVeguMKJZZLkQ=
X-Received: by 2002:a05:690c:4a0b:b0:796:2f6c:70b7 with SMTP id 00721157ae682-7990a8c467fmr29084557b3.27.1773144481312;
        Tue, 10 Mar 2026 05:08:01 -0700 (PDT)
Received: from pop-os.lan ([2605:59c0:e5f:a910:f56b:22db:e23b:9613])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7990a54a46esm14838847b3.15.2026.03.10.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 05:08:00 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: toon@iotcl.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 7/8] env: put "sparse_expect_files_outside_of_patterns" in `repo_config_values`
Date: Tue, 10 Mar 2026 13:06:28 +0100
Message-ID: <5e30c28b48f1ebc8bc4b830b55f2885521fa376d.1773127785.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <cover.1773127785.git.belkid98@gmail.com>
References: <cover.1773127785.git.belkid98@gmail.com>
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

