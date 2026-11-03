Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702060;
	b=TQqpaCKfbseHYEcbY0248eAx7dTddY2GLlCOp0/tZYPMNcK9pFS3w0eMTedSBd4FC/Hb
	 cnD/H7mSozk4sdTj4p5w4jo/9dxlfE4PMsY5nO+VIIkQcbhvF71Tazc062DuS0PYguRYp
	 Ok+J++q6X+BJlj+Kb44lcNkGG4kNTUTwaMpWa+LwDxutplwtvvVpk9I+Lr3P3lPp0wNkT
	 TjK+cQ97Y9fFNOGU23LnwMHyhplkkO/EAMHctgQTpZohj89OV3G7j3GCIuzBv2GM4B0VK
	 0km3gHCuK5b5+aFs0V1vr4PlWHM1IFHFv3CUIoNmyUpZfRcboBQLFIake4njMMzXr3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702060;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xoxL+A5HLhStJIzen3bH+vn4l5jIJiQ3YXYoTEN3kiU=;
	b=SMHu12pHSErleHlvqIE5ow2YWgAG4fGPi9iH6pn9Ru0dhuwmhwkPL7hYtJlTVqzovLSp
	 VAcq5+qhLKW9jFvJbHvRPiivOf7iQqe9GbgGBmuppY+Kpu56xZ7ZT3aR2RPlgGTqQLGtc
	 jNzxfEilLY3pe3cZ2dx0/Vr4F9sjg1ErFmIsnuRXvzdmHvb7J0L1ekKA2+4Iw1wZue/Jv
	 rW4AOF6zmy4tcIQ/RF4LpwQmYyvTN23g9Z6XJRdmXJpvRSaOdwNFDuFF20jvbda5zgV4i
	 d1dPvA6afWZ+qmiYgyFWZwAX6GKLi8qPw4Zxak0UhXEnmXVZekPl8dATh12y3NvjTjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Ht0acWi3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="b/BN/Nue";
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108E6072BEB
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1108E6072BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Ht0acWi3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=b/BN/Nue
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 538501D0011E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:34:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 05:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793702059; x=1793788459; bh=xoxL+A5HLh
	StJIzen3bH+vn4l5jIJiQ3YXYoTEN3kiU=; b=Ht0acWi3iLJ8533FEKvaDGIl/C
	LIG4E6UJeawaF7xxueraz1chPfPU0rlFLkPCVk2j2VD3BOx57xit0NMN/3JQw7BE
	hpUHylSJTnRNsyDP8p76cmEUPZ/8NZ+8yWnQK3hJNEzb94hsZeQxhinFS0dfTT70
	Ka59cz8ebcbsL9Oiaj7h0imQ4KYb1hrERvlp0Wrga0OaTiZPtQZjxMaVFEJ7J8OE
	LJeKbTYXzgYG9DxNhQMPlgyo6vufqH9vOcUNoiG07kZbG9cQ2K7s50kGAHQKa94A
	WDbkrmoZgGsABLEJNgVu2DtGsgCtEJBOdzH4Y1KwRh4qLRZrIhNsEeYkFLSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793702059; x=1793788459; bh=xoxL+A5HLhStJIzen3bH+vn4l5jIJiQ3YXY
	oTEN3kiU=; b=b/BN/NuebqFhgkOR4E55ge0sbPjucdjmo+VoolAfPWJt/e6MoiI
	lyTb3Kwr0pUDZcwNkLQzRLayPIqH90jzF4SARFiMjd9sWWjKOaoohZkuVzleK4hm
	eC1G3CYg8y3wREBazuU0yYJuOILUEvkRQTcImM/svkAyWI6i7FmIOvnrdEQkJmz6
	sRKDjqSw0bHptxxgZ6hdT5vZwf+DxVa0E7uMqxk1cJpfzVqnTH5SGJSutDO4P4EV
	kyjx8DCoQ3/awJIPqXONGZIfVbQkkvvqltt4YVX6caqBMx9fUmTLc670FtrmRxD+
	TCOHHjNR0bZQw/E/S7h6fptyXaiBCFkiM+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793702059; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:sWcabsmQqbnNxnArgqM94qPe1BzbqGDWc/80i3Pr6Gm7iQP
	/pEy4Ec2abVXkR2O/zxp+i3v0ZsgpbZs6trj1doj/Q595HxK6aTmXHEJSh22Qcst
	m7YRsJGIZtw3jIezuyWgWcmWtpM5qCukyk2UUITU3T26lTlgli1Eq4eSA5VKlLeR
	Y1NphJXzWEh/ccX/jZIUEThTaKBqgfqSWDav+UEFN3EmXoYOxDJ+zfF0U70IZst6
	jzE6EAgsioUb/DgPAbTCQTfq+t/7vZEIfbgMU1KIFkg/S6wD3cjS0vQJyuEwVU30
	w5OGRObszaz5zMRia2Pz84DAjoEb5XDFouScbFA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6eJvq7GWnxRNX+slXjZTzhNHRuG6++q/kQkGDPB0Mbw=:2Ul8s9uQkf9IPi5W1mIhZWDUSkcn6gS70Xjk4UkGPd4=;
X-ME-Sender: <xms:q7jparEQVQhnT0JkL7OvsoGYgXPk--0fNGs5XRyjda342EvFL4o2eQ>
    <xme:q7jpauXA9rLTIA2wVWL-vslvEyQAD6fE1cZBD2YTgVeSC6KOa0GiV5o-FYdLi-jGn
    9FwmsTs_8QnyM0lE9p5A9lqKv4oEP3gIFIpXoYXIjdphxk1PcaGQmc>
