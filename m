Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622303;
	b=ss1RyCi3QHQZqD8KXOr7souMqrtD0XfN9/aMfA4P6WIVxkL3lZuLi28YoSE3xL3OVbZB
	 7vScTZVp59H5lgEAe/k+fRpxleSgE56kDqYiZvEuiWrCdQ1QiifHP93ALl2WW0qwe4cv5
	 lPfQcxRUfWxjiQCW89JFJNLFx5iJ7KghyOSJPk0dH4KgA50KR2RvM93btuld+sbMyqsrb
	 JY7ApXqFgc/NbKEX/rj8ZzDcYOxbo2b4VGTeFd5CLmHFn5efa4R3CCbbj1TEuw7UISTOQ
	 Km9Db/CrErMcSM5iQBhFbupcPOcHuws7k2deaJOctkRwVMUuBEuVVSEIXFPJhIjlPRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622303;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IJBDPDBdqT8+0s6IE4BGvNkWIo2aw0wEGCAO+yTwd+c=;
	b=xjYXzsZFwIDqFSK1vrKKm6p0qxwwa2hNj3EKP6azt5deUh/d+BZzO4kHL5Rq1SdYd1sA
	 +alUhU2o+5eJoLn/3P72lJPzIxcIsHq5kuCRZFWoC1GtbZ5Dq9fmRrhPos8LSthf1LJ2H
	 UJ/L51458MaurViYj+3A9ZKQC907L0cXqIviIjzQ16Z5SpEbb1PrYOM6lIk8Yqhdl/2ZM
	 6F9zypmcYX6yRX8JIrvAXdiPYvjPrZk+rVWdQOBdPKRUjw+YlM/giXFnDAiSQiO9TrCkP
	 xr2nudN1L038tJ7nvuelJM0tbNvNyCPkkMzHIuhPihuegLZOV2LHq67jo/7YhEgukRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=J2RzL0Lk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZukNni2l;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CB606A336
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 753CB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=J2RzL0Lk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZukNni2l
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86EDD7A012B
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 07:25:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 07:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793622301;
	 x=1793708701; bh=IJBDPDBdqT8+0s6IE4BGvNkWIo2aw0wEGCAO+yTwd+c=; b=
	J2RzL0Lk9Lug4uFhYnucQ5uwmpCacv0OxwUgS9q8D62FqvOrvGNBC+I/9DAqfA3U
	cleyoucsDj+6Kdwy9SOGKW8zbkNSOpDPnuBDRDH40C23nx4G0JFfVtbZubUp0j/g
	CU6jUsBCbfRO5NpbKXM2XuO7sYICbWTj2ZukiSzj7sGEl8O9jk60f0Vj0ZoHOFcF
	Z1iPrF3e6xqthEXpRZ7d4j9QS0bJ1AD0QRvlvVDhajM4Rhk3E8nFeC0PdoCrjFeK
	Twp+JkPmvMjgthzZuB35VtvWFakrhAzlQgF4gj2+SqhStal02YRbQu9mTvUP632f
	UPYbvWypFOm1BbP4zMbMpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793622301; x=
	1793708701; bh=IJBDPDBdqT8+0s6IE4BGvNkWIo2aw0wEGCAO+yTwd+c=; b=Z
	ukNni2lPo1E/gbAMOO79KCWCTP0tjy4OcGYLwA5QERi3yhRrD/lng5RAc97yRhJg
	KlfuBiNkLZK4LmeLcDv2H0we62OzELP4mYniyUee8pJ/9f7T9yDsR0fJyK9szpwO
	V8PAtWHgmsKMuOIgXDtlgKCxgqpVkPrdHreTFv+jeTCdz63JFgHbnfdo5nVj3ots
	oWsmeRs5ketNy3PmLoWzyCa9oInMLGIbUiWUYUS++oQ3wziZJpBn+8vEh2Aw//Da
	iHqIAI2vrfuV0R/KOST5U5+QCO5DKkDZ9ges1jzpF6V9jSSzcZQ0oC6eKQ+ee0rz
	WH8rNl95KDqeRyBKYTYSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793622301; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ue2Fl/7gyZlNvV+Th5HdglUYsmaphZTYSEgUhra3nf3G4CD
	eMnkiobgjAQUCJRKbj/lDlSERR4DrtOYvNoLFzAgIRuKrlrK+D6fK+J3RPXUnfKb
	IcdVHoNssZmNwv5SLY0Bz5Ikyr263bpxrfI8ODPQJ8LA3awu90emTT7cdGRnp2/T
	gTIEr7WkRyS/PtZbY68VMYrfG6+hX1kA8Z5qzcPrMd4+s8B9ooFwm1odkGfRZN1p
	VdxSPCIqUk/GdXHK691NxfPTiOZLzmXfr2RIKNLg0UVRgu4UuSPEnOpKCtUbeMnx
	QPaQJcJNz27H/GpLi9tU6urIhoqfMRxl1N3q81Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:BWK+gqXMM0WA5NrzqTsvDxL8sYZKxlTtptwrxozomtQ=:vgutdZpy5n1wSBTW10JRWlfn5mxDyL0DmuqUKXxeZxo=;
