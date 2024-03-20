Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDFC8662F
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972339; cv=none; b=drpZnLOZD51Ch0H5uyfu+e+167zGWUi75+gRUy71HAXTRO1OIOoG1jF+JZN/y1+hMACA5kSSbtuuuh2xK4ouZxe2eooPX0HUT/2kxNxRwx5ofReJ7Azw3QGMerPWG9E9Xz5N/zKGVwjrqJgEA/eLlr6Do2MgSY64eWR/CiLEJoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972339; c=relaxed/simple;
	bh=w8whBemgTwx22+lyuKLZU4+ok9yfOMqG60sIXaSGVnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLY+z8IjRh1upkiXjtowze1VWqhP31b0LvpOOasKnpFx6mcJP2oDlTh0ByiYOvoaMz1vcBcABmjjUSvrwvR1OpGjFVSZVw/1wZNfILyl43wCAINe7KnVj4u/BwRemmmDjSgq2MTUYFtke/Q7zAChaUgMpNmfXHCR7HLb7JHTNMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ln+M8ww8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ln+M8ww8"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-788598094c4so20092385a.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972336; x=1711577136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJxbbaFLdDyVr7Us64ZQdBUVq66chOkLYZkEZAOhvTM=;
        b=ln+M8ww84GMrBe4p55SnLYKb31VESrAPpTDbpV7KHVGmtbsOPOfBknrA5xNcGHftCC
         IMMv/SG6R0JBUEz7wHrewgRytwXuDjYuwslaOsqwz9G7oN3jYynbriMfptPuM9m4J5nG
         zmidfZNf4fV+JGUbgQj9BM+S9uEUNNiGlEc3uOLibci/8pnyDPOWlQJvpgu5iOp1MHLW
         iaPOBR7El3Vm6lEmnfjb/6yc+lXNE9aPLgoge4Bgcsc/H49L0PPOT1FuLYYidfGRhO7Y
         eekPrUyPmyz3fTZZ7flPjxbZ3oaxRNk8Rtb4ruAMsF7m1AEdhG3n5qJdm8V7kObzmD1J
         nlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972336; x=1711577136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJxbbaFLdDyVr7Us64ZQdBUVq66chOkLYZkEZAOhvTM=;
        b=RAMtr2B33gIao+ifwP6NHo5hWZ3Xd4Q16e+1MbPCrvMBuQOu/1dT6vtLR+nAZ0oUbF
         A3J78ubtN7DAWAC7MbGgYvmyaSdxvtVbRJGKA51RlyXtiyX/r/jAirNlHQcjuK/b3TsK
         /hS13+grp3rw8qIOxdsPXzfJ0jy7KwUP/m2B9DfgoxZAZoKY/0PYk55QiviFwwX7ZbR1
         mbrfd/z8Xu+MQvMkQIlV9oV9M9A7Xi3yW2FFivh6J9k31HGqfUlzs2T/NotLXoDPLcgu
         EAqhu/N6NwG67ynhBOVT+SN7LIfPb7JzOsh3ES785LYv1IXVocks744qeongM/cExkR6
         /8hQ==
X-Gm-Message-State: AOJu0Yya8NHL48ku+sioRmmk+U99v82Yrf00dRFZvUV2PRcnjPhWrTPQ
	Pi3YZOolJ7NHtkW/pKRVOxaXIlfArDAI9dnCn0ZkqFM+VdW1ct/tN4L+NwaUye/GDyftuk5cKkg
	TV6M=
X-Google-Smtp-Source: AGHT+IExc7AsB19goaoprC4x56ywnaj1ZQ7Um1kDr8j4/iyHjN8+173tkN+diPwJDVZ60tmrkc/2Bw==
X-Received: by 2002:a05:620a:1443:b0:78a:6de:8743 with SMTP id i3-20020a05620a144300b0078a06de8743mr9194281qkl.30.1710972336332;
        Wed, 20 Mar 2024 15:05:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pa30-20020a05620a831e00b0078a255927c0sm837019qkn.41.2024.03.20.15.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:36 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/24] pack-bitmap-write.c: write pseudo-merge table
Message-ID: <4c594f3faa875a6f54a801daf4250e2f8750a87c.1710972293.git.me@ttaylorr.com>
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
 pack-bitmap-write.c | 128 ++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h       |   1 +
 2 files changed, 129 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index db1c38f4e46..2d1b202fcd9 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "pseudo-merge.h"
+#include "oid-array.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -748,6 +749,127 @@ static void write_selected_commits_v1(struct hashfile *f,
 	}
 }
 
