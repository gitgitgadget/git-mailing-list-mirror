Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956396;
	b=jucFIXOZShvCPLcrO039433zraQCUf6PYq2i4Y/jAUa2hZ34S0C+wbOuhofMjO0CfRYf
	 z8eqg/g7ygpHn3ST6iXR3PE6ZlAQljx5PdvU2jj02Rj5w0ceovP1d64kHL9840qTL19nS
	 anh48/HtEWZizXB2MW/BG9AlWQlMnoagzN39HV6ebGSauEDDSTDOXwVaJSzqipZWRs5k6
	 XjSr7HPrmQxLUVuf5oyem+Cv4Y23QCmDEsKzIWfxBmXvXaR76JISjJqfwzy1LwjhnsIMp
	 2PldXi6gyr9BXUnGWCeeXIlDWBrmiH2Z2yLa5IHfckmFQGuIbyKx8zPNcLo3S0y/80Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956396;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=70z1AsvujYxt0NitpX5X0SiXthDvFOmEsAnlJhF6+cw=;
	b=folBCYpWD8sz4wr98d5MCnwNpYRKOLgo9Wa4KPAWa6cNGXLSkfWL9BxNrHhHIDBC9Mfb
	 PY7prUQcCsSONosmY3Im15KPWGN1ApX6eaFbywwjMYvX1ya855NR5xbph4TOhyZC7Ln27
	 gcvc3DRJg4uBQHYjiG3t5NztA66BaL4DCz/hTktMyS3x3T2fxnTO9/s4OSl1W4+hRyjmB
	 CRGZz60tr507PW+Y/nv7b8fL9U+1aCAUttvt1CeX/54a+JGymqLO+LnHbriK3sRKJE0sD
	 ktTuM4wKLUMMTkCFfsLLc4g4l9zrwpXgd3ArJ9wprXT53kK6WKKSvUp83a8reseUl6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="gFwS5/Hu";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o0EJGaEC;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D18606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gFwS5/Hu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=o0EJGaEC
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EA731D002A3
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:59:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Nov 2026 17:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794956395; x=1795042795; bh=70z1AsvujY
	xt0NitpX5X0SiXthDvFOmEsAnlJhF6+cw=; b=gFwS5/HuUtHamZC9a3Mw6BtXSa
	TXCVO0e3V4cKkkECZn/cXmIiw3uh7+NyF28D8MjOZgy7a2UA6PMJlNQyADnHqdh/
	ZOYSBvct7o1St/vd2MwJJqclIp3dO3HHjr6sOH9WgAV5vJcmBhZoj2lXwtuBkuQl
	Mr4L2A7mqwMSNknAu4bGZn7m6m0mIogrx/LkacVqlMjfyBtn3tKqP0QPCNEW1dNm
	HOJjpE5rZsNxe1tPoQBflix8brnr6RIVBKO5bocexgyJ0gaFdNiZ/Yo7azd32rHS
	zrH7p0EHk8q7Bz8YY1iX/sSucBiZV2hCRxkQGce6H5SYxPSesacdgABv1MEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794956395; x=1795042795; bh=70z1AsvujYxt0NitpX5X0SiXthDvFOmEsAn
	lJhF6+cw=; b=o0EJGaECvtuRetOsdcE9T00k2XuBOhVLSed/pHKPYK2kSPuDdht
	RQBCFj8HRsdVy/TQiTj4A1mdAnXkQSI+6UMVn+CSam4bf1Of8Cp0EFHxPMFG/o0Z
	wgym7GfrFFzRaMpCyYwgaGxwc20/p4oSJArSuNvV/Istg/5vCsu5lr6Qs8CyDmFG
	ABVtOziPWF6yiTeS8TKwDCM+3HdYNCEc28uEQOc9qM71oB9c08JPanWUYoHL7A+g
	PNWGTvT62XNH4Nl46u64WnzyoozJ6vc01/0t60EdSM/A1WLlc27Qr08WeH+Sz/Vb
	EKTcLa4ECZaMQCA6LfTSTSu+6BpFLFCEcyg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794956395; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mD5n4euXgXpgNPNc7PFQUKLFYsne1N4cmVTmqvzT1RQGOra
	jmw7xooil6rEHmiqEFvBQNx/kJQzMcSKfk9AH1Lg7z25JqzsC1hKT2BcwunG3ZYQ
	IQ5LzjgVYMJZ2IkSaEwQEYbCq4GSKxCWu+2aF/sE6/5o/SCKxlvdPU16cbRiNjNa
	86RJwinm7+lnxDcuG1yTahuPxmUxaTP49DDPexOIcD9cWnjPUO+02lgejBNdZ9C4
	LXvkpEUJ5rXdNYiiPVDlMnVebCQBFQXgGue8COX7vr1XoFD0TrTfs06wEB0c8cOf
	5h/j+hsYKZP3k8M9Jy+Yj0qBG4cYUkxACzdF/7w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:TouFEZk83i9VnuINxnkV3xQl/SjbdzegycwQnIP2rWI=:B7WAfh+aoyIh4qPAjO1uQJaN4NNzy7EzjOLxdiiwu3U=;
