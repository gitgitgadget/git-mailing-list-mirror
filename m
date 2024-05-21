Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A21494BF
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318137; cv=none; b=diZ2QIFek7HUKZg1jE92hW+iUyWtz6qCM2jqKEHjg3UMOHCRt7iMMAOtnNHFGBESj6UApCsgynCeKS1FYtrbBcl28qhGfZen2BkWhVf4et2Nb1UqgWQu9f0Yhrc2VFhDHcYkUtAP1FagDfn2AVNViOnQ6GhVZYrifYwxdIctInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318137; c=relaxed/simple;
	bh=rFwwZzCpRRs2uUVGpntak1ggwg0sOFRPsErihbQO8kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blALrZ7TuBwbaw7jfDo1kvFuThiQlMSWZf5GEqdGOFSU8x4ahqKhvS00xBYTZ0X9BufkF6p+9EqWMoOLSiaaZjR+4cxgzzqGgKdeCyAmY1ejMq71Ra+vFTjfxUKJjl81uiLjIf/3HMQVSFbTRKQY808q5VqDk84pKfcnPFhDFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AZbxcI9u; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AZbxcI9u"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43de92e234dso1523631cf.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318134; x=1716922934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KXAwHXRnd6XAfJ4r/CzVC8TwkfRAR3OfEiLzf2F99G8=;
        b=AZbxcI9uAI6+nPoLG7U4A9Uk/YfUr+tygjirmri8cU4LAKlk4zWHMC/83Gjj3QtGnu
         uUD09kVqPJAGqfS1YZJYn+C8bB+pCSnNkTrPeIio1jO4eT+G4sIEJhoYzeSayDUYBYmH
         FUPTuYIvjBn8yy0FdrzHhIRWWRYlqZzp/3pp3HUdqwvDhy/euH0fA/mINlDfI2G/NcT4
         7yFfrxtfxmsaiFzLXwTJbF5iKZNn4B85dv123+5BsrqiDCPXFFuLLb/i449EeOAlxRtH
         QFlfG3a9xrNfrYFa5xaQOlr+yRFglQz2Lo+9X7wc7KgJHO4+Qokz5qtFHZFwho1kYtOb
         RWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318134; x=1716922934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXAwHXRnd6XAfJ4r/CzVC8TwkfRAR3OfEiLzf2F99G8=;
        b=lwAp2Wvd4ncguJSam5re+MTpo5gNhPSSlFnIbz0JnKrABJi03WzS/mZ0KPN2dEH6MN
         lEAv5hNg8F0uqjO2Jax76KIKOwGuF9mzckCn1PqYD5V9X5cDkudSKeIxCHrKbDM06/WS
         s+4Ak3zDG1ATQqnI3+2mKzGIm047JRLAKS9esfairSjRQusnZVGo2IoDWFt8ZIr7msH6
         ck9JqdNtztE0vVyBX3ahVqhsk2B568shKvp0wyVArhFaQaJIgvK55AtnejV+lYNY1xJ6
         oJRLbQ9rrmHPFyUt5hlYXH3ZMTeELODx0fK61jMDQBa4GcB1nsG1bwAF7VpdsDhWRoHq
         yLcw==
X-Gm-Message-State: AOJu0YwdryrR+LYJNmKsRUSij0CdFpjb4ymcCvrkcrylkL44MEcmFjDr
	s/cYu4+yaSdHtt1QO/yo5KDWT4YBrmcadb1mZHtOb23V13bfDpzCAZHjInAy8tEi6D8p9j1Go+o
	g
X-Google-Smtp-Source: AGHT+IFRoZ+OBaPTyRdV3qFFAnxf01S4Vn6ul4Z0vird8DrWVFUNiRI31+pW0LBVGvAtAhFD2GmFuw==
X-Received: by 2002:a05:622a:1186:b0:43a:b8e2:5870 with SMTP id d75a77b69052e-43f9dd930eamr216041cf.3.1716318134293;
        Tue, 21 May 2024 12:02:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43dfa7c0c1esm156526451cf.34.2024.05.21.12.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:13 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/30] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <487fb7c6e9c760f3febb1d795b9b6f408f67ea0d.1716318089.git.me@ttaylorr.com>
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
2.45.1.175.gbea44add9db

