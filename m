Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F17D13C69B
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715103; cv=none; b=a1JXykSPH038avCuEeWyBqVGsqfBDBQupU2LX7iNQkexvP0L+nCsiT/oFxpzOLqFX9bQYM7aQA6oNMoTzZgKd4u3UYjZgZQEZ9ijIrANT21+IVNmS8SURXw7UTg+kuoW3Av8WWpDmJ15red04jGOJZhdNi03WZbyktLHG2UUhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715103; c=relaxed/simple;
	bh=Jx+EKax+f7OjPev5cLBiFJyyZy6Esium833KHPLgd44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSYRrPIP9cfyBaC/7ZuOdNMWtLXvRcqrgmIt9tpZ3lOXmH+SMNw7Djq6WtOKysWxvzWRO2TzpQt1WAHvxKZRetW175ssXffB5vCIHK025upnuWlR+I+G0uQKdhG61uIrpskS9KRvkgp3kNWxN202/eHklKrAwxxYuZl9TR5ois8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Z0MPs3WW; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Z0MPs3WW"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6afc61f9a2eso12149646d6.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715100; x=1718319900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkCtS+Wk30MAcBbc1irqppF/G8S5cfZAS08t28BM9eY=;
        b=Z0MPs3WWG+lon20HV70ysuM0GEpuMaAr4GcwMlBXYHPCBSLTSkkabqwGg905J3cwAy
         Kge4pjepFterkjT4pqcWrfDP7lJJPrjJvoN+tLnFrbjfkTdflG2/GBEp16qMzoNDoOpc
         L4CVgC9xr+OoZfT/M4q4d8MgR49jbmQygwukDJ8aB0y1GLIS9x/KWN/tKfN9wBLVkKbe
         el3U731fxP3YCcGMELLJGdahh3um250SV9pxWid8QgpDCHQa0KIiY/8ry8SiuX5TR79G
         WF6YrAhkwjinSjuO7wDxC3LLRIqQYBIvTqRPYNThCdIyeuYHAMoZrD14nfF/4xBJlyps
         zPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715100; x=1718319900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkCtS+Wk30MAcBbc1irqppF/G8S5cfZAS08t28BM9eY=;
        b=PKJ4qhyXrFN8poVD4uLEcyOJXpouf17oE2oKoDVJ8tTqPbSNnqtLnDurdfxMwWuraf
         CCaxx/vbEEObmsRi0NDecvQf92plpiv+ueijIdF7t/oY3stcgxUtljIc6GHMdXlDpN4e
         +pE92Opu4TJslAwJfxgUUU97ZrZoCqZPSTgejJ5p3hXGR0n1lFWDUuBPLWVdwFacnZxF
         UE2IFXTKS6s2I/2n3/6Qix8SD2HMosSx+x/n/foLi/rozaLcSAUOX6bulNAKbc5qw3hB
         apnxEPLwnjBTZ1zeLvUUJ47o/uk63tPXQure78WnOPWHXx5S0NcwUw6YQBC1d8cyCk8O
         bFKg==
X-Gm-Message-State: AOJu0YwQHn2Wx81dZAObzX9uGh3aOxcohD6ymIXGTOfBpLUbPHcb4+LD
	60IFvO4gz3AIkjlmGu3UJomR1W6tjyfeabzK9ucM1miYvnZ1xlpEpTIuFwMRzCWKEwnp/lSKHIT
	FnMQ=
X-Google-Smtp-Source: AGHT+IGpk6a6r0GZ1sKdY6nLj0Y2bBg83rGG4AHLc9mE+T2p7Iq2UEQ2Er6dbjiYR7MA6esWuH2jOQ==
X-Received: by 2002:a05:6214:3217:b0:6af:c64c:d197 with SMTP id 6a1803df08f44-6b05952a874mr18647676d6.8.1717715099795;
        Thu, 06 Jun 2024 16:04:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f621640sm10554406d6.19.2024.06.06.16.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:58 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 11/19] midx: remove unused `midx_locate_pack()`
Message-ID: <02b1d39fd2aa0da5c2c2591aae1268498e70aa05.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

Commit 307d75bbe6 (midx: implement `midx_locate_pack()`, 2023-12-14)
introduced `midx_locate_pack()`, which was described at the time as a
complement to the function `midx_contains_pack()` which allowed
callers to determine where in the MIDX lexical order a pack appeared, as
opposed to whether or not it was simply contained.

307d75bbe6 suggests that future patches would be added which would
introduce callers for this new function, but none ever were, meaning the
function has gone unused since its introduction.

Clean this up by in effect reverting 307d75bbe6, which removes the
unused functions and inlines its definition back into
`midx_contains_pack()`.

(Looking back through the list archives when 307d75bbe6 was written,
this was in preparation for this[1] patch from back when we had the
concept of "disjoint" packs while developing multi-pack verbatim reuse.
That concept was abandoned before the series was merged, but I never
dropped what would become 307d75bbe6 from the series, leading to the
state prior to this commit).

[1]: https://lore.kernel.org/git/3019738b52ba8cd78ea696a3b800fa91e722eb66.1701198172.git.me@ttaylorr.com/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 13 ++-----------
 midx.h |  2 --
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/midx.c b/midx.c
index c3802354e3..186d8344dc 100644
--- a/midx.c
+++ b/midx.c
@@ -462,8 +462,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
-		     uint32_t *pos)
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -474,11 +473,8 @@ int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
 
 		current = m->pack_names[mid];
 		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
-		if (!cmp) {
-			if (pos)
-				*pos = mid;
+		if (!cmp)
 			return 1;
-		}
 		if (cmp > 0) {
 			first = mid + 1;
 			continue;
@@ -489,11 +485,6 @@ int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
 	return 0;
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
-{
-	return midx_locate_pack(m, idx_or_pack_name, NULL);
-}
-
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
diff --git a/midx.h b/midx.h
index 46c53d69ff..86af7dfc5e 100644
--- a/midx.h
+++ b/midx.h
@@ -102,8 +102,6 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
-int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
-		     uint32_t *pos);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
-- 
2.45.2.437.gecb9450a0e

