Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDEC25E452
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748198524; cv=none; b=i/WXf+dK3Yth6tsZOFuXRtQGeW2jzjQrcQk8KnhQcsqJp5FiAvXiYOHQqGSCvCWSbNmr/SLzcMuB4ZJ93fsGVbkmhrGsx+GH9W1r1V/HPCb+07goFIGydARI9lbZQuJc33VlHUCN2Sk0eUdbiX+0GH61iTJYNJODXar1R0wYQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748198524; c=relaxed/simple;
	bh=xrg8qjbFyrOExgqY0xY9KHZKH39PBCrx7Ncr8GqckSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAwYEy/qTc4yICW6QG2ICHCLTq4iN5gBo8t9jBEfRqRG7523O0bqra0o9dnXRCJNj/PN0HGt2lilzb7Glup3jYdx8qUjbebMdDIpe+Ph//9PZEhqSa0RMOxQq/S5kMZ7y1B0VfDu1HQI5CRkFPES1QuGvlmLOSMqsJtoyznNOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Rbehneyv; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Rbehneyv"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cadd46ea9aso212942385a.1
        for <git@vger.kernel.org>; Sun, 25 May 2025 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748198522; x=1748803322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHf8W+yP0t5QMNdVlLkmDfRY7v5FmikjKxrjkUdE17I=;
        b=RbehneyvE9XadZbeFjfV7dlYmxkeEzyJwgZaA9pT35J+eqMIfZ8K+dvHdtp4JqCYVz
         IO7vJx2HFgqYhHtIJ9s9PuOH87nZdpmpGJUWUzEj7sHdpecFyS0LwvFYXqkXu0bOATpk
         v6uIbwuuBTqygrQccdyQ1CkxXAtR0t+NaySWyJlCOtS+DDRXXJEg5Adh8nM7o2xIX79K
         Ys+93/0mskTxQSkM7mRRPjyEa4GlygGVe7WjnuR1icngg1NNi+Z+wHHXzbGXocNWTE36
         nfbPJlWr82f8hm1hgeZG+GK4Dx3fLD4NMSGE9mS4f2um/PefcnP6hEF6EKjhVdKDOPe5
         gMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748198522; x=1748803322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHf8W+yP0t5QMNdVlLkmDfRY7v5FmikjKxrjkUdE17I=;
        b=qNnt90nnzyRdVtdnG+nW/g6FzMLjvWfvyCru/N3LBKW7QXgMBE+flRoLoHWNhyaKXf
         ylsVsJbvUl7lI3+Pq9156/TuMxpJY0VxatLtdNjqSDwGZl/k3AJmCWSsqbfGEMLQi4J8
         l3ojAHvgJn6RMpvqF55lx4b0STcJPe4RkZBn3XD1BKgsU1sO+JtGZBxQ4tUdYwSeREGj
         pt3XwFexGh344p9ejKzlCTgIMQfE8ebzV3f8j7PE93aglO1uf4spdbKAtzOLHuOkSJol
         bhK++6deMy0b716Pklm8zbOq/MoT3Vn+UVL3CBk+XbclJ9zgmjsW7t0S7eqllM3C7Swt
         WqUg==
X-Gm-Message-State: AOJu0Yyb/OYgnCZk+69YbYrQxX3vrUNfQbVYKSWeoBJ4G9mSd7I/3pm4
	+rFU0y/9Ekz6c/0c7XpAqPs2XEpkJYSuqmQVURUu20vuESLVE0zcFz4AULDvm4M2KGFQ5lLrZOQ
	b/8NV
