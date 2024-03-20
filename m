Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077685C76
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972348; cv=none; b=S18kahye8RPaALbrhUFwIro+qaGUell667sGITLlBUzWXZUbobJ9Xh8L+BBZce+2tfK4JlZZjkuLRk/wg8e8wOFyRnM4OzF8bJYDsrXb4pnNxvKA3COf05OX9yaL9jxmCeYgeN4Rez7ch//FEeXPb9Gz+cCOhGdqCbxOaaPyf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972348; c=relaxed/simple;
	bh=6+96b/5sUjjFsIAMFH1PO40G1FFuWL/jgT3XvZj3H/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om+kUd7W3Nyv7RrEzQr8SijmXiJ4aPldp105vG8pIq7IH+te8oJInST5/hFeHIiQrTKhJW6/bn3qOwIN3BnZGUYfFzq9m87HbZxBOyspivsoYlENzBnQXxAYGwbrGAC4J83H4Yg5qfFgDvtt8VJCFQYR34O5ltNEmMara0keBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=m1CjYVa7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="m1CjYVa7"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789e209544eso20960585a.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972345; x=1711577145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6qVirMX4vU5terMRqnTxnGDczVXhtaoK5hQiSz628s=;
        b=m1CjYVa7MEKQncNnav5Ej6fry8G0jaPCyM1eDYNRAIsJeF4ejQPCJwI2hmIB+NRDS9
         B1+ottCyN8Jkz2k6YvzygQlXwSLMvE022Nvdf4Xcfa2osrT+6yJMMUA/n0vDbn6i0LLM
         eA8cdYowVyDqpTYK3eDQBASizKmThTPIyMVzgSArOl80Z9ViDxnmyEu7vjugWjeoGtMm
         yjSq07MLhvaH/U6eP89VtB5XSym3q2cztUrjp6CQvxQbrw7NbhPAxRGYrLEaoYK09+z7
         gWRDY3kVXsYIJods5ppg2cjfk7Md/B0ygcdsCKQ/vGI/ziD97KM+hV+w6TnULOx85af3
         6SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972345; x=1711577145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6qVirMX4vU5terMRqnTxnGDczVXhtaoK5hQiSz628s=;
        b=lu38H82Rcm2FisS8mmHZwyVWLVSdXEywt6sAtw1R1YvA3ZCj5V/PqINfXb2nGdN6Gm
         vG+NJfPYMAUcCR8Wmyi/BvrSUzjG1SQusV16bSMeCIUbrU3WG9pD2s4gLxyS5VlOc/t2
         Rkbl3ztumDYf8a++bDr5+8E4oDD20wJNkgUDq5LaKcf3WgzfT1QcZ0At4Cl/oXPJpgOE
         jN7Yfw7s+BM+Ubhhyd8jlxm2eNd4QzJShDIrNQH45LKNJCqHAJyC9evp8AEa1WbQM6Uo
         h19JVPxpqRJIutpHLjbKCWxCZ/ZShDACIhPNdoHXHKm3/sWVshSILOECkxGehCXYmDgz
         2kMg==
X-Gm-Message-State: AOJu0YwPdo5K3QuMxCBHQLfGEVexT+aRDaTL4lkaIUS8khkwAYhDfpOd
	m2I3BJpNjd52S9xTlE9uZMDt72QwnwgKEZqBGF9CD1THom+6ASU9GiuLJiTCCM4ieis6eptkCrb
	PMg0=
X-Google-Smtp-Source: AGHT+IFhqdAC8wLa61kYoXnrm4Eqzv+I1cqstzH4SIxLtrfr2kI89020iESMBMeWH/5bqzktcOygMg==
X-Received: by 2002:a05:620a:5819:b0:789:ea36:c461 with SMTP id wm25-20020a05620a581900b00789ea36c461mr16148059qkn.74.1710972345339;
        Wed, 20 Mar 2024 15:05:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z27-20020a05620a101b00b007887d30dbb7sm6901918qkj.60.2024.03.20.15.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:45 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/24] pack-bitmap.c: read pseudo-merge extension
Message-ID: <7bb644b2b0c3478c65e16c355be41127f32c9787.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

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
index b3b6f9aad21..e0f191b7581 100644
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
2.44.0.303.g1dc5e5b124c

