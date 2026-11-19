Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101361;
	b=3h3vlfagrpDbS9dUV/i1YKokqh3kzypqewcfALtbpskuqVyvtFIyrdglvvSLTNM56FmR
	 HqEYciD/tgpjPcWmNNaS2V6HQIewwU1c7ne2u32fH+YxYZniNQoCN017dpvN2wAU4YUgd
	 JufJDaSZij4bUhRA/GBoAu/BGA430JltUOSe2ZpmxFvt8giTEiVj4ksTT1l97RxFg2lXf
	 2pzZyl2mf7hkWX+UBD2+Co8dosyNaa8HIrWxESCFxnKwJPaHT4vYM1eE/wLAG2DkDoHPE
	 zq5cbvCu7NVrKTRmjJVYJAYM6ZRrV47TikJibTbv5M7k2ANR+apvk20iRfC8+3yCZZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101361;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=VJ5W6nCIv/pgy215pNCGyHGzsnWnWiWAe7mXLJf37yg=;
	b=hLY3XViGoCplYOaNCvB+iUC4eMa6Soi3sy7891rE39gYX2pKNUO1bOHLlkk1LMzEfwQT
	 fXHSPFJ7rb0JQ5qL1lVrqVa+TKzaMqOZ0gai/lIbiM7HFdUwDh4jyTrExU5a8o1NYaqKO
	 NSKGfT+8dY8ybrnzSJi8FBMCETlaCXWez/A/+PBW2EmPptz1SE66okdvi8GenESgs1M5L
	 897t0pl/2p7NlrLSatvhno2b+CUJ7Q946nF1gQwJsqtcceSKm8ruSTPC8zr5VUMPIqtRf
	 ffrtUe1NZ+ZqUHOr73/5oTkTostKVMb8nKNOvM4bjQicE3+JJNccOE3CEkiYed+ZB5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=hjCbQK8z;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jQ+wF0mh;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CF606A333
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 953CF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=hjCbQK8z;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jQ+wF0mh
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A8E9F7A02F4
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:15:59 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 19 Nov 2026 10:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795101357;
	 x=1795187757; bh=VJ5W6nCIv/pgy215pNCGyHGzsnWnWiWAe7mXLJf37yg=; b=
	hjCbQK8zMqHJBQLqZgJGpNE+AeXIyyC4DHjqyt2+IhBdub7O71/sEYHZoGIZ91RB
	TQea6YXWGsUsiVMLB8THjdJ4Okp4meRilxUvH1my+tNocT0OadfbFgMVFC9kPYzt
	r84rNFo2te/oPPLiIq6VYDjDk6P8B9dHgNKuoZgduaKkyNg7vBSMQeANB+tTt9wH
	R/jqqK3OImdFJQ9WPZ16ueRaiz+Zxc1jfNlCju5LuXDym11h1u2v0E8F1jUg6Wrw
	2RIKu9Jz2XGXtdoqPhQPX63/HccSqLg0fjpjKzB75nXSNxghUCWrWk/SjO14DcwA
	orsYkRkdJ58FyrvZmL6afQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795101357; x=
	1795187757; bh=VJ5W6nCIv/pgy215pNCGyHGzsnWnWiWAe7mXLJf37yg=; b=j
	Q+wF0mh5/gs1SZh9zIHiq/l3WY82xL19EQoH03gU6bG65i2M3By3vKzADrcObeVC
	33QEfqFQL4S673DFZVX5ECnk2RFcgPt0skKE/LKnqydkg3sO1CYU0B5ztJF0K6iP
	jdk5Sf4T0Qf4FoPz78EtmFf9/paN06iOpzURXFovKY5ARiFSPBWygHA/48kbcBtp
	R9HOPytb5z2lhPxJW9HVYFDiJkj9Xx+NIh6nBtCpkDrd5I7A4yLkOyOYeaIWCVv0
	2lYSolvH+33dHbSqa+x6b1EVINlUonUwqDWXOWHxqS1tR8DcHuRTQ76AGs9TMsbQ
	OJsAjx1Y+dNeSpS8zg7kQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795101357; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:K7155Hbew5GgkkpHJDoaMjh/as+K3nOi9YtpxIzFVf3cNRy
	km+KYyRcH9AgkpDL1ED882H5tj3lMtElYNONzvIJj6QilyRq3i4fv4yYT1KZj94g
	EXNWbB6pfn3I/OM059rN9FzFjlnW2tY4TM75nhyDt+ZmAVXGsoNEMw4p4ycvkZ3s
	qHgtxvgX8wegVig5DuPeO2UVebkNQIRh0LfsUyo2HxJotwthlsfCQyjdnr842/f8
	BO8TzyJKhOdA1txJlOy5v7i5uxiryB0rPhaI0Xg4WGf+HctEsvSlpLr1cKG2s6B6
	7r0B4s8JhnVCzpcO3gUZbDBuXxtixIUwntCXngQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:w33foe2JC7W8sq95n5jzfU9KLuxmNN5wXC/pGYcQm10=:zZ0oy1mOUJ4MhZaGMML+5a22G+qpgKmyLFdrMFWeQig=;
