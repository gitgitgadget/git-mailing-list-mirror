Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C4178CEC
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423406; cv=none; b=tkQRuwjvlwWjPhpzs+KreyPSpnhJIS+jS+GHKGQIMLu7ogTU0jRX6+5As/ikxEkeupDiZbAkIH6mHr90dDRhkyej73vVeqPRh0+3XzYEXaPSNbsX90TmhETDfKmy8jvv01CkvKrQSBkGD7TZ4XKO67NVk0WPoGnMXLcnLZLDnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423406; c=relaxed/simple;
	bh=MhtoFFee8VEI8nIR8q+Kc1MDVwkatehkVx/4Jwmlya8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVUcLrAY72fbROLGx5piDyjaSDVhR9DbU0RYPquE6Q4jru5aJJqikMenADFBS3FU0oD5wfzaCqKdrCFr348SidoXWMbT/nwoL/+x5K9cu4DE0s24hl3lX/9PWr0G6wDQBHCgA+aFsQbCsnhLKgGSdPL20i8Q2Kj6n6QD0Ex5eio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SntFHexL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SntFHexL"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6969388c36fso20410996d6.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423403; x=1715028203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qnJosCcbkQgZoHuN4GTVYVsyg93qmGK++c13D073jCY=;
        b=SntFHexLAj5nqT5tEUs2I3CqXSFJg/BSgfzpXSGXdNbgphUotcRwoxqAU7vAI5CDKJ
         7c5Hk7jetNpVHs5BaunO5OmklvdTPv+wBeLKWEUk2rqRKuVTjR5dOwsOQcDRp8Ckg1NN
         FpSEin6m2xeUczReXeVrGuxkzug2gKLw3fpmhpeVL5NOWsO2eho7zaDKKeWHF6MKmVVR
         u/FRy94N96PwoWHNESw04rbN/Z0hKg2Mv+YVSsGyvXdHhd0bU/Np64zRxHaJM3/eHwJb
         LTnAjTY90f0HTUY66sWH/00BgdQVCwLBJneYxtide78ucAuuy911d3GfwtO/u+X4h92A
         23DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423403; x=1715028203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnJosCcbkQgZoHuN4GTVYVsyg93qmGK++c13D073jCY=;
        b=MHFSBhS0r5ch1xYxn7JFOLC0S6vqd5K6w+imkKJwmhrTCexlKzqqY9+3heRUfmdawC
         s0/Ao6hK9Gb4E6eMAK6+jrOif3H2cjV4taNS4A/1e00qKjF8ecXb/ITYraFb+gEJJEk3
         XXWc0T+aHuZWQr2ZGf2Int/TdllDYu5b8ew8UdpAlpbN2Hfz073L4OjDmvvTgBSLkJei
         Dd/ncYmFRbop63ehKyEQu5CyDmIk0f2RThWFBbUvGw2uS8SgTpDUXL6OkbGtot16F/HH
         lzUF9bxWdFty7G3zhssDXZdJiNdc9NuWtCi0GRcaFzBaRGZTYLnUwpSwDShrHv035o+W
         4lPw==
X-Gm-Message-State: AOJu0YzSlPwsfMem63u7J7Yy3yYKZs8s4R1rsQ7T2VZelLRxsEmutfIu
	ado6ghuehuISvBF4MOrs3EZmWsfTT9lgu4hrLxZNUBg/PGtiUBsU0YVDRPRzU3XNZIYZk3zE6xX
	/+rQ=
X-Google-Smtp-Source: AGHT+IH5TD3YRIDCytHRlzpFCLDwAn/lKbvMi03SsWBX4opmhXPvtqEwvRef26rK8kBzrbmPl5ujow==
X-Received: by 2002:a05:6214:76e:b0:699:3a91:e25 with SMTP id f14-20020a056214076e00b006993a910e25mr628656qvz.11.1714423403479;
        Mon, 29 Apr 2024 13:43:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l26-20020a0c979a000000b0069b10d78445sm10860126qvd.142.2024.04.29.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:23 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/23] pack-bitmap: make
 `bitmap_writer_push_bitmapped_commit()` public
Message-ID: <dfd4b73d12edc1833e5090c956cda6f28046c9e4.1714422410.git.me@ttaylorr.com>
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
index c7514a58407..dab5bdea806 100644
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
2.45.0.23.gc6f94b99219

