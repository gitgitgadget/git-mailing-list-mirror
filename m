Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA74F15D5D9
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886636; cv=none; b=aHpSnrz6ciAxh0aJn+4NNJIxbEXa4pQkL5aJsduKiNlBEZX47jb1YdKQEjtHhVDTSAg6c0jXnyE2IceLnL9YQRxGGvYUNR867HhPEIta1wmRFjEKabimSugXtkPrBVvU108mDvnaq4aDoIqQIBUFBCjoD+hKAsTG2zybDa3FdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886636; c=relaxed/simple;
	bh=ELg9exsF0wGGXAksFt898911N9rjXuEf/dgd+1xLrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BX8q1RELbllC5Y4edC0MHqnDVeZRSbNdECTBMB8JNwUA0f+F1qfXUoWqQ0EfQW5inaiI3CWSufKCRHi7FyvotB7RxnUeaV5r8dHYg2QEkNUmdyvYzTswdJpJsy7UHpOyafHN2LYC/a9VjiRTpdJdAlYCNrYhKt9eprlhK5hdrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IfUmbV/8; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IfUmbV/8"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03caab48a2so93219276.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722886633; x=1723491433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTKQ1jsmPhE5tRu2IPmtdAcvqHxPUsbiqFe0O8n4b04=;
        b=IfUmbV/8/FPFI/iSd/KwqfEGPr/7yX7Yyn2Kv5pHQQlocmsKWU7pvUHcHD1Uq43fBr
         9RSPzrTWP1YplehHqGoWgJyiJMJL9gLM4pPXOLh5LSeHFb+r/3YnhI+zKVeYulNrKz1q
         V8nm7XYSZXoCLMRvqYz/C1wL84gXL9oFLmAggqJxUargKYXRhRq7E57lBHEew38tUbAH
         KR5capWJvuBXVOjAPdwAu8Rc1N5xpnUV745cM8ZmzQGSvjMIJfvOC6H0EZDtgeMskInf
         qOwWyFRCjpdzwH8m/aUhmIyrMi5qLZZF8LiWF5yCF4anYi2LWTRTp0LDlQwLop3JROuQ
         ymEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722886633; x=1723491433;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTKQ1jsmPhE5tRu2IPmtdAcvqHxPUsbiqFe0O8n4b04=;
        b=aqiAdwbAEMXFLalswOJQ4KHO7Uue1MQYcPz0OEhzI2n/Dx+XlI0xINFHunPw0vaHVV
         23VfYpHNFCsxD4vy9LHAeeqIo7elurvpGgOad3VweOqQvbA4k6zPQO0r2ZRXqCGX/6gQ
         Iu6mjzoXDYffyltSGlwELabnlDmuJcnXCeGS/+9rou4/7pFb9UqXf607L2Mi7liQAC4W
         WBoIS8qVfD4pVfhN6UgVebFZokll556RYYyv3nLgOapNLlRNolUUdAc5NETCCMxMwR7X
         dM9qfUNqq9gSwhYTI8yFbrm0KxYanughIkv3AfEo3I2kCxNzKgd3n3kep3+Xdk74qn5H
         XLVQ==
X-Gm-Message-State: AOJu0YyM92Gj5bqPp8dTWk003i7F7ZuKgAVRc2kt8gPj3eTMqd0ynPR1
	YAk46XbkXyxfuWaBr7YW7fDaZYr5AXlQz/8G2OIXlFTu4aNbVF2JLWeWMjnRFkEsa6gtHyo6Jpp
	p
X-Google-Smtp-Source: AGHT+IFvLJMSbVUl4Dy4qgAMPwpVAi1NSLu+hTMG7eiIRzWm49jr17xSijVhsfoGl5I2rKeLEgSbpQ==
X-Received: by 2002:a05:6902:1027:b0:e0b:b534:d790 with SMTP id 3f1490d57ef6-e0bde8e9400mr10804953276.2.1722886633325;
        Mon, 05 Aug 2024 12:37:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be5323ca3sm1451861276.13.2024.08.05.12.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 12:37:12 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:37:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/t7704-repack-cruft.sh: avoid failures during long-running
 tests
Message-ID: <95cdc30bad38f464b37e87d78f38e1d91c9e083b.1722886630.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On systems where running t7704.09 takes longer than 10 seconds, the test
can fail.

The test works by doing the following:

  - First write three unreachable objects, backdating the mtime for a
    single object ($foo) which we expect to prune.

  - Repack the repository into a pack containing reachable objects, and
    another three cruft packs, each containing one of the objects
    written in the previous step.

  - Backdate the mtimes of the cruft pack *.mtimes files themselves.
    (Note that this does not affect what is pruned further down in the
    test, but is done to ensure that the cruft packs are rewritten
    during that step).

  - Then repack with --cruft-expiration=10.seconds.ago, expecting to
    prune one of the three unreachable objects written in the first
    step.

  - Assert that the surviving cruft packs were rewritten, object $foo is
    pruned, and unreachable objects $bar, and $baz remain in the
    repository.

If longer than 10 seconds pass between writing the three unreachable
objects (the first step) and the "git repack --cruft" (the fourth step),
we will mistakenly prune more objects than expected, causing the test to
fail.

The $foo object which we expect to prune has its mtime set back to
10,000 seconds relative to the current time, but we prune it with a
cutoff of 10.seconds.ago.

Instead, set the cutoff to be 1,000 seconds to give the test much longer
time to run without failing. This helps platforms where running
individual tests can perform slowly, on my machine this test runs much
more quickly:

    $ hyperfine './t7704-repack-cruft.sh --run=9'
    Benchmark 1: ./t7704-repack-cruft.sh --run=9
      Time (mean ± σ):     647.4 ms ±  30.7 ms    [User: 528.5 ms, System: 124.1 ms]
      Range (min … max):   594.1 ms … 696.5 ms    10 runs

Reported-by: Randall Becker <randall.becker@nexbridge.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 71e1ef3a10..959e6e2648 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -330,7 +330,7 @@ test_expect_success '--max-cruft-size with pruning' '
 		# repack (and prune) with a --max-cruft-size to ensure
 		# that we appropriately split the resulting set of packs
 		git repack -d --cruft --max-cruft-size=1M \
-			--cruft-expiration=10.seconds.ago &&
+			--cruft-expiration=1000.seconds.ago &&
 		ls $packdir/pack-*.mtimes | sort >cruft.after &&
 
 		for cruft in $(cat cruft.after)

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.46.0.46.g406f326d27.dirty
