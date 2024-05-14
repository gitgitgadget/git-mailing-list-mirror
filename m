Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC8182C8F
	for <git@vger.kernel.org>; Tue, 14 May 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716624; cv=none; b=FgwVxW1+raLb0j3FCdW8yhyXHMcwLq/PNeMDF2OjzLHEK3yUfAXZLyp94UUbCpS5I8TwQBYIpwNVQgSE91GqmuCksN1V3xdb9sGkg1BMMKdSTom9pZi97hh/17UDvb0AYe8EJjlPX8r9f6y8fzbtxSJ50ftl23YEgBvFj4ezq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716624; c=relaxed/simple;
	bh=YNa2k3iqRN4nGVtedkaIMsojc0JqtDEh1dZf6YF94Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qONQ3GW9IknaC6tLUm4ddjmESADbGuQ9p4HHI31YYa2LHVlSQjxqIarklXRxz4B8y4jNP1U5r8mkJbmPhcqsOAzgqKVp/ZY2T5W3UVEFyWb7duap/V7CiO5JbCd5paKxcSgYHCrdpvdfQ1n0+WRdLONZEIo3GkQ5lG9uNvDGu8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LwnlLetn; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LwnlLetn"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f043eaee9so402922285a.3
        for <git@vger.kernel.org>; Tue, 14 May 2024 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715716622; x=1716321422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs46K1THFTAvWTI4osLAXGh4TVt6cHIlmU1oU5tOwcA=;
        b=LwnlLetnUCoc/xsQuNbrBekvFc6PTc+DWnpPLHDjfyIVL8JJS3WJGCkAA28q/cs+ND
         eZdpE8sxNyXU8rhJiE2B3RgaWvn6APpbG9sgczSwpQACn1FFq3aec5/msRRc4yoZ8mzZ
         2iRfJnqkmT92BpPGKCzskLgn246XPKRPQVo5tKlKrkQXrOQG4YI/jLqztVU/U7VyTf6I
         yhwCrDH7/dOYrkBURea8kYIovqrrEAuMx2d+LJr1BUUAfax/xWtwDzJmMc3U9llIkoDz
         P5UFFeusE8SsUav0pxGlOIMMCLWcqmzATvJzrt3xrI6d87Asbn6rS78Obt6uWgq4THmh
         aMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716622; x=1716321422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zs46K1THFTAvWTI4osLAXGh4TVt6cHIlmU1oU5tOwcA=;
        b=tvWvBajdw/sOYoWKUkn+s7OAX9ucTcRXM++jSBQQ1lRRaUWhvxb4fCntOPWd2g6Kcw
         XFdT0TaeiQ/rT+U0xHWEzB1yfMa8cWNlvZEINzMlmIj6FlrKaHfCXLF0sf4f1ZMQI3PM
         smAlUp9si/YyiuwCvSgMR9UPsmXG0CFsrGatcLY26nRYPcVQ30euj8pMl01tefGyZ4OH
         U2FIsAwVUx+hCyOyHczMc8loS+8+L4WBg7dt/2sC1vP8ydoFnnBHzqvo2ADooflJu2PQ
         eJTil9fjp30p1qQHOJVQ/2nNy6GKW9R5QMq3nOyMLjSWRKUWAMLvuonkqqILZimAn6lg
         K8lA==
X-Gm-Message-State: AOJu0YwJM3BxeNJdnOYLGhvgYKBn18Ds5a/zU0hgJN/01YsXhwDxmyoy
	xG08K4oWurcb2cifbHzSJ9w03GqAvPnlGy9HmIdtiNJbu4Qo357r0rnbG183SUB0XK9DtI96QDf
	P
X-Google-Smtp-Source: AGHT+IEVvvUT80kIBK4E83i62I5BA7wcuRfpkN3pD2cpKtgk+trUtaWALVwEkgMujdeboWG4+VtDXw==
X-Received: by 2002:a05:620a:a45:b0:790:e65f:915f with SMTP id af79cd13be357-792c75ac087mr1521922285a.41.1715716621931;
        Tue, 14 May 2024 12:57:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792d7866176sm335369885a.123.2024.05.14.12.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 12:57:01 -0700 (PDT)
Date: Tue, 14 May 2024 15:57:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] pack-bitmap: drop unused `max_bitmaps` parameter
Message-ID: <b38dd5464d5423783ef6bb7863977d3051d5eab2.1715716605.git.me@ttaylorr.com>
References: <cover.1715716605.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1715716605.git.me@ttaylorr.com>

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
 builtin/pack-objects.c | 3 +--
 midx-write.c           | 2 +-
 pack-bitmap-write.c    | 8 +-------
 pack-bitmap.h          | 3 +--
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ba4c93d241..10e69fdc8e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1364,8 +1364,7 @@ static void write_pack_file(void)
 							    progress);
 				bitmap_writer_select_commits(&bitmap_writer,
 							     indexed_commits,
-							     indexed_commits_nr,
-							     -1);
+							     indexed_commits_nr);
 				if (bitmap_writer_build(&bitmap_writer, &to_pack) < 0)
 					die(_("failed to write bitmap index"));
 				bitmap_writer_finish(&bitmap_writer,
diff --git a/midx-write.c b/midx-write.c
index 5fdc8f2ff5..78fb0a2c8c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -841,7 +841,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[pack_order[i]] = &pdata->objects[i].idx;
 
-	bitmap_writer_select_commits(&writer, commits, commits_nr, -1);
+	bitmap_writer_select_commits(&writer, commits, commits_nr);
 	ret = bitmap_writer_build(&writer, pdata);
 	if (ret < 0)
 		goto cleanup;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e22fa70745..c0087dab12 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -587,8 +587,7 @@ static int date_compare(const void *_a, const void *_b)
 
 void bitmap_writer_select_commits(struct bitmap_writer *writer,
 				  struct commit **indexed_commits,
-				  unsigned int indexed_commits_nr,
-				  int max_bitmaps)
+				  unsigned int indexed_commits_nr)
 {
 	unsigned int i = 0, j, next;
 
@@ -611,11 +610,6 @@ void bitmap_writer_select_commits(struct bitmap_writer *writer,
 		if (i + next >= indexed_commits_nr)
 			break;
 
-		if (max_bitmaps > 0 && writer->selected_nr >= max_bitmaps) {
-			writer->selected_nr = max_bitmaps;
-			break;
-		}
-
 		if (next == 0) {
 			chosen = indexed_commits[i];
 		} else {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 5a1890a2c5..b2d13d40eb 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -131,8 +131,7 @@ struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
 void bitmap_writer_select_commits(struct bitmap_writer *writer,
 				  struct commit **indexed_commits,
-				  unsigned int indexed_commits_nr,
-				  int max_bitmaps);
+				  unsigned int indexed_commits_nr);
 int bitmap_writer_build(struct bitmap_writer *writer,
 			struct packing_data *to_pack);
 void bitmap_writer_finish(struct bitmap_writer *writer,
-- 
2.45.1.151.g7cc3499008c

