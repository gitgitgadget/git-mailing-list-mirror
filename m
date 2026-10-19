Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440441;
	b=n5Ud8cQyAb6Q3PFOfM0KU5d4mrqEi49dM0zlLEMihxTdCerPVaOsqy7ROWB4zLM/AwOJ
	 dlU56Qe50AXhoCSK4Yvn9eQXnEDl1/Rri6itGydcuLJlx5vAlt9x49JK9V758gS31DNza
	 EslWgPMhU4Lq2kJvtQz3/Gb7NKdF+NLM9FcsP0DUkZ6g/iiGLroZaVMSH/V/8czbhXfmT
	 K/BjHPJ9HRqi+fGoJB5MR1BmEA30hEvrTNV8ggJEH6abMbm+Ny8oM+5OKf54hTZxczLiD
	 FeXot01LPkTndPHAMhu0MCBNkdGTOwrP3mQE8c0YZKqAU935V1kqll5akezlapCm08g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440441;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aUv9854QlDIZucEuYNZijDWpLF8pEZNrN/IlMDaXhRw=;
	b=D3MrKWK/T93tIOE+s1As/Kh76hDBi6AblJpkJdnG1pX8v3cBc1ZZMa+AlHdvHnVWBu3i
	 kHrPQVBmFcynahejcFA7vOpGlAgkyFElf0Sh+JpIyc8uUehtHPMUFPX59cGZoxlIp3HKW
	 A4xPJLAYMyeytwWmfh7Eh3eYU2A2ajPeGWAdddgi3xDi7D8tgFTjcGZWU8ail6mWTaXuo
	 qG23sreMwqV3Sa5z4DLwt2FA1yKZGlHuw1x6jUQ7HvxK1a/kTGNmGD/te2J/hUx10XtH7
	 mRYX4oh1V+wDDoOwzXgtFovrIv6UtNyBJ2yQuASk22x39S/vfQ01g6d0+BO3UElu0lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=LA6E8tOI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="fDYrL9/+";
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F8606A327
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A74F8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=LA6E8tOI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fDYrL9/+
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B3F8CEC00C5
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:07:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 19 Oct 2026 16:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792440439; x=1792526839; bh=aUv9854QlD
	IZucEuYNZijDWpLF8pEZNrN/IlMDaXhRw=; b=LA6E8tOIz2rF1+ZKtHdmYBBxFm
	qZtUHuDZI8c85upQtklCm0jPGR3o5ulh/+qGZh/5nsimGt4z9WbztWBgU9Aqz3+p
	W1VEBo+B0mXJMwFMfO8xaCiR0PxDu4WIsaa99UxG845vc5e7UeB5hM9oxVDqj0aY
	qVj78tzzpmkl3z59IrtCJFyHXxBoQ5LVbDoWASRcv5J7lHVDnwr//rhv+0r3wLxl
	pjyLjho6NDOY4A919IeUQg7SijJI/q6YQOk5+cwAWfQ3BI6K2LPtt4+3bLpaw8oD
	AaoRbZqnYgLIiqdGgrm9XIQbF9sfiz0bmM4sVindCheWTy9s/JP8EJ+cpFdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792440439; x=1792526839; bh=aUv9854QlDIZucEuYNZijDWpLF8pEZNrN/I
	lMDaXhRw=; b=fDYrL9/+nQG+2c3amDIt9sQ6l+1UoN4lggS5TumsOeL5//FGYqB
	zVwVPbeqTDLaaGfsw3UJ2tiTIIj/1WGksH9DTAgD/HD0E435Y7oUgQEqY3n5T8ha
	P7E5nbdasnm3CYdeTS+ISbPsXaJdnokuXjdtG4e2QVbzRkVqzNwpEdfeNnU1o4AM
	CvqBkP3cXD81HW+qbSHz2GetXp5y4nsXW1X7a2gZMizSOTGcaIzMG6s37LJ74lqt
	N3KbrQcU7GO8/jWNjp2DyQ23iFn+ej+/zbjQ41m0vr9Ud+ruT3nj+0UzxEEoXlHX
	S5ixK4kC7i+IV2UYa0Fy4s+mT21w2ibzq/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792440439; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ArzlMgO82lv72qg/ouAkaGqnMwHVDf+u+RN5IhvOv/66rkr
	2ACP1FsULG+n5AMmBUf61mtyW4lbzLLvveBtfApQaIfgWsV7TjA1CenZ2NMR/kIt
	DXvIZjR3DidMvQCbqW0mp0TY3V/uVBnajauGpXIdhF+4FZGMZoGQ2gwxbv6KvxcE
	Ny6LXv9fNjfIuk4ZBquF7nW8+ce5O3/+SkUCEW2L/sSqqZx3K/hAuhv/1b8GQzL+
	HW10//Ty665zOmAVGYtDLpMQzXTM0bdveLi5mkY92vJArWPZmUclnhRbkGbbMohY
	uJWiVaGPtxe/cDAH03rVSsG2GHQbRC1tXp6mxSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/ddPvx0fTkllD2qojA3R1BrXV8w6tGRgxGOrncc8eEM=:FaTLMbHjpSYUkPoJB+pIUoCI0P6k8y8XJU5mr9O/0cM=;
