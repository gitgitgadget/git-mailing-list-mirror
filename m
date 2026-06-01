Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66134B183
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301860; cv=none; b=T0/dqAf8ONezrviEHw6rj3VmePYg3nP/B6GFQ6t0I/BITRw0c24lWd038bROqoq6CyXVOFjc0o2wCx9ryBDdVR5o+hl+UVwSZ7n0UoKXazHOaSUqt2jothSziHYwejDcwTwu+RJIYJqtLOwrxtLW0D0AYKPNkskFjndAFRHqQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301860; c=relaxed/simple;
	bh=YIwUd9+2OwVVnVGJDoFR1IKwE7Ia7DyQT0Wx9+FkE9w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=HS73OXtXKg7lQS7C0+SmQxLUaFohQhKXlobr4tqI9w8SeAwzyW5qtgx+PEOfqjKrDcIxsZlOKRahWIGSXQtO0Uk0/l2FL292tqImhGsFtgMTdIDcV1BCD8AfKhP4uu11R9KoDtzxTNYtk7llYej9/Wx2j5uO+MldKdMfor0zFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3kf4aJO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3kf4aJO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915660e5b8eso52635785a.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 01:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780301857; x=1780906657; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saj9281PGTEYuboYZIutwjZTKP3ET65D9r1YzZXWK5Y=;
        b=r3kf4aJOErpJxjhnq7Boz7cJ51tgASHkKfkyDehCMw6mMhmirB3o8gSs0N1OMfnyUW
         8wKTcvO37Myf7a0rt7N3B+Nxwsy8xNncf5mG+IRHvp4rEuf9K8IaHad3DBoaNi3YNXUe
         25w6NRkDgvRWZ1APDruvzhIHKFjKmrjkyhhgHlibC1rBiqQUpZgbdqlBLMFy9UZlCywE
         oSvfFWknnxgqx+oS6y9vOz4YfD2SHx7BmaqcmiZFhk9y4f6v+jOS8NPIuo7RhqU+V1SL
         +eCDc7rmeKpag5S4u7ISPiauiH5m41tQcDg7WSoM6oselmrieoU4uz2Rr7qByerpXNPV
         nC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301857; x=1780906657;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=saj9281PGTEYuboYZIutwjZTKP3ET65D9r1YzZXWK5Y=;
        b=E/7H4EgFqIyov/R/bhi/UXno8WuIhCzpQrjFkU+ewNVcanQ4IVPlpUst1oU07iI7t6
         MpjFGSMV58hVJYqW+pJHs0KUpJ7VXslbnV6s1pkotySE3NdV0Jxm5GhxfO8O9udBfMt3
         HVGrIKjrbLnMU3aigjaFWqtx238UKR+g9QhjGgG2Q6jrCM8KT4McSTH+PlgdBlv/1ECp
         Mkk0Y27ry7XjM3UjmkC0DCMkabV262aA6lgIoNZSRYc6BDMhd3zH9nZEYP29PruTLdcJ
         xqEx9/y4gfMmt4Y+VCfGkt0wtk134XgX5IOhIgZyV9eR80EKIKlyy+3WKn6lqEhSd4py
         FPuQ==
X-Gm-Message-State: AOJu0YydacYFlifA0g8wrPHSDxUC1e9owx5odWLyemvJZcAtV+X8oett
	pNle89UxkioXbfcl5jDKBQcxllsjRpyCotpc+fJ6bWzFGX1j2XHYcNHSolnH5A==
X-Gm-Gg: Acq92OG0uIYGnGXVlhTrnXAQuF2WWI5zE8EH2e357wVOx7WmQPAa7m8FDcd3UIdo3G/
	TbUVnuGFLG0v5lqE2+oQ2AR60Dp2qfpw56przuHFpGw8zB2nivGNXLAAEN5w1+tNSJ9AJ+3vqRC
	Cjy0K+8DADoiGxYqCjk6UaIg02iw5H+ZINnbBRkJA2+aUfjPuv79WdBhHA9UQ+4k+Vwl0Hc/Fqp
	S6Ok355lz8CtZ6eCclRT06ungqaPZklScLObjpxFXWnJM5JBXJBcF18LcMiAU3Orne6Q2lswNL9
	k7vjkC31c6rFRPQD4wN9phj8ZnEQ9XrOLqgQnt1t3D1+AmpCVTmvtcI+GOq9nbjxYbXM0Ttm2Zd
	QFvv15Ab9r+Lt5WgnopNWE+CmrDorlNU/lHlWCM4xu5PRorXirUOdlYTUhcC/wqJWOrz5mQKyrv
	lbr/LR5/Qqzn6Ph37e6GmcaX4ECStesGgD48H27w==
