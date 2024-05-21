Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC96149C60
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318148; cv=none; b=qCsQ0VERDGF2dD1AwO/zZd/fd7o6grvi4gU0diacCLiPU8j9rnv0wKpDyTgCi4Qhays77oKUaB1ZfKK1EYcv/l06Kc2Ct7cOgJiks7HOpdDpf0Tzr0mN8sSh8hkn6XvdyHNGSybJl62B33Y8eqgsx5QXTo2Cdzyml8RjOoG44X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318148; c=relaxed/simple;
	bh=ElSEYqMG35FVztiwNx65MugJny7Y5G4YINRmErucZwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijKvMfngd58GSiv3gFK5amIVkN2WrUczdes+40GnT40PPG1XN30OJuUlXKNW+LWhItl4LDUCqhe2XTJAEZoM71IBsKUESvCNDnPQt+ZYeGHV5WZ6R7SWBYtR+JovmgR/D+bbsdepy5lTtEwKnhoCkPysNK7iV50gfcLM5fus86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=B4CcCeYo; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B4CcCeYo"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c9c41cdc4cso1589337b6e.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318146; x=1716922946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvL1r1kutsC8n40mTvcpvKDxHEn+2zuNKJXrnKFiFIY=;
        b=B4CcCeYoji8SM1fMwO5ijD9aeKNpM6WVgMn8SEiDzWFyKubkOcyyOuzPRVps8RPNWo
         fGYs+3GjMF7stX8KDj7VYYjaWZ1TEjp6j/pOlAj9S4ke4MbZGU5UB8FLIVfjEIn9haKI
         5v2DP5PaqN44gToo9+cbBWgiv6DcEc2jVfzow+7lyZu1Oy0PEhDUQxUFn2cnvQ0H4/X6
         P3hsyZ3q6jm5Lvyd07Srt26D6hEZXLs1ynNvUmCtZgKEDQjLOMghU6IDh6G5LmMxZRob
         Np7j69lQZKoHo56IsVYl5Rlgv3y8x6Bg3M8eNMyXbUUnXmPzx4hVuu5XbaqWDt/ZeABU
         nBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318146; x=1716922946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvL1r1kutsC8n40mTvcpvKDxHEn+2zuNKJXrnKFiFIY=;
        b=xDHJ0f6fxra1eIZVTzKUkw+H/Eg8lLNB0li3XYcbNSOlcxw3meNl8QTVbxzewAMD+B
         CB0J0hNWDfDA17HkVrQzt4+5Z1JyhjGp1FSOj+e+nykPoqwU6ay7AJDek7lOvUqluU2p
         cR7FZsLUglZafXVv6Pns4lnVU8Ahs4ynJhtUJdTtJKptvYH4hK//AR22aA1c4zMHtL02
         Bc1Z18KgC4N91zGnvV+3G/+hi8wGqSNQFpnm4g1bOep9nr2+cQJNIn7gNa9luakzis+Z
         353Fs40kFVnYCKncEe9o2xcroY2Eb7M+mSdQKRlJBL4q2CvfACmEIL9oQREajYi+KYKh
         2OPw==
X-Gm-Message-State: AOJu0YzXxNNrrH89829n18mMz2UnriX1DNfNKuPJ4l687SOz7QFF00G9
	n59ftGoFRLajlq7wH+WMXikR78i+EW+OrHTvJYC/KJpv/ZSnypi5zWEazQQ+1KfAnk4Ee6bMnhx
	v
X-Google-Smtp-Source: AGHT+IFWnHmOuxHYpzWjWsBgFcCSgvoyFincw2eLrH1cPj3upS7E+QzIfP6oebx0O3RXiocz+hxvKQ==
X-Received: by 2002:a54:4890:0:b0:3c9:668b:c9ca with SMTP id 5614622812f47-3c9970cec87mr42351741b6e.39.1716318144330;
        Tue, 21 May 2024 12:02:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab0f86c3adsm19446316d6.28.2024.05.21.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:23 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/30] pack-bitmap: implement
 `bitmap_writer_has_bitmapped_object_id()`
Message-ID: <99d2b6872baf5702aca74429c7c31b6fab5b1ec0.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

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
2.45.1.175.gbea44add9db

