Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF5173
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987790; cv=none; b=kxAqBZ8wVx7YVlonjEwuQLM5oYFYx4jNJ39URdDSBDIUiRL/Ct/TSkHFxS9sbCqFVWV3WRw4NYtfIOsEJ4JECZTG1QKSqLKjW+KXxQXAs6mK0PDhNoxZz+LWJpa17ZQDs8+Trsy4sWqsd+DZWDmFl5PKtQF0jpkl7+dwvQaPBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987790; c=relaxed/simple;
	bh=DJcB27CUmQCBYG5356gwKm/6k6XaD2QImhA1tVaw360=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeOoWd9vpNwlpsHC7ZH1I9keqp9O57K2TqhUghv/Fiy9Q/SP2D3eIXyyP+4MwPBsbZIspUDCmlYwIqd/E8BLHnbeVQwxYQ01Y7ZwpIV201+3066spah6JHfWqFalbhvrCBHTCG+763y11yEOnbVi9ObEMbi7svta8nMKBgBPwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qccQM51f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbU0osg9; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qccQM51f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbU0osg9"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE4F91400077;
	Thu,  9 Oct 2025 01:29:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 01:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759987787;
	 x=1760074187; bh=P7G8uLFAPPLsI2AfF11P5zOn7DfgWSV9POD/by/JGvI=; b=
	qccQM51fMzWPU0CJZjeVRiaIQfwfJU5VJvo0IzmetOXx5ZxLI0z37wz61OOWRk5p
	FMHuSppyYo9FZQUdxo141GYv0O9yemPPpf7W847wUR2stZcxDXxWIT654aE0Np3D
	b5IANOqdLagtdqvMIsCUygmE1u39E7f0JzID5FmAjp7QlDIvjbc7L5DwxT05X/Va
	xwyEwXaFqOPjvQyCKTosN+x0ueiXulOgqquBYHb7RKA0wOrw8Y9WlUNWCgZZkS2B
	FWeIhkfDX9poc+OSHYx/XKi6RB09ark3msn+BH/MgNPYFxLxBSNfybXAQvsHOdyY
	Lary6F00pOtvcpDIXic84g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759987787; x=
	1760074187; bh=P7G8uLFAPPLsI2AfF11P5zOn7DfgWSV9POD/by/JGvI=; b=Q
	bU0osg9f/fY9rrRjpL6Em2cyygtAduPmDcpoyXJJZxY0DTSSVqtdorMZ2AYu/xlq
	3XGE6ujprdnIwyZ0kt8HH3PTkRQueLyCocTiNPq684kVwGZm2FalotIrjwoKLZOp
	S0lThpsVjNa7fNEI/O3aYClPB2WHgg5X1zSxS/S72bE9nuzy3nNWLUnyTxOfSJBK
	NnNvd+PvbERT5POaewEN8BhMCr4b+RJA9vgxe1ry5Xo9S3VF5cKFhq9gsBRAKB5E
	488pe24x+CNewfp/NfJ0Ux5K4yVWY8AR9TtRtd3amjd1G/1KmdCRKPWk0Yt2NUd4
	kpKJG57dkjFGjnsRbzBaQ==
X-ME-Sender: <xms:S0jnaM_McaBEC_oW9h02NItsFSZtepNZmg8NJe0ejDMnfC_q5R1hTg>
    <xme:S0jnaLkUd_pJdZp3BgaF0_yqvjYhLLr0N7-WeHliq7hgL1zdfVUtQIe9UM4yUEucH
    jAbb_rHuP8jRq0vy5qvuoClVKOqo7ruZ1IOgsku1eUkDIFEPohSHA>
X-ME-Received: <xmr:S0jnaKWb8MxIljzIoe_ZrNAHwIr8WAgW1EzfsBBxMcXHo2vronkNEc62dHHlRt7wOkuSl0MT_sytxhvOp-eT9pFZV8D7ekJ_bb0do3wicuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkh
    hivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S0jnaIGtBYaHHf32vnfkpq2E6FyYIxWx8vcNPFRqP_L3MxKOYsCOFg>
    <xmx:S0jnaOeCTjAIAvmW3YVrgK8UD_v6sBxScAux9_IvIiRbZQqcQRT6vw>
    <xmx:S0jnaBKg-R0shyBQvNLdVEeQWolS_dVqvzJNLlzN29d3CrtLxz-stg>
    <xmx:S0jnaLGb6ovDjSQTX94swwvTkBcQn80MKPcHWOrQrVYQs1WcmCTIfA>
    <xmx:S0jnaIBhK67wk0K3v3aapDLNq8gFnrCPegDTiSoo7OmY_QbE0e7XFDAi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 01:29:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2e3f282 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 05:29:45 +0000 (UTC)
Date: Thu, 9 Oct 2025 07:29:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
Message-ID: <aOdIRnB-SGQwj935@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
 <aObPzzLtZzodZf+Q@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aObPzzLtZzodZf+Q@szeder.dev>

On Wed, Oct 08, 2025 at 10:55:43PM +0200, SZEDER Gábor wrote:
> On Tue, Oct 07, 2025 at 02:36:30PM +0200, Patrick Steinhardt wrote:
> > Introduce a CI check that verifies that our Rust code is well-formatted.
> > This check uses rustfmt(1), which is the de-facto standard in the Rust
> > world.
> > 
> > The rustfmt(1) tool allows to tweak the final format in theory. In
> > practice though, the Rust ecosystem has aligned on style "editions".
> > These editions only exist to ensure that any potential changes to the
> > style don't cause reformats to existing code bases. Other than that,
> > most Rust projects out there accept this default style of a specific
> > edition.
> > 
> > Let's do the same and use that default style. It may not be anyone's
> > favorite, but it is consistent and by making it part of our CI we also
> > enforce it right from the start.
> > 
> > Note that we don't have to pick a specific style edition here, as the
> > edition is automatically derived from the edition we have specified in
> > our "Cargo.toml" file.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> 
> > diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
> > new file mode 100755
> > index 0000000000..082eb52f11
> > --- /dev/null
> > +++ b/ci/run-rust-checks.sh
> > @@ -0,0 +1,12 @@
> > +#!/bin/sh
> > +
> > +. ${0%/*}/lib.sh
> > +
> > +set +x
> > +
> > +if ! group "Check Rust formatting" cargo fmt --all --check
> > +then
> > +	RET=1
> > +fi
> > +
> > +exit $RET
> 
> Our ci/*.sh scripts usually rely on 'set -e' to catch failed commands.
> Either this script should follow that convention as well, or the
> commit message should justify the deviation from convention.

Ah, good point. The reason is that subsequent commits add more checks,
and I want to make sure that they all run even if previous checks
failed. It's otherwise annoying to fix a first set of errors surfaced by
the CI only to then notice that later checks also fail.

I'll mention this in the commit message.

Patrick
