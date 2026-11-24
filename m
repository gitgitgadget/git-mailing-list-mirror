Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554845;
	b=lpgzu+hjrJ6yF+fdqFfpliYtsRNZUOX+SW2TayZiADUPi34qVtm1IhwhrQ4CuRmZYtkV
	 DyQmgB7AsBPgMlPcr8EVptYvBhqcPL8ekhssPqwWvmtYpzcm8QrTgiBzzq++sG8O9jLW2
	 /WeJOJbHWNq6fDmH0wB+UDk/dp1sFry/nSN4hrHJq9rIw2KUGc5msW+azCChhXrtt1C01
	 0ysfDDDMEtB6axL0Xf/QNKJG1NeKD464ud0fTQ7rH+jKrivDbYhdueAb2WcUogYYovlGC
	 166QloPUtKpc4rg8ECnU6t10U7KHwcmMZ57l/hT1VUrSJhx2MU436JILgYxSOnJdJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554845;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XHm6ottBQNZad6tIR6LCwGVC0qhXk5wrOqNLzHUXv4g=;
	b=PxPNtpYhe5c9DZ18OI2BmH9Ti3fRVWOOYEp3pviLwrbh+kA6OnKDsWogQ1bR3wNfaLhS
	 tElKllFvwih86Cta1uIqRsI1G2nL0/aOzF7H5ZMed5RLFSvDbhHfMrgmc+EKZ+i1Fsjjd
	 xYpg89F8LwjNKUdg3MYFRN7yEuoI/Ghfehdnyx7/OMf3WMV7I6O84uYC/TSWGdVxl5EgK
	 D4xWLmEAaMA0yYuzT7rzG3FLj9lWCHri5nRcvdBLka8QSU/NhQiqh7v8iQh/sBefOMM+D
	 zdtsSgN125m6O6boKEKk+70gaz6xUOl0RDfFUYj41aEfc4YtRKdacDFx7pzCsZjn42Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="T/ae4mP6";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WXt8614j;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF00606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF00606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=T/ae4mP6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WXt8614j
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4907140032C
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 16:14:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 24 Nov 2026 16:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795554843; x=1795641243; bh=XHm6ottBQN
	Zad6tIR6LCwGVC0qhXk5wrOqNLzHUXv4g=; b=T/ae4mP608BA6Q8EHLvRr0/7qC
	7DegBg9POyDTRFTaunDraJUwNiAU5vDVJpnFSW9gMisREwUyljUZ+qHI6GsiCTFP
	WmUnnPZheKfVY+CzA/m718cQz8aldGSu+V3nAd/8ggt/ydLrOtd3S74AjbrIlOIo
	NppTz2MWXrk4BiP0ijCXUM5+koxMSC5mtSyJ7qgLnIOP3MMtnt74qC0XWMm+6Afn
	UIUnWjiDVJaLXcfgrFI9TkUtqbiBxmHkame1JOC8FyKWu0faloWOu1ebZ8TMOduU
	abvr3lhYG2+tntVgCYo8PhwwxKiI0Q1AINwuL4ISr+B4ybsoxZErbadqX9GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795554843; x=1795641243; bh=XHm6ottBQNZad6tIR6LCwGVC0qhXk5wrOqN
	LzHUXv4g=; b=WXt8614jQ7rcl+y3RYgWnQwCwkO3KQvSmN2oFMVcQ0ugrKstMKb
	NLrQ6x5t/DCoCXy6F/Nsx76LiVytJ4JwVTcBJq65Dm80INdZ5HO9k1xKg7EKbysx
	j0T5U6Yq5cxxRo7zt1qAqMXIT3w5VNwGyqhvqk0V+E6By90pTMOCK48e1Z0bWdAD
	azXvMq4EXSUk9tcaU3t/o2BZIB2w2/y08N1fuA2oLHawl+hYKEhjLYOriTrEMLu2
	rGWI+/8raQ3DfJGO0i0u7883CQ2GPBd2bQ+a0x864QLMwOxFgH1FxvfR3jz6Y3UQ
	JUoPHlSt8IGpV0u3NenZHjRwfiNmTD91jKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795554843; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:R93F/HB9WgS2wFVI/Mzu0bhBHpy2CVRykkqeFfY+Uizzt5H
	jQQqnI9BIr0IzXZiM0xa2UX+u6nz2HABZa15OXGEyK9UqcIRjVFnOrbj52P0898/
	n5AmuZFkpL4tNSU8vfkNQ01VMJ61PSWOwsMf3XX+CepxnqWJ7XEU7SFHGaPVIrke
	NajTNg0CM5OPWVWNEaaVCi2Ns+5G0MUGP7CMHaflio6qo6rqW4NOG3aUojetF1p/
	j3J1FtqoerT2KX5bBYz4Rluhx6klN+Rh7hrFxWt9TXfF1qnVyXdLY53tJX7Jf8ZV
	20PETybJ0+FLO+3vQ6C+WlEOfIUxoEke46ICyzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xfZCIc1zrgVRzcAH5+mHCrd+67PuRXj5+VAN6b5P8e4=:EMn8bz6wbpCpi2NusciG72AnMMVZedyAe7jiXxh2Y7w=;
