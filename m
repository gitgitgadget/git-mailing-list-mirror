Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8517799F
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423438; cv=none; b=WJfSdo83MhpF4caObRFNI84uB1M9JjSYxJoZItYoMXliwcLzGBEy9p8xgqtqNEnf/Mor2Yc7AX9G7TU3pO/MhULxfDy0W3t7Kx9QQJDEVF1W2kFCUZLGONE/bDlveerLt0HGMdNiGJU4GWbZVL7ASR4o+o8MJc48Bno9VkmdPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423438; c=relaxed/simple;
	bh=qSbhVW7oQb1bERhH992tv25U+uBS0ux2GSLnVUlPu+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtSlV+wuDEf1oJHJ6juUZpxgBUPYY/vOOcIF6KkPTlnygsC0whqQk9k1HLKBGlMEMD6UepDf6gtAdBW4nSP2CRwHjfFkL8QX/tm+g4h2TjWYcvi8QtvaXkcBUA4w90CN18AaryHDkOebxJvTWcx2AK5lbzGJlhC14cBf2OGb0rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tGH9Vsl9; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tGH9Vsl9"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b4043b7b3so29334346d6.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423435; x=1715028235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcuAcp4qIz1oR6JgwihtPgoqgjoZ8TNZnxuAUK1aUTI=;
        b=tGH9Vsl9E9IiaHWLitDx9JGTzLnzSexxB2k8WjoDcYvKjOeSjme2u778D7johYmyu+
         V2b1dUun4lqggsRZ7BGrHUvpNXLJrfybp8wJxSxW8L/lPeC7gE2GopdP6tTJjgSlkJLE
         UkB3bVp49sjQf5uxffxebhbnD2u2K0ImiEm3tV4LQwjPWqesnG159e74La8dzNcbIcjO
         gJbfEAmxhVTO8b6T2Zn2K5/n9lchrtZbjBNkHEQgYOIVxXt9cHX/AVp+Sgjd1vAZ62zH
         aA8660JgY0JSg8hG0vABE5rJcdyOMUhMB0hZtnBtSfHO1RxWN7dYskUnqWpsXX6/qYar
         3TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423435; x=1715028235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcuAcp4qIz1oR6JgwihtPgoqgjoZ8TNZnxuAUK1aUTI=;
        b=QUOS8Gqzmw17ILcgZLWFCoi9/9eenr/yMOa1KgXxw5aEyHWPlia21k8ZHGnUAlOjJa
         3g3OMD8WmL/E9V2l7UYBOBRsF/3nTgh+SwATrtR5LdioxNPKdMV/waOlynRZQeXwhmCM
         i3jwKzCgw2I6F24KGNmH9CeLSczniu6yHTPkhNPVn24wee7uEKPomc1SRJYB9yIzRpeK
         iPyvK7h50LX9GNRZnEXVx1IoJxLalGDhHWC/eu1yhZQg6JJ5us33NOm/jjQC0kEqxnbz
         1wzXcQSTeYucqxmTv8WZ/H/86bt3ogAjCPlFfZqPpiJy/TahUS8csH6qcUyUIzAkuNOO
         ZfEw==
X-Gm-Message-State: AOJu0Yxk/wmXV/k64SnJJ5nLegBZH8Mj+S9xkvHXPv3lWjshKtsI3X60
	KwJ0/Lo2MxDNJNzQVeR3FMojtXSYsNfKKacpbebpPffNg2Xukw3JIRBoPRCzXVmvttFijl3o69Q
	bfKY=
X-Google-Smtp-Source: AGHT+IHqJf+102N5N5A6AmwjuX3D4lU3JlIen1+7jkUGyVIK7QJeTIQleEw+6d+URk+dhsc+NRtpCw==
X-Received: by 2002:ad4:5ca2:0:b0:69f:ebc3:7d0d with SMTP id q2-20020ad45ca2000000b0069febc37d0dmr14432429qvh.60.1714423434560;
        Mon, 29 Apr 2024 13:43:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p18-20020a0cfd92000000b006a0d701ee4esm642548qvr.75.2024.04.29.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:53 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/23] pseudo-merge: scaffolding for reads
Message-ID: <9465313691be43c00c6f03c0be58710edbeb9caf.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

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
2.45.0.23.gc6f94b99219

