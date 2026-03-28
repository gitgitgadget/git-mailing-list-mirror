Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895B38B129
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774704610; cv=none; b=ACd+GbUcxww1jKgXhtKupN1L7YpPkKHE5u4bm7d6yTZ+YJ7FUlkWDt30qN9rNBsNeyWmSkMpLlURXg9CuFmEWeQ4VvqOOYF7Cj1P55lJOkuHNgtp/uuIdKn+nwpci7W3Gb1bd+r3aK0wbPRYI7HRrymR4fd9PtkxSja8Ej1tJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774704610; c=relaxed/simple;
	bh=IjSS1JE3Ss14P3clXvHkm0cbiYm5G1ThVZEAykcwdRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ61c3pHIPIK79RAYg2M2jzMVFZvvZJWSdikKeZlU6Dlc3ND7zVXsjgduhcKaR6Sowux5WwglY5sILu+LpHb6D68yjW7wTaLEQJBb1n2eK+UXNnFM70CxsDY2DJ3SN/3D9uWf6sxRjZtjr0/wJhoSUIY8iNPN0kAnUUnxdUJvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAZ83t/F; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAZ83t/F"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824c9da9928so2205194b3a.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 06:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774704608; x=1775309408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpN66M5H7/5Uf0czB195Ix3bWTYfa92Y1aI61sSxLV0=;
        b=OAZ83t/FZhiI9HZgkFiOGEbjb9crxY0Km8od7iTdZgo298ERm6o8zPPWwNWzYCNVKH
         rLgx/kgExsf6RsTlgQvGHH2LzT64USVQNxHhu7n+ZZptFH/lB/bt6jrkr7EzbR68PbVr
         sQU/kYKKwMXh6FVrdrU/lwh9E7+YKSeHQua+c52rVyNMjFpqHmokSxX3e+ZWx0JAX/fs
         tyIPkNvdxE6uW6I49GzWjlO1bHyKNPuzLTJBQJVTwtjYH4JChEqIBuLwY8PbkUwtDCS7
         du3s2RAT+iGkk7vbkZm9F4x6r3+uPJneqtzn86Hnz2txNSMF3OZiDbxy8mInMOopjRQ1
         qJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774704608; x=1775309408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpN66M5H7/5Uf0czB195Ix3bWTYfa92Y1aI61sSxLV0=;
        b=MtEg8c/cK25OBIkMu6uBTaLxbCqAK2RZI3o9ouePRJqet6JCvpY7GKIhYiGN3G+ZQR
         vpQ6B34Cvy84riS7IYYPB62g2IE6+plLOiigxA8H0DjCwYJxXNHH4abZJK8IIRvJWxgS
         hPTtcyLDRm9HrIwILJHXnohZlpDkU/qgzEMDquVl5kBNR1mPn49JOx7G7IEzTPm0D7Bg
         krCJx30Vi8dXaKZPjuiEJ2IuTzx0R6bYaNoot3m1z6C1VPbYpDBSpGV18rvf749mMZFk
         w8412En5mxtU0dhOtcEVFwIzPKOaUdbxv1+Ch8nwFyOeEG5Tbd8NGm63wEVC5rnu9iHm
         I34w==
X-Gm-Message-State: AOJu0Yzv02OdNZwsOQVxY7j26ZEPRqTJLSz4Kq7iXa1mfdun1Ztmme27
	5SBr4egBQPUB+4hwKjsYjB+GgX7ovzlBkr5IfFb4qDEWcECmzul+AcCLjQh55Z5h
X-Gm-Gg: ATEYQzw0UQqrhg4EvGTSlL8P3zuywmD30KiEFIMQxQYk0+7kuJZvpIAUiYepJjRAH7j
	bIr6uYyue22jdo/UuPmq5VXPM6xStgBELR/81vZmVXf3RyVVyyrRal+9TU6S7eyzLNwyU6m3eLo
	VSO9cXrTJHEtJEN0/7cWixL/Vk+NOJbWhYBdUrfuZSYQzBIlEAr3Ev7VnB8ogJeka+vyaOjgt49
	PLtGsaoyqOyG7xEMTmB1EugwDAZWgByD43z635syKnKp0GjHX0pvgHmZqPDUfPWT3NokHSbj+ui
	Cod9r75KDuK7gFhsVtBdVWtCyMmFYZ/LBlbl5D0ooQErbU5ft/RmLUgZ7mxlZNp1JxNqCtV8G/Q
	ZwBKIyW1UmrA5M8qBKlujkDp2peDFoCBv8MjS6HZtcrYa/dXd9NMTKQ2knfW8cNt4ikGXvuvfYX
	6zwiBruzfSrFbtJhVLTNN0bxfA1aC6ycICtifod4Lbw9py123ilnAEQTSw+oSAOBeExmn1H+YNi
	KZhqc+3TA==