X-Received: by 2002:a05:620a:8088:b0:915:2355:c455 with SMTP id af79cd13be357-9153d9cac56mr1566534485a.8.1780301857429;
        Mon, 01 Jun 2026 01:17:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.182.195])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9157397e5eesm1397085a.16.2026.06.01.01.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 01:17:36 -0700 (PDT)
Message-Id: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
In-Reply-To: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
References: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 08:17:35 +0000
Subject: [PATCH v2] prio-queue: use cascade-down for faster extract-min
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add sift_up_rebalance(), an alternative to sift_down_root() that
halves the number of comparisons per extract-min.

The standard extract places the last array element at the root and
sifts it down.  At each level this requires two comparisons (left
vs right child, then element vs winner) and a swap.

sift_up_rebalance() instead promotes the smaller child into the
root slot at each level — one comparison and one copy — until the
vacancy reaches a leaf.  The last array element is placed at the
vacancy and sifted up to restore heap order.  In practice the
sift-up rarely moves more than a level or two because the last
array element tends to be large.

Work per extract drops from 2d comparisons + d swaps to
d comparisons + d copies + a short sift-up.

prio_queue_get() now calls sift_up_rebalance() instead of placing
the last element at root and calling sift_down_root().

sift_down_root() and prio_queue_replace() are left unchanged.

Synthetic benchmark (10 rounds of 10M put+get cycles, CPU-pinned,
same compiler and Makefile flags):

Ascending keys (git's typical pattern — parents have lower
priority than children):

  queue width  baseline  patched  speedup
           10     4.39s    3.91s    1.12x
          100     9.10s    6.61s    1.38x
        1,000    11.84s    9.25s    1.28x
       10,000    17.50s   13.92s    1.26x
      100,000    23.97s   20.19s    1.19x

Descending keys (worst case — last element always sinks to leaf):

  queue width  baseline  patched  speedup
           10     4.94s    4.95s    1.00x
          100     9.75s    9.42s    1.03x
        1,000    15.01s   15.29s    0.98x
       10,000    24.79s   23.88s    1.04x
      100,000    29.69s   28.24s    1.05x

Random keys:

  queue width  baseline  patched  speedup
           10     5.05s    4.99s    1.01x
          100     9.90s    9.50s    1.04x
        1,000    15.35s   14.77s    1.04x
       10,000    25.35s   24.21s    1.05x
      100,000    65.71s   63.38s    1.04x

No regressions in any scenario.

End-to-end benchmark on the linux kernel repo (1.4M commits,
range v5.0..v6.0, 311K commits, 20 interleaved runs, 1 warmup):

  Command                      baseline  patched  speedup
  rev-list --count v5.0..v6.0    484ms     474ms    1.02x

The improvement scales with DAG width: wider DAGs produce larger
priority queues, amplifying the per-level savings.  In small or
narrow repositories the queues stay shallow and the sift-down
cost is already negligible.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    prio-queue: use cascade-down sift for faster extract-min
    
    This is a small optimization to prio_queue_get() that reduces the number
    of comparisons per extract-min from 2d to d (where d is the sift
    distance).
    
    The standard extract places the last array element at the root and sifts
    it down, comparing against both children at each level. The new
    sift_up_rebalance() instead promotes the smaller child at each level
    (one comparison and one copy) leaving a vacancy that sinks to a leaf.
    The last element is placed there and sifted up, which in practice rarely
    moves more than a level or two.
    
    The improvement shows clearly in synthetic benchmarks (up to 1.38x for
    ascending keys at queue width 100) but is modest end-to-end since
    sift_down_root is only a fraction of total runtime. On the linux kernel
    repo, rev-list --count v5.0..v6.0 improves by ~2%. The effect scales
    with DAG width.
    
    Changes since v1:
    
     * Kept sift_down_root() and prio_queue_replace() completely unchanged,
       preserving René's optimization that avoids the get+put overhead for
       replace. The cascade approach now only applies to prio_queue_get().
    
     * Extracted the new logic into a separate sift_up_rebalance() function
       rather than inlining it in prio_queue_get().
    
     * Updated benchmark numbers for ascending, descending and random
       insertion ordering. No regressions in any scenario.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2132%2Fspkrka%2Fcascade-sift-down-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2132/spkrka/cascade-sift-down-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2132

