Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3113B27EE
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911757; cv=none; b=FkhY/iD5TSYtdtMMm3m6pYOO7Awwj59ywTfrTd5JpKO80VDWzE2d/TWderTEpIO2WPrUdVOAGictit3oopRqNkTZQkZ2Xe7AoJVE34bZvSENwSinO+DTbNbTmE1JHt7PUJsXKhk7CTJHnuPdWt0GG6RysjZ6Yu77+ZOdrSSAtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911757; c=relaxed/simple;
	bh=oED77I3SEzk5J1VRHceSJzuuYBU85z9uz6zU7RxubWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCeqwkCOgRj+DesCr+5FGhy7uBb/kOQygVIYkkzkPWuBfKuYYdcsXfvzGwjKV39+aSppxe6o4v/2tv2BxzFUjMHLbqp/sXZE18eXeej09NEPm6TUz8OX5PiIAG5Fhc6Zum5IaKivtwtYWqwIEhqrFtplcMI+FyVwdJ7XkJkWNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IKanr3xF; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IKanr3xF"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c23248f3a3so127356787b3.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911754; x=1780516554; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a6GP5yx8tHuovJJW0RK5VucGtGx+EILFy0M6mwPs764=;
        b=IKanr3xFxVmNFoWi8NSvIjcQVn9Xpj5CFiAOEYfjQpxi5comVZ6OJjP7SgqKtBItez
         +5dTq4G4LpO6tcma1nLXokR3qFOlDKBkmsmAE5TdvYRmlH/YzMZola6wmpC2T5O9Jjki
         7O4y/NCVRMrFxgIyQoD3dIHzdBKMykqEnsFsMKRWxZPDSTCSFIRDEh7ZwT5eMmLCVXIY
         TumSCx0mVUhBnynHW9IgxS1W57PRRWAqXEg9lJojiPw58jZGZ0+NIrGRQkRhVNnjZbMF
         bxf88Hdk41xp32ItcNYXs+1OZtc6jfYrTCDtl8nVVFSbP4Plnifo0AYQatrSfT8LGsGJ
         NVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911754; x=1780516554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6GP5yx8tHuovJJW0RK5VucGtGx+EILFy0M6mwPs764=;
        b=abhexLGbyKOJ4K6MK2kDPH4JAcjyT38t1LAhbdv2alRLOnIrwyh0y7HWpFc9/1WBOS
         h8HPIv3cF5FY+32lOO2Rvi7h6xzECVR5lpPAq+Mvs49gYehgGavik063vn0qG5fM8R4c
         M1lTuGZ2JHoSb27rKLsVyrmqsYQNvMvw2VCeUxfJI/bX91cqTLgoGgHnPtTksw1JdfAE
         Pecm0/UWllN0gxsoxcRpod5JGtpHtyqsR/Ylb7Y3HWPeFIEnIlVtRDmeUqZy6rIQROup
         6M31WgFyq5c63yDMo42Y6TjNku5SCr1hZg+guL2dowsUaImKExylNYrXGGXmUB/xlnAf
         W7YA==
X-Gm-Message-State: AOJu0Yy/C1lWtMf0rKJBzWhmmlcN5zN3RJYIfwMeAYTsbmItwVoUgJ7h
	vYe/shiILJA55eP+SteEcDwPaay4l/BfSxNCQ7HLfHfQ2G0EzwE/3hnLfGB2WB/M4LhC0ZSNhhI
	SAHs9tcM=
