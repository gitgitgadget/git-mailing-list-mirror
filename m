Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A898D1AC8AD
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743070; cv=none; b=kAsVNRIECUyEhFbVUmeogPwwWrrq5BZTbIqOiVTKG1byI0p36CYtQZGuhKWBHhwMHFRuvCPPzztfa1R5EavcTQ2dpJK0soCs5jFIZ3e0Ufkq5sOj7qgmv2sTmdcEFn/ZRoUTK6uFKq7NEk1kKQVHSXcG372KVHaXi0u7J+YXqx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743070; c=relaxed/simple;
	bh=qsk/+ZEBfqtYOwcRYId3MIMMQ4jpX2ZmeLaYG+XHo08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHE7cZxcAeeSQPzZ3t1DgGRGnkugw6eWndyYQUFr2A1hPki7eJfzMx8Ze7BeLFuiicEk4wkjb3dmkEteHImURw2Ygsm43f8+zLxSo60rQM0pn9AymntT4ejtAuKaZps4FtuexVHt0xRLw8099yJW0KYb1QFTC49qdCBKmBz6elU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bIVDKu7v; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bIVDKu7v"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-651da7c1531so11401367b3.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743067; x=1724347867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AGCuqafwp6JTN3h3USTiyPTerSi7lVscMbMQyuEqzY=;
        b=bIVDKu7vvooUkWLtDPJUaUiRGvH5JzpLii/+VqC4RbT8jLEiZ/y5pUMXkxjVm7xnl2
         pQPbUYQuBdg7Y+WtqgrZGXvygYTOg/x1abUsZiKQwFCvD3H5xXt6Ig1w6SYs2jXxXV0r
         LnYtRzTUCJtmwTYqa2/S7hNFB71sZDMmGA/XOshDcQQeBqchqN+qQSqXOJoGccKAaSuP
         7JfAhufK6oIj7Pf0fPWl45T5JtJ2896ccTUPOI5VxLxkgXrsz+tAmwCogY90J9qJ1HMK
         1t77DHVOVqP6C95Se18x+OUDuU4EbbmEDHbEnHRcsAbwriTFnGixrK09oUFDY7YChr9s
         X4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743067; x=1724347867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AGCuqafwp6JTN3h3USTiyPTerSi7lVscMbMQyuEqzY=;
        b=fzq7OdNSlboR8Buo1D+YSaa0rrYeI7q4I/7TwE0Y1V8skn2RDUKcWeV8YZhXFeHfgR
         LVKWZR0vEmbOJp7J32f1Fmh1sgZDD0hCnOXhWQ/GbeWgIel3mQnsQcPe59vkCGJ6rZGV
         0xSpNAac6ovPDyhbUp5e5SPde1a7g6yIMB09gZfWJozxsRC4Y6UZQPzC+UbGoXKg6kFR
         QIGXO5FwCpSEZAdaYGTnubkvaxck8dmLAvw3d5Fzwy0Donmb0XXk2I+W0EbrodjezW7b
         ChSIuzXTuCB6Wk1zBRJP4+Y0szhk/ax4qetd0nV+lHHAC4KMIz5awF/kAxCHTTKXdv/W
         kUOA==
X-Gm-Message-State: AOJu0YzPvF3I0ap00Sg1t4Qx+X5S1nZneleZ3s9UKVVF5MzeAAY0y/ET
	tnGbcJW/BlOoZSivdpG3HitbAjiOeI/p1Ux7VV50xXgz5xUwGJp8OOqgDO+L6ZQEqpId7A2qp6K
	d
X-Google-Smtp-Source: AGHT+IEIkdJtQvoCouz2OTWMy9UMggVd6m+1nlZEPFfPKauSgVM+dVqare3ah+rFRCWg1DrxFmu0eQ==
X-Received: by 2002:a05:690c:4183:b0:6af:125a:1c5d with SMTP id 00721157ae682-6b1bc3f6774mr2582277b3.38.1723743067395;
        Thu, 15 Aug 2024 10:31:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d82757esm3197037b3.104.2024.08.15.10.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:07 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/8] pack-bitmap: drop redundant args from
 `bitmap_writer_build()`
Message-ID: <5e198489fa807c551c36b391c8e8ca8efb0c52b9.1723743050.git.me@ttaylorr.com>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

In a similar fashion as the previous commit, drop a redundant argument
from the `bitmap_writer_build()` function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 midx-write.c           | 2 +-
 pack-bitmap-write.c    | 9 +++------
 pack-bitmap.h          | 3 +--
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c08a62718d..97090433a1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1367,7 +1367,7 @@ static void write_pack_file(void)
 				bitmap_writer_select_commits(&bitmap_writer,
 							     indexed_commits,
 							     indexed_commits_nr);
-				if (bitmap_writer_build(&bitmap_writer, &to_pack) < 0)
+				if (bitmap_writer_build(&bitmap_writer) < 0)
 					die(_("failed to write bitmap index"));
 				bitmap_writer_finish(&bitmap_writer,
 						     written_list, nr_written,
diff --git a/midx-write.c b/midx-write.c
index b3015af07f..1ccdf0df30 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -846,7 +846,7 @@ static int write_midx_bitmap(const char *midx_name,
 		index[pack_order[i]] = &pdata->objects[i].idx;
 
 	bitmap_writer_select_commits(&writer, commits, commits_nr);
-	ret = bitmap_writer_build(&writer, pdata);
+	ret = bitmap_writer_build(&writer);
 	if (ret < 0)
 		goto cleanup;
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 34cdf5f150..8d7437955d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -569,8 +569,7 @@ static void store_selected(struct bitmap_writer *writer,
 	kh_value(writer->bitmaps, hash_pos) = stored;
 }
 
-int bitmap_writer_build(struct bitmap_writer *writer,
-			struct packing_data *to_pack)
+int bitmap_writer_build(struct bitmap_writer *writer)
 {
 	struct bitmap_builder bb;
 	size_t i;
@@ -581,17 +580,15 @@ int bitmap_writer_build(struct bitmap_writer *writer,
 	uint32_t *mapping;
 	int closed = 1; /* until proven otherwise */
 
-	writer->to_pack = to_pack;
-
 	if (writer->show_progress)
 		writer->progress = start_progress("Building bitmaps",
 						  writer->selected_nr);
 	trace2_region_enter("pack-bitmap-write", "building_bitmaps_total",
 			    the_repository);
 
-	old_bitmap = prepare_bitmap_git(to_pack->repo);
+	old_bitmap = prepare_bitmap_git(writer->to_pack->repo);
 	if (old_bitmap)
-		mapping = create_bitmap_mapping(old_bitmap, to_pack);
+		mapping = create_bitmap_mapping(old_bitmap, writer->to_pack);
 	else
 		mapping = NULL;
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d2529abadc..0c5b83e954 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -146,8 +146,7 @@ struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_g
 void bitmap_writer_select_commits(struct bitmap_writer *writer,
 				  struct commit **indexed_commits,
 				  unsigned int indexed_commits_nr);
-int bitmap_writer_build(struct bitmap_writer *writer,
-			struct packing_data *to_pack);
+int bitmap_writer_build(struct bitmap_writer *writer);
 void bitmap_writer_finish(struct bitmap_writer *writer,
 			  struct pack_idx_entry **index,
 			  uint32_t index_nr,
-- 
2.46.0.54.gc9a64b1d2a

