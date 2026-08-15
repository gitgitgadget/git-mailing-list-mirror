Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A45635F609
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778321; cv=none; b=mG9mcWA9qsTAN6IIYlvs8MOWysBn1udeAPlXHUgpsxbYafhJflCV6QQg7rS7CWWn+x2O/rJpR5jgO+LsqdHEvRlimWeR7Q2ahV/fYZVLW1JaZZQoOUqhwkbQCTmpnGWWYsQne3nyAc+Zr1wFEMVaJBH5qMOlWeiNIeT7Qi77IHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778321; c=relaxed/simple;
	bh=GSjbj7R7NH3EEBz6s+d+NRKisRkxsXLdsyn4gwWBZAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P01RuxQizODJrcUZJGU3RGeGxGCpWmrugpogxcSkg36DroSpVgCaJbfMS1EQISR+HjGV72wZxR2Y5RpduORiqkoT4QWyLIjVstQOg9zXfYZnYK9JTWlZ6MON1Ao1CKR2xMihh9n8EMY1f0XryjAEXdmQrflZljSarfVG7YzwnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rX21brTn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rX21brTn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf27856f9cso17405425ad.2
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786778319; x=1787383119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eqbgRbUaTmz1F5keNWWycRdi48iZ7RRdDFzODPsC9+w=;
        b=rX21brTnbRlIUF7dtiqanJRm5OK87BOQUVAQCwR8J+BSHC7DlR9BN9eAr/zSMhWkwq
         yGv7TeRROBdhguSdTR0y5QaDaSsAVKau2Ha3Qf2tnYa3RJQGf4+8abu+Z5FKpJfblcNx
         uv8ab3SMyiS8d9DHn+pnKQcTCQIuP3DBo4Y6VPMjlzozptKKaOEjeE6bvXTGXFVC9MFk
         MS0dKHKa9atYwy53D1kXGHfoCPreLuRMVs8h4iVZCFruCcYREDJA8l8LEtgyrLWnxu9w
         stQb3gLe/SclZUL4tYenqTdYwgsxN0OKwmN/89n5axD34X/Vx4gvy3vwTwEl8DbhjpXl
         /3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786778319; x=1787383119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eqbgRbUaTmz1F5keNWWycRdi48iZ7RRdDFzODPsC9+w=;
        b=ZHbwcR49idAAsElkOvYQJSQT75yrB3OPQ1a88aRhsf5m3Atq2pLEUn8uQAe86m2lBi
         w1FrrmhDyQO3VF28icqW+Hev5oF0auYAK3B2MUcb/3Sr/CPiwdChbqlcTWC2td96LwW6
         uMRg0t+hDcIivgacrUWfQ/xvszSCJdOemElBGHaQUpBNuhusg6V34CzGkF0t8dbwmGYz
         1d9ul3x/NLlWRcJ0bWxLXdd2OTlIufzKDw29p2m6KOEeT+QbXliv+ny76L0w5gFRR1AA
         Ce74ymD+9/lP7W0SrSnDB6wjM9v3vD9vOMszTAV9VKdoSpTEZ01NVq//EJ3CCJfjIhKM
         uBYw==
X-Gm-Message-State: AOJu0Yx6CI2B2X7ij3jTDmuodQLi0oHDx1UMvB55rLWt3Jcx1hhwc/15
	SuVijX3mQzQIm8ZHLsW5lBazbLOJzSu9243kGxzHMeERyoAZAm+gLenKESTASw==
X-Gm-Gg: AR+sD10yE78g7urLLKLTS1qeELBCXiSwgTDjE1tL2Yms5JhFuNV4AKxVo0ztoL1+ACQ
	sAtb8xBJQFFM6Zh1JpRnWZ5GpgF3MlvsbfwbU99JD2ac+5qUyJb1jjXSSePK/u7o5fqdg1iY0gA
	rVlKUCVspFomWT+SQ6iaIrLi5+NYWNvp8ZNFfzJBZy0kZwbZ6pGLvptATfpfAZI8y0Mv3lvSCAq
	FPDPqgemxmbiYNyTktsZDk7RPo8KHDhRzsqZ9Ic4Lhpb5QO9H0V1JXPhd+NowyRdJrkUcVLRQs1
	H1/oYR+ckGKOAs76Wld36i2IfwxFEmeED2k5Yl0JHVfNqR/dX4uNd8UZQKebc2649Gz4yv1URCT
	Jnz1DArwA1LQx02w1bW8kTMKP09OcSEuwi8PfBfS71zmYxhkJlT805UVm1FGyutz7czAadwC6cd
	fIE6bGP7HvuCG6wgsRw4I1hWyPccEvulYpOOnIi7ogg3AmrPKoiTnzG+QIhnTAhEUECVPdRyEVJ
	QAY2ZDtFWKYC9ZLoicPwt74sapBXg==
