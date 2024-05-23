Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021911292E4
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499584; cv=none; b=GfdYiT199Y8hXp8wHiORsYpnl9247IvGjldAPmI11krGRL7t9g8jKg4hSaepwhVnkxfKDijfufjmupnq8C+TCP+RYXNPrIZ5DHUpFGhIFaQGkq1jxjMWG/L1oVqW0KWCiHCQGrAGMDhxlMIHA8qqhwY6rggUaEF5ACiQ+6lAEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499584; c=relaxed/simple;
	bh=soKJO413PZJLyqJiHb1Srzoxys7hX2I7+8wqYORq+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyX8zSRAAuDvn1jFTt9UNP+Td/yEE2KUaCm/3vTS4DmdyaX8VP1Nu2NevQ+ESpakf8oP8uIcehdQN832fg/DmzKChItad9fVmBYFSMs39o09bL8gHj6iKrFwOjwNsmz4x7xBlpTuN2trTDs1GZVTSb/TUkyUlVO9KOsYtpK9X3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=o2yNdWCa; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o2yNdWCa"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df4e7763603so2140395276.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499581; x=1717104381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7c2NoJ2o1olbMC0NuhOqP/GbNvHrAvQ818tlxsMKZU=;
        b=o2yNdWCaD5EFskjnR5vHmfcxENhoar2qgCOSBYjT77GiBKXskRf3MpLAAYQ4nVctwN
         kYHo9GMz3Y1W38j47ZUurAty3IZfxYCnOzexXqlvRgjWsGE4/aleHJ4YfREf9SI6qSx2
         r/ho5ZS7mvWEhQGMEYnT2Oj1K13gqszXoeiOqNEwFlG8JgUv5IKs1qqsEzPhtapgj0GF
         BnmpfRpaGKm2H0Yc23KwRsWnh8jm6JBzPzDcvadzVKhku+bInScvq278m9A23WQ8yQk3
         NYPN7s03ICDegQnQYp7DPsXjpnw2ZMbjDiO75w3fApt1r+nvi7sLwBL5xdWRRaVmlMx8
         +bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499581; x=1717104381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7c2NoJ2o1olbMC0NuhOqP/GbNvHrAvQ818tlxsMKZU=;
        b=WOs6n0PCepHx5l0WOmEEeODV3rYZEiYmfHMESkPKioM7vVF28VVY9pw4jfwCt0/QGI
         gxq06Mo25MndJ6bCgbbLrcGK8Duwqvk473P2d9IV/A2ngxU9n5iSCmLmPBKDRSTl4RU3
         lFAYQjpPCECQ8drAV6lH6UxIf5ehNnYKUvPKJSrnh1LnNoQPz743pork7EUhASuMsG6Y
         bI4xx4LUkRBiNPqyL6WMHct7mRBr5LM0GoCVxX3d3ExqnegW78gutDkyyibK8cQHrCmd
         VnijW6xoGfauwb4HMJeHGuDS/wg1Xu4bOH9WEfuZk4xbMH3yuHDfswz4QJXXJfuoG2wy
         sRQQ==
X-Gm-Message-State: AOJu0YxS1y0GLa4Lvkvpbu7K3RtlFXhwU3o678f/j9A37horWCV4WysT
	bYV0d95+Y9S2Z0PBU30u3YUzew6U2xYQQL39ID0tSoKiQouLid88IO9BmWXWZGdrNqJtGX3ErtH
	Z
X-Google-Smtp-Source: AGHT+IFaX0itoiUpzppurKW88TRM4GhEsNii08fY9QE/nNWjthhW2FIpxyw87rB+hmMecn2hnpANUw==
X-Received: by 2002:a25:5f09:0:b0:df4:c920:f80c with SMTP id 3f1490d57ef6-df772185bfbmr451180276.19.1716499581592;
        Thu, 23 May 2024 14:26:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18c1268sm521901cf.87.2024.05.23.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:21 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/24] ewah: implement `ewah_bitmap_is_subset()`
Message-ID: <211d6f1412874d6211f4ce92f74bb3ed88292f8e.1716499565.git.me@ttaylorr.com>
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
2.45.1.175.gcf0316ad0e9

