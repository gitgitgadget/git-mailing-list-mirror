Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDB3AC0C7
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679773; cv=none; b=bCsGphfOgO/1KPam1zDX7avKbCKAZRip/eJJDCuCH2JzVgCN6TfatyeWx47RazYq+XoapNXKdZcAYkQeJM6c4vLhwvSDvsf7v+1teaEeKw5YJZX40nvNu0i8NP7p94jFVX4bUD2RVGF5m1y+jYQgAz1FyDTBxSMrI+2Hu5NoL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679773; c=relaxed/simple;
	bh=/1oxNXKjAf3E8AQLJO2I+CEyyoNp0HZt5KR60FDABZM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YuKStlEiA5xSIvmITbQToeRX9JkQ1frYrLM+IYzQ6GqHbw51VmRDWN4bjyhmzPqT8erIWrStF4+mV6Y6M7I0tAGRRZrWQRex7OszSyqDnUOp5IgQrXieuCKgim/EceFXPBqx/7J8w79TXc+95DGRD5wvQ207g2Xcd1tmWmVbHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhRsDeJ3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhRsDeJ3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e53581361so37727385a.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783679771; x=1784284571; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NqgZ7AGindYkbpbqTXbhOsg229NhVMKHw5DSLGDH28E=;
        b=MhRsDeJ3mcvHHAcuQsJSlcL5raAzOSWBVWnmmDo/Fh0lNerM77HpagtdGhlMitWpuw
         7cYDaRSxX522PubdioXT/srPZDj9XZSujd+/bwLYfVwoiQj5DROLO50dFNp/2QiFdQGB
         hzE/kmwnEbWWpapcZFjFUpMX33es6TOy2cxOrR5NnHIgTnwEqIpG5IJHHIswCOqpTe+j
         EQDsXMSBF3Citph4Uh6trmR1TlO547C8cZfJiQymGK/yWVxV+x4nOeWf2I9vwxvV8pox
         blT4C9vfhDEL/NGXfbOyAokYLceqFm2BrR5maOAZcpu+FvWPbXtm9bkSJCRAV8rd7d/M
         fiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783679771; x=1784284571;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqgZ7AGindYkbpbqTXbhOsg229NhVMKHw5DSLGDH28E=;
        b=rhoG84OJr7/qde3LQoVUyhODmP71bElIlSvJGs2nf2JyyGjUgrdkjoRXG6ElyVwXYO
         nGqvosJ7/OtHmC6BLi0dG9qUGV7GwuulOFp8LfOwH+PnapndZwJFJ6TsCMdHBZo4XLUR
         NRet+kpoNSmkO1c3fvnFa98mTblwMd+6C1i87/QhmStlzHNyLZ7mcWWWtuuJHh7MxP8V
         8XJ2xb5jSiUrbN5KxjpCXMaSstOKqe493+76sEchDMDR/xRLWzE635Kf5k/Z5sGf32qB
         Mqcgi0sjdoIseK3xI71LowfMVPNLPEUA6V+kNor0XLGfjoyglVVvi30Y/Ps+wNSv6W1W
         b3Vg==
X-Gm-Message-State: AOJu0YxfeCdE0hxiAhzABKhr8dfyEKwjdtJMPlhhXnUSrTkQ67RFdWY5
	K+9gX/hS1Hn6mY9xG2+DbRGwA0ygG4AOzbRos32cve2yEnyUBJ04fVZSdeqWeQ==
X-Gm-Gg: AfdE7cm6Zvle0Pi4bm2BnCAGiMncSDTpifGKNGSgiuWnDXsf3IJn2EX+zfCp8Xp0Sm8
	Al69t1Zc1wSBHLwnveFEywchwU9yBYXKUXqcGkeqXcRsGh7YmlsTlTx7b/ntdxndLRc4CPGXsgA
	5f1gBdTe1gbsR3UgjYW2wHkFTXXBzXj2XljIoMUc5jZ1LZh9uUyqdMjMytv7Zi1XSkBxIhahhmI
	SKvodL7ua9Z8BDZrAfDrOH0t4m3vX0lPoUgmS8XgTJzS5vx+qVyMGvUsOuoFpJ/TWK6voRMpBc7
	50SIxNXdNsJk5ZOTwhkK/RYGCZGLNczu7w50FXQFBJyEvquchwSMcA8Ut/HDhxUrFUvyP1aEOOe
	QYSa1TDHkvBmcvSD/wXLUrTDh0vbwixUbzD7xJwipHocTIj0rJ7Jt4G9Y9R5lpnKJPIzyHOk7CT
	gndW0EQox89enei+g=
X-Received: by 2002:a05:6214:4842:b0:8ff:60cd:8174 with SMTP id 6a1803df08f44-8ff60cd88c3mr92804526d6.60.1783679770884;
        Fri, 10 Jul 2026 03:36:10 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.134.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e0576sm38578336d6.8.2026.07.10.03.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 03:36:10 -0700 (PDT)
Message-Id: <889d0d38bc9952a9f5f74063c685c72c299b1490.1783679767.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
References: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
	<pull.2166.v3.git.1783679767.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 10:36:06 +0000
Subject: [PATCH v3 1/2] t/perf: add perf test for ref tombstone scenarios
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add performance tests for update-ref when many tombstones are present
in a reftable.

The first test exercises the scenario where all refs are deleted
(creating tombstones) and then re-created with the same names, which
currently exhibits quadratic behavior.

The second test uses a separate repository with an asymmetric variant
where refs are deleted and then new, differently-named refs are
created.  When the tombstones sort after the new refs, every create
scans all tombstones, making this case even worse than re-creating
the same refs.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/perf/p1401-ref-store-tombstones.sh | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 t/perf/p1401-ref-store-tombstones.sh

diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
new file mode 100755
index 0000000000..9e3d8031aa
--- /dev/null
+++ b/t/perf/p1401-ref-store-tombstones.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description="Tests performance of ref operations with many tombstones"
+
+. ./perf-lib.sh
+
+test_expect_success "setup" '
+	git init --ref-format=reftable repo &&
+	blob=$(echo foo | git -C repo hash-object -w --stdin) &&
+	for i in $(test_seq 8000)
+	do
+		printf "create refs/tags/tag-%d %s\n" "$i" "$blob" ||
+		return 1
+	done >repo/input &&
+	git -C repo update-ref --stdin <repo/input &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_perf "recreate refs after mass delete" '
+	git -C repo update-ref --stdin <repo/input &&
+	git -C repo for-each-ref --format="delete %(refname)" |
+	git -C repo update-ref --stdin
+'
+
+test_expect_success "setup asymmetric" '
+	git init --ref-format=reftable repo2 &&
+	blob=$(echo foo | git -C repo2 hash-object -w --stdin) &&
+	for i in $(test_seq 8000)
+	do
+		printf "create refs/tags/old-%d %s\n" "$i" "$blob" ||
+		return 1
+	done >repo2/input-old &&
+	sed "s/old-/new-/" <repo2/input-old >repo2/input-new &&
+	git -C repo2 update-ref --stdin <repo2/input-old &&
+	git -C repo2 for-each-ref --format="delete %(refname)" |
+	git -C repo2 update-ref --stdin
+'
+
+test_perf "create new refs after deleting differently-named refs" '
+	git -C repo2 update-ref --stdin <repo2/input-new &&
+	git -C repo2 for-each-ref --format="delete %(refname)" refs/tags/ |
+	git -C repo2 update-ref --stdin
+'
+
+test_done
-- 
gitgitgadget

