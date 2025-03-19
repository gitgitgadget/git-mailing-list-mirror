Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D078221DB6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424773; cv=none; b=ITiRmcjQ30saSdSU3B6CwJVMy3Prf82PbqKhreRHaZlqB+ac73UZgLLf/CpT130EbvEiaAX0nxIF20rpmugartM+iMNncV5ptG+zXulbTn/V8VmPxFoYKcflL8iywYLfBUHUjVt0YiXfnapzdNdW9aRrJOEAMjZD3wcG32uhcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424773; c=relaxed/simple;
	bh=Sf7sUzDrfgaX4D0MYTRigJASUSWSFcyRXD+uI/TLUm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDCYMCdc2CSR1TwH27oUt90o1lPL5nBWRUhZEk/hhW+V2JYPdzcBP5rWLYi0LYXpfh99SFx84PyuheXOvVGLXaEWTnk0KmKS49qIM5VuHANd94H9PNnlbuPmQ1ynZXmGe+xDTvH923O3MW7uhXnk5yh+5daeHSFcZnsNtO3gRfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gmweT2ia; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gmweT2ia"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46fcbb96ba9so3712781cf.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424770; x=1743029570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hkadr0ec63dWV1Qj07O2dbQWEVCNoVPFLDaLtNcdHaU=;
        b=gmweT2iaDmoLyKUBYn+GO/cinbL4RpCOLLSE/JP+B4ZdvWTBTYlSaLCIE9l2wzX7Hx
         b4M+DEEMU9TcuG9qycToFL+7p2EcIZuVGUAAxKbkU9ZlsYXjiT8UrqiSQVXXgjcWNfiN
         Nz1CG77IiEDNDOSS5mmwChSrbq/DuAHntuj/NolYnE4vDyVA+xMJJoF9P6jy1gElZ9IQ
         7tWgg8Vweu1DD39P5iEa07CZeQtcraSv3CUMt0hXA9kGtdrHQddXPu4SgYjTzgvQoQrb
         cie1RE/ogR4WwSUQcll/Yh3W+8zPqtEJ+S+UeftjeVhRNtnxB1n1XUH3whzySTFLwKxc
         duNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424770; x=1743029570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkadr0ec63dWV1Qj07O2dbQWEVCNoVPFLDaLtNcdHaU=;
        b=RAU5/46HGfeWDAJbJEI9U+UpCpgsvNQypb7kvreZfb/b0fj6yD98cYq8yrHmnRd5Wc
         QTAvsT7RX82skAEV99LQmGizeI4Jm9tn2sQ4D7vC1W37VT2gYnICyIuXmkIWx/FP/1Xr
         4XNyJHLd2AqjKZhRJRJyb8rGGGVoMc5GR+1X0t/4WBKLm7xDFVnwZ1jklqbfmVlUtM2T
         TP0mkzkMP4UJ46xotN4P/QTbsmgLHnzaIw2jMU3uBrYCUr0pU46250zaokUhy1VX4UHA
         GyecSRavmG5u3d+mYI+rVoTIS/TLqs45AnrO2532fgfs9RxXE+JcTRRs5e44QWK5whth
         OZtg==
X-Gm-Message-State: AOJu0YwYUIOIhSv4vY8VAkq0YL6qVeUcQK8f1ouA5e1bG/6PBjFpCB3c
	pYeU2XwOZe+0hjM27elftgvhZSG7O4/iPtBA6LUlKQ+fI/B5gihIm4CSvbvICWovs21nkRwX4Jo
	5S+4=
X-Gm-Gg: ASbGncvIy7MDnDis7kgdbvrg5w0PIcDHjiq3npufWHfzvKbTP9CkKJAmi0aJppgUyoR
	pvm7MG1YkViGmahrsuDnl33Qdlvo3NxGWamJ/Sk8ezJrdcVLyzZhy67CbaZQZH0Spyz0Md9f/Zw
	f7UOFca4TVbNajbQ1voG0qHp6FNiSsIaPwdLvihiPkBFNlhDsMWEiZMEL85CaEqIpMJjsaQXrJT
	PEoHDl18OZ3zIgTBVLcq4Lmqy9Po8CuPOkgFDorQBh9vLpaIBIgxkvC6fOrKeSJas2nvpA1gC5F
	PoorkOIIOIncIRcA/k8s8VtsQHHVQaBOBbkYhGI2eG88R9V6BwMONCCmcmmvZAu06PR4HzYEN/v
	tBPg1k0sJVGqmhHJ6
