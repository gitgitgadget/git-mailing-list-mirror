Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C63921D1
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680001; cv=none; b=WY1F469iSYNIWwDcd52zx89WVtaHTiuBd5YivjS5Hagw/H7Q0tByoYArKTd7k8ruTmFSoqQbqDiQdMM5V3oNi9am1USiL4Kz0Jae++/vEQ4D+qPihyypfXwUof/SG1UMat2oVW5xO4R25NehAR6SMjJIkk7vQ39vl1OtWct8CU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680001; c=relaxed/simple;
	bh=Xg3vvUdf0r2bEgKD8K5Oc0cxjPBASzpfWNcgksK9eQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZlprA3GqBfmmi/o+PEF7gp5oecZPRNPGznNeO7ChjFot6COhndiQtFklu/aJ+a4I0Z9eLwbTXmx6S/n4HRFojqudJVgMEAE+Z7FzkFOtaTpcsHQeb9BxIcZ0Bv5BmDgfruYk4ANoJJRRhhPIq4/JWM+z4rBbkEXNSD48oM/g5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNyHSdu0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNyHSdu0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b23f90f53aso2312235ad.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775679999; x=1776284799; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1pAK0ryeeAXecnEoZZnQkotgHR9g+vtvUR0S01ezx8=;
        b=eNyHSdu0oZ0bhFaimuRt3bJ7+NgbbIdZXATpHVDNeBbI7yOyXv2l920p98cczryo9d
         M7pZ6P4/pv0Hp0TfONMXe8HJylhpVWnGNiuk4jZIfkzLBGZA2STXiGmGiKYecGHYCe5q
         88FJEG+Kv9zWz5PLmMll1W0QlgpSD1bP88i1gcfj4UcHbKVwv5+dADKQ+sEtXWw3tBfC
         aHal7mS2+jhZ/GJMRzjqMesGnhhUNQAmd+RYiQcFmwt9b0AXQ9xZ6R2OoAOvKjzLho8/
         XtKN+daelf6KQCVi3lh1DYxrsng+uDNXe23IfGJvK5LMSqHMcsR6rSAzQZIuHM+rKLQp
         7tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679999; x=1776284799;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B1pAK0ryeeAXecnEoZZnQkotgHR9g+vtvUR0S01ezx8=;
        b=Qj+vPsmlJlY0FcbChHqmcwKEPdszD4OR0vxYIXdLJA6YLLZjrrTiRa2P9MD52bZ1EK
         5jBza5eEc8HU+hS3fCmTgJ8YmgrL1fLe+av0zpT0L9W+aJMQfx/kRHw27lsAm0qz4b7N
         upmAqvnDQMYzJYFprvOWc1OpoAOFdTo93hiM5VPPkjjEcNo6j2IlQNflV2eKNrNRm8OU
         bZOO9qA56dOtP6YxFOoOf3xDs8xIvdfuUxcZhFv88hpRBPxzUcygvBhwRKBkeEoPyYh6
         WJJgtew+p0sNw2iLbG2NqNRG/acnffp7k2HnrvBBnrDA42OwjQq+gL/epX+4jct0aotF
         +BVQ==
X-Gm-Message-State: AOJu0YyijRVuSY8Sp62TCglpwO3fYyAngvi/wwRRMaiCY660z7wbOyqz
	fc14zAPTfEl3az8WcU082E1eg0ITo/fzZ65LuhmN0A/hUPLAxbMe5j3e1moddg==
X-Gm-Gg: AeBDieu9Ukh/VHnn73DmBUmt75lpcyGY69xnbRBNiBNH+O5m6uBt/ccjcyyqVV3ICOV
	WR+W6fv6KiIwTMdRPpJlzBcbs0WJ2cvXcWCv7ajQJNIVG+q9auphuV2K/PVvwGh5Nl0eqPCaia2
	t0o5010Ao3uG7mRsrNkM9SVbbov+htVCnyfI1V+5CIyt3M3mU5+82k6kPopvSRgnv5qBHfEWTCW
	fmjkBFzvxJ1TDk7PgV2PvHU7BgQP7OWUQTxdnWtBMaJQQCocK9SC9aM71qq59agFKTASFtt0IRp
	/bMvanYcvAOwqEUgoqgalegoMY/7i0+UcKPP0eeZVD7negrX/ZdshoIt0M/7BtKzOAWJR08MwaJ
	TEIPLFPdN2VQTFNEOmghPUNUQgDxLXR35vd1jfy+QDtC6lG2TBaXl6oRtr209yh1k+mUgROj4kS
	rRwQO9IsmP6ui+AAQ3tPUgL3hKkIkD
X-Received: by 2002:a05:7022:45a6:b0:124:9dea:188d with SMTP id a92af1059eb24-12bfb7670d0mr13390308c88.30.1775679999008;
        Wed, 08 Apr 2026 13:26:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05a7beffsm14479735c88.15.2026.04.08.13.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:26:38 -0700 (PDT)
Message-Id: <88c68fa89a263a6031fbfc201e930e0c3d9ec6db.1775679988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Apr 2026 20:26:27 +0000
Subject: [PATCH v5 5/6] xdiff/xdl_cleanup_records: make setting action easier
 to follow
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Rewrite nested ternaries with a clear if/else ladder for
action1/action2 to improve readability while preserving
behavior.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index bd8baf214d..471d9567c9 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -303,14 +303,24 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph1];
 		nm = rcrec ? rcrec->len2 : 0;
-		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
+		if (nm == 0)
+			action1[i] = DISCARD;
+		else if (nm < mlim1)
+			action1[i] = KEEP;
+		else /* nm >= mlim1 */
+			action1[i] = INVESTIGATE;
 	}
 
 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 		rcrec = cf->rcrecs[mph2];
 		nm = rcrec ? rcrec->len1 : 0;
-		action2[i] = (nm == 0) ? DISCARD: nm >= mlim2 ? INVESTIGATE: KEEP;
+		if (nm == 0)
+			action2[i] = DISCARD;
+		else if (nm < mlim2)
+			action2[i] = KEEP;
+		else /* nm >= mlim2 */
+			action2[i] = INVESTIGATE;
 	}
 
 	/*
-- 
gitgitgadget