+static void write_pseudo_merges(struct hashfile *f)
+{
+	struct oid_array commits = OID_ARRAY_INIT;
+	struct bitmap **commits_bitmap = NULL;
+	off_t *pseudo_merge_ofs = NULL;
+	off_t start, table_start, next_ext;
+
+	uint32_t base = bitmap_writer_selected_nr();
+	size_t i, j = 0;
+
+	CALLOC_ARRAY(commits_bitmap, writer.pseudo_merges_nr);
+	CALLOC_ARRAY(pseudo_merge_ofs, writer.pseudo_merges_nr);
+
+	for (i = 0; i < writer.pseudo_merges_nr; i++) {
+		struct bitmapped_commit *merge = &writer.selected[base + i];
+		struct commit_list *p;
+
+		if (!merge->pseudo_merge)
+			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
+
+		commits_bitmap[i] = bitmap_new();
+
+		for (p = merge->commit->parents; p; p = p->next)
+			bitmap_set(commits_bitmap[i],
+				   find_object_pos(&p->item->object.oid, NULL));
+	}
+
+	start = hashfile_total(f);
+
+	for (i = 0; i < writer.pseudo_merges_nr; i++) {
+		struct ewah_bitmap *commits_ewah = bitmap_to_ewah(commits_bitmap[i]);
+
+		pseudo_merge_ofs[i] = hashfile_total(f);
+
+		dump_bitmap(f, commits_ewah);
+		dump_bitmap(f, writer.selected[base+i].write_as);
+
+		ewah_free(commits_ewah);
+	}
+
+	next_ext = st_add(hashfile_total(f),
+			  st_mult(kh_size(writer.pseudo_merge_commits),
+				  sizeof(uint64_t)));
+
+	table_start = hashfile_total(f);
+
+	commits.alloc = kh_size(writer.pseudo_merge_commits);
+	CALLOC_ARRAY(commits.oid, commits.alloc);
+
+	for (i = kh_begin(writer.pseudo_merge_commits); i != kh_end(writer.pseudo_merge_commits); i++) {
+		if (!kh_exist(writer.pseudo_merge_commits, i))
+			continue;
+		oid_array_append(&commits, &kh_key(writer.pseudo_merge_commits, i));
+	}
+
+	oid_array_sort(&commits);
+
+	/* write lookup table (non-extended) */
+	for (i = 0; i < commits.nr; i++) {
+		int hash_pos;
+		struct pseudo_merge_commit_idx *c;
+
+		hash_pos = kh_get_oid_map(writer.pseudo_merge_commits,
+					  commits.oid[i]);
+		if (hash_pos == kh_end(writer.pseudo_merge_commits))
+			BUG("could not find pseudo-merge commit %s",
+			    oid_to_hex(&commits.oid[i]));
+
+		c = kh_value(writer.pseudo_merge_commits, hash_pos);
+
+		hashwrite_be32(f, find_object_pos(&commits.oid[i], NULL));
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
+		hash_pos = kh_get_oid_map(writer.pseudo_merge_commits,
+					  commits.oid[i]);
+		if (hash_pos == kh_end(writer.pseudo_merge_commits))
+			BUG("could not find pseudo-merge commit %s",
+			    oid_to_hex(&commits.oid[i]));
+
+		c = kh_value(writer.pseudo_merge_commits, hash_pos);
+		if (c->nr == 1)
+			continue;
+
+		hashwrite_be32(f, c->nr);
+		for (j = 0; j < c->nr; j++)
+			hashwrite_be64(f, pseudo_merge_ofs[c->pseudo_merge[j]]);
+	}
+
+	/* write positions for all pseudo merges */
+	for (i = 0; i < writer.pseudo_merges_nr; i++)
+		hashwrite_be64(f, pseudo_merge_ofs[i]);
+
+	hashwrite_be32(f, writer.pseudo_merges_nr);
+	hashwrite_be32(f, kh_size(writer.pseudo_merge_commits));
+	hashwrite_be64(f, table_start - start);
+	hashwrite_be64(f, hashfile_total(f) - start + sizeof(uint64_t));
+
+	for (i = 0; i < writer.pseudo_merges_nr; i++)
+		bitmap_free(commits_bitmap[i]);
+
+	free(pseudo_merge_ofs);
+	free(commits_bitmap);
+}
+
 static int table_cmp(const void *_va, const void *_vb, void *_data)
 {
 	uint32_t *commit_positions = _data;
@@ -855,6 +977,9 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
 
+	if (writer.pseudo_merges_nr)
+		options |= BITMAP_OPT_PSEUDO_MERGES;
+
 	f = hashfd(fd, tmp_file.buf);
 
 	memcpy(header.magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE));
@@ -886,6 +1011,9 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
 
 	write_selected_commits_v1(f, commit_positions, offsets);
 
+	if (options & BITMAP_OPT_PSEUDO_MERGES)
+		write_pseudo_merges(f);
+
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
 		write_lookup_table(f, commit_positions, offsets);
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 0f539d79cfd..55527f61cd9 100644
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
2.44.0.303.g1dc5e5b124c