X-Google-Smtp-Source: AGHT+IFwq7MIQQGGJRsx3SObmSnKK6knM+1QiMZ/d22VVL/dc0xnhrBx5ViTATBCqXFxDyQ2/yPqUg==
X-Received: by 2002:ad4:5c44:0:b0:6e8:f17e:e00d with SMTP id 6a1803df08f44-6eb2938e55fmr84889736d6.14.1742424770114;
        Wed, 19 Mar 2025 15:52:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade231bb5sm85516446d6.34.2025.03.19.15.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:52:49 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:52:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/5] t/t7704-repack-cruft.sh: clarify wording in
 --max-cruft-size tests
Message-ID: <5e8bd3e66e304f42d4e84ec2aa9f06b82321d64b.1742424671.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
 <cover.1742424671.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742424671.git.me@ttaylorr.com>

Now that a number of new tests have landed in t7704, make sure that they
all make sense and are testing the things they say they are.

Things are mostly OK, but a handful of tests needed tweaks. Those tweaks
are as follows:

  - Use the terms "too large" or "too small" in tests that exercise the
    '--max-cruft-size' behavior. This has historically been treated as a
    threshold beneath which to combine cruft packs, but that will change
    in a subsequent commit. Prepare for that by using a more generic
    term.

  - Remove references to "--max-cruft-size" in the freshening tests.
    These tests provide coverage of our ability to record updated mtimes
    for objects already in cruft packs whose mtimes are upserted from
    various sources (loose objects, finding that object in a new pack,
    another cruft pack, etc.).

    These have nothing to do with the '--max-cruft-size' feature, and in
    fact none of the tests even *use* '--max-cruft-size'. Name them
    appropriately to make it clear that these tests exercise freshening
    behavior, not '--max-cruft-size' behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index cd452040ea..e6e4c2fad8 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -149,7 +149,7 @@ generate_cruft_pack () {
 	echo "$packdir/pack-$pack.mtimes"
 }
 
-test_expect_success '--max-cruft-size creates new packs when above threshold' '
+test_expect_success '--max-cruft-size creates new packs when too large' '
 	git init max-cruft-size-large &&
 	(
 		cd max-cruft-size-large &&
@@ -173,7 +173,7 @@ test_expect_success '--max-cruft-size creates new packs when above threshold' '
 	)
 '
 
-test_expect_success '--max-cruft-size combines existing packs when below threshold' '
+test_expect_success '--max-cruft-size combines existing packs when not too large' '
 	git init max-cruft-size-small &&
 	(
 		cd max-cruft-size-small &&
@@ -236,10 +236,10 @@ test_expect_success '--max-cruft-size combines smaller packs first' '
 	)
 '
 
-test_expect_success 'setup --max-cruft-size with freshened objects' '
-	git init max-cruft-size-freshen &&
+test_expect_success 'setup cruft with freshened objects' '
+	git init cruft-freshen &&
 	(
-		cd max-cruft-size-freshen &&
+		cd cruft-freshen &&
 
 		test_commit base &&
 		git repack -ad &&
@@ -257,9 +257,9 @@ test_expect_success 'setup --max-cruft-size with freshened objects' '
 	)
 '
 
-test_expect_success '--max-cruft-size with freshened objects (loose)' '
+test_expect_success 'cruft with freshened objects (loose)' '
 	(
-		cd max-cruft-size-freshen &&
+		cd cruft-freshen &&
 
 		# regenerate the object, setting its mtime to be more recent
 		foo="$(generate_random_blob foo 64)" &&
@@ -275,9 +275,9 @@ test_expect_success '--max-cruft-size with freshened objects (loose)' '
 	)
 '
 
-test_expect_success '--max-cruft-size with freshened objects (packed)' '
+test_expect_success 'cruft with freshened objects (packed)' '
 	(
-		cd max-cruft-size-freshen &&
+		cd cruft-freshen &&
 
 		# regenerate the object and store it in a packfile,
 		# setting its mtime to be more recent
@@ -304,7 +304,7 @@ test_expect_success '--max-cruft-size with freshened objects (packed)' '
 	)
 '
 
-test_expect_success '--max-cruft-size with freshened objects (previously cruft)' '
+test_expect_success 'multi-cruft with freshened objects (previously cruft)' '
 	repo="max-cruft-size-threshold" &&
 
 	test_when_finished "rm -fr $repo" &&
-- 
2.49.0.4.ge59cf92f8d

