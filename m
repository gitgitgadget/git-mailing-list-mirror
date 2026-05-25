Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A922B8DF
	for <git@vger.kernel.org>; Mon, 25 May 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719291; cv=none; b=tWrBHLY7XbcSmdkZek19tt+/+CUyYOxuVqtxb1oKyGjU+2RAn+G4qVkyh9E6Ru2IpJlGmO6CuuBX/obMD0rCL2beneT/dz9CHRO+8vVAK+Qyknr9Z2qnYleydrpBi3muoY7BD/yznZpg9RSD1WIdd4l1decl2x+A/M1tVj39uZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719291; c=relaxed/simple;
	bh=kLfEUDVLBCDgwtwj+8dakjFnaXH57qBlehuA/n4oXl0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R9bU/NbX7ADHurN/SAvbOvdWC01y/uzs1v+mNtj9uEP1xVzyou+HC+cmnjQ+PnEgsROl/5kRDFxFLgZoTt4k0ay/ER/kTWo7NQTsVHfXJgpyUuBAIy4qPKaIOVXbEYIr5XPEper3UkvYFkjhNHQo9dm3nfEZLDqjKc0XmRTtzPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeeWM61W; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeeWM61W"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91173f20ccdso426051785a.0
        for <git@vger.kernel.org>; Mon, 25 May 2026 07:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719289; x=1780324089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU48G+srmNihnKX2xvRr1iNRNTZMeIDh1SuJf0XjRlc=;
        b=MeeWM61WQdv8DDgAWZ2WRUeqpu4OOgL0h555YUrpQWNWIaBvCubIoy4WjNkzWJS3SD
         mbWlqgpi+dM0G8T/VmAq2Mgc/e89FQZY+OANhPl4U8XtN4MPLxNdalemd6NtMmbgKIG/
         yNs3+cDSsQgH2jqtoau+kPNy45yXMozY3qP9nMKUxvHYGLITaaR5oh5Bkm1YEZ8MDwT5
         WueyL7yQzL4PSDS1Cnr+H/pZJx64g4h7j6ZlCUfYuWz602HP1GLslxEzLSbXfJs/fiwQ
         gYj5JTgMsrXDRyVHHOpyIEqYaSVOL4GHwPiroG7XPTy3DM1yoHylbPFIFzf/MZL8zLra
         IplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719289; x=1780324089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IU48G+srmNihnKX2xvRr1iNRNTZMeIDh1SuJf0XjRlc=;
        b=s7d/EQVgcqdWrfNzkWKrO1HpBtTsXRpLQxLQk/AdwTjukQBLus9vXX8D5GPRSM1dC2
         ytUNuAy90fnmGqL6cizgLnh4XvT366TLOvKWk9StQg6C2H0fNYjE8P/D957WEAuumP+X
         yIc89svnMMBInILCLDanH1uFl4lp33VoXVnAgaBzPMrfASmfJ7xYE/IqBzyJSHdIIOqG
         Wk83SPAWiOVvdjvvK3YFYHm8wUbyQbLTS1Ki3tsPYzS7ZSa5lYfDd8kLRfguYVIooYxA
         nOqDY67L336QPJCH93pVHhediTKlKxTwOy0fntczAlghaOg/MGeWeXR8EzUOxOyiJ1mG
         ORPg==
X-Gm-Message-State: AOJu0YwivG7fTWsXXmQ4Xf/3Rk90qsy7DgmktxY0x/Ep8xHdcZjj3z4B
	POcpdxCKFhEIfQrGkcx2UYmNhooy3EnqEtld2iJpIMoKsQv7/IxKGJKzR3hdMQ==
X-Gm-Gg: Acq92OGsyfrzgIC6cMxXTfTEAG5mffaILzgymqEisB3y7GbjdoINUiq/yk5la4Yp7mz
	mvVlTYAlQ1RvUrnNoCuRyNlGPE6ysxgSY1dWOoKlnS3IcYKTLci04tTrKw5ubHQyzh7m/DUglS8
	f0u8Vuct0LatJomI/nBoH7Xh4ntjcm134YR9YHyfQyhc40k/DhwJ9HsZe4Sz91CwvoYRX3UiTUk
	L9sIirlHPHFlBx2vJzQWbqsVPuU9gtsJXucTXEEkm6+yLp1QvbDJjAwcBj9CWiitHvtqpjFyUok
	wHRF+jg2gbE4NmUndnKIeK1MquFqvhhdOdJMs0/YmBwzkeoMeRZc0MAj1Qqgtkev0kfiEaIJFou
	nVpJIYtXlY6kY2VEw+Uv6Naun9SayUgWs19hBxPy9EB06yHIcawhaQfHF9FAcoMGTbeiee2rK/g
	e2ZAdIIeuupwPconltllGdbMc=
