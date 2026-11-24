Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557846;
	b=f2bw0faPJKMEu18rZtc5onOl6A5E9RSA9N0nYcyyPsGJhXVrCsGnZjj+K2z7qliV+qVT
	 4RcwwBuKxThIfDlTJnTdsDuhxOD6gfhycaRjnXZ7YSHpFWrBhnheJQjHw2ovvLiCcKFSw
	 zmUgxodVm54fivDw1W/fnrOjVLFNbdAXmdXiD7cp7yqM/gs5x1EOGJcPQAYC948xfLAnY
	 EaLTKudGScwgRY5TYVdvFYMS+DNQibWFixEhCOpFclrQI4eJbTD6T/3t2NFI9g42UcpW6
	 MeWluVzq6j2ymjCvpoF/IpuOyvoKBp7g8eiTUUqvCTtLQalU3acfQnbbpc3Xj2j5CCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1SvZGikDustzm3IOWmoIgEMPTqa+OBTEcwEpTCcbawM=;
	b=R0b0Xvcdo+GpBlJyT3b4eoZTaYvhJ1g8X+BIbicjUQuW54Vcj63DUZ6v+X/dDDbd/605
	 c2d2pLWyt4/ZyJCiWQjlP+wntgOGRQfME4vOB4MQI6RvekTkp7yijbwlv8isunAoSdBfh
	 /0XuFdYPbBvLAytBMB2hu1E4/3Q2cfpNXRwhoDCwRF5qE2yG4BFC5ZcYQkmQj6NnAHDCv
	 v7dDtprrZx3sihvlvL0P1UZmWkwo9IXjz/h+oCMfYWNTlyIfn8dnTPBUnRbUSr8xfatGb
	 4e0hbEnT4LRRVlOPo71wC1dNaeLkU1PoHic5qFavspXHWxrbjgiCg97XkarCJYejL6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZpNG8J4O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cQ90xFNg;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7D606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 22:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F7D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZpNG8J4O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cQ90xFNg
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E266EEC097E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:04:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 17:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795557844; x=1795644244; bh=1SvZGikDus
	tzm3IOWmoIgEMPTqa+OBTEcwEpTCcbawM=; b=ZpNG8J4O28BiPeovzo7Lnp8zMn
	JjPAxPg3BhRZl02l0WEAPXYzm9wwO+RTnhT7Xrr2Gl7FfnZoVbBShVd874b4VSBK
	JslreGH5mBhGKU0gadFiCKeptcVYetDBIjsc7onYe39JrxloL/0Rs+kLVyf+dTJC
	Ba+d0b+GVJYEXMWCQBcuskENIDHrO50IO8+4mpEnBbpPkF/uhZZfbCJreD8ZTFmz
	0gWjCvncopTKducmXDCsVtEYFIycFKi+XvRxaLUAnOaXXuwYL3+MxuZAoco+YV+6
	MvMPnUiqzao6O054A2+ArjJAeuv156+D6wZu+69g5GDKKY1Pbnyk8AGiMbcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795557844; x=1795644244; bh=1SvZGikDustzm3IOWmoIgEMPTqa+OBTEcwE
	pTCcbawM=; b=cQ90xFNgmypCRKOIPvd1ntm1ssH74q40HwvmX2FXNOnIf5mjS+o
	Ao+sop1ISh5O1U+HjJWAXQS1SygJdXX0ZQCfrv7kNlQSvr4ZqErdYOwesKHRpyfp
	YiHlSovsP+a6wfaoO2IoCEPv6lIeZ2qhlIoHO6uXcgIUttEjQzznZVg0UzkD9O/L
	EUQJvTFYE46ECx1rA7r+Q018hDHVGPMfSSTCfjV4Isb8FQXzxuMInNNu4qMVsITs
	9exPtw6bngKl8j6UkjquVvqzKOX+bpIAlP2paDea30qgI0c7L8PVvERD8osFqHR6
	2PHLQtS0IYItJDlUnc/X0RJAjJ7jAHKi0pA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795557844; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Z4HpA5wSuSr7R244HPE6HyNZktPUll9IQ69utBVUvw9nRmM
	E6Out92mmCjT2f/gIWiQXcCFD0aKTAgy+uHws670BZUFNi9wGMHSiiwV9CxjGLWf
	77f5bQxXfhdf7ep0YBGVS1AnFdas6WP9+VgvmzfDbuSWwx1HSr/SfSPxukQHP2QC
	TLqF/FXFtCus5DnvBX051AjHzLTIIXo4RX0ze+LfgIyq1LwnAhq9sP6l7KM0DuSN
	fIjzMzMyAHPWkv2NmZwH4aifiWQBI6tXaUAIEqzJE0qG5fk87hICieo+DEMqOkkW
	YMkX5jtIq6rZ1jkNBZTrhZCLD54V1s+y33YJX+A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:K527JlC82xxKEXrPVbHHg18erV4wBGXCEHZIsos5qK0=:iTiL9SQERH8G9qhQFFCrUNmBKc24iB7vEPPY3AbrO/Y=;