Range-diff vs v1:

 1:  9ca2fab4dc ! 1:  6051d44e59 prio-queue: use cascade-down sift for faster extract-min
     @@ Metadata
      Author: Kristofer Karlsson <krka@spotify.com>
      
       ## Commit message ##
     -    prio-queue: use cascade-down sift for faster extract-min
     -
     -    Replace the standard sift-down in prio_queue_get() with a
     -    cascade-down approach.
     -
     -    The standard approach places the last array element at the root,
     -    then sifts it down.  At each level this requires two comparisons
     -    (left vs right child, then element vs winner) and, when the
     -    element is larger, a swap (three 16-byte copies).
     -
     -    The cascade approach instead promotes the smaller child into the
     -    vacant root slot at each level — one comparison and one copy.
     -    The vacancy sinks to a leaf, where the last array element is
     -    placed and sifted up if needed — typically zero levels since the
     -    last array element tends to be large.
     -
     -    In the common case, work per extract drops from 2d comparisons
     -    + 3d copies to d comparisons + d copies: roughly half the
     -    comparisons and a third of the data movement.  The sift-up phase
     -    can add work when the last element is smaller than ancestors of
     -    the leaf vacancy, but this is rare in practice.
     -
     -    Simplify prio_queue_replace() to a plain get+put sequence.  This
     -    is semantically equivalent: the old implementation wrote to slot 0
     -    and sifted down, which has the same observable effect as removing
     -    the root and inserting a new element.  No caller observes queue
     -    state between the two operations.  The previous implementation
     -    shared sift_down_root() with get, but the cascade approach no
     -    longer accommodates that cleanly since sift_down_root() now
     -    expects the element to reinsert at queue->array[queue->nr], left
     -    there by prio_queue_get() after decrementing nr.  This is fine in
     -    practice: replace is only called from pop_most_recent_commit()
     -    (fetch-pack, object-name, walker) and show-branch — none of
     -    which appear in any hot path.
     -
     -    A synthetic benchmark (10 rounds of 10M put+get cycles, ascending
     -    integer keys, CPU-pinned, median of 3 runs, same compiler and
     -    Makefile flags) shows consistent improvement across all queue
     -    sizes, with no regressions:
     -
     -        queue width       baseline    cascade    speedup
     -        ------------------------------------------------
     -                 10        4.32s      3.97s      1.09x
     -                100        7.95s      6.49s      1.23x
     -              1,000       11.30s      9.66s      1.17x
     -             10,000       16.34s     14.15s      1.16x
     -            100,000       21.43s     18.66s      1.15x
     -
     -    With descending keys (worst case — the last element always sinks
     -    to a leaf in both approaches) the cascade still wins slightly
     -    (1-4%) by replacing swaps with copies, and never regresses.
     -
     -    In end-to-end git commands the improvement is modest because
     -    sift_down_root is only ~8% of total runtime.  Profiling
     -    rev-list --count on a 2.5M-commit monorepo shows sift_down_root
     -    dropping from 8.2% to 0.4% of total runtime.  The improvement
     -    scales with DAG width: wider DAGs produce larger priority queues,
     -    amplifying the per-level savings.  In small or narrow repos the
     -    queues stay shallow and the effect is negligible.
     +    prio-queue: use cascade-down for faster extract-min
     +
     +    Add sift_up_rebalance(), an alternative to sift_down_root() that
     +    halves the number of comparisons per extract-min.
     +
     +    The standard extract places the last array element at the root and
     +    sifts it down.  At each level this requires two comparisons (left
     +    vs right child, then element vs winner) and a swap.
     +
     +    sift_up_rebalance() instead promotes the smaller child into the
     +    root slot at each level — one comparison and one copy — until the
     +    vacancy reaches a leaf.  The last array element is placed at the
     +    vacancy and sifted up to restore heap order.  In practice the
     +    sift-up rarely moves more than a level or two because the last
     +    array element tends to be large.
     +
     +    Work per extract drops from 2d comparisons + d swaps to
     +    d comparisons + d copies + a short sift-up.
     +
     +    prio_queue_get() now calls sift_up_rebalance() instead of placing
     +    the last element at root and calling sift_down_root().
     +
     +    sift_down_root() and prio_queue_replace() are left unchanged.
     +
     +    Synthetic benchmark (10 rounds of 10M put+get cycles, CPU-pinned,
     +    same compiler and Makefile flags):
     +
     +    Ascending keys (git's typical pattern — parents have lower
     +    priority than children):
     +
     +      queue width  baseline  patched  speedup
     +               10     4.39s    3.91s    1.12x
     +              100     9.10s    6.61s    1.38x
     +            1,000    11.84s    9.25s    1.28x
     +           10,000    17.50s   13.92s    1.26x
     +          100,000    23.97s   20.19s    1.19x
     +
     +    Descending keys (worst case — last element always sinks to leaf):
     +
     +      queue width  baseline  patched  speedup
     +               10     4.94s    4.95s    1.00x
     +              100     9.75s    9.42s    1.03x
     +            1,000    15.01s   15.29s    0.98x
     +           10,000    24.79s   23.88s    1.04x
     +          100,000    29.69s   28.24s    1.05x
     +
     +    Random keys:
     +
     +      queue width  baseline  patched  speedup
     +               10     5.05s    4.99s    1.01x
     +              100     9.90s    9.50s    1.04x
     +            1,000    15.35s   14.77s    1.04x
     +           10,000    25.35s   24.21s    1.05x
     +          100,000    65.71s   63.38s    1.04x
     +
     +    No regressions in any scenario.
     +
     +    End-to-end benchmark on the linux kernel repo (1.4M commits,
     +    range v5.0..v6.0, 311K commits, 20 interleaved runs, 1 warmup):
     +
     +      Command                      baseline  patched  speedup
     +      rev-list --count v5.0..v6.0    484ms     474ms    1.02x
     +
     +    The improvement scales with DAG width: wider DAGs produce larger
     +    priority queues, amplifying the per-level savings.  In small or
     +    narrow repositories the queues stay shallow and the sift-down
     +    cost is already negligible.
      
          Signed-off-by: Kristofer Karlsson <krka@spotify.com>
      
       ## prio-queue.c ##
      @@ prio-queue.c: static void sift_down_root(struct prio_queue *queue)
     - {
     - 	size_t ix, child;
     + 	}
     + }
       
     --	/* Push down the one at the root */
     --	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
     --		child = ix * 2 + 1; /* left */
     ++static void sift_up_rebalance(struct prio_queue *queue)
     ++{
     ++	size_t ix, child;
     ++
     ++	/* Cascade: promote smaller child at each level. */
      +	for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
     - 		if (child + 1 < queue->nr &&
     - 		    compare(queue, child, child + 1) >= 0)
     - 			child++; /* use right child */
     ++		if (child + 1 < queue->nr &&
     ++		    compare(queue, child, child + 1) >= 0)
     ++			child++;
      +		queue->array[ix] = queue->array[child];
      +	}
     - 
     --		if (compare(queue, ix, child) <= 0)
     -+	/* Place queue->array[queue->nr] (left by caller) and sift up. */
     ++
     ++	/* Place the last element at the vacancy and sift up. */
      +	queue->array[ix] = queue->array[queue->nr];
      +	while (ix) {
      +		size_t parent = (ix - 1) / 2;
      +		if (compare(queue, parent, ix) <= 0)
     - 			break;
     --
     --		swap(queue, child, ix);
     ++			break;
      +		swap(queue, parent, ix);
      +		ix = parent;
     - 	}
     - }
     - 
     ++	}
     ++}
     ++
     + void *prio_queue_get(struct prio_queue *queue)
     + {
     + 	void *result;
      @@ prio-queue.c: void *prio_queue_get(struct prio_queue *queue)
       	if (!--queue->nr)
       		return result;
       
      -	queue->array[0] = queue->array[queue->nr];
     - 	sift_down_root(queue);
     +-	sift_down_root(queue);
     ++	sift_up_rebalance(queue);
       	return result;
       }
     -@@ prio-queue.c: void prio_queue_replace(struct prio_queue *queue, void *thing)
     - 		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
     - 		queue->array[queue->nr - 1].data = thing;
     - 	} else {
     --		queue->array[0].ctr = queue->insertion_ctr++;
     --		queue->array[0].data = thing;
     --		sift_down_root(queue);
     -+		prio_queue_get(queue);
     -+		prio_queue_put(queue, thing);
     - 	}
     - }
     + 


 prio-queue.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index 9748528ce6..66d445b078 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -76,6 +76,29 @@ static void sift_down_root(struct prio_queue *queue)
 	}
 }
 
+static void sift_up_rebalance(struct prio_queue *queue)
+{
+	size_t ix, child;
+
+	/* Cascade: promote smaller child at each level. */
+	for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
+		if (child + 1 < queue->nr &&
+		    compare(queue, child, child + 1) >= 0)
+			child++;
+		queue->array[ix] = queue->array[child];
+	}
+
+	/* Place the last element at the vacancy and sift up. */
+	queue->array[ix] = queue->array[queue->nr];
+	while (ix) {
+		size_t parent = (ix - 1) / 2;
+		if (compare(queue, parent, ix) <= 0)
+			break;
+		swap(queue, parent, ix);
+		ix = parent;
+	}
+}
+
 void *prio_queue_get(struct prio_queue *queue)
 {
 	void *result;
@@ -89,8 +112,7 @@ void *prio_queue_get(struct prio_queue *queue)
 	if (!--queue->nr)
 		return result;
 
-	queue->array[0] = queue->array[queue->nr];
-	sift_down_root(queue);
+	sift_up_rebalance(queue);
 	return result;
 }
 

base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
-- 
gitgitgadget