X-ME-Sender: <xms:HYHoakpEzUh-zfseZfyUqXnYj32hq4KQU_bnSIXlxFxryQS5TwMoiA>
    <xme:HYHoauXQaYJ3EuAvXNxmm8u4TwNgFRqebR_xq_5y91tsWY6fHVylVPHW8mWdUCTaB
    kz0Jpv-uRPk5Z4Y7VXvabFk2PS5OIJ_V-E7XOA7Lp79F6-_ZfjwmQ>
X-ME-Received: <xmr:HYHoajAKmwqHR04kMoecuE2ENx6D0jTZDvaTzg5xuQYi1F57Wb_YUmWaAPSqyJHjPVwUAg>
X-ME-Proxy-Cause: dmFkZTFJUhUpYfNTYfaSBPcS+yWzqaS6+jgEuvv8nBaAMH3hfwwitKpt2n22r9gADKSPGH
    b9KECqm1aOc++fUsfdcNCseY0UikOtOIuuEU2SLG8PD5vVicC7KeW64jU1wsHHddkiegaR
    +4ELulp5wLP1P+LGf3R8j+d6Y9HOTi4TqWNwg+YhFvB6FBlfu8B4UdmSnlpUdHlixD+KUt
    qxXuvMMVjhLF56BnNrGr7O6Q5O06cqUu2P30ydjfN6KU4x448naGSQN6KZ7oQ6iVDSliL/
    Fm4SY2JI1Eu3boXz3L3e9YbQ9nIh/IqkVOkMwsOYrc9XgOhkSc4eHADCzZPPrhzUW5B8Ug
    e7beppBMhJIK6dxacxkD95JXukP2nhGVeSMKWyYF7eD10nqLBXKyURuahlxw/dhC+6Jnf2
    5Pjck1hL+TfvfCJLwxH77zQpWPf5xTkn5r1RtWpP+3g5kyeO7CflV7J9nKnC5I/hcj3EN/
    DqRcfeumTUpdX/pZnuQf9R1ON7Sbk5qfyu+feWnbIFrfr2s59l65sO1LzGe3Hbxubw/2yX
    NzrqI0WlWCIdsuIV68zvKgjk5od+AyiCNN/locaT5ZKAfA2qJv4+TfdD7Zy8RMaevedAeo
    NUTmGktsLP8x2ig/RVToyoyCb+LmdRty+EGIuIsik362U7kKr2AqrYYiwQ1g
X-ME-Proxy: <xmx:HYHoai3mV7ectqZc-z8fxbdbcKV6GJb4KgNwzjN_lgnK3160Bywckg>
    <xmx:HYHoal0-K6fMJXNAP9u4NVANIowfNV4-LsRxmvxA4Gy_nSed1YmEGQ>
    <xmx:HYHoanA6Xbq-am7e8vMtAd90VzVwPcwxJpBoqxk0glkx9lYG9KGSpQ>
    <xmx:HYHoak74eiluNGhq5RgeAZDbRnKE-aa20VF8-Xew5KNK8r-6-aEcLA>
    <xmx:HYHoasOYkvgidtNhwcdebvk5z69u5Cn7UgXInRlZFEN9z5Kkcplk1xJz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 07:24:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64c90467 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 12:24:57 +0000 (UTC)
Date: Mon, 2 Nov 2026 13:24:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	GGG <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
Message-ID: <auiBFhXI_xiBTPbg@pks.im>
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g>
 <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
 <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
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
In-Reply-To: <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>

On Mon, Nov 02, 2026 at 12:07:29PM +0100, Harald Nordgren wrote:
> > > Is it possible that maybe the review process needs to change if too
> > > many things are getting stuck?
> >
> > The regular reviewers have been talking about review work being scarce
> > compared to contributions (contributor work) for at least several years
> > now. How can this be changed if there simply aren’t enough people to
> > review everything?
> 
> We can loosen the requirements on perfect code, as long as it does
> what it's supposed to and doesn't have security backdoors.
> 
> Many things like tests, leaks and linting are already handled
> automatically by GitHub CI. It's a good time investment to automate
> more, because it frees up resources long-term.

Even if we automate more of it, that would still not fix our bottleneck.
I do no trust automated reviews enough to just merge patches without a
human review, as part of the review is also the conceptual direction
that we are moving towards. And that can only really be reviewed by
someone who is familiar with the project overall.

Now automation could of course still help us. For example, if
contributors started to self-review their patch series before sending
them out, or if we had a tool like Sashiko [1]. If so, the human review
would happen on a patch series that is in a better shape already, and
that would likely require less of a time investment overall.

Granted, at times we err too much on the side of polishing the last tiny
nits. But quite often that's also us trying to train newcomers to write
proper commit histories in the first place.

What I would very much like to avoid is reducing our standards just
because "carving in to AI is inevitable". I've heard that argument way
too often by now, and I don't think that it's a reasonable stance to
have. It is very much not "inevitable" that a project must move faster.

Patrick

[1]: https://sashiko.dev/