X-ME-Sender: <xms:1AkGa0o3zBwkdGg2X3ZGVhp-cGZ1wQd48v9RlJw1kAN8FQwPLmcncQ>
    <xme:1AkGayH-qZLDOp5f9WkWrPdxxFc2OjjYis125Lo_ddqtbYIm3lioSHK2Mcjwx9XjD
    BwTAoPL4b2iMbTfv3yATJcb0GCUbHmHEYH0N_vH0QtNhMHqWgvrVg>
X-ME-Received: <xmr:1AkGa2ninEVcpr3LeBIAKwyUznQPqkoEM06yxTZogonxc6iLA1ukoLVVKJ23GVFOXWR9nnPbDNOCFOw6LodoySgi0dMpRQ9-kiba7rk>
X-ME-Proxy-Cause: dmFkZTEOBEVs4R8T36UFVna1dlMCv464YPNbweHSSW3LqmGsBR+kC3fFhYA0of031HipyX
    9DtYFBzpEYh69Hn7i4dQzhXiLcSv95lGeoFDYy9VLpc8N3gSg5/Fz5zs3Sjy9C2U+O2KxM
    MuFgEkemKkrY11KrLPYNo0zvL1vBg92ek2Ff7+GDEIdfgAx+eu1ZuhliFKIHoEZ459lpmf
    p7q1l2u/smpuOBYz5NdTkK1EKnbEBWG9PxmxZ9kNZUACVNWoOEw2stumFkouFOnQRQ+6DY
    8/OPLjRI3l1K79hIJvbr3vuoyFBPdBDYqvk7LqFgz9tOQUZc8HE11xengzhBcQRbQv28Cg
    O5fhJNz8r90wXq9Ec614yfrWwTuj31QKWVx+srUTMGjnLPNmDU60zgcn17lSg56OK0Yv/d
    eiSG52AhbURkr9O0UfWXIxukHek2UV5Qw++E2ih8rRni+35Rf3MdTM/22jeTK6xIhVEJM7
    i5yIBxG5RXVAXbjNkw6/xxu8Xsda17c4DVsSDZZT2k7K3VlNF7WgmwsyJhmUz1mCnP9pXS
    ZRKLmnpzj43YINyuPNXDq70/o3zLmyFP9n66NoBD/9GgU86yjBB+ViHZy0oM439OIL0UEK
    3LsTvKzSMD6PJbi6/7h/ya61t39SS7J/q+FwF5U+fUxfsMhN5iP4N9PBvu5A
X-ME-Proxy: <xmx:1AkGa1lAzUZAPiwMfYqWKJPODKhiciXIJo6-cPYgQCsISy_Do_nmHw>
    <xmx:1AkGa3vXoXdo-b60inqq1xuf-hnsmuPRqTyYNypaibcU90F_fVUs5Q>
    <xmx:1AkGa4nCdrEiiNR86i5BKXqJSK5GEBjy-hATP6eAtQLuRRkOLAS7AQ>
    <xmx:1AkGayv0dtSDN4HKy5c-LHajIXNHlinGQvQD2mgOZTSSRi7xosrMCg>
    <xmx:1AkGa6MQTCIJUYJt2S-Y3_j_YR3tUeZq_YmfsL1MvnN01d1Ff2Qr7tHl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 17:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] packfile: inline `open_packed_git_1()`
In-Reply-To: <20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Nov 2026 13:02:30 +0100")
References: <20261120-pks-packfile-global-statistics-v1-0-19beb83b145f@pks.im>
	<20261120-pks-packfile-global-statistics-v1-3-19beb83b145f@pks.im>
Date: Tue, 24 Nov 2026 14:04:02 -0800
Message-ID: <xmqqwlq1lwdp.fsf@gitster.g>
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

> The function `open_packed_git()` is responsible for opening a packfile.
> The majority of work is not performed by it though, but instead by its
> `_1()` sibling. But this sibling really only exists because we thought
> it too hard to handle errors properly and close the packfile's file
> descriptor on an error path. So `_1()` doesn't handle those, and instead
> defers to its only caller to close the file descriptor in the error path
> again.
>
> Fix this design smell by introducing a common exit path that knows to
> close the file descriptor on error. This allows us to inline the call to
> `open_packed_git_1()`.

I agree that this makes the descriptor ownership much easier to follow.
It is not just the call but the entire function got inlined, but I
shouldn't split hairs ;-)

> @@ -510,55 +509,81 @@ static int open_packed_git_1(struct packed_git *p)
>  		; /* nothing */
>  
>  	p->pack_fd = git_open(p->pack_name);
> -	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
> -		return -1;
> +	if (p->pack_fd < 0 || fstat(p->pack_fd, &st)) {
> +		ret = -1;
> +		goto out;
> +	}
>  	pack_open_fds++;

There may be a mismatch in pack_open_fds accounting.  If git_open()
succeeds (so p->pack_fd >= 0) and fstat() fails, we jump to 'out:'
before incrementing pack_open_fds.

> +out:
> +	if (ret < 0)
> +		packfile_close_fd(p);
> +	return ret;
>  }

close_pack_fd() (now called packfile_close_fd()) closes p->pack_fd
whenever p->pack_fd >= 0 and decrements pack_open_fds, which may
underflow to UINT_MAX if the ftat() failed because of this?

May not be a new bug (we used to leave the p->pack_fd open without
nobody closing instead, so we may not have underflown but leaked file
descriptor instead), but since you are touching around the area, we may
want to fix it as well.

Other than that, looking good.

Thanks.
