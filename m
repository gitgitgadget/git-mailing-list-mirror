Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBA140364
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715082; cv=none; b=p38RlQiWmr28A8X5vu2MPtX9ipi/VHCrr0VN/pumM9PW7bAUIysSLZYmXsqu7OjbPFe39Q3DmIgEyyem+4FfLJECC5ZS29YOfEUGGn7Bxz3VW1AxkmT7tmpwqwmLkApVP3B8m1L7Dss1oB1cUfWuiDFwDDYNKvdZzoCAjFVHL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715082; c=relaxed/simple;
	bh=kmMeGIqJUXwb3X46dMrlMwaBvEhuH5d+I7M5n254914=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv3fl+Ox1imEfM6ftvB/OEsVhuiI3xGU2qc1QEF2WyT8llK44f4HyRkQs2ZPaJDx42C2hLyZ7eoU1NoY9znD9p7Brq97wbYyPRlQ/tSx5qFMBNoLcj6Ol7KK15gknjXND8fb8AU92iC5zzZ31x49LCPthWpcfN0vnTv3oSQmgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Pg3AqFjm; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Pg3AqFjm"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f938a7f492so771290a34.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715080; x=1718319880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNY0AS1hSrzf0C4LWgDRvNdiqZb4JuvAfrGShKK43sk=;
        b=Pg3AqFjmotI1Egzn4BSbA2MD9AGuFXuBS4zKglYpfdZ9uQSrKNGS8CWakGfU/ZbTOX
         nYLy9Fc0uzTP/OxSRDmaibV97Ggzlc8p/DhQdf+yNrIqjAzJsED/DGF53fszQ3Wbz2eY
         +yw4pvesvLjuLGi6FKAvLuHcJTUWUyUqpzRPhKlzl5chVlvhrwFZuFjRrCpklOKqFFuC
         Iuv0eR52wdjvJFFviVsl7gK8dupHJcPuIj24AL1MUAf9pkZ2ieGoiXJya+pWi4AnSfDF
         eXTMB3r2rgU2np8ftwNbEGSUSq3mWQ3i72s1xfPYbhCTIhJXw4A+kNI83d6kNU3Cf0gY
         tCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715080; x=1718319880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNY0AS1hSrzf0C4LWgDRvNdiqZb4JuvAfrGShKK43sk=;
        b=Sy5ZDjVtvSpRPd66QNUPWppVLbNrJAfG8THdIgb2k3YJhlgvg+pOQkU1NVN6Q+5GSn
         niwUcLI0JxQITuR6hRX1XW2SFDq+Iorw6Tj19XU0suDgpQAdr3LH7VHVAOc8icXZKkSb
         khiWvzjQUkC+GomHW4TmZmDFWadh4E2K7y6DrAPF9vuOKayOukpGyUY44Bk/7Rn5zsqA
         Bv76C//fUogJ/+4Jn7rD1WJsNmnrphVlVD2fbFm7/D6UaHFDyttryxr3E/NlVWVwiixZ
         19QRKiZWa6wW4IxdiCduFgIw5vXNVExq64TaMTe1AXjw2e4YO984ARTIfeyJn5Jgiaiu
         IlQA==
X-Gm-Message-State: AOJu0Yw5JzL1xBoSMyDsSI76x9rrS8riuqks79ad2cUmvo2nvLn9tr20
	5YLE3B0LT6e7EfcRREM4FUShAug1rPp2rSQNYR0GTdRAngChDplsAa2FCYqQIBBkoKCQ3iL1L2H
	iGYU=
X-Google-Smtp-Source: AGHT+IH+gJ8lCdEU3SQIIYqI18aMkCngKS+0f0fBeY6mZsjAOIdiw7REkR3HYAncBKL0oTWD0w2SIA==
X-Received: by 2002:a9d:7f8a:0:b0:6f9:4164:bb3c with SMTP id 46e09a7af769-6f957351a13mr796067a34.31.1717715080096;
        Thu, 06 Jun 2024 16:04:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b2277sm102689585a.79.2024.06.06.16.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/19] midx: teach `nth_midxed_object_oid()` about
 incremental MIDXs
Message-ID: <a10772585d5fa9dcfd6f5bf5ec6fa81154181144.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

The function `nth_midxed_object_oid()` returns the object ID for a given
object position in the MIDX lexicographic order.

Teach this function to instead operate over the concatenated
lexicographic order defined in an earlier step so that it is able to be
used with incremental MIDXs.

To do this, we need to both (a) adjust the bounds check for the given
'n', as well as record the MIDX-local position after chasing the
`->base_midx` pointer to find the MIDX which contains that object.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 7fa3a1a7f8..cfab7f8113 100644
--- a/midx.c
+++ b/midx.c
@@ -335,9 +335,11 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n)
 {
-	if (n >= m->num_objects)
+	if (n >= m->num_objects + m->num_objects_in_base)
 		return NULL;
 
+	n = midx_for_object(&m, n);
+
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n));
 	return oid;
 }
-- 
2.45.2.437.gecb9450a0e

