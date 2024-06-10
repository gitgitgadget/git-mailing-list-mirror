Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374314F9C4
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050260; cv=none; b=qQKxOH/SYOIjt0TQArGKvUrv5UgI8PTcf2mtNEiAkqoEW5GrFh/frzDSgVdJqLJy6UsLgJCH6Sm3PKNinzmcyZq1UbgrMxNgQ9e4F/nl+Aa0e6m7oZzvIzkyy9GuaxL8rmaZDqY9ZcGKuVe7LOydamPjf6T/Cg6JQ57/7I8X4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050260; c=relaxed/simple;
	bh=eCvmPzYi7AadWtcxt4fXaOzcL7TAhhLNjxY2EuRPWrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkDvo7e70ZH/1743kkwiAExNHXFT5j6/V5KK7JNjvCpSKBt4QBsdOuDAdGCVMEDkaEFB3b03T3IeOPz14DiM5nZigHe/JqbtgRkm+FwihtDKTmvUGtLXr3LB/CEo+vonKyYwKooEEfQZmbTF8rzNmd2Y7yWYBddM43AwFWaEg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wuwCxzWg; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wuwCxzWg"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44055ca3103so12321451cf.3
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718050258; x=1718655058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jgnSMfBpjcPYzP5mgcB3+JIdc7hYesVmmxIf1BPeEo=;
        b=wuwCxzWgMs21V8KocFad5Q+V4lSWxYDX60j/unyMtt2154/JKvu9iawy7RE9KhQya5
         Wc1kIVAKB6MGS7uDW5bzd2P4JGe3kejrbjugojbY/F80phDUfZ1YeB9cbhtkvXxlzkDZ
         PuPrmUnLz35n88Yl9fQ0J+NpSqojYHzgS0k4HQJxxXDICj2imX+AiqhHC7k2E+tdJqyq
         wztxSZRBJa1V3vf0FCvj+RRmE29H+iEX0gfWfQgOey9CQ49pSiIRdB++fwctHFcLqGUF
         2S30mKPZzEWpSmAnZDc0nveIZf6CtUrT79sdtu5a437M94KG0AwFj+NCmjHNFrkQGGWn
         62Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050258; x=1718655058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jgnSMfBpjcPYzP5mgcB3+JIdc7hYesVmmxIf1BPeEo=;
        b=DuvUeatZB7WXfkDz2fEtemuKBTdM0uwLOSiHS02bh64niN5pqiaZ/uBjDPPAOgyO29
         zti0nWjPlz3nQq2q3fs2V8whLN2gIQymCUKgtH1QCsAREIRT2ma1K2Qq2arFFEXDVRez
         644IwLOta0o1nWqpzPVzLK7wj6E9+5KPtEjlglUzN3Dg3n+o5ltevVGQ/FD/j43EnnzC
         WxyWziUTxV+e6Gy9lgEswkQpG1/E5jT/J/P4C0ISF8Tp+tdkDjANiiTSRkP6aaF2GWpf
         jMmSGS9iFzia8oW2yzrLhUIuVn/0L5FVoYKr86gNCwNSdjz298vX90GZri4hqh/2emZ9
         M3uw==
X-Gm-Message-State: AOJu0Yzw5USkSfYAgPNKnGoLb6fqhr2ANmgXWm4FsAFoWZHz/uAlBPg7
	rIu4R6uv6JjN5fJOjTVEzAsSODuBOb3ZZw9msXhq6rzqWTs7A58BTmChhVZj3bLhVXsF3ZLYAYp
	gpzQ=
X-Google-Smtp-Source: AGHT+IFPF1LDwhPfSg8FrMyOFrppBD9etUbgywillGR5RS/Cink+JXZgN9If70xiMVRrzyo3jOLIAg==
X-Received: by 2002:a05:6214:4508:b0:6b0:7c5d:c0b1 with SMTP id 6a1803df08f44-6b07c5dc351mr50787336d6.0.1718050258070;
        Mon, 10 Jun 2024 13:10:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0601f3174sm38201936d6.93.2024.06.10.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:10:57 -0700 (PDT)
Date: Mon, 10 Jun 2024 16:10:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/3] pack-revindex.c: guard against out-of-bounds pack
 lookups
Message-ID: <dadcf96c06ffaf29abefc9adfc1450f399089549.1718050244.git.me@ttaylorr.com>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718050244.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718050244.git.me@ttaylorr.com>

The function midx_key_to_pack_pos() is a helper function used by
midx_to_pack_pos() and midx_pair_to_pack_pos() to translate a (pack,
offset) tuple into a position into the MIDX pseudo-pack order.

Ensure that the pack ID given to midx_pair_to_pack_pos() is bounded by
the number of packs within the MIDX to prevent, for instance,
uninitialized memory from being used as a pack ID.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index fc63aa76a2..93ffca7731 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -527,6 +527,9 @@ static int midx_key_to_pack_pos(struct multi_pack_index *m,
 {
 	uint32_t *found;
 
+	if (key->pack >= m->num_packs)
+		BUG("MIDX pack lookup out of bounds (%"PRIu32" >= %"PRIu32")",
+		    key->pack, m->num_packs);
 	/*
 	 * The preferred pack sorts first, so determine its identifier by
 	 * looking at the first object in pseudo-pack order.
-- 
2.45.2.447.g6b4ffca7ec.dirty
