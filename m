Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774482;
	b=qyJvDwylcrffiY9auQUMqkCLYFYRKjj5Fv/VSeHbbFlffpvV1zbfQUZbILpvQYKXd6kq
	 D4QBI28a1TcQNctFkA4ChdnEGCbxiVSwycdzAfpwcQq4uFXZ52JHzMWoSkxx8WwHrp6PJ
	 0gc6uaFLnYM6R7nVoDYcAIHVLkdlOCF7LF4HCNnK+WMrh6PCGRxgNNIL0hIH3Wi0VphwE
	 xg63KcbdgjAM+bPhTMvOrHT8cTCbx8enyErZGlYfJXknqc568uwZ6smFWBwAIO52zPrHc
	 BEHWh0TkzuW5Kh2S58b6LRiMz9+XVMwIo4R8OcYEeyIzQSO+3yu2BPOBpcrvxLNTeKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774482;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/qP45UfxjC4ePN7lm9haXiHtkZVXP0A6ny/3szRtf9c=;
	b=FxbaTSPJZ/ailoe5PWpyv30yC3G8tdosqJylQJl7H00rZ89gIWeuPeh9L6apOErFNQCI
	 SZ13lTHMrJ6dFD4XHuA+sTJmtAH4SFmsAosvAWoBLCU0PxO57+z+zwS7yGUBqNM3xnUgl
	 Nk2Ty+oitaGIHMWzpkKoSMj0Yd94rNZxCvuOfcgzzI5aCa8qncQyxFGm0CkLsr1XXeCqN
	 OvT+OmMj90psJnhe2Ctf/ZLEOLFsVeJvsf7faMTM5n5NrZe5qMFJLQIf5i6ELJNT6+iMt
	 qqeqdn9BItoOUMMuTjmZVLXVmpwciU1Mh/0I9wPq9CKHcC/rusyWH3m/oeIYs5iR0+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=qTE6PFGY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KQQ2JKWb;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969E606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 06:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7969E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=qTE6PFGY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KQQ2JKWb
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C6C441D0002A
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 01:41:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 04 Nov 2026 01:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793774481; x=1793860881; bh=/qP45UfxjC
	4ePN7lm9haXiHtkZVXP0A6ny/3szRtf9c=; b=qTE6PFGYX+acD/FKtaQJslNhrY
	suWxmitDGteuDpoPfin5lido0E7Wn0Q+V6iWXEpHLqpWufV0kSyq21HzFGA5nLze
	XtCXJ3k5aStBTZge+C04+6w1B6Kz1CUC4nD/7fRyolSqMfLAA7LULn3hXMyR5XG4
	78ef/PnXc6wsh4LqwzAPKb4L9DZT83wN1oJ0IO6Hkax5StdrHnDJqUwu2LH5j89Q
	2IImNvDZe0IyCZHOihgcBwqEeAXG9ljwLotyczkq1MEQbdmdNES59foo1vXwGoYk
	8M6fdv3srGb4uxEGz3d6y5z3WCXKmegkFrelq3ZUZEzCNLOGacKOm29xt47A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793774481; x=1793860881; bh=/qP45UfxjC4ePN7lm9haXiHtkZVXP0A6ny/
	3szRtf9c=; b=KQQ2JKWbmNJiMkDdSrkOB7sQN4ZGyJ+UlPxt1kxxVsn9gd4YnuN
	R34plZCuQxw2nX7lAKvZplDt4etYYYRJXdfDCdnzM6xyE0jOwzHlirYSbR54oG1K
	dzoLwIFoUD3CX8iabYcq3ezP44blj/L5Z0Ma/EISA/MYI5pv9yDN+SZmckD9PBgS
	TtqhKarQupiq7XtVGV2J54JkSeQmXnCuHFfSsTVqR7YDl10BkAOQ+Nl5hsuqqzBq
	86whdON0llRZSbQKOwCkS7iJaCFCfh0ipLR6FANoY4AmJ+KsrBBUpT1MW04+XN6z
	O7EmW/onCaY7dvD7JN37Px/Z0MP/kCb3/5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793774481; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LofDLn5Zv2Bb+5XWRzQDw3S/vsAplz/I0rCEAmHHQQRQNt2
	k1p2jG6OhktXr4o421FrKIbOg4nwwDualYZvpIBE0adjiG5cGUOq6v7hO/s0jGwn
	un+DaSz1SwLLyc5CRqA10RLywFmHKvWGfPxkxk6N2QeYfCJ654i7p7bO93HeZmsR
	PpBmLUiOLbyKlEfr2eBRyQIJ8H2ACdCNN5PLL39IgAbHFZVxSwy9SLriQpRFfWqz
	5Q7M/A0e68pAzmD0G5J9ISpwGDHHu5I8MfBpI80Q4lw/x4ouymioqIOt1LCSLboR
	hDM0YpmQBNGUb3QlhQaDIt5SXakjKyi2vksB3OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Uz2c4i6sR7BLeyzN3LaDdn4v7jyfPtDHMsFmcZKXVok=:FPn/CM9sfaQRfwtQ8FIzFl6v1gvYN3XDFDXDxfVXB5E=;
