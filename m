Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794879474;
	b=SQkaPHdrmAZnzMe7yM4nde1yuJU2ioLGnJ6H5pO5w1wMKJxOnCYPUWKQj3tNVN0FNdOY
	 +I4VUzG07tGTUY1q/41ECxflHAPvb586/DmQn4x0Fpo6fzJJfTDI2lTFYEVBsH3LfEOt9
	 qp/HVYhQTHbuN1ECI2gOgk0HJ2hdDLbB63ND9gO3oNjW7984k2r2gBpHRhrMUM17VIs++
	 IN0PqiAOay3YFYacYuTlEWykac58nK2waGOUwzAVTTMlGaCi1IcVO7tBfd+GalpFsF9kX
	 9LNh/Sbq+YNQZnaTM0jSBxbZTDYpF2ExVK06sll+TsdcywoFxqne5hXn1iYobXSmFEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794879474;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hu1mudkBfvzAdG+BOle4EbXjlfPch3aHb9sA7ziW1Oo=;
	b=xDBqMY3XYkC+zql6di4lO6iwEuEdpFilw4uqQSJeEIty6O78M2xcBDiPzmmUCzppj148
	 gfqygniqTJtM2SaLVjR8mnI3/fnN20sIsSUsn2IY26D7EIBeMVPoOpWZETQ5TGnUYdiIF
	 N6l/Fk2SwX43A8xa8TKrRiUelzwmbgHPhWeFobOgnhhv+9YFjVmIS9MnrJsWWoeXVH1fZ
	 s/SShIFqnTJgqdctZgN0Bhg38QGdSCZHbrNHI2eYK2mhIQR3n0yuS1cVcR5xoKBFaAdEQ
	 6qt8QOTfJn9JBuWGZEN8MKWUzDGuD5Z9NCTTmWNRF1Mc9ec3epVgy/K73OnkrO/bbgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P7f+9snb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nvEE2hKS;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25671606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 01:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25671606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P7f+9snb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nvEE2hKS
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A9D1E1D001BD
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 20:37:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 20:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794879473; x=1794965873; bh=hu1mudkBfv
	zAdG+BOle4EbXjlfPch3aHb9sA7ziW1Oo=; b=P7f+9snb2wQqLgkHZOFK3yJp3a
	DBHJMrYzl0Qj+1rZydeHnJg1M6yYNmA86+k7jJjqiflYcL8WqoyY8+0RmQHurGqP
	44nu63ROtPY2k5eNwwt+mjlHYrkJYzx47V+rOQqgF0w9z16jIEXNwlZddz6hn/oE
	m+Gr3zOj274/iLl/vh2uwSfkFcY22pQhzwP1ec29RUeK3cOW+GqT/KLzvPJLOoA0
	pChpU8KiQXU89ZaArO6R6OuCv1i3JkdoCzS9TlsPUuGZ84YQhEt06etzOlGV4XXQ
	NY6CCFDpFr+Ig50BnBf2+yY8P1amyKLGurmb5cmwJp2oA6Dc9hp+pBlsXCGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794879473; x=1794965873; bh=hu1mudkBfvzAdG+BOle4EbXjlfPch3aHb9s
	A7ziW1Oo=; b=nvEE2hKS9V5cYIfGnYUF7ce8fnJGrp1tpCkyF9X6F81vm2NLdff
	um7aRq4rK/drNSaDOYJhdVcQlEuqqvPDRn3wngWK1biz6f2d4vKlBnSTZWoSoBno
	Xa7WpRCa68M9lqwtfQIz/KlQyI8cbaVaY1LyTvOxdKwz9GWTBsMrRDyWKr6duj3l
	IFPYBdJBDj/AvpBVzPQy2ZIqCR+ae2/TMO9NNEgKxjJkzkBWCV3IL5i1TcSNOpWU
	G1ayQSyMgvHgvc2Ay2M9QbpSbetejlPpqJTHpC6w3kQAleJF0aTqwBG/D7/t0gp8
	feUq0+lPa0JUMB3b28Ji6/lWdpOUfQLKR5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794879473; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JyIXK2EJpe1/dmGJcB68XMdJIMU2xiaDp58EFEJyfBzVxYV
	As7kZuBk136XjhCVe+TB7vWupjQnZb7yKTbiZeN586hFA8zNqWzyP91EEp2PcxPU
	kCN021KweVoYC5ILLRonSuNsRQ5Bq15/dzllIlwe060PwlXcmrHokjEfxFnAtZ1v
	ZiC2zbjNRpFCup/uV7yS9K6QlvH/Q9nP+R43Rru5+QgslqjP5DVfupq7nsZlgKer
	KdZdNtWFaNPDKXvX94BwGDvK8HjDfdKwaGQ59YkN+7NjW+3rQplmMniIwlaqYG9i
	MpvFqhNrfALQDyJwhl1y71t/hk0xi3BNhinivhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:31NphDC7sg+wWvrOQxRzOhtl0QwbTiBD2fp9WWn1lDA=:BtA2QdQKz32+XBCwVSqRiaI7B5hUYliKiwHFWVCKQZ8=;
