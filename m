Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B2114900E
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318176; cv=none; b=mTNe3du6VjOs/d3r37YyjtCeu0GcdBqVl7G4yB93LQhwCKLBcYsvTFTiStCio8jr6rUqKVog/0qMaQTqgDTNNE0azkgpVzEe3k/Z9OcwrzqC18CLzEgYG6RlZTaLG9pqHH+dz0xYd09rDYhx/Yq/tcoF95wCAaHNkW6aIKk4o/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318176; c=relaxed/simple;
	bh=opVO4O6tcQ4Ee/iIhnebO6lIeVOUp5WzOXhacWWLrVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5EkoegCPoG/hOZ0ivW/TEqvoG4uIvHqiy9HygTmFEF9NoiJHXnvhwpozteuoHYJqz0WDrTf3+ACUseAf4qDegoTSaC/ukADi/I7xdOo24VXIhAj4pBYk6z7HjcYaSdZh9Si2dv5DKPiwCRhtqhGNqlBadZnUSX4F2OpN+HB3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=l/dgyTHM; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="l/dgyTHM"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c9cc66c649so2431926b6e.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318174; x=1716922974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi17tgcchXG4ghdIXJNw3E0XqTE+LmY4yBJAKAkYsU4=;
        b=l/dgyTHMtklbEtcgDbSN+DMI7ZcmxCv1KpkvgiZCwZJt+6mHYdvu7OiceRcPFJCpHd
         NRtxgLG7PHlWlS+HI0+6XoEdGr0C8IBn2LNsh+CJMDJezLkS+w+Ds4fEN02hakAzobZw
         VPQamtdDMlKNayW5/LoHkIpFiH1n//jGednf/kgzAr4ERuma059XBMEVgrivWjfYdKBJ
         lh7WByXViMTm4rXdOMOsu32tUy6WHj+noK9Einq5jnwZ+qbOZRya2dNw7rGYT1aP4bcA
         E/NQrsY9+36ihuV+xW+lKkrmAyacfTaXJ9EMWtHkOumIlaPuo/j2MQsjryrWdYSZ39pw
         1d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318174; x=1716922974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi17tgcchXG4ghdIXJNw3E0XqTE+LmY4yBJAKAkYsU4=;
        b=iXwiY3J+nBAralVBdOuMkPTbL63MOQoIYLyt1MeWYwE/aOUk8QAJIHnG3OV9uJf1lm
         itFTxClS/VUEOSFnQg+BdPS4AOYsKjUKGyS24Y8R4+Kdt1REkP4l3fwMaii/j5Ig6AWr
         6mxEDJtCe/BBv4eNligGMNE/UNDpgVIQ36sPXcL/TbKaE7yRFnSP3b1CpI3MM+f+xPF+
         wsX58GW8oizWpAaYu1ar7xUix3shr9Eg681MwrJujt3/hY/5Qie90sXBKpLJev8JExux
         8Luo/5fsCPGQa3ifOn6YwNjIDHcLuF5PdmWscYJ2MjAu70ZtsHXQf2StvelIpa7Cyix/
         vX8w==
X-Gm-Message-State: AOJu0Yy16bTtu8dRRDCXqx3tVe42tLAO/GUGV7hsObL2dutR8LrMI6Uo
	BN0fKBN/ofk/6UWW0vu9UsCnz6WATXOv7LE5aV6R+3JhWXIzi1ADlZIvkbEVbRiX6nbi8D7L1BM
	Z
X-Google-Smtp-Source: AGHT+IHu6Qtci4GL8Qj6jxgbgwjROUlBVo/WO+foLNPEvQWJ6x2k7O/d6dqV8bOkFPOl2eRkgT6Pvg==
X-Received: by 2002:aca:1c0c:0:b0:3ca:b21a:7943 with SMTP id 5614622812f47-3cdb20adcd1mr18087b6e.10.1716318173654;
        Tue, 21 May 2024 12:02:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf33b16dsm1314093485a.127.2024.05.21.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:53 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 23/30] ewah: implement `ewah_bitmap_popcount()`
Message-ID: <2c02f303b6f5629c08b92cbab06a827905c83f1d.1716318089.git.me@ttaylorr.com>
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

Some of the pseudo-merge test helpers (which will be introduced in the
following commit) will want to indicate the total number of commits in
or objects reachable from a pseudo-merge.

Implement a popcount() function that operates on EWAH bitmaps to quickly
determine how many bits are set in each of the respective bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/bitmap.c | 14 ++++++++++++++
 ewah/ewok.h   |  1 +
 2 files changed, 15 insertions(+)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index d352fec54ce..dc2ca190f12 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -212,6 +212,20 @@ size_t bitmap_popcount(struct bitmap *self)
 	return count;
 }
 
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self)
+{
+	struct ewah_iterator it;
+	eword_t word;
+	size_t count = 0;
+
+	ewah_iterator_init(&it, self);
+
+	while (ewah_iterator_next(&word, &it))
+		count += ewah_bit_popcount64(word);
+
+	return count;
+}
+
 int bitmap_is_empty(struct bitmap *self)
 {
 	size_t i;
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 2b6c4ac499c..7074a6347b7 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -195,6 +195,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other);
 void bitmap_or(struct bitmap *self, const struct bitmap *other);
 
 size_t bitmap_popcount(struct bitmap *self);
+size_t ewah_bitmap_popcount(struct ewah_bitmap *self);
 int bitmap_is_empty(struct bitmap *self);
 
 #endif
-- 
2.45.1.175.gbea44add9db

