Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D51B33F5AC
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781951826; cv=none; b=qJCiWMFXzq3u7M+LgLu2z08tZypCrTx4dt6/uTxmDgPJM3madTJ6WlRWuiPZIFy0RVCB+Ob/deLiZPe+hHZcpcX2mevnyRvkWzP1Gr+phP8goSop8e+DFKdvnaWc0Yp7+hqTbnloAcT3HXcHZozEm3Zx5by83qvsWlOD8sY+yxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781951826; c=relaxed/simple;
	bh=8NTuNU2f2y+2exJuTtUj/TqLniuhTVx7yJ30e7DPSvU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k/KYC1Q7GTMpkH1FUxMVoq5KpxH1VvthZHF9cHOLH5NbDYtLVwqAF+H/nrkyzERsMP9YjjiFPcsOBwnF3Im1amx+YQ6uFF4t7AJrGwUD645qyrUY8/TT4oCzvhnYd9sfqBKcAXLqf2vrWx11VQg29B1Wh3D7pD3PBoPURPICoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+GyhF/W; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+GyhF/W"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bbe98c3f0so4600447eec.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781951824; x=1782556624; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbTOyqHUp/NbszZbc0bQfjY2enSTi/HDsyZkjzqV/Hg=;
        b=N+GyhF/W85R3yFzoDCOwj1iM9rSvrpkGTRxsWFhb4H3bhHdMcVyDZDBaxs4AexqUtN
         lu0pNAFxL9fCZyBVgLzbmjvVeLufFEJlQy4DDA7YBLyQfMsdc9WyVl6IEK8R9+N9MprD
         zySfDcHu1h+5i0OArfQa+jDgXsdIN8sHjYx7GHuY/au81yNPBMLrNes1ng0x/9cGyDol
         e9Z4VhKrjnFXiyBpYPDNg91doDUtEXgVnBWljMYxzha6pZn1Re3JQeGG7+k1MhvSnP8Y
         HjpU7h2lpZ4p3G4y+4G5uO0LSUbHvOOmsMIWA8qPmd9vfQBoUr5sEV+xyzwz0QTNuX7z
         /ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781951824; x=1782556624;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mbTOyqHUp/NbszZbc0bQfjY2enSTi/HDsyZkjzqV/Hg=;
        b=P7Bov84/DRKjW0dYTkR8LsVNi+3km5JYtdAxvX57HTbaaRnkZAE1y0zVEACbRvNh/f
         ygLSygSLL6wF+IyzHSOWVrF3IHpIEDVxuvQEH6pbRvLd+K4rTGB5WEIlMdWrKst8ddOt
         nveRFBxQHkUo/pXfOVePS5/oEdkjLQsXRflbCnzxViAQvD9anfpo7Uh0+daDL6ciRBKr
         Y1Fw9fUycbidOWpXkbBBixmIyaeI1BDYAnTHKYwnDMU7R7pF/QS/MMb1cVb+SLSlHnmq
         TcZabbMNPLaLWI/KMiy5fto7AvWXdAFbJN0CTFYfICxyODh/ZviJeUj1YGjsY/ZCs/Gd
         U0eA==
X-Gm-Message-State: AOJu0YxFShPGNNK6QVFL2iAyOsuYOkgQ9Ubww7Ec/E9gQHlIvRY/lAlA
	oZ98j2NPhd7Qx6y0t6jjlY9XUZeZ2rfZdYbR+AwTXeXMMtoNMS5uxQSrGaWaBQ==
X-Gm-Gg: AfdE7cmMH8kNm5AfHxducNVaMfPmsnlsOzVNuZGl37mytdYWSrAbLdZQ0Vx4aHGwOsU
	ydPt1uo+3/zcx3fBZ1yzjTx/dtgxh5djsWAshBIBvPqiAH/1Ye8QG6GB7W3tx48OCnWf8Cs/Ya7
	IP8u6Tx922vC3GPbzXjEEP+sGssg9sL/mbuxYAhQWN+lwL4A7Objq+SzCDtAFpI5+8UBCMfp7ID
	0GDKqfZwSN+fXcrek2kR9GFs9renPyaEDnHJ0sAiOt6TnrRAY17OoDTLw6cxwotnEOkh2cALOqc
	Lj6MPBvWR4NeKLQDn6tTM3Zsz5QBzjQYs0JhKGRHQHVL0NjA0IewPfO65REAXLa5wvoeea4rfxs
	fzaOfpG9MTy6/qDtDjHAdxR5uz3Ult/Ki2a87yZIz1Ie5g9exRfn6h8L4NgeqT5Wdmqur7cviF5
	3mhTwET2MtiZjB6+Hy
