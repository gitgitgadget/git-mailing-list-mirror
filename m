Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938286;
	b=IRRm1ycfadw+QsOYHebiJSqgkCDgYq7dV4eGXYP3dek53GAOtlSfcCv0KE1V0lAGaq3t
	 nQtPlI++1/ugw2E+sNvU1KMEutDkeX6gbQHZH5kv8vr5HI9/7/om5S0BndK5N9IU/7yuk
	 7NJF7d4CYkMxrWOuFcL2s0e4GfFhZTF17JmjqSrqxguE7rTm5sZXTWuP8WuH0vd4XCz3F
	 ivxq9cPe4d3MDuiP6WrbtKkacIUrVFYMyf+HnvJqSDXhY/NL9ELjO9jVAlDspB41Dvk5s
	 ElUcxMAPmwC2nTXq3rPPEmtyA1AUjQrJOPp9A481Oo4GcEUElcrEGAX4lUAYfFYWC8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938286;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=nxgAGXMFfcDLWB1++1A534ExTDRKXtuAAomk1+zGwbI=;
	b=nh8SzU3Z/N11deR4TakRcnezp5OZjulMZvSQdMz//e+6NO+NM/Ctg8q3fhLgwsK9e3jh
	 ktYu/8ftXkJPG+n5YMje243/FhsRz/1VrCsQtxMOZDH7AmqIDu5jgTwKZocXWrjoI5tc+
	 L/zl7r8/NdyUwDr7e1rFMwQgyH1Jv5RNByjGanhgYrtyQm47WHgN3X3NWEhXscJn+omIa
	 Pyp8fGOVwPNTYSO+jWvyYXJl9TEuGwMylp0Ct1glu5bxySxmMCqgFPymnhnlIkn45tWUS
	 61anICRd7dFawaxLTihRaF7s27s6aUdzS0oJ3ZyWDIJBFZSpjcbpsKCHxFLaIh5BU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lFzMo27l;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="bL/N9za1";
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45695606A31B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 04:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45695606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lFzMo27l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bL/N9za1
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 572D014000DD
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 23:11:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 05 Nov 2026 23:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793938285; x=1794024685; bh=nxgAGXMFfc
	DLWB1++1A534ExTDRKXtuAAomk1+zGwbI=; b=lFzMo27lZnXzNGNjn6WkmSznAy
	VLHjdTXg2CB/ss07CXvXRjQEjnd8+Ufz9hbIezdMD2eNQ/BEpYbX4vVKoBAL1jsF
	RZd0Oi99YJ9nMpXi2F/00Qnq35FPZQFG9XlY8CU3Z+O4Yiapap84RF96nEgFahf8
	7RM5iQxlpHk49eJskNBuJirp2h5uia7wi1FVsJstuFXgZPnpGXoJj5Z2IRgD6zUa
	q6yp1rZF4h9gZYLZarq/QFHvYmtMbH/6HYMOr4mBieAtUo9mDO+mwc0N3B9XWFBJ
	u7nv8rEKB7tp62Ii3eXlqg64AUpilQ+ncG33oWB5B2XbAErahAxqg5qTB9dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793938285; x=1794024685; bh=nxgAGXMFfcDLWB1++1A534ExTDRKXtuAAom
	k1+zGwbI=; b=bL/N9za1e6nrlNJ8+KJdkKVm7EuTlLz/I5iKZRzxY9SSkm3/xwS
	jj2CNSKGO0OebBh3jYS+ldeQuAa8g8QiRjLo/CxtDhKXCpW862bNh8esiiEcAHJ0
	h6N5JNdr0mm+48v8w5oui3VsgUz/aicSeIwYyjXOaUizia/VaxrXDmBo2ANrzjE9
	tyA1IHitJAWpjKcmKYi0FykCPW6erDNBMZ5f6iKRi51c21ZuBRzhpZONyFAPJE8f
	yGJ0Pps7+/sfCBaYtmXTAuK5R0lCCfJUaCm0BjZr2GfOEIgcl5aenCepYalVFKgn
	osG4T8OnllEV128jV6HEDg8LdpIOeJjf9hg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793938285; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iK4Ik7YqUMDhx77YUJzWxW+SiVVijQKlFX+dHYxl3elUW/S
	x+3Pl+MuJxsPDNEYTKcI/UUkyJ1Yeh9gahhJXYOiockU6C0s+/eNeQpI3Dm0uXh5
	rRyEsuKh8IyctXwZ1ftpqAS9a6WAcXvZu9Y8gChgMpS/5xs91wHrhd3zH2tdMQTO
	dV/LzcE18IYZxG6EEo8S4vCt0jBqwbN9oeArS3XZncCGzIweksrmVi7UbRXrG+lj
	C689lUwdUJLI4VdVXT+tBAoxCGJ6d5AOro2TTPcRR4bYOI45TNneS5MCpBoaA0qq
	HMZtpcqs/L/Hgt4cJDqkUpALnpTWCzi0XDCcwCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Pl75HMvP4F0ASSoyiHvRxwZrqln3mx8cIeab1CVsoR8=:zHo0st9xeRRfDTEQCGdSMCVD7QD9FqhpZMbrUOvfyfk=;
