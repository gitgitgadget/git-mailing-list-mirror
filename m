Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192618;
	b=EWu/7EsH/0cXlAhQ/1WqhvSZNDPI9wQJ6FORz+Zl4D00dYjumTaJm0ujawMosOMY3nU0
	 f7MzhG7Yg3yPxYXQzOCj6L/euQf7n7Acke7dw9LLEYjaRfkajnzQTW9wbLZY+jkjjLxUW
	 DDy+eZ28+76KUxEHWQOHaBxVkCRWcbs9DPPBCAVL9LVcoaw9DBpI2JnSmRxzkBa+kum7Y
	 Yhp5Xjf1VgLasVqs3Vs9KQE+A/vOlAxyZz4isfWt04b6Xaav7EJQztJVAnHAux6tiBHV0
	 6A7af5Jv1igiH3IMQRoKnRgG1MfeLg66GZio2Q8EBXRM0U4jdA8PaiYZ9aS5HO0u8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/8WrUhi+WOy+fxiDMa+T9YUtlqhTLVltaAD6FW7FHUc=;
	b=Qb+WD4LSqG1FQG16aSEIN9PtHRkP+an5bTkjIADouXq3oIF5g5jrwqMFhy/uixcAheyd
	 V0uJYz0BCLkrXiq+w1mPaiopDOroTfA9qUZ4P8X1I3iqZ852J/fapu5h7F31OUD4RL84+
	 xlES2Q5K6l9YpGHxyAUx1kBtBSL6pyVV2pnYQmKC0ZdjWhyav+8nmjv38jUnQAlum8H3X
	 xB/cnrdxciIZfWCVBUOcrcWQ5kFstAOcejQeRnuNxDbSiSbDXjpUivgl9QZX0+dg1p9de
	 AASVgbCqaywnzgWnmgFCfvaSMeVKLvWStA4iZhMYYzhZTcnnzAloJ1HNDIT0JZZoGPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LiB9ehYj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="vLOAsLH/";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B29606A333
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 16:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8B29606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LiB9ehYj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vLOAsLH/
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B79E81400271
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:36:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 11:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795192616; x=1795279016; bh=/8WrUhi+WO
	y+fxiDMa+T9YUtlqhTLVltaAD6FW7FHUc=; b=LiB9ehYjeQIv5XQ//ECw/w8rge
	qi4lTjXcvET0Q6rrxpndANB10RBLqhE4VhmKHlx9TCVoNloYtNHtZeirYzUBnVMt
	oDB4QJgqHgfeSKak5g6xhEdbDYm1RC1xv7fg6/aSewwEzZZciqSTkwvWkVHC6bE8
	c3OeFuFkxQH8iDj4bgYOdSd5w0di3AawJHE2ykSaiCAPC6hu6fJA5cMk9wwDZ0NP
	SmSJBDDruUzQ4Gpbz5oe6DfXPl/yxWZWUr5kzNu892qmA4ZSbWsW2V9y5GBsFyb3
	De4uE8d4/+55qJSN45R8HZ/SIfU5mOzJ781cSzR6Ymrtz8K1VMUwo76Q2LDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795192616; x=1795279016; bh=/8WrUhi+WOy+fxiDMa+T9YUtlqhTLVltaAD
	6FW7FHUc=; b=vLOAsLH//KUd1mIfiCwSVs41pJrgY8inpiVoVMa12GnnMM4Lz3P
	Mk3sHHOYeksHgcrD+AGTa7ZS+PfJa2hNgi15fIWKa57joi9pcFnYqxc6kcupPCqW
	I3AxxYdfuiz32QLet6eKuTtNVfpqdkIyo9PSwl/j4XRsXJvzjl+3Za5gNbtwk2Op
	q+b966IQJihwiEf9Wgx2uwjytib2fnUovF3ekgvEZt6JHtpgV8jWm+J6w7XsDbKR
	EQOBWXzAEdan08ILIns0l2+PqxRGFZGPrQjfUzVr/y8PxvBD74IY2YQAwKvOJ1en
	gT+FBv9JL6c2bHjf3qsOuqoPt6KwfrwyZmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795192616; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IYHBp7EeaUteeQSKgfXSv7m4CeXI8FYjOnJkJ8GM/dsPs2w
	xWxzEoShQsJPZ1VlaRY9SppnZwdmnEHofRQtvnd9NgAhj+BDr8hHnTKWh6+K6Kav
	P6PW3Tj4nDWvYe7f6jyuxRgJ7/JbOMMBlHqswTq/qaYkaaWAKzepTyMJ/N75hl2t
	V69GdCiYdTtpVY6Yb07oyBa8P4FfbENH99uDuAY0vRsHoGLMapq+Pf5Dt9mchOLd
	R/3dreWVu48niibenG3rcFHELpzrKPLzV1+6nYfRUEnmFYLI/fUy+gsgrDuMt3QM
	2oXav/G4USNbf2kr5n4rC2hmQIRfe1y4s8ysAbA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:te1wzC+MNmUNGMza3T/xwOasfOH6FiWBsr2Wjcd1LCE=:3qJw49DqQC3jpqgoEXcxqdoEZiNNlZJMXUDOWMO0qkc=;
