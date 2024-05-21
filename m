Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBB149C75
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318203; cv=none; b=l8mLO/5M6NA8+iWOZH8U9OtRPkVOIN8GcxpL3fZldQtJmd96VMiFISiYV1bjJmBIaOmtsb8/3kEq19fW+h4W7d1SVEJbX2xl9XRm+CveOdzKKQ5mh1RMFCi7MTajtqErmAGEbJ+ltu1Ugl/zkM8SrfNbRH4Slp7ehKAfAgo+OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318203; c=relaxed/simple;
	bh=/1J781I2ZkQcBClblGKFACa1qEddzLPQ3Ima4SFXNkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bp0rdvJYSrqg+/lDNDJK6SDUrbkfM6vmQt1sMgwLSyL/o8DER1Qh8dAmll25SH3FoEHgm7f3Ck3KqswtZRKLw1JAxOKimsJ6WlSjCKXnSJ7zaNELdwyOU2AbGXxkHx/XdgTlP4/kBUQzU9nY1s1iVHcHeY2ln91/6IQUJ9jEqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mvKt5xYk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mvKt5xYk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b8bf806fso30879185a.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318200; x=1716923000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pJYhTRVWR6lVrJ9L1ix7SPzVX4IgOrcOaxp91LKDAE=;
        b=mvKt5xYk6RYOWsY2O1rVkFmlnu0aQfYlUQw9uR0nuflEVwm1iuPfdQLkx7Kck5aGcO
         9cYyFc4RdB4P8vcJyU7rCouy6MBokskPFiASYKx4PGMJwr/9QxvSzk6zZXYiQojZpDAf
         onM9UT86ns07THnyL1uc1pAx3OcTimcWeAF+NZEzCBQnKn3xICHBEN8l1UygT9HIG68I
         S49SGLVznVAq3CZkc17E3dhrMCwHtsz1q4HpPLy4SxC1A9DqU9/VcOqU5avf/gzSaudQ
         VDHpA4zMLCl1/1FTijex0QfQoGTP9fLSPbu2U61cHEodNuaUUXimDcpoCfmlZnojWEyK
         JqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318200; x=1716923000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pJYhTRVWR6lVrJ9L1ix7SPzVX4IgOrcOaxp91LKDAE=;
        b=viHDOJgrfjyddMVYR2s3D8cBEp1qK2cigjDBwmgo80ZNM5AYRBMVxN8csvDBv1vKF3
         SxHgSt4Psat3oEfHlfBcOwIuQiIl+jlDur+Hai1fcZWQ4OorwyP+ytz2adiD4qjgkV8M
         SlHsMqEloVy0yn7WOsv6bmTolYa1sDc4tIGkci0dX/+bLzhQdrIhQ+8fTR8j2Z+mJYhG
         2/S75RyetBWxwRIB5jYWDUQj1XQPvXXMlhZ/fJQUHDc+VupxsdE0gwP+LS14jODdAAA8
         B0w5ROqIK+G6QppjhEiJzfLs81UnUGcC7rH5NSpS8K16Zyt3iDSP6OwNit5YBU981nhN
         Vb3g==
X-Gm-Message-State: AOJu0YxRhkiArj9mc4VqtDGWFRbJRpobS+8QwLv1zN7A95FE6TQtqCX7
	+IFNPxDsxYhaB9rU8trR+bp6q/fbN3W+1Pay84QhiZ9L7Sykn5HfwAO3/KQeavnsiE+1u3+vJAv
	6
X-Google-Smtp-Source: AGHT+IHgdxAEPkP5Zm9qcXOHQnsaKlyeZ07CMW1rkgnjuyHCkLaUlhXbE3DNBmogtfrOWsufy7q1DQ==
X-Received: by 2002:a05:620a:4143:b0:793:82:ad50 with SMTP id af79cd13be357-7930082aeadmr2149380885a.23.1716318199708;
        Tue, 21 May 2024 12:03:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794724bb95dsm369130385a.53.2024.05.21.12.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:03:18 -0700 (PDT)
Date: Tue, 21 May 2024 15:03:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 30/30] t/perf: implement performace tests for pseudo-merge
 bitmaps
Message-ID: <6a6d88fa512ba344543f5f0df33d5a61e406f3db.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

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
2.45.1.175.gbea44add9db
