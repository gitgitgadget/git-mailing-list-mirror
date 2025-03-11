Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684225C6F1
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704053; cv=none; b=pZ59DB7pD7OV0t70RQcf4SP7Lmtau9TfmluolKR3wu5eB5LNx9ADTdjXIdqoQShTWUTi6ZwPh5xVdpW5Qn1ugdBxle8KKHiGu0WkB31DVVlcamNLOAxVcT6kZaR0l4CYz/bLvGz2SN86cYDsC4GLujSb434+PtE54L4HBHDE9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704053; c=relaxed/simple;
	bh=0b8msB7Nux1ikDgU7/CMLkftk2T/KzuBTIVABXmUGC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdiLM+JbKKDCHEPqpcq8e2Bkx5qRc3GDXJhJTlse+MJJ/ne5SQ8K3Z2z6UChweTXTks+HdzRyCeo+Xbmj/kWVAJrAfWtAX8caDb3h7hnC3N6mdn5DcSaB51vgBejz7lTt6u3VW9nhGJt3mxjM8yt04pXluaiXXvrmf27JP1dgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qs841MW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PF1wNHdr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qs841MW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PF1wNHdr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 745FC114018C;
	Tue, 11 Mar 2025 10:40:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 11 Mar 2025 10:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741704050;
	 x=1741790450; bh=gwtsHLtHNWVr4KPhJWbLGul+x97NrLQdjlUCIc4QfFI=; b=
	Qs841MW3YrSkezJ0nRnhb3tw6oK9hNOrYfSbswWtR+amoVfd1Mf3LP9q4Oxi2GAZ
	RD/D7Zi8PfvTIJDYD/ncbD0i6tNvZZ8rq4cgz7gsnRY/3LJinKegt3YYEsZFtn7z
	6wXgduDdORleFgyl6bIje0KSIRLgqyXIyNr+zyNQg+kR1X5a/JUgbFFrROG0uEdv
	4RHdaY4PXiPOQm1u2jrBsMUo4jPa5OJnc/8ifjBK6UznXMoLIhMxXxSFaJQlT6Jx
	Y/7XIYtEJzBDHKZxR7lvHlLzp4tuSQzLZQQmrDNw73u+pPTMmKFe1J9LyDiTj5g9
	3etPnxUidS9SkmLUBo9KPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741704050; x=
	1741790450; bh=gwtsHLtHNWVr4KPhJWbLGul+x97NrLQdjlUCIc4QfFI=; b=P
	F1wNHdrf8HeZoKqGv1Oeu9b7Uny3HP34lrDe2ZF7ejKFg853kmU4GoJBKlchjAVt
	y6GcU5isrqTzMj8I3qj1ym3hmD9KPRmbLTWwpy2fp7eP4gu2P4Lld5zJOOEdyfAu
	G2XKVHZOBfeEJCX+qSdbYih6zOe5XptbXBtGRUBVlAAO+MpmUBqTjNamp7i4bbkW
	y8/LMp5S+en+b5Xej7GmffAeoV+dvWkOWrmGCw7bBvtOLzvxjZRoUpUbJXpGan0m
	7mPDDW4C9H0nGc8M2q+sIgoSzWzzIbQhbg/tPIxxgO9Z7W2El/0VBCFwpV7QptvQ
	NJ7pw3gsc3bbmbglujlyw==
X-ME-Sender: <xms:cUvQZwChA-zYG5_vORf3ZSVW3bmBR_xEr7FG-PMttEGtkkXMJ5eipg>
    <xme:cUvQZyipJ3RZ4ta7ss_vZEC9_oxFroZ473dmun2G-GpJBsLkxL-b2W_4KL5TgVNqo
    lMNPa1ERyUf1y6BaQ>
X-ME-Received: <xmr:cUvQZzlOHa_XTXZlodR6bwd44MSyxeI94cqHBoNFk-1nglw2cC-MxBY6fAsUxPS_j_FG8YGNgljnQarkdKxajzyrKa_CHcmYNOcw6ox5S_6BBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:cUvQZ2zwMLMI4aASjFPsk0ux96KHoBru0LKjI0aIQjzGItdEnQBTYA>
    <xmx:cUvQZ1Qqq8vNoL4w7b5c4E5z6MAUoMKiA3Tnj1lz3K5sxUAMY1nwmA>
    <xmx:cUvQZxYaP95y3KE65y0X5s_aSDgKk8vDJ_8bDVFJ0zvry3hChTEADA>
    <xmx:cUvQZ-RwM-Wpj8xxbB0wCuG5Hl-ZRYWmZ_asd8oDKS4c3rJDYLeRDg>
    <xmx:ckvQZ3dsLCyy_jnmsiRPvK0jbdjSil-YLzYBJEAs6TQF2YrQXXWR1Hxl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 10:40:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a36ce0c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Mar 2025 14:40:46 +0000 (UTC)
Date: Tue, 11 Mar 2025 15:40:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
Message-ID: <Z9BLZWUarN0kC4CQ@pks.im>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
 <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
 <56cf842a-7c1f-4354-b191-35bcc1e139bd@gmail.com>
 <b5fb3292-216a-4456-b456-e9ed38affc22@gmail.com>
 <Z86Jze2qZ5s5OyOB@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z86Jze2qZ5s5OyOB@pks.im>

On Mon, Mar 10, 2025 at 07:42:25AM +0100, Patrick Steinhardt wrote:
> On Sun, Mar 09, 2025 at 10:52:44AM +0000, Phillip Wood wrote:
> > On 07/03/2025 15:07, Phillip Wood wrote:
> > > On 07/03/2025 10:32, Phillip Wood wrote:
> > > 
> > > The diff below stops us from building pack-redundant with
> > > -Dbreaking_changes=true but still builds the documentation. I don't intend
> > > spending any more time one this
> > > 
> > > [...]
> > >
> > >   if get_option('breaking_changes')
> > >     build_options_config.set('WITH_BREAKING_CHANGES', 'YesPlease')
> > > +  add_project_arguments('-DWITH_BREAKING_CHANGES=YesPlease', language :
> > > 'c')
> > 
> > Looking again at this I think it should probably be
> > 
> >     libgit_c_args += '-DWITH_BREAKING_CHANGES=YesPlease'
> > 
> > to match the rest of our meson.build. As a newcomer to meson I find it
> > confusing that the CFLAGS for the build targets are set implicitly by their
> > libgit dependency.
> 
> Yup, that would be preferable indeed, thanks!

To set expectations: do you have the time/intent to work on this and
polish it up into a patch? Otherwise I'm happy to pick it up.

Thanks!

Patrick
