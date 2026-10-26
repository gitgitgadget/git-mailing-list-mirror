Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014927;
	b=c6YgcSr1MFq7463FoXrsiSPGLY8GXPgnWuWJSS2/lN6jaTGkInMjxvHijVpJBGkXZzZw
	 aX1jz1SPlERTg0GqPexzrTBZXb4V7Dg0kdQuAoHRY+3RvuOzdFKDk6M/e4ZO7Tarh1/SI
	 5qMNie+aPRU38A7y5wCP4rRSrO6SjWWQip0CCHJ/HsP9qnvyWkC0Vgp0pz7MLZcFFIwcr
	 oGdkBa5iotSN7pEsEVMJngDyO/mP4mvtOYFku0w0RCRq3al/9Mc2qUKxUIslD+791REVD
	 It7N3cUJbT6811LmAjE5vLFR6Xd8P1JN4jUmMsdlIoXV9wend2STKJU0btxZ+Y9vQXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014927;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tntLa7sTO45kE73cdkg2rCjVEVeuQhzHa5cOAA2HuSU=;
	b=lIxNGLwdDp5eQL7i44X6gv1SWnyShab87d/FWQywbYj+dE6Ti9Wi9uB10aIuHmMExNiS
	 P8b3qAPia6VK9p86r7rzpQINwuURlsgpOTkanfv6jPjrDY7UfjwniEzMuqiJETqIlp6Pz
	 bpSbGMJFbOW2/EmXvJ+pksJ9dly6MQjcncpt5+soPQ348Cc4wYRFMC5Hi93lE95WpkWzZ
	 iVNHlhpQSvZtESMY51srX4VuI+TmUZa5ES+LaXAKZkcuLQw+KmHmwLHyre0orzKUd26Ix
	 nEWZw22cw9qZx/I06A6jXeg2w63A+ymNL8xkfyW+CqSmJvnDiDNok6Ee5MrRkcOoNjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AETIyniZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AnOiNx6+;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB5606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32EB5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AETIyniZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=AnOiNx6+
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B1D07A01A9
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:42:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 07:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793014926; x=1793101326; bh=tntLa7sTO4
	5kE73cdkg2rCjVEVeuQhzHa5cOAA2HuSU=; b=AETIyniZF9BfYuLOtKDPobHoLO
	O4BY/V9reyBRFRSwhYgnWYzPdNjPuL5mVkFO9/Wet/zz59QFxPmkcxZFIBxQz2gr
	D4v7a9z0c4oTy/0mbPtTJU8Ev67RvVGOhl1pVIi0Hck5ClTUyjfNUBZHNsfHnCKS
	EVaxxH7FnHYGxVuX4NrubL+Oo8hIbkuzI1CLcP+8WyvDX034hAKboOTf4Qt2wCi3
	yC9TMG9SLyn7c45gtqnnFl68QeQpSbON7Mx2ptl2vGTamcfWnukfPRa4F7gtqlZe
	iZeNx0IxcoI0huiXz3iNCIXNzuUCd4jstQnoepSh/FNp6EQbInp2O8SAp94Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793014926; x=1793101326; bh=tntLa7sTO45kE73cdkg2rCjVEVeuQhzHa5c
	OAA2HuSU=; b=AnOiNx6+bJ7fe/XHJnAX1nyZEwnsdiHtbMsGspZ0WbfKpJXzeUo
	yNvL4UxykOwZiLDB8b+UKGAJhi0QovWkuFK1wYjhZIM7Ht7/BuKQ8TDStDMghMR6
	zr1N0aFNyAeFl4mEb1ay1ceXnlM5Ua6uor61W9tulE1cpcnahxqobOoR19IermsH
	abG3PQOlmg62JSYiZrROMEpdrgW3svSuYM4ZsrABipg16MCWLbq/NuQRtxBD+uac
	DbS3bJMyqUaS6JllfJlWsDc+N3zLKfKMyES6n7itN+DD2PG79yooulCf345SlgsJ
	kjTSswHS5mmu49hrut0Twm6UXOegVEF5gvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793014926; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ilZkKvr7Z3akJL74KFZDvKXSx7SRrjphFwK9KKEUb2/pZ44
	iA5qPe6YjaP5U76nc1X+l4g/d7Bxp5zwcpNtyumweevEqxRI6qS6rp/PIlaVn6E5
	oA05zTqWbRpJ+5MGuF9QS0ihPhMWWBGjgF5MniooRL/3td2v2GpvrH6w4HBDYFmi
	r3xvAjckIJBI3RsKi7POXQJttn3GqCXMNWfhX9nAyEtzXyfl6q1j5ywmujbsEoyZ
	hTCvM6D/rPxYNe/+vYHvaHgInJ3IzhbOWC1KtRLbrXbUmRF4HoSK9eqCnZZSsqoA
	hxgRtUcoFDOh9RsP4OMMxYZHqrI47ALJ/ObkLmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:J0mT49/XabYFCDDvnT8AIO/8nC6+UO12X/W90pCa/9E=:d6h8mrwHFB5ymzZ85F4A95bvNi4hTTfMmwzYww+Eh4Q=;
