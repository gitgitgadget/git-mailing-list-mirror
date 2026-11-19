Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126446;
	b=1B6Fdxu1ybVqRVouUCi+QQITCEc+z1QXqjxoo9xQJbnwYn9giJyF48Tl9sy7ZffOZdCU
	 fk7xJG3FDzuOO5G88Q9/A9XSeC8IhvOjqO5YWG5eUTkpe3+6R67IWQ5TozgwWTalhsaeJ
	 tZl8c+23Z3q9LInuzAEXWTp+wwP2UTo+YJGeqL26B6eyhzoGQ0hICE4rPXATYhuz/Zqpr
	 PBADLdHq+4liRvXoEg7fcLme5DCCBYLbOA7/ME2mCQrnjQkqaxIcEkKvsiRJDn46XH4Y4
	 O3VdBBNhJ/2zHWNJgZQdp21yj26K59ESRsfReyn+0fOpcqwGvkPrBmu+nCFEkyEOTgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iXuT4t2pFDVhfmgTU+iT/McvAxDPtRe+dwHXkbdqQWU=;
	b=hOBiGV53cTzvpcVA3JMxBLe1PCVI8LNlnMyJj/IlgDwf8835b4h74Wnl3s76M0/QjR5U
	 ealF5tEPBSqNDPYt29UOOnas+GyGTMAe1RhmeuF7cDnMcbRRg4aJS/T2h0IbYhZdrn+eA
	 aZGvxZh6OAhtn8E7RyI5afZU/Btmn9y695R4uB1f+XX+D8gCWdNzwEFHqopuOLVPHxqKL
	 sszHLCwDy7UcOGdBrggK299KFM8bL36BCU6H6M2W83TwMi0WgQwHncL/D92UcA21VoXSB
	 LtOHyxeIRl5YDVR4V98RbpkJ6NIDofwExJ/Hcl0wHUWgdKZ9XRp49DqHrnw7B438Ujw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ll2wwW6O;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EkHNyQeR;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDB606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 22:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CDB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Ll2wwW6O;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EkHNyQeR
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B19767A0325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:14:05 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 17:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795126445; x=1795212845; bh=iXuT4t2pFD
	VhfmgTU+iT/McvAxDPtRe+dwHXkbdqQWU=; b=Ll2wwW6OU5j1KldPQ5GFM/3AP1
	DcAjYKxQIJjbv1Zr0sXlpVBvrZEd7qm9Zal1yXjJXHyBlMucjbTtaLK+/ebawdSZ
	ToJ20eA9TpKv9NR/HCIKvLgZOxTwl62TwqofJICY7y1NvZJvQFjN4qE/h48ATYIm
	m34zcfRx6FdH+DVvqxMM/DA+flZRUfrhp6c5oeN091Ni+QSii52sIXhXXZVb7tVz
	Vh7XsqkJy6LMStdus+Wj/OPgRNBqUtLUAoxcD3HncViime7ffmat0LyKNDAD+Az7
	4oNS/66x8/jAr9zZGBDHSsgavBBJVMVsKC6UhREMpxIQhyriHTpzFhWnEL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795126445; x=1795212845; bh=iXuT4t2pFDVhfmgTU+iT/McvAxDPtRe+dwH
	XkbdqQWU=; b=EkHNyQeRODKHanN96/iA5SK+0bTrf9k5W/V+b9sp4qG3ijiRHDl
	g3K1+ZAkTMEvIm07Q8p+ZxLKUq1o1k9KSte+IE/DBNj06FIGnIY4lrdTt9opbZnU
	kLPFmMV02l4/2Ujk1Aj7cJteYA/ZayRSIOKqxm7XVc/cOo0QzKXTVMfJ79hLjeQ4
	8Oz48OWB0fBL9Zw/yHLtslEQVhd2culAJLAFqo8aZzsS8U2Gd0Jk6wj0zlM9alVL
	vPhus95Kh5O5br6JCJUPZeI/p2h6kHOfxoRFQxvzYHD5K1gaHlnK940cekIr182E
	HrOQQAooRYz0Nct1RoF15fQF2RSGwpJLfhA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795126445; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IswPgK9A26q77C5FUHwzTk+9S6AtKnJm+uk8nhRfuc3JbRt
	4Slx/juutuNDxtHo/dhdk9COHgefdUZuTE2cZreqydpejKxDKMkHjBVDW7BvGAgG
	d411GvH7RlCaICgIVL6pyveqPkJlDzmT/1q8Qo5aXZPJYLF1dB50NZC6H5q0VqSo
	Y02wUIjHQ8/jgrLt/6hVeNP+pVlTQXBEfCNYJVP5S6l2GOkL2RaKUoZyxNQ/76VI
	NjaNJH/HWujzwLPpEirjjXQyACxrC1qsN+b3qwKTPfZtGjZWxkX+FxAlGSoMjRgU
	m7rXwf8nLLrq45wOL3r4ufTrncEdgcinF4pomLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b+OsEF1DzYQ6ndNB/0/OxVxWa7cWt7pbblMoU0WPdBc=:iXuT4t2pFDVhfmgTU+iT/McvAxDPtRe+dwHXkbdqQWU=;
