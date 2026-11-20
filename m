Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181225;
	b=O1n/YHN59PL+nAU/hCZSPWIodhmQlfhAM8OgGiaAkqVpIccxDL8E3KtWudoNZ8hz8dyV
	 ZzzQK22pg2ATqHdYZCAWYnVA4sO/AGxGFXgjCMOhcX4FSd4YZ9I6coKLJayDKS8CxIrwH
	 NNECX6cW4bsPO4u6TpuHEkzj9xfKRGTOsmwICInU/At5ErkaNb3b4mX68QKJ55Isd3U/B
	 baQ/NRp2dx/oOVmwxGVfDZWI8RmluNyhKVzoGkvU3rZXBqGkY8+WnfcjRSQ8txQ4Q+myD
	 lL0PWeAGjDTByD2F4kH5guxYH+C4VY7UP7iitrAgb8hv689+M5uV2N52obo8CoezEfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181225;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=npu/5WSBwbR2GPTfEP8CVKEATn72q5TqhNnrTkhmwG0=;
	b=lhXiI1Kwtb9c85O8lQPVAjeA7wO8ZGFpdzno/8wBDdcazowNiBY+PXp611WLkfvJtcOY
	 DzO46Ll8xtJJe4mtXudn81mH++KOUBxNjn1jrTwslIpH681Brk/vCc/yVTCESJZcUHkCA
	 YIh44UG1yNG4xLwD85U5Bwzw+jdUGKEJUK+HSICTJLvhW7XSDX9K6+bbdeVUlCbQO16Eo
	 PHh5bCr1MmVKuxt7tzwgn80ryV3NROAgvMx99I9TZhCOheChyG1FK/MZia1ohQm2K7DLd
	 FFmMDqrBdXPqlZjms/rGsZF6v1N9s/fcWT1fbINsZ+pGxHJf9Fr6/xbZRbBiJzfwNqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ovjxaOKb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YeZMY9lS;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE879606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 13:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE879606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ovjxaOKb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=YeZMY9lS
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D2A5EEC0A25
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 08:27:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Nov 2026 08:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795181223; x=1795267623; bh=npu/5WSBwb
	R2GPTfEP8CVKEATn72q5TqhNnrTkhmwG0=; b=ovjxaOKb8bcR6t9vS1ZEP52GM5
	ucHCOv/A3OGpk/Dy2ES+cy8oKYNVzdufc/nf8f39rWIMkoDzg3pNc1qdtSGXrEUR
	2ol9TAA8neex8VB3KSaj7+wG+VNFxfktUTjfcmDVdo8UtdmJS25PjymrTC3mlYnd
	4CFX+dhj8QWq/nVC0bOp8oIqqzgbEKxhRp/xXi0K4wRSbZPHYZpzxk6uFseVA8W6
	PGxK2W2Q4lsq/O8aOe2YcZg4FdSqrBn/w+3xVPeKHD8zWYsP8yxhRKLbbMaTmBHh
	r2bbKwlKa/zTvyQceVd8U+GR9Tjz3OG9uM4XLackhE1yhcFNgOGxy11XeARw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795181223; x=1795267623; bh=npu/5WSBwbR2GPTfEP8CVKEATn72q5TqhNn
	rTkhmwG0=; b=YeZMY9lS3Gw+Ol7i1WYYPVIsaSjFnNSH4Vo9ZUQYninkTmHFQn7
	mHr31wmc06X9AuaMc7MDH14epFz8UPHM170VwwEAx9UOJLH4LtP1weFt8Vfalb7z
	83dVX2l4voqWusmjKoy/RHL6x8LZ9TqXJjvo0JubD5tcFfyfEntb6iVjCXwU2t6+
	Fwf3Zj4+T/aJ1qL9vQCm7UVOV1yDCyj5RXlmupUlmeUaIz5sqRzJHM3eocPbJY3F
	IuHv2B3tOkszqa96CAyZubYgOJuA7x8JiPUOGSn5OzMRqiuS8P11KekWK4Mw0pq9
	DdfuEjqyVchGatGaVPK9K2nOuvFpQtaZSHg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795181223; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:EgXoumZEv/vAwiQiUI/5ZTQyvNkq4xYk7Lr7BZLS48+M1KS
	oeGW9w8oOItSjhMQEYzCDqeyq2gZHG8InQR/gDoc69GB+0vqR2yT83sMqFhLO/Bl
	EDDtiJrKYmwOGgdWyPhPaCok1jfItB1ZFJEyu1t8vouymYr1JkAqW8S9bVZ2lchg
	01+Smw9Ty5bc10crflv/Qqm9gPpvRmNBKV6QBsdnEgbFrTGpdJK537BvMgR8LEhA
	lTljQqoxQH3b/WbX93N/rHknBHFzB7jVVajz4e/7+ZrA5m8/DSfGzHPhRf8qIyKR
	JeBE7+khTwOfrKmNlob4byl6ykUZbsoUhn0aviA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4p5w6I22rVZrdWHj8Zhzy3/pt+KtZ4iBGAfS7+UwesE=:yMGDT5Q0UveGROoM79KNCjCMaLHVuHUGrLaULDV2Pr4=;
X-ME-Sender: <xms:p0oAay51vjsPNILyW-yWUfRskWe8vXRffPE01WAFfYAGKQVT4zifDw>
    <xme:p0oAaywf9JKmd5aMPKL0vLQHsT9GB7KxEVdoNcqGp-owMiPmktvuFZtGe97Pp163W
    66TGY3zaoJPKXkhkxuwNsWJOI5XvESqje4o_XfAxtwfmBPiPmlEdA>
