Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6A7262A
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508012; cv=none; b=jm2UQC/hndp5Yg14GZApm+gwWmB6TioXR8sjirHIepSarCO2DNo8+/BohfHDX7RR+s105HwxkJ4ZDxl/ugzUcNl7nhV5qFpgEamGSMBv0xZmpKs17C9nXdE19ABVjCNzpBF1GzswFUdWsnIsEFddrogEtWxZzgJL+1az/0hDXmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508012; c=relaxed/simple;
	bh=kBJ5RYCVg5TrZmleC9N83/Z5Sfq61nXDtCZ8OHGG3cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USioWE15bPyCH/HS8sO8dAqMjiGoF67M4/XmYDIQtzqIs8ewQCKx6z0SSm3qp5Wa5PLEDy1W2b8F3eRd3ZemwZLDYSdWdxyzFG7iJCF9oRCFVHDEJ9rdK4JLF4whBA4FomX1zdw4rJsxG+VZdOLyMCjCYm6gHnkOENQfvXwtLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EwBgCoGl; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EwBgCoGl"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a60975dc5so3943807b3.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508010; x=1778112810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dogwEYD6olMWfoakd9pv+Vy4/qhTa6LxyBlV99n/daY=;
        b=EwBgCoGlH3lgEUJmGrllUQsOzm3XzPrY7tTgnlHVGbVNT2CF350dYwGUph9OHclzlL
         SbYi+kpAfL11NAuS4GnbCzQKE41iQ3Po5sJnfRrsIGh7vG2ILKZCqiWo1J/oaZmNK7lN
         jAdx5O8RUs4Bw+ZlHH/w6ySKxzgcax/zwkBQNA+Oe2+QJt7H4fH56zRMjQOl8rrb/aJ/
         ptdCsQynDeTosnZ+C9nuWgltSNVXm+ld3fPhHz4+a/thLPriSCWo6VMbOM/EryZsxPI1
         7RP0s0b7QHhCFda3zQRhD7/C/1CaNbIL615PMHAFdcTMt0CxuN4L+Qfqzy4cmvwRSi+n
         o3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508010; x=1778112810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dogwEYD6olMWfoakd9pv+Vy4/qhTa6LxyBlV99n/daY=;
        b=gQjWLgTCejeaL/7U/gNufhC7M+T8eJDTtlpz9kqIjuCKSjNd5PWtxC86cUHe1R1WPX
         8SNl7gvxIMDp3qemeSg/osKrPrHukqYIaYwsOhJ0iVJNC93Qq3g+R777uRxRypUK5EE1
         TAAK97DfPgiRerD5mDgNnzXdm9kgFeY8KwJhTSsdSwQbd3WuLQT6o65PgJtNduPd3yTG
         xUaYbRCthabXuWQ1XGfEqbyQnPHoylqIP4UmL3jjxEUQk/HsoQKWlGfBRpsJV6neTwXf
         667ur/sOmUU+KFmp3PXBFDk8A+u3bwIwGDD+/I1GGLvlm6UPYNlbz8Kt/+SIporTWEZ/
         BzuQ==
X-Gm-Message-State: AOJu0Yyc0/0VbixavxXKY/NoUabcVfBPth+JjaOoc8jij8vR1ciQUR0F
	NmZp4IMjZGHhHIcCO5VqakBwqEPHAvOTc6BbCDVVvq3UHoZptP6xTFuDC2T9AdlX68b5Y2CgLEM
	ti1HyneUBCw==
X-Gm-Gg: AeBDietpGV1c2wtT0aJmQm/i3Vfquv7d8u7NNG5AIuHUH1xgQ6r4/YCM1ZTcRH4WS1j
	7Sa4GF6rk2kkNgZrePDZ/6QMMnNHn8JRgJHv4Mvsl5VlY7lpD3wRYmhMkobvWWToMWqVQcdyczb
	QqQEtpt37684ciQOdwFVsMrQ24QeQ+IqWKfLEzzk8TACN6kYrtAErkBeka0a7xMWHncCb+NQOIl
	hp7QSv26VpcdB2O9KntoO/+k7Q+xqXuK6Tr5sCcld/1M2KVM48r+5BN1bzhtgJjlQQW/ZVkFvD4
	DFSDShWGO/ST/kLuEeZwC/ry+vOxvJQU7QyM/JQ6qQ5uywXoAr5Bx7csLJPlEQejrTABtEeTqoP
	cil7xFfVdKMS7txSuOEKs1tD48RZoJnNnzbsNy7TrYnMdq1qhaojhPNgZ9oJ16G+VqGz5/bvmxr
	NuiIxZDhzZGLZhwj71mE/k60L/uVK6B0KI99a0GmPyOT7phYP/i+YDmV8othAWp1V7rzZB+G6/R
	3OJjsxDL1XJk7/LnrR0FuAGqzPRsPV8RZHzVjJHbFO7QrlneY+Vzu8ssrTXFlDmdokU/gaprcXv
	9cF9R76Jccyf4a4BukE4KkQyn5M=
X-Received: by 2002:a05:690c:6201:b0:7ba:e315:d8c9 with SMTP id 00721157ae682-7bd52969c8amr10130817b3.36.1777508010040;
        Wed, 29 Apr 2026 17:13:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd5500bab7sm1530317b3.25.2026.04.29.17.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:29 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 08/16] midx: expose `midx_layer_contains_pack()`
Message-ID: <d3ac65c1f11656d11ff6c17fe4e5b02a916585d5.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

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
2.54.0.16.g1c05dfce579

