Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D57C48424C
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632964; cv=none; b=oy+axhnqhpcFxDpGazynVKz+CjtTmtkT85mVb6kRwXVjSdZIYomzTA7drUQ1fPIUaJOBva2uJbJAXzqiHDaLUi5WE43N6nYbPnR4PCArl8YSWfRv1iF8FI0I+TySmPq825nKInvml5tYUyR4QCQ81VIZhOtvrq127/mydrHjXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632964; c=relaxed/simple;
	bh=JTAut3VAw2pac211Lff/VJMgY4bg2Cq7BHwgawY/CZo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VuhjEMbfnzvlcFk29kpl5vKM0eCw8owpMlfBq09BG7uCxl7U6OB5vW+fwC0guedzwpiWeMipW8X9GW/wSek/b0Zqzo3R0FJwiQtG7rLGLKtRmdBbwHnzUdEDX4WJZ6MYpsIY1uXI28fbuizm4fabB5P/eweKK7xJ39PeTc64xsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpwh8On2; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpwh8On2"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso1030961a34.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632960; x=1787237760; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=No9UgJ1nMZm4YSZxXW11S5ilQgAJMp5gjDDbRnDHSq0=;
        b=Wpwh8On2Z/AEzpP8rLmB14CnSdsRmGrR4d9InbWQIVRlzTlOdbwmlOKYqtS9XcFaGN
         L/LE/gxq7x4XbJMmk7NIuhExHrtk2xWhkF0Yt4d6eH2nN88IxuSJUoug/y2IWsauAHqn
         9RVFfZn3/zl+9dJt9pkmlxfWFJyVtnvuAiXTbsf92rnlYp7eDnwwALUhTGuir3eJ0FG4
         uBsr3MvRWOALGL55i7pMUqB6eaf0lLE8pgZrJPsBXDbZcH8MdP/YPn1G+5lKzQE5KWcp
         mzgWHWuDeVGKVLVe5rIUhKw7W+e4GLWVmvA/R5eFzk8HVvDkda3oTM764jI8xU/x3StF
         WgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632960; x=1787237760;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=No9UgJ1nMZm4YSZxXW11S5ilQgAJMp5gjDDbRnDHSq0=;
        b=SYkuMRC1hCBxWumKmeACpFwOa+n/V73nq0+l0aelvqAaWrZdL4lvCsK5Kyjz5c4C2l
         /OMWQJCznVja+WPQA+RDWHnXKzKEDhsdDlHiHxCJUs4NAv0whB+xga9A+ZgSr83iDsx+
         EnVEnRQBB3X0DOHO752LnKRegjOCyjywrcZVhtxzYTYeuwoMthLtQFklG2IGfzo8uw3c
         y/mMeFGfFLNUc2UZI02J8alAhXnVD0tSrS+f7MZotIFdiwANVh/q5E9qdnBRHavWhXyl
         +j3j3e3UA04mhNaVxHYZHtPXuFrmidD2Aa5TFJKYrZLCTjm79LaMAhsdGgNTh6ZL9aZF
         2E6Q==
X-Gm-Message-State: AOJu0YxgmFyjoDUXMDC88DGWpBeja4rGjYdGowZ4tUm6EvAKBoo6NWeW
	7/Q/Rv26o7VKIKfzJcY+P4BVsVaPtYB90qVvXGJKz8CZg0o+QyD+4vEp0+jyXQ==
X-Gm-Gg: AR+sD11vRRDXEVzqx5F9JZEsjULQ+eI+S2iteQIlKpR3o3GDpFej+PE4yPsZh7JJkpk
	fGgjwlDZdjVc+L2dXkugWjO736tvwdA4O0lPCHqYkML2jir8J4NbAvc3MUY+5ProdSNJm55P0oT
	CNrq2II+wU2jrxO37ojqYAsSsqLwadzP+4hoIW4waVQxlOQzDyEAbn3bYA/NPxk6ObuNsulqcpH
	a74peVQyfZ+q5XJK/mUaU8B4fiK/MLgHXBfzLPhLy3PBJciSh4ZDuMsniTATuYjAax4srMbx+Qh
	er9MiO0NTq4OUKk0TddOqygCovUXlCeW5qOX6PT/B0M74C59D6aZXGSz41lvEx5a+/yiIOBa5d5
	8mMdkLospet3ERS1HeDIcqKDDFpC2RyJ/GBRPfpvKYAJkO6MJXtLl8VP1VDXwsRwqpmPRloMz9l
	4MMM3MpQkx7yJx2b9ZWqWd3r904y+aJvMqy/1s4RlSEX5nKLHTM0OM3vtKIZ434TTi
X-Received: by 2002:a05:6830:6ac7:b0:7e9:da5e:93f5 with SMTP id 46e09a7af769-7f3cae642ccmr2368283a34.12.1786632960110;
        Thu, 13 Aug 2026 07:56:00 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c9e23b85sm2212342a34.26.2026.08.13.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:55:59 -0700 (PDT)
Message-Id: <9850de1a91c826e673a1dd401c84a4c14c15c317.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:42 +0000
Subject: [PATCH v3 04/13] pack-objects: widen `free_unpacked()` return to
 `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`free_unpacked()` sums two byte counts: `sizeof_delta_index()` and
`SIZE(n->entry)`. The latter has been `size_t` since the prior topic
"More work supporting objects larger than 4GB on Windows" widened
`SIZE()`/`oe_size()` to `size_t`, so accumulating it into an `unsigned
long` return was a silent Windows-only truncation on a packing run with
many large objects.

The sole caller, `find_deltas()`, still holds its own `mem_usage` in an
`unsigned long` for now, and therefore still truncates silently.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 97246c69ae..503ebbf091 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2972,9 +2972,9 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static unsigned long free_unpacked(struct unpacked *n)
+static size_t free_unpacked(struct unpacked *n)
 {
-	unsigned long freed_mem = sizeof_delta_index(n->index);
+	size_t freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-- 
gitgitgadget