X-ME-Sender: <xms:jTzfat0CIzHbT70gJa8gi3QZyKSrRNUBMIcMEZ1EFVwTmkfAHh24eg>
    <xme:jTzfarGGZQ0vak2tF21MzFJABNxyMARcy92o4DC5NoH2R16CvaygEN-ndZ1KIZw93
    gIVUgvXWALtnrIjnrind-T1GWtfYV6UIJX_4cRZM7LceypPx05KAw>
X-ME-Received: <xmr:jTzfai5tUwIS0GKqcs_iS28ESZW74sdkvhGQOzAutQLaMNOUsgnhTQ>
X-ME-Proxy-Cause: dmFkZTFUYTnEwqY/fiRr9OSbbToSv0xIEDyo9jDJjiSiBVX4KrBZ77Q5++boexAnGRovbR
    AJMIffHMnN0o39lsjgbE95tiyFYQVCZgacV2u+vDpFRVrqAQy/WD7NHUqSp//VHlE7LEeN
    +vmobniRm7TRjX5eI0GtHFWCGQacnT54J2bKKifx4U4YMNFIb6pBB6ieEEf3o0G/M9RK9J
    GTb5ZCNJAuFsE/tIJatf/OqHFexboVeQjHmhZkNyvgVutyifCTVRjE12uIJPfVs3PATRuO
    IWfirGg8YVfiCKxyv+S7L+gQbWesD4w87f4io0pmP3ovh2G4X1zbWUg92DWpAWyQhtzSM9
    u7M6wKcEOzeElIBC1EuOi4WlOlQm8DHBDXYJHt/SwULEP90JD/jkeiqg1wuTxwhJKPdc47
    bufBTGaYnkwtyNkxgif5qvzqw3B5cQyeTDHjHdkdwacqNW3FeCKBKadWRZjStNsof9GQYH
    83y6tcRdY+OisTBZTzYX6yqzR1NAbGuWmHnKmBgAo5+AyiIgyK9iGwksGcApV7d3xFKVrG
    +zkxIXHcq88tY5zw/Mrw/E7T/NrthEcEqA+6Om3L1yw1lf8lTlCme9lixpwrBDs5L4ZI6w
    4JT+EPqeN3p3RFZN+VSW3NxI84cPaN0qIBmRZvvJ+FuyzZHR15y26ir2hcLw
X-ME-Proxy: <xmx:jTzfapveJFXSDA-bzAzrXLve_qkSrR70IvyQb-cp5_glPJOZuPOBzA>
    <xmx:jTzfar4_165LUpFHWh7dwM2tfKGrJc7D6TO3DCkFTNh_czXz2L8ROA>
    <xmx:jTzfasUlqaqK9rPDNgj0Iz1226nZlkCF52nSxoPSHWHMNoOlleu7BA>
    <xmx:jTzfal8me9FGia72XiR58fGhGuTIkSe9SeSzwoevndfhvgT6dQndOg>
    <xmx:jjzfagqLG6l8iGQTDSH7_07qaFHC5h9ciZJ_1teGfMciv3smAiM6QpWI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:42:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08908d84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 11:42:04 +0000 (UTC)
Date: Mon, 26 Oct 2026 12:42:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: gitster@pobox.com, szeder.dev@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] log: speed up --follow following renames for
 non-linear history
Message-ID: <at88iclPaLSYfERm@pks.im>
References: <atW0ctTe-lNq08A-@collabora.com>
 <cover.1792701579.git.vmiklos@collabora.com>
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
In-Reply-To: <cover.1792701579.git.vmiklos@collabora.com>

On Thu, Oct 22, 2026 at 10:45:19PM +0200, Miklos Vajna wrote:
> Hi Junio,
> 
> On Mon, Oct 19, 2026 at 08:11:05AM +0200, Miklos Vajna <vmiklos@collabora.com> wrote:
> > This leads to a larger patch: should I extract the "rethink the
> > approach" and the new tests to separate patches or it doesn't matter?
> 
> Here is a series where I split the changes into 4 patches: add more
> tests, a refactor, then your suggestion to start over (with one more
> test) and finally the speedup.

Thanks for your work.

I cannot really provide much of value as I'm way out of my depth here,
but will try to do so anyway as the regression has now caused an
incident for GitLab.com. Hope to get this resolved sooner rather than
later so that I can ideally avoid backporting patches in favor of
getting this series landed.

Patrick
