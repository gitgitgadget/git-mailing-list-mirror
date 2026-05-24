Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC58395DB8
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644546; cv=none; b=JExh3VKVz8mEzSAPWK0zAZ4iQygNXI/ljRMi1OZZ0xTnfOdVn7rA1UE04K+3eCEm9L9Mc2b7DtIhjUqfdPhBFXCOzrtHuTvwPEhpbOVwCLq1oR8W1Isbv3IhrD+g85DqEYvUx95DnPoWI90PHqzWjZ6LwQROGKW8eiuw5EMZZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644546; c=relaxed/simple;
	bh=/2h2+NWDmEKMFC+FUshgXVzevZcABoGLEZqI2fUDT0c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sm7YR6grMj4AMxb7++tOYBuONM6+M6oen3CjD+bLSJspHf+YehObb0wC/qwBjFyUYXgDussH5LC7BCo+sYQgYzKwX4GUJJQH/fJE0F65yTwNBhsHanSx3F/xfgRx3W42/QFw/VsVzKVv/9sOWyaIISJkgFbNW0LcDw4ndfzHvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJOzKavM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJOzKavM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-512f09ecc67so61798981cf.3
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644544; x=1780249344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRyXgMEOTX1YzjDc2AReb+LbBBwLy8XjwKNiK74vPZY=;
        b=TJOzKavMOGoJubG8qF57TEYEUepEYuAK74iCpsYom8t+ctpQIkgW6KsbRUA70vybuT
         xEX30w6DXgCaZb0LFyM9MI+wvpYzaYX+nTg4v555nytDm4K3g6kpzc4QgDOCHE6AudxF
         uIAZhvJckMKRtPrDcvE4bdbmVTLgQI/t6GwHBar6Q/tE4ZVh2tVKl/1WwNnjPx8oZQau
         9Y3rqdLvnmv8eMwQdMUZuU8mepkCJu9FoU+2beOFdGwxEqgD1mIcwvubnz/yJ+p0QtAs
         kgWL/BsnQKLo/Cp45et5+InIY+yheSaQivvRgxVCOIeB+B3KieA6YprzCkW0PutOH2OM
         8jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644544; x=1780249344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dRyXgMEOTX1YzjDc2AReb+LbBBwLy8XjwKNiK74vPZY=;
        b=PnDLwSAlkGkdY427Syr5npbuCVmbOvDHNsru1/ow55alS2YqiLgFdmP2JxtkWDfXtb
         4nrWMGDDVlBc6S3jDmi/wdyrYVQr8UQkmYvHX3ygitrRhEueyKRtnTb1/bUJgH82rqn/
         Ab3dw8xXLFGq3XCAGSY3PFZB6aSkO1fIMiU8lhwExoDG4Ql00ztJlFdvdCQQutzOj8nq
         rFhyB9iMR2NY2jGymJhQqUnNx68dwHUWMcWPHtI1t0uqOQEDnuIipTDw/Wiz07YT0MGJ
         tB1QYrX/PbuXmbnDukgV34ELrBxdfyTR1nEzvW0Za4l2eaLHDJ9MtvZ7z2QqKg4OXfXj
         rTvA==
X-Gm-Message-State: AOJu0YxLzNs1j3DEGGv2kTmTfqwTfimu0kOFGGjlUfucM+2OmIqJo/tr
	DsKd55LcOkFRIXioM80EyaqIJgE2eOkwCcENaCs6zOZpWWr6u7Zvd5L4dhh8tsZ1
