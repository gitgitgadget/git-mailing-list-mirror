Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C23B841F
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438914; cv=none; b=HdconzMb5YNJZxO1vI7d3JKRLMCMZ5+a+mmcwvETP2MtSYKyV2Nsrn+MBumnZ4rJSYwSU7iOGCLNHcUFky/aVdKkF78xqyY+OC4lcK79pfo8wZ5JyVIO0rn2yJz1QIeEsGVGsh+9bt2dfTYbeuNpxO5Uz4X/4l3ZTse5RWSbqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438914; c=relaxed/simple;
	bh=LRzFuLBaK78WgXMkXKk1ZhL5tX3maVni/udz2foNawI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njtDNF75/rR+lQ0b1ziKB0Xn/IN8FPBaigavbSXz/grIvPWyQVPl5scq+3k+pQnUA8fd0oKXoLsPTb8+GsvZ3A88TZ5GTnuCBCpA0mGGr8VpGkf6R+YKx7RMk089sN0hIWSTtLQ6s0k+m9uOGxvG5cQXIfCFtLA5xbAxq1qAoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HRvzZ8p+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HRvzZ8p+"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dfe7712572so35760357b3.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780438912; x=1781043712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e22LXOZuStG5QcoiujsF59hu3iidj7RAgMt46TFCjFM=;
        b=HRvzZ8p+mHY0csadquZ3kjMId0tL5gjIo5vnkRxe6L40EPpGFTOPeaaYyHJbZKFC1z
         ePccPnuBB3Fgox2zQDJvHHkMhHKwRqY/6Ka7DBN9lvXdFpQSpkFEe7cx2sYog6dgDjsh
         5mnkLbJcqUxi2bkOJjfT4zXIJxQsJZH2Hkd2u96+ohSI0pgRCmMZWgXykxcdrA/Y+f/Z
         7Qm4ZPuqbl4pwkXC4e6ppH3ngdzpX103R/3amEHD/pDLdbary0+1mD666GGFdAtwuLGY
         LaPIgxi9eMHz5cCwHX/6SZBmoGI4YY6qPC28ipbajC628bUI80gIRrar9E0ifMDDALhW
         9JaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438912; x=1781043712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e22LXOZuStG5QcoiujsF59hu3iidj7RAgMt46TFCjFM=;
        b=ADMAPcrvNHT6cyk72eI7DwqsrO2boBdgBVosY3t36qNfakkvbsjSWhKzLy+V4elGH5
         V3aWJBoggiQ9qn5cIluDduMOGaL/DSPmMmqWMUwV9w9qMxw0PvwGWfwvqb/h94fBBXtm
         2sgfS0UPwG4pMS4EkzFleUdMegqDIClQVqMgIAnFEGKvIYSgpL71rY/jkWzVzThrZpO6
         ME9/B41wGO3stHsSGudLM+fcySUlxOssXfG4mcWeSShmwaWmMwe9/IqfnB9b8vTcpTiL
         1Y8muCJfofdRKPZEFdAhxgh2m/3Q6uvxdeIVuJHoB9HfHoiTmeZSmtJwKshdLJAtBpRW
         Nqng==
X-Gm-Message-State: AOJu0YyfA4o0l/iwAT2tBx5EolMKm/GjVpTRUIkmZjJEw0GB070OHJgs
	HALA3FfYJLN31Cbi2DhEQuMasYgXxWxEAYGKMD6m268qoBUWcJaRF8BhdGGz4gsXVM31b6uDYau
	q1K78I7A=
X-Gm-Gg: Acq92OGYrGLYM6hBKfdzZZLcKaMT8Jl8UtCXAv91vwor7E708roBB4I2WEn1BHvBU8E
	Ak2MkaXAvJV0XLOP+5sOhHsSJA2f9WOXD02tVZg42NRsYUBW2LIGVutG3nXSuQ9YQW3NbkEywpT
	Lt7bEAjuf8P3ezGVJjiaV5W3C2Td99QJ0etH0lC7aW5QpfYtumPTSSGzsX0fe+BqjSHmWaEq78t
	xIQRGJdmUj/Y63hml+zN0VDs7xh8GggnchnrNeSwFykW6gHcIGCr+xnNoJbOVWo2tJSF7uJMH2U
	kO51kfZM26uUhZCs/49COGPJZoRDU9JPLMYsx8hz2/4PM3o/hsW6FlVQrPeTUABaN/dBD6iURKF
	JWmfDy27VMB41xbt/nFZbEBAAAsOwk7rqDBzThWsD8jkWIN396xUEgaCTN5nxy6Mj/p9eE4jgCz
	tNCFvSkO/cCT6vlE0un0Pc7kME5B1w+JJBd6C2YRcpxI1QXQF0WLJ9h+5V8b9AW1zCQ0NShqg7H
	syNG9fdCcTcep2KL2IC8poYYSDsL68rHww4vmrTRx3Rge/oK3yvVE7Bk3gGS6BnJpqxDtV1icTg
	FVpKISOJPwGT4qUq0NEwlSjNU3w7I5WJFYvsCA==
X-Received: by 2002:a05:690c:c512:b0:7d1:b184:5407 with SMTP id 00721157ae682-7ea47cde5e7mr9293817b3.18.1780438911967;
        Tue, 02 Jun 2026 15:21:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2409d513sm6299057b3.49.2026.06.02.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:21:51 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:21:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/4] pack-objects: extract `record_tree_depth()` helper
Message-ID: <069c50d337002680e19eb6c35e62491c35b3becf.1780438896.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1780438896.git.me@ttaylorr.com>

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
2.54.0.23.gae57607b57f

