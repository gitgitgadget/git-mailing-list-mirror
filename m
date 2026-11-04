Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769765;
	b=IwLQPcUlS/vbPKp/1GuYZEBLV3IlxjoSf6o8Lkmn9d84i9tDCqLHJlgsoz4BiSGtRFuK
	 l7LwZKfTycrEUBIWywM00ksVU+9mskaYhoAQTJWPkkREFsIeicJLwlbDF0XIMHLhNYN4P
	 /eur3Iyvx8B8LaPEIDLLZD9g+lHXeXvjSADXPJINGvSCnwtceSneKUm+1JjMupd/O15PJ
	 83RpOgqrj7OJuY0+YkA6SV2DJXsIXvwdiaCF2nen6t97cL04hWWHXmabALqxN/2MAwCgO
	 sS1HOnb7IRWXWTWd6h6wxGSoj6+UJz70FdjXQSu4UFf2IDgdKlD7r/KXjEUuKgpMtwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769765;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=+PTXce1UKLDBhB5O1azPc6w2YWsACTCwpc6l0BDonTw=;
	b=EqKqbvqomNDScsGCnU6YWsQNqYR7pe2e34yxXZaYidJhioisy95Hdn1n90NXtaMgrrX2
	 B2cAWq7JGXDOf2ePCG1QHt0XOna1CaRW3ixjJCDF1Y23VoVx7Jy9QSsQyiHz9RbBH4v4J
	 GU0b6YHoelVVi7YbvqdjkgvZ6zsZhmQda5AYNHLOd04dg3rqkb34wwNzsbbWrj+rabYa7
	 gK6g263oabfL2yWhZfu9xBl4DyV3rBbEVGoCpSAjvKsl12ECyI+Dxce4Kb59iqdS/iF58
	 rviWhaM6h6fqqu0EQoY8umq7WLLjnqZYX7CIymXE0arnk14W3cJV3a/5w/AWVDMvssA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=FmejYzjG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n+JNa2i5;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAA606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 05:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DAA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=FmejYzjG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n+JNa2i5
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABBEB7A026B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 00:22:43 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 04 Nov 2026 00:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793769760;
	 x=1793856160; bh=+PTXce1UKLDBhB5O1azPc6w2YWsACTCwpc6l0BDonTw=; b=
	FmejYzjG8RH5oOL/cVcw6wD4qjiBmO3xiQ8zWIdWgubE/3IQ/741pDqVxVNDSUIV
	uL2owLyAhPR8JpZ4JyyE80TzhxfAcYJvB6zZ+iY/jRM7tBJmw9Yudi5SAYinfVjY
	bt1m/v92iCUlj25iXn+qqxszdNiso4U76HrP2pQqONlE8WcIELFmxeEs6BUh2adX
	Ym4iKHBTUa6IFJORf+AK2VDZKLXnZaK4Bx+YqK4+dj2TEG3Ydi8ZTdFJ54sZdUri
	BaCx2EjCxH1lLe9s7/wr3EpLs7RUvDdoPN+MKwO3hjk8pIuKzWWr2dDwpkSnDmEb
	/GpnxE6UxmsGpaYXOvDo7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793769760; x=
	1793856160; bh=+PTXce1UKLDBhB5O1azPc6w2YWsACTCwpc6l0BDonTw=; b=n
	+JNa2i5cRKWtrAdJimcEt8QYW1eyL7UQ7ox5dWrTHLpZtoP6TaGo7jCuAYixpf/a
	13kDCfdG+xSy9+qn5NqauoBmAjbhKJ/O4GreoJ0iunFaaSXAYwbVZLy35VVSeTF/
	zdPYfMJVILXblt036B9g8WMAuhQ95y5UHR56krCifGbjnaHUGNeZvCOit0G3eiTU
	mlgZNgAKuNb5OBBjpnmZPO/djmb8qNpqM8jcjVG9eDsOQS2d2kD2Ctp6xri4/RNd
	+gVgKavGz4Gsk94Xb/S2ezMjWDmcJfEHiw0E9fB8/AfRI8ngPeG20Jy/TP6K006a
	CiYdgORuYY3/urZwjTfTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793769760; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:foqWcKgt8PAS5s23AiPPg9ITx79+MOXBxdCjTfU41jKYiKe
	4uOgt6alY6sVukGhc2gSAff5i+22ZNOulEadVUkcfEvdZpdD17JOTPXwjCePvqPN
	dWRI6OND9TBXL1kQCHEP1t0dI6GFMw1dXdi3SlvOH0hXs78B+yByxgAqiJ2yRaKC
	qWeiTa23OlJ4jttOJn3EKTedIqwdM7pstYeQUs491cv4HBDfA3aaJFzfTDFzLOKh
	9NH7+dr1Mt8ebPccJR0gafuWoMZmIPNxNtUVqXL64yAYaH+SUqPz8ufJ+L9x/9xo
	iJa2eHuCKKPnWBrjrCGyv3ysPAAwx0bJ69K+VaQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/4NIRUsMwx2Yfma/so2Xm2It6L/H9RxBsWLvQhjQ1Gw=:+PTXce1UKLDBhB5O1azPc6w2YWsACTCwpc6l0BDonTw=;
