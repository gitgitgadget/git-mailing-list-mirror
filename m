Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792736477;
	b=cfATUNNTPWtOuI4cN+Qv95aE4d2bNyo8kefjY+H/zn3uVQSafCbh5DUEj0thQtUabZE0
	 wzwsPLeF9d8nUHVNhv+ybXQ+/4W0bdESKgBtynS/kmebim3yGx30JfokAwOfF+Cv+t1a1
	 qy+aNcVI1Yo8NNITVGfVznnGDXfXlR9T4GO8UaW8sBPkm+zR6uGniDm9xbHmnNNoJx2jI
	 OIHM0Rt+u1kYR+NP9efoqY6l7xyP/AKHuv9oTewefNHK7jhhZeOhi+KtbIZ3vvAqYLaiS
	 kQjuu2SOwFQtIS8yDbBoewzh0Ndf9dtw/JSjrZ+edasYE4AzTngQpFxxYqQjnKj0FzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792736477;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=xdS/d3gAogEsLQf5DQFtvmELaSq7I6QsXA/f2QCAETI=;
	b=xn+s+0PEVMoKgorrfC5mYcuXuyyANxpLDVFMvMqafZr/VfauSXVgV25ypVqCN7rw6Fyk
	 /VoCFAEZlvXm4bI3mYKkNiSmB/naRLLDHcmdqs4OqKOItXTA9wWblx6KopO/qSrYgjdkB
	 th5ByUeUuCEY/eoQQx7DoJr8ofH85lN/I3OwVAqK+Wb3oyHk9+7A37mhRuii6V9ShItc/
	 XVbkftlhYM7ifLt13caX+hGmluk9uNJhtzKeSYTbphrqzcxG9aNQOZifZH8uLHu1iI1wL
	 MdUXexEeE9hXo4teN7HooJFtj25YNmnTld/N2wzXAUSGEDuxrI+0UBq/i6X+mCBffYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="VhnKwp/r";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QZLVY8SG;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6FA606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VhnKwp/r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QZLVY8SG
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CA081400137
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 02:21:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 02:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792736476;
	 x=1792822876; bh=xdS/d3gAogEsLQf5DQFtvmELaSq7I6QsXA/f2QCAETI=; b=
	VhnKwp/rWN7y5FBCDDHfINT8cNC1tv1JfYty2PvlipPmz3O3SFcvjR3bj2OmIlCh
	kRakvyg00N7z/BzHRXk1SrGKdrB4R5osz+xNC2exee9RX625D2LFXzz9U8NxeiRa
	ze9YLL4fD/kNbp5O7r9t8Skx84gPod66JhmgXSI321o6ff0Fz/+mhZkkJ11wNqKY
	0WNQaNFarQvfziNNt1dVoxb6EmlWgHPO6MuAcKByGVaHletUgQKhW9bPKw6w8vEv
	sRWN5BY/kshlt/sL9bdxCBJpviIshndnahzO+IHIWlHoiZPO4O9fRVcS8jIzAziX
	RhCVOOUcOe9N/w6CowSygQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792736476; x=
	1792822876; bh=xdS/d3gAogEsLQf5DQFtvmELaSq7I6QsXA/f2QCAETI=; b=Q
	ZLVY8SGgnRUIS/7fdDauwA6k1pnDIXCAfQPRpuNJRNKfBn9vvusgJNiXBubkq2BH
	Z00ZDHSPH80hrPdWDm9t2n5+MqVCOfCoXroulR2plr/hzb3PClyh6DCqV3iCEguH
	bz/4jKCAsrNW3ek+iGrnZ77182LJrGIwPBfh1ZV5tufFcz9gvPMz1eLy6f6Rzj9z
	bDXDXzWSFo0AF0ABLX5GxYDHM8XtSHBRIiOSRohBMPVk3vghyHQG8Js8y3+SKvOA
	+Th/oa3GbUoLMujpifwqYEcpQhpReWJEYAydOdue+Z665jBtDBsVblydLtwu6J7J
	QqEFaDQyaTxozwJIGnNXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792736476; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OPR78ZW50ViXcp6xqEigvj2HLSUShAvocHK6wjA0fGim3sN
	msQMdqXQBOI7oWrf26MfF46g93mHcvs7WrAt6asKcghYsO12akRomiNyh+QijYaq
	MI2adQ3usXlcxy2cC8zCkMfvSUICoeXSLT6II+l3gz0s+h3qRJoWjqjlQDY4wNP3
	TxKRDoASqT+ARcAtZcD4cb+IoK/quqIjk0++nPPfiDLTkzTrsNf8qxH6WPvkbjjo
	4gjgkRYVbHT8tWCPRzL1IxTedNEQ3Qtq3msR4F1fxUvnxRgY1QmDeYoX8h0JEHT/
	WXH/uPpA5ZtgLlbLkSRJl7r0yDoDkHvrz1H38Rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pP7jYFDIei7UPwC+S3qR78/7vX3ZLWFXIg4OPFCdvsk=:K5J6o+xNscJICqPWIWdMEwEIKFdomcqJ0ExWKaLIQPg=;
X-ME-Sender: <xms:3PzaamECl4ji_OtmekMWmUhqiuES92sGAjNqItVCOfvCBB_omBadkw>
    <xme:3PzaauMPCD-joPgS5-eergyo2obMTdOb-7Xqnwtwn59AjIF_F8LP90eGcivZt31hA
    O60sa1nOqJfwKGtWw4H2Y7Pp2JLD6G1CKv3Wns3HC8wIWN3felLO-Q>