X-ME-Sender: <xms:d3jWaj8PfF2DliWhjVHLxoZvIKE2Dqk2SFXeTlVD0jHFkm5G4h6xqg>
    <xme:d3jWah8cZ_LpgrZ2jMPHkZbqb2_8ny6skqVupINc70IdumciJ2XyulScEPazo2Ka_
    bVNl_RC_q4X4HoJsHyLWLm8CGFcVF3cZNq6mrRpFx8YkIDHWn3HkIk>
X-ME-Received: <xmr:d3jWajSvApP57H9tZZwdLMGaQ1-K3RcSwHF3GQntkjtUkI3FSNfJkFJPEgeKxF_U1bGJgpo5iEjEKfZy32UsKRLG73XU6IJ468JN>
X-ME-Proxy-Cause: dmFkZTFNW4WTk8juohknP+XtV0JcgC4eDsAg+svKEghPWOEaGy56vUpWUxCGAIvUwucgds
    hxdgLvQANX91TihUVSjUO4W9/w7xlVT+c5kOZpwR1ehb/A0CwItA6SPhX2qAVWCExlGOrI
    guEoXTz7zYW3pbzOHl389CfVe8TWM7tPoKWyLc2MS4ZPO3qgEjTcbdZ7CuDtW2PdBY4eTw
    CKY6FcUIitIPJiPIqJLxrchZbsp2M39yJooIbi3+9r3jYauk8TnG3XJw5IdUc7cGjCX0fn
    sZkkSL/PtFrbeCJ+/t/SIoO8YDmafAcbNnbTeRZypYvutWU94+oxMnIzbDvEVSwBS39tTl
    cfM5LqUM1ghRW0zN8WnARBPRUteBV1f47t/0egdssm1+TvWYcWdZuXttt63Nd+hDsiQDiz
    5lYPMMTXlw/jfFEB1xOxexpeDmdrNEUtafwwwdi6Pk7mk13AvmrxJN/7IsjwAQ/dtjbCqW
    LHwebx9XzU6bqxpiMJQbm835D91KqihfOrniWeUeh7xTeCOhthmYb83O+THL9+IxkRre9t
    +Z93k+GsgzC2owgMXQrYQ1wHeX89fhlNMjKYtDKfOF88oraENZ06r8qSlELpWh6oONZfnH
    XMMnFLkTQn/IikcWHdhpKddpLDZ78DXx6NALKqyLOF8S2XqjnUWiUPhsWS8Q
X-ME-Proxy: <xmx:d3jWale_LCyFG2ldS9v9Cu5ZjDiNY_4ifY_Nh77jdeyCcWqKajz2Bw>
    <xmx:d3jWanB23iArUpHCrjv0o0UB6sNdTbqY7AfM1a4GUD8vkiMlofy8Iw>
    <xmx:d3jWanltrn4OrpObpMoISXQo-Y4iRh-ljLLA89E6nkw3kT8zKvbfSw>
    <xmx:d3jWaieuBfStvhlZ8JABh3jEqsjFQNdpS44z7dmu0MbHA03A9lNHSg>
    <xmx:d3jWalBfQuneSiRQdNeg_W_kwxPfToLdSxijHvxb1A_FbRNRfceuzDrM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 16:07:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,  git@vger.kernel.org,
  Jeff King <peff@peff.net>,  Todd Zullinger <tmz@pobox.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 3/8] ci: drop unused "linux-clang" logic
In-Reply-To: <atW1q6fAQBpS1r_7@pks.im> (Patrick Steinhardt's message of "Mon,
	19 Oct 2026 08:16:11 +0200")
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
	<20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
	<e6550ed3-351c-451e-8740-f9f449e98402@gmail.com>
	<atCdWdE74-4K5aWc@pks.im> <xmqq8q3xirru.fsf@gitster.g>
	<atW1q6fAQBpS1r_7@pks.im>
Date: Mon, 19 Oct 2026 13:07:17 -0700
Message-ID: <xmqqmrs94fpm.fsf@gitster.g>
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

>> I would consider resurrecting the no-rust job is in the same spirit
>> as 8/8 to ensure test coverage for reftable by shuffling jobs
>> around.  I do not mind seeing it done separately, but it is not too
>> big an effort to throw it into the feature testbed or linux32 job
>> just to make sure the system builds without rust, and doing so now
>> would mean we won't forget.  And it is only until rust becomes
>> required anyway.
>
> It's not, but I've already got a subsequent patch series anyway where
> I'm following up on some of the related topics that were raised in this
> thread. I've queued the change as part of that follow-up.

Thanks.  Knowing future plans always helps.

