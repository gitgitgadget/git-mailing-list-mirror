Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18A221FCE
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474429; cv=none; b=tF8gMx8v9tjCbPJYtwO4AgzpYYbi93LC3VNSj1kr93FyJZLSpa/hOsOIYFwuwDk95HFfs1qzMF3xwbKuk+XELwNj9//2Z72uN4qgXfybKvoe/Z9X4O+YumO0YF6QM5LgaeQIZWNkuf2iKU14gDC/XizXWcAzCC1J28f3Y9fj7Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474429; c=relaxed/simple;
	bh=rerBZNnW8KqTZ3uomjUn4k4NrQOli4aejO1AH7SiwgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oor1fnw8pJhha2h3g2Pm1voo+TZsXxWXiPXcQCvVRoTX9BQgdjSTfLgbCrf0juskBiHcrG+j0g7kWflvrea3QFr8rw5YCl1S0OL4vY7WKaMqE/rZU0e/eYXc4V5KPttjQ9vxFl8qlC8hDFcqpZ2mJoFVE7FSZ7iV5nqqkOF3u5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LuKMZ62l; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LuKMZ62l"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70f86c9e3e7so3948727b3.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474427; x=1749079227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8Vfb0dXN62/pDIuPuvqfWcgEcffl61JpCLLIXEDZDI=;
        b=LuKMZ62lUPKY9Nvpr/LM/G4b5UjrOKyLgWesBDzwwgytoD2WLZEacepIFBk8QjxXgD
         EfeclKltU9+6WJ+m/CimYb0yQ0OPA1gGv4YG/Wdk0qjoPUYxuQ9KfU0/Ur0M5l3Rn6tv
         LkWqsaRzu9CkV/yr6a8g+T4E89XtZRqSRvai4p5/u0yCtAZLW15bcYr5KdCUTUsZEiHZ
         MBBlkZ5L/7ZRvW+tdwR3y3ri6rd9SwZQO37jGpa5V6FsWtfILp/q+6QuTU2qHmyYbk1p
         0PF2tIdzHZjyJ8XUcJZvtqQrJIwf1jIWHbTSMFFgWeIwxHTNxSiyUb9nirstVGzpnwae
         IF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474427; x=1749079227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Vfb0dXN62/pDIuPuvqfWcgEcffl61JpCLLIXEDZDI=;
        b=ii5xfPftCTydHSfjZLa8dCSn7+BALohrnATlRF4SrNI48xLczNB8hOb9RIg9HQS5fX
         chvuO2yl9p+ZQVUjubaK2DAyfQGAo2XR9EhHFH5iQyG3WsLwCxeUzebK45cwsdnR0o8n
         Mob7ZR4VsUJ8jRtPoHD2EjFD3aPK+GrW8Lj3vT38ha4KDXj4YEOG6RP3mz1Hfty5tmoA
         BRpcv5W3b5eJ27qNJnOTpHhWe8q833toD8S09sF7Yiq0yMCljLxu55/1AEINRfQNw6EP
         pCo5Sbx79vDd3Vo/Q5gcPbS0/JPFOm7pmj7d5TQ8eIntVqXzO0ttychzxqv6VVsf7fxP
         cQhQ==
X-Gm-Message-State: AOJu0Yw/EBIo1MSF/bLJe5MuFuUif7QDZxFQgL+FTTym66/uDm4couae
	7sJUx+nuHZlnDLY6SYpMzWOPbLjWCRnfZb9zJeUyzFObQRqdJhKEh+NwUIMsC9tQrK1+vAwM7IA
	Wx1dB
X-Gm-Gg: ASbGncuN7mdJ4id42pUv9tFagzQrVmcY3rDtOoq7kNLEQY0F7GTA5UAwMXUlpUlijqG
	ogbhGqxW9j6oDPvpchFKbBw3/3Zxf/CgW5nY2a5r3qPoar0Z5Ooab7mQYpBj68A8Rkg6daNmC1w
	NC+Y0uGYO3u2hlLnlj/X2S5tXsrcKmbgrQe4vZpP97dhsZ6IeWs1JmyCPOa+5EGK9MN2K7BYkS3
	rLdpapTG3KDPFqAMqmaPyrTi+maNO+/ugWut98Sk5w4aCzkT7PLVeJP0Eg3wA7QYgL0XBddzCpM
	A3gYHs6zG4/WTdgPkKyytiw3oa9nI396E1oTRxqQrcu68nTaiPs9t0f+Nfp2ryc86OaMlnqU/cH
	Cbfq51DcFTy0Tazer2zyUGb8=
X-Google-Smtp-Source: AGHT+IE4lX+8h2+dne5AY7zhSRxISxbFIHt6jS5dEW6PtfduR7X6s6CNn1uz6Y8qBhXLiLUQRioEKQ==
X-Received: by 2002:a05:690c:62c7:b0:70e:272c:95ae with SMTP id 00721157ae682-70f8b922532mr2048677b3.32.1748474426973;
        Wed, 28 May 2025 16:20:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ad26154sm347377b3.121.2025.05.28.16.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:26 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 6/9] pack-objects: fix typo in 'show_object_pack_hint()'
Message-ID: <0696fa17369c545cfa1bd92850ec252b217d897b.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 359f0c3c30..a68451c3d2 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3532,7 +3532,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * would typically pick up during a reachability traversal.
 	 *
 	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
-	 * here using a now in order to perhaps improve the delta selection
+	 * fields here in order to perhaps improve the delta selection
 	 * process.
 	 */
 	oe->hash = pack_name_hash_fn(name);
-- 
2.49.0.640.ga4de40e6a8

