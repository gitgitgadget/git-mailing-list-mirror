Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48807386443
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992261; cv=none; b=P0M3toDEsnEavbD63Xtv+/WwGjSzz7xL+fBWlltNmlih8oOWyZv7baVPLiJOVk1ERSJXhcMSBSNpEts38xtEYpOoF2PuBqG//Z1o4nr2jPe7wb+IJd9Fcvd920tvs7zF8TZPE5Il3P5ZkocSUmnZ3t17cCF83BAnmA2lvmuisH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992261; c=relaxed/simple;
	bh=oIJnyCW180AK9SjUZig+IMT9aL3cBY0/B+w0iVq7L7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HArByq55WQW3a9CpKf+GtLXTjqSXS9zVN8aI9+Air35ePT9BkmabecX8x90kNcBgWeZYl3BP0r1znqUntbOEEvZVPNhyLFgS/+h9ZMRxJk1Spz2OJHof18i4Pc5uKyt/DCLLo4Y0dt9qF03V0E3FOtBL2TAE6jhMh3FA1YglKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1lSKJus; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1lSKJus"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b21f71613fso2756384b6e.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992259; x=1792597059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cx5LF9IU0DRBhUc1Qd8KuOs9DcDYu8sTLCspu+td/a8=;
        b=B1lSKJusFMTcvt5bG+ivI5qnTsHJ464vZoU6OZwYQtPU1LJjdZApBJPYI2Z14vxwRK
         g3nRW690o2lEpCX++uDEYJ26y6Ga9MqkcnpdekJ3zCc905Ln9GMGr4GFtdhYD/CXIzd6
         Yh93kPqP+ttgRFmgQKrHpnnIFNa3ikLbQK58ixHQG3z9vJfUdm4AU7ilC+aNTB67z2T9
         GVf0aCADntU14sZ1gEn4NX8DdZkoVH4bVc/yibSev4C7z21mFRgwxTKiuBZ9J0OA322Z
         tjuS/zdXAVRIUUO8By12b+XPA2eTtU3STyfApu6zTh0fTPMFFqTDWH0ogNKkgYa4qBbH
         BPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992259; x=1792597059;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cx5LF9IU0DRBhUc1Qd8KuOs9DcDYu8sTLCspu+td/a8=;
        b=gq7QiXNRCYM+iqZflki4qDw/Fh6usWxhBQkegQ0I1uIB3s8p+2ko05RJX1T9StoxTd
         32/pLcZKrjaKLGBn5Q22jP2TX2PDBtsxvX3dgyXOoDF4tf1zP/iOscqJWS5f3SQd3KoC
         bxIPiWN0alEDQpsT9thYMH9U8+0tjkbALpvPsXaspTpNfI1L26/EMiiIpvD5k0K1NUWX
         xtYVW1YgWRnuKO6vk+p710GOgvoCdko1/wmozsRg/uj+amiZ/lpEMrbSc9aMq9abEg8F
         8quhNqHdFkJevwhxLdW20FEbfAr5rnw3Atw9sATvt3l9N1f/MsPUDTh8TEDCYD/FeGol
         Jbfw==
X-Gm-Message-State: AFq9FYKdApEIqPTOD9renONrBUYYlO8vZxMyMh+nO3oAmPB6hIe42uz/
	Eus4ANOdRQFMZYzd9Y2+ptpNDOy97UIZI7RXrJGY0Svr5KNx15U3aFb4
