Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520592;
	b=kDakwvto7YN87EbbaI875kq6JPErf6bhYHMWWT62g59AQI3RTrlKSKoYyWWGzfPpo79Q
	 8blANJ91x05AfWZkoK5lq4AzEDz9Sj2cAE2qgut8xYUFY14KGquVfUk8sFfQKFuwe61nY
	 geb0399GhHaCH28pvI6FKPvbUK2cKvHzt64YU2PzsRT6joSkXG9N4K6yEKls/Z87HmpsW
	 tZvpyJPlKtQ5GFGXhKOzXiL4msA5bLjzWmIiv19dgR67Uy1kolFYkdp75hyQMhw5EINHM
	 aGXhdcRf1Tr2+c7PselujDkKsFZqU8mHUf+geb1fcxCmbruyIGwPmrVAyLVw5wiqYgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520592;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=6mh/ZpTw2W7aK5wJsNFMYvJ6Iyf1hy73AssjkmUm72k=;
	b=c1GmMbRxKpZXWcS7SPmF4UU+1aO3ZtkmyPreSGi3wYHAyEwkjiQ17qYSGsJrJb41FwTy
	 c6AHEk1LHHX9ugFXZu4bkBywaGfKsc67nKEHrs5fx0NGIrqjFJs9DMMzpm19MRsSsUoE0
	 2RdQpLDLv9Iurx6M9wnufwbPCDcUEi1DZGneXnpakZShiGhCCw+RIcLmO0C6sNqe1hpdL
	 7WiJFfa1lOzp1oTH+xxffvSpLUiISmLij8VS9JmTGg/f8nn+lScQ/s8bWNIa94/XBX5Vo
	 /LExcJqKqChLYlPjH17HhKvJ/mj8y366kZYRzjPxQx0OBFdU+07B8oZjlWaI5uiTHWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b="XQ/ZG/5I";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Adz2xtos;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDEE606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=XQ/ZG/5I;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Adz2xtos
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43BEB7A00AD
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:23:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 14:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792520590;
	 x=1792606990; bh=6mh/ZpTw2W7aK5wJsNFMYvJ6Iyf1hy73AssjkmUm72k=; b=
	XQ/ZG/5Ijwe91WMxE/p5W4sDF47DdMf1f3vLheIrn7gf4Fj08QGv0HHyXVmnpbCk
	qck38B5QGh/4QxmDRCnGdSMn5Bm3X6cjTYpTjQzIeKro5xGcXScWHkQj6IQMzBGg
	arK8+kuJnS4IYoZosMN0ngYOORxGN8/cUxVmRu1X65oM1a1yKZO/krONE5OoBlZs
	eidQM6GRDxTfTtG0hSWHeiC1VfWWTQPTIuMeiFDUqXEJEHfd1UNGGP9uxy8erA4u
	VCwlIYKfMM07DfYdlkXbOQ5XSZrL3308drRpbebLm0V0wSxyIaKjfl4CdFFsg27W
	g5Y2/+0QOhSOGmD9n93sjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792520590; x=
	1792606990; bh=6mh/ZpTw2W7aK5wJsNFMYvJ6Iyf1hy73AssjkmUm72k=; b=A
	dz2xtosXloIg9AF7i9ftgbk/COSg6ISfDM4pe4y4/HLJKTz3UEDoZ/XYaW+odS0c
	3cFVMwRJgMUKR5VTuGaCduYGOnH0tEzay1Fhbp75HnwT2G48DTGvILadwKUCaS95
	z8TK342/qH3obFWye4tw9ptWLANGvNg9yJi9KyCCbsQGtFGB6CnslUS1Gdboqto5
	4CNFYRbUxbbmcwtnSlJiMpmj8bDaVaBs6X0EtQjVDFHxAlcVA8XV88U6p1tUhbi2
	Jk66Ek9fKTu7qE3A/rdMe52OmAEVZs4y2agbGCoa69113wQITV4fAtq/hyWgNxEx
	ggq1q4KsyX71HJew0eBDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792520590; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mPERW6okwSU70ilq7raxgIoM1+WKmnjVQJPl8s+Dr6qUOSY
	PJh3MvdSjdpFfqUCbX7/fEEH40O+zkEZOspQQODf0+HqKQw6DgiCZE4A3z+g1VM0
	yVXfU1pWwWRdVXn0t19YGxJYQBTGc+ohP9maaAjCc5TgasA47ohsjR0cWBK5NxgR
	MSfbZMrepmCZotgLD54jZftuCqqT3E65BqaIcthHPeTP1cD1O7hu88xUPf3pN64r
	ong6EJGbpdqtiflLgIZzFoTyC9vHP2xkpKsmq3qvbKNUg9VleUAST5HuMEZDUEd4
	H/egPGXcVYRCtbbp3v9A0mjU+MxMCb1ruLMaw0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WycPsZjhCO4uTL5BqlDtXfkP50/c3Z9hLJIn2RqaZbk=:6mh/ZpTw2W7aK5wJsNFMYvJ6Iyf1hy73AssjkmUm72k=;
