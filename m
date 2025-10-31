Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2EA32C950
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920548; cv=none; b=RCItPSpbooZDgkDJ/8g5eYpm5rEph5FLpwVKoy28Yta7e/GEII2IrbMedlQDslThNxr6CJ3mE5d2S5nvAiZZprEfyWRz7sda9nTSypWwjXwYP3h9RN4Gs4FrS2ocT+gC0v1zB3aw9okruHwRifIw+l72/5AgkBF4Hzhkm2OIQyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920548; c=relaxed/simple;
	bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qxa6o74XsZy08YSljrkYPNWB866TIWfrpolIMoDiRhHkOurVHVt018Sk0fN0dz7SguZbkyaRT5+RMVpHUTFAW+CmfNu66nC/UHs65jMswRoeQMq+0WR2gDadKru338vd0hPNgpDek2ovkrluMjil2EDItPUa+loPm28qj8aq3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqKlpHeq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqKlpHeq"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so14012275e9.2
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761920544; x=1762525344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=FqKlpHeqomY76x+RQ8Sa+OEpZnFngFbnmSnMxWDA5FQxPXRBmqsC72T1umXGrfAXY9
         dGuGhOPVeDax/4yK8eBlzd0SnW68K6+Y0e75nYReR9ppb40InAGcEueKg+Ouxy7TreEM
         DA8YkAshz4wBpgOA+3h4I38ZHTnuxYpQ2tjpaWg+o6TialwsxV2PVZ314FClmHwLGvaM
         GIYeQMfk5YWNFix3cpMeMEQR6b0Q0JHIUusZ25m3SDoiyVLSiqiNtC37XobLLqGvLDCr
         +qen0NSeYiWZ4em/mqxJD4fvXZZ7Crbm2Z5ajZ+aZYpL+r6pbjPcJsQCJE7tt+aAUwUE
         FHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761920544; x=1762525344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=X/Rl7zsHYEoEK9y/erZZekI7FVy4SEFQ5yDcrHOPd9O+ClElhGsJHhmmbJhuDy+DRK
         JiMAo6gnc+dA/DnkQ84c+sQ76nZdaARqWLVzA2Tprfb1vmOfGQzZo0S0jEVSXFV1dnP/
         iEEYZ+CS+zoZJVxJPxN4uafcm4sWxVTBPf868PsialFmsZzEAyWYd6f+7xyhJkAyaJXl
         MSeIaoZdykLv1sGFtlA4c7jQg/ScJl6PETxYz1LDMPZgp7MHOCqFQL1o5OhFlUQEwItU
         U+vn/AwrC0QYQqQCbKEdOeofpfHjQiIfklvGrMkPzJj6y1/Y3i1eWv0bR+uFvHCnjQrc
         +bWA==
X-Gm-Message-State: AOJu0YwVc8HiRp7Zb3Uke6TUnLPwX9x0U06sLL3abZcPXRU/E7oy5Bdc
	BFUW1ZynNJRoJeZp1hitjKmOfLUeW+dJ7DoavuyhXH1TReAdx6n8P7Xubma6TneP
X-Gm-Gg: ASbGncuBGoQ1P4wf1dP7eSKkxc4ZYBXjNRgvq5fEydu4nnIRB+WEkJoXxy0ax6RNSvk
	WdkhWgAb9zpogRhwhACULI5r+pu88zhbLxfUeIf5KHFa6tgapDUItqhlAj/sT6Qi6E/5PgGZN7w
	wvFkpvWVagGBQ722KAxb1b059AIHxZ2SVPkI5isQ6FhgCv/iIYAC5BbZ9sg7z0OaZxcpq3gXe4r
	4CjsOHrPGbLbcrsD0yx0cIvz74LVzqKbOT6/YEDSeLrCKOKjfVv9MPh7PLKoTM4BiJ1A0U7DMAn
	zFrW7meS1mwGP9ZzTOMZlh1QFgAi1h2S6V11RQsYUPE25Z57sKIi2vLaEv4tGCumJKCcjelxC6p
	MkUnwybCMeV1SrQOn9UtRDCImf6m9eSj+dyhcaBdRjRLOWGnKiynGvm3eQp61AunoVJ9WAPtsCR
	cuqgM=
