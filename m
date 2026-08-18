Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44E37E302
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065233; cv=none; b=XSTip/ONJmWTdL4cqPiTOc3S9U2394mnsKVp/r0YDY3miSHSkJJ4PPWU/ZwSh0ewrDaR61AgKysaK/dryTX3qe2tgCmkvZcHCUT67W0Ufnq/o1nFQaC3ht4iBA9lQ4c0TbO3G1aTaOuSrs+/pyqRlWwtkcfjas4MvaiJqFchi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065233; c=relaxed/simple;
	bh=sm/hciHZkBCP6uTWJsB37SGClWfq81zpR7WoHDy0460=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQY3kGaYeOphY5La6p4AkOyR/e5CqE+lYe0VxVSgr4RrwBVixnhEG8vAE918u6BIc2JQ2YmyOzJkm4GMNOjmfAY6sG06AOzp152qF+jM+h3vkhVTAwGleb8M3bXA1S3RhnXjZmPQ4uEsTAyD3yRanWl6dym+f3N0O0mNODIadBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJw9DPFb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJw9DPFb"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a06b9eso41933547b3.3
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787065230; x=1787670030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXGp2UZKJoxWmCOMMmogL7kVyZ1ReMzh2MkiM2WhHEw=;
        b=QJw9DPFbLIGbKsdsxlctQz2lRlv8rDCcHS+7q5AgAHZoyWDByvb8jCpko6nPrFOF86
         qlzz+PrAGW2o+/t1F7JjdXMvi3/bmUkB9YavyEU1l9C3lmkX1EjGQBlBKdsVuk3ow34K
         j6f7zqX9UaXJe/NSfx9HrvRUWC1j/xQC4XDd6x5ZHtH524RvdL9VQG7If+vztm5I8ZJ9
         Lc1cXKoR9KOt5FY54CP5mGK6qTu5vRMGtXY7DO7cYZb1pPTerYTpMmjHxpXbTh9AHfu4
         WTnsPxMu9HHnV0uwuxrdErA4VWJrYsSqMS/94A9AEy5DMLFxBPMG5yuFIigMt4q/AZFX
         DTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787065230; x=1787670030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXGp2UZKJoxWmCOMMmogL7kVyZ1ReMzh2MkiM2WhHEw=;
        b=Kmo0tilmiMQel/hr0CwTvl/9HkuOh3u0QOe7aSjvRzaFdXnS5i0mScOQciri4BXgZ+
         JQjpxSOU5l8m4mRz/hXEdytgMuItjrR1cTbNH7oS8ZTY7lPLpyC8JxH2cDJjpQsVZjEj
         POYWv3LYY6CXQ5VjG2Ca2qAWuVqfLKF66d7/0mWxr4wek/d1ENVXhsoWRGhXZZHF1I0d
         Srct6iqYsh0+w07ptp+gKs9+6E6N2pIPdOsRjJtulkxIjno4ZrcsXV7SJd2KxtsfP10u
         STKi7yvSTmauWzDisDGIQGVhxpzBmPwGPMhPcL2bJc/bj6pl+oyBtEPrc8LT1tBC7Mqe
         lhXA==
X-Gm-Message-State: AOJu0YzPSpvKu4ftDJgRzAYd21OFItfoM1kxvN4KvVlBX5QI6LtPx3+k
	zm4cbqMRLiwzCV5SFGmr3KUku3ML9ebbzA0tcOdnKTP9LS6htI6DkS9wlDbW5GqT