X-ME-Received: <xmr:q7jpaqzVwoGorlLjZmUNncdQetO3F4uHUTYcDzTbBLagTl0GZWv1WA>
X-ME-Proxy-Cause: dmFkZTE0gS5XOz6dUjX2WxTvKbLlC8Wj574AW7CIHzbJkGAwjLt0iqeM70jeZj4a6clHL8
    LB4Ot9G/hgA8/LtpE5zbhXoHYTI+nNNtnKwu2oTjkCyMQsqZV0GfZPApFB74chxxsEkbCu
    G1dwyCDe+0bVM364AJVGt1BVLdFgdadtH+1W95Igv7iy6rQ3xqd8GDAX/wmKimLuk7ASmI
    sooVXe6pkgZ3qN7qECHoMjSgq3PaiCW4k35C4a2yJ8ZdcyUVGno5hz3RiqbGTq0EEx007a
    PPP+Wk1JrriAAblMjz3H6V9gkHsq7FPrRUGTT51EMUcWfnC+SBWv0EzAFkyrRO6ypTJrH6
    Z9EdSa/dGfxxYKrQIpe0ZsfeTHNhGcDKm8z2hFE66p8mORUyv829txnpfAOH6XHPRcF9ur
    X1yq0PM1GgNLf0Cai8MkqCefQ6BG3O7XL6ftCjCsftulQzI9ExLdNatA7Tx6+436RcZz27
    ggpsi1WlCB8Mga9ZjCTCer6aRxJPdW5zvNuKvu2gxNraCMfh3kk1wkVijrZJ4Q2U9hSSk7
    JC2so7BbjK35QzYkGBfcLTbuqWp+O1186BMH/J1D/Ch4fT9haiqfj6zQ7XzNB/+zhYb5hb
    3rj8OsY5DHo0dmLzf4ooo3GFWBXImatReQsBafvRxauvciJaQvfJNOoTTS+w
X-ME-Proxy: <xmx:q7jpakPLV5bTIJqE5bO2RBE_0J869feCBd2UoJV_aliwsYlUt7tFcg>
    <xmx:q7jpaj47ikn-FuVAVVr_jC1eBEuCYDqbtf8jBhIPEZvPBnB9N2rpWA>
    <xmx:q7jpatPY1H9JcrAxv2lq0BNaiLWHbK-yfHv3vyqxHSVOhM_AQsI1iw>
    <xmx:q7jpapmWhmA-a8XDKdh60Eof3Wmv0iVJQUS9Np9MzGYtxY3miAuuZQ>
    <xmx:q7jpamdLXZxC5_p2soogkflpMjGsm2f__ekfg0GBTH6pkJG-4h9lx5qQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:34:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae67b163 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:34:16 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:34:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] config: honor file permission bits
Message-ID: <aum4pZp5P0ZRC-cf@pks.im>
References: <xmqqbj8p7okv.fsf@gitster.g>
 <xmqqa4o0v76o.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4o0v76o.fsf@gitster.g>

On Mon, Oct 26, 2026 at 07:59:43AM -0700, Junio C Hamano wrote:
> When dotfile sources are kept under version control, you might
> protect installed files like ~/.gitconfig from accidental changes by
> making them read-only.  This fails because updating a file writes a
> new lockfile, copies and tweaks the content, and renames the
> lockfile over the original.  The original file's permission bits are
> ignored in this process.
> 
> Teach the configuration writing machinery to inspect the original
> file's permissions with access(2) and avoid replacing it when the
> file should not be writable.
> 
> This implementation targets configuration files rather than the
> lockfile API layer.  While in-tree files like .git/index do not need
> such protection, out-of-tree files like ~/.gitconfig and its XDG

Nit: a curious reader might wonder why such in-tree files don't need
such protection.

> counterparts are unique in this regard.  System-wide configuration
> like /etc/gitconfig is typically in a directory already read-only to
> normal users, making the issue irrelevant there.

Thanks for adding the motivation.

> diff --git a/config.c b/config.c
> index e0bb29b53d..2b84fb215c 100644
> --- a/config.c
> +++ b/config.c
> @@ -3066,6 +3066,28 @@ int repo_config_set_multivar_in_file_gently(struct repository *r,
>  	if (!config_filename)
>  		config_filename = filename_buf = repo_git_path(r, "config");
>  
> +	/*
> +	 * Do not allow updating a read-only configuration file; it is
> +	 * annoying and alarming that "chmod a-w $HOME/.gitconfig" does not
> +	 * prevent the global configuration file from getting clobbered by
> +	 * mistake with the usual "create a new lockfile, copy the original
> +	 * while setting a new value, propagate the permission bits to the
> +	 * lockfile, and then rename it to replace the original" dance.
> +	 */
> +	if (!access(config_filename, W_OK)) {
> +		; /* happy: we can write to it */
> +	} else if (errno == ENOENT) {
> +		; /* happy: we are creating this file anew */
> +	} else {
> +		/*
> +		 * most likely EACCES but other errors also indicate
> +		 * that we cannot write to it anyway.
> +		 */
> +		error_errno(_("file %s unwritable"), config_filename);

Should we quote '%s' here? The function is quite inconsistent, where it
sometimes quotes and sometimes doesn't. I'd say that quoting is the
better choice though.

Other than that this patch looks good to me, thanks!

Patrick
