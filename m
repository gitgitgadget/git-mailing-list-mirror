Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328830;
	b=F6HJW2YC8qqcTIIjSFunBWRnjttcKn5YGeNi6WCy+S2zt5HkS6RWVl4CPVuoO6yRkH7E
	 KAsDkFwlQW+yZZg/XmzKjqyOfx/mBC1MId8Q3PMO6aQbaaET1W6JUBtj6v2zH/NUOrwD4
	 INrR9m/A8bg2UlOIG6ed6toU9UkBgUX2L16P5opTczyKVsWzQ1ZyMp/9eV9LO5qgYD1T3
	 ww+ayzJQc59lL8dFUk1CTuJpuakjfOZFBO6/gj0yzGusIbP7PIIWSJKsjajW1Uy7tk2+q
	 JNy7IJ0ABDdy7DYeyKOEo+j0eFdKu6NU2971rdM7cfVXC5eb8VlrfWb+PGnuCcZhX/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328830;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lwo55wOsxebqn9urEQ+u/pukdyGRAlbbDeIZFs4dXUo=;
	b=FBsnIKLZ93tnJmiT0OphXWNVPPyfmOMNYRRA9otOrrOFuYUYlEYCw4/IR8pmpvUntx2L
	 FD4V5KuooseYj1K7V66FOQYO/lxtT+KA5HCJwhnamRx56YvKr/d/sU8QLincAulVeJLhA
	 g4epSZncOPhx9CCMG3YAuZ7kFeZCCFyrvcCKbDE9b+4jHZ8f1RU1/ZQPgeKhwYkuUv28P
	 I1sa9DRSP4k146qwRgn/ATq0kL5BJ9+jgAGFEkQhg0sCTP9Yv/H1sxrCrtJCN8wxtwpYI
	 1H0903DkVDf4VfQPNoCNGCIAaMmbSveXtWVb7SpYCLhNQtEcsxxuSR20CWO5WnsOziQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vt9GK3uL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mwAmT3UJ;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719F2606A221
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 719F2606A221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=vt9GK3uL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mwAmT3UJ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FB0EEC05D3
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:40:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Nov 2026 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794328828; x=1794415228; bh=lwo55wOsxe
	bqn9urEQ+u/pukdyGRAlbbDeIZFs4dXUo=; b=vt9GK3uLO4GedP/ZZXWRevTyON
	3sdyhVTs1weTBt/q+FYfSQ49jhSEJ4nS1lN+ga4pIDb9QZPh9/qmE4yIRr5nSKAC
	yE42kojtxX4vxt5hrjXw7D/06LcLF6gA/LSjbhZ6JNcB7T6GooaVht9i1q87y0dH
	RHnfaZl9F0npt5vguwmuEjVbPdZpmJ90ew6VsXNarNHyEIXAcw7OK//qqk/LgxZ9
	zzGz1DtLH0MIVxvp0A0e7UMsVkcF/zAOisGSi9LzqEpKCZ1MHOHXPpUnPEzFCx5X
	zB1qjGNt5Ks80Hrhzn6AedtFmVhgZcWNs/VRrOkC8wfZReUgyHY7U53CEfJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794328828; x=1794415228; bh=lwo55wOsxebqn9urEQ+u/pukdyGRAlbbDeI
	ZFs4dXUo=; b=mwAmT3UJQqnDsMTnf9GNGCqAk5k+H42ggiZ5SDNnXqeAgng8jrH
	/cv6Day5AfiK53c+yaTQ79dxvegrdG8jIdl8+7aNWxLjg7Ht/0GAyMITOz8JTmnd
	5jDjku8zG9ecB1QGvRu1UpbdWSUqQEJbZDNUz+k5UdIKdUh4tNVzX+hL+z8zkH7Y
	Y8JAavri5SoKyBKWHD3xgr0JW0A5lB35k7t2EJXIZCPro8MupdfIGIgZa3YSh8hQ
	rnWRum0lkR460BjNWkNObuZQqKYmq3sqVFoZy564nH5gS9gI57byHV6q70N9Akti
	7NLvuDmfCxRg5czqM+T3COUIU23KFmqJeqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794328828; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:TqfcpWdvalJMEz7I5wlKrYlcd713R6DtW6XRUGzR7ulxH3g
	gFO6CPd4GNd/46ZF/WduYRF4VNYyfY8VfuOOiKJap3g5u1uZ7lb62fTsetzFM5Wm
	GlZeGKPbxjXOk533v5oqW3C5CqJ1DyUjUzrQYTRngVrIPShE93kJ9XY1I0QZazIj
	q2k8bARMYWQN1KBuOoxm6JAoS9Mfz40xPVnWuQS6QapxVot0nZundgoJr5oY6KMx
	B7D/tKNxEJXEbr7i6ek0AjT5p72s2eU1WDRNGmEWp7QbDTpBS3aDZzDbdih7oUQ8
	/oAvBYPFRMGdCPoPSG3zRf8LKUnn5zUCRZPLH1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:FNh0w2rsc5QRfA5+oWvfTn4R0HXus+t/T5MhbGAFik0=:bsdYZecqZobgWgBFeBpcIiwOQZlIUK+/GwhNfFm6kpY=;
