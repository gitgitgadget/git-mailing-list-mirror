Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E232DE6E8
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532034; cv=none; b=hHGNbI4knWRiS5jxjwVDwiOJvAScQZTlBQA1hPd6wQ5lizGe0YM0vbE2t+pQ1pdXgox+Pa234cUVVnJ7apycjaKYoHXFUDHYZMcSYo5l9zJmUWG0wHamriHFr51c6/xBP/E5GoAY5QZEyk9XUhNgUTMnvkGj8XtpukQVX9vczFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532034; c=relaxed/simple;
	bh=4T+FZ2QP5C84QJsH2b6eh/PugqCO02cDtDjYiBts3Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgwK6Jh80o8OONRwk2An8FyCVrqy394YFyIcn/4RebF27N++UmPI5F+u2fbddosE7ucO+1hqd9JClp4ET8qXLtwgQao9J5KXw7SNqXxIq0fVkIrNnYOmM7tjyAF9ctKyMYaXxygmODcZVUQyvDPeT+xzJMdEEFNPPc7lSlcKsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RYNPr/SI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ni2BsI0V; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RYNPr/SI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ni2BsI0V"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 576087A01EF;
	Thu,  3 Jul 2025 04:40:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 03 Jul 2025 04:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751532031;
	 x=1751618431; bh=dya59Y9MzcONr4+i+3qgwot/47OixIpYo0SAkm2+WFM=; b=
	RYNPr/SIT1GUVmGHBlE7F6mGs8KNjjeu1wJ/qYve2v+0hpzkwIqO0ate35y888rT
	HQc5KtFCkqlzxLGo+9zv7J3H1+Ermn0GdgTYLlmO290LnhUcPjY6QZrwzEliY/ee
	VHt3wnPMnC2xpj94Yp30kQKVclUXT7lWC3jmx0gnpmVHtiZ6Sr3zmsNDBzzxe3Qd
	eriek4gHfrGZE88dSo5ZQBsiJ/KFVeWKL6x7+CuUgjifDFvoE/iCkW9zJhuah03O
	aE8MEgN7DkieMdmZIPh7YzR4oQgKbe5ehbNK2Z3cJ06B2I8udgNwQPaChURkVhjR
	M4HRN1OV6MPTKRVT6oPVaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751532031; x=
	1751618431; bh=dya59Y9MzcONr4+i+3qgwot/47OixIpYo0SAkm2+WFM=; b=n
	i2BsI0VrGyqsZcM0GsUYW6taaMCi23C/iqE8Pi4GqiUglOVqc3Ep7UdZNvd+hccy
	uego2oUV9SDBlBHa3D5cHFlcGfBOAETkqKxMjT8cnyEsxNQ94q7xuKIQwkvdwTNE
	hrDS0u2CrfGs6wHN79af3t6Ktd9cTJcPzXqrywgJaXCpcU2gXNviMb5yFS5f0gVU
	/MrDcb25fJh2GhLBD25+douQFcj10iqqoWounUQfbvm0iiqYHPunFiTYX4W3Y4ay
	9rAWhqzkPXo2eo3Al7uPAk6ggOD8MG/55IuhRUcF8qeiBQv4TIsPZlZOldncLiia
	sXCnoynVCPhbzy+H5ONDQ==
X-ME-Sender: <xms:_kFmaDzuXDgAAthoHahzr3JdhYJ3ELTgc7DBCA3bUci-NJPe8-ad7A>
    <xme:_kFmaLRz4WxG0uQ0RknwHUPS9638VVzYrGuRxUiBxPDWeaibDLkoXnN4o08KJKXO6
    unPJjahrGyPOFJAUQ>
X-ME-Received: <xmr:_kFmaNVTQqN5SdIuTUPxMIHiJ6DkvjOBy_oHciEpa9KMIFd6f8ZZyINxXNojs-TzIfMr_uj86VylxFegb6KXYzE-3Jo9uwLXrNCJ7J9aNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgrghrghgrsehfrhgvvggsshgurdhorh
    hg
X-ME-Proxy: <xmx:_kFmaNh7zl0_CPwaGfR_yywGZ4sDsu2fHl_yHqzmgKYciZI0sL5BBw>
    <xmx:_kFmaFCPkiteAlQwUxsOjZSLNzs_dh2AcREC_YNY7qkhdd1btPgq-Q>
    <xmx:_kFmaGKBzzgvy0-vZ2Kg91OQ8PCj7gd_S6aXBXRRkVrCA4r0aaReHg>
    <xmx:_kFmaEC0jVNyaWIz5vneaGuQWcyxQ3KZ6qh9sCTxYw4ExvcPCWEqHQ>
    <xmx:_0FmaOflNKzlhxQfP-PjUA3vFImyscBfuYANzuK49zXnvSHdC3t90HxE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 04:40:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78f6f80f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 08:40:28 +0000 (UTC)
Date: Thu, 3 Jul 2025 10:40:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Renato Botelho <garga@FreeBSD.org>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
Message-ID: <aGZB-DYo1nleB0bd@pks.im>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
 <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
 <c8f4ae13-8578-4db3-bee3-1619f03428d4@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8f4ae13-8578-4db3-bee3-1619f03428d4@ramsayjones.plus.com>

On Wed, Jul 02, 2025 at 11:33:23PM +0100, Ramsay Jones wrote:
> On 02/07/2025 12:28, Renato Botelho wrote:
> > On 01/07/25 17:03, Ramsay Jones wrote:
> [snip]
> > BTW, should I start moving the port to meson?  Is it the default build method now?
> 
> The git project only provides source code (i.e. the project does not
> produce any binary distribution packages). So, each 'distributor' can
> use whatever tools they prefer to create their packages.
> 
> [A long time ago, we had some support for producing Red Hat and Debian
> packages (if my memory serves me correctly), but that didn't last long!]
> 
> If such a thing as a 'default build method' exists, then I would say that
> the Makefile (without configure) is it! (Meson is the *latest* build system
> used in the project, not the default).

Right now Meson is still considered experimental, as there are still
some things missing compared to our Makefiles. I will address those
missing pieces this release cycle, and once done our Makefile and Meson
build instructions will both be considered officially supported ways to
build Git.

> >  Is there a plan to remove autotools?
> 
> At present there are no such plans.

There are no plans to remove our Makefile right now, but there is intent
to remove autotools once Meson reaches feature parity with our Makefile.
It will probably still be a couple releases before that happens, and we
of course still have to make the final decision to actually go through
with the removal. But it likely is to happen in the not-too-distant
future.

Patrick
