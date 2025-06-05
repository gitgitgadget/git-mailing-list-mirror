Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF52566
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749104673; cv=none; b=hSbnQKh6jlrZ1IDB9/ixJ9imkJQF5dxaJAlHliGVGueThzBV5qBQceuIReY09zdr/kKz++BDm2U4sKYg5rNt3RUKIbQsdZVz6mzkMruQlInfNK+pHZwXdtUoT7qoe8cTtQsjz2OEBqjQj096+2lDjdnXoL1VPquc0Rr7cttWgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749104673; c=relaxed/simple;
	bh=PMlN2ZS9DdICVuZzN5V2sKL8y8x9A7yv3HN9VTg0nS8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QJ9mmBi7yuhzAQPy09FE0QsuvFiMHT9xpBaOOcm5ixM7j4IF/L7nr4u4QYOj9VqBdHMSOb+xqbHFR7lqE6kmhQTXYNeOkW4dLMjVXIZV1xw+efH4WT/qimH/im5C17JaG6e8SNJ/pk/STJV5GaMJPeOTl/pAM9yP6vC5Aw7IDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/oNUv36; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/oNUv36"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so4251355e9.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749104669; x=1749709469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sziat50AcSf9CYAFSgPwvevB71lj+dZ/C7tPKtVB8pc=;
        b=E/oNUv36V5/IZ33H9Iy7a9rbWxehgz2/yov0XXmPgJjp+NKJeJdhgjKg8R6di9Pv2J
         kQqY2CiPDsYWq55x2JtorVpQhYVzjD+D5BOiG70Yafre2mKVxE6Adnb7XSw554GPT1qw
         Em6aic489ag+l2rYDfLARZsLVLlW8quH2B5xhuRgisGLl3ORFNSOWmbRDI156KdUqjGO
         JyxllRRLs/z4o0cXieAlSWlacSl4bQlSe/YLFruXL8TcseuDmbmVaoR0L6taJsSwamJn
         In9psD2O6CWKXxjUHqb8CuSqT/35dp+C4IwncBxBCYT5bUElsUiQ8BM+1iK5rC2uyqlY
         hUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749104669; x=1749709469;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sziat50AcSf9CYAFSgPwvevB71lj+dZ/C7tPKtVB8pc=;
        b=c+3tqqvQt7ZOh0ZpHFnNOn9w4nCia5cE2/BCmKZCQOJ2wmVvXjKZKR/PoLjq9qdfOz
         M0+hb/DdCKCzrejnmlP1GD/fqPO9NuSQC6654vN6MYEpwJ5mgcqs3DMyVtSZ45xZp9Nn
         ADWB7M3WHGlXCx9BsGdYeV4Fwk0L5ju8v2us7/8YeuaJuNBmoqhtAz48SK9NssfidNy1
         iVM4VZg6DaARMDVU78dQRnDYW0jLYqjbz+P6aNYRlZjSG7UojwF0sadFYzxLzQjjsPLj
         8/QOmJ+SNQCdHYCypADX550fiNs8+zF1EBHWvBU2zxSrvu/oF3YW96+TASLHBbopJ1Az
         J7NQ==
X-Gm-Message-State: AOJu0YzfAF/TBvJrdV/vxZRdCG4D0SfMnPdqSkxdWEn3rzO8+pRAidzp
	mGbItMnbvOU/PyWtyceeXO512/wgII/+/opYuZDus0ShIxjKIdvKt1osLCagSw==
X-Gm-Gg: ASbGncscs/GTYc5jexhaxlgxJaTgICrFRXA3hTCsYky2HwxnfMMxtw2PSZI+SV4t5YX
	iNwhBhbHPB6hx1Ug34m5ivHlyaYiInatdyquzVPl+JPne1w5ifdvsRpMPxnGFgZTTAi5Eo71YKA
	gmvus6xQytD7/LvV9+0cYq3MumyESUzbbywba1XAwCRcgYJS8rVe0PnVVdJNazsSurmaUQA8PeT
	YIQza94gfwvebKuu8K6BICK0adOWP4/7MDTpqDKjZ5ZnkUsNrn+VvE9OSakd3mytjcVYToh7txy
	tQmcjwOa403iGX3fOxWp/3Zh/d07RUl8+lrO46psFmH7tdkthLCj
X-Google-Smtp-Source: AGHT+IEB2ktq99XJRjEZQicRoisab1KLmnk/vw1aWke4HMu+KAre7lv641/dtWndFefPLLjmrGRvWA==
X-Received: by 2002:a05:6000:24c7:b0:3a4:d8b6:ca3f with SMTP id ffacd0b85a97d-3a51dbe7304mr4293434f8f.30.1749104668926;
        Wed, 04 Jun 2025 23:24:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a526ddb8afsm1476793f8f.0.2025.06.04.23.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 23:24:28 -0700 (PDT)
Message-Id: <pull.1977.v5.git.git.1749104667618.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
References: <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 06:24:27 +0000
Subject: [PATCH v5] pack-bitmap: remove checks before bitmap_free
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
if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() only
use roots_bitmap as a mutable reference but not takes roots_bitmap's
ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap leaks.
And this leak currently lacks a dedicated test to detect it.

To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
always calling bitmap_free(roots_bitmap);

To trigger this leak, we need roots_bitmap contains at least one pseudo
merge. So that we can use pseudo merge bitmap when we compute roots
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v5
Pull-Request: https://github.com/git/git/pull/1977

Range-diff vs v4:

 1:  fa443065436 ! 1:  4bc90c83a40 pack-bitmap: remove checks before bitmap_free
     @@ Commit message
          To fix this leak, remove if cascade_pseudo_merges_1() succeed check and
          always calling bitmap_free(roots_bitmap);
      
     -    To trigger this leak, we need a pseudo-merge whose size is equal to
     -    or smaller than roots_bitmap (which corresponds to the set of "haves"
     -    commits in prepare_bitmap_walk()). To do this, we can create two
     -    commits: A and B. Add A to the pseudo-merge list and perform a traversal
     -    over the range A..B. In this scenario, the "haves" set will be {A},
     -    and cascade_pseudo_merges_1() will succeed, thereby exposing the leak
     -    due to the missing roots_bitmap cleanup.
     +    To trigger this leak, we need roots_bitmap contains at least one pseudo
     +    merge. So that we can use pseudo merge bitmap when we compute roots
     +    reachable bitmap. Here we create two commits: first A then B. Add A
     +    to the pseudo-merge and perform a traversal over the range A..B.
     +    In this scenario, the "haves" set will be {A}, and cascade_pseudo_merges_1
     +    will succeed, thereby exposing the leak due to the missing roots_bitmap
     +    cleanup.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge closure' '
      +		cd pseudo-merge-boundary-traversal &&
      +
      +		git config bitmapPseudoMerge.test.pattern refs/ &&
     -+		git config bitmapPseudoMerge.test.threshold now &&
     -+		git config bitmapPseudoMerge.test.stableThreshold now &&
     ++		git config pack.useBitmapBoundaryTraversal true &&
      +
      +		test_commit A &&
      +		git repack -adb &&
      +		test_commit B &&
      +
     -+		echo '1' >expect &&
     -+		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 \
     -+			git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
     -+		test_cmp expect actual
     ++		nr=$(git rev-list --count --use-bitmap-index HEAD~1..HEAD) &&
     ++		test 1 -eq "$nr"
      +	)
      +'
      +


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
