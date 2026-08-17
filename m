Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB72517A5
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943849; cv=none; b=Hz+THYoDNpoQYCwn/ZnKQdA6ZenEbAQHaUOSp1N8Frk7MQGL/FnnBPWeJuzUFIiaA7K1VnMcdLebmU9PfMt9lz2vvVFzaZe9ZR/ll1faqCoffr1NRC9f81s88VXPd2WQtciSiattVqBdUI6Z9xtotwvY4m1Jd1k3uB3x+ZhYrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943849; c=relaxed/simple;
	bh=Y9TsNF+grhnU7cyqNLJ3+b41Ojj6vOwAJ+aMjjPfqpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQupLVRPFp1w0HsSQPUZXRtJTBGQq669+FdjHmWKo4ASIHNIrDP1z/60l93ZIiKftGmPCqHd1FXIbv1vZo62xpteFNMqaf1lFRux5EFAyjxxF47JkO4kA2tpgpFaIIzpVXczK8q826rZK49lTqiw5Ci3IEVIpwnh9Njjc0BkfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQMkT00R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALpp4yb3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQMkT00R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALpp4yb3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DBD87A00D3;
	Mon, 17 Aug 2026 01:17:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 17 Aug 2026 01:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786943846; x=1787030246; bh=oT7+wWpxOq
	VYYOd01hbFU/Oh2c0hxsMj4b1s3vpQCWs=; b=iQMkT00RJfZF+FSJZH26yv9aJl
	5zMNaazB6I1G9MFXb5GNkxx8oEYK7ITp2GRV82g9FoCctBu1WIPnPWxPlRqepIZm
	cu3PS+HeA9LVBN9ebn9ATOQSawpJWx1xoOR1zFFCR2r4xMXOyJK1ZMEmVO6seb1J
	IYeqjYGYAl0Y5UWznCeKxrXik/jCup4CGj9IMs01NyjkJkHcQhLIIqCqt4ybzZcn
	0BL4YivxvU/ILwOT+Odg3A9dg/gKYmQofuphKzkQ8LPuj6nGC8jMW159UjK1NVbB
	6CkFg1dy7VfQ9rYLD2aIe6y47k9+/04xLQWi49+n13a/4qY1lUPjmeo9GTNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786943846; x=1787030246; bh=oT7+wWpxOqVYYOd01hbFU/Oh2c0hxsMj4b1
	s3vpQCWs=; b=ALpp4yb3YiV0H8/g8+7j9GPQVAN5mhrH856UzY70irUlb48zHEY
	NP5NFvMBdswcvGR7kAKGyJUYm4ZlILY21TGwO0o4M0fLfVxZzqb0Pv0N6SL8ijOV
	X+Gpl1KaNgi/hSdZnjyiW/LctjU3/q2E/qbZmy//QIwC/jWAl8Tt8aJixPUaCtPR
	MSsWOepP8GCiM1tOcD8ivqi5S2IB3OrVWoT/htYvDoGOsRg6LdbIhsGrwK5qr8H4
	QGFrVkWbeXn55cElRWXX0jsMIIkOUqdBlkq/TRXqsJFKfQF98FzAcBSiYGCoxI7A
	v+pcP9Jwgp6Lg4PMLmp+/SlhFVfCHrS/e1g==
X-ME-Sender: <xms:ZZmCajUHzZCotI8MKGVF1WGCA5wQZ037NWtBU2jaFAyRPzFVExZ7Tw>
    <xme:ZZmCajCncyj-JCSRw69zUqjQ8KtbXfW4mWEilJ7AP4UzdaXTSWu-iu4vzRBMyJj42
    ZYNBVX1EOmCdAN42ZYF4KlDyOLO35TV6RDPBZJA3YrrGX18J9OMwb4>