X-ME-Sender: <xms:qxL_atJIKVsnVSYhdR2QrGnT4a9WvON_d24Y_zkNEONlKbQCKrBSc-Q>
    <xme:qxL_aj-BJwHWpuHZ8BXC_XPzS5-3fwVHmQlGV0bWlqSM6RuSY6l7aBHaPWmaxNfWH
    G1FsiaTP7-2OXfTCwaALfvTJOZoLBpxyw1hMcy8KPe904qqcWyp_JY>
X-ME-Proxy-Cause: dmFkZTE/jBEbPFhvG0YnKvA/JJRmrP4R5+OzJ0R8YkvG1NMd+IjLzIoTvtLwyxM9wiBy3R
    eCSq0kSiRuP89kj0dQL5VXxl6x+mGLCPQ82Q6ehjjzNPAaefjya37dk19gb3/Je/tNIO4K
    lI93w0NjvWkFDeHa01SYLnlXtIegBESCzrpMjbIgaD6qZQfqW+iTkrHxQPeaKdkVq33LHM
    YGtvUN8A5nS1ee67b8pGs5Lr/N0VtZ2bYHH05rBhZ6i6GtaT/ze6JL1pl2n5RASfheBINb
    gPJmwpEx4G+vgQKg/FHVPJE5WfJrpset3y4TQHlHXvD9QJiylNc1ERBunYh9y9LcdhhFN8
    xX0F5B+uXDf1C3QVspB91yAIDchdvZtYCjiBZX0QmgvpfXJ0+/34NyGk/eFmIdlJ+fzNbq
    E+ZzNsFptO9hrcsn4zMpHhalHBYhzpUnyxUei4SveqawVd5SNpWNOvlQnqJ5q8oEemqW75
    fIDUW1BDXuZ/fgm0/AAd24/oQEPTwhIWFjKC4upAfGmwuNQ7spLfB8K9rX1Og+sU2uRmu/
    /3YINMlJm7TLEufHtLiiv19JyH2B7Ug70NYHcSY5xJNMwQyd1W6XZsP1cGcH9p+T8FmT6T
    3B0LQikD3Kf5sKVdAQoZIb0s0n5vD4KDA95LXD0fZFoEUU4oWRMxA+zfOrUQ
X-ME-Proxy: <xmx:qxL_ahlUMIMFz85FdNiezTFi7Rrct03vAttgx3Eg04kuweu5feZESg>
    <xmx:qxL_aknI-GQ2LcM4Yp6R0bzSeaBb1iBeRZAEZA_9w20GYy-6X4dpNQ>
    <xmx:qxL_aqtYjN2xJTOQkTO4Ilhlca8ei4wM8NhRmome_cdEIypVje7u1Q>
    <xmx:qxL_avnjoH6tagc5Jq-dNvRb763rV-90g6Kvmep1RYBGHPT-8vvvsA>
    <xmx:rRL_ajAG1V2-_iB2Ucckf9BUrjTnyrXGB9ujPQttB-qFi2n0ZHOGeZXy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1474222C009D; Thu, 19 Nov 2026 10:15:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ARKginnIH2HR
Date: Thu, 19 Nov 2026 16:15:34 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <b0e1d692-0be0-4453-97f2-c6581630b9e9@app.fastmail.com>
In-Reply-To: <xmqq33sy6lgb.fsf@gitster.g>
References: <xmqq33sy6lgb.fsf@gitster.g>
Subject: Re: [PATCH] CodingGuidelines: !! is not all that exotic
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 18, 2026, at 19:31, Junio C Hamano wrote:
> Remove the clause against "clever tricks" that cites !!value that is
> a standard technique to normalize a value to 0/1 boolean.  We could
> resurrect it if we can come up with a truly exotic example that we
> would want to avoid, but this is not a good enough justification for
> this rule.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * I think we saw a good example that !! was used in a recent review
>    thread, and the idea to remove this rule was floated back then,
>    but without following through.
>
>  Documentation/CodingGuidelines | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index 3c8d6c7dd3..4bfa615bac 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -522,10 +522,6 @@ For C programs:
>  	    that_is_used_in + a_very_long_expression) {
>  		...
>
> - - Some clever tricks, like using the !! operator with arithmetic
> -   constructs, can be extremely confusing to others.  Avoid them,
> -   unless there is a compelling reason to use them.
> -
>   - Use the API.  No, really.  We have a strbuf (variable length
>     string), several arrays with the ALLOC_GROW() macro, a
>     string_list for sorted string lists, a hash map (mapping struct

I wondered why this was added in the first place. But this dates back to
6d0618a8 (Add Documentation/CodingGuidelines, 2007-11-08). So it was
there from the start. And you objected to it on the first version:

https://lore.kernel.org/git/7v640ega5q.fsf@gitster.siamese.dyndns.org/

JC> I actually think (!!var) idiom is already established in our
JC> codebase.

Andreas Ericsson replied and emphasized *arithmetic expressions*, which
I guess means that it is not just a single expression normalized to a
boolean.

AE> Not very widely for arithmetic expressions though. I believe this
AE> alludes to the (!!a + !!b + !!c) idiom used earlier, where it's not
AE> exactly clear *why* a, b and c can be > 1 if != 0 is the only thing
AE> we care about.
