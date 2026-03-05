Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9149460
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717001; cv=none; b=s7qRYdVwqHBb5tH7Jeehe/Je6QFqgXDBoyY80Nh+j4qD1lDMhMKavCsVylyu/9QfggUhNA8JfngRUQfPe3rKQXL8VyozsKQD8V72NE5PYD5tS3tahjVyMMarSlhtpRfGHvqt8oSS/ktsh4F4rxmsjM6/m94vJe1mVOwaMgUKBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717001; c=relaxed/simple;
	bh=0bWHayZcyaAFm70ePrApGuuo9K01+Gbgl3AhE62ZhUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+urflvSw6cQxBjpcbVQFvgiWQj/q4KspAVShxgnYPJLM5eHzPIiC8wjC24SffzPyuCdlfYE+pUX29yXUKjUJ8dJZsvDb0mIh5b8SlvJyHB+g597o6u5YNEvKeyR13/BvnH3zXiGXJgD9RdZR/vD34JTxGdQAX14desL1s5+GW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq7lVnda; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5jFfXdgL; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq7lVnda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5jFfXdgL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0AC427A01D3;
	Thu,  5 Mar 2026 08:23:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 08:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772716999; x=1772803399; bh=Coa9LtZIpa
	m/lAeT3VlkE61KVDp3VBaqATKMuv34YsM=; b=Zq7lVnda90Q48BZ3uRyXkC5Riv
	2F1WP1IVCCaqMwXJsZcSmQ9DtomVv5bMVmqS/DaWhWYkA30ls/iVl/aV2Zvk66sB
	8r+L9EWZ9eC9ykbGXkAujN3aQU0wnvb3NGpmg2PjQdTiH7SaJf1O/1hV9jY13wMm
	UwNB8+Lkcc+jLMnQj4r3pnZ5pFz8AWJwbuBB6zBTbjnCMlJmxh18dAOw4KOGhqF6
	qaVpUAtq4306cdQZcmnt18RZMfdByVYTJHBqEc/6TEqNOi5671JyuDC2JcM8BFRF
	8kOjYER34WgjFDGtwMxds/GttUX3oUCDoPeMWtqevpWEyHUPLgfrzUAesUgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772716999; x=1772803399; bh=Coa9LtZIpam/lAeT3VlkE61KVDp3VBaqATK
	Muv34YsM=; b=5jFfXdgLz1YPPhMbg5ZpoQVEgqjTM70/yKmWi4s5wlNRjqtU8My
	7DjB6MIoEaGpPheKcS4iqYEJ45qYs73B5MEqBTZ+qQEr5Go10MkjpE1EZTcsXtuH
	o3SHAGicaHP0flkp1G7B7QhdRurZJLCBtOOQ9zVWhRT6VAxBI8SofP9i+kHptfYn
	f3G+gan8rt4VOLOEgynEVxprA94u2/pQkNwAW2u7PPV2jViJmDl/CjoHNADJICT/
	BVAMsvKRIqamOspAGD37FSQI9cNytPrzc7jez4DoZsmJnTU1FUPEcYeHm1fWKnk6
	OxMKUFUOqK1uyUHdarw1r1Ob+uk0g0dqoZg==
X-ME-Sender: <xms:x4OpaQoB_pjTndSuUGzZNXM2YIsjjQMbwik1Bzb3GCGScKDySvgVPQ>
    <xme:x4OpacoM4dJXr-1WpViKJ3--ZHZBAtOkDnMFd50zRCfBuTsGfw_tT2U-3TXH_Olmy
    LwUttcjGxPUQWf7ZlatDL404qW4V401uzc6p38g-aK_2ucYOw>
X-ME-Received: <xmr:x4OpaS3k0CUE-BYlaSJuhsM7KAB2U23wqy2oZiSCIyo8wKxvxgcDb7Pu-5I-oX8BtlQUKX3HF0mMYknpISpLuOWR-XXWXgqRKlYgGgAiyXTC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x4OpaTDeR07GChY5BHr7Wx2UooJPw7GR4bVcdIClvqglJ3NP3lV7mA>
    <xmx:x4OpaSc4P0RYBV5mR-jYkWauWSc3A8PG2JVOCdRhwecZLkFLJ5Bc4g>
    <xmx:x4OpaQje6Q6QYa8xmzSmIfKv3TRI41onKlG1z0xq1tqEfSd1f65I9Q>
    <xmx:x4OpaSpsA_JwjW6MqwKxfTkO75937_J-jqURDnhWoXSPJcWOmZXeNg>
    <xmx:x4OpaaZ8oJGmKibltatrIVjbAQFFoDBh7b0rOQsx1LX1Pl-r5hwpjC5z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 02f044db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:18 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/17] odb: introduce "files" source
Message-ID: <aamDxB-s7WW0Mq9H@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-2-253bac1db598@pks.im>
 <aahbTN_lFx1Jhy7U@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aahbTN_lFx1Jhy7U@denethor>

On Wed, Mar 04, 2026 at 10:57:26AM -0600, Justin Tobler wrote:
> On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> > diff --git a/odb/source.h b/odb/source.h
> > index 391d6d1e38..1c34265189 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -19,11 +21,8 @@ struct odb_source {
> >  	/* Object database that owns this object source. */
> >  	struct object_database *odb;
> >  
> > -	/* Private state for loose objects. */
> > -	struct odb_source_loose *loose;
> > -
> > -	/* Should only be accessed directly by packfile.c and midx.c. */
> 
> Is there any value to keeping this comment around?

I don't think so. With this series it becomes clear that all of the info
in the sources become private implementation details, and future patch
series will double down on that even further.

Patrick
