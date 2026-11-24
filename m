Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542846;
	b=EwY7fIGx0OfdN4d1RtVDXMOreTrsCaNiYEkHVe2boJI3qoZosB0ULV0nRBOMzDHNfYtT
	 zUdF8rSKS5SCUxGNmFigfiG9CPD4SGZ7IsoD23DB4z1G84WdjO20mBSXwN6NI3M79b4XW
	 PpREB8yI2iyE8sSsCQCXWBs6uFwoiklpyg7vF1z0gsib7M7ORNrzgvxWy3Qb5zVkHv2jL
	 hjAnNohFm8vES6S/CEaEOvJDSZOe2oCHxIWTIuAiMYPnvaofCOAYzdsZoYytNucJKRF70
	 hmou62RYiEMEG81TIerQ721ISRAOYJce3twacUMIRsfJYg3TfekisOmfE3GJlyYVavQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542846;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=oOh76JiXFHCnsWXPTOci4fqXwY3FNVYM4I8kqvaSojM=;
	b=v62B8NuWZ6Crz8DCHyitXnXZC74Xf8qDnwGoOCp3s9geAP8FLLEFglMvccB4DF6X1uiu
	 hyJJO2MwamBalHttbel58UrmCWGpKWMuWz41GQ0PqadVCu9AfTnflJHialGGzgUbCmY15
	 nWAVcXbFnTOcU2crpUytDWUp5ClPMrIlkQvtXCFe14vccAbmP0sQ1HGW2NU5ITCm0g7z3
	 Ur7h8f9kHpjpAIie3I6XlAfMwgYDsu7D565ZIN6dNN3rI22bKGwbxf7K+9e4l43k5Ow/Q
	 N34FBdk6SDUw5fe4gqx/ShEZiIp5gAB7z91KYcSs5jlGrTwteTj+WgF1jCTdRRB5lsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dC8OZdbv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V3xM2hjE;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3812606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3812606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=dC8OZdbv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V3xM2hjE
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F2497EC081A
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 12:54:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 12:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795542844; x=1795629244; bh=oOh76JiXFH
	CnsWXPTOci4fqXwY3FNVYM4I8kqvaSojM=; b=dC8OZdbvlq8H4Weq//eVeMw4pw
	mSlqGQFOudtYTrws71ImD7lbGt6ho2ylu8akzjYjKS17S1CwWXbM1aAblw+6ZJ6X
	Mh0zrNZZcO1IAtxDZ6sWy1D3pgE9Yhr64RCEDM9uV+8OjU5dBrgZUx4+Mmhp1VeP
	j32VLVLt5ectXHu6UwqZ+2tg6dErKx86Q+xfiF3mjTqb7H2ITqpYRqZLUNgqildm
	bv/P7HYU0wOV2epGOXRweGTWR8bflvMJE02YVF4685m9G+Ke0xBW0zt+WfaG1wQM
	2DYuLLKCV/YH+Ltpokluiu3v2EZalc1OqnnfOZ7004Pn+i1uc/led0miSOyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795542844; x=1795629244; bh=oOh76JiXFHCnsWXPTOci4fqXwY3FNVYM4I8
	kqvaSojM=; b=V3xM2hjEjmx+pr5T6IiO9lYKHAd+DKg0avSJ3CEU8OqW2VcdrGQ
	U4lsYpGDwGmMMPmmq3QfZoRIobDjZGHJ2ND+no7d4t3OTA1nsfNf4WNtGoMNrxrI
	c3B94KAN6NDAMEro+ko1rGbWnLdPjqawq+guNyKI5y1lC6NySLsvGcHFzJdCVUVg
	YZebpq9XgZ+Sz7tWWMsC62U8ionX9jnmgN4b0n7cwJp1nGtb7MlEle4nhvltXDPR
	ZRwJnHnc5mmxTjMBhHxQW4aiN/xbUBqMYEZCzCpVIuXBdZFQDoKrBJniuCtKjbZp
	IRM5rHIkXsUNEgS2SML/Eo0MGvMnUihOr9A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795542844; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fZbGMlA/BjHXAsMkGmLeF1eNbxN1R1U+thmVczQAKKgB9pk
	aXpk1TeT0dyQefOgAlhjC0q6Gnh2It7BlAyOmEmF0OtmiXnl1rnKllAc4PdBidgo
	r678kPFgkmWlsVOYRiOlLvrOxSc8J6QNJXupx20Yb+UQi3b5yyW+WHjLl9CWXdlY
	nJyVOgaGIff8T08UWGTJiHHn1q+qAzbELZqDs4zct71bpw3Pe/sSh7wxu54qNkae
	K3Ru5b1me6lsN4NYtZuB9NxTZESYyAuvi43gEBwDZVOME1ACfSsPcNRcRJI2iT5p
	DXIpOu3zXkFMOn1ciGRiSMgoxTYiSpbLjeZCAZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:/hysO+NwA7V5mSp27wQpd7WLZ7CjcDefolUywjewtsk=:oQvYe6oIJlAeDKuhSAZS17c7RB/0Vhj4puN/vYKLSUQ=;
X-ME-Sender: <xms:PM8Fazq7u03SAaF5sRY2YXJCObHumgBuxl_pshmtIn_QrT7aoSIB_A>
    <xme:PM8Fa8vOBTcMaLiJRt0NmU5oap3EIRIsz1OGDJ_5qBaMUzreLl2GauQqXgI_16rSk
    lalmlS3Zz0ICeXtlz937ccIGW69PPPSjemNj_6gefhdK2yvIsikXq4>