X-Received: by 2002:a17:903:3c4c:b0:2cf:9cf2:3533 with SMTP id d9443c01a7336-2d3b0cbcd4bmr139916185ad.18.1786778319148;
        Sat, 15 Aug 2026 00:18:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:313a:bee1:6c01:e931:89fc:1f80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3218d3f398dsm12472234eec.22.2026.08.15.00.18.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 00:18:38 -0700 (PDT)
From: tilak-raaz <raaztilak07@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	wy@wyuan.org,
	ben.knoble@gmail.com,
	tilak-raaz <raaztilak07@gmail.com>
Subject: [PATCH v4] submodule: warn on valueless active config
Date: Sat, 15 Aug 2026 12:48:29 +0530
Message-ID: <20260815071829.22190-1-raaztilak07@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <MESSAGE_ID_FROM_JUNIOS_LAST_EMAIL>
References: <MESSAGE_ID_FROM_JUNIOS_LAST_EMAIL>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The config parser throws a hard error if 'submodule.active'
is provided without a value, causing commands to abort.

Swap repo_config_get_string_multi() to repo_config_get_value_multi()
to parse valueless true safely. Use the standard config_error_nonbool()
helper to emit a warning to the user rather than crashing.

This resolves a NEEDSWORK comment in submodule.c.

Signed-off-by: tilak-raaz <raaztilak07@gmail.com>
---
Junio, thank you for the review and guidance on the terminology and tense.

(Apologies for the noisy v3; I botched my --amend and accidentally left the commit message in the past tense. This v4 corrects the commit message.)

Regarding causing the command to fail on a malformed config: I investigated returning an error code here, but is_tree_submodule_active() is evaluated as a boolean predicate by its callers (for example, if (!is_tree_submodule_active(...))). Since -1 is truthy in C, returning -1 would cause callers to treat the broken submodule as active.

To avoid changing the existing caller semantics or introducing process termination from this helper, I kept the continue behavior so the malformed entry is skipped after being reported with config_error_nonbool(), while valid entries continue to be processed.

Please let me know if you would prefer a different error-propagation approach.

Changes in v4:
- Updated the commit message to use present tense (fixing the omission in v3).
- Updated the commit message to use "valueless true".
- Fixed the whitespace and indentation in the t7400 test script.

 submodule.c                | 12 ++++++------
 t/t7400-submodule-basic.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5c92575888..07d1fc63e9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -231,11 +231,7 @@ int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 /*
  * Determine if a submodule has been initialized at a given 'path'
  */
-/*
- * NEEDSWORK: Emit a warning if submodule.active exists, but is valueless,
- * ie, the config looks like: "[submodule] active\n".
- * Since that is an invalid pathspec, we should inform the user.
- */
+
 int is_tree_submodule_active(struct repository *repo,
 			     const struct object_id *treeish_name,
 			     const char *path)
@@ -261,12 +257,16 @@ int is_tree_submodule_active(struct repository *repo,
 	free(key);
 
 	/* submodule.active is set */
-	if (!repo_config_get_string_multi(repo, "submodule.active", &sl)) {
+	if (!repo_config_get_value_multi(repo, "submodule.active", &sl)) {
 		struct pathspec ps;
 		struct strvec args = STRVEC_INIT;
 		const struct string_list_item *item;
 
 		for_each_string_list_item(item, sl) {
+			 if (!item->string) {
+				config_error_nonbool("submodule.active");
+				continue;
+			}
 			strvec_push(&args, item->string);
 		}
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..62b2537174 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1549,4 +1549,15 @@ test_expect_success 'submodule add fails when name is reused' '
 	)
 '
 
+
+test_expect_success 'warn on valueless submodule.active' '
+	test_when_finished "rm -rf empty-active" &&
+	git init empty-active &&
+	test_commit -C empty-active initial &&
+	git -c protocol.file.allow=always -C empty-active submodule add ../empty-active sub &&
+	git -C empty-active config --unset submodule.sub.active &&
+	printf "[submodule]\n\tactive\n" >>empty-active/.git/config &&
+	git -C empty-active submodule status 2>err &&
+	grep "missing value for .submodule.active." err
+'
 test_done
-- 
2.50.1 (Apple Git-155)

