Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007740;
	b=FakFYowLEIaLRhNaFDWf2CK+Vu81TRJX8uxZyXmABJrVubmf2rMSyjE7sOb4/fsSit4n
	 EByNISeyanH3IBz0xB+MyMbpgtN2h8MQNKkvERXX1YLOUPKYh1g4Ch+24FXxfzf2crEwB
	 aVkIUcJJkXSILDdteRLd9sETzT8Re0lIpvZuJjFsg95JJtBfX02tNa9U+WyGWCzHueaH+
	 Lz+A7JKDQWAKNCd4vxRhqLBoaxzFMBW+x3cszDKluc0WOmTWlXqmDbSK14go3pw+DPPWt
	 mAL5U8JZLFGV8ov7heVL0rA36nRUGsLYiwTHHyiStdjMztXxpQlIZWfOCyj2hChyK7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007740;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Mq6cNaTmrnMnCyyeuyObEaDBm3m2nns+CxvE6hahNRM=;
	b=oyPblsGWuJj94kILQ0WFQWPaCyGqrc3jRD4E5VJjBEaKfIcBs5unYcD+wDtxQakJT9gY
	 28vSCPc9jE2uzvAb6K070Onuqmaj6Cn0WiwszQaWbIsB7u5hDt5zILSKc3dPaKEj/3aqF
	 vBnAbRMRfRx7oUNOFQPW4CeWMayt0/JarxBTnaijkp82AcY2ZCIi4YO0OKaGn2fZC81ak
	 lx1+Y0RNRaIW9+Oh7d+cL5TOsCWCdSqLEihgbbus+hB/sPaxckfMTl931YWFLjdTb+z7y
	 kr3b63E+PgPAttZkCTmeMhbU4uycenXyh/CqgR7oLhT15SsusAkHXBQhTnn/jj3Pesg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vLY6ryY1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g+dkUqjE;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E486606A32E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E486606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vLY6ryY1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=g+dkUqjE
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 727FF7A01E8
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:42:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 05:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793007739; x=1793094139; bh=Mq6cNaTmrn
	MnCyyeuyObEaDBm3m2nns+CxvE6hahNRM=; b=vLY6ryY1lyyl/FvPcp/IIMDPPf
	wlRLQvVvztCB2/eJdUOu3/DYtLPybPzSfpUtFrKuD6W2lLKr0j2PaRlvcNwjpTfw
	pSZ+hqRLKm2GbKJQHqBOQxpW396fErHJXhY1o5r4+xrr0ti7honzlbGIopnF+ERl
	v6GPfs5R2m+iMD02YJu9Yg/5woZpb5mINaLUHT6DG4g0NeK3hIzYm00dfJqofHU9
	h+cLy0zqeiWc33KInaz3Z+ZogcuTXzEHWKkInpB2CzhdiJEfG/wuWQqHUhT1gj7s
	QSEmRgH4gEudbx/aC0Q4hcyTK4nxkaUpjQosOsWxPeJw5+NbRI59egGxW90A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793007739; x=1793094139; bh=Mq6cNaTmrnMnCyyeuyObEaDBm3m2nns+Cxv
	E6hahNRM=; b=g+dkUqjEVWk5WsWjjTyx4giqltYe4pH5uf4AdG86na6GCs2wsym
	sswauiEhnmStsDmxIldzcuAksdZx0purLIqsl64UilNTnZ2dyKBGSQPV2LDJrGea
	7oppBYPVZjO/XXxpb7NN7eIjENLy5Wq1OrInxm2Uo1w5QfWgnKqvHefDS7dZzmUO
	KQM5HUecFXxSxXcTaq9m8XxcAfsZpMLsmaqTW0a+4LLCd/mtJ/3Heea1nz3gtmUG
	nNsWEYflOTZMfi5h3qIzw1/6wzTsM8PXEQGj5patVegSmE0iIKjbcLU+ijBDr46Q
	XzW/hqV9GTmQ44y4X90c2KkAXsI7t/IrANg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793007739; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:r6XF/G3s/L1i4tlFs8vLF5HC81//hV3FdLbU8y3ZbR8KUgG
	UWo6X4dz+eTOF10LqBy+Igb3svEcR/KAfrZ9/mxEf8gAYQLum5BUYwRVK10cDMVF
	EXddDgK8oogvZ9ZPJcO1FKwVniUIlRAybDkWo6wJehs8DdCK913dY8Y9BPyrn+TT
	9uZjB5itnru/fKFKHmkx4EZkm25b4Hj0mfddxs5LhWdU++qJHQRzui2tQOOwRhm4
	q7oq1Gg5ODmBZfcHSb1Wqowfl4mebgZ+gfULcBrndzJSCPFN679iIHfsjR0sdVv2
	sHbHgg/eNyDO1XP5SVe57aiPApmY076FFXMSmMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iIv5JeePbvYj6y3144NmNf80Qb14YxUPhcFHYXJCsM0=:ZEOnlIO1YMDxpBrpGdQqMtKoelhJP8pbQFtCh885iZw=;
