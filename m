Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BD1A262A
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398024; cv=none; b=mZnsMLGMA9JLYIo8NxMbpwzCj7X7d0LdXuaei0/KZxJa7MFu4Dg2lImBVLEg3aZ8WG6mtUwtVw2SJm8CghQLWJNPWGXeto0+CATVjVuN1AbZUKbSoB5L5cnICIh+1a3vUHwcko24/eCZyf3EqiU3CstPjPhA83FOZ0J6KXk7wro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398024; c=relaxed/simple;
	bh=dxbXDI6rAZtR2htwu60jSc+rSEnltXxdECVwAuxH7Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLnBD9RcLDHXjFbMOnYLoFS47pms9HoQHAJnCEf9AMF0I3bXNUKnjbelxPf+40o/6ik7gwzYY0sMcVktPp3RYK/tALrbYotdWgq8yFRBtqlWE0boBNX2zK4iUTUvJ8qMpNGyDDQrfbTec5hdExHClYfBRNQZbgEriv8msuSSMQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkBMWDHF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kp62bFRI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkBMWDHF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kp62bFRI"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3C80140015A;
	Tue,  9 Sep 2025 02:07:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 09 Sep 2025 02:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757398020; x=1757484420; bh=ny4XIkqlIr
	27EnfUpPb2IGsTO+aGwjyceRvVysvFJz8=; b=nkBMWDHFUWbty7eRhLw+3sxyEo
	nSsGPif0qi50S2ZNvD2uUOtj2iqjpoy+yJaH0wGJQ5Vb2ReD7BQuf9Qk/8k1UtLy
	1cRlGkjTZkRMi1mUOApAXJGTjHLgxOxRARHfAteU4chxF5sW/djI+LkRAcm6kDmS
	3jUkupF5vSdRgvpiNGPbVz9mhRF03o7RZTJCXCFd4D9Pm+Mdi38aBQfu7fOzwLfO
	aVu8RzmEfaGLQv0DSPK2BElSt1vH+L6H9A1cjwrMP6AHdkCTodDutLtDhcsL+Lqn
	jmIEoIxseQ1HL5FOTRODOXcy5R22RBJJXPqKCjakJuaDeB/xDGy8B5byq0PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757398020; x=1757484420; bh=ny4XIkqlIr27EnfUpPb2IGsTO+aGwjyceRv
	VysvFJz8=; b=kp62bFRIXFmwPDSZVup0uIiAIlnDK/DTCshSb6C1R/HTpIkY3fv
	EKIJiaWLCx/LzpCX0OalElLFeQX3mA423PrdmsdduTQLT1KVi8xQ7aR3XatnGs7J
	k1E3B26GH8wpGWvTtgRLqrUiznhdvnMIFlxvV7xZ0v7YkxzSKeT9aed57eBsys5+
	zXxho+x6KC2qVErdS8woA3lbaZ379G7pX0V5TiFzuvTJrz1yRxmNooHHeDc6SJJS
	7DVaJwmKbvEHzrm3InN+AwduaaHituKjbwEeEO1Ns5+Rvc0gWhvdfvL19Fo8o6yQ
	Dh+BIrh2eeVnbu/HzM7zuQa6iZPy9FF2aqQ==
X-ME-Sender: <xms:BMS_aKfuuhzFwX5BLDqHhrleDSE7t0OZNcO6N_iJ4t1wPEdRRGCIkQ>
    <xme:BMS_aLEiV2wP40GNwxNaRD9p8dPi7fms73iTVxL84Y95qbo_BSuODB7MBHDPBpHVQ
    8m5zImZeqKop28Slg>
X-ME-Received: <xmr:BMS_aIdMAu75ZWWg5mRKM9gLaIUl-giq3IgnzqDGaqf0LT_aYjhIAu2HBiJmP0yWz5bTTXaakpJ4sm5O8cpfaT3oeuQc3rhkN-VCLL1LDAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehishgrrggtohhstggrrheslhhivhgvrdgtohhmrdgruhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgv
    th
X-ME-Proxy: <xmx:BMS_aFHpAnQWxP67t8L6D0uMOyJW7nsPtQyRtsxhLkSB-BQNYvhZrA>
    <xmx:BMS_aBXetroAWJYesNk2502y-RPmiQixPALJijtbv9XlWDI0oiIcrg>
    <xmx:BMS_aMJ6qSrWPhTrCJqlL9LYp3HXNEgsNeOqbKKbDNmRWSxfHq8fIA>
    <xmx:BMS_aJ-ea67yCjfLMdkaavRwncfgtqADTbCFW_4p2GoicgOdMZQytA>
    <xmx:BMS_aFDKQ0Uy4fLrCKLRJ1BNljvVin_UukGx5E6ZAIiEFlOIaTd3piGN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 02:07:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ef4c94a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 06:06:57 +0000 (UTC)
Date: Tue, 9 Sep 2025 08:06:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Isaac Oscar Gariano <isaacoscar@live.com.au>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add-interactive: respect color.diff for diff coloring
Message-ID: <aL_D-quAoabKxhCN@pks.im>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
 <20250821071918.GB1839835@coredump.intra.peff.net>
 <aLfs7wuFpMhg8fK_@pks.im>
 <20250908161648.GC1308482@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908161648.GC1308482@coredump.intra.peff.net>

On Mon, Sep 08, 2025 at 12:16:48PM -0400, Jeff King wrote:
> On Wed, Sep 03, 2025 at 09:23:27AM +0200, Patrick Steinhardt wrote:
> 
> > > +static int check_color_config(struct repository *r, const char *var)
> > >  {
> > >  	const char *value;
> > > +	int ret;
> > > +
> > > +	if (repo_config_get_value(r, var, &value))
> > > +		ret = -1;
> > 
> > Not an old issue, but should we use `GIT_COLOR_UNKNOWN` here?
> 
> My initial reaction was: yeah, we could probably fix this up in a
> preparatory patch. But the problem is much deeper than the
> add-interactive code. Nobody uses GIT_COLOR_UNKNOWN at all! Even
> git_config_colorbool() just returns -1.
> 
> Moreover, it does not even use the ALWAYS/NEVER defines, but just 1 and
> 0. Making things even more complicated, we sometimes want to consider
> "do we want color" as this always/never/auto/unknown set, and then
> sometimes we collapse that (using the same variable!) into a single
> true/false value.
> 
> So using that consistently and possibly switching to an enum is a much
> bigger topic. It may be worth cleaning up, but I don't think it's worth
> derailing this regression fix. In the meantime, I'd rather keep this
> code matching the rest of the color code (it's not even really adding
> new instances of "-1", but just shuffling them around).

Makes sense.

Patrick
