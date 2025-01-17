Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B1187550
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148727; cv=none; b=GMO1cRoOaG3i73++wLwlWux2nDZUHlgnH/HzQ+4azgAUHwR3zgBI7LQmdmpJI/cXJnFOsySpS3uBh/1Gg0QUZ2kyMNlRCed6IBnTc1e3ej+LLBl9U1vYOLxr2HHSA9egCkmjcHjxeTvzLoeQBt3mIztYbJWS9IIPAXixlqhR7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148727; c=relaxed/simple;
	bh=5gevh2JtGL80SUdQ4ZRW3gZHFporh5O+Pt8cNzC+2nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDY++/yJQ7K2UFC3sr0QkgmD2tasYebYsn2GQ0zWG64aEDiaJpRyuQi5K7Z++QOGvBIRCjebMPKy0V8i8NoB0+Xkk9ylM7TzaWC7QaobGUbZ1D/NqtzegMuBm/uc+r12fSe3hc4MzB7eqVtm5qETu2zBbxQ9LLG0rXK86tmllrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DX8ymNRJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DX8ymNRJ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e46ac799015so3551483276.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2025 13:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737148724; x=1737753524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJOL7mFPRBE0DOZjXJy4a340ywtxsWgOpXZclt4HCUI=;
        b=DX8ymNRJ5UvA7jyakHcPIrJzZWENsFXQemF6rrIhZEWY0a9kqtSoFjoYT1aqNubVlG
         hsIGgAAzHnfW4NnOkCSaIetCXeL7ofotRFu6wt5bpOVI+EdGYyEa5oQ+4o4VJ+alv6q/
         alWbVh/Buk98D6B1gKiim9sAD76O8qUsLja+/dG+jiuI+bd29RtYY6UUlU0TrHmVZ77n
         W2SCM5XnWfYe4aZptKv39UpBMp8qLI+USft3oNE6ijGJaOrCar5yvSZSGTkVdYLIIMhR
         5rKOLLbeBUUmRfHM8ZP66bkae3SvARvWBxeqLKZUhWq4BL6i3RQc/TBbbjLJrVcjjpFc
         dNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737148724; x=1737753524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJOL7mFPRBE0DOZjXJy4a340ywtxsWgOpXZclt4HCUI=;
        b=saaVHsxqZbnz3ggKYzvtL2mSkfArpEoWYKxvjJ5CWaS7q8SCZPC8yQf6d29ihJHvKK
         OnQqU1kVIAs3KP3VNFvysr+xyRY+QOlhPtAKX189BQPQqTCXQiZJHh4A/bbHqPaeQcu5
         qM8lHD0YN/RE213NZ8sZxu0Gk2CgfC07KzDwpT6otHcdf0UbFfgcDe8Ey/43bT3wZfaD
         KcVJHxgwzJppIIRCnuGCUP+yB3AnJfyRPw/ohH0uwLPorkz5LQDysYke2GRXbSH6h4nJ
         xGavfSidv/JQoD3b7MPef96l/stmeSONNHPPZAMNIlNBbh78mx6o5O/H7hi2lsgcjGVe
         XiTg==
X-Gm-Message-State: AOJu0Yx1IJq3J7H2+UZ8ovFuJoAo/oW2B3eEBaR065fClbLwgnszyx7f
	x9K4SUe9KBA0H7gCSCWTRWXUCvEqsLGGaRrcqUDMs5nCS3w6aKxsPpN3G6hu+K8=
X-Gm-Gg: ASbGncu0iolK5MjeLSsWrWlzXuyfhiEdiT1lYMIH3dx4OrcyI2rTLjHIK10momVHrV4
	Bj7S1c18+vs7KpCXqEw/gbODZ4VkiBrmKh01ZYjJpzaq+WUwGxvJpayS1LuzZlI8+UOepMR+RLh
	Do5d2hee8KJEeCeH5t+WGOgCRn3CztMA6qk7AfyD6K8ObuCPZwsMPfZi6TDhfgE8kcMVrdJTHuS
	s/VSMHyr8y9yTkk9VRn+FckowxQcg5PT2hM8/xmRUD+JMcsi9sgU9LewExyArcEsbR0hxwjwh4K
	f2hRuOL2a6S7gj0EWpFqUMisn/1y
X-Google-Smtp-Source: AGHT+IHpXvaLUY+w8gFDb5fbcjGCulbTPH7kHMaTqwBDPfP150z4hSktqQY3qR41AG+4fxQZHizbrg==
X-Received: by 2002:a05:690c:7345:b0:6ef:6536:bb96 with SMTP id 00721157ae682-6f6eb677215mr39343157b3.10.1737148723938;
        Fri, 17 Jan 2025 13:18:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63a7ef8sm5794257b3.17.2025.01.17.13.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 13:18:43 -0800 (PST)
Date: Fri, 17 Jan 2025 16:18:42 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 4/8] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <Z4rJMhEkbNfhQ4ua@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <99dcbe2e7165d96e3a9c025540995a75f74b2489.1736363652.git.me@ttaylorr.com>
 <Z4jyZCAwqOjZ-u2U@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4jyZCAwqOjZ-u2U@pks.im>

On Thu, Jan 16, 2025 at 12:49:56PM +0100, Patrick Steinhardt wrote:
> > we can instead write:
> >
> >     struct git_hash_algo *algop = the_hash_algo;
> >     if (unsafe)
> >       algop = unsafe_hash_algo(algop);
> >
> >     the_hash_algo->init_fn(...);
> >     the_hash_algo->update_fn(...);
> >     the_hash_algo->final_fn(...);
>
> This should all be `algop->init_fn(...)` and so on, right?

Most definitely :-).

> For what it's worth, this prompted me to have another look at my
> proposal to stop having to use the hash algo altogether for `update()`
> et al, and now have a version that works. It builds on top of your patch
> series, which still is a step into the right direction. So I'll send it
> once your series is being merged down.

Exciting! I'm looking forward to reviewing it.

Thanks,
Taylor
