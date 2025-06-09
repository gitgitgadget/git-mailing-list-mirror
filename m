Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865CC133
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749457130; cv=none; b=aZToUxgzX0VmNdmuwAOubIvSIWFrTyU15rGD6tiOLC86IS9gJO7KCFOs+BV5eXCBj5R7dvgoDusPTynkGWD9N9hUV9A9hdXqGMWcTbIH06ZUBhLfHJlIPJOPCdEwbBtMoFEtQki8C2fTrnsc7TbPsBrdEitw3mpfL57rQHkjLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749457130; c=relaxed/simple;
	bh=/BshulUSaZ05Qu29/bM730yLUDfhxt3IXO715l/chG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GO691yvSwbqmvUKWbFjLR+8QCyhDLERMVGrn0qKAdTTjW7yx7y1JDdeuB1+njpqAMIkTGNgYKnvt1O2facOdga0J1RBVAXxUoilQ+fj9j9OHcZq+SibbZO4mrA7Hz793gXRy7iuRoInOXWS/S03+D1FsI4Qd6wZoJHs5H7zwIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTY1zEWl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTY1zEWl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so1384495f8f.3
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749457126; x=1750061926; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQhea9XO+HRv3x+qEwcJmVIw1oBgk2ak+CLOZl10F4k=;
        b=bTY1zEWlQ+Iybs/Zb/SB4vNYKsCxGmtWRR7he2HhUhwHa5Cc1OfH6CTlqysWc1F/Q2
         RzOLsVV2UgV2L+Um8aSPV3iE6sSraV7YCPnakV+c8OS4sJXAJc7gA/uZZb+LrUKFZaLg
         ldBG7n34cYd7CNeNkSoNSPjt0wkWRhR1CQjrhhj8mTOic9K07wu4GDFQEGgUSgu1bsCr
         f+gI9BOmwYho1l9vwPwGxrFzXiKA+o0m5bcjRRBI9PpzqgQEijpD1nfy8b/tCN8lt2fH
         pN7Lr98cKjSay1KwKACte3uvY2hMi7jzC7cNQJokThwPf7MdaPX7YqzTcRta45RpT2w5
         UoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749457126; x=1750061926;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQhea9XO+HRv3x+qEwcJmVIw1oBgk2ak+CLOZl10F4k=;
        b=YACXeauB4hUUTFlXNeNuoADPd/d40yxu20BPTuPROjRPcp5lmjD1pwLFoCfGqoLjqb
         dezUzPBkphC5YfJ5QPkLysxaeYvQYHxmm8ZIO86BwCDOr9Pf/JYyzcyncTMC3cLfD7iR
         Vf6k4iDsQsp7D88ZuLsaC8YXgjJACHe9ofAShideHlZG6hDrW+1GX2/QEJMSTlokA/aa
         EfSH0AY6APfc0FCtUHjSN+2jKnCvRPb+DEUIvu/Nb3SDab1w2vqji3JSrhaU1CvVUOJm
         j9PFo8vFg95CtFatIslx2Odc3X4FmVkfrLifQ4FEm3+MvTsb2bmyjCrlG7XElkNFQkot
         yVyw==
X-Gm-Message-State: AOJu0YxJ+n49Xe+y+kCwTCsAD9v3UOl7OsIECQKczg/WFM8EKF6eA4FY
	yMr+re5Sq8xPrssa/b9ImY94Q0yjhewzwIhdg7qD6rS/cMi3xfvoiEBmn8J4Bw==
X-Gm-Gg: ASbGnctBjRM/FE8cX2mM8P6sad4nOV3s1/w5nVj7Vo+pwC2ZLEgwdZiPT/c7+UGvbfv
	a221SYxvYwVmj+3wCaky/8J8CFHE9As2xLswPlj6ZCB9ayEG7ce4+Y8lZWCXYYNBdX3G/wP/aCd
	HqqhoRuuL2dZpfe4xe/qQPBmeMe33ILytK7G0u7qNRwW3IXW0zJOIjn/ck3ki/ptjl28u/qh7X7
	prwK1KHOyC86hhOI1tzt14f44ING9RijgDztwrDN8pq+vHNmrWya2pVr+petWy16zMHr7F40WCy
	g3t8ZquxA2aVq3sMbfVEIF8E50vjGxEX4kFL+GnEjPWs/9enEWJb
