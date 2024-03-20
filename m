Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891868614B
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972333; cv=none; b=gGJLwMkmLRS84vH6JeqK70ZNsoM5gqBvtw7vDxW1CqNcrRd7sdaHw7O4LJDeWhfMKy//BZp9Kwyetfn3nx4PPyi6npvwlhE6hXZqxYI7J5zDm7yFTxiYyOwUNVTdtxJU55omivZ1Mradfu2I/m6G3g0+v/wmDwx5y0yl/ndyrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972333; c=relaxed/simple;
	bh=9DAyVKjbBrrbmKFf1swBCqyVJcLKHdP/wqVyJfoN/rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX4mn+/M5V8YYePoJx520WGkKaF2hFQMcZupOXkr+M+V94/vjII5tCNDX/dEZZfDo/ihQM45uFSesT4l1rdgnHNV5tMrVfitQYhhnYNiKbbXRWJY9eDl4k2ixan5+9SYUrWzHQuWlLCSzVG+7sb+dKC10RFDLkQduNlmiTBMYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fKx9U1f3; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fKx9U1f3"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e67cf739d0so154457a34.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972327; x=1711577127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5vrcfYevncrhJq+1MH28mXP7kdJyD4hn+TuiGuKeq8=;
        b=fKx9U1f3VLKMtgrNao3flambDVoXB2VSOuP+v6yKlHSXzNKqN+ue9V4XSodvx3tx1C
         /uRkVD2kvK0GaomsnAqx0lKMaK3Z2KSZgmpm0S5GQyx5fLSoxPJI54lUy0u8sYadg3uE
         DDblHQdTuqALjrKO0RuHTrDhumDdvjOtiNnhCwaw6NUlpMkXO48J/dU2YU7AtXqSWO+v
         s2up3HvZug2g5dXl8QmYURILpeDbN4LdGA6KHrvOC7PHW+uyTAA6wu4LMXyALJUjbDQd
         DPIULFKDY3NgyGDLy4HVGYinjdB8VL81Xrai7pZ143zlCpkrvbJXXAbr+RBEkGj9SYYX
         LfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972327; x=1711577127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5vrcfYevncrhJq+1MH28mXP7kdJyD4hn+TuiGuKeq8=;
        b=hoNmAN8OuZcb7cVQfQPWiHWoxS8s/1ipSaVyrbLKiqknHgyoGHRXkA04xBzgLWGrpC
         Z0OCw77VsPJQfXbRCfX2jiv8FhLlDUtP2TvNgMw6lJDcMB9h8vSQT7lOUiczcz4Z4DBg
         e5JLQv83T8TGuqtJ9NEwJJonyyAjmhkY4kzEUsl9gSVvX5+KWgLs306f61SagHEzsI0I
         c2zm+51k+LaL7VqLu9IUccKGpob+hFHI3YpDCGelu8XNMwuaYjM3rKRmkiEPs9nekFwJ
         xbOjUiaeVp9zOltvruKMIJwCewGiQqNSdkeyNicAM91dKiLfl5lr0/mH2p7I+v8TGUX9
         tjhg==
X-Gm-Message-State: AOJu0YyXqX+t6Jps8CjqDJbB/8vDxjkb/j9Lg5EOU5s+piL+81dqk16Q
	fmbmC1fiBRjeOu57fRGs0j/c5tuZiAdQ2MdW3Ibl3hc/Q00+YKAUl46ccAtBMWQcq6HTRTx5QRo
	e2aA=
X-Google-Smtp-Source: AGHT+IHmJryUk4YFrIQxC16Gf03S0+FXi4CAidbZ7r6KNftsx7lTXj06g1C6JuZcUzlQUdkwx6TShA==
X-Received: by 2002:a9d:638b:0:b0:6e6:b01d:846 with SMTP id w11-20020a9d638b000000b006e6b01d0846mr335462otk.5.1710972327515;
        Wed, 20 Mar 2024 15:05:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a09db00b00789f0d9e6dcsm4387103qky.93.2024.03.20.15.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:27 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/24] pack-bitmap: make
 `bitmap_writer_push_bitmapped_commit()` public
Message-ID: <d74cf3e484d4c2bb8267717df1eb998108278510.1710972293.git.me@ttaylorr.com>
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

The pseudo-merge selection code will be added in a subsequent commit,
and will need a way to push the allocated commit structures into the
bitmap writer from a separate compilation unit.

Make the `bitmap_writer_push_bitmapped_commit()` function part of the
pack-bitmap.h header in order to make this possible.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 4 ++--
 pack-bitmap.h       | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cd528f89a76..e46978d494c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -132,8 +132,8 @@ int bitmap_writer_has_bitmapped_object_id(const struct object_id *oid)
  * Compute the actual bitmaps
  */
 
-static void bitmap_writer_push_bitmapped_commit(struct commit *commit,
-						unsigned pseudo_merge)
+void bitmap_writer_push_bitmapped_commit(struct commit *commit,
+					 unsigned pseudo_merge)
 {
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 995d664cc89..0f539d79cfd 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -99,6 +99,8 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
 int bitmap_writer_has_bitmapped_object_id(const struct object_id *oid);
+void bitmap_writer_push_bitmapped_commit(struct commit *commit,
+					 unsigned pseudo_merge);
 
 void bitmap_writer_init(struct repository *r);
 void bitmap_writer_show_progress(int show);
-- 
2.44.0.303.g1dc5e5b124c

