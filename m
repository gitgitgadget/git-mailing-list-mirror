Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683336;
	b=4Ftyye8pre9r3Dt4I807W7hlociQq2xZHE86m5igPShaaLMhr9MWRwehCoD+UezGWywt
	 8sWBaAjAB8jjYNfES3x700j2cYiKZ6pbiG3AaJkD7amS/d9ylNmYDo4Sujvh5OgE2LTHz
	 L5Amzq9B1A93gcq1neJFwVdImoXaIeoqhz1FTOzBOi+vCB3rolFjTkkLoU6V2uIr8wfmB
	 O+naILw6K7vEfWEqZdzdzo7dCfTvyUDszPIAokmloY8egpZzpVvOcVRnMgKYxwqG18HKT
	 T8PiKTOmN46UPoO7kgrqJFccOx+nhRFYx/rWWZg766hYmRFMWZthPXC/kWrbpCx32dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S/40eBDXFPMDIWtN6unsvAZ6sHJNVwWisxgHIn5OUhU=;
	b=c0AwVP5rltkYtTsXtlH7IoxuvSY0cxzyqc29K/3VzP4trqoDuDj4HUBawCjeJilXj9Jl
	 zJC2xh8NyjYJwnay1Vt5YufL6xuHv5BNm3rC8q0pAUEhRjK8JqIv8pL39n0zufaaClufy
	 HyxpMDgMUcMZd45KMktnQZQpJRbLGVkm7qZ2af9c+FHh/dAH6VByYaBzraYzhG6K9I8us
	 yhrvPIcgK6qFmwbEnQyn5XOFrqByh7dZYPd7OdiTbSVnx8GzeJCVLULiK1vZZh9Rzpabi
	 J6nZ84fh4W6z17jjP1ZVRbYTS0xIMr/e9qgCQSLaNlEG+AeP4NDRhfOrUnyccJUaYGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F80BJlEZ;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B8606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F80BJlEZ
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6e560e00a86so1163129eaf.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683335; x=1793288135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S/40eBDXFPMDIWtN6unsvAZ6sHJNVwWisxgHIn5OUhU=;
        b=F80BJlEZHAoBjnDDBfcnStKqgFhcRK/8E9BhIpdaUYB20H+I2SxFTnReFwBX0/6z44
         rkn/lB4WbOyKdqWwRYdtu66q9bnUMGiBiWvrIG4erUUp051SXTetgBLClQvReshEpRrf
         ogALWC4JvzQI9CEC3sXVrRjqqOXxv1AWzOXIvH74J2bARPqr+8l4F1eWoSZgRAfFeTrY
         aRR8iizM3iTFVebLBBbi7FTWBVksDIP5Dq9/vn8+zLFn5e25xhjYnqwCztLnbuuqhlZ9
         tOatO/BmP6sZVAGyI4pH1CS01WMKFpRwBrGVE11ikUNCM1lQpoEr1MPc3ayqqZnDbJA6
         jLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683335; x=1793288135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S/40eBDXFPMDIWtN6unsvAZ6sHJNVwWisxgHIn5OUhU=;
        b=Th48YPkVOacUZ0jQ70n9LhEmV+zGUVI4X42d/vk3/xoh7ClWtgeAJH8vfJJxlV+kzD
         NVg0JILidgGjOE2+nvIy+ATRCvkNUoP/Wi5xayiu2DWDHWAHc/09NmiaC4k6JQJpRK9s
         9zKpjlh0OF0jWgz4XI3PqUbfFfnjEqjjPFE/bpBQZkk6Id5gvFJ3PyX14G+aXQu25ecv
         rVIjJ4Z2r2JYh6vY4bS1u5hwb0NQL/gWtR79MPaTnNrGIjHeg/uxjx5pXcJzBywsPk7W
         zleMSzq8AFWWwsQOss1g0SOzClKo7GlD6TL9OYzQe/PpqQEjsB+vydbDaskZ7d2UmeOB
         oj1g==