X-ME-Sender: <xms:jrHXan2mMUany7CXeXxdhM-RNFT8BTyBb7doUr_NkoWsf8s5woqpfA>
    <xme:jrHXatgoxhH_vOiADTaP2Eqe9sE5ezf96VBbMkRAV79aY7EWweQePfqbFfFLbsTD6
    e7SPaFo0fM5GvvAGS7fRuu5Amq4RqtQn-mdMt1i6OtRbuSznlLqcgKw>
X-ME-Received: <xmr:jrHXalR8r8UtogD1al4DW9J-Vu6cElrFmb70lpNPOVzqdD9I1z14ZPaCLPg5FgZiyQcqWS_6d6P5k3NSH21VoOqeed_pbBPh0_SSKSLxkz80Mqw>
X-ME-Proxy-Cause: dmFkZTEmj4kKH+mPIvI/1ykHi8HpO/fXFfauNepfdYYM/lrSjG85ISnbRihsCkOMjaa0az
    4N8OMkjN1II90dKf0UrWxIcwmUwMU+rb754TDQVTZTrgUzJQD6Msckw58TUIv2Ck1DYwnC
    Qb1p/eRswx0zebFCT/fWIx9pIQcmO3RYOyvFuH00KiVRhn9enTxmHfwJ+flm41pmTAOmgu
    +wotufk8B94icAHlk5orThQmZd3KiO0xm6OGBBYZDwgJ/UCl1EALHG762EZ2pTTsqfTMkP
    61akg/hemYS2St3ZUerMA6dEkaLMNjJ519bvcOfdc8MaH7Dp26O97qO7BblBduIRVmCqah
    7AeQl2KZLbldWPJ7emqnyKpB3oJN2WGr/KsOKCTGBdwH5OMtLkS8jaT1Aggzq7sNJgIwAL
    gv8gOJJtG/onKjlvZu1uHkMR8kfC3YPFSLrCRNUXgRLyS+NlxHrJrpAxADdAgKBua2qowP
    0DFL0FauUkEKh4MuoMav5MAQt8ksyYJ0vJU2vkK12i1iLqF0aHtpGOI+vGr0MFCbxRNra8
    cDIPuDLDcNuQ83yyUCHwWnyVTpL51wg9xAYz6V/PmU+P6ByI5xt+Vl2x65eJznbH3jwAAn
    H5/cWaPNJv/Pb/pZdMkxgZX7USnaCV0A2wgqy7kmyVOBAIhsFtwCe3QbHYww
X-ME-Proxy: <xmx:jrHXamjrpTMBat1s7zbdyqSM6Xi87DxzpxEqck4QOAewDAULw4rigQ>
    <xmx:jrHXat4mZq1xRMzl0TSBBTsGUtsBuj0-JfR28-YkKu0d22TCy31JvA>
    <xmx:jrHXarCBo_6ljxKuY44sIQtAjS4wQwE6JCSgBB7D2h05l5gKgI7drA>
    <xmx:jrHXasZhNe6oHRVamBHjDFIB5JLsVDmlWchKp85za0-XZHGOzyIQVQ>
    <xmx:jrHXahhRFipp_LztJYpMoPaPa45323T6irJvyVQIS22zUHUEc7nWFLsc>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 14:23:10 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqzew8wb3g.fsf@gitster.g>
Date: Tue, 20 Oct 2026 14:22:59 -0400
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

>=20
>> +Step 10: Create an SSH key (if needed)
>> +-------------------------------------
>=20
> Even though AsciiDoc implementations are somewhat lenient to allow
> difference by a char or two, but the number of hyphens there must
> match the number of chars on the previous line, so add one '-'.

I meant to reply to this one. I wonder if it would be better to
update all the headings to use a different form, like this, because
it=E2=80=99s easy to accidentally get the number of `-` characters wrong =
when
editing a heading.

=3D=3D Step 10: Create an SSH key (if needed)

I don=E2=80=99t feel strongly about that though, happy to stay =
consistent=20
with how other pages do it.=
