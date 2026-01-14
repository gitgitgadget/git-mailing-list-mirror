Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DA3AEF28
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428252; cv=none; b=gLX/1QHNx1WwsJwvFh4t7572WhCcuxdsubQuBIf4C3IRD4PYqRCS+dbTkOlW+ar/jt8kjnM06/B2U7qp/+aBAfqhqrqFbgkbLWxhn3cQx7koHUooyO5VnRhlrxxZ4fNHyw01k0VisgZtvl9wLz9Udyapod9OTLVAKxIc4Rs8PJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428252; c=relaxed/simple;
	bh=grOs2tPo0i01KuY3s1R0tjLhhXiy1EMkLaEs/XoCyvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWftsh4IYs/jECFxahkqkeFJ5rMqWqx1UnK5H3TPCkYAjyvDPCML5RxvVgFzEl8uRdJPaVmlwBrLH2XeK6qq2OV/zBTRfapsuzWCBnIgA20+Wy/BND2+ye2lDlQdHuJgiwku2osuvgyA6lA3J0MOTd8l86pi9k/0rkS0i9BtsSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=C09JvlFd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="C09JvlFd"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8907ec50855so3379316d6.3
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 14:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768428239; x=1769033039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQc556nETx1+xEo+HXjDlHOz7wiyUQGfCkg5uQlVnQU=;
        b=C09JvlFdnpszYrO+Nk2HjQd4jkkVoN1FjafgPuHxvLcBQ1qV9naa6AEwXmjNFPXHDe
         wfQ9qxGgYSKl750t0Ul/f/TksTXt8UNqioiGXbw+7LH6A2Unhw1f7U2zxqXLNRviLdLe
         3znvFtSMHs7WhYwy7UPkRzyPoWg5JMnBcdrL0/FelLmbg5jx684DbW1TdOIM8IHfVs5H
         0ci+duf0EKFjwOJTh9gBDivSWktLQAmSlOOoa4WGd6umMz49JofRmuW6r+1+KCy4nIca
         RZU0Xmd4+8edl57oSvi83EGfWvF6BmDnSBhErHIJsMPZ5gwmvOPIW0zqyyJncHFLjMRz
         FOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428239; x=1769033039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQc556nETx1+xEo+HXjDlHOz7wiyUQGfCkg5uQlVnQU=;
        b=ZV7TCY3P/4+K+mXRMZqt4F3BB7BaRcY1GlEwLbyyb9bsmtYzOK/vUgeY/QuZSRjx0/
         ftwgsgP3fSu0OMx/mqfsdYSGWXwPl6PP30Krc6dUiIuBNd9PfAMRqq0SwRz1WWC9hmS1
         x/cVBDjwfFvbVea+2pUXEAA+1cSP9hgkipXcyNjhX+POl1P38pw5xQlxD7FZaBFqPQRz
         JG3Uxuqqhk3E0KB/kju9q7hWaKHQmo5gD3DcV/Luce6kUDjgBgux5pk5LxhCXLG0A3tg
         PWfF1V8pbQjmzLl+QJ89qF+UwYXuYjM56EVNZhPmnPJKV1EK7LX8SD1A1BoghJokehJ1
         I0UA==
X-Gm-Message-State: AOJu0Yz/WuqMOM5psV6Davasz7qrLWHOBe+Nxgi8vqIMePrK+e6iwucj
	8HA8Ony7P6Cg7XmimAkDDMNZnbzeXTvsxDZIF1CwiWappPuGXipEoe8UPy76R1g48ZQ=
