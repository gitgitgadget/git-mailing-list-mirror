Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468F227563
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493398; cv=none; b=Hi9foCWD5aA0tTNrFryWy4UOpDvGitNDzIfmuHjVnsZV8QS6mS0WH7USiJzrc3BH2HCNHTofhl/qs8A+j8f4lrK6+XuuksewSzzAbtc67nUMhUZ60WsBPqGW78e1T8Ba9ULPSvJ5tR5yCj3jUaKiKauK+O+Gu97dko2jektwBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493398; c=relaxed/simple;
	bh=WnVeB1hbVLcyjXSQUbTbZCThBQSh0ip1ULFqeTh1Io0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0s97h8WIdcDvEilVN75ms6DAVK3IDLe6QZgk6FdUsNbr+GeWj7eGLqJ2G8IgyLVZqJzD0hKc1jeS3c5my2TAAZcCeNI7Jrw7rjuufD/eSxuG499i8xETOwr8skxEmSFQjAhY8JFRRazb/1Ce++Je6rAc3FxrdkCrStzXYazuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NgF0xOR/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NgF0xOR/"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5a88b34a6so114278285a.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742493396; x=1743098196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8BumMeL9zYKjokSFg9jhQgkRk22D7RUsejzgnvQcvU=;
        b=NgF0xOR/GOm9f5Pb5DcEsXqiEn+2DlcHPrUW7eX8THzwRhpyEi0hp0Fs6F87NbGPZ8
         zY0awV04bWAKOiN+4914Nis+y3fCFMrA8xFXcQRHbkDND7buKmurNVvxITPAnWurerLG
         F1IY5eZiA3fWrCqCGzqJbCw9v6eLGTtWBp6gT+GZYM3YjmRs8zR74cqonN/8iWWAvqLL
         LKmhHGNLLwni0jBzMyMXgRjuj0eBE+rIb2E5fZ5AQ/JGkOtx8fZV+6DbMfDcSO6FzYay
         55EyKx7yw2RG2B6l+rWnCs0BzP8cNX9hVGs3ztxlqkDxuE47qxO0BLA+fzKHXHhYdqY1
         evaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493396; x=1743098196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8BumMeL9zYKjokSFg9jhQgkRk22D7RUsejzgnvQcvU=;
        b=OBUAI8feK2Dui3sttwsYzYaarA5gnzsyJM6TiuFGtO4FoUNKAbwGBuJ2Vu/f9cfXqU
         KfpTmIzLfZ/LjJlbs6eoKz3czoL/KIcucPGf/bEDKM+zyidD33zcgMvAnb22zyGVdmVb
         3y4hgoBkSmT2B/W/GvzetxYfWQQ5DIUrkq06Bq8Vm8ExLQz2VXAoO2QgZbz28t5S3ckw
         fLHVM8yL+mUmVHNh5ncoSAon+V6UwcFCNZAW6QyKkcjp6BW5JF6c8KXiVTW5lIgANoQ5
         h17pc723be8XZvYFFrNi2ehBSTL/3uIa23X41PDMsWUK4vtn/+wpbF4IPqm6qWwJgqMH
         WPDw==
X-Gm-Message-State: AOJu0YznzDZo2gdWB6fiCkG2hnr8FzazQHCgqnlJaF7nr4GbGvA9xWWo
	vEYAEAhe2rUwUQ26YbBq5gfBKoice0Nxu47LceAkt3xhwU94hrv5pcHfAmuobKJueyZIUPw8Xbr
	2cr0=
X-Gm-Gg: ASbGncuyxO2EBfpoaATGbwUc3aGrHthZ1ZOtvrAIgJdugf8JQ9XpR4R8mzgySbsWQxU
	fQWFj4lW2c6yR5MEfnsbosFSDYZp+9obxOEo2/MVEimlz4lQ71oc7TdfxVFDbsSqILQf53u7S+t
	IcFiJn7tMzUw3kx6rqhWoJachD82qyhxHroQqIrZKAKORUsOLkUgAxkNYDJL/mdjg92HpQ50eWs
	8u9CmR03Rq8hlaknpqZHEOT5B52YYW3dDYtDhZ4YCfggPqcgr3egWLFk5QUtBGDC1UuCndOOIOf
	K70qHbcVUltQpgVCa6bBEEYEnf8S5lvcTEECy/ryVWHuHq2iZXaRcW47+/WXYYo5czwVdHYbpXN
	v8f/qiUWJACK/OK+LjkPo9RXfIrM=
X-Google-Smtp-Source: AGHT+IHCF4r7d26tDjcEyrgKo6pBpc96SI6SdQxpwbAJynuJdWiVoBmUk3Ddfpy0JJQ5PBEgpPdIwg==
X-Received: by 2002:a05:620a:3908:b0:7c3:c329:792f with SMTP id af79cd13be357-7c5ba135bd1mr17030785a.3.1742493395831;
        Thu, 20 Mar 2025 10:56:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b92b8609sm16451185a.18.2025.03.20.10.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 10:56:35 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 04/14] pack-bitmap.c: open and store incremental bitmap
 layers