X-Gm-Gg: ASbGncvlzIC4YOOGiE7lJFIPFOibQk06PQe610dF9z2yfw7ZjLjqfUxL00Eq8NqIcvC
	YKL7ybX/zP+wQOb1Y5gm52gslstMihk5Dy0s7VpHpI19rC+nlRf/65Sixyy+Co+DkLcozG9wZH5
	cMYKS6x3lmSSTsRw8ebxJjbUv3rmULn3phWl6xsQHcsb+PDKY7uWuGsyGMi5/bpPr2dn0Sm3Ive
	AnDXqOOQrcUfJYDWP/4WZqUM3r/4KYI7iXNi72k/dJOkFkE08BB5gctTp8FIOcZOWmwpCR76dBl
	QmHg/Un7aR/PNxQdEoCM109odt3gJy5gZDW2EAQuO8Pah8rVFg/0kShrbco/y8X9VRkz03ve8bj
	e6vONwdgL2hslKPaJcNlLx7o=
X-Google-Smtp-Source: AGHT+IHApA1GU7Kz1vV1xQ6QtfmrKee2Zk1T47e+sCRVtKTbnhu3b6qoGuzm+AEM6LjYihrfRlzPPw==
X-Received: by 2002:a05:620a:248c:b0:7c5:4d22:2149 with SMTP id af79cd13be357-7ceecbe8069mr1045045285a.30.1748198521792;
        Sun, 25 May 2025 11:42:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd467eedd7sm1468104985a.56.2025.05.25.11.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 11:42:01 -0700 (PDT)
Date: Sun, 25 May 2025 14:42:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/5] midx-write.c: extract inner loop from
 fill_packs_from_midx()
Message-ID: <a4080c12dfb971cff1f029502b13da01dc6f0929.1748198489.git.me@ttaylorr.com>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748198489.git.me@ttaylorr.com>

The function fill_packs_from_midx() does relatively little, but ends up
in a doubly-nested loop because we're enumerating each pack within each
layer of the incremental MIDX chain.

Let's de-dent the inner loop of fill_packs_from_midx() by extracting its
contents into a separate function, and calling that.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 62 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 7802a4b694..2afb67d728 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -938,6 +938,38 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 	return result;
 }
 
+static int fill_packs_from_midx_1(struct write_midx_context *ctx,
+				  struct multi_pack_index *m,
+				  uint32_t flags)
+{
+	for (uint32_t i = 0; i < m->num_packs; i++) {
+		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
+
+		/*
+		 * If generating a reverse index, need to have
+		 * packed_git's loaded to compare their
+		 * mtimes and object count.
+		 */
+		if (flags & MIDX_WRITE_REV_INDEX) {
+			if (prepare_midx_pack(ctx->repo, m,
+					      m->num_packs_in_base + i)) {
+				error(_("could not load pack"));
+				return 1;
+			}
+
+			if (open_pack_index(m->packs[i]))
+				die(_("could not open index for %s"),
+				    m->packs[i]->pack_name);
+		}
+
+		fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
+			       m->pack_names[i],
+			       m->num_packs_in_base + i);
+	}
+
+	return 0;
+}
+
 static int fill_packs_from_midx(struct write_midx_context *ctx,
 				const char *preferred_pack_name, uint32_t flags)
 {
@@ -957,33 +989,11 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
 	}
 
 	for (m = ctx->m; m; m = m->base_midx) {
-		uint32_t i;
-
-		for (i = 0; i < m->num_packs; i++) {
-			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
-
-			/*
-			 * If generating a reverse index, need to have
-			 * packed_git's loaded to compare their
-			 * mtimes and object count.
-			 */
-			if (flags & MIDX_WRITE_REV_INDEX) {
-				if (prepare_midx_pack(ctx->repo, m,
-						      m->num_packs_in_base + i)) {
-					error(_("could not load pack"));
-					return 1;
-				}
-
-				if (open_pack_index(m->packs[i]))
-					die(_("could not open index for %s"),
-					    m->packs[i]->pack_name);
-			}
-
-			fill_pack_info(&ctx->info[ctx->nr++], m->packs[i],
-				       m->pack_names[i],
-				       m->num_packs_in_base + i);
-		}
+		int ret = fill_packs_from_midx_1(ctx, m, flags);
+		if (ret)
+			return ret;
 	}
+
 	return 0;
 }
 
-- 
2.49.0.641.gb9c9c4c3bd