X-ME-Sender: <xms:8a_7am16A5xiC6wZlr8a0l8bkQ0JV5ZDq_Ss2Jegna50-Ny2CI5GMQ>
    <xme:8a_7av_0IQu0jG0sEbc53lR4YCPYejPCQxbdVSDE4XdOVSfOG0mVDEi7AM1w993eP
    QYL0N7jtG-2rFnci_ECdKnXb9WvGJKVyt5SKKjKW9NR-YMb5rLaDA>
X-ME-Received: <xmr:8a_7anP9uN8pp0RkpJsmoTL_QuVBpE7S8_sLrD51bNamESlH0cNaKskIngkmSyJckjaXzoVUTV2Z0I8ZGvlATRtY_GqgRhPLK318>
X-ME-Proxy-Cause: dmFkZTEntWp/ETakhqvX+xRhvBca5YAzRNdMp5u9e1cvlFWpkDADpaE6LCeMseL1ys0KVr
    feAzIsv+DTI6gExSjlPspA8iyU1znHw2CWQJvU0E7+ih7MrK/lUKdGDpLBBAVNHl32Qovd
    UvCp5ofsABBN6IOtat/ApZYHZXe/AL69NctpZPMAqze7jD5qXbR4TOWrhzpaLMs12nLpwe
    vDSPDkJJ2fRun5uhmeImFEsuu6Jp/mCkJbDWs2iAhDT/YyREB2Xf/ZgHsKlufSVjtpXPu1
    lMBB7d+9Xc8Kd7OR9AD1xSAVEntfa2ILACRS8PEThOHln/hSCAB120OpoXZBgc67ww3smt
    bypIfTlDooxZazCneWxHV8+FhM5WC9p0me2SohtZw5c+OFSjon8+nTpb03hriXNvRZDyjz
    yJdp7siigiVWr5z4PborNc5TWsqrWtQYWqn3gTHhWHHq7kdTq12x3cEgSyVA4YJeQ3gr4G
    yoK9kRI+BAcL23nYEiGJXNWUf7Xea+lTCqYyPhcSe2Ggl/nYZ77G1htr5YC7wcz/5gA1zA
    WVxhNT/l74KvcTElucj0YdRAciRcv1iKdalXXAU7eUsTmHMd3BMGNWrfeNhBY/Qi6bJBOT
    XtZ9onytGPyxk8L92iIqo/314yWtVBUfPQ6fSQsIAu5Ib0F4u2TbK7GxTJkg
X-ME-Proxy: <xmx:8a_7ajdmHlsTHhxn8c8jc8oOfci2dCQJ7jMEFzv7TmFbjnnaBvBPBQ>
    <xmx:8a_7amWskD3Cdh5HU3JNCg_NKUB7VqsT1mOQaGzKl1wx0usW6EK1nw>
    <xmx:8a_7arh-lLhaEgirE_XCcXn_-Z1kBMbXHMO5OJDNSMCByJH6apel-Q>
    <xmx:8a_7al-M7Ljcy7aOzl4BLPkd-P-27wCJMTUmPIOliTuCe1v2Ca2Ixw>
    <xmx:8a_7aisTT29wK7_PpmPgYmIHiMmigJbb-DLlHr9IN9jGzALwRiwWAP5h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 20:37:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 09/12] builtin/rerere: turn "diff" into a proper
 subcommand
In-Reply-To: <20261111-pks-rerere-subcommands-v4-9-df0c8bf79e16@pks.im>
	(Patrick Steinhardt's message of "Wed, 11 Nov 2026 13:18:45 +0100")
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
	<20261111-pks-rerere-subcommands-v4-9-df0c8bf79e16@pks.im>
Date: Mon, 16 Nov 2026 17:37:51 -0800
Message-ID: <xmqqmrr8grv4.fsf@gitster.g>
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

> +static int cmd_rerere_diff(int argc,
> +			   const char **argv,
> +			   const char *prefix,
> +			   struct repository *repo)
> +{
> +	struct option options[] = {
> +		OPT_END(),
> +	};
> +	struct string_list merge_rr = STRING_LIST_INIT_DUP;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rerere_cache cache;
> +
> +	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
> +	if (argc)
> +		usage(_("too many arguments"));

We will make a mental note that "rerere diff" does not take any
extra arguments.

This matters when we look at the documentation patch later.
