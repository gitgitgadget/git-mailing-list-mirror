Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4015884B
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019892; cv=none; b=td+6a1+ld/e1YnXhguCK9JSKHxQXvOSE9KYucpYAcRUE4euYmwitqi3bcykNQLV7vRHUMeOppOsP2BAZsWK9FX9OH6AcbAcZwABXD8/nCSSXgvGFCjPeN3AR/xxYp0FVDW/E/trGbUK3DXrlEIXXdto7nd4ZBV1uqFxLTA2iU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019892; c=relaxed/simple;
	bh=Y23qGup9d3OFWnnbvdIMXiHejefv88ZHhno0r2w7kxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPW1SocnzCbFT7uvHuDMr5bgQp2KRLTH1hNAfUlmrYxAuSjDkGb2aQfHcVoBI0Q8hYt4Ied3UoStKsvZgVOhsxN+DnkPohCh6egPImbHdiZcG6RZNHXcMu0sGAv+HyOVS9OM8QTcrJgIiC5ppgr85/a/PlkP9gIdXfG4gEIoQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EH6Jah3J; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EH6Jah3J"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c8644aa3feso1614997b6e.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715019890; x=1715624690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM+taJZ93LcF1wO4Sx8cGV8xL+Nu2q4mDXm0EXyXF5s=;
        b=EH6Jah3JZBD9fjjMAiS4sRHDu/OlOS0trP8PIT27Y/lyDzDSBIVm/0f3+ZYs0QR9s2
         uj2ufA+pkpJyD80z8y+aOsjt1d9Al27dVqTuXgvvTHrstMUavFZrsQpU7A2ejiCsHzqx
         eIqoaRtPQ86XLi5r3xccO2wXIwot/VM12dlDVyaA153l5GUWJxvC6ZK5iL9ihv1R0uhW
         VAIpJ0o4WKRLGKRXJroY8wgpPMUTKvXgGmd4HXUNsOtzOTOpIK7ckvBFKydBbXhv52nm
         n4nFJrZt5xFrBJxU08wk+W0Rtxc5jD5coBVx5fLhP37psQqlYPvYAmGdra/Pxw8xjDSW
         biQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715019890; x=1715624690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM+taJZ93LcF1wO4Sx8cGV8xL+Nu2q4mDXm0EXyXF5s=;
        b=scOoiKqgaC0vIrwIL3lQFuXFKl9/qDYaXGAmI9mVPaZKZh5tUUz4EpFFFnfD+ATf5s
         6TghqKQWWTnMGSiceT5cgeQ1LlyB5jaLjpxpE6NHKioZLpeOeZrdPI56c0KngXVHd/aU
         G8/p6oQBToPaYDhAcjboIgbap/I1tBc3knx6ZuS2nNS9vYfJWUNNzza9DYu/CDplQ6KS
         +b8E1uUDtnDIvJ9rLy+JckUPzrGvdwOVLSunRDjw07oVEovGAd04fisGcRF0HJsLLqTC
         mRcjKH88TGEX4T2Ot7SKKcjwKPaPZKiQ2bBPT8Mozrmy9TBRCAX/lNbglCXXZ1eRA4pU
         VxyQ==
X-Gm-Message-State: AOJu0Yw9NVBRpMQoOGmL+p309ehfrNjLiz8vi6vwqFQuVgj/IoswrbRr
	qZDEby/tXacTU39eOicS6wZfgmcO3vXz3fuM/JUBVzoa7PXJGw5kxl92BPQx+eA=
X-Google-Smtp-Source: AGHT+IED/pYYQqLGB2lKii25HVi/Ow1MyI86s17B1x4OW3WhIra+ZVowC2QjR+jnBNi2zcxMhQ5Gxw==
X-Received: by 2002:a05:6808:ec6:b0:3c8:2bb4:2288 with SMTP id q6-20020a0568080ec600b003c82bb42288mr13582400oiv.2.1715019890163;
        Mon, 06 May 2024 11:24:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cx8-20020a056214188800b006a0fb776a77sm3943409qvb.137.2024.05.06.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:24:49 -0700 (PDT)
Date: Mon, 6 May 2024 14:24:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/23] pack-bitmap: move some initialization to
 `bitmap_writer_init()`
Message-ID: <ZjkgcKzruDu7Qbmt@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <3d7d930b1c5c4d122d8731ef0dc3fc90115573a2.1714422410.git.me@ttaylorr.com>
 <ZjjEkivTeqC0xn_q@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjjEkivTeqC0xn_q@tanuki>

On Mon, May 06, 2024 at 01:52:50PM +0200, Patrick Steinhardt wrote:
> On Mon, Apr 29, 2024 at 04:43:08PM -0400, Taylor Blau wrote:
> > The pack-bitmap-writer machinery uses a oidmap (backed by khash.h) to
> > map from commits selected for bitmaps (by OID) to a bitmapped_commit
> > structure (containing the bitmap itself, among other things like its XOR
> > offset, etc.)
> >
> > This map was initialized at the end of `bitmap_writer_build()`. New
> > entries are added in `pack-bitmap-write.c::store_selected()`, which is
> > called by the bitmap_builder machinery (which is responsible for
> > traversing history and generating the actual bitmaps).
> >
> > Reorganize when this field is initialized and when entries are added to
> > it so that we can quickly determine whether a commit is a candidate for
> > pseudo-merge selection, or not (since it was already selected to receive
> > a bitmap, and thus is ineligible for pseudo-merge inclusion).
>
> I feel like this last sentence here could use some more explanation as
> the restriction has never been explained before. Is this a strict
> requirement, or is this rather "It would be wasted anyway"?

Thanks, that's a great call out. I reworded this sentence to clarify
that it's redundant, but not a strict requirement. I think that's a
sufficient amount of detail to motivate the change, but not so much that
it distracts from the change at hand.

> > The changes are as follows:
> >
> >   - Introduce a new `bitmap_writer_init()` function which initializes
> >     the `writer.bitmaps` field (instead of waiting until the end of
> >     `bitmap_writer_build()`).
> >
> >   - Add map entries in `push_bitmapped_commit()` (which is called via
> >     `bitmap_writer_select_commits()`) with OID keys and NULL values to
> >     track whether or not we *expect* to write a bitmap for some given
> >     commit.
> >
> >   - Validate that a NULL entry is found matching the given key when we
> >     store a selected bitmap.
>
> It would be great if this refactoring went way further. Right now it's
> quite hard to verify whether the writer has really been initialized in
> all the right places because it is a global variable. Ideally, the whole
> interface should be refactored to take the writer as input instead,
> where `bitmap_writer_init()` would then initialize the local variables.
>
> That'd of course be a bigger refactoring and may or may not be a good
> fit for this patch series. But I'd very much love to see such a refactor
> as a follow-up series.

Yeah, I definitely agree here ;-). I will plan on doing this as a
follow-up to this series.

> [snip]
> > diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> > index c35bc81d00f..9bc41a9e145 100644
> > --- a/pack-bitmap-write.c
> > +++ b/pack-bitmap-write.c
> > @@ -46,6 +46,11 @@ struct bitmap_writer {
> >
> >  static struct bitmap_writer writer;
> >
> > +void bitmap_writer_init(struct repository *r)
> > +{
> > +	writer.bitmaps = kh_init_oid_map();
> > +}
>
> Given the other safety belts, do we also want to BUG here in case the
> bitmap has already been initialized?

Great suggestion, thanks.

Thanks,
Taylor