X-Google-Smtp-Source: AGHT+IFBUgcmQ7qhn6CG05A7QUgWt+rOnALoIkhCyw1SjbEX+RqnM9O25oBFH3aSeaeB5Fzx/EU+Fw==
X-Received: by 2002:a05:600c:a42:b0:471:3b5:aeac with SMTP id 5b1f17b1804b1-477308029ecmr35910285e9.15.1761920544495;
        Fri, 31 Oct 2025 07:22:24 -0700 (PDT)
Received: from [127.0.0.2] ([213.61.187.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2eae9csm570435e9.1.2025.10.31.07.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:22:24 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 31 Oct 2025 15:22:21 +0100
Subject: [PATCH 1/5] reftable/stack: return stack segments directly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-1-a03d53e28d0e@gmail.com>
References: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
In-Reply-To: <20251031-562-add-sub-command-to-check-if-maintenance-is-needed-v1-0-a03d53e28d0e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkExh6toF6J7PdbAm4pq/aA4gOJJ5pziwhpU
 j2ZltepzAD0s4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpBMYeAAoJED7VnySO
 Rox/pn0L/2LojgNnI/xlo3GhTa/sqbtBUg5MGFkXdr9myeRoZ4InN5jL5MhdJJaHfBKhO3+oku4
 JNAjHXgr7KE7ulhglfvx8D1ZD7neazoLr/vGl2rVgIJI5yNK3DtmTLGKG06Tdr101mBTB904mkt
 UWKkUJ7Qwv6ORwdIrb1eGXgNyF7ZeWWBgvvqK+WyP0RbqwjO5hiK57q7Qk79fLvV9yeZoqgaZCW
 EjQWzSHSLC23r7Mc5o+wz0A94bkszxOao0juiJcHeL2JYozwDGjh0FbRQb9SpIVeKmVnCfypnUr
 Xz2PzIFSGzm+ZJqnrHZ1z0ldxCSDWo8eghsquXDB84t0hGSurGULqZFW7+9NHpVY2gg2X+p97pk
 wuiXHqnYFqRG/ud16i7P92xKBCJT3CfxKZxS22LZr8X6jHUJE3pBFwVSoEclPRAVZ22S7cdkUZh
 I6Fa78Pa2ou3cDbUhyy2F9yf033zaEdxUtWaUzWH5FnuDGfQIicxZhhZYXNgGpaaIG2LjHfo6F5
 4k=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `stack_table_sizes_for_compaction()` function returns individual
sizes of each reftable table. This function is only called by
`reftable_stack_auto_compact()` to decide which tables need to be
compacted, if any.

Modify the function to directly return the segments, which avoids the
extra step of receiving the sizes only to pass it to
`suggest_compaction_segment()`.

A future commit will also add functionality for checking whether
auto-compaction is necessary without performing it. This change allows
code re-usability in that context.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 65d89820bd..49387f9344 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1626,7 +1626,8 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
 	return seg;
 }
 
-static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
+static int stack_segments_for_compaction(struct reftable_stack *st,
+					 struct segment *seg)
 {
 	int version = (st->opts.hash_id == REFTABLE_HASH_SHA1) ? 1 : 2;
 	int overhead = header_size(version) - 1;
@@ -1634,29 +1635,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 
 	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
 	if (!sizes)
-		return NULL;
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	for (size_t i = 0; i < st->merged->tables_len; i++)
 		sizes[i] = st->tables[i]->size - overhead;
 
-	return sizes;
+	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
+					  st->opts.auto_compaction_factor);
+	reftable_free(sizes);
+
+	return 0;
 }
 
 int reftable_stack_auto_compact(struct reftable_stack *st)
 {
 	struct segment seg;
-	uint64_t *sizes;
+	int err;
 
 	if (st->merged->tables_len < 2)
 		return 0;
 
-	sizes = stack_table_sizes_for_compaction(st);
-	if (!sizes)
-		return REFTABLE_OUT_OF_MEMORY_ERROR;
-
-	seg = suggest_compaction_segment(sizes, st->merged->tables_len,
-					 st->opts.auto_compaction_factor);
-	reftable_free(sizes);
+	err = stack_segments_for_compaction(st, &seg);
+	if (err)
+		return err;
 
 	if (segment_size(&seg) > 0)
 		return stack_compact_range(st, seg.start, seg.end - 1,

-- 
2.51.0

