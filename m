Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FF1AC8AD
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743073; cv=none; b=BmBTOlo9VeXW5p7Au0+lBNXsxKe/+aMSNWGWbvg1al8HHqwDO1lGpb9YnBKy+CPiViX6zYgD9sBWF7c4Sx8QfjWxnHfJiGN/mYOteF6ghAijtDKXKcFeP/buYi8z1bL4CgrdqtAkYav7ts7KUridFUR8a9AUtvS8i9TRRhJHrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743073; c=relaxed/simple;
	bh=/SW8UQUrlGvTDTyMB1b6LQ7DJd0FzIi3k97MeO103UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBmYmxqVR3YhVOizQc0hbMs7bKN5SPnv9WufsmXKQTC9EfxyrVuIaANWm87hDjKwTxsvJj/KU/42RdtQK93t21VPWjoGUiSh3FGNpLG74jLICi0a3tFjb6vWBe2Et0IurWYKP2kPrU/l2he0WUYVmS5QF4EhY3DkuPAiHzOF954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=CP1mCZMo; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CP1mCZMo"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0bf9b821e8so1210913276.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743070; x=1724347870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPWscMb/aq/2Qly7IOYyJH1CZhpa5gjX4bW5bmLYhX0=;
        b=CP1mCZMoqhgWjBLpWnUrOnUS/v8lx0KygG4hnRjaI6QYMD8adV9UXP0SPf9XngynrL
         DD6RGc+x0U1HC1IGsQBdGtCdaMF/OZHct1hnUMI9yC9KiWMa2jFMqmQRAe2cfW6EGHVQ
         oAhrijKgsbIq01uZ1u4zLN4L5Tl01FjLtpgE3aROofSX7rJEXJ7Pd82GPL/pkY9KZPZ/
         z/HOsok/DoxCgpSCVQG6X4dK72VVFCMgeTA6Vd6kVUKuR3TJTWFqRym0LkLuwIwwDEPM
         Swse9nkslmncs6hptDf23lTHYuvR31QnHVGieyG72Qma+OhuRy8FeXEcCbX2w5qPWmwR
         lZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743070; x=1724347870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPWscMb/aq/2Qly7IOYyJH1CZhpa5gjX4bW5bmLYhX0=;
        b=Z3bdveAvWrRoNoKU3qpwGfX5GpjE2rl/MY0iT9FXD3f4EzAawByNIYHg75G+sNgqQh
         3cyvnk5MtIXpEIV2qijMyp1e1OAd6fFexarN5GrJkJaQ+LURhFw/WrfkXIOS93ZyxWX2
         Pealb+XlBVjpRSAjwnIgnSRSfaBPpgY9b5AmHQXRG0Egqzv+044puSHazMLx3TdP5PCv
         yKAnvF1nJt1vJDf8T25j5c9QlwHq6rZ5pdqBz3NiI0IunoFhGdoyFVO3HYihdkD9F/+/
         JjaV9WR2c9egUvZjFKt7Q/L9OdiowogAnMfu/hO36Z6aCrXQQjuMRCByIZH4sXzXVJIi
         YcTQ==
X-Gm-Message-State: AOJu0YyU1GQXm3hDhFABe35iu8TNVKPJXJFooNKpp4mOe9Nucgb0mTLk
	Sp95/sOJNJjX53kyPutLuQNtN1UOwzeFqjJD3Rrw4GX/FGuprI8VVVsRAtbJnuH7FnCQv8CbWej
	J
X-Google-Smtp-Source: AGHT+IGlMN/IrpFXp0BDdkM/YY1RWx9Ba/SGIS/KrVS6ur8MhEZO34t9YZa5cnNR/8Y61D4ikHNEHg==
X-Received: by 2002:a05:6902:18c4:b0:e0b:e47d:ccc9 with SMTP id 3f1490d57ef6-e1180e6b23amr592390276.8.1723743070307;
        Thu, 15 Aug 2024 10:31:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1172031fe6sm385979276.58.2024.08.15.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:10 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] pack-bitmap: drop redundant args from
 `bitmap_writer_finish()`
Message-ID: <819a0765f380e69d2ae53304214d77dcdbb7b91c.1723743050.git.me@ttaylorr.com>
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
from the `bitmap_writer_finish()` function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 midx-write.c           | 3 +--
 pack-bitmap-write.c    | 8 ++++----
 pack-bitmap.h          | 1 -
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 97090433a1..e23c4950ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1370,7 +1370,7 @@ static void write_pack_file(void)
 				if (bitmap_writer_build(&bitmap_writer) < 0)
 					die(_("failed to write bitmap index"));
 				bitmap_writer_finish(&bitmap_writer,
-						     written_list, nr_written,
+						     written_list,
 						     tmpname.buf, write_bitmap_options);
 				bitmap_writer_free(&bitmap_writer);
 				write_bitmap_index = 0;
diff --git a/midx-write.c b/midx-write.c
index 1ccdf0df30..d2d13447af 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -851,8 +851,7 @@ static int write_midx_bitmap(const char *midx_name,
 		goto cleanup;
 
 	bitmap_writer_set_checksum(&writer, midx_hash);
-	bitmap_writer_finish(&writer, index, pdata->nr_objects, bitmap_name,
-			     options);
+	bitmap_writer_finish(&writer, index, bitmap_name, options);
 
 cleanup:
 	free(index);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 8d7437955d..346fb29513 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -998,7 +998,6 @@ void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 
 void bitmap_writer_finish(struct bitmap_writer *writer,
 			  struct pack_idx_entry **index,
-			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options)
 {
@@ -1031,12 +1030,13 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 	dump_bitmap(f, writer->tags);
 
 	if (options & BITMAP_OPT_LOOKUP_TABLE)
-		CALLOC_ARRAY(offsets, index_nr);
+		CALLOC_ARRAY(offsets, writer->to_pack->nr_objects);
 
 	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *stored = &writer->selected[i];
 		int commit_pos = oid_pos(&stored->commit->object.oid, index,
-					 index_nr, oid_access);
+					 writer->to_pack->nr_objects,
+					 oid_access);
 
 		if (commit_pos < 0)
 			BUG(_("trying to write commit not in index"));
@@ -1052,7 +1052,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 		write_lookup_table(writer, f, offsets);
 
 	if (options & BITMAP_OPT_HASH_CACHE)
-		write_hash_cache(f, index, index_nr);
+		write_hash_cache(f, index, writer->to_pack->nr_objects);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 0c5b83e954..ff0fd815b8 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -149,7 +149,6 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 int bitmap_writer_build(struct bitmap_writer *writer);
 void bitmap_writer_finish(struct bitmap_writer *writer,
 			  struct pack_idx_entry **index,
-			  uint32_t index_nr,
 			  const char *filename,
 			  uint16_t options);
 void bitmap_writer_free(struct bitmap_writer *writer);
-- 
2.46.0.54.gc9a64b1d2a

