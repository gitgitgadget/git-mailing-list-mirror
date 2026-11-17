Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946064;
	b=b3mTDAtt0Gw+HzGJgjNGnSzvU/Au8DZRWZSw3M5k7JAu7LeFds79uy53sH+Z7JfI2H/8
	 mf7ojFBVv/JA3h6cKXgRygaoPc3zGInERYCOIRgZpwljQ/VO1+DPa60aLoBatkOXz4x6r
	 iFr0oV8bw7v1ScE3/GBBdfeiDGBS8ZqWPQIjHRSXi4S/WOdu/iJSp1E2fVT3tFyv+xis1
	 XEMu/JyjNdX9V7E2vEzOntrlIN8z3foUlPbQPeT7GDu2OAmEsqwyN6tGBkgjbCMQ9JrJL
	 jK+QjVUrwkpnB00H7Hj1r2460JxDfme+Vm/EYElWGk9IaHHuiT028ii5XsNbsl5LuxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946064;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=t0OhnQrd7Lefe5toIq8jThIdrvhpkGUkQButXqTdCnY=;
	b=WIsujlN8QLsX37UtiT6SNC+7AYmfsJmgcx3Lu1sXs2YcB+aPVciltaD/5yJi5VnfNkDy
	 ag0RQPLqnqxcXsidEZ4Pt86dkfGAkmCdCqacobf0aUnSuwVz0MTFAOqziUVXZ6GVg1nQi
	 mWDJaMRP8LfXsAoEp9rDv3EWNRtzJwmT5kvhUn0trhXEKtX/7fUfQJ3Xag8OEXQUgAEkV
	 cXEzrMsfILNfOdjjlTpITnsASQehK9IYBOR8My9YMQ/Spf6lbfc5dbTubI0lzDVywiW0s
	 4ivzAg/uv0wODQA7rPv+cji8cNFlIs5Ym9tdPkqPr/r05CZqpD21SikOWaftGsnckgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="EW/yV+LK";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=thdypOMV;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05D606A32A
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 20:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB05D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EW/yV+LK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=thdypOMV
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0EFBE1D0025C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:07:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 17 Nov 2026 15:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794946062; x=1795032462; bh=t0OhnQrd7L
	efe5toIq8jThIdrvhpkGUkQButXqTdCnY=; b=EW/yV+LKq2u3xRoBTX2WHb9F0B
	hV1/PXYMzV1BYW9AuebzxJh+UR+VEBS5cyvWA2zBonqWuVqqKMTFbgoxsz9cG3EW
	35ENr18em8Qk1pATLBRFo93qcb7WNsbATwvFYblWQmIwy4utaMyHR4E2wJvRhDJY
	nfv00XzD+CpvM6l8Dt4NWSftQfm6uW3zUblsqO1Z6e5bPYmwfr/WggWESthxnJ8E
	TDy6zitlDsNsMieanKH/wB7nQETBclOiUw3MaEx1OWAAQr6BmhRMwehGH/I+ID0T
	ntALTSLseUIZWJ7mdVLwDKu47cK7QfN8g10+HHt4CxnCGGaU6ORFHSDX5vWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794946062; x=1795032462; bh=t0OhnQrd7Lefe5toIq8jThIdrvhpkGUkQBu
	tXqTdCnY=; b=thdypOMV7AmLvsZCTGEmbzw4e0ZnU9B/5CFnr6iduETqgI7qjO4
	xwPB+PT+/+dk90ajastRsmBQucqB5n88qDHVvhzp1V1/qsvHSKUgaTEeiJrjOeNs
	o73JAQIx0jX1ooNFMoI/vpcUmVw1fHfuY5ST7QmiX1CHn28cJG6hK2W2aVuhg6fj
	cV/IDGy4O2NxtT22/xqX71ypOFgXzDruEtUZZ1lojKDpXTE0IUYpxuXJEbDpx/3F
	pqx9oL/NLggVXSeEf4mg3SbSjVpitb9vZhPtEiBXTCfaOupUk2GxvyeXGr3rUj/2
	YhGk3PSWyVVtVad0ug0IGoTTRxxI3UYr3oQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794946062; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bdW8duGCEH6u+6mxvDnLCAIxFw+LH7pJcG9fulvnDxcsTQg
	gyvRFKJ2UZKg36cG0qe0KSILOVMV2v+WeiqVFvXp78Iw40LF2okZ4+8i/UMNGGHL
	kWiND/uBLAHrkP5HleWdFeLpjGtcmPJmXsXo9NzV3ahnR0L9Na2cKPGnXemfgZG4
	5/33zK4DV4YMacbEJEpUxn9AUT1p51GFgfWQybV6/kG80U/KrOzXmVwRxu2hbzIa
	bit55EHAGEfYnaNMLtEbXZ4mIhGINzzCahVnBnwCO1cFTJP33XUHGHz/SnRWmqMU
	EZ1xU9U6Wk1gohXvcBX/ptLi0nRAUG5vMIAnibw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Vtlss0eT9Wafk56Ae9Ql/ABBnb+RtyvB+El1CPsIdQI=:7IM8sKdiKMWO2hZVm71/mpfVo2jnKrVK0fS1X69+DgE=;
