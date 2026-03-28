Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B013AA2F
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774706382; cv=none; b=FcuEF6tpuQcvGT+vAg6cfK724mmzu5oq/VuYicPgaRa4uNueoDhdRvvYRC6ErirGeBV4N3VedGe6XcFszRv6T0yHVjI7z+cL4Fk+XGG8geuIQ+Ib7c+QsnpUK67U1yb92OMYbAnKvFnSc6Vdmt9rHJQfhpDJQdItQSaAP5pS61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774706382; c=relaxed/simple;
	bh=Wt+BaB14SMYiipIJJjsuFgXyl+8GCev59wxLpmLq/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrHPMyqs8ngCcAqv9DTtEj33pGSg0CuPg6cYUUmtDN+nfb+6SZmsOLDyiJB7j4seoJxk2OerR15e2uWv4qrPQ+zD+ErNA1oFcWA7Z/NfOELOw6+GE5CfU+f9rFsYl6GEgnZzobVhpRTsM+e8uKD9lnPrRq8tjLPij0CHHuupVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/2Z+F8u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/2Z+F8u"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso2220665b3a.3
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774706381; x=1775311181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOxtvvuiPdhSpgInB8HPEf89vrmzsgtehVl8kaVbW+E=;
        b=s/2Z+F8ubUmIIVZ3gXv8xjpmOcCOfy1Zr6y2VbLye6NNs01hkkGNB7kNeYfJ3kN2Xu
         sWkm4B1rDPB8a9MFAma1MoE6FhL3yVWI6nKVrHW4hXj6imrBk1LPg5h1EdmQ/aBsFzJk
         Or58JiuO2fJ2q0r3pqyXysk7EBU6qynfbECYRkDOWzG0APJ7QKFKqOPaZ9W5UGMGA1zX
         O/Bn/vqhuut53DoFm3XO6Pcr8MMq7sS7aW0LnVK6BPxqslKsQFGfiFcYdKe3IGG025aG
         wF5pJoaimF3Y9YXzsdexrVJn7slRzdrQJ/bZkaoboI7LPD2mzvdUOLX+ZnI3GGlSCKj/
         JPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774706381; x=1775311181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOxtvvuiPdhSpgInB8HPEf89vrmzsgtehVl8kaVbW+E=;
        b=ba5nOTcRtwu7x8bnd0vYL/ai7j4Mhu2FvG3Y7pnr/BFjqjLtjI1IGFwgyLpMNm2SVM
         T0axUokxH/a/JBpK2pJLc2PhtMK3/xlX1fdg3I73lgYPhghItbxJOoDFRJSqLf/04Whp
         I/ujGLeHtlYxlcEBd5FKwwY8RlEC3OZSip4Ci9/RgYjidQTtWsBEm/Hop3eeKJlygOMs
         L/28qfTKf/sLM+38oSjNSXNCAXKMqcY3D1avriaIUi6gqeTuomsycmzVAbSKfliEDJzw
         zq+uQgwg72pADPGYXYDLQA0jIxHkPzK35fvK+pgFF7/HWFqLkeaxL8isxdDWXDT6AUi5
         q/Cw==
X-Gm-Message-State: AOJu0YyG7Htk3rgLuMagphwhYFGWn+LUuO2M2AsCbOQuf7r7yzBD7rYi
	UsllJ3AofHonXJobdkA1aH14qPfBBvKQitZCWozc0+2ScCyfCgVfD2L+4ZI3JyvE
X-Gm-Gg: ATEYQzzeJBsNR76OGhPYubQFGaQua3O9pOHRq/3IdLPRbKyE1ImqR+ZjNXxYR/3PKzW
	oHpL/ajMdZtH0AQ7II5qwPsF2gAxjik0CTN2BPlP7o5N/ibmPP+rwz4btww8VfCTmoQu3Kk1hb6
	harTztDDLntgJ5bHyyUJdCVJ4lFfRGNeA6E1hkYKJ+9RXYTPwbRIAMZHgm+PlEOhA4iyc7BKF00
	wTtieE1dDeacFIMHvGBmADNd45bercKbfnS6rYBHAs1DE/u3OJgSSl0pU81jeaBF7gLL3hNZE+Q
	mTgVtO2qZ0qEZxSlnnRhNb8gkL6ZXW/svJnIfWfA2NOPuF1KFlMvHHoavEIVw9tPn5uyaBmVBGM
	sLO1ZVsdsuKyaWm0PFLnSQnaBsBZHtf99N2bV78GGR/izwBF896GzR5ADEI6SoHk3blHCtJLLUK
	NBYv24HGqEf0Iqa8G3rSvJ+uzJK3iz1sEJAJaCm6KAppAllVMg8ejhsqThbIK+sLt2elUjuUxxX
	f71bbKrgg==
X-Received: by 2002:a05:6a00:1884:b0:81f:31c3:2e34 with SMTP id d2e1a72fcca58-82c95d42a4fmr6770757b3a.25.1774706380925;
        Sat, 28 Mar 2026 06:59:40 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca86286dbsm2222325b3a.56.2026.03.28.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 06:59:40 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH] t6101: avoid suppressing git's exit code
Date: Sat, 28 Mar 2026 22:59:35 +0900
Message-ID: <20260328135935.180646-1-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t6101-rev-parse-parents.sh to redirect git-rev-parse
output to a temporary file instead of piping it directly to
not hide the exit code of git commands behind pipes, as a
crash in git might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 5f55ab98d3..7281889717 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -39,7 +39,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^$OID_REGEX$"
+	git rev-parse start >actual &&
+	test_grep "^$OID_REGEX$" actual
 '
 
 test_expect_success 'start^0' '
-- 
2.43.0

