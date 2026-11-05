Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892649;
	b=yzVn6KhwYPntdzUoK4s2ojCgyuwNvSP0wuoXDMrLP1f9FVVrra3FzbD+66fEQKCOizmZ
	 CbtkeQh9SBmXR21Tx+m8C4rXKlBuofrnM39SZViTNdracgtgyTIlmN5LMGcL6S8BDnmba
	 WV8JPuSpkiaawM5Tv/HilBA26DU+5Pd3fCLoh/3zlFCs9gKHAtsfcC06AJRLLkVAMxbtv
	 McnWor9LupUuLmnon+uJLAJiggaTHigf13km1yNpwys12RPYOsdrTcjQdEH8VF6Nu1nVh
	 tc9FaHJGxg47aNfEKvIbxMA9sP5kWIa0oEPU9ZY8/q2VYerykGuJepzX3ydLVX8HPUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892649;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5ZsJuP5sfDCnkr6ajnplbk8ZYHisbcFEM32DrXLea/4=;
	b=tEF/FoSi5m0E+j5VgRHThPfIFU+PTCmTKZ6POGps4uUjTa4vsplXJk0VwmFfeNZuojLM
	 e9ADXvOki8K3bmMO1dRdpoA92c2/V3SO8SnlerL7bHIfzrx4B55NdFLzJZ0b+cXhGErsN
	 bV2pwYjcyEPppv+MfNbK4z5BCYSEC/ApEm/Zj+4vJwqKuGHAZEkrEEHmvMBd+pRlDeGd9
	 ZPa/Lf++wFp93y8KBIjROu7e34WKCuSdh0KCKYaZDeAkma4En3nyB/ts87PTtE3c6Tsfx
	 NPR1mLgS40h1FtCmbr2949OLbe5aO7c8/fV1jEGYpeGB8TV8ZrOapk/qI9l1yYsiYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=I5n7X2bt;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hT2sGm4J;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240BF606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=I5n7X2bt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hT2sGm4J
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4373214000EE
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:30:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793892648; x=1793979048; bh=5ZsJuP5sfD
	Cnkr6ajnplbk8ZYHisbcFEM32DrXLea/4=; b=I5n7X2bt9OcxGmo0QSmx/XeTOf
	qBY8GWfh++5j3rv/yXvpZmtYp3IDNlsIgzvJlqcJjNsbcxYNjgOyB3IufcBfdIXz
	ib65Mrh9Z4LCyL+Fadfh/HhjMVb71soFNk2BpgeOMklSafWLGj0QflWBE4xZMInN
	oXPmyhL9NrtIOxn88d4si/Gkg9QR4ipoh/pHUw/h/p+fslA9vYbGg5T0o4Eumuey
	g7xcf5yg0BwYq7jZPCZvsOakdbjg0S40p3G2cR4GYo6Ci1P3hFITTZDqUg3l1VDC
	NhAxcPzD/stn/3w6sWVblYjTD+OzS4HBtpYbChBf4rwZKpf3oRq4h28XYcDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793892648; x=1793979048; bh=5ZsJuP5sfDCnkr6ajnplbk8ZYHisbcFEM32
	DrXLea/4=; b=hT2sGm4JtLk5mFJzYi9tt4/dKaZPQ3IAC+hpF4gcEYw5IMH9HNP
	izFOjr4Ryh8VcViBpAmY0hqymQU1Slv3OSGIZpoOuHOym0KncRchICmvbjHTQWa/
	g49VShf3i4Yc7DUprmdemmEvTkBcbVQaDEoOZrmZByq8Q10sOD0Z7j+N05L0FjXU
	D8XmYneEjrex09BTk+mIAUuwn8KOchJX3kXgCtSlp1UpToT3wg+OQKJujVk+aUp4
	xhJTUahmQwwCPvbWqntS8lU/AKZsmIQ344flOd5PrNRx7ad5G7v0kUqEKYPkaLuI
	Tew4uWyBMcX20M8xWW5pPCGokMlL0wmFFpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793892648; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:vhmTGsDMwoKOIO1chiwjo9R5Dfs++89e1alvfRNbsYBN5d3
	MB32E4t8pjAXO/lsY+x79LD0/dxmTownC8GpRDmx9FvFD/vs1hd0UxKvQ1whI2u0
	OHY8+VTj+jbfwpfrkvDwifEJi/qIjn1mSJA6Ng3u6Rd9Cp9d9nY0MzRTYl6ui3kv
	JN6hyCQzNyFIFlTaZHTDgyMECdOTX/e78O5Dxj8gDIYLfu1SaBh0sKZaE/wVJePP
	dJdTwKjIzthLZnVfC2kVBfPYmKZow3pG3X/qc9phVnGGc1kpaijQJNuSMfzQDXL7
	JDjOu7Uy3o/Y7pupCKw1HNcMOvXvUS9F+QB4cmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vhkS2R/jnKB8fDzl6RXZQQ/ahpo13elHVaGmGaWuSh0=:5ZsJuP5sfDCnkr6ajnplbk8ZYHisbcFEM32DrXLea/4=;
