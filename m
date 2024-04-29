Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03D1411EF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423386; cv=none; b=cPwiqfxNuzbhzBBh358c0shemIQqlOV75xJAVHNDbSzB0sGljvGc/8oHlm/ZbwPD7ysXjbOrnhcgQRKjjKjU68aaTg3vu2LpQuDx2Ng7MSq++8vQ61vlBr5+pX7g7FIo4WCYY8Xdw8Vlln8VFIO9uNHvrFrx9SU/qw13GqOe99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423386; c=relaxed/simple;
	bh=xbESJ4F4HQc359w7+VrXMlAFZrYzInK2tDCTLrbnSbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxSR1qeT6WVpE+sF5ghvBqyUnuOKPeVTjKGNgoQI5i1D0Re+BeZtlg3AbKfOhBr93M9GdUCZAke5UFhOG1GnHkHn9mzEu3HcD1B65MESWDVprDAaGnYc/NxCS00mQo3wOlKdGo9wJ1ECDMUUWFy1xRTawuAAttRTYne3ORAR/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RZMoQ98e; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RZMoQ98e"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4347cbdb952so23110631cf.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423384; x=1715028184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IaU+CdAhesO5/IIvhGjVMpnAErIz1OGuGakuUZZErX4=;
        b=RZMoQ98ebojG1NEm6/smp7aRmwS2XIxwQif6UIJD7CcY400MQfSTCbOZotiDGRLLP7
         XBSX+JvpIwPsFtacYjtyraHTtAP1GvuZdGuhG5oI68812+BwSWhkk8nRiOZNmb2IbkVN
         0gG8bS8EY8bUXaEo1lgckKDkNmaR2T6l9af+ytTjUjRCObm+ihn88EwkxoumGVNPboI4
         xXTyghfdexJLyBDDsFb3r6aYByIGcengr+uV3+AGTFGLGJDEq1kU197CHqjwd/GdGezw
         7q76/SS3DCjpxbw/irIBpWQZv6dAsqkoPP4o44OPbxj7KSzhDEqCNHbl8g+y2dDwdplZ
         QumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423384; x=1715028184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaU+CdAhesO5/IIvhGjVMpnAErIz1OGuGakuUZZErX4=;
        b=A0ol0/xNqKUbKHlR4DNAcOInL8FBtKnG+6+CPE9HcXpLJ7ee2h4ZW2iTmcmnBXhXQf
         cIp18a6Vb2AckSiSJtuq2+vIUNSKAlWIHbTcoB33Id8iLYAHWpUzVbEs6yOnqaCKNc12
         oumBywfViKAiEuMy4+6zYCg6UJPMyo+6XwPvaUFsKNyMefl1ZgYmInxQMopNzSCKu3jU
         M2RELjWS7g50WA7l5QTWY2FKR6B+SCGOjiw2a83W0uSMF6dHpPOtJGiLG9GQelf/RlBs
         6yWtdg5oXgfL3pAj/BceEoxzM7Sw1rQ7yQd5PdDWiXLXrjirxVAwGm2phb72XhwQvuQP
         pjcQ==
X-Gm-Message-State: AOJu0Yzfp1se+cMGnxVbyKFEUUVjIqxmPKTcLD55YyhRUJM2rNi3WDLj
	MDIRJCMLtBsHq0xTShO1GC6NFbT5R30T9uB/Hu8Fzz8tGZA8CIdkSBagc+EH4n4revgY/BYKBmJ
	6Bp4=
X-Google-Smtp-Source: AGHT+IF9orO3F6YpoJWUyBMUfO9sa3/eyDlbjTKF1cvWOUQquSGUsrYw3CLddkvra+yBQPFrSWtM8w==
X-Received: by 2002:a05:622a:3cd:b0:439:daae:d6a6 with SMTP id k13-20020a05622a03cd00b00439daaed6a6mr693445qtx.15.1714423383596;
        Mon, 29 Apr 2024 13:43:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y15-20020ac8708f000000b0043476c7f668sm10772799qto.5.2024.04.29.13.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:43:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:43:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/23] ewah: implement `ewah_bitmap_is_subset()`
Message-ID: <290d928325dedd89d8e95aa12e643434b0dd2501.1714422410.git.me@ttaylorr.com>
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
2.45.0.23.gc6f94b99219

