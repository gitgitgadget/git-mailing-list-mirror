Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6786244
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972318; cv=none; b=n6I4wnPydZ6QvTYh9dsjI+FcjProaW03C1nRPSPTQJyPdlehN++Nf2DQYJX5ouL/BGwJBgLHqRtCZF5x8EsAmFEJSTeaCgBnWhxR4NLRuzJwb9rbJ6VypQ7YSVKU0YJP9G0ZPmmT1LcX97aQKlbihrymNXf5ZrdHnPqslStME/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972318; c=relaxed/simple;
	bh=VqD129M93bDYzaYEhQFXwnFcUEGRpSklBnn/IfNhEoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+mrz2Hx9QDeRvXjRkIu0yyQKuQnpRtpLVgRJ5JwW6nF8F6oa34zaSutmKU9KUldmpRfAYViUAOJpve3BGZD9+oD8WhAu4vShTj9lNWkGQJaTjtIef6TlMOZW0V6agjrLEwMatORvA8ENi4Q3XGpeKjAmR7ORtKkDF8XMyRrBQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=R47HZNKu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="R47HZNKu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789db18e356so21322385a.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972312; x=1711577112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHX25G1+IyF0ODK0NHnQdkKcrCUyK/ZF2OPNcfqltHE=;
        b=R47HZNKu1/MG7g/7yxKItc4mQ4J2QVAS6mO8ABTIKYaPk7yuHPDO5kRMRQFgAvklQ6
         hUs9QubnnfGJUuu8CvzNtabJIh1QhWPbT03T9pFDf4M6P0UWuDyxzVJxe4FaDnG0NPuI
         0CJnAwm8sjqo5M/skKJhTww8XhdMYVC25xnBpNP6zI+X1lgSg56ewGC4CpfPpUAjh5gj
         NoQY/5swvRBXLDreI3rX9Qsdz5ACBp3ly+5EqGC6JcgH5u2CTClXetkzvcrxhY+yAXjL
         z6pNHOX/uR/TgxNEsCTngknqcSYCMJi43xMiuDYZ36IIDJE+klGS2fR3Cugb4riXbpyS
         GYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972312; x=1711577112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHX25G1+IyF0ODK0NHnQdkKcrCUyK/ZF2OPNcfqltHE=;
        b=U7XVJZOnpVtE7JccKWDQRku7BXPhWGxFWRfDm1SjvO0sO8gn5jjSuErtUIwDGg2Gvb
         cZJXW+qT+FeRLqNr4tw70hCvCTqZyCrBfiZybkHOhtBbY0uhq7NERBykTakBMP4tX7FX
         OI6RoIQ+3T8A508BMsgWXinAE0sLecI15Sm6mE6Y3blvSAQiK0yedMa1yDNIjSy8d/MW
         6+REXCzWjBAnklAAYtadOwPPUf7laLzVDwwfHge44UcA2wpa2iQrZSd7xlT9Ks6CFoid
         1tK1PTX138Cby0Hp+ONUqN/fkY8Xe9u/fIY8fQBHMAhfzAZ/gPWJVhsg39O49k2FqPDx
         8+JA==
X-Gm-Message-State: AOJu0YxR+SeO5Smk967tMK4mUcTsiKgA6kXHUblg3drehfAwdAFScJse
	CXWGJDy37PV93TOq/gzdyK1yed8UR0jT8SYu+rB1F6LuEYW3r3BwNC7s6didW6uqoV1i88LqjFg
	8i4k=
X-Google-Smtp-Source: AGHT+IHVjznHwONJnwlaiCfSTmCifIXcKpFhCbm8bCEY8GfpbfOi0WaTj68TasFfrvwS4hM1rorx4w==
X-Received: by 2002:a05:620a:2f6:b0:789:e9b0:dc50 with SMTP id a22-20020a05620a02f600b00789e9b0dc50mr16534468qko.67.1710972312203;
        Wed, 20 Mar 2024 15:05:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m22-20020ae9e016000000b00789fa326156sm3727556qkk.82.2024.03.20.15.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:12 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/24] pack-bitmap: drop unused `max_bitmaps` parameter
Message-ID: <c6a08dae037351f0a5ba8f1044837c894c471b4f.1710972293.git.me@ttaylorr.com>
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

The `max_bitmaps` parameter in `bitmap_writer_select_commits()` was
introduced back in 7cc8f97108 (pack-objects: implement bitmap writing,
2013-12-21), making it original to the bitmap implementation in Git
itself.

When that patch was merged via 0f9e62e084 (Merge branch
'jk/pack-bitmap', 2014-02-27), its sole caller in builtin/pack-objects.c
passed a value of "-1" for `max_bitmaps`, indicating no limit.

Since then, the only other caller (in midx.c, added via c528e17966
(pack-bitmap: write multi-pack bitmaps, 2021-08-31)) also uses a value
of "-1" for `max_bitmaps`.

Since no callers have needed a finite limit for the `max_bitmaps`
parameter in the nearly decade that has passed since 0f9e62e084, let's
remove the parameter and any dead pieces of code connected to it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 midx.c                 | 2 +-
 pack-bitmap-write.c    | 8 +-------
 pack-bitmap.h          | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 329aeac8043..41281cae91f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1359,7 +1359,7 @@ static void write_pack_file(void)
 				stop_progress(&progress_state);
 
 				bitmap_writer_show_progress(progress);
-				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
+				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr);
 				if (bitmap_writer_build(&to_pack) < 0)
 					die(_("failed to write bitmap index"));
 				bitmap_writer_finish(written_list, nr_written,
diff --git a/midx.c b/midx.c
index 85e1c2cd128..366bfbe18c8 100644
--- a/midx.c
+++ b/midx.c
@@ -1330,7 +1330,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[pack_order[i]] = &pdata->objects[i].idx;
 
-	bitmap_writer_select_commits(commits, commits_nr, -1);
+	bitmap_writer_select_commits(commits, commits_nr);
 	ret = bitmap_writer_build(pdata);
 	if (ret < 0)
 		goto cleanup;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 990a9498d73..3dc2408eca7 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -591,8 +591,7 @@ static int date_compare(const void *_a, const void *_b)
 }
 
 void bitmap_writer_select_commits(struct commit **indexed_commits,
-				  unsigned int indexed_commits_nr,
-				  int max_bitmaps)
+				  unsigned int indexed_commits_nr)
 {
 	unsigned int i = 0, j, next;
 
@@ -615,11 +614,6 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 		if (i + next >= indexed_commits_nr)
 			break;
 
-		if (max_bitmaps > 0 && writer.selected_nr >= max_bitmaps) {
-			writer.selected_nr = max_bitmaps;
-			break;
-		}
-
 		if (next == 0) {
 			chosen = indexed_commits[i];
 		} else {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index c7dea13217a..3f96608d5c1 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -110,7 +110,7 @@ int rebuild_bitmap(const uint32_t *reposition,
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
-		unsigned int indexed_commits_nr, int max_bitmaps);
+				  unsigned int indexed_commits_nr);
 int bitmap_writer_build(struct packing_data *to_pack);
 void bitmap_writer_finish(struct pack_idx_entry **index,
 			  uint32_t index_nr,
-- 
2.44.0.303.g1dc5e5b124c