X-Received: by 2002:a05:6a00:3926:b0:82a:6eef:56ce with SMTP id d2e1a72fcca58-82c95ed5b94mr5954615b3a.27.1774704607947;
        Sat, 28 Mar 2026 06:30:07 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843bf3csm2208791b3a.11.2026.03.28.06.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 06:30:07 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 2/2] t8003: modernise style
Date: Sat, 28 Mar 2026 22:29:55 +0900
Message-ID: <20260328132955.172262-2-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328132955.172262-1-vikingtc4@gmail.com>
References: <20260328132955.172262-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the blank lines at both ends of each test_expect_success body
to match the modern style used elsewhere in the test suite.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t8003-blame-corner-cases.sh | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 17ed5af121..30e7960ace 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -49,77 +49,56 @@ test_expect_success setup '
 '
 
 test_expect_success 'straight copy without -C' '
-
 	git blame uno >actual &&
 	test_grep Second actual
-
 '
 
 test_expect_success 'straight move without -C' '
-
 	git blame dos >actual &&
 	test_grep Initial actual
-
 '
 
 test_expect_success 'straight copy with -C' '
-
 	git blame -C1 uno >actual &&
 	test_grep Second actual
-
 '
 
 test_expect_success 'straight move with -C' '
-
 	git blame -C1 dos >actual &&
 	test_grep Initial actual
-
 '
 
 test_expect_success 'straight copy with -C -C' '
-
 	git blame -C -C1 uno >actual &&
 	test_grep Initial actual
-
 '
 
 test_expect_success 'straight move with -C -C' '
-
 	git blame -C -C1 dos >actual &&
 	test_grep Initial actual
-
 '
 
 test_expect_success 'append without -C' '
-
 	git blame -L2 tres >actual &&
 	test_grep Second actual
-
 '
 
 test_expect_success 'append with -C' '
-
 	git blame -L2 -C1 tres >actual &&
 	test_grep Second actual
-
 '
 
 test_expect_success 'append with -C -C' '
-
 	git blame -L2 -C -C1 tres >actual &&
 	test_grep Second actual
-
 '
 
 test_expect_success 'append with -C -C -C' '
-
 	git blame -L2 -C -C -C1 tres >actual &&
 	test_grep Initial actual
-
 '
 
 test_expect_success 'blame wholesale copy' '
-
 	git blame -f -C -C1 HEAD^ -- cow >actual &&
 	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
@@ -128,11 +107,9 @@ test_expect_success 'blame wholesale copy' '
 	mouse-Third
 	EOF
 	test_cmp expected current
-
 '
 
 test_expect_success 'blame wholesale copy and more' '
-
 	git blame -f -C -C1 HEAD -- cow >actual &&
 	sed -e "$pick_fc" actual >current &&
 	cat >expected <<-\EOF &&
@@ -142,11 +119,9 @@ test_expect_success 'blame wholesale copy and more' '
 	mouse-Third
 	EOF
 	test_cmp expected current
-
 '
 
 test_expect_success 'blame wholesale copy and more in the index' '
-
 	cat >horse <<-\EOF &&
 	ABC
 	DEF
@@ -166,11 +141,9 @@ test_expect_success 'blame wholesale copy and more in the index' '
 	mouse-Third
 	EOF
 	test_cmp expected current
-
 '
 
 test_expect_success 'blame during cherry-pick with file rename conflict' '
-
 	test_when_finished "git reset --hard && git checkout main" &&
 	git checkout HEAD~3 &&
 	echo MOUSE >> mouse &&
-- 
2.43.0

