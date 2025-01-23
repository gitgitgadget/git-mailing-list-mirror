Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADA20E32D
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737631795; cv=none; b=CnUYXnukJN7Vl90KcgQEouL1TXEdGOjgSTh9OfGvMdpoJ6TEarDt8d5uHmhqO5GZnZDwXmSHrgGKzItXAqfO1o+Sko8MGV3Och0HvEbMxAraNU5Yive/l4yBH4zdKw0vUBg9RvtPT4N7pV4UNruLY8Rs5Pom16VoAOnuZJxxj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737631795; c=relaxed/simple;
	bh=v8Qg3svhgiyKGe6ozDhUXjWWt+IuJqFfE8OU/dYATfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm33aaHBbz8haUxYOoTKHS7/dvRNud/9a8eNo4At22UeQmX7/cOacvHZ5erXsPaxAk3nWg8UieG+SiaMFiTLMOFhf0KhqPAJ+02QS15KA0KbZj0UZd5yc4Pg5G8qvlAWQaRalwyGN64KxCiK+5m7Wd/ukzgOFlwU4RQskJR8uLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8gp4XTU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8gp4XTU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b1f05caso11811115ad.3
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737631793; x=1738236593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgFKZMTm2jbYcIn6p+Hov+E286g2p8KW+f3QWxmoxlI=;
        b=S8gp4XTUgbuaNwwpSgmL0qNtR1wCvzsUOnZtY5aubmzGD9Scj8sWC4TAYCpdtOGy7L
         jA6deJGjHziobE0T9r4UxP7Ksrn8cC1kHrqmJMm8mCuLpXlD7j0OIhVkbhUXLFqSKnkC
         atcr5VZvE/idHY1BhLcgHxIsYLnOJLermmPWMTMGMoLLSyGRp63Fq6oPcxY+BbnlMpib
         yOCJybyyWJZ8qCoFjYIvIm8KcTYjDUx7f3uLbqW43qP04DbvGMXsRlLBlxjM8yp02Cid
         6IxdJB1ZgC3ra1WFl9FJomUEe8HJkZxoSLkR83IIZtDHVdHhDvorGBomJ4BtVtyC2sV1
         exaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737631793; x=1738236593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgFKZMTm2jbYcIn6p+Hov+E286g2p8KW+f3QWxmoxlI=;
        b=lhTIFRaxoqI4SR/D9oZds2vCRbZfPuTwtnrSCA3j+JBPcxDdGAOabhJMHh9bRVYVdt
         spn6yBP1Iv+m/bWWm3bl5fRqp8NZw14+11SQJ4OF6uh7m+xTRfThIzc8ElkWefCtruiY
         c2Bv0Q0QDhHOrloRAgO2MwpzRlsW4Ikpy7RaYf5vmsc59U5pxyYmBJtCIbeXc9ZfotOK
         HemlQE0Kp5/P+VOAJSd6aDA+LjDRocFNu6B0HzQ2iB5rkmCogmF7T6OI3jCP1HMIY03y
         /RQNRhiH8Gp71/GVVTiO+J9akVFJhp/c+4XzmkFaWBaocXlLYBELAtJgvk3obVGNgrzF
         ULqw==
X-Gm-Message-State: AOJu0YwTmneBuuBLD8sJ6+QiZGR5VpM2bNV1PiDFmY595qWmPb9gJuMS
	xIPB1aoqzFZClhNeWshe1VlTQxsJpxtHHkLAoMpkmiW4u01d+oQK6agFqitx
X-Gm-Gg: ASbGncsirufl0nooSLWmJ1pKzH00jt0Eq5ODG8HwXN95uTs7X4lTlwDAbwKP62phH8I
	fgLzswTDE+GHFuxDDPgZeevc3FKWv4BteFIPZg0S48v4YkRr4LXFSxkdfzgYBvfOAEclcbmZQlL
	2rNkQaUg+vsTQ5upvOFUnOO47OqQzcWnnYs5sE4FiNZFu4Vptpls4JE4fQ3w1raYVeWUppUB1yZ
	dHel1V0hnHmDajY3pvWoqten8nX5OGogPOLS0P78+EDP1uyX22X911tHtF1V6SPDLZy/H1wTeKZ
	fIizECExdjj/94pSXFxM
X-Google-Smtp-Source: AGHT+IGxMqZtfT+ADeYeP1G1ymA1SJ1vOM7pnd11rus6GZI+elP2xSB7YeFIu6RcWvAzflM9yNE02Q==
X-Received: by 2002:a05:6a00:4510:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72dafb367dfmr34404232b3a.19.1737631792948;
        Thu, 23 Jan 2025 03:29:52 -0800 (PST)
Received: from localhost.localdomain ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f2a44sm12912702b3a.36.2025.01.23.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:29:52 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	nika@thelayzells.com,
	peff@peff.net,
	ps@pks.im
