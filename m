Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D754DDA9
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 04:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478651; cv=none; b=eK0s01FagfD/PDeISkVim4+YFCHznXRuqg0BD1V0+Egp87SOcgJFkUwO20SVe4YMrLiIJ/SgeM0+srsy+f4KwJJhM9F6xwSjqwmOdeQxjp/rocaCoPN6TR2J9Qa+eRx7yPAHTFAJuKXUroAJGeo3qNsrJzv1U2U1TJFCRk3ZZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478651; c=relaxed/simple;
	bh=k6a3iePBBZQK0WE15RfGMjhZ61M42XR3tvG1d/ufcCM=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OxMD/nnKdrY8IO4ZJlv72urk3AAiNencWHQuDMoEwp71kzDaKS9LpRIPiX0xWDcsMn4AnoSEQavhtqNsKRCY9iMnaSeFnmICpm3/wNDDNYjttvqjLC72XdCQsweRwmuho6r2PjTWkymON0JOhYYfStIiTUH5uGtseC9Fe51pnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhHY0RpF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhHY0RpF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e162b1b71so1550147f8f.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710478648; x=1711083448; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bRk35rCJptRsR34lFFULPr/lQowkcvVH60glXcDb/cE=;
        b=VhHY0RpFGh6nEgWAqDdQ+KosN9uWxh2fHS2i+SNPBetw10rI62jmOOQ03RMQPJJv3z
         x4jnEmW4uGRun7hv6uKvjLLpJZ0YXKqV9iRDJyQRkluCbaDY0pgrJzgFaIuxMhFsQPzs
         tQrohHx0sWb/OKnyJATbUFLlBj10vEZoaHWH47MeWd7pmoiN82Sex8IPNnhhu6yYUmoa
         0qgaQHzohvWZrShxV2Llli08ex0Nl5vsMBrCmqiVKRYRzFUQiianbPsapm94CKMy8BlN
         a5JmakUJxcibhyXIAMkYiE35vo/y4xfdo4W+QqXkyWsLt7oz4/CYLzgc0qKxYu0YkJu2
         cRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710478648; x=1711083448;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRk35rCJptRsR34lFFULPr/lQowkcvVH60glXcDb/cE=;
        b=qjU/YPI7WP0AR051JNL8b0HeCqwBY1EKViD1upsv5KPCF18fPSBbx5eDU8lWcxspdh
         eK6eGuDAW5ZHooppQDwFVHgPC4ouSB6NdSuiJTCFr3gdjMBlg+m3njFFlp1CF+MouILF
         NBablPlnAL9H7e/Aat72UPQZtU0IDZU27v73xAbTFX5D7ucD58osZflWYLuviSVizrFt
         qALtt71KXRfkxl53s6pOWQQpCkLWxI/PAoCaurTG/aB9VF2D3eo1MMZoI5r493dYL4Te
         ydHQAEC/p2fgAu9xoZ2Z1picn//6ODIIU19jwBSgZRVc8FPlw2CPaBxFILT8g9XvBwtT
         bd3w==
X-Gm-Message-State: AOJu0YydhQ2YCOLHb7tuLQLOpvM0XfXUU3k5Le593vnmfLuWrEE5tb6B
	gK8xAINGAy4GIFcUcGh1B0P/cTyMkdEPEKeCe64V+DGaQ5bbQkZgrDxjb00F
X-Google-Smtp-Source: AGHT+IEjHZ79Kb0D+H7xdbXlaWd5QxBogYWbxlKuTp4HnZ7L/xIcJTHh7UiSCNp2Q9mWdg6Qy34eFw==
X-Received: by 2002:adf:f802:0:b0:33e:7f51:c2fa with SMTP id s2-20020adff802000000b0033e7f51c2famr2936462wrp.47.1710478647721;
        Thu, 14 Mar 2024 21:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020adfe404000000b0033dd2a7167fsm2239001wrm.29.2024.03.14.21.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 21:57:27 -0700 (PDT)
Message-ID: <pull.1688.git.git.1710478646776.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Mar 2024 04:57:26 +0000
Subject: [PATCH] t5300: fix test_with_bad_commit()
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
Cc: szeder.dev@gmail.com,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

0f8edf7317 (index-pack: --fsck-objects to take an optional argument for
fsck msgs, 2024-02-01) added a test function test_with_bad_commit() that
contained two bugs. test_expect_fail was used instead of test_must_fail,
and a && was not included at the end of the line.

Fix these two issues in the test.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    t5300: fix test_with_bad_commit()
    
    0f8edf7317 (index-pack: --fsck-objects to take an optional argument for
    fsck msgs, 2024-02-01) added a test function test_with_bad_commit() that
    contained two bugs. test_expect_fail was used instead of test_must_fail,
    and a && was not included at the end of the line.
    
    Fix these two issues in the test.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1688%2Fjohn-cai%2Fjc%2Ffix-t5300-tests-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1688/john-cai/jc/fix-t5300-tests-v1
Pull-Request: https://github.com/git/git/pull/1688

 t/t5300-pack-object.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index a58f91035d1..61e2be2903d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -465,7 +465,7 @@ test_with_bad_commit () {
 	must_pass_arg="$2" &&
 	(
 		cd strict &&
-		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack"
+		test_must_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack" &&
 		git index-pack "$must_pass_arg" "test-$(cat pack-name).pack"
 	)
 }

base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
-- 
gitgitgadget
