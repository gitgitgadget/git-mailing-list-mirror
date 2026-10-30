Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388670;
	b=mL6ewQS00uF4IX1zjWHHZEjqrb8QxTl25CQJhLDEJ1UkjRP9hwiAX4ARnVa1XHLIM6s5
	 m7u77iJyqAO/PeyED4d6ASeD+knZsNlREDSJOjiihJYDjhjyRke4Od+mUsvkI0+2KAcBB
	 NuygQ7TxlasiC/zyR0Fqfw0xZ9A4/vfQcIIk9FBz1+vuzyQ62rkWEkTMZZLA7Nq3B1U2m
	 d/eETykKRBGae+VFrdFiYev99VYoVK8CX7Y4BPcpsfVznoSnVxntLujteHY488qmdTTKg
	 QFyBty5S20brjTWhZ5Gl99aft6gz5EWAWs8AHD4IzzNkVfYiee9kw29WF3uFD0ea99w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388670;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=pAruMa/tean6dnuLfteRjIdbFBUL7Vq6da0WnFkir6Y=;
	b=2Vsl7Iup8yauvz2GQCUiJqNYBCyYP/2jbvH0cXofxB/NEppbrG4hm23j2KdX01wWEw9A
	 iUC5dpic8EIHzDidpSOFnqlI3C/Aky/RdWYmiZb1kHPg5KdX92nK6pSMAKLw0B1Ax4GzB
	 UnDEqzJ7y02skbhPNY5jYJMuDXoF5FIW/qBZP1Wm56MMxA6yjx8+ALVj/BWAntxr6yn38
	 Ns0uFYiRJZLUf622hBqTXkF+CAglUQiz6erXih21hTRaGVBZyvO27zWOYhvghjR08hPbC
	 8fHVa5LhwrLoU4YxiFLsEsxjbJlifqv9mek6dyQ4cFvO6aHDnM7FM2JndX+xt+IVjFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h+dmjsLj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yLS0Hl6K;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F061606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F061606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=h+dmjsLj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=yLS0Hl6K
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E4D714001E8
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:31:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 Oct 2026 15:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793388669; x=1793475069; bh=pAruMa/tea
	n6dnuLfteRjIdbFBUL7Vq6da0WnFkir6Y=; b=h+dmjsLjJ/mwe0hW9OvXfJITva
	43X4s3f7nUAkYgqoT2aHA7wRdqpjJfvrNiWGOAJJowVhv5f4ZM4zAlj8D63Av+kb
	LZPa5+gZoEThyCbbYbyqVX3TuV23KcXk84ztrZmqaVDNpqlRIm7BjZiwLX1MRADA
	tsg+L8hxJtXVUnq0j2GopmXWauN20xJ6+SvzMOVkgrKQZ/IQu7Kgwp1VJ6fHHwtx
	mfXkNgbH9dXCE4BDv2Rq+bQfsh+KqZoImg86KA5sAhqdVVDqSkp/Wo7p7oe+5O+X
	F2EOcRlEzpw6QKTv6G4GYin8yNFlka+p+eB3RD2bPcO3ns2ezKuFdjgKUogQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793388669; x=1793475069; bh=pAruMa/tean6dnuLfteRjIdbFBUL7Vq6da0
	WnFkir6Y=; b=yLS0Hl6KSN6eFgWA21inlt9xcG8gyHraHsRmS0d9nJGDZx7oqDi
	Nf9zBtKkLga7o0FwkUrgVs6PHXSQun9QpSJtYfZtjF83XgoSvRArg3Bq8ElDJYk2
	8redTmPDQE9A92LBX2GT/zp2/6oi6dQZ47ApNRB6PmPifZ8M1RRq8/rkcXxI7QNX
	vwYJh8S9TCUA17gnPGo2BB1bHQRKy9lgxxrD72oRI1Q4m7L8fDFlqPQBGGInNlBS
	OAUF2b4Y57DG4mGNvVuYnlvIRmobqaCHaDnrz6uIo/hA5K8Fi9EI5U8/jrwEg6o7
	2VDkMSfLVWpBpk1XFne6mtrW/kt0dk/xg/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793388669; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:W03Hf9RkEYhGSS9h+j6P6UmiUPDE85Mmx1SCsplvekLekgH
	x1/Ha07XrLY4FSkR7JyRiSOMvS4spAFvafcxmDuUVUz+OAkdDbxAux6ypPOUBrH3
	m3WOUK6yaPsmBZZHGX+jz+PwWpCgAYKAu7TUnfsmhe4lOxH0iTQmDkdN/XnTtFnU
	8/TlTS+92L4elDRQjmwTunTiySN6SZ8TkfQIVYmUeHforqKr6NpfXRATM9JXT8Le
	f7O/vqzivGiiqaoPaZ4pci2DlDhpgym5wsf4vhy1CaSUCADOc4uU8vygK+MeeNBp
	tPPeYlGctaFoX9tCrIs3UTrYgrOTgYkda44ZE0w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xtUw6F9n0EyogTl4wXRH7dXuWXu/qsVCc5DMndf0taU=:rkMIYXPIq60ACPw+QV0oa/eXjMndeC/W8800l8cNbjI=;
