Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331374;
	b=5jkp/5ZAXe+k+3hgvy2KhFGrY8Ax7v+NE+bwjUmy27/fB84c3kyHO0dc341IHM35sWpB
	 1bqEPGxmIhk2rE09LGCv0OSuX20QI66SH4Dl6IJnY6/7dLBbbU7Vmdi5Aus/msm5F9HJw
	 6XL8s8QDYIX9oINiX63pg8ZtFsl2xXkqMfv9N8SLPDbUuXYq2jJhHxIvN3hTpdrPfrDC5
	 0JdPY3SCZTL1ZLHxe8oi0+otstXqmVRV55pgbN5OOgoPIKNvyK52RYS7uIR8o//420uCL
	 66SMv/faMOnWkI+vyXPZNyDmh5naumtBVQxTtARNuUM/SXlm06v78MNiL3va5nxbCQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331374;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1+aal105ZpwxSEk8BRq9wHUl3gIXRgzc37RGkO6+eDk=;
	b=4JVJUr7+meLfYTpDb0oHQ1u8CZZUrzmADIj3KGDDplElrzjeCzSxEZrUjOPWow+W14DI
	 XqC1h8jB9cjZ/nKwD0cAPgJNPSMxNiZFki9txjFalcBkDbZ9H1cZoc4E7qSTDapJlDscs
	 W9AaCUBDDIYcRxAL6pkHmUcoLh6ex3sX+usOqod/v9XyXuM1xkaqdn64rJEVZBxkavf+W
	 cKssA1NrZz7Mb0FKJiTSQ3kq9Eiz4N+PODFgvb9/n87R0GeZOGb//UbuoeLzeSRi80e32
	 O/Bqr2wCOUvHw5FzRhKtpalm98bYZoQt4v0Z2oFOgQU+3gBdRZzB5tZE6cKAd6Pz6TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lJMqdIzR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wPvqMSC9;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB792606A325
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB792606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lJMqdIzR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wPvqMSC9
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D1BD7A0331
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:22:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 12:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794331372; x=1794417772; bh=1+aal105Zp
	wxSEk8BRq9wHUl3gIXRgzc37RGkO6+eDk=; b=lJMqdIzRdtkEhbgXNfgZ5a/A7/
	IairagqwBnMARY4CMzxvb8KVbPFILjUrVhd8etjhSV77XvVHNj3Nq4uBPGIUEhgw
	zlfbNKz2CfzZPbIHMTkwNv7QRFi9ljmD9f82Kpca8rXolcJY3Dww0TgqU1OoL4As
	qY46mF489gkKjpQw7SkLMA5JVWvpJavXbLhByd0B/SPqnja/YXhR+TDAHDk61K7L
	znAdhWON41BqQ7yBeaScgwSOLSKm1lZkvMHdveQeBenAtDjWaQOXnbPY9+IZcZh2
	+0rIjP4Pu/TSiMnstNDIAFmNyca53wxd0Ss9VDBWw22y9hYFAl/C8kSCURIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794331372; x=1794417772; bh=1+aal105ZpwxSEk8BRq9wHUl3gIXRgzc37R
	GkO6+eDk=; b=wPvqMSC9PFt39RNs1i4wHnwo6ZAkyEz7xHn5cNfMxn1b90n8JXo
	49od1dFL87dkMDDnTiip7CZ0e6znNVY19yRLSsSRc7oi2s2mo/UTN2myG3h1RR7A
	3BtjsobuvVGnLtGgGdgQ1fnpKHmGxJ+39/viF0Wz5pe/0dXLS61+KRPM86/zeP57
	0UxtTLhUMNpHi/4Q0M5svZ7gyPW5eTW9g2cnyetAPNys0aTFavJN0fjrIhN6eaYz
	nDk4FZ6tT2HBxWlDfHfU/srI0yMGuzRnCrYz9K+nNwQeFmg0nt/fUjn6Hpml8mec
	q3IV0pk2vXpkHGSjHqQktBZuCG+J4aFNpbA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794331372; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SNMmxN2jV7MXaWWxiQ7c6px3XJtTRzlF434Q8vDTkYAJcuY
	F21fA2EooTWo+eTJQVJ6ZaZA5VtMgdBx8aDD/ZEPTJIkwD1Gr0Az6IIuWHtulfk8
	O9O3OAkCVgHyPJ4OirM/d8CNTNnN2vbM11b0YfSg2ouAmEAShNycQDa3+L1qveGt
	U6uqjWqAzFp9Uc/I3gwJbza8VoD54kODkK1961xR6avsXU7movLWpZ8Kk0xViWmt
	s6DHN5HEP18iKy3/fEuHEk9aG3ZT+J0uWGcEZLAt8xrD4L+/UeAThYjo7JqSeYdO
	gSKjXBivyGd9YOjMXgFzSO3b/s9/CINlVDgzq1w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:c3ffcPGq2+f0ntUTVu8dis26sU71Ep+qBkPZQE7zj8I=:1+aal105ZpwxSEk8BRq9wHUl3gIXRgzc37RGkO6+eDk=;
