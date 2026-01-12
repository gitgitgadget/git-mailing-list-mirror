Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5B33AD8D
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205874; cv=none; b=cNW8C8NXa1eMeyC3Bpow7n8M8vlfcFmBfJuH8hJppzTp6WTsuJqcz9Z+p+eWOWGwugxCcGAZ+EVzhQDMAsNth9ku5NP/nSwfx+uZINYdUSdxnxsn0gDhTymj17ZC2GCKxXIERp6JjscfQWQRmgZIb5dEsWKBUnoaSoKJHA/M/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205874; c=relaxed/simple;
	bh=yGjXIedOJEmvvyeMTHoG2AhmykFEU92Mk1DLWd6svbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McmDCrBZ4hRmb7fo0wWVPX1HTTIPzsaW54QgV6AZk2vbRWlGdXewwuK7d12wpzTWqdWKxWVrLkhGBXq29Ih1cgG9Uaq0PkCsxErgtLsdgL1Hdj04bvSQVcRr/pjGeQY47YYPJ5ESpl4Rk+TCvfv6r6oqVtxTCrG2Xo5l6s+ECwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E3crdUBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DA/7c9Xc; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E3crdUBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DA/7c9Xc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35B3F7A0041;
	Mon, 12 Jan 2026 03:17:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 03:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768205872; x=1768292272; bh=+MhJZnv7wt
	t+/bnA2X63J95NkIdsgkkrVNxscm+8kyg=; b=E3crdUBXpSEvA1LTQWQd4J0nHy
	lQbrDTt1bK79tG/CmxZW0wJeM3aG3YOLFRcuEl4UuAvtthalRsfO2904kpT0HRdm
	eGAoAmB38gLW3yF5CIhEc2gj4HUvOHwtk5cnDupCBuFfdwk9oKa4zEvwi1q4+2fv
	VJPGHPQC29VC8DQwYQb4AEcUNFhq/VON3FIjybyJXHlyn9EsTCSEhgJI0nKzAvDY
	/y0+CsWW3yoBH5B4mnxdKA4U9cyrGA4NEYVxvYAZcNetA7l32HK2H8VRzlWUoN5Y
	7U8iPO7FsOowz2ZbT+468AUAL8G+vJS4ccBDrG3irP93F2upENeiwjSU+N1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768205872; x=1768292272; bh=+MhJZnv7wtt+/bnA2X63J95NkIdsgkkrVNx
	scm+8kyg=; b=DA/7c9XcskHVsegPfEgqkDqacf0KiFrEXXw8Pon5S7LhzjoBG2O
	j0mzqd1upnoUGv6JBzEO7B4P0LR2fLZoD06gOstV7j/Oqgy2OZrlnC9ZqvLzV8aU
	S3Q0HxMEAVzdAJ8ZRnwreG51iGnbIQoxXRHwcHFAzeZBuVoa89S9pXhFhtU6AvSR
	t5nx5VA0iMZ90z31axCYCBPwbjYpuUZT1A3lJyrtGF+umh8BPcTZMZAlRQ4AMFhg
	BW1MVrGlRu7FB9hJYGDmuQWwxMq38IjdfLFzHXhK+FU5bXvV6VyqTW/cb4S9h8Rw
	Uf23/bvz8tdyarbhcMlVqO7zo1AWYow37Wg==
X-ME-Sender: <xms:L65kaSmu45ixMaRPxw1q1faSWXu6T-OKF0AuLhzQT00CSPy36-23Qw>
    <xme:L65kaRT1B3VrBdK6PYdLF7nRbcLUxNUXeQbKR7ygxJSg_i0xA594eii3j2Jo5pLfn
    KE334ZnY-mhFRa2wX-8rEYEyVUldBaMXm8CebTVIi2S40iQOu-UZVs>
X-ME-Received: <xmr:L65kaeBZgXVmn79RyZEMHt2cQpBb9JMQm9zjr76N4IA9kCJ-F_RvbzeQslamYNM_jV-nH9LvWw-sQsHedCMfGFWclI0RNC8MFxV19zKOXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeileehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:L65kaQQIHUIb-00grWXCzMDq-u2aLF3ZQygX93SsPsth1XEbpIviWQ>
    <xmx:L65kaUp9oYEp3zdAX21m54aa9C7qb1N-Az18lYuB541U77OuIrU1hA>
    <xmx:L65kaaxVHP_xTMRouPcMjoWaPgm3Qlw1XAnQCgaiB8_it6Llny_KBA>
    <xmx:L65kaRIMbKQhct8-lcwZZDeNjURgVuw4YnyENhkoUpvEdsMLwZOneA>
    <xmx:MK5kaZv-dRsZnHIC89XCgz7uZj3Oo55t234DK6Vs7WrrKjkw0LmH3VxZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 03:17:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d351bf26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 08:17:50 +0000 (UTC)
Date: Mon, 12 Jan 2026 09:17:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 09/17] refs/files: extract generic symref target checks
Message-ID: <aWSuLIzHPDSxMg9y@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-9-3587dba18294@pks.im>
 <aWJNHgFnimXRHkb6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJNHgFnimXRHkb6@ArchLinux>

On Sat, Jan 10, 2026 at 08:59:10PM +0800, shejialuo wrote:
> On Fri, Jan 09, 2026 at 01:39:38PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 0ff047d0df..72c1db849e 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3718,53 +3718,39 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
> >  				  const char *path,
> >  				  int mode);
> >  
> > -static int files_fsck_symref_target(struct fsck_options *o,
> > +static int files_fsck_symref_target(struct ref_store *ref_store,
> > +				    struct fsck_options *o,
> >  				    struct fsck_ref_report *report,
> > +				    const char *refname,
> >  				    struct strbuf *referent,
> >  				    unsigned int symbolic_link)
> 
> 
> Nit: as we touch this function, maybe we could change `unsigned int
> symbolic_link` to be `bool symbolic_link`.

I'd prefer to not have this while-at-it change. The benefit isn't clear
enough to actually change it, and it would distract from the actual
changes a bit.

Patrick
