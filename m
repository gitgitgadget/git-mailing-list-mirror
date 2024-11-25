Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AE18B475
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523209; cv=none; b=GczXtngU+cy7MiS/gL/V7FC+F4BiuwWCqVH3vWuBxjYwExvsZogJN44jqZbbBC/0vHJMtIta+pgqfUqv3SQo6kGX/krSEShPmXo3Vkkzx2LFele/V0uG1q5xxBjwibc+oT+vXD9ivifptPFu2BYRQOuxXhCVGvGAbSusc0V4dVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523209; c=relaxed/simple;
	bh=/eTPswgtBB0d7NuvepEjp8diVk2tTQFcYeHTlWX1SrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR2zSyxLkBao9XCR4slAzAGz7W/E1yl5OUfQAuv9Pv6iDmCFA0iZNKzuVVqrUT7WASMS8rFE56ukcJeCbBs92mOJtTqed9tuIuzy/2IQt1fcRVRW6WUEsOs5InCXTcpaDZtufPzs5D1QokDuBnpe5g6djIURAF2dNVUQbRoMIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UmM5zS7X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sCaYPv8T; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UmM5zS7X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sCaYPv8T"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89F7F2540161;
	Mon, 25 Nov 2024 03:26:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 03:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732523206; x=1732609606; bh=Fawd/KaKdd
	WuyBp64sde5tdHXhR4RMmDBhD06VTLo5s=; b=UmM5zS7XcCDrBMiW1YKGdoAnbt
	PEEdyDKgNfL4eG46fvGXKgXk7Rs6aSp779xnwIe2KaytC7MOJ/hZvsUslD+g1zM+
	uCokIglr8Syz6NjChwVVN5v+NGTt6146k/E9CAq1Gn6qxRubq46+/SzsK9L5I08z
	s0zo7Dh0Ss2eosSRy02IkkDOLdkGT91YD+2DQgkDJ9UMrXwaL0zFNPZwShi2q7DK
	84AG6CgYPNRFgdn/jRMEjHoRBQsJZMyTO+L3mpvWN6pTQ+8iV0+b/munbkazRFcJ
	3F8ghDDp0/t3cVAKbPjynPrJNfOboAjDsUBXunFbes5oXDzmMKZ7CeOYf8gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732523206; x=1732609606; bh=Fawd/KaKddWuyBp64sde5tdHXhR4RMmDBhD
	06VTLo5s=; b=sCaYPv8Tp0Nc1SPv4J7iFqOX7N8eILuWaSnPpE1ZUt2DyusgG1A
	35K+xLJ0ut48SBqenk4Q63S+6Rbig9JiEl4iLAliHoIYbR6KTX1juHHdVWI61aRE
	ZvOGLo3xvlwNEp9UvU1ZMKmlp0HSeuYWo6GFaMwMd/urqsjU5GujelB8EH/KDdTp
	3dPy5tYV1056LWlaSAwL8va1pUdLXMYfGZz0u2q248Tnu6zCcBcE1GYE1sd3zsUn
	UJELAEN3abaFNOYEAAgjB8CXnUdo8dd15GlV/f5tFuADcKnf8Ivo5PoXOBdq7El5
	Op1IHv3CZ7w9McNXzQBlQvZi5fRrzWzZZ2A==
X-ME-Sender: <xms:xjREZ8h-XlHfx6KBA-KqlR9VVYNlBJa0tSKDJ3DheBy31mkG8Xe4jQ>
    <xme:xjREZ1DHeSO_usPvNwDMXZwRjdz_-Bga8VYZ7UR-BTJvqajfxgLxYMH5y9JiJQdCl
    YWfdAvjiJpPHUX2aA>
X-ME-Received: <xmr:xjREZ0EVDJkNQyLLP464LDWyHoJMFVp7UFc2EUsR8Y42OJcvOzzauTkIRGaQtIBUQFAW7dq_NAKoMaDNQNG5B3kaqy_XZ_Q20A8FaX7s4SpLUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrghrrhihsegvlhguvghrqdhgohgushdrohhrghdprhgtphhtthhopeif
    ohhrlhguhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:xjREZ9TeDEC2Y5w-j7DaAa-QSiQ9_HRPmyKn6HDp_MVJrt5CvI0zYg>
    <xmx:xjREZ5wcYVWNu5A6wA56FsPubJb-_BzqdK7qmVdpLAyCYISHd-OmoA>
    <xmx:xjREZ77yw8Kt7pg7Dc1iS-efqCJNJWgme0E78zWCJKLf48s-XuLCow>
    <xmx:xjREZ2ygSveeVaKV5zs3hzQ0qXEwwsHE7awZSn6TwaC9g5eaNZDSMA>
    <xmx:xjREZ7tQz9IklHiaqY6VVzBycA7rPPZkQNpLqsbLezFOkhtHsAm_ttjI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 03:26:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a09fe72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 08:25:44 +0000 (UTC)
Date: Mon, 25 Nov 2024 09:26:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v2 5/6] push: only ignore finish_connect() for dry-run
 mode
Message-ID: <Z0Q0ud0SJ8ZeEvXx@pks.im>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
 <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <1ad61a02955fca35c4d1763adfbac3fd36482e09.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ad61a02955fca35c4d1763adfbac3fd36482e09.1731603991.git.zhiyou.jx@alibaba-inc.com>

On Fri, Nov 15, 2024 at 01:15:36AM +0800, Jiang Xin wrote:
> diff --git a/transport.c b/transport.c
> index 9e03a7148c..186d58e907 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -923,10 +923,10 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  	close(data->fd[0]);
>  	/*
>  	 * Atomic push may abort the connection early and close the pipe,
> -	 * which may cause an error for `finish_connect()`. Ignore this error
> -	 * for atomic git-push.
> +	 * which may cause an error for `finish_connect()`. We can ignore
> +	 * this error when both `--atomic` and `--dry-run` flags provided.
>  	 */
> -	if (ret || args.atomic)
> +	if (ret || (args.atomic && args.dry_run))
>  		finish_connect(data->conn);
>  	else
>  		ret = finish_connect(data->conn);

In the same spirit as mentioned in other commits I don't think it is a
good idea to condition this behaviour on "--dry-run".

Patrick
