Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F83D904F
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355952; cv=none; b=QsB/wvGwpXYjLnyRzjQWNGZE0MGHnlL61cOaQdepzumE3Az9OC80vyUbsOcuu+uwgbX+/wvRJjf0DQgpvdBbvwrhmy9kMaIGrKEDFIqTKEG21t4V+pSyNxWvcx9tWRQ6w8bFzXm0cNjRSTIncLNrvc8vWfATKinvIDFu53Rc+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355952; c=relaxed/simple;
	bh=NdP7TypjJ35M5Pw/jBdJyL6P7C4gYw9uQ70sGE7L2i8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuKan52xUuQgwOSdtcBBJafN0M0kvV7XH4oR2ICq/tT7lbHV7i7cAPne4U3t3HNNq5bwarZmXmdf/LwMKMsImtvqP4B5vtnxD4od/AOWocfEMWaKJcp1Jflk78H3XmWX+d5PhDU2ADb/0R8Ft4db0K6j6699fe4W90YsDWqQRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+ZQ7iwm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+ZQ7iwm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so8643935e9.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355949; x=1774960749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xv67ZSalHlzzdaKtqQkbyDna82ODaIT55o/aLgYbo3U=;
        b=i+ZQ7iwmjoB8PZWLpVjGD8E64a6GRKDUD291+tR79ezkXRfATPcMfB1q3GIKwSlxEZ
         t8WpNuSZBWNqy3KfmW8aefKhZCkNf21+lQavME90FV1LBJSMLttvQAINASERziwJTmtR
         UVC+Xtxt33SxhFJPN2GaYYRt9DeUbLzATEu3dFBO4l1/X9h9PQYtY7Ncm2iXO4+1olSq
         SXNcBMw/vrWV3RHx2zJrVMxZz3vWfAE4dlw2tMkMerRPIf6DyMXHNVaStAGDgfkLju54
         RQhpkz6mPjnEvvgCb2k/vf7BHoeBaXzOsyTwtnfkZLGvqJXeqrpEMUZr9ADURae4FrXu
         U32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355949; x=1774960749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xv67ZSalHlzzdaKtqQkbyDna82ODaIT55o/aLgYbo3U=;
        b=ReZp78cTV+QS4y8JQrAPenAHdm9DVRUekLs6EOhZkXXprai7BRBKuFi4X+4Al4oaUh
         iF+RimYDgZR3rZjnb13zL4lihZHylP65mxvCBKLsI2pk+WsS3a5EA9Vpos6pt7QiygYv
         Gn8tGR7ubnNnRFoDKGXGFGdvCiETcYTySqg29253O72tc/5HgiccWjhpNkGsY/uAEOKD
         K5Ugpzhj6jUUbhiP7Yu633j0LBNScVcOc/Dw6/cy4FARpdZsuYvwiSGeqL3pGuFJURLV
         xee9F98NP0V+ARbw1966Zv0ObRYFcPCfHOtb4E4m4u24MT1CxgKJUyjWFQSnWWNEYqgM
         WInQ==
X-Gm-Message-State: AOJu0YxKcbVbdr7IEk2Dc44Sktk3QePMzLR0aRk1+cbh3Fzri2DdSWSq
	/oM7JGFYS656SvdFq72X0fUajcMOT8du1P1EjO8QU0dttc+b7Gcattu2BqAFo+A+nzw=
X-Gm-Gg: ATEYQzzfJPVvx/aLarhbasJ9gLKsDko1GmDcmKvbfjdv5jNinTpIAdEDwjYaHFcpETG
	LnHRuTd3pwtjX2crbO+sU7iZHS8OCihN31vwyEjTPe5kMk+6p/55yMgwk48ig3PBpzZj8D3VIAj
	H54l46gYFYnq39ZbAhuPfixTmyR/8sFB0ZCcrU8/q6hpseq4vcbymbna1HvDmm28qaL0p3i4qtz
	BvJC8hUl6/rqtSZrxJUVLWNayWFNAAGOB/T0v5cGR7bggzteLsz1rqp0rtGEsDiAhOu9VDfp+AN
	Vi7+PaYQhL07tmxLFr+U+AF+Ia9rLrQg0OmNHh8OTgcAwRhIE3hX+dlkzGzg0Zro9x9jim8CTOq
	DUiMj4GpblY0GkZkZ5utObzS1RkXLXt3gx23KUPotNOkAIjXWwI5Lhmvg5PlUoM/4wT5cgZhUmW
	PszOetE2PmEn5jj4a91oCPO6SbiDOJLxDtOsC9tpIzEAVGVU6Ha07cRmH9Cyr/BZFV
X-Received: by 2002:a05:600c:530f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-486fee0f92dmr223072325e9.20.1774355949257;
        Tue, 24 Mar 2026 05:39:09 -0700 (PDT)
Received: from pop-os.localdomain ([102.88.113.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48710fd2c4esm32049815e9.4.2026.03.24.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:39:07 -0700 (PDT)
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
Subject: [PATCH v2 1/8] environment: move "trust_ctime" into `struct repo_config_values`
Date: Tue, 24 Mar 2026 13:37:43 +0100
Message-ID: <20260324123750.157143-2-belkid98@gmail.com>
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

The `core.trustctime` configuration is currently stored in the global
variable `trust_ctime`, which makes it shared across repository
instances in a single process.

Store it instead in `repo_config_values`, so the value is tied to the
repository from which it was read. This preserves existing behavior
while avoiding cross-repository state leakage and continues the effort
to reduce reliance on global configuration state.

Update all references to use repo_config_values().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 environment.c | 4 ++--
 environment.h | 2 +-
 statinfo.c    | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..0a9067729e 100644
--- a/environment.c
+++ b/environment.c
@@ -42,7 +42,6 @@ static int pack_compression_seen;
 static int zlib_compression_seen;
 
 int trust_executable_bit = 1;
-int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
@@ -309,7 +308,7 @@ int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
+		cfg->trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "core.checkstat")) {
@@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->attributes_file = NULL;
 	cfg->apply_sparse_checkout = 0;
 	cfg->branch_track = BRANCH_TRACK_REMOTE;
+	cfg->trust_ctime = 1;
 }
diff --git a/environment.h b/environment.h
index 123a71cdc8..64d537686e 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 	/* section "core" config values */
 	char *attributes_file;
 	int apply_sparse_checkout;
+	int trust_ctime;
 
 	/* section "branch" config values */
 	enum branch_track branch_track;
@@ -161,7 +162,6 @@ extern char *git_work_tree_cfg;
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
-extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
diff --git a/statinfo.c b/statinfo.c
index 30a164b0e6..4fc12053f4 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "statinfo.h"
+#include "repository.h"
 
 /*
  * Munge st_size into an unsigned int.
@@ -63,17 +64,18 @@ void fake_lstat_data(const struct stat_data *sd, struct stat *st)
 int match_stat_data(const struct stat_data *sd, struct stat *st)
 {
 	int changed = 0;
+	struct repo_config_values *cfg = repo_config_values(the_repository);
 
 	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (cfg->trust_ctime && check_stat &&
 	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 #ifdef USE_NSEC
 	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
+	if (cfg->trust_ctime && check_stat &&
 	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
 		changed |= CTIME_CHANGED;
 #endif
-- 
2.53.0.155.g9f36b15afa

