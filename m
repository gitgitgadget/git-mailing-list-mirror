Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F2128392
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499610; cv=none; b=DhN59BzObRtoJm0iPmldTc24DEdP0sBaPkXUBv2LLvIvY7yG3o7jOAXQ50lzo1L71y25awnaadwJmhK+3joVxiUNvGg5tRdmc3Q71fFI8KSsDUNviyL9pJLqBHMBWHM26fqu9jmdycjWRC/TBoAuwToEupT2UhN3BMNWq3HMWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499610; c=relaxed/simple;
	bh=lk9U90HV1mqzYpVtj+DG3yMGFwlUM1xhgwh63VVhAb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkPk8Ka3BS45Koe6Ll6VhbkeLlCKzwPYz3lS90qUm7OlkWUWq8SnOmMqTwCj3pgamSE8SiH7bKLwvdGwju4hAFPvlaaOfUC5Slrrm1Ok3/shOuFHmRm961fnLbppZVtKn84px0Rs7JwRp+2sowPkWRPuOWe81Jg4oqN3cuH1/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=yrH5eHhh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="yrH5eHhh"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a08b1a8e6so1818167b3.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499608; x=1717104408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFp+mJUCzJxxRsbaBVCiX2U8/epF29rzfWU1nTLuigI=;
        b=yrH5eHhhLcrTxDXMsdGVQQwIYRp1Ttn9O7J0M+Ktwblh9LIngCy6z1+fMZyzs/e58F
         j6MAZ7AjecYRusjjVFG7csY7maK3hgWlCPaBEjm2UsFAP0WVuVvdFmPRkQadtJvwEAIy
         zGmXFxDPCXYhrXOo24Q/8GJYdQuoPdtvRzIoD1YHFhm5yq792xK2cjVcYc2n8VvKnYG6
         WadVZM0MeSn+TJT1BEIKi4IZyUupB9HUoH6Fe1JpUaQhSLPR/r3jdEWOlp6FpfsUY6w+
         7on4/vSO1YKLHGrY/hQGxFAZ6EReMIMl2dRhES4aoF1lKVQbRQlzdMcw/H0SmO1OFpv4
         jN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499608; x=1717104408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFp+mJUCzJxxRsbaBVCiX2U8/epF29rzfWU1nTLuigI=;
        b=MxW6K/PiQo2Wow5JeJmTgBKNNH92wMm8iUOC9qAWOgNbNijXGGx0CM86pm4bp0S/bR
         mwn7HKr3uWUv2uZDLRLc6TpO+kYtUqMWikOtZPTjN6JLvEYr5EszMk5I23D4aAbOCNE2
         wo8NmoY8qyf1zOtTpUhkchHsthaoKMA3d3r1zhIRxticywH4QUDxACjBcqdP541T7GLq
         7Om0VWVoJI/RW72dvMQ5kanphLPpsba1LTP/ohk7R8vt68XlcHwyuOxx2NVSyg9Ig+r0
         RPFd4Wwq+yHErSLIQx82Bn4Lc4sO2HUyqK0gTcf6HfsCy9mcOT4c2XjiLFTZzb73VPup
         51ag==
X-Gm-Message-State: AOJu0YzVgjNM0xMYVP5xCxmEeJtIjmUmEd04Ssxqm3/XDLal0TXAk9QX
	hGspnDj3camhNf69D3jCCCEm1Z4hlvQnwUqor8Vmvro50l8hOYjnVNZOIMb5W6gW79f3/EgYGWz
	I
X-Google-Smtp-Source: AGHT+IEx58EOnWpx32P34a4JtiUHGNxY5QIDKg8rj32gXN/Or03FCgOuhpe+zY/yCQRutYZQmwfksQ==
X-Received: by 2002:a0d:d583:0:b0:61a:b568:a3cd with SMTP id 00721157ae682-62a08d6253amr3988387b3.2.1716499607705;
        Thu, 23 May 2024 14:26:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162f05d3sm571816d6.86.2024.05.23.14.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:47 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 12/24] pack-bitmap-write.c: write pseudo-merge table
Message-ID: <90df19e43f54ac3950e05c5a007e47650e75fe1a.1716499565.git.me@ttaylorr.com>
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
2.45.1.175.gcf0316ad0e9

