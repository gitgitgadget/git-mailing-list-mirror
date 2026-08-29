Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC113D53C
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788010721; cv=none; b=BK/SXTaW/Cr/VjF9dbvrrxRhAzKwV5ZCS6CiTyOcTZDEu/CsanCMICu3ZJRVQRraaw0utaidKaY2Uc0rraTBsq2cg0jKFkx7j3mDqNn2S2dDhlDjS0JH70FWSyG1SMzNaKCfyfRAIYaRg2Y1cLy+YKlXWIKx2okY6Kd2hcd/V7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788010721; c=relaxed/simple;
	bh=ZE6En3Fst/bIDUvkH6uIqY1H2l3w7nnPDaVmy4MTXLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+m4MkmKJWki6Wsp24XBQ/l2/tgvOiGFaLoPUd84Duk2l3bewRpnTa2wkVPj+3Ops4tQ6cmUOJO+WiPX3/zJiut202mtZjm98Dn8IrTiCV2aWe0FLf9IVuBQCw7lsbq0/kPkw9X+vDkprTgA5PwigTb6ISGrQKalVuslnsFdHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZG4l1Kn; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZG4l1Kn"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-86162c086f8so3046987b3.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788010719; x=1788615519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4S2POTmH6xWaI35O09hV8AW6IzYD21o1nLw1AbudeyQ=;
        b=QZG4l1Knj/GrSP5AwzAyl+39/Pjacr8crwshMJFlULA7EY6s8qxUXakjF8dYcRX5a+
         vhRYgjpezT26z1miHWxwCf2XW4UFk49btFkZRwUniIyNd5imJ0YxPY6tNDXbnyDUYP60
         y39H6uxr3gRr36geZRn0kdw0AoFvGxkJ5VZRLmWcilCUROoFoxXY4+5nFUIs4mehPxAU
         2kra7XdbJ+VxqgwGBzOBgD5a+UBwUmtd6u9SzrhiqcD4HlJE/E5S5Pb5vkm7quc2TpIv
         vmrYoJzE84dcL1KMmD6sITnOJgZ0tVctVbR7f6pYWE5PqcnqP639Be6qTHqSLXa3fvpx
         WfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788010719; x=1788615519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4S2POTmH6xWaI35O09hV8AW6IzYD21o1nLw1AbudeyQ=;
        b=NR2QTFaMfMGwwDuXPozRZQab0tDtEi6H9OKZTzWK/s6uUF3i8aYM7WCSPhVNvnUEgS
         kIeY6zJO585uoZeNemib6LypKRXXYC8YVdxeNBW7Pk1KWa/rJO+pdXYRioBh3qY+mmFu
         Zv5sqwqskklgryt1dBVNZrXHGnBVeEdqmuFoJlGAsARw4H2o67CVLrbm6yGCgQyDYfQv
         qN6Kg8mgKI6hPfW7Yhy6lgxlkdl8jVgpgOxFf2DxHCx4VTEFLn+Qral/N1ycUpsrq4e4
         VIKINwSXrJmuhkskQ8JG2ahVOe8dAo87ASZIYhPD5RjIKFpkNbRU4kH2G2H/N/Ary3z6
         9CcQ==
X-Gm-Message-State: AFuF++lGYSnopK+lGvk90s5Sw8CcgXcEVmBeosbm41XQD4QnzIb7uJUQ
	yxpXo+7Zurp94B2wtq1FVCX60jXWl2zfsLZnoQTAhbWx5ZYHGWh3pe86ozXwOUyy
X-Gm-Gg: AYBFou14LljYq1c17za27K6jeoOwb3K9fAzWvB6OplWsO5xn1cFIXps7TcU/abBtTfw
	lzqQeTyFXYpNjBEY3xF+MWXzPRC8T/5x2sPHTgTJuklxUIkVKj7iPPY78xDiH90LfD9mxDmQF+9
	hmUwRhbdVJ/vwREThFanb7qPWDhGIgjTz3wF+4tcTAuieJVZODsYbIKTfbLa0sB9XY2Y1BUd29b
	EKljqTJwCgd+kPkiGi67i+qK9R2qd8RWgSXNnCquhHuVgr1li4GdCUKfmVZhCUrRFv6dnyEyIyF
	dNrZV9CoD9VvFWpKknsrm8LpBF2tOe6JxF3zHqq8c8hGunCvs5BXqa0Mld41BoXgVQiY5sI4wgw
	a8+IECan1O73u3zvlENslm4H2ehYFlixbuuuMYdqzLRqU2MhOcpxF82RCRxvcD+fpwZ9qEdrGLJ
	z0AQ6b0ptGMBuncq6uxOkxvoSND0virXOcXuIwyM1SsQ099viLftcp30sSAvsfZkwzcqm9dtVNg
	C42u3D+vyVUhjeJ2HiJdxzpQuDBKCHiqMTR9Te5Sa1PEwuOv6hfQF30uc0xEZ58wTfBi5dU3mAY
	82vqmsNWuM0=
X-Received: by 2002:a05:690c:338c:b0:81e:fdf7:bfbd with SMTP id 00721157ae682-85aa334b791mr80359677b3.15.1788010718639;
        Sat, 29 Aug 2026 06:38:38 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e66abaf31sm21364557b3.35.2026.08.29.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 06:38:37 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 2/3] environment: align repo_config_values_init with struct declaration
Date: Sat, 29 Aug 2026 09:38:19 -0400
Message-ID: <12974e07d088c1621248296d08b6583c568ba4cf.1788010335.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed.dirty
In-Reply-To: <cover.1788010335.git.ben.knoble@gmail.com>
References: <cover.1787231825.git.ben.knoble@gmail.com> <cover.1788010335.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The order of assignments in repo_config_values_init is chaotic and hard
to follow, especially with the definition of 'struct repo_config_values'
to ensure all members are initialized. As new members will be added in
the future, make it easier to validate changes by aligning the two.

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

