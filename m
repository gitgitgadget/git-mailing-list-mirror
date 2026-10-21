Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565376;
	b=ALGojnXo/pj8kdqUi9yN1CXGRGd7OqA5nhMm5JRtu24hhGP01nZ+AVGHvC2nUaoplVxD
	 9C2XdU6AXtak5KaFOO+F1tdM+zdhdyyGZ6JXc+nM1DNAiaXuWdadWk4xkF0AsT2ywNMuM
	 vVpnaStJU/bgY8x1W+2V9YBR/XCOGVsFBF3+oRFNVrksCMPPoRl/OBJwsIGWvWv2bn8H7
	 8Y9xcYOQUC8QU5yLvJ0c+twLE09Y8AnisIiajUq3pZ8qDi/D0KOMLybQTp8tpgKS/8m9G
	 0djd+5I9LpNN/NO3gKv9pkYZ8NwzsSwYH0fyxqUaIsEEL97WQUdMMxROyYOGzsvRBsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565376;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BbUEF0tJTLTcAnc8B+rETOehiZYCDamUrh0poromYG4=;
	b=wUEL/l2U5nImxhpCqf7S84vWbaRzbBeeQM2icvFdCkTUlEYBC4c/zDGLOgRqwIbgYPfk
	 tZLExd7Bpqj0GLCxJNorvA9C1qHU0Ky46okimDSkzDOXMxBQ0Wgfq4Cvqxmk/tpHJpq/n
	 1gugcW9E9uY/2GZI9YlobWuge51vaf1QQhvQya0xQ9PkhXDiveoBtWQUMn1PevG2r4DFF
	 czAFOsssZCD5xN6wcB+w+huhV7ccB9eQ1sSvLnjZyZw5zaaIo3yKImEYI2qc7jCJDO5ub
	 zGMDEeSGLhaa9Wy6/a2+64t21DaVi62luL69k3UHq2Wt7kmo/GIF+6JO+97WlQa+jBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vIZbimtA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M5NnwZOr;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71C606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE71C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vIZbimtA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=M5NnwZOr
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0BC9A7A00FB
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 02:49:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Oct 2026 02:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792565373; x=1792651773; bh=BbUEF0tJTL
	TcAnc8B+rETOehiZYCDamUrh0poromYG4=; b=vIZbimtAf5uxPCMHAWA9nEabVv
	Dx8jifII7RZj85cZBzIRNzYiKKbJeA/qCgZKplLL3fGptaL04AicgezZ1hFOPO7r
	wHE8JvFQcxZYceHxYJTYBcY9SS9Zbx3srFgWybN4cBT/6UTuIwgiDAV89ana9Wkh
	EaacYtx26vPLtaJgvjhoqveeAYzTxYChrj3ZvvFxnA8oVzx1045PhzQdLpCtCgNe
	IaBb3KNfCkfGuqCkAPcrvLfJfgLNKyNSVGhqYj7ImM8SiQY9SHMeeQR1SaE8vBDb
	o0GpiJZf5z4oigDteZ15Yau3jU3SeJiAJ+zzeG51D/7eLlpb2SNFaPj15fyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792565373; x=1792651773; bh=BbUEF0tJTLTcAnc8B+rETOehiZYCDamUrh0
	poromYG4=; b=M5NnwZOrm/ahRvLmdYgvtKo2TLxAvFVlBmJvkvYgytpx8tb3CL7
	FnrucdDUijZ/6rVMFsRc5Ylu9b0RstlxXcqbvIpu4vR68V5iAVBDixsbG/tTM3I7
	QAiiwTU87PGjEEn5Se4oxG+GvcEd25LqsmjyJFpUiOsIXWDw0G6rp5RmW5JyVjV/
	MNdGw2XRPJZgx1S8tD0ky6ATdjD0ykkwpaKE9lGerZBMuGTJalQjegL8TUBkNw7Z
	mR6kLHbcnAuP2emLOCR2z+C90Jrldicqbr6MpQvd7F0mUcZDl1whRKp8T7B/gcAU
	yoeQMgsc/EnrvT1yLnd8mgKp94soqLOUzsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792565373; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AAbvZ38HdKIEx/dVhP904fYvjzJ9FcrvoUPh3WqHFy6AjJ8
	7OgMZT7X9kN9QIpetaTWTmvUq8FSRw2uyNO7l83dP3knOA0QtP+h7/9T2bGccAcT
	exWQrWb+dALkzyIG9S6wpIpFQxyA5KAc+jFmb5XTtCuzNCIX+qa7hf62J5PI9hds
	ayPjmvPrdjm43rfWVC3alqif3Hbb6uACpu5GDfKZObOGT/HpGZN00Z6xxq/RImrQ
	mPAJJfByOBWSyPMiruXPzMJeaRc6v4VkZJ5frVX6cc15IQQot0ms/M1FT4perR2K
	OJMkYZHjwJsGwv/cM8zckwpO/DPrW6voNvKpj0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OKqawFCGCAulsVB8QD5uqHY6pmCWG1FX+O3Q42RtUmg=:z2ggqY1COtocoA6ZHrbWiHnx+elt7RqL+IWOqCTR9LM=;
X-ME-Sender: <xms:fWDYapUjHQn6QbXwlaKdiE8k7He6Y74EK2Gj0hhFEEKPnSldiZ1vYA>
    <xme:fWDYahwVLtUdmSQou0enHF4ObzT781FTuwwFosPhGwgkbc2aE2XJUUtFG8tnLC91l
    L7vGNHvBxbCgNbC1ibqJTJ0l4Mqu6CCuVRdMi9LwnBOJTBCcVggrUw>