X-Received: by 2002:a05:7300:8628:b0:30b:d31f:1577 with SMTP id 5a478bee46e88-30c0d12389bmr3742172eec.34.1781951824084;
        Sat, 20 Jun 2026 03:37:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.54.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c32csm3722674eec.6.2026.06.20.03.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 03:37:03 -0700 (PDT)
Message-Id: <5492acda0ad05eab67198880a5262e84a3f22ba6.1781951820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 10:36:54 +0000
Subject: [PATCH/RFC 1/6] commit-reach: decouple ahead_behind from
 nonstale_queue
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
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Move ahead_behind() off the shared nonstale_queue abstraction to use
a plain prio_queue with a local max_nonstale pointer. The nonstale
tracking is inlined into insert_no_dup().

This prepares for replacing nonstale_queue with a paint_queue struct
that tracks per-side commit counts, which ahead_behind() does not
need. No behavior change.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..377a5cc42a 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1089,12 +1089,18 @@ struct commit_list *get_reachable_subset(struct commit **from, size_t nr_from,
 define_commit_slab(bit_arrays, struct bitmap *);
 static struct bit_arrays bit_arrays;
 
-static void insert_no_dup(struct nonstale_queue *queue, struct commit *c)
+static void insert_no_dup(struct prio_queue *queue,
+			  struct commit **max_nonstale,
+			  struct commit *c)
 {
 	if (c->object.flags & PARENT2)
 		return;
-	nonstale_queue_put(queue, c);
 	c->object.flags |= PARENT2;
+	prio_queue_put(queue, c);
+	if (!(c->object.flags & STALE) &&
+	    (!*max_nonstale ||
+	     queue->compare(*max_nonstale, c, queue->cb_data) <= 0))
+		*max_nonstale = c;
 }
 
 static struct bitmap *get_bit_array(struct commit *c, int width)
@@ -1118,9 +1124,10 @@ void ahead_behind(struct repository *r,
 		  struct commit **commits, size_t commits_nr,
 		  struct ahead_behind_count *counts, size_t counts_nr)
 {
-	struct nonstale_queue queue = {
-		{ .compare = compare_commits_by_gen_then_commit_date }
+	struct prio_queue queue = {
+		.compare = compare_commits_by_gen_then_commit_date
 	};
+	struct commit *max_nonstale = NULL;
 	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
 
 	if (!commits_nr || !counts_nr)
@@ -1140,14 +1147,17 @@ void ahead_behind(struct repository *r,
 		struct bitmap *bitmap = get_bit_array(c, width);
 
 		bitmap_set(bitmap, i);
-		insert_no_dup(&queue, c);
+		insert_no_dup(&queue, &max_nonstale, c);
 	}
 
-	while (queue.max_nonstale) {
-		struct commit *c = nonstale_queue_get(&queue);
+	while (max_nonstale) {
+		struct commit *c = prio_queue_get(&queue);
 		struct commit_list *p;
 		struct bitmap *bitmap_c = get_bit_array(c, width);
 
+		if (c == max_nonstale)
+			max_nonstale = NULL;
+
 		for (size_t i = 0; i < counts_nr; i++) {
 			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
 			int reach_from_base = !!bitmap_get(bitmap_c, counts[i].base_index);
@@ -1178,7 +1188,7 @@ void ahead_behind(struct repository *r,
 			if (bitmap_popcount(bitmap_p) == commits_nr)
 				p->item->object.flags |= STALE;
 
-			insert_no_dup(&queue, p->item);
+			insert_no_dup(&queue, &max_nonstale, p->item);
 		}
 
 		free_bit_array(c);
@@ -1186,10 +1196,10 @@ void ahead_behind(struct repository *r,
 
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
-	for (size_t i = 0; i < queue.pq.nr; i++)
-		free_bit_array(queue.pq.array[i].data);
+	for (size_t i = 0; i < queue.nr; i++)
+		free_bit_array(queue.array[i].data);
 	clear_bit_arrays(&bit_arrays);
-	clear_nonstale_queue(&queue);
+	clear_prio_queue(&queue);
 }
 
 struct commit_and_index {
-- 
gitgitgadget

