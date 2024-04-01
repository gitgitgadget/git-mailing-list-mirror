Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC75491B
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006202; cv=none; b=tYIw3orHg7VB4jkHNonugzW1AiW4RFZs1IWIGek1jojEub+cRBirBKUq2mW+4L1Xjv+wEAFRY9Sp20GHQ18FB/zaE1myBS1BgCN3zixB0JHdnxM6U+ntxEB9/4+4Hq7KMvEY4ToRcep3IaZLOJ4wqNnR1RA8h+GKbw6DV+VTVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006202; c=relaxed/simple;
	bh=vZO7oc2NhcxM4Rtohri9MS1xTBSDqHIjEPzdxQli/p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuDzjv/iX5V3ks1IlE5snk41ebWo3lmWRVxSG0NED67VJrfdqQPn2RXl4KXAJ5xnU/zWmN3+wsjTlil3MUIQ3EHHF15mJTZ/G61rLT6OB0p528UHRVWYNY+fYPkGHT7eso0mjHjbn3mLyWAqa2N5yxIl+szVFv6AThE2KVGZXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pX8F5Hfe; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pX8F5Hfe"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc0e0dba0fso164342139f.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712006200; x=1712611000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5u9FFC4lToDvBqr7YnfWSIMsbz06LBELHEi4o97Jpo=;
        b=pX8F5HfeZLj3D5xVnsyfSOLjetRDUrLxzVKa11ABtggISgEU+MrqteaBqnJDZBBCZq
         OOeJfCIXDEdkbYr5x6zShSTfgsDV2dUKkmTvTD1qkENwOanv4R252NjmvSSzY8lf83WC
         +bhjt7a1yVvsf5nPtdN1AegTx+6+ejgBp+2U75vrHBRwgxq+iv3zwWUfa/wGsW75UPF5
         71ZkY3HAKRLGm+ixtV9AlJSyS2cJGbw0s1KTODcfbrre84/+/Rt6RS+GreBQIzfQWAlZ
         SjlCLK9PNXMKQAMfmqqd3imo4Hqm9Ojok2a4LQGsMTndZE1fIJ3hgAQWsel48U/QyoEx
         JiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006200; x=1712611000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5u9FFC4lToDvBqr7YnfWSIMsbz06LBELHEi4o97Jpo=;
        b=h9lA4Xo2NIk7v/nHHvNcdiEO6bZBLHr/A+HL65zipZfe3z7d1xJlBR5MrZUycOv90y
         Wj1otUCdOa3f5WOOBbo4ViZkxYhcSqK5avm3dU0oPYeyUse+26RMs35cgjoSc3Bg4Jwb
         CrTorx/F35y+b4S+2QbuxCV1pWrOfSecfkyW3Lpm+7TiHX7nfI9Xr6/+iKVGnjDsHhKW
         qLjLz4lw8QzuntH4+3iSwEQ0hm7dsRKhNK1oE2pAtjPlN0VKv1lu9d1l+nH8oAH7f4LX
         Ry2a4cBtAaA3JFl9PJ4iZPHz1fw/aNZLY7Z4CM682ocdM0IeHQ/WHJ31kekIIM3yNrHY
         Lk8w==
X-Gm-Message-State: AOJu0YxH11IwQaTWrhjsv77oyhi20kd68XrFV5CE7morT1ZGYBIZbqGw
	H1YnQQ0CHRRZlo96VkIu0cKq/npVNTx8jIYyjXXGLsrEzMuaiHpUNU3VOXNyVBFFDX3hSOtGFQu
	DkGc=
X-Google-Smtp-Source: AGHT+IElN7N62yiEziyJHi66J863ggXn4157YCfLDm5kcIEOnFhqnDc48thNo/XWmeGK7Bb9EA28Vw==
X-Received: by 2002:a05:6e02:1c28:b0:366:c49f:9f9b with SMTP id m8-20020a056e021c2800b00366c49f9f9bmr14351343ilh.28.1712006199871;
        Mon, 01 Apr 2024 14:16:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a1-20020a0562140c2100b00696804c73c5sm4846861qvd.115.2024.04.01.14.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:16:39 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:16:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 2/4] midx-write.c: factor out common want_included_pack()
 routine
Message-ID: <0064e363c0cc3288346585a6b4340444ce7b863c.1712006190.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
 <cover.1712006190.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1712006190.git.me@ttaylorr.com>

When performing a 'git multi-pack-index repack', the MIDX machinery
tries to aggregate MIDX'd packs together either to (a) fill the given
`--batch-size` argument, or (b) combine all packs together.

In either case (using the `midx-write.c::fill_included_packs_batch()` or
`midx-write.c::fill_included_packs_all()` function, respectively), we
evaluate whether or not we want to repack each MIDX'd pack, according to
whether or it is loadable, kept, cruft, or non-empty.

Between the two `fill_included_packs_` callers, they both care about the
same conditions, except for `fill_included_packs_batch()` which also
cares that the pack is non-empty.

We could extract two functions (say, `want_included_pack()` and a
`_nonempty()` variant), but this is not necessary. For the case in
`fill_included_packs_all()` which does not check the pack size, we add
all of the pack's objects assuming that the pack meets all other
criteria. But if the pack is empty in the first place, we add all of its
zero objects, so whether or not we "accept" or "reject" it in the first
place is irrelevant.

This change improves the readability in both `fill_included_packs_`
functions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 5242d2a724..906efa2169 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1349,6 +1349,24 @@ static int compare_by_mtime(const void *a_, const void *b_)
 	return 0;
 }
 
+static int want_included_pack(struct repository *r,
+			      struct multi_pack_index *m,
+			      int pack_kept_objects,
+			      uint32_t pack_int_id)
+{
+	struct packed_git *p;
+	if (prepare_midx_pack(r, m, pack_int_id))
+		return 0;
+	p = m->packs[pack_int_id];
+	if (!pack_kept_objects && p->pack_keep)
+		return 0;
+	if (p->is_cruft)
+		return 0;
+	if (open_pack_index(p) || !p->num_objects)
+		return 0;
+	return 1;
+}
+
 static int fill_included_packs_all(struct repository *r,
 				   struct multi_pack_index *m,
 				   unsigned char *include_pack)
@@ -1359,11 +1377,7 @@ static int fill_included_packs_all(struct repository *r,
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
 
 	for (i = 0; i < m->num_packs; i++) {
-		if (prepare_midx_pack(r, m, i))
-			continue;
-		if (!pack_kept_objects && m->packs[i]->pack_keep)
-			continue;
-		if (m->packs[i]->is_cruft)
+		if (!want_included_pack(r, m, pack_kept_objects, i))
 			continue;
 
 		include_pack[i] = 1;
@@ -1410,13 +1424,7 @@ static int fill_included_packs_batch(struct repository *r,
 		struct packed_git *p = m->packs[pack_int_id];
 		size_t expected_size;
 
-		if (!p)
-			continue;
-		if (!pack_kept_objects && p->pack_keep)
-			continue;
-		if (p->is_cruft)
-			continue;
-		if (open_pack_index(p) || !p->num_objects)
+		if (!want_included_pack(r, m, pack_kept_objects, pack_int_id))
 			continue;
 
 		expected_size = st_mult(p->pack_size,
-- 
2.44.0.330.g158d2a670b4

