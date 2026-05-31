Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6050713A258
	for <git@vger.kernel.org>; Sun, 31 May 2026 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250240; cv=none; b=r7Mkxos4dF8cMbe+x+ZjFX8wOex3SUREMmRqIfRBddK4Fw8ofQuPgqrAW/HvrRrkYaNA5nGXKnYr/t3J7B5h0BqVwrh/PRKXhKonXnR3NRWshjoagr9mhvlB2OlrDjREpQ8H82+/Lut9XAZVGuJIEoDiFmU12XpgUijA8k0tBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250240; c=relaxed/simple;
	bh=M/MmGvfS8o7Dh78KxHjBYWqY1Y7G6XEBZVNBlGjY1jQ=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Vc9C5Dpl/b7+zzDGjMbIdFxPVj9ra9NK0vS1lm9ME+NbJ9SjIGF5NFnZ8S/6S4HsrTou2kiK0v6cEI4CXyW6859aStG2goXCM0H/kvrPbyVAEJW+2rOpwPI7ganPLZi/LvZ1QVdZnwcV9+gLxstPBqsDka/cI+gEI9lD5Bcd+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csOM037+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csOM037+"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91550dfc11fso82572185a.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780250238; x=1780855038; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PU3NiTwxmPFgpxT2TEvKdEbIUahtZW20jEMA3kjtWdY=;
        b=csOM037+6hhcQmTLrBGZ5USJI6TCR856ZJQLAxoS+MfEwozplUqdBxaXDMKRzD9g3h
         FQBv8AYUjEN0VBzYgQvRhz1hZ2XA4Tre/YRHSURRIw6GIgo+ezj0Qp4XtvJUxIg0T035
         aEpIG5ixv6d790Ey1Ptv+mlwcUAy2/LzQGqK56rsIUxTZUbxPvLCvoHrK2MIJhWKahby
         bo1ffj9moYdK7Bxyy+iQecnmeLeqIDhtdpqAFKCKy76IKI1ycKIZkdQeeZGLQ1dcZgDP
         h0mehcRJTUC5UFY3GBM+ePJEj+6tohGX1JZ9iaw5RKVyhYLfwSUdc898xEzWPpS0UytD
         NusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250238; x=1780855038;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU3NiTwxmPFgpxT2TEvKdEbIUahtZW20jEMA3kjtWdY=;
        b=VG1N7sUy6bBfEpIwSRvhJFoQ3o1p/GYdvvK2o+uWWwN2RLSlU1cdbHMbjHO+FKoVrg
         GB7isOg0gkguJ5DHt086KTIJbllpT59z2rD/p29Q9BjNc1ceeWv8xGkI3vSFXMwTp2+X
         H9P+dsTVCp8s6lZlJdR9jCO+8QZdHoFr8qTvdeaTPZp+506uwo0/ribGzh6fAY6nKqkL
         OfJbGij3N0OBatKknxJhDc41s3ZE2MprSYb+lP4p6k83R7Um8Hnp530TU1T5CF/+rcWI
         NZVz2NoOmbOGTnai7B+J/BIX0WVk87ZgWQxuIIMxr4dZJMkhZUDu7+T/Wu7YI92bp7TJ
         9Ujw==
X-Gm-Message-State: AOJu0Yxcmm+oBlY54T21qTMYFfuZeLlEXUosE3zqFUKquDKOgl58xzM0
	2NfZhXaizqlgO9i/GfDd60ovS/F5dAF+0eFSedPf71uB8jzA+PT++dA7Mm36cA==
X-Gm-Gg: Acq92OG48LXGJr/dsMm5V7ITwKadovtFNwt2+hWyH9nzsb3U+keTs55pPCOcR4DAK9s
	Pxy8F3xHdmdBt8PJRZ/qnBcsR2GAtw/jBo8w/zgs5mshEBVXJX63QOo9vdEdceSd6qQpmQZ4MQV
	y/7Ri0dEFc/7dJ/fHlEDGP+b6WiBu6t8uw6xrTejstx2txmN8iQ9g8MsabOckG9IyV4SpgKJNlJ
	SaL8zGkmvdjkJngHwy9GBgJ9FOyqXi5L58QxPEzp1AfV+2zELEruu+26dQRyhR2bD1XQT+ADlgF
	xXx/ludJt82Jwy856mM3rTOs61tjByxR6txCpq4gyfQ43DtFhw4wuVwgKOCMKD6qUhpBYxeB3Vv
	vmc760UnyKbkU3V76puYAoJ6vCBHnYsp+x6po9W0TEbN8mUvoOibwTgw5CHM7GO6xWqfesPAGtG
	uOu2No/LMXozP+Dr40b3s9JXfYN5sQHA/VAhk/L9k5Ra5NDmti
