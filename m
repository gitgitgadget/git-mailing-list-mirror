Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864354;
	b=qc1QyirzWr1ZF7iwO8TThilIk83ABHerc/d5x07oOPYrGeFroyrYWVos3bj0BbqAJ2jl
	 SqYFcEf5Cg98jkRocmGWxNXV0Q47IJVgrvLO1DIWivRZ6CScNVnF+XPgxdCcgog0uz7Jm
	 axW8Of0m9pokZymEpJozpATvHEhiSTRQY8gQ45shWWQfF4dRG+zES8zTClmrBjcLyFNbJ
	 YvTX3kla2sZjxBsHU4c22o2jQC/4hv788vKRBkWGgmS+Lw6+WJPyF9/cEkX2gsafIOg6t
	 +6gq0TJpZ2i9Y40LyYF51qVaM6wekvCW1AXaHA2QXEUtCNzM31Fqmbl+9+K3c1y1HqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864354;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cMz9dbeYc5LJr8dDvVSyUJrIgIFyf4MejGgf4XDPulE=;
	b=EkkOCzhKT3bJ/hUeGQ+dD0oDWyTHMb2FrHHLhkWw+c9+e8wWbV0mb+nKRKnkCmHlWb+v
	 /8OlUh4msef5xL3m8qa4H7pedp31A2+vbx/oT3NmwKUQYNqp09F29z30mb/eEYPamF1Ce
	 UyFLx+NheW5eZSiAQ9T3Afq1S5q6jmL+G+OeWlCWzFHI3HKeZy0XyRx0nYl/4qI9bb9Dw
	 x7kDMqNDCTlETRb4J9Ze+fT3mJvpfb8SIPux6SRUe7CnuIkZQNFCFrL7Jb/ErUJDnir5p
	 l3+D5GbB1ozb1Efrabl7kB3I+JsLyTNG2DrWWaflAgqAALadSUmZZybRuTrWGWrq1qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f1NusdLO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yGNLhFtF;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13348606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13348606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f1NusdLO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yGNLhFtF
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 58B121D00135
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 02:39:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 02:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793864353; x=1793950753; bh=cMz9dbeYc5
	LJr8dDvVSyUJrIgIFyf4MejGgf4XDPulE=; b=f1NusdLO/BWhOvEwlQe5uUPvg8
	MA5rDJD1b1upx+vbAqtxJPDj1YWblnPKt3nFpr4LWun0IJmGo7rqIj+Gfe4QSJs6
	ZZpH61rm/syCpJCbZ9SZlQ3Bm4cCLDaXL7t3A5YNqzp+COGRTV+D+b3NowAA0z1Z
	VxjTZat/7dVZXV/qHfAHIUKEDdUAHWWqzY5AcF6p7dwWCuyXlv2ZAHDMRXJvhnmz
	E2WBLrnzajn9atU+F3xJpNcVhRAChX7gAj99Uh+8L9vJH3G+Wtj9C8Yh0gVnSl55
	oKUvD8ZTymFlBXTbrlPdL4e4XqkbNnhSUeIupN31Fji7zCukWmPtjq0riy+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793864353; x=1793950753; bh=cMz9dbeYc5LJr8dDvVSyUJrIgIFyf4MejGg
	f4XDPulE=; b=yGNLhFtFcnpELcnXozE6OgxWAHYttpGldQhJ9i9gcrNSjdxTYev
	K0x4i5P5I42zY/5GJkj1la/Zacvre9mX/EU3gVPSstf2IBpsWX6MyosdAyDZqqct
	FtK6E2BsRdfmMupB4toLDFyyyI6hhfb/fNhsE4FAbbD2iVIv2wQp0rvI2IAQ551b
	DE6bK4XLsjNXdlve2iVI1691XZzk2kawTHcbVTnOlIZQo61D9ZhDNPpej2psTVfE
	hPjOKjKh+1lwulfx1pxK0f5eXPmDMKR7eJzV7OqnI86J439Cf319ACOiK2EGw6Y3
	Qnzm3LRQvoVzORiZzellx4EHMguE7oPp55A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793864353; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nZYnllggPZvY2b5Nnd1p2xamkwgehNL7HiDmyzyUCw7Ef7h
	JhoC1d2Dg+JQ095s2xNGVqwYP3dtOK7LQ5JpW+wq5c/RUoMycDx1WGZn0jgcAAV6
	C3lKvfCAa+ZLcu6k9/qW9w4dXCXot/Qp2VwlyT6F5EJuN8xxxVl/kdqAEVwI1VMe
	NDau7bMCBsqUmxntaIRYZp1XZ6osyxjoVkhF5t/NQNvJ/6Oo+kQErWSlQ3/QHPwn
	0KxtLq1R7JenB2rBHusxbhwgVCNpbDfuXnXjc6VWHM6iBk/N2kY7ihYa01YkZPqv
	5cemgLw8tXyDfj+AmWnNdZG6h++8EYyn7lpF8GA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mKgy3pckQx1B4nX101tcMZUNytTTVLyg5AKLQ7tZV7o=:fC34nbm5ksU3MPvVlobswzWYqiC1H08z29dzJ4ecgIg=;
