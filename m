Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657E1494BF
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318134; cv=none; b=mkPZbGlGa4yZFuYCOPpivra55I4/dAPCwWAlGSs9rDlH0u4+7EXWISpbzYvA2eDbV7EKPgDytvAzRCRCjEq2lqASZX9mi4H5sNcNekul8GZnuqO+SWTqQIifJCHEcm3xkHrfAFfIvlmbQULJgY8jr+diO+q5u+0GixaRLy3mnGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318134; c=relaxed/simple;
	bh=GyQgZ1oHifaF1aA6YJ79/i8EiqDL5cRCWzEt6XGJhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRRljM74i94S5UB+JeZ/ifmsHLOpptSuVlCulB+d6wzdWTzLASLlpx7RZMCLVtJuTFjeeZg3xzpjl5zasakGUuaADhWvm+Tw9zoB1Apjsb+xxe8lpy4dGScBzWo6yfiTpYEB0MJCwIGylIs1O97G5qBIqKLTMsUwFR0i+ODL1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AJt1dMor; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AJt1dMor"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bdf626beso15679185a.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318131; x=1716922931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8F9/JtO25EibLgceDnUtIQkyknjeWzUIMGx6e14HKOM=;
        b=AJt1dMorxyaRCp3HRTrPm09GZ4Y6bhVw0bTRfeJs+N3t5m5zMEpdLB9CfN25HdQY0i
         a7y+XVAjea4qkEm0Q/u+yNx500KomRDeuJIa8NXjJ4LWCE+/42A3UUk7fugRUaUxa9I4
         3Qxwp1nZ4qJNyRt9ffIrHsoFa8ZT3Lkj07w2Mux6QRikOZZb8J14poxKVn/mVQ6Kmrdd
         pddQ8TKCK1XH/3ZoG7soXQLCgjtSOwMA+d5qObSSVTIxQkzkVdSWNommEEPgjIHUOn73
         7Fxz3yJG7wrWdamEjSlIdboH5O9YmvGfQ0JpoOd21uDdezaa2cmiJaSuJaeF2LvqEgZv
         OgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318131; x=1716922931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F9/JtO25EibLgceDnUtIQkyknjeWzUIMGx6e14HKOM=;
        b=VVKh7U0HmtwT8WNWCOMrUfa7Qn2n3bph/yp9wIZkf1BfPTVKq35cCWkfpPOpOzXFid
         ky1BcJSCDZ+mbJGXFpKYyxatxCMcg68J839dJo1SFZcnEFzRlNnvZBYpmOW3xfdkRzMq
         seHn5ltJDkAB3tz89gsMp4mZOq/3XItnumYQytzW4GeT7ckD8molJppFn+J40QvORb0Z
         5VvrujPo2Lu5vPEHAxVj6Jrw96RPp7omlnAX6OYGrHYJvV3RnLmkjbjOHd9CBCwQfgqh
         F+CjX7UL43gOzLdFqR6LsEdCMAy7lVJzkYZqf4LXrzGMoqslg+EaXoEAl6uKkjht1lNd
         TNgw==
X-Gm-Message-State: AOJu0Yzl5oYBua4GcmKEY1XFagj/pmdk5vpZlMZD/wDC2GTFkzkG7LqS
	1J6fIDCqM60UqKjvTTXcTh1IXKFzv2s6JqiE+NnO8PJQC3dArmxX+DXYXU3yz3eashp0+hu2+50
	5
X-Google-Smtp-Source: AGHT+IGBLdNkNi1v81uIPFt1tl6O0kElNtyiSuGstyfBaffTLwQZtMdtVEOKLOcp0LTO9QrSM7fb7A==
X-Received: by 2002:a05:620a:4416:b0:790:ea3e:61cf with SMTP id af79cd13be357-79470edcccdmr1686288685a.15.1716318131158;
        Tue, 21 May 2024 12:02:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310c2csm1314847185a.112.2024.05.21.12.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:10 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/30] ewah: implement `ewah_bitmap_is_subset()`
Message-ID: <40eb6137618ad4c648eaafd720a9678d8d84c96a.1716318089.git.me@ttaylorr.com>
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

In order to know whether a given pseudo-merge (comprised of a "parents"
and "objects" bitmaps) is "satisfied" and can be OR'd into the bitmap
result, we need to be able to quickly determine whether the "parents"
bitmap is a subset of the current set of objects reachable on either
side of a traversal.

Implement a helper function to prepare for that, which determines
whether an EWAH bitmap (the parents bitmap from the pseudo-merge) is a
subset of a non-EWAH bitmap (in this case, the results bitmap from
either side of the traversal).

This function makes use of the EWAH iterator to avoid inflating any part
of the EWAH bitmap after we determine it is not a subset of the non-EWAH
bitmap. This "fail-fast" allows us to avoid a potentially large amount
of wasted effort.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 ewah/ewok.h   |  6 ++++++
 2 files changed, 49 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index ac7e0af622a..d352fec54ce 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -138,6 +138,49 @@ void bitmap_or(struct bitmap *self, const struct bitmap *other)
 		self->words[i] |= other->words[i];
 }
 
+int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t i;
+
+	ewah_iterator_init(&it, self);
+
+	for (i = 0; i < other->word_alloc; i++) {
+		if (!ewah_iterator_next(&word, &it)) {
+			/*
+			 * If we reached the end of `self`, and haven't
+			 * rejected `self` as a possible subset of
+			 * `other` yet, then we are done and `self` is
+			 * indeed a subset of `other`.
+			 */
+			return 1;
+		}
+		if (word & ~other->words[i]) {
+			/*
+			 * Otherwise, compare the next two pairs of
+			 * words. If the word from `self` has bit(s) not
+			 * in the word from `other`, `self` is not a
+			 * subset of `other`.
+			 */
+			return 0;
+		}
+	}
+
+	/*
+	 * If we got to this point, there may be zero or more words
+	 * remaining in `self`, with no remaining words left in `other`.
+	 * If there are any bits set in the remaining word(s) in `self`,
+	 * then `self` is not a subset of `other`.
+	 */
+	while (ewah_iterator_next(&word, &it))
+		if (word)
+			return 0;
+
+	/* `self` is definitely a subset of `other` */
+	return 1;
+}
+
 void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 {
 	size_t original_size = self->word_alloc;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index c11d76c6f33..2b6c4ac499c 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -179,7 +179,13 @@ void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
+
+/*
+ * Both `bitmap_is_subset()` and `ewah_bitmap_is_subset()` return 1 if the set
+ * of bits in 'self' are a subset of the bits in 'other'. Returns 0 otherwise.
+ */
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
+int ewah_bitmap_is_subset(struct ewah_bitmap *self, struct bitmap *other);
 
 struct ewah_bitmap * bitmap_to_ewah(struct bitmap *bitmap);
 struct bitmap *ewah_to_bitmap(struct ewah_bitmap *ewah);
-- 
2.45.1.175.gbea44add9db

