Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEE34FF45
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228226; cv=none; b=jmPK/f41Qyt3kvMeD8bOfwU1rETmaHzzzGGQEWQ3KFTxpO03LeEKY0mPp0gKZIiavGfOyRQuagXQ6tFRN17yb3Mpj8d8offU9l9t6wBziBGtb4Gt7UQN/9HwvSDvmkG3mC2sAKyoIkouxRS+fQEpZsby7orYBzagcjaMZhxhNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228226; c=relaxed/simple;
	bh=rjn9S4uPFxwGpahy9lehBMnxjJlImovlbC7EdM8Py0Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z35fkxVUlEVmhqGRcymZ/WBaUqFqAYyyRINZ59F0kufpCs12svx8eDQrUYXJVJ0ej9zNjW5lLz+WswhXy9+3q+gcJSOCNiUs93vKAfgbS+0/+mUoOLJd1kkbE51Wt9IL6tehYS+Z8RtAxhvk1KaOK+4IzgrIQQ7EuZj0Stz6zfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTb6xufW; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTb6xufW"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50faf8ed9c5so9008241cf.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228223; x=1778833023; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70TF8LhV/nmHtP6Yix1dhugn/uTsr6ytzSbF0QWIOek=;
        b=hTb6xufW5L/QIzAAuZTjyvTeBnYNTdPTHEMlpPxu+OG/ISmMjJHwQSBxruQF6Y5600
         9QotJ7McIKY1IBSqIXNxtW6W8Y1dtE9IawY0DnA1qA4bQIvmTl3CmcsD+Lm8qR6lqo2p
         tS6+V9IuujHpTnDjyHztE7ptsh91rkA5IH8dWSt07NchzwBx5O8W5RuCgkzvL6Zx559Q
         NznjFyo9HCT1RmYub5gNPVE/p1lZxxvVSRny9sc0XQpFaJyy+VaiEDmxtmrxKrUoILRO
         yPe/nTToPNsbc/7WqkrP0qtnFteXHNyU2rAAfcqGuhtHGkIrUpSHmYLNweZZq2IuwX0L
         1wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228223; x=1778833023;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70TF8LhV/nmHtP6Yix1dhugn/uTsr6ytzSbF0QWIOek=;
        b=lasoK7gPyyCtxaJVNnJDzxyuABOdXjYZhk1j6GG+qwzxAf1pVS0JhlLnNBbDWw7N4D
         W8qtcaEBsoy+TmveLscI6sxlo77wNgISI/Z6gDdTMo5uyAvesrqDRSQK6NdqUd1Ko/7E
         rZM3jpCtRm2Jcm9Q6+WP8+z0/DL9QCw2UyLL6LXmBv9ZhQ5iaNKEwQKyjm9fveI6WXVM
         vCeFjSYRKiCcZBBw9SAnVWvVaDWwzE3SNndhyUWnx6i/nYyAM2acZgfhk3NFOw/urgss
         qzkObUmMlv8GhSTT0+ff0twhjds+P/R8fzBqx5PN20DlCs8Cq+k+Hs0tnQE0vn93rZZX
         adww==
X-Gm-Message-State: AOJu0Yyp7svI0CxVuWFxx00i/lV5R0uEABqKPOt9DOznUsc0gngT4vVJ
	Sp/lLDEpZkk8pUoHtYxWL5InGhmPgp+SWP6bix1lE440DvgnHx9FAlwnZjQ5Ng==
X-Gm-Gg: AeBDiesUAmZvLcFzDBlH4iRaBOXNv1Lr3GQrCz8iNV38ADXXhePj+NleV2c+JXx5oDr
	Qdjb166D2d9eft8qV0iFTeaTFHaRL/e/UVznaE44RzqEhSreJAeuqa2QfAH2mQmRMFr3aLlzSJz
	2QpLPyM0BbKluWtT+uYy11f6Zxi2tmbNll6FGZJXS6uUlzSYY70vBWwxOYsvQbS66HTID+p/wYa
	Z40T1qFptzOsjx11864QIJw3VVMUe/yFqEuDQSgCjVHMmSgGqqr+ELHM5SrHhL7pc2ADlfsoYrR
	I3uQomH3AfW+5XlAov1OkkEgcPN2vuMNP58U/qmTBXUj7YXDHx/Go84nyUlpeCsHqf1HVfaS+5d
	tKgGuudDdy/mVb+FFVxxSLICWOzsw/7A+pxlC2RwAIugl2xGqOD2wnsH+436wAaCTiesAafci1w
	nb/vvWWFk+nRrlGyUTiC4p0oFYtw==
X-Received: by 2002:a05:622a:2613:b0:50d:a8aa:8087 with SMTP id d75a77b69052e-51461f9fc6bmr155878081cf.38.1778228223347;
        Fri, 08 May 2026 01:17:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e82579fsm10146811cf.24.2026.05.08.01.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:17:01 -0700 (PDT)
Message-Id: <4f207c8a470af1f8cf00c704043dfa94e6e1420d.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:45 +0000
Subject: [PATCH v3 07/11] test-tool synthesize: use the unsafe hash for speed
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Jeff King pointed out on the mailing list [1] that t5608's new >4GB
test cases dominate the entire test suite runtime: 160 seconds on his
laptop when the rest of the suite finishes in under 90 seconds, and
305-850 seconds across CI jobs. The bottleneck is that the synthesize
helper hashes roughly 8 GB of data through SHA-1 (4 GB for the pack
checksum plus 4 GB for the blob OID) for a 4 GB+1 blob.

Since the helper generates known test data, collision detection is
unnecessary. Switch from repo->hash_algo to unsafe_hash_algo(), which
uses hardware-accelerated SHA-1 (via OpenSSL or Apple CommonCrypto)
when available.

Benchmarks on an x86_64 machine generating a 4 GB+1 pack (2 runs
each, interleaved):

  SHA-1 backend      Run 1    Run 2
  SHA1DC (safe)       75s      80s
  OpenSSL (unsafe)    21s      19s

The effect scales linearly. At 64 MB with 10 randomized interleaved
runs, the OpenSSL unsafe backend shows a 5.4x improvement (median
0.202s vs 1.088s) with tight variance (stdev 0.028s vs 0.095s).

The speedup is only realized when the build has a fast unsafe backend
compiled in. The CI's linux-TEST-vars job already sets
OPENSSL_SHA1_UNSAFE=YesPlease; macOS benefits from Apple CommonCrypto
when configured. On builds without a separate unsafe backend (such as
the default Windows builds), unsafe_hash_algo() returns the regular
collision-detecting implementation and the change is a no-op.

[1] https://lore.kernel.org/git/20260501063805.GA2038915@coredump.intra.peff.net/

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-synthesize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index 3ce7078078..e2faaad7b4 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -217,7 +217,7 @@ static int cmd__synthesize__pack(int argc, const char **argv,
 
 	setup_git_directory_gently(&non_git);
 	repo = the_repository;
-	algo = repo->hash_algo;
+	algo = unsafe_hash_algo(repo->hash_algo);
 
 	argc = parse_options(argc, argv, NULL, options, usage,
 			     PARSE_OPT_KEEP_ARGV0);
-- 
gitgitgadget

