Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73A20C48D
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924341; cv=none; b=OlLVo16+bwc0b/MiwzySnGW+zbfmvYGFlQ5nX8HpWK5J2i6Kzeh1FSsj64WLedLDSyQXkrwrmgS1XpbS9btgGR0ChYEz4Zs4oaLL5pT94H7GxDFZQRZG/BG/Dx3XhJBL2OpVFa6xtXuVFqCS8msURf1MOEZkb3i7X2c/oZ5BLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924341; c=relaxed/simple;
	bh=WLg1EMTkCxZMOY0JfGrpXDLhNlQqF6x+XF+yjOKy2bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/20jxU9jA4XsHfHHev5ulHenQ6poJtb556qwEWNprwtFyUq1EicyheQYDPS+9zWK9DEAuls8SXbMuUveCZKlYVKz0VRv1GOjmW75xRtO1Ydz45GLVzCAlZtXGrgm55hsWQRh0EsmmJ/I7WuneZXhT7U2FOTT2y25cMY8yOb9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tGCyAS1n; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tGCyAS1n"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be49f6b331so129010985a.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744924338; x=1745529138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bz8APon2NyHjpYlSUdGNNSSkl4iAVMW3VqT85kMBhS4=;
        b=tGCyAS1ntWxna56NDQGyugoDwFPraoOkQTdddgFwnR0IUEdUSt7hCFFsRpPDeWC50d
         39soLy2pUfAboufXl9hKBK8Wb41Mx+irlF++65kvHqjRlbHIoJ8cfUf87ac8evqmj1QG
         fhZ4osesCLt1uNuDaypPMSfijrdOyt9DFGtHfCj1oZDEBICHAqq3t9PQLCMmHeQP+oAv
         WvrVen5btjdps6Vh+jAPi1SUIMEgpy1e8rFmJpnqxN/SxtejkFxuOEm2CKV0SRyD1nOJ
         emWtgtQCpf8iKmBIlvkXxOo1I8sHe0V1GfeulWjAztQFJjbiTxdvmXyPPKDWxwSZgr6V
         WtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924338; x=1745529138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz8APon2NyHjpYlSUdGNNSSkl4iAVMW3VqT85kMBhS4=;
        b=K4/AeeOBcuvyv6uWAuLVftPj6wJgxwBU1O1Lwxs95BXspem1l8MP81NEAIUPknxPkj
         RLzEVUVljQ5E2iAxULlIeGjWeYTV2wL5NU2uimbN9t7a3zkC/g6RKDb9Fm6nkWR5Vqlv
         kmcssEDYhQCEoZ++Pdfmn4juooukjmpR8BpG3pnuo4rlZA5okUveX2iBMeII4/t6QxLq
         1NOwd5y3Y1FVfkD3V5dgzWTE5XHBikMTJI1qjFMYRvkoGzdQLUwCCAsdPFiYMaqBWO8s
         Dzam9cenFaaE26yQJVxLZPJvVMctn2UCYW/Rd42HeaIgw7m3d6+DNKcbj3Vx2VTXPJhp
         syzw==
X-Gm-Message-State: AOJu0YxFjm8381uuFRFMoxJi/SkPZj3Sp0WJ+MxqJh5gs2lIj27bQ7GQ
	vENvXD0GgKyT8URq3o3moHDyZfwYy4IadcWzTJ0OfElH2fUAKYWdgX+TsUFlQeg+K4RD2pIMjT+
	Q+jM=
X-Gm-Gg: ASbGnctMukrA42uQ7Mz+ye/m3kAu3iD11u3G01cFgy90O6Go19BOGBRpDIVPbexsYMB
	8S0bmmcHdUMKtFSXjDedMoMh6iNfYNcuj1BMgzwaFrxN82SKbyo69WPFI3PwZPQ/0Dei+eDEQQP
	xTaXYnwUlDCjnmTl3rnDuF8ULFWmhYlDhVGlcIODuRJ3IeCDc/Wjc0JsH6g/gyo8YzLBgCcImf2
	e+Jd0F+RvVQFBJU57K8nS7CzJQBhmZR727uGUrdS+EfnfaJWYMbjPtwH3x5qATYdCEgmWjVePEZ
	e754MnSYvQKwnpKBNAJtPNW5EM+e6a7g1D05P+7ej/mHmMHH4T4wkaJOhpvhGbrrZJoEMt4Yrxi
	qE+i6zUkTfK9Y
X-Google-Smtp-Source: AGHT+IEZ3sa3fqW90f7H3SOZRP6EzOc8F0w6hVPNh7YKjXsnQVGyX60I4Yr28zpU6vUMNh35XIYrXg==
X-Received: by 2002:a05:620a:4112:b0:7c5:59e1:f0d with SMTP id af79cd13be357-7c92800924amr55039585a.39.1744924338532;
        Thu, 17 Apr 2025 14:12:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a8fcdcsm33826485a.42.2025.04.17.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:12:18 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:12:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] p5312: removed duplicate performance test script
Message-ID: <51c4604e16c886d888138f2b513e4d3407b10728.1744924321.git.me@ttaylorr.com>
References: <cover.1744924321.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744924321.git.me@ttaylorr.com>

When the reachability bitmap format learned to read and write a lookup
table containing the set of commits which received reachability bitmaps,
commit 761416ef91 (bitmap-lookup-table: add performance tests for lookup
table, 2022-08-14) added that mirrored p5310 but with reverse indexes
enabled.

Later on in a8dd7e05b1 (config: enable `pack.writeReverseIndex` by
default, 2023-04-12), we enabled reverse indexes by default, which made
these two tests indistinguishable from one another. Commit a8dd7e05b1
should have removed p5312 as a duplicate, but didn't do so.

Correct that by removing p5312 as a functional duplicate of p5310.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5312-pack-bitmaps-revs.sh | 34 -------------------------------
 1 file changed, 34 deletions(-)
 delete mode 100755 t/perf/p5312-pack-bitmaps-revs.sh

diff --git a/t/perf/p5312-pack-bitmaps-revs.sh b/t/perf/p5312-pack-bitmaps-revs.sh
deleted file mode 100755
index ceec60656b..0000000000
--- a/t/perf/p5312-pack-bitmaps-revs.sh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-
-test_description='Tests pack performance using bitmaps (rev index enabled)'
-. ./perf-lib.sh
-. "${TEST_DIRECTORY}/perf/lib-bitmap.sh"
-
-test_lookup_pack_bitmap () {
-	test_expect_success 'start the test from scratch' '
-		rm -rf * .git
-	'
-
-	test_perf_large_repo
-
-	test_expect_success 'setup bitmap config' '
-		git config pack.writebitmaps true
-	'
-
-	# we need to create the tag up front such that it is covered by the repack and
-	# thus by generated bitmaps.
-	test_expect_success 'create tags' '
-		git tag --message="tag pointing to HEAD" perf-tag HEAD
-	'
-
-	test_perf "enable lookup table: $1" '
-		git config pack.writeBitmapLookupTable '"$1"'
-	'
-
-	test_pack_bitmap
-}
-
-test_lookup_pack_bitmap false
-test_lookup_pack_bitmap true
-
-test_done
-- 
2.49.0.226.g0e6cae136d