X-ME-Sender: <xms:fPDkat05TwMxm51oBZvHUsHf4u2ODQF2Afwu9CeetZHGJUWb68Pgsw>
    <xme:fPDkakyfIyN1St47-XNhUxgbKXHHyFOaiUfWcPwa8BuhvN6RCJ4JWzf3OraTKu1Xl
    sXoDRyqeaWQ30R-y543vYhqmSCo9KTxptaCQ6t8NFepB6-WcmSN2g>
X-ME-Received: <xmr:fPDkasHvDQGkCXikGPTbKk6mP9ZEE9ujcoeVMh3gqOAMpZOZXH57dK1IUAYmHl-GCyem5j-9w2HRMoeG9KXowm6dvXuWm7CYjNtZ>
X-ME-Proxy-Cause: dmFkZTGJfDbYZqL6NRTWzOEdXi5eOSUmMMWNSi2TuNY6D+BexBs50MPhdovP/hhdbGNhFe
    PBEMBiKQeEtsDmPgGnym61eWT1EXKUyXzproxcwcvF3ZmFSGaRJZcTpHJ4uwacDYLAnYHY
    dKe+r9aMfJ7BNyy8uHqNNJ4pBrkyWMYR7yoOuxuJyLE5xdcjuOsqxpkOQQX2u4lFm4g54x
    q5kKj9Qlx8JrijGIR2X5WE7wS6Qp73P59SjH5iawGCaYkF8KD4Wtn0L3TjOrwboSvs7chb
    n/sNPKwpl5cN5PDGijWzwfP+UtCW3ElIigb/ke3Ej0x40PG/f2nU76ErGIL1K5fcGr1BP5
    6gEJweG87L/jNptBFAgq9vx5JSXz3CcPJzF4TXAGPVdsSuJvDBe2tOneCkOhShwLAzbNqB
    nB7tr5sGQ0flAMMp1vwfvu29GHafx+QcDNf5+PUtqmLyJVtUYnHoDrRGjP9zXsaojGTUnG
    RuCkmboQRlND4EIFMZLSEPyodylqajX8mOn0NTkfmP4reAv3PsCGNeJs2aAfhoL5Mo9X08
    nb/AL4KWAtxj2UEn7KmODS9DwgR3mRg8Rfv4vTkIc4IbCsYrgm6vLJym2jygsQfxyTRdXb
    Vvj013QSv2CYn3n+bmmVKLRLF9ushtdpJq4CSvMcXpN3SHEnJY1qZujVvZ5g
X-ME-Proxy: <xmx:fPDkavbaj66p6YDIhM0r93WllMW-u0LaLrdwm12l99JyppIfJBkKCA>
    <xmx:fPDkamCamzT7BDTT_lKFU7a-EakaLyElYfdqDc18C0MH5X5Xrf7kdQ>
    <xmx:fPDkavn121H9FRdu00G2uuWop1b41TIFJBRH2XgeCQYKpJbgPui5Rg>
    <xmx:fPDkavwuvrynTmK1CaKtIyD6iGw2aVQRILrMDfe7TzN-yIWuOSGAFg>
    <xmx:ffDkaur4_9L2o0aBs3sLkt4MSGRB8Rt12NMNcjuImaaLKfkN7__LDP_P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 15:31:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Omri Sarig <omri.sarig13@gmail.com>,  <git@vger.kernel.org>,
  <julia@jvns.ca>,  <me@linux.beauty>,  <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5] doc: git-rebase: update incompatible options
In-Reply-To: <20261030192719.8KtoR%taahol@utu.fi> (Tuomas Ahola's message of
	"Fri, 30 Oct 2026 21:27:19 +0200")
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
	<20261030163841.31840-1-omri.sarig13@gmail.com>
	<20261030192719.8KtoR%taahol@utu.fi>
Date: Fri, 30 Oct 2026 12:31:07 -0700
Message-ID: <xmqqse1nugsk.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

>> Thank you for the review!
>> 
>
> The range-diff against v4 makes it clear that v5 only changed the commit
> message.  Unfortunately, the reroll introduced a new typo:
>
>            section from the option description.
>          - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>            2021-09-07) removed the `--preserve-merges` option from rebase, which
>     -      removes all incompatibility references to `--ignore-date,
>     +      removes all incompatbiilty references to `--ignore-date,
>            --reset-author-date` and `--signoff`.
>      
> Otherwise v5 looks good to me.  Thanks!

I do not quite get what "all incompatibility references" mean,
though, with or without typofixes.

Thanks.

>
>          Additionally, since 414d924beb (rebase: teach rebase --keep-base,
>          2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
>     -    it is not mentioned in the INCOMPATIBLE OPTIONS section.
>     +    doesn't link to the INCOMPATIBLE OPTIONS section.
