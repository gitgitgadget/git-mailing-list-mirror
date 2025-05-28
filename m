Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8022221562
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473144; cv=none; b=HJB+KhWpM8DvbEuxPvRfq8zN4w0UvHWO/YNsCU8Z/LoeW7ZmGKhrNciXtCp3OLtOLhJFJN2Sudjb/1A7TO/xS1BjApAs9aNKLMeCbTtVqNqiCGDvFmZHj8NZ7iGJzhhy7lViiMHPb1RoIX5kgaXP9G3qQQtAvyVxu1V2vYLcNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473144; c=relaxed/simple;
	bh=ICcgL8bANC0Q3nw+1O3uegAguVVHvKFUXsmIaDShltw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du2KIlMvrTS04qQ89XRp82GkuRev/5JuGBa0E3ghemSB6Xq8BjDDyh28vWwU5iPxWPPftMkJh2oD1lE4G1uY3JWgaQiOi03H0hUjuT9YddXysDJsBH+8PMRaJYwXBVapoF9pRd4lxvi/K5Fr5M5td7DKdrgXUh5MrsQsjFAUCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pzYE2pMP; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pzYE2pMP"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7d925ff60bso252770276.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 15:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748473141; x=1749077941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKrfzdq+oZZ9mRJsd/kPp0XhmTANHRfaju/QNfZviLI=;
        b=pzYE2pMPvwPxvknY2LAXFVjY9npDmGwP5WQ3+BH1i/8GNTRhAaO9EIulUm8dK18c55
         n9NCune6o8KL8Pmqw03oNN4NP7vNTWUDaprKFdL2zVicYoPdiloomTPrY71bg4fczw9Q
         ZwhMZBqh8PSYpBQlFay5iqMY8fFRG5vp3dAymmq0oQLUyvpmYKeKLNM2L/grd7YVcNaO
         67znJW/nBBOt9oIIW0dWAN3MsLT8miDW0YxJz8XHMpdvWlqq5fvIsQIbVeFSgbGwxLkq
         V903kpYRdqPsSJApPbhsqZbRsXloR6pgutUsynH6OG5nEdraV2glPi3hFn2+GjInk077
         Wqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473141; x=1749077941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKrfzdq+oZZ9mRJsd/kPp0XhmTANHRfaju/QNfZviLI=;
        b=l6+ULkU0qT65jnKCQOT9eTvOB5tr4JHc8pYT3XTrO86fCdgVIFf26cU1tPIhmzxHy6
         NfTXDlNIzyzT03Etho2dA4DeyED5DjBMTwe+brnAfdPL32PedIEV0YwH4qELBJlmc/GR
         Ute66I8Hrne6/u4fVsNgR9QCEdXSgoJ8CjbEERarzcYiFVWJD28tGmwZnMPBwi32Cklz
         5jabnxPGTs5A15apz5tP/vqRsXWlS9FahVpdKhU/AJQeycJTJIulbKs6AuZ1FtZZWekG
         stbiyybJdODSlAF9fqpp/mjwysRjfUhZUYJlWeANbl/VmfpQnS1dKfhI4UjGWeLHtSky
         KxWg==
X-Gm-Message-State: AOJu0Yw6Bk7DDerim/MrrmwU4gkQVtIBbh2q0fSHOo5VL0TO1Ch5NFDo
	4DxR5W3MqimP7oRE+UOo0BniiWxFwE1WegF9lFEuY+D+5NRHc1rVSZL4+kfd/ePgN0HUmIYcPHt
	Q6SgH
X-Gm-Gg: ASbGncvc1BMBXBEmQOGomOC9BB2nrxwlx6qSwbkuFF/U3+rkWXOrkYzTVIFPQlfmhQ2
	qTZxeFJfeW+vvS61vtTfP26VDPNYYuTUgH1SCnt8SQw5GtEXs8QlMGbuTSUUNaR6eTOIeZYsFaY
	2Go9ss4xxik0AySOxDHqI+vae5WdiLcQww7UvtVcvIB3EPQd1wP976PAfV2Zoyh2Xwj3P+KVRPS
	20B64Rsa+8NZIEuMscWyvdecC3J2TuV+L1DYEtzKfrXA9tDzWHI4gP85BsA7VpR/NPDWK7I09YA
	f/vLHJfpj6AWtHbSME6qiYPnAZRAetNSBHZUC2hi7B282VKq6ZLjQh3VNhjHA9Cb6ZUGQymnJB4
	zgehQyii6OoCxEOKFeCBtK18=