Subject: [PATCH v2] refs: fix creation of corrupted reflogs for symrefs
Date: Thu, 23 Jan 2025 12:29:44 +0100
Message-ID: <20250123112944.3922712-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250122100319.2280647-1-karthik.188@gmail.com>
References: <20250122100319.2280647-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 297c09eabb (refs: allow multiple reflog entries for the same
refname, 2024-12-16) added logic for reflogs to exit early in
`lock_ref_for_update()` after obtaining the required lock. This was
added as a performance optimization as it was assumed that no further
processing was required for reflog-only updates. However this was
incorrect since for a symref's reflog entry, the update needs to be
populated with the old_oid value. This is done right after the early
exit.

This caused a bug in Git 2.48 in the files backend where target
references of symrefs being updated would create a corrupted reflog
entry for the symref since the old_oid is not populated. Undo the skip
in logic to fix this issue and also add a test to ensure that such an
issue doesn't arise in the future.

The early exit was added as a performance optimization for reflog-only
updates, and it wasn't essential to the original changes. As such,
reverting it shouldn't cause any further issues.

Reported-by: Nika Layzell <nika@thelayzells.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Changes since the v1:
- Modified the commit message and subject to make it a little more clearer.
- Used `git symbolic-ref HEAD` in the test instead of setting
  the default branch.

Range diff:

1:  dbb1186512 ! 1:  9326fb08a9 reflog: fix bug which didn't resolve symref reflogs
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    reflog: fix bug which didn't resolve symref reflogs
    +    refs: fix creation of corrupted reflogs for symrefs
     
         The commit 297c09eabb (refs: allow multiple reflog entries for the same
    -    refname, 2024-12-16) added logic to skip the flow for reflogs in
    -    `lock_ref_for_update()` after obtaining the required lock. This was done
    -    because it was assumed that the flow ends there for reflogs. However
    -    this was incorrect since for a symref's reflog entry, we need to
    -    populate the old_oid value which is done right after.
    +    refname, 2024-12-16) added logic for reflogs to exit early in
    +    `lock_ref_for_update()` after obtaining the required lock. This was
    +    added as a performance optimization as it was assumed that no further
    +    processing was required for reflog-only updates. However this was
    +    incorrect since for a symref's reflog entry, the update needs to be
    +    populated with the old_oid value. This is done right after the early
    +    exit.
     
    -    This caused a bug in Git 2.48 where target references of symrefs being
    -    updated would create a corrupted reflog entry for the symref since the
    -    old_oid is not populated. Undo the skip in logic to fix this issue and
    -    also add a test to ensure that such an issue doesn't arise in the
    -    future.
    +    This caused a bug in Git 2.48 in the files backend where target
    +    references of symrefs being updated would create a corrupted reflog
    +    entry for the symref since the old_oid is not populated. Undo the skip
    +    in logic to fix this issue and also add a test to ensure that such an
    +    issue doesn't arise in the future.
    +
    +    The early exit was added as a performance optimization for reflog-only
    +    updates, and it wasn't essential to the original changes. As such,
    +    reverting it shouldn't cause any further issues.
     
         Reported-by: Nika Layzell <nika@thelayzells.com>
         Co-authored-by: Jeff King <peff@peff.net>
    +    Signed-off-by: Jeff King <peff@peff.net>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## refs/files-backend.c ##
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      			/*
     
      ## t/t1400-update-ref.sh ##
    -@@
    - #
    - 
    - test_description='Test git update-ref and basic ref logging'
    -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
    -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    - 
    - . ./test-lib.sh
    - 
     @@ t/t1400-update-ref.sh: do
      
      done
      
     +test_expect_success 'update-ref should also create reflog for HEAD' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		test_commit A &&
    -+		test_commit B &&
    -+		git rev-parse HEAD >>expect &&
    -+		git update-ref --create-reflog refs/heads/main HEAD~ &&
    -+		git rev-parse HEAD@{1} >actual &&
    -+		test_cmp expect actual
    -+	)
    ++	test_commit to-rewind &&
    ++	git rev-parse HEAD >expect &&
    ++	head=$(git symbolic-ref HEAD) &&
    ++	git update-ref --create-reflog "$head" HEAD~ &&
    ++	git rev-parse HEAD@{1} >actual &&
    ++	test_cmp expect actual
     +'
     +
      test_done

---
 refs/files-backend.c  | 3 ---
 t/t1400-update-ref.sh | 9 +++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cfb8b7ca8..29f08dced4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2615,9 +2615,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	update->backend_data = lock;
 
-	if (update->flags & REF_LOG_ONLY)
-		goto out;
-
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e2316f1dd4..29045aad43 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2068,4 +2068,13 @@ do
 
 done
 
+test_expect_success 'update-ref should also create reflog for HEAD' '
+	test_commit to-rewind &&
+	git rev-parse HEAD >expect &&
+	head=$(git symbolic-ref HEAD) &&
+	git update-ref --create-reflog "$head" HEAD~ &&
+	git rev-parse HEAD@{1} >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.47.0

