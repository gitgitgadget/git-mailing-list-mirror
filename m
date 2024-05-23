Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D41292E9
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499588; cv=none; b=QKlL2wxHv542fBodQMTD52aRNbmt0oTjxRRQSWqK63oxeHv6tZ9FIvewmXDJbu6x1Jp5ix9PrV+I0QOsfL0dSZLGzkacsqv652CdiqW0phmxU+mPeS7bFHi6Sj2k4AL9pXXYCN4TMOp/qFcN4eojv4BHjsWlMStu1v98zhMpTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499588; c=relaxed/simple;
	bh=JQFeOzZPRi30+17T+1kb+CRnxss4pIC0YEGwVEm/cnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oifKJmFAFl9BBl4Kbm8XFVnEaPW/XIqpK4bME+kgugPQvQmo6DWWYyUqY6Ogd+3lhw2eYqU63I9WrEzoMznOuFPV+SrYWmlJOSnYJDS85gLRJfQGvuGb5NEAPT96d/wwAQZ1QLeIBaDQpU48axDP/2u44AtV2HUCqJY1SJeuBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Zp9kztpV; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Zp9kztpV"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-627ebbe7720so23951587b3.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499585; x=1717104385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rwgV4LKg4jESB8+yWiBKJLJrM6OHHYtmulSn+FnkSM=;
        b=Zp9kztpVEeWbbZzNUvFjLm8HSf5yFKpN4Z0pkizVt8I8eEIwElM156zsFWK4mmGtvw
         VuFWTY8Q/CeRRgXi1V5ilv7TZJQPYv3FIyvsSCNC16jVy4bQoUhlk6QkRqm2cQxSsUt1
         B4DnTTz4MEV4i2ojoDn6RdqZteM12XBH7e1xkCPNfvcuJOFB15s8fnv6tphDCfhMm+RX
         kGwo1A/c1eHmMyvCZTYS6E2m8H7ttAH6SMU4/RXqMm7GXWcEqOVVvtABdWx/XpHfExw4
         ItG4+nwDBv6b36ULMpsQWPYtrk372o/14KkZr3Un6JdpP47+c9si37bpkt58OkpTIX/Q
         lD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499585; x=1717104385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rwgV4LKg4jESB8+yWiBKJLJrM6OHHYtmulSn+FnkSM=;
        b=j7+WQEynkR5KSmIh1jyhOeYy5OJXG81l26A1mvc4Q92Fd8vEA20CrvogieaeOxJHmB
         V1ngQgnRuoKhcIaqEVo8q44iAVstlEhx+UyYTfbe0E7mLq4K6LOcWM+1lqGNAg9AXiXo
         IxslonlbXkZuxqtdOt8k0eLOlBIUtqpztV+Z2C/nNRHu5hYAWw0IX2ndXZ5ajb4PAHUI
         HmatWAXyWtz/kCrdQN4JjXVKAMMWMxSJ0iuHZAJbtsMx0WDcAqb+WBGMo9LQY/G/1F3S
         s1dqASqk+OwHV3mpLLWT4fDQCeKaiGWjFvoimlCNav+hCS6kL0Jhd1A9KypJ1ociiqPn
         pN8A==
X-Gm-Message-State: AOJu0Yzn39cPPm5c7T3f7FBp37/c19S8Cbb3tMH9V1q53LxwlDy2FAMA
	CfV47v4Ir65GUb6azE9BUrCSb7OaaxX/8c5wPlG1DSa7ZzWc9N+PjswuZO22fUXMeapz5FEm9SH
	X
X-Google-Smtp-Source: AGHT+IF/oqcczS8r7AtJ0JmR7b5PKa1+A1yATR31uacULmLNvLBQAg7pNEL9s5ycY1nHAw7s3Km2RQ==
X-Received: by 2002:a05:6902:2787:b0:de6:a3d:265f with SMTP id 3f1490d57ef6-df772156e66mr507022276.2.1716499584897;
        Thu, 23 May 2024 14:26:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070dc53bsm623636d6.41.2024.05.23.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:24 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/24] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <650cac2dcf920b2bb64d7a026aa83228a2b2c354.1716499565.git.me@ttaylorr.com>
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

The pack-bitmap-writer machinery uses a oidmap (backed by khash.h) to
map from commits selected for bitmaps (by OID) to a bitmapped_commit
structure (containing the bitmap itself, among other things like its XOR
offset, etc.)

This map was initialized at the end of `bitmap_writer_build()`. New
entries are added in `pack-bitmap-write.c::store_selected()`, which is
called by the bitmap_builder machinery (which is responsible for
traversing history and generating the actual bitmaps).

