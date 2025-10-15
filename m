Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764730C34D
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567263; cv=none; b=cCUEWY6+qfeUgQr69a2JUb9caxKJYDyBR9Y/nYvQhsvjux7GZ2RAlXcRYcq9PYj8Cj+fsP9J2MnnTIUQxXTtoxzAyc9ySHJnkASYPNUGI3P4X2CqUhXPyd2WP4r9wHgSBnEkXu0EjBhozxnrqzJ4BDivNv+Sou/Ih1N7UDaXGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567263; c=relaxed/simple;
	bh=UicOh9QPFgzmOV1rwevUjy4DUcsl663b2EPPzjUMAUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDpeyekJVsxa15h7UbqeOljBYp9LfwNwwNhLtklaQSU4A8WvdvGzzm+ocj8qg94Mhpq13vh0aQ2FvqjYTZXS1L22BY6AvumU3rJkKNOeBCIGSszVCdf4yDe76Maw38B7RhX+76ho/eFxKuDvAweqRG4pTY45ZYtUcn2lVp/lF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=alIqSmcu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="alIqSmcu"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7815092cd0aso783837b3.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567260; x=1761172060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZks9+VT59SUA8++pN9WRtFdbuDHPCIU3vLJMtkTQlU=;
        b=alIqSmcuM2c3Y8WUAJWA4ekdfVY1DHHhdkdeY5jHC5EF9n0GJK+85jNq7Smg/eOONn
         Zy1Uni8fBxOiCZar0tyyN2NYHTXtbEAbeCwNvjqAY6b3vISQVrK2EAhYVSjO0S4Z/07v
         bQMenHm52Nyx37d/3HsJe1Urf0CKQ6+XgO77kcvJY/GJNKnKrxqWIqnmJg6oNfwzsNpO
         xEtUdGnfWVUtLantuY+Y0N8ExrgSrZJKSvpbwEv7evANJ6tPeFNekL2Kv1Da3ZGRkfJV
         zbckrlJPhg3wgyl5Vr1m/ciexz3kHchWKjxrMCONWvB9cmQZq6s0zJvSA2Hw7h6D4xmY
         kzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567260; x=1761172060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZks9+VT59SUA8++pN9WRtFdbuDHPCIU3vLJMtkTQlU=;
        b=t0eaqj/Ccjvi4N2IwWShbCLuIKPyehV3fXAdZw2tw1EXtjxTOTVHZa13gUkHEtoIyL
         T0oCRvOrYT72EPn2l9fjEqboYKZ4Pk9N0yFiU92+Akga2YAOEK/SujZxaQDxNrIdVe0n
         Elg0dMXQNcxQ9ekYYH8/bVPBQbRTon3FfVLbFePnJa+DLds0jAXscxfd23QlRmyIikLA
         15lYiryZzc2/ERxSJn6GL9bEY/OwtHOEnCFd7HZwMZ15zsmvL9vhvP0X/7CpJ2LdRpYt
         wYIjNaQWuV+4mi49slrwZFXS9ZPe/flqo0vkHASBZLf2dN/x4/RFYOg5yQYc68a6a1Bm
         s+gA==
X-Gm-Message-State: AOJu0YxEr9rpQmahCX9AziSYYbUFO5U5GNLII17LWEUD9vh4eriZrqYh
	ThCR2KCEr5Lr2+F/JuwVX3q5/8BUSTVmvb+39SG86mHGPSV27pLZIMkRN/Se91ignXwImR670CN
	/UFzBrhlOfg==
X-Gm-Gg: ASbGncvIt/dGwqtxF+YEz73WyGlp71UgMTCKvCKC/ZwCGj4QUcVfc4vlct69K4hnQ27
	IixF8UOYR0ZgV+DpIDe+/Lk/Jr5uSvRwvuY+YeGoCVW7hIfG/F6YzQ7wx8k9vmAytzDHCEfKaYS
	0/FxvjGmWaHjMpmKnWEFp9HNRknqqNJALPDYa3AmLnSAzgAKxzRo+KHYceSZ8V0JKtYGAA8oPcz
	e64poY2+LeOR1sviCLVBHI/b3jcklLfW24rAod1g7cK+42v47eo3u14NW7QQmD56zSPMkxR9n7e
	Fb3K30LLBoVrOtVcUN27WP9Garf9zFyya4qog8GsW6qIkymbc/y6hb/QOVPKd1sgvzWgk1PZRS3
	yZtQRUTrsZarNVueqPzKtHyItwr+oBygh0iz1nrHEPM1nJ+DbbRbYtOJY4Tmtosuu4HWTp7rY+9
	92Hc60+WKDYmaxdA54yNvIVH8rIxsi9NfLJvIV+XoNG2XgSBTwMcv4QrLJER+K6M3CmxvhFtJ4x
	Q/dPwtH7xYIS9ZfDA==
X-Google-Smtp-Source: AGHT+IG9et4E+jJSYIJek8pOiqy3JW1uGdPJDIDMqUshjMZn/CPlajb63urSMO8rWo4D2jYqgfI3dQ==
X-Received: by 2002:a05:690c:6f8f:b0:723:bf47:96f8 with SMTP id 00721157ae682-780e1739e9emr304277267b3.53.1760567260159;
        Wed, 15 Oct 2025 15:27:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7828ced0c21sm2765727b3.3.2025.10.15.15.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:27:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:27:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/49] builtin/repack: avoid "the_hash_algo" in
 `repack_promisor_objects()`
Message-ID: <34b503618a455b30030ab152e925bb47af969522.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

In a similar spirit as the previous commits, avoid referring directly to
"the_hash_algo" within builtin/repack.c::repack_promisor_objects().

Since there is already a repository pointer in scope, use its hash_algo
value instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 7d62959dc2..a7e94ed03c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -452,7 +452,7 @@ static void repack_promisor_objects(struct repository *repo,
 		struct string_list_item *item;
 		char *promisor_name;
 
-		if (line.len != the_hash_algo->hexsz)
+		if (line.len != repo->hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		item = string_list_append(names, line.buf);
 
-- 
2.51.0.540.ga7423965ad8

