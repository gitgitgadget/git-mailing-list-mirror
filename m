Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003266;
	b=DF/1Kgr+pARWXyw0XOIL+iBpv6Parc5WNkwkeX+cpfZ5y6LYm9+6y6jLllGg8IWcrHLs
	 jilyft5zVqtNbC4x94hvD55DiCGzZSfRJgzs74EBL9rfGltDBIOYp0dPQtVs/a0Nhnslk
	 05mGkRz4kmsiwU83eIt9l2cthxXJJX3UyIp+xTJK6kGPLfNF8Gew6r0Coz5NWQkC1sm4/
	 Mn4Jmtw2EWWu0wu/tBDhcNVK+aiiymsjPBlHlzF3x/dGXuuXA3l2KgGMr5tQ+35Ol3fHI
	 w2p7RKn8zIBOB5uU93GUhI5lSUkDpQcvvxujkjnpcikLt8HAs9uLeD9ePk8TshLtniA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003266;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HUhOLHgotTw47QLO44J8JTFiajqHk/lcqVVNMvCIDck=;
	b=0fwa9p28+DF2xqsETN/2xA4IUX2/gV3h+8FfxoPdWS0LF/P9UOzBgxSUF0k4fMa/FHew
	 7T/RPdXrDSQQXTiVBGmhcksy54fiFiE1d/D9UU9EnAD0lrATNF18JxwaJp0uXgL/AyBbb
	 Iyuq40hoMsI6ki/R7EzxlaLzlG+Zu2MhOOj0BOS40YDt7VVBSHLFsA4evZM/eiVV1U1nv
	 XOkAJSoM8rcPPb1fmVEyFDCEJetXwTux1vWN5ECTDcafiFdh2Fr15uaG+fmxwtne459Dz
	 uBQ/7j04H7tYe32MsUrVr9uRW83C9XK1UoUFv1tbcR3VM/znfxyi/yrQKJMwkFLZ1qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hSkwLxXw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ClO8V6dD;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA0606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1AA0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hSkwLxXw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ClO8V6dD
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 009AC1400126
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:01:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Nov 2026 07:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003264; x=1795089664; bh=HUhOLHgotT
	w47QLO44J8JTFiajqHk/lcqVVNMvCIDck=; b=hSkwLxXwO8KYTuWA9pJxjy2Ce7
	8/HwIUBPqqJTDMtewSwLMl7/i7GPCGndvWsdU5fs5dzhPHVxnwuekoJVSBavACui
	IMpAHnWHDlPcieDQDwZ1yNtm2CAEY9855zGAF7qbUCVZhNhgPFih9/195ZBK/o41
	UkKK5D5vNhdPBkROK8Qkc4cpGagdJJoDTBLVi/2f6TvTSuMJedOpAGcesgyBxdSZ
	nDWtRDQQe61w8paWwWYExDExG9nSCtonzziDgZyOqgzHLXbHIlg6f1cNWv7E84uT
	8zN+nfgarkfW/JJCNtj2ncQcuFnoVJRLe6reg9yqSGtn7tdNW+S/6Ra4FWYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003264; x=1795089664; bh=HUhOLHgotTw47QLO44J8JTFiajqHk/lcqVV
	NMvCIDck=; b=ClO8V6dDUT5SkvqbSSJLMlnEqiUpix2ngWDiEi3xhEunjOY4iPe
	ovuvhtcDzdY+5wp2REbBtoxgR5e9AUyz1cga8fEQTRb2H5W1KZB9Mc5E06VRbU54
	u5pwyQqehqsZfV4ulyu4X0zv3Tc7diP1NZUC11u/eHVnF4izXDjszNltNeqpi/k/
	URzG2pPNlw/LouC+WdMLfnfARUsoia9eafud+iFCMVI07ViKL7W5FunzmyfQZOyw
	8gaZpwmCo3qd/csz5osP69+R00THe25Oq6r842NY+U2Ja9qty7hIyMWm8wZFoz4a
	cu5XEzTYJaqP2r5HPcV/4M75AyCdyCaYOyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003264; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:pTs9a8M7D+KUvnr6O0yR4DTis6v0YFOrFkv2Vt0QDmPyStn
	Au354+9i+cWsu+ysh9tQqqO67mYT8I3TKjli8Zec6qoksL8JkOkTs85Z9xFwnpbJ
	jpUNucxnAvbIh/yMWT1HScdEtNjNv5NdNYm+ZmSf1Wmb+69eyiBxmZHOZciewmtM
	yJFkAdC4RMdtT/jg898xdyMmFDvgZ7aVIZ8MVj2ES789p3buqyf4JuFWb/9OBr6q
	4xAk7RPPfKcSQODpbp+29lrhEJQV7uwYdmnlT9LepywC5Ig5yQZlETwTGOOPkS9x
	4XQ0/JkL40L8JjquE/f5/cd0NPnZ9tjM1HEkgcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:g1OYT4NqYk9L5HHdVIkXklYKvxveUC9tmg8AyKI6ThE=:rW9Rz1LO8H0z+ZgmassSJZl8ERCeWyJbSXGg1AEi0L8=;