X-Received: by 2002:a05:620a:7108:b0:8f8:cdd0:df80 with SMTP id af79cd13be357-9153dbf89ccmr1397429685a.59.1780250238224;
        Sun, 31 May 2026 10:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324489b4sm779744185a.1.2026.05.31.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:57:17 -0700 (PDT)
Message-Id: <pull.2132.git.1780250236304.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 31 May 2026 17:57:15 +0000
Subject: [PATCH] prio-queue: use cascade-down sift for faster extract-min
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

Replace the standard sift-down in prio_queue_get() with a
cascade-down approach.

The standard approach places the last array element at the root,
then sifts it down.  At each level this requires two comparisons
(left vs right child, then element vs winner) and, when the
element is larger, a swap (three 16-byte copies).

The cascade approach instead promotes the smaller child into the
vacant root slot at each level — one comparison and one copy.
The vacancy sinks to a leaf, where the last array element is
placed and sifted up if needed — typically zero levels since the
last array element tends to be large.

In the common case, work per extract drops from 2d comparisons
+ 3d copies to d comparisons + d copies: roughly half the
comparisons and a third of the data movement.  The sift-up phase
can add work when the last element is smaller than ancestors of
the leaf vacancy, but this is rare in practice.

Simplify prio_queue_replace() to a plain get+put sequence.  This
is semantically equivalent: the old implementation wrote to slot 0
and sifted down, which has the same observable effect as removing
the root and inserting a new element.  No caller observes queue
state between the two operations.  The previous implementation
shared sift_down_root() with get, but the cascade approach no
longer accommodates that cleanly since sift_down_root() now
expects the element to reinsert at queue->array[queue->nr], left
there by prio_queue_get() after decrementing nr.  This is fine in
practice: replace is only called from pop_most_recent_commit()
(fetch-pack, object-name, walker) and show-branch — none of
which appear in any hot path.

A synthetic benchmark (10 rounds of 10M put+get cycles, ascending
integer keys, CPU-pinned, median of 3 runs, same compiler and
Makefile flags) shows consistent improvement across all queue
sizes, with no regressions:

    queue width       baseline    cascade    speedup
    ------------------------------------------------
             10        4.32s      3.97s      1.09x
            100        7.95s      6.49s      1.23x
          1,000       11.30s      9.66s      1.17x
         10,000       16.34s     14.15s      1.16x
        100,000       21.43s     18.66s      1.15x

With descending keys (worst case — the last element always sinks
to a leaf in both approaches) the cascade still wins slightly
(1-4%) by replacing swaps with copies, and never regresses.