X-Gm-Gg: AY/fxX5AgBwhUMsKxHjF/geH9waxR2xWfFbWWBITCDiQflBX7Ku1H43oO2GgpC2dtV1
	tOw79IJb+o0TlCtjWts8F+QnwWdq64J2TKfTSVic29YE268e4SyDchiiiah4AFjCdRDPl9GHs6B
	GwNGqaqK4AUG79zBptFTfcJ72QM62yYzAMoaLb9Zf45wtHNZmZ25q5ZvnuBZot6kkoLDjdopFee
	r5IuDxqt5gyOthuvweMYQ2BjjfC2xgUlfjqmMmboczV7czGiR+XzeFLLFbGd5Gd9aPWqSrbUgZk
	XTU969j+NT5D0Fiw4b6PhkzMDpFabIuw72o4fP17//qLw+C9ONqNZVgfME2Q4h47Z0wApZ/s8MQ
	e1UEytWJXVjqr0DekXFQur8h4oTcQiVXXcyGYRUV4FJPkhl4PE1lSSL4p0BO72iuKqJXMrpf5X6
	i7EQwlkmXj+jE3fcS5OJu00nH2FQCY+vCaRtzqV75KpDE2sKKFKqe7aAXblUdp233Q5tc4sX5B4
	6STXvpWsFDYwZdXyQ==
X-Received: by 2002:ad4:5946:0:b0:88f:e332:c009 with SMTP id 6a1803df08f44-8927431ad12mr54380406d6.12.1768428238650;
        Wed, 14 Jan 2026 14:03:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2a8fsm185678916d6.16.2026.01.14.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:03:58 -0800 (PST)
Date: Wed, 14 Jan 2026 17:03:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 11/18] git-compat-util.h: introduce `u32_add()`
Message-ID: <aWgSzI30k0BZfZ4Q@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <c0c1769464b1c8065c2cea59dfd85a1d37de9dd1.1768420450.git.me@ttaylorr.com>
 <xmqqpl7beugj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpl7beugj.fsf@gitster.g>

On Wed, Jan 14, 2026 at 01:49:00PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > A future commit will want to add two 32-bit unsigned values together
> > while checking for overflow. Introduce a variant of the u64_add()
> > function for operating on 32-bit inputs.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  git-compat-util.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index b0673d1a450..db62a6f25c5 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -641,6 +641,14 @@ static inline int cast_size_t_to_int(size_t a)
> >  	return (int)a;
> >  }
> >
> > +static inline uint32_t u32_add(uint32_t a, uint32_t b)
> > +{
> > +	if (unsigned_add_overflows(a, b))
> > +		die("uint32_t overflow: %"PRIuMAX" + %"PRIuMAX,
> > +		    (uintmax_t)a, (uintmax_t)b);
> > +	return a + b;
> > +}
>
> Neither this one, nor the original u64_add(), seem to me a
> particularly good API.
>
> When things might overflow, it is a given that we should give a
> controlled death rather than nonsense behaviour and/or corrupt
> output, but shouldn't the diagnosis message given to the end-user
> when we find an overflow be given at a bit higher layer?  At this
> level, you do not even know what quantities you are adding together
> *means*.  Even though your caller might be able to give a more
> intelligible message like "the number of packs to combine exceeds
> 2^32 that is too many".  But dying in these functions means the
> callers have no chance to do so.  The only thing the user sees is
> some code tried to add two u32 and overflowed---without any hint
> what these quantities were or what the addition was trying to
> compute.

I agree with your sentiment here. Let's avoid proliferating an API
pattern that encourages non-descriptive error message by dropping the
sole caller of u32_add() in this series with the following:

--- 8< ---
diff --git a/midx-write.c b/midx-write.c
index afa077a09cc..99e7116f4d0 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -990,7 +990,10 @@ static uint32_t compactible_packs_between(const struct multi_pack_index *from,

 	ASSERT(from && to);

-	nr = u32_add(to->num_packs, to->num_packs_in_base);
+	if (unsigned_add_overflows(to->num_packs, to->num_packs_in_base))
+		die(_("too many packs, unable to compact"));
+
+	nr = to->num_packs + to->num_packs_in_base;
 	if (nr < from->num_packs_in_base)
 		BUG("unexpected number of packs in base during compaction: "
 		    "%"PRIu32" < %"PRIu32, nr, from->num_packs_in_base);
--- >8 ---

As for removing u64_add(), that should be straightforward as well since
there is also a single caller. Let me know if you think that makes sense
to take up as part of this series, or if you would prefer it done
separately. I tend to prefer the latter, since the state after applying
the above is that we avoid adding any new callers.

Removing st_add() and st_mult(), on the other hand, will be much more
involved since they are extremely widely used by comparison.

Thanks,
Taylor
