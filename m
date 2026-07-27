Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C701042BC44
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172511; cv=none; b=S0731vmf9gYIwAoIB4N1OPS3pJHysXBBTbJCTD91eNDA0AJZoLxxYBAb387v45zvz6ACe10icYiaQ+vztkSQhjCBm+uEwJePlHiMi+7LDP5FPowePg6P7U+ecGJnu694T2RFilYDsEyqfT6AwFToBYRQ9F0nAwmHv0MtLUSa/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172511; c=relaxed/simple;
	bh=Ti9q143KZbc2ZB8pvhp3TjkICRAZcMW6tGDeqjb6mho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUaTfMuQ0o5cTIxfuUjxCKGPLl2XTKGIaoE5yznCOTLpX13scG1MIju2y/Cc7VwKZePEqNX7npt87vUkDOKPYU3vr1+5z7TGAyTdbgV8ynaR8X725MVnLITof8rnX8NSVM3H1Wke/SAlOaFURq/z2bQmJMyMeSL89aKY+4/j3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD6F25mD; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD6F25mD"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80e24970f1dso18900747b3.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2026 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785172502; x=1785777302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6SL0woMH37cY6FxVwTd5OgL9X+RIYNrTg+towpZFvdY=;
        b=eD6F25mDLI6XkDSDFWNYQ6vf/8iwa4wYif9HlTr27wcqSOpRpP2iudF3nlX0uAeSfz
         3mAoJxMwO9i0ZwgnhCjW7YGb9mSSBI+wvO3m7Li9C3KOTu0cf3cBZl4l8GGFQjskQzMx
         z3zoBR1OqC19+mZBvNaGzjHshwou15LKfcYNgDbOuCmFYdx1HRue6Di8K+6FzF+nG/dW
         U6GfwRc5FQrHje+EJdB20LapPCZosEcjgdyUv4EYz1ikyDz4ikhWa5LYNeatFZ65Psb6
         T1vngCWMgfMGRB8XouZRbDzNB+b17Zt+QTJROeg2J2SnUZGsoiRdibwTRs+/iF9xQQ5U
         zbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172502; x=1785777302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6SL0woMH37cY6FxVwTd5OgL9X+RIYNrTg+towpZFvdY=;
        b=SCw+bccLXNPSCazplgNFyCWL7+6Ua3GFtxL+Ucf65LxDNKehyvt9CfGLTMNMw6b6os
         E7zv0sZ8vE69dJlb5JAkpc71F2JukvjCvQ2WsQfp3XZUZesxucPoox4idJ6YzAADDrBf
         NWVESlPq0fWR1MCqQdwDwOZsZNdwPgg6wTnRFBw/R0UeL44U++tPTZ55O5pWTTUeoQgF
         xN/C12qs32utMvJ9y323SsN7SgZnX4hQ0mSXOUKFA+GyThrN+0st+UN0IOWxXzdu/W1g
         sQX7mLCbJsV0pfq7zgriHDJwwkW3OJuDvlyVfi4tfF9OlkDF1gUOyXHIrTWuB7GZUw6c
         fx6A==
X-Gm-Message-State: AOJu0YwTv9FV8OXY4CWv/p7rvKV+1+cWZ+C3Ff4yCXbwFqaxwRuygFpf
	X8ejlDhgd0X8VZ0pk1zI/Fo9FzlAgRixRaWb8S41nzsVv4VXy99Mhk8cGKM9gevI6xc=
X-Gm-Gg: AR+sD105WzgLGySQMgkPxh2h3YfHb4MAeKjFE+8eYC4Na5wT/2c5C7lE95L97f8SCj/
	9wB2UdJCObzsllzE1rhYHcUNXvifhQseQVaH+kmAcKa3/EtgbKk+fdwBorw2MikeyFUNN12e/bH
	GSSg97CB+fkuOIWjcxM1PJcSDCqWPgpRi7Rjzu07Rbj7pfN+MqELKt+mrx24H461t7kTt0BSy0J
	/0UGsJ/0WsFS5ImBNGqvpfxwwwVkQ8lSrzeyaGz/dN9D2ZemmZU3o4V6mW31zSeB/5aMZqlgy8i
	wvLnP6KaqlHzrHyJ/WGM69qJOu0XRYKwJeKqhV+aeyW3xx+7gLYxKtte7PoBCMgfZI4lLWh+g5R
	VOz+owfJ0PQag0YP6XJwhyyUHLFT0jiPIqgZOvn5T7lO0K43VojKRGshR/FQMFcsa9vLdBYjjuj
	u5UUB15rhG1x8Zazc5CfobGAQkSHJeVGSkRPCauYSnfev1UDCl
X-Received: by 2002:a05:690c:9a8f:b0:81e:685a:2f78 with SMTP id 00721157ae682-81f69e2e736mr29670657b3.43.1785172501726;
        Mon, 27 Jul 2026 10:15:01 -0700 (PDT)
Received: from st-davidlin1 ([139.45.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65932eeesm34832997b3.48.2026.07.27.10.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 10:15:01 -0700 (PDT)
From: David Lin <davidzylin@gmail.com>
X-Google-Original-From: David Lin <davidlin@stripe.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	David Lin <davidlin@stripe.com>
Subject: [PATCH] pack-bitmap: handle objects at bitmap position zero
Date: Mon, 27 Jul 2026 13:13:31 -0400
Message-ID: <20260727171331.21088-1-davidlin@stripe.com>
X-Mailer: git-send-email 2.54.0.1783223981.geb76c99f7f.stripe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`bitmap_position()` only returns a negative value when an object is not present in the bitmap index.

In `find_objects()`, we have added a check in 11d45a6e6a to avoid processing a root whose reachability is already represented by the base bitmap, but accidentally uses `pos > 0`. Consequently, it never performs the membership test for an object at position zero.

If that object has an individual reachability bitmap, we unnecessarily load and OR that bitmap into the base again. Otherwise, we add the object to the not-mapped list, only for the subsequent pass to recognize that it is already present. The latter pass correctly treats all non-negative positions as valid, so this does not change the resulting object set, but an off-by-one edge case.

Treat position zero as valid by changing the condition to `pos >= 0`.

The existing pseudo-merge traversal test exercises this case. Its position-zero commit is presented through multiple roots. Before this change, each occurrence is counted as a bitmap hit; afterwards, only the first occurrence loads the bitmap. Assert the resulting hit count to cover the boundary condition.

Thanks in advance for the review!

Signed-off-by: David Lin <davidlin@stripe.com>
---
 pack-bitmap.c                   | 2 +-
 t/t5333-pseudo-merge-bitmaps.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d8dc4ae8d1..e85bd69ba4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1569,7 +1569,7 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 
 		if (base) {
 			int pos = bitmap_position(bitmap_git, &object->oid);
-			if (pos > 0 && bitmap_get(base, pos)) {
+			if (pos >= 0 && bitmap_get(base, pos)) {
 				object->flags |= SEEN;
 				continue;
 			}
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 305d677108..2a6c0e2318 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -85,6 +85,10 @@ test_expect_success 'bitmap traversal with pseudo-merges' '
 
 	test_pseudo_merges_satisfied 8 <trace2.txt &&
 	test_pseudo_merges_cascades 1 <trace2.txt &&
+
+	# Position zero is named by HEAD, its branch, and its tag, but its
+	# bitmap should only be loaded once.
+	test_trace2_data bitmap bitmap/hits 1 <trace2.txt &&
 	test_cmp expect actual
 '
 

base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
2.54.0

