Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2686140
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972374; cv=none; b=S5LHZnMsmjp5TPppSseSegy7SGvsDB1716hhA1omzF1d0MA6MUMUiM4V8vTS5basojKru1R5b39Z4n6rA3BAtp9T9jwyfSjwERSXaFNJFDmTuREdo5uOB9wQvhltsSHsS1gX0vrCrA9hUejU9PwWods3ggNaYJZephjm9BAwuv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972374; c=relaxed/simple;
	bh=3iAnkBErJUUehPh9jl5QXCZKhTMOX0axVfFxaSGxLoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbgcdJCrFFFBjvwgH1xwJz/Ac8OVnzZlh2cxdK5AeAyF78m+42kS/y/Jyq+rtF/DmoYIKUlYp8mgvPIAj3cfhCIAoj1GtRsK7IRyPGvZb9Yoa3GtbP4/3AzwhHFFNHwYNRaJ5fFfRHaBCxmNSqXCpx3NxjmPI24z9oXwyylzAmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jaGX6sIx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jaGX6sIx"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690cd7f83cdso2158466d6.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972372; x=1711577172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cA0lReE301x14H+9nv5o6mAI4tz1gT48nr+JRRADIVw=;
        b=jaGX6sIxvgmKsm4mdd4njVvPweCQ9v5yelrDxo9ret/YsldBd9pEwByFucpbtj19Yt
         pMoEG6UzK0lu7HIksk2bJtYd/GMuNZigFcNw6KY2iGGoyUf3XtB5kxIAKZgafnLkmeN4
         p2QUJhMqJJxRoDzHQ7MyM5ESgJECHiLEGO6XbjvUTdsEbWExPv16cQFksMRWu0WOuJiz
         EsgVHycvAUy/A244YGJTk/vppr7toc+CwTU1ilcPCNb3FtIgJV1Lo+7VhFpy1I2Pq2Ct
         g2ExXM7l0JNmitwZBZRfmFrlKZ1BvClFLM9KD+PgeNRLqSHv+HimpH04OYsp+9sdBa/c
         m+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972372; x=1711577172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA0lReE301x14H+9nv5o6mAI4tz1gT48nr+JRRADIVw=;
        b=qC3G1DWubhfSbP4KOTziKENvV4dbEHuIfRcjoTtnX5IjjRXt2uKQ7x5ZUrcwPNfrfY
         f9xaj0fhE7HtHCiWe3XnZkDbZAc2NTmTX47Wq8TZ7DLL86lfWf5WC4D71/KcWbmDUY0/
         qcNG4FsjTFgGP/fG5+Ku3mx/YabpyOqACe/BmiVN6JF6KFSC4v4QJEpVAXLKmP6vXz36
         UO8nkYRAdI50IWuL5p4iuTBkJ3WihOriqqqP4WCXDgUZl4Wdci2rdtzT5RpV8ANHGrIf
         RsIMaJsXpTny0qA5VWCZfQxwqY+liE4s++SFwJShaTxt0AAJUZMzupStZd/G5aEPbYLq
         yWgg==
X-Gm-Message-State: AOJu0Yy3xVVLiJjpWDroWLVCcFrM1xp8yC7Ma2rsbUdpUxcgbG3vLxNb
	7RTOrV5pl69pd2KvR2r9vxxSKDxh4+udlOTfx8EjP3J6Vmo6wIP/UDfExARrU14Mb/xTOOYynro
	M0W4=
X-Google-Smtp-Source: AGHT+IHIq5MZ7zI+CvCpPC9De6AvL9rzcS4GJObaeO2ayv/eeplfEyoURrUmmJSrSNHuXDkp7D+vnQ==
X-Received: by 2002:a0c:ac0e:0:b0:690:b2c3:bfd0 with SMTP id l14-20020a0cac0e000000b00690b2c3bfd0mr19944785qvb.57.1710972372022;
        Wed, 20 Mar 2024 15:06:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g12-20020a0caacc000000b0069186a078b3sm6237622qvb.143.2024.03.20.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:06:11 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:06:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 24/24] t/perf: implement performace tests for pseudo-merge
 bitmaps
Message-ID: <a05ad42202d08b419deee5af68e109f10ebb14e7.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Implement a straightforward performance test demonstrating the benefit
of pseudo-merge bitmaps by measuring how long it takes to count
reachable objects in a few different scenarios:

  - without bitmaps, to demonstrate a reasonable baseline
  - with bitmaps, but without pseudo-merges
  - with bitmaps and pseudo-merges

Results from running this test on git.git are as follows:

    Test                                                                this tree
    -----------------------------------------------------------------------------------
    5333.2: git rev-list --count --all --objects (no bitmaps)           3.46(3.37+0.09)
    5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.13(0.11+0.01)
    5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5333-pseudo-merge-bitmaps.sh | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/perf/p5333-pseudo-merge-bitmaps.sh

diff --git a/t/perf/p5333-pseudo-merge-bitmaps.sh b/t/perf/p5333-pseudo-merge-bitmaps.sh
new file mode 100755
index 00000000000..4bec409d10e
--- /dev/null
+++ b/t/perf/p5333-pseudo-merge-bitmaps.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='pseudo-merge bitmaps'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup' '
+	git \
+		-c bitmapPseudoMerge.all.pattern="refs/" \
+		-c bitmapPseudoMerge.all.threshold=now \
+		-c bitmapPseudoMerge.all.stableThreshold=never \
+		-c bitmapPseudoMerge.all.maxMerges=64 \
+		-c pack.writeBitmapLookupTable=true \
+		repack -adb
+'
+
+test_perf 'git rev-list --count --all --objects (no bitmaps)' '
+	git rev-list --objects --all
+'
+
+test_perf 'git rev-list --count --all --objects (no pseudo-merges)' '
+	GIT_TEST_USE_PSEDUO_MERGES=0 \
+		git rev-list --objects --all --use-bitmap-index
+'
+
+test_perf 'git rev-list --count --all --objects (with pseudo-merges)' '
+	GIT_TEST_USE_PSEDUO_MERGES=1 \
+		git rev-list --objects --all --use-bitmap-index
+'
+
+test_done
-- 
2.44.0.303.g1dc5e5b124c
