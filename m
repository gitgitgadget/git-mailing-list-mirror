Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7591946C3
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744451185; cv=none; b=JiDJBXs/n5GGJ0/1dPIUfsUyq7P/kwLy+DFGvONT1XTgpiHKxNNwLh1peNXaaW7Fk/ppB/EBWkSjeIaT6L9x2ztLZR5ZQ0kGAMkBxn7Ok7GCwyN9xWTEE4CFipUrUWo3hXbtqdywwMcYVn8fiSu2O218tYDQr4cDsojzyncl/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744451185; c=relaxed/simple;
	bh=SXUgK3dh5cOJiAVpUAPECS60Ksi72bZqpMGGaN7bsgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkyvnRLyDsKHPjvJA+rPlJqueYR+G2Z6Gxrkc8Ri5qVv88En1LKwVyfAsT/o+VKpQY131UCpua7HsgPRUV/rtsz8rf5JXS3lPwGHBQ51j3+8A9QEueWSRpVMljEF9TQUNW3a3pjpF2rZuJInDrVNy05TF7xL8tx10RyxTEPlfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLLMrhHS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLLMrhHS"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso1948343a91.2
        for <git@vger.kernel.org>; Sat, 12 Apr 2025 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744451183; x=1745055983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoXoln2vHJyk9xCbcgjLkuc5IxWNt1Tq38bkeSSAfXE=;
        b=aLLMrhHSaXfal/vvAKaKGgMKQyiLEJPEDJZ3NgznPLd9Eb3PzmkfL1i5GPOOYlB7j1
         oD5bmwEpCFxEWAnLrBARV3DSt/bj55xZvaow1waDVc0a/ep669iaerM4G1NYaaxq/RXZ
         vCjC1gOzu9J1000rFEU6D8jmHoHASNZF0i1ij2k+HLqZfY7aEVBKlZMziR3Tw39C5mC2
         7FfKTn2QtxmM7DPUsqFyqE9e+tLYSSxffjWP1XmKh5HkdWIVc+h77b7H++yQ8kzhJeGf
         oTGsG0jZnDllLIxzUoNey7OCHYYE5Basm7d8aoXCyPCur5HgwGwEKZreUoMJV1VwSon8
         8qpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744451183; x=1745055983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FoXoln2vHJyk9xCbcgjLkuc5IxWNt1Tq38bkeSSAfXE=;
        b=eTYX4qox+Ah5PRddYRyF4pnR7KEoJstWjkQXccNfO+ejH2pHSKEYRjQ+NaL/wd7ZWB
         cpcr1ciP1oJIZFAa7NsmGzTUn6V4clDGRIqGNsTrWDgrgBId525v9zdW+H/KXgYrzdkO
         2yc+5ZArV3pdkgEEi/5fVM17dhp9+EUPaZQ252Sl/lE+h/W/2sXOLIaGN3tYoOUx2auE
         JLEPcCtu+z5AfRX4iGlQDdghdisnJXTWILVFa7Cfqo5RncJr6dbB9gzaEyFOORMyfDHX
         Bhf/hugFSa7GYXQ9yqa+2bJhv+QNpdWnFV0Tdy8Zxr7WHeWCgtfNN4x+NavruF8YUKz2
         C2kA==
X-Gm-Message-State: AOJu0Yx1Og59iOUHma2mdhbeI42V3yq6JbUzcwsmOW6YlaSSHJLXfszW
	p2I2aWhbqQ6wShQPpV5IJCW7YsSRFFmN89+8qkTWWBR11kvkjmr/geKRfQ==
X-Gm-Gg: ASbGnctiWWq2rxgHTDNV8xPZ7G+6aSlPqx1iGiDm8gXqh1z0jyZnNeDSUkG70Bx+Xi+
	OjcRoDqVDkcBOV5tVhYbZ4Ks/aDvG7BrcFM1y4zSC1sJX0nW6GjCDWZI5GR31rG86wp76Kc1s+L
	pgcpKhCVPl4d23qfhKf2aBvBti5Iu1wQLsCIHIZazko6IxS+F4D3QXwaq+AbM30t9pBMSu9h5oT
	nqxuqltXRxpiqAKU81pU4ogrt2r8iPVCtXEzuaElSDdO5sKFk2zoHv5ekH+mUL7O8KHvglo0JJk
	KSLHteRmVC5T3mUh2oCK0oT8B4510pNcgoDZ5eskWF9bearke/s6Fz1+vGxfXc+By00guACyxtM
	=
X-Google-Smtp-Source: AGHT+IGWvKH51LdIiSW92qp6ixdSHB365Zvctf439YJP2XkLyTyamy9/8GwqjlIThgp8FhK2E/4EcQ==
X-Received: by 2002:a17:90b:1d52:b0:2ee:bc7b:9237 with SMTP id 98e67ed59e1d1-308237b51bbmr8208681a91.27.1744451182493;
        Sat, 12 Apr 2025 02:46:22 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c005:b018:5841:514c:af52:5598])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd2ed48dsm6354395a91.0.2025.04.12.02.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 02:46:22 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
	piotrsiupa <piotrsiupa@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 1/1] add: fix handling literal filenames and wildcards
Date: Sat, 12 Apr 2025 15:16:07 +0530
Message-ID: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412094607.236382-1-jayatheerthkulkarni2005@gmail.com>
References: <20250412094607.236382-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `git add` is given a wildcard pathspec (e.g., 'f*'), and a file
with that *exact* name ('f*') also exists, Git incorrectly adds only
the literal file on the first invocation, ignoring other wildcard
matches like 'foo'. On subsequent invocations, the wildcard expands
as expected.

This occurs because the pathspec matching logic short-circuits when
an exact match is found, skipping wildcard evaluation.

With this fix, wildcard expansion is always performed, ensuring
consistent behavior even when a literal filename matches the
wildcard.

To explicitly add the literal file named 'f*', users should use:
    git add 'f\*'

reported-by: piotrsiupa <piotrsiupa@gmail.com>
Mentored-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index cbd82be6c9..0546c00952 100644
--- a/dir.c
+++ b/dir.c
@@ -519,7 +519,8 @@ static int do_match_pathspec(struct index_state *istate,
 		    ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)))
 			continue;
 
-		if (seen && seen[i] == MATCHED_EXACTLY)
+		if (seen && seen[i] == MATCHED_EXACTLY &&
+			ps->items[i].nowildcard_len == ps->items[i].len)
 			continue;
 		/*
 		 * Make exclude patterns optional and never report
-- 
2.49.0

