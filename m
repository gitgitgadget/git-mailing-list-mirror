Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E33AFCF3
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206284; cv=none; b=mKsqIWZX5MEYntgsf850JJeJLao14QeBUuLi2JPE055UFL0VxuDf8QofH4GtHTDSQKBGSWrCNV8/j8ef3GTP2vbcXI/cNAuxBCcidefVuYuoee1nVLjt9fKComucwugEhOV4GmBPCQdag8HybvhWqOV4RRMv+8kK0U5iAjTc9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206284; c=relaxed/simple;
	bh=17kiY5azNdoPVtt798bXVwwToHLxbmGbyNNlWYjvQ8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdBDcedLPuLxWJMobDzcZNxteL+9tEBYqWpifhiUuN85/WZvh97JQBB4B+ua3S0VKBpUolguItkSx0U1ETMivochb7RLnZnA4ZNwW84Mm//z6VaQRpl5lcIUshBVK6dhucQoJToBAbJh13OIHpKtgp5PvuW2TSwdzRL9a1B9LRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=k8kFPU51; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="k8kFPU51"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651c5d525f6so3825992d50.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206282; x=1779811082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/PONC/5xmkFQNUQS7vZGf0um1bFhHvGd5lRSLV1hRk=;
        b=k8kFPU5159oUFPOSZaLHfheqUPBzkucdiYsnvLg5rMfQn/921SOoyKncahZjrC6VYu
         Xw0m5O0+HdCz1F+TzeU6E656o4tRFwVDj3XkTZABFwFsTXbg3al0vlRRYhioK9MUeBcH
         55hI7v1OUDPZ0uOARdtkBAVswvTYH7MyWIJJxHfyOKLCK/DGzI2/zaacpMUgvtHaDb9o
         VCkiGu+yOK/Fmyj2ShaWo9vEZ13o1LbhANS48SVgaoEfhX/DuEi+BQJFHtqyOTLtv3Y7
         21VVWR1g1KEt+4uD8a5DMtq36co6ZZYncL3DurbOJuG6JoBOvl4ADgBsUTluwdzLRn3B
         B9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206282; x=1779811082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/PONC/5xmkFQNUQS7vZGf0um1bFhHvGd5lRSLV1hRk=;
        b=PeYydSgwZKiyl8MVgGjmGghK77SnLeo/C8uG9MDwl2y7C2ZZcu/gUtvlHNL1eyMuYL
         hZEw+cA1enqXIcVE/sk3/9C7G40SdMQlzU+JElpevAWt757FHz/M9qdDyCBIdGpnxQqz
         m4X7o5oZRdysWyvhpyrNWYdgtZlQeyUwSItzV1qYoaLtqZfn/Q+Kz5tKO4p8WmvhQyHU
         8T2vDjbPWLucPUn6TXXqnPLSlEm8HuK3v0fgy+UW1sZO5lthQBMwcyjyoCWvA9kyLGwF
         15x1z05kXusiZPAZG2t6ktAejqzHgyWDli9kGM8vJybuRmKBFv8NEQYXTyVZgUGNrD9m
         RXaA==
X-Gm-Message-State: AOJu0YxYLFw9Dt/Q5p2hSgdCZn18MLQodX2lDlL8Iyqv9NSLovLWTFzx
	1o1UHUrpWBCuhuE74+hfH/iP3jEbcXGJQJR19pIBZf5Cx7gbNQwdHxUe6JSath+Wafi8PUN99jV
	r+PhGSxq22Q==
X-Gm-Gg: Acq92OHkQQWBadDP7YKoSKvS2CnN+ZTAJ4Qa7NszLBgWfqUottx2P6f4LtXq0XRVVGn
	hlujmWGqNWLy79s7ACwCvExHQT+AI9FKu5bXSe1cbJw6AM79FyuV2njJEbt4YNOLNmxJNWqUltK
	Vyc1L5z9RJAJWbNz2TdGLWUhcmdH8Ao2Bh7dTq90MbNxkf2WApjFdSpDkxfTKfuRw3Fvd99LNOz
	0v8eiFV4jW2xGzpX+F+2SYRdBxv2W4mIWcSmtzgiw3t3/gToU6AJ9Gl+eMWkLCClQHZ+QWftWgb
	pGogDt6wuF61pZFVQoCdtuAkLWyUUxKU9AIGQvu7MlW0OAXJjtfpYNcI0D4GRjAf8rhb4WIuVKC
	6bnNhyHl07xGte3+zrGjKOxjTWLHLkjJUrea83ytdtzNS3AFh/UHNkGwtjMNJYsGtp2XWDO9Na+
	VhxpLCtFid91zEv0NkDhjaw4LpAUBguPcFMSJ7/qTgNdb4qHJ92b4I3F+hHHAjrbtCdNHyg39r4
	ipbwa4DLt8qr2hSMcj8vH6F3zrRbHSQpmApGRcKjrIXaFqjcj6hxyDq/OExN5R4BuU3hCxEOGEf
	bJkkkn+0plitZ00p
X-Received: by 2002:a05:690e:d4c:b0:651:c38b:e60e with SMTP id 956f58d0204a3-65e22685cedmr18931918d50.4.1779206282085;
        Tue, 19 May 2026 08:58:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86bc02sm8007240d50.4.2026.05.19.08.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:01 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 08/16] midx: expose `midx_layer_contains_pack()`
Message-ID: <8d1b8b1d301313cda1a952b02b162ccd02f40c01.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

Rename the function `midx_contains_pack_1()` to instead be called
`midx_layer_contains_pack()` and make it accessible. Unlike
`midx_contains_pack()` (which recurses through the entire chain), this
function checks only a single MIDX layer.

This will be used by a subsequent commit to determine whether a given
pack belongs to the tip MIDX layer specifically, rather than to any
layer in the chain.

No functional changes are present in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 6 +++---
 midx.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index bcb8c999015..dc86c8e7fee 100644
--- a/midx.c
+++ b/midx.c
@@ -667,8 +667,8 @@ static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
 		      m->pack_names[*(const size_t *)b]);
 }
 
-static int midx_contains_pack_1(struct multi_pack_index *m,
-				const char *idx_or_pack_name)
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -709,7 +709,7 @@ static int midx_contains_pack_1(struct multi_pack_index *m,
 int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	for (; m; m = m->base_midx)
-		if (midx_contains_pack_1(m, idx_or_pack_name))
+		if (midx_layer_contains_pack(m, idx_or_pack_name))
 			return 1;
 	return 0;
 }
diff --git a/midx.h b/midx.h
index 77dd66de02b..3ee12dd08ec 100644
--- a/midx.h
+++ b/midx.h
@@ -119,6 +119,8 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 int fill_midx_entry(struct multi_pack_index *m, const struct object_id *oid, struct pack_entry *e);
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
+int midx_layer_contains_pack(struct multi_pack_index *m,
+			     const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
 int prepare_multi_pack_index_one(struct odb_source *source);
 
-- 
2.54.0.175.g8bd0ec98dc3

