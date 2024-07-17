Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979F188CDC
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250753; cv=none; b=Um4GTUrwDbgyczZAKFTgfYgnXAIIgVW8N5uhXfDBZZA29+s6zHpUktRvrELB4BPgPJCpPaWOfyOQsQfvIVKlfFIPw8O4N93SFBDoPY5H/zxBukxL6f5yLOOLlD94iqW2fk7KlOS+f3jHsg8QLgZSrnil3WaFOcNqPCMWz4fuMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250753; c=relaxed/simple;
	bh=IqcyzxEercn3gQXpgKMAgTaIphSF5/oTg5WI4onxlU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp8+vTBmPQelM7fvxAI/dsiPrexBqVbOk9YaasEWofA2QsKc/XOep0uhsLnoUdN9jh7KxRjxUHhSqGNkeORYF/uQRERWuyj3iQvuyw52hmUne+EMN5XLbYN/VD2YE1px6/LNAHZtm39OO5V0SDfNz2zkFBZLijEf2XcThTy6vss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kRgXwcjj; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kRgXwcjj"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6512866fa87so774197b3.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250750; x=1721855550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e74Z1x1jZ+hsBKN6Lza6AhIkxE9dD8u6Nwie1Vz8AIo=;
        b=kRgXwcjjKbOqVIIVe3Z5bmR+z9CzbIfpfoWDofb8PQ/2DfSgnhyKq9ZeQl3i1nyVcf
         3IZ6QmiYpW5O2AvqHXZ6677bxZLgL7BSKw+BnYeuWVe/8BED5uZmLrcXIzh6vj4hKSgq
         qahEZ8cG88vL0j7EFSFQBtJ6BLmoixONWP+AK3//NizJVj6qGJTqYppNBBud5lGLZhUC
         LPZUtQtAgKKwDP3wOegMNa9AcfRO8gHS/Ti4oEOgtCN/y87L+7Y5uJJte2/FHBWwdli8
         clEY/iTUV84EkVkPFicoc2U13dYnZIVKReqNlWtrSzpHrvCQiMBnM0xW+g6Ug3WmmkUb
         GOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250750; x=1721855550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e74Z1x1jZ+hsBKN6Lza6AhIkxE9dD8u6Nwie1Vz8AIo=;
        b=ujlF3B1rwygkdHHbii2sw8t5tP6AxH/9fbVlDroSDI5ExPW0sQsqnEH6CdXSMUpQN8
         wol32wzH68YP5X6I0Fvww2/okRlIRYkaopOChbA86YVpjug+TN5P7flMh3F4uUbBPj+H
         VtzmWxHgEa191ssp7XHz7Jgs49eV7JlgYsZZnXtes/uFbO5i7t8j4+yi4y+qrlsVR93c
         xh6efaoyK6n7AKvREYehjtYOo/+1zM8G2+N/gW3HY8M9oN2pS5ItHt4AM2++mchplHqD
         kPwmlC9TxhahBpBMvqm2MX+PixcoykndRtm9/HLeoOs0ZD1LRH2HS0Pnn2pWkR0ztHvS
         nFBg==
X-Gm-Message-State: AOJu0Yx3W8N1MaoAwH7WQQlPZSLhZI4+WXjajdfue7CsW9SmrXDUze/i
	+Eb48AxHAzy2+sq0FpOTdag9MnLyTJvhPRfcQzSM6KjyUD2zIqo8md3XJBkVe1ccL1pCwVtX68f
	H
X-Google-Smtp-Source: AGHT+IHQIJCHC6rv3uGz2PZBvYjVI/6/QMmeN0xEEpCkwuORZaWeQDkF+HbqUFAjr48HHQIUc2T4Aw==
X-Received: by 2002:a05:6902:1548:b0:e02:ed0f:e83b with SMTP id 3f1490d57ef6-e05ed6b96a0mr3432497276.11.1721250750601;
        Wed, 17 Jul 2024 14:12:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05fea86e65sm84425276.35.2024.07.17.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:30 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/19] midx: remove unused `midx_locate_pack()`
Message-ID: <22de5898f3fec0cfff4289660b5f52aa31533fe1.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

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
index dea78474a2..59097808a9 100644
--- a/midx.c
+++ b/midx.c
@@ -465,8 +465,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
-		     uint32_t *pos)
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -477,11 +476,8 @@ int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
 
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
@@ -492,11 +488,6 @@ int midx_locate_pack(struct multi_pack_index *m, const char *idx_or_pack_name,
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
2.46.0.rc0.94.g9b2aff57b3

