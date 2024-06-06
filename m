Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214E13C69B
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715098; cv=none; b=JPLvSr9FAnPFUyWpYa9ZgCS06q3HbXMrvJT69POMtkS0ocOvrx2MJDGwXTm2+7KoljSG8EwKZI2CtV4/8PgyWX+HiiBb5tcyl8f6mDKPUaTiiCT+jMEmRJZJYPRRCW1xdA5fy842ROVD5PRSc981h6BVIXsB+1d09KTAbNdSM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715098; c=relaxed/simple;
	bh=GaWcuw/GtMJiNkkzeiniXl46oLK22OBHh5f0vhTNJ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHajEdAoPnv7aaZOlahd180RYX1NIU+gvrO9R0zxRT4CQX1R/5oAgpVGUqXMZKM58ItvCIEaHBcaHftksKVnrh94qEBPzr8/PpMynYStQr0OKil7vLXAueTcmrGuMuV4XeAkcotGZgwUKamWv4zJZxrzPeWrsq2L/VQTMv5CZnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jGKpPd9V; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jGKpPd9V"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7951e24db3bso84908285a.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715096; x=1718319896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kTlWimwQGMqq0Er0wME7lSQg8iz6k/KH6Kxn+SJg/Y=;
        b=jGKpPd9VzA11/QrsV7nZxNJyIG7IIh4BCvPsAAAyQ/6jdY0T8JxW3kP8Qlxn/TvDgV
         pK1FTOM2ZS9Ree1FWhyatY614bv3usg3lPaQEkqKukuFMyW0XncmWzFBRyN0n2rdmwTM
         poWRYN7h1uMqI0GyR949HmlOqb7xQ0AC2NCCaXk0LsenxEvEYxhCeldKJeDeiaRsmbja
         RHyImwQnOf6JDcJOp3glQVz59YEnoeh0sJL9VF6RnyRtaMCnMPoXy8c6um9l+8brTGo0
         c6yJC59VxkQHiV+Bt0QP2KsCuC0SpQ4GTHRvnnqX5h/6KBdLm8HDjdHCkp111pC9SgK7
         sLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715096; x=1718319896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kTlWimwQGMqq0Er0wME7lSQg8iz6k/KH6Kxn+SJg/Y=;
        b=mmGc/kJxBlpCEMnvQLCPlApX82sTNxYjltuKVmJhiJiIARcbi+voI4DTJr06jg/tkD
         H51Wz5DVMFfHMYAupM5y0dCnWy0bqtqTtNwCyHv7VsuKQ8JxletuBtK/MtZKDdDG9Qjb
         B2HxQzCRsPD/6mtdBGdZ2LKQ9TInIyFT6F9U5StDJM/HNnNTqtyxMnQAkq8AenpugCLi
         tLSlLPP2xHOPcG+PSDZdNJANxenN3kSs6s+9oXDw36AbwAIHLFzgLhNMD9AwsR8IacJQ
         CojgicTk8/m2V2z2aA707hrk6b5ofiBXUmXUAV+rKltogUJS8u3Pa+H1Uzb9sI7TztJe
         Ss4Q==
X-Gm-Message-State: AOJu0YziB+YlTTuDFi5lrLVPyPt2dgz5Hka54acgQxGjMoVo3abFfc19
	v5iATgnDE/AxDdfH3pqE7x3VXbF/5yVTIbcqoI+a1wQ68jrHRhIe6ANvaGLZF+05MosGMFmCiem
	M8ZE=
X-Google-Smtp-Source: AGHT+IFDQLKO/1qN8RKxhPU4QS+JQst6FFi8bakNMOhRy6NpUmCt6OzAYeKkgQx8H3kvW8aZu7kemg==
X-Received: by 2002:a05:622a:1792:b0:43a:4b3c:3a85 with SMTP id d75a77b69052e-44041a80fa6mr11920981cf.0.1717715095738;
        Thu, 06 Jun 2024 16:04:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44042fe10aasm1303441cf.15.2024.06.06.16.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:55 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/19] midx: teach `fill_midx_entry()` about incremental MIDXs
Message-ID: <984ca9dc2dbc1777586424243b8a6c1aeb565eec.1717715060.git.me@ttaylorr.com>
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

In a similar fashion as previous commits, teach the `fill_midx_entry()`
function to work in a incremental MIDX-aware fashion.

This function, unlike others which accept an index into either the
lexical order of objects or packs, takes in an object_id, and attempts
to fill a caller-provided 'struct pack_entry' with the remaining pieces
of information about that object from the MIDX.

The function uses `bsearch_midx()` which fills out the frame-local 'pos'
variable, recording the given object_id's lexical position within the
MIDX chain, if found (if no matching object ID was found, we'll return
immediately without filling out the `pack_entry` structure).

Once given that position, we jump back through the `->base_midx` pointer
to ensure that our `m` points at the MIDX layer which contains the given
object_id (and not an ancestor or descendant of it in the chain). Note
that we can drop the bounds check "if (pos >= m->num_objects)" because
`midx_for_object()` performs this check for us.

After that point, we only need to make two special considerations within
this function:

  - First, the pack_int_id returned to us by `nth_midxed_pack_int_id()`
    is a position in the concatenated lexical order of packs, so we must
    ensure that we subtract `m->num_packs_in_base` before accessing the
    MIDX-local `packs` array.

  - Second, we must avoid translating the `pos` back to a MIDX-local
    index, since we use it as an argument to `nth_midxed_offset()` which
    expects a position relative to the concatenated lexical order of
    objects.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index d351dbb7e0..c3802354e3 100644
--- a/midx.c
+++ b/midx.c
@@ -403,14 +403,12 @@ int fill_midx_entry(struct repository *r,
 	if (!bsearch_midx(oid, m, &pos))
 		return 0;
 
-	if (pos >= m->num_objects)
-		return 0;
-
+	midx_for_object(&m, pos);
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
 	if (prepare_midx_pack(r, m, pack_int_id))
 		return 0;
-	p = m->packs[pack_int_id];
+	p = m->packs[pack_int_id - m->num_packs_in_base];
 
 	/*
 	* We are about to tell the caller where they can locate the
-- 
2.45.2.437.gecb9450a0e

