Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511757;
	b=kwN4pNFt2vBkssyf8J1WSqhNjfLynNKISWJbV3kMEfCyHKwDsqhi9UtsOhBRXipqb+Vv
	 7StDy+XlWJ5ycAgkRUbSjHX+1rgtN7cOomOk9E4lHGqNU1yF00rBHQjCd9mmvxWELVWjX
	 c+2x4RFydyqSJK0hraVX13WQ0EL9jNA+clxnnTH3CejWVxmCQBK5EUMWb08fh1GpVKaOT
	 NkQgqieGUTl2hLuTaGBe16DTjbcxq6ppFB5FOQAE2Io8bzqkjpklGP57kHXGbITknmtWb
	 dusmWc2SGPiYz/BQTV/986PiR4zudz8yKiu5VZXviULG4WfIA82P6V+z0qryosixY/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511757;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9x8q7kllnfPPoskEJPCdWUhPn3O39i8kT1BQMDrnM14=;
	b=RtX3uvTmJisEMFCNuTqtTSwz5VOVvJHvpUCNxDyB5m9VAsMpK2z82njKYjIZX3BxrznB
	 PqcuSbSaIC/kkmQQBoDZEd3b8YFKR0pC7ziBLtgW9p86QxWaezKtj+z/JVSrXJPpZGDpy
	 a4bvZNHvWjeqNyF9lLtzThGGBa5Xx9NZAMO/sWJZsagH4qgxYcj1lhgOCUqXfpmy4cW5r
	 kbTG+8TmOulY+n5iZ+wZtQl3AkXH4NCdF2xM+lncZGt+NJWxZvgMzItVM32bUL7qnkNLo
	 LAh/CWi+aCgceCyKaz38W29h77xLtsXWU4V97yvu8Jw9rcvRLr0S22b3IVIACJx904g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=W+YHCKGi;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5GVdmXLm;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576A3606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 19:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 576A3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=W+YHCKGi;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5GVdmXLm
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B05187A03A5
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:29:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 14:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794511756; x=1794598156; bh=9x8q7kllnf
	PPoskEJPCdWUhPn3O39i8kT1BQMDrnM14=; b=W+YHCKGiStY4Cm6uxeYejxwr1E
	gQic76eXxLKaHfWzsvl9xPKYr+KNbi5Vr9ZIaRMt3JT9Al3kfBb2EJpb/FtbCx+o
	D1KwJFdY9DQUYQD93V0IXI2w0MZB4LCUh9te84QFvpYagmWS+FTtS1WS71yAbtz8
	OQ0m3B3vg/BYNfK2v3+ffC9o4Uxyolj1mENXIymjge6WaTyopLXtEB+yzBGPa9Sq
	iA8U3+sAxy1yz23GowUyk54x1N8LGndhBPGN2anq9XoTgujz8QYYvcwAtduA4YwB
	soXX+3sM9J6gQk1iexIjUceYShtVtUHabnsyxNS29Cg3webk73fJ/xNN071w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794511756; x=1794598156; bh=9x8q7kllnfPPoskEJPCdWUhPn3O39i8kT1B
	QMDrnM14=; b=5GVdmXLm7l8lSXn9YATvBVK7FIf3FBKa27mw0WmPU2NAST+oZoN
	P2kqdTpf/Ku4ix+Cgrlz7SZxraABSmlw5nUAdTaMwWtB3AypuNf9FuPrj7tEUYaq
	pCpf80H4RX+GEMAE0/LQfhswTj9eH7FCVqbAZe33xWpG1U1ay6lIxGRWAXdTnGjf
	chfycUb4WLuq57Tb0Za34vOfweoHn3h6vvIcPdfQsrz5zWFQX91TB+sYjcoBwYUM
	g42CJv76fpmDaq9EYqN5bpijL2NtUm+R9ogevhu3/Wetstg99XvX3CQV6Ty8LrRw
	vF1MIbHaiauqqOQs/21vdLvCPsLvPcFpTYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794511756; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Zv85n1uWpfvD3V+M5PUUYYGjUoZsD1fWvIPfeq8ZNVN6UEn
	pv9fp6Qi4Ijxlfc/Koj7QQHZWSYveEUDVytAG2mQZH6iE7liAQvKfuvL5ihtz6MF
	3QsnvBD3C6/cg1JSNuipRE4/Q+dsxS9Bko+bW4AHBeaRddYGy8C82YUdOEkMWiOf
	1Z8TNcRAHLyD7bEas7Ot+1FGoM+QcA7ehqgPMkbMiuOhVRL6UMvEY+nHGtLG9gzj
	OGS0OPix/jD8MEYwzbBSSuCiX1Jt93g/J187v7qs7qBjVVjTXNCbuzhZVyGFjBLi
	NgNbR+pCjy6z84xOwKQmYFgOYOenH7rBvqVHojw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jkq2YHMdMrkcgRQt0yCcPe988iVZXkdRdV4P5vVQmDM=:A5hPdW60QKEekLILY3t7KS8GfaGRru2Bp1/u3Cm1skU=;
