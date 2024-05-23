Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED712B16C
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499597; cv=none; b=LAScxXn2ZhA6dS9ZQuxBGMOMP3NYYafzjN6eYrwtXcIIIZZKrBouWorDSiRsECxO7SUCLDBY1ucxtvlsNfFpBxP4gUOoIiEUOc2gw9fmYyEZkIswNOqwO9QZd+xr7knBaeI2YGVxmP2MCHGQvffbFCgllpCyLrCi1yWjZ/eNGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499597; c=relaxed/simple;
	bh=vzp80rjWpRzvGkNzHwXXh6MvuVxC5bhiEl1zOUkL4Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjXmjY8kysZk7rsyW1MWl3QFvHT6R+MWOXZWrtFQF/Hnw/rZ51nSmS3oy9ON36S3F3ZrLyRSmjyJBbi/3UZNPSxZT7XqerVAn2BqY3YbWDOaZXRNxblmyUiDZ+JL+j31q+4RPwCv1P5xmLVIadLZEbTrLVUpUCImgGa9g92txRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Wjdg123k; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Wjdg123k"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ab9d3d878bso1491676d6.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499594; x=1717104394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qU7wYPHttZ3eDvUe397jdb9pOvr2Pwy1R/Dotu6BEkw=;
        b=Wjdg123kuL+WeigOfKVDs+jMaYFOiYjqq8+tA4s3vynxeSdkYxI3FeIXz/T8yBImn8
         EGOZJFllfaqB0PPXKgsBnuYxOdNQCeiYmWN5OhIbCU7vnpDEEOtrhh2KOpnTq9BoQ3e+
         tSDaZUYuUcKECeLPZrhwLX+uMN5qcSNjFubyNK1gCIImj2+RRaCcUzwsKVtm3P7sPePy
         eGpF0T/E1ZH74U9us+hceQBmyAzY0eYcUz2WcHdZ+qVnx9xn96EwLq03KEqVRX2SkNlg
         xw0vQIoUEr8OS7lYw96F9X2YyVLQnDh4KZoh/eyRw1yfDnwiWR7Uyp8waEGkBgeAbEH5
         usdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499594; x=1717104394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU7wYPHttZ3eDvUe397jdb9pOvr2Pwy1R/Dotu6BEkw=;
        b=diKiNXJQxv4Iq/xjHoWdSXwz9st1QHu7oX7ACzZI2ipTt2UppEAin06atPJgzDVsoe
         i/7tT9GcRsGyJG07RyZMkh7C1ejezDNyrdDJuBahAE2acTmODjRgZOqTj2Psk/E+T+IS
         F6yGKi20kdszXTF0l+ARgseqK2GkG4xb0xaWlm+yxomLsCctZ7Wrtdn4Ns79e+Ofmj3e
         b8PJPSAcfOK0g4uwSgYyP0JgN8nHM64SEdBWrRoOjgB2R3jmjLXnkTPfebUjRZgIwW5X
         JXjipsEklzrc2aHqIvXvMmhm8tuY6jcG5qVY+Um6lrGDXfOtrlDP+8xh6aFXYj/qw/ne
         +x3g==
X-Gm-Message-State: AOJu0YybN7dX68FawIJQC0EmSI9lm2K0mUe52UM3RdkZA/s++ZU9kQ4u
	HwGtLcEgZebcXAsupmlNkgTJ0x0vAZskVPUW2P3+ybTLngn4iruY12zIwi9j5jFlOqT/jVu1VOh
	j
X-Google-Smtp-Source: AGHT+IHMxxn/DhteTU6dcR8uBSBOeU0aIdvNkQcqkO59xaSdWt/wcsHtF/XH3P8Fii39dkqEciiUsw==
X-Received: by 2002:a05:6214:4888:b0:6aa:f601:ce51 with SMTP id 6a1803df08f44-6abcd0d2d37mr4237956d6.62.1716499594292;
        Thu, 23 May 2024 14:26:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070f4b7dsm606516d6.67.2024.05.23.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:33 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/24] pack-bitmap: implement
 `bitmap_writer_has_bitmapped_object_id()`
Message-ID: <fe458728c8a14a6b1fe9e86340c3ad79e7fa804e.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Prepare to implement pseudo-merge bitmap selection by implementing a
necessary new function, `bitmap_writer_has_bitmapped_object_id()`.

This function returns whether or not the bitmap_writer selected the
given object ID for bitmapping. This will allow the pseudo-merge
machinery to reject candidates for pseudo-merges if they have already
been selected as an ordinary bitmap tip.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 6 ++++++
 pack-bitmap.h       | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 60eb1e71c98..299aa8af6f5 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -130,6 +130,12 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 	}
 }
 
+int bitmap_writer_has_bitmapped_object_id(struct bitmap_writer *writer,
+					  const struct object_id *oid)
+{
+	return kh_get_oid_map(writer->bitmaps, *oid) != kh_end(writer->bitmaps);
+}
+
 /**
  * Compute the actual bitmaps
  */
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 6937a0f090f..e175f28e0de 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -125,6 +125,8 @@ void bitmap_writer_build_type_index(struct bitmap_writer *writer,
 				    struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr);
+int bitmap_writer_has_bitmapped_object_id(struct bitmap_writer *writer,
+					  const struct object_id *oid);
 uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 				struct packing_data *mapping);
 int rebuild_bitmap(const uint32_t *reposition,
-- 
2.45.1.175.gcf0316ad0e9

