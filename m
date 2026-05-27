Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E82641EE
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911771; cv=none; b=kPpyTu6no/TIGtnvI1Dfo2UEA2hmsu5WMKgWLKQO4F0yq9P7f30dSxTd0NhIAht4kvIqoVoxLzMAZ5Pwi0/4/pzpUkE5FzTfg0XkC8fIKT9pWeK4jwMyYPBIoUvm/bZuNLLBIrWbEh0lu9lghXN3znxP+2CBlgR7VgDG/lfmC30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911771; c=relaxed/simple;
	bh=ixUzTJVEiHMnZ3LhfAs/SnaEnNr6hmp2QGwQ8rtwlCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icNhn6O5QHEHFtq/7LRSuNuofuXkjDIzFbPrFxLn+npOwfUabr5xkU7RXalCRWT8EwTergFesGWuoUceNsJgGIhjnnt6gf/wEhuF6EUWOXxwecxPgc4qquKPnND22GaULbADCQfrpG5ucJOYUIGI1oqFHqb/rryK7UJ3fKOeCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Rw9R0YJM; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Rw9R0YJM"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dc67a5e102so270687b3.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911769; x=1780516569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=omwJD/afcxY/pHceQvvm1/byYQ5jTEjL5abRZKGFo+I=;
        b=Rw9R0YJMJpF5Nn9cQMIhY6Spc4U5eo+qAlbfv8IvoJSW/U+8dzimXX+LaXPjpfOdej
         O4AFHNmENRkuPVQACgaonzrC/yQpZDZMz02drCIsDWD2ZqgXyP+hPbq7D41TQHBMx9lP
         wZ4KcMP0+HXw93lzHjr4z+zCrs95avph/MfpC6zqrwxo7Up6i7/sLRtbt1JSuGW9cdQ/
         t2z1AyFbQN2RjDb4AMzkRkS0UoSQB9v8WZq5qEJZQ4noPf8FuGBG3QSCC23dc7JulrxA
         dUGS9pT8ytxlSN4e2cFIuiSSEd1o3SFV9VUawr0aQ5aGm3Wznpm/JrbZ85wZ0fC9KQKD
         e6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911769; x=1780516569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omwJD/afcxY/pHceQvvm1/byYQ5jTEjL5abRZKGFo+I=;
        b=VpsmmWt9ynTvxP2GvbSUw6GshPxDoYUX1Tu+t54nGLKTOy8wn95JoFknO3qAq6DpXX
         zfMHRvMixDx7aCdo3eXIQGjNtviX1qWfsGiQFtDxajICoHK+Tu6KN0NcxgIxSXqiSZ4e
         GBlHcHH3JT9O+uuUG8wH4lAr7MN4TKyaj90PWx4fCgrb+A+pch9nn2j1rIcwY0nOZh3H
         3twyWXPWZLymEbMoVLq3x7npUskPPIoPm/ULx8z2uJ5FN4NO1+XcLh2fgCmqHTNtqQ4+
         eFBfe/32FIn8Q6ccXe8utKCD9dSplg0cnhilACS24TW2hmtVpP72RzlMH1pHRJK7x9Hj
         aBTg==
X-Gm-Message-State: AOJu0Yyv0kXNxJKsfFRiCO0YamikAi58r0hFXcih6t34zILzpbubABCZ
	PC38R71CnDivySDEYFEjAdj+lfKZvOxMOdPSTWuvcVIedeJQ9z1gmjJr6AhC+WQZaa1JaBNYqZi
	fJnWYNT4=
X-Gm-Gg: Acq92OF/lH9Glytw5sskdvSD6/WOXs2XHHUl/mhHLYbH6w7SEqNBotf0Xn5+J1ilWh5
	Y590VaOm1T2VcuLXARVVdubW58z4de3PW2kKzh4vm88WwJ0SMS3Ni/f3AnicSAO+ouOEaWm9BXE
	0vZOlaFSmYUMTvKuc3PKO+ToXtpAFYBWIjXnfFG2MF0VJgWmFMZp4vVIgU2p91STKxhFhEXSfs/
	SxqwCQPNyLznoVOIIoBWe2zXeDz7Zt1xlMYun+S6eHp/rY13h2RDMK4T90DToPWbaFJlp5afKNn
	Hzfpty2GTe6OiAXjapfWiOSuKL79UI9ndLVrzAFi5jGIGh3ITfSp2dbhHO636hCcELzQ2T2KpII
	TJRS7s+3nf2nEIYs2MtfrOhlbCgzC7oDrjk47qBize4LhwQABQSkZ0cDVj2Tmo0sZEvOQjAitre
	u37eu4h5NgjTLcYZee7eE732x1ecr7owh+/L1bpfGDByUKN8B49ZLrxHN7Ufzg14eAv2ooUDQDv
	hWyWWi6UE2F+6zEv8IGNGhAgSup6JXT9n8uoN5ZtU4/rL7AgZ+E2UzUiVfziwKrOkrMQkZ8aAqM
	EaCc+l1JnYKThGpJMYWFUDYeDGk=
