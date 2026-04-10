Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFFEAC7
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796814; cv=none; b=YBotfapj2C5CWTAJguWWxJBgMKXJeigkQvnFj1Pg3RVpHhHjbdjsky8E193yrx75J/vQX1Ix8AXGRUXZueNa2MeLxtHKYdUMvpWAGp7dCVNFsdIhWjNxfTIPwzKduxK8h1zzhdhs9wJAZDVZq7rT8LK03tEqcZEsHuZPGF56604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796814; c=relaxed/simple;
	bh=DUtZCIElpqpQZ+pxWYzIGSslJVzo5vpWMPiUOrTYvBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh85GPpzTECwSQ0yHcjMBQSfZUmY2JlWlV8xu/uiQS8Llca/uX90tdSmjVMVmvA+9lh+H1yCSzWLsaJ0LS/f5PvPahuuIZafI2s4xh1s5xo0q1WQR1utcdKYckBjBS3vlZBoveJC0pmRSc9DiSRgq6y7V0+Qfy2mjv2ufZmw0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WbyJHXdK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XNEgpyS6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WbyJHXdK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XNEgpyS6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F3EBEC0402;
	Fri, 10 Apr 2026 00:53:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 00:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775796812; x=1775883212; bh=KGV9dtQCcH
	wFZ2OEfv2pQxBUzbG7JOgF9vSKrofPJeQ=; b=WbyJHXdK/XJcwj8fIytb3IBP+g
	HOqyAPWFmrsxypoP/TRsnytXZzWLbYJfJ6v3XiAt6qBDJSj4+IWQwkAKhioB/hWV
	ASJM46ZckDUc9gGgdeJYC6cZhOMf5rdyTFa063DkSFRblDpHl6pmTcgR/bQpN07a
	subid84RkzeWJzyjMA80wuxUGG9Ai5yUbcZRQourRGRVx/pvV6StdoiqMJpsAGo9
	MpLyKjH68CUI0EW0JaRs9WlVcR1R45aMcn9Ep1Fhd9blVeyR3zT/dOdKwa6r0p2m
	XomyvIk155SCNg4oHgqb+CHfBKOeobkAZ38BybrbU2Md7JU+T+iniEyfDEew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775796812; x=1775883212; bh=KGV9dtQCcHwFZ2OEfv2pQxBUzbG7JOgF9vS
	KrofPJeQ=; b=XNEgpyS6pEOQ7zoEw1M/3vWhoNXfnqGcMEkgiHC2iRyjGxYiHnU
	4Sq+iD2uo/83uNIdDV/nj8KvmisWeXRCZdkxOZT86Mrs5FcxaJv8hf8+Kp9g3j8o
	qJDrrsF8dpVg/sLPVfvenddzaO2PpMyMIsJCagq/ZHZYdMb23C0iuk3L398zWvS/
	ODuNd9Ty8ivAgDBLjUWAAi7lfKEQq7hwmSI75ewkaw+yfGRRHvFpDN2vtUjgcuZd
	GAfqpFzlf1NQemgO2dRKa9hQubYkGId3v2Gj7UWlOmYa1GcfIap87tiEmxA3+85t
	X6uDAyZzSq8regt9Hngzsby4dXeoYyRxFIA==
X-ME-Sender: <xms:TILYaSV-mMpwgIFKLFk1NNfSvomnwuUw802DTRsPnaqjpNEG9lrYBQ>
    <xme:TILYaUmT8nyjn0-QNKCupqNiBlYbSgNxx6OCndXLjNbuD7a41jesIivb-b3INy2mq
    JB6Qq7Nyrs8-O3Ce1nCTpXaTl3JnJaqj5mOqiYxKVhOv_RUXMEU>
X-ME-Received: <xmr:TILYaUBCMW0LJ3qTN9slhM5iKMkGedrywCoIiYHGRiVLPu4cGfl10GdIq9ZfCZ8WzYHp-ytdq0vEvbpWhWkm67VcY4p02gCt6H5iNFljwq05XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TILYaUf-WHpy7PRACwstLzQFlFmicujfVnPySwPENeRqtUJiCyi2QA>
    <xmx:TILYafKLkvEv_HBL_ZWEQhK3wyI-d366jrJSF0E7soV1LgxLouSL6Q>
    <xmx:TILYaXft0AF1CNnkr5gYTjGd05lPEMq50Q7lIk9_Dx2CiS-FmuTvww>
    <xmx:TILYaW24lnKyf2R_23R-3Q2gDNB5KNT0_02JE5seCOG9NtI-aUbEWA>
    <xmx:TILYaduCSKFX4BhMoRQhXau8hJF5UBq6iKFr8uU3w25FBdq7NftuEVQU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 00:53:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbd4269d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 04:53:29 +0000 (UTC)
Date: Fri, 10 Apr 2026 06:53:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: introduce "inmemory" source
Message-ID: <adiCR-rx3OwYQP9H@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <xmqqa4vknjab.fsf@gitster.g>
 <adYQPmnajLmVr-vh@pks.im>
 <xmqq5x61xgvv.fsf@gitster.g>
 <adc3mAItBiKMUFNJ@pks.im>
 <xmqqjyugw8jt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjyugw8jt.fsf@gitster.g>

On Thu, Apr 09, 2026 at 06:46:30AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> But stepping back a bit, does this new "in memory" refer to a
> >> concept that is different from what the rest of the system uses "in
> >> core" to represent?
> >
> > No, in principle it's not any different. One of the reasons I decided to
> > go with "in memory" though is that this backend may eventually be
> > (power-)user-facing via the planned "objectStorage" extension.
> 
> Doesn't 
> 
>     git grep -E -e 'in[- ]?core' -- ':!Documentation/RelNotes' ':!t'
> 
> give many hits that we want to be in line with in the codebase
> anyway, and even in some user-facing things?  I just noticed an
> option "--no-kept-objects=in-core" (which I didn't know about ;-).

Most of the hits are in our code though, and end users wouldn't
typically see those. So what I think is more relevant is documentation
or options like the one you pointed out. But "--no-kept-objects=" is not
even documented, which basically leaves us with the following hits:

  Documentation/gitformat-pack.adoc:write a cruft pack. Crucially, the set of in-core kept packs is exactly the set
  Documentation/technical/parallel-checkout.adoc:parallelize the work of uncompressing the blobs, applying in-core
  Documentation/technical/racy-git.adoc:because in-core timestamps can have finer granularity than
  Documentation/technical/racy-git.adoc:([PATCH] Sync in core time granularity with filesystems,

I think that these hits are all related to what we're doing here, as
we're talking about object data that we handle in-core.

I initially said "it's not any different", but thinking a bit more about
it I think there is a slight difference: in-core could be any object
that we have parsed from the object database, even if it's backed by an
actual on-disk object. In-memory objects may not even have been parsed
at all, so technically speaking they may not even be in-core.

So in summary:

  - I think that end users have not really been exposed to the concept
    of "in-core".

  - The concepts of "in-core" and the ODB source here are slightly
    different, as any object is treated as "in-core" that has been
    parsed.

  - The concept of "in-memory" is easier for the end user to understand
    in the context of the ODB, as it's a more general concept compared
    to the very Git-specific "in-core" term".

Hope that makes sense :)

Thanks!

Patrick