X-ME-Sender: <xms:gJP9as_mUd0-XYX_Y_NcbhdMVYn9ljaKI8w6V1nkyOo9_99PUFgVKA>
    <xme:gJP9arkmPjWFDBnwPv41rpTExMCfOYQR8xxQrIqPDvP0Qy2BTYO6ENnRaklkaQJKD
    pep3_rR4vs5RPkrTDlM-TwO53RK5z2y63B2-B-XKYNusQf1DDvwaQ>
X-ME-Received: <xmr:gJP9aqVF30X0Q-BZ9Lg2h-X0ta1G79b9vJfd1IAsGrfpNzD9BOhBCw>
X-ME-Proxy-Cause: dmFkZTECbNYxFIxkaYjpW0VfO9rO74u1iVYKW7QI9vEsr6193uQIfhV8zJoxlMd7AyJnq7
    CwDM3zxesbiu8cH5guNMerUINtvvzycLx3Pko+s0p+9VYLTdIqwFK9Phn+cNbLKSu5dmtr
    gq+4F4z1hSfTOhV6nck4AWWRnhOZvWARdEpI7QcLEtSeHDWRzCh93ai6IS5DJDUaDPKH4j
    lM5H7A3oB4gLdXWYObVXB16Gt5WBFH/62vsJjIchgVWpkex0qRHNhY/I+E43674KTdaDua
    D9kUkYrPN/glDkW/gYGWBrjHOd/70puWFfFoxgFrovyt3UgZMWQKekQBualSHkdFpYNaEe
    YFMLkNBm1ZLZPaw+pjbHtNiT2iD0PVM1EvbLKAmhSmYTrfkY19py4wp8X8Bs9EeMczD2RM
    aaKqOwf+0Ae6KsA2uCs6c9h5hqHK3yD3tPM3rMvPwIpBC0A+RoHz0nlJgoT+m0TZX9IGPL
    venyqIA3nepTFDwJRatGVSnRgxPMOFIzbCwGFFHA0XfY2dtXal0AZZxtLi8b2+dX8o8X8y
    RlBvhvtse4lYGsS39zcLptV3eXpK8ASo3n4PHTdzOuulEDrL/FexDcieeB14+tbf/ayCGJ
    OjPjP7r2EVcv7JaHkVdsCmLtMDBELba//DbI33JsAW1xAHcetxq9H4sGgMGQ
X-ME-Proxy: <xmx:gJP9aoEPYCg4H5_uUu4zNnjDBa0Bu1Z6TUUHtP4xGoqqk0Gxf-nU2A>
    <xmx:gJP9auc81tycNrhdi_u1ITBymg6e7OYG01VZV0r6jCpRWbekIT7evw>
    <xmx:gJP9ahLS3_xiJAoFwrY7sfW4QVYeeqs_Z0X3jXgYEIBgNsVid7AhXg>
    <xmx:gJP9arHl2VzxM6hbk_awVd5MXsjEKAOuG4qAvPR7o2KtvlOuF4nLLw>
    <xmx:gJP9ahp99P2BjKR7ciE6fFKbi_pGF8iKZCi4CauVNLrPv1sBKXreAfa6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:01:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3a0dd74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:01:03 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:00:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v3 3/5] http: add http.retryStatusCodes config option
Message-ID: <av2TehodwlsK6BnO@pks.im>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v3.git.1794022836.gitgitgadget@gmail.com>
 <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1794022836.git.gitgitgadget@gmail.com>
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
In-Reply-To: <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1794022836.git.gitgitgadget@gmail.com>

On Sat, Nov 07, 2026 at 03:40:34AM +0000, Ravi Mistry via GitGitGadget wrote:
> From: Ravi Mistry <rmistry@google.com>
> 
> Commit 640657ffd0 (http: add support for HTTP 429 rate limit retries,
> 2026-03-17) hardcoded HTTP 429 as the only status code eligible for
> retry. In practice, reverse proxies, load balancers, and Git hosting
> backends also return transient 5xx responses such as 502 Bad Gateway,
> 503 Service Unavailable (which RFC 9110 section 10.2.3 defines to
> support Retry-After), and 504 Gateway Timeout during load shedding or
> upstream connection resets.
> 
> Because 5xx responses are not universally transient across all
> environments, keep 429 as the default and introduce a new
> http.retryStatusCodes configuration option (and corresponding
> GIT_HTTP_RETRY_STATUS_CODES environment variable) accepting a comma- or
> whitespace-separated list of HTTP status codes in the 400..599 range
> (for example, "429,502,503,504").

Hmm, okay. It feels a bit like we're capitulating and push the issue
onto the user instead of fixing the inconsistencies on the server side.
I'm not really much of a fan of that, as now every single user will have
to potentially reconfigure their Git client so that it knows to speak
with whatever server they want to.

I'd really much rather prefer servers to get their act together and fix
this properly. Because what I think would be a bad outcome here is that
the fragmentation continues and that providers tell their users that
they are holding it wrong, and that they need to just configure their
Git client properly.

Maybe the fact that Git now handles retries is a motivation for
providers to fix their infrastructure and instead align on one specific
error code here. So instead of making this configurable, can we instead
nudge the ecosystem in the right direction and make providers fix their
infra, so that it just works and users don't have to configure anything?

Patrick
