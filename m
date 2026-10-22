Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792650320;
	b=V/0/yRMBOGJ++dAIfq9rvMe7O25H9DJVeRkg/dcPF+Cgv9B3Evizfg3FcdL+6EXC6CCz
	 cu/TEHUIbsh6yPtScTqIrjDQBKpw+POodCPV8Mi0r2t6jC/Lx70tyeXlbIc2/BjoU/pIL
	 unXuMYWuuQH+Yf2KvDc9Okx8crn2Ux7a54haK8+i9KsDc0vOYdz4Rk3XjEkiy3ghFvwBL
	 mLa8GvPMRfewewbIPDu3eKsXriI9M/cZzqJqiKGcZt/sD7j0amD4fOAQgZBZU3/sa/wUi
	 qK1TnE7mUGDkVHvlsz7GLANjijmMfriM8+UXOe5nkt5OL+HPz+EMhrJzmdRHbpYk+nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792650320;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cjpQcHcs3vY3/icILVQChD6rwsxTnz99JUUNY8uMfm8=;
	b=lASqPqx2EQsTgKI1G81f87cMaSLKEOk5QhCqqNTzr7cCvYOArTL5nX6FRZIGUzwohfni
	 KQYudZ+9Ebf3wrW0Plby0NP2l4341N3//Mrs8N4XKmDPItPbdqd3obRT1ZaAFesszx/Km
	 pPiNB5SvW9lcFazwYyz6KT2MJoQCUqBDzSG/RNBMLketQESRYFz55uHSa7i2JP3JrQEQB
	 lXRoXBZg+dM3STNZ7+8EwRP4OuR+j5TX+RqJBWGL4yzg0oUGfG26OTUPxweT4ptO1qfwz
	 9kMxRzY743Rqj1jA9Agf7UsYydRkXbP3HW5avf3fG20W7jgxufszAAcIjZAgbETLKbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=N0neama8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hv78dAzT;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE11606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE11606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=N0neama8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hv78dAzT
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 58E9E1D00067
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:25:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 22 Oct 2026 02:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792650318;
	 x=1792736718; bh=cjpQcHcs3vY3/icILVQChD6rwsxTnz99JUUNY8uMfm8=; b=
	N0neama84gPh4JXhftHRBWT0ZMrjGUQWRL/BJ6AJqZxiwZDOwowMUW9983tNPfUC
	0HF5O8AnHPwOrLJnCtbIIu7rtMGnzOVlK3myqQzuCeQv/mMx9iXre/OJmGJI9f1K
	0UJTclOP0ACxpdVQSSLw0Ea7fMwe0d1UxEGhSkAnIyUtjfkvVQk88xDCc/t5l121
	0oL9Esa49hhmoCHrrsGYOlcr76+wDjDLb1tcxW0V/wzumIqYEcqrYjlpNZrt9B2q
	Rkd/JRZOsfMCLB26ay+RjFBuQsAbm3Iq3VEAIIFWPZBBSAeC+lY11fjOETK0GYKp
	vg7jKmdhTVDgu/72Cl7sqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792650318; x=
	1792736718; bh=cjpQcHcs3vY3/icILVQChD6rwsxTnz99JUUNY8uMfm8=; b=h
	v78dAzTB90WHajunKEHq7deHt14dqMCA9B1a3lqMepKHlWNhph/Du+oh0CifnbE+
	XMl5MH85c9HUmi6uHhVcCnC6ZKslb2CMtyX0+QKFidigtxRfDVS2c4x1h9339e4c
	arWE1uFsa9IsoVGCYwZu4DcIovJ3f4MQMpBeF4exb/wMmlyBNRhs1ZIbChevI7I8
	ZotSTsrt//Z61Wj7kAsgzbWGubwW7DQPqRKaMUZ7d8o6gUy7t1VFLG0WP9OsPv70
	2sI4IlbiWMQslxoUTC9DhJXJ0HhxPuIqLruTCcdzi+o+BdInkVSkysODWQL8dcfq
	+rWoRV+E5CjEPgks7S0Og==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792650318; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Yp2Wwi6Uuff/EUlThLFFjvVp+EmTntua9Es+Etkd0JprE4H
	KsdfnF7dJQY3Ag25dkAnVSSHBK7XQA/Vlf5et3i3WtH7mG5dwikDlHmTGujj/AaN
	ClZOpJ9FTQHIA9IhQX6ROQ3q1oWW1Lrzw5EGMOCUzApm8bzf5hQxxLS2MxpTOMZE
	Gl7JK/1NeoM15/w8FTyQQE6cBpHcsyXcYn4sUGyD0QDOGj2A2Y149fqIfsibWyZt
	qJ7jXwJAy1zLXyO3iAXAsjLQZ4UGWT3L+vQYaq/3rVdI+UdXep2CtatmtyW3mOjD
	dPslCYxMBHHpu+55+shj7t3qBLNfV6yAaiynTdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VOZxTGTttpUdqBfMtuDVp6z3iAc0nY2fE5E3VsGtfdg=:ofBvIIUkMkr3t2jsjz5rYAt62gf0Dw6ifONp7bNF5Fw=;
X-ME-Sender: <xms:TqzZavcrjpw_dAD-DCnSaebMYkgjNKnW5PS1_Nxx5plqlX1elj4M8g>
    <xme:TqzZajCw3PYkRlQ28JZPfMjj6ZCNmU3pNz4NWlpTnLo3FMvW2veccHA5uXcwUCht9
    aq7gLNM6yLxsv4Q5LkE8mYQxMj5c2DCMcROTUvalTvu4AZROJuOe08>
