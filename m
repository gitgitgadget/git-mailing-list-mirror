Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830436E482
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774820487; cv=none; b=bnJIF3f5N0L49Q3ojukpylFSGUS96WK47MVptD8nq6k/LQYXoUZB7XioW+Erlj++l1dNRmGRvWpN4U1lvgD3ptoegUjoKEaSzj0UCrmeadeAh9lS0zEcmotsjPZ0qCnZMTXs6ITwqHneso8PoaeF2QmbXWrnwokngFikK5EmQT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774820487; c=relaxed/simple;
	bh=cBCMss1U1okbsBpAxAls+aEF7XfdNZhoVSlv6RVAUDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN+uru+Lq45l/6FrJv5IZ5MuZ9Fwtp3YBrTumdjw0Ra1XFE6TMjVznkbBvWecd08J8hdNpSScEqFyZ3XuV2dJfdU4pbIraqi1i8kAneoE4iUDk3wPO2LezkxwQB9iP9Za7czw0dWxafQaKU7GNGbBr9RucqRXUBBytpLRo51+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GzNu3yFO; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GzNu3yFO"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6500040f172so3139103d50.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774820485; x=1775425285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8k0s+DidFUu7qdWKFmfGKPSkZeqFBA6v2wdPKiu4vs=;
        b=GzNu3yFO4BWHe9unJnNR403/Huu0zfViiVnR+UsOTXWOkCqF9LB8KNpRpQinpXMG30
         faUk9ozI9pmjJ8gJJp0nJ58tBywn/Dv3PVuAZ8/Xs3eBqTFggLDodrdCXkykHkVYI8El
         BegwAmIhsN0JnwIdmKz3WHh6v+pLR/nAZSZSbcaYC+6Qad90V7SB8jSSK1i/Nrbm7Gcu
         +ULymsEzRqqmgihcGnTG/yK49kjMYOVlhUa9jjY5kSSjakCcy6CJuEP83PULfl25+KeB
         TSnjxHd093GMF/dpxb90uPqd9u/rk3rbwSyhTAb6I4ZP0Ra7U+jINOD4CoqXNY3r4Eba
         uDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774820485; x=1775425285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8k0s+DidFUu7qdWKFmfGKPSkZeqFBA6v2wdPKiu4vs=;
        b=pUx5+XCSsndunnna+ZUv5XlKj7Cr/7QbfKY9MSNvqtCLztiQAxdCQZ+EADX3lzmT3S
         7wsDKAY2WmLygECZ83Pyj35VVXtisxOlx6wuDNb5ENGYO2d3t7wbBCasO/vsGnLsvJRN
         /S5DzRpmx4LMv6oux2hvtb+2xmNj92tAE1aGERAMaKZiYCaW7MTm7TVVyPx4vI69M1zd
         f99APMWH8Jg61qzeSa9JLRbEuwPEjHclX+2IY17NWgkrXBNesG2Yab2n+XEoGetysEfG
         JJ3r/wb8OjJH5wd+FYSc4+xGh5AzVfz7R6hQwRUX7M1pJGniME50OqBoH7qMNmnOM520
         CLtA==
X-Gm-Message-State: AOJu0YxFyhZai9LtGEe2q6Fe4XWRH1P4ehXm/grf9k9ylIDp06kw8J7p
	O/cQAp64qFPeBfDOtkUyCet6FvUGmFrHb/WISvMoFiwyMN7wYE90fopsn2AFv9KzmWCTwZdNJqJ
	mNlOX4x6AqQ==
X-Gm-Gg: ATEYQzx2jpSaiEBcMAYiiAHbLX5EuurXNMEWJ0Ew+3OKWY6FYssJihkr0JRK5OqMYrT
	i4XwTyViefGLZor4uI2NePcariv/U83eBW/CZ53nlrITo8Pxdz4FqpxfIhm0HQyt+YVpiOHHdZJ
	9Ectqk03hxDgmRS3jVA//ddPB5LBet+t0rOkyA38oekK0r+Oh6OUzwx6sh7oP6UqcNYXAWywy7i
	dlOBaM6dwx+aFjjfSM+M6VwrPXRIcL5oVSA96iuob58zORsApOAL//6eapAmpt9EKu0+KPE4+Ul
	51h+KuFDx7kggeGlYawx0E9okGsNRX8oHz1zbz4QEGV1x4TE8uoo50zsjB6XeTzummA8bXQxKcD
	S1fs8byMBlVKISNRbjIKF+QmLfIDV1W7FySTWNF5EkZdj9T27HbmLf8VODwIVzNDFjK5fwqlQgt
	UmeGAddJ7IHXwGQCUOp/L3GJDoHY69Qi5WDjypxENXZ+PXSx7MvWc29lJHdKv8IKe/1bihU3z60
	nm2vfwBBL79YVMuThC5yFXyzVLo9Q==
X-Received: by 2002:a05:690e:4391:b0:64a:ec39:dd54 with SMTP id 956f58d0204a3-64ff73d2039mr8511233d50.39.1774820484823;
        Sun, 29 Mar 2026 14:41:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65009345aefsm2984663d50.15.2026.03.29.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:41:24 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:41:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 13/16] packfile: ensure `close_pack_revindex()` frees
 in-memory revindex
Message-ID: <e304e316ac4d4e92125e2e57b32fa445acf66e3e.1774820449.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

The following commit will introduce a case where we write a MIDX bitmap
over packs that do not themselves have on-disk *.rev files.

This case is supported within Git, and we will simply fall back to
generating the revindex in memory. But we don't ever release that
memory, causing a leak that is exposed by a test introduced in the
following commit.

(As far as I could find, we never free()'d memory allocated as a
byproduct of creating an in-memory revindex, likely because that code
predates the leak-checking niceties we have in the test suite now.)

Rectify this by calling `FREE_AND_NULL()` on the `p->revindex` field
when calling `close_pack_revindex()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/packfile.c b/packfile.c
index d4de9f3ffe8..97f7662e079 100644
--- a/packfile.c
+++ b/packfile.c
@@ -420,6 +420,8 @@ void close_pack_index(struct packed_git *p)
 
 static void close_pack_revindex(struct packed_git *p)
 {
+	FREE_AND_NULL(p->revindex);
+
 	if (!p->revindex_map)
 		return;
 
-- 
2.53.0.729.g817728289e1.dirty

