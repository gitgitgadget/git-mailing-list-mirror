Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0512DF137
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794984; cv=none; b=SpacIymd5bLjQBVxLdH/yC51qnN4N1BixPKvEA6HaySmKcePaSKkC8tOhi9XdoK6zkNIIh2RVUlIQi5IRFvPfIg25h6nWaCPZfOG95z6olv/yE9/Rk40HK7DlTI+WldyOr+m6VWAP9GvWSiYlf/3unUlRnTYHAR9xPiA34aM7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794984; c=relaxed/simple;
	bh=xdCkF9nfoNBI7VU2Vhaga/g/8BHinwFStL2QyT+uW48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j24q/IlM/NCrypVlyETT1+9/MgWr2/UiDH6p4hEffZYjQwNSmCFadpxFPMBtE+X4/CLs6dKhwkCsUzVQgG5CUDh+TIx75MA2y48OH2ENcKftW8zTHc97Ey3tLpPp/vYNsn2h4lGljY2CDs5rT+kA7hTz7KhtR7DCAyEtF5gnSWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jS2JILPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gk4+w4Um; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jS2JILPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gk4+w4Um"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 76DB5EC04F9;
	Tue,  2 Sep 2025 02:36:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 02 Sep 2025 02:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756794980; x=1756881380; bh=mrNANGlgUJ
	w7P8Ikx8n/V7ogWfZqHBl+mnS9B+UEUao=; b=jS2JILPoXKcokpSrfOq/v8fwru
	k/mf3VRB5nQKF/C7nqqWrNE7bmaLV8q/OpXTyEk8pQkuvVmpUGc7qPwPoBtFSttw
	+W57Ofgwx/4jcF65E5gu23BVV5dMWDqRb/GxQaE5vigolCde3AJ566N8GFOEo5Sn
	mgxe8eUXEEYiFYA31BhMberF33ADV2NwogUNaTcZODTqtMwkJq0riHFpNdoyVR8C
	vXZzuZTdcBw0AEV1+Y+J2+33NSjlmSSFE7RiNehEgZ4qUiOVHdacvS1FYVebNQsD
	jNCP0sTwV5Qt9qcUYGEFymZ0vRJgX1L9qtTR/8N3u7t/oL/JbcdDW0NmfDJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756794980; x=1756881380; bh=mrNANGlgUJw7P8Ikx8n/V7ogWfZqHBl+mnS
	9B+UEUao=; b=Gk4+w4Umcaj9oX5/25wD8Tud9TnAImHCxcxz7Hs2DAD2gvjpsZK
	c3s8OYUuSIzOqxoGhOVXpdurEq+BTcK3lScFBdLgFz+l3uy7Mfu/vfOVLQx+zdpd
	leSyJzvMCsg0WvryOIw2B+v3T6ilZgmV7Ge1MG3ziLKuBLKsneudlhetlDBbSfwV
	PEovrm7VDJJqVPs0gS4QHgxWgTGSl/tIGSThhwX8eLioIytdwLL6pipsXjUpemr2
	7sJZHKIX6nsJIpNczVkRWP7ADCuurdD60cEnApbKLycCrlG4rE6oC10lKawZf/i4
	d7dHWsqkr2TPcp7UqdeMaTXykpSymU26/9g==
X-ME-Sender: <xms:ZJC2aKypF6qBWPx2ePgl-5XI8QYlMnrWqO6chYR2e0xIRcog40wdCg>
    <xme:ZJC2aOsg14mo-Hfny6qawG-dFd7PNvjHlbvEx4SSbynIDrcMZ7Jv0EOQEgMrqxFqE
    U5PIjkg5akqv4nx1A>
X-ME-Received: <xmr:ZJC2aMyVvf7slGiYYUFmFYOx9ZaKy-TdHHHgJS4k7QrU54W6H1SvVuIphzJSTIQficO51S_sEf-tyfJ2A9OhOuCwo-623oImuRUx5gHDmAJ0dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZJC2aBDf0zF4w2x2hMdF-F_ls8-g8vrsGYntkGswILC2ErqWGdSt2w>
    <xmx:ZJC2aKd4jqOxegrvxqyy-La41iBsKgmeHMi6Dp4tLCGGVfga7sAGCw>
    <xmx:ZJC2aLnfC76fPLLP_LtBvbt_F1hlz-zhrSFGDzkATjeNdIxx9DRWtw>
    <xmx:ZJC2aBF8aEEL96urWLQAyd9YpusQ2dMlfsAE9DJUjb3LrhyXBbcmQg>
    <xmx:ZJC2aDcRfSHAvdWguKsPkbJiuXBCClFWKNcav1P-sQrWmXn_1vYCwlAf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 02:36:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3404f6ba (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 06:36:16 +0000 (UTC)
Date: Tue, 2 Sep 2025 08:36:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/10] midx: stop duplicating info redundant with
 their sources
Message-ID: <aLaQWPK0Kxw8o7VV@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
 <xmqq1povt67o.fsf@gitster.g>
 <aLD1s/LAcYlDujJG@nand.local>
 <f6c9b931-1587-4517-9cca-9e9d0899021e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c9b931-1587-4517-9cca-9e9d0899021e@gmail.com>

On Sat, Aug 30, 2025 at 09:39:02AM -0400, Derrick Stolee wrote:
> On 8/28/25 8:34 PM, Taylor Blau wrote:
> > On Thu, Aug 28, 2025 at 03:46:35PM -0700, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > 
> > > > Changes in v2:
> > > >    - Fix a comment typo.
> > > >    - Introduce another commit that simplifies the calling convention for
> > > >      `link_alt_odb_entry()`.
> > > >    - Link to v1: https://lore.kernel.org/r/20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im
> > > > 
> > > > Changes in v3:
> > > >    - Introduce `odb_find_source_or_die()` so that we don't have to repeat
> > > >      the calls to `die()`, as suggested by Taylor.
> > > >    - Split out a patch to adapt `link_alt_odb_entry()` and friends to
> > > >      consistently name the parameter that refers to the alternate object
> > > >      directory's path.
> > > >    - Link to v2: https://lore.kernel.org/r/20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im
> > > 
> > > This has gone quiet even though the previous two iterations got
> > > fairly detailed review.  Should we declare victory and mark the
> > > topic for 'next' now?
> > 
> > No objections from me; though I still would feel a little better with
> > Stolee's opinion on the MIDX --object-dir stuff.
> 
> Sorry I had missed this series and in particular how it handles the
> --object-dir option.
> 
> I think the modification to add structure to the --object-dir option
> by passing around an object source is going to make things better.
> 
> The one thing I was very careful about was that we are not trying
> to create a full "repository" struct based on the object-dir, because
> there may not be one! We only know that there is an alternate object
> database where we want to break the norm and perform writes. The
> changes here make that seem like it continues to work.

Yup, this should continue to work as-is indeed. We also have a couple of
tests in t5319 which verify that this works alright. And overall I think
the whole logic becomes a bit easier to reason about now that we pass
around the object source explicitly.

Thanks for your thoughts. With that I'm happy to have this series merged
down to 'next'.

Patrick
