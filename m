Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B9493D59
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816803; cv=none; b=f0k4Nl2LApK0u5XpsNPw42uR5EDZ53euf/RgdGvoDmHZWkSkvmZyEqLoIm1sH9xPXgkNCpiuRwZ+unKgUodhfZfQYmKXRU07krHjhz4VzAiKJUMu5QBLAvnY60l8NkKATXrrjt/c5ej5D0SCOK5maEU+y7lXVoIA/xezcUADfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816803; c=relaxed/simple;
	bh=OcdlyK3TuUzmg68OFwK/pSyoKckregvMngci+vbW0IE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pm4FlxwyzC/zr86R4QA6/ib1eHsWnaH/F/JRZoy1G+aNR635dhOW527sqTzZ4ihHCgug+conOLd93RIdDNy9YD0pJrXtzEAaZGrpkueJGypf1Ci+tFh5VIRYXLy40AiV588jNb19bhxRGYONDD2ziUlBseypL/HXX7ZprEk7YCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJMI8c8q; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJMI8c8q"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-918f75a68f0so36084016d6.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816800; x=1792421600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
        b=lJMI8c8qcUmfS4qzdeRxW6PNDmC+5nczW40jNfL6QHZKav6aS8vjcsZ1U7GRasKa2K
         XfUvibBFk6TOMN5QDh7yqG/Ns64Vjlgr+cF7QwJYUuoY7oqsywxoZZlLunRU8BbcEvBW
         QTz7dAFCwCJr0G2MTNldBELtJGYZPfHFvzOwb4pd9CNthVy+225GgtcyzYLvRup2MKTQ
         ULXF3x76Eg5O9cKhYGnY3DW7FCzZDG7m+L9xp+vaVQKVcBFLgcx1UzIx1mSO67u2E0p6
         Df3cNZkTI5EcPrYTLzW8YtM0+vAnS+Iz8fdUmyKx7C3CGiRg6uuPFg0PCJHJC7jTgiTN
         Yeew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816800; x=1792421600;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVMN4yYvQBwSe22gBPvAn84Cr7GNBJBX2Ji9ZZYVwMo=;
        b=qFPd2Rt5odstECWt1VrnMMlBe+Z36iHMDu8UxyFE7W30ljat1NT2QJ82WsvPS17cHe
         yViIbJYvC4noUaxG5JgfK8uf279Y96awCHpsFUgZfdfexmL5GkmDhRnGnbYlp7z7kY1r
         l+xYlXsHntPuCPPr/PA/P2WrUAOrsQH3f569obuVuMIhk90Evxm7vfQ/rUsNtI7+RRcV
         Jz8kOGP6qheHZ3R+LbEtxzvEGxMQuQX8uaQpgFvSBwzPBPaiLhUY3VDoRlEls4Uxr+B/
         Qgf2V3oSgTQZGWH85Bvk3Z/lPQ9NTb9zthWdaNXsAz0qMVM+cQphF053FkXcP3z5e7cw
         y8fw==
X-Gm-Message-State: AFq9FYI+sQQhRT6bAyixCvwbgeczoW46Wijoft4fw7G+DUxDNuxOsJlT
	kAL/j1WwiMH1YaRdqFCLNqzD5DPBQAtp3PGciSTH7lkTrwUz7drRd5Df582QujNm
X-Gm-Gg: AYBFou2TpBkEBwdoVHCB4jx2bFFB0vOKiIXRE8Qub/GZiY8LI9xrfHhDsXQrU60uKgb
	Qnyfztbf+KJwoKOI56RmLYwn/WW1otqNUYWi0oTFTrynfuJGX4Go+DXThaqBJSPWmE02wN71hhi
	vWuUaQ0pwxXvhbp9Dk/vBagiwNHwsjY+b8OdvajMjdj/8fEcn/LKv5EwPXdWY7DzgWeT537OIoU
	SBoAsxwSodZwnfffytPiRMvyiSTCT3DnPA/2UwNHMi1aF0tRYxHbaATZkpngy0yk0njpNrlrtLS
	TqUcmdXsZJSr9+0Wix6qolkAmt3CAYf643VQ9QylDkHBamPS/zgwesT3rFgA4bzvA8Mrtmjji83
	wUx68N8wJaCfUZt21b72HQV0Vtg6pLCTEGko9tu9qE7Sxgrfq89ZoaTeiWKGRmHvohfpFvX4MGG
	w4JIVI90xqHyMAYjpEdUxgCdDOA8INI2H2aQFF+8veY7zrchBztfbTl6a1c0b0/rbobYx0Nmsn
X-Received: by 2002:a05:620a:608d:b0:93e:c12c:f13e with SMTP id af79cd13be357-93ec12d067fmr1652363985a.72.1791816800397;
        Mon, 12 Oct 2026 07:53:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef508c857sm1985885a.38.2026.10.12.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:19 -0700 (PDT)
Message-Id: <85e117b070f955e2fc828a76221ceedc64075f85.1791816795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:13 +0000
Subject: [PATCH v3 4/6] doc: git-revert: link to new merge conflicts guide
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
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-revert.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
index ffba365e63..bb0f859f66 100644
--- a/Documentation/git-revert.adoc
+++ b/Documentation/git-revert.adoc
@@ -31,6 +31,10 @@ both will discard uncommitted changes in your working directory.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+Reverting a commit may result in a merge conflict.
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a guide to handling merge conflicts.
+
 OPTIONS
 -------
 <commit>...::
@@ -162,6 +166,7 @@ include::config/revert.adoc[]
 SEE ALSO
 --------
 linkgit:git-cherry-pick[1]
+linkgit:gitmergeconflicts[7]
 
 GIT
 ---
-- 
gitgitgadget

