Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576234EEFC
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420462; cv=none; b=RJJEZdOp5Zy8JX4BTDJAwvNtZ0u28gG1gcCN7P0dToWD5heWimsraeJj43SG4EpWX9HpSzT7QSvqAaO+c+2VtvoLTaxBmq0oQmgGY0ounf53Aw4xxgB290SlRfRdjAA4E3vmwi+AELbXfcmG9tPtanZ07PJO2oC9fv4Ftv3sEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420462; c=relaxed/simple;
	bh=nxRcyaKY1enxyBVxxS/FuFMaML4HXSTg79mF4CdjCd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYgzxfOJG9ZGrlLOgXpRGgHJmnT9sqiYws6M3iKZVd7MholsNNFIrf7rLza/Kkl4H/VR06g7WoLfUbQLF6t7/troAPUNN/PWA03Yj5T2mBURVDgqDFehpUki5q2P7EEdKQUiovNq6cpHnrUjgex8nnN7DQAFDi9RMjVt3dj04YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Px/7Wbnj; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Px/7Wbnj"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7927b3e5253so1106557b3.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420460; x=1769025260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipExfWIz0VYaf2lq049WHqAeLtz8taJzEGmdM1Rh8Bw=;
        b=Px/7WbnjCoN6Cf3ugEy55nAK6KqLP0NrYAQcWXSD4z6RAfn2IR13A66HvC52cZ1Whc
         FifqDgXv/k9bPPQACJO7ntYVYJKf+pPlN6XM2X1H402HYutOnFVHFMPfFJgl5dlFOulf
         K8i5VtH9ZYh7aohDw6DJYeZJ1cY1qdY43UEKIfNr9qUuiEiBhhxeMM7TCdcYiOHob8ZZ
         O6eq77hfTwGJ/BOUsx8mYoH+7GVg1xPYc94SOKVhxZZDwnSLKzw9lE3FCWTetiGGeQUE
         ypAg3AcyUXUciTrb9GlPyHoJG33SVL5OH9iXQfk2y4oXqvL+7YucM352ASMeabxhgg4P
         OlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420460; x=1769025260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipExfWIz0VYaf2lq049WHqAeLtz8taJzEGmdM1Rh8Bw=;
        b=t7Rq3eSFEI+lvjHcWirB3TEJZUpXT7yTnjsGPzIcWXJ6Xx/2yGZ9wQ7Xw6F/8+xm+0
         fCxqOKuBSzPGSEOxZ/1+SfWdHXiWQmH8EJzmSB2w2voxnbmcc7HlNcLubN+QlwMMMU9p
         YYz+bwuogRLzed7aq1xGzfP/G18R8FdJs1JcVw+V7qIv7G7mfG4gptfQ0zJ1h0WKtpra
         9XtnI0XG2xxvBl6G+9zV6MNQDyIbpaYAjRdTAfM8Y/srY8cOfWWyVnRWe8bKmbXHDzko
         7uHTB/hMPFlkUBz6ITeBfwHla4WYefBVydI6Icdb0+NLbylkZWg1WcWRmoy/5hpjBwIy
         1mDg==
X-Gm-Message-State: AOJu0YwHFlm8YgMcmBuCzahKQp3CzlVMuFpY46eHkgf7jfTAemBZSHlD
	NK+oKvawBWrGDL3hnhpGhnyiNdcZRaC+AXLDQynfZ0yKPaKiZVXfvhvs6GuC5MPN+M5DBu9YLVc
	w9DoEIjMAQw==
X-Gm-Gg: AY/fxX6xqnGWfip6Zrs8oOArN0rchc4c31uQAFwktZsQp0VGIe6QCx1vhTGyoDOOK9E
	hYMFcGRVTeQZn/coaSsVrs/9ixFaKuDVhtTRU9L+dywFgt76+AiuLB7dDY0oFsrGfFyTuuLBbV1
	UiNhUZ+UYTWwNhTPcmaoKgHYkQO0qfcRVdHYAAcu3dPUbfB441NonVxuD89E7tKiXI1atXRZlmM
	tLCkQyVj/6zvPM1Crb84ZPM6ZH349imTIFcEQu9oEWiR0wn1iJNTPcb0fzGnKtbEE+NxDMQZvgf
	qEB8FQJ8xEqc6RIsjdfeaa9NEYWjPz6xJRYBQq0E2QnVDkp6ScMtiycq/85uEr/FNLCuU4Hslx5
	+irE0nkmyVs/of8V4bqYHQm33AFeFNEh+yHwGYN6Dk2157BvPsp01wuASBhr8vTWU24gj+kw6a4
	yVOmD1vaXgJN0647a3/RyB0qbjI0D/Ir/tKtdu7dM/N0OnoV3MM/BZSWKUSA+vkED0+aC927OSH
	Hoj8c96IL5cOgjUFw==
X-Received: by 2002:a53:e317:0:b0:641:f5bc:697f with SMTP id 956f58d0204a3-64903b55f0amr1926052d50.75.1768420459571;
        Wed, 14 Jan 2026 11:54:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b241csm10884687d50.19.2026.01.14.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:19 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:18 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/18] midx: mark `get_midx_checksum()` arguments as const
Message-ID: <2e549ea6443e8c4189a7a1c1f59812f9cd22df74.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

To make clear that the function `get_midx_checksum()` does not do
anything to modify its argument, mark the MIDX pointer as const.

The following commit will rename this function altogether to make clear
that it returns the raw bytes of the checksum, not a hex-encoded copy of
it.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 2 +-
 midx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index b681b18fc19..4c90eb04c64 100644
--- a/midx.c
+++ b/midx.c
@@ -24,7 +24,7 @@ void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
 int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 			 const char *idx_name);
 
-const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
 {
 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
 }
diff --git a/midx.h b/midx.h
index 6e54d73503d..7c7e0b59121 100644
--- a/midx.h
+++ b/midx.h
@@ -85,7 +85,7 @@ struct multi_pack_index {
 #define MIDX_EXT_BITMAP "bitmap"
 #define MIDX_EXT_MIDX "midx"
 
-const unsigned char *get_midx_checksum(struct multi_pack_index *m);
+const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
 void get_midx_filename(struct odb_source *source, struct strbuf *out);
 void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
 			   const unsigned char *hash, const char *ext);
-- 
2.52.0.457.gb599f1ad4b0