Message-ID: <922ea2f6075b47419a07e881efb2557ac73ba0c9.1742493373.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1742493373.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>

Prepare the pack-bitmap machinery to work with incremental MIDXs by
adding a new "base" field to keep track of the bitmap index associated
with the previous MIDX layer.

The changes in this commit are mostly boilerplate to open the correct
bitmap(s), add them to the chain of bitmap layers along the "base"
pointer, ensure that the correct packs and their reverse indexes are
loaded across MIDX layers, etc.

While we're at it, keep track of a base_nr field to indicate how many
bitmap layers (including the current bitmap) exist. This will be used in
a future commit to allocate an array of 'struct ewah_bitmap' pointers to
collect all of the respective type bitmaps among all layers to
initialize a multi-EWAH iterator.

Subsequent commits will teach the functions within the pack-bitmap
machinery how to interact with these new fields.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 62 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 87f3b5cf4d..e84211de15 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -54,6 +54,16 @@ struct bitmap_index {
 	struct packed_git *pack;
 	struct multi_pack_index *midx;
 
+	/*
+	 * If using a multi-pack index chain, 'base' points to the
+	 * bitmap index corresponding to this bitmap's midx->base_midx.
+	 *
+	 * base_nr indicates how many layers precede this one, and is
+	 * zero when base is NULL.
+	 */
+	struct bitmap_index *base;
+	uint32_t base_nr;
+
 	/* mmapped buffer of the whole bitmap index */
 	unsigned char *map;
 	size_t map_size; /* size of the mmaped buffer */
@@ -386,8 +396,15 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
 char *midx_bitmap_filename(struct multi_pack_index *midx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	get_midx_filename_ext(midx->repo->hash_algo, &buf, midx->object_dir,
-			      get_midx_checksum(midx), MIDX_EXT_BITMAP);
+	if (midx->has_chain)
+		get_split_midx_filename_ext(midx->repo->hash_algo, &buf,
+					    midx->object_dir,
+					    get_midx_checksum(midx),
+					    MIDX_EXT_BITMAP);
+	else
+		get_midx_filename_ext(midx->repo->hash_algo, &buf,
+				      midx->object_dir, get_midx_checksum(midx),
+				      MIDX_EXT_BITMAP);
 
 	return strbuf_detach(&buf, NULL);
 }
@@ -454,16 +471,21 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		goto cleanup;
 	}
 
-	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-		if (prepare_midx_pack(bitmap_repo(bitmap_git),
-				      bitmap_git->midx,
-				      i)) {
+	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
+		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
 				bitmap_git->midx->pack_names[i]);
 			goto cleanup;
 		}
 	}
 
+	if (midx->base_midx) {
+		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
+	} else {
+		bitmap_git->base_nr = 0;
+	}
+
 	return 0;
 
 cleanup:
@@ -515,6 +537,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	bitmap_git->map_size = xsize_t(st.st_size);
 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	bitmap_git->map_pos = 0;
+	bitmap_git->base_nr = 0;
 	close(fd);
 
 	if (load_bitmap_header(bitmap_git) < 0) {
@@ -534,8 +557,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git)) {
-		uint32_t i;
-		int ret;
+		struct multi_pack_index *m;
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
@@ -544,10 +566,15 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
 		 */
-		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
-			ret = load_pack_revindex(r, bitmap_git->midx->packs[i]);
-			if (ret)
-				return ret;
+		for (m = bitmap_git->midx; m; m = m->base_midx) {
+			uint32_t i;
+			int ret;
+
+			for (i = 0; i < m->num_packs; i++) {
+				ret = load_pack_revindex(r, m->packs[i]);
+				if (ret)
+					return ret;
+			}
 		}
 		return 0;
 	}
@@ -573,6 +600,13 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
 		goto failed;
 
+	if (bitmap_git->base) {
+		if (!bitmap_is_midx(bitmap_git))
+			BUG("non-MIDX bitmap has non-NULL base bitmap index");
+		if (load_bitmap(r, bitmap_git->base) < 0)
+			goto failed;
+	}
+
 	return 0;
 
 failed:
@@ -657,10 +691,9 @@ struct bitmap_index *prepare_bitmap_git(struct repository *r)
 
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
-	struct repository *r = midx->repo;
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
+	if (!open_midx_bitmap_1(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);
@@ -2901,6 +2934,7 @@ void free_bitmap_index(struct bitmap_index *b)
 		close_midx_revindex(b->midx);
 	}
 	free_pseudo_merge_map(&b->pseudo_merges);
+	free_bitmap_index(b->base);
 	free(b);
 }
 
-- 
2.49.0.14.g88b49c1b34