X-ME-Sender: <xms:KHcAa1JzxsYFMr83x9CO9mVBtMSPs5B1Csyzmld2rcOP-e4eahNsIg>
    <xme:KHcAa4KG4bz2SEYNrJaw8FHpweTWMgHwtTa_c5ZVpphD3FWH3Z1O5P1OmB7NbiVh3
    pVDWhLhdNKYG4GBfGaB_MU-iQSZsPFdxHiRfeLwXzNey9MWKaKU-UM>
X-ME-Received: <xmr:KHcAaysfoTRN77_MzXHRZv8h1TQFtAnYIMs-Y94NNkAwEKZV1sD9CmFm8yoBmExFJCAEcaG5KQ80oQj24sdSC80iSO7t8_yLEWNB>
X-ME-Proxy-Cause: dmFkZTFye8pBcK1qe8l4jWZCVpq/jkmRXX3nj7EQOuwOlGkYDpqRR4I54duvlEKzktqxtN
    cgNAgpTAMoixZPuy7YeI27kFu6ali7G+YWCP+DaGeAjT71h9UMV59M1zJ6rKDaZItUMBzK
    nOoB/TUPxYnjMvkscp3xCaGQtRADpH+PfIBuDuiFbWhKGXz/JzcGsGHE6WQo+avTP6/SGP
    aiNrQk2gOGMErzRI5m0fYgdVLK9bvZmAD0pPy1tLA6ytYiXJMrqGcRLICjitVHc21d7XNP
    huQT9gAt31riN77sEeKq1UGjFRqMaca0Jch7Q18OjRfftvaXRC2pe9/n+8aMAfvFo0oRaM
    qUwRDvTM1sZGpJV1SvsMwPH7YZiYrIy3jmPDWi+C1IQ68OIi6jMdBgiKKfHgaNiJj/tbBa
    SWINvOMlJJ4aDiqycq76+gWb+WI53ZvfEWQaUns1O1aKAjIwclbm5k7SKZGb8o88Wv8/dL
    YHYnyINnrdYXuOg/Q8avcB9RfLiFXKHQ4VpTpdanf9RpmuUA3RQ9o84y5Q6eW653j/iFgx
    Y9D2Q4lrCVya5EUNSVb/Rm0pT9wCIq7a5B5z1U079v1TjJ21a6IXc6luDRazB4UWsjc0wY
    VObC8RXyo0+t9Fhtubf/1vaFSxYygqJCjDPzY6jyInFSUBgHhHluUa5R/fKQ
X-ME-Proxy: <xmx:KHcAa1T1XgktwIa-Tt4Gc8Hy5_jyh6MH64-wvU71wYPpy4ygJnmG5g>
    <xmx:KHcAa4MiifyXCGJ5xPs4Bre2OXCUpcZEomoCtI_2duUbxdeLBa6QCA>
    <xmx:KHcAa6axv3RI1zkBh9tth38W3SwULjTquMl0-0tIHrueceEabaDCGQ>
    <xmx:KHcAayzbLDCO2Optl0chpR9TU1Qmy4zThcA8nhgrnBzEaSbJFaAP2w>
    <xmx:KHcAa7vFAfMnxotiY5PKAXEAyp4fTZYnr-Cp5r15C60oFmR22q41y7RC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 11:36:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: Dirk Gouders <dirk@gouders.net>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <CAHWeT-ZXEXvxn2Zf=mt1tvjLxMvPzgeiMUvC1Ani5mcLbEvFGQ@mail.gmail.com>
	(Andy Koppe's message of "Fri, 20 Nov 2026 10:16:16 +0000")
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-1-3f2aaec15d31@gouders.net>
	<CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
	<ghbj7k1mg5.fsf@gouders.net>
	<CAHWeT-ZXEXvxn2Zf=mt1tvjLxMvPzgeiMUvC1Ani5mcLbEvFGQ@mail.gmail.com>
Date: Fri, 20 Nov 2026 08:36:54 -0800
Message-ID: <xmqqld6nsbmh.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Callers could already sidestep the length check by passing SIZE_MAX, and
> the number of consumed bytes is returned, so I don't think that's needed.

I like the simplicity of the approach.  Thanks.