X-ME-Received: <xmr:PM8Fa2Ys9OV4TGzqj1tTJktcFT2TxVkpLFSUwDPVz-pa0gnl0yeJqcspgJ0HYiPMf5549mNgYAG9ttKq_HyxmgQ6psBOKG0V9PtuJeU>
X-ME-Proxy-Cause: dmFkZTG2ZMQ2VVPFH8XQWIJusR4r6LvlknRVhQXLa8bTUpb2C1Qzd+2fK9qKtZsc67/ZZO
    PLH99neoVLbz2D40Ir+Ei10yrW5mRYdDs6txFb2uZ29q5qLh+QGQF1hhS3atPqtoz0xewp
    x1MJb3akChrCkdW4CBkgVlM5doVF6IiqCbGCAWDZPYkeCIum2Jtp3IVXeuqPnbpAer/+N+
    34Xu2xAN3MNcYtTTDbRbNXifFuqMrE7s+Aib9bmeSMMgDM00oW6pyFGAF37ZpqxAJY/Fsj
    AspeYbUQSjyDw9M6Yi62liaVkrnybWVcuAhInfnnHfGX5/ib7iIhLCNBjRc0ogt3IcLTK2
    H/cKZ6bprGbB5ggVQl78xif6QtFOA3dOdx28xLMYs8XEspJhFd5eNMvVPoQCV+kP17JcfT
    ara5m5G4vzpsxyQ0yrCFgyaDl3Yq34v29d3yXp4ubbp66bbsMOmDOGeEYmDkzmwFhKC6QM
    xZqyQk5+Nsey/EcwWzaPuzuN7U8ABhytdhRKc9UEnSvdluvMhWxeLzyfckGnz6CfwSoH6m
    qWMFnsGQV6UPx2wU7OHRZOO4nWzA+YtCg0u+NPiBygNZedzYSaafpiwz2nnEv8RSEoxS7v
    MEul9IFPXifez2b5aUXRBkm13T/IFsmzaB9sx1/itW7uVk+hZOIcaRuqkedA
X-ME-Proxy: <xmx:PM8Fazapyx_pwbmECDVjRaTbyl2pORbqN_239e-8CTA1EJio9iCFxQ>
    <xmx:PM8Fa3kexH0nNvj7Av9kvh6Si_kFbMA4xvdnBo3r0Q21gYb4unf2uw>
    <xmx:PM8Fa22tJabyAdQ0xZ9Oxf4QXuXlWz2F65RkP_H5kdFAf1zDZGaUMg>
    <xmx:PM8Fa_0VGoE1oho9p5sx1O_Bci8oFFTXwcKC7iRGG8RhQiAhSqV1zw>
    <xmx:PM8Fa03pWwvqj3JvM6bZ51PE6EUMcUqK5SFF7Ows9hQxHi9gdmAwb089>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 12:54:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Harald Nordgren <haraldnordgren@gmail.com>,
  Simon Richter <Simon.Richter@hogyros.de>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
In-Reply-To: <38cc1dec532ff56a2d3de5ea85f80077823bbb19.1795472027.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Mon, 23 Nov 2026
	22:13:43 +0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
	<38cc1dec532ff56a2d3de5ea85f80077823bbb19.1795472027.git.gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 09:54:02 -0800
Message-ID: <xmqqfqwqt8sl.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `fwrite_sha1_file()` function tracks the number of bytes written via
> an `int` variable, but the total size to write is of type `size_t`. When
> the HTTP response body exceeds INT_MAX (~2GB), this causes an overflow
> and a heap under-read, then writes that data to the local object file.
>
> The hash check afterward would reject the corrupt object (so no bad data
> enters the object store), but the under-read itself could leak adjacent
> heap contents to the temporary file. In practice this is unlikely
> because curl delivers data in small chunks (typically 16KB per callback
> invocation), so in practice, the total size is far below INT_MAX in a
> single call. However, the function interface accepts arbitrary sizes,
> and the accumulation across the loop means that the `int` variable grows
> across calls within a single invocation, not across callbacks.

The second paragraph also repeats "In practice ... so in practice".

I had to read the two paragraphs a few times to convince myself that
they are not delivering contradictory messages.  In fwrite_sha1_file(),
'posn' is a local variable reset to 0 on every invocation, so a
multi-gigabyte HTTP response body delivered in normal chunks will never
overflow 'posn'.  Only a single invocation whose eltsize * nmemb is
larger than INT_MAX would overflow it, as the second paragraph notes.

Perhaps shorten the thing (while removing the repetition) along the
lines of something like...

    The fwrite_sha1_file() function tracks the number of bytes written
    during a single invocation in an int variable ('posn'), even though
    the buffer length size = eltsize * nmemb has type size_t.  If a
    caller or callback ever passed more than INT_MAX bytes in a single
    call, 'posn' could overflow and wrap negative, causing (char *)ptr +
    posn to under-read the buffer.  While curl delivers data in small
    chunks in practice, matching the variable type to 'size' avoids the
    defect.

perhaps?

> diff --git a/http.c b/http.c
> index d79678d01f..2879eb3874 100644
> --- a/http.c
> +++ b/http.c
> @@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
>  {
>  	unsigned char expn[4096];
>  	size_t size = eltsize * nmemb;
> -	int posn = 0;
> +	size_t posn = 0;
>  	struct http_object_request *freq = data;
>  	struct active_request_slot *slot = freq->slot;

And of course, this single line change itself is good.

xwrite() clamps per-call I/O to MAX_IO_SIZE, and posn/eltsize division
avoids signed-to-unsigned promotion on the value this function returns.

Looking good.

