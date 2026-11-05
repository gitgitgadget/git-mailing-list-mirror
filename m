Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892770;
	b=RO97Y3YaQYMAorfqzUBWf/Fs9YlLAPMwUuenhyENrwpG52ev8GbyYW7iAzMWrIOCbZoV
	 jZYLqAM4h0pocfm859CiaGcGg9kmpVItIfnL1gr7bdAmuSWljAo90lLMTe6HDrSLfsAzI
	 Tn58L9rJHbOlwU4yvMi9PduLa6/lu8GC/aBkWJPHGjSTKGD8av7WUkw4fO4iUARLXFtrt
	 72MGigsnj2m6SCwyZfMcNYfFb8OCg/qGQbCTXRfPVzwSN/1NwoZTf1Fpk9hVVu4HQ2wFO
	 rnpBoz95gqPdcAgei7soQi16fj2shxRO7OWCFK8ynhMfWxxbT3Zenn6V2OIcuXJI+5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892770;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=5lLD/W15TgWBgbcTaQOnsIf4jGVmb3NV1ZHBvc00aw8=;
	b=AldHDPsIZiFAvL4cvbwX9fJ6DNmbKMoRn2dX9/F3Qn3hUhjiKGrOgR/7FNqLI+szdm3Q
	 lcTRpm74MMmb6HnGnFhalRtaWwXP7A6Zk3p7N8VQenOdnr5xYz56RxgqTOJ0HHopFg3gZ
	 +gyaGsf0kImDhpfI0Z1Ns4nUIKmeMtQYENylNTuMVq7TbQBtEvYmZlxTBlW3TFSLiCrUo
	 cfgaJC5wm+jFhpzlDlMgVbVFg5xe5LPYO8qBzYS0yN6M+Z2KCewfDcBFhLtCYGqm7garq
	 7/Rbf6Szymt+c0K1Vd5wMpiE5DCrlHNeifeEYll0dlX2a2QhZCcZF95Z+YBVaPL9mZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lpUDSsiX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="vRRBlN/y";
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1592606D80C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1592606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lpUDSsiX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vRRBlN/y
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C4CDEC0616
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:32:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 10:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793892769; x=1793979169; bh=5lLD/W15Tg
	WBgbcTaQOnsIf4jGVmb3NV1ZHBvc00aw8=; b=lpUDSsiXKLMwpHgyrrPil7Hj/F
	d3mOmfzbLRFl6Kd6q9Wwjbtad3XqH9BK22OpbU9XGHIriZ8bXJ8f7dd57yWd9kiN
	K5Q3yOF6THxXQIlAwMqD/OTLqf6Z/lat6yt/WvQrfDNPSpX30tFG8C8spqdNYane
	e3LZ85Ye4sHiGmVkG6pCNkCqs0C6sOtjoTf1xpA0ITs4bcvVQHnUVw59Rq8JTZ2B
	cIaKFIbjhGtu3XUNg8bGRMnV8X6JIe28/nR/k+PrDuD+M+L1lluc6581ZoTavwla
	vMNPHQNkBo2Sb/SIekrPNyENLw06fKExYJ1W3DELbFUPoMgjqBKeEW4l45SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793892769; x=1793979169; bh=5lLD/W15TgWBgbcTaQOnsIf4jGVmb3NV1ZH
	Bvc00aw8=; b=vRRBlN/yeP3eBQzYWUwU/VpIAqfieZpjnkm4Foeo0agv4E27tvK
	RyFeQ91jL5QPUpn7G0gImq5Bwmg6wKlG04zI5AwZrYDLx69MYtmkZW4YDF3bM+Aq
	Id7Mjewiay4PFQwUKltEdTrOGwOnGQArtqxPn0ls5dD/wKVFZ3yoa0olXlTy0Uk2
	NL/fazdiHYgoiXRFfCdwCw8NP+ECFiMz/xEFwn8GmwQLyFX5Fd5s5iDlXiND2jkJ
	jqB4mfsrfoi4NE5kWhd+860trstEKgeB02gH3RG1SBS+Is6sJZq26YvbSuBttTM9
	pPingKiR/jLojaBl5O1NiH9jbvT8TeqQhFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793892769; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J6aml9iUotvA8W2clvXhYpwZs+en+dz84+Vd/9lMBts0Z0W
	a5JL58kyIJ/YzjQkyGNL6rPwdk5U0l5Ec3BqumMe2MylvwHuBO9KjeazNq+6U9DS
	lJA8VDEoGr55AUQnjll/7ZGMs5duQBK5UKMGDRGLvg2/NXuiX9Ni6ZuWDKcSZFCu
	b+VjnBLO0u75b1kMicaMCit2rcJtDUm+GqJpkUMnRi+4GrD69eUjIRD3BjgYdSfT
	mLVccCwzK0i9rwXLMdrpXqNW9SZkGtT+I/tPO9RTGd9tEYd8sp3unAz+4kkcKCtO
	9RbvvbyWovJwphU2PDDbdA5vErlVzATbvNhi+IQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mrQSiAyY3Yy6lVOkdcy59No7f6NEvtaQRHcM6THWxuw=:evGNgA4bb5eGUy1b0ry0bRaEkYE9vR/uI6KWuYolAW4=;