X-ME-Sender: <xms:bVPtamiIWaADzsaHtnjnXw-Au7YllUEZz5PYtQ5jSSZR1tZaq_xIrg>
    <xme:bVPtaplkQNkAf8KgE4ZYK8KVn0W6-QlEI2rdh7zwUwB-YDhnAAawmBg5IdIUbQA_e
    n4xWWvSbUjEf5cSOb6PJWVItN-Z5HCrIKIDVROYMOBWG3skwa3Oig>
X-ME-Received: <xmr:bVPtahsg9ky4DmrRGMLT4B70Fi-X_Z90VVsBu31FQVlKBtyFgu7s-tb2iN_Uu-ktk-4wJPRqCrDwPpz_lrPxvmYk-wXiCr_iB3jH>
X-ME-Proxy-Cause: dmFkZTFXNI2q7ZoqmxD4jVfzctmFTNlbldnKXaXMbpiYzit+tbo1nXYzQphzkwxoVFwtk1
    bJD1W6DlqnFCt1h+NGegXhyDeGQQoJd/34iOGMZ7s1S55JQ1VS4ruGBkEs61k3FyjnEfOV
    OumZ55/R8ZTwdPDQfyS8S0tqJLYQjgbrhb1clqfOLJhKGZGB/PX25YHKTZFpPLFRfMCJ+D
    D9F9+dfjGPfC4w/fHRl09zHX9SqiiR4jjKWjGUlolKp7B9UsuAS9vvKFHdqn61HBExLs24
    9s1ad4mRAG/WD+gtk/UI1+/9AvEGE7mRhULiv5aQJFhZWuzya2ZEnm3P5PFmBukbaqpxl8
    bEX+cC8PXGQFQ0e+P5zQtaTzfZjNrBdbHiAaWLM3x9r7DFjHOt4SKW7nEc+UsCaggl34Pw
    LkRhE7l2+o8Z9A5mnPRw49wsrcx6WzlIAdwfOyYqDyotpbD3ghktEkrZpe9Ns+1Y5LHFbA
    hRfmlARO1I4TpxQtwFs0QinWN+oG3/obd2JTAKDc7grSpenxWu8vdrm7eBgSLFbK1HU7ul
    5FejZBfnBfCoG6q494Tws26lw3ji7imeC3BBikMnoPKBJ14N4T6lqZYymwWqQWq9eeWpZg
    dpXp9d8h8VQj4CbG129CKWrpL8JsNk76Ykdy8QTBz5xzuX5l2/pcBibegfiw
X-ME-Proxy: <xmx:bVPtavaiFPbjFpI2xN1lftxnaMNYvFJ5VlJeIyjFUS1bS3FsUj133Q>
    <xmx:bVPtapCWemGse62Qpl3Rlzwm9ENLpxyD5cy5vn2puzfWLi_ICul19g>
    <xmx:bVPtan8x2WKa5oM4GsU7wWmJOEa3VwLL9qxm4NWMGXzf4_G1k9FePw>
    <xmx:bVPtalQpDcWvxj7D5bTKuy9QGLK4rmMPy-FXAtPDbpeutlr8XhSCjQ>
    <xmx:bVPtas8Fr6vwmKdisl1suZcWIYUmBgLEfTZJdgrKsXmG_29Jb64mxpqM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 23:11:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com,  herroyalpriestess@gmail.com
Subject: Re: [Outreachy PATCH v5 1/3] parse-options: answer
 --git-completion-helper before command runs
In-Reply-To: <20261105223458.1534785-1-tangajoris@gmail.com> (Tanga Joris's
	message of "Fri, 6 Nov 2026 01:34:56 +0300")
References: <20261105003914.708836-1-tangajoris@gmail.com>
	<20261105223458.1534785-1-tangajoris@gmail.com>
Date: Thu, 05 Nov 2026 20:11:23 -0800
Message-ID: <xmqqfqxeoaz8.fsf@gitster.g>
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

Tanga Joris <tangajoris@gmail.com> writes:

> +/*
> + * Programs that call parse_options() early do not need this function.
> + * If your program has to answer help requests (-h and --help-all) or
> + * the completion helper before parse_options() runs, call this
> + * function to answer them.
> + */
>  void show_usage_with_options_if_asked(int ac, const char **av,
>  				      const char * const *usage,
>  				      const struct option *options);

OK.  Let's mark the topic as ready for 'next'.