X-ME-Sender: <xms:a9z8apT22eM0SprrrGfDy1jq2JF0g_42HTf_bntmQu-pSPHsfzlalQ>
    <xme:a9z8aprb85q4_MmvyuWGF7E9reCcN_1X0pko6Szu04HWIsRG4zLWBqQCiHhq28TgZ
    DVvHBwwr-lFI8nXo_K_2r8b0ibmvEYtxycBRkpKl1I30CoEQ4gjmXv9>
X-ME-Received: <xmr:a9z8anJvK7Lpe1lqtinTkzGazTv9EwlbBOrNQFObKb6WMRJde0CPN3EmIfXrcQp2xx1mAxWIojnFiG2VMoQ76H9E51ynT-zLfDTd>
X-ME-Proxy-Cause: dmFkZTFJhOg33cWZ9syACh1F0U9k8SG8qQu/ENe0wKqzBTS9g80wGnqWkw+pjkTRhmfPtk
    zNne/wFgkWK4BfCdG7wVRcBrkmVB8+TVsSBgbyw+ue05bMGh1WYvunxyDG0GdXFyGx3kku
    OVcnS8WtybF+espC+TGE1S+FhDhlErSYALuWs/AlgbTYmNb6hES0L8iNxTHybV9ZoAyDhn
    mvq4EMhIjj4woMlxhuO9OGF83urzKtF3JJ4hLYyPphXMiqraMqyYAlfh9mjIQ0eCKzEn7A
    HIIdKS99CHqMXK7mCU4PUJKsz5CtGTSiSRl62Hy5Gu77b6IUdAmDCIxJMMhkCb5NKNSQhz
    SgsVUa02kyNMBD1aN7LjItGsId/ZRqsMjNpK+NQb/OpQ4jrtZVr+v4HOL9voW7VpMVKpdZ
    FTqFRSXqeUEY9N3At3jN8Tbuw0kCSLMDQDe/AiijJEw7EySFnSDotosvWKC5fpa5smTfNM
    /5a5LLviiHq88/kF9xkberOsXqjFXABFvWzkSwpFfxYIPJqhgAhjD+9xJKAZ1rPRACEQWH
    MKF4dAZo18xw8ynq1KxcmQMWN/PQuFWUqK0uFtTkb5d/DUMWAJsvD5qxMOWmDeBE36SVnx
    VZyo4aI7LHLBnycQPhhJ5PxbMU8An0ZsMLxGxSLL4bvyWrxBnEwZajNvQMgQ
X-ME-Proxy: <xmx:a9z8asoJWAGRgQrZtUlaA4SijgwnxFAEiN-qRcPxw8S-nodU0i715A>
    <xmx:a9z8avxjlRIFQu-A-ToKUjO9i0c_E0fwezrDuDXj5pr6uniKwxw3kQ>
    <xmx:a9z8agNUvNmeAoLCwtsC-E6rFEj5FfT6s77tuItkS7rMCyIzq8-l8A>
    <xmx:a9z8ak6_p0syE9fDJnzJpT5QTnKHhqw51cPRwC0PdkHmMsdK63t7ag>
    <xmx:a9z8avRtuU3GL25BxVrE-8S5VkcPYzvpyn6m7uNx8YAppoQ88uBEgnBI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 17:59:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 4/5] cat-file: use size_t for the length passed to
 batch_write()
In-Reply-To: <5b61a1b08997d4d642e795ccb366e45f911bd982.1794914210.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 12:38:57 +0100")
References: <cover.1793355390.git.gitter.spiros@gmail.com>
	<cover.1794914210.git.gitter.spiros@gmail.com>
	<5b61a1b08997d4d642e795ccb366e45f911bd982.1794914210.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 14:59:53 -0800
Message-ID: <xmqqo6bnawt2.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> batch_write() takes the length of the data as an "int", but its callers
> pass the size of whole objects as returned by odb_read_object() or
> filter_object(), which is a size_t.
> ...
> Both fwrite() and write_or_die() take a size_t already, so just change
> the parameter type.

Well analyzed but somehow I find the proposed log message a tad too
verbose.  I am almost tempted to say that the above 5-6 lines
suffice.

> -static void batch_write(struct batch_options *opt, const void *data, int len)
> +static void batch_write(struct batch_options *opt, const void *data, size_t len)
>  {
>  	if (opt->buffer_output) {
>  		if (fwrite(data, 1, len, stdout) != len)

The change is trivially correct.  Thanks.