X-Gm-Gg: AYBFou07bJXFs3bMVxUj5pvlwBcU9hsHBWIs1iiAQppkJmXmfzNsAVyAskprGwt6Ozy
	RKMUH4rAPEDwii37+6PZHRTI3rvvoNCZ4gOhdCM37u1/+MindCS8qZZjbsv4ItqqCnswQzWyhqh
	RtlfBcjP24k1bcv4BEoPeRdpAkkFU8SpKo9cWdyDAhhbu/+vvylw+bszSUPl5zZw3kMUkhvo8IT
	BJsEKCII9ZN6veRtOksOQ6w/66/3/xqjs1pLI5+yNla6dzHQRGJ6cUV9TtREhmrCphQgjfBv9hi
	tJCTVkurwh3lZOWVZqUOFGTVWZqTetjLcraGlmXaDmNF04d725GYQCwyhbWgNBap+b0q8GRq63j
	Y/75SaSUy5jfpP8APERyVHjie0PCSbeP4RULyd2TpyZmaFOnwU0G33uENxwta9TWUkaanMKe12x
	XJ1yDOuVo/1Caj9lbqDZP6MmGRkmebzeiVTWpYfr0aEoFUhXYlkE/FHzmXHjnrYeO3+7MZkpVKy
	ewcPmGw3+RLXqUciXnSYSKd
X-Received: by 2002:a05:6808:138c:b0:4e9:f6e3:1326 with SMTP id 5614622812f47-50c533ed125mr14766886b6e.47.1791992259062;
        Wed, 14 Oct 2026 08:37:39 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5283bc29ef6sm4149090b6e.18.2026.10.14.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:37:38 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:37:37 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 3/5] odb/source-files: make the second read an
 implementation detail
Message-ID: <as-g2QdXl2zJkNoO@denethor>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-3-b7030ff2b26f@pks.im>
 <as6al15q80dII-bk@denethor>
 <as8ne87RmBCl10ng@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as8ne87RmBCl10ng@pks.im>

On 26/10/14 08:55AM, Patrick Steinhardt wrote:
> On Tue, Oct 13, 2026 at 04:28:37PM -0500, Justin Tobler wrote:
> > On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > > Note that the "packed" source also used this flag to figure out whether
> > > it should try to surface an object via a packfile that should have the
> > > object as determined by a multi-pack index, but where the packfile has
> > > vanished. The multi-pack index is stale in that case, and that scenario
> > > should really only happen when the process is racing with a concurrent
> > > maintenance task.
> > > 
> > > This code is adapted to instead use `OBJECT_INFO_QUICK`, which means
> > > that the fallback may trigger on the first read already, but not in a
> > > case where callers know to handle false negatives already. In the worst
> > > case this could cause another scan through all packfiles covered by the
> > > multi-pack index. But that scan should be fast enough anyway, and it
> > > only triggers when we hit the race. So the effect thereof should be
> > > limited.
> > 
> > Would it be more correct to say that we are now using the absence of the
> > OBJECT_INFO_QUICK flag trigger the fallback?
> 
> I dunno. Whether we check for absence or presence, in either case we use
> the flag. So I'm inclined to leave this as-is as it starts to read a bit
> awkward otherwise.
> 
> Let me know in case you feel strongly though.

I don't feel too strongly either way. When I read it the first time, my
first thought was that we were using the OBJECT_INFO_QUICK flag to mean
the same thing as OBJECT_INFO_SECOND_READ which confused me. Then I
realized it was in fact the exact opposite.

> > > diff --git a/odb/source-files.c b/odb/source-files.c
> > > index 54235821d5..9788a5adf4 100644
> > > --- a/odb/source-files.c
> > > +++ b/odb/source-files.c
> > > @@ -444,6 +449,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
> > >  	}
> > >  
> > >  	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> > > +		if (retry)
> > > +			break;
> > 
> > IIUC, we don't need to bother checking the loose objects a second time
> > so we exit the look early.
> > 
> > Nit: Mostly just a style preference, but instead of entering the loop
> > just to break out early for retries, could we just return early prior
> > the loop starting? It looks like the rest of the function is skipped on
> > the second read anyways.
> 
> Yes. But I've got a follow-up patch series that has some fixes for how
> we reload alternates, and as part of that I'll start to iterate over
> loose object directories that have been added after re-reading
> ".git/objects/info/alternates". So this is a bit awkward right now, but
> makes the follow-up series a bit easier.

Ok, this sounds reasonable to me.

-Justin
