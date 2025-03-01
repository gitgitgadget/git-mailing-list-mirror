Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED8F9CB
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788530; cv=none; b=g+CCE4X+H3Zq71+3svXAbn7Kw0DF1yeKru631INCt0gYDaIIEVdnb2iZL9FN3EauMC3Ht12nDKzgla/XPhTj6M91HMQqAc1qrTEcHCeZ5d6c2nMKjpEY54QaLiPJAIMvG5X+8W9VHNan3S81/zMmoXjE5B7SJo+9sSITVfsqmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788530; c=relaxed/simple;
	bh=h97S5FUzwPqgch1fzAWK0qit8H3XhTFhkf/Gj1N3f2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Caf0/Tk4RkCaPCVE5efdI9hGqKk6ZOQiH73GcZxb/RqQ/AYHilgOKjWQjPMxikQdApXD7kt9al4BfMKUqjnzRrr/npotdS9O1SxQqxCOcUBF2saCmWeiLpftM7EejDv27YmuEs68w+ghbKgYBDLo1TFA+u7IgKNXANxmBX/bc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=np885Ww1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="np885Ww1"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e53c9035003so2120850276.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740788528; x=1741393328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gz9gyt5a8+Vqxo13lmXCum6OkGwHFDTpLpSA1/MfARM=;
        b=np885Ww1LjeZdxLdwkd5LEioYgD9n/AA3GkTjv+OGaG0qb5r8Xhg4FK5FG3egiFiZG
         +8aWV1e7xYamwPfA8v8uQALo1ELKsSJ95lXyTQLnBWkzWQEiWT6MCn+NiTcJKOBWul7K
         /Est4+bvBcCWZHIxf5CUV6C2FBDXwbobEmQj58TN5aNG1OFcCaOgUoegkZ/E3nPajymB
         xTIPkXheWw1baie8Y18tT0I5et4EadA4MaHknHiFctk4kSCTHT1nq3+1aV87Y02zKJ9X
         SXx/OR6jdBlLaZjRRyOpunvVUWjsrhxvCV2dr/xAvb2A1bJjoGjyrcOvwdaJmNrch1Ng
         XDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788528; x=1741393328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz9gyt5a8+Vqxo13lmXCum6OkGwHFDTpLpSA1/MfARM=;
        b=T7wcon4+BjbF7V8tKJhWcwDInoTdgV5VlW/n7RMzn14cZOJLElVYZeYtefwDSMhfAo
         SLZLIMfuIOmu/+7DMAp3+uM2qaBDyXTki2RdLcW0M/KOfP4Olg4XuT/iLB7WDu5Oo42F
         2p0GE2t86HjQXk/+D29p2k5JHFQoh9jrMm68HvsDGDDvwuQAbUnhxn0U5pGHlf5ifWXk
         +izyciH6a02GT+tu910pcTByxIS6KKrE8VixiWUtuboHLuCn1aimZwe6KtyVaz2297dV
         f9JR2QO70PmdDhSyBY0sZ/Ak1RHivcybzSyvsya2jvFgg/FMvWxCxioTxrfgMDo7Rf+X
         +3lg==
X-Gm-Message-State: AOJu0Yx7l2+ECXEx0tRj1Yh6fglMx/xpCwL3v4okU7/C5vgfTnGpdeRD
	Zjur/tTRzWdJkYLi5WOcYtv9EFIyH8FIbZNxz0GxHaTi6K2sYH1qEkfTd+0Uzck=
X-Gm-Gg: ASbGncvjJmTEhbahuNgKMi8fyC/J6sUFVqEy4tkeX5RuA98lSH3J/RAulUyHi3+ctfA
	UFU0KmJy/nZiz0Z1E9oOks8wwJ8GBitkMacn04ysDiBx/QEkPObE2uCILglDKxK3Mpg3V/d2lSc
	m+PLTZl8e1CPw9P8mx31H4n7uBkX6TS2uzZ9yOo5+90vJQP1opNwiQqulLPv5BuPce40C1krzLu
	Ut9TQ/etZN0/SMXOA7jkMhFS8cvegS/mznjDdYhY7IwVKM+Kfsk6TQ2UtX3hmtHvMQtV+wKgnPr
	PCKj4kVbnGZqdndZ6zZSE6XjmpfKzXPD1bpnHIaG5ajV6iuX8ZZZOVW8+OK74EVRXZafU+nawXP
	NUeX/DlvXfjJaxQOF
X-Google-Smtp-Source: AGHT+IFTSG0vlanw1yhe+j0HeCtohFZq5JWqHHZf2faAEYrM/5d88OPVrqOlNPSJJ7nvPnfjSHcrAg==
X-Received: by 2002:a05:6902:1502:b0:e5d:c798:146f with SMTP id 3f1490d57ef6-e60b2e91f9dmr6262971276.2.1740788528183;
        Fri, 28 Feb 2025 16:22:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3a42594sm1421645276.31.2025.02.28.16.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:22:07 -0800 (PST)
Date: Fri, 28 Feb 2025 19:22:06 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 10/13] ewah: implement `struct ewah_or_iterator`
Message-ID: <Z8JTLmgOQLNshnVS@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <e1b5f6181e38a526cee4bd1f08a397d88b776661.1732054032.git.me@ttaylorr.com>
 <Z8GJemN4K99BVT2J@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJemN4K99BVT2J@pks.im>

On Fri, Feb 28, 2025 at 11:01:30AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:47PM -0500, Taylor Blau wrote:
> > diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> > index 8785cbc54a8..b3a7ada0714 100644
> > --- a/ewah/ewah_bitmap.c
> > +++ b/ewah/ewah_bitmap.c
> > @@ -372,6 +372,39 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
> >  		read_new_rlw(it);
> >  }
> >
> > +void ewah_or_iterator_init(struct ewah_or_iterator *it,
> > +			   struct ewah_bitmap **parents, size_t nr)
> > +{
> > +	size_t i;
> > +
> > +	memset(it, 0, sizeof(*it));
> > +
> > +	ALLOC_ARRAY(it->its, nr);
> > +	for (i = 0; i < nr; i++)
> > +		ewah_iterator_init(&it->its[it->nr++], parents[i]);
> > +}
> > +
> > +int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *it)
> > +{
> > +	eword_t buf, out = 0;
> > +	size_t i;
> > +	int ret = 0;
> > +
> > +	for (i = 0; i < it->nr; i++)
> > +		if (ewah_iterator_next(&buf, &it->its[i])) {
> > +			out |= buf;
> > +			ret = 1;
> > +		}
> > +
> > +	*next = out;
> > +	return ret;
> > +}
>
> Yup, this looks rather straight-forward: we advance each of our
> subiterators and or their respective results into the accumulated result
> that we end up returning to the user.
>
> One thing that surprised me though is that we don't seem to be able to
> tell whether all of the iterators could be moved on to the next result
> or not. But I guess that makes sense: iterators of lower levels will
> cover less objects and will thus eventually be exhausted before the
> iterators on the higher levels.

Exactly. Conceptually each iterator ends with an infinite number of
zero'd bits, and indeed they are expected to be different lengths for
the reason you mention.

> > +void ewah_or_iterator_free(struct ewah_or_iterator *it)
> > +{
> > +	free(it->its);
> > +}
> > +
>
> This should be called `ewar_or_iterator_release()` because we don't
> releate `it`, as documented by our style guide.

Great call, thanks.

Thanks,
Taylor
