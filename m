Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C50E78F2F
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500548; cv=none; b=BLkQO/lZM9QWsWLvhU1STELNUhVYIFpa4lHvMr9jmy1JvFkwqW+EBvcPDqi1/8lGqRTa9/rExywzj6n6CGB0hro8nevYZJt+KhQFM6QXxOO1CDYk+pDUizeXJN7dFcvey9H98Sulp4ejWo3EbQWV9BCxjauxpc7gtx5Ncv7CM/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500548; c=relaxed/simple;
	bh=cxc70MEwxtw/enRXaTBXRn8mdC2HROZZCx+g9ObnsXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/4Re6XYw3t7vJfUWwVnb1SRyIoRf+/eMmSA3Hzw6ehqu+EjaFFSA48lA2uRrxK44BQGDFEBeGczNQfmHnQ4eTXKwFPHtmrTLWiXafE9ZUK++JWXomTJWV5Z3TaN6vZYe4LJcNTagKQ61170VqqDJrwVm6JAQNZCXwrCe0wcleA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Q3UAzlYl; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Q3UAzlYl"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6649fde483bso1237397d50.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500546; x=1783105346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsEPK7AshQB+Q7F1WrAIjr76UJXi4Iw+x/oV8/reME0=;
        b=Q3UAzlYl518bwHz5sg5zjIqPcLjKdSo/EpF1VDgX41BACKbtcVyJncW6ZV3gSMgk3j
         DBBySiY9bVm9Y/KLMzAFlxnmaCFY2v6LSS64bKuH7L06VT1b8NtTmZB/OKK7pT6ZIfOK
         rdfe5ax5iuTFSC+GDxdCqpqMxxaqnAGq0zdIU/hBmJrSArfP2LNOP+qa/4rr+btyjVnX
         l+8KPQsejYhW4770v5nYWtejoWsLJn0T91vo3N9aBjsH4zcPF5ZTggJ40Y6Jyy2iFEOR
         Mmax/TNHHXSyf8P28+s1b3PXlwjduhX9qxMmaxMaL9wGCJo90RqL//a4oY6lDf0/PDpo
         itnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500546; x=1783105346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsEPK7AshQB+Q7F1WrAIjr76UJXi4Iw+x/oV8/reME0=;
        b=TMmyvqUPD6YYAe7GMPgasp3nL/G5lcaidwHYpPugcbFEZ3JOqVwNTRYHekit+c1ugQ
         qKgeyq9U3QcCGWwFMrUDFyfc02W3nejvHICH1cs9gMomOTnSM9sJcZeiotItsXGYoO69
         tLu95HWcZfUytvD4vKhlLiWZQ9a57prilpXUL4yjJdYSaUDf3VlkC8TebTx5Sli6nk3N
         nlbtldOjiJ2yQQjAJ93vDgD6FkpPxQgj3Zyxh3alpL78/Fm6NuQRCr38gYFtQ/ufE3mO
         BhGqUfHOXemGyn3h/QLa5t0cGa0sYQzoDCu7wlSCn+sJ9SmiqESDWYY4uP6AXVAwsdvE
         TZsg==
X-Gm-Message-State: AOJu0Yyy86GkfflQxOcRWvDrCY2ZLzma3xpQWVTD1mx1wlARERQDQgcs
	gp7euDN4wROZMPalnpvL6uNUG5xzgKOb7jWGtSrl4b3BMvoqa0QSXoLAANEOjy88Hd68YGk/RmT
	CsV8PMkLWJA==
X-Gm-Gg: AfdE7cmEQRCWOf7ek9C0g0Ni0QgqROUHpg51K9i6P1WejCT5Z4WKdqAK3aAPqNPFvCI
	SJBeaMeG8VXUKAnk+B+WfIIVuwXIYDnNpp4cPZ7377GU8WlZa8bI185/JI+Zm9fsaUKBW2LTuKx
	I43iNRfW/udcnAzF1xYIUpuLcow/F7xeth7ADKbeBZppH6xFT4oy4jxRIB3cYryFjvbNa+Sba74
	yXNr82GuTD1egCECwAH3c6GQK0Mgip2ZD16W9hq3ncV1QFGJL7HrbCRAkvntggZNgMZDZH2m44V
	5L/iLus8pMPRTwhie4ZL3Sd43cXSahl+qOJwr52xfhyKZ2OiN+g9dH/QXmIzW0n9RpqdulsIeKS
	DPdm6b3yns+VwqA3F6hX45cKGU8nz8JiiM9TVYnyD2MeCyvfQ5oryua0ZSnXKXTKvoZL0vGUqDc
	q0t6yzcWTPCEDR9YO1LDSbRYLLhlGYM2BYxNJX/AnW7R1p11XIOoY08xrBrTwTintGcO4//o2mu
	bDlNqVWmDYIGt9CEWxVh5grIOiHYIEHoKI9ao6HI8GBR/X7ZIl9KM3vfZNztzvG+ekDXlBPiJTG
	tj9EYxhJVkiePXgq
