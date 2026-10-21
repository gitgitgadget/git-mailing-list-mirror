Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571102;
	b=bgpmGQ9lU9g+M6dUgDsfQ7XWUMTiwsj4J7hUh3l+iEMn8z7N/1qBGUEuqALvpHYNHyXD
	 wGRLLqqAiGvvam1cNXgDrAm8hLu2U6vq7PHjo0hYJ/jc2y8yJV3Epm6lIULoK6dB5Ryz0
	 RTSPCVrkgxZ2QsJ94lVJxkOMsDL4cwMTYqFdiOaAa80RJjgCj5/socnZ3gi6mvfO4H0Sc
	 Cl63H4pqeiGdwfSHE0bLpqE7x7lhvbKNUhFPdkjJPV2ei0VVJMKzvhwaj9vJ5gqbtrYL2
	 B3zZhQ4TK47LEdGfNYXK4m919v/Imtt9E3N7iG+cJW0OZ7B8Wv+niT1WICt73hY0PLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571102;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PT5k87VZM3qWQubdUJxHc9YfSbZAAWroMUvDGeNqhKI=;
	b=OJlsuyPjbegBUB0P9VtifY2Ue+PvwiT49eqWU63JH9hWtXiyvGPtv4invklcAQv5sMx2
	 w2plP8Fi/sa/qfwXhGMjo/559qE8gQnAQRpkAMP/R6Zcb6mgN2R8unagr+BuEmZubSFCR
	 0fGjfLHpbzJTlUqzhIJZOHuWOLEfuXxDjQZpOWd/YnUS/g6L1wXy/0vWub+XZvfj69Np/
	 Owe4QD/Fo8D7W13yB76COYDgv2chBhT+anbKN+PLfDh7wB1hlGF8CH/3lpYZLHIlLbYvf
	 KCalJmmxk6sSvBNSvKe6RqIWhE9L+RMTkJQvGzdE1YL2Ge//CkfWU2giqGs0h/sZMxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=d3ebaHMq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kFdMLIkG;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80213606A325
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80213606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=d3ebaHMq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kFdMLIkG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A02977A0101
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:25:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 04:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792571100; x=1792657500; bh=PT5k87VZM3
	qWQubdUJxHc9YfSbZAAWroMUvDGeNqhKI=; b=d3ebaHMqlKVjWB4H1gsMbOzXv5
	xoSuv7ruUF07DXzcsayPvaQ5BeVY5rcZcFIpN8GAq+glBMuNrBfh7bMbb0yabi9d
	gX86FXAzx4E1oO3F9MzJsxAV92rocS/hzYvsXSGhuETvv8C1bDouqsbTQzu1OdMs
	snYwYK7HmYooGWm6nmTea5Syopk4K94PWt+HA37hn0ZTIEfhdDy3PLq3KFke5eZz
	BpsUfHHn6qbWkiMTDuTzLB8UYlmNEzMa9sN95Hy+Wl2/Q/rIQWNr3KUxxfHU9ZCZ
	jlYycPjiIGsC3fqrdCpwAKWaV1+5gC3LACptsbLT5qbD/bJs4HZNVDlxjUHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792571100; x=1792657500; bh=PT5k87VZM3qWQubdUJxHc9YfSbZAAWroMUv
	DGeNqhKI=; b=kFdMLIkGq5QUGScQP9cF4e63yGd2YhCfSgO2aHBlAJ/1qFnt0Qv
	vAaBKjoTGcdK4DBMqf3jlwo9/7zRkzy9SSbF9zbrieO0I3x3sq4vm5b2Bm98YVvr
	lXQPZcF/brjFRlaCbq1hKRrkgv16q23jJHaMV0pxpvB8FSgQEvLR3pKCPCDic+/j
	d0JWXPGVA3I0czWjcDEITF8eNEA1YZ4QUYFkl+SgR4v3GUGpCyQllrsVOu8iF690
	9541IBHA9xCPb1svTeSwDDFEbIDe53/+XIx9CQLCH1PfXmp6sOi4wjg6NXMRhWEr
	cQIChBgjBcx9jXLShtY8CsQ5c60ogkmCiTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792571100; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vadvUey0FYIS1ABVkoWJEo9EnUIOfc6Z8RzJTs1ilKLUtP9
	ydlX2q9NTOY3uoIICdh+9AylBgcrsaUL6bBfjYx181tBH8Qzr561++aAsHa7WjY3
	nd4eRguwqkd29wpgkSOIKLf6VyOaVJaA8ztfNyfI5uZZgtoGPUoNIynhiOLu0osm
	SrNLY7MHQXnNK3OYMBdKtFC3n6vvkNl8L5ZO3bmoAZxOZNbOYFqYEpxft4tHZog4
	b7Vah99d3tLzZvg9r9kYUaKnPepNWdSEJaC6o2i6RqwsXW/N+tJUCZcinYBFz9Bi
	bpRKTur1HAVPmM8b+RVNUCZZ5YyVFMnPPuPfJFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JYGhUCrtAIJD/kZqPyBlxCPKYu/GaCj532/4oaAs8QY=:Ni1z4amzS10KN6XQhKhRrXFdJlpmSVM5hpevQdvqHSk=;
