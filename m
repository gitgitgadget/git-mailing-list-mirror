Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CFB3B6BF4
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667353; cv=none; b=JXdx2l9vKWqZEPJq0cM5RPMo4t5kPV39tnTspm5Z/s3iQExzwpIFjgwPAG3Pn1p09gwrELMHf3wBmxaw6mbXRWmabrNTokXWs1NKzw09ghq9cBcRbaocqhlHZGCWry664F+NE1KdJGSvdFBI8/bcLnzQ/5UdC2Cjo6MWPyzAkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667353; c=relaxed/simple;
	bh=BxAt+I/3k9c00ZZXoDMZLFbV4VQobrD51AGvKLGCfPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDAMJGsSFlz3Ap4PNyqUFTOg8HHtjCtWI4Vq0LHOmMFUa0xA90T07stPJKtrnNZUuGGwXBNlGRId+xZBzRWDrRhHwnfE6rqQRVeZrkYQPwdjP9lKCNFVUt0Wl5LG7rWSvV/5WAbSfRB2PsIM7X9SvuDnn1IPu1Z6i+YCuN7kcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R+GR6/lD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DpsJQIL2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R+GR6/lD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpsJQIL2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 982E3EC0187;
	Fri, 10 Jul 2026 03:09:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 03:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783667351; x=1783753751; bh=Np2J+2sFrN
	kEMb7G7cj8ZYLsvwseMj9pkiutj6BLCzg=; b=R+GR6/lDnPXOlvgLBMco2lgtd4
	AowDT4hg/0q0ZuPATRNUIk1MxnYefy75FvhaUYNDM8jiDMSrd5zrgtsz144O4aka
	71g5o1Vw1SipKS/tYbEGhzuthlEzw5SsHty32CG2/rdDsNM5/bQ+vQ9SCOVYiVDt
	q1V0nMobHnOFs6xTNvP1bzr6ZBnTn74NjoQ/zUOQTy1PwurZCXo6wrrEtVwGg83T
	nZUcQWp08qz2vs5VMIk2IeB3NUVJgC9TCKmkwiKxtdN3Y+payPvbbtB2RfmESlqV
	hUqMuqVXJ470sdt31J0A1cik/NcPX51BjrW9LnTqkf0f0ySyhPqb0XOiGMhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783667351; x=1783753751; bh=Np2J+2sFrNkEMb7G7cj8ZYLsvwseMj9pkiu
	tj6BLCzg=; b=DpsJQIL2U3wqI/PecU/0aRcx6GaoDiWrb838CxTbHJaHS5faKIV
	CftN8u82CQFsw/hm7Eez458qeE7u0KfmLJS692wE93CR1eAkrcBQfU5v1ol0WryS
	g+V9gM9HaQJNDurzM8AJMwQbTLDeKYI56TylATnaeOUOyAtZS8kgWDGKnh2u7vfX
	6JN5hQO+gI6+ziwo8CAwwavOsCaej6glXkU9OtEEyPe3IYrt9/I+pKIfmifZ8Rtf
	VILghEggORBoaypDszr9wy5uXadiSx4puGAg7eltn36WZwfuKJURk5ZstoApfhAo
	XBfEtwckWV8fQNhJErrsy33FFB/2w5xM89g==
X-ME-Sender: <xms:l5pQam4v_l64yb-lZeTNEG1uEGrTPUS3WfKIq-l1CtaPQxKOwVzIBg>
    <xme:l5pQal6l0sZ9u_nlU52_NoY0cdLDsIeZ9ROpEknQ13f3nJwfAqKU4iBtbjxiw4_7q
    81c0aLisTn-r2W7NhucCHVXoUVr99AGPH9yfU0lt5d_RLlfa7P1Ng>
