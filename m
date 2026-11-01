Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793566655;
	b=YB04NEFVbLPqB/CK6Con0/vGGY37nsQOnF84IXfAumaGII27oDiI9gW/EloZlerbEoPB
	 kH9zM45PhSKXtCYACdfRBfF20j7Hpf7WYSS7EtYYtxucLWXsldHqk5kr8i4dA3QfzmQDD
	 P81Ut7Vu4GGhnStoomlhQZuSwvw1Ek26PUFy3n//WKua12V26wISjHqKproeebW6Qqh/A
	 YzNJ+dQXsaMn8b2FmlGXrKrpQC/xSpu8eKD6kRhxYb3J6bgIX0XdZy1T56nDfi7mGrJmS
	 1VVNO5L/J6i00ig8r9YeQDZ/ONPWA4Q9w7rRW+QXxqTazzl5DsrYXV440Ba6SnzwDQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793566655;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dj19wG7z3AR0vaiSGKhB7GMWOmDB76vJN4pjkrIMCiY=;
	b=xL/03ELvSvO8OWRWbheUnLAHGqXYPikQiiF2j0oxxlUieC5ptxcrBU56DH2pmWSkTg6L
	 Tguq05FUWmY2ZD7GhMo7BOI9YjO7aX92C91FS2Wc3J76ZUhG+CWa3GsmqIbKYXnxoFn6G
	 AfrB7HjmK+nbxtU7+u05gwV9JJmIAoF1OVenkJqlFozmqlFYVPW+wVRADhEHvbKUdv2XW
	 RYIKWB7rNNZLIhtgW2v6XtMzQZl0I7eG56n+BJFC0pfNW9Zbo5G1Nw9RmkaCSBgappkar
	 v7QBo/kja1bIImZrQr/q6Rlqh2a0wWzhPvSxCb9J++b9bwNC5b7x2i+qWv7Rk1udyig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kNaMQKjq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aBqO4UHU;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E59606A330
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 20:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35E59606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=kNaMQKjq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aBqO4UHU
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 607801400179
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 15:57:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 15:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793566654; x=1793653054; bh=dj19wG7z3A
	R0vaiSGKhB7GMWOmDB76vJN4pjkrIMCiY=; b=kNaMQKjq9CorhVHlpZQ/AGYHOF
	kM1YYhtjB3CzpAyQyd4N4bjlHcKXDSETNKHBXrBw18/YfBLmwJt7b1R+wipwcvam
	9VaEuiWsI4j5H7Iwql5JBHN8R4EPDjnERUz2ocg+8k8piXd8u0JLYE51hxSGZAJr
	0otX5jDtFLyeCLjArHqE7pjJeAG25/b+VndtXk+ZiUMlsZ0EhBKFAB8DW09RZ/aT
	w3liLGpNJSsUz/g1jme7Bl2TSaw4Di5qEDoZqOmcAK/abaJw8kNbzw5UjTY2P6lh
	FQR6eAgbuHIKu8mwkgZvCiE+b9yWDizJ/IGfm9ENzqu+iQy0ID96FuGPbn+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793566654; x=1793653054; bh=dj19wG7z3AR0vaiSGKhB7GMWOmDB76vJN4p
	jkrIMCiY=; b=aBqO4UHUEB3saDXBINb65I4JYxdgip7EoSJpgo3HVQ4NNWIqGhD
	huVMbPSjG+Nml+WzL7CV4yi1CWdiU2G3c06OtXn744ik2FQQYT/FKXaqaxniYZ0e
	0IQG9FXIxiyWDHYwyL5NPRb/BC6GKb2AJR+JKNa6eM6HWgsrdx/ChvhzwA7CuLB+
	CgR4yli5dWcc29eftKZv7xKU46hicz0SiBbso1zOsJKygCOxEsmrsQTcqe7hXuqu
	LEilJcvWc8yo72Jcih+TLWtCgRas39bPkB9K99x94xI20XcWyvxackkB0WmWSvC1
	m9e1NUGBwRB4aim9PNF6Y7XlbHJc+vSla0Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793566654; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QqYhvhSXrwT4CIdzVQr+FZX5B3K1aCutPWmxSter5GXpeAC
	LzXNJOe43F0qufNICAKNYWoU+EQYwty/MNC+sX6rMIBFk3gaeq1ShoQcM/c5l6zJ
	Cw6xQw9iH8CZjE3jNwmT7BNzLuG7aS7/sx8Ctg8DP1DtOt09+oz5PHpYDm/AGe/S
	Qu4jqq5bIDp9OGXO1deh9FQ401wPNGuNVhRguyNW3vch8s2uMPGYDcJuOJSfNiIa
	J0abLsXKh8hj1PUx+x0vPbpnq6+yMZU3NwOHI9RIaqN9PcX5OPbolNnT3gtE2f1O
	bguuA3GlTHIpyJGhlf9Lw8inNsX7tTInF/SCX6g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:pRYuVWpEqAOesIXTxYeb4puNiAvKWkjf6X7wmPTTlHU=:dj19wG7z3AR0vaiSGKhB7GMWOmDB76vJN4pjkrIMCiY=;
