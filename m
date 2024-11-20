Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C016EBEE
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142935; cv=none; b=ZSZrOLTL6LcozI47z1XadVIcbR78BqgD94mmIjCqF+3EvTn4VNUKSgJXoRURyR2n+iIFlAcbi26nzdUWxe5msptdTyjYNAu6sH7liuzmAAs1J/q+0TPrBqfzFs9Tl59NfbSS0nwd+Pq+o3KtQR9lKF3O8VGYmnvNNRzr4pvUumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142935; c=relaxed/simple;
	bh=xogCA/owl8sVE8ud8d4N+1Lgyj11ntCZsEYEw5zbNDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZYoEgt3YVn4DEVRIbaZiDd9Taoyr+LnRaDujSJxxXOJVRCCdT9DO3GcBPtvDogITEBvumd2l2eZlxBboOluz/gmSrRlBFHyX9KKlnR24KM023DsLt71skseey5TXEF0b9QlspMvda7RMq0K/LnrWn+27us3qAG4g5598cVK2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=tn4EXvsU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="tn4EXvsU"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eb0c2dda3cso2516967b3.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1732142933; x=1732747733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0s+GGVO+hefu8NQcYPzaLn7aMi4cLNXDbv7WzorIVYU=;
        b=tn4EXvsUETCkF1rbLuyKNqMFMzd5DarcFtwVbKYJyL5xwLFebFe5qn0lSmJnnE3LFS
         VOosrdjSaSndbuOCeHmV6oJ/98DF7osex9VYOQba0xKfklgWFi7B2Q0vk+KFJl57j5nq
         YkPTYV3n/X/v8nd3yAiejtBDwGndyazbfxpUhcStxnXNIoLSUoFoiJ3zlfCB7/mamOV0
         +L/cyBFtNr+Y+Y1owkbQNCeIBiR9mgDnb8ncfYziRVHVcRdN8B73OWhvSxakzEBHNI0j
         VOM1vJfK6BzPA+6Pc0pVB44qu0PiLjqNyHwdh0liduYpAmgJ+DT0SDZiHvkA4M6/9EgC
         odxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732142933; x=1732747733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s+GGVO+hefu8NQcYPzaLn7aMi4cLNXDbv7WzorIVYU=;
        b=i1g32qXbVhW7N61/zfdGyUtZlj5cte6bBa1DYHHJBqCUY5toeuvnffFAozIoiQlqQI
         DwYNqiPKdV6qJQKaumQc7unHeF9nUViI/yBSWYfCopCGdDC47yzp1Mju8uMvE69L1ha5
         GW2PG2YLu3dj8AahOcp6Y5D6UOMr0j9BN6IeijRkkzwKTJoHbk2vq4PJIMzI3vw4jLwY
         FENv0VVc8Go4g6xhNjpfukXiGl1UbtHYr4V87/1hQw199kWo82ibgbWh+Me4mtfZHqbN
         abVoOEixL//HsgXrQN23BmOGWAZrg3KPa/Sx6NENO/1+GslX66rXnINsgP2OHp+yvS5n
         1KkQ==
X-Gm-Message-State: AOJu0YzehKdV0cQTz1i0+cul+AGEQA6FUJO/f8oJnttY2m66PJ9r1S7H
	2Epng5nDiUv/fLYi/zAsZdysP3WxOfwvPFYxQplnWcGLoxJLp8641NphVmJSwTftlcj6Tx8Eg3R
	l
X-Gm-Gg: ASbGncs5ty6LPHpxHHeVQCA7/Jg2FSDoBhvoglPZ1u9atPi09IonqgJ6lHTUTskyzFm
	+/hB8VJoQsrXxLYU3Ka8TEs4tX+TYlMajGZwvgfcbAeFRULCmJW9oOsxFrV4UOcZk0b4F/8zbrV
	AGKOuvKgH8qQx5h0zOQ5SwP2LFre/y1F/xGiYSJADoVTQ3lHEFR44IWhZ0F636gO4Ol3ZgiPrl0
	9Kaai38dD9A95TjOB+zO3LfPNUoRTV7Msu8G6ti8DUo0kIIAod9r69wTD1zwLvF2FwiLlgd9V62
	u/eH5nEnEcL4TKmavCN1oQ==
X-Google-Smtp-Source: AGHT+IH2QTqRhfstjNmihnY0u6rAfHnYwwD4sD2ywMJdQAB9L+BeFQ3gmn2OugF6N40XYLE5yCelhw==
X-Received: by 2002:a05:690c:6c90:b0:6ea:66c4:2d08 with SMTP id 00721157ae682-6eebd0d4bfemr52920637b3.1.1732142933070;
        Wed, 20 Nov 2024 14:48:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7129a2e7sm24627107b3.28.2024.11.20.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 14:48:52 -0800 (PST)
Date: Wed, 20 Nov 2024 17:48:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH] packfile.c: remove unnecessary prepare_packed_git() call
Message-ID: <884ca9770d1fb1e84962b1f700b1ce4adce6321c.1732142889.git.me@ttaylorr.com>
References: <Zz5k9HsezqHEWTEm@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zz5k9HsezqHEWTEm@nand.local>

In 454ea2e4d7 (treewide: use get_all_packs, 2018-08-20) we converted
existing calls to both:

  - get_packed_git(), as well as
  - the_repository->objects->packed_git

, to instead use the new get_all_packs() function.

In the instance that this commit addresses, there was a preceding call
to prepare_packed_git(), which dates all the way back to 660c889e46
(sha1_file: add for_each iterators for loose and packed objects,
2014-10-15) when its caller (for_each_packed_object()) was first
introduced.

This call could have been removed in 454ea2e4d7, since get_all_packs()
itself calls prepare_packed_git(). But the translation in 454ea2e4d7 was
(to the best of my knowledge) a find-and-replace rather than inspecting
each individual caller.

Having an extra prepare_packed_git() call here is harmless, since it
will notice that we have already set the 'packed_git_initialized' field
and the call will be a noop. So we're only talking about a few dozen CPU
cycles to set up and tear down the stack frame.

But having a lone prepare_packed_git() call immediately before a call to
get_all_packs() confused me, so let's remove it as redundant to avoid
more confusion in the future.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 724ce8e977..5585075023 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2223,7 +2223,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;

-	prepare_packed_git(repo);
 	for (p = get_all_packs(repo); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;

base-commit: 78e4bc3efc49ee4c9ec1ce14117c2e7d99999234
--
This applies on top of Karthik's series, and was something small I
noticed while reading it.

2.47.0.237.gc601277f4c4