X-Gm-Gg: AR+sD10TxNzMCJASPhL/gwbMw8cvpqeTXhF9pYcgYsaQUYFrcfT+5yhNq6Co7hiHeKq
	U4UbOZPam9M4MKQeHeZf2zSMPyZIuMazEHZ++kVLYtVnSzLPGr7sNyPusPW+qtQv/gCBL0LCgc5
	yLf2hYnnNkdkolUj7c53UqyCyTQlIYVt/mOUYwQKXv9EWA1E3Pc47ZA2AeMHmNgMvCTJufQmxwS
	VJ0dLOkLkfsUDY52U4Q6SIAAhE0y4/RvifJ/hpY8gxG4Ka1DGYnaPDoPWEtG91RvWTvPTooA3lu
	V0pr3cSdKrux3YGzW9tlyoZa06//vti/4jxz9giX2jEfRP2IRrnf921tAAn30rWfbYmaypBAwpw
	UNA+ufVtOX37KHh2Ydqyu/wLsDSyz/EHo1sAGEO0hNSKOSvvYBdZ19WCTjSUuyxQbS2zYPexwQH
	tCFbqLk0Pw12iJBFLtngFV6ajUgrdVrDlTsumnvdaE2+kg68ZWM+v9vwdYkH4ATFT5s9M2KYz+Q
	8ZCyKxYdMDC/ICh52P4oo3jV3H1wqad1hrGWp5ePZGFX4ovXc3iDxlbWqrjLRSBTciG+O1sQSXV
	wNFKZlqxQd6g
X-Received: by 2002:a05:690c:e295:20b0:81f:b410:b214 with SMTP id 00721157ae682-837124e9cc0mr84877967b3.27.1787065230000;
        Tue, 18 Aug 2026 08:00:30 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-840f3d1fb12sm20201097b3.48.2026.08.18.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:00:29 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 2/3] environment: align repo_config_values_init with struct declaration
Date: Tue, 18 Aug 2026 10:59:46 -0400
Message-ID: <5693baa9923afd20333c0eb016cc5949f8dfc423.1787065125.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1787065125.git.ben.knoble@gmail.com>
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787065125.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of assignments in repo_config_values_init is chaotic and hard
to follow, especially when comparing with the struct definition to
ensure all members are initialized. As new members will be added in the
future, make it easier to validate changes by aligning the two.

Refactor assignment order with no behavioral changes.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 76ee65e62b..6676e6f5ae 100644
--- a/environment.c
+++ b/environment.c
@@ -745,6 +745,7 @@ int git_default_config(const char *var, const char *value,
 
 void repo_config_values_init(struct repo_config_values *cfg)
 {
+	/* section "core" config values */
 	cfg->attributes_file = NULL;
 	cfg->excludes_file = NULL;
 	cfg->editor_program = NULL;
@@ -756,20 +757,24 @@ void repo_config_values_init(struct repo_config_values *cfg)
 	cfg->autorebase = AUTOREBASE_NEVER;
 	cfg->object_creation_mode = OBJECT_CREATION_MODE;
 	cfg->apply_sparse_checkout = 0;
-	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
-	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
-	cfg->ignore_case = 0;
-	cfg->trust_executable_bit = 1;
-	cfg->has_symlinks = platform_has_symlinks();
-	cfg->branch_track = BRANCH_TRACK_REMOTE;
 	cfg->trust_ctime = 1;
 	cfg->check_stat = 1;
 	cfg->zlib_compression_level = Z_BEST_SPEED;
 	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
 	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 	cfg->core_sparse_checkout_cone = 0;
-	cfg->sparse_expect_files_outside_of_patterns = 0;
 	cfg->warn_on_object_refname_ambiguity = 1;
+	cfg->protect_hfs = PROTECT_HFS_DEFAULT;
+	cfg->protect_ntfs = PROTECT_NTFS_DEFAULT;
+	cfg->ignore_case = 0;
+	cfg->trust_executable_bit = 1;
+	cfg->has_symlinks = platform_has_symlinks();
+
+	/* section "sparse" config values */
+	cfg->sparse_expect_files_outside_of_patterns = 0;
+
+	/* section "branch" config values */
+	cfg->branch_track = BRANCH_TRACK_REMOTE;
 }
 
 void repo_config_values_clear(struct repo_config_values *cfg)
-- 
2.55.0.860.g4b6b3295ed.dirty

