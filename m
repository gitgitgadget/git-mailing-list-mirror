Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEE382392
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228230; cv=none; b=f7YW+XYOOwAgm553qTlz/K2i4cyIfhKNYJ2qE5JHeaBfCzADhiwxpmKsnt1SGNuNdQZhSseoqb8m+mGEvzJpHYx4R6BGY99TXSvYHqg79/6ONES6HRQZpGgEUfV6/myH702CBvCjtVPz+z790cn20xkCWAfMaUZz1Zs9JKAqpDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228230; c=relaxed/simple;
	bh=XrqegptEScXZEZ4tIqgZeYMz23cFOzFGfQgW7Le8H1E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qz+ml9nUOiR/Vqxc9fidyoeFTDLPnO3Ko4vt3GqMS+WURiVYcxZ+07lhXo7fILEiyHBWBhIqJEvyoblQqW+MccmEraBU3qbFnXT0f++DegnUyswZWgWqgBO6MDXnnALAfuFuop14w21snxSLzNSO4bcTe26kWEszkJFocQGR30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qf6q6WV3; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qf6q6WV3"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ee9ec26edaso191195985a.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228227; x=1778833027; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzfeQKNRFbHs8UYc9tcKAr1Sqop512vg8zVhUqsKnsQ=;
        b=qf6q6WV3BEfDyU/B12DnP5I0dN63R2Rnwl1dcbBoA3klytWQwug9405lyu/h7GpUz2
         gojnACYag27XU2E3gqhuc68nmG37f8hov2K0UtmOakCxyNmCOgVx0iphIyUmvZ9witXU
         1/ANSQhesaAFeuG3ktNKnPNMWYUO9PvZMWzBpG2SrgYtuUyPQelag9HQUJ26wDQiR0Lt
         P7FX593ve8zlBHQu2MQQq3rFWumphobJtXgOakrKYqm7h5o2jXYNVIY6XxElsEhJupiK
         Efuj3mWFuaSs/4Edb0seTTzbjd+UaBHG6bO87FWa4ZRPlxsRbw3ASVya7peVXtjsjaYi
         pItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228227; x=1778833027;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UzfeQKNRFbHs8UYc9tcKAr1Sqop512vg8zVhUqsKnsQ=;
        b=P711Fvk1Vz6HOxvTmwkeduafYLBuq1rdEUpoD6Uxg5MZtLGeNDTFFurjiusgcnsRBS
         3ygNdszd0xX5g2fCkf/7OYjXjZ0FWGe7WUwvmj99VYdnsWWpCFggJ85wcx7jzFuikBnA
         FQaPEucYtOzgKbyQPUFMZ34XjGO54f2zghPtOx89ZiNpvSfK18yYyQJQdGI/S69sQkgA
         55VtK5E6q+EqcYpgHfTGdeXoD/EN4v4JRhCbTvSc39tAAs38vPcLMtBtyObiEelsP6r7
         TWXPMoc4BEWzbikwVdGtSMG9PjYMOtYx6ZFh3N+zkK6El2wgCpWMdoAqkS1MeIEANOBm
         KpLg==
X-Gm-Message-State: AOJu0YxMi4+2XRw4mGjhqDLPd75uHtMqUIMAhbRkX4EPZw1NCgtCdcqs
	nmpCV7lXrSsOugcNavpzhuczNwIkhMzIG8bWCrzwR8mBO9EDSPYjVh/KtchbVw==
X-Gm-Gg: AeBDieuQb50t53i3TL061jFAieH1Gq6rVK9XIryiyapRe21x/p/V8pu2F1Y8Lw1ZMj3
	R630PEPJiNE57oyzBevzCJuXxbTYuEYjDe6uzCKGcnMHd/18JChlI466z3eigglOa/2zOEKMKZ4
	nWifGzFFVOPUPZ5UpO15smbh8nku8nUVEU9qnS24flpEohcmnaUfF+oaJreuHWnVZdNFtUvOy/I
	g9Pz3P1HTZ0tUK2IEf/09hF2aPy0BK43UxN/GYDPkUX3fTrc8rgzHfl9nNx1y69Ufx/Q9u4L9UG
	eoesx/kB9em0W8TFfmAm4fMkU4UwdUeoUYGdOX84sJovTyP7vwjAQcv0a8R13dKlBngvzIXozK5
	A5rpfxJvRjpxnP2Qu2D0KP8mtlzt+Td9ocJNATPKMvouZB0E8U1IXsho0qCND4hkbRLQ9g6EKph
	F4o6Zt5qIubqLBYx9NOZLU3Yl2iw==
X-Received: by 2002:a05:620a:458f:b0:8cf:d9a8:561b with SMTP id af79cd13be357-904d1081bacmr1725102785a.0.1778228227055;
        Fri, 08 May 2026 01:17:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9ea06sm131815185a.20.2026.05.08.01.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:17:06 -0700 (PDT)
Message-Id: <86c09af4f56deaa5ee91eec5ede5e640b46cdeb9.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:48 +0000
Subject: [PATCH v3 10/11] t5608: mark >4GB tests as EXPENSIVE
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

Even with precomputed pack constants that reduced the helper's
runtime from minutes to seconds, the >4GB clone tests still take
200-850 seconds across CI jobs. The bottleneck is no longer the
pack generation but the clone operations themselves: transporting,
unpacking, and indexing 4 GiB of data through unpack-objects and
index-pack is inherently expensive.

As Jeff King pointed out [1], t5608 alone takes 160 seconds on his
laptop while the rest of the entire test suite finishes in under 90
seconds, and the test's disk footprint (4+ GiB source repo, then
two clones) is problematic for developers who use RAM disks for
their trash directories.

Gate the >4GB tests on the EXPENSIVE prereq (which requires
GIT_TEST_LONG to be set) in addition to SIZE_T_IS_64BIT, keeping
them out of normal local test runs.

[1] https://lore.kernel.org/git/20260501063805.GA2038915@coredump.intra.peff.net/

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5608-clone-2gb.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index af93302dde..4f8a95ddda 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -49,7 +49,7 @@ test_expect_success 'clone - with worktree, file:// protocol' '
 
 '
 
-test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'set up repo with >4GB object' '
 	large_blob_size=$((4*1024*1024*1024+1)) &&
 	git init --bare 4gb-repo &&
 	head_oid=$(test-tool synthesize pack \
@@ -60,7 +60,7 @@ test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
 	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
 '
 
-test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone >4GB object via unpack-objects' '
 	# The synthesized pack has five objects, so a large unpack limit keeps
 	# fetch-pack on the unpack-objects path.
 	git -c fetch.unpackLimit=100 clone --bare \
@@ -76,7 +76,7 @@ test_expect_success SIZE_T_IS_64BIT 'clone >4GB object via unpack-objects' '
 	test "$source_blob" = "$clone_blob"
 '
 
-test_expect_success SIZE_T_IS_64BIT 'clone with >4GB object via index-pack' '
+test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone with >4GB object via index-pack' '
 	# Force fetch-pack to hand the pack to index-pack instead.
 	git -c fetch.unpackLimit=1 clone --bare \
 		"file://$(pwd)/4gb-repo" 4gb-clone-index &&
-- 
gitgitgadget

