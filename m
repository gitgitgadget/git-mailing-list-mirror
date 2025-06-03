Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF50252903
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989388; cv=none; b=kFMBJX/YIOMowsyebEeYJ5bqLSlDL57I1ElHkxHYpEMWGv1bXvXiIZJ4f36FellMRXPGTA3UpHADtzpHynHc8erdoPYOuA6p10DO4ieei9H73uqV7b90QpdvAIZo4CB4gj8wWHXeSwCxPtsKe4cgDJPhlUOYEp3Lg0s7jexBw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989388; c=relaxed/simple;
	bh=Gn8b9OzesogqsHFR7iHQafsDhpVhkHhs7r6/PakHz/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXv3vlpFoLkvIqKm2zOoS1XhXo05rdsxzSGkzYBM8bpYdwhcjgIsWZSKtwLK7o7aXj/uZnlmox/tDer2uGKM8NHggNG3onqx2MVHNgZteDXQG/WXybAI5u6gdGvEOkv4cpFClNlARxbV9bXsJ+4DmTQwXPJUD5KhajLia+MGP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VWOjNo7m; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VWOjNo7m"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e812c817de0so3399337276.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748989385; x=1749594185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qx40CODAx7KPXzWGHpJnhFcvCtAzhm6MksWntkLfvEE=;
        b=VWOjNo7mthmlLtl+xKwhizo7YQzXRPcXWN0qcsbVQl7bHLbzA9dpsL9cKDKnOri+bW
         ROuxCstG4EvmWsRKEM9/BfQ/URsx1OUfAUFePHFTWR8o9jlYqPVNE2a2inA0ZZMVjWm9
         tkQ6E/mckYZRL9AhSDxU5mGC1biAfWiInXn4sfFIQvZ134n4rjcynnIFkX9zZenaH5qt
         cPlHAO2x9VMSs5V+PzYvu/Sh0yeW8yh7uJiEg/xAzPwzpNX+MX7Ze1Ha3tndsy8KWo0R
         X/Ddcz9Bj9VsDAJ+DOmF0QJoYZ2msOH9lJ5LxMp7s3R7egv1TgdIb0tfeGANCqJDaG7L
         wEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748989385; x=1749594185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx40CODAx7KPXzWGHpJnhFcvCtAzhm6MksWntkLfvEE=;
        b=ePWGRg7vrWtqivFPDDABHxDNrzSj1m5IzyhRFJ2A3qLfCy4vuj/AKCh8I7JYcA0bH3
         UeVMvlTDYxLlT6A4lONQ+82ifl8Eqs3+7D/loUkzwun0vRmtQw1QzlnqJRljjJS6KZ2x
         zJGyR7t+r2dS2OFcA/fHEVVKYkdgVgxW9lXMsamEpzL4bdg//tPS2J0QFSwJUwDEhYnk
         /byuyqomddCdSUus5MxAf3VZuSiStRU9BoJe5UTnygCYzZcVV/I6ubTmrcxVIZLM2vV7
         R2Pa4oq3To5J+hhzxtb+CtsRQlH2KAlHebyEkQl1BcyforPfKK7D2wb2m1KBGu08YZqm
         C2ng==
X-Gm-Message-State: AOJu0YyO8FB+NFU1B1trZF8O0uMMXFoLgzE9Icm+NWj9x44NYruMBjZK
	np5irpzTc7umqVn84dx+mqzewjJVoRwAuOC5O3iH6alR4xconmT2pfYr1/NxPnJUkpo=
X-Gm-Gg: ASbGncuiZeZhJvazVisWDa+0F1uHLHkngSUB9Klrgp+D+vLg6Ob5Igjisxxpvmec8cZ
	DB7eDsWiYNlIQhF/0ih3uXQKSrFrGlyqqxNMcX8n3E/V5YxK0Fg8SPmjl5w5cSf+taK2XS5eAQ8
	xAwkzaVb/sbdq+a8d++OskyCqa415FaX4pWDvZxZ2g0A+Mzxjw300Zb0Ru70vhVR8u8kE5zAp3o
	s0hgxCYT87TQQLueZSURNPkOwU06BAdoM3P/awV0rEPBCRRJTKk+c4EVkxJaCINrWevdLSlOVFV
	eowMxo3XapPW3zm89IBiB+l4uP5jtGYasux8RCS3Rz7M+WyuJtWA7l6SnoAe1z86Hmam0v93bxi
	cuuwgW5ocxhnwxrhqlu796LNkXiJ7UytUwQ==
X-Google-Smtp-Source: AGHT+IE2WZbnsAfCh/5jLARd9sBckMj6uRbmgzxzDcAt0HNppE7qkv7G6m8DBWyQrYlugLiRBbV/uw==
X-Received: by 2002:a05:6902:2b90:b0:e7f:f638:4a9e with SMTP id 3f1490d57ef6-e8179c59f52mr849869276.15.1748989385463;
        Tue, 03 Jun 2025 15:23:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8128d5a14bsm1848138276.35.2025.06.03.15.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:23:05 -0700 (PDT)
Date: Tue, 3 Jun 2025 18:23:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] midx: access pack names through
 `nth_midxed_pack_name()`
Message-ID: <aD91yE8rKkjwe3mf@nand.local>
References: <cover.1748198489.git.me@ttaylorr.com>
 <cover.1748473122.git.me@ttaylorr.com>
 <d3508d3cfbddb512dbca4c2177731fffb5827084.1748473122.git.me@ttaylorr.com>
 <xmqqmsavjg3s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsavjg3s.fsf@gitster.g>

On Thu, May 29, 2025 at 01:51:03PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Accessing a MIDX's 'pack_names' array is somewhat error-prone when
> > dealing with incremental MIDX chains, where the (global) pack_int_id for
> > some pack may differ from the containing layer's index for that pack.
> >
> > Introduce `nth_midxed_pack_name()` in an effort to reduce a common
> > source of errors by discouraging external callers from accessing a
> > layer's `pack_names` array directly.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  midx.c                    | 7 +++++++
> >  midx.h                    | 2 ++
> >  pack-bitmap.c             | 4 ++--
> >  t/helper/test-read-midx.c | 7 ++++---
> >  4 files changed, 15 insertions(+), 5 deletions(-)
>
> One thing I forgot to ask.  Should we expect that
>
> 	$ git grep -E -e '(\.|->)pack_names\['
>
> to give hits only from the implementation of nth_midxed_pack_name()?

I waffled on this a bit... and I think the answer is "almost". Certainly
callers outside of midx.c or midx-write.c should not be touching
"pack_names" directly.

But there are a couple of spots in midx-write.c that are really more
convenient to directly look at the pack_names array rather than going
through the accessor.

Thanks,
Taylor
