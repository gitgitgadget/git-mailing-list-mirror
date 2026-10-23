Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743791;
	b=QhXQ0agy49rb93NERQwYx055nXYGWGIQw0GRBjUUqN8546C+jvIKOZJDBVLAcognCekn
	 MCpsDBrK2B109UZHO/MjwgpXXgzV4y8L7XkAIrjqU5kh3K3+PFWHOp/CgFLcisDNfWS1q
	 jTqI6U2loA2Mhanvhrnm+20EsN7xnCMvfWh7XtBnhh1xO0Wr9wgTtc4D8jt7LbYTEvhWK
	 aFTufQn0lyGmyaulT1oNV8MVX6EiPzeYJuNisNmwXuuJOm6tKJUBAQt54O9cOjsKPh5Gt
	 z0jS6XKBBiautzWJN3fgvGxYR0TSgKIHQcq05OJzu2CcE9RD9D0CdMoj1QIAxx+XQog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743791;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ridM8d7d23V8R44jm2OwA2gyE1y+4ki6qRz1/lMmBNk=;
	b=vyEmUKQ2DAdN1Yo35LYkoflSGqlRRKIDN/yz2CBgcrkwUI/l/bjtyfRBD9lB0Y6F+M2H
	 h6LX5wyzYPO4GlfP4SAmOVtc892YOom6G4niy5/k2ZqmIwJoQqKkEGbczee/THm9RS872
	 s6WgwpAcheZq5hvfPQeWAin+cy9hdBZmqx9381G6zC5heopcMrIh2tNmODy4sgfFEIbSW
	 xih6jVr5cgF4pYDVB8ZyB/BZnMwq6n76BmJiFaeLFBz7cDtObaBr8YSfHKZGsblY5dbP6
	 7DdsmU856u83hZ4/je68ObNYt8vl2qMnpaDKynkz3VaX+uxgYwmYkbhZl5cnOD2smhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uMt1PNw9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VrGDuLzW;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A0606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=uMt1PNw9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=VrGDuLzW
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 711D7EC01A0
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:23:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 04:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792743790; x=1792830190; bh=ridM8d7d23
	V8R44jm2OwA2gyE1y+4ki6qRz1/lMmBNk=; b=uMt1PNw9luAZgzD0yy/OsgheGD
	eYnCeN9NXTm7jmJidlU1To0gLmioow0UL22x70/W+PU3NeAp/laGRaGM/QaVDMyp
	Na9cUvrotwV7d/0LOl6R9wSPyNm8d88vS18jCRvZQxrgw/e401GC7YY5KjypsduD
	+wUr0KnnwpPBBo24Mg73CrOibeWRNyDhikcpV8Wb4zeeJ6tZS/qh/Mor4ObJDnJ0
	CU1iKg9FjAZFJnbiDAH7xPZSpXx/9Ak1xDq+z0h/tiy+cez7Jo9CkYNYCQ4tYgle
	SIQxHWvHxNTwTwQLkAZYTbya/Q5gP/8Kk9iRnyScvuM6IIxjVgfYj9UgtMnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792743790; x=1792830190; bh=ridM8d7d23V8R44jm2OwA2gyE1y+4ki6qRz
	1/lMmBNk=; b=VrGDuLzWUzi3HR+CpY1JXzgUOrkOiv7THDTNc+bEmj/i72bs4Uz
	pTg+LujIaoFk3xP0GWOH9XJFdlEiLnGqMsM4O6OVRjXiKapm0MsBMlxrk5TkueXW
	VLCoEgIKiTQCvJEGXVyT2CFUi5o9Haha/5KGJ19qcsYbyZSgzPsiwFJgbenUrlRr
	fy9uvo0dfmNKsZO6Gmsf+E0TFlAmOrvbgvAAWDUYaKYw8x1vyd9/V/38cef0nee6
	TJOieFfkAc5zavbJp4PvB4U95uy9WY+QbcFKIkHCVkf84+uaWMRpbMYUvO/njbeT
	baK1gqlY1yZJ0Z18GknoiSFxZXMHNJNuctg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792743790; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ebJJiUHg0N4VB0UDXmWUAQqQiGSPZFdfwzPsnT2g3/O/++G
	sMAHSb+ri9Gs/AkkXOUN78WN9frMxBP+HYfyTumYFhL0LmuQRUGnCiGySjXMwZLJ
	rT/DKwNsBxu8lwllfd/RpCAGudcBybEZ+KKD3+tOYYOfJ1FccAAHfBW5akzpD1LF
	kdVGs5SMOjOmm+Ca+S9BbVATqn4PblyFrlRDfL/EmONAicqJAdLvyUcIKSyqMBTF
	rMIX5oC5oFsmJuR3qMesZyO7EB3JxraQwYC1wBZ4MjobjTJ73qPKdDPItTOu3jCe
	lejeqU/Kot9EmpzJix5Z7iTuJzItBJS+pQ9JVZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1wzBw9xtxS3flt3fSLm4qJ92MbrojCxF+z45u/dN2vU=:dxnOUAkQyx+LB4UzKndjjoP3SBE/czRw+28/oH78TCs=;
