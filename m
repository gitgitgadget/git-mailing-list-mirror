Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263C27D782
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756056322; cv=none; b=Lbku1SZWwrhRxxKrxIk9qmI0Gc6MV3LrfYGFSltmQHH/KjNOUa5vnFcKPXwe5s2a60497uXsVp2rUBKKhXI2jRwNU9ctMc938va7t1e90l9PXwe9rQ19Hp8Vo8XtZHrITrL4kSdVpzoUUJ/p81X+mbrVls3GFZxeYNbsqvATCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756056322; c=relaxed/simple;
	bh=Yw+WlLNgxKhTzP6REf38mhCqaNdykKB6GlvSjSzjQSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suKbNqwH9qgCzZ1E3PFfKSCIgnQoWduWzXnHmWgGEvXvY4WuOhmIKpzL3BXS9yxh3lXA6yoRabIfjj/2n/wg1PVrnHRMqHXZCZI1uhLke2BaVjgMjAK/P/JgdzIe04J8yslxCFal7vSkp3WI65DaDze8CgazrFSVfxZ8X5VZXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jjc5CuLa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LrgsUXJo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jjc5CuLa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LrgsUXJo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B26DA7A0110;
	Sun, 24 Aug 2025 13:25:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 13:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756056319; x=1756142719; bh=uGD4dLcmea
	TouusBNXVtswfUcq0KoVpOLYv0kcBV+pQ=; b=Jjc5CuLadgWnjXkR3O5E9pR/7g
	VnhSPBtVQCqc4+xWyx+c8f9yKSnpC/NXRIYSTmG3ihZrQ3GrS1R+iytmXk0/xaat
	YMZMdowA/31TJJYsjnxyV2vAPYI21DIWTc6zxRz1fRDX/2zqi6zWRRB3Deh7AVjt
	f1brSjY5NbWlEfDkclWl4crhpev3dlJgYZ0ikmetIsHcf+nDgxVWcz15AJse30Lo
	QI+gMDutrJIJogBICPWoXAxRfq/iL0wRCk+HR+D5Poz2mpJktw0U8IeEDr7SXjEP
	4Pb3JvaUrI1Ri3GmJHtAAQbnYr+vatwX7jLUZF1Zeuk6mgiuqfeFZhkOoWfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756056319; x=1756142719; bh=uGD4dLcmeaTouusBNXVtswfUcq0KoVpOLYv
	0kcBV+pQ=; b=LrgsUXJoR47231kUIGVBxpEG5LrKBUS/oEYbwySzLyL3Ua/DQVr
	GNoOFM27Cz65d7AifJCO68mCPXeuY4/ugPGqVZTYyahtHaPswLC/ygUcEAF6U97e
	JrZ8MN+my70fjE5OxSbhoCh8DGkISvaZrFUodWEB72z9yVPLOvjerqdCm9Jh2PRB
	k6PX2Wp/MEH1qHHMiJTy77wPC/YKAOAFGhLECEzkM9Qur+sMnf9Eq7thwWX9W498
	vLTMy76HKWBUWMdJ/1/vd4YhUb9xBZOMJvJwX9zEp40AMprHGkKnEftwyT7XgMCu
	H/T+m2G3bDlCW4atvFRuur8Ie33CFsY920Q==
X-ME-Sender: <xms:_0qraIh8AY3lCnromn3LxDa9q4p-TypP9dLRIUYxUaSSEc0q0lFBoA>
    <xme:_0qraEQ-YlErYc7iEKb8_7zeLN7QtCt7s7SQYlWUDkXVQyr8OCSCHKH1zRI9anAik
    xbZpwkTwk6B99h4_g>
X-ME-Received: <xmr:_0qraJgeQDJ-NSoxKKmJtYBSuOe7iXD9H69sFOzcylXf5XkrkKJa8vC7nDKRnMQ8a3nZrTHW7Z-F53dd9dhNDNFSCdI3xhyIX7M_rG48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:_0qraE4SS28hcgICNRfo5UThzDcJbQ7xQr2r8EUOCjsXyZBjT3ZExQ>
    <xmx:_0qraGBg4mPk7wG9jKe59NS8DHCKdIJmhMd7LyR9SADiz2bV1uz18g>
    <xmx:_0qraLZSTHBX8zLP2-v1IpC0ZxYQxcbvAdwY0GmeZ0zco8461AlGow>
    <xmx:_0qraBZ8xdkgy29GxjG_oaKCb5QNKbnuFQFq-Yh_wc3bOvIVOksvtg>
    <xmx:_0qraJQ8IqhQJx8bvkT86RYsKU3-a3dIiAcDV2vlnly8L1W5HOR--jAu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:25:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74179baf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:25:15 +0000 (UTC)
Date: Sun, 24 Aug 2025 19:25:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] meson: wire up gitk and git-gui
Message-ID: <aKtK9fYPqLpXeQ1V@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20250819-b4-pks-meson-tcl-tk-v1-3-6bcaff0bc0a0@pks.im>
 <CAOLa=ZTScBdh_JEvSez20+4cqnKaPaJmmmAGqGtdbzcTz703VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTScBdh_JEvSez20+4cqnKaPaJmmmAGqGtdbzcTz703VQ@mail.gmail.com>

On Tue, Aug 19, 2025 at 02:40:55AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/meson.build b/meson.build
> > index 5dd299b496..edf7b69a00 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2207,6 +2209,16 @@ configure_file(
> >    configuration: build_options_config,
> >  )
> >
> > +gitk_option = get_option('gitk').disable_auto_if(not wish.found())
> 
> Since 'wish' is defined as required above when 'gitk' is enabled, would
> it even come here if there is no 'wish'?

Yeah, it can happen. We're checking for `enabled()`, not `allowed()`.
This means that we only require "wish" in case the user has explicitly
asked us to enable gitk or git-gui. Otherwise, if the user has "auto"
configured for these we may end up finding one, but not both of these
commands. So we do have to auto-disable the feature in that case.

Patrick
