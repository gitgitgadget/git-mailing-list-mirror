Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322DDC2C6
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451959; cv=none; b=KL1Ynu83w+rPFXX97vxdqQefatSdIJ3MGRgGOjLtNkHu5axxnC4TMnrMIA5QW21/u/GqanbkEoVQ0GOJRDdlikhLfY9V7k3GcTxHb4Bg9U59fa12CwErkKrVet/gRD/b5IzqZiV5snbh9+BoLVLAm2mU8yBfXbWeISwwm5yS0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451959; c=relaxed/simple;
	bh=BVwZQgm4fNuN9XYHLwgTE10/nM2t8R6cCePYUfXoa4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gevuOjuOlw2Q8OeJvE5BEm+FxFurakxTbtBh9rBoe+h/eD78DDOStmRzhYpIdMUR7CMupt9D7FtNMKrsnCyNkZTI/oHpizPVTW2Z/tcvclKToFyau8oZCe1z7dgdQw2uYqY9pLaaBprNCA+GKNz6FTL9okgcNpDDxNLfxCl38NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQw/BFcG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQw/BFcG"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so2753842a91.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 12:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729451957; x=1730056757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hm4eyajkiO36FBTZpacAzYq84DGKVuqsQc2nM69fRw=;
        b=dQw/BFcG1G/sPovbBbF4IoO80Z7X9XDCiTOc88uWAfJEdqCvLXo7tBipc9a5L5GN65
         Blp7mTnEt29Plx3yYC2FRjkQ161sahvhG4RP5WmCBgxpRXP8WXTlxfQefYJO0H8YR98X
         TlGlsItMuAnEvLn4i8aCH+OGZE/x9k1TaJj7W3nYHqNEOWlSwsJ8uq+r5c35XKY5aW/I
         ERytXqIWbPTzs0wO/fqdY3rt9vHTCljM6a23uoRj31Nm0D4EF0dMc/DPHKIyuNz4dV8/
         H7SsZ0xq7BqYAIuMd9xGsH28bnqV5Qesg83LVEw79+WS8oWQA0NmUO7duJm6jSC0iZpd
         4YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729451957; x=1730056757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hm4eyajkiO36FBTZpacAzYq84DGKVuqsQc2nM69fRw=;
        b=n0HE6OzFsA+r95yavk5UhulOK4HilfIKyKMCa/UVyB34OeKdQuR5120x8VMeTzqbbm
         yKa2E1/75dpiDvqKbcYiv3kc99JM71jSwgRN9BhAAyyh9vLYS0FzHcy5E/1BuSbev8b8
         mjAbDKYJOUhF58NtvZFbqeNhKbVWnCPPTMe3oQtz2mRu8FJfJ/EyjihuT7/P0Uhzb/yo
         nzjnlStt1Jrwup8DlJkKUfndx5EkBzU1PuFiFIAmzGJGpQAgFEBEQAdz3oY4d7uqx6WL
         mkjOylGuiC6QrpVo9FKuicFCBcKitYzrS0sCrvXxQZw2INToQixBuEkU07eAucjfiAky
         IfJw==
X-Gm-Message-State: AOJu0Yyie/a7W+4Wnv4EP/S9I4KrepnuoRC3XT9zwfojDVAI37JYQxD/
	WuOu8PIqGlP88/C/c9566dSXpHp5AmK0OtIgKWp/5y47NFScm+s8D2/PXbCn
X-Google-Smtp-Source: AGHT+IF5xouEfoFDLqEYweuaAHDWfl4ju5svXF3ma7A2mIHXlTtdp/QaO/VpvRSJrOEFRlwhNHfGeA==
X-Received: by 2002:a17:90a:df8f:b0:2e0:80e8:a31a with SMTP id 98e67ed59e1d1-2e561a17ad4mr10333784a91.35.1729451956877;
        Sun, 20 Oct 2024 12:19:16 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:3236:eff6:ef7e:192c:2d85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad388effsm1894576a91.34.2024.10.20.12.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:19:16 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH] t4205: fix typo in 'NUL termination with --stat'
Date: Mon, 21 Oct 2024 00:48:47 +0530
Message-ID: <20241020191910.31096-1-five231003@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "expected" to rightly terminate with NUL ie '\0' instead of '0'
which may have been typoed.

We didn't notice this before because the test is run with
"test_expect_failure", meaning the test would have been marked broken
anyways.

Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index eb63ce011f..57b8b79738 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -137,7 +137,7 @@ test_expect_success 'NUL separation with --stat' '
 test_expect_failure 'NUL termination with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
-	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expected &&
+	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n\0" >expected &&
 	git log -z --stat --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
-- 
2.47.0.107.g34b6ce9b30

