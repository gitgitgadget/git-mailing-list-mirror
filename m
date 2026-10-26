Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026910;
	b=TxfB3oQ3s6IkwE8CQItkUUOfq/6ZLhMYb7laTyyWm2a84GT0OOx85U6WtJdGr5+s7xW5
	 ipwa+5a8kQjDawxzNSdzLmMP/sA+YeTQp7xsXop9TcXbVad2pHLDDs6oxqubjUYTQJ+jB
	 Ptes938CsWuOTHS+cTL/RAAylGM9mYSD7NHqnKPNH1I2cYwytJACgUcQq/+gX9AGCZE0F
	 174irVKDxIIJM2o9cIo0dCQqIjIPaC2A/SZor1RHu0tBlogL7Bv9iWDK2gDohIVBGLTNJ
	 08vbsZkk94Km2coIprhB57yqxrmT/V3xn9724Esbtuvv6ZM+x2plHpouE0YxdeWMvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026910;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mr/IHRe3TUsybOvh015PQ/hjmxCeU8RIDccCcH9y/uY=;
	b=TadQCCvmWEVWm2F9kSe3UWiDRKncv9WryZS7dlMBmjd9q0RE5YCUDZEcQ2Sm8TArF1uP
	 0ZDbD2fSsTzsLyrwTEY0NXmQQQbgmjBRYQ9XsRsinjOuWi6Q8E8sM6bKf7fFO1wRNHi37
	 jtVRWwZbyy9raGAj90m7ZH9H6tmGIT67lCEc0oMXyE79MXjNZLA5vPDtHz0l92mvee/jA
	 SRgcmR0s7l9VVMGasoUQL4IA0Bmt1ooHlVPBJYVNtcHp6PZeDK6XJgeRpHfJFUiqeiRrc
	 18g9Z9RCVWZHbWJPF9Zyhl842Hkq5xnw5KIWjNccG7HHnvucSMiMtZ35rzdGaK06eIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=asDU50lv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ACAZ7gO0;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13867606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13867606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=asDU50lv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ACAZ7gO0
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6B6011D0024F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:01:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 11:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793026909; x=1793113309; bh=mr/IHRe3TU
	sybOvh015PQ/hjmxCeU8RIDccCcH9y/uY=; b=asDU50lvzoSLmAxOJaxi3mMvTH
	88Wc7SxWX8nvUJ6/RZd5WkGaHq64h1Kh/rbZSbZT4tTdMxsrhaQ6nxIr5fDXcNLK
	GBr7SQEq0n0zJvQYdYlETc/VXJUzF1MbtvZt4VICrOwj/5NZi0sqM+jzomj0TKxC
	0yEFanC5wuwXUc0umWJrXg4jTak+Jm9FOgSaeKx+3fkQz2Vt3pXh0wSJebQdOh6q
	+qGqEo1BNzoLrCbuwD/GCJ52X9UFtiLeeds1ZX39hkGG2v8YNqupgGuarLwtFhDb
	Didsr0+CDPgnSvvSSK1w9AbYC+8XZIDQGenKlFakaJShCtmrd8ckv9CcjJhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793026909; x=1793113309; bh=mr/IHRe3TUsybOvh015PQ/hjmxCeU8RIDcc
	CcH9y/uY=; b=ACAZ7gO0nl7qNv3LrykOYECZqJ5CdG1HTyNQWHRVuHDY/EWiwCN
	JkJWbX/GPo+7SgxrKtCYVD8mikc2cgO9n11LsWcs/zn13TV9oB4kF1JogHgeyiVS
	Na30EOGlULZahjrx5q+NRsp2ZM2K8n263cQ/E+TTi3chtz7x8K5dISBzynSDIYJD
	9EfyUw1VNg9qM5F1/RQgfdB+CtQrfba1TtefJYaHX5q6n9dAmcmli5KUgfSABAsj
	3z7H/rjJekFN1+buJQ+knuCnlFYRfNL5+2616Sd4D+kkmIcp9gP8QHJgDk0Ije0B
	x8XswwLSMayjZXfy8Z+sM0TIOIDb0ORPXPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793026909; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gElG+YAcMQ83GCaFgNOA26tIYccKNoomtKXm2Wy0dFSdNCB
	AvVfD806UhyxZUTK20vy9sYAN4pyeySmTjE6ehvc59rQ78VR2sKx5em7AfSvxBNx
	+IptksYmG4Gzr2Smhsk+Po15ulmJ8qeBhQVJbF6xDLhiXNH1JfUyu3CQUAPQJcNL
	s9tF7l+eGFGbfLGlsHXOIrg4kAoO0oVvYdVCyMTFPNTSaIO8k8kuGq37fT6aguxR
	ulb9kuyPBx+3AUr9qn3qp0Vx5nFoIDntZkSL9WutqwLwTM21R4wKKhnf8P0qqU81
	WhjFsgKDICxdX+YNbLnpDs/wAu+LK77JJxvIEjg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:J6/NpNbx5gImZWjCDxmO+j2zKuLyfVG0vgRxuwMNFwo=:EpfAFWx9KK2ntKQiVpcoJUDWCBqNcarc/GFoi/6j5D0=;
