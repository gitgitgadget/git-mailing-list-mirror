Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873112BEA1
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499616; cv=none; b=aIo3eooRhG2hFgM3H/lpscHtAIGO/x0yjNk6TyHKQPA7QOOxtJd2vajGx70cPvlUVMSCORNPQ9whfzVH0WniNO8HZZhWivFuM+SZlx1ha5vg4Pid/AUUA7cnuc/THCiRuL731J6xbFV+kJ04g4GghoWOyJWTWZmFZohzvOrvulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499616; c=relaxed/simple;
	bh=Q5ZI6L1kOwAWAt36F1OOELWsCOdvl0IcNJI0VNSGe+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUrpFQHf6GhbGcnsoZ3hXK2Qwnw4/Q1JvfwASPDY8eyqE5uv0vMQUtR10tG4+Dd1KTAnEEkbcT3jTuxqykpspqAgud5ml7saRMYE62cWToRhz1EGrKuDflrbBwT2rp4U+poqTSgXu6vrVcJI0ea1LjTTeBgfEAO0Wj0DuRdwJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Y/RxPkBb; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Y/RxPkBb"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9995562a0so4139676b6e.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499614; x=1717104414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry6S+SautFv9UU06O4Iu0WmsczwpKrNxBByii8xV/Tc=;
        b=Y/RxPkBbmfaxsKGiHp2mQvPvazE4D4av+MI0UIPcMg3+fp/xmt+z5GvjKTHW9kS7E4
         l24qVYXLUOYUZUnTWGcQjqGd3UnlC0yc0avWDR6uaZcTuLpgYmi/B+TTSv6bBLvaFTBr
         hPan/lsA/foc/sCgeU+keVfsWDa8chnQxxOwDlxk5CQD3yHxifZT8ilK1xLPSkTEYF5f
         eoccGrZcUOmlwbbVRMBjgRoKDXmoCOM3WZVuryIoGF5AXsheor0bXl0L5aHOKsqQ2zMC
         HZ9/L+3REeccemZuSETw2+tzxE+lM1dJIe4criiWBnCiY6QueGNlBwkkUoOLcaQmxF1T
         ji2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499614; x=1717104414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ry6S+SautFv9UU06O4Iu0WmsczwpKrNxBByii8xV/Tc=;
        b=sWPiHWWXctq05tsX0kzIromL+VmKh+V3/eI9wNr5LQPK7T5gitdJggpyxmR8Yugqpb
         tf/WErFE12CVF3qRFJxB9eBGkXFa3aAUiMdAoFHPRGFACjlRWiLgxelGKlInla1JJgE/
         Su/5ifzE7xiilxP2DEYWVeAiEj4NEB5k+nIr6HyP+3m2rDTIzuwDiay1guw/1SNhTcYa
         tS0dLYcM+I86GpO+haBEAjsfydRQQEeUMBzPtj6q2dbw8jFtm1bkNB8CcPZ1Za+V1UYp
         cEYrCCGhdHS91cwM9cMUJkkn4JLfR0JmoT8fq36zHOO7u7C7e5ixVMaCtNCLeMZtRm0k
         UD9A==
X-Gm-Message-State: AOJu0YxO3uvaIYsyHLE7usEoCuQVZuznzJ7d5JPXjgX22Ec474u55I/g
	aAFRkKVTuqoTsptrr1MDeKL8ERGJFiQUsW9B6wwf62IABMfTSKT4FtcNtrjJUnfSOsLqMoedTFw
	5
X-Google-Smtp-Source: AGHT+IHC/KKxAS+qB7xFeFzGr1nPuwyOud4ZZsKCiK1dOeZFqeG5lyDLfeHutxFcm8LFZVuOsa/ITg==
X-Received: by 2002:a05:6808:1a27:b0:3c6:ce0:6820 with SMTP id 5614622812f47-3d1a62fce1amr745157b6e.35.1716499614065;
        Thu, 23 May 2024 14:26:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca5934sm3069985a.11.2024.05.23.14.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:53 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 14/24] pseudo-merge: scaffolding for reads
Message-ID: <435ac048003d55355c8b58812d836933dcffae2b.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

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
index 0f6854c753f..f0080d53c03 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -454,3 +454,13 @@ void select_pseudo_merges(struct bitmap_writer *writer,
 
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
index f809cf42aeb..e9216baace8 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -97,4 +97,69 @@ struct pseudo_merge_commit_idx {
 void select_pseudo_merges(struct bitmap_writer *writer,
 			  struct commit **commits, size_t commits_nr);
 
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
2.45.1.175.gcf0316ad0e9