X-ME-Sender: <xms:bhnbakHGkOOL4dDtpOU5u1ZQhzRC589ytVzUwmBCOAKM286tRwGwtQ>
    <xme:bhnbajVvQvFdM42v1VxuDeWWoH_kg5ZAcf3ICfi5YVDBOdvhoXP6-TmmzHcLaqJSJ
    C5cFY4r4FqhkRJDKxkTJ5QF0-qBvdQlUfPxpU9-22dCffBjbMXDfds>
X-ME-Received: <xmr:bhnbarztVxjBV2hxwP-Q8ILB4oN5idoQD-7xAzig4AsoiredkJqknozC5A-r5VBRByAo5w>
X-ME-Proxy-Cause: dmFkZTGrXCcgpmFGgURFoXKcVMkEVLSPluW9G4B5CFYu93Gj3mObArkTExPfaZAeQ7MPne
    G7x9iIifVSS4AfTi1GzzhajhF+G3dC3pJb9RZHQ/GipgQLLjXTfbF2yLF1gNGsQ30YOr3c
    YbnQYdLRokBxG++1QYPDeqgJXUIUljAtRznlNUb3UFNp0PSwUjxHCQpC8sytTdKuSeVg5R
    31f7AcYnKUMCu4krKJkCFii+TfHVzK7r2zQ39h5zawBTPhIbxadCVxC4HnJ/D8g5qHDjKl
    omgK1CoxgJT/AuN78ANMCmvDwDiiqgAjsrPnfE57hyuR+aKq4cX56s6x1k2x85EjAeLGHQ
    qs6nRpHybL1izNnBfpaqoOrKF35dqWsgsRRJ2QnC/fS3/ngNb0Vc9OyWFm189NzoMxYEgP
    e3EGjvDo6rBoe1f7OPm5kHmcmtkjdp703pMcmito7RFJnq08unIjUtf1HK6pYHd2wyMNOW
    DThIFdfAXAWCyER+d/0u7AfL1cwWcJfsGieaa9droAAZxcDcU4+LJYKMnrtdFw6dhGNBRs
    DMXg3W9wUv2vpOz6BgmzF8Joyr7Y47zkHEA/50XXgs22JXoOU1OPwreP1HhJaurmPCH/KE
    XvjeMifKu+TJsi0B3IFiJO32yECfn8CgoiFV2YM+vnC96Ou+4HCPoMYH71Kw
X-ME-Proxy: <xmx:bhnbahNqMbZLcb5D6fAE1Roa0JpgUFjDRX3uXU-JlBICSYctLaPQlA>
    <xmx:bhnbas65oSWkqPc7pqjZG7_-LY0jsnpHQ2YcCNc2Vc81aYydNcWJjA>
    <xmx:bhnbaiMcS94wg1Y2eC9Q_waJ7YL38oeRy7QbDXj8YSn3PYtgntgopw>
    <xmx:bhnbaqkfG0cD2b4q4c7j7fXNMMy9MhsZME2DwzF2UMvxaT488pPqbg>
    <xmx:bhnbavcI83XAyEwZaYg45S3Ks2Z2v_OxKoH0e9GjqfUtSL01qmQdDCQ->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 04:23:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f04f2f6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 08:23:08 +0000 (UTC)
Date: Fri, 23 Oct 2026 10:23:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
Message-ID: <atsZX6exgGJkNQQQ@pks.im>
References: <xmqqbj8p7okv.fsf@gitster.g>
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
In-Reply-To: <xmqqbj8p7okv.fsf@gitster.g>

On Mon, Oct 19, 2026 at 07:27:28AM -0700, Junio C Hamano wrote:
> Because our updates to an existing file almost never makes
> modifications in place, and instead create a new "lockfile",
> propagate the permission bits from the original, copy the contents
> from the original file while tweaking the contents as needed, and
> then finally rename the lockfile to replace the original file, you
> cannot "protect" your .global configuration file from accidental
> clobbering by doing something like this:
> 
> 	$ chmod a-w $HOME/.gitconfig
> 
> Of course, if you make your $HOME directory unwritable, it may
> protect your .gitconfig from getting updated, but that goes totally
> against the intuition and is not how you would protect a regular
> file from getting overwritten.
> 
> Teach the configuration file writing machinery to inspect the
> permission bits of the original with access(2) and refrain from
> doing the usual "write a lockfile and replace the original with it"
> dance ourselves when we shouldn't be able to write it.

What I wonder is what makes our config file so special compared to
everything else that uses lockfiles. Or put differently: if we think
it's important to honor permissions bits (which I think is sensible),
shouldn't we do that in a central location like in "lockfile.c" so that
all users of this interface behave the same?

Patrick
