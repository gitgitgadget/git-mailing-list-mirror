Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C31411EF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423389; cv=none; b=t/DSuTuG7gyxbPqtKLjYblqTp5ER/s8Dj2P+xLn7Vdqyqg21bU27ugBte4zNn0f1CfyDHrpgN2Tp/vpzAtLn6uoBLYd24ykTBjX9AAAFjA06IKU3ua2cy4sYB1jG3Qje70JPD9KZZy19NV3hEE9IgZa8BW80SPu0S6TqqjpDx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423389; c=relaxed/simple;
	bh=iKnexeLn1VB6/XrI3uiwbpAxYwgIfxhwsCkSb7jo5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/QQggU+3Pd5LaB2hdp0aRcNJZ8KWQ4TGQF218GvftyV7tm/yJn4pk3w1nCiKcd45D3BsFkRImr2RMxvYMfTaY/Hfoeec2Pj9Dg5sNJH9mNLftGOKIrj+z3uLvx0TfD4ftJGxL1R/c6RSPlj4SrGVJndNxkXdHULpiFQOleYq2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NCy803Cx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NCy803Cx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69b4e94ecd2so24187786d6.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423387; x=1715028187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JjtxHcAnI7ucNOXIsqOnaxMAIC5xY892HGXD+sKEcHw=;
        b=NCy803CxIx6WqnNscLASwVSj4z1lZNqUd1wK2Reo0bZ/TgyVNZO8hgyxCuJzflqr8M
         wnghyuFhZRt0GIUKkM8l9wiGaSsuiyECuL3JQqUw9TA1Uuwzr1ytelLL6yF1kLP2KNeG
         eH1X7Gtj7Xe/2HrvkOULX/Tld7S7F3yfBOMKcatrvQZqTQ/ObonHnSYSqHQas08owo61
         h0rVFnZWEElFjtEziUm/Xr4Lh5/UKgk47M70+S2Jf2z38/2F0aljuBQ/YjoyabidhaRS
         t4T9ZEEpPImjEZbX4R30iEoMevdQTEvym2nCMBfSGfRBl5u6PyHzYi7Q8MbMTRjsiJUB
         vxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423387; x=1715028187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjtxHcAnI7ucNOXIsqOnaxMAIC5xY892HGXD+sKEcHw=;
        b=VkYm4Dlir+E1+A0qcGv0wBw3WW/XKUTI6xrHUG11y5yduS5yP6XwtgYrzf0rkrT2AT
         YkDlsghkzHQQeEHp1FiASRC+qkd8yMZmzV14HTBJTlsrVFTwmpabEj8V7nJCZcI/NX2I
         qDIN7480wmcfh6RXKKewnznhZJAejmQUlLV4/f7vzH5918Wjolspqh1JOnectWYdVp0w
         imkKWfGcQMhKMvT+1liVLADnsIgmCO7bg2PEelvgilkEIstkUUWm5P3ODWYW8y/xiZ5X
         SKsdiJhP78h44KL91uJyyNN43NBQ3HOa7CozCigyDrlGqjlIfuFqZoPSHjxQCD7Bu5lI
         +C4Q==
X-Gm-Message-State: AOJu0YzUfJ5BsZf2+o2pkNiQhT+gPTOBqUeLXt8Be1YMliiTOInAqlCY
	IKb5/MD0C3VDhSC19hkDvPO1zW5Vi1XT867CbPDkMNCW8VZwyhwwKYk4pKDFHEnKDukAlz4BTmP
	7ylk=
X-Google-Smtp-Source: AGHT+IEnT8KkgkLEzTdKtBKiUqZKxkTN5O9McW+b0I/fOdSCv4qr6VBiX4sEA68UFCG3NzeTgBxMng==
X-Received: by 2002:a05:6214:29ed:b0:6a0:aac9:c56f with SMTP id jv13-20020a05621429ed00b006a0aac9c56fmr8996204qvb.33.1714423386750;
        Mon, 29 Apr 2024 13:43:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r1-20020ad44041000000b006a0d4d7ec55sm765496qvp.88.2024.04.29.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:06 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/23] pack-bitmap: drop unused `max_bitmaps` parameter
Message-ID: <5160859f7f3cf72de03a4644ee3d3743eaba2bc2.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

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
 midx-write.c           | 2 +-
 pack-bitmap-write.c    | 8 +-------
 pack-bitmap.h          | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index baf0090fc8d..5060ce2dfba 100644
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
diff --git a/midx-write.c b/midx-write.c
index 65e69d2de78..469cceaa583 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -838,7 +838,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[pack_order[i]] = &pdata->objects[i].idx;
 
-	bitmap_writer_select_commits(commits, commits_nr, -1);
+	bitmap_writer_select_commits(commits, commits_nr);
 	ret = bitmap_writer_build(pdata);
 	if (ret < 0)
 		goto cleanup;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c6c8f94cc51..c35bc81d00f 100644
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
2.45.0.23.gc6f94b99219