X-ME-Received: <xmr:TqzZai9awxvyBCEZYfXzoQvk5SJLWAGd-qOkeIaCD6fGFFiNuWc1ur1veWVFufgz-S6hTA>
X-ME-Proxy-Cause: dmFkZTG4TOnWAM1417TOgFYEZ6BqbFXGfzjWaroIB5rPzUxMhReTbIKW+m6m0/ertXhDZ/
    74EQjmt2YFb54i9dQev2huFN0NZ5DSgt5MpXcosMYsz9/F9JfY0rTJPEjS8X22FSaY45Mg
    b4nMOL71Fb72c56luHl1g2O+khzj5HZhjCrrGfOIKufaQRK4clUsaYZ7/EcU2rGdA4n14b
    inweRintJA7TAawOSs7mfdXHfQoRGTvxST/EhlPDBnz+dwhWdV4hMBuWbfEna6MaIWe6FQ
    nhZ0A542Ca7XN8BUAjdabsPpofZUpI8Fun44WUYPRFIzcOV30qNWKjcbUTsSf59g9i0Al9
    nHTR7c8OUOJXcWS3UwKtcu3kqhvz7PgU7iFX6Hy+gLnYvth7S+V8KNAqbqENcy/Dz5QBu7
    XAgbtiFUwqjp0OqJx6aY9OEcD7bs8CmGSpqLSGN++mcnh+mN2oI0Ag/k+ulO14e5int7Gx
    BnF0B+cziBltAqAOK0+vkN5L4JdlV/v60+J5ntJDkMIDwEsq4t0191c1S9XI7dwjG3w45q
    gi2dMhXEk1qoGLL13lrd+E3TfsSRZ0fkteqAAdNOAgPeNAESYvMRdI3FVt1ASn/KONyXTQ
    4mBdnLnlZpdYxj8E1KRAdQhup9+J4UrRW+OsASmN6dYkd5ARq77d3z+7J/JA
X-ME-Proxy: <xmx:TqzZauLtHYmfqLISRhvNx1EPlj5rBZiwhNVQMKiR1xvc-k8wg7IVHg>
    <xmx:TqzZarhouhVPCVOSMSbcq0qkqXFxUGXX8gqPhrt127yqMLitrvrKvw>
    <xmx:TqzZau7MQO97yslcPi-ZuWSoxRSlY-6oBwDCHCRFB9eO5EasETbTRQ>
    <xmx:TqzZajaoLwkHD1gK8yByM8ty0V6XIURek6cPiaCM3iYCugVsVYkjGw>
    <xmx:TqzZauyoITMjLLBKsOFjNFf0MaOTZTI_2aNi0NXTWNKCwGmMLBefKNtv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 02:25:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27ea807a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Oct 2026 06:25:15 +0000 (UTC)
Date: Thu, 22 Oct 2026 08:25:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian =?utf-8?B?Tm/DqSBSYW1vcyBMw7NwZXo=?= <chris@nortesoftware.dev>,
	git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] doc: gpg: say which date SSH key lifetimes are checked
 against
Message-ID: <atmsSIJrFhA0t1rH@pks.im>
References: <ec4de165-c7d1-43d9-979b-08c1cb67022d@gmail.com>
 <20261021030347.565306-1-chris@nortesoftware.dev>
 <xmqqqzhior8t.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqqzhior8t.fsf@gitster.g>

On Wed, Oct 21, 2026 at 11:14:42AM -0700, Junio C Hamano wrote:
> Christian Noé Ramos López <chris@nortesoftware.dev> writes:
> 
> > -Since OpensSSH 8.8 this file allows specifying a key lifetime using valid-after &
> > -valid-before options. Git will mark signatures as valid if the signing key was
> > -valid at the time of the signature's creation. This allows users to change a
> > -signing key without invalidating all previously made signatures.
> > +Since OpenSSH 8.8 this file allows specifying a key lifetime using valid-after &
> > +valid-before options. When verifying a commit or a tag, Git checks that lifetime
> > +against the committer or tagger date recorded in the commit or tag. This allows
> > +users to change a signing key without invalidating all previously made
> > +signatures. That date is chosen by whoever creates the commit or tag, so it is
> > +not evidence of when the signature was made; the same is true of the creation
> > +time in a GPG signature, which is set by the signer's clock. Relying on a key
> > +lifetime is therefore only safe as long as the signing key has never leaked;
> > +once it has, valid-after and valid-before guarantee nothing.
> 
> Saying what we compare against may be valuable, but everything else
> sounds more like an empty fluff to me.  Isn't it self evident that
> validity time range is a useless concept unless you cannot tell when
> the signature was made?  In other words, instead of the long
> discussion of how useless the validity checks are, something
> succinct like
> 
>     Since OpensSSH 8.8 this file allows specifying a key lifetime using
>     valid-after & valid-before options. Git validates the signature by
>     checking the committer or tagger timestamp is within the validity
>     time range.  This allows users to change a signing key without
>     invalidating all previously made signatures.
> 
> should be sufficient, I would have to say.  Or am I missing
> something?

I think explicitly pointing out that the timestamp is under control by
the signer would be useful context though. It's implicit to us, but it
may not be implicit to everyone else. So maybe something like this?

     Since OpensSSH 8.8 this file allows specifying a key lifetime using
     valid-after & valid-before options. Git validates the signature by
     checking the committer or tagger timestamp is within the validity
     time range.  This does not provide any security guarantees as the
     timestamp can be chosen arbitrarily by the signer.  But it allows
     users to change a signing key without invalidating all previously
     made signatures.

Patrick
