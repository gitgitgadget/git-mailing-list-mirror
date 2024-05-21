Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0C149E1B
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318170; cv=none; b=Tw8IemFBjvtGa+jIncHiETUjYRH157Nlu31euG/ZEGlpZBHkQcx7PL3nXTsn3/pizc9VREnO2MoVXFyB6S8diQKG6IZTcqZn4fvjjf1mSXnSJPeXjtDBdWpnDkmt23cantmpIZQulshG/BCx6hLBpO2LTWoXUeD9A/oeQDn9n5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318170; c=relaxed/simple;
	bh=zANdjcydiA+otR7WPTOiZbeC5lcepqIqDY1nRjlxtWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr9erbpihAX1E6fQeSaaCFQsD2YgxU2nq8QlnsyHEuhP4xHoc4DKtCKPVsZofM4uTvZq3ULCfDw2RSdKR0LwwIUIcv+t6HeTONLTD6vcvLLYBtIgtb+CHXm1iCgqocWjrqk04bh/YswkT4BXRQNkEdSm8LaVAKkWKWpRO1RHdVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LnUt9okH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LnUt9okH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43e1593d633so3200691cf.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318167; x=1716922967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opLcp5O+zjuR/751L16t+v40EZdGi5KDRmF2283eYE0=;
        b=LnUt9okHw18wZwZjWDfoAYuqxlKd6UbOTJsHPH6KStkMVJN0vOgdrNhy9h9w9jh72l
         fEAJwOW+WAo0eRTbntRiku036mOB/432MgtN8k7HppC8S9c+XP7Emn8EhfJgG3EeueJ5
         SPKcG19g41Liw1h/BWOCuUe3CxKan4qDKAC0IaJrb67JK4OpPx49KyGj/72rdtB+IQdV
         oiSsv0DrbycCfAqhaRl4JhhUQrFq2a6Qk3fArzihXVT3ams6gcF60RXjpBIwAB7tbD13
         cdL4u3ImvTkMdBXhmxsKGOqfFxBTg6W/XB2pSqNyAlUHQsGZ/d5LQ6Z/oS0E8Wt0mLSp
         lpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318167; x=1716922967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opLcp5O+zjuR/751L16t+v40EZdGi5KDRmF2283eYE0=;
        b=BG2OWc+kPiZJ/FYWBIif3C9SIoahKBTbpp/X7KdE3CcSluhGHc/kCDUNEwsdUlFLnt
         kzqEXys9ZE0Z4pNRgQ0Tv67UY0ZHgE6xYWyKp/EGYg6yNtau3Cu14fwap303BPRvJrMh
         aE9rA1jsYZBwgtwZew2RWJOrmExVnR5Rbvv76g99sDzKzuTFdNIPAZSdhP/xzRBchYcJ
         xBBwam0WCWExBO0rc6TPLFPKvVLQ5mX0t/obcovKwPdopkrlvuMYTTVWR/I8VPMFyct2
         W1w9xuPqprjGCkUEz7AQOJ6Q5qscIYZ7ku8I0ELJrxk2JP1AxVTB6hrnLeLC32fXUIr5
         2Qcg==
X-Gm-Message-State: AOJu0Yw1w0WfQ4Z4Xwx4Vp1pvyIP/6roWnszE8pHBvGw5Yb1K2UknokN
	cfxaAu8AG0oHZBFjoqrzJmNynacrYe4K6l1ExY+NodNfMtXD8jZuBgAJGHG/UyZ10I3IA/oX0vP
	5
X-Google-Smtp-Source: AGHT+IGJAmc6gdcz3wEw7W/q/RmgwnycfGw6NENt9U9c4BHXc48KMCc6/EjWe3U80sH0vAxNR1Dnzw==
X-Received: by 2002:a05:622a:241:b0:43c:5d37:5a94 with SMTP id d75a77b69052e-43dfdd6a6b7mr347475161cf.62.1716318167238;
        Tue, 21 May 2024 12:02:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e15b37e83sm124180351cf.1.2024.05.21.12.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:46 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 21/30] pack-bitmap.c: read pseudo-merge extension
Message-ID: <7664f5f964867f62dbd748351bda83007958a751.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Now that the scaffolding for reading the pseudo-merge extension has been
laid, teach the pack-bitmap machinery to read the pseudo-merge extension
when present.

Note that pseudo-merges themselves are not yet used during traversal,
this step will be taken by a future commit.

In the meantime, read the table and initialize the pseudo_merge_map
structure introduced by a previous commit. When the pseudo-merge
extension is present, `load_bitmap_header()` performs basic sanity
checks to make sure that the table is well-formed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3519edb896b..fc9c3e2fc43 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -20,6 +20,7 @@
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
+#include "pseudo-merge.h"
 
 /*
  * An entry on the bitmap index, representing the bitmap for a given
@@ -86,6 +87,9 @@ struct bitmap_index {
 	 */
 	unsigned char *table_lookup;
 
+	/* This contains the pseudo-merge cache within 'map' (if found). */
+	struct pseudo_merge_map pseudo_merges;
+
 	/*
 	 * Extended index.
 	 *
@@ -205,6 +209,41 @@ static int load_bitmap_header(struct bitmap_index *index)
 				index->table_lookup = (void *)(index_end - table_size);
 			index_end -= table_size;
 		}
+
+		if (flags & BITMAP_OPT_PSEUDO_MERGES) {
+			unsigned char *pseudo_merge_ofs;
+			size_t table_size;
+			uint32_t i;
+
+			if (sizeof(table_size) > index_end - index->map - header_size)
+				return error(_("corrupted bitmap index file (too short to fit pseudo-merge table header)"));
+
+			table_size = get_be64(index_end - 8);
+			if (table_size > index_end - index->map - header_size)
+				return error(_("corrupted bitmap index file (too short to fit pseudo-merge table)"));
+
+			if (git_env_bool("GIT_TEST_USE_PSEUDO_MERGES", 1)) {
+				const unsigned char *ext = (index_end - table_size);
+
+				index->pseudo_merges.map = index->map;
+				index->pseudo_merges.map_size = index->map_size;
+				index->pseudo_merges.commits = ext + get_be64(index_end - 16);
+				index->pseudo_merges.commits_nr = get_be32(index_end - 20);
+				index->pseudo_merges.nr = get_be32(index_end - 24);
+
+				CALLOC_ARRAY(index->pseudo_merges.v,
+					     index->pseudo_merges.nr);
+
+				pseudo_merge_ofs = index_end - 24 -
+					(index->pseudo_merges.nr * sizeof(uint64_t));
+				for (i = 0; i < index->pseudo_merges.nr; i++) {
+					index->pseudo_merges.v[i].at = get_be64(pseudo_merge_ofs);
+					pseudo_merge_ofs += sizeof(uint64_t);
+				}
+			}
+
+			index_end -= table_size;
+		}
 	}
 
 	index->entry_count = ntohl(header->entry_count);
-- 
2.45.1.175.gbea44add9db

