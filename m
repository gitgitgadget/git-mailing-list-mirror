Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B5F9C1
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760175399; cv=none; b=BaBrl4AWvJOeabLurip6oa8+W80ne83dGSycjLiSeXJGGiT4CvA8wu09wrrNahALkGxbYjKaXA/1c76YAgDwYhrxbKb3FCQ/EKy8OxFUZH3IvlzWdDy7E/rAhoz5mK8NcCLoaRE4OmaupQNYk1O7ikKja0iJwywm+fYP0K5g5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760175399; c=relaxed/simple;
	bh=nXhmcbBZzIluAzg5UwPZLUFosTd2DdruPGlB7EUKNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOMHJCZopMb+RLpLyvmYcPPbPECvA4p4uGtaNNPoXqQnGEFL5wR1SBAJxEB3d83Oz/RfrsmSU5HZWKe8pdAAAE+OVBtwh3/TukozkEreQ32/53tIb5rb3X9/uBVs8Lfpy6Dn4/YbYco2KP6BHBJcjcdWe2uqhUyNZlyuV0DJVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awa47XkW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awa47XkW"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3ee18913c0so435508766b.3
        for <git@vger.kernel.org>; Sat, 11 Oct 2025 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760175392; x=1760780192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ksn4qf2w+8na8x6Hw+JkfEXBbdaYQlufGOGPe3J4FNs=;
        b=awa47XkWasl+qKKfjv1d7ONP49aIhmqf5si92u5MEmwlCW6XyuNdR+iP3mvUoHwVdw
         HNzmIhDDUKTkL8KRE4IQpkCUOXdVSwESHQYVtwQ8EoSfRtCO82aUt3P3JegqldmLdjNd
         /Rr9LT1Pbwr6AMIsXR1jEuL7q/36ewqyZ5QI2oGiKP3D5s2R31Q2e/6XM5eAM2Z97r0M
         VeRymOuRZPOepN4uhzaI3bE7jVXrMlj6uJ4wQcCgLuFkl6+Wk6R804Ak+LVefU4qaYm7
         JiQWhpdElpl7iNoCWScaoe2QL3CB8aTVkXr98+j2ec1HQHJItUlB73c62SCgCEENJybp
         uGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760175392; x=1760780192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksn4qf2w+8na8x6Hw+JkfEXBbdaYQlufGOGPe3J4FNs=;
        b=Kdb37o9NyyjweQM4QuCRAF9cd9mAiLtEkcgiHUonaejHMP0L2Z1ew14qQ8yApzD43a
         9SkJZiX6uDS12iIrYx9iYqKQi2xq1CvIaPLNHhD5Z+mXTLDMvWNLJZNH21S6f+7nxHLj
         B4U6fq34vxrV4EiKXIitHYNvKu8S1fFgLoeHdTdfLeK0XD2bSXkiDCWo+MHGlcPJx43r
         1u4Xq5Z/etwi7iUCSHTmkJTnbLDz7XirGcC4NNSNSVdVC6QmOlK2mFfuZDR4YazdtUBj
         yrIXwX2mbEJZcEjj/fHxA0m2hEYVHjh9/TFAB/psIRvLan/95E466+9zrGuAi6sWJwQc
         VSaQ==
X-Gm-Message-State: AOJu0Yxb3+x51bI76SeROZnMsTgCjZ3iitgA/Nrb6lhnjM4/9K0vBFdM
	Y/TA/dgNuY43vR2mVWdk6qSKckkeRSxL51e1A/2kRjvhdHefYaB8eoG+ulMwaYTsNG27Mw==
X-Gm-Gg: ASbGncu/2b2PniiAGZmB4M5B+9k8IYdCqcS9c3i1ZOe7vpHHArgN/WgnCvY2rySaItL
	m46CRa0kDVQun0wT0eYmLo6y21YLuER9i2bV4EcH0oej7wOfX1AycrQR5wMmfp29oTk6gfkGmSb
	yExrd4xCCZkuWffrM1kH6Ms+T4Avv5P49kJSUPr2RhWqZCPElCIscjfdm4f5uvSyXZhytyOlV2A
	AJa3ovOxTYRYuPkqJIRZ1zhLX3zv/GYeUhcPrBhdUEO6rkU6V7C2UTY3cTrc9ckezQo+9mPWEBp
	otbrRkGHOm4EyCPRi1aMXjvlY1tTd60UTFZHOnOLuNky+uGVcNl5p+I6yplgXnk5yNNSzNIYHLa
	PmQJPyeDemRP4QQkeRkSvJ4ji+s/dshycat2RPbQ1Q7OcLnhIlj7v88Z17PVGqzeqDKQiE0i23G
	UZNFyDdtDDjOkDXEHfd+F/DX30IOm4rWHs
X-Google-Smtp-Source: AGHT+IE5n7Lq5CySgC7UspyWcyL5G7RBlYwprgT1V3QASYhWyIgQksaPhheWMrHiaodn5QkrT9zlMA==
X-Received: by 2002:a17:907:d0d:b0:b4f:e12e:aa24 with SMTP id a640c23a62f3a-b50aa1862abmr1401130066b.22.1760175391565;
        Sat, 11 Oct 2025 02:36:31 -0700 (PDT)
Received: from localhost.localdomain ([105.113.114.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad896sm452063066b.1.2025.10.11.02.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 02:36:25 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH v2] [Outreachy] commit.c: clarify comment describing commit re-parse behavior
Date: Sat, 11 Oct 2025 10:36:11 +0100
Message-ID: <20251011093611.62937-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing comment in `parse_commit_buffer()` mentioned a "leftover
from an earlier failed parse", which could be confusing to new readers.
It implied an error state rather than the intended cleanup before
re-parsing a commit.

Clarifying the comment makes it explicit that we reset the parent list
to ensure a clean state before re-parsing, which improves readability
and avoids misunderstanding during future maintenance.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index 16d91b2bfc..af20ca7c3d 100644
--- a/commit.c
+++ b/commit.c
@@ -475,10 +475,9 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (item->object.parsed)
 		return 0;
 	/*
-	 * Presumably this is leftover from an earlier failed parse;
-	 * clear it out in preparation for us re-parsing (we'll hit the
-	 * same error, but that's good, since it lets our caller know
-	 * the result cannot be trusted.
+	 * Reset the parent list before re-parsing to ensure a clear
+	 * commit state. This avoids carrying over data from a previous
+	 * incomplete or invalid parse.
 	 */
 	free_commit_list(item->parents);
 	item->parents = NULL;
-- 
2.43.0

