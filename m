Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B911DE894
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806181; cv=none; b=ilqtggFmoDdEMCRJKg1xMgxZnNkFmKS3DViIcvb+gmctqRaPNIwCtOKifVjenqMFWptobLv64VmfUgQI3WeEOqpNqpbHKXptcBk/h2wPpuWsdfOuFCN1hWGsA1lcuMWHkRm6nXmiwd2aWwpdaVobn66KKTZ3WqdLaDY7yE2rjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806181; c=relaxed/simple;
	bh=um7/UJzvBQEYd1/Uudenc9jRnQlTVT4paUBoX/Z1ZsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3tgIP6pIWfWzBOaQ3usIf7Ge9TUt8/8PorqC3GFZG9MVQrd4x99ZKWHAI3GtY1FS4AOsXgrZ4FnT1t+7vmHM7Xj5YeLTeoi+XpCtE/shQerj/9E6WUOPD07v7BU8ih0F4XRUy/n1FJFhQy2vElGmKsqq/yLKRURromEwPfI/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KFPmerWm; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KFPmerWm"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60aef2711fso153877276.2
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741806178; x=1742410978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G1454M0Ew/2XsRu09iH9yd1xVZOilbW+ueFxGS6Fp34=;
        b=KFPmerWmDYl+ksexX82ynB4yHhUlKVCF+J1u4O71Rqq3GyksBlMBc5uIFDDHawJSo+
         AgMUkTg1Adse4Fiwr+JWSNPxjdnai824gvUoGXy/lqafwAGrebe99OhRSEae37LFpc1Z
         u3FHLYs9i3tU68RqgrVOWOLKj4aEsXO8EszxOKwQkV8B51oQmZ9Ggk1J49RahSXe7YOm
         TeKdUit4g7Su6VAbbctP6UXqZ/ZLwVFM0dZMg+KH+wjsg7L2DEBAg04pREWnglFHm7Pc
         HtFxB22/I3jiTzADRYpTj6BW4Yq+SXN23mNwxkRQK4P+8UDCN/fOgtxdmfEYPKYi9AtO
         yjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741806178; x=1742410978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1454M0Ew/2XsRu09iH9yd1xVZOilbW+ueFxGS6Fp34=;
        b=upg4e1LCGf3/UiFqEZoRzGN9y6asNoqLFxzCW5k3PyfrlTqx7PNkquF5XICO3POj7r
         IPCB3P8l2+0RlAybm8aRzFNG+UV3BuNbIzuz8mDXV/FJmrICqmoOsND3PMuVpCUwuQQl
         3bK+ubvwda9KIZsZ363ayoWSGROD/vtr0a5yt3rq1QIcZC8pRbM3c/ZRSYxIU7YK6vwh
         Y6+d0wOo3LDoReKNsCnzPFR48k+9xWLXxdkThbWAJK1VPMlC1JP+ssoDr3fMcyqACCy6
         xw62Pi+0JnzlUBBlf8rrJN4t8h2TQPqVyuw+0UCBR17WbBz5NZNf602JNkdwqFW0wZNC
         PEKg==
X-Gm-Message-State: AOJu0YzeU3NlQ4582EkdzADW2xsfLZoLZa1mEkkaCZFY4sq1krd9+DK/
	u1OxSq3wEnoBC8mfoDkn6Py3Aq8WFsAUexYPB9txcsqCNCnqDTdg4wUgsQYouE0=
X-Gm-Gg: ASbGncvRm+sDv2OAIOPTOXHR30brd9QigQhodRMNqX4fjRUKpx1xhtdeUKNn5fp/tAq
	Paldft2V8d9CZsaKgil2/xntkdTWrWgPYrQVDhTfJSHM3Jo7vnI2EK2O08FFCjj1jqfsj92Cz2Y
	MrKBEAshnMobBhmrawviHXLY7oMKxErL81OfbPKsglyEgyc++Uf+BhD22E97EwrXyAttphdZ4cX
	M5P5rq9YwmmjVk2VxxEt9Wfmd+B9FPkRWH4gVdZMVgWrelCmvX76RLgNxejlM1hU8uDoIbpvlBH
	2kez8nl3qGRv/8GgH2911V0HKOpMtAhBPOAmPlR+IuluSDxmtHxxJWEjy0d66UEGgn7QU1yqN61
	K+f08JH+oJwRDXBZiCwEnfzuR3ps=