X-Google-Smtp-Source: AGHT+IFDCqBAQXRIeFi4qiM2jQAYlhHAY2pK+o34NheHOebFVmpm0K3CofZ65lotYfLhu8ByRzZL9A==
X-Received: by 2002:a05:6000:2891:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3a531cac39cmr10562868f8f.23.1749457126104;
        Mon, 09 Jun 2025 01:18:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b653dsm8994859f8f.39.2025.06.09.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 01:18:45 -0700 (PDT)
Message-Id: <pull.1977.v7.git.git.1749457124804.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v6.git.git.1749138820241.gitgitgadget@gmail.com>
References: <pull.1977.v6.git.git.1749138820241.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Jun 2025 08:18:44 +0000
Subject: [PATCH v7] pack-bitmap: remove checks before bitmap_free
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
if cascade_pseudo_merges_1() fails. However, cascade_pseudo_merges_1()
uses roots_bitmap as a mutable reference without taking ownership of it.
As a result, if cascade_pseudo_merges_1() succeeds, roots_bitmap is leaked.
And this leak currently lacks a dedicated test to detect it.

To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
always calling bitmap_free(roots_bitmap);

To trigger this leak, we need roots_bitmap that contains at least one
pseudo merge. So that we can use pseudo merge bitmap when we compute roots
reachable bitmap. Here we create two commits: first A then B. Add A
to the pseudo-merge and perform a traversal over the range A..B.
In this scenario, the "haves" set will be {A}, and cascade_pseudo_merges_1
will succeed, thereby exposing the leak due to the missing roots_bitmap
cleanup.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: remove checks before bitmap_free
    
    In pack-bitmap.c:find_boundary_objects, remove cascade success check and
    always free roots_bitmap afterward to make static analysis tool works
    better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v7
Pull-Request: https://github.com/git/git/pull/1977

Range-diff vs v6:

 1:  43cdce190dc ! 1:  74c41eccfb0 pack-bitmap: remove checks before bitmap_free
     @@ Commit message
          pack-bitmap: remove checks before bitmap_free
      
          In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
     -    if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
     -    use roots_bitmap as a mutable reference but not takes roots_bitmap's
     -    ownership. Once cascade_pseudo_merges_1() succeeds, roots_bitmap leaks.
     +    if cascade_pseudo_merges_1() fails. However, cascade_pseudo_merges_1()
     +    uses roots_bitmap as a mutable reference without taking ownership of it.
     +    As a result, if cascade_pseudo_merges_1() succeeds, roots_bitmap is leaked.
          And this leak currently lacks a dedicated test to detect it.
      
          To fix this leak, remove if cascade_pseudo_merges_1() succeed check and


 pack-bitmap.c                   |  4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac6d62b980c..8727f316de9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1363,8 +1363,8 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 			bitmap_set(roots_bitmap, pos);
 		}
 
-		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
-			bitmap_free(roots_bitmap);
+		cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
+		bitmap_free(roots_bitmap);
 	}
 
 	/*
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 56674db562f..ba5ae6a00c9 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -445,4 +445,21 @@ test_expect_success 'pseudo-merge closure' '
 	)
 '
 
+test_expect_success 'use pseudo-merge in boundary traversal' '
+	git init pseudo-merge-boundary-traversal &&
+	(
+		cd pseudo-merge-boundary-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/ &&
+		git config pack.useBitmapBoundaryTraversal true &&
+
+		test_commit A &&
+		git repack -adb &&
+		test_commit B &&
+
+		nr=$(git rev-list --count --use-bitmap-index HEAD~1..HEAD) &&
+		test 1 -eq "$nr"
+	)
+'
+
 test_done

base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
-- 
gitgitgadget