X-ME-Received: <xmr:3PzaaodICzf7xishCvTljwuMmF0ljIfnQVJMN9jnt1ZsO5lOZ6USrtNPwBATAOE-TzTHxA>
X-ME-Proxy-Cause: dmFkZTFdb7k+le7C7dN6xonIuqrk05JAQx0Oe2Yw6SovV2LEmeGwr8nGZjMGQ8kV4D7Bxu
    g1E3yt84RqAzgIEr6IFXOD/oxjzYTd1+TfAJeWA/VskBPfr91EH+GZK2S7j4a6EoGE8uLC
    59qt1+ZmJyWKd0xec2dwjuTukD9uPyH9t6HMocvqFqHCdh4ljenvskWOPXLWyM15ltae8m
    k93I9uKO4bo4QB6mp19rzKRB95Jy/1ZLCj2MDdQ4dnpdyUkMVf4wqsd22Jp5+9kEW+HeUl
    BTocF07VpTpfxCKDD0Zr4jP8PxZItHCRYEuBD0KuBzhB0F7cR5UfZG9b1Yvi9P+UOPJGp3
    avPZJeh1cOGYGDJZ9ysl5QKuV9AlbbLB+PYVTjElnYK/D0I0dOWy0qaC7D2hIMIV8h/KAe
    CvAwDIye2qPvCsf7hac09Sffv9s+XUKFCU0Yx1fa/fScLi4lZjz2tpWqecWmrYkT8l75oD
    yROQSdANcz55BhrU4tz47n+QJU2/RSve23BG3hzGD4GbDicWWZ4/zJWZvRVSnTIQ06lMVl
    PkWZW2QG8xJrX36S9pRPbXXlYNGqU559wb+JNs+efs7NX4QVxAGbQDlwdwkBrClvMky/jU
    5U+awzra69WxyToJhoOeNfN5+R4ezJUMNuOKlR3SI4D5JqP0pWfRoMfkgDDg
X-ME-Proxy: <xmx:3PzaartVDAfQzKbGzyF-fDzxmNDLBpQ7WW-sWSHRtRKcMYy4F4sYpA>
    <xmx:3Pzaapk_wHwCFlrkBsU_VN7rybDGoSGS0IwlKxiX7DWeYeD3qTLgAg>
    <xmx:3PzaatzjBiqEtWVw6TEXTy88IgXY0hjU9eDJTUC8YIEKZM-Fk75Hqw>
    <xmx:3PzaarP0r0I99wflXirbdAhWQy8CqY-bvVB2plULnm4zUcD3LL1_qQ>
    <xmx:3Pzaak-axzVb0j6aSeB6ae_jMZ2wrx7LV9UUXOVVUt4G2CZDPEVN6ra8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 02:21:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee2e0c85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 06:21:13 +0000 (UTC)
Date: Fri, 23 Oct 2026 08:21:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/5] completion: drop "stash save" completion altogether
Message-ID: <atr81upZrCofQACJ@pks.im>
References: <atHZ0gV5Pz80l3ho@pks.im>
 <35E6B235-6370-4F94-A0B1-4B6A941D8C47@gmail.com>
 <atcEqHErXaGiMu4J@pks.im>
 <CALnO6CCUfja_AxYjbz9xpZgoibbdvy6C4utDDQk9ONhjiOYYzg@mail.gmail.com>
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
In-Reply-To: <CALnO6CCUfja_AxYjbz9xpZgoibbdvy6C4utDDQk9ONhjiOYYzg@mail.gmail.com>

On Thu, Oct 22, 2026 at 09:14:52AM -0400, D. Ben Knoble wrote:
> On Tue, Oct 20, 2026 at 2:05 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Oct 19, 2026 at 04:01:15PM -0400, Ben Knoble wrote:
> > >
> > > > Le 16 oct. 2026 à 04:01, Patrick Steinhardt <ps@pks.im> a écrit :
> > > >
> > > > ﻿On Mon, Oct 12, 2026 at 01:48:31PM -0400, D. Ben Knoble wrote:
> > > >> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
> > > >> deprecated in the man page, 2017-10-22) and the previous commit removed
> > > >> further documentation suggesting to use it.
> > > >>
> > > >> Since we recommend push instead, stop completing for "save" and remove a
> > > >> special case in completion code.
> > > >
> > > > This is the only part I'm a bit torn on. I think it's reasonable to not
> > > > autocomplete the "save" command, but if the user manually types it,
> > > > should we really stop autocompleting its options altogether?
> > > >
> > > > Maybe the answer is "yes". After all, as you mentioned in the preceding
> > > > commit, the command is deprecated since 2017 already! And after almost
> > > > 10 years I think it's fair to start giving users more nudges into the
> > > > direction of using "push" instead.
> > > >
> > > > One note though: the command _will_ be completed in the case where you
> > > > have GIT_COMPLETION_SHOW_ALL set
> > >
> > > I should definitely mention SHOW_ALL; I’m not actually sure
> > > what happens for « git stash save --<TAB> » with this patch,
> > > so I’ll double-check. I actually wonder if it will complete options.
> > >
> > > Would that satisfy you if so ?
> >
> > Probably depends on the outcome of your tests, but ultimately I think
> > I'd be fine with either of the options. But if we stop autocompleting we
> > should definitely mention SHOW_ALL.
> 
> Here's what my testing showed (all Zsh):
> 
> - with SHOW_ALL, "git stash <tab>" lists "save" as an option; "git
> stash save --<tab>" completes options
> - without SHOW_ALL, "git stash <tab>" does not list "save"; "git stash
> sa<tab>" does not complete "save"; "git stash save --<tab>" completes
> options
> 
> I'll update the commit locally to reflect this. Thoughts?

We could of course add logic to explicitly stop completing options for
the deprecated subcommand. But I doubt it's worth it? So I think this is
good enough.

Patrick
