Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569466;
	b=iRzHkQJQ5Ta52WhAot6GSR09+VE1DGotGrHUGRwQPH34cLwDJv+LdQ9YMBcVzqEsvw6L
	 ObwSp3aHTeCRQe/IsvMKHgu7W24Fr1cR4Tkj9ptHwFujBUf2seX4iAPrcK9860+KHXJ4c
	 6By32Bi8rfH3DbKzRyZ+Kp2YcRVBDjGmumzkRp5Qz36rTWY1s+ZAKm4HSC/5MNbEV3D8S
	 3taAtYWtzsp8Fn+jJPoQjBZq5FwyhEpMbTSn8zk+ah9aD6mnqgU9zu8JCo+U/MzZEsWR0
	 0607dZUgUhG1iKMIZbS5SgLQk6m/+IJgBJO0E+qmJSFc81nz3Mo75yHqQi3VgJf2snQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569466;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LwkF+I0Ev1zIajfjJRylDTbgmSdDs7rapyCFrqXwKrU=;
	b=OJiRJHCNKcxIOPclO3ai6iMdQORsbkgRyN750R6jDceno7pXUtOKIbRJ6iH/ApH11AOf
	 VmNNz+kRFFHm+L4hElcVByOcrvZ+jSYatsnebvQMGr/flDpHYSMNO70InPfUoGPj2ALGF
	 yvHalmFWWSaUcBaAp/1Cr9IzFNKNHdSUNQX+mA3KLzGsWxB5UPJCnyMnxXzhz5uG6fixQ
	 RIEssyvVkGnjglfr2TxZGIca/8rMEjVmU2kK+XRTS5/sLF2mbmfo0ikBfaoz4eUaf4Aw5
	 xIn88Tbo3YYCdt29xZbuGB10pK3H2wTjkGfXv5HUMsrl6rGIHW6+AolnH0rjqdgPBWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FhjVEDHX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bzTz8T83;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C7606A31C
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B9C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FhjVEDHX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bzTz8T83
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D4901D00009
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:57:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 21 Oct 2026 03:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792569464; x=1792655864; bh=LwkF+I0Ev1
	zIajfjJRylDTbgmSdDs7rapyCFrqXwKrU=; b=FhjVEDHX2H2YS3HI5aVG30p+Di
	VljQJ5lEbmMPT+hKsDSIcYDNSasffS8SPnp9ql0gaLQehE4cfDGHOjJ97IVVxRnE
	VO0IjMhPit07y+WoDe05YMoe0ou++PD+teMPxxTdawwLPGo6UWB0TVwKaG+WL2nT
	za7fdpzsHw8Zhm5ehTVgS95PdpakGsUSb3KzfwzpOq8991mcDePWNhcoJOw2HiSf
	QWG0RccaB26FMFxMJIvRa/yQKNoyzZQeYmeS9a3oOM0sHq+mKFd7Eog4MH0mSih/
	cEitMEeo7uymfMq3EALd/Nbvmz7C2EYIv33wjUmVy0+xWUJUhH3QZDsLMNHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792569464; x=1792655864; bh=LwkF+I0Ev1zIajfjJRylDTbgmSdDs7rapyC
	FrqXwKrU=; b=bzTz8T83p642s0DmuhpHJI9vU22xiFT1NzBWgg6oabcEUoYwCGm
	kuhzNzCyNjqB5NaR4Nm6EU1Eo7nPejBakmpMpYeLDK4MVNm64wJwDeCQ4SomIqXG
	kz2muS7z2nhVVHfnTfMY9SWDG9r9diHHO358vTz6MRfUyr4u91XdinQ6yZcJi6rf
	/erx9QJeOt09InZELgxZJWB/WJdepCKTqr6mB4sviLnH7wLO2jWvg+UFS3Wt3QQS
	3gsuLAO7KQcBS5nI9YSqLxseupGaoEDa/1uI+3KDefaOqQ0gG17RXxrfY1Rll99J
	q8HTsKe479YHxKFPnQv816yKBSRdTzGQvlw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792569464; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Rm2s4NI0hzWqkZLP8HkyDjq9U76ykT2AuYSxqk+u8ldAtRR
	I8lAq8Zv325U83bXxyORxJBITAYYvaJFhd3+hCN/TxUPM6hIAJvcq22IIda+1hTB
	WBosFZA4dNUXaIctrVj0WnaejypgM+c5mT0GsVEDYUYQtWdre/qX8CY+qNkGxYk5
	Fza4JFjXVDpNS/OvAF2JzDbQogVBVb6CBaD8ZywuQzGt0l4shGZd1tTCAGlkuvzO
	W63oMXRUH4MwK3zdJkcJHYGYhEXoslvwXMQlaAOJxPc3DzkUr0hBdOaCLTi8/gi2
	DYCkWqA9xaVhlM5qQCiWpMx/air1XS4HGxSdBIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:n8qoKQZY4cB9B61oF/TAmREsDfTRSe8O0khGkZEL+Ig=:WCzvwMbMPaZVR/KwL90fnOXRmPYsye+uI5o67L0hFG4=;
