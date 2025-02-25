Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2F256C8B
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464672; cv=none; b=Cyd9OfoxoEVMef8zfLNATT1BUyTGEt6HZgO7lV9awWr0BMIVwfNYHavnsj2o4anQPBxeYqT8CxNbv77PJPKaeRB3uxVVtqfo2KLwxTBYiNxqaI849KWu/ZZO+ksixed2telGF2oFi5Ksa5TT2LbRTL0AAPFUL4p45pZ25fZKRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464672; c=relaxed/simple;
	bh=1MYDSP7IIe+5rcfeb/emoPYBYCP2wSvsyw4N6Z/PP14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OycJ3q73ZOQ5xrqs0YjM2QW1l8ATOwkzZgDxmVwVtZ4+eQEytaTMsI8uSsZaYmPA/aqa6zFa7t6yPzaeEzsCgVYl343zEUIe7icl+LqUKsG00VIEg28CMsQAw0ZGeyh+qeJLCnk2cTCf99rKmUpTm3KC8jhb04MrqA0i+RKKnGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WilE1C6E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t/IwJqvS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WilE1C6E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t/IwJqvS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AA055114017F;
	Tue, 25 Feb 2025 01:24:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Feb 2025 01:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740464668; x=1740551068; bh=NTqleIZLdq
	h/wfTWvq8TJRkfK7YD4L4aWqOERQfAuCw=; b=WilE1C6EZQgRqzOWxPdRTWmxHX
	bZud5d/l3qHfkNURlPqI7/8cW4rwdwqmAhoKoy3WkYR6VsVm6wh4cKiJGIogY9Kg
	lJ8H1lFN706gEvSpfkQ/28zIIEsL5L19jRkzXNFl9aPCABw6z+KZYDxQr9ypY7/d
	wepbPKw6YTZFuqnx3ChcaBJexL1Cjewf7egS6EE3VUnbF+v497QuvPx0Sf7U4Z3A
	/VUha0+PA96PoqMif8QfVGeIXmIUY037nYtsstwJ2B7OiNn3APSXjoabtfgOyncF
	eB5OXoSPGWtXrtWW4Xune5UeFFKx4EWHRuAwJdbkEZinxPxjWtoZiswaTG2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740464668; x=1740551068; bh=NTqleIZLdqh/wfTWvq8TJRkfK7YD4L4aWqO
	ERQfAuCw=; b=t/IwJqvSLi0ZsZb/3JUMzK7H2Zxy6Urj8tPdlIdG3HB5HxATwal
	fP1mVixRBLraBCdi0tNOO46kjImPboCMm6h1pv2p+5O9qYgyq02EYH8xFyc2YzJ/
	qClJWaURNBjTJyChmUa3AonVjSqlknBmmhyzSlmdqwRDq/G7jnW9PEepXQiioG9t
	+z1Rpm2r7sZ7tA0IAV08lK3My4rLzxgPODPSsUE8sIBnXMhJBZkcRJBAWc1CZQw4
	SpfdYrCBGk3Bqvm+ttHW0GXBa4tOj8J8PO9A0LfFQYjGWg3nt2R7iOKux1Z/zpGA
	l96B4xKmRXjzxA9/2+WsQmQGNn2Bam/0oAg==
X-ME-Sender: <xms:HGK9Z82sll3Z4Fd-IAp8WSQIx3MpJQxI1uE5b8vaLLDHbAWv7M5lnA>
    <xme:HGK9Z3HdWZOIiEtttCs0gSJNJS2xoXBVNQxVWslGAsWisfqCoSi80ZBp6C-L3ELbV
    A1FNoO_npySYP7zTg>
X-ME-Received: <xmr:HGK9Z04nw5N1vvmEl1o3wxC2FWgIT311Oytt67O6ncolik5lRrL1zGNdVVEEj240M6g_139ZszfJx-iEJ3aUSfKWyERpPb_rplfAZ4itKWS6ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektdeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:HGK9Z108M2T25Wsz0pDglZFhxzI4_Tq7v0Z8HJU_AgjSdxeoVwdaPA>
    <xmx:HGK9Z_EFDDr5Z41-mzRRmYgClLZ58DHtNAu6iArT7aijZe4o_lM-iA>
    <xmx:HGK9Z--ph30F7goY93fFABh-CIIbqfqPbP8g2cWNnqhh7Uy_xDyIeQ>
    <xmx:HGK9Z0mmYbK4GxK7GwHkkrkDFPamJA3MwZCnrxxAUBuxwlI5GV0d3g>
    <xmx:HGK9ZwOPyVQ5gxOEBMEFLVr6RqYPwHkc_juzo4CDpQvfu7y1wpGoVKbN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 01:24:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c62a53d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 06:24:24 +0000 (UTC)
Date: Tue, 25 Feb 2025 07:24:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
Message-ID: <Z71iFPGHNY60l-jJ@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
 <20250222072048.GA3096947@coredump.intra.peff.net>
 <xmqqr03n7218.fsf@gitster.g>
 <20250224221914.GA193356@coredump.intra.peff.net>
 <xmqqh64j3qkn.fsf@gitster.g>
 <20250224231024.GA729825@coredump.intra.peff.net>
 <xmqqcyf73pgl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyf73pgl.fsf@gitster.g>

On Mon, Feb 24, 2025 at 03:14:34PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > So the only question is how and when to convert from time_t to
> > timestamp_t. I think our general strategy for when has been "as soon as
> > possible" which makes sense to me (most of the code only has to deal
> > with our one type). So I think doing it right after the stat() here
> > makes sense.
> 
> OK.
> 
> > All of which is to say it might be a bit more than a #leftoverbits.
> 
> OK.
> 
> Thanks for a dose of sanity.

Indeed, thanks for catching this and the discussion! I'll include the
fixup commit and resend a v3.

Patrick
