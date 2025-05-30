Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1C23BCF2
	for <git@vger.kernel.org>; Fri, 30 May 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628853; cv=none; b=KMiNQnoQMSOy307Mc4cgy/JRrS4QkPqISEzxpEdSeANgzYW64W6nTNBWZhT18zGryz6dfsN/i71j7J3OInlhIP88VvDNoYIX3Rbg2ZqQDc+J6WaP0gnjBaWYcNxw3Ng0WUhrd1HQPchRJH2cqZ7xuaBmyUr70u+t3TFqgqYGu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628853; c=relaxed/simple;
	bh=s3CzoYy1E7yb4ps8G+PB/GwFE9SiwlJ2lsMLRMkl9ko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jRnSshJjQ9/6Ze4aC/GBJ5zU7NAXE7yIBLT4CGhSbIZDi1k356Hvof7c4BPrjH1vIZm/vbSIAOfO2kmgjEvRRfxVodt/HvrG5tr4nPV3bGkLb6sfhBBP59+JNjnvFCdWF8j5aJGWApPz0v2lJvqpUVO4gmA9ELatch4K0xZynuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqf33Qtq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqf33Qtq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a36e0d22c1so1382377f8f.2
        for <git@vger.kernel.org>; Fri, 30 May 2025 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748628850; x=1749233650; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R32yJMWysyyGP3DaAfQAdU/lMGG5cTIggE6hM0+PI7w=;
        b=jqf33Qtqnrama4Rh147PrJdwAhBvV15RaV/J4VMIcm2eVJHug1UMQU3f+sBrBWeOJR
         xycqwq+FTRWAJSCBcVAxB/6Zfnmstw1A2+2XHnia5wxd6YK8+mNu3TgcahleC+G8d4IE
         ksRuQG7Zzm38mdfe6Y1xGugiJPHT0asdVfBvJyFr6E3u2XSHVS2ROywjKzbIAysdNa4f
         AqntMPG5CBypsIaWBXWSUWSsWRTOum/ZeUL6rdnH+te8BncaRwozUerSdwKQVPDhKbhJ
         A8oWmn3GwlnFIMK5hdFjtw+qO43fnnsP4hW4dqp+yVuuBrirWZslzJ/F71gK7TSxWG18
         TakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748628850; x=1749233650;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R32yJMWysyyGP3DaAfQAdU/lMGG5cTIggE6hM0+PI7w=;
        b=BD0u1aNYkSNwttMk8wjVA/wVlJDoTt8kQ1P5vv+WcJ1f/e7qP51qf7nprUKzoK1VAL
         sp965VfgCnXIbVLvT336acsiPWQDBDS0CKTPramx8D22f9Y9/vzQcwcmCYmjuXCWcROR
         9HnJnFrFKruJbIXiiTxb8nu8KNt09xlRvSgaul0gdplSyh0sfsfTlwrHBzwXJJrRguNe
         YxDoc3QmAewmOD0o9OF7AehUaAHw2t/5Ilc+rfT2REUyMyoYp++JavWSnrbGsdrW5wN3
         Me5/GGciEB4QpKFavMIrTg3KmjvcWvzqeDHzm3QX26Uqq8NvEJF4KoWU0gMmsN5qyF1g
         Pocg==
X-Gm-Message-State: AOJu0YwrbMGER0+BZlNCmN4aFJ8WIFHFGdUXVtgTUVgZvH0sKkbC+afd
	iTaVLxMxcKI9PPNZQV1OWZpppR47TC8VePidHsvgayojKOYt1l2ZixZ7h1v2Dw==
X-Gm-Gg: ASbGnct+/YFevEHhyVN+Jc1cxAHRUx+xPi2ZWf39hBlKi2WUvhQ6cM8pdceiNFXABGZ
	8iHeLvfeP5Va9aWs05q2Gsq5pMCWeSUUCihKK8xmkPbOr15GrKQOBwFyYj9KRrMlOvfVUh2xPWG
	Z9Z2R1ZA3VuzHuXMCU7vaSeavKKmKUwSuDA2VQ+4iOC6u8navN9AQLV/YFlTrFy/WLNPP+Qqpoz
	9Uyx74wl9PvPaUhZfD3Fgwl5TpV9buW21pHYpSWL0sTeqGHfOkwGvRqWRKsNbZTkJxkoIJi2Fxc
	mlWjBt1FHY9MXA/0/+q+dKLvjX5uTUeoDesgnjff/X3amLBRJ8I1pnkA3ksaTIo=
X-Google-Smtp-Source: AGHT+IEb3qBMJ8m2hIhlFHmwgsX8XfhJMeYsY8vM+mvXWK+3zY8JcWlu4IrL77SAxJw9yuIAgw+RgA==
X-Received: by 2002:a05:6000:2212:b0:3a4:edf5:b941 with SMTP id ffacd0b85a97d-3a4f89d3186mr2540695f8f.38.1748628849714;
        Fri, 30 May 2025 11:14:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a017esm5294248f8f.89.2025.05.30.11.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 11:14:09 -0700 (PDT)
Message-Id: <56b24d681cbcedaf5c03c89eee582d554a0894b7.1748628847.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
References: <pull.1977.git.git.1748149783383.gitgitgadget@gmail.com>
	<pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 18:14:06 +0000
Subject: [PATCH v2 2/2] t5333: test memory leak when use pseudo-merge in
 boundary traversal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only freed
if cascade_pseudo_merges_1() fails. Otherwise, it leaks, leading to
a memory leak that currently lacks a dedicated test to detect it.

To trigger this leak, we need a pseudo-merge whose size is equal to
or smaller than roots_bitmap (which corresponds to the set of "haves"
commits in prepare_bitmap_walk()). To do this, we can create two
commits: A and B. Add A to the pseudo-merge list and perform a traversal
over the range A..B. In this scenario, the "haves" set will be {A},
and cascade_pseudo_merges_1() will succeed — thereby exposing the leak
due to the missing roots_bitmap cleanup.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 t/t5333-pseudo-merge-bitmaps.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 56674db562f9..5e263fce50a7 100755
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
+		export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&
+
+		test_commit A &&
+		git repack -adb &&
+		test_commit B &&
+
+		echo '1' >expect &&
+		git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
gitgitgadget
