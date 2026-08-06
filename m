Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583C175A5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996180; cv=none; b=Kdvs3W1BTS129ANFKBLpvJqLlZfR0FusZgiLhYtW7434GIzcM9Afy2Cc4v3+hvTYr42af10OjUWnD/qtOcC+W6/Iikd70CP3EOami9phBcQmhW6H3dJLM6cwZ88S0QZii2b7eIyOZV8alaTTaahe3m6clllSf3irwjVCNdwZV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996180; c=relaxed/simple;
	bh=5pvIkkd60cXMY1VYtHyyjXF2iALDXwjrAYswokcxfk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzIg+OO1lHjuO83mpZ7GfPMJez+xUdLrgU4wFvM2xtZKsS9Wq6NpcvmcKPhkPGpPs1Ev0zQeDD3wsp6KHs/rs0oZB9dMkEbaY2MS/F7zbm6jDAJHX4o1sFotRpGwA9cXU33lmJj0FNW8Qm9VIlsWdRAbwVp2SvTDmbMcmoFk2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X6ibp4EH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hv21tItj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X6ibp4EH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hv21tItj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0C2407A0159;
	Thu,  6 Aug 2026 02:02:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 06 Aug 2026 02:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785996177; x=1786082577; bh=0IsCTN7k2J
	qthT9fL7hXYIBs/nx/IQEHnRvuQ3KMs8I=; b=X6ibp4EHSl34fyrL4NB3uEyep4
	6cvoE4xvRgtRdIPtI/+w5I7lxdyFC3AiJLCqCNM4R74M+j3Rs+s8VgyAl9u7RXe8
	5YhLMrj0kEqOrJds7qzizKtCvPhk3xpTi3X4SrLCAAkDEiGT9kkSJPj6NOKrnlpA
	sg5sBeIgzaOuIF2WMOCCtPOOFQyjP0QkyHWcZPptc6SjgLKibs4HRtpEOr+YZ5XY
	fx5MAsKMEoe9jHaCjzb5YwSlRUOwxs/4ktvg/vFy3A34FNYatBcw46T7axJ266pU
	R8YEOYt1c2yJTBLAlJY5fBruUzlyfKWW4wf+unu2wUE31z1/79x2RyWCWqBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785996177; x=1786082577; bh=0IsCTN7k2JqthT9fL7hXYIBs/nx/IQEHnRv
	uQ3KMs8I=; b=Hv21tItj7uZrYz5r4PWg43eMtpLuvyHumsn8cdxa1Vx0svOP2aZ
	cFUaVy4sENN+59nvJlPFayC6yO+R96gRNYUUr/iVMmm9H0cYAqkD17D8QKXK/3ym
	KfWTkUR5/xQQPHEJz+2TTDUyKQTwQgZKJlEpONMRkPcctlDLgS+rEo9P2Kg03f9d
	x82AOu/UCKZl494Khr63TlaYHic5SwueAOK6j2YrQ6NR6vAhiqnwKHdRnYPKu54H
	bveGmgrbi1zvuYjHQ7zZR98dzmgOFDQH5yMa/2yaoC9TP0O/AUG1nBPkjlzbY4nb
	XLXomHDafO9wRObezHUF8UUqfsdh15rrsdA==
X-ME-Sender: <xms:kSN0avmPiroXNdpdVHbQcM1cjLuFRXMopvctlDpjOKh3Kl86HrP13Q>
    <xme:kSN0ap3DE_WKCGRDlsaZtVKRcMZTx-6UKCe70Y_oC2lMr36bOAOfSZ5HGEPXOqkOC
    TKdZYB-CWuIP6BFJh-vaSAFjzPlrAM20gXB6fcHwHLv0B8QpmIbmg>
