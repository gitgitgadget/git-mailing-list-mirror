Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB031A2547
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718393043; cv=none; b=mAxuYs/Ye8UBh7HJxQsYX8OXXWHuLSX4RCUouv/vYbbxDsTc0XV2sr+Skt2lPDQNKR0dB0QIwr4PP5KQgfOrsC2J8djc47TRcv4IwlFGW6Pdh9uyOKDGWIxzmOB0jP+r1lKqlq6uVgyRGpcWER03CD99Dcwpi+DApGNHSEKEcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718393043; c=relaxed/simple;
	bh=AQEXO7kL2aVHmSr9Jaz/0lh5mVYZjD+r/hA9+AVEpLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgH+5I7VXvmoYQKqu2G9MlUP+4w1T9qflH+onzCLIvvSbedpKo/8iGTaUSmMRcaf3eon0gfgspMpRmc0vevNYxYB7q+fgAar+dQa6KcaGBVJtI/jHMnaTHWlZEDGyfZ40wleTxIbovPj9zBu0qXcc/HrNgpgyswO/P3ofK1LIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=XRTxBQTY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="XRTxBQTY"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795482e114cso167587585a.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718393040; x=1718997840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sS7SfQXD3hvrlN3eHsEo9FqpaOakEK556a1CKHkShYc=;
        b=XRTxBQTYLJeiJp66A5hZ2+S0ifkJd1p0BeP3wIUq3if0xIwyP7L1mBkCEs2rk5PAjE
         DGzF3HDpTh+HFqG5Zv/6/sUTeM/OzsJde7t3P+rsrr1TpsuOQcIZBUqTCNiNBXFNS+J5
         UGlGwoEFHBMr0ddypQj0YwUj38pztqyxaHirCNCMyjCFk9QryvHk8qBkLy6X9Ij/X74Z
         MuFlbGdcfTneRb0W2R9IbM1vNuOl3Ge5A3cAxwDmsSUIpxOlXOjtpk/hLdytT4Dsctog
         b7qrahpDrE+5/WUb92CUrtlGw/yrT4NLsO2PtkEj8ufwJIKOzBO+MSu6qaGgdQZo7UEM
         3M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718393040; x=1718997840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS7SfQXD3hvrlN3eHsEo9FqpaOakEK556a1CKHkShYc=;
        b=C5nzW8rCo9X7zPjJnDU8WXz1R1crFCPWlmARHypYoPZ09aUBzufo1TIGETPVt9qHHU
         l8XaLkt/4wehq5c3E18ShSXwjvsfLJSmI8aWsNSamGI97GBsMe7/rzmyo3zAJDJiXGJV
         /AdPn53ZHPV7Zry2Jchw8HN0ZN9u8WyMVSUUGlJny2MaEBV/gIb1Op/yqYvWszflF4Gm
         Kj43VNwOgoSlxBu71i4yZbK+XJOElm88FRu8yF1x4ik9zWxyZBW4JAu/IJEK5yrfPF7a
         jFjfh0htzM/40/GoNRILVpVsR0TdhQFB71ASAZkyCBluaO/fIH4aP3AYNtzRoDvrq+M1
         SiHw==
X-Gm-Message-State: AOJu0YwZDqaRO+ZLC8nK+E9izrF7X9c6JeMjhf8Xhh/Zt9Rd6LhT97rC
	yLmv7cGberUxHRdhg1+u24wUSgkE8Ois7ode9GXd88bVvk2MBCqANp/lbGhVHEuM060GgcvhIt0
	5B+A=
X-Google-Smtp-Source: AGHT+IE5j4Obu9PEHTDb7WE+5JYd45nQ+ZSfQj5c4OTRnqkjHT9kzGQA+NqlFOCiuDpU1Y3riyLxcA==
X-Received: by 2002:a05:620a:1a27:b0:795:4836:33b with SMTP id af79cd13be357-798d2532090mr391393785a.35.1718393040093;
        Fri, 14 Jun 2024 12:24:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798aacb1c94sm173481885a.5.2024.06.14.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 12:23:59 -0700 (PDT)
Date: Fri, 14 Jun 2024 15:23:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/2] pack-bitmap.c: ensure pseudo-merge offset reads are
 bounded
Message-ID: <8abd564e7cbea8a3a165db86354d10a3f966d50f.1718392943.git.me@ttaylorr.com>
References: <a71ec05e5dc0c8c40e1cce14a7c5fe946437a24d.1717699237.git.me@ttaylorr.com>
 <cover.1718392943.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718392943.git.me@ttaylorr.com>

After reading the pseudo-merge extension's metadata table, we allocate
an array to store information about each pseudo-merge, including its
byte offset within the .bitmap file itself.

This is done like so:

    pseudo_merge_ofs = index_end - 24 -
            (index->pseudo_merges.nr * sizeof(uint64_t));
    for (i = 0; i < index->pseudo_merges.nr; i++) {
            index->pseudo_merges.v[i].at = get_be64(pseudo_merge_ofs);
            pseudo_merge_ofs += sizeof(uint64_t);
    }

But if the pseudo-merge table is corrupt, we'll keep calling get_be64()
past the end of the pseudo-merge extension, potentially reading off the
end of the mmap'd region.

Prevent this by ensuring that we have at least `table_size - 24` many
bytes available to read (adding 24 to the left-hand side of our
inequality to account for the length of the metadata component).

This is sufficient to prevent us from reading off the end of the
pseudo-merge extension, and ensures that all of the get_be64() calls
below are in bounds.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 70230e2647..ae13d7ee3b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -238,6 +238,11 @@ static int load_bitmap_header(struct bitmap_index *index)
 				index->pseudo_merges.commits_nr = get_be32(index_end - 20);
 				index->pseudo_merges.nr = get_be32(index_end - 24);
 
+				if (st_add(st_mult(index->pseudo_merges.nr,
+						   sizeof(uint64_t)),
+					   24) > table_size)
+					return error(_("corrupted bitmap index file, pseudo-merge table too short"));
+
 				CALLOC_ARRAY(index->pseudo_merges.v,
 					     index->pseudo_merges.nr);
 
-- 
2.45.0.33.g0a16399d14.dirty