In end-to-end git commands the improvement is modest because
sift_down_root is only ~8% of total runtime.  Profiling
rev-list --count on a 2.5M-commit monorepo shows sift_down_root
dropping from 8.2% to 0.4% of total runtime.  The improvement
scales with DAG width: wider DAGs produce larger priority queues,
amplifying the per-level savings.  In small or narrow repos the
queues stay shallow and the effect is negligible.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    prio-queue: use cascade-down sift for faster extract-min
    
    Hi, I am not sure this is just noise or not but I thought it at least
    was interesting.
    
    I looked into the internals of prio_queue and found it was technically
    doing too much work and could be simplified/optimized. I found I could
    optimize it by ~20% for the common case (adding commits that would
    typically end up far back in the queue) but only ~1% for the reverse
    case (adding things to the front of the prio queue). The average speedup
    is somewhere in between I suppose. That said, this is not really the
    bottleneck so the overall boost seems to be around ~3-4% improvement for
    repos with wide DAGs.
    
    I would normally classify this as not urgent or important, but I think
    the advantage is that the change is very small and simple and it already
    has good unit tests (t/unit-tests/u-prio-queue.c).
    
    With that said, here are the details:
    
    The prio_queue_get impl is based on removing the root entry, then moving
    the very last element into the root slot, then sifting it down into the
    right place. This uses both comparisons between sibling elements in the
    heap as well as comparisons between the element to add and one of the
    siblings. Then it uses swap operations to move things correctly.
    
    This patch instead promotes the smaller child upward at each level,
    leaving a vacancy that sinks to a leaf, then places the removed element
    there with a short sift-up to keep the heap balanced.
    
    We can analytically compare this - for a sift-distance of d we can
    reason about the number of operations to execute.
    
    Before: 2d comparisons + 3d copies
    After:   d comparisons +  d copies
    
    
    After changing sift_down in this way, the replace operation can't simply
    depend on it anymore, so I reimplemented it as a sequence of get + put.
    This is technically correct but maybe not as efficient. However, I am
    not sure that it matters, since I couldn't see any usage of the replace
    operation in any hot path.
    
    Performance: Profiling git rev-list --count on a 2.5M-commit monorepo
    shows sift_down_root dropping from 8.2% to 0.4% of total runtime,
    effectively eliminated as significant overhead.
    
    Synthetic benchmark 10 rounds of 10M put+get cycles, CPU-pinned, median
    of 3 runs, same compiler and Makefile flags.
    
    Ascending keys (git's typical pattern -- parents have lower priority
    than children):
    
    queue width  baseline  patched  speedup
             10     4.32s    3.97s    1.09x
            100     7.95s    6.49s    1.23x
          1,000    11.30s    9.66s    1.17x
         10,000    16.34s   14.15s    1.16x
        100,000    21.43s   18.66s    1.15x
    
    
    Descending keys (worst case — last element always sinks to leaf in both
    approaches):
    
    queue width  baseline  patched  speedup
             10     4.84s    4.78s    1.01x
            100     9.43s    9.20s    1.03x
          1,000    15.28s   14.71s    1.04x
         10,000    23.61s   23.49s    1.01x
        100,000    29.16s   28.22s    1.03x
    
    
    No regressions in any scenario.
    
    End-to-end benchmarks
    
    All benchmarks use a benchmark setup of 1 warmup run followed by 10
    timed runs. Each configuration is built from the same source tree and
    tested on the same repo in alternating order.
    
    linux kernel (1.4M commits) — range v5.0..v6.0 (311K commits):
    
    Command                      baseline  patched  speedup
    rev-list --count v5.0..v6.0     455ms    440ms    1.04x
    
    
    I also ran it on git.git but did not see any performance diff at all,
    due to the size and narrow DAG.
    
    The improvement scales with DAG width: wider DAGs produce larger
    priority queues, amplifying the per-level savings. In small or narrow
    repositories the priority queues stay shallow and the sift-down cost is
    already negligible, so the change is not noticeable.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2132%2Fspkrka%2Fcascade-sift-down-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2132/spkrka/cascade-sift-down-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2132

 prio-queue.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index 9748528ce6..18005c43c4 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -62,17 +62,21 @@ static void sift_down_root(struct prio_queue *queue)
 {
 	size_t ix, child;
 
-	/* Push down the one at the root */
-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
-		child = ix * 2 + 1; /* left */
+	for (ix = 0; (child = ix * 2 + 1) < queue->nr; ix = child) {
 		if (child + 1 < queue->nr &&
 		    compare(queue, child, child + 1) >= 0)
 			child++; /* use right child */
+		queue->array[ix] = queue->array[child];
+	}
 
-		if (compare(queue, ix, child) <= 0)
+	/* Place queue->array[queue->nr] (left by caller) and sift up. */
+	queue->array[ix] = queue->array[queue->nr];
+	while (ix) {
+		size_t parent = (ix - 1) / 2;
+		if (compare(queue, parent, ix) <= 0)
 			break;
-
-		swap(queue, child, ix);
+		swap(queue, parent, ix);
+		ix = parent;
 	}
 }
 
@@ -89,7 +93,6 @@ void *prio_queue_get(struct prio_queue *queue)
 	if (!--queue->nr)
 		return result;
 
-	queue->array[0] = queue->array[queue->nr];
 	sift_down_root(queue);
 	return result;
 }
@@ -111,8 +114,7 @@ void prio_queue_replace(struct prio_queue *queue, void *thing)
 		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
 		queue->array[queue->nr - 1].data = thing;
 	} else {
-		queue->array[0].ctr = queue->insertion_ctr++;
-		queue->array[0].data = thing;
-		sift_down_root(queue);
+		prio_queue_get(queue);
+		prio_queue_put(queue, thing);
 	}
 }

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