X-Received: by 2002:a53:ed06:0:b0:664:ae6a:e9a5 with SMTP id 956f58d0204a3-664ae6b0d2cmr1221881d50.75.1782500545653;
        Fri, 26 Jun 2026 12:02:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f963737sm3316763d50.16.2026.06.26.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:24 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 04/10] repack: teach MIDX retention about geometric
 rollups
Message-ID: <ad76f06fc7ed304af97c73a5931e1ebc5f2d3895.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

When writing an incremental MIDX, existing_packs_retain_midx_packs()
marks packs in the existing MIDX chain as retained. This keeps them from
being deleted by the later existing_packs deletion pass, since retained
MIDX layers may still refer to those packs.

Geometric repacks need a narrower rule. Packs below the split are rolled
up into the newly-written pack, and should remain eligible for deletion
even if the old MIDX chain mentions them. Packs above the split were
marked as retained by the previous commit.

Teach existing_packs_retain_midx_packs() to skip packs which are part of
the geometric rollup. This does not change the current caller's behavior,
since geometric repacks do not yet use the existing_packs deletion path.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c |  2 +-
 repack.c         | 43 +++++++++++++++++++++++++++++++++++++++++--
 repack.h         |  3 ++-
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ce979d86d96..66b46b86896 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -576,7 +576,7 @@ int cmd_repack(int argc,
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
 		if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL)
-			existing_packs_retain_midx_packs(&existing);
+			existing_packs_retain_midx_packs(&existing, &geometry);
 		existing_packs_mark_for_deletion(&existing, &names);
 	}
 
diff --git a/repack.c b/repack.c
index 9b3cb425431..c7b79a3c113 100644
--- a/repack.c
+++ b/repack.c
@@ -292,6 +292,39 @@ void existing_packs_mark_for_deletion(struct existing_packs *existing,
 					   &existing->cruft_packs);
 }
 
+static int pack_geometry_contains_pack(struct packed_git **packs,
+				       uint32_t packs_nr,
+				       const char *base)
+{
+	struct strbuf buf = STRBUF_INIT;
+	uint32_t i;
+
+	for (i = 0; i < packs_nr; i++) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, pack_basename(packs[i]));
+		strbuf_strip_suffix(&buf, ".pack");
+
+		if (!strcmp(buf.buf, base)) {
+			strbuf_release(&buf);
+			return 1;
+		}
+	}
+
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int pack_geometry_contains_rollup(const struct pack_geometry *geometry,
+					 const char *base)
+{
+	if (!geometry || !geometry->split_factor)
+		return 0;
+
+	return pack_geometry_contains_pack(geometry->pack, geometry->split, base) ||
+	       pack_geometry_contains_pack(geometry->promisor_pack,
+					   geometry->promisor_split, base);
+}
+
 /*
  * Mark every pack that is referenced by the existing MIDX chain as
  * retained, so that a subsequent call to
@@ -300,9 +333,12 @@ void existing_packs_mark_for_deletion(struct existing_packs *existing,
  * This is used when writing an incremental MIDX layer on top of an
  * existing chain: retained layers continue to reference the same
  * packs on disk, so those packs must not be unlinked even if the
- * freshly-written pack supersedes them.
+ * freshly-written pack supersedes them. When doing a geometric repack,
+ * packs below the split are rewritten into the new MIDX tip and should
+ * remain eligible for deletion.
  */
-void existing_packs_retain_midx_packs(struct existing_packs *existing)
+void existing_packs_retain_midx_packs(struct existing_packs *existing,
+				      const struct pack_geometry *geometry)
 {
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
@@ -315,6 +351,9 @@ void existing_packs_retain_midx_packs(struct existing_packs *existing)
 		strbuf_strip_suffix(&buf, ".pack");
 		strbuf_strip_suffix(&buf, ".idx");
 
+		if (pack_geometry_contains_rollup(geometry, buf.buf))
+			continue;
+
 		found = string_list_lookup(&existing->non_kept_packs, buf.buf);
 		if (found)
 			existing_packs_mark_retained(found);
diff --git a/repack.h b/repack.h
index bb4c944d0cb..f0d082df9e8 100644
--- a/repack.h
+++ b/repack.h
@@ -87,7 +87,8 @@ void existing_packs_retain_from_geometry(struct existing_packs *existing,
 					 const struct pack_geometry *geometry);
 void existing_packs_mark_for_deletion(struct existing_packs *existing,
 				      struct string_list *names);
-void existing_packs_retain_midx_packs(struct existing_packs *existing);
+void existing_packs_retain_midx_packs(struct existing_packs *existing,
+				      const struct pack_geometry *geometry);
 void existing_packs_remove_redundant(struct existing_packs *existing,
 				     const char *packdir,
 				     bool wrote_incremental_midx);
-- 
2.55.0.rc2.10.g29e31820dce

