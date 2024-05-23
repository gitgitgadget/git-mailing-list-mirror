Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA912881C
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499642; cv=none; b=aYpcoPlmN/EDVJlpWkzuJbjkdDF2YqG3v9kdGP/ILL+7BDIfIsoQ93jzjPrF4UijvMKhm5jZosBnkcoos8+KWz2CV0MxzocfHDPSC212KjbQHAGQh4Tb4CrSxaZ0rNQ8hu4h1XH9wJfK85OeKRHis+TEWRvF76YVCSUja2d4H9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499642; c=relaxed/simple;
	bh=rYDApDWeh7xbLW8jFhYmmI2xGsnRwv51iQz+Zyp7h84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbB+CGhThpye6mA0vcIpf9O4FnxDyEfO5uLfUE9tRI2ULnzgJrUaUtfULreFO0LAOWuSS/5x22S5lNIFtX50Iv+1sVdGFfJtCOIuCLLHTiyGwG/emFIaIF4705LT+wGCfbInIBjfeXA6riOERZRtgKVfHRNyohZWL8jJa/5CnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=f/Gi01Oy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="f/Gi01Oy"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ab9d074fd1so1348436d6.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499640; x=1717104440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sibx1wvZ5ibj1oa0U6cIkDGfjpB7yz0ftXmuVB2FEgg=;
        b=f/Gi01OyFZ9NDom6xj0enkBWeZDcPXpUiCnKpEhPny02JgGaViDcQh8eON0vPA/BLQ
         vn8cFfG2wyroXYr1nJM1jdy6oszYzdrKkH0/jQG8tk4eCicqYp+btG1ebg2VSIRDkgdG
         pM8vl/fi9wcfCKV8e+pXFSAXATNqWIOzsYF76lr6qz8BTnxUYX4mSpClcE6frmj5zmKE
         1LJxmnDxv5doljF5F5dw8NEpUmFC9MaS24MQ1L0MCiaeex2A6MYHjenGKP244WTVHjUb
         zoK7LF49iHVteO8APmleTnUkw17OW6oqTbVmOeoB7lPeyDkA9UO6fLfpmsRniceUF+S6
         My5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499640; x=1717104440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sibx1wvZ5ibj1oa0U6cIkDGfjpB7yz0ftXmuVB2FEgg=;
        b=s4c7cVwNE9C3HmlKluPtRpJXh6kPXea8IRHeZKTG+y45mZ8Rzn3+vf8bREfKq9VFjK
         Ek761TMPOSEi5Gw/8K0259Hlk3lM/ypEfDW+3at1SRNAw5rkk6qfkr8hdNbNK+pudeVU
         LN1UFWmDCSvtyBmSVOlhNLl/XEOzFLUHtROg8jdV2hN0Q3zybIZrjXKH+GeNZcvg1JgJ
         v4txhWxuzISOgmWTKqEKpBvMNBm/Wr3YnRaWkDVeGaHMXHbZCtrqxFoGGtyaeekRctN0
         v9jEbkbic3GCw3BlHz8eooEPERiJho+Wk4jkduldRc4hQ9rOnYFQ/ZFG05qM6qe0+qrO
         6lRg==
X-Gm-Message-State: AOJu0YzjKOcigExEc+lTCY00L02ZYHN/wScXATwA5E68KGDzv5+AV8pF
	kmlDvK/bhEh5tVzC5mIWRngfY75hAyx4peoox+Vxy8t5UdrhH4n8ZgXsyMWwcrbJbDQWYpHpBRC
	w
X-Google-Smtp-Source: AGHT+IE0rHeWGQ1D0G8W8zMggGi9UpXYTk08Ww1nkncdQoOBR+TSu2RyP96iJow0/UcmGHMRrtmyhw==
X-Received: by 2002:a05:6214:3385:b0:6aa:42a3:3cde with SMTP id 6a1803df08f44-6abcd10a865mr2544416d6.59.1716499639826;
        Thu, 23 May 2024 14:27:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac162f2356sm567706d6.98.2024.05.23.14.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:19 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 22/24] ewah: `bitmap_equals_ewah()`
Message-ID: <625596a143229e6a9a8a36d2b0eaa480ac204809.1716499565.git.me@ttaylorr.com>
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
2.45.1.175.gcf0316ad0e9

