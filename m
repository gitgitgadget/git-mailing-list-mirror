Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46D17B515
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423476; cv=none; b=WyohTYYSHvaqD35D714xR7mnO4se5E2sqDfr6RWnB5eopp6gSQCLAFqYyw4YUTh7jVl3ity/eaiNIyfud1F4PrY15B+p7K092CekhIXf/dt24eMdpTgFI1+PIiL7GUN0bMW6lW3vlMhhEmpDmkEQQavap56nTF4Onb4k1j7OCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423476; c=relaxed/simple;
	bh=CV1DOlc9nztiU3u0j6d7RQWToUVFH1YonGGXHuRhH94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMMsj6EICtek5AUrr1Ssb8hO5lyK0tXTZVsvxfK8q/fWBEvYbGgXbPk8HpBlhFJ/+DfexCpaAEb674DVYgYkzDmGzEQhiO/Qrp0JyyujdQpI0kIs6SRmVsLRkLhzpk6E6EvG7m4u4sHJAQOrkg3nrlOvDVponUrdoxJQuIYYkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hscL4oGl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hscL4oGl"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-439656c1b50so30204551cf.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423473; x=1715028273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JL0Kf4HGUwy/IQMtp/3ZaD2qeBJ0iAlE1x8LJAajc9M=;
        b=hscL4oGlPjYOlaJYwZcLwmZP24Ei3VR11PIHZyDnndr8b9Oz/7i5tavhM7Q0p8wazu
         TVwn2ymXRbhqGFXhx9HQ/mc29CqYlzp//z0OKAXDP2Nm7pEr8ITGABmFac7sv2aLtmGN
         R70uRP/+U7puzpyrwmQx4ZayLL/U0I/z8quNo6twx4UYgBse+FIZ2wRnSBaZVAA1XHD9
         JxeFkBYBQ2OjiJOQJ5JMhpB9gEg+o9QFtilXSlonFJFKdwLVtHAK9V0kSr4VSD8kfDMj
         9rcYKmTHqilPsGqxOL1yxJVV+ijJChZYejR5fhmvN/vt899pEfuoFIrsK11A52i/24V6
         +iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423473; x=1715028273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL0Kf4HGUwy/IQMtp/3ZaD2qeBJ0iAlE1x8LJAajc9M=;
        b=XJR1gJEmmM9kQkYkLR7m8BhKIlFDP+prB1scbo2JDXYDUKBo6xd5GhsEMF5NuNVouI
         Prpq4f42MaJDdWiOLGbor5++dekeBkwZjUc9a/y+BzcZzD4rMFMbDo0osJqbnU29BO8g
         A25rjMWIrYZMFfrGBmn0ZCNgOiUrdd1uUZNeq9Le/dQHW8wqFbxu45txMXGIP80Wl2eL
         OSEXLKInb8yKLoeuUsRE3jGlgi8KbJdKXvE+cDwk9uaDRmAASUT+LJTjXvPhOWjpJbet
         TL2IaNh96L3H2VhNjFhfjaT168nzZfC0l+hI5QW2mMUsrlK0TlXJd+q01wGsxZ0HH2FU
         47Ag==
X-Gm-Message-State: AOJu0YzFOjUQZOlyi1hq4LaMjREx6y8ByJPZYl/Z6qyxFgczQdxaXDOP
	e7/HwVkljof9s2/Xc9k7GI2yg46us6MeGjLGz5Bv1uaC+zggfpBRR6lN5Oz+e/NfA5/nQzQqjxn
	GQic=
X-Google-Smtp-Source: AGHT+IGxRqdKrAa9mnm381JmU99ql3wrJDp8+iBDCXkvDcnAPCU7zYRWYDxkYoFMsG94/usoUBLD4Q==
X-Received: by 2002:ac8:7d4f:0:b0:43a:c878:d7c6 with SMTP id h15-20020ac87d4f000000b0043ac878d7c6mr693082qtb.66.1714423472809;
        Mon, 29 Apr 2024 13:44:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x25-20020ac84d59000000b004343f36ab58sm10803823qtv.81.2024.04.29.13.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:44:32 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:44:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 23/23] t/perf: implement performace tests for pseudo-merge
 bitmaps
Message-ID: <2bd830d35dd79a7b1201655df70fc0039cc44d7e.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

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
2.45.0.23.gc6f94b99219
