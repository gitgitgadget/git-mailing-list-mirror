Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAE353AC
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 00:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133719; cv=none; b=RrHscCpLMWVgEbPjwFg5YXzS5QC+DGFez/UBpFuz3yG9kqFLFpY3V3+3JjeJzgrLO2yHijjixnjv6nhaXk9jRuY018ckC/E924ZzOZ175ZPTb9GbiG4sLq3pOmiUio4UpXY7BRlQMUSO98v2nr5764DcnGzds6oudM5GVwBTvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133719; c=relaxed/simple;
	bh=YI3b4nEE0O//o5biY3qHH7SKTuXs4cixNae/4RacGqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO3kpMmreqDsV2ZzstOZy4CFQz0KSRANvpLk2/EZxqwQlDijzHf2RLCDocdzNqVC5fbptLV8qJphnjWYKUXVybBQ9qxQzcbIGdOza7I/o1PLPCJOwtQXwfLiQq1B4OtIXFY4c8eJIR8PwNB6L6GVnlJ0mZu2jVVeXNVplDq2kBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TiqzMIkx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TiqzMIkx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fd9d9ae47cso8233417b3.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 16:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741133715; x=1741738515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsxs1v9icyEp2NARlc8fIcDct5S3bdxA9y9eKFy7eqo=;
        b=TiqzMIkxE4r6Jy6sq6yp8eD8HlBloKmRudwLclQTSjgs5oZRPx9kHkvRIFp5Qlj9UK
         zhXbBkS8KjGRdn+8cGNueC0NCpNZAboKKmBn0afsd1x7rI/bcCjLQd7XFPKQDJz8Achs
         I1CeRqExPjBkG72KqKmvfmKVklEtoHrzruA+aBSUynWOfgvIluZho8ASI0pmzEVdoNI+
         YLOTzpJRb3YGQGod1l0hhA8KLdHeKiOVGBGu3eW2Kpi3IAXirrrFSeE4murgZ+66mQnP
         ULPAVTnvHduOz2LCQOnA6S9G/S3rQJMLd9m7AlqoGJht/PPZV4UMYJ4fIT7ikusn2YZJ
         jGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133715; x=1741738515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsxs1v9icyEp2NARlc8fIcDct5S3bdxA9y9eKFy7eqo=;
        b=sStLRpvrRXCdCx6koQvgeMY4AkvgS9iEPaQLdaa0vmJb7XKufdIUBDkqPfLGy18TPM
         j0UpRs/hpJ5lCSX5vuYyhztXj8crDXSowOQWX46Z3aXcS4SRIQRevwWbZNuxy8HdqYn3
         3WM4XaXJ1ZVDHOKPqB7jmGMStauE5pXDFsYkD5zx6JQ7gIfuuBBc3VvEuGyr0GLHFVk1
         LnoSXrC4yTPrR9vCSwzPFHhIRWQtNBwZxq8ZL+XUN8HHUsPtvSuk/goAbV/D+XzevyY7
         gd1YK/WxqbCU+xWN0Lbkt6A8jjdff5uGn4lf0g7ZQ9jFQ5LhiTfLIl6BJYuTOD4siFvJ
         fAXA==
X-Gm-Message-State: AOJu0YxvHGNyG7hd33FIbZd8sAFqUZzcu/AnCAEBMQb2UlatwWnDoU0Q
	46tENLmfo6HVM2CY3XLVC/DyLm+SG2THpCn5jpWfK2ZOi/dO4JY+MsQDD6PulEe/8z1np4zYRmg
	m
X-Gm-Gg: ASbGncsB4EviSRthAOS/1iDVeAkAjdjn6A6fes6mU7JzkvyI0c1AZ4K/2ifC6141cWg
	9Grn3SD3yRsv2XcH/o+TYz4KwzdaqyHnt3JeVpaDglEHmEbQPnBDW4O01MbBcByvE3nvYW+HX/b
	d6ENZL388/80ZGuQG3O6H4WlBS0Mft16fmQYOM231yowX7M8378MFeolDP2xPPIOGHrx+tu8UCu
	3+5xiRK3RoK2sfzfuLuO8tikBU1TSj3I2v+DHHVlcv2xJrlpOY+mLSSEwo4cABbaXr7ERWTij5d
	izvkBY5BZDVLBXfvwtUhlpAivYr/638PEzH7OGO5AKzsDZh2fdka833Bqkj426b1bcLc8urUhbT
	Xpt6/OhAQH/VQwHCo
X-Google-Smtp-Source: AGHT+IHEEAa9aYiYyPytcsvLzhiT5gUDDbfLRFdUV2x4MhWTgRe08w7RwWQainXPZh4gPqO+izCJGw==
X-Received: by 2002:a05:690c:7207:b0:6fb:a4e6:7d52 with SMTP id 00721157ae682-6fda3192f66mr23872327b3.35.1741133715520;
        Tue, 04 Mar 2025 16:15:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3ca445a7sm26961677b3.37.2025.03.04.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:15:15 -0800 (PST)
Date: Tue, 4 Mar 2025 19:15:14 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/1] pack-objects: freshen objects with multi-cruft packs
Message-ID: <cover.1741133712.git.me@ttaylorr.com>
References: <cover.1740680964.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1740680964.git.me@ttaylorr.com>

This is a(nother) reroll of my series to fix a bug in freshening objects
with multiple cruft packs.

The only update since last time is that I dropped the first patch, after
Patrick astutely pointed out a flaw with the approach pursued there.
That flaw is why I wrote '--max-cruft-size' in what appeared to be a
convoluted fashion, but I couldn't remember my line of thinking at the
time.

As usual, there is a range-diff showing as much below. Thanks again,
Patrick, for catching what would be a very frustrating issue to deal
with later on ;-).

Taylor Blau (1):
  builtin/pack-objects.c: freshen objects from existing cruft packs

 builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
 packfile.c              |   3 +-
 packfile.h              |   2 +
 t/t7704-repack-cruft.sh |  63 +++++++++++++++++++++
 4 files changed, 168 insertions(+), 18 deletions(-)

Range-diff against v2:
1:  63ea9d4d00e < -:  ----------- builtin/repack.c: simplify cruft pack aggregation
2:  7ba9054701b = 1:  6e93471f9a8 builtin/pack-objects.c: freshen objects from existing cruft packs

base-commit: 08bdfd453584e489d5a551aecbdcb77584e1b958
-- 
2.49.0.rc0.1.g6e93471f9a8
