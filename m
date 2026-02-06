Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC89376488
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388419; cv=none; b=GoUQtqq1qZUm4CR3n3IayojUOwF2hzpiTu4tyWVd4w/r5vPXelOJ1OaPrso57ZFaaUvgoIQOoiG/4gWcPLujG+QyDmbBeseTVtdievlIKA6J5fVDkO8PsnN35hxMbHbviXRsShqN0Dh6WXpSFRGVkckqPa3kuNBXfyWg8Dl4VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388419; c=relaxed/simple;
	bh=bE2FDhWnMPbpggZKS3tu766vEloUcKF627kmqVkE2Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjg7tRK0qWiVl3OoNpAHChh4IB8bOVRKiAc6MS1xipreswIYsyvoRj7JLtmUzWYa58fuDFgSyUFpvoCzBik1mmDLdCpDOyGBxBIMbs+buHUj6KRtIrGPUkonxe9yieZfmyag7dUPokGAIvoV3mI2nFRPlW6VQeDDq6w6bSO7aa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hCUxRYTU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YcG2jqK0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hCUxRYTU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YcG2jqK0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2DF851D000B2;
	Fri,  6 Feb 2026 09:33:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 09:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770388417; x=1770474817; bh=5OG3UqLH6s
	acFeqnXHcBv9iiqx8adGNW+/UOhZXijUg=; b=hCUxRYTUo15syNgue9ALtsiJ84
	ZAEIgbOuqk6F8/qRB2LOa9toxsARP+xzEul8nyuFp88i4MsFrTR0oK7ZBIZNvjSV
	jf+P2UL7HQo4nkkUqTmDhzj0qXFA6dle8oXhr9mgD/LVuDlNKv03JVqCMi2W8qfv
	GCTKOEQfFPvBJUFjP/cUQ9NIHFo19xKsL/Co+iU0SLjGSjBcNfR61s/ERqUrPPth
	VpkcdHvIWZVA+OUtpSzZ61V9DRyECoy25klGSnytp1TsDCzA6yoi4xsL86w+WQ7w
	ZTgI92KB/WQJF+I+jk7ygnUh+W9HfJ36A1cGRCyh86w+rppLIwJOV0/wCT6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770388417; x=1770474817; bh=5OG3UqLH6sacFeqnXHcBv9iiqx8adGNW+/U
	OhZXijUg=; b=YcG2jqK0ida7J+GuYsRYQ8w5UFnEYrv6Y6f5yZU+yA8n6X+5KEu
	wRjVcvypqkklM/8l7hfc75/mPnIT1nczzOE6rZYJ+cwaEjDkz9vU4yPkdRwro8Ro
	ZsZ8P0Gk3uq1ssPPhDBgPLXYP+I/OSIRwO0RzGyhvNzkZPz6N5P4HDqvQCD5oNZl
	uXhVvYW33APLw/i1APeHk2ggURyB7KIV+1xARlwXNr9hPhbhVLcszay9V2aAkYZQ
	8GJtUocXAuAnL/skfHLaaLcyrwENC/UCaaYE8mQ/WKQqEfUF738vQlzJp+rrCU7O
	pZBBwTFRVSw72u2IETxAJFxa8VTATLPtHJw==
X-ME-Sender: <xms:wfuFaYv7O7auV39oGZw3AQl2K_NbbzBTtuT32pDtqey9jApUL0iusw>
    <xme:wfuFac7zfpufudV6YueJX8M1Y3VKFSPDhlhE_Fh6sMtB0-4XvfKQy5EIKnTLhwqGu
    aJLde1pq2IoE7rFtPaQzmyNou1WVOT7pPxpprSm192vBlUv5S5ksQ>
X-ME-Received: <xmr:wfuFaRLrft5rUY0Fpqk60fZKb4xD2cj7-18yLznHiPo7VWEPhnahBUABIVpBNz_bJGAdGCaa0CJaFnBtCh50mg0W3yDxMQSrZqfdrywf2kY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:wfuFaU7GnvxfEobTikAvRZiuwsknaktxix_dLU8q4FW6yjoQmx0m2Q>
    <xmx:wfuFacz-DRT9R6Mv5iKkytBXcrdMfoJH9FtmHfnJMOf3Kw5lzGDvFw>
    <xmx:wfuFaQZGgvN-QjvkIh5N2qYrGRYnONu0QPY2xmVLvngOSLGvHcLrww>
    <xmx:wfuFaWQ-vOh-YsYlMW0WW8qFtPFdPPWxp24ZlVJ0kEp4vRtuyNAWYA>
    <xmx:wfuFaY4r6PUoiCO57pSOOTKBbcBytuHP6KzjeVd5QDN8dE1NhGmsnTvh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 09:33:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24e93734 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 14:33:36 +0000 (UTC)
Date: Fri, 6 Feb 2026 15:33:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 2/4] refs: extract out `refs_create_refdir_stubs()`
Message-ID: <aYX7vfG8XQ0p6h1F@pks.im>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-2-3b30430411e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-2-3b30430411e3@gmail.com>

On Mon, Feb 02, 2026 at 01:26:31PM +0100, Karthik Nayak wrote:
> For Git to recognize a directory as a Git directory, it requires the
> directory to contain:
> 
>   1. 'HEAD' file
>   2. object/ directory

s|object/|objects/|

>   3. 'refs/' directory
> 
> Here, #1 and #3 are part of the reference storage mechanism,
> specifically the files backend. Since then, newer backends such as the
> reftable backend have moved to using their own path ('reftable/') for
> storing references. But to ensure git still recognizes the directory as

s/git/Git/

> a Git directory, we create stubs.
> 
> There are two locations we create stubs:

s/we/where &/

> diff --git a/refs.c b/refs.c
> index 627b7f8698..32b4edaf2d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3402,3 +3402,27 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
>  		return "unknown failure";
>  	}
>  }
> +
> +void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
> +			      const char *refs_heads_msg)

It's not really a message, but much rather its content, right?

Patrick
