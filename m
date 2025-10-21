Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58843126DA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035641; cv=none; b=KxvwTCNfevQXeBeY6KEnKOH11Ul5Z0LKM6HvRdCCj2GopcoPyRSO6lcm5xheKxusnc0yrqsBXV5ZWf3rLaYsIvmVUXPFz2EBwcRYsF/NI+20rOPyMjvG5kvrvBo5d9rWth669mng9pNPFuXICXq/oIiAFy0/U/6lz8zSObThX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035641; c=relaxed/simple;
	bh=5JxcGOA4sNA16KfzrsqWOPe2sLWgj1nXSPOpDaELkZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqv5kgbtOfijp4QME30p4RL0g5ai7tOMmV9djvNebRDRP2Rye3cyQhwzHd6l/tOHsP9SUcqX/eNrVmz50VFGQmg6VmgzZQkAxbC2g9pn3A0itig6R9yM0vilsCEBCN1nIYCwmoXiTEAoWotjb9rvX90pd6eC4ZNAZrsfh3RfExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TeLjBWux; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNQpVIP5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TeLjBWux";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNQpVIP5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 104BF140011C;
	Tue, 21 Oct 2025 04:33:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 04:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761035639;
	 x=1761122039; bh=hkMl+e6kunyOS7Q0YmyCizOrDuetqKDF8BtbUYPW9c0=; b=
	TeLjBWuxV2IA2M8G/pgtJs/cgp06L2J3OthFXKlWnzgoX+jR33gHu8UNi55vFi1G
	W4VGtn9GyPdNN4ypyAVEJRNRy048xJX/lWN4m61FlTb0/oQ6toTGhP0OCzWycjqk
	oy7wPIWcJGzD3+J6LEDcH1a+srGTvx1jxDYQIeyu2Vea8zNjleeAf5lclke9DWEj
	klptGSftUSijpE0+W2nt+GH8+EzXKOOsAcHiqzKesO+Q7uF6XH6+vB6oebMYZIBc
	uxEf0DVpEXm/rr1WaMV8q01HPTCUrW08jkVVoWw7Ou8VHjK5N40jYbgGc0+L1kZ5
	Z4909kjr4nkypLXGBZ1vPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761035639; x=
	1761122039; bh=hkMl+e6kunyOS7Q0YmyCizOrDuetqKDF8BtbUYPW9c0=; b=J
	NQpVIP54QPn9dk7yOAWxOGmUTIwT08E7+e28jAIbDOUbrBEkpjbu19dul7yzyjSd
	JTafUacdbkP0NC0KzFp0M+QIRyLpR8nvbr3F9RrRVhgoG2scL83vCoSyelersyz3
	wbQWW3WNFBhw7MAC9tfdRVj6UaUO6g8RtE3TKd78dJ/eOrPExHAO2UTpj8Lm82LX
	dtCzxI6Fx0d8888h5AyZf2sDNlbtpHjMGZhy4Dkmj5yTKFzEw1th5S5/RXAlznRO
	rnCNIRBDCZ3CmytTLV+ROhu7GMdzrH38QCLbbK9O4P3zpfjdW7njXFV/cTikWgOt
	D+5Z3nY2eEKodhlfKG5fg==
X-ME-Sender: <xms:dkX3aFvWv_O27itmpxVBzDpPfkhprkKAmtBuMmlKqKJ2_ySV2FdbLw>
    <xme:dkX3aF7--Vq_ANbr2R_0LRQ1JBj5I0x6B81W-b0IkdqY-tpta8JkgVfpcOp_yE8Br
    vWn_7FdL2dyjKJ8fMlVBY5FwdB8NjT5AheBSyOOWCTOOUFkr6xNIA>
X-ME-Received: <xmr:dkX3aGLKH44myJlrBrE6j4FUsXA_gH7xedvWXDUyCvrm8k3pQh1T-VKYNXdaASa54STE4mU99C0rZzSh6xOHR8P0pCFmtWbCVzKCuUJpiSEnzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dkX3aF67f4o0GXRbmCkmtKGdHKiNw05UF4zzlFIA-e-kW204VCwWtQ>
    <xmx:dkX3aJy2wmNHPCkuuAVs7LW_QnrUegG2eBhJv4aUC3CsMwhisGfssA>
    <xmx:dkX3aJZpWRRCQxZogiEj-3i-K5Idt4Ab4nOHJx71kqgXnJtmVtft4w>
    <xmx:dkX3aLTCCdc3xdRqJXGaFFRNiR4RkrAkNxdqXQkky59gT-9bpxpOPg>
    <xmx:d0X3aIUMCgMBhgV5-BtT75BkuEYQZAzZF40tMTyEFZVjZnfMIKoDlbvF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 04:33:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ac33eff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 08:33:57 +0000 (UTC)
Date: Tue, 21 Oct 2025 10:33:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 5/9] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
Message-ID: <aPdFczDXrlu6CJLZ@pks.im>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <a3e706ecdae51434fd5ee112c13f8cf374faf6ed.1760563101.git.gitgitgadget@gmail.com>
 <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH=ZcbAjX=V_VvJsRzvQEA+CMM7dWQx6E5=d4FL5CD3s+ozjBg@mail.gmail.com>

On Mon, Oct 20, 2025 at 05:29:25PM -0600, Ezekiel Newren wrote:
> On Wed, Oct 15, 2025 at 3:18 PM Ezekiel Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
> >
> > The ha field is serving two different purposes, which makes the code
> > harder to read. At first glance it looks like many places assume
> > there could never be hash collisions between lines of the two input
> > files. In reality, line_hash is used together with xdl_recmatch() to
> > ensure correct comparisons of lines, even when collisions occur.
> >
> > To make this clearer, the old ha field has been split:
> >   * line_hash: The straightforward hash of a line, requiring no
> >     additional context.
> >   * minimal_perfect_hash: Not a new concept, but now a separate
> >     field. It comes from the classifier's general-purpose hash table,
> >     which assigns each line a unique and minimal hash across the two
> >     files.
> >
> > Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> I'm a bit surprised that nobody has commented on this patch. I thought
> that someone would have criticized the length of the name
> "minimal_perfect_hash" or asked me why I was splitting one field into
> two.

I actually appreciate the longer name. I'm not a fan of abbreviations
that are hard to understand myself. Sure, they are easier to type, but
in many cases they end up making the code way harder to understand if
you are not deeply familiar with it. There's of course exceptions to
this, but I don't really think that your patch falls into them.

Patrick