X-ME-Sender: <xms:jBP2avlGYgNKeZpTYNd0NWWX9gWuu7ZZKb0OYst8x38XGlr2NlQw3g>
    <xme:jBP2aqTl-ckaVZt-aGwcVBf82yzSiOqvSmKs9mitrhSqoL5pjGolylyDHgadXXiRx
    0lt5TQFzmeh7xXJN0q5VgdBsh6R7xCW1O_ScloVe5-mH2f7exDpktY>
X-ME-Received: <xmr:jBP2ajAnZqPehTXoOFqR6RPtjYA-tiio32G-HDjg66ZkDGadl0dxrouhSFOesnifwc8qFssDAqOJNl7IrXwBAy19gNpdVgEe2lwA>
X-ME-Proxy-Cause: dmFkZTEOrRcSQcT5mZCVmvba1pYY7laJCxuPyDosDmeNj9tc0O0RIYG1gvtetgZicHVygz
    Iac5Ou5F0Z0je0AcRNRl40d1NqV+zQivIYM5s7IGtdQTIDFcv96MDZj3QzmxaPVi50C9Kh
    EpslwqDj5Zyccjazya0p4vyC/UA0/JLZHuGdA08+8kAn08wq45wHSje4DG9yhNrRnzxCPa
    uIGm9ZSLLh4CZ0mQQfdBhoJbBlDGys0kObBQBq7XuVcHNJTsKUmE/AHNV37egWD4/ajEqH
    Rvod0kPRhUKkRKBRiz7587yEK5WuwQ6tngUqngHP3D+ucUdcWc1PVJvqk1I8s+qojibbeM
    iipwU9p43d8VvW0GU/5ceoY7FzkaRsIbpiaSUAxF4Ev5QFxYgHDPe80d0DUkbd5SrtOPXQ
    BYbrcy/oiM3fmjzHZiA3QZR+Iruri7s4qnAEDqD/SmmATf0KfHSWJaao5d/knqGgzb/CPv
    8BFC7+MvcmV43jJoPmnlBCcKC4mR+q26qq52H2cDQApTU6M4Nj3ceOLpfezJGxRPZFFoIO
    rTumDACE9uy/L8c9jsAowXGgXZOXkM0jntbtGDt+04kG2yZh9f3N8XedA+LQxzRcBFXKsE
    fSJ5Ht86grLPJEHW9UUNjNACpJ+8dO6xBScvWYrmbtEeXD1y4jrisUP6Nk+w
X-ME-Proxy: <xmx:jBP2ahRTvgKfEKFpFFVdXgvokN78dMXOIFYekvBCrJjH4Wb4bZO5Bg>
    <xmx:jBP2ahrTfoIxEcD_VM3FXK59NxSOUwOTue6_MlC23MiE-fHB9zISjw>
    <xmx:jBP2ajy_MrTk-zN_7VvZCTAdROynINU0i2ZBsLoMU45pgDCVgnqsvQ>
    <xmx:jBP2amJejhK5maFqgni9R22uoxLPJVnaPWUMpNdstqpFPtU9kRsnyQ>
    <xmx:jBP2ak3gh6fIz1JOzd3PN5SthwZRKtuxi4t2pDlyTcmgDw1gPW4XVe8E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 14:29:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jakub Kulik <jakub.kulik@oracle.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: uname check fails on Solaris due to different return value
In-Reply-To: <SJ0PR10MB578540903B4931FFD985580C8A702@SJ0PR10MB5785.namprd10.prod.outlook.com>
	(Jakub Kulik's message of "Thu, 12 Nov 2026 15:52:49 +0000")
References: <SJ0PR10MB578540903B4931FFD985580C8A702@SJ0PR10MB5785.namprd10.prod.outlook.com>
Date: Thu, 12 Nov 2026 11:29:14 -0800
Message-ID: <xmqqcxs9j1bp.fsf@gitster.g>
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

Jakub Kulik <jakub.kulik@oracle.com> writes:

> Hi, I encountered one more minor Solaris failure.
>
> On Solaris, uname syscall returns non-negative value on success
> and -1 on failure [1], which is different from seemingly all other
> supported platforms, which return 0 on success (and still -1 on
> failure). As such, the current check in version.c doesn't work on
> Solaris.

It seems that POSIX.1 is pretty clear on this.

    Upon successful completion, a non-negative value shall be
    returned. Otherwise, -1 shall be returned and errno set to
    indicate the error.

Erroring upon seeing a non-zero value like the preimage of your
patch below *is* buggy, and the updated code looks right.

> I managed to fix this with:
>
> --- git-2.56.0/version.c
> +++ git-2.56.0/version.c
> @@ -83,7 +83,7 @@ int get_uname_info(struct strbuf *buf, u
>  {
>  	struct utsname uname_info;
>  
> -	if (uname(&uname_info)) {
> +	if (uname(&uname_info) < 0) {
>  		strbuf_addf(buf, _("uname() failed with error '%s' (%d)\n"),
>  			    strerror(errno),
>  			    errno);
>
>
> which *I think* should work on other platforms as well ([2]), but
> I might be missing some where this change wouldn't work. Still, I
> wanted to at least report this.

Thanks.  Care to make it into a real patch?
