Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D923D287
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420215; cv=none; b=ZAnpgZQsL5vmcTcC0bth3stsSFrDu5NfWX32WaQsn155nfejp+Iz/OhtvoW+Y1EgsoGMqWRanAs2IrxapTC+sMqUf0qQcIk1mSZ+XOIZfn2YRNOJ2eLKvlaT1sDe94e9zuf6RaEStcv1OJlskwe42czKOTZ1VOZGQByaM8nyvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420215; c=relaxed/simple;
	bh=d/EzqvEfRdux8pxF95tI0VKOKy8jQ+YCQq0LUVKoFmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc7fb0ucEU2Hjwv3KdoES7aJszVGoSwlIUqv5K3R+9k4vuwrUUFZgWIMw8U3cRUcK+xiCO3EFy5lkPVQ9Fy1v64WLDMgQ7LJxCZlYyakCw/PqGAYD0vjex0cXBJIjHSazZ2MPOB2gS4cUKDfrJGoNTkikJPMplrN4oGmOFOIBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UqawYmc9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSvvftFu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UqawYmc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSvvftFu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AD7CAEC03DB;
	Fri, 25 Jul 2025 01:10:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 25 Jul 2025 01:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753420211; x=1753506611; bh=VMlBHfe0bd
	CZSvzqj6h9ubN4YvSIaH7znn+EBMAkUNo=; b=UqawYmc9veK0/qlxIwV5eJrZf8
	BJhRqP+r2ZAO/27tnk7iTuRdMtGQMzIuz+Rm1iMz3PO6uApmARI3Fite0dBHkkV6
	HgGC0XxfZH8tu/vB6fn43k0I8gfd3vMqNQ0sj3KN+9D27iARIZCDCM1zbqoXcwVz
	NUzFLzypnYckdFpePrIMjMFRYNXwM7TKXjglJOg7Bzk9d6zh2hXVocirZo//S+GW
	eFgeyKcmbblFjkgrafO/VL2AX180UyIPGLQYTVz8Ei/75qxyxBTyIUV6WzA9oAFU
	/K4LILGFHw4ISybvT6VuBUaQlP5lxA+YdD+2uYxZ1zr2jbB3Fj/qm0577FjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753420211; x=1753506611; bh=VMlBHfe0bdCZSvzqj6h9ubN4YvSIaH7znn+
	EBMAkUNo=; b=OSvvftFueC+oiUEWyLFrfDVheg7nvBajlfTJB2Tj6pJ4TptnfED
	0VLLCVKaGFwAuG9TA67VfjYd+FsqHsVJX6R7knfLhIp8Xe/MFxskIuMBeY8Dkyte
	4bhmodA6Hv7IkNBtLri2VDW2VvQR+oP+KfEpwyE9pdSk7OQ78/u1O1zMecJWwEnj
	1aR7/64Iy66ukNEptod75yh2aZzDU1AKP1CVSdpsrGLGsbUd3tB9c2BRx3xMv17m
	j3PYpmlIwv9Oeuj8Uy1h3DNI8Aq7erdHxuj012f9potzXfJga545PYyJLg3A3d7D
	L/dwZKqN6fEIhIyROjr7QwJquoDGd088XqQ==
X-ME-Sender: <xms:sxGDaENILxrtqIP_4tDpSpa3YyXAUm7S5e3UB9pfZYwSWNZRZ4HVqQ>
    <xme:sxGDaAKFEIHpbsvj2HQy_-jTTW05qcg6Q9pD-CiLAhcFuhbDIgJVhO3kVFFAgOQC4
    lMCx7aAYEeX7axcAA>
X-ME-Received: <xmr:sxGDaMJrGAY8lO_Km0A9DUux0F7eVyew2Vwq6Di9RskYvQxmj4Ex9fQbxdedzM1rK8RH2hqYw62oeRdlEI_4-0jD6eMlJ3zQaKBzK1C0DvDz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghu
    ugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:sxGDaC5-0Z7SV6nJq79hzLSfCar6yjtmraWF3GVkd2h8U_GjtE3jTQ>
    <xmx:sxGDaOftqz_YCIEcvCRT04hZb8snlDgG1mjdEPj0Y0t08eCq0mbUxQ>
    <xmx:sxGDaFGqA75p_Ce4KrJ8tLT68-w9E2z83a7SiqeldMI_e35xB_miwQ>
    <xmx:sxGDaPT_zIB57k-5QN9sT_9UUXCelq9Bhzr2FnGvBLWhpXwYI5v7yA>
    <xmx:sxGDaFEDpxIA6WRjXf2AXdvwLjC5qYkvi0pKClawry0LOdwNEDhrRMN->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 01:10:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b703510b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 05:10:08 +0000 (UTC)
Date: Fri, 25 Jul 2025 07:10:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	git@vger.kernel.org, oswald.buddenhagen@gmx.de,
	ben.knoble@gmail.com, phillip.wood@dunelm.org.uk,
	jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
Message-ID: <aIMRrV3Atv35xeXj@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-2-lucasseikioshiro@gmail.com>
 <CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
 <xmqqtt34tfna.fsf@gitster.g>
 <aIHRCz_qswp7RgSy@pks.im>
 <xmqqwm7xindq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm7xindq.fsf@gitster.g>

On Thu, Jul 24, 2025 at 09:06:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > I'm not really too sure whether we need to bother with quoting. The
> > LF-separated output shouldn't ever be used in a script, so I don't mind
> > too much whether it always works. But I guess it wouldn't be hard either
> > to just have something like:
> >
> >     if (uses_newline)
> >         quote_c_style(...);
> >
> > So with that in mind it's probably better to just do the right thing.
> 
> The right thing being...?  Use <LF> as a record separator to avoid
> forcing <NUL> on possible human readers, and adopt quoting in a rare
> case where <LF>s or <NUL>s need to be in the payload?  Or something
> else?

Use <LF> by default to help humans, but do C-style quoting in that case.
Provide <NUL> terminated output format for machines so that they don't
have to care about unquoting.

Patrick