X-ME-Sender: <xms:XWvfauJYfmsVFWhIzb6RteEW3Oqzz-ndekFP4p-TcKS0nudwq2MBkg>
    <xme:XWvfatnb0OboLZB8Se4MhncxeIYFyqh6jx6tKfu0BpTuUMlgwhTRSYLBskjBPw86P
    zIaoepqkA3ZUjOiTRJ76Jjep7IgjnMilPM9xhI-YkSzyFVT9vOJIHk>
X-ME-Received: <xmr:XWvfasGZ_PrAU93Gv_a7ZiKKCVfqupc-vMQUrpTyz0O9Ce91eB_7qnqS14VSLAgDKutvVqS0XQ5P-hHzlsmFJD6h_IOy955R555v>
X-ME-Proxy-Cause: dmFkZTGD1l8L39Sw1Fh/GfwNQs5SvVlAbqlmXfGImH59yFJnkop4JjnGpnGf84n/8B9dgR
    6ckFUamI791Vx/77DOv6NhtooPUaVhepD8dKsOJCfwvnsXCyTHipv7XGfcsp5d0GfsgL/d
    e/j574pGDymtVqQM4+Td5gl9PW7YHk4/o1wvCUzFsHERNEgicWTFiEgQmTt9lh9JfIIM8H
    ITOkxmeG2SLN4sEyUvK7DKp9yEGaIPf2Po1C6WhS+fKAknbZKABtFC+pgFmREsIrmk6B0M
    x+5xdDE+7WnGaIv60SUsnSmtitPQUlGqXQCd8j5sDjhGlG+aord08EOuFkCUT82zLQ9BJ5
    PE/2vD15naTyOHJ9HNwMGJFYIkhhtQTIH2PCrCOFOyBMC1oXExJniiq20O19gkYkcdlqt7
    TSF2KZyx3323rxhd0DUOPYEHr4jxRuTWGP7I1hJoV9CV7zFvkrucbD5HG5SIDNvNkh01aT
    WrHpiVPacESXsJZ1K45ei4cR8FqeP8cm5vunp4DURDcmI5JlWWO3NMrWxD+Q7qSnhDqYds
    X9bsg/gk6wIlQdG72btBsAKoGmtHv+PIULf41cu00QhCnIFFwv2fmUZYkGKtHqVF7VX7Hr
    JaLlqPC3akoWJz9yhQB/U3DnL3AyC7AzL5XzaNK2ORaCyL84n+sGwDIDcpsQ
X-ME-Proxy: <xmx:XWvfatFgZ9QBWG5Sij6TNSLdzJ1HJu_dTm2hxtfy6uSUCocDZKhuqw>
    <xmx:XWvfapN6DTqvVvoxIFC5nrgSh6ykjLfI38Le4Mo212l_DcKDllElCg>
    <xmx:XWvfasHD8lckadeOhW9kG3g3nykPa-g6eQRa-xbPnXFV_S7n7xQnYw>
    <xmx:XWvfagPJ-8_IVebsb0inTOgj18kelJDcOhKvu7GoU7xgUMr1AfHn_w>
    <xmx:XWvfalsqjAYkHX7s-yI0wWYtwGHqpaAKGDIRGwPF3VVDlN2GEm32m2wV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:01:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
In-Reply-To: <at8R_QThIEedVbO8@pks.im> (Patrick Steinhardt's message of "Mon,
	26 Oct 2026 09:40:29 +0100")
References: <xmqqbj8p7okv.fsf@gitster.g> <atsZX6exgGJkNQQQ@pks.im>
	<xmqq8q3obh7u.fsf@gitster.g> <at8R_QThIEedVbO8@pks.im>
Date: Mon, 26 Oct 2026 08:01:47 -0700
Message-ID: <xmqq5wyov738.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 23, 2026 at 07:54:13AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > What I wonder is what makes our config file so special compared to
>> > everything else that uses lockfiles. Or put differently: if we think
>> > it's important to honor permissions bits (which I think is sensible),
>> > shouldn't we do that in a central location like in "lockfile.c" so that
>> > all users of this interface behave the same?
>> 
>> The $HOME/.gitconfig file and its XDG counterparts are the only
>> out-of-tree files that suffer from this issue, and being outside the
>> repository is what makes them special.  Theoretically, /etc/gitconfig
>> on a multi-user system could have the same issue, but the containing
>> directory would typically be read-only for regular users, which makes
>> the issue irrelevant there.
>
> That explanation makes sense to me. Probably something to put into the
> commit message :)

I ended up rewriting the whole thing from scratch to follow the
recommended flow more closely, starting from an observation of an
end-user perceived problem, analysis of the issue, and the solution.
The above naturally became a sidenote for the solution description.

Thanks.


