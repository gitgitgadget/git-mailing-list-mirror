Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA03E3DAE
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914523; cv=none; b=mjm3+Zb7lobdgizkmPk+54QgFJR1QZQwX5qXjfWC8WqaYUJrguCyZ3V8OPspLBbqlxZ1Nok/OL0oh8PmHV+wrpcwyxIY0NJJAXCpJWSbCQSMzZ/Kj6v2Ub8mytnNsQ0FX+CzpNEbTzvQZAnhvASdKamVmqEfZbBamGgZmZFj2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914523; c=relaxed/simple;
	bh=rjn9S4uPFxwGpahy9lehBMnxjJlImovlbC7EdM8Py0Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p2rLmRTyDiWTrhayNKCVRh7mDgmjEsNZ92ANwTvCDGF98+Rr4J9k8dOXsQEYLgmNaOs+6XBVmWIy7GwzuqG80ySoOExLDnmZWiNrl8NUSmVH83S/g7TjKvXrYskA1qiG8JpoFCl5UWuXu3Ky99AMyxGdLHnhJUzkqt07r/QVWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXJkKqb4; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXJkKqb4"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ec9f099fc6so481048185a.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914519; x=1778519319; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70TF8LhV/nmHtP6Yix1dhugn/uTsr6ytzSbF0QWIOek=;
        b=HXJkKqb4s4g98icePqVZYuR+lFD4P+t6FjKABmkM6XnRqkXDmxi6ksjIBJxBpDQon3
         JJCZ4klmkJ/ze7QRGHTII3RjJI2S0fYrEz9nMqT6L0+iRrYkO+jWAiof9R9tqyqRRMVG
         MJtiKSW+Y4ZVKiIIuszyE5KnPxTfVgdkB4Z94nkEuqglqqZ2GIbiJd/8kC5ZAtc34OLw
         xm+oEt/U6/iMAHvbRTvxqSEWMAOpj+Fyt6dY2WliHABgccvZteShEBQw4CBTpEJsUvGP
         BfnqKiGcS7NW/+7anmpDj2kYokNU4FfQxqYxzQRWO3rDCBr6EBJ1Ik5J+tisqOTwDejy
         j9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914519; x=1778519319;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70TF8LhV/nmHtP6Yix1dhugn/uTsr6ytzSbF0QWIOek=;
        b=KJAX5GbqhYl/DpbCHA/oJfVU5JA020xIw4BqkiWHfx84HRjo54J4kr2AiFwb520hDC
         B0SctxEGgJWSfgAuyfE1pLtzFo+HIbnpFlu/o28AFTVfglAcHj6shuGpibFFw09SK5xa
         OjQwDTqa1w7yorpSqNOrp+KN5dfqOzwFFYeADAnrXcsNOaS+yU6egCPqHKLpcxbRkS9/
         WraxFUcDaB49OZGcn4iKCiUHKeKF0rGCwbCbzgcHxXAuS5lRzxu++9xDgA3VTc45MOIM
         c+0JH0Z8iQ7uwwGWboNeB+RDPRI6aunxDuLCQvSGyQhW5bL8F7setJif9tztJ1PHBnlp
         NkLQ==
X-Gm-Message-State: AOJu0Yxt7Tl4hbDljapnu3zhUqUyZtAYroHbaUU0Q5g3y/NnfmbveJkh
	93BD+qi7jOVXx5vvmkc5HsuFw4UHeQS5EXHdEcExApT5pQHvNYfWyZ/4ef1/n/tG
X-Gm-Gg: AeBDietLiT5W3bC9uxUykuo+8mLEypQQpkaFsJljgJJHYHUzH+wsQVCQkVshxmKR6nJ
	/wfYtPKEv1ieZh6gUB24SNX/6rWjDUTcgnNJsP1L6OR9vcVP8z6ajYqULRi8fKoaHjm5CB74XfK
	UucYQ1/dKABtWT+Sk3jJA3fCPDQxXMm2qLqz7RBOUPr2mXtaw900G62/jtw0yqa7T5zgOTKlM/p
	RWiNUc/OUAnTUgHtv2TWVYRMC4K/Bv6DIeh9HoKY72cbwm/tJiAj7d4HWzLLXd4fFEJEnvrsLOt
	G+LPDxqA5Vmeso7eOn3oMzBe7o7dIU083N9WrNhpttB7MqMHNk4LPf4zuCG4kr4h0zLZyKT/x6w
	VrNx+vXiZER6frMll1IFYLVLkesPgHulfIWPbeJ8uHJBc3Z1Ji+wcMTXZduAnvIEQioqzmoK1Td
	eBZ0C69oOMHZT/BiKu4gdf038akMcvFFEfKeWU
X-Received: by 2002:a05:620a:2892:b0:8d0:26db:4f9f with SMTP id af79cd13be357-8fd168a55camr1600466685a.26.1777914518432;
        Mon, 04 May 2026 10:08:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.231.101.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c807sm1201275285a.32.2026.05.04.10.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:37 -0700 (PDT)
Message-Id: <859e93e7a9f1d5ba965dc2b9891b5885a6c167ef.1777914508.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 17:08:24 +0000
Subject: [PATCH v2 07/11] test-tool synthesize: use the unsafe hash for speed
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