X-ME-Sender: <xms:rXT_anRZF0CaWI5FEVDFujMFOkL67JfJig3-SD5Y1T5-8Y9sSuRBQA>
    <xme:rXT_aiG-LDef_GpCppXoS1mCCc1C_2zDBGcmB1bPY9UMdoFs-qXXC-Z1O-igGv0_P
    JK5l02LwbeXGRrgdKCl8js-A2LmA8j_ZlE-B_1JQ8DDRz0w2RyhiU45>
X-ME-Received: <xmr:rXT_akFpwPuL5wqugs6uPiO-dYmFF7bOuryCknQ0zlEEzd9XQCJmGl0fYPtzbx5bHJq37Crus1Zmu15yBztBSkx9w6nwOsWCIj-w>
X-ME-Proxy-Cause: dmFkZTFD9AHGaXuOayaH0Q6jACK+G3fUn75DvbqhsEednZKsYr4Eaj10uWSO2UmmXDZJm7
    I/82AV5lxzxIkti0SCwBN048XzuXAdHHlEIofFrnr8CsYgHc1HTsoC2cG9/HIDEOC/7yyh
    hioFSL3PlkX64+nM/eSJhB3coSmgfV5pXjouatvFeSrNDGfa4RxXqARwnmRWeDpHWl+q2L
    l6UOq1H7UVaXxbnD5DG5ja45z8cYCIusY1vyD7qq8GMBUFKn35VnXJsC+czC9JBRO9OWOr
    vXdmwiYFkBi0a4KvSUym7CqzKtlim10zenhDOWNhWi5r+kMIv3vKOAUuC1ToklVxFRIRsd
    d6m7eFmWbGOrS5ajDE3975gKD8VfIfPeyiJhhUM43dejxKWIx9MORKOvRBARmoGx9rmz1D
    Hd3EBLgac3MyQX0LA9cPPTO+vaAfr9qMMz5wkST69Mv4qqb2d2IJkU68+Ej/9YYqUULixZ
    RFmIQfGCXc1nX/94xZUyEZ5G1U5a3C+7gppF7m41kCndLuDDeqzTooBhndw4XO7G0wU4A5
    fVTW4ZZ9PkEZQ1trE1qUvtrFYlYpqV+OMaOEIh1cjOVc0T+CGIfF5SYGn3f9MP1s/ID4Yf
    vR19XAxjmokec6kKocJcURXFdGWRkYmFOKLqbN1h0WRex5onmIbRSWuisJmw
X-ME-Proxy: <xmx:rXT_aoRVmQSFD4kuAfIKAwqM6aCgCTx3WPlrzEv-2Sz7i_pGup7LNg>
    <xmx:rXT_atJ31hOfb5XyqLbimwscWI2Qo0pf7j2MBmGTs453f0ewLVAHpA>
    <xmx:rXT_ara0XbLQVqEv26gKjqEc3sg2doj2GzS5u7mPLUrkSOBniaa-Wg>
    <xmx:rXT_an9RTXkjg7Frog3Blw7XLu0xfat7I7LOfx488j7l9DmqsAVQ6Q>
    <xmx:rXT_aj1R4JfEEQXvUrMedNIcWV7ke2-Ch3whI7V4W7qDsEkum2mCRGSQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 17:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Andreas Wendleder <gonsolo@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 2/3] submodule: only suggest submodulePathConfig when it
 is disabled
In-Reply-To: <871p8hjb6a.fsf@collabora.com> (Adrian Ratiu's message of "Thu,
	19 Nov 2026 13:46:53 +0200")
References: <avuJBGlB3pRU3JU0@pampelmuse>
	<20261118163249.1693361-1-adrian.ratiu@collabora.com>
	<20261118163249.1693361-3-adrian.ratiu@collabora.com>
	<xmqqzev63pnh.fsf@gitster.g> <871p8hjb6a.fsf@collabora.com>
Date: Thu, 19 Nov 2026 14:14:03 -0800
Message-ID: <xmqqmrr4v590.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> ... dropping the "hedge" and actually check in all three places, it should
> be a trivial helper which reads repository_format_submodule_path_cfg.

Sounds super sensible.

Thanks.
