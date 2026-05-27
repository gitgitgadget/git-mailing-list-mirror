Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3B12CDA5
	for <git@vger.kernel.org>; Wed, 27 May 2026 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923925; cv=none; b=pHcme6rIQMu1hsS0FCBqZebvSFZqzvKDNQf0Xu+pcrBQ2Js09T0HJQH5Fd5ucWM/PCjmO2/YRoA9zgkAjOXl9xiUqpUp/kyeyo4cA/lM0pDy1S1pVhpGTPTe39+I5QsadLIXNmKnAPFrQRdHLi47H1TBaO73rq6bMJOlLWZiCa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923925; c=relaxed/simple;
	bh=EFZkSM6GPJH1afu2h57ZKDeZA545SrsvedtZb2Mb1q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiFSWLKkzHOoexTzU3BjMSx67fd2YEDwVxOfdvjHsAjQB0sOZPIIqVEfBK6sNMC+U3l1Z8PSPz76qRhULEGiHGfBwEVbqGrVLmDfUByF8ZNRz6+vfni/Aka0k2iSbYF/840HoOYfNJNy5iOrwgXduCvRaJtNDVJ/k8cei9aiI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Taq+qCiA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Taq+qCiA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7ca947f9b00so117454737b3.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779923923; x=1780528723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2wYqpis43ZRtPHZmftfRoshmhx/UVPqy3kq3QfpkfE=;
        b=Taq+qCiA2ko9zgW2OowmiSbaGc5LfLtrHA6u/1zp8c2BBmpQiVGMptB992bNe0LTkT
         CI32pWW/V5K9q3WGQltuDDUXBoDMGLOJH0vAzZcLuWKZ8N83FgU0sdiMZ+c37q7nrDaA
         j8elVNKI2C57ZAkMIlEwRfT0rKkAKQHmPOjU7vNzAyG1CYMmW7lmRUZs9D/hUVN68HkN
         WhzM+NVcnZvjow7/IUZonIK9iB4OifHnLTIfZrGlseGKV2SXai8/lB3XWPupaVwFWP0v
         QL8ll8LfleuEIC0h6QxusesL2U0yifQ6JMGjB0dF+GOpjoLtTzw1eppXtuHUEhvAH8N2
         0KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779923923; x=1780528723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2wYqpis43ZRtPHZmftfRoshmhx/UVPqy3kq3QfpkfE=;
        b=FaNEDNaC+m2Tu7tBpnMMP0KT3v8eQ8TloTzHKh7bVk42B4TzdcFp15LUdBpLrahCjU
         wi8JYaPgCnD10gRddYbIaxzN4r00p0GlfwetezBrbpfY+glhv9ZZT5cCdEsRbQyqm1JE
         R6d65F8Uwyo3N76Ou9mmsf2hKqnTLUpgp3Av9zJ2yWV5TQnhxkcha2/UL37s5B/+rq9D
         AQ2njUR67PWdaEsn/ejWctZHbEkN54o0LR7RKJtMIUY0AHduJ2j9WtGLdZIK+RB917zm
         0hNuy7onaj4gbbd5cboxfaWmWI8wqYOlzB5hSgxWPXTyekyk4Bt+ObSQQiTYT5CIrvAn
         Vxcw==
X-Gm-Message-State: AOJu0YzFcmSy4AluwrqQVpPgtONd5rCl+fw03zgWtWUr2IbLvsp33NQP
	7hq5L6DQ9z29Ohq2+ca6J9N+b01XI3LJMlFa15bwvGJqv34u0E2SOG8f36TlmcGLofFoB18/qL2
	SzhHrrEs=
X-Gm-Gg: Acq92OEAaZ+VWVYEYSlXQTZwJhRKR4AN1s2ZqfYOLiGB+uk2Py2AVDM5krMhcoqLStM
	cK16YlNerGLMC2Kpf+ok6o/4yJcEMQw/owYcAExsiQBtnEOaqY84aInqCELhTx+1wdkx+DOx2iw
	8kci1+QLanYdtH/DAu1/huxMgQkx7W5xAULBvg+nyoj6Kewu2bq71BbK3BARQvuwKlnp10TMMET
	YhTeHI2PStReBhdmf1X9nUjP5A/KglDs7qIAru4JL3GdWqQ60zREfarBUxUPRT5jqhI3o8zYnO8
	8DuY4JH3HryHl3j14+hH7yIdW1eSfkbIpdAkkKE8XFRyuD/3lvcj/IQxWa41GZ+7JI7BzznN7PU
	PqHy/8eRBuU9oXEvDEdN9l49/9svp1ZPnNqDy7mE7HeoKT+NepQPSnQfNsLmG4YbfNIqUuNokUO
	Hg8yT7UKI52kUhgGJTXyVNSnpdmrdMm9sMesJdZse4C9uTEiwDoJhtb8qovYtoetPaQ/R5ACHCr
	eJbia/KVaCmfoI49iXwumu07Zx5xupxk4w7qCfwImmN4mCDCF8RmIBO9ZDHZ55X/f6mmpRRsIRd
	+BiUWIdHj3dJYvD6pdEkoL5cvqQ=
X-Received: by 2002:a05:690c:22c5:b0:7ba:ded4:df53 with SMTP id 00721157ae682-7d3356dfe00mr256013407b3.32.1779923922805;
        Wed, 27 May 2026 16:18:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7dbd651cb5asm9669307b3.49.2026.05.27.16.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:18:42 -0700 (PDT)
Date: Wed, 27 May 2026 19:18:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] pack-objects: extract `record_tree_depth()` helper
Message-ID: <bdae873eaab71ac7973dd8bec2e276e8f0fede75.1779923907.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779923907.git.me@ttaylorr.com>

Prepare for a subsequent change that needs to record tree depths from a
second call site by factoring the delta-islands tree-depth bookkeeping
out of `show_object()` and into a helper, `record_tree_depth()`.

The helper looks up the object in `to_pack`, returns early when the
object was not added there, computes the depth from the slash count in
the supplied name, and preserves the existing max-depth-wins behavior
when a tree is reached by more than one path.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e4dcb563b7d..ec02e2b21d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2722,6 +2722,22 @@ static inline void oe_set_tree_depth(struct packing_data *pack,
 	pack->tree_depth[e - pack->objects] = tree_depth;
 }
 
+static void record_tree_depth(const struct object_id *oid, const char *name)
+{
+	const char *p;
+	unsigned depth;
+	struct object_entry *ent;
+
+	/* the empty string is a root tree, which is depth 0 */
+	depth = *name ? 1 : 0;
+	for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
+		depth++;
+
+	ent = packlist_find(&to_pack, oid);
+	if (ent && depth > oe_tree_depth(&to_pack, ent))
+		oe_set_tree_depth(&to_pack, ent, depth);
+}
+
 /*
  * Return the size of the object without doing any delta
  * reconstruction (so non-deltas are true object sizes, but deltas
@@ -4375,20 +4391,8 @@ static void show_object(struct object *obj, const char *name,
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
 
-	if (use_delta_islands) {
-		const char *p;
-		unsigned depth;
-		struct object_entry *ent;
-
-		/* the empty string is a root tree, which is depth 0 */
-		depth = *name ? 1 : 0;
-		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
-			depth++;
-
-		ent = packlist_find(&to_pack, &obj->oid);
-		if (ent && depth > oe_tree_depth(&to_pack, ent))
-			oe_set_tree_depth(&to_pack, ent, depth);
-	}
+	if (use_delta_islands)
+		record_tree_depth(&obj->oid, name);
 }
 
 static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
-- 
2.54.0.22.ga642305e3c9