X-ME-Received: <xmr:l5pQajHTMxMRl_v-1a42wv9YF1Y0ezI-kZrbdyGYMiUK4RZJiqx-HxDnG4Hh0-axYoB0UVWMQrpJNqzaNhvJw-ol8z8G6a0lwM0Whbh1vnBcaQ>
X-ME-Proxy-Cause: dmFkZTEGzWF0KumW2c+ke85oX0TErXRs9sqhW8ursPvJjv+whhfnVn3GAZczbwBG6Ays9X
    YucgkxvtFpJhiMajQeeOC1jFUVacskPLHdU0EI7R1tXz/jLkBV51LNuJfguqn8i/GsZ6JN
    SvmM5YX3du48dcK6cntyvi4AWMrXgRJpom6tv8SJKB1LaP1bk7n+CwOo2A+lP7/ZepUtef
    P0BnMVuyZQjp32LQ4EXVJTeniQF37BY8sYdAqNfdWDRt/GAdBpKT6b6GeIRhXS61bedCS8
    /lcvPzebmnYRGnYpXNfbRglNbhO+0bz9Tnv0NKfEKgiwEUNWpv9IfOLtxF6Scrqvm5iGT9
    6CpLgqfUQcXHt5edETuZ0FnB6AMIYVxC1BtfFtd6SyVR/8aXQuymr4QowFblxFPHgjEFsU
    QlXXZh4iJJpyt8jJpReGnMhGM0PCLZdAyX+EEAom3gSOIPiKGAspInD+d6L3bvzVJ3jcgf
    HDmZZHnYCYRD2CUiyXWxdn1ZHqhAPEh909EtqFNC4xPyjpe3ZRHv+ix17z4emNEfhjhan0
    2oYO2RxgMaI+r9o/jLAmPWM5Ig3Aa8Z6ydDJQoAwgjjCh6JGLCjaZP/V8J5XLUgJxcLLgq
    KyNPjOii1cRodPnkg9SxC0uhjgTqJOl4NftZ1HYkv2qb5jd7XP2bkYIw/Eyg
X-ME-Proxy: <xmx:l5pQauQ61RPpNNplUdo5i103MB3wJ5L8-dCR5KqZDlTvYzhQA0RxIg>
    <xmx:l5pQastoqfAnw2QqiaKCBCfgZp1njlCYZNW7Kob7_GZlubp6MS3APg>
    <xmx:l5pQatzrA-9WvuuUMLZbpbN1kNEMry2ZSxvf21P0BOuUEnx26ov-Bg>
    <xmx:l5pQam7H91y5fFabfMUIGVxa2cngs_ZJF64etPLNiIOMUCboKgA-Ww>
    <xmx:l5pQakrxtWwXxCjIb1lB9buaQ1Pk1I3f0V5QlRS56hKIUM6RRPLliGsx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 03:09:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25cf151b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 07:09:09 +0000 (UTC)
Date: Fri, 10 Jul 2026 09:09:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] odb: introduce object filters to
 `odb_for_each_object()`
Message-ID: <alCakwxxOc4FEEAv@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-6-82fe014b12b3@pks.im>
 <alATd_YS2d_l3CHq@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alATd_YS2d_l3CHq@denethor>

On Thu, Jul 09, 2026 at 04:43:58PM -0500, Justin Tobler wrote:
> On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> > The function `for_each_bitmapped_object()` can be used to iterate
> > through all objects covered by a bitmap. The benefit of this function is
> > that it allows the caller to efficiently handle some object filters. For
> > example, this can be used to filter out objects of a specific type with
> > some simple bitmap operations. But callers are currently required to
> > manually wire up the use of bitmaps though, and to do so they have to
> > reach into internals of a given object database source.
> > 
> > Introduce a new `struct odb_for_each_object_options::filter` field so
> > that the interface becomes generic. When set, then a backend may
> > optionally use the filter to skip some objects that it would have
> > otherwise yielded.
> > 
> > Note that the respective backends are free to ignore this field if they
> > cannot meaningfully optimize for a given filter, and consequently
> > callers need to verify whether they actually want the returned objects.
> > While annoying, we cannot easily lift this restriction anyway as the
> > object filter infrastructure supports some filters that cannot be
> > answered by the object database alone.
> 
> Huh, this feels rather awkward. So callers will always still have to
> ensure correctness by filtering the result a second time? IIUC, the idea
> is that the backend may be able to more efficiently process object
> filtering so we would want it to attempt the first pass.
> 
> Is there a subset of object filters that we should expect any backend to
> be able to answer? If so, maybe we should define a separate list of
> object filter options specific to this interface? Any filtering not
> supported would have to be deligated to the caller then.

It's a bit awkward, but it's also similar to how we handle this for
example in the reference backends with the exclude patterns. I don't
really think it makes sense to enforce that backends may only handle a
subset of object filters that we know the current backends support, as
that would artificially limit us.

For example, the "loose" backend already cannot efficiently handle many
of the filters that the "packed" backend can handle, like for example
filtering by type. So ultimately, the subset of filters that can be
handled efficiently by both backends is empty. And as the "files"
backend always combines both of these backends we wouldn't be able to
ever use the object filter at all there.

The same could be true for any future backend: we cannot assume how they
store their objects, so they might be able to efficiently handle filters
that the current backends cannot.

An alternative going forward could be to perform filtering of yielded
objects inside `odb_for_each_object()` itself so that it will filter out
any objects that the backends themselves couldn't filter efficiently.
But I'm not sure I want to go there as part of this series -- we only
have a single caller anyway that iterates with a filter, and that caller
already knows to manually filter references.

I'll add a bit of an explanation to the commit message.

Patrick