X-Google-Smtp-Source: AGHT+IH+SyM6aVwkRnRd7jVad+4yelE0Agp3WV5e/mzmzvKMKP7nBIJKgmbfeauOVBvJ2qm8pTZzRw==
X-Received: by 2002:a05:6902:2507:b0:e7d:6791:9c06 with SMTP id 3f1490d57ef6-e7d919b690emr21776753276.23.1748473141648;
        Wed, 28 May 2025 15:59:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f733ed108sm26337276.26.2025.05.28.15.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 15:59:01 -0700 (PDT)
Date: Wed, 28 May 2025 18:59:00 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] midx: access pack names through
 `nth_midxed_pack_name()`
Message-ID: <d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473122.git.me@ttaylorr.com>

Accessing a MIDX's 'pack_names' array is somewhat error-prone when
dealing with incremental MIDX chains, where the (global) pack_int_id for
some pack may differ from the containing layer's index for that pack.

Introduce `nth_midxed_pack_name()` in an effort to reduce a common
source of errors by discouraging external callers from accessing a
layer's `pack_names` array directly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                    | 7 +++++++
 midx.h                    | 2 ++
 pack-bitmap.c             | 4 ++--
 t/helper/test-read-midx.c | 7 ++++---
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/midx.c b/midx.c
index cd6e766ce2..6705e77881 100644
--- a/midx.c
+++ b/midx.c
@@ -506,6 +506,13 @@ struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 	return m->packs[local_pack_int_id];
 }
 
+const char *nth_midxed_pack_name(struct multi_pack_index *m,
+				 uint32_t pack_int_id)
+{
+	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
+	return m->pack_names[local_pack_int_id];
+}
+
 #define MIDX_CHUNK_BITMAPPED_PACKS_WIDTH (2 * sizeof(uint32_t))
 
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
diff --git a/midx.h b/midx.h
index 9d1374cbd5..0fb490f4d4 100644
--- a/midx.h
+++ b/midx.h
@@ -107,6 +107,8 @@ struct multi_pack_index *load_multi_pack_index(struct repository *r,
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
+const char *nth_midxed_pack_name(struct multi_pack_index *m,
+				 uint32_t pack_int_id);
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id);
 int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d86604..8ddc150778 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -490,7 +490,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
 		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
 			warning(_("could not open pack %s"),
-				bitmap_git->midx->pack_names[i]);
+				nth_midxed_pack_name(bitmap_git->midx, i));
 			goto cleanup;
 		}
 	}
@@ -2469,7 +2469,7 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
 				warning(_("unable to load pack: '%s', disabling pack-reuse"),
-					bitmap_git->midx->pack_names[i]);
+					nth_midxed_pack_name(bitmap_git->midx, i));
 				free(packs);
 				return;
 			}
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index ac81390899..fbed0f6919 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -53,8 +53,9 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	printf("\nnum_objects: %d\n", m->num_objects);
 
 	printf("packs:\n");
-	for (i = 0; i < m->num_packs; i++)
-		printf("%s\n", m->pack_names[i]);
+	for (i = m->num_packs_in_base; i < m->num_packs + m->num_packs_in_base;
+	     i++)
+		printf("%s\n", nth_midxed_pack_name(m, i));
 
 	printf("object-dir: %s\n", m->object_dir);
 
@@ -108,7 +109,7 @@ static int read_midx_preferred_pack(const char *object_dir)
 		return 1;
 	}
 
-	printf("%s\n", midx->pack_names[preferred_pack]);
+	printf("%s\n", nth_midxed_pack_name(midx, preferred_pack));
 	close_midx(midx);
 	return 0;
 }
-- 
2.49.0.640.ga4de40e6a8