X-ME-Sender: <xms:kdPqajdyuYsvFQ3TNUEokDsgTS29gNzLswqeqNppZB9AZ-MPkqY_cw>
    <xme:kdPqavOq2u_vwmOhPEoBFS4PuNIKM5iqIClkOS2AtgWn9xgzZ3RoA1XwORdWmVvS6
    KiWdY0ds9Abds59fEaaPng1iDD7lWrFQP2zgkZpGfRVlwJYfaK0VaM>
X-ME-Received: <xmr:kdPqaqIR_hsXyFH5etWRfgxIz-i4NpaZ_adKYhGFBRZu5BzQ69z98MOkgocWxgMJIHiec7Y>
X-ME-Proxy-Cause: dmFkZTFmuKCFgEpycUpBVh3X8Ke75Wasr7ztHQMcTcR/bClKHAFsTVCN8Dtr2fi7j6AjiR
    PrIY1lEomzWskSyQ9ZUN93okWJxZWwf+g4WsG3ZOrVrZQcl7dYryTzOI0yfzFeV2JEl1Q6
    rpI0boZdPsG2CdmGXsAzGWnKKU9mF4sC6SBNR7U9dGUaNKmCv1EsylrDh4otq33AL7Q3KG
    BnZljW8WOz0um7KvbBlvhz+iyeLTYzWYRQA/8+0vrlCZQArQ/JGu67JpqvSrhE47vbQgQX
    j8/o8EnQ8NXWXezPzLc0RADhOtLCGFtr290NbJHfN6FjuKVlT6OJhb9DqAfYIROcxDTiVB
    REWXOOh9EgqBWG1rCz//AfVKpkNys4Ffr6UlKfA5+L4mCXQheb0dFJSZ/DYAp1nd9VE3NO
    35Tminn7mqMCbDn6FINNvKDqGj+BCBSFH3r28N25F4feZBOoCJyRd4nevn2iCPwzQtY2BU
    lqNjhGQ2QuH+/YUb3Mp1hPbwkKgfdYq1aOCjnPaOqZVVuXAA1UGCEMlyTq25VpT/Hrrsha
    EQy6tQmlUsC2LM/k/6WKc5dRMW4r8ybMLIQ8fr8w5Wr4dVu2Yz+jfaFm2C5CQhOFPa6AZY
    rFgPUIwh5JmIdXRYXkb+1OdiivBAaFjPhMr4qkswiyAI3fbplY0Ee7g/dW7w
X-ME-Proxy: <xmx:kdPqagFXNxT1vWQA9DPcgRxUu43v5U1JdyhEPwCrOxwFB9wmRfFb7Q>
    <xmx:kdPqaiRvbVAwrwcbZz4VMB8nA_DIVrLiW_VFiu05o77T1Grz1t8MAQ>
    <xmx:kdPqasGVOtssSva7XMw5pcoLpJo3fN6HuDAQy0buQhvJ3M3J1h9n7g>
    <xmx:kdPqau_b_UHKzk4RAGBt336Fin0_M3hNaaGC2m4hIEsES6wE2wTdoA>
    <xmx:kdPqau3nnq6gKamHHkCVsAMW3dn8ZJyE74aFtWADgB2JgvUasH4s2p39>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 01:41:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4fb5f60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 06:41:19 +0000 (UTC)
Date: Wed, 4 Nov 2026 07:41:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] ident: remove unused
 author_ident_sufficiently_given()
Message-ID: <aurTjEgKc5yw_vwD@pks.im>
References: <20261030173956.585250-1-gitster@pobox.com>
 <20261030173956.585250-2-gitster@pobox.com>
 <aum2GVDloMarZvwi@pks.im>
 <xmqqtslx7nam.fsf@gitster.g>
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
In-Reply-To: <xmqqtslx7nam.fsf@gitster.g>

On Tue, Nov 03, 2026 at 11:00:33AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Oct 30, 2026 at 10:39:53AM -0700, Junio C Hamano wrote:
> >> A pair of functions {author,committer}_ident_sufficiently_given()
> >> were created to replace user_ident_explicitly_given() in d6991ceedc
> >
> > Nit, not worth a reroll, but isn't it "was created" as it is a singular
> > pair? Might just be me not being a native speaker though.
> 
> Neither am I a native speaker, but "Syntactic vs Notional Agreement"
> is what makes both valid.
> 
> Treating the "pair" as a singular subject is the strictly formal
> choice preferred by most academic and traditional style guides.
> 
> Even though "pair" is grammatically singular, it represents two
> distinct things, and in this particular case, we are retiring one of
> them while keeping the other, treating the "pair" as a separable
> two.

Thanks, today I learned :)

Patrick