Reorganize when this field is initialized and when entries are added to
it so that we can quickly determine whether a commit is a candidate for
pseudo-merge selection, or not (since it was already selected to receive
a bitmap, and thus storing it in a pseudo-merge would be redundant).

The changes are as follows:

  - Introduce a new `bitmap_writer_init()` function which initializes
    the `writer.bitmaps` field (instead of waiting until the end of
    `bitmap_writer_build()`).

  - Add map entries in `push_bitmapped_commit()` (which is called via
    `bitmap_writer_select_commits()`) with OID keys and NULL values to
    track whether or not we *expect* to write a bitmap for some given
    commit.

  - Validate that a NULL entry is found matching the given key when we
    store a selected bitmap.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  3 ++-
 midx-write.c           |  2 +-
 pack-bitmap-write.c    | 24 ++++++++++++++++++------
 pack-bitmap.h          |  2 +-
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 26a6d0d7919..6209264e60c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1340,7 +1340,8 @@ static void write_pack_file(void)
 				    hash_to_hex(hash));
 
 			if (write_bitmap_index) {
-				bitmap_writer_init(&bitmap_writer);
+				bitmap_writer_init(&bitmap_writer,
+						   the_repository);
 				bitmap_writer_set_checksum(&bitmap_writer, hash);
 				bitmap_writer_build_type_index(&bitmap_writer,
 					&to_pack, written_list, nr_written);
diff --git a/midx-write.c b/midx-write.c
index 7c0c08c64b2..c747d1a6af3 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -820,7 +820,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer);
+	bitmap_writer_init(&writer, the_repository);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, pdata, index,
 				       pdata->nr_objects);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6cae670412c..d8870155831 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -27,9 +27,12 @@ struct bitmapped_commit {
 	uint32_t commit_pos;
 };
 
-void bitmap_writer_init(struct bitmap_writer *writer)
+void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
 {
 	memset(writer, 0, sizeof(struct bitmap_writer));
+	if (writer->bitmaps)
+		BUG("bitmap writer already initialized");
+	writer->bitmaps = kh_init_oid_map();
 }
 
 void bitmap_writer_free(struct bitmap_writer *writer)
@@ -128,11 +131,21 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 static inline void push_bitmapped_commit(struct bitmap_writer *writer,
 					 struct commit *commit)
 {
+	int hash_ret;
+	khiter_t hash_pos;
+
 	if (writer->selected_nr >= writer->selected_alloc) {
 		writer->selected_alloc = (writer->selected_alloc + 32) * 2;
 		REALLOC_ARRAY(writer->selected, writer->selected_alloc);
 	}
 
+	hash_pos = kh_put_oid_map(writer->bitmaps, commit->object.oid,
+				  &hash_ret);
+	if (!hash_ret)
+		die(_("duplicate entry when writing bitmap index: %s"),
+		    oid_to_hex(&commit->object.oid));
+	kh_value(writer->bitmaps, hash_pos) = NULL;
+
 	writer->selected[writer->selected_nr].commit = commit;
 	writer->selected[writer->selected_nr].bitmap = NULL;
 	writer->selected[writer->selected_nr].write_as = NULL;
@@ -483,14 +496,14 @@ static void store_selected(struct bitmap_writer *writer,
 {
 	struct bitmapped_commit *stored = &writer->selected[ent->idx];
 	khiter_t hash_pos;
-	int hash_ret;
 
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
-	hash_pos = kh_put_oid_map(writer->bitmaps, commit->object.oid, &hash_ret);
-	if (hash_ret == 0)
-		die("Duplicate entry when writing index: %s",
+	hash_pos = kh_get_oid_map(writer->bitmaps, commit->object.oid);
+	if (hash_pos == kh_end(writer->bitmaps))
+		die(_("attempted to store non-selected commit: '%s'"),
 		    oid_to_hex(&commit->object.oid));
+
 	kh_value(writer->bitmaps, hash_pos) = stored;
 }
 
@@ -506,7 +519,6 @@ int bitmap_writer_build(struct bitmap_writer *writer,
 	uint32_t *mapping;
 	int closed = 1; /* until proven otherwise */
 
-	writer->bitmaps = kh_init_oid_map();
 	writer->to_pack = to_pack;
 
 	if (writer->show_progress)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3091095f336..f87e60153dd 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -114,7 +114,7 @@ struct bitmap_writer {
 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
 };
 
-void bitmap_writer_init(struct bitmap_writer *writer);
+void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r);
 void bitmap_writer_show_progress(struct bitmap_writer *writer, int show);
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1);
-- 
2.45.1.175.gcf0316ad0e9

