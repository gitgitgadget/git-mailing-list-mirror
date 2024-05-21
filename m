Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E33B149C66
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318195; cv=none; b=VNy5m81QQKIZPS3oD6Kd/jVoqOhWq54S6AfMnqHELnfzYDOxR4DVbnfGugn6Vyj9lC4N3Vz6gm4gNAirBrP3aH2DGX1bunaL3l/F21MVtjiF5845kL6wP2vmhX+lzFa0Htq1ygqbeCf38Lrooa44v6C5R4Yw6H3MvDQGDHjCi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318195; c=relaxed/simple;
	bh=8hPjU0ugIJf4TcmbrO4sEG67fSpJLtsuDgDFo0EY0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feI6+/8jG2PX6U7P3i4XtS9Uvg9NVU8Yr5lT7bz5VtPthTteEUSDliR90A1kef5bg8LY72KqvSwRfUBOo26WShuDAmCEjvB9GpLlRkFPYc1dejgAjj9+R0H8vbdBoGYgSGM4Y/DLxhu7hnffIMDWbrmkceQMYJ1y09XlNh83j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vCOTUfW8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vCOTUfW8"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792b8ebc4eeso327827285a.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318193; x=1716922993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+TApMOej23rAq8J7X8zVnMzg2eM8MoZahdjZuHHWMo=;
        b=vCOTUfW88Pl4RihCzXy1e3UKN6XK5BpdtRL+Rfao2kYROGiJTZ9SsiIbajZLniilrL
         4c+HJSMOzuIa/SiAoFTvfdqzzGeVf2W5va5vZW7ZrKxCQY3wl4W3p48m2oxUjyWaVfc1
         hm1ZoIZXgtHguObaKfFYye6fJwAJXyhzyrheR18wdvEpCuQ820hfG8b2lS0J3w172MQb
         ssB9EtlMZ8zmCnpanP0kXU3xiS8eES7GJF9/60B4ZStm2nCWRtaHt+C6AlonApn1cD9F
         qAdSFmm55hzoJPs4N0V8QmWrz10qpCRMLXEoZDupj4Nbgo8+RG/GlYw7bR7Bb3ygzJ9y
         kdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318193; x=1716922993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+TApMOej23rAq8J7X8zVnMzg2eM8MoZahdjZuHHWMo=;
        b=lSgki6lYrdy4gPCBIdopJs/Hr4TErg7PUtN3brAVPRKUI54K1T4RfHrR50kyn0LHXA
         PB6c7Kyqsr9Qf2vh9IlCCk9bIRRQGbVXwJCBk1qPvCcCi5mNsvDHlKyTJ1oLDgByjcRI
         DjjzipOUGPQOfD0PXh5OLVtwKiicpXl83xHxQZ9bcZDVpNM7Y/wv3MgM5OIiSkWKPo6Y
         MaA0hDrnOWNZUv6/qMuzugVsaEy6XgN6tvjwBb27m4rvJq7OmRVZS8MARQLU99sk4vN/
         Dd69X1ciDO8rzUafV88+o6UKGy7qYRU/mSMwAu/LOnBXd8LwHqDpQIsF/8Gi4+7i86wl
         T0jA==
X-Gm-Message-State: AOJu0YwTUuVVl1yDyJ5Fxq8tpq3VxXsAFxDC7C9wj6qtgC7w3yaBknws
	FhaIx+UmOKAU8/R0TCq+Se4xOiTEKv7G2ah13Vn9fDFDtLLoMJVifhXz40BSa5tV7ZK3sVdEHkz
	y
X-Google-Smtp-Source: AGHT+IF8xgtroXwyNLSCaNMok0dX3hXztlqkeTYjjc8XdY097T/ZRcJMLXz825iFSx1fq52YyIXUWg==
X-Received: by 2002:a05:620a:a14:b0:792:c0af:dda1 with SMTP id af79cd13be357-792c75abf30mr3293911185a.32.1716318192574;
        Tue, 21 May 2024 12:03:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf3106c2sm1312022185a.106.2024.05.21.12.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:03:11 -0700 (PDT)
Date: Tue, 21 May 2024 15:03:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 28/30] ewah: `bitmap_equals_ewah()`
Message-ID: <da2fb5b4b48816eb97d2190461f7b3dfa4da917d.1716318089.git.me@ttaylorr.com>
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

Prepare to reuse existing pseudo-merge bitmaps by implementing a
`bitmap_equals_ewah()` helper.

This helper will be used to see if a raw bitmap (containing the set of
parents for some pseudo-merge) is equal to any existing pseudo-merge's
commits bitmap (which are stored as EWAH-compressed bitmaps on disk).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 19 +++++++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 20 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index dc2ca190f12..55928dada86 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -261,6 +261,25 @@ int bitmap_equals(struct bitmap *self, struct bitmap *other)
 	return 1;
 }
 
+int bitmap_equals_ewah(struct bitmap *self, struct ewah_bitmap *other)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t i = 0;
+
+	ewah_iterator_init(&it, other);
+
+	while (ewah_iterator_next(&word, &it))
+		if (word != (i < self->word_alloc ? self->words[i++] : 0))
+			return 0;
+
+	for (; i < self->word_alloc; i++)
+		if (self->words[i])
+			return 0;
+
+	return 1;
+}
+
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
 {
 	size_t common_size, i;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 7074a6347b7..5e357e24933 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -179,6 +179,7 @@ void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
+int bitmap_equals_ewah(struct bitmap *self, struct ewah_bitmap *other);
 
 /*
  * Both `bitmap_is_subset()` and `ewah_bitmap_is_subset()` return 1 if the set
-- 
2.45.1.175.gbea44add9db

