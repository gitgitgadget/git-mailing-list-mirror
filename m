Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D81E25E1
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753958786; cv=none; b=HT9OyFfNOsfYOWNZVx5C86yoIxmnjmxbXicxZ6F8XD2uutQWjeOuVCqksR5jX1e9iEqrdSNkIYZ02LpP3LDKk8iQCNwkPIW9+mNoBk4F19piqCznOsBO11DqbMu9+jMxAgwJ/VEf1ghxbvKxe9QHBgJucjZ0JPMtWJfZNQxf8as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753958786; c=relaxed/simple;
	bh=vdCzNkoGlNyD8ZGkATlpQs53oHSGEMMaLEjzADJovD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pB9C5UYn/bJlainpmXAZf0Cm15K4mn2nYo8zUKLvsP0SJjjGrjh0aBca39Eh/JWSixYYig2NG6Iqz8YFPRIXVVUrf3aY2riI8Q8wHjhasmf7h9sxH7SCUspwQaVG2mtSB/RK3OP45Y0AfOTsc4zWUixlUVf5rhwpiNtUGE0iCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S3jnNzNO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TC+QCkdE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S3jnNzNO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TC+QCkdE"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF9107A1931;
	Thu, 31 Jul 2025 06:46:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 31 Jul 2025 06:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753958783;
	 x=1754045183; bh=lX7ecuncIgl/FEAdQORF3oxDBfTa2PB05heW1oxLTCs=; b=
	S3jnNzNOlumqlTA318Chf/uD5nH9Bc3UFm/zw68s4f4N3VB1+AOLn6Vh+KTWWund
	jLi4v5b8mycdta5Ydl+OmiH+S/WqkudR55VmUaEixTGy4jibcC82EBkVF2V5eUt/
	vKi3v+ehVwVyC4FZL8wDbx5qDmPk7iVsn5CNOIEA2Gsb8ZB2wXHrfKBRv6CYt6Ih
	gHifxxqMEflV7dwzdZu3CWSQJ5Bk23Fzcrh56QD21gzrBi44ZCnJWMW3DAvZTTkt
	U/rGMHmp3Uo1PnNdCcBo/AXrRyNqkjJZqnNL97BuKvDQ6XKexBP2skEehtdXTTWr
	1sh4J6Yqs092xxM//iradA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753958783; x=
	1754045183; bh=lX7ecuncIgl/FEAdQORF3oxDBfTa2PB05heW1oxLTCs=; b=T
	C+QCkdER16tEyzwXbStu+nChnMGQF9JlpvIQppbR/lI8vnUjRGcZr/nZvSdjaePb
	eM5YPLMH6yjd8zY2Z2aOrckDeGVmYz7ln5ZQ3smxEVmRpa/yp9F+Pg4UZQ3Vl3uI
	dSQCF+HoIRNjTiMa+PXjLepFR8w1IGA+IPfYQEY5lgXfboMs4Zi1PbWQRars/PIQ
	BoBm6OAl+B4RsF6XGEoodCXlRDaIMpD6VpyD1i1JdGKKeQ9cwc+tTrjCIekguIRF
	l3+xTPaiEk7eN+nWxcs7KTjfes2Ow9lR9z6PpDevHlPlnd9XKMrn7xqrydXiMaRD
	qDh/i0bPPH9QKDRtLuXkg==
X-ME-Sender: <xms:f0mLaPz_al8-cKyMZzSncKl7rn6Q0kap3okvHW0GvsbiqPIzxRp70w>
    <xme:f0mLaCz57el3dIU9FScsJqrVIhiFRIyp0w-1PMGVIRdnw8jKRAqWXeb8qx0GDLyOZ
    K2Cj9qUhpN95zUgog>
X-ME-Received: <xmr:f0mLaPzJYcpRtvnhVfe4U8i0fcW8J4MhVabYIXu8UozrCD0Xd47Etzz8IAJLZCdxt3zF_-Y_u-F0KnNaySsU1-m9eJt7fC8q3Hv3CSxi6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmlhgvvhgvuggrhhhlsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:f0mLaEYlgfjnAbYAp9JXZlXzM2dne8_lPaxBqRBuitq12hJ3p9F6hg>
    <xmx:f0mLaIUc_ur22jCYzkZO9tDeX51Owi-t8zTbO1bIJ1-aqWlWTBVleg>
    <xmx:f0mLaKjqplJOXIxULmfRfv_5SKVW_ozWeQs-E8vizlTPBQHDoxuPRA>
    <xmx:f0mLaOsaNiIFt4KvbANiG2dqJr-XXZ44CFvc86ZO-6MUCVKhwlNR4w>
    <xmx:f0mLaJFhTlTaqNLeqrnw7B9OvTEovbWIqNWWzVswS73VaAXwngl-3Y87>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 06:46:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc64b32f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 10:46:21 +0000 (UTC)
Date: Thu, 31 Jul 2025 12:46:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Carlo Arenas <carenas@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Mark Levedahl <mlevedahl@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in
 macOS
Message-ID: <aItJetAs7kieT2vC@pks.im>
References: <20250730164052.15371-1-carenas@gmail.com>
 <74891c16-8850-4148-ba15-d5b3e5571bcb@kdbg.org>
 <CAPUEspgpF5=w-=w1zofkO1P3+HYdvRUxZfpnM2pcJGYOOoEmdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPUEspgpF5=w-=w1zofkO1P3+HYdvRUxZfpnM2pcJGYOOoEmdg@mail.gmail.com>

On Wed, Jul 30, 2025 at 04:54:12PM -0700, Carlo Arenas wrote:
> On Wed, Jul 30, 2025 at 12:09 PM Johannes Sixt <j6t@kdbg.org> wrote:
> > Any help would be appreciated on the Meson parts
> 
> The Meson build works when tested outside the git repository, but since the main
> meson.build doesn't yet use that to build/install git-gui there is no
> way to do a full
> test.
> 
> Eitherway, it can't make things worse.

The Meson part looks reasonable to me.

In any case yes, I haven't yet wired up gitk/git-gui in Git itself. It
is trivial to do in theory, and I've already got the patch series
sitting locally for quite a while. But there's one catch: we'll have to
add those as subprojects, and Meson looks for subprojects in the
"subprojects/" directory. Which means that we'd have to move around both
gitk and git-gui directories to be located in "subprojects/". We can
pick the name of that directory, but it must not be the top-level
directory of the project.

I shied away from sending such a patch series for now because I wasn't
quite sure how it'll be received. I don't think it's too bad, but it
certainly is a bit akward.

Patrick
