Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE261A5BA7
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877732; cv=none; b=idvfijFo1q3+ur7anJJTpuEVTJXn60H0+gAedZ0oBG17OCcWxbiwG7LjCkJMwgSHdRkI/H3vz+EkJ0n5va11hDjvQpHellYxj64YQGytgWw/twW159DAMqqR0RO7Qnx4CdLaYGHprAdoVgWkvlWfISfuq+TK/PQxGeoz8WkbO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877732; c=relaxed/simple;
	bh=i0Tv2+rAxsK1J5aIlt5Lh+iNFWT8Zzc5EcZTfp2aag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLN2ktDXo9bLtOhelRmBvov/h+s8mCOH4eROOi7WkC4zmbJjIeLyDkgQyNBUDqP9Su15rNVz6r/bhqX/KLI7X6GCCKnkFwdOlxSzJCKoxdrcxIBDAcOeo7IdzQySe8PozN8U5WFFFhj/HHGSiswzvKgmkpvUELqgg3lcGw8BI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gEDDkadK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r8r76EAN; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gEDDkadK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r8r76EAN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A97413800F6;
	Tue, 18 Feb 2025 06:22:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 06:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739877729;
	 x=1739964129; bh=+NuoGC1DkCdujUq4lZMuCs1cSi0edMu5dTt0CPQb8fg=; b=
	gEDDkadKQuNo0eflGlwMbvWM3a0Uhbxl1I5HIfD/1N3knXjp+mi6iSC4AofOUR+V
	3p6LYahh+hV1tlZO+W1oALeuq0h3w5K9Fi9W1E3yapxdqzW21XJHn9rWn0+zacVF
	rbT+ARus5dZWF2R7QKfkNV2Odf8iVB78q4OqQBxSf7uhytXE7QhmaMHE6E+SXPlW
	r/hxdbciW8U2i4yEx2DJJGgrAdsCG/caxoguwcZRtDI6XRmQjNBTSqt2J3N0g1hL
	rPwKpue/CN7/oCpsrqfvJvYlYkQ7VUwU3eKapCPW7Mp1BzjvtorHuUcC7FhrY3xu
	araYWCyNlqPkaPz6Cnp90w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739877729; x=
	1739964129; bh=+NuoGC1DkCdujUq4lZMuCs1cSi0edMu5dTt0CPQb8fg=; b=r
	8r76EANqEhkLtlGsRv4EKl5fre18CfHUtDFnHjmiSFgBSsAw+AT5XmPgvCYfA0mk
	IO3TPlM7/rIbLD3upy0WarRSVKegiv3MCVR5eYhf1Fp+SBcbfZrC2pMMltxWaRdo
	ArxgO68aKMPSQejTl2RhwjG6tlN5p0dkDS7q6axR9hn42uP5phDFITdR5CCS9IEH
	WDcsJklIQMp+MmDB7goCH9365i345LHReR85y9aebokd04RHtUr0VmG6652Rk0se
	qjawJ2qdIefMviLqDiUcL1s+gHdF/QpSFzkat4nCokB+ymYuh5fARBLxaKx6JE40
	xV+E/StxMTfXxsLAh9ifw==
X-ME-Sender: <xms:YG20Z51D_3hPUBqg4aJBIJsr-TB138g7qW6TZLeF35JmuJ2rnwp_ZQ>
    <xme:YG20ZwH0IJ69-glXvg4JLAuUiTiH4Bff1x89-5mu4uT_sWwvXbM6zctyDYeD_ca4L
    OIUZPA_zPSnsDPnUA>
X-ME-Received: <xmr:YG20Z54ijbVK5LRH2ddSj-EtFiTeafjpmLPxChcn6vAU28pl39t-qeCohhHYL9NCqqPAmfw01mPniPd95f-A2wr7iu_QxnXMBZstcGmGhPu5nF0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiuddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YG20Z20dvUzyCdcQOb-R1rv3qvFe0ftO4ket9rEXGfvACWaIHtbpRQ>
    <xmx:YG20Z8E5tXdTpd6LVjplybUBJBGyEph6VWtiyg_KoCFJDE-Kxuyveg>
    <xmx:YG20Z3-Z3-ZO2vGSjyhXT-PTrXyr5HWmPlPT6Mimo95OP9ICwI9ITA>
    <xmx:YG20Z5kGzkYv2q7pALYSwpH97M6TObPPYXE3YW40SJRbJauvnIMaFQ>
    <xmx:YW20ZxRe6_FOOruqPbpIyMOwYxC3c3O8wFvFqw5n0wqmHc4xsUYXxiQy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 06:22:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 588e5200 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 11:22:06 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:22:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc(send-email): use correct name of the
 --signed-off-by-cc in git send-email doc
Message-ID: <Z7RtXXsDRxuEqCgC@pks.im>
References: <20250218085913.1381537-1-mcepl@cepl.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218085913.1381537-1-mcepl@cepl.eu>

On Tue, Feb 18, 2025 at 09:58:38AM +0100, Matěj Cepl wrote:
> I don’t think there is an option --signed-off-cc (without -by)
> for git send-email.
> 
> Signed-off-by: Matěj Cepl <mcepl@cepl.eu>
> ---
> Rebase on the top of the current master (Whoops!) and improve the commit message.

It's better, but still not quite there:

  - The subject now uses `doc(send-email)`, which is an idiom we don't
    use over here.

  - The commit message still doesn't use imperative mood.

I know, we're quite pedantic about commit messages over here, but please
bear with us :) How about this instead:

    docs: fix misspelled `--no-signed-off-by-cc` in git-send-email(1)

    In git-send-email(1) we reference the `--no-signed-off-cc` command
    line argument. This argument does not exist and never has existed,
    but it is an obvious misspelling of `--no-signed-off-by-cc`.

    Fix the misspelled argument.

    Signed-off-by: ...

It would also be great if you send future revisions of a patch series in
the same thread. You can do so via `--in-reply-to`, where the parameter
is the message ID of the first message of the first version of your
patch series.

Thanks!

Patrick