X-ME-Sender: <xms:_EjzankaG_IKyoG_FbdPmgSta7w5RFQV19dGNOE6Y64fV7OzqfV-Kw>
    <xme:_Ejzag2bcp2Ay9p47JUVZajRu9R6e28xanQK0oSaeaZrdT3yPF_5KAaTBtADW_Fph
    zvp42lX5JQjwIP1g7kR_4U-PfkPssMJKVDc0BHTPQLpLd19_gh6UtM>
X-ME-Received: <xmr:_EjzarSoXmtnwl7E5_3xr9FxpkS1T-viNaWOrpaVsPpUsN6WGStjrrEtDyvII__Ncl5N6w>
X-ME-Proxy-Cause: dmFkZTGvZ4AU/YwXiaVcdL9jqhdmS/r6hUt9TJItOyv6MsSh4Mqm19cXKfozx4I+u5o35A
    MzH1DHrNhd4Nv9lPo7NzhwemTXLBbObVlqh6SA+i5l4rE0MyG2G7jKvfXg2MYh7ZtYk5vy
    Pc/HUvkqLI3DPar6nb9M+lT+/URHD+cl1JNBF9seB2IAhuqIeoe1AUdXlOrE9VGv2tQvJ6
    zB9WtUkRXXxABz0iBRsk85/ohsWaxMyDUNoLD3/f3FrKoAPp5MwG6ezZ2sUP1Zjop7F3Mt
    qpbEB74m6Py7C9zzVjZkDXA948iURSS+FkuRuVTLOVkHWl62woAoAuDEIYsM32p5yI22gh
    oEuZ5lkQF3M8hh2RSRREWUFaFKYk2Lmo+J8iaWhCDrkhk8YO8lgZqXOKAhoQnsk5AKNQBY
    WYjNwn5eJm2Fop6pGla23ZAONjORvWGJgTqYCYrrB0BsCrg2o0AbNIgidBKxzshsEGvKz8
    znxfd74jXScRFmwOgxVXj5x1If5n8XxEgXa3MIqWAaRjwRlP/Z3BhQt4FYyljuhtsu6QF7
    oZNmT+uzbN2jRoi21nt2who+S0df0j/kbkBL3943xa9ZLIhy3jO6bzVSxzeB5j3UlvlB31
    kbCHIHjQI0Z3NSeYnJwH40fwPuC6JeBe5ppOhdQAMOQutZJnUzT0n9YnJpbA
X-ME-Proxy: <xmx:_EjzaqvVqYh9LE-kAUjFnfWZyfppdSNIFcfmm_IqRijxVzUmqyuC5A>
    <xmx:_EjzaoYZsvPRN4HhH99eVrcw6dudpUtnNyo8OcnQqxJuEOp4wMn9Ow>
    <xmx:_Ejzanst4x73sJgvErJuYcm8lglTKhMcFjRnUon6c4ClumiKC-xHxg>
    <xmx:_EjzaiGSj7RtOSwbcweAR-9gsh8O5ceoLZhyspXxvVb1SSOyEx--eA>
    <xmx:_Ejzai_ZE8DgOBpA2ngbMYBBjpbhIKUtc43AAQ7vUJT1F5M0LwxukPuf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 11:40:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30b20d04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:40:25 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:40:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
Message-ID: <avNI9rHN3GS7Kmlz@pks.im>
References: <xmqqtsltbfdv.fsf@gitster.g>
 <avHNf-aaxdsyim7g@pks.im>
 <xmqqecctzttt.fsf@gitster.g>
 <avLCDTHuScp4iLyj@pks.im>
 <xmqqse18u0jw.fsf@gitster.g>
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
In-Reply-To: <xmqqse18u0jw.fsf@gitster.g>

On Tue, Nov 10, 2026 at 08:13:39AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > All I'm pointing out is that there are cases where we could be as
> > defensive as everywhere else if we started passing down the options to
> > calling contexts that don't have it yet.
> 
> OK, that does make sense, but I suspect the current helper functions
> that do not get unpack_opt do not because they do not have a reason
> to access anything in it.  We could throw "struct repository *" into
> that struct and use that one (ignoring the one in the istates).
> 
> I however think that would be a separate clean-up.

Yup, that's reasonable. Thanks!

Patrick