X-ME-Sender: <xms:HcHqavi043jG-oP_j5ipnqv590J63a0e_z1KcznoCPExhc6JW-d-6kE>
    <xme:HcHqam2xuc1SFISG8yYQtxzc5WmXlFBbvuoRVM-ZYrk86-qzvMvWl_-DkkS_NOjxa
    tUJPThX6WiPNn2E0ck_7UvUYWoHPrc4OOVmQMU5DYl9Hly4NSS2oDI>
X-ME-Proxy-Cause: dmFkZTFIbC33KI8pVNUJvH4HCHAb324uLaMAK68ckXKPhK6wog1w2V6o7LN9FHQZbeSv2q
    Z7RMForfWJp3CaD18D4R6TBuhO2Cdr7MCfG1bdhKtFFRJbRqTOFBRjknpaGGAvxGCBEKpQ
    D0LJceYjvo5fM2D2se+q8Y8iEos2bVEM3VLV1Tyiz9EOrkW7Ckr9Vn/T4B5TO2HQgYhnOs
    rmUR3E6ZIhRcYef4LMJkwkpepCAv89M8Fx01mwQzCdTjuaGsPuTz5ZUfac0YsxSbRewCAc
    uMYqufzqH9L3hiUqQBfGJYWP4myhSB15WNVj86XUxrSqBlpaLUOkQaO6LqS6e3Kqvb9nUA
    s6CPebi3bH3aCmeURYt1z/OjGVIOpvHyu+GOprOUcmZrAlY1ghx1JWsNRYi6E2g6daK9pN
    k8l9h3KyGvqcf16V+x/sY27BgKrTCF5K9Wm0LIf4q+xVvVu6Luf36Y0PuUps7ahPBZhLWm
    qOz2m21oZd1Poc5AuGkfxiNCtn2+DZ+tx5hMslxjCjh1cA0x0bERSNH1aBafZW7YcIRXsd
    enWWfI6RZjmWGkOuQ5vw5zaoNWX9yiiDqiK/d7EGPiidNJmio9j5vTVbodleiVefi6SI0o
    05HE05sgeSy6TBsvJhdp4PJcCCLtXfXgy0e2nJnhEsGXWURsZKGuprHh186w
X-ME-Proxy: <xmx:HsHqagmi5vpH77LWiQBbNK_GzsbuHmKlbjCHqZ-k0kSUuuwL990LEg>
    <xmx:HsHqahU-tL0SkPl2z4W8gyWoVIEBdjLxfsMi0LvNtPA9SORBed0A4g>
    <xmx:HsHqausJ91tCKxKaV-LZIPRAtLU61MgZNwxUufF_NRkb9bYIlDhf7A>
    <xmx:HsHqasa0uA0wnclSDlucj9M-AggpWlJVMLzusfcCwt09A_G0Np8Mcg>
    <xmx:IMHqag8LMDlPDwpPipdGapPjunX0wolOhwSISrxc9w-4sEhf3mXPRnf2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1208A22C009C; Wed,  4 Nov 2026 00:22:37 -0500 (EST)
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
Date: Wed, 04 Nov 2026 06:21:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tyler Cipriani" <tyler@tylercipriani.com>, git@vger.kernel.org
Cc: "Usman Akinyemi" <usmanakinyemi202@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 =?UTF-8?Q?Patrick_Pero=C5=A1a?= <pa3ck.perosa@gmail.com>
Message-Id: <510c81e1-dc54-4049-bf5a-c22ec157a4e3@app.fastmail.com>
In-Reply-To: <20261104002721.304153-1-tyler@tylercipriani.com>
References: <20261104002721.304153-1-tyler@tylercipriani.com>
Subject: Re: [PATCH] push: fix --force-with-lease forwarding in push_multiple()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026, at 01:27, Tyler Cipriani wrote:
> [snip]
>
> Reported-by: Patrick Pero=C5=9Ba <pa3ck.perosa@gmail.com>

It should be Pero=C5=A1a.

> Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
> ---
> Thanks for the clear reproduction case, Patrick!
>
> Based off maint since it's a bug in 2.56.0.
>
>[snip]

--=20
I don't have my glasses on though