X-Received: by 2002:a05:690c:c458:b0:7bb:712:a768 with SMTP id 00721157ae682-7d333bd8ba5mr243161877b3.7.1779911769423;
        Wed, 27 May 2026 12:56:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c8basm80779377b3.37.2026.05.27.12.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:56:08 -0700 (PDT)
Date: Wed, 27 May 2026 15:56:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 7/8] pack-bitmap: remember pseudo-merge parents
Message-ID: <673b6262911dbcc8a8fdb11995f7c112f5330906.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

write_pseudo_merges() currently builds an array of temporary bitmaps for
the parent set of each pseudo-merge, then serializes those bitmaps later
while writing the extension.

Move those parent bitmaps onto the corresponding bitmapped_commit
entries instead. This keeps the on-disk output unchanged, but gives the
parent bitmap the same lifetime and access pattern that later changes
will use when pseudo-merge object bitmaps are built before the write
step.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 66282ea14b5..8200aed6101 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -32,6 +32,7 @@ struct bitmapped_commit {
 	struct commit *commit;
 	struct ewah_bitmap *bitmap;
 	struct ewah_bitmap *write_as;
+	struct ewah_bitmap *pseudo_merge_parents;
 	int flags;
 	int xor_offset;
 	uint32_t commit_pos;
@@ -102,6 +103,7 @@ void bitmap_writer_free(struct bitmap_writer *writer)
 		if (bc->write_as != bc->bitmap)
 			ewah_free(bc->write_as);
 		ewah_free(bc->bitmap);
+		ewah_free(bc->pseudo_merge_parents);
 	}
 	free(writer->selected);
 }
@@ -210,6 +212,7 @@ void bitmap_writer_push_commit(struct bitmap_writer *writer,
 	writer->selected[writer->selected_nr].write_as = NULL;
 	writer->selected[writer->selected_nr].flags = 0;
 	writer->selected[writer->selected_nr].pseudo_merge = pseudo_merge;
+	writer->selected[writer->selected_nr].pseudo_merge_parents = NULL;
 
 	writer->selected_nr++;
 }
@@ -1004,42 +1007,47 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 				struct hashfile *f)
 {
 	struct oid_array commits = OID_ARRAY_INIT;
-	struct bitmap **commits_bitmap = NULL;
 	off_t *pseudo_merge_ofs = NULL;
 	off_t start, table_start, next_ext;
 
 	uint32_t base = bitmap_writer_nr_selected_commits(writer);
 	size_t i, j = 0;
 
-	CALLOC_ARRAY(commits_bitmap, writer->pseudo_merges_nr);
 	CALLOC_ARRAY(pseudo_merge_ofs, writer->pseudo_merges_nr);
 
 	for (i = 0; i < writer->pseudo_merges_nr; i++) {
 		struct bitmapped_commit *merge = &writer->selected[base + i];
 		struct commit_list *p;
+		struct bitmap *parents = bitmap_new();
 
 		if (!merge->pseudo_merge)
 			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
 
-		commits_bitmap[i] = bitmap_new();
-
 		for (p = merge->commit->parents; p; p = p->next)
-			bitmap_set(commits_bitmap[i],
+			bitmap_set(parents,
 				   find_object_pos(writer, &p->item->object.oid,
 						   NULL));
+
+		merge->pseudo_merge_parents = bitmap_to_ewah(parents);
+		bitmap_free(parents);
 	}
 
 	start = hashfile_total(f);
 
 	for (i = 0; i < writer->pseudo_merges_nr; i++) {
-		struct ewah_bitmap *commits_ewah = bitmap_to_ewah(commits_bitmap[i]);
+		struct bitmapped_commit *merge = &writer->selected[base + i];
+
+		if (!merge->pseudo_merge)
+			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
+
+		if (!merge->pseudo_merge_parents)
+			BUG("missing pseudo-merge parents bitmap for commit %s",
+			    oid_to_hex(&merge->commit->object.oid));
 
 		pseudo_merge_ofs[i] = hashfile_total(f);
 
-		dump_bitmap(f, commits_ewah);
+		dump_bitmap(f, merge->pseudo_merge_parents);
 		dump_bitmap(f, writer->selected[base+i].write_as);
-
-		ewah_free(commits_ewah);
 	}
 
 	next_ext = st_add(hashfile_total(f),
@@ -1122,12 +1130,8 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 	hashwrite_be64(f, table_start - start);
 	hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));
 
-	for (i = 0; i < writer->pseudo_merges_nr; i++)
-		bitmap_free(commits_bitmap[i]);
-
 	oid_array_clear(&commits);
 	free(pseudo_merge_ofs);
-	free(commits_bitmap);
 }
 
 static int table_cmp(const void *_va, const void *_vb, void *_data)
-- 
2.54.0.rc1.84.g1cf18622df7

