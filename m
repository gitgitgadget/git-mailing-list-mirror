Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E727F171
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767854854; cv=none; b=U5eS2b6tYLLUh9iy9E6RBWteYpnhCt5j1CNeG/MSuKLX/FlAIMmXrLiQBaPd8ScsqUb3tYdaOymY3yuTe7ct9dgDZk3xjkBt5rBh9nlWAfe57FrM+9X6msSqTHqdA5mEKqOYdBPODyaxtb3PzIalDG5xMHjtQkp2ReHpNSPyO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767854854; c=relaxed/simple;
	bh=301Zmk2fm6CKOtHfPO2rg92qdP3KKwFUMhhhZqKb+sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqCXJ03hTHzb3UlDKcEh7qgpBqf74d93xDWM0lSJc6NyAVhNI5ps9NgeD+HC9VFnInWtKlYAEniK8eLht8556VgX+SLVcxJeKZMiaz76qe3F1s6iYf9euiJUV3h9p8RtVPLXtFxLyqO5/BTuR05XlElqyJz3j2hihsZ0ZaE/l6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tzweg8jB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kq/sAbGZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tzweg8jB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kq/sAbGZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D4EF1D000F5;
	Thu,  8 Jan 2026 01:47:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Jan 2026 01:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767854851; x=1767941251; bh=lS7Ss+FdN1
	4WnMJ7ivoQUSLTbErsBi7/7Bh+T1KGv18=; b=Tzweg8jBZwcrT6VblMH9joRnQz
	S3r+zEVgRI7m1c2CXNOPVcws64qf+ZCDBnNp3dH2wQAYN3pINC8UPkjGYxxDnOLc
	3uGza9pl5F9qzQStRIv7/SpDGY7iuidfJ2UWgJ31mGjoXNy6YAXQ9s2GehwzhfJD
	aeFvL8mIpzZtqviY65uN3jjoQE8W6irCyRlYhuqF1UlrCK3Hv+7U6MkkOtwHLGzn
	BfIUEachvuIFbwWxySwP09aaB9SEGucL61xqzeLF5aRfsmJbevwISMVeGzspSxK+
	zTcnHyztmVcLQweq1C8HRrfYQF+iYw8e5lofnJgMia1ozuP10yCgagSHjk3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767854851; x=1767941251; bh=lS7Ss+FdN14WnMJ7ivoQUSLTbErsBi7/7Bh
	+T1KGv18=; b=Kq/sAbGZ82OqT/ud4y6B0E1coF4apfhEKhjPr09wASjtl8hYPW2
	QzxKVYlMaaOPM0rV7xD5MocPFuzIOTni+oQypnQXVCbmwJGuaApPg8PH3QBm5pZm
	P3mfHvGelKAYjwkSLrawx5qvzwKT3BtAb9hkDx2fI2ldXCqM0AnjADgQQleaEx0A
	+r7LZLGoIoKnbwJsI0nqHmQ1whJ2zPN/tRI06oBf1zd/EiGJuHtqNhcpjieyRaj7
	Q4+Y7w7ze6e95A1hf0ey/PZmoglh38/gFwSPaT61bj6HCYPT3O08rDMdgTeVtB6B
	fBDVWVKij+T5414PjJ3+EhogGvZdAlHl/SQ==
X-ME-Sender: <xms:A1NfaZE8vanRZJY1bMHFS-YCAKkkfvPY4Epjwc3iKogQKQ6kn7QrAQ>
    <xme:A1NfaWggG6A7bftt0sweET7XDm-7l1h26Ye-axwAz4GN_QAJBjWT5wa6ulmjlKsa5
    Qwp6CR26_GDdVbhgM_edhPmWN93UXK6jJJKAfWRVM2klFZHuCcX>
X-ME-Received: <xmr:A1NfaWv-BCTNFfwWjxci14nMbLLzGgufrYLOvGq7jvken1by-_0xPSsl7YQT_f0cPyG1jpsZye0a_bn7gRGGPIfL3mSWs01RExZ69KESUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhrnhhivg
    guvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegt
    ohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    grrghrohhnsehstghhrhgrsgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvges
    ghhmrghilhdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtoh
    hm
X-ME-Proxy: <xmx:A1NfaZv70IkDrkOoSP74DRNmPum69s7g7_GOHIqUaYXCiAftmGf9fA>
    <xmx:A1NfabGmOsRC0JAiFgg0gVFQi1RQpSRirkDCimoAwL9C1kvG7i1NjQ>
    <xmx:A1NfaUPSzF6tFayQsVH9uL3jK3qIsAaKSB-WWoJF0rBlrxaVrQa4yw>
    <xmx:A1NfaaLTrCEMVJ9NZx2vWsuHI5gakCdy5LbFeT9cTrrloOCzYnSAQw>
    <xmx:A1NfaUnkzCEHvc-j2hljMb_6_F7Y10xIr9Zz5bB6XW683mzoAbau-poR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:47:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a2d27f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Jan 2026 06:47:29 +0000 (UTC)
Date: Thu, 8 Jan 2026 07:47:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v8 00/11] Add submodulePathConfig extension and gitdir
 encoding
Message-ID: <aV9S_oUJjitkeWjo@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20260107230145.517562-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107230145.517562-1-adrian.ratiu@collabora.com>

On Thu, Jan 08, 2026 at 01:01:34AM +0200, Adrian Ratiu wrote:
> Changes in v8:
> * Added a new test to ensure gitdir config path is relative (Patrick)
> * Improved gitdir validation error message and added advice (Patrick)
> * Renamed init.autoSetupSubmodulePathConfig to init.defaultSubmodulePathConfig
>   and moved its init logic to initialize_repository_version() (Patrick)
> * repositoryformatversion is only set to 1 if it's 0, so it doesn't
>   overwrite potential future higher versions (Patrick)
> * Fixed global init.defaultSubmodulePathConfig leak between tests (Adrian)
> * Whitespace and other minor fixes (Junio, Patrick)

I've had two more small comments, but other than that this version looks
good to me. Thanks!

Patrick
