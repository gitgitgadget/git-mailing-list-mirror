Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A32D4B40
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864460; cv=none; b=O+LgsSPQiFpuXutlMa0A0oziMbqFaKEkZekGqTFmpRav2PjUQzBZmz37858QdVEmSb00cnM378RrYwYkmfQGuWhn2/bJ6PvN6G386yX5JAb3NfUZVTMrhewNvD1MPo44lpBq0sAfxdD/rnl2xl+6PtF2FnYFOqGK1sD7NCPmIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864460; c=relaxed/simple;
	bh=xeNJXPscZF2AKj3JGIKLQMM3QUI6jeZpJmPp9AgBtF8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oak0RRF+aXBZRkE75dfPM3CNkrP7Lj+ue6x/e/ujG79PyqTtI0AznhMayFpbog5qeoYsVgtEaiiyK5hQGAY7mAH/2v3JLidbdoUnZyM5NBmze7BFnwOqwOe9Wy5Ils+LUtfMPvtwWcfmj0CPmWTgzlY8ih6lPD3tm0mMM2fo/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVyBDSE2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVyBDSE2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba895adfeaso375027eec.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864458; x=1774469258; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5M0sJjEVUJCMLqQ9BbheMsagiHSpaSj/MNKGxArCX8=;
        b=mVyBDSE200NoB4i8PXdAwR0KVq5qcH5j/T5av+lKjgLGNC45CJvZnMWiKBE+hFv7Vg
         0I98v64ql5n50YXOmmCtEfuOqlv7j+vs3vicW87v92RJtvB0dAftX2VNMb7KM/pXz6FF
         WrfIR8Nmpu4vjwfcxG1564AZMISF3a/l9nS2vUa8dimp5ccWVRL870dUPIQF5S0boeuS
         +FDDMRKXwBku3YRtIqXtA9ZTGSgIDb6AI7T5hSKfM11FnsrxNS5q0NOa8HjnaiFdVcLD
         6bFTFSfpqVZUgFeyL8HIHj3cbjkWJsWNkOwFwzrwRiC7s8Vtnb+PR/wauvFxLJWqxgyk
         OH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864458; x=1774469258;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5M0sJjEVUJCMLqQ9BbheMsagiHSpaSj/MNKGxArCX8=;
        b=mh5F4g133rrngQBE86FHBHJ7mXcxX5l1UOYYFjehjdglMkmSECu/p09kgL5njLpNfF
         aUynKmCsQXwHvxw1WbV98jZFWbLmmxIog70gClYfk0a9Rbym43jWTNfPzP4DknL2XydH
         eSQsVUY7EBCtTv/MOkhzAo188/L7grbgOgoW4ulhwgp0JoxfQn7Iub2bhyh081LySRN0
         iV4MYrExMvJZHPDDsMA1EOx616D3vD9GQHr7WrmhuA4UPaNxtSCS2Cs1LYg1hJ5FabVd
         h4M5bV1kI0b12hZO2ZA3K8rgt/aHHmpWmamnxy6ZqK7OuXm6OGPSz7kjWYm/MwfmQ0Rk
         Tb7w==
X-Gm-Message-State: AOJu0Yxw60dM1BZ848tsyGEweM6xDO93kBWvitkfv/A/lPxzRjMOiL5i
	yCCUOpvegZyv6Tq5pSAufmYyn4+/kWtr9rbVypAcOXZbClKNUIz2hl5nEDsnNA==
X-Gm-Gg: ATEYQzwQVHbXN2lNumgLLmuRQC7H3LhLFFklWqgD37EH5YhyouDHqUC/RPLMbjjnFmb
	p/unn1esAVKDqb6nMkKxzjJTIy6YSYV1DO9i14f4ZZQWazZeKhfQWmcIeXVEYl6uzNyJzY1QWkE
	9q9iIHggtO/RuNxyT4EVGa6XrfryEL2k4ni172Cnl3SwM2IhKP7mJHQ0jpid8dBRW/Y/LtHaNKo
	KYReAr5hnhTHlxvPEY/vJIHmZyKlZHT5nA3FReAlCjOlvishedUUmJyvCE0ByjwLigLL+CunubT
	SUt2mzh3tGRmf/Hz8jxNaCp1EbYu9DNA6KUrL0QaWWUAiEg0WpKjqO7Z9FOB2YsFEEyuw2JAert
	TsGVlmrfoJXM11w2VWHeAs+/doQBII2z6OvaXTKZ2Lxdd/948cBZz/dfCMGhvGJVGvoiGi4xdW8
	IFitqZHONp4BJnuvpK3LMrXTw=
X-Received: by 2002:a05:7301:100d:b0:2be:1946:857e with SMTP id 5a478bee46e88-2c0e5017629mr2219229eec.12.1773864457598;
        Wed, 18 Mar 2026 13:07:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.162.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5368a7fsm7692032eec.1.2026.03.18.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:07:37 -0700 (PDT)
Message-Id: <pull.2071.v2.git.1773864455956.gitgitgadget@gmail.com>
In-Reply-To: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
From: "QUANTUM via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Mar 2026 20:07:35 +0000
Subject: [PATCH v2] t2107: modernize path existence check
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
Cc: QUANTUM <adityabnw07@gmail.com>,
    Aditya <adityabnw07@gmail.com>

From: Aditya <adityabnw07@gmail.com>

Replace '! test -f' with 'test_path_is_missing' to get better
debugging information by reporting loudly what expectation was
not met when the assertion fails.

Signed-off-by: Aditya <adityabnw07@gmail.com>
---
    [GSoC PATCH] t2107: modernize path existence check
    
    CC: Pablo Sabater pabloosabaterr@gmail.com, Christian Couder
    christian.couder@gmail.com, Karthik Nayak karthik.188@gmail.com, Justin
    Tobler jltobler@gmail.com, Ayush Chandekar ayu.chandekar@gmail.com,
    Siddharth Asthana siddharthasthana31@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2071%2FQuantumDev-CERN%2Fgsoc-microproject-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2071/QuantumDev-CERN/gsoc-microproject-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2071

Range-diff vs v1:

 1:  264040c6a8 ! 1:  6ed91f8d9b t2107: modernize path existence check
     @@ Metadata
       ## Commit message ##
          t2107: modernize path existence check
      
     -    Replace '! test -f' with 'test_path_is_missing' for better
     -    debugging information when the assertion fails.
     -
     -    Found using: git grep "test -[efd]" t/t????-*.sh
     +    Replace '! test -f' with 'test_path_is_missing' to get better
     +    debugging information by reporting loudly what expectation was
     +    not met when the assertion fails.
      
          Signed-off-by: Aditya <adityabnw07@gmail.com>
     +    ---
     +    v2:
     +     - remove "Found using" line
     +     - expand description to mention reporting behavior
      
       ## t/t2107-update-index-basic.sh ##
      @@ t/t2107-update-index-basic.sh: test_expect_success '.lock files cleaned up' '


v2:
 - remove "Found using" line
 - expand description to mention reporting behavior
---
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
 

base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
-- 
gitgitgadget