X-ME-Sender: <xms:oDLsaqwUXjJITYo0ju8U6mz_NJnqLJHTmD5EZGk1KaBUbg4k4IKWlg>
    <xme:oDLsalVQmr3-8M_PFb5oq9doAxsJ5rVWL6eDmRvsjZIDY2HjN6aWFXlLtjHdzJU-C
    LQPUagVSJ2cWPbODKr3HUtTXZYzOXgcgIk5KgX2O2_Jo-pZR_2GnbfX>
X-ME-Received: <xmr:oDLsaihQybY7MbxKveNKrjgfZ7lwtBqmsjB1ayUaQPCcpywuVAe5BuIUJptetgYPpuLLepRuX-uIbYwEqSe5OIlngNc0k6YrJRv6>
X-ME-Proxy-Cause: dmFkZTFBfGmxQWOOsmvl4stDqhowM2MSbRJpUf35ChVXTVksMWquhpO7EqvXkCV0IVDrRg
    P8V4nR7ZOaxKJniR5aCnEVWW4r/R7Zc20n9Pi4gDDaUel6LbjXk40041BMXMj2kNM7jy8U
    ba0ZasGCMzH4asrG1SM1JPf4jg8nvGFoMiP4HIl/+U1x/TFJDQAipVmTGIomD0sxHn+uSr
    RRzYO7pPA0GxYkaVm5ulkqonDeHxO7gfYbWfhTVBE09wRdYVhX5CXWvbyCJteKteBDNwbE
    Na99iMrkL6KhA/aQX0NSpnCNwtC/qnuOR2mgKRXRK77WQi08KdOukL6Q00YjLCwCb90NcU
    xhDtYg/5tSW56uWUKYChEuSzVtFn6yfDCkKs38sOadNlVmb8wU6SioB+pdkshbidKmXRkn
    VzEU0+yKHh/ClAFHarppJYAUIKOVBQZO7t4q5jflHh1BvpeT/FG9rFNNR/BYrXJPGELMw5
    GDiWBjaRbCpquNwj9Twgu+RL7Vq3d4m5qoBi2KuDUvgoufEVN+zrqPS1lreeNWwgiTacXd
    Xsh4zPwYxtvNm+C7OvkizeTmhRvqkYBc0XxrKDNGok58U3t9qtRIW55obf85Cg2oHG67lK
    jqmKLZzM/fjavug3kP+lMU7CVdj1OkMIN+6OQNqirF/leKofFexKgJXAbzcA
X-ME-Proxy: <xmx:oDLsatAuhLvO_QX51PwyX54Nvqm6_11PJG6KxU_toMlOmhSHC48b7Q>
    <xmx:oDLsagtdVUlxLp6q-76DkmnRepWI7m3CO02mGxdGsBZ-PO5jQZTkyQ>
    <xmx:oDLsapd9zBur2lM3j9GcfRrUJwP5WjV5bqgPAJdzJC4FtjUxivMRRQ>
    <xmx:oDLsat9z3srT2j6Z5UbiZA072zQ4ePGTDbBJ0WWBhLph-WD5pvmIrQ>
    <xmx:oTLsam-kDccsbZF6P9zfpjp-EeRz-9QdrPDvkz_PG5vCj6Ac6O5Ouw27>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 02:39:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  M Hickford <mirth.hickford@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 0/3] credential-cache: fix two races when daemons
 start at once
In-Reply-To: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
	(Farid Zakaria's message of "Wed, 04 Nov 2026 11:53:13 -0800")
References: <20261101-fz-credential-cache-race-v1-0-28f0bac51e11@gmail.com>
	<20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
Date: Wed, 04 Nov 2026 23:39:11 -0800
Message-ID: <xmqqik2bybfk.fsf@gitster.g>
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

Farid Zakaria <farid.m.zakaria@gmail.com> writes:

> - Not changed: the socket is still removed at exit through the
>   tempfile API, which unlinks it without the unix_ss_was_stolen().
>   There was a discussion with Junio about this. I can do that if it's
>   a requirement in a V3.

Sorry, but I do not recall having any discussion on this.  

I just pointed out a potential problem, and you sent this version
out without responding to my review, so I cannot tell why you
thought it was OK not to address it.  Which means I cannot answer
"if it's a requirement" question.

Perhaps you had a solid technical reason why the "stolen" detection
is not necessary, in which case it might be OK.  Perhaps you were
too lazy to think the issue through, in which case it might not be
OK.  Or there was some other reason why you thought it is OK not to
address the issue.
