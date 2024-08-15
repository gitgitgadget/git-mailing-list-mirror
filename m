Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E29446CF
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743066; cv=none; b=oCOoQFyBE5xHRT+b+5gK4oQYZMKvybbU2ucR3CAKMXNxT90RbR0UdxqXepIV/gWyLRZGibzIy2TUQr0EqSLBKLHOJMUve5MEVZgUFaGtM46yKB/MoJbONem3KqwH0CJvqKnViqIXywW47bs7gv15Bl91lgiJwBWbzYqEFwH2pAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743066; c=relaxed/simple;
	bh=CtODriVAFScW8TmG+duJ8zp7wBVOgHUNrJuJO76haf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1ne5LVRhavuTocG8B5opqQ3UsHrVqYMqFS0QE+YkXcCqEHDLvYRanFtvP207dgEBWTV8obVQwxanlqYaO4U0JKaYS6MCBXeQUakI6y+2QFTpmL+/rF4H8oGYivq+8ghiD7NtNJaQ4KdkO3eQ+xY+536uKTabaMLgeCx0WxUYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xn4ch6rf; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xn4ch6rf"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-685cc5415e8so12304347b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743061; x=1724347861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFKdT9p5VTOnLKtZORotBuoE9O3KxtZKM/MyGcn0tiI=;
        b=xn4ch6rfdlgVlqhOxwSRYiSZ73R/51P5+N7cWoqpNkxCh9BDaxl7ec85z0ldYSM0HC
         GKs3QdDvPugypiGnumJzNCKEsVqRBD8zZhVrDeTf0wi1BnBJ/o31egWtOZ15WgstIpmi
         v05+EAR0hHr5+q22197ViOWXR4KnoqZgbNDyz/ww7M4S+gy/llBWde4AR0kos8nmk/Qn
         UbH2oibF3v8reFfJt0L0PGK8lmgfgaGCkJhQOn1OVUmXw/BNBUosy7E0BiNX+DaPWF7w
         mWgtMkE6+HupDGkKKJbw3ViqsUztnlq5MOIhX79bub62Ut9GyxhWItQkN5ELvAMp2dd8
         etcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743061; x=1724347861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFKdT9p5VTOnLKtZORotBuoE9O3KxtZKM/MyGcn0tiI=;
        b=ondIDrP8a7BmcuJVqGgVmvIu8yJQNF79bP0k/dNLXyObqFlxG7xIb/ieyGWO5UFRZ6
         uQEYMpeFvwS1xLuQmbD+yYvRkMVvuQmG/76du6PrtpHk38FfM7eqLEGqxELogtUSzlDR
         PJ/5olG3TrPrxUXiUmuU2VtzAWzCw61I8c2U64sPxbkBHTb4761Mo8pRCdzzXQ941tlE
         YaYY+2ddUwbk1hXGKYG1eunMtPBdsYze10lJCga9B5P2P9Ih2XXC8pduj3tWUrjEPmG5
         KOBT/CWH04sBQJBujR7fpyX8onXa6mgqAlT/5XkTRCAgJZQI7enE2lFLXFgu6DS5Zw3X
         lmdg==
X-Gm-Message-State: AOJu0YyTqY2iMSmnbt8OefDme2fnhUF08K8pamCaYW7z3a52+YLzrYms
	SOIMEf3NyuIuPEi91bJej/iVn39ud0qIe7zP3hBzPFGh66rem8vWo5x/B8obDOxMF+W9WppisqH
	Y
X-Google-Smtp-Source: AGHT+IHYnrZBbfil70YIIcVD2WLttzO4DIGYew8/c7Lzwu7XoQRi9XtnQEt5s4fje7IzNgriFLCo3A==
X-Received: by 2002:a05:690c:4f04:b0:6af:eb0b:6544 with SMTP id 00721157ae682-6b1bb85e488mr3054747b3.35.1723743061422;
        Thu, 15 Aug 2024 10:31:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9ce76050sm3134117b3.101.2024.08.15.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:01 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/8] pack-bitmap: initialize `bitmap_writer_init()` with
 packing_data
Message-ID: <9d322fc5399c453913d08f35eee907b5c909ad6b.1723743050.git.me@ttaylorr.com>
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

In order to determine its object order, the pack-bitmap machinery keeps
a 'struct packing_data' corresponding to the pack or pseudo-pack (when
writing a MIDX bitmap) being written.

The to_pack field is provided to the bitmap machinery by callers of
bitmap_writer_build() and assigned to the bitmap_writer struct at that
point.

But a subsequent commit will want to have access to that data earlier on
during commit selection. Prepare for that by adding a 'to_pack' argument
to 'bitmap_writer_init()', and initializing the field during that
function.

Subsequent commits will clean up other functions which take
now-redundant arguments (like nr_objects, which is equivalent to
pdata->objects_nr, or pdata itself).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 midx-write.c           | 2 +-
 pack-bitmap-write.c    | 4 +++-
 pack-bitmap.h          | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f395488971..0ad533c045 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1342,7 +1342,7 @@ static void write_pack_file(void)
 
 			if (write_bitmap_index) {
 				bitmap_writer_init(&bitmap_writer,
-						   the_repository);
+						   the_repository, &to_pack);
 				bitmap_writer_set_checksum(&bitmap_writer, hash);
 				bitmap_writer_build_type_index(&bitmap_writer,
 					&to_pack, written_list, nr_written);
diff --git a/midx-write.c b/midx-write.c
index a77ee73c68..62f507eb72 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -825,7 +825,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer, the_repository);
+	bitmap_writer_init(&writer, the_repository, pdata);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, pdata, index,
 				       pdata->nr_objects);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index bf96c80898..4a7d2d1370 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -41,13 +41,15 @@ static inline int bitmap_writer_nr_selected_commits(struct bitmap_writer *writer
 	return writer->selected_nr - writer->pseudo_merges_nr;
 }
 
-void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
+void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
+			struct packing_data *pdata)
 {
 	memset(writer, 0, sizeof(struct bitmap_writer));
 	if (writer->bitmaps)
 		BUG("bitmap writer already initialized");
 	writer->bitmaps = kh_init_oid_map();
 	writer->pseudo_merge_commits = kh_init_oid_map();
+	writer->to_pack = pdata;
 
 	string_list_init_dup(&writer->pseudo_merge_groups);
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1171e6d989..ab20d6a0b6 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -123,7 +123,8 @@ struct bitmap_writer {
 	unsigned char pack_checksum[GIT_MAX_RAWSZ];
 };
 
-void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r);
+void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r,
+			struct packing_data *pdata);
 void bitmap_writer_show_progress(struct bitmap_writer *writer, int show);
 void bitmap_writer_set_checksum(struct bitmap_writer *writer,
 				const unsigned char *sha1);
-- 
2.46.0.54.gc9a64b1d2a