X-ME-Received: <xmr:fWDYag_n4HKzuq2DTejN7w7FszS1IfNFMo6qv6W-xYYo1KpEmGZf8w>
X-ME-Proxy-Cause: dmFkZTF/SVjbVlUOFKM2uc1L9xgYIX55gV99TvPeKGvFhxQs9z0czBmY8dBH7aYeDFLUjq
    RsYSGtYmI4piVTqo0luEhZR8q2IjykcrrR4ng25QGZslf0falNCCNE/y9M5DM6Csl5TO3P
    wzqHM6sPc5V2kv7lRurTvCl6J9CCkZwu19BjHBvx5E26TaQNuq1D4wOIUMHvkLvrfXCGiD
    RiKJJMDF2Qh0z2y12KoC6h7gwMSJ/CWWac8ni8+/AD3P5AYM8/zh57F7lGRahNf6aTOvUb
    GK83l7Eqa4E5P9Kvhpu+sW/V/iWl/w1lbTXleYsxbSgN6OdCCLKnw/g5agN5vJ8aAd5tWp
    iXfjfU3CU0GKXR88Nm8WKew5nBBsIPyO6jE3zgm7L60B2Oz3y4vXZaIMoQ50lJq+TCOaZu
    SCK+sOTg64aYssxc22YjEX0ZMO1emO+k2FP4YjXA2bQH0HSYvKxWwzc0IspH1gb1d5+oXP
    q94DOSp0KzSbksJuoc+4icClqpym+Ua9z7XWLmhQuVYDQA3buGrMgvconuccsvIP//6gw3
    YfVjwcl02XRw9dafUKI3+mqItqwr8ipwGaogs9dB3D+Hvw/RjmMrDutuPMvPKM1jrO+bnp
    szZ+LXOKVBaS1+4KDgVHu+dJUkg2ouZhQ9o3ZqzCyadiyP1XqkegyA/z9ItQ
X-ME-Proxy: <xmx:fWDYam9hpl_XINbg92JMt-Uyr17k5jh3vahO1KTF3oa5M9SqLFLuFg>
    <xmx:fWDYavV5A0GlUx7o6egstgZ6fh9Dk_9KJK-5J-0gm0kcvHwQ2oSNdQ>
    <xmx:fWDYajfezahKVT-x6JZIRNnmlajBMc1yOTOJQPypACJLsxqgw_R5sw>
    <xmx:fWDYaoYizDFj1DXwH08EpgomLRL0y90hwL3KSTQf3oNAzIpp2AEniA>
    <xmx:fWDYauiZ6DiH4dJKAsHavVM8MBajBnSjviHmWujVo2w3R57Qp9qDkdgM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 02:49:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc19c4e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 06:49:30 +0000 (UTC)
Date: Wed, 21 Oct 2026 08:49:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: Re: [PATCH] negotiator/skipping.c: parse parents before queueing
Message-ID: <athgd6Ya12zRdIR_@pks.im>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
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
In-Reply-To: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>

On Mon, Oct 19, 2026 at 03:17:07PM -0500, Taylor Blau wrote:
> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> index db90fa77b53..ed6e88b59b4 100644
> --- a/negotiator/skipping.c
> +++ b/negotiator/skipping.c
> @@ -151,6 +151,9 @@ static int push_parent(struct data *data, struct entry *entry,
>  parent_found:
>  		;
>  	} else {
> +		/* Parse the parent before using its date to order the queue. */
> +		if (repo_parse_commit(the_repository, to_push))
> +			return 0;
>  		parent_entry = rev_list_push(data, to_push, 0);
>  	}

Why do you parse the commit in `push_parent()` instead of parsing it in
`rev_list_push()`? The latter would also cover the other two callsites
that call it, and to me it's not clear why they wouldn't want to parse
the commits before adding it to the queue.

Doing so in `rev_list_push()` would also bring it in line with the
default negotiator.

There's also another call to `repo_parse_commit()` in `get_rev()`. Once
we start parsing the commit in `rev_list_push()` we could drop that call
as we'd know that every commit in the queue is parsed already.

> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
> index 96e224168eb..7a0b9b32474 100755
> --- a/t/t5552-skipping-fetch-negotiator.sh
> +++ b/t/t5552-skipping-fetch-negotiator.sh
> @@ -223,4 +223,37 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
>  	have_sent b2.c1 b2.c0
>  '
>  
> +test_expect_success 'recent ancestors are sent before old ref tips' '
> +	rm -rf server client trace &&
> +	git init server &&
> +	test_tick=2000000000 &&
> +	test_commit -C server --no-tag base &&
> +	test_commit -C server --no-tag parent &&
> +	test_commit -C server --no-tag main &&
> +	git clone server client &&
> +	test_commit -C server --no-tag to_fetch &&
> +
> +	git -C client checkout -b topic &&
> +	test_commit -C client --no-tag topic &&
> +
> +	# These old tips have known dates, but the recent parent has no ref.
> +	# Without parsing parents before queueing them, its date is zero and
> +	# all of these tips are sent first, delaying it past the first batch.
> +	for i in $(test_seq 32)
> +	do
> +		old=$(echo "old $i" |
> +			GIT_AUTHOR_DATE="1000000000 +0000" \
> +			GIT_COMMITTER_DATE="1000000000 +0000" \
> +			git -C client commit-tree HEAD^{tree}) &&
> +		git -C client update-ref refs/heads/old-$i "$old" || return 1
> +	done &&
> +
> +	test_config -C client fetch.negotiationalgorithm skipping &&
> +	trace_fetch client origin &&
> +	git -C client rev-parse HEAD HEAD~2 >expect &&
> +	sed -n "s/.*fetch> have //p" trace >haves &&
> +	sed -n "1,2p" haves >actual &&

Nit: `head -n2 haves >actual`

Thanks!

Patrick