X-ME-Sender: <xms:eiDfarKB525OfwX6pk7qFxx0Ybexd5GG1gKXd59YffMQl84ab-njZQ>
    <xme:eiDfamkcAtWm21cC5I6Y5fgZpy7Xx3JR_BB8tnUoMczZFGxwd2dL5euP32_IBVL0-
    5VYHigBymL5kJ322sRDp_hTSwSTae68ArZnIKRJFSlV0l2X7Dm00A>
X-ME-Received: <xmr:eiDfahF3tgqVYJ46cEPeF-ELwb5a9LEcKqbpiD0URb1dYS_L8D2SXA>
X-ME-Proxy-Cause: dmFkZTGE4mRmZQm5og3Qg5YD2zgJ7LHRGSPprc9yKL/63GJqN9VVTGdvvjs/aa440tDpHz
    n99vKX33mY66EGQkqEvzT3iRd0kOSU9Z3+KR+ZqhE5D/NY6vEULguoiq+Sm+Mjb9IVZ/eQ
    epDWWPjcY18IJ0uH34h4VeaCh1gj0zntBxyW/Y2rFEZfb4RK16iS48AUGMRFI3/mLnOo3F
    +dxJo9J/ySo30eZl3a8FG6RanLH+5HOl3bdNhKhYaSa7H6d5xdWNLhy9A/YVwrnx1rK2b0
    BBOGFMoPLBGEmFCkGCl8V0WqkHBinHYOQnWZcNtMcefRRsygMcuj7vDLCIkQdAqSV+1DKn
    fDwb7yozokisMeIVsYDp4Xs6z+jvPwh9W3Zv/69tRigEeFoO+dgwR7O8FKBr90pcUSQTto
    cSztHCHVbtQTAOseKvnNo2WPQJby6GYlEwicxEmGhpM8xMOasx4y/i4jVGTHvj9kdYq4RM
    Bd8Dz74LLY5y5Yvn0p706ZGANSf8IXf6UBRoolvPquEK49LmBYpbXDe0kopEywu+qrb7vO
    +WKSrhoFbSvFLVaAboXLt++TF5SsD8jbuTqOtoC0cfRmLWzUD2qIaADM5ylgTCziTm/Pgr
    y+XtihYhqY2MATxJW3S78+PnwsY/latfcdhrq8mzdouIIGtW6QebEISuj0DA
X-ME-Proxy: <xmx:eiDfauF7IOkzJHwLHbXe7vzXNNzmbpM4EQ6Uq47avF5qSN_GWEewnQ>
    <xmx:eiDfamNg7i1ybQ8iYDSPRYv3_eXKDm_D0_ODP7td45Qnu2MBR46BYA>
    <xmx:eiDfalF97XgHrt8TcasKkoPFe0LH0a5jYUWjBliY7V-8Ws3uapxZhQ>
    <xmx:eiDfalMrNA5pGsmAieiBYAE5kM13ElcybdAase2-QLTutusueQch1Q>
    <xmx:eyDfakDTvx29DxWTtrb5CPtAoYCaOK_nH4mEd0wDPG-6m2GWgFNb1PtE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 05:42:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5c5a0b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 09:42:16 +0000 (UTC)
Date: Mon, 26 Oct 2026 10:42:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 1/4] imap-send: wait for the tunnel command to finish
Message-ID: <at8gbEmbW8b5cDjo@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
 <0f446c3c12aa5963259fed2617da51c31b992321.1792652185.git.gitgitgadget@gmail.com>
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
In-Reply-To: <0f446c3c12aa5963259fed2617da51c31b992321.1792652185.git.gitgitgadget@gmail.com>

On Thu, Oct 22, 2026 at 06:56:22AM +0000, Harald Nordgren via GitGitGadget wrote:
> diff --git a/imap-send.c b/imap-send.c
> index bf1d2cf74d..fa326c4ae2 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -118,6 +118,7 @@ struct imap {
>  	/* command queue */
>  	int nexttag, num_in_progress, literal_pending;
>  	struct imap_cmd *in_progress, **in_progress_append;
> +	struct child_process tunnel;
>  	struct imap_buffer buf; /* this is BIG, so put it last */
>  };
>  
> @@ -858,6 +859,8 @@ static void imap_close_server(struct imap_store *ictx)
>  		imap_exec(ictx, NULL, "LOGOUT");
>  		socket_shutdown(&imap->buf.sock);
>  	}
> +	if (ictx->cfg->tunnel)
> +		finish_command(&imap->tunnel);

Hmm, okay. Do we _know_ that `ictx->cfg->tunnel` is always properly
initialized in case we call `imap_close_server()`? Or are there error
paths where it might not be initialized yet? If the latter I think we
might see weird behaviour here as the function does not seem to be safe
when called on an uninitialized command.

Maybe we should make `imap->tunnel` an allocated pointer instead so that
we know to only finish it when allocated and initialized?

> @@ -1163,19 +1166,20 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
>  	/* open connection to IMAP server */
>  
>  	if (srvc->tunnel) {
> -		struct child_process tunnel = CHILD_PROCESS_INIT;
> +		struct child_process *tunnel = &imap->tunnel;

Nit: I would have avoided this local variable, it doesn't help us anyway
to shrink the diff.

Patrick
