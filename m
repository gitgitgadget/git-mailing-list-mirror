Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D886644
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972345; cv=none; b=Dow1UKceYW/sbRjZqLKxUSi4NKh5cbgVwzV3FBT0bMB5XhOUUmEr+Obu4xYSAG6k8GBg3f8FJGxQVYVfz3woRqcw5u90ipIjWxhL0LAoDhkGE9guRJhN2EoUA+mmRugumKMSTkw/25StdfFPK6Dnqwh/ORJrsDCQvG+C2DU5waQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972345; c=relaxed/simple;
	bh=PdfFqYZdxSeycYhSJK6Y5ObhSIdSURN1uLCi4/tpTRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2yTy8VY1P/zWxwoBHtIRGk7X2je+evJ6Vf6X4Eb5Y+OzCAquDhzygPddl8eVkNdIeiyPVlL5w8TNKzQju1OF/0srgnpXbApj9CXyn2IDLiX/O4yjBx42Lg8KFbEGxKNuQxdl/ZOUA4a6BfKmtGGulWtJFAPUgdWy9aTDU4SM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JYp1rIlQ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JYp1rIlQ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a26803f1aso23741485a.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972342; x=1711577142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0JFyZvkyvarvvwkoe9l/kl0kJb7pObru261GyhxLWwI=;
        b=JYp1rIlQcU3sQWYp2zKZwzhnkU5kp3CAkPLkj3t10bjDTjmgg1pUXU2DKgAK5+l+ps
         tNaEx14SceveIdhb4lmpftVlXS2TXjnCyPctFfb2AkHtdlaR7q15kH6XDxc64wzYBPAT
         4U/ctfhE2WL0eOoFS8zZHBzFEG/bKppa0O0bZ3n6sha1ISYblGhxbUqn5kbWZwt/fnoN
         GhFK6Y0yBZKC+A9JWAojMxq2FpY4pnYn5k8c106CEzgRLVntHWWnJ2+M5nvfhTFwkPGF
         s2dNOV/f/awFNnzmOnL4TvZwqRnCf6O0lJ8OQOFXyz56NXsv5iddyn7sut5Xq/OngcOc
         atGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972342; x=1711577142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JFyZvkyvarvvwkoe9l/kl0kJb7pObru261GyhxLWwI=;
        b=noRbNjPU7tzYchW4iFhv0LU2mla1ofyOsQL50i/I5Hz+HTxa8VRmZoVFVPEhqe/KgV
         qWoWjVIJf6jenAQE/fKxJVUIyb0WDL1HE5OkU7pj42aGU+tWqMX4aLgbyLOGgqkx9dJf
         oOLIDWZD23xF5Q+WyJd36J5oWEU/y/6fLSyCzuOVUKTaMMjgXHWCl9oH0dMFXc8AU/w1
         6zxbxrYhAgzatMpQ8jtmGoJFf/v4FVXT8Fy2D+SEgaEI5nBTEaNOkfkl8iGXyDOu1H6u
         hmElIbPA652HmGrZL+qyFXkhYmU0BWxISQYMDiyfIbBadaunRrHPGIhuG2qiwh7G5llz
         xcKQ==
X-Gm-Message-State: AOJu0YyKK0jz92NQ8um8YgVOuRSwSfAzgADeY/p7anoPv4W1L/E5MG0s
	apwFFNyyEayM06FcStjQ8ctLlusDSPU6GmMfOrPOfGMuK+N+HS3t0jLWOSlonZzv/b+Eb15HTR1
	T0GE=
X-Google-Smtp-Source: AGHT+IEeEUXaEMW1G6k8eULJzYPhy5QeWlUJ53/W6a+4NTxmYUb6l2TFs9PfYLIROqtXf/S16aF6Mw==
X-Received: by 2002:a05:620a:20ca:b0:789:d0ca:82d1 with SMTP id f10-20020a05620a20ca00b00789d0ca82d1mr246393qka.35.1710972342256;
        Wed, 20 Mar 2024 15:05:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c14-20020a37e10e000000b007883a49baeesm6945635qkm.4.2024.03.20.15.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:42 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/24] pseudo-merge: scaffolding for reads
