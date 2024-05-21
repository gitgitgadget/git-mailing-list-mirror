Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E300148FF4
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318160; cv=none; b=GqHFHCmPTeCuETtI9kl+VVbmv61+0y6PDhp5cjC1BJ/3z6kXogsy1wKN2mt7LcFz0Zo2BKfZqbpZd8hm0Lb+iHre6MlXNrMpCrP0pe55K6gl1qVmRO7VPomoUW9IQLlIQCHi20rfyQyfeiwbxFz3G27GKontkFhcfNXPt4uHhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318160; c=relaxed/simple;
	bh=72OY/KzEYF6JmbGPUaSgQv3aUGh3LYS9jLBSxSpuKD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIxeZW3FzUDh4zc1Qg4k/gJS43n8OPTGyUy3s+4QGNPw+IOrhudX1YnLg796jGe0O1NcWdBWq9cFaglbLAIKdk+Jg0IKpVAUgUm3rD2Cns7TvCRdZ5s8ENOlLjB2JRIZcbX7QWEQvA4QB0VNYyjFEjRWuiJDFoQT4OQAQ5ZV/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SoAmiQVh; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SoAmiQVh"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3713ff97cf5so3332195ab.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318157; x=1716922957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vubycmys41sbVyGLY0zuuN09K5YNF0WjIn8Lo46HYdw=;
        b=SoAmiQVhKjlF8vwBJxP8inpndUMo8RO7ZeBu7+VAPubkpNCKKa5hwROvyZ2bTuagDS
         cIRydePo2sEDtI4yTSalsAvskwsFGFy3++2Uy/ERxUWI2fYrF58CN/C2OF58GWGONQQT
         2g+h/xhGoyKiXyj3DjaAkxBL3A3GDbTjZiAnyK8962bdgerAgMlJJMACUkfAuu89q3Wu
         6LgWktL+Gr9dYE5tQv7ahHFM3KvVhAF8b03M1EqFGwVtFdA2Ks76+YaKa3gHj2o/oc/7
         kFl+KWmpGCUfet9CmkX+FVXyQuMNvCtrHbHmb6K6ROwh2LP0iKM2ZLzJik840+3iclQy
         BjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318157; x=1716922957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vubycmys41sbVyGLY0zuuN09K5YNF0WjIn8Lo46HYdw=;
        b=TYU/6Uor4aRbHlqZgfWvTza4zTdQDQ6Bmmh9fCqqBW2wL68q/Q/wn34XaqrikOJDYd
         gPZjmkZPcGtIIMuH1A5VAz65SPn/LJ7XAzxH9OIUPzQwoxWOmxu+NhuX6p8mMu8IdB+d
         S3rit48NGvDKrI998zALK3mgtihUdIJJGxeH5Piyju0oloRPHk170wqDos1w+wBjZBHi
         Isv+H+lkpjImpLPecFIpEDCAvgUXgRnT08wSn8S7eU6h304Aax7xpgqoJfWT/YPL01El
         CsBWFsQRIBX4pIIs3+IVjwOm2RUszyqTLB8zLkQGv2PWB4o+Js8utWya9mwmzEPoef4I
         TZBw==
X-Gm-Message-State: AOJu0YxI/Kf3fXfXG6qlaqrXu5OkmNz7k4zujaF1Hp0njzXzb31aDnb3
	UOEZOSTDveS7Igh9YFk2BOElQdEW6qsDkF2mrEGsyMrViO/6+XhgJHiI3PyorB+bS4fD5X4ENNE
	z
X-Google-Smtp-Source: AGHT+IEJqa2NzFaCJhWyxXdg1qM/+XGJgHEJYiuvBOkACNy5jDV/HWwl9dbLmbJU2cKUAFrg0MHsmQ==
X-Received: by 2002:a05:6e02:1786:b0:36c:46bf:4afa with SMTP id e9e14a558f8ab-36cc14406famr432413815ab.6.1716318157143;
        Tue, 21 May 2024 12:02:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f09847csm125976756d6.0.2024.05.21.12.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:36 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 18/30] pack-bitmap-write.c: write pseudo-merge table