X-ME-Sender: <xms:3HbYasqXXiFdU3TNZw3giVkf-TCb7ksyXFX4VniInSztYkwWJ2X2vw>
    <xme:3HbYaqEUsP1krsjL4OLTJWxA-OOE5vD9eZ6dgidxklIqfirDWAR97wB1Feqyf2QAR
    hiOJDh4ryQTgH4yk4MYQZ8C4gQodiFmmjVqz9JE_e8zgW9I4eOBoQ>
X-ME-Received: <xmr:3HbYaul2aw0dMCEq0pwxGjL0VplsP5iRvP1O5ooWSc8Txod1WqB-VA>
X-ME-Proxy-Cause: dmFkZTFGK+BmQVMyww2oT3g1c8x3w58A2sfpOD9BgiqaYkdPlIfFQQvvCX6H/aKWgNwe1a
    2G7YBhKH8W4h67bdgULip6+GJPbaK1vGJ0uDt4eIi7O77UsQMXj5VoYXqE2PrAzkIoe5cU
    3KwWrVtoj18lmB3CUgNVa3b8h34GUT/OaW7MXVq37deak8x8TwoRRmEuIRdpxNIvmwAvsS
    reL1NZoXUonjAFkwHMjtWy9nFycXVZtm31p4ucssuIceq6XXItDXLbyh4wTLNLAN/By1ml
    +MmRdft+hXKGtYpx/e0XbbJQmmD4BFoPBdCSP/BVC9VY8afbBMvwcKsSZ6CVByLHtdDHHV
    EUkQK/AqzaH0BAX33zZ63yPaLUN/SGoO0zj+uomVs9jxBj0EEhv4V48dgjHiIq10GjikCQ
    sl/WL0El+f8vIn6ylPoM5vcxePVlOSArPQQmBFHlOK4bo8fLJdl8O14T1ceClVX+tZW0Fa
    Sg9ZsTP3lW/DZRHK6DCanaH44Z5lSs7zqDl4ZuEHevZBqfmBMwIcKoR3ampKoW5Zc47QoK
    usVqDQDv7fDlLek+5P8MQ+mhxKT1xm379qOfRMoN2TnbFgeJuE+WMoxD4AioRnMnR2mKbz
    NcyTsbK5KEcYaglyVjHwun4zD6wOVmNx54V0/5Sq5YIoI0XcGo98T4k+nlvw
X-ME-Proxy: <xmx:3HbYatl6LdkUgNLpI8tSMwDcpZcNCx0sEhJ4CHruM8HQ0ON8G0ATwA>
    <xmx:3HbYavu_KS198szfb4fm9S5z1m2kQPnFKbwqm4IJ7kGRDLlaIpPmUg>
    <xmx:3HbYagnBN22YYypZ9k31sOCkPAni1KSwh2EY_-R9TWIqgWTuYwsrOw>
    <xmx:3HbYaqtQSsiUZreAFO-juuB5pBCwyhKOQEvokAB0zxGiGRFE2D0dhg>
    <xmx:3HbYaviOYHxPlzVTN7tk1gV4tSbUuLT5Q3w_EaujuW6g_P-5F1Lt3Wfo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:24:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a3c2f86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 08:24:58 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:24:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/2] imap-send: avoid leaking the tunnel command
Message-ID: <ath21xI1yLScKpuh@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
 <b170b1f6d33d42b9441585fa8877a9e24d8d37a9.1792566469.git.gitgitgadget@gmail.com>
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
In-Reply-To: <b170b1f6d33d42b9441585fa8877a9e24d8d37a9.1792566469.git.gitgitgadget@gmail.com>

On Wed, Oct 21, 2026 at 07:07:48AM +0000, Harald Nordgren via GitGitGadget wrote:
> diff --git a/imap-send.c b/imap-send.c
> index bf1d2cf74d..6f76bade35 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1176,6 +1176,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
>  
>  		imap->buf.sock.fd[0] = tunnel.out;
>  		imap->buf.sock.fd[1] = tunnel.in;
> +		child_process_clear(&tunnel);

This change plugs the memory leak, but the bigger question to me is why
we never call `finish_command()` on the child process at all. Is there a
reason for that?

Patrick