X-ME-Sender: <xms:G_4Fa1wTnz0kb-OR1JHKhXb0SImhj0FjpodnOuxM6n4cgksSxox5eA>
    <xme:G_4Fa8vdwXoPDESNl_qsAm6wMDLG7-Urfowq-i0l6KoXmi8QO0naRYAGrbrOiTXdz
    F9JAcTMlJBvCZ5SSuHzpcSrHfwPCmzpMaaXk6qLMesJSewRjNbsJTY>
X-ME-Received: <xmr:G_4Fa8vZcScNJXMGob7jwWzff6ih4fONLT9tQHS7eBuq_j8CMaPNHOfYz0qip2X1D_MSL8AFptA-OJ8iCeYHC6qYz0ydCggDfek2sAs>
X-ME-Proxy-Cause: dmFkZTFbr2tZnHX2Cknwe0v+cTtJtNyy8o7DcYPuskBdJfU7WYpvPDTaHZUDZCSyFP3mDW
    7LdkNbxzRaMLh+y8cGsTfnU6WMq7bnxtLob3Hur6Xs3hquqyoakIOyl2BJIA+uzqv87lUx
    scrQolfev9nQnBo+4RonKZYFlGXybShLDRDIWBUFCNm9Fghap45HxGzNj33xP5w4pFgfEM
    Bqd7pFp30wgmLjYnkbHLxoko1lS273Uxy8yXXCldHsRlinSpLoO9jvO1Woxd+LDBauvrcz
    d1Vw0tN6cA4u0Xqv4tzmTQzA/Pt4lyd5RkGMiW9UhbixD7N+dIajs109VwU1HyXG4HDxoc
    QWWcQgxqtsZ/9qJe0Z4t4Z1jAb9LyivYxL3JZ1RADZzSFZzXfo/7nAfAXpAYcxvbPaEbSL
    i/86gS6ZyfeSHDe3t+ciuPq9tviJ7dS4g68sV7eqlqs4ptyg6hUjdCAOnVFJ/kkouCwKeD
    PklMWF0ZIEjG5O4sSOsxN8rbecSC8HWQOlM51VDnNDSCKWwM/otaLMaO1o5umJGbHT1e2Z
    jKjdFg1MiggyDJIZ8TQqcQXVOApFtJqyLHVPUBtteWU08PYSpODxCnmL8wuHxwcdwQ4jkh
    wWoWUIw+ldyQxqElSoWu+lQZEkpMbproGpfzgkuOQVxLP/lLynte31hbcE/Q
X-ME-Proxy: <xmx:G_4FaxOhFM9O0MeizGsZYeekerI0R3zclbbM02SNIGMX67jQiaYgyg>
    <xmx:G_4Fa60iZRZKf7va3225e0slPX4M_m_dMzknHNpAPrBEGJLTVdiC4Q>
    <xmx:G_4Fa9OyRG5_G3Z6Qc4X2X_gHrWrOtcIL0zd9fVVAyliLnpBEqjtAQ>
    <xmx:G_4Fa62_QO5VqrvGLP_JUcf2I50Qh04mOfRK-nHZnXfc4Q0fp0yBSg>
    <xmx:G_4Fa00NLyhtVdz5g0pSK_mWIdEm4w_Q9jJCQglW7O9D1phCzjQvF9-_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 16:14:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] packfile: skip closing packs marked as do-not-close
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-6-19beb83b145f@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Nov 2026 13:02:33 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-6-19beb83b145f@pks.im>
Date: Tue, 24 Nov 2026 13:14:02 -0800
Message-ID: <xmqqo6belyp1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When closing a packfile to maintain the maximum number of open packs we
> completely ignore the `do_not_close` bit. That bit is only set by
> git-fast-import(1), and as that command allocates its packs manually it
> wouldn't add those packs to the list of all packfiles, and consequently
> we won't ever try to close such a packfile via `close_one_pack()`. But
> that feels like coincidence rather than proper design, and the result is
> rather fragile.
>
> Skip over packfiles marked as do-not-close to reduce the fragility. This
> should not result in a user-visible change in behaviour.

Hmph.  If the only user of the bit does not care that this codepath does
not honor the bit, perhaps a simpler alternative is to retire the bit
that nobody else uses?  Or am I reading the above analysis incorrectly?


> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/packfile.c b/packfile.c
> index 0d5647c74c8..86ef3a79d9c 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -414,7 +414,8 @@ static int close_one_pack(void)
>  	int accept_windows_inuse = 1;
>  
>  	for (e = all_packfiles.head; e; e = e->next) {
> -		if (e->pack->pack_fd == -1)
> +		if (e->pack->pack_fd == -1 ||
> +		    e->pack->do_not_close)
>  			continue;
>  		find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
>  	}