Message-ID: <311226f65c27295aff159fa741e1e6a44ade4b8b.1716318089.git.me@ttaylorr.com>
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

Now that the pack-bitmap writer machinery understands how to select and
store pseudo-merge commits, teach it how to write the new optional
pseudo-merge .bitmap extension.

No readers yet exist for this new extension to the .bitmap format. The
following commits will take any preparatory step(s) necessary before
then implementing the routines necessary to read this new table.

In the meantime, the new `write_pseudo_merges()` function implements
writing this new format as described by a previous commit in
Documentation/technical/bitmap-format.txt.

Writing this table is fairly straightforward and consists of a few
sub-components:

  - a pair of bitmaps for each pseudo-merge (one for the pseudo-merge
    "parents", and another for the objects reachable from those parents)

  - for each commit, the offset of either (a) the pseudo-merge it
    belongs to, or (b) an extended lookup table if it belongs to >1
    pseudo-merge groups

  - if there are any commits belonging to >1 pseudo-merge group, the
    extended lookup tables (which each consist of the number of
    pseudo-merge groups a commit appears in, and then that many 4-byte
    unsigned )

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 131 ++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h       |   1 +
 2 files changed, 132 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d5884ea5e9c..47250398aa2 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "pseudo-merge.h"
+#include "oid-array.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -771,6 +772,130 @@ static void write_selected_commits_v1(struct bitmap_writer *writer,
 	}
 }
 