X-Received: by 2002:a05:620a:a412:20b0:914:b5f8:c2b3 with SMTP id af79cd13be357-914b5f8c745mr1414140185a.18.1779719289163;
        Mon, 25 May 2026 07:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.135.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914c828b976sm780934485a.25.2026.05.25.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:28:08 -0700 (PDT)
Message-Id: <fc38c0f856e93b80073ec3f1b9f641b9ab187e4e.1779719286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
	<pull.2124.v2.git.1779719286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 14:28:04 +0000
Subject: [PATCH v2 2/3] commit-reach: deduplicate queue entries in
 paint_down_to_common
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Jeff King <peff@peff.net>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

paint_down_to_common() can enqueue the same commit multiple times
when it is reached through different parents with different flag
combinations. Add an ENQUEUED flag to track whether a commit is
currently in the priority queue, and skip it if already present.

Introduce prio_queue_put_dedup() and prio_queue_get_dedup()
wrappers that manage the ENQUEUED flag on enqueue and dequeue.

This change is performance-neutral on its own: the O(n)
queue_has_nonstale() scan still dominates the per-iteration cost.
However, the deduplication guarantee (each commit appears in the
queue at most once) is a prerequisite for the next commit, which
replaces that scan with O(1) tracking.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 27 ++++++++++++++++++++++-----
 object.h       |  2 +-
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5a52be90a6..85583ae359 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -17,8 +17,9 @@
 #define PARENT2		(1u<<17)
 #define STALE		(1u<<18)
 #define RESULT		(1u<<19)
+#define ENQUEUED	(1u<<20)
 
-static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT);
+static const unsigned all_flags = (PARENT1 | PARENT2 | STALE | RESULT | ENQUEUED);
 
 static int compare_commits_by_gen(const void *_a, const void *_b)
 {
@@ -39,6 +40,22 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	return 0;
 }
 
+static void prio_queue_put_dedup(struct prio_queue *queue, struct commit *c)
+{
+	if (c->object.flags & ENQUEUED)
+		return;
+	c->object.flags |= ENQUEUED;
+	prio_queue_put(queue, c);
+}
+
+static struct commit *prio_queue_get_dedup(struct prio_queue *queue)
+{
+	struct commit *commit = prio_queue_get(queue);
+	if (commit)
+		commit->object.flags &= ~ENQUEUED;
+	return commit;
+}
+
 static int queue_has_nonstale(struct prio_queue *queue)
 {
 	for (size_t i = 0; i < queue->nr; i++) {
@@ -70,15 +87,15 @@ static int paint_down_to_common(struct repository *r,
 		commit_list_append(one, result);
 		return 0;
 	}
-	prio_queue_put(&queue, one);
+	prio_queue_put_dedup(&queue, one);
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		prio_queue_put(&queue, twos[i]);
+		prio_queue_put_dedup(&queue, twos[i]);
 	}
 
 	while (queue_has_nonstale(&queue)) {
-		struct commit *commit = prio_queue_get(&queue);
+		struct commit *commit = prio_queue_get_dedup(&queue);
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
@@ -132,7 +149,7 @@ static int paint_down_to_common(struct repository *r,
 					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |= flags;
-			prio_queue_put(&queue, p);
+			prio_queue_put_dedup(&queue, p);
 		}
 	}
 
diff --git a/object.h b/object.h
index 2b26de3044..8fb03ff90a 100644
--- a/object.h
+++ b/object.h
@@ -75,7 +75,7 @@ void object_array_init(struct object_array *array);
  * bundle.c:                                        16
  * http-push.c:                          11-----14
  * commit-graph.c:                                15
- * commit-reach.c:                                  16-----19
+ * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
  * object-name.c:                                            20
  * list-objects-filter.c:                                      21
-- 
gitgitgadget

