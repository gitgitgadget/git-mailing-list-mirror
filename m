Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5758F5E
	for <git@vger.kernel.org>; Fri, 30 May 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748594871; cv=none; b=JVUppbAttxDUFBmSxTB9U8VvLqkUSINVeMA5CvIXHx03JB6rY2Sf7yLwf3DMvtyM0jNaa0P4oQaFJBPylQnQM+kLrw0hZV+DxCmr4Pje74agldC8qH/54DsO/tv9VybHjFcn5faeTtIQt3SwokFwXyKhpIp4qn47Uk8iqOZH3x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748594871; c=relaxed/simple;
	bh=PFRtCz5iCHnRYwSBRKER5QUeABZ4vdTg9THcIUnsKPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKqQrul0COPacSWJR4mCTpx/00RidasTrMT9uPFVDzjHF/fPYkbL6XZjh19KhTmsHggbRwiz5LiUBVpEWdBwpqNIa6GrVwTVzYD8lprwpIyVMRa3r7AIa5hM8qIpdEiqURAdc8LqlFy5XEQbUwmjeIq1o2lwNhSvYxtv1iJHdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L8q36VWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLsGw5kI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L8q36VWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLsGw5kI"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 776E41380325;
	Fri, 30 May 2025 04:47:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 30 May 2025 04:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748594868; x=1748681268; bh=VCWa/tALXZ
	YQ0+TrrhDmxe4DDAKWHUsM4VVmbfE1RKM=; b=L8q36VWv81ai8Ffutdk++ZnWx9
	+fbenqqgt1TPRjUtys5O6lSUyCCG9ScHoDDJjbhK4rxqoe/datvSDSVOU5HuCipB
	rtwE+hWn11SenOHqjOc4i3pr/fPTaQ4FfAwVkmCJHj7dHiFzdtVp3zth/Gvjzku3
	mfMOLDwT6vNHrXOFRn7jRMVczRk5eHwb0S1Y5js4USHOkkU+l2QbRz0Sz+e6pwsN
	2TW/1Po1fwZDofs2xUUpdIikz6fehET522veZmeukfpp93yuEcEmi/JytYBt+JTp
	JqMlEkYwK29hsOV2wDKtVU6uudy31ucRPJmCkbZJyWYFLAmO+Ziec5+clPew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748594868; x=1748681268; bh=VCWa/tALXZYQ0+TrrhDmxe4DDAKWHUsM4VV
	mbfE1RKM=; b=OLsGw5kIP/cHrR0IOA0yLdixgahdA6SNnOcUG2WOQi9eWjKL7YO
	ETNYrAHhL1av/za7gf87d3+48n7wRHQ6I3qCVXztPSYpN70Q0y5R/IJGGWBxGsyq
	tGFWL49KfmJGh04lm/5Xtv2ALEPT0qo5DNrbbOqp+S+sRLjmoeGtytLxRnsVrHvz
	yzAFrxnIYA4cOCra/Hv2NuqpnDSfBsHOSS6D1o5Pk/a6WM9JSFsnIcG3Kc7hxtng
	+7mEJfgdEXFtGZmfhdX3g9fPNkMS/417PzEWWdHpsK4sQX9vdDrQxpMRd6RXTpfp
	kew0Ya/OhsIFfS+0koE7EtbKin9EPv3IJnQ==
X-ME-Sender: <xms:tHA5aAUQIUg5URK1Z06BLqtBoG-crZU68IOSotayIR-Q0kX4WJmTow>
    <xme:tHA5aElsCs2CueIPLwhH5ZAL9Lj4IdWt_gLephIsro6mZL5NSIHGzwiuNGtQjPd0g
    j43ilaZKSqul-XJmg>
X-ME-Received: <xmr:tHA5aEYJZsNjPEaBIPN-nAa48E9Hxzx5eZ3v9vjk1-OgNt1QSJb9vyX9m3F7QuPFPXlod1bf4kqwsEVu095wnrLiZhsm6L1ZBmDCypgA4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtledu
    iefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghrvghnrghsse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvth
X-ME-Proxy: <xmx:tHA5aPVCMmQ6OhFixL9bp0Yf-ZGSuqBT-ITXCwTkKU3DdT9EQ2QrJA>
    <xmx:tHA5aKlkrj0jMzXVGw583Q2NNUcfQnz6rsZz5kpOl5yW-PBOc9HRjw>
    <xmx:tHA5aEdOY8zwLJ-1Eq-ldprHuJ3DRlBxJCMaI-ZseCFkGI1y5Z0UnQ>
    <xmx:tHA5aMGvrWxbcJzvtKmVxqOKrRZvz-T_0cAN7XOK2rpg8KO8TSS42A>
    <xmx:tHA5aBHXjOwZ726qgas-Pi80n4023B4UFdp9pb434VMMd4BaOwQy26rv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 04:47:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b407f6e4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 08:47:45 +0000 (UTC)
Date: Fri, 30 May 2025 10:47:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
Message-ID: <aDlwsM_18nYB2MOr@pks.im>
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
 <20250529101136.16219-1-carenas@gmail.com>
 <xmqqtt53l7cl.fsf@gitster.g>
 <aDlDtbUcX5NA8wCK@pks.im>
 <20250530062533.GA1321283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530062533.GA1321283@coredump.intra.peff.net>

On Fri, May 30, 2025 at 02:25:33AM -0400, Jeff King wrote:
> On Fri, May 30, 2025 at 07:35:49AM +0200, Patrick Steinhardt wrote:
> 
> > What I don't understand though: we have a `MAYBE_UNUSED` macro that has
> > the exact same definition in "git-compat-util.h". Why does the macro
> > cause issues in the reftable library, but not over there?
> 
> We turn __attribute__() into a noop for some platforms earlier in
> git-compat-util.h. So it doesn't need a separate #ifdef.

Ah, that's something I missed when introducing `REFTABLE_UNUSED`.
With that added context the patch looks sensible to me. Thanks!

Patrick
