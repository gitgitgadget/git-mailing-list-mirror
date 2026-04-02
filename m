Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AED73E4C8F
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140417; cv=none; b=InjMdmiAhfY4xnH6tldU0WFRMv/Hdl6/zmP6te8A2USqOG6H9lz5pr4ViJi+d03qdrzeIwbQ2YKfUUn/YAl8IBjmvVJAcUBKNc2Thuy4I9wx6CCZiXCea9SGwMRifF2xS3w8JTJy0Qlw/ofWPaxIYhgqA4jG96vZpEOFkPQWrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140417; c=relaxed/simple;
	bh=bW85PusBQwgXzYLUQl2Zr3Gc3XQ2kB+YUaDHT8IPvUM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oaIfRQ1646tZJzS6aZIdcMnd2zrU7ujcSSUEjH0gm6spDxSorNiHdiP+uXXiyrZAS43P2qwBTNtVcfGTlw5waDWp/jOpFaHk4R8Q6gKVUsXmDTiJXpbooLcwyoQ4U8e4ZCEue4en/546HzeHDjzI3I5tpKA/nDzO1UyswgB4Pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qit3Ia3G; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qit3Ia3G"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a6cf8242so8564911cf.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140415; x=1775745215; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OAglk67/FA5TLBfkit0E1VV1o4AIGbJZzAaZXu0BOs=;
        b=qit3Ia3GPiYvrcsyfNMr9saKiiADze6zL0Kzmn19Q3DdJarTI8FO9ZwDJHkcFX//sK
         pROLNdJrJfy+wTMTkFu1Gp0ooL64/f+PA6sKB3l7pYB0cGHXkWckSdeJonPlHBqDf3Xq
         AQ9Z2MhonNGtCaIRQUrpfbxrq7Npn7tKhOyNbOW9fLI6r/rQeczLhTCS3mdPJzNS1lnd
         hL5ebkAZKvAkNOKFobj05s+CA17m0IboMPP9x3QfrQ8g08G6bpyJQI6RZHXkQta4428E
         y3ed8uspChb2a4ArS4JPw9FA/LgZTu355RBV9UQXlXP738Rul8dvYHSt+GIfAQPXsTkj
         IJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140415; x=1775745215;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OAglk67/FA5TLBfkit0E1VV1o4AIGbJZzAaZXu0BOs=;
        b=SEuqokOv6xnfSHWW9UogEzVNBR0H2QaDfH7yD1nBvuOA5CNiOyGVaj4oMwN1a+NTyN
         eo3MNt1Yg33FUS8hpEYovtIlX118maFPJQGGmVKLlqqEi7t3O2iG5+K7oAri7ub63nU+
         BcpiIdqs5VF2cNEFwc7dmIdF4WpjWQJ+0An3pwfrZn9XiPIE7dlpBtgYWtsQ5+kjY/ER
         oKbaILbNT3hkxsjvH1Zuj+8fdeZK7Ik/l/2WIYVNNUBHyI92/gL8M5eB2/hTmgreX+ss
         EzR3Xa1qJUrJaMcp45ScxtTuf94ittihAQJqN5idszYytrIGzsmi/3LKw7cZe4+qTcgw
         04cw==
X-Gm-Message-State: AOJu0Yy/BdbKYcGNK4RcMrFzFabFPtuQVRVqZ3Z4VRnb7UeN9dJFj+Yj
	8mnWzVFuzEl+YsFa7njWK+QmiACuERP/L9y1qmNnprbJib0NlIVBoLSRopc+IA==
X-Gm-Gg: ATEYQzzqLos+s1kN6pQDdyg6U+VoKwk6jPY4GTW6oXlupXJz1j+EEwvSXnnSv2qmUuA
	+gRxdVsUCTCVQGafxiqX+6zi87FnyvEP0hdspKGP0kG/TrRCLRt+sXWmafRNtnAk+b5q2OtenL3
	YarfUzcU/duj2tsy2jol5FK7eMMRfEm6OHCUHPXpyt8ZVvuBDmXU3peb7DtVIR3XcvX+xPv2+nS
	dUPVC5cl4NfdX3eEFwsjwLg+erMmfsspEXRgtIo8BUl1NdWQUHKF7lG50i1iHBMgHrwvTKRdlTi
	CTNFVqMd7Sht2HFnHit38Q4LZrkx3NZIWPCOeXTlap1fLovBJ7YFpndmgv+F+S7ACgyjdd9Iiiv
	hCrm1sVlCgzhfNuXj8Dmh6TwxoKfuZMskA1OxIHqZj29Yg0fGpLjLgqTSOwvOtrHu4FI+u8ULWG
	UEY/+GIBfzRVRTbaQ11LxdcIKl8Z0=
X-Received: by 2002:a05:622a:1190:b0:50b:3895:c22f with SMTP id d75a77b69052e-50d3bbe4931mr93187601cf.26.1775140414582;
        Thu, 02 Apr 2026 07:33:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b93dd10sm22643801cf.7.2026.04.02.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:33 -0700 (PDT)
Message-Id: <6a7730cf57b6b5efbc8d0556e19c8117955a74de.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:13 +0000
Subject: [PATCH 07/17] t2400: explicitly specify bare repo for `git worktree
 add`
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