Message-ID: <7e4d051f37a42e9e44b13acfc60b42fbb2a891b5.1710972293.git.me@ttaylorr.com>
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

Implement scaffolding within the new pseudo-merge compilation unit
necessary to use the pseudo-merge API from within the pack-bitmap.c
machinery.

The core of this scaffolding is two-fold:

  - The `pseudo_merge` structure itself, which represents an individual
    pseudo-merge bitmap. It has fields for both bitmaps, as well as
    metadata about its position within the memory-mapped region, and
    a few extra bits indicating whether or not it is satisfied, and
    which bitmaps(s, if any) have been read, since they are initialized
    lazily.

  - The `pseudo_merge_map` structure, which holds an array of
    pseudo_merges, as well as a pointer to the memory-mapped region
    containing the pseudo-merge serialization from within a .bitmap
    file.

Note that the `bitmap_index` structure is defined statically within the
pack-bitmap.o compilation unit, so we can't take in a `struct
bitmap_index *`. Instead, wrap the primary components necessary to read
the pseudo-merges in this new structure to avoid exposing the
implementation details of the `bitmap_index` structure.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c | 10 ++++++++
 pseudo-merge.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index caccef942a1..d18de0a266b 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -441,3 +441,13 @@ void select_pseudo_merges(struct string_list *list,
 
 	stop_progress(&progress);
 }
+
+void free_pseudo_merge_map(struct pseudo_merge_map *pm)
+{
+	uint32_t i;
+	for (i = 0; i < pm->nr; i++) {
+		ewah_pool_free(pm->v[i].commits);
+		ewah_pool_free(pm->v[i].bitmap);
+	}
+	free(pm->v);
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index 81888731864..2f652fc6767 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -99,4 +99,69 @@ void select_pseudo_merges(struct string_list *list,
 			  uint32_t *pseudo_merges_nr,
 			  unsigned show_progress);
 
+/*
+ * Represents a serialized view of a file containing pseudo-merge(s)
+ * (see Documentation/technical/bitmap-format.txt for a specification
+ * of the format).
+ */
+struct pseudo_merge_map {
+	/*
+	 * An array of pseudo-merge(s), lazily loaded from the .bitmap
+	 * file.
+	 */
+	struct pseudo_merge *v;
+	size_t nr;
+	size_t commits_nr;
+
+	/*
+	 * Pointers into a memory-mapped view of the .bitmap file:
+	 *
+	 *   - map: the beginning of the .bitmap file
+	 *   - commits: the beginning of the pseudo-merge commit index
+	 *   - map_size: the size of the .bitmap file
+	 */
+	const unsigned char *map;
+	const unsigned char *commits;
+
+	size_t map_size;
+};
+
+/*
+ * An individual pseudo-merge, storing a pair of lazily-loaded
+ * bitmaps:
+ *
+ *  - commits: the set of commit(s) that are part of the pseudo-merge
+ *  - bitmap: the set of object(s) reachable from the above set of
+ *    commits.
+ *
+ * The `at` and `bitmap_at` fields are used to store the locations of
+ * each of the above bitmaps in the .bitmap file.
+ */
+struct pseudo_merge {
+	struct ewah_bitmap *commits;
+	struct ewah_bitmap *bitmap;
+
+	off_t at;
+	off_t bitmap_at;
+
+	/*
+	 * `satisfied` indicates whether the given pseudo-merge has been
+	 * used.
+	 *
+	 * `loaded_commits` and `loaded_bitmap` indicate whether the
+	 * respective bitmaps have been loaded and read from the
+	 * .bitmap file.
+	 */
+	unsigned satisfied : 1,
+		 loaded_commits : 1,
+		 loaded_bitmap : 1;
+};
+
+/*
+ * Frees the given pseudo-merge map, releasing any memory held by (a)
+ * parsed EWAH bitmaps, or (b) the array of pseudo-merges itself. Does
+ * not free the memory-mapped view of the .bitmap file.
+ */
+void free_pseudo_merge_map(struct pseudo_merge_map *pm);
+
 #endif
-- 
2.44.0.303.g1dc5e5b124c

