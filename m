Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1441C85
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733286970; cv=none; b=bzps8Xa51zQnhYWoRIw8MuUMtT1q/LNcEbNTx60YfC6ODSLrRgJHJWSf6taLodJa15uwGtxdtXfv7uP8n4FQdeAB3sZkXdBXqjA4HHBc/E7T85n/rV+HsGw9jJ0ihJQU/nLngCNEZFbMwyDweypmiDhPJoP3QRzFuaX3o8hsXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733286970; c=relaxed/simple;
	bh=vyk+g4/NOY5kEQkAKUqpnCU9Of9DfiW49X6PUJtdYPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TIU97s7IvjOgOXJJGOQwWe95QjMuMDauBi8v4L0tVjDM5NeVTrRWwMYlHCbj3CrVujYWKGnCraYC6DTHNqzz5tiU28mha5NH7Mf7EU8/9TTT5gRyPfb5R5pahKQ4cd0PDQDG9jgFPG+mzjc0lwVgSpxcjT2nBi3oZ+bQ8A0Irx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6Sx4oHP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6Sx4oHP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 03B741380717;
	Tue,  3 Dec 2024 23:36:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 23:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733286967; x=1733373367; bh=E5cCLqxeghp11KKjiBAy2VOWPw2p+GBO8C4
	T30XXq5E=; b=l6Sx4oHP/Vw+2WHFU+GNj4EHit7mWgbom4NaNHCWBIf04ymCB45
	us/ecY0UzSNFiAeu/OiYoOC5sc22rZg7MrH8imFuf0qyL/d6OAnfCIUBelUiHxyy
	P2lx7P5CxqIPxICVRZE/GKF/q0nB7phb3FcLRrSrUVtz41rNGfx/6zxOMtO85zN+
	bG4rkDHKWkkQCgW84wt3P+Bmvdz/IWY08mKzOiX8IcmVF3T6K2kWyJcJLIDi5Re2
	WorFFvk+S8hEZKH/mM6D/BUx6tMqeh+CEdgj1s/iNyTw3PC9PdkDxzo1+Ny5iShs
	9oIHl7EFy5m3GrfWh2IooyunUvLKGTKBlRw==
X-ME-Sender: <xms:NtxPZ962vF8SMvvo0D9Z6HVXTLnDDU-pbbPLAn-by-srXokxB2z2ng>
    <xme:NtxPZ65sQ7A29dQqBTGtVPCr_wU7a1GxN88Jjr960nf-EFj_UuLf1Nv40LuY2UMBq
    b-oEObZOc83Bk0MIA>
X-ME-Received: <xmr:NtxPZ0fyIaxSEyk9wL61ucFavOPG9B3ML9hGmF_8JyoQ5AvP0VFKwtxxIubkCToIAi8qCvLijccZ1RcX71ILLY5xyZB3-xFP3oaa19k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepkeehue
    eiheeiudeiffefffetiefhieevffdugfethfdvheehhefhffejieeugeeknecuffhomhgr
    ihhnpegrrhhgshdrnhhrpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    hnrghthhgrnhhtrghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NtxPZ2Jed_rmV80wWwO-fGSQVOmq7nysSvc8BevYeRVfigeAHdLBjg>
    <xmx:NtxPZxIAOx51UzkJykKtx2s76g1KCHi4mwvkj-E1wb_2wAXA9u-gzQ>
    <xmx:NtxPZ_zPrQ4m9BNZiAlup9zsWGmL2ZLtZt46CDSKu4aTagJs3X5Y4A>
    <xmx:NtxPZ9KHyx8V3GmJsarhjMTLoAt11LByLuEGB8zQ4NkBD0yyXQDeBQ>
    <xmx:NtxPZ-F-4-amRP-CoO2VpOHP-X-Q4s4PCvNWtoJ3a_qKJGqLuLdiE3cK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 23:36:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 1/3] index-pack --promisor: dedup before checking links
In-Reply-To: <7ae21c921fe367d4b15cd4a299196009c15205d9.1733262662.git.jonathantanmy@google.com>
	(Jonathan Tan's message of "Tue, 3 Dec 2024 13:52:54 -0800")
References: <cover.1733170252.git.jonathantanmy@google.com>
	<cover.1733262661.git.jonathantanmy@google.com>
	<7ae21c921fe367d4b15cd4a299196009c15205d9.1733262662.git.jonathantanmy@google.com>
Date: Wed, 04 Dec 2024 13:36:05 +0900
Message-ID: <xmqqy10w3w0a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -1781,26 +1775,41 @@ static void repack_local_links(void)
>  	struct object_id *oid;
>  	char *base_name;

We may want to give a meaningless NULL initialization to this
variable, due to false positive from a compliler.

> -	if (!oidset_size(&local_links))
> +	if (!oidset_size(&outgoing_links))
>  		return;
>  
> -	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));

It used to be that it was really obvious that base_name is always
initialized.  But now due to micro-optimization ...

> +	oidset_iter_init(&outgoing_links, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		struct object_info info = OBJECT_INFO_INIT;
> +		if (oid_object_info_extended(the_repository, oid, &info, 0))
> +			/* Missing; assume it is a promisor object */
> +			continue;
> +		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
> +			continue;
> ...
> +		if (!cmd.args.nr) {
> +			base_name = mkpathdup(
> +				"%s/pack/pack",
> +				repo_get_object_directory(the_repository));

... we lazily allocate only after we know we will run a command.

> +			strvec_push(&cmd.args, "pack-objects");
> +			strvec_push(&cmd.args,
> +				    "--exclude-promisor-objects-best-effort");
> +			strvec_push(&cmd.args, base_name);
> +			cmd.git_cmd = 1;
> +			cmd.in = -1;
> +			cmd.out = -1;
> +			if (start_command(&cmd))
> +				die(_("could not start pack-objects to repack local links"));
> +		}

We know outgoing_links is not empty, so we know we will enter the
while() loop at least once, but it may be possible that all the
objects in the outgoing_links oidset end up to be missing or packed
in a promisor pack, hitting continue and never running the command.

> -	oidset_iter_init(&local_links, &iter);
> -	while ((oid = oidset_iter_next(&iter))) {
>  		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
>  		    write_in_full(cmd.in, "\n", 1) < 0)
>  			die(_("failed to feed local object to pack-objects"));
>  	}
> +
> +	if (!cmd.args.nr)
> +		return;

But then we have this early return, so from human-reader's point of
view, we will never hit free(base_name) at the end of this function.

But GCC used in the macOS build does not seem to realize it.

https://github.com/git/git/actions/runs/12152173257/job/33888089229#step:4:380

It may be safer to give a meaningless NULL as the initial value of
the variable.

Thanks.