X-ME-Received: <xmr:p0oAa5xglW38HxaN9tCJCiSeltKE06Numsfq7fHMuUrWKTTMAWmGBa6xnGsrjTOEp2sJdw8>
X-ME-Proxy-Cause: dmFkZTEkSyXSddbzjaO716eZwXZBumRAhda9uFjbp91iwUaDz68R6VrOVaNTL27ycDviUk
    D6uyMMUk6HDCrXXUzDqudGp6Fp14nGkm0CbRyddYCYzXa/V3Pfze1yMpGpva1rvIOQziy+
    QWdnsaLd89RSxBNZJ9dAZfCEDfxJAjWJ44Ays/1ptZZfhtWHD64RwxXWqz2jpUzWhY9KKE
    p8BESWJtwdSq8s7MsOfmOLidZ36OHgFix6uNI1CHKO3SC8Tpv07Pjiw4qTYgDJbM5GeDl4
    JSoYyp8SSav3yOLu5H0KSpBwTVjy6JpV47w5c7aqHXRyV7elcj9mBABJhzkxL8xkoKYDjs
    +7PY9OAzeI0cenXQn0Xsqxt75FwIGYxKllg7xJvm6kbjdmdPgSn2tuWfF0Dg+DnwBmsGmG
    QjH4FwIr8ElcCuHz6AxDM1MPxJqKzM9K2/8V2KFwSGok6W5Zsn4C5TrHXllDEEJ7Z86xa8
    WGvKjMP1j7bvwaRAhvmdZCyz/L1hRQXrIDr/AERhv03dpTgz6jlMazpz0T7FqxMP5BxDsN
    QCrwul8ERV2I2svMmPx0ZQKvQIyi6MgN9V+rejp9Yvx7VYNw6Z6ueQdOTcdpGkFPogU/mX
    Y+6D5nfdl380bS5HdN8ccecsscMNuxcrFqaDbnMlYJFNnOXtPiGP2Z0J2UHw
X-ME-Proxy: <xmx:p0oAa6x017rsrEJSPGJmLPDgwZiyrv2CQPoQf0vRzaNcO4siNSgt9g>
    <xmx:p0oAazbyNAyu7Bk2mJiFwfsFtUOfLuGs9cqsYoPnE3FCD1TI6fXW7Q>
    <xmx:p0oAa7X-6-XbV2nnBc-QFZDlk3aVyv2zPRXuSoJdkZsV4lvhTIwmhg>
    <xmx:p0oAaxhZZwezNmZhVmiQIN6_HhS3nCPRpyRKicNWdt6lsMPBiluRRA>
    <xmx:p0oAaxKxo4YUCPsWq8wmcv1xgXUv0Rcz8cXzsdd0L7n1E9-rcTacdKnT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 08:27:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 048fd046 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 13:27:00 +0000 (UTC)
Date: Fri, 20 Nov 2026 14:26:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/5] object-file: use size_t for loose object sizes
Message-ID: <awBKj7DjFg6i0kVj@pks.im>
References: <cover.1794914210.git.gitter.spiros@gmail.com>
 <cover.1795069177.git.gitter.spiros@gmail.com>
 <c9facd8b3b8a60c8516075616f66da4308380684.1795069177.git.gitter.spiros@gmail.com>
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
In-Reply-To: <c9facd8b3b8a60c8516075616f66da4308380684.1795069177.git.gitter.spiros@gmail.com>

On Thu, Nov 19, 2026 at 07:21:47AM +0100, Elia Pinto wrote:
> Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
> APIs, 2026-06-15), parse_loose_header() reports the object size as a
> size_t, but unpack_loose_rest() takes it as an "unsigned long". Where
> "long" has 32 bits while size_t has 64, as on 64-bit Windows, a header
> claiming 4GiB + 5 bytes makes us allocate 6 bytes; the check added by
> the previous commit passes, as the stream does hold 5 bytes, and the
> caller then reads the object as 4GiB + 5 bytes long.
> 
> Use size_t along the whole loose object reading path. No st_add() is
> needed on the way: the size is parsed with st_mult() and st_add(), and
> a buffer of that size is allocated with xmallocz() before anything is
> added to it or subtracted from it.
> 
> No test, as the reader allocates the claimed size before it notices
> the short stream. On Windows,
> 
> 	printf short |
> 	loose_obj .git/objects commit $((4 * 1024 * 1024 * 1024 + 5))
> 
> and "git cat-file commit" on the resulting object reproduce it.

This reads weird, as it doesn't give me any information on why this
statement means we cannot have a test. Did you just ask AI to "please
shorten the messages"?

AI is very bad in writing good commit messages, as it tends to ramble
without conveying what actually matters, and because it has a very
uncanny feeling to it. A reader _will_ notice that, there's a certain
vibe to it that is very hard to miss. I've been saying this elsewhere
already, but because of this, commit messages are now the one signal to
me whether somebody is investing their own time into a patch series. If
it reads off in that certain way, then my assumption is that the author
either didn't bother reading the generated output, or polishing it. And
that significantly reduces my willingness to spend my own time on
reviewing a patch series, as it is likely that I will have to invest
more time reviewing it than the author did thinking about what they are
doing.

So in the end, everyone loses :/

Patrick
