Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC839A4D8
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615787; cv=none; b=XiR6bSuQNJ8C/eNJmlzfKv3xS0Je2XcpkMpUQgCt3LLTtz4aV5u+J4eURj74Nvu3HbB2KYcABpxBVCkmf2ZAmpdycsDioEl3Dpo68oqDBDp3351+o7D3DCRzzpDx1YYLGPxsPeA1zMQNuPPpoTZxSmqoJoRg71gVMKeznawUxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615787; c=relaxed/simple;
	bh=qDUr4PvyHnDTzho6MS04IIpzvc5908AWbnwKG7GtRXM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IhmVLSOwKGtAvIIAcGTDhwE0wd2B6L2DyxWti0hF2vY9KBIcNZZ5JMVKll2OAiZGa6sANmNi1Sssrc98kVtsfzxheZwreaFgA0AWZIVad0aIeBkNFC3gwtPBPjfhzNBGhGKRBWI1uy6vWgcHXJtjIylOltbAoCRaUtdup5Ixu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAjSuuA/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAjSuuA/"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381065a7a03so131156a91.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615785; x=1784220585; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rBJxsHNicIi1hWeD8Oht2inB0LivoFofKWLMSlWiLQw=;
        b=dAjSuuA/pfdS7cF4G7sJRjqPvOLBee74pEu8GQkmpotQzF1BrdO7kB1YGRUS/o57O8
         2UKuiXESsX9O1X5TkdCa5A3+eT2O3e2n4Qgw761oD3jZgyD8T3U4TMk7gpPUOa2AHubw
         Rm5Rx03byrXJ/3nfP9n2aN6ANqO8jG4Dk8aLcNQd1jw676Ue6JjSjGVfItDWaDWnbAH+
         r9JL2UkUF399FbpUZVcjeTUzvoFb7V4qBQ7VHk3iCvKfdlKPFbfO3uVRDEXmc6lhvQPv
         L4SFMRcL0Qiq0aMvSVLdMjZyCEDlc+VEMQXgO/iCrdrmlm8hzyQVuUPdR608TB8ccqja
         SWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615785; x=1784220585;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBJxsHNicIi1hWeD8Oht2inB0LivoFofKWLMSlWiLQw=;
        b=JJcjgPPLN5vdwLIr3RX31VgEBv7cDvN+1ZVoPN88sUb/1fcZm6HuWunKh1TOseXxXf
         hZQ2zhiyuK8veP7rF+kEmpBzXcYWm++pIW1ceJcl9fyvSmjvbDyeqoKIl5o74xzJgXXw
         Exm2WfEetL9KO40gWM/OTMk7yNwX+Y1BFmjrhF2w+nXAhXO8cx0zbPlgYuFuJbIL4U1f
         U7fdrjoG91ryfqPOjMTVz0sEnTlyU0KrWziiPD7NeqKjRUYf5Eo9joMJT1dDbRg9muEy
         Yl5sh5VFoQwf1MvelZfdcgFF1zRIWMLFPaqb4HUaCU+XI7/eC8EdPj4DV2aDup/VVJ+K
         WLSQ==
X-Gm-Message-State: AOJu0Yxye50eZoQLRE8bE3NA12FAK8c0ocxgSG0OrPbi1TaPv30q+J2v
	pA2v4T6jSAMHoM9377/jj3VBYR0mM3T3DLFVkRF4N61+y6L6LVwFHJf4A0kveA==
X-Gm-Gg: AfdE7cnxbvaswgfAWEXFEsEboZZ3dzg++bOl+Ry1H+q8AhntMCX8Bp3ieWAqmuwiJST
	X11ikDoJ/EWAZFaAvTd5BRIAqUjfvyO2qxq2p3Qls0AjirgWKVXvCnxRTYAnYmGmS/Eejo+KIa9
	yqu0YCGpVuzYWMYPdztMXeaqpRJ4BzBr97rPrcKz+rr4AaZ98naSdV+dCO/Vri146H/vBRe0Wq0
	nOlVOJ8nCa2/LX5ZdtsMyG+T/4idH/MoxxxYpEovq2rLhLJ+Iil4ENpS9DN2BlsTpH6TrAKTBBY
	612TiG2ZoA17xPn85uqtSHZFJrNga9kmAuBqZCgdYoByOl3zDF9e9KzCjWthejaNbmbPddHTkzN
	Vh+hQ3lNd/kS1+2aWBkVXChKw4xCyOCBlAY+mJ5EX64yrPMvHiwIpugX582Of1HDLvK54Wj1O33
	R/3q8iapjlaAWvPfk=
X-Received: by 2002:a17:90b:56c3:b0:37e:1430:769b with SMTP id 98e67ed59e1d1-38941accfecmr7945489a91.24.1783615785414;
        Thu, 09 Jul 2026 09:49:45 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm33160375eec.10.2026.07.09.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:44 -0700 (PDT)
Message-Id: <d92a5d4dec8a87c412e9dbdb72285e8f7dca61ec.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:29 +0000
Subject: [PATCH 02/12] delta: widen `create_delta_index()` parameter to
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The sole caller (`try_delta()` in builtin/pack-objects.c) passes an
`unsigned long`, which promotes safely, so no caller fixups are needed.
Splitting it out keeps the `diff_delta()`/`create_delta()` widening,
which does ripple to several callers, in its own commit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h      | 2 +-
 diff-delta.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/delta.h b/delta.h
index eb5c6d2fdb..a19586d789 100644
--- a/delta.h
+++ b/delta.h
@@ -14,7 +14,7 @@ struct delta_index;
  * using free_delta_index().
  */
 struct delta_index *
-create_delta_index(const void *buf, unsigned long bufsize);
+create_delta_index(const void *buf, size_t bufsize);
 
 /*
  * free_delta_index: free the index created by create_delta_index()
diff --git a/diff-delta.c b/diff-delta.c
index b6b65d7607..c93ac42594 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -132,7 +132,7 @@ struct delta_index {
 	struct index_entry *hash[FLEX_ARRAY];
 };
 
-struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
+struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 {
 	unsigned int i, hsize, hmask, entries, prev_val, *hash_count;
 	const unsigned char *data, *buffer = buf;
-- 
gitgitgadget

