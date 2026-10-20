Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476335;
	b=CBF8WyEiCZscjjMQAiLexCVTuSQdjwtH2kmSWGX5/38Ka9lbSvt4+OFYbSJPuPVBoIrN
	 rXXi/RalSJsLVj9wOfVE4iKHAj0rlRhDKdj8DJ96AAZcf+PB1umY9698EiP0yXVXT4RL2
	 sWTXQrridWpeNZvANJXciXNY8zcQL3K/pweau6mxFl0OOI2yyGhB+zRVlBy1SnhG2oIWu
	 r06T+nvVMGyYuRBgXetB6XN4TKZBkWGHf0bFlHBSBfwnhDKE+VG99xZd/93wdp844rYzu
	 gIJVDRXgUehnwZgwk/AKS60o+23waq5ZOlgkZc69+B1Vu1jbMuFjy48ZamNmNuJ/Bvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476335;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=B9qtVVDb7qOOZVTVwOq583YYpxjPu28flDO9I1XJokQ=;
	b=ykjPy7WMVSMHouzQcIueuEMEAdfp7C9NjtPqiGGIPfTDKjsKe9F9ATB/54JXLwqki/Ad
	 muxYC7FuWk+5qU4pFzK99u5raHH96uX6cgqI+x75jLM5F3PzGE/l8UZqBfUvHyS2hwYbH
	 2TTWNKfFGKyHeMRDH2ZJ7t/R1U4EJvzDiwfZeTkW+sYxeX3etBp7jt+gUTmi9CSHVogTT
	 8Ujq9oyKcAE+Qc00sJ/F59yhHecmSk2boqmsUf6ZX491YCTfru2lP22/GDqALU45yFZlE
	 4gIgCCza6JOkrhgbEochDv7WKcnf7ii3cuRizC+9hBBt0M9+fK0NkJWNPqoCNNZd9Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Mq3gA3Qn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=j2Xt+UQm;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EE606A31E
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28EE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=Mq3gA3Qn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=j2Xt+UQm
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB20314000F7
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:05:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 20 Oct 2026 02:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792476333;
	 x=1792562733; bh=B9qtVVDb7qOOZVTVwOq583YYpxjPu28flDO9I1XJokQ=; b=
	Mq3gA3QnJT0XZOlX4j3Ggk/YOMQQIZA1bL64ac5I1BHPCcD2naNEOIFhsdnoEVnk
	DXNrWWLOpuOHZbw8fZYbWGAaV7TqUcTdbNlH6V+wil2XRhvD8swZ2QG2Fb6gOO+y
	CA1EIRt3Wxqc99lf12Xp45yW2QCcxr4RNwDgvnNT/QXBsZwqDP6KhFD3FfB/W45D
	WOivDJDXRIwj6HbjkrIFsV/OsRwRWUw0IYNZBN+Sqb3+iGtRrRwhJ4u5e2UkwW8w
	tPjLNzzqTMwuboOFqHReDh5o/x9OOHjI05zXcQXsSdFbIj/NLYJq5Oqc+UYpbkyw
	TPGhWFIaO0nABSSUSgGtLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792476333; x=
	1792562733; bh=B9qtVVDb7qOOZVTVwOq583YYpxjPu28flDO9I1XJokQ=; b=j
	2Xt+UQmHewknCg1vCGSDhetdN/qqG6/L5bP7pEOxPPOFs0szerawvyqIpfIqIbE3
	HtLHKNqgfCFUWDWaXeltXNYfgriU+xs8kiX9OCNiuWugAAgGuUyyv5v3PW1+sOjG
	t6lzcHUCPLmZEOxND/qJhTBSkDXJoZHNe75yRmIU/chD+GlhTgd7PSPNzKSGA6zP
	+ZAuuFlmMRc0t6TEgAFyCD5WiuqAelg7x7YX5r41Fyb00+2lGknk9sdtd9Gg2Mn6
	bfykAGDaWRwvGXSHOSqYJ1NRSOsBxM2j+DGxomnNt7VkIquJnLjSLYG5gr13LMNu
	URh3wjpq0CBuRpdyYdDFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792476333; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:YPbd1Xeb+LbXsGKX0rdwoOSh7/rc9g7tg5JstteplLWb1OA
	tHGp2oI8W1OxzPAFDTcXUmcEK2tZBJiSvaq/dE+Rd/Fas5HDnHM+ErJDpBLlOvyi
	3MzcKm3ZAbDeY3dDCd8QbCuGjul6089KZwucEeOLdkV0yV0xsrWgeDn8LCjL4G4f
	vGPdbxU1Bq6teyBzjGutjMgSqPu5xyTC8Hrt3R19AabO4T0nX8sTaVW3LLDWLET2
	7FRTYii8gZtAVubI3IiC/kc16Zidomzjew1ZC0wBsT1r0N28laW9EJr7dhhMqoX+
	lZjq4QOvpabZsv3Q/vLxvaNpZrxtlSNHzOlz2+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:4LD75upZWkDMHBdQJE6gHFgUFyZIvv/fM0zkmWD/Ebg=:5a51nWgmKyr6DAqKbvmxj8GPOl7oyGMHiXkI4p5ibz0=;
