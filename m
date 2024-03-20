Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB4186266
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972327; cv=none; b=PNBTBnay2py99D0+km3tRH8dU6U77X/sgaPa7JJeUlr7NK2Neaqesejqr/0PG0WsMiwZp7PmJ02snZJau9JqjeqO4Swzw428yQr03DioyN2gNGyPp72E8bR2Jz2bIf9LM+hdKGTAD6GepEOZ1X+esOIt9i2b8xME4WTbcQPJT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972327; c=relaxed/simple;
	bh=4bA1iwDkOVDSOittigWe/os0ZHe2tPAYHJgJOQ7u1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSU+awKBQ2hdmBPdhK4dg+ViAujY3XLseHm76A+QQIsg7TWTW42yMJr3yVuoqKxgwb3je9yLWOFlpD0c6xda7pI299uT/8lvb9YVuejKyVn4HprvTi8elgFk78WqLHEI6pBxdhzQ2DS5J45qGDeAIFHtvhz9OYJBQ85Gj5Ay4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZLRfPeXz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZLRfPeXz"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6928a5e2479so2425996d6.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972324; x=1711577124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz7ra4JiW6Utg0xo2MU2HtcuHmcU5S3z7XX9Bjv406g=;
        b=ZLRfPeXzv/oiY0LB9erYmU1D7hpGxmPXvYK/oxdj2+SRa8Jt3hY6Pf2YWi5zJI36Ea
         NqSL4u8WYNFpG2Q2EKX52+k8GENMkVkfaAiwoSBhJ29UDxzMN6GP7yeCLCuwE5TXWVKz
         ++/0kf305iDR6KB3oXF8tg75l3JB6fwTmrPyds3j6ywKBJBlPDz7GoL8un5wfa8bouIj
         fHMos45j9hJDUHNplae/vmyZMlAEwYK9aDYcvzEbR/o/U2Wo0Oh3DuUS+6XeWQf1cHJ7
         /bRywWn9FVY6DzA1mb5S27MW0u2Ij4OLijb81Mh3rj0Wf0Q2jxalEJPWv7cKm8tEDlF4
         raMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972324; x=1711577124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz7ra4JiW6Utg0xo2MU2HtcuHmcU5S3z7XX9Bjv406g=;
        b=QZkNUMAjJYJRRSWnh3Cf1uGOsFsoegIrDK5erKuYfTK7kvABYVQiHla0PmiVBHZarC
         qIozFkesFm9NJTcMymfmAPuexwWv2H01QomKtDE7rE2pagnMI+cg4/XoJCBVLqVEKqn9
         CsUop6jNsnKm+MH8MTRx1atyGerY7EDvzsy9VgeYe1lOVbqW3ZDY6iKYFSDRulQd0olf
         363E0miwNUd0F58v6D5YqwVp4e+MzmQIhq/hQBp3fMISOoE/iCZ5gBRjRXLWTiI0xSuo
         8rcYOpuLHw21NXUNTRklDra5DWfAeYSEvapPRh79pRbRjtmYNJph2o6SECuAFDWEBrlH
         TTlQ==
X-Gm-Message-State: AOJu0Yy02Emnm6d2Rw3UgRqHmkH/nGZIjKcd8KoVbQsYqYsdm1LycFHw
	oyBpw6f2QKVoWfwXk5jTHcx4g98l176+viK1/6XjhEePTUOz5CNF77lj0VzwVCoUS1y4ycgKj9z
	G34M=
X-Google-Smtp-Source: AGHT+IGsuAU353HxJri3QAjaXRl6U9lXNAIForRZ467ue5CIunOv60rTspYkk4gkVVkr5mTXNYxx7Q==
X-Received: by 2002:ad4:5bef:0:b0:691:641a:7bb9 with SMTP id k15-20020ad45bef000000b00691641a7bb9mr157065qvc.43.1710972324528;
        Wed, 20 Mar 2024 15:05:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q15-20020a056214194f00b0069183f7fc99sm6482134qvk.144.2024.03.20.15.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:24 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/24] pack-bitmap: implement
 `bitmap_writer_has_bitmapped_object_id()`
Message-ID: <4fdd7dda2744a938f19b76324c76196b033dc2fc.1710972293.git.me@ttaylorr.com>
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

Prepare to implement pseudo-merge bitmap selection by implementing a
necessary new function, `bitmap_writer_has_bitmapped_object_id()`.

This function returns whether or not the bitmap_writer selected the
given object ID for bitmapping. This will allow the pseudo-merge
machinery to reject candidates for pseudo-merges if they have already
been selected as an ordinary bitmap tip.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 5 +++++
 pack-bitmap.h       | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index b1e8a0ad66d..cd528f89a76 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -123,6 +123,11 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
 	}
 }
 
+int bitmap_writer_has_bitmapped_object_id(const struct object_id *oid)
+{
+	return kh_get_oid_map(writer.bitmaps, *oid) != kh_end(writer.bitmaps);
+}
+
 /**
  * Compute the actual bitmaps
  */
diff --git a/pack-bitmap.h b/pack-bitmap.h
index ca9acd2f735..995d664cc89 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -98,6 +98,8 @@ int bitmap_has_oid_in_uninteresting(struct bitmap_index *, const struct object_i
 
 off_t get_disk_usage_from_bitmap(struct bitmap_index *, struct rev_info *);
 
+int bitmap_writer_has_bitmapped_object_id(const struct object_id *oid);
+
 void bitmap_writer_init(struct repository *r);
 void bitmap_writer_show_progress(int show);
 void bitmap_writer_set_checksum(const unsigned char *sha1);
-- 
2.44.0.303.g1dc5e5b124c