X-ME-Sender: <xms:vqfnaqJpyetljsd87lDTaegGcIi9MvLVMSwmko_B5eD3CNGL95TrlQ>
    <xme:vqfnapl90-jkAsYzws8pgqC7Dif0svEc5hJyUU6Fn7Umn1njITaKZUnYzuvUcx5dV
    LOrhNxensaBuRNlnV7SE4-6EcFvuMVfro7K5At6z7fNXCiM8TPcSCI>
X-ME-Received: <xmr:vqfnaoH4bdCHJu7WRqRTZicRGXonn2_URysJBZmcTGNHvvldwpUlollxizoWFuA2WERenOSjlB_f_HP2jntMKRXbfSFbCOJrNkRz>
X-ME-Proxy-Cause: dmFkZTGI+Afj/8BNY6alhZLLvP7CZgj5isX0v7fIw3PgJFA+XZqeFekTG0XUJ8a/yUIzYF
    M23+aMJlthJkv0fcg4aJJrIO6jfp9+bw2BzcmJIOasn3bJVNHej5DJf0b2pXkWcyDGVCWL
    F1CEL+Dk3cZnoE+iezw4Ed78ZLpLlrSMEa5sehrba0i7W68/X8VxrN7FDhUDAPcBo3qZgV
    kVvpxUUkoJxvQHGHk31qTBcFfkzwriQOE5QbzRcNpHBp4E6him+SUTtjQ+2gnDlv/OymRa
    a3405VfcHojyiVejUyEG/QKPpMAHHA/xmdBgcHDao0uuHhMtcO3Lv+4oDXr0XRt/3Jxtjh
    OvRBx/iVUp/sH0KwI26JBclspmgKNRuH1g/DQLR6so2aE3xONRLNsssrhLg9PyWCeOGZ7d
    vQGp3SLvEs+NvfaSn/QplIVlDhG8+3v2GlgZzQ7cjEB55cZJySW4kXvfQi1LXUAv7wSyv7
    Cd5ZW/jMfBRfpx8vNBqcjMX3etIFZiekLR2XS8EFLU7mG7cnlhdZixdJ+TT0P502wiUEmF
    fdCLvk5gQVfM7Ll3XcQjAiiuNyfZzw7sGNFNNMFQwWrGAxpMz4a+KX7GpmNrt14BgRZ2oj
    jTgxqinuG0H6pIDRXI8XneAcD+FTFl6cB67PYB25xEuqMNc4gcqdcxlfK6WQ
X-ME-Proxy: <xmx:vqfnapE4zWmhGdDqc-l4u-RAbGV5uKOs_u8bsSbuD0AKRl4Pc6eKng>
    <xmx:vqfnalPXQLsonXIX7aCObnDjlJ2ghX6oMRUOAYlNHAyC2VtdF0I9JQ>
    <xmx:vqfnaoHBJYG6qsn4kwDX-eLVQiX_aYuE0AhnCDrrVib_Exw2QjTexg>
    <xmx:vqfnasNTrJe5L_Q4kaAJdaU1zWfqg7felDJHzMAPcV_p-L4xmTvK6Q>
    <xmx:vqfnaoVIFFporAwRhd-PrsdTLeS1Sm0R8-2a_ojXjMxFZ6eDTN9wZ93b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 15:57:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5702: be more resilient to env quoting
In-Reply-To: <20261031050337.GA1202343@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 31 Oct 2026 01:03:37 -0400")
References: <20261031002550.GA626623@coredump.intra.peff.net>
	<xmqqwlqytvg9.fsf@gitster.g>
	<20261031050337.GA1202343@coredump.intra.peff.net>
Date: Sun, 01 Nov 2026 12:57:33 -0800
Message-ID: <xmqqpkwoz2v6.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> I think you're misreading one of the tests. The one for fetch checks
> that we _do_ send version=2 in the $GIT_PROTOCOL field. The others
> confirm that we don't (the idea was to cover all of the possible
> operations).

You're right.

Queued.

Thanks.
