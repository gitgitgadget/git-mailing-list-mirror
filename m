Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9D143722
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358627; cv=none; b=TmuW6xbLGpTM0OE59x553v7DfrL4TbI0bEWrCvqrLSTdGKqVSuKe0Z6qlvgZa8HdwwnvFsmLGH72n6nfKa3DIrOBcHuYF1GkFHxo2B4QopmY32GGMwicwRYFabS7xt+kJ7jm3pdXpI54EvVxmLv9uqkiU2gPBNz7Ldb5KS/6Rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358627; c=relaxed/simple;
	bh=1QpwJmm4WgtoHiKALicG4sv03E57uzG6HJh21k92e7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ6SaWdPQgWvrWVOeF/NLphmPc+9ru6nOPSr0ctknSCdHSD8MYcAhaSwMjUiQJoz+IjHRRyMOnkCkT7Jyhr0QYG8S46QiIQIQHmPYALipKDa98L6+B1+Mv1KYSRnqv+HkZVe+hqf/C1HgnDP3+Y0u9VXGSfRaaf//Ab+pXHWFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NuJNccKV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EEQFYfVZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NuJNccKV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EEQFYfVZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB3C6114020E;
	Thu, 26 Sep 2024 09:50:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Sep 2024 09:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727358624; x=1727445024; bh=zCEjLb7TGL
	BoEy3qxdmQMoeet7XmV4W38x6F7Uuf85w=; b=NuJNccKVd/d1ZYTTuZ2e24Zedr
	Pyjv08yx4940s/xU7KJHMzfvoCmOn6ROo5vjtu+uzj1Cwnl6OTrpcEIU7UHueyIM
	ht7o9U5XfYhUlnEh1ungiJERUxZnUBjQmRN5tUetx8iMa/g3x31SPgU/L78Qqg0q
	/MDGSMzJ8bXl8vjiPZHqlJruItyQF8LK1eqom8HBfqPgP3fXhjK5h3C06zMR4sZQ
	FmLoAQfPXqz3UMtPabhAMj5d2wE07xgqLVx0DuopgTnMQtFILbiH/uaJojcZ6dFW
	ZtntT+CzfbMzK73sHu16AvRemq7ooZ+mYSp28UseGVD+1gjyf2nxWvN0vhCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727358624; x=1727445024; bh=zCEjLb7TGLBoEy3qxdmQMoeet7Xm
	V4W38x6F7Uuf85w=; b=EEQFYfVZdHcxzfI49oSDdQhmq+dwLxkEEeTtY56ppdXs
	QUB4bDwTfoqXul9tfCTYFyikJ8tuRW6OI/XbukF2OS7zGXsI8eQQkAlqqH4xjq0V
	ROhhw/aySedieVgALdScx4ns27n3hLjq9Bw+3P2Vk15GdsDgse0sXr7TLDCxDhku
	LSid/ey6UzsNPGxhjaxPiklcKYzCTfw9vYur3OE1O0JpI1GY4A17AavsKiz3/whT
	Pmv9NmEsNtavDgv84f3Foa0KVjspypApcE8efSRMPr/IQQkcLkIUdgGqv1hD27+/
	Fv+FNR1z5fhSuABT7qjyP5krT81ghPmutmtNtstprw==
X-ME-Sender: <xms:oGb1ZvF3XrIGB0aUpu1sKJ-W9XmAg6SQ-6LUK0c4HKStWAh_cALE5g>
    <xme:oGb1ZsWzHaofz-a_FbdaJLTov6P6S48NtsVAfdMVyf214oc7wBOLZFHLqfj0Vq01x
    PowLYWsYHktQkKYsA>
X-ME-Received: <xmr:oGb1ZhLhJKWUyhjAZrLTYu3ozNODeTCM5sWQVhsqw6jVEXJ0w_H4M_7tcL-K2aNUgUDqq2gX_ja3Px_4p8Gxlktp6RwFfLWY9_-B3CKyfEXlug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oGb1ZtFsZdDWFGskh-gwF61BvAfypKzTXiC0XjxX7I2TG4EQ6QbkxQ>
    <xmx:oGb1ZlXf4qXWtYcyd58yxVYbVAv3MHpszw2hFFPqR4zo0kzeoDESCg>
    <xmx:oGb1ZoMRgo_binrbHNLw8_PahQ2JMUfM-H-w7Eeqczc53rAZFeVK8g>
    <xmx:oGb1Zk24fieHFFG38jbZHnGujndEXFLMJG7_n4OrJtCPWBQZwLaVTA>
    <xmx:oGb1ZiiiCBq5rZGAVMEys7Jww4OhOhCCLtZwGUe1EGsjSqn_03OdOkee>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 09:50:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6f86987 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 13:49:46 +0000 (UTC)
Date: Thu, 26 Sep 2024 15:50:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/28] http: call git_inflate_end() when releasing
 http_object_request
Message-ID: <ZvVmnCJNRY_V0a8a@pks.im>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220213.GO1143820@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924220213.GO1143820@coredump.intra.peff.net>

On Tue, Sep 24, 2024 at 06:02:13PM -0400, Jeff King wrote:
> In new_http_object_request(), we initialize the zlib stream with
> git_inflate_init(). We must have a matching git_inflate_end() to avoid
> leaking any memory allocated by zlib.
> 
> In most cases this happens in finish_http_object_request(), but we don't
> always get there. If we abort a request mid-stream, then we may clean it
> up without hitting that function.
> 
> We can't just add a git_inflate_end() call to the release function,
> though. That would double-free the cases that did actually finish.
> Instead, we'll move the call from the finish function to the release
> function. This does delay it for the cases that do finish, but I don't
> think it matters. We should have already reached Z_STREAM_END (and
> complain if we didn't), and we do not record any status code from
> git_inflate_end().

I had to read this paragraph multiple times to understand it, as I
wondered why you did end up adding it to `release_http_object_request()`
even though the paragraph claims that you cannot. But what you say is
that you must _move_ the call, not add it, and that's what the patch
does.

So yeah, that does make sense.

Patrick