+static void write_pseudo_merges(struct bitmap_writer *writer,
+				struct hashfile *f)
+{
+	struct oid_array commits = OID_ARRAY_INIT;
+	struct bitmap **commits_bitmap = NULL;
+	off_t *pseudo_merge_ofs = NULL;
+	off_t start, table_start, next_ext;
+
+	uint32_t base = bitmap_writer_nr_selected_commits(writer);
+	size_t i, j = 0;
+
+	CALLOC_ARRAY(commits_bitmap, writer->pseudo_merges_nr);
+	CALLOC_ARRAY(pseudo_merge_ofs, writer->pseudo_merges_nr);
+
+	for (i = 0; i < writer->pseudo_merges_nr; i++) {
+		struct bitmapped_commit *merge = &writer->selected[base + i];
+		struct commit_list *p;
+
+		if (!merge->pseudo_merge)
+			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
+
+		commits_bitmap[i] = bitmap_new();
+
+		for (p = merge->commit->parents; p; p = p->next)
+			bitmap_set(commits_bitmap[i],
+				   find_object_pos(writer, &p->item->object.oid,
+						   NULL));
+	}
+
+	start = hashfile_total(f);
+
+	for (i = 0; i < writer->pseudo_merges_nr; i++) {
+		struct ewah_bitmap *commits_ewah = bitmap_to_ewah(commits_bitmap[i]);
+
+		pseudo_merge_ofs[i] = hashfile_total(f);
+
+		dump_bitmap(f, commits_ewah);
+		dump_bitmap(f, writer->selected[base+i].write_as);
+
+		ewah_free(commits_ewah);
+	}
+
+	next_ext = st_add(hashfile_total(f),
+			  st_mult(kh_size(writer->pseudo_merge_commits),
+				  sizeof(uint64_t)));
+
+	table_start = hashfile_total(f);
+
+	commits.alloc = kh_size(writer->pseudo_merge_commits);
+	CALLOC_ARRAY(commits.oid, commits.alloc);
+
+	for (i = kh_begin(writer->pseudo_merge_commits); i != kh_end(writer->pseudo_merge_commits); i++) {
+		if (!kh_exist(writer->pseudo_merge_commits, i))
+			continue;
+		oid_array_append(&commits, &kh_key(writer->pseudo_merge_commits, i));
+	}
+
+	oid_array_sort(&commits);
+
+	/* write lookup table (non-extended) */
+	for (i = 0; i < commits.nr; i++) {
+		int hash_pos;
+		struct pseudo_merge_commit_idx *c;
+
+		hash_pos = kh_get_oid_map(writer->pseudo_merge_commits,
+					  commits.oid[i]);
+		if (hash_pos == kh_end(writer->pseudo_merge_commits))
+			BUG("could not find pseudo-merge commit %s",
+			    oid_to_hex(&commits.oid[i]));
+
+		c = kh_value(writer->pseudo_merge_commits, hash_pos);
+
+		hashwrite_be32(f, find_object_pos(writer, &commits.oid[i],
+						  NULL));
+		if (c->nr == 1)
+			hashwrite_be64(f, pseudo_merge_ofs[c->pseudo_merge[0]]);
+		else if (c->nr > 1) {
+			if (next_ext & ((uint64_t)1<<63))
+				die(_("too many pseudo-merges"));
+			hashwrite_be64(f, next_ext | ((uint64_t)1<<63));
+			next_ext = st_add3(next_ext,
+					   sizeof(uint32_t),
+					   st_mult(c->nr, sizeof(uint64_t)));
+		} else
+			BUG("expected commit '%s' to have at least one "
+			    "pseudo-merge", oid_to_hex(&commits.oid[i]));
+	}
+
+	/* write lookup table (extended) */
+	for (i = 0; i < commits.nr; i++) {
+		int hash_pos;
+		struct pseudo_merge_commit_idx *c;
+
+		hash_pos = kh_get_oid_map(writer->pseudo_merge_commits,
+					  commits.oid[i]);
+		if (hash_pos == kh_end(writer->pseudo_merge_commits))
+			BUG("could not find pseudo-merge commit %s",
+			    oid_to_hex(&commits.oid[i]));
+
+		c = kh_value(writer->pseudo_merge_commits, hash_pos);
+		if (c->nr == 1)
+			continue;
+
+		hashwrite_be32(f, c->nr);
+		for (j = 0; j < c->nr; j++)
+			hashwrite_be64(f, pseudo_merge_ofs[c->pseudo_merge[j]]);
+	}
+
+	/* write positions for all pseudo merges */
+	for (i = 0; i < writer->pseudo_merges_nr; i++)
+		hashwrite_be64(f, pseudo_merge_ofs[i]);
+
+	hashwrite_be32(f, writer->pseudo_merges_nr);
+	hashwrite_be32(f, kh_size(writer->pseudo_merge_commits));
+	hashwrite_be64(f, table_start - start);
+	hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));
+
+	for (i = 0; i < writer->pseudo_merges_nr; i++)
+		bitmap_free(commits_bitmap[i]);
+
+	free(pseudo_merge_ofs);
+	free(commits_bitmap);
+}
+
 static int table_cmp(const void *_va, const void *_vb, void *_data)
 {
 	struct bitmap_writer *writer = _data;
@@ -878,6 +1003,9 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
 
+	if (writer->pseudo_merges_nr)
+		options |= BITMAP_OPT_PSEUDO_MERGES;
+
 	f = hashfd(fd, tmp_file.buf);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
@@ -907,6 +1035,9 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 	write_selected_commits_v1(writer, f, offsets);
 
+	if (options & BITMAP_OPT_PSEUDO_MERGES)
+		write_pseudo_merges(writer, f);
+
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		write_lookup_table(writer, f, offsets);
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1e730ea1e54..db9ae554fa8 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -37,6 +37,7 @@ enum pack_bitmap_opts {
 	BITMAP_OPT_FULL_DAG = 0x1,
 	BITMAP_OPT_HASH_CACHE = 0x4,
 	BITMAP_OPT_LOOKUP_TABLE = 0x10,
+	BITMAP_OPT_PSEUDO_MERGES = 0x20,
 };
 
 enum pack_bitmap_flags {
-- 
2.45.1.175.gbea44add9db

