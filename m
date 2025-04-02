Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C220ADF8
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578181; cv=none; b=UPm7Kqj+HNuRAerh5M0mJjOsK+vkoY6ozcSgAlePdjkybKvzUczgrUKOd3b/Ee7rvf7T92JbXVWyfNMCuw5ugHBgSp40uvhB56Q5iHDKPFKuJLxTZsy9vdrBAcycpM077yl5TWrpvPGSRbPY74K8Y2SnC2IgyJCj569MeYtqv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578181; c=relaxed/simple;
	bh=vrbDV7XzNNIEHU8KMGE/rjiNkYZmDqjCrWSmS7kwMnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dq14kDnhML7jKqpyytFshVfkQNksp9e4wTV4sey3XNMPm05y80eX4nKtWH+PuSWbQ+pfsiEKV/A9f3a8Dek+MIbfvzQJ7WBc3n+hIZQFlnp/fnZvYlewv7s2qj0VPhYwrMOcrQ7nigSqTv7aD5m6erXl5bLkGsvnbgc8KtXBDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=buo0NFVE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZtRtMGN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="buo0NFVE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZtRtMGN"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C18711400E8;
	Wed,  2 Apr 2025 03:16:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 03:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578178; x=1743664578; bh=0s2wV2OC+N
	IL0IhXmfhehDV6KPUY1j+DFvI9b52uiJY=; b=buo0NFVEEXriA+UkkAHzTt1kNG
	jzTXZP6QEvbYdR7OP+wuJ8XIZzQdqV2jrFdX8o0CK0pVQW8Vjge8JbPm358kYcHh
	W+toDbToVreFeKU0Qa2vE2YC6rQ5j51riRsnCj7ogDHsfzAyR2vwt2tWvKb/B191
	Ew51tbC4VbjgnRcku4ONnpwHVT0wbdFNVXCjGpxsgZEo5AWCglkuoib2sOoOGqNu
	rAle+Z9gya7L5BuGrpuO8xeMD3HheDl1lzaggnemir9mM0CNiu10gyaPSFaG0/2w
	mscIWbKNlZ+cw9eFFhHT+VQYrHFE+oEhnaZKYDMgDBnkzjgXYOjXOmx1nYMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578178; x=1743664578; bh=0s2wV2OC+NIL0IhXmfhehDV6KPUY1j+DFvI
	9b52uiJY=; b=OZtRtMGNeYcJ/sm9B8ruSmT695XWMFxvzDbdrTVq6Dh0tJjWmsH
	ZWc2J+Dl4yMN7wYqlArwJ0ALgFnnyzEty4uDNs5uTa+cyIQoJVU8tWN/c4xdL12M
	m6bTJ3yNf5QgoSiOFm3eRAeVLPeNTSAZe16vv/WrIH97d6yf/evXEWwJ9WdMLYKP
	kna1W/TiY5TtxCxd1w5fIhlq9uBoZBDwFmK6xNrRQDXrkkvBaT/ih5dRrituHcTF
	0+gMTV8oeQ+gKVXJXqdv10q3lQAGWI0gMP/W00g+Lm3A+hZ6861oGCeMTp5jPkL+
	pL6K1sBRWh/aPl7/LbvNiUYUttykwlCjWug==
X-ME-Sender: <xms:QeTsZ5hje2ctptlgXBDY8JvQ6nz8ix_jjeywXmay-hPMz6MdF4bj7w>
    <xme:QeTsZ-ATGtO6Dh5brv1mcZaGn6GgswSgEQQo3w4l7A2_NYOwOD_jIQAaLf3Hk6Tmi
    S0YG5r87NnS0PMXtw>
X-ME-Received: <xmr:QeTsZ5EO1tmbtobdmmUp2fxwkTrjtucgzCVinfDKmgqXCwj4qljrJg3B4ete_51tI1IUbYiP2epnSdeBdKCMnNnpob1m-B1LiLwVS1BbZFl1-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgr
    nhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:QeTsZ-TlyYF5ynLLhdykGsGoIzuq3BpLeKFz-wZ_O9rVPRm2rrL-6g>
    <xmx:QeTsZ2x-9YmInOE-VuCrqwhHQVBgozsZ0-7thi4zcH7AilLIMWIDxA>
    <xmx:QeTsZ054kgE4zsZgRPT_MHmwixQDdwrkcUBE5x4Z2t38skDCIx6OAg>
    <xmx:QeTsZ7ze-EEWgQQ7A0TMqskg8iUieBbZTzvPqpu_f_Mz9p2c8m-5xg>
    <xmx:QuTsZ53iPUtTvhBf1yImsDesgfGxiqbt_yMzgHyNrEXPu8TNwYXrW67v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:16:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48705017 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:16:16 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:16:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 17/20] t0021: refactor `generate_random_characters()`
 to not depend on Perl
Message-ID: <Z-zkP7T-0zyW7HAc@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-17-b436de9da1b8@pks.im>
 <92fd1e8b-4790-0c81-409a-be81aed9f290@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fd1e8b-4790-0c81-409a-be81aed9f290@gmx.de>

On Tue, Apr 01, 2025 at 09:04:44PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Thu, 27 Mar 2025, Patrick Steinhardt wrote:
> 
> > The `generate_random_characters()` helper function generates N
> > random characters in the range 'a-z' and writes them into a file. The
> > logic currently uses Perl, but it can be adapted rather easily by:
> >
> >   - Making `test-tool genrandom` generate an infinite stream.
> >
> >   - Using `tr -dc` to strip all characters which aren't in the range of
> >     'a-z'.
> >
> >   - Using `test_copy_bytes()` to copy the first N bytes.
> 
> It would be conceptually more elegant to teach `genrandom` to optionally
> output only lower-case letters. But that would be admittedly result in a
> larger patch, therefore I am okay with keeping the patch as-is.

Yeah, it's basically the same reason why I decided against teaching
`test-tool genzeros` to output arbitrary characters. And again, I'm
happy to adapt if anybody feels strongly, but meanwhile I'm being
pragmatic and go with the simple solution.

Patrick
