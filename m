Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9BE1803A
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958670; cv=none; b=HK0lojPq4vZ4zaPH+V4arOOj0XrMro07dDmS+eSXsWnb6OhgnVhq2ezK13ZbkrGOxMCQ0n3/xLbefUtEw+PKdOUiqyUYnBMma0QyCCx0IiSTU7NYZZ/5bdiv91uPq2++LUwcOhEEU4TPwaaDu+Rg8dgi+O4hMl/JkOsjD0HeSi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958670; c=relaxed/simple;
	bh=y9r26JRkPthmjfOdeZzbvSJh5wM7rEhc+2H8bT5CxXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5xf5Q/WVMD9PB5/RGw4bgiS84i/e6q/7/bdbEdjGN6NKerM5YQZBnOAlgu28zcO6VqKkt2wpvC0Xk6FABhqTc27X+1QQsl1ScLfuidvPSsI6SUhcUUCl6TXKHnniPCxNr07B8tiC39+pV9oQr/enKp+v//IV2yxOegIpdSNcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lRDJqkQ4; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lRDJqkQ4"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65fe1239f12so7323337b3.0
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958668; x=1723563468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOnNBaq/Cg3iM6T2URhiL+L1EIqmj0r+sHLewqbQDJY=;
        b=lRDJqkQ4a/PMPO65pQLDnE1p/KPBJqqiQwb8J3ukf1ivMXN8hd7F0REejkEmupVWK0
         C+w7+FmG+/6eIf2tE57fd+B2cfDFZdfP97LaDgwl4gCAnbIYFF/ABledszfzzgUEuqLE
         7jSX8ZVEXTURemzqjNbZy3+N/oid3wOpLlnxtchdF+LSlnL+MBEuHmIVXc7XIfNcxb0C
         r+ycjrVG0xu7enolF5YO/IaEyk3SLBs3Nne/OvuP4N87xK6pSln1uc1xnJikwlvluE3m
         SA/pzVh+ERyAdJ1Enp75i19vdaAeuY/StgAm+2NrlyMA+AhWBX3bVhnsIuv2X2JwsiAK
         A8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958668; x=1723563468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOnNBaq/Cg3iM6T2URhiL+L1EIqmj0r+sHLewqbQDJY=;
        b=UL1I2nnQMqf64ZDMRGmAcz5R4BmV0JX5+7f77JCgUu0LG19eAHpcfBrf/1FfsDF2Zi
         B4rbaYY3Y++GSGgsp3WiOed6MD/KPRYKmVfIcRNa9GPueP/UYx2409m3kKcDQeG0Znwe
         jm41YwyZIBLWhTgoWl6nDJnYlIxQVAC4QqZDXN3gDwGWEWjtRNHk4sBj08OwDzsyUDu6
         ZdhPMnM64qk3jI6mssikqupGShAm5WMRfJbAZIybikEOa2L2oGsrgFISENGG1fDhENbB
         L7zINYHHJBawl6oz4Fb+TJztv4H/hV6QzMRWFjnk75pLuEkuwVCyp7+oW9+S05CkEIt7
         wgEg==
X-Gm-Message-State: AOJu0YwQ/pyg8DB5kC7OwYUk4FEBG4XuQMbo0diGTIgJAeEaREm//8m4
	4wT8U+7I+aDoXLJVLCtuUnqSJnNCTlmk0k1ahIOyMZ8mE3urE7UNk9XernWdQSYIhDq0HX97FVr
	t
X-Google-Smtp-Source: AGHT+IEbWtP0EM5cSRnVmcigh0eyXRFC5xwwSeCIJxqWyuxvpt1EzUiKPZscvWlIJ2C5TpN9Tghx4Q==
X-Received: by 2002:a0d:f3c6:0:b0:672:e49d:430e with SMTP id 00721157ae682-6896096854cmr143281287b3.15.1722958667573;
        Tue, 06 Aug 2024 08:37:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f419115sm15794327b3.19.2024.08.06.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:47 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/19] midx: teach `midx_contains_pack()` about
 incremental MIDXs
Message-ID: <71127601b5d412eff69d6451e328e4b1c74b4caa.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Now that the `midx_contains_pack()` versus `midx_locate_pack()` debacle
has been cleaned up, teach the former about how to operate in an
incremental MIDX-aware world in a similar fashion as in previous
commits.

Instead of using either of the two `midx_for_object()` or
`midx_for_pack()` helpers, this function is split into two: one that
determines whether a pack is contained in a single MIDX, and another
which calls the former in a loop over all MIDXs.

This approach does not require that we change any of the implementation
in what is now `midx_contains_pack_1()` as it still operates over a
single MIDX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 50f131e59a..454c27b673 100644
--- a/midx.c
+++ b/midx.c
@@ -466,7 +466,8 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+static int midx_contains_pack_1(struct multi_pack_index *m,
+				const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -489,6 +490,14 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 	return 0;
 }
 
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
+{
+	for (; m; m = m->base_midx)
+		if (midx_contains_pack_1(m, idx_or_pack_name))
+			return 1;
+	return 0;
+}
+
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 {
 	if (m->preferred_pack_idx == -1) {
-- 
2.46.0.46.g406f326d27.dirty

