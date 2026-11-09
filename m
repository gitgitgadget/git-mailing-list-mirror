Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216425;
	b=5oB4P+csQgwvXkHKR0LLpGeIBLuZk8AxbuWuUC3g7mTbnCdDl+fTQKeCJximEb8BM9Cu
	 +fcLs1nmvRhWkuFDkSDKkGcSs65Okq+zTbxutNm0gX5x3SlflEoOZc2cfSH4+4bUlbeo0
	 Z3DSC61Ql7+XQcgJQYVwpsb9etr6fVaTC2jo3DlwpyYuTmYNQqjH1spzOsUIRNcPlwFUO
	 gdYBgqN/4eyV6Y4l97u+RWh0xANxw8MRM+iwptfk/SKnXT0juICzmPMtDwpHKOD3c6rPc
	 54j6XVsd3wpqJvf47/Rzs6iK6rkuSxbhPnJRl15GjHX97qsXD06BZLUfQyg1wqia6Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216425;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kH1VOtloAamoWHZDzg6dmWJgrLPbfhZVNJK+ppIDfVA=;
	b=20+ClABFOA3hSO8QHRP69mjM0Z2FJbS+y6t5BOk41hl9C6XgFIvfICgUDIEV6p4Cz/U7
	 OB9rbN/qc6i/A5yry//h8WEfN8BEjO0f1LVQHWDqJtl6NLqnVZRIxyfacY6TM59a6N1AI
	 knBpLcDirqxm+drLTvHoBCAePnjGzdGDdY1Lkd7d6/FrlaTk4cAnS7gvYyqYeY+9w1sj1
	 KHpGbBuXNFZyT35o3JRj3HEQf7gfn7VwSNgd4y9oWgplFUoSs6wKk0jpTZ0Vz8fTIpgmk
	 zZDwpBXQSrafkpmwZ/nF1Pg6l8h8p+fVtsKsEA/wxYq/DC6vdo7XQj1S0ecdRjKZbIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JnN0BNkF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kNlgA3KR;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26925606A322
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26925606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=JnN0BNkF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kNlgA3KR
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68F207A0165
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:27:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 04:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794216423; x=1794302823; bh=kH1VOtloAa
	moWHZDzg6dmWJgrLPbfhZVNJK+ppIDfVA=; b=JnN0BNkFJdy8/vNLKcsXiylJ1s
	owGtLJP/mQ29CswHqeNCfZf8FBNsUPl70O3ScBfuIAJRm2JqmGh45JO96T6HBZxs
	xtyveyvF9EDBmOoriyHFE894LAka8NGlc+0Rqhrcjt9uMijLDzNxJGwk6l/6mFj7
	56RSDC7CfFJyzyQXWAfi+9ScUxDRLiGSl9iMIU1S201jdqlphlsR6WuYajh+aI6w
	JA0jsixkRzD7H4MHlJ0goy2iCafGkEEUiqZQ0x7v8QzQzexl4+JDnXbhiDeHJ88g
	caTFOGQiGNnvfbJFAfxLzm7ng0dT8TemLw6+wRPGwe4dcJkQNULh8BV7VSPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794216423; x=1794302823; bh=kH1VOtloAamoWHZDzg6dmWJgrLPbfhZVNJK
	+ppIDfVA=; b=kNlgA3KR4GfguGhXMS0PbmnMfpDknMbSPrKYo6GuMGiHLvB9jFJ
	K1hX9gtcCgHcDuX+9ZmZcV+pMhFkK4TVGRZOaJ8ozvZLG36DYd/ThDP29QquLPtF
	r27Qllwl/nKmGYuNpU/5tjjzsHK85aZ+p+jU8FQnpSr3TremEyVTjd+t3i3AO6O0
	VPso3V7U11M/EcAxJ67+7VWVDWctShjJEh7lfg44gYnuQbQuqC0UAKpMa21cb9J2
	Xsb1Yuklb0LfpmmHHQ0uSdBovhyH9hTsUVlpw3iInwOmB8MXiYC2e+2Oa1e3o2f2
	wN/iQSa7h1GYu03orl0d5iZMXSQhRflBCXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794216423; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Wz+CH9295R8PFB5tHAf2cT2+EIkrJXpwCLupuIKq4OywQx1
	tLVC0FZE9qbkoMWzWjbglEYiavRBEWqSp6D8xc02vs/F3kKhsWzIAuVqzmuELkyu
	EwrNdwDmG8B4QwjSomBs/ITh6s4ZMpmoLVh7YWQou+gG1EnmGae7/e3hnmaxLRaN
	m/8jciGlenWyEwz7AFxN6vjUKFC424C2nL70ydatNned+81lzjoq6AT32nRzv8LJ
	UirNBzh5iySQ7suZEWjee/YiqtZkS0laJ2B91RpomOHHTwY4fdZSIb6qJxRLjh8g
	OGOuOhiQgoTwCCO2EVAB7OCcOdYR+y3aEUmOliA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:lMDkIR5a6nII2IKgwVEZu1XZL40ayJ5PfVPcAHfcPUA=:PaEhYrVYcdv4GACsw/1UgFoZp9tPViYI5qle4bs9blI=;
