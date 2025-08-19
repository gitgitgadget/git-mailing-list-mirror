Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EF2749CE
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590727; cv=none; b=DhbhffmTyKLtObSNDll83ktm50N97J927psOrZHC+HOmXOo77J3WussLQf5X3FNu00kvZPVeDMrgIZKmT1yzy70rXRnB8CZW8tehnMMl93qJFgLBIm+0AIQ0pcteMYsAiKBT+KbwaW3PXMtGmv8am/QlkAmn7wHgRx48adxjbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590727; c=relaxed/simple;
	bh=k2nUwQIn3kHT6ZAn0VVpjiuuFy2RT88CRBkQFd6s3UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRJU+8MfD40gttiAQHDrNvJJnp9iLpjIaK/7dX92LzB3BGeo4WdOmYX07HCW2SMUScJhBNSBqUunYJNONTn1JSEhxeF7X4x+M34wWfDRlU87dXJIfnRS+4Hh4Zy2B9x/srzaWQv3iHK8DXG0tJ2MUwr9Qnz9jNBWLVZHK+b8bGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fnIjfrxp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMsX19AZ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fnIjfrxp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMsX19AZ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAAE97A01CC;
	Tue, 19 Aug 2025 04:05:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 19 Aug 2025 04:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755590724; x=1755677124; bh=Ct4T/LzU3S
	ENodR7XfZEkPNxUHMcfcFA32qDwylxiEc=; b=fnIjfrxpKYtota3Y+CYF413ZtB
	GWtlCJxeM0f1UFSiO+5xBtWrhuzBJ7SrIlOkmpNusIIQMVaYWV06NxlKp2s5Q7vL
	Wn29o3O13ui3Lo6JWGdl2uxoUFRNvQYV2RyahiXZIF3R7pa7pNCWlgHJwPK4/vGn
	6bkvNJiZU660w1eBpUuU9JFRZOxfXvbVD9PuSowwe4FEGWOcPB4HK70UFc7IjL9U
	hjWMyv7Nz0XhX+hFA4OWYjO/Mix7CaFyiqVG8EAH48skMqHDwrR0Q4GY4R3sKWNz
	qLOI+nSwGcY3fVQiJuzgXVCoQ/FcbHncb0tRlc4yBMyLV5wY/7bPqu+pAtOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755590724; x=1755677124; bh=Ct4T/LzU3SENodR7XfZEkPNxUHMcfcFA32q
	DwylxiEc=; b=PMsX19AZBp1wRXYLiiGKYhQ699Ioz4JzwdIe9mV+szHlR2cXd6+
	7h1N7qMxwyhsX2DwrxOyh/n57TKbmq+SNIc8GK8oOYUxk0YNnZV5rf3dfxpygppJ
	lMKgwJeWhB5GD2GV/2zqTevz23Lm0K5//9goO6VvkHtXevlCT0qu0P5fHCFgZPrH
	FPE/tYrg3gouqstNPxuHdusV1Co3TmsuFNCrEeoXieU8f/bCHBsdfvpfExTFZO13
	f1k+kit6tMW+FX+YPSZGGeh5ERW60Bb0LnfKnAOW0myrrya349CmK000Lv9v8Tr/
	n7h9utL6jEMkaM5Xgz2XDrhfxiGF7ISLtzw==
X-ME-Sender: <xms:RDCkaM8BYR6VyMYRrPhNuDthihB2JjQBzTq7Z7bLdvYSzY3wHwvwlA>
    <xme:RDCkaNIZhYw4Yuf7oUCjcrWAoH94fZjID0fHFBvTUrdU0Il8axxkm3enEZv_OTU6N
    KvcWoLWIjqcXE6V5g>
X-ME-Received: <xmr:RDCkaCcaZDf4YzS6NHozpOcm0n0xW6ik4RVxfm62pcfDAN5yt2rqvuxKCp_Ajt50Q_B-FFMNjGDFjW6-SmL9ZUZD2wQmpQ2sb8rGlMmM_PfR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehprhhophhhvggthhgvnhhgsehsthhurdhpkhhurd
    gvughurdgtnh
X-ME-Proxy: <xmx:RDCkaM_7h9kNPtT73qqdGm_6MXSKeQ-Rw-sdpZ074Be0eWAH7btcKw>
    <xmx:RDCkaPpPJv8xyNgGCNJhlPcoLjXG4UQVGw3miv1u9xJX4rEr8jha6w>
    <xmx:RDCkaBAgq6N0JLEzOqAxDpwQJejk27rU_3NvSMgzIA_xCFFqfOA3Fw>
    <xmx:RDCkaBwLOdwx7111WybB6k2ZlRaaelpHywMTC_svArWIrpJEAT_QHg>
    <xmx:RDCkaLSaUMAe0WNi38MqoqAeZsLTvyGa-xujvTqGugyLdsezYtlIQBsx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:05:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6df1df62 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:05:22 +0000 (UTC)
Date: Tue, 19 Aug 2025 10:05:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] describe: handle blob traversal with no commits
Message-ID: <aKQwP01nulsquhzi@pks.im>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210312.GD1024556@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818210312.GD1024556@coredump.intra.peff.net>

On Mon, Aug 18, 2025 at 05:03:12PM -0400, Jeff King wrote:
> When describing a blob, we traverse from HEAD, remembering each commit
> we saw, and then checking each blob to report the containing commit.
> But if we haven't seen any commits at all, we'll segfault (we store the
> "current" commit as an oid initialized to the null oid, causing
> lookup_commit_reference() to return NULL).
> 
> This shouldn't be able to happen normally. We always start our traversal
> at HEAD, which must be a commit (a property which is enforced by the
> refs code). But you can trigger the segfault like this:
> 
>   blob=$(echo foo | git hash-object -w --stdin)
>   echo $blob >.git/HEAD
>   git describe $blob

I bet that the enforcement is only of partial nature, and that there are
ways to do the above e.g. via git-update-ref(1) or by playing around
with symrefs.

[snip]
> I didn't include a test here because it requires corrupting the
> repository in a way that is only easy to do using the files ref backend.
> It doesn't seem worth carrying a REFFILES test just for this oddity.

True:

    $ git update-ref HEAD HEAD^{tree}
    fatal: update_ref failed for ref 'HEAD': trying to write non-commit object 4b825dc642cb6eb9a060e54bf8d69288fbee4904 to branch 'HEAD'

But:

    $ git update-ref refs/some/tree HEAD^{tree}
    $ git symbolic-ref HEAD refs/some/tree
    $ git show
    tree HEAD

So that should allow you to write a test, right?

Patrick
