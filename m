Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0D346791
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332210; cv=none; b=Nfrke6neArEPtEpXKSVcBMz694tDCJwrzgA3uQROY9hRXn895l+OxXf/mMZXsUAY/vDp8roC8gPrXCqdFDxgtLKPRuw30UmDjOj1JY8iuFtEqqWkZXxxZ/83WNcDDYQ/8nyvbS6LmzxHlBg9HTzf4QC42xKWoTrA5IMaRim9Z4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332210; c=relaxed/simple;
	bh=bW85PusBQwgXzYLUQl2Zr3Gc3XQ2kB+YUaDHT8IPvUM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IwG39Gyv5uWpU4bN+gLfAGIVeoMaYZXY8eiy5rx15tl2rgYUb+999WXkm79C6OZXFriU9JrgTC8psv4BUfw7l4XorBXQhTuz19oKngWl3IjXatpc/WddCh82FvmDcHK2fwWekO+ZbWpc/+rtHki/lemtvzAGbRcwQ/1ARKk51/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaRYA3bu; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaRYA3bu"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89cc68655f8so30278996d6.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332207; x=1775937007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OAglk67/FA5TLBfkit0E1VV1o4AIGbJZzAaZXu0BOs=;
        b=NaRYA3buMOadWthCCXOb34a3mrdUfApwtak+E/FXIuGYGFrlmMF+0ojFAQKQEfxT1G
         f9NShTEGilv1REPyNZFeS7oECI79ZY1Veglgo+tX/nQUeR70IUCnHP8x4aROY4Bh8Xaa
         S5xK6pWknbaC8WVGRQkQFog7cIOwQwoA4OgAJEssyNDZjF6a6xo/HS2THDtwXE2Tdp2r
         qfDWQbeDri3x8hPWoHtvITXZ/xCyECGLot1JpALWK6eqLpH9wn+2sHz29KDGyt9oL4/p
         ss2s2obSWNCzA2CpoMJ0ypmNtIKqEQh+uF32/HO2O5cFduykIoUQN73TAuo1d/9QbEAy
         LVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332207; x=1775937007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OAglk67/FA5TLBfkit0E1VV1o4AIGbJZzAaZXu0BOs=;
        b=Jag3MCs5dVuJUGBwovI6Aer32F3KDwbhecto7bOfvOvJS6eOxe212w3VjlwDr3JeW3
         UJZRMPrreiukbPaWxHMESDa1PFLkfoE4pz4aL+XcUbxNZb/8Bah3gmJaO9MECbFGNqhS
         Z52/UfMiAZByZxwpmiNz9MTgKVaYfHZVBZxcHLrPbHlYgXdixReI6yBaultiubhbS3za
         JFIio7eIRFjPiO+z5BcSPIfRJxm0gyYQZWhXo0ZFfG+ZOXckWKNXqMG70qMTCgUhFgF7
         zc9jmqwvMbDO56vDX8KzH6Xh9oCP3f1HQcffyHYu9uB1TesciA7t1vrqHx0u9DOhLApw
         pVOQ==
X-Gm-Message-State: AOJu0YxVBL6SQ356ajCYlhoe1TllgqrcvJtFkBgBoJ7Ll5wqu+y3jEyZ
	Z7GmK2mUs2R/4QSG/KoifXX5ipwOc+XNScCPmCVI6Nw5Urzrj7IEUKjSZJ7o8Q==
X-Gm-Gg: AeBDiet7m6Vddh2rcG/Si5+kKnIZqM+bVrxOyak1ENnCy08Ek8dybeYsiUBkAyuj+ns
	DM+HDSM4mOfnobThg/xfGQk30nlANKbMUJrJPRDDC4Zn4IyKR9J9+PM0OFlTR+PiUb3Nu6VNfXq
	sFAA9KuTEAyubWYuagQcPUYoyvSXueZaSx0VxOoaX5Xl29WtGNHsE34fmRtMUSljfl195t9+r7+
	9PK13jBc7SLXQXD+xe4CI6ESgDg3umdkRuEcZPFTOgFiqcZ/qGViIA53rwHd2Qg2+3FupsekGtv
	CjNHWu5N3ekbZc2JqRHBUpGpC0gWHfL/cgYgjtfByz157Df2Enx8PdbZQoOtM2g0PrR0Q7w0XNb
	l0E8aL+L+dqmtCWuZXmity9MEGjn2W2N9tYFc3cSNrpkCRDJZ1+aFNep1gbxBPDe0h9PYj4gTBq
	bheHGQ9pLj026abU28msGzMFZgcTc=
X-Received: by 2002:a05:6214:260f:b0:8a0:c2a9:b7 with SMTP id 6a1803df08f44-8a703b312c8mr114462776d6.11.1775332207378;
        Sat, 04 Apr 2026 12:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5971ef80csm76770836d6.40.2026.04.04.12.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:06 -0700 (PDT)
Message-Id: <6a7730cf57b6b5efbc8d0556e19c8117955a74de.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:47 +0000
Subject: [PATCH v2 07/17] t2400: explicitly specify bare repo for `git
 worktree add`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), specify the gitdir specifically in bare-repo `git
worktree add` invocations via `--git-dir=.` so Git does not rely on
implicit bare repository discovery.

While at it, also avoid unnecessary subshells and `cd`ing. This
simplifies the logic in a rather pleasant way.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2400-worktree-add.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 023e1301c8..0f8c837647 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -171,11 +171,8 @@ test_expect_success 'not die on re-checking out current branch' '
 '
 
 test_expect_success '"add" from a bare repo' '
-	(
-		git clone --bare . bare &&
-		cd bare &&
-		git worktree add -b bare-main ../there2 main
-	)
+	git clone --bare . bare &&
+	git -C bare --git-dir=. worktree add -b bare-main ../there2 main
 '
 
 test_expect_success 'checkout from a bare repo without "add"' '
@@ -186,15 +183,11 @@ test_expect_success 'checkout from a bare repo without "add"' '
 '
 
 test_expect_success '"add" default branch of a bare repo' '
-	(
-		git clone --bare . bare2 &&
-		cd bare2 &&
-		git worktree add ../there3 main &&
-		cd ../there3 &&
-		# Simple check that a Git command does not
-		# immediately fail with the current setup
-		git status
-	) &&
+	git clone --bare . bare2 &&
+	git -C bare2 --git-dir=. worktree add ../there3 main &&
+	# Simple check that a Git command does not
+	# immediately fail with the current setup
+	git status &&
 	cat >expect <<-EOF &&
 	init.t
 	EOF
-- 
gitgitgadget

