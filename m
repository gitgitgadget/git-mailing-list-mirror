Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E952D7BF
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 05:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429322; cv=none; b=jZmBgWySY6MPKKw6YZs09ALLTgtzIsrW/oFGiQt4sokxdkzNYmnTVrIxZq9TfAbimvqvQMNhpOmw5OjlFBeWWVXghMRiTsau74JD0O3GKVD8UTwqekU+T5pPeSjpIR3GVfOaJI5V3Fi9vqadgbxBmGmT/SP+BIbwSmYI3u4/83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429322; c=relaxed/simple;
	bh=S4JtaQYSnwmI5TiGQ/R9YmnWzQcrzqsIYnVXg1gmVrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQYLt7mwkH2nfFVrwoKpln6LKteCJgVn/JkPk0U4UutESNe9+4pA1j0Vv2AvIqq/NZP5WtebuMXKo5tB7YLtXp1ehO6R56iPuS0bi+TgRonxD/7mIOUIZEEJ4ZvDuytEoxf/JUNJcvbB5KX/E8vF94b/B/7XMuyn1hfHHajZ1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CfXladuf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfzsv23q; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfXladuf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfzsv23q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C5EC1D00118;
	Thu, 11 Dec 2025 00:01:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Dec 2025 00:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765429318; x=1765515718; bh=5GyzNAEY/u
	Wno1O9gBpeiA/4VDx8yrV9fTRzE8YhhuM=; b=CfXladufIbashwncfLbjICtyUJ
	aX5L/ORv9/sWvCQHvmHzpZ3RUREaff1oGDufzVMaOjuXaDWavDOxhBX7p96MZhtI
	mCcfj0nSEFHqd+1Ue164ogP429NbieQf5u3oFqzYy/mHztz58gTDS3DMpaC6Jeh3
	F3Dlms/K7fYUvvGGVki7gWy42rhw/l4UQgodvxD1/UiyXZej1THpOTFYol78/8h9
	KhMLzBXNswHJ3+ckf9K+krdocTu0/5UIs+bKDTLoU2AENZc3Y1WRC+vDrQi2NOys
	9Vb5rjUBHXZvZUqkjjYKasruPnzf/K6qUxXR0Gtt6l9+tWHlaAxBNxwYDpbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765429318; x=1765515718; bh=5GyzNAEY/uWno1O9gBpeiA/4VDx8yrV9fTR
	zE8YhhuM=; b=mfzsv23qcwjXuFpQ3FU5wYp/pV0RwJfnftEYgnk2mzxohAM2KFK
	o9lZA0qa9hw/wx9Nt5De8RYPmgSuF2ET2Z8WzIWtGm6BDdZQu3Iu7p16MXuz93Nl
	UucP/29DsluQ6TTjV4wH0zhdG5du7+WuBRtwebbAy3HPjoKlgfpFN0aDP/QYTwFz
	0s9gHtIKTdLXqjvtlEM9RO3mgCUbOKj0LLnAD85wn1p7AZ+HB6OUqAJFmT1Iuhru
	WU4rldDjTrQxTzLSBAmvvcAnCPz0m13zGlqCufSVRoN10q+i5lt2DbXtvCH1i0Vf
	97Z4gYjjb9CuPSYf0zIQCUcOJM0SK0JjDmw==
X-ME-Sender: <xms:RlA6aToZymSnvR4nVWgj6bF8Yfn8Zd3xZ1F9GTyvplIuI7rZqaiCHw>
    <xme:RlA6aTp5wuJpkBD9IJJCi4EDPyJoWg08EVPPoVCYfRnhggvLDUEaqf4b59Rj3eKzp
    kYzoU_nmcpZ0HAowdG_IVV5eWZqAHLNaAvbulHDZOGGcbBpsU8Fzw>
X-ME-Received: <xmr:RlA6ad2veId2DFHJ7q20cC1r-ZkLR88yOyEbiCbgsYlEz-eFuwWBKqsBYSe_hm5wnGCwNdT2KKGsVzOe83MuUOmenmACgEkDW3OG8EaDZVOd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etudffveejleeljedutdejudegjeetkeeuudefhfduveekleekudeuudegvdehleenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RlA6aSC4-QkONHAJ6CxxF9Cyq_yzX0eTgPQk3rZxVdJrBQS8RsVyYQ>
    <xmx:RlA6aVejBgLBXUVO7gnD9Fm69af4OukVvnLb7Rti90CrEY0MBsY4hw>
    <xmx:RlA6aXihX3efVsQKdkX4X_2PwzjVu6SRa8q6XFUa9Z04tYlYk_lyiw>
    <xmx:RlA6adpC_oSuYbnPqjty1RG4A87IVuymJQJq-MSYPGyooNzPi6ohyw>
    <xmx:RlA6adaX_htPEBveKjvdJMCTjiWGe7vZ-zOMs7I8qSb6qeIHjTVZpSvP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 00:01:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 534c46cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 05:01:55 +0000 (UTC)
Date: Thu, 11 Dec 2025 06:01:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Refactor handling of alternates to work via
 sources
Message-ID: <aTpQQNJyhdLpgKNg@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
 <5kulb5uk4uzn7gl4yhvnc4cnmqxzm2ngtezn5b5kkv33pgexmw@klqedekkink7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5kulb5uk4uzn7gl4yhvnc4cnmqxzm2ngtezn5b5kkv33pgexmw@klqedekkink7>

On Wed, Dec 10, 2025 at 02:00:39PM -0600, Justin Tobler wrote:
> On 25/12/10 04:32PM, Patrick Steinhardt wrote:
> > Changes in v2:
> >   - Rename `odb_add_source()` to `odb_add_alternates_recursive()` to
> >     highlight that this function is recursive.
> >   - Link to v1: https://lore.kernel.org/r/20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im
> 
> Thanks the changes in the version look good to me.

Thanks for your review!

Patrick