X-Google-Smtp-Source: AGHT+IGy+tjaywd1X7i+CuuoV3hHUdLqEom4tBpbhZzGPKakbq8X/Ifc+i/BmPKVBDNN+/pXakUWjw==
X-Received: by 2002:a05:6902:154d:b0:e5d:dd0a:7fdb with SMTP id 3f1490d57ef6-e635c19566dmr32363792276.28.1741806178036;
        Wed, 12 Mar 2025 12:02:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e63d108f722sm280657276.0.2025.03.12.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:02:57 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:02:56 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/6] pack-objects: generate cruft packs at most one
 object over threshold
Message-ID: <Z9HaYEyYgBYTiia3@nand.local>
References: <cover.1740680964.git.me@ttaylorr.com>
 <cover.1741648467.git.me@ttaylorr.com>
 <f2ca92245ada74825806b50f786aab312275fd85.1741648467.git.me@ttaylorr.com>
 <xmqqikof2pqp.fsf@gitster.g>
 <Z9Gmo2P3Fnt3JeOs@nand.local>
 <xmqqjz8uxfyq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz8uxfyq.fsf@gitster.g>

On Wed, Mar 12, 2025 at 11:26:53AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> So would it be feasible to remember how 199MB cruft pack is lying in
> >> the object store (i.e. earlier we packed as much as possible), and
> >> add a logic that says "if there is nothing to expire out of this
> >> one, do not attempt to repack---this is fine as-is"?
> > .... So
> > the majority of packs in this case should all be removed, and the small
> > amount of cruft data remaining can be repacked into a small number of
> > packs relatively quickly.
>
> Given the above ...
>
> > Suppose you have a 100MB cruft limit, and there are two cruft packs in
> > the repository: one that is 99MB and another that is 1MB in size. Let's
> > suppose further that if you combine these two packs, the resulting pack
> > would be exactly 100MB in size.
> >
> > Today, repack will say, "I have two packs that sum together to be the
> > value of --max-cruft-size", and mark them both to be removed (and
> > replaced with the combined pack generated by pack-objects).
>
> ... yes, this logic to reach the above decision is exactly what I
> said is broken.  Is there no way to fix that?
>
> > But if the
> > combined pack is exactly 100MB, then pack-objects will break the pack
> > into two just before the 100MB limit, and we'll end up with the same two
> > packs we started with.
>
> If "the majority of packs should all be removed and remainder combined"
> you stated earlier is true, then this case falls in a tiny minority
> that we do not have to worry about, doesn't it?

Yeah, it is a niche case. But the more I think about it the more I see
it your way. I apologize for all of the back-and-forth here, this is
quite a tricky problem to think through (at least for me), so I
appreciate your patience.

The original implementation in repack was designed to aggregate smaller
cruft packs together first until the combined size exceeds the
threshold. So the above would all be true if no new unreachable objects
were ever added to the repository, but if another 1MB cruft pack
appears, then we would:

  - See the first 1MB pack, and decide we can repack it as it's under
    the 100MB threshold.

  - See the second 1MB pack, and repack it for the similar reasons (this
    time because 1+1<100, not 1<100).

  - See the 100MB pack, and refuse to repack it because the combined
    size of 102MB would be over the threshold.

So I think it's reasonable that if we keep the current behavior of
repacking the smaller ones first that this case is niche enough for me
to feel OK not worrying about it too much.

And, yes, breaking --max-pack-size when given with --cruft is ugly.

> > But in current Git we will keep repacking
> > the two together, only to generate the same two packs we started with
> > forever.
>
> Yes.  That is because the logic that decides these packs need to be
> broken and recombined is flawed.  Maybe it does not have sufficient
> information to decide that it is no use to attempt combining them,
> in which case leaving some more info to help the later invocation of
> repack to tell that it would be useless to attempt combining these
> packs when you do the initial repack would help, which was what I
> suggested.  You've thought about the issue much longer than I did,
> and would be able to come up with better ideas.

I think in the short term I came up with a worse idea than you would
have ;-).

Probably there is a way to improve this niche case as described above,
but I think the solution space is probably complicated enough that given
how narrow of a case it is that it's not worth introducing that much
complexity.

So I think at this point we should consider v3 to be the "good" version,
and discard this v4. I can re-send v3 as v5 if you'd like, or I can
avoid it if it would be redundant. Either is fine, just LMK.

Thanks,
Taylor
