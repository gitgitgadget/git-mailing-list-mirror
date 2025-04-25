Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013022FF4C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745574339; cv=none; b=MzEuKdUoeOFFCozfAX2m5CAHyAGTKA2gm0u3ZlVZ+gw/q29xdB5Nn8APa35itmgjeyC+C3jIUmLu7D2mjT1AXlc5qaVCf3P6iweTKQvrfgOFMc6IRft4EM5CNSe52ehm4ENeN9ruMS7O27wIyC0VGuaDmdkjLodYbR5hv7B8Epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745574339; c=relaxed/simple;
	bh=8uOTCbJd3QVA1xqIx4sXa+uI2hFWGSVHnkBDra+LO3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlZQbkkcopIYi7E5F7TsRXCGQHnIYmpWMbHFZ3inXFMP21D8rZs6RkKq8ox0TLZuO+/zQYidNRO+0JdXJJcdbOTMYvxm7BgUS1Cf8KZRSu1e5gGdEK2zjQ5bxUmE/YPmATgAsC4G3CQsPnLvCuOg7s2vr7wwfrQPcpHpYQl21jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNEHC2YO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b1YNtarQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNEHC2YO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b1YNtarQ"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C2BE1380213;
	Fri, 25 Apr 2025 05:45:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 25 Apr 2025 05:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745574335; x=1745660735; bh=X79/mlCGuA
	YuIa6/30ruPssN7VB2wp3tqduYNJf9+oI=; b=bNEHC2YOxaRQo32FRBVHCVLKo8
	gsqFHTt8bNjYLZthOitlDgyl+AzIorO1+bydsO/ITxnQQbEIzoaZF5NwBFH84wgM
	e3qxk9mZHt/AMycO8HwY69kl11150ug7xLBGZGvCjOGPcqQy74qoih9UCytOvwE1
	AwOEAgPPrtfXQIHH2zTBUAskaHiQT40G6GUhj/qjU3Wg4Fx2rAV7oC/rzW7givSO
	9pBcJfdoge1HBhRLazfobwUSodVMNnIqXYYZgIJLQ+2ECPB84vpAOj3ptmfKzfP0
	A+3G4fJKNT+gTz2zbE8qjBf53aIzdirJ4nV4usG45abCQbUVQ5rwK7ug0oyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745574335; x=1745660735; bh=X79/mlCGuAYuIa6/30ruPssN7VB2wp3tqdu
	YNJf9+oI=; b=b1YNtarQbCdRhl7tYeTzM7N4fX5Ql4UYCUTYhKSsO6Y5YQowfot
	sERryksT99nD5exHfCK8aUXMWra0LoBs8LoObKSwF+aKW2tDwEOIsL8o6IS6byj2
	9Uy19lBeZmzvKQt0gaGc5XZBkJq8L1Hs8LJZbARrOojLnt9qJUCkXgzqXDabXZ1C
	xvOOQXT6+T4tLxDVEBE/gZsavilg/Zu8R1V3JNIY6y/bDbHbeaGxODMYDvm0gNCl
	WboBH6NiFappXf2LgnZ1oQl4faCorD4Td3m2QNgSmy9JStEdR4PmzYum6t4JyQW6
	pbbz8GXvnWigD2+WXt9olu9dLZzzx2TjvkA==
X-ME-Sender: <xms:vlkLaNrEQ1GFeVuskQcXt-Xt5XdSjRPAGhgOI5QApVIIrl8ft7PkuQ>
    <xme:vlkLaPrIpEmVx-PlOXLmhKwPorFF1Vyc7vvwV8yOzEssTaiTnPcIkgUeQpKLkUSNQ
    RbvEMJgp5mOu1jIMA>
X-ME-Received: <xmr:vlkLaKOGknG7UFdBW855BTaQUfzFqN4VbmqHkslybb6MbkxEe0qBszBLJ15m0lePzzz2T7MYPErmuwM-R48dZy9s17v002r4gsrnK18u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:vlkLaI4xgb0FANvkbbsEHB1Mh5SJSg-M0rH-U25SEQ-Wcl9oIcZAUg>
    <xmx:vlkLaM5xs9HGJNSi4lTawJJeD4c2Ye9oZPFp88Mt2siJw9zFf0nFZg>
    <xmx:vlkLaAgldZBeK8F43tzN0QLX13uayP8eauvj2hOrN-h1REh-izdOGA>
    <xmx:vlkLaO6FI0eosBYIIThauLttMYSeNWnEka9Yxo7NFIdUiasJqiKbig>
    <xmx:v1kLaGblPU1zS0WaDX37gpaI4hda4snGMMthdpMQZtREJvVW683xUsQv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 05:45:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8feb9dff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 09:45:30 +0000 (UTC)
Date: Fri, 25 Apr 2025 11:45:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
Message-ID: <aAtZuU6Qqfag6OHj@pks.im>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
 <aAsQwSfr-YvS2Mvh@pks.im>
 <090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>

On Fri, Apr 25, 2025 at 11:34:01AM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Fri, 25 Apr 2025, Patrick Steinhardt wrote:
> 
> > On Wed, Apr 23, 2025 at 05:40:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> > > diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
> > > new file mode 100644
> > > index 00000000000..db7d1c3cd1f
> > > --- /dev/null
> > > +++ b/t/helper/test-pack-deltas.c
> > > @@ -0,0 +1,140 @@
> > [snip]
> > > +int cmd__pack_deltas(int argc, const char **argv)
> > > +{
> > > +	int N;
> > > +	struct hashfile *f;
> > > +	struct strbuf line = STRBUF_INIT;
> > > +
> > > +	if (argc != 2) {
> > > +		usage(usage_str);
> > > +		return -1;
> > > +	}
> > > +
> > > +	N = atoi(argv[1]);
> > 
> > Is there a reason why we don't use `parse_options()` here? It might make
> > this tool easier to use and extend going forward, and we wouldn't have
> > to care about invalid arguments. Right now, we silently accept a
> > non-integer argument and do the wrong thing.
> 
> I think that `parse_options()` would be overkill here because:
> 
> - This is a _mandatory_ argument, not an optional one.
> 
> - The required data type is `uint32_t`, and `parse_options()` has no
>   support for that.

Support for that has been merged just this week via 2bc5414c411 (Merge
branch 'ps/parse-options-integers', 2025-04-24).

> But you do have a good point in that we may want to validate the data type
> (even if technically, this is not a user-facing program, it's a test
> helper that is used under tight control by Git's own test suite).
> 
> Consequently, I would suggest this fixup instead:

But in any case, I'd be equally fine with your suggestion.

Patrick
