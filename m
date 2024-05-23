Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122912BF29
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499649; cv=none; b=J8JzKynBH6/9tTCopM4Qyb+cKv/qO6N4/6zQniC4nEj3avvFs1+v4p69xI6QEtVVDFpWX5Dx72T2GDV9eg8kuHHaPuLnaShaOw9H6fEkj7JlXmgwsG/kL6ur6e3NYY7veSz3WjBf7NMDbZD30v1bYJ58MV4EJoAYJM2aUWNMkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499649; c=relaxed/simple;
	bh=1JlysWEi5+vieexP99dbIwxjrsXiZxm9+0moyQr3wh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcuEaOI2eFNW/F58SdQdSeresrqqW4gX+N9s3FtFBFK3tT0d02p6T/XMqlq+bIU9a1Z41x+IW2h0GXE15+lDy0CbNXt3vyUNsg+Gx1Uz7ZGWbyQEURZPfPQSHYRkQCgeQAoMbbtgHP+VzrlryW9RonZXg03Q3jPqXxERR/3Nsj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=silnn9Zd; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="silnn9Zd"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43fb05b1ef2so1180661cf.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499646; x=1717104446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yLArB5HF63q5EyTyW3jWNMwIvlmnQ1EZW92cuvMM2o=;
        b=silnn9ZdyXiNquQMaL91JKc40wmrONHFuyryikDCBgSZqwHJ3qbhBplZrFzsfP3WHY
         e6zRE/B+LLaSnjjraW54gk9W/QlD56VJcQ19ulRzNP1+gmDMjFiEjd/HUDhuNyCHMsu8
         KK/YgrVU78yoAHy790b6Mu8NBNMPkNQsW3PY9uRiCaaQlgBxZsuFMCcwVM7K4p8Dezl2
         fYT8AKZJhe313/zGAfcQfxMsyqN7lA95OvZ+/ZuEdYEGZ8a3skYLifM7dHqGljI/OBVs
         FaIii+yBEqUlDlOXRTXZetW6BCEHyMZOvpU3pFoAAIGs8umqN+tPb//5ppAQh6Hcx1i/
         X7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499646; x=1717104446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yLArB5HF63q5EyTyW3jWNMwIvlmnQ1EZW92cuvMM2o=;
        b=UYXXFaTmBZyCs9ZI7ETjjmU9Y/XzhJ6gOuzUbvxw7B+70dLYs39zyq9aAx7OWZMjUe
         MpVAKgkEK3r/OYzsEBbTtaWpa3bEyuu0GpSMN3vK997oW3T7UMxzOxGhK59xoo4hJwD7
         P2QPQg9ZGT0dsBZ3otSE79QPBazZZHT8+huuLjDDcyRzt/ixB9F8huDTASWTGFnO4xeV
         WFRZfTLu69h3VBObIQcwCmX9bSDzzcn3WRFaH/sDhOje9GScJqttEyrLYegzV0vPdRu6
         dmf1FrqYWUyNhW1q2o6lY/394WzEdeAdHkiCSEMQdGXKuNlWzaLSeTKSO8wh4CVhLNxE
         FWUQ==
X-Gm-Message-State: AOJu0Yyh+aHfLlkfa3DnOEUm1uvL25Q4/YEzvsLkMk/LIl4Ki8cR/jXf
	Bca8SQaIECMHSHs5rwao1ldDhYusppNNs3eENgEVMi3mf8WsQgStHizMgP19ZtD3j9gf/GfRGNi
	L
X-Google-Smtp-Source: AGHT+IEcNFZ6BV9ZoOk42Gue5MYmYCqhTLTOntbW67nH1NRPmRrKLy7SY0Zh7YHik24h4sZ/bjYKSg==
X-Received: by 2002:a05:622a:491:b0:43a:bcd7:9898 with SMTP id d75a77b69052e-43fb0e74c23mr4264831cf.5.1716499646194;
        Thu, 23 May 2024 14:27:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17f3bfasm601911cf.37.2024.05.23.14.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:25 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 24/24] t/perf: implement performance tests for
 pseudo-merge bitmaps
Message-ID: <cf0316ad0e9fc1ab77f67df69d3dc0abff5b80ce.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Implement a straightforward performance test demonstrating the benefit
of pseudo-merge bitmaps by measuring how long it takes to count
reachable objects in a few different scenarios:

  - without bitmaps, to demonstrate a reasonable baseline
  - with bitmaps, but without pseudo-merges
  - with bitmaps and pseudo-merges

Results from running this test on git.git are as follows:

    Test                                                                this tree
    -----------------------------------------------------------------------------------
    5333.2: git rev-list --count --all --objects (no bitmaps)           3.54(3.45+0.08)
    5333.3: git rev-list --count --all --objects (no pseudo-merges)     0.43(0.40+0.03)
    5333.4: git rev-list --count --all --objects (with pseudo-merges)   0.12(0.11+0.01)

On a private repository which is much larger, and has many spikey parts
of history that aren't merged into the 'master' branch, the results are
as follows:

    Test                                                                this tree
    ---------------------------------------------------------------------------------------
    5333.1: git rev-list --count --all --objects (no bitmaps)           122.29(121.31+0.97)
    5333.2: git rev-list --count --all --objects (no pseudo-merges)     21.88(21.30+0.58)
    5333.3: git rev-list --count --all --objects (with pseudo-merges)   5.05(4.77+0.28)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5333-pseudo-merge-bitmaps.sh | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 t/perf/p5333-pseudo-merge-bitmaps.sh

diff --git a/t/perf/p5333-pseudo-merge-bitmaps.sh b/t/perf/p5333-pseudo-merge-bitmaps.sh
new file mode 100755
index 00000000000..2e8b1d2635e
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
+	GIT_TEST_USE_PSEUDO_MERGES=0 \
+		git rev-list --objects --all --use-bitmap-index
+'
+
+test_perf 'git rev-list --count --all --objects (with pseudo-merges)' '
+	GIT_TEST_USE_PSEUDO_MERGES=1 \
+		git rev-list --objects --all --use-bitmap-index
+'
+
+test_done
-- 
2.45.1.175.gcf0316ad0e9
