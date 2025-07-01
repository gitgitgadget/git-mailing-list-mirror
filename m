Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D41B0414
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751347935; cv=none; b=BDRGd5mTaxTy6etsFy1EdXJ9+9Ws/FOVA+vukk5WOlewZirVtfVW33hrOawsxtkCpVsMXud++/OT8Z0SnaEcLTLXVN48MynkXRgfrcitqjsW5B1a6vtK+iUpeB8l/d60BiQANxn9hZcKpB4nWZ8Zewu5WumzAN848CfXJR5mRSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751347935; c=relaxed/simple;
	bh=n1otn0Cqiw3aGOPdCc79Es3oHvH8cEs4kqhSIkGIClU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qZM9XVCt2v+mTsE2vLbyIVZLhPfZy1H7EQz02yWF8HyBodcmkf7hyRDG/6uShfJ1GFnga5ZDxclM+GSC6VUvpabvVnwuMYcg+lVEnZBe7hDntii2Su0KniS9u6MfDqc3NB4Ap9mhPVaDPymeays0XJryCUR3mfJ/u889ZTczawk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpZaOV1r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpZaOV1r"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45310223677so20033365e9.0
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 22:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751347932; x=1751952732; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jtSb9rfAZqyZ28+QYahyTgWOD9DQ4rf0nljreMSil4=;
        b=mpZaOV1rtxeRy0D6tR1T9fyWXbvCUExA68NFe2z2tbF4sL0293ELtRu3iVsl/4zRxh
         6COS52HywN9wDrK/l5ToLrHnYery0m+QS8CXfJD5YaJ+mpJyWpcamw3oASw6DOZan2+4
         0TrlOZ8LUVIDqKbip59wXro0c7BIqtiJFfnHStcxrfhwjXKg53UTELHPqANFvXKUUwFZ
         ni+whz7loQhaTBXiqU1ZFSzUWfSgVWSd1qZ+b7nUWvJaPjs+sOzFL5cK1RJ0KCLyctp+
         URm199a6iTTajp0tPD1n7y4xpf4V9/QPj9PPdYcInIJuu8cjyN32g4Y9eC9etGjY5x2u
         9ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751347932; x=1751952732;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jtSb9rfAZqyZ28+QYahyTgWOD9DQ4rf0nljreMSil4=;
        b=st2trhLWqDJTVl7LsZUzYMxs8NWH3phFiK+osDdbFJvBruoZhsXxth6e0PV8GT4y21
         BemsAWPB12r9ekokveR2EVaXhhpgdCZ95r7MiPYV4wvnLyDg4fod8SbjW7K511Jno5x8
         8/L8dBG0HaxwF+SbKknkTQ5FT1ogr5i9MJbVw4/HR4yMIu7uUhgMHW9daC+ZzOuxzMhl
         3oWm17GqmndSRHsVL6fG39FY2NWdK2rGFQgBpy95RdlOmU6KIUiaHlu8FLJ21zMVRDNY
         ALEmyUf2tBnZowpvTjF8HhUrs8HYq861d73NwpwTLkbWhGiEn6p+gbHSNBazOiEglIPt
         aJ+g==
X-Gm-Message-State: AOJu0YyJ052V9X6l+QFYjEsSQua4NjRo57nejmx3cpB8iczMpVnsGIlq
	12TEaED4JnrpOUFAt+j6oqhu8UbscWRNxexS8yFo/pk2RSrx8rQnoL0rigug9Q==
X-Gm-Gg: ASbGncti+pfBvFRpWLjPC6Tt9f+LGNyTbA1LyWsFtEEMXpOLrpdeGhslIG8MUlQfnPx
	rAY6prgKSMSw9Nc1kKOvOZQEiiUnjTpAprqKNv73g8Oy446OLBjCASBXZpZVGomCMiknRRBVrJh
	yzWBtw7mh5BRjaMl3EZAD6ih+Ehc6mjnZQ//M20GlO+b6+A6qm3X19s3H1ClP+ZCGdczSRib9EE
	h7Ze0Bl1QfGNLQrMQYRWdYcHICAQ+PZPB3nud6OwSJP52/LTRMsLjXpnnhsovAmSTY8hl9iTHR3
	HPhJalFzYWot83Ng4Xj2qgD4lOoLWnXW4yNir1Rh/1ssowlXVn4Yh82hWkYAhAc=
X-Google-Smtp-Source: AGHT+IHKHO3JHaaVcZb04SOFDra83GSTCxSXbQJxFywukzeLbSbVxRJyuvNgJSZKU/cWJKd2XcxOLw==
X-Received: by 2002:a05:600c:4fd6:b0:43c:f63c:babb with SMTP id 5b1f17b1804b1-4538ee4f9c5mr141069515e9.1.1751347931302;
        Mon, 30 Jun 2025 22:32:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4213f0sm154925825e9.36.2025.06.30.22.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 22:32:10 -0700 (PDT)
Message-Id: <3d70e14e415f7f13864d4d3d2d5d4395f6e14bb3.1751347929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
	<pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Jul 2025 05:32:07 +0000
Subject: [PATCH v6 1/3] pack-bitmap: fix memory leak if load_bitmap() failed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

After going through the "failed" label, load_bitmap() will return -1,
and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
will then call free_bitmap_index().

That function would have done:

    struct stored_bitmap *sb;
    kh_foreach_value(b->bitmaps, sb {
      ewah_pool_free(sb->root);
      free(sb);
    });

, but won't since load_bitmap() already called kh_destroy_oid_map() and
NULL'd the "bitmaps" pointer from within its "failed" label. Thus if you
got part of the way through loading bitmap entries and then failed, you
would leak all of the previous entries that you were able to load
successfully.

The solution is to remove the error handling code in load_bitmap(), because
its caller will always call free_bitmap_index() in case of an error.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 pack-bitmap.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 8727f316de92..38588b4aec01 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -630,41 +630,28 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	bitmap_git->ext_index.positions = kh_init_oid_pos();
 
 	if (load_reverse_index(r, bitmap_git))
-		goto failed;
+		return -1;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->blobs = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->tags = read_bitmap_1(bitmap_git)))
-		goto failed;
+		return -1;
 
 	if (!bitmap_git->table_lookup && load_bitmap_entries_v1(bitmap_git) < 0)
-		goto failed;
+		return -1;
 
 	if (bitmap_git->base) {
 		if (!bitmap_is_midx(bitmap_git))
 			BUG("non-MIDX bitmap has non-NULL base bitmap index");
 		if (load_bitmap(r, bitmap_git->base, 1) < 0)
-			goto failed;
+			return -1;
 	}
 
 	if (!recursing)
 		load_all_type_bitmaps(bitmap_git);
 
 	return 0;
-
-failed:
-	munmap(bitmap_git->map, bitmap_git->map_size);
-	bitmap_git->map = NULL;
-	bitmap_git->map_size = 0;
-
-	kh_destroy_oid_map(bitmap_git->bitmaps);
-	bitmap_git->bitmaps = NULL;
-
-	kh_destroy_oid_pos(bitmap_git->ext_index.positions);
-	bitmap_git->ext_index.positions = NULL;
-
-	return -1;
 }
 
 static int open_pack_bitmap(struct repository *r,
-- 
gitgitgadget

