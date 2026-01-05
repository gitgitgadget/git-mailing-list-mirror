Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BA2F60A2
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625420; cv=none; b=LiDOyCrN0yIkb2M8fhAe+jqkuZLLMb70I2zIU84A75Y8K13hmeBhJUVTBwH41Uv7cpM9FT1Ro1Blyk+HN2yqnOCeFbv0rbB4kVqL7zlCqE6jveTU/A2xzb+JxUQokTbndvMDgTtjz2O3vkInd/aGsUZu0Eh9klpEEjDfn21JPls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625420; c=relaxed/simple;
	bh=O9iveQx6CaE6vLEHMWR+65pJHpPf5VWpIqNj+HFirEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0ifiRZeWjTd+vap7Oeg3QysHtsID6Ud7Rp6hxLonRKqAuDCcvRSCQluJXZBD7wpb+5Evtfp18JqHHDh3A1iQIW0lxp9rklywBczEqfabDaUaxmQy3aghnP/pARpaJuImdzBYbiyYmmmMkXaoS0ci3mYwKJrreyBRQrFu+6HL88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TdoCDbTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l63sDoTF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TdoCDbTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l63sDoTF"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C08211D0007D;
	Mon,  5 Jan 2026 10:03:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 10:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767625417; x=1767711817; bh=dl+nbIe4OS
	7S9R+wODXDGGaS0YOPbvDGOBMbAjmu1hc=; b=TdoCDbTto0osKSM007YLFx3QRe
	6aibztBa+Y6XgIsA8OwCdNaeVRUrPLLpgW1QCecD38ofWYLCEj1Ui5MgBwNg5f1r
	o8+O3PUFvzXW7Z3lS3FgnlvQcmNjy6ulIIdn1YMN8sRervit5RpyKVsp7rqK482s
	xgL0v9NfoOs3t8GUrs7SfQffJCoON5Ej45mk1RCY8S2j+0WGMSSIa8CgLKCk9UCe
	7xMjzQVZZyvJ1CJH4qXYPkNHnkDBTE6n+boa13DEh7breZ/xWqXOID+/9TEe06M3
	bk9Ck/7BT+un6naOecE9N4qaPvfo9la/VRJY9af1d9uNHhmdvhasFLZ5i8Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767625417; x=1767711817; bh=dl+nbIe4OS7S9R+wODXDGGaS0YOPbvDGOBM
	bAjmu1hc=; b=l63sDoTFQSjYq2ZqJXrASuSLTS/N4dM84qNbRh2E1+0JG5LtgtK
	9GHzYZjQztlV+43vq1GDOJFZaXk8IwdZa9J8SOQNPAaW3acRwBdZxE0sxGboBsL8
	eNfE2ginOjCuJuh8bk5QShjoNoKP6k0Ckv/XeXlPq/l0e2Oo76qZizOBBUUXulZ3
	I2/u96ZWXptdA3Z11l7vK2Fn6l9Lx+eyDeOGNtfkpnGZmvazIptbpvWq/W0/PlXp
	rZUGwtXkk2mpPU9wdv9qc8tU/lEHbqsMcgCn+5O1wQr72rNVxXMNP1amgbtUfmCa
	+o8dfCSXhm252CWENuFXAbAnl8bQVxr+z6g==
X-ME-Sender: <xms:ydJbaViSRyFV5ZO4mME4lQt1QgoNlqwHm_iAcwM344OMHkHQsSTngQ>
    <xme:ydJbaRdX5mMh-w1F1-WljDhNENixHeCs6Z6dJUSGFA8e1f8Fn6sRLYqO8nbb2TN-6
    o9pboCTmKJRDnknFyCTe5SOpm5gcyLkbH55RYUEjl4hEKyoa7D_>
X-ME-Received: <xmr:ydJbaSfHA-vJiLuP2jgEn74Genxbe6DzLvMETnZ7kugBuIOMkwZiI5-1TTdpdtjwpCY5Stzfz116ZuNWAAoDGnNUH1RHBNURh2N4bZwF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeeludekgeegieekjeehlefglefgvdevieevjedvtdegkefhjefhieetfeduudenucff
    ohhmrghinheptghouggvsggvrhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ydJbaT9ZR8h2I0JdSGIDrkSHcwUlyJzPSDFkS_DzYxx3gKKBilM4Vg>
    <xmx:ydJbaWkVBbMPzE6eBExHSkUEByfFeC97f6ftyUHH6PQx4Hrxy-A7qw>
    <xmx:ydJbad_0w58q94D4-miWbvV5y0M5b2orGwEKz_SZqefm54GuxteoEA>
    <xmx:ydJbacmm1qFwIc0K9PlDHnDy3pV-fOh4a1wi5xGfoOjH2KG7jHj0mQ>
    <xmx:ydJbaZqhK_cHtXMYR4fYKEN0vVbRUbCM7HfcHKx4ikHLHZyVpHVBVD2S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 10:03:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98afa314 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 15:03:35 +0000 (UTC)
Date: Mon, 5 Jan 2026 16:03:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: git-last-modified on bare repository
Message-ID: <aVvSwkK7RdpFDaVv@pks.im>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>

On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
> Hi,
> 
> Now trying to actually make Forgejo use git last-modified after being
> pointed to the non-yet-documented options but I quickly noticed that it
> looks like it does not work as intended on bare repositories when looking
> specifying files.
> 
> $ git clone https://codeberg.org/Gusted/math-accuracy
> $ cd math-accuracy
> $ git last-modified -- LICENSES
> 768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES
> 
> And on a bare repository:
> 
> $ git clone --bare https://codeberg.org/Gusted/math-accuracy
> $ cd math-accuracy.git
> $ git last-modified -- LICENSE
> fatal: ambiguous argument 'LICENSE': unknown revision or path not in the
> working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> 
> Is a worktree required for this to work?

A worktree is not required for this to work. The problem is that you've
got a typo in there: you say "LICENSE", but the actual file is called
"LICENSES". If you spell it correctly it should work alright.

> Because it was talking about revision, I quickly checked a refspec as input
> and it looks like I found another way to trigger a BUG.
> 
> $ git last-modified -- HEAD:LICENSES
> BUG: builtin/last-modified.c:456: paths remaining beyond boundary in
> last-modified
> [1]    202076 IOT instruction (core dumped)  git last-modified --
> HEAD:LICENSES
> 
> On the bare and non-bare repository.

This looks like a bug to me indeed. Cc'ing Toon.

Thanks!

Patrick
