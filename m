Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A085306B3E
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200451; cv=none; b=HLFI2tNT+z3o54bFR+GEXyNzVj1X2iys5VYAVgeqnuchmqfQJMOCzva+oABgnIgY76ra1ZvT/5BnAtbOva/ts9LVRwyuhbb4iu6DSJZpgKjQNlbFCrNzmDRKlH8GLR3LEuQ04kzWqdlb9wqLeGsW9XvRm9768sDxzz2nbZo6tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200451; c=relaxed/simple;
	bh=oOoOQ17JlLSiivZk0bRP/sJsxpevgf3/Dwqf7QI5BGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0iiSBCwgF9xm+9nmMDnX8MDML7SN7ge9ReAAd1OR4LwBaEBDyrjbbMO4F9wlHe7gL6JILMeghIZ/JWcKyS0OXsK6Zx5+RyCS5YxeC9QefqtG4kmc6+mmaFDe9Lb24LuBMEFzOZTSeCr/vImynPY5mF4DC66XoI6AFrWsXInYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PttQSqln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4Zqvk/7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PttQSqln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4Zqvk/7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 37BE1EC0362;
	Thu, 18 Sep 2025 09:00:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 09:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758200447; x=1758286847; bh=eLYJ8kVTHC
	aOHgGs63sp4EfG0qnd4ArACJhbKKDPEjM=; b=PttQSqlnvvpxDOVRfHOphc29gN
	VA5IqPmEPk67nF1up3n0fTF5JiP6VmKPBU8yVGjmA9iX7XFYX+Pg418oVznkxW4r
	YeQ7ItXD7AZPq1VwT5NBEg5oCySpG2HxDce0W5fHee4HPgCFO3AZtyC7ZeJEEflC
	mrB7QP6YLNBBPLaJzFPkEdu+dFENt0l9rJn2EYVRVBPCG240WuhBaGk5GJPXBaiJ
	o5WgfAgpPpQ+UGtH9PWgoHt5RRKqJLl7rPuzCpFfrl2zow0o4rL4icvnnh6jHbHl
	2SxERIWYBw2lk4hUKo4HiDI1yec2MnJwBlPURXraLEY8jSBEbdKZ5z6MHtnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758200447; x=1758286847; bh=eLYJ8kVTHCaOHgGs63sp4EfG0qnd4ArACJh
	bKKDPEjM=; b=P4Zqvk/7jvh6l+EqJKCBHT141FV/RvAli5aTecoNtMhGuh94htB
	jRdURYdhAWhNPK4WrhlvFdhm0b9iKNHTHPexJtsrfz/j3cf+whxVOc/xT+d4KPvV
	fO5B/AkM7Y5cgGuhgCdAk7bkYiEHxZWEY7O++2uIRkV08h4PqqnT8VDuXjrdHf3W
	p9kJ/KWpSQUa947oPiAQDafld9CYwHwedNp7yvRViBrv4LULXihYMeEKvrFHLsN6
	2Zt5D7OunhgW4E8S8vfzy02PrKyCg7Iwo8AuGi7lTlc37GaEPjNsZC7wc4IcbRO2
	H4JSHLel51APVwHINSo95vPS9mm8BJmrhTA==
X-ME-Sender: <xms:fgLMaMPznAriYQqsJWCmPcmrggqxKd3PY0e_jm3xXGRe3339BiVUFA>
    <xme:fgLMaGMEF47_tAc4yDiTq1Y1klqZadvXh4wO9Cz6I2UnltUFi28uTP_r5c0yGcvR0
    OWHFno8jp626ewhJQ>
X-ME-Received: <xmr:fgLMaMtTzPsiF2onhIK5SDOzQI52SS8ZMDNf8QV82-ZZ8fPwlavvt7hdLhs6KqyIVhmXoyC-npkWwryj1DFr4uR9gIvenvJvM9l2gVuUGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetff
    dugfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtgho
    mh
X-ME-Proxy: <xmx:fgLMaAWLzXybB7h-zG9VmL2_TBMA1cc3wbw2D0MLLujVafmbWlreIA>
    <xmx:fgLMaEswmFe_sQGQLeH7rvg5xZMB7MNQZWrKDH0uM0ey33EzlcP8Sg>
    <xmx:fgLMaMX7JgS3hhvsNYxSCV0yARjAW52Y9BmIJASb-dXkTQYR1i30uQ>
    <xmx:fgLMaHnxlh0Qcam_vZEaUnW3zYV9nHRrZZabjflsG5f-cjV4HbUjNg>
    <xmx:fwLMaJjqIjhEX3nC0cfp6aonE8HK0_nA5xj-rwehzcHop35FNzrwF5fE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 09:00:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 26ec6de8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 13:00:44 +0000 (UTC)
Date: Thu, 18 Sep 2025 15:00:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Change] Git build issue on NonStop
Message-ID: <aMwCcw-6l1x85Wz-@pks.im>
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
 <20250918022912.GA1135133@coredump.intra.peff.net>
 <01c601dc284b$24496400$6cdc2c00$@nexbridge.com>
 <aMuankGhjxXNKErO@pks.im>
 <20250918063152.GA1168297@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918063152.GA1168297@coredump.intra.peff.net>

On Thu, Sep 18, 2025 at 02:31:52AM -0400, Jeff King wrote:
> On Thu, Sep 18, 2025 at 07:37:34AM +0200, Patrick Steinhardt wrote:
> 
> > > >diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c index
> > > >80c5359425..f408af850f 100644
> > > >--- a/t/unit-tests/clar/clar.c
> > > >+++ b/t/unit-tests/clar/clar.c
> > > >@@ -875,8 +875,8 @@ void clar__assert_equal(
> > > > 		void *p1 = va_arg(args, void *), *p2 = va_arg(args, void *);
> > > > 		is_equal = (p1 == p2);
> > > > 		if (!is_equal)
> > > >-			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" !=
> > > >0x%"PRIxPTR,
> > > >-				   (uintptr_t)p1, (uintptr_t)p2);
> > > >+			p_snprintf(buf, sizeof(buf), "0x%"PRIuMAX" !=
> > > >0x%"PRIuMAX,
> > > >+				   (uintmax_t)p1, (uintmax_t)p2);
> > > > 	}
> > > > 	else {
> > > > 		int i1 = va_arg(args, int), i2 = va_arg(args, int);
> > > >
> > > >would be sufficient.
> > > 
> > > Yes, it would work. uintmax_t is part of the standard set while uintptr_t is
> > > considered an extension. Not my decision on this grouping. I'm setting
> > > the -D in CFLAGS to see if that works, I would be fine going that way, 
> > > although better would be adding it into config.uname.mak in the NONSTOP
> > > section.
> > 
> > That should work alright, yeah. Peff, do you want to create a PR in
> > https://github.com/clar-test/clar to fix this? Otherwise I can handle
> > this.
> 
> I'd be happy if you take it from here. Note in what I posted above it
> should probably be PRIxMAX to show hex (not "u").

One thing I missed: `uintmax_t` doesn't work on 32 bit systems:

    ::error file=clar.c,line=879::clar.c:879:8: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
      879 |        (uintmax_t)p1, (uintmax_t)p2);
          |        ^

I'm inclined to just use "%p" instead and accept that this has
platform-dependent behaviour. Means we'll have to drop the test for
this, but that's the lesser evil from my point of view.

Patrick
