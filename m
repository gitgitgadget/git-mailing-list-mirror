Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B6821CFE0
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742424043; cv=none; b=TR8P59Y5xcwe6ljku/NuMHcrrkTGqS+Jz2nEftmqoh22sdbl7tdLYI8h5hoIwVJZZXOqMr4KFeoHOUprUmr4J3gPN3mhBVMj44nCURw9kQ1fyElpAwmLD8FD4w4MT0tYvY9w2KzLR/TVL22c9B36Q78vOfBQ+S19T5qxdg+4cvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742424043; c=relaxed/simple;
	bh=moqpLYnrHKhLCwNWpTWw427o8TtT04xY3mhAFump8IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvCC+7FRu2LQHxHP5Np7yJaqaP+EMnhZoG3GcW+i9sCN+oWf1HDSN/y68DW2oIt7vInZndOzYMKdqngVqB55GqWhZM0ciZurXfz7xyHLt1yijFKLkeZCzQVGcznT3na6tsNGzCPMtUCYwzS2/xBItGwlo+fUwzET+5ZO/oGiCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PGlKw1gO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PGlKw1gO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c54c52d8easo138098885a.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742424041; x=1743028841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8nWa+BirRIAxjYYWH/vIeGOn1TIzn6/i7wo/v46YdM=;
        b=PGlKw1gOjEfcgstGJa0uj3+u3C6oX+5PpjtYh5I9N+gR7a3JWX9RuUoQrTH3o0MMl0
         WVE5Ig4QpixfryulFHryKyHeBJZ0CsIfYml2n78tMALNY5uSbNdgIJ+hqrBMH9XRWHTM
         XZt550JRcmcRH16FT1vZtqWfytrtCgb5bzGY2bS9ie8ondkq/KhlyLWrTfGbtW1MsfUB
         mQDpchVs8QffNp05a2AIxjIeYquf3I9/gR0TrOmnkJTWWHE8wU4d1LLCjJhGe64iASj6
         zF9lHlinqLDq0s9wUkS5NZSIeEeKaMPKtL0F0BkEu3qGWpGRAgB6w0lSb18s6MVg5cyM
         uT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742424041; x=1743028841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8nWa+BirRIAxjYYWH/vIeGOn1TIzn6/i7wo/v46YdM=;
        b=X1+LgzsCUIbFdIBa1tXhdB7/j0q7+XnvVDY7YNfZMqF1+0NxH9PPk2PPayCWZf5iUY
         hXhr/yK2p87NKYmV8eLHcIEDLMe+vlFOZbGJuKkY4+RXEsbRUqnMvEJx9fLsT/AY18fM
         RXU41ZVTrR77YIh6K8qg72X9dtoCp8O2BPHdcDet750iWineI+yeb1joN20Mcy08/4a1
         p980tRPhbj9rJwAUFaN3KAH8I9FHZAox87YMDwNeO0qug4uPrGvKzTIFNYRusyr87TlX
         YnnpusBE+sl2UWHKd8Qka2ZGmt0DWdoh9SzkyidLNOjE9EbMPyME/Mw0mXfkZ7H2pyAY
         vlcw==
X-Gm-Message-State: AOJu0YyeBzmbze0PphE8UeeprDuUPR3+j1SSMIkpJqfL/jtagMUbNvO7
	vlesbpwVQo9eBmrFOD51tCd3rWDOB1o1VM0bQAKGFOiyL+Nf96+GGF0tcsue0IaJRbRmuBdL5+l
	YP88=
X-Gm-Gg: ASbGnctumOc+yPPTwpm3TojQDSDSmWRfn01L8Ps9er/BL8ZPKkkhRnQk4FqwAfsdYZ2
	omwizWcVkb/4XxVzYzEPDmh80FbWOj4q6nFdV15XVNjLMq7lA6G9GeulAU1sLUW4ll5HqXueGKU
	Rj/B9VSyYiXelCF3hzeQKQJ6zu2msx3S1mSKz4X0U7GI6A/jbOaqgxZCbVTymC0XMAXvHf02cXe
	Z4uKY85HpDkQGMWAiX73Yd83IaaetrDzyqeHm1YhGIHlel6cubnZYCYQjTq8Gn6nLcI3A/GhCCr
	Ir/0f8bLgO8nhnSZPV2Obf17FsqkVGuRTi39KD8c9i6ahCl303xft7UKPHu6S8+R4PGK8uzYuen
	P0UMIeVUf17gZc9ql
X-Google-Smtp-Source: AGHT+IFWiG6qcl0wXOiWvb1jsACFmeuvCQU8h2qbduc3xqSO20ABc9/O1IRTUs6NkLxhniEASldo1A==
X-Received: by 2002:a05:6214:dc3:b0:6ea:ee53:5751 with SMTP id 6a1803df08f44-6eb34a394f6mr22302626d6.21.1742424040928;
        Wed, 19 Mar 2025 15:40:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb28bc98b2sm14971856d6.107.2025.03.19.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:40:40 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:40:39 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/5] repack: begin combining cruft packs with
 `--combine-cruft-below-size`
Message-ID: <Z9tH5zbZ/eWC1e6p@nand.local>
References: <cover.1742252411.git.me@ttaylorr.com>
 <7f120c35e95dcf41282c87dc2d1b2640ecdc5d84.1742252411.git.me@ttaylorr.com>
 <xmqqh63q47zd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh63q47zd.fsf@gitster.g>

On Tue, Mar 18, 2025 at 09:30:14AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > @@ -81,6 +81,14 @@ to the new separate pack will be written.
> >  	`--max-pack-size` (if any) by default. See the documentation for
> >  	`--max-pack-size` for more details.
> >
> > +--combine-cruft-below-size=<n>::
> > +	When generating cruft packs without pruning, only repack
> > +	existing cruft packs whose size is strictly less than `<n>`.
> > +	Cruft packs whose size is greater than or equal to `<n>` are
> > +	left as-is and not repacked. Useful when you want to avoid
> > +	repacking large cruft pack(s) in repositories that have many
> > +	and/or large unreachable objects.
> > +
>
> Shared with existing entries in this file, but let's strive to make
> sure we explicitly mention units.  --max-cruft-size=<n> is explained
> to cramp below '<n>' bytes, which is great, --max-pack-size=<n> says
> it accepts k/m/g suffixes and its minimum size is 1 MiB, which is
> explicit enough hint that this is counted in bytes.  This new entry
> should hint that this is also counted in bytes.

Definitely an oversight on my part, I certainly agree with this
sentiment.

FWIW, '--max-cruft-size' no longer explicitly says "in bytes", but
mostly because it (a) doesn't describe `<n>` at all, because (b) it
refers readers to the documentation on `--max-pack-size`. No need to
cover it twice there.

Thanks,
Taylor
