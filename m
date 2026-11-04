Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774478;
	b=mtxo5JG89VIKhPtGXNE3AmJ0y0QqZEi/zwcGdYzRVvlGI8cp04wehUcvIezyYqDtIixn
	 js9e3xNWHC1iU7RPMmonYmE31yv6ndTMDQhMWwr8/B8V3j+ISL4gENA7qHJtwiuQfEqMR
	 3KPZo6nuoWvQuhd4Dn/++/56ZWieCfES0fpNhg1XcUIushqNJv4ZjcFo+NvjnyecjFyNl
	 /+Y722Iqs8BvpSaW1ij1ljCLmg94tKuHVTXZE86OTuA0V1VIr7phxPced6tTBpuPibD+W
	 BxCPOZrihPBhLREhpBJpwkE6A+X2AenbA/maN5WAWsQbnVsM89n/ltv+gMRvasPLh2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774478;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Nqy4H+zryYm694a3ZQpCsNYwzVHmch2taJ5D01ZdP9A=;
	b=iv6Yf1HHAA4JkfJ3xSvk4D0D44FU2MLtexKfVHjudwlf6hRJocyMiVC5VSrtvUoXjy4e
	 IH9rC2LiGoyj+HCZj+wasS6UlrAXSU9PbHNzAfPohj2u2qcsLb/rG6AVitdaoscC1vuD6
	 GBmeyqIa4FKskVb4ea4SBnCgieMxzmx9tDutl3KEk3Aa+uAiLRP4c/7xCrdoS7Z9A9NES
	 +VayIicKl5QgPAGmP7q53PVgtnwr2sCKUI5Djtikni07NSIyUyXJwPVJzBSP1V2LCUS+c
	 UG+6IzJC01bspJlKll090NeOAc9wf9ZBTgA0wXHoJnDlVNJdQbFtm39OUwLGNWVqZ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=LQP1F0w3;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A7606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 439A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=LQP1F0w3
Received: (qmail 12340 invoked by uid 106); 4 Nov 2026 06:41:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vXUcOt4Yxu0YLlRn67S9YQmqyeXAEH2U8635m2yFe3E=; b=LQP1F0w3i9eVSBQ08Gos4p13NWyyjJHR5QyaTZstsqkUFYQp3E/bvGejFt+OkRfded3kRQEFptwrkyAcuO0LFJi9d/+mx68XReykkOavBCn2w17HRusgTVvsecXL4Z5mkecntXbOUCJ6wkFvjXtvFGifI7uQVzB/heV+6WdIDcX5AQwU+jO47hxUMc7GC3tQ/rX1YBHliGGlB3XvEfbUciG+u6hBTONx2mj0Sf2pPbUIgUalk1FHbqd9P7ZotMvn0zdVAPyI08vX089NKnEgvqI9Z1964k30QkAeEeYTNOBaQ70xW2nRdZGYljHdDhWMfm4htbHBNMNs8X+n4nNYzQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2026 06:41:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29693 invoked by uid 111); 4 Nov 2026 06:41:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2026 01:41:15 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Nov 2026 01:41:15 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #01)
Message-ID: <20261104064115.GD1543013@coredump.intra.peff.net>
References: <xmqqcxsmejd9.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxsmejd9.fsf@gitster.g>

On Mon, Nov 02, 2026 at 06:31:14PM -0800, Junio C Hamano wrote:

> * jk/test-env-quoting-fix (2026-10-30) 1 commit
>  - t5702: be more resilient to env quoting
> 
>  Tests in 't5702' that grep the output of 'env' to check for the
>  'GIT_PROTOCOL' environment variable have been updated to explicitly
>  echo the variable instead, making them resilient to quoting changes
>  introduced in newer GNU coreutils.
> 
>  Will merge to 'next'?
>  cf. <xmqqwlqytvg9.fsf@gitster.g>
>  source: <20261031002550.GA626623@coredump.intra.peff.net>

It sounds from the discussion in the thread that the coreutils behavior
has changed so that this becomes a non-issue. And I just double-checked
that the version in debian unstable now works without the patch. That
said, I think the code after the patch is more robust in general. IMHO
it's still worth doing.

-Peff
