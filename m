Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058F3033C6
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197605; cv=none; b=fElNX929BCin/Un/qOFi7w+YW6ffezz+6mWOEggsM1hzkCrAClVZiL8Olbe/QXrllrsK5Uxw69OdCV/43z60BoaojWsb5+Z+akYT21sx4j3UZbs2cCAGwl+wq8DPDP7MfFUW3g49COsot6tPoA54MGn0NtEpz7SedrWa/jHBAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197605; c=relaxed/simple;
	bh=ZP+GdOa4F77wCuRYGBWzK5nCofMlXBiRWpL58jOF0og=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SRvH6un1gRYa8KHyCi4rhzCm+7ub2ySWawa7LkQ5qxICoaHblJdazUwVJNdZpbcea4kE5FJ2kRxfeQoZiclVrtiZTKR+wk4qjn9sqyUISIL+DjLJ1j+iMMTuPQPjqq/mNFhJjn0c5/V77IKrolm2xyk1eNxSYqRo2ekTVsZO1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUCkS+9v; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUCkS+9v"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfcb045909so279351085a.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197602; x=1774802402; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fwDESrMy6atrmzP9FHL5TEXg58bhtTWh9n8+BMeO+HM=;
        b=YUCkS+9vC9yCUcR57AaTh+6YM2a973IEDMWvre4fKV+eB0JJ0gNEJn49FRMTJZLRM6
         hek5ezCAD28EMO9Q2SwLwIhUWB4FNMcYfMPgf+AsztsIYcBazNXuktWv+5g289r2ecwY
         YkOsGcwNCg4zYxjxZY587FPlDA9wxruRcKMK0Rjq3PBy56Jx1U+ugiX7nG9CWhPhpBfK
         kt2AKr5FsqFBwzGbi5zx/t5jNMgC054scAEdvsMzyuIvjhyKhOYbsYG3bHa3IIlwb+9D
         eGw2UM1yCOO4+Vxj2ZDcPRZOHwJFqrnFJ9fXbGMULCAxEBLppjinx+EgbhiGPtReI4n2
         +rwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197602; x=1774802402;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwDESrMy6atrmzP9FHL5TEXg58bhtTWh9n8+BMeO+HM=;
        b=oL+SRB1p04XC/Yh4hD6KtTVgEXpss/1pBlENiMEMd12KyBvuaOtuT8hGwVwbtgVqm2
         eux4yT45uVIj/pNiTzAsVcdFRyRs6PN6r0Xyh3A6zNEOrLmcLS37gMpwuhUr2JtcgIOz
         LjY1KBlabYNgNcNI/VUaj0s3aAnyOQUoA8R3q4kh+6wYEZCHxkye24dHHlf+a8dRO4OC
         783GeJUbmg1cqQVUOQcRDxsAHJMEMpTPtyG879UIwRta/6+mlVAoLT+u1/Szidnzf60o
         YWwW3xXmx6u2xpdmh66J6n1aIxRgAVZdkUTgAa3RbcGTmfrUD76SsxvSDYiZ8+4yeyYF
         V4NA==
X-Gm-Message-State: AOJu0YwMmovJqYdUgweRuubE1LZfWWJwmR3VqYwprCnAb9WqxNSbnOrU
	Y/EH+D+NvA/yCu3nIjKw39xqxJUCjgfuqtaB0TJMAcUJqrCc3q1jB+Atahbt0g==
X-Gm-Gg: ATEYQzyhyfkrAHkdGvlUsq2ToymxoFrIi0fGEwIMN1hOS6W+/pqZUHOfAdc6sI9m3X5
	SLSWnsMii8TI/IyB5Ox0pWTqjWUqUsjRAmUA3Qj7/dCsyukedNOTRLBaSXMp44Ujq3VgoKpp2qV
	sjZ1QJBbhxFmOgC75VKUd1a/qY2N8eAY2NBkHzq8Hxev5BDfeVFOLLMyYH5brgRguD3CE2FVQkq
	N6WwLW1oGTHEkZ2CeaJVshGHzxrKahmwDMBmu7Gq+QiT4AfugLRsLsRcr518hIEEJFqIj3MSxDu
	dOc+rZRO6C2BhQxiXN+GBD8au/S2tA8RCgMMw3wXhTPph8bWNrDkK0WmVg+LtWfQiAbsznQQYds
	/TvRKETvsT5dsJfCi70Tfp4AHibFgkIZUn9V02JzVPEECmDn0xJQXIF2RviFd7EO3SIn9DN9lDS
	GYq+Nxe05j0qUoZA2SrzTnkVc=
X-Received: by 2002:a05:620a:aa03:b0:8cf:cf2c:e008 with SMTP id af79cd13be357-8cfcf2ce4dcmr1078184385a.62.1774197602089;
        Sun, 22 Mar 2026 09:40:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.183.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfd55e79e6sm423725985a.29.2026.03.22.09.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 09:40:00 -0700 (PDT)
Message-Id: <pull.2250.git.git.1774197600379.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Mar 2026 16:40:00 +0000
Subject: [PATCH] t/t2107-update-index-basic: use test_path_is_missing
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Ayush Chandekar <ayu.chandekar@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

Replace a raw '! test -f' check with test_path_is_missing to
use the standard test helper and improve consistency with
other tests.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
    [GSoC]: t2107-refs-tests: drop '-f' from test_path_is_missing
    
    
    High-level (Intent & Context)
    =============================
    
    The test script t/pack-refs-tests.sh has two issues that prevent it from
    running correctly.
    
    It uses: ! test -f .git/index.lock
    
    This is inconsistent with the Git test framework, where helper functions
    such as test_path_is_missing should be used instead of raw test checks.
    
    
    Low-level (Implementation & Justification)
    ==========================================
    
    Without sourcing test-lib.sh, the test framework is not initialized,
    leading to errors such as: test_expect_success: not found
    
    Replaced raw file check with the appropriate helper:
    
    - ! test -f .git/index.lock
    + test_path_is_missing .git/index.lock
    
    
    
    Summary
    =======
    
    Replace test_path_is_missing .git/index.lock
    
    cc :Karthik Nayak karthik.188@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2250%2Fjayesh0104%2Ft2107-missing-helper-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2250/jayesh0104/t2107-missing-helper-v1
Pull-Request: https://github.com/git/git/pull/2250

 t/t2107-update-index-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f..3bffe5da8a 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -86,7 +86,7 @@ test_expect_success '.lock files cleaned up' '
 	# the_index.cache_changed is zero, rollback_lock_file fails
 	git update-index --refresh --verbose >out &&
 	test_must_be_empty out &&
-	! test -f .git/index.lock
+	test_path_is_missing .git/index.lock
 	)
 '
 

base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
-- 
gitgitgadget