X-ME-Sender: <xms:DrT8aiGIUtDPrQPtgsXZF8eOMH33Q8dLyzXLhlw6e0VUtq_Wpe2gDQ>
    <xme:DrT8aqyTr6fcqP8XUrwHoYbCF1zGW1JuLLRbqWjWzPwZAYMktlfQb74HZnVvdJ5Y5
    s2J_lwAHeWcHUqlWfX-lw9ptDAgYDdiW9NMnCF-2pyXdXAUY7g_3Dc>
X-ME-Received: <xmr:DrT8aphwfKN85AQWHoe6kjRR4kSAOf3ka7oYMQGIdb4RrTHnMMvjmGqtxqCdwamKPAJGSsifEpk0QUCjyJyyz3kaPNs64lHY2UD3>
X-ME-Proxy-Cause: dmFkZTFa9zdL3WfIUulGILKygTQaPdT3Z3HKIgaXnfqt9O+Y5aW/Zr+jOu3EzB/vc61+iJ
    X/mGFGr8+51WCvqOlm1svuqHA7f2FoeWavQ7nXHRyHMd/qyVQcssjviABa6eS/9/owiJlC
    IS0FHPnEUAep5cacBoDJJbZUQvYb8MfFbZQe3/g6L3H9oi0GubkNckoUMumx1c6ObHzdyx
    DTZDSEfynGf3P/mYpn6Hi5+5JpyCBZAoOf2ZLReZI9Su8VpKjIklPhhEIk1N6m4bmZE9+0
    q07fRS+QluDzL7WMdXVu3LjzVkf1V5RHlAeFoWfwegdamZZq5j0kVj0OianxKFvuCjdzKb
    CwTf2M96RUAUPPm046FBjoSpLV4w3ETuDkeYJDmrDYZiZg1WwiD26uu2lO59r//WB/waJE
    DVgJJiRw8BZT+greuFALCgl1y7cpMrboqIO2GghcvDSr2a6htg/rkOsjGZ9SSQL4IGQCEV
    HLmp67dFkH7Lyr5Ej3jQlVW5H78AISc6d4RD2jaqkzVMP3Syn6CMmIn0qrxNEnHEeWfIxP
    RzFpBGGS228AQ4sQP5vNRsnawyxXptM8JGXVQ3BSb6EFU4r/cncu95wd8JQNXOcMHLACk+
    MBOkttureus6Uo0KSyp8y4AhHTcqU2jcjgkudrhqtrg9YWD1KAgMJg8bfYEw
X-ME-Proxy: <xmx:DrT8alwED-4LDqej0_TaTN9aBgMs5i0NA_T1wSfiIJVWbUNnF-IC9g>
    <xmx:DrT8asL-gBFttsnu4jGNL8xHUfy3tPjuSawU_CIsAmL5zOi5yQgzYQ>
    <xmx:DrT8asRFOHo0Vw7AFY4D1jr18fTPoUNTTMi_CduZgPeYFzEO3EUFDw>
    <xmx:DrT8akrWJk_UlD0x4k1sh2tRsLgVMfiwjy4CLC1WfT3kV6ZgETHCfg>
    <xmx:DrT8akIBrPk-DGfQhs7kz9WcyDs9wAAs3JbuW1sMlwpWNbjpXsQY1uJ->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 15:07:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #06)
In-Reply-To: <87a4n7jti0.fsf@collabora.com> (Adrian Ratiu's message of "Tue,
	17 Nov 2026 18:46:31 +0200")
References: <xmqq5wxwolja.fsf@gitster.g> <87a4n7jti0.fsf@collabora.com>
Date: Tue, 17 Nov 2026 12:07:41 -0800
Message-ID: <xmqqmrr7cjci.fsf@gitster.g>
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

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hi,
>
> On Mon, 16 Nov 2026, Junio C Hamano <gitster@pobox.com> wrote:
> <snip>
>> [New Topics]
>>
>> * ar/ls-remote-show-object-format (2026-11-12) 1 commit
>>  - ls-remote: add --show-object-format
>>
>>  'git ls-remote' has been taught a new '--show-object-format' option
>>  to output the hash algorithm learned from the remote during the
>>  handshake, helping to identify the object format of empty
>>  repositories.
>>
>>  Will merge to 'next'?
>>  cf. <ava7178U9hXzPy1Y@pks.im>
>>  cf. <xmqqfqx5kjoq.fsf@gitster.g>
>>  source: <20261112085205.452463-1-adrian.ratiu@collabora.com>
>
> I think this is ready for next if nobody has objections.

Thanks.  I have an automation set up to turn "Will merge to 'next'?"
into "Will merge to 'next'." after some hours of inactivity ;-)