X-ME-Received: <xmr:kSN0aqplzwOc66JuE-fenAHAJ-c-TxdpJDtkGYNs6nUFKG_bWz5owIGxRpVIiVJhfv9QUG5Vmu00lbGvZ5guLlrt0LcSQqEM9dzcgCHHZm0>
X-ME-Proxy-Cause: dmFkZTE/8BNFwtuFZGwYaQa/rRnQ0RDnlybGw+eM1fOU9CO6a1opcxq669S6XLwum9btqH
    irigTyLIYIJSeDTGl2rXjC0Pe7zp9nO/ZNyo9nFXC6mJXzK8jDkG+yY8M4/scuHhELlWM/
    xtd2DzGLFLtTzjaJK0kx7QFvYXVFjDLbeImV+QA1lo/eZCC9pxeAzoebj7HvbqBPaq5mq/
    wTLWZsn2Yrhj+VSBUFF6VpTAQ7FCHWcAyNW5NWXcadrdQ2TZTk+ucy1Twhkw5XR4EmOhtR
    Rdh43KLYbHNcxpxwShlcKxWo6bZ8biLTApNA+nzRaog4LA3W90gbvh3qhn4RRx4pNCFzPc
    tIP0NEZqPt/SrSFR6OFtjMqCHeiotYjPpqaYGTrFJq8msNwRQMziG6QiNPsdMuUuCvIeL0
    YzbERn/1+VJkFqyTvodCqKjB6c/cYneq94aHwPFqeRpRPAxucBQDonMl9s4XwPxegl51Vf
    6MzKkuCZuHfmtmzn1sK+oGx5aBnW6kiCPla76jwbQrmA/d0ZNKUtQRHC6s5AKBTOg9zRDl
    vuH31v3xflK9eMGMg5V5gdjQQes3MVwFX1zf9lv7v0bzMWHmofAGYVpzXQ+zeZNvgGAJuX
    fVVbKRyfxyNis4LIyWJ3+aC50PFFrU5+ArEMdO54dPioEYyDqM72BSCENJZg
X-ME-Proxy: <xmx:kSN0amcTffJwIrXN_58BsD6xqgTEhHZD2HK0pUNUiyL3pngvl4OVWA>
    <xmx:kSN0apoC5YDaa30GpXNdxWfFEgRHQkPinamvSvQIT_J9b-KXsIOIoA>
    <xmx:kSN0anHFZuJK33WALwnG7G1-UsZUL0WTlGpq4sUqMPryG76GUW_-gw>
    <xmx:kSN0apuqPEWZj8O5ebGAYtbGSGWvWM1D7zvr28Lb_WeYIzKgyxauDw>
    <xmx:kSN0asrMCNmFBW8Sc6dx8nhLaI5xJn2sME2McrAlDeVbSxb4AqhGKOx4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:02:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ece115a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 06:02:55 +0000 (UTC)
Date: Thu, 6 Aug 2026 08:02:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 4/6] setup: defer object database creation
Message-ID: <anQjhlnvvhKLOFPV@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
 <20260805-pks-odb-create-on-disk-v3-4-c0ee3ac5141f@pks.im>
 <8733ws6424.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8733ws6424.fsf@emacs.iotcl.com>

On Wed, Aug 05, 2026 at 04:21:39PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In a subsequent commit we'll make the creation of the on-disk data
> > structures of an object database pluggable. This will lead to an
> > in-between state where we have already configured the repository's
> > object database, but it's not usable yet until we eventually call
> > `create_object_directory()`.
> >
> > Defer the object database creation so that we handle both steps in the
> > same function.
> 
> With [PATCH v3 3/6], Justin's objection[1] is stronger now:
> 
> > Naive question: would it be simpler to just require invoking `odb_new()`
> > explicitly after `apply_repository_format()` in all cases? There doesn't
> > appear to be too many callsites.
> 
> As a matter of fact, I've given this a try and see these changes on top
> of this series below.

The reason I was hesitant to do this is that I want to move
`apply_repository_format()` into `repo_init()` eventually. But I guess
moving the call to `odb_new()` out of it doesn't really prevent that.
So... fine, I'll do it.

Patrick
