Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4F2222C4
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474432; cv=none; b=BedfDx6C/2yJ9ge0bRTmPkObnPzEggEg2XHzfO9rqGflR+HXDWMjQZB+bnH8Bva/LxP62JUHf+eD9tccSzRdoe5kxYWWZbjh5pceVtCeMnoNI2XK89bfgfv1eAT9sVaOZhHr+c4iOMzCS1phWOPIBOmLkTnqSclIQLTwPm5u4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474432; c=relaxed/simple;
	bh=AI4QH8RFW+ZlVmiK+I8YV8wIus2iWQcrbyep+Or0eSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhofCcUi25wWDcV2rgzX34PVbJhJ7w/bguMqqkbwkm31kUjta4yE7AlpbHKgfb693YjX1zy1qTg6kRhzY34xXmWU2mnKikOS43frT8nLxHPFLi3jLw7/Uf7lgFgw5EeePNdXCNAX3ao6vGOi8O/fQ9XqZsVV0f+lX76Ozpj59vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TyyDAYQH; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TyyDAYQH"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e75668006b9so304454276.3
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474430; x=1749079230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsZxlS5OAJs61vrf+0kXsxTnfNMTmcrNpBa/fvve8ws=;
        b=TyyDAYQHXTTl3S7/R5ld5IBcBEn5jbCr3P01fjdicX0vZELn8TEqq4ToEHOQrGmQ7S
         z2VzKop9dBCNApAW486ViOM+SQ/zbSJuVC/I9+PHHMt053CMbQWWWFev/RbTnp1HEXud
         RcmffIr3+12+aHTCELFnylAfuYhabF1pDPzWvGSoZ5eRI4wyQt2Lje/7BMnJVwUw3ZdO
         A+NIk1MycHyuPjAAa7ZPF5qbDX38Ah+2Lp7OHoekjbrJIz65UuppvXgnWYmyHxqxnuA4
         Zn3hLFdcX9zINE8dAKd437E0cj25wqes55j2FHafz1T5zIj4yImJZdvRsBg5lzva1ffa
         Cbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474430; x=1749079230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsZxlS5OAJs61vrf+0kXsxTnfNMTmcrNpBa/fvve8ws=;
        b=r1M/TL/7v80Fsf1ILjzaRsjUJHJ6GqXXT5AN4MakdvSTzqA0Hc/bXhKNEUKfurdoUs
         p/v/rBlwcj9hD3vb9TK9OKRLrVIIVRq+QCWLvzuSUEdJLbYIUWcmAAXFzhf88lDqE4eL
         wMGrBF5v88eyXBY6T9kXc++qL9v5xrDn4seWdXX+FdtGRjCed0d+kZEt5sB+8ooW/Pck
         bezHuu1aeAklinITUts7GxqFqcOgLZFA9iE17YaSHHBrSJkgjHPIKwJzRAJsxgiV9b8J
         qWOIVxwgT54YazugB+SoSTCDkHrzoMRgp3HqbjilrBxUxaGqrzYhbBBJ+BLOOFOZgpUv
         MJvQ==
X-Gm-Message-State: AOJu0Yyh3BIv/4trnlcyWv5AWUQHS1TTziHac++F1N4iK6cBXKytrFaU
	7BUYonNPXcZ1uvRuVrh7oPtffCzAshMAexJT46FCmJqfPfAwW0YiNT9QyefoIKGEuoM3xXwzBSd
	PiCl4
X-Gm-Gg: ASbGnctHMd9zAM+MTljRelhQruFnppYpH0hVlWtwqaJBQAtJVN+Msoi5IBDv2Utw0tN
	EMMxmERyDAQmgvd5wdl5xRB3cU47zfBzkAOjiUq7f9yPFVyZePWxS+TH9rnh4nGx+ccmZV0ZWcs
	emudXxn5+KatyK+/aiwkdOgs4UqQX4TSCqYhf7Xc0tYRhOC8ubDk8QQHKZ313AUS3QOxJG1HvB4
	nvcZ+tGINOtvrRLi4+w5Jr7rGgTHGNFNdhAEvhSKaBNehPJUe1A+6r1D02JXPM4aD4ERYlhk5lB
	6MLb9jpK2rWjKcVUVwjFHxAOQHOlqFRjsoqchdMbTdbWmigoQWfdgXGNJvkOh5rjALJ8KxpycoQ
	fbCwRAoYmfe6E9n0cGeSaHNU=
X-Google-Smtp-Source: AGHT+IHlvU9oHCaRbuWkV4OS/j+Aw/BEl6EDoGcU01z2khHDZVElQZ4dsUMJPuGf8HQB+1YdoQe15g==
X-Received: by 2002:a05:6902:20c7:b0:e7d:d151:e556 with SMTP id 3f1490d57ef6-e7dd151e722mr8347231276.32.1748474429913;
        Wed, 28 May 2025 16:20:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f735243d6sm28449276.56.2025.05.28.16.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:29 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 7/9] pack-objects: swap 'show_{object,commit}_pack_hint'
Message-ID: <1cc45b44721c7981514cb45203f752729865cb23.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

show_commit_pack_hint() has heretofore been a noop, so its position
within its compilation unit only needs to appear before its first use.

But the following commit will sometimes have `show_commit_pack_hint()`
call `show_object_pack_hint()`, so reorder the former to appear after
the latter to minimize the code movement in that patch.

Suggested-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a68451c3d2..d3dfe983c3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3513,12 +3513,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 	return 0;
 }
 
-static void show_commit_pack_hint(struct commit *commit UNUSED,
-				  void *data UNUSED)
-{
-	/* nothing to do; commits don't have a namehash */
-}
-
 static void show_object_pack_hint(struct object *object, const char *name,
 				  void *data UNUSED)
 {
@@ -3541,6 +3535,12 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	stdin_packs_hints_nr++;
 }
 
+static void show_commit_pack_hint(struct commit *commit UNUSED,
+				  void *data UNUSED)
+{
+	/* nothing to do; commits don't have a namehash */
+}
+
 static int pack_mtime_cmp(const void *_a, const void *_b)
 {
 	struct packed_git *a = ((const struct string_list_item*)_a)->util;
-- 
2.49.0.640.ga4de40e6a8