X-ME-Sender: <xms:7FLzapCDkNu4x0xN9Kc03mg3aT2dfkUSbV5hNxgmObdCE_0Lqe_xlw>
    <xme:7FLzarOl7HJZ2XzX6XlfEdLm9fGyFmLLcL7Ay-eL0JVlDbet5Va0Dm-5qmk2QRvcx
    J04FxN7EFoI5vhcNfLAeu7vyW58cG87dLVMLnc23cEgP5VQvecpt7E>
X-ME-Received: <xmr:7FLzaua5aM9eULoX5z09rtCUfCdraB29sTBWROBcTycAoe9TEOgsNyITLhIblg0QhpBHIdl4NXwrV8IF9u7TS5TP0Xt0P0niaxgp>
X-ME-Proxy-Cause: dmFkZTF1QXR7g4c/jDnw5bLm0cJPAlt8JiQ9z96dCqrTbWxobWTgH6BOAyZpmePf4t9QK1
    NL0TY4WbR2YV+sDhM8tQBuoQh3gmAqNPFfYVwF4XMX7VROij52VRvxv7YhwQWHnJu3zjwi
    WEHuvF1orLjbZj9085t2ZwA4MtcbNDN7CTatYuFK5BltKy4yw/b+Ez931kFbSfzKb3Ahdv
    6d8XMzF9SYN6lRxxVmey87+uvds0TqCPu4v66xTnVJg9XY+N2DgKFXmKuNzRTf1nXa6Kyk
    Z+3pnk16CXNDk7RW85M45lMY4DCdCLfYRKlh2qbpDC+zfJOounsE6tfzr3QYKFUo/8oVXZ
    JUt6MfsdRzrwvOW7iR1XNwW205GhPwsUwdrK4H9oq779ipgKKp6RvPMJqSR4zlVBfy5+85
    bDQ8Xj7OHknurdTc1W27a61V69ZEQ7CfZuf0G8beJVLtOvCVhKsHIAE+gZYXRU9wmIjUYC
    DLGeRRFNBShNBYDtPTa1bKCdvWD3lryplZ5E/h3tdwT9XYsgz6rkZg025xfi08YV1LmfhR
    tkIYIk9ML+ejspEX7TEryAZYHcEHmkMQGXwYZ5t6s2H8iVP5WaWSkPhzjKOK/5QGOvu2h+
    Mwa/KZRKfzYKFMG6WyOXI556SZywjwFVejYQ1xAtaoRo8ENdKvoQxPsFnYlg
X-ME-Proxy: <xmx:7FLzaqs6kR5Q2odBoGbIe41qKqfM2LI2FKBXSNSDU47G1PDFrj5a-g>
    <xmx:7FLzagNspUQR6eyiogNFPVeyOgB2lNjengNBMjOuO0O3rSLOuvp9pw>
    <xmx:7FLzah7ObZX6Q0F5CxzCVxogZZaXdJBM3fMWYscIWHCXMkYRnxqMkA>
    <xmx:7FLzamQtoFz3LogRKKEHQ7hoofboGYyf7xzNxacqvYp--E4-Wuqinw>
    <xmx:7FLzaqr4H41ETjRtH4eiJkOEp895xeI5GSxDXigr5e1rdaJRBRinmvGO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 12:22:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Jeff King" <peff@peff.net>,  "Julia Evans" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <10dcd7e2-657c-49f8-b8fc-0c29fa55e6fc@app.fastmail.com> (Julia
	Evans's message of "Tue, 10 Nov 2026 08:46:32 -0500")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<20261108023730.GA1242909@coredump.intra.peff.net>
	<xmqqa4nhwstl.fsf@gitster.g> <xmqqo6bxvdbf.fsf@gitster.g>
	<10dcd7e2-657c-49f8-b8fc-0c29fa55e6fc@app.fastmail.com>
Date: Tue, 10 Nov 2026 09:22:50 -0800
Message-ID: <xmqq8q30txcl.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

> Thanks for this, I don't know how to apply a patch from an email but
> I'll ask in the Discord to try to learn how. Same for the other changes.

It might be easier to fetch from me, find these squash commits from
'seen' ("git log seen" is your friend), and cherry pick them on top
of what you have.