X-Forwarded-Encrypted: i=1; AKwUvBwlIWRrBG6xw5zmw3yQfoGrrWZMW6iUjXuUqgJ0TOhqDVWe6tPFkhV10P2TBry8SsiBLeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2jKh+PSImnXM8OVNUDgVVJXKrpQT90CD7FN4Qj9EduC3gMTqQ
	9orp2rcS5fChFX+YeVEs0bl0Gmf7vv0cLwTEHmKdz164Ih2hzv6zQ++ZNCRshg==
X-Gm-Gg: AYBFou1hz57aN7SZpt70SLOxe+nTX2secWd5K60mUdrYO47kb8OTzht38uazasz8LLz
	AAabtOE60vzaB1xGPJV999M32Pegq7NxvN48yfc6AfSAT5ewQ1j8kxqNwhrfkwQ2Bq7G1xiKBmI
	6F1VSQS7MDHmy/YCV89fmdc83MRp3cf3GWVBcuDD7r87//UNeMnGHuo861Oe+CGNQyZEohqWv8H
	IEAVeMnY1RamCxQGeFJVtAPNcI6IbJVabtyUnR9wUR66hqoJ9OmSw+CR+VP9vIytaGv0UHk/Dgq
	KToMgv5N0w2+wTrjE2sadu1lb3iyeobWec5RYuzbe3Dj2vq+VP8GoAaaABVy3lrvMAAjI3bvhSD
	D2Y3zi0yoD7UfQOrytqdp/ot7YhrFg686obmmTmnYBRFDytwKLf9cTvIbiuNjJ/AN8rksYKmD5a
	QyrTaGVTLiWndHZGthDJ+qXKa7wBRSPT5uM6n8TQQFwnD/BZxfAV6Vcsaqw1lvheKM7GDbnhZb9
	jAMpEJOQYlzyJtXKj1RZdHkO82M/wxxcW5Mc8ePQBlD5KXSym+zY701JGo7zmCSO8LiZF7XcTpn
	6fM/
X-Received: by 2002:a05:6820:151a:b0:6e2:3d8b:a01c with SMTP id 006d021491bc7-7093fcb38famr3553991eaf.19.1792683334690;
        Thu, 22 Oct 2026 08:35:34 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f78202a99sm28413a34.19.2026.10.22.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:35:34 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:35:31 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <atokQ8nPx2StLq_O@denethor>
References: <20261021200341.378978-1-emilyshaffer@google.com>
 <xmqqfqxylnct.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfqxylnct.fsf@gitster.g>

On 26/10/21 03:06PM, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> > +Voting Eligibility
> > +------------------
> > +
> > +Votes are welcome from contributors who have authored a commit which has been
> > +merged to next, or who have provided 2 or more code reviews, and who have not
> > +been banned from participation in the project. All eligible contributor votes
> > +are weighed equally, regardless of the overall number of contributions they
> > +have landed.
> 
> That is a fairly low bar to cross, especially the code review count,
> as it will not be easy to define and enforce some rule that rejects
> a response to a patch that only says "thanks, I like the feature
> this proposes" without reading any parts of the message.  

I also agree that the proposed eligibility requirements here seem quite
too low. From my point of view, ideally eligible voters would primarily
consist of individuals in the community that have both a vested and
current interest in the project. If an individual submitted a handful of
patches 15 years ago, but have not been involved in the community since,
should they still be eligible to vote? Maybe it would be worth
discussing whether contributions must have come from one of last X
releases in order to be considered eligible?

At the same time, if the requirements are too restrictive, the eligible
pool of voters may be significantly biased towards the most active
contributors which tend to work on Git for tech companies. That is not
to say this would inherrently effect how these individuals would vote,
but I worry it may not be entirely reflective of wider community
sentiment.

> As it is hard to track patches that as in 'next' a few release
> cycles ago without graduating in the end and the authors of such a
> patch should have the same voting power as those whose patch is in
> 'next' in the current cycle, I would suggest strongly against using
> 'next' as a yardstick.
> 
> I would have expected to see something like "two or more topics that
> appear in any released versions" instead.  Note that I said "topics"
> here and not "commits", so your topic that consists of 17-patch
> still counts as one.

I agree that counting topics in released versions seems better than an
commits in next.

-Justin
