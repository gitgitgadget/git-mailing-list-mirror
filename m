Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF01552EE
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760963; cv=none; b=QMciYliUkgIJx8MnsnptjkqcNLIEvfEE9LvuVeCkDO8EB++hh8ArtSel52VW60e39YOk1tM5wPQ2eNcToICFYSSqtrjmM3JZXobqdq1rT8fhmwzd4Jyqrj9K3rEnNRsw0OjBD7OeWUPgusK3d49S85hgorITRXKWSxGv2jBGmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760963; c=relaxed/simple;
	bh=e0pUdkypE5N8JOR0223KnhXy7yYCfVdq0REDUuVeAMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdlneSWkXWMccC+DhUCgC/ipB60ypDymE/EX3UtFZBu8z2kMRVbAMYJEv0Cw0WRB3esqCRd8V7YmN25KGbuiGNuqIqQBwlQjRoB4GV8KpdoxyRt+SSeKfAMGNDbNk+A/rswiu8j+yVtypQJ8tRk/u2vslTnBOUd2/aGEu9ZMnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ADK5V+H7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ADK5V+H7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso1442706276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723760961; x=1724365761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hk7olCEw+V+2tKC2Zlgs33ebK2vFPcs6qBfEtV08lR4=;
        b=ADK5V+H7IfoBLAdfLgIsX7hj/3GBxj7qjTNvTmAg+tnMh0XeQyC8ZrxN0BBM3i3aMU
         p2zmG5UhBucFn0IZ5OqEhObT0eC0wuGE4s0YimzqO5XmRIg29/MUNuc/P5CYQrsrgFi/
         HZ60hfMvIg2js2gZxdwiNq50iRtKJySF2LZ28kyfGtCxAc7rozwdcL0gLPNnhnuMyQ+p
         cOXLovQjKXSP1D0tHramGsEud27NoigypGzPDezQTshwetprk1uGkM9aVXqGmf2nchxO
         udpJN1m2Bid5yGoNWVPPrfrbD7gtpf6glW0ybT7G0s7MTpoZuS8iC0DltJ3HospQYNP/
         yiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760961; x=1724365761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hk7olCEw+V+2tKC2Zlgs33ebK2vFPcs6qBfEtV08lR4=;
        b=iNntljlVL22oTn7b2uTiaXtkWabl9jD5a54fd/PIA7+/K7zzczzo/zU2+VqsxOwX8N
         +bA9yZZzM4gPhb9V2uScanrMcZOY4NreIU3+FH77JzCJHdtVVx05tvYyxr8L+JsWzV0e
         fHU7mY4X+xIWmnizuo/8/W/gpGgX+9aQDPJf62FscNY/2cvctBDwMBkfOQTYGdMmuKZf
         ni2unV/2XUXM/hhtAghN3pznvYSluf7KT0S2e2iZ1pCXKGQ4KSPqpMRaZE1pqKOSqqdM
         moal6HPsr5IoVvyA5x/mpatNGLdXD+fJILZorDfuw297vRtl3kwyoPnNNiF6esmE+npB
         XCDg==
X-Gm-Message-State: AOJu0YyzWWLBRTZhJ4oFC6CUsbD7cJhFEt5QFdCtXE3q/hvPMtDwQSay
	Eei+gEvSQUKbeDDC0Vu1PrlqU67jnbUHwexfphktNNBsLG2mezqtrEuzXcebcrTtY1B7L5B2N97
	W
X-Google-Smtp-Source: AGHT+IELJjF5axX7xn6DhiCySXYwPkSJRbodbp7jzHXFkpq0uuK70TW+0UN56vJbrkQxnf/3TwPUAg==
X-Received: by 2002:a05:690c:2706:b0:64a:4728:ef8 with SMTP id 00721157ae682-6b1be8b6fbbmr10247397b3.44.1723760960789;
        Thu, 15 Aug 2024 15:29:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99410b80sm4179047b3.10.2024.08.15.15.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:29:20 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:29:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <04042981c1ad0edb6ab768516cdff341ee278786.1723760847.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1723760847.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723760847.git.me@ttaylorr.com>

While individual bitmap layers store different commit, type-level, and
pseudo-merge bitmaps, only the top-most layer is used to compute
reachability traversals.

Many functions which implement the aforementioned traversal rely on
enumerating the results according to the type-level bitmaps, and so
would benefit from a conceptual type-level bitmap that spans multiple
layers.

Implement `struct ewah_or_iterator` which is capable of enumerating
multiple EWAH bitmaps at once, and OR-ing the results together. When
initialized with, for example, all of the commit type bitmaps from each
layer, callers can pretend as if they are enumerating a large type-level
bitmap which contains the commits from *all* bitmap layers.

There are a couple of alternative approaches which were considered:

  - Decompress each EWAH bitmap and OR them together, enumerating a
    single (non-EWAH) bitmap. This would work, but has the disadvantage
    of decompressing a potentially large bitmap, which may not be
    necessary if the caller does not wish to read all of it.

  - Recursively call bitmap internal functions, reusing the "result" and
    "haves" bitmap from the top-most layer. This approach resembles the
    original implementation of this feature, but is inefficient in that
    it both (a) requires significant refactoring to implement, and (b)
    enumerates large sections of later bitmaps which are all zeros (as
    they pertain to objects in earlier layers).

    (b) is not so bad in and of itself, but can cause significant
    slow-downs when combined with expensive loop bodies.

This approach (enumerating an OR'd together version of all of the
type-level bitmaps from each layer) produces a significantly more
straightforward implementation with significantly less refactoring
required in order to make it work.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ewah/ewah_bitmap.c | 33 +++++++++++++++++++++++++++++++++
 ewah/ewok.h        | 12 ++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 8785cbc54a..b3a7ada071 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -372,6 +372,39 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
 		read_new_rlw(it);
 }
 
+void ewah_or_iterator_init(struct ewah_or_iterator *it,
+			   struct ewah_bitmap **parents, size_t nr)
+{
+	size_t i;
+
+	memset(it, 0, sizeof(*it));
+
+	ALLOC_ARRAY(it->its, nr);
+	for (i = 0; i < nr; i++)
+		ewah_iterator_init(&it->its[it->nr++], parents[i]);
+}
+
+int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
+{
+	eword_t buf, out = 0;
+	size_t i;
+	int ret = 0;
+
+	for (i = 0; i < it->nr; i++)
+		if (ewah_iterator_next(&buf, &it->its[i])) {
+			out |= buf;
+			ret = 1;
+		}
+
+	*next = out;
+	return ret;
+}
+
+void ewah_or_iterator_free(struct ewah_or_iterator *it)
+{
+	free(it->its);
+}
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 5e357e2493..4b70641045 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -148,6 +148,18 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent);
  */
 int ewah_iterator_next(eword_t *next, struct ewah_iterator *it);
 
+struct ewah_or_iterator {
+	struct ewah_iterator *its;
+	size_t nr;
+};
+
+void ewah_or_iterator_init(struct ewah_or_iterator *it,
+			   struct ewah_bitmap **parents, size_t nr);
+
+int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it);
+
+void ewah_or_iterator_free(struct ewah_or_iterator *it);
+
 void ewah_xor(
 	struct ewah_bitmap *ewah_i,
 	struct ewah_bitmap *ewah_j,
-- 
2.46.0.86.ge766d390f0.dirty

