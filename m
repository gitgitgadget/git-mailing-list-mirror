Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EF38FA1
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958657; cv=none; b=UiK0vPWO6STYORqnqKzJfE5B+5SndBfCk4l8eTvW0lXRiVCkd3y0SD4Yg14hcZFjSLgVPwGPMq1EGwR3ySvfwWQHer4RE9ez5W4amrQyvpxZnDRHG2prJIMn6H1FbMRVq1Ihf6IjHv9cTjj/Wa+rtkQfXr+gnktr1ykIe6vRsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958657; c=relaxed/simple;
	bh=xyPhpEP5dPyf3X6sGmGSrgVn88wCTTm8nh5XG6FHn0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EK6zhProfujY5Y8FWyoK2IZuZb5pom2GAPqkRim/cdQ6F3If/x4hKh8hnGaDRfQ3fcIMCjvEbWaG//h9E3tPfC33/ekzvu1LoJLRm/FfdWQdX/ViLCqBZHxcAjJEQqq8U67tXgIXl4L28Byjgud5fyxo2dy6cI1VYdUXKHJVGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FYHSQKNK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FYHSQKNK"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690ad83d4d7so7434267b3.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958655; x=1723563455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYdP9CgGzHuHysAZLia1dFD2NJ3efZo7Gdh3krm5+Es=;
        b=FYHSQKNK/51LEbrBkRaJhAaoXMI+I8NzXiyUicy+HwYZJaEmoF/Gipb36thr/sefHl
         edzxDO1lljT1SUNXhaQG+vI0mnk5QPPVsSMHRa/f6kF6jQAUhAVzh7nAHkbSNmveAQUP
         lJH7mvdW0j6qXATNrCN9fGYSkET+8xE/5drFBBkzv4ifAmezBdfEU8fyy+lJ2PkX7ukB
         c9lrVCHasHYntvTBPEi1ucG2fMz5PZoIW9TLL5XUSPXNTG56W+V5ZIt81YCrKLjZVuGd
         ysAFUWhm9OpmesX6lbg3uQDHAcf5QWZ6GIYvSYeCY+y/JdI16m2UuYVLotGbSevMEIl+
         ehXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958655; x=1723563455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYdP9CgGzHuHysAZLia1dFD2NJ3efZo7Gdh3krm5+Es=;
        b=iKOe89yCupGHLdejkGipGc5gOqzNGOMliFn1E0h0EO8lFLKy6ZgjnZWPD8q1H8nQjr
         rTqNCE4xZBAPWdFeKx0lP1Fzzl/GGrcqrGfcAu6+Zx4G4IhfqgMTgZw8BOJSdeVe5Dtg
         sAwphSSO8aN+YWPcnWnfdWNq5cznTqfSCf85BDaTnNmCV+ScWSTTxE6WWLNWveFAShNM
         qq7HcbnlWC9nJ62RxXKZBjDhMPpsz6coZUkkeG7aCx1RbLr3/ItxQ+Ek1yCFA+8du3OF
         qBD4B0JPWF5AOiLmMt5hpiCP7JcGjRPkxryCjcAbxocAt0bSbH25isHirigzyg6rD8O7
         7Ckw==
X-Gm-Message-State: AOJu0Yz6rYKxzPr/LtiiXpXWfxJJyj3VASHm13B8i1IuzI8gky6Gd6ak
	FcolET6qhqLw8BCC2m3mvFldHOfLaw1Abkwc3tO9YYBHDPv9sctyzct5iqJqkvmAzKXrtlcewT1
	3
X-Google-Smtp-Source: AGHT+IEzRVJlwj/ZVDx/4lfNL8gcS03Wcbo1/PxYZBwCf1dWpmcJrNxH2NieBfKAaDNdwAICl9wyEA==
X-Received: by 2002:a81:7702:0:b0:65f:dfd9:b23d with SMTP id 00721157ae682-689601af052mr180247987b3.17.1722958655370;
        Tue, 06 Aug 2024 08:37:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b4b37sm15761247b3.130.2024.08.06.08.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:34 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/19] midx: teach `bsearch_midx()` about incremental MIDXs
Message-ID: <16db6c98cecb103c9c4aae263dc8b9071be2caea.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

Now that the special cases callers of `bsearch_midx()` have been dealt
with, teach `bsearch_midx()` to handle incremental MIDX chains.

The incremental MIDX-aware version of `bsearch_midx()` works by
repeatedly searching for a given OID in each layer along the
`->base_midx` pointer, stopping either when an exact match is found, or
the end of the chain is reached.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index bd6e3f26c9..83857cbd1e 100644
--- a/midx.c
+++ b/midx.c
@@ -344,7 +344,10 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
 		 uint32_t *result)
 {
-		return bsearch_one_midx(oid, m, result);
+	for (; m; m = m->base_midx)
+		if (bsearch_one_midx(oid, m, result))
+			return 1;
+	return 0;
 }
 
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
-- 
2.46.0.46.g406f326d27.dirty