X-ME-Sender: <xms:KKHsanYpG65DYIfZI-pEzRQaF7V0_hWpjK5lHoqx2jf8i77cPu1Yjw>
    <xme:KKHsasZKLO5HMraM9IDXei6gtxCafM62svsGNpm7PXuaMcXvSKfM6rODCe50TkDEs
    kxv7NSM3RK5FMcY2aV6V5hq-M53hs1LD1xjERH_ZV9rnmVYoc6xzj4>
X-ME-Received: <xmr:KKHsanmw2gq6ThdYyyOFsjomYQspdHUlhL8XHWQHPfso8klsnv1qog>
X-ME-Proxy-Cause: dmFkZTGC4e0U3AKZwkNsyL6gpgfU7wiHJIxySTlJ51huPsK7dSTJgWs16sHVXTjDs7r+5I
    t6dmwjVlPReKMurP3LiUsw2pUxG04QMClKW1gKYU5li5lulVkdemYlg5k/TGU9ZNe7goFr
    AdT9LSHm6vKfRoP8g/AXhGYJaT9BVdYjpPJoLGaGSdDANrz1oWuo9Jsr/VLWbyt0pAZJAN
    n1C934b7TbGUcXZki48jwUTp7BFPIjJ3EhRlW7HmtM2q1uLvXhTG7n7KI6To4H8foGQBig
    3o2xULOc6+OqsGN7JH6PmhzdxO3k97kiGG0X8gV/1nvp/8Cs3GUFOIRjET60HQhXMpeAaO
    iGIZZL0Q/QrKoHFRAHGd5Bgg/tSmHfg+9SJBR5o0LqAsA6OdjJvjcaJfCP9L2FgCoTcNRu
    nLObd8t16EUpXDUYtpcZ0CDrm3h5XZ28UuubJyw6FZy56d1Eg81fCRhDMfkrtinR+Rn3tG
    aptit9o12M1QE5U31l7Vpx81q9JhimlsuSGDX0sZrcLCTf+pK+n/n/U0Oliqm0VejziqOH
    DdfDSg0i4xknVYR7dGNnDVQXfafG0hZGcgoxuJI0GvcTruw72GyM8qiLMW7VnUlpAwngk7
    iQ8nNUpU34krRqPpap0riRtYTrKnp1pqNK7rze0K9kbH9K4JZTAE2xnoFn/Q
X-ME-Proxy: <xmx:KKHsaowiEN9qWNexU_rpjCy9OBqa9Pzc_JsgqpHAxL0DY_qxVlFq8g>
    <xmx:KKHsalP7vqNfitcDU_-HzTIAueFaiTfwkI9ZSmxfGQVFes-lLopimQ>
    <xmx:KKHsasR_OZZLBI39OFoLHlOTW5SvY35ecCPV4S4Uj1NaGZHjDACJYg>
    <xmx:KKHsajYxijsVC0RUWFanok8l_i9NR2yTcgTtdml3wy1r5GUYbTA6OQ>
    <xmx:KKHsatJL1XdwwSe7KlTQn1-o61M4kI85oSdQkSzCMq78yYbUxSxKdMmu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 10:30:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 207100aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Nov 2026 15:30:45 +0000 (UTC)
Date: Thu, 5 Nov 2026 16:30:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
Message-ID: <auyhIvMHLomMQrPm@pks.im>
References: <20261103212410.1389988-1-jltobler@gmail.com>
 <20261103212410.1389988-3-jltobler@gmail.com>
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
In-Reply-To: <20261103212410.1389988-3-jltobler@gmail.com>

On Tue, Nov 03, 2026 at 03:24:10PM -0600, Justin Tobler wrote:
> When git-index-pack(1) exits abnormally after reporting the packfile
> name, `odb_transaction_files_write_pack()` records an error message in
> `err_msg` but still returns success. Current callers ultimately discard
> the return value, so this does not cause any issues at present, but the
> return value should still reflect the failure.

Is this a theoretical concern or does git-index-pack(1) perform any
important steps after reporting the packfile name? I think we should of
course respect errors in either case, but I wonder whether this is a bug
fix or whether it's a simple cleanup.

Patrick