X-ME-Received: <xmr:ZZmCasxXMRb3BdUCDPF9BDhR_Qcw1_1ssthYP8Fsz5lb56q8megzVuGWyGHbv5L3fq6fzXfAZaGaLMF3zHya9GCELgKukPoowo-tczG4fQ>
X-ME-Proxy-Cause: dmFkZTFnm5qKoPmeuOFAy+ySuDfMe0DSk7WrAcYYSbQfOR/KemFog4uQ0G4obU8hWcSalK
    rngvOWxLGyWZdV2Hyie7KHrZurVanCz51rgpwjVoJOfGlh1HcuY73XOmFEn2KMIwEYbZfO
    MNjIlY4qJzl/iqXzMXEXoQxY0x8D8PJh5Lp+wBLDa4BVRMqFgDfOS2Xl4Yq8i/HtvJkheV
    TvfR67cLOkgHKgYKzt3bABX5f6u82eJhQhH+hH6xUqwjg/RMEtr+FQG7ZxTI9Ji3jATQbJ
    7f8ZIDdaeg8wKkgsIyJUoQrwGQ0x1CmTXhz9OqGJu7+Fnw/g4qBO7ONyRw/sCxGRsHsip8
    qvOMu4U2aFI7MyCyj24wdqwX+00EepbumOIjXgW27ZQIlI+I1fOPcG2acHZ3hHvSzIJ5Oo
    tpd+XhJFraNbdOikac8Q4klNRK5kYgv8YjX9psqt3bappnhl0WYimL969DE/IDog1irHqO
    4LVWx/a6HtSchBZRYZ1OO7bshXjGwsFMP6Earme5o3V/9KbbVBGrwFsngZV4ZaLSKSxYnO
    T8sd5bjojKMbfF2GppHWWhC+dTEXXSNj93LOsu7cUZZChhaV2dspZzGrz1iy9qz3nYIMJE
    539h3IDjSNCc/mZhDEw7zICHrUh8sHymr06ypojCTDv6vhDTjhnjF0DPqunw
X-ME-Proxy: <xmx:ZZmCaoAtvoioOjBkwCoPJvvLzfDPd4O1wb1vNLl_ACsNEfc1-WiHig>
    <xmx:ZpmCahbbO3Kh-E7edw5Uj7q48lQNDysGNhcEocQ_FMLgUMKfJSNY8g>
    <xmx:ZpmCaoiNK4FjZWJPZ1aIHLslf1HmndQUtCRNd3TFlTiDa6mO63RLkg>
    <xmx:ZpmCar585vdDl0CEmy-DUB1RqVqs_YtCTADBbIbGyltbAg13Hu5LmA>
    <xmx:ZpmCanAt2CtOOhmJTz0JZvS7ArH0M7jtPYt6qqdx1WiK_438eIrNiZGT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:17:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf3778dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:17:22 +0000 (UTC)
Date: Mon, 17 Aug 2026 07:17:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 9/9] odb/transaction: add transaction interface to
 write packfiles
Message-ID: <aoKZX-eBZ7xIyHCc@pks.im>
References: <20260809190106.1565882-1-jltobler@gmail.com>
 <20260811175415.2044235-1-jltobler@gmail.com>
 <20260811175415.2044235-10-jltobler@gmail.com>
 <an7XAyQr7PrPlAGO@pks.im>
 <an8YSE8iIDXPSkH8@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an8YSE8iIDXPSkH8@denethor>

On Fri, Aug 14, 2026 at 08:40:32AM -0500, Justin Tobler wrote:
> On 26/08/14 10:51AM, Patrick Steinhardt wrote:
> > On Tue, Aug 11, 2026 at 12:54:15PM -0500, Justin Tobler wrote:
> > > +static unsigned int get_unpack_limit(struct repository *repo)
> > > +{
> > > +	unsigned int limit = 100;
> > > +
> > > +	repo_config_get_uint(repo, "transfer.unpacklimit", &limit);
> > > +	repo_config_get_uint(repo, "receive.unpacklimit", &limit);
> > > +
> > > +	return limit;
> > > +}
> > 
> > One thing I noticed just now: as the intention is that `write_pack()`
> > will be called for more use cases than only git-receive-pack(1) we'll
> > have to add a way to tell the callback what scenario they are running
> > in. I still think moving the unpack limit into the backend is sensible,
> > but now we're not givint it enough information.
> 
> So we already have transaction flags like ODB_TRANSACTION_RECEIVE that
> can be used to differentiate certain callers that may require slightly
> different behavior in the backend. 
> 
> In a followup series where I expand usage of odb_transaction_write_pack
> to git-fetch-pack(1), I was originally planning on using this flag and
> also adding ODB_TRANSACTION_FETCH accordingly. It's probably a good idea
> to go ahead though and start using the transaction flags here in this
> series too. Will update in the next version.

Ah, that makes sense then. And I agree, introducing that flag now
already makes it a bit more obvious for how future series will look
like. Thanks!

Patrick