X-Gm-Gg: Acq92OFFpzOzvP6aXUmED+S/mMn9ObhNUjKzIEXHTkzr5F96s3zvWD+z/yr2aXlagyz
	tMr8RHMhdkwlYI0W7/QiECE3loIkUZddVTf21HvV5871PUiSgL1DgDxW9CwcAJoEsM2rIi+v6EI
	MuDm+4CJZpvNHfRMZRwW2tKbWNvyUGre5gcxc3FW+f4pZfy6ewHzTAsCALk13BK87xGeUDJyVu8
	MTLvPWSs/skW1tNYdYXAYmqr++ZvG9p8FwYEQLCd26hObJ8CU+d8JdcyoIH537h5ZuFPntc4d9h
	C9+VH9GafQECWr9HS6zEicD8ARXbx+DLSgL+AhjOJ/1Ir36cAnHh3e71spH5KVuvi4YXBzmAy7B
	it5jmYKWeXaNtpQRbTKjqoVeZp+LkB/dUapXukZff1LeFQ6xjJBLc1k3MkaxiyaD3XuuRagWn+r
	hAyRqd5cD/Tfvn72hprZyC/VF989YewbeP5SSVEkXfixcpDP3fQuxbvhDEGcgmp8CeZG5/Ca0X8
	lNQ9tGblhe9EOq1m+OlO/64GGN1VhAK1LaPoopE6x7DUh0t+lh9brsuRgfF+RqLH8wfZpLIBUA9
	wD24kj0zA5lXUio0q3F5mN5+c/E=
X-Received: by 2002:a05:690c:660c:b0:7d1:dd7b:b71f with SMTP id 00721157ae682-7d3379ab714mr265030447b3.29.1779911754553;
        Wed, 27 May 2026 12:55:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c43645csm80900317b3.41.2026.05.27.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:55:54 -0700 (PDT)
Date: Wed, 27 May 2026 15:55:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 2/8] pack-bitmap: check subtree bits before recursing
Message-ID: <59da63d0330de760a4c144d210e70c44e1e142c0.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

In the previous commit, we adjusted the callers of `fill_bitmap_tree()`
to pass in the bit position of the tree they wish to fill.

This commit makes use of that information at the call site to avoid
setting up a stack frame for fill_bitmap_tree() entirely whenever a
tree's bit position is already set.

Since this is such a hot path, the avoided cost of setting up and
tearing down stack frames for each noop'd call to `fill_bitmap_tree()`
is significant:

    +--------------+-------------+-------------+-------------------+
    |              | HEAD^       | HEAD        | Delta             |
    +--------------+-------------+-------------+-------------------+
    | elapsed      |   582.4 s   |   562.8 s   |  -19.6 s  (-3.4%) |
    | cycles       | 2,713.3 B   | 2,621.3 B   |  -92.0 B  (-3.4%) |
    | instructions | 2,415.5 B   | 2,348.9 B   |  -66.6 B  (-2.8%) |
    | CPI          |     1.123   |     1.116   |  -0.007   (-0.7%) |
    +--------------+-------------+-------------+-------------------+

In the same repository as in the previous commit, our timings dropped
from ~582.4 seconds down to ~562.77 seconds.

While the cycles-per-instruction ratio is basically unchanged, we
execute significantly fewer instructions, and correspondingly fewer
cycles.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 2d5ff8fd406..72610397020 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -463,12 +463,6 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 	struct tree_desc desc;
 	struct name_entry entry;
 
-	/*
-	 * If our bit is already set, then there is nothing to do. Both this
-	 * tree and all of its children will be set.
-	 */
-	if (bitmap_get(bitmap, pos))
-		return 0;
 	bitmap_set(bitmap, pos);
 
 	if (repo_parse_tree(writer->repo, tree) < 0)
@@ -482,6 +476,15 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 			pos = find_object_pos(writer, &entry.oid, &found);
 			if (!found)
 				return -1;
+			if (bitmap_get(bitmap, pos)) {
+				/*
+				 * If our bit is already set, then there
+				 * is nothing to do. Both this tree and
+				 * all of its children will be set.
+				 */
+				break;
+			}
+
 			if (fill_bitmap_tree(writer, bitmap,
 					     lookup_tree(writer->repo,
 							 &entry.oid), pos) < 0)
@@ -582,6 +585,14 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 		pos = find_object_pos(writer, &t->object.oid, &found);
 		if (!found)
 			return -1;
+		if (bitmap_get(ent->bitmap, pos)) {
+			/*
+			 * If our bit is already set, then there is
+			 * nothing to do. Both this tree and all of its
+			 * children will be set.
+			 */
+			continue;
+		}
 
 		if (fill_bitmap_tree(writer, ent->bitmap, t, pos) < 0)
 			return -1;
-- 
2.54.0.rc1.84.g1cf18622df7

