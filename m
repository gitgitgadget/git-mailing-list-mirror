Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C71BF53
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118560; cv=none; b=LLa7wF6e/wH39l2///lt+9o8mHg8jQv3QAPf9KFh1KZ7ppJo+NGJIQJTTshwRD/wbN0qFJN+Ifhq/lkU6avTUzW3uMmeFfKBtpCZqGKBOfItM41eHRku3b6QkRaSnoTvYJ0jSSZS9xEnP9rhS9zmPTaMxDRJfPMy34n0BuNpXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118560; c=relaxed/simple;
	bh=s+XSX5VRc8C/ePru5am65XPte5gFKITuhFrZxMXMic0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=h33CMavnAGGRy8PekPUn8VDN1V6UJnQ5d3rtrmNSYIxwYs8ldOPjXtmOOzzA2qIpC84UIpL0791Zqw2PJE7HDpRuuHrtWKAXU60cdvqq+Q36fNC2QV8w90Az+uRL1AX92A9vev2/xx21Q9ilzyjZXDlzOmipXUHr7iVkkjw1KgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoJ5sGjZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoJ5sGjZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42133f8432aso8623185e9.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718118557; x=1718723357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vJSCtPDqs8NfocMXHajlE1M3BAJYqCJzEiA8MJYBdCw=;
        b=AoJ5sGjZRhXAFRfyytF0t9QaUahfhHvxg12DbNF/pswYNtTkAkI65gLVL/OmCLbh2p
         3FQFAd4Q7M9t2dmU3BpyFqNmR8N9Z4a5K1ef9aVaHcHMGLIQuNC/n3tgqpIneMnlv6S2
         C7jj1iPNbv8hXNi1Mf69ApddoS0eCGo30y4mnTlzTYzCs4k5ImlFPsI8f5BT1uWAuf42
         715UAwwudTlEUDwE+vp9XNzv2LuaBK2UqhJeHymmJKthP0/Tt+JCf3Bg9Ah4W7mB6PcH
         G00FpunaJSQk9eifn+D0UQc1Zisei5y2qt+6I730hR0cw3b7/TqrhmrWh+en3CVlhy51
         esow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718118557; x=1718723357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJSCtPDqs8NfocMXHajlE1M3BAJYqCJzEiA8MJYBdCw=;
        b=dCK1ZTbRtIloraADxJGvE/r6gsMDE9xxSgLYzZ567XBoO6kMCJBpSgRBg6L77h+Nsx
         p34P2PhYLuMwik7CqZkxlF8i/CVjFW1TuuE5T0ZHomPTtTiNIooMuP2CbLKDCWtgritm
         4DVJqd8EEaKBLNWe0tQmIJzKdECJxV97xo4mtwHGINOl4tsB64dMNFvZrx7MJuaVbskj
         KpgQZNLhSN3CHagvzkYxFycKpv2Z+K5xQ1y88NxYHGUvRU1vNn0lFvqmLA++4Mg7yNxH
         xtdDovnnrNjX/8EL9y0RsZ2DXeOmba4DikO73yjYQTtXDXNY+nDIXy4PMYm3+KYjSOCJ
         BuuA==
X-Gm-Message-State: AOJu0YyNUnQZja8AJfx0pAg2BSGtg+P6fnktWlyXDea1PQ08X5mw9b9u
	7qk5MTQ7vFPgMu6Z9zunXqUs0uRof059xNW5Ej5pwrtBKcc9p0BDh7JcZw==
X-Google-Smtp-Source: AGHT+IGpSpXsjDG3eHQaBEozTo5VMGfgMiHHQdhYJaM3Re33Ux84vyLQ1+vLFM5pavgZJHhiQqwI1w==
X-Received: by 2002:a05:600c:458e:b0:422:77d0:a3d5 with SMTP id 5b1f17b1804b1-42277d0a77bmr5088695e9.36.1718118556418;
        Tue, 11 Jun 2024 08:09:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421b905908asm80758935e9.20.2024.06.11.08.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:09:15 -0700 (PDT)
Message-Id: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 15:09:15 +0000
Subject: [PATCH] commit-graph: increment progress indicator
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
Cc: Derrick Stolee <derrickstolee@github.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

This fixes a bug that was introduced by 368d19b0b7 (commit-graph:
refactor compute_topological_levels(), 2023-03-20): Previously, the
progress indicator was updated from `i + 1` where `i` is the loop
variable of the enclosing `for` loop. After this patch, the update used
`info->progress_cnt + 1` instead, however, unlike `i`, the
`progress_cnt` attribute was not incremented. Let's increment it.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    commit-graph: fix a progress indicator bug
    
    Stolee noticed this bug when integrating the for-each-ref --ahead-behind
    patches into GitHub's internal fork of Git, and fixed it. For a variety
    of reasons, upstreaming this fix fell between the cracks. Until now.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1743%2Fdscho%2Fincrement-progress-in-commit-graph-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1743/dscho/increment-progress-in-commit-graph-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1743

 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index e5dd3553dfe..41a2e1b4c6d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1597,7 +1597,7 @@ static void compute_reachable_generation_numbers(
 		timestamp_t gen;
 		repo_parse_commit(info->r, c);
 		gen = info->get_generation(c, info->data);
-		display_progress(info->progress, info->progress_cnt + 1);
+		display_progress(info->progress, ++info->progress_cnt);
 
 		if (gen != GENERATION_NUMBER_ZERO && gen != GENERATION_NUMBER_INFINITY)
 			continue;

base-commit: 7b0defb3915eaa0bd118f0996e8c00b4eb2dc1ca
-- 
gitgitgadget
