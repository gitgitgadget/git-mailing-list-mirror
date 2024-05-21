Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A073149E1B
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318166; cv=none; b=WkwmkEugj0/H1Y5cQy/qQ6lIM43k3/y5Od++oiPPbZmGsMfnMpDAlEEXHJSYb35BHWhUzVnPehKAsbLiSheNRLZVOhfiDzUnkukA6Y35xjH5W2sVKE1qNoCjIMYDb5pHL7xCBjCsR2q5f2J3pW9+l/j42zPn8J7VmU+COFHeGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318166; c=relaxed/simple;
	bh=6gPiXTQbzqTM2VOoEzLtIO7Cfo8n/fDoeFiydNoFK4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX3D7diNFw33gOI8ekxIasHCTAdI2JWTvkRYyKMv5QtATURw/eHHGrTxq10dkCXRPYKEnB7nzZ6C7xOBmce6UpCUKN5N0Ozdfaa/cxwE4RxfA6M0D22DVUo3rJ9zCI56dpU+NAeRNNdccWsK+PG2Sivy005q3JAPFsPiGC/lV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=dle+Cemx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dle+Cemx"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43df23e034cso1628411cf.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318164; x=1716922964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/3J8+gYtOZkY1JR9A4bOqljMajPYqybQ3k/nNPdyKI=;
        b=dle+CemxEJRwhnA/BmAx1TfZAG5trGYpqu03sgNL3u+RuHSLAJhVitLHrLmEgIP29+
         tLXtVkuAM1lvPaEvD+UbBhlJSxWtn5a/gkbSE3ZIXX8EtlAH6NNW+P6VQdvESTHsTqaV
         4BwC+7Rosvrx0r+bs7+kSwsjmqjsV/3fP8gl6LvZR+R+ig6v57DPu0tE3TV409AHG4hb
         m45OpGdQ+txa3YwnwahsrFCZnQrYiHZpFHBSAu1WiqPpQN4eOljJKWblS8OXZtJJZqyv
         PPVSpOib7ZpZ27hP+d/mSmN+JS/Pphs09L0TWvlr7bHKDfIDPaqogI1s9ludenUVtmD0
         L7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318164; x=1716922964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/3J8+gYtOZkY1JR9A4bOqljMajPYqybQ3k/nNPdyKI=;
        b=H2yiCu5MVnR2/EivssrSUSeGlrWHznLGMD+bGBLMEzL63OuQ46tUwnogQUusBhG77G
         ThKbsLyIfKO8J8ArEHnPsZElXMrZesD/YD/nbRD6/J7kKn+FN0zPmF4B9FC66HN006AX
         jobzkM4SRPmwwIeJ1CLkbwJGNh2/0+MS6eEr42pMZuzG2AO76kBE7d1xLe8zx8dNoRRG
         4gV6jp9qMVShaeehqzo5Jcu2wbpdGeIoc6ekwMljWWX0wp/rsXpOQfqrHZ+zDBuZvv0T
         4vOko9XxoGp3bmunuN1ugFp3XhD8r0H02V9ya0wAre0XvE26cOlKkjOoKiKwVqc0rG16
         DrTg==
X-Gm-Message-State: AOJu0Yx1FKIVF2BTQqboarxhzyi1XmzFm+PEJnh5R91NVKoGIGCCj1hQ
	F2hiNb41Z0WRZuvGxvXK67gseYDOkKL4jATPjq8EpmjbV9KWxAyESfAW1q3piLrVrYAX/BMyx04
	W
X-Google-Smtp-Source: AGHT+IF/C0OQlV8ZyPqOdTyhpWTDq9o6TiUTeUCYT/kE5D/sfj1TL9A/3b1KKv9HCTIR1Mn4wcBHzQ==
X-Received: by 2002:a05:622a:1827:b0:43a:1d94:c573 with SMTP id d75a77b69052e-43f7a2c8979mr188665651cf.22.1716318163544;
        Tue, 21 May 2024 12:02:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f991bb19dsm5969611cf.63.2024.05.21.12.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:42 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 20/30] pseudo-merge: scaffolding for reads
Message-ID: <3cc5434e44e09e8ba5f73df602bc3801112fa8c0.1716318089.git.me@ttaylorr.com>
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
index 4be730563eb..1aca70ecdfb 100644
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
index cab54daf14b..a3f0243062c 100644
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
2.45.1.175.gbea44add9db

