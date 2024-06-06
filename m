Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04813DDA0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715112; cv=none; b=fW9XvVT+Vb2Oi8Y8MhiJCy4UMNU51/jb8IfI0AxVislcLpyWU24FJGtR7tHpPUh5J9T1GdZAndxXSK2EDmAZviReac6AHLA5oT7R1cZVtbQFa5mIgfDBT9h89ScvIN8NHHKHjuztA3uhuNCvPTg9NLX4Yk7AWdQWXbZdBHMJqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715112; c=relaxed/simple;
	bh=UO1scOQICroab+Xp3blihB9i14dE8VsRbdZM6aY0DLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdr4RDur0IbSACE8jlCKg6nhYFKLwOCWxE06HhquOvXgNAgPhspk0+XnL+RpbpjDTnt+SHOUuIEU69LzUfxTu3SgsME/Isn+IYWzVFt4LBBU8blXXz4Zd6UjmMQXewsljUVSCWquBoglthNmjJ5zOm+9CiSgdLs++TcrqnmxtGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pPDWtkWf; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pPDWtkWf"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7951713ba08so126263885a.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715109; x=1718319909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UG2JDNDcuB3SCaR3reBRe3n+CL4I4BcUSmoDVUVCNGc=;
        b=pPDWtkWffTFUNboNHD5I9mvMMfcXkzGjyc5Nq51CgUllgKlHrzMm3me74ztA/uiFia
         Nxx9VYdi1fPvPQyt20uJzqntt5aN/r7AKbSmJ5zRgISyyYNYHcdjXF3ulXtAZffF6aoS
         uOB4OXNKt7Rgf7om7g9Fc2OZFiWws2fU0Dqf72fxticA8qRwj5wTScVvnRYS8rz8hA79
         3uIHPrlgD+n9JFKXKXLPQuyb8jQKTI2tpRPzzaCO/L2TfZynC78vw8pqGIavFsYqCHsp
         KBMPJymmwg1ojArqd87vs72wI3Ie4JNWaij47GaR9dhZhJPs2fcmoYiITQch87/jUnKq
         463g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715109; x=1718319909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG2JDNDcuB3SCaR3reBRe3n+CL4I4BcUSmoDVUVCNGc=;
        b=jkJL9g04i3xCybLXuWlo+lqa7blQBYJfMs7OTQ0ei4ufWGOR80lMrS4ik0BGY0jIXn
         dzXbLa4iytVGAy09mz0q+yo1YiP3rT69xhbCBf/Q8VX8h95MAD/qB6tchl6U/4OkL/Pb
         kkCZd82b3hpIG0UiQKyUTKV3/MoTuvmLTsG8dmPPCSjo1LytOdHxIbyXuo+iNERgv0/v
         e82xmEt6tqWRgAa5UldKuTm5vwY8kRpKne67nmYOSBIOtk10QkcZJG9aLGj+BqALYdDy
         NZCuIfHq+J83koKLgsAe6F+6tEvgryGBempX+FpMaiJqGzhlacL0LiKTDHPxmvsvkMHd
         qaoQ==
X-Gm-Message-State: AOJu0Yz6xv3SL4fJFmTVjmOyl+5eL6nYTQ7jiNpNcaWCPWaa6tqCB3qg
	/Vf7TQfVtrs5P9YOLrwBTqpNoS0tqplMGhwiCeCGGRDbjoPXWA4SAlJlTMJO8wa6iF57mMeLmaG
	5TKA=
X-Google-Smtp-Source: AGHT+IFwb3hBLEPQnDwNeZGaH2WAyu6s8tPkZ0FNXxx3CYYVwQ1vGoxsLkQustjxNZYsXZklro7ixw==
X-Received: by 2002:a05:620a:235:b0:790:9817:309d with SMTP id af79cd13be357-7953af0d49fmr198551685a.9.1717715108873;
        Thu, 06 Jun 2024 16:05:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795330b7607sm103079585a.85.2024.06.06.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:05:08 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:05:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/19] midx: teach `midx_fanout_add_midx_fanout()` about
 incremental MIDXs
Message-ID: <e0e30adc6a0c625b372a4fea314b948e1e175eae.1717715060.git.me@ttaylorr.com>
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

The function `midx_fanout_add_midx_fanout()` is used to help construct
the fanout table when generating a MIDX by reusing data from an existing
MIDX.

Prepare this function to work with incremental MIDXs by making a few
changes:

  - The bounds checks need to be adjusted to start object lookups taking
    into account the number of objects in the previous MIDX layer (i.e.,
    by starting the lookups at position `m->num_objects_in_base` instead
    of position 0).

  - Likewise, the bounds checks need to end at `m->num_objects_in_base`
    objects after `m->num_objects`.

  - Finally, `midx_fanout_add_midx_fanout()` needs to recur on earlier
    MIDX layers when dealing with an incremental MIDX chain by calling
    itself when given a MIDX with a non-NULL `base_midx`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 55a6b63bac..b148ee443a 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -180,7 +180,7 @@ static int nth_midxed_pack_midx_entry(struct multi_pack_index *m,
 				      struct pack_midx_entry *e,
 				      uint32_t pos)
 {
-	if (pos >= m->num_objects)
+	if (pos >= m->num_objects + m->num_objects_in_base)
 		return 1;
 
 	nth_midxed_object_oid(&e->oid, m, pos);
@@ -231,12 +231,16 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 					uint32_t cur_fanout,
 					int preferred_pack)
 {
-	uint32_t start = 0, end;
+	uint32_t start = m->num_objects_in_base, end;
 	uint32_t cur_object;
 
+	if (m->base_midx)
+		midx_fanout_add_midx_fanout(fanout, m->base_midx, cur_fanout,
+					    preferred_pack);
+
 	if (cur_fanout)
-		start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
-	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
+		start += ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
+	end = m->num_objects_in_base + ntohl(m->chunk_oid_fanout[cur_fanout]);
 
 	for (cur_object = start; cur_object < end; cur_object++) {
 		if ((preferred_pack > -1) &&
-- 
2.45.2.437.gecb9450a0e

