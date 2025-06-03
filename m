Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BC1B3725
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931656; cv=none; b=ucUFuD/n20eG1lm1ZnKAbB2LjWHLF2HCicoC3Vl1FP4D7W5xh5PM9I0xX1JriI8knrhrE+keiRIcGeTTj+U3vFPGPtkrPVwF7R3a7oXLHpBjWY2qPOBpqW2EYk8iXsYXez3EGiI8HouiDXtFB01uncDXDn9ODcyxSO8vJdcTtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931656; c=relaxed/simple;
	bh=eA1Cu7xJ2cnWL0UHUorj8sHk87N2V1xyucQha711m20=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VtmYc1KF2X9itpShjfTpRQ9+C8AvVAlCM7U9fWmpAoOsasMxxc/QdwLCnaJLHiBJFuHBWgAnhTBwTCcSyCLViA23246W4b3y9UQtl2GcJiW3rXHmq0h7ajThNffcEExQDy6SWSjPb5cFJyn1eK6ym/EUCzg9809mg8bqUpcL52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+WxmyGv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+WxmyGv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so31315805e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748931651; x=1749536451; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN1arpdwEYqh8M7quLER0lazGjkzL3PUOIUACKgwhZk=;
        b=C+WxmyGvNg+HhSQR0RIJzNVvbKncX3N4PZ6BHI/8C+SfGooYw8ORVT53W5xDX+ia5p
         8KtqdNdYakpcw/+pX8pLyYID2emRZjIY9nFZBFuqE1l21qUp4udOwwsJliKjuY8NcipM
         e4VDoEwqV+1J58pimit4XR/e1u0nmdJiznTQgzKjBIQ5NDAvaF0UznqadPlnxlXoAu5A
         gYO9kmiOQQimTMPMnSRFMGg4vrCkvy4E8zF/MhpmcAMFI0ocAhaXwxqdLreGAsotKt8a
         sYwdcsa4zSwm7TPdiHexJffrbinbCWpNUkMuM1MlSzThX/EsH58IIHON/l3qYhsqIPEU
         1Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748931651; x=1749536451;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN1arpdwEYqh8M7quLER0lazGjkzL3PUOIUACKgwhZk=;
        b=lxIoo0iKzXMf43pygYz0EkXhAbJwp5AJbyzrb3J3hPWnfbF+uULrB5aDaCEXZyWTDO
         xJ0EZ9BmgyGr/sgZgCrjf1ERFKTuCuyOppX12iFqUIWHQx+KlAcoEZkL5ogpLL/hgtuG
         QD7tJiPfCpI9tTLa947rRqzGjhflohqOb875MgIDQsgs39BYAKezr4AIH3+FAtE1FX4s
         IukIpTCE7DCTRXQZARE3YCDwZd78b/bv+V7/jTHArPI/3RFvuNOpiJxL/G4KOx5egIPJ
         f+SiUFk5OfeZ1XIgbR4Eav7bRG9nWPxYvvQUFZwYaHvrU2hp3ikVnHnuFAwVD53Ig6a5
         8FnA==
X-Gm-Message-State: AOJu0Yx4OobJfK4NUSUcvC68pZri30S4Tx/+e5zkWIP0a9vIZ5mthKf4
	XB433XbnaQcIbb+eUFaX/UmzGVqbpbZqa0wCINwTBTPDs0D+hlZXr2AD1xe0oQ==
X-Gm-Gg: ASbGncv+gwStgSOiys/AAPYzdBMQR+hII/abEvZdTJ4mJoqao1pgn0firHD8r7Qbnpk
	aTC2r7Nd8i8Iz/T62urpjvIiXuxFtnB5oITjkrrJxXqp5Sk33WOa+g+2nHmXOLC9gTT8r3a3uRz
	iDKjCOYjxJEEC7DR+5KFRtiSf3qvojQ0e5hx42FbsP4OJOCLrTpQel8XxW1SbeLjLnfFRdTPhiD
	jB2OMugHCUGF77WPwSDo1ZpY1vpohCQFNcZPO/7Fx2GUxaIZ5X3NsCmPqhuu/5cNZO1hRO6t48y
	HhhV5kVfI9AubRwOnC/eth+dL5gwuK7fj9E+o2OyO0/6ICpVMiIV
X-Google-Smtp-Source: AGHT+IEsCY7ir1GdoSHLDqYvOULnI/PpILxXglkAMxFxEbTfocPAqzdj9ETZf2vdyZnC33Pc7VI3Qw==
X-Received: by 2002:a05:600c:8509:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-450d64c313cmr146303615e9.4.1748931651350;
        Mon, 02 Jun 2025 23:20:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7facf9dsm144681535e9.17.2025.06.02.23.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 23:20:51 -0700 (PDT)
Message-Id: <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
References: <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 06:20:49 +0000
Subject: [PATCH v4] pack-bitmap: remove checks before bitmap_free
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

To trigger this leak, we need a pseudo-merge whose size is equal to
or smaller than roots_bitmap (which corresponds to the set of "haves"
commits in prepare_bitmap_walk()). To do this, we can create two
commits: A and B. Add A to the pseudo-merge list and perform a traversal
over the range A..B. In this scenario, the "haves" set will be {A},
and cascade_pseudo_merges_1() will succeed, thereby exposing the leak
due to the missing roots_bitmap cleanup.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: remove checks before bitmap_free
    
    In pack-bitmap.c:find_boundary_objects, remove cascade success check and
    always free roots_bitmap afterward to make static analysis tool works
    better.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1977%2Fbrandb97%2Fremove-check-before-bitmap-free-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1977/brandb97/remove-check-before-bitmap-free-v4
Pull-Request: https://github.com/git/git/pull/1977

Range-diff vs v3:

 1:  151a7f5dc70 ! 1:  fa443065436 pack-bitmap: remove checks before bitmap_free
     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge closure' '
      +		git config bitmapPseudoMerge.test.pattern refs/ &&
      +		git config bitmapPseudoMerge.test.threshold now &&
      +		git config bitmapPseudoMerge.test.stableThreshold now &&
     -+		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&
      +
      +		test_commit A &&
      +		git repack -adb &&
      +		test_commit B &&
      +
      +		echo '1' >expect &&
     -+		git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
     ++		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 \
     ++			git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
      +		test_cmp expect actual
      +	)
      +'


 pack-bitmap.c                   |  4 ++--
 t/t5333-pseudo-merge-bitmaps.sh | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

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
index 56674db562f..e665001a410 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -445,4 +445,24 @@ test_expect_success 'pseudo-merge closure' '
 	)
 '
 
+test_expect_success 'use pseudo-merge in boundary traversal' '
+	git init pseudo-merge-boundary-traversal &&
+	(
+		cd pseudo-merge-boundary-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/ &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold now &&
+
+		test_commit A &&
+		git repack -adb &&
+		test_commit B &&
+
+		echo '1' >expect &&
+		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 \
+			git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
-- 
gitgitgadget