X-ME-Sender: <xms:eHDYagKkjZS_nzWDe8s2iZ_kCmrwX3lRebla7iW75NlxyV-GwhIiCw>
    <xme:eHDYamJAFEhaJ9ZiMWdW_QZDWXzXTw28WitNpHAaBA8lkvJlIEJsY_8GG4YxUFucs
    aQ_3A_tnR1EwBo48s4JcUfpwRzIXAM7NTzeMEZojlePQvhEhLVbRy0h>
X-ME-Received: <xmr:eHDYauVrGG1xR6REdY6hK_ji58WtYYDiCaS0btbip1zTzU6hfCUOUg>
X-ME-Proxy-Cause: dmFkZTGiCbiqFtbDRHAmOTwNQA1UduGya9+MKQXb9sS3ShcgOm6uyxOWv8hKiFWbgMchFp
    JzwLWtrSARUySveMBEZA0R0XG5mhdQaP7kfacCUO5ZyhqATM6TDvFM95spSnpGaAG5oWLY
    dll4OufnN/z51GrpC0evIu5Xx/lE5P61aaY0u0E0H3COSyOdznA824mhGeilWk+qglXhFf
    US3/rEY1NCgCpw8cR/a0FW+lQMH4C8JZHinKo2I2+nMaWvEH+ElN1vYs9mvkuXfEE25R4S
    713c+8quuYberBAYeWQDopY/VR71vGs1gQYomoRg5tOdABI1qCWGJ4HqIgrbbZ3Lm/q0ee
    tcPS58IK4BBtS8qqZxui4GWG60flKVFwrri1TB18NA9f+XOoTtGGoPFi0ODgz87bZEZy9x
    213oN3D1heAAbzl+Kfb1t55fKM0oZO9ap5MnTM40QzT46BW9qOZE6PnY3MUvROaTRjjANN
    TpAc1Pd3jsuyOzBeuGxLLntTQQj1UuGgw9u1W9vII5K7NVkrkL9q01YMibKjcNtpxHP/Sx
    RfDjbCwbHRF5P9gKP0jA9Bi/T8maJdVEpZEk+QkyQrrR+npUzqORonwpchU6jUtAR5RsHr
    r5tXmbXwlinTNSHnLjzyIDYYcIe1U5x9C7H0QzGD1yWWLgZ/gbewRtG5OBHg
X-ME-Proxy: <xmx:eHDYaoj3S5kA9jmpzalbjnOLXbKiQ6tL9LPz_UszU_AyU2WO_nf1oA>
    <xmx:eHDYap8S45AwXO3w-MXvq1em29rc1CwilwotBFSr6WR1RC9jBdmTHw>
    <xmx:eHDYaiCzlV1ptdtTo7Q7OwM2rgEanKFkH9FIFSKsf44xA3Zwaqj0rw>
    <xmx:eHDYamK3wBSDdRFOxlz8j5CBJnSMHD6uX1eiF1EJukW9dPyhbuAUMA>
    <xmx:eHDYajjbXvxVDNcvc0-f7vI6pZkoUvDQ0CNVXtAOyjeWoAeH6qKvAKmc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 03:57:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d426b3e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 07:57:41 +0000 (UTC)
Date: Wed, 21 Oct 2026 09:57:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5] github-ci: update macos jobs to macos-15
Message-ID: <athwcntchANgnJxD@pks.im>
References: <xmqqfqy5clgz.fsf@gitster.g>
 <xmqqa4o7sp0j.fsf@gitster.g>
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
In-Reply-To: <xmqqa4o7sp0j.fsf@gitster.g>

On Tue, Oct 20, 2026 at 08:37:00PM -0700, Junio C Hamano wrote:
> GitHub from <no-reply@github.com> address keeps sending
> 
>   Subject: [Action Required] macOS 14 hosted runner image is closing down
> 
> and suggests to update to either macos-latest (macos-26) or
> macos-15.  Use macos-15 for two of the four osx-* jobs, and
> macos-26 for the other two jobs.  Use explicit version number
> "26" instead of "latest" so that we can more easily tell the
> differences and similarities between github-ci and gitlab-ci
> and compare their outcome on the same commit when needed.

Thanks, this version looks good to me.

Patrick
