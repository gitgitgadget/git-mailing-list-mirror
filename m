Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C713C832
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539282; cv=none; b=bYEk+qi74/A/sxYKQZU7yT/Eux05kpzzc0MOQRAKaJlPVKaCVQYr6uFTGCpB0sD3RM6s22e6zt2er35XfYj67eZva+dJVts01VDdFyXKobBZsqOhKcMT4Vx9swAILrGukRquzMMm/1oYApsuGfjEXIKzZcW7I2IWNUJCHAURzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539282; c=relaxed/simple;
	bh=UV52tFzUHAt5JpFtNQn56W6xL8+T1vEfcxgxC0Lug6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoJUPPbT+cMxpIpR7cgmaeIbhoGCLQnf+MGn5ByT67KKOrB7yoeiulkKv4vwVWIJ8S/b2eXyfS5L8ERCgSuljzn/ULbLMtPpT4elQ7rJppV/bgaAjdGR/eZXH2b5I3jb0AyykwDMAJGDwhmxi0XNxOaCTYjS6TDCYQE3TiAZAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BtcoL1Kv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BtcoL1Kv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-67682149265so61442537b3.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722539280; x=1723144080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oVVQWohNe6DtaznVSF4FasyyNXsqfYknW2Y3adTRX4=;
        b=BtcoL1KvdAh+DRBxU8BuecD7ex5PvofJdYaChdD4yQfy1Wo4fB+AnQIhJsTwXee3Wr
         g5HrSDfmDHYtJ1vyrg5ZqIx2b7SDajkbucayIiaO4avVuKRZoymRavC1w0B9V3FshUJf
         ee4SwHn/D/FzDLX/+uJFgqnFu1PtJd1mIeQBfrncPA94pFIasFLxWTcfdMRyrOfb4kEX
         cgy1FEuwljsmiGuHkYhOfKdeannItJx8gOZO51/dZUjX4FepUEVAjWRPuLxhOnxpQo0S
         QRxabguKywtaRxlMYHvY4kq7A0DrQFUvNMlPRIrVZgh/setsSQrjQ4bnZxgd2ZUIvt7y
         XitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539280; x=1723144080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oVVQWohNe6DtaznVSF4FasyyNXsqfYknW2Y3adTRX4=;
        b=pOBJ5n6m+jtVJkp/RmRFVxif2eMZ7h1Dve6Uk5/ve9PPieHj6ODsCWJsFfSljrLwvB
         oeDRHi+F7WVt0L6dUIcQDejjiX7ywnvAxW8WH+AfwM3Mch4kbwSml1FuMhePimCFVerk
         xKDp1YKGj+WasQYxlJ2slyZIN5TOXnXcDBJQUbzMdCHF0PQLyW21+LtvOB2RgYVYky7/
         mBU+scFD1X3yCG+oxfy2vLKnBvqU9hfxqW6bsvxbVN5AEmyoVphqZMIV71bQIVjFfMNs
         3rTkzT3WCKC2A+1IogA/IlJhty1uYC8dU8LneX5mqhfBc4OVGms0uh23PCnD+HXYD0kV
         gukA==
X-Gm-Message-State: AOJu0YxgFuoT3Bvl3z1MjZPTloXNJoMawM8luCUxpQWldoVEEAjjeBrJ
	hL4V6wg8kT6yD1B+IjDCYT529GDJzkGcHKq7VaBgKdeP5wxtSDvUh/iIh0hkwikjELYrJX187kd
	3
X-Google-Smtp-Source: AGHT+IEPvLgcrFPm2pK+j+KL5w9hfbwmdF7ha/iNURADWaBloZ1nVrhlnJu7enSfj+7b8A8R+ZUmgw==
X-Received: by 2002:a0d:dec1:0:b0:646:49de:5dfd with SMTP id 00721157ae682-68960873eb8mr11672567b3.25.1722539280313;
        Thu, 01 Aug 2024 12:08:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b05b9c2fsm495317b3.53.2024.08.01.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:07:59 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:07:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/19] midx: teach `nth_bitmapped_pack()` about
 incremental MIDXs
Message-ID: <ZqvdDkMZA8Yxcm/q@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <650b8c8c21b7e8a6e4f65d9b47185a875f0022bb.1721250704.git.me@ttaylorr.com>
 <20240801093947.GF1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801093947.GF1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 05:39:47AM -0400, Jeff King wrote:
> >  int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
> >  		       struct bitmapped_pack *bp, uint32_t pack_int_id)
> >  {
> > +	uint32_t local_pack_int_id = midx_for_pack(&m, pack_int_id);
> > +
>
> Heh, after the last one reused the "n" variable, now we are back to a
> separate local variable. Not wrong, but curious to go back and forth.

This one we care about having both, for a couple of reasons:
prepare_midx_pack() still expects us to have the global pack_int_id, and
just as well for bp->pack_int_id.

We could write this as:

    pack_int_id = midx_for_pack(&m, pack_int_id);
    if (prepare_midx_pack(r, m, pack_int_id + m->num_packs_in_base))
        return -1;

But I found it easier to have a separate local_-prefixed variable for
when referring to the MIDX-local pack identifier.

I'll add a short note in the commit message explaining why we took this
approach in this commit.

Thanks,
Taylor