X-ME-Sender: <xms:55HxajtcBaC3m79ZJhHEUGO1XelHOmrn9KpOpzfyekaSHBXCyAXR3A>
    <xme:55HxarcHuIYBCzK9-xZmQIduJwW-NtVyrREP-gTbCL_OtSYoFbp_MwDsFPFuPC3Fv
    EQuG7Lixi4eXK5UPU31kt-pi3LLmonVJAWd1eixYeJlD8coLPUS3w>
X-ME-Received: <xmr:55HxarzA5-_zWEkCqPp6vMHfxJf67_rD6jZZu9UM2Ax3Av7ivJKJscOIpFckctsnIyfIahg>
X-ME-Proxy-Cause: dmFkZTEgAVje76EMmQyBg9LEmif4x3TyNw1/X9k0poCIQwfK1mrKbmOOUaxQD/D5KxStpR
    5p/ZHbAmQ6kEm7ZUZ6tjUdZH6E9IqPPOGOnVi+HOJXdquFoXqXrhl6ifz6KYEAo44s75KL
    anlFnyVJEURHYOvSjQ5qKbIoFOC0xFJ2dWjziQlquOrcC0OTWFszzMYmU1YYYzmZtj23uC
    WHUx2yyvX37aWY6xpq276hl0A4j74ndD8HxwG0LfJVCf2tHO5u7YWiMrJkNlpKjli3r9xr
    f1lz4HdUXOArhuPYjwQxpqXW7KKKfXl3Pja6zEBlxMvV4kRI7XmIKwx6x66W3bVlIChiVw
    03FdjjK6XYcQIY0ZQodOeheQDzQy/5COvT5T4pO8/u5J+lBiVWpZbwGS1Z9uON4IgoHDik
    UTm42ioN5k6QZOotATjnP577Ku8AJZT+3NTGggxIGX77YOgylK6R5WEKEm7aFDahSLcupL
    gMy0q+tA8c/aO0GN5z/bSI1WpoKCRZEfTqcEU7ikYeHbectd5mtO0WT0Ta97EVckxD5Nbt
    +DwgK9cdpWRWa9yqGsPgjYlwOb8ftNOOWjSiy6D1XIW+8v+b+KrdvAuGCltZlqYdpwqIdi
    TFyQ8Jz4mi/nORvil270s6x7H7+NQAfDM3qDO9gXkg3YG6Jf1jPtrm+fyYLg
X-ME-Proxy: <xmx:55HxahEGRut5QK6qxS8pZ_B6VUPSxq0NkR0oUbHYzy1qP3qdKdlXlQ>
    <xmx:55HxavwQMRlzseqojHfMO2_n_tNrIDix5drji_lAoKqT1Spb8Fceag>
    <xmx:55HxaivxDE79jGkIDsnm6OxBHnfWF55UxzqacijxmQ0XrQPE4km5Dg>
    <xmx:55Hxas1kvgFR2kucGdsJ0dDXLcr8_sPh-bUlwkrH1xaq6pC7IDQnFA>
    <xmx:55HxavSpQCOfyRSPzEAJFzjNKHsmfl-HzkoEvCuCyscnlTuLh9kjkAw7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:27:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a8e482b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:27:02 +0000 (UTC)
Date: Mon, 9 Nov 2026 10:26:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] bundle-uri: do not die on unresolvable relative
 URIs
Message-ID: <avGR422rPHr1Orv5@pks.im>
References: <25a32212-4906-467b-9b1b-301b38ca0e2d@gmail.com>
 <20261106172533.612673-1-aniketgupta3001@gmail.com>
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
In-Reply-To: <20261106172533.612673-1-aniketgupta3001@gmail.com>

On Fri, Nov 06, 2026 at 05:25:33PM +0000, Aniket Gupta wrote:
> Hi Stolee,
> 
> Thanks for the review.
> 
> > I'm less convinced on this factor.

Huh, where does this quote come from? It's certainly not part of the
mail you reply to. Also, you stripped all necessary context for somebody
to know what this was even talking about.

> Fair point. I tried it with a password in the remote URL but the "failed
> to download bundle from URI" warning prints it as is. I think this patch
> will only cover this one message. The reason I did it is that git
> already hides the password when it shows a remote URL. For eg. in the
> "From" line of fetch. It is a separate patch so it is easy to drop if
> you and Patrick think it is not worth it.

I don't have a strong opinion on whether or not we should strip
credentials. It feels like the right thing to do, but I trust Stolee's
input here.

But the other part of patch 2 should definitely be retained in my
opinion, because printing an error with the URL after we have trimmed
"../" components off of it is just plain not useful. There is no way for
the user to tell how the URL is broken because we may have already
stripped the relevant components here.

Patrick