X-ME-Sender: <xms:rQTXanj1gDGBbmFEHBD9wvDRbH6qIW_ic2uaa11Ho-yH7dvH_6vzcg>
    <xme:rQTXaq46P2ZPCkvuXtG-I2LAMN7BU0hT0XyfnZ-tJD2gXqwvAQHbxiMQ4u04e5aEX
    aZFXYhwR8sPWFcNaiZAZv2js1eXTaMd00bpWKQiDVbBUDP99sP-OyQ>
X-ME-Received: <xmr:rQTXavbiHvdpTfyRpQ8uxSTCMPmK9VKJoYHKECPssw_qn5E8Cw1lamqdFhsflBOjd1oMlg>
X-ME-Proxy-Cause: dmFkZTGrnanuUEq98P1m8Ccf/hgiPyTo7XuLwW3Sove3cukyWSg6dm0qWc0skPGd2CbpOo
    gcvdS+/P/TnIN26gyKeeR7qpB1rAi21FpM1gT/HaHQ9rwWbqSWqOMz8qPol7HZl0YRHFKG
    nltqbdjvgWF5nXFqhR9ULAQrezDS6x8BvNacRrvvOk4pBgl8QMAqlPNYedrJ2XyRhGPWMg
    K8o3QLP+9NK5wvZlkYnsuWbNbSI+DSiWmB0EeDqBjxOTHqro70f0kA6mlhIg53y9+q0P3m
    1l9ovQQ6RarrW0guUz7no7rZt0uILFwafd170AcaIlH36eYhtCaJt0tuyFTLa5q7R6iFKY
    2rIf0WZWVA3BYvpf6rOVv/xGaTUe8QMIJ6q9Wwt6MKsB58oITgZuEIoVz2hhl6C1qqgEE5
    SYZ1Bzv3pkAOBoR0UMtQK7+cH6uNz2oh8lA+2jb4hDgRoSImPgrYMgrqFpcvOqvbsNuZAv
    eJU9J3feXXgQ9mmW6aTgzX2vEhe0ZBWY3zGSGVIN6jsfp6/5hBfH+f3zakyMKRXQGnO8IB
    LLu0+pwAAR3WPvP+ladWNMPtDnES4q5JVYGFXDVAFUsmmCQcqH1+ih+aChwpzRpsQ0ym0o
    tckbyLoKkxgHVDNpIaXrNSx9jJUOhO1vV7rHZy/AoVTOPC1n4rliA/IpUFQA
X-ME-Proxy: <xmx:rQTXav7QeAwA2WtLmO-RL7uKwDbu1a-TJexCgViBahFoucSj0PSLNg>
    <xmx:rQTXaiDtcv4zFwB2zaYrzj0p3V0oYasGhSdOYPq8oyl0deDWNq_9LA>
    <xmx:rQTXalcQdvW8c7y-C6gtLNsEH8QLl9dmtNlOKb8GHqM2Zsylu5VCZg>
    <xmx:rQTXahJnYG7o--By4KOWQvYHm4Yq9e9jAthpnCCu6TK09F14FtCcFg>
    <xmx:rQTXarIcqRwZxyTMirMndfqlneFuUIJk25mAzTzmtnUMTZXupxZ5cIda>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 02:05:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7a34d38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 06:05:31 +0000 (UTC)
Date: Tue, 20 Oct 2026 08:05:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/5] completion: drop "stash save" completion altogether
Message-ID: <atcEqHErXaGiMu4J@pks.im>
References: <atHZ0gV5Pz80l3ho@pks.im>
 <35E6B235-6370-4F94-A0B1-4B6A941D8C47@gmail.com>
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
In-Reply-To: <35E6B235-6370-4F94-A0B1-4B6A941D8C47@gmail.com>

On Mon, Oct 19, 2026 at 04:01:15PM -0400, Ben Knoble wrote:
> 
> > Le 16 oct. 2026 à 04:01, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Mon, Oct 12, 2026 at 01:48:31PM -0400, D. Ben Knoble wrote:
> >> It's been deprecated since fd2ebf14db (stash: mark "git stash save"
> >> deprecated in the man page, 2017-10-22) and the previous commit removed
> >> further documentation suggesting to use it.
> >> 
> >> Since we recommend push instead, stop completing for "save" and remove a
> >> special case in completion code.
> > 
> > This is the only part I'm a bit torn on. I think it's reasonable to not
> > autocomplete the "save" command, but if the user manually types it,
> > should we really stop autocompleting its options altogether?
> > 
> > Maybe the answer is "yes". After all, as you mentioned in the preceding
> > commit, the command is deprecated since 2017 already! And after almost
> > 10 years I think it's fair to start giving users more nudges into the
> > direction of using "push" instead.
> > 
> > One note though: the command _will_ be completed in the case where you
> > have GIT_COMPLETION_SHOW_ALL set
> 
> I should definitely mention SHOW_ALL; I’m not actually sure 
> what happens for « git stash save --<TAB> » with this patch,
> so I’ll double-check. I actually wonder if it will complete options.
> 
> Would that satisfy you if so ?

Probably depends on the outcome of your tests, but ultimately I think
I'd be fine with either of the options. But if we stop autocompleting we
should definitely mention SHOW_ALL.

Thanks!

Patrick