X-Gm-Gg: Acq92OENcgYPF0R0FoVmunticnVLY3Seh/MMAuvIKvU0aVL74JKWiX+q9fAW+NnDqNW
	YYEgxegZckeMO6GQngioAyz5Y4rEM9H7KlOtYbwXRpFwFkip/zFbd4fARvZIDOzCKvxp8/IdwPE
	xqGWfTtMM8biCCWKOm/rJ7wT7UQ/7wOiqO5+AJiEqjImgczjZXNt4UDyUGQXqK8DycPxRhWM4GO
	kK1wy1HcaKEV30BBRUJOvZEydO2n1c4buLmDchPp9QhVKyaE9h7nTXtNHlmk4i1dBExZhNjrXjB
	h1oOmT/8YaeNDCs6y3AZO9iD1NkVOl9Afro5H3mnjjjVoszUOvwZSr4gvkw/Xdyfct1f//Q+Ezf
	Zjzm0IbHyG3qVZYh4oH33xQuYPkTAlY+PPmT9mJpnO/RqVfGUq7fbW0wkEd1Hsr0JEli+cUafF8
	xCYwE8vd3JV0ImonKBW4wNvvIQpw==
X-Received: by 2002:ac8:7d45:0:b0:50b:4491:a2cf with SMTP id d75a77b69052e-516d4317528mr161206731cf.27.1779644544110;
        Sun, 24 May 2026 10:42:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.235.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8c91c42sm75180621cf.14.2026.05.24.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:42:23 -0700 (PDT)
Message-Id: <1d3751569ba3a5f0c353fb468578d6c5bcd0b738.1779644541.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
References: <pull.2124.git.1779644541.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:42:18 +0000
Subject: [PATCH 1/3] commit-reach: deduplicate queue entries in
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

paint_down_to_common() can enqueue the same commit multiple times
when it is reached through different parents with different flag
combinations. Add an ENQUEUED flag to track whether a commit is
currently in the priority queue, and skip it if already present.

This change is performance-neutral on its own: the O(n)
queue_has_nonstale() scan still dominates the per-iteration cost.
However, the deduplication guarantee (each commit appears in the
queue at most once) is a prerequisite for the next commit, which
replaces that scan with an O(1) nonstale counter.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 19 +++++++++++++++----
 object.h       |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index d3a9b3ed6f..c16d4b061c 100644
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
@@ -39,6 +40,14 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 	return 0;
 }
 
+static void maybe_enqueue(struct prio_queue *queue, struct commit *c)
+{
+	if (c->object.flags & ENQUEUED)
+		return;
+	c->object.flags |= ENQUEUED;
+	prio_queue_put(queue, c);
+}
+
 static int queue_has_nonstale(struct prio_queue *queue)
 {
 	for (size_t i = 0; i < queue->nr; i++) {
@@ -70,11 +79,11 @@ static int paint_down_to_common(struct repository *r,
 		commit_list_append(one, result);
 		return 0;
 	}
-	prio_queue_put(&queue, one);
+	maybe_enqueue(&queue, one);
 
 	for (i = 0; i < n; i++) {
 		twos[i]->object.flags |= PARENT2;
-		prio_queue_put(&queue, twos[i]);
+		maybe_enqueue(&queue, twos[i]);
 	}
 
 	while (queue_has_nonstale(&queue)) {
@@ -83,6 +92,8 @@ static int paint_down_to_common(struct repository *r,
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
 
+		commit->object.flags &= ~ENQUEUED;
+
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
 			    generation, last_gen,
@@ -124,7 +135,7 @@ static int paint_down_to_common(struct repository *r,
 					     oid_to_hex(&p->object.oid));
 			}
 			p->object.flags |= flags;
-			prio_queue_put(&queue, p);
+			maybe_enqueue(&queue, p);
 		}
 	}
 
diff --git a/object.h b/object.h
index d814647ebe..05cbf728e9 100644
--- a/object.h
+++ b/object.h
@@ -74,7 +74,7 @@ void object_array_init(struct object_array *array);
  * bundle.c:                                        16
  * http-push.c:                          11-----14
  * commit-graph.c:                                15
- * commit-reach.c:                                  16-----19
+ * commit-reach.c:                                  16-------20
  * builtin/last-modified.c:                         1617
  * sha1-name.c:                                              20
  * list-objects-filter.c:                                      21
-- 
gitgitgadget