X-ME-Sender: <xms:oaHsavc5DpuO64IJMKqxOHVz2RDss6JqEKrc4_65YzlLfUjeSbgc4w>
    <xme:oaHsanx4iqG1wOglXpG53PZe_GwVPRI4P4YJZ6OROdAAd5OTtZmKW1XAvZyAb6wuT
    dw7tiT68bOe-05NgD7y9JZsD-rukPthK5-hKPsStHmhzPySgSYWvu0>
X-ME-Received: <xmr:oaHsasKJolGlNo-eAYzJZO9NrqlUBVTxn8FiVzPRyNLLNmRe89mFBSiEsvvznFv_INedez_jA9CHT5EFqZsmunLZH8DaHC8MlmZK>
X-ME-Proxy-Cause: dmFkZTF61/i2GGpDCZEH0jOzzS3AwFhcPxKVopP2wSKyEBIzceWawytNk7mbf64kWS4fUk
    esUyF8mniXUXcnObVMIYh+V6PJQyAvPUE4eBLuBhkCTLKGvuiv6WFm5oS/uD0xuQ/YwRlb
    HTVkBqCssqynAyYCuSKtKtQD+ec4TSWIh1sSu54Ofb9d+vpdpzZCOSZ9Xanm3jNRfNrU1I
    XBS1/jqda/rUrQM4X5vgk/RO7gvxTql1mg1I/GvjhWXZ86obHiR/d1guRaRjlPykqen7YB
    MLy3hmQETSfHspml2jFb5JbzpDXW590DpUTevzxMtYeLY/KwjTitvQrW1lZSxr1uOxO9Sg
    0NvICEYJ6ouc/YVhHgEIZRnaTE+DglYnCl91VdA7Xy4B7W5QhTpqX/8jMkSZ/CpJX8SJC0
    zq/fUNKebdct7l98JqpY/4yJMFsAqNnX3CoadwvQQWYxCJwb2Bd75PL9g90kHAYZqRI5Rk
    qe/nAr4I0iBnzNtmk6652foHPZRok06sw6QIu5esz+wddlXGW3UYFhNByUGNcyO8glY2AJ
    rOeVb8hr5X5GRUDBTJBY1P3ql+aKBGoIb2eQd0RFTuVKg6WjoyeI/XSpDVNr2O0x3JYPhC
    wpHlxMuu64G33/XLiLpG/gh3Kankx+Zr1d0uPoz7rPsODsQ7s4r/Q0jGg8Yw
X-ME-Proxy: <xmx:oaHsahGpXRLuP4Su9C0Sy6d5GuYPBxX4n0zBE9rPoCFBE1-vgx9aOg>
    <xmx:oaHsag9y8hKcgeNDY-5oRrzDKbQfpExrA-SbTgWPCe8K7M5vbMbsdA>
    <xmx:oaHsapLAKR0-_XgcX2KsnHPzJ4h5PsbnEe2a5AOV92C-A5o9HXYEWw>
    <xmx:oaHsamsmadlpG_cDOmYweoFJSgtHQGRmf2Z8LitEUOV53vxXPkxGew>
    <xmx:oaHsamrIxCgX32pOv3pKXWxpyKESx6PqQ-4Ug02a1ZoSttwN4ZETD0wf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 10:32:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tanga Joris <tangajoris@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com,
  usmanakinyemi202@gmail.com,  herroyalpriestess@gmail.com
Subject: Re: [Outreachy PATCH v4 1/3] parse-options: answer
 --git-completion-helper before command runs
In-Reply-To: <20261105003914.708836-1-tangajoris@gmail.com> (Tanga Joris's
	message of "Thu, 5 Nov 2026 03:39:11 +0300")
References: <20261029231621.48958-1-tangajoris@gmail.com>
	<20261105003914.708836-1-tangajoris@gmail.com>
Date: Thu, 05 Nov 2026 07:32:47 -0800
Message-ID: <xmqq8q37xpi8.fsf@gitster.g>
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

> diff --git a/parse-options.h b/parse-options.h
> index f68b51ceca..7ad33801fe 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -427,6 +427,12 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  NORETURN void usage_with_options(const char * const *usagestr,
>  				 const struct option *options);
>  
> +/*
> + * If the only argument is -h, --help-all, --git-completion-helper or
> + * --git-completion-helper-all, print the answer and exit. Call this
> + * before the command does any work. Then asking for help or for the
> + * completion list does not wait for input or leave files behind.
> + */

This is a very strange thing to say as a comment for this function.

There is no reason to expect any normal program to "wait for input"
or "leave files behind" unless the program has some strange trait.
What is it?

I think what you want to describe is

 - A program that uses parse_options() early in the program has no
   reason to use this function.

 - If there is a reason why you may have to react to help request
   from the command line before the control hits parse_options(),
   you may want to call this function to react to such a request.


"wait for input" and "leave files behind" are peculiarity that
exists only in fast-import, that is shared with nobody else, no?
The fact that it does not call parse_options() until it gets an
input, and that you want it to react to "-h", is what makes this
function useful in that context.
