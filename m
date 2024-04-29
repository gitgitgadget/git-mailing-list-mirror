Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A6178CE7
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423402; cv=none; b=nj0xzYRAk/3f6CHvZVFZL6ThOLH09hfugDtQIQLoJS7exn9+tdZRZ24eK8lxjDwygHAbdjIsmoVTqJt72uEe+I9u9vLAZz+jDSrXU/6xnNebf4Wbs473GYJGnuB22nr6DY+Jv+KE/TlUSHk4DgKCZoAU6bqKDVqOFlkxlbOpvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423402; c=relaxed/simple;
	bh=lp6+12pYJTcvHGbcBqxpNoi3F3KEBEnIhVMIg4OYKuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XE+Hd1WBSJwc0tMeONjdTiSPRA6cWs33l4nZTTlJ17BQd26Ond8TaE8zMEd4PFOgLDcAQoTPaFcgzBpRYFsCDugKlwEyTNoxp/Csy47wfodRHruooX37rDWOdvZHmD2gxCfx//43WrAJ6t7XZjkhiAetNQzI1+UBiGQe8BH+Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pT43n5cN; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pT43n5cN"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de607ab52f4so691658276.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423400; x=1715028200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phMBd8bIvedWnGXfGOIYfGH1sSspJcu4/f5+qrtXNmg=;
        b=pT43n5cNA9vaCC0YgOj+vq5tTiulKNv8KIx8EYKsj7WkFVgrdEQOgLpcwgLxRv6NLV
         dS8YMyWaah2nmBJqXBTpeBf35AYpCv24WdqWY7UhysvadPDyD9F8Jo0YDPw0UZbdGFOk
         z9WGllZU/4XEqhZ6E8QBJ5KpBzS6Ib45yBeQy2bx5IS4DZ11MRSPGGUG7OQPMbdIYVdn
         LWh5qC2pec3y/ym25PXqUQVXm9oFeqEbs/2Pk+ML/6o7/BkmGkOQWikJeICuwoQpwCy+
         6WVkfNXahPA/hn/Ys+Vr73N28ounCRln0GEZoMHSEyXF4WIHmTTCkEGxq4KhEUP1aQVm
         Kkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423400; x=1715028200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phMBd8bIvedWnGXfGOIYfGH1sSspJcu4/f5+qrtXNmg=;
        b=dSiddOt57cdJnY/HxpAmcBPLBV67dwGS7QquBWFEJYduSOb8iVRbEkXEkcpIZy22xz
         K2RQiGcyjTFM4lCbUJO3lGos5VfYcyt8YVhG8fZTkDNKhZm64CU8I+MrEOCKYiZ5cIhP
         xzNq9fVvQfnjjlttGOQmekwm3VCAsCufmekUnaVrlU64uok834oP/W2L/SCJrZu13fLt
         6lfN4J9/BgGtuHXBWzhkUVl1avgVrGXU+B7P+V6x5LTKhrsLaTGld1yrDMPlb0F12ymU
         5OTGoL1xTV/NGSDFhdxaELDAI+ykWrgiW3j8pdpX0aYPPUub/ud0HqP6xMtDrCb4/SnU
         ulRg==
X-Gm-Message-State: AOJu0YxKBcxPdFL44H8YsiM/4wZxf0oE+c4h6nOXsKWSp+Aj900X4E53
	777JFFHyZaIhSS//IQjX6KxsXai/+AlrnZvZrw0eLSitgakUEGlaAkGUUMTA7iVWh/ODLKXhFdL
	zO04=
X-Google-Smtp-Source: AGHT+IE3vZ2w2wVBzY8fddfI3hKyqEB4ooK1oiMXnU3cZ5Enuiy1PmCj9hPfuNLqBNTlo68MfyVchA==
X-Received: by 2002:a05:690c:6105:b0:61b:1b51:371f with SMTP id hi5-20020a05690c610500b0061b1b51371fmr12799283ywb.12.1714423400231;
        Mon, 29 Apr 2024 13:43:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hg17-20020a05622a611100b0043ae2fd5a7esm1312355qtb.23.2024.04.29.13.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:19 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/23] pack-bitmap: implement
 `bitmap_writer_has_bitmapped_object_id()`
Message-ID: <9c6d09bf8742f880647067af91da16d656bab672.1714422410.git.me@ttaylorr.com>
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
index fef02cd745a..c7514a58407 100644
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
2.45.0.23.gc6f94b99219

