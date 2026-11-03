Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731018;
	b=BcVWknkW+d6tfTJlB1t+qdTZ0jtkGIUYHJZFObGrBEb2nKbg4XTIyx5od4PaOeI//4tS
	 6I1U9v3GzEvLpwVLs0fG+aBC5u/wTCXsP+wjqYP222XZqmJWviqRznTOiyzRGIINp1yxQ
	 +SAQtB47+KQZxdNR9P4GrgMSLpWVi7YPmj/H9cKwf1DQcwe/Y8MSdmanDp234m8E9WqB3
	 o5VsRSc2ZBVdhTxHPdOfBsOcilddHMe61fFxShWhRWgTawfVBpIZMZjmjJyayJe6ZIlHb
	 y2P2mqLs5Avsk1TvDQNoS8bzf2HeaPLbS9JBH252sJHzZy4n4P9jTdBZpL16qxfxthw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731018;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Ci7QoPoASEkDX1IGrD4iPIAt0kbCas8ZJY1WvYrPl6g=;
	b=4c9UVPL9ZBNtJMCwBL9p1VsTc9nyfu17GbRN5tq814JCuRSKLQiz6R9o2ohijuUzbEgg
	 CRht90uvUW97w+8421i3Q5Ehc325/TN60rwBkjO7uVQJ/kYzt+4j5ZkDQRBdLOHSSDcBa
	 5sAbuOPegCqwtXUxgPXLh6adb2xvM8SJLPDm8G6NO9fGMypCNSzYYRbAMeESgqS0n+wZs
	 6Xpaz8hGdace7JPNyi74b5D/jrJeQjqq+lZs3HRs0gJMYcA+5tL7xnO3AnNKhAVyU1Wtg
	 apGqTmQNDP+I6rvvSxy/QprUDagJIqLH4eebMVLRzKQeoQ7JUtDE2Cy6NVll0EWVLJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WtbqNu7x;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bzjk3YFI;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1D606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 18:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FA1D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WtbqNu7x;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bzjk3YFI
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F245140009A
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 13:36:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 13:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793731017; x=1793817417; bh=Ci7QoPoASE
	kDX1IGrD4iPIAt0kbCas8ZJY1WvYrPl6g=; b=WtbqNu7xpVekujobVchd1aGYHR
	Et/4972XOJHznhyBIoeba2e1XtPFW8zZXYEivTAcAZ9W8VQlFkFS7/uyOUP72Uuk
	IsY4df6Mw4PSRq3gEK6fvLyNSxGYVMjQlQBdl2NMVBo/Hee7GnGTvDL/0vIkdxkl
	iALBQCxwtZLgOJPbL/QJvgsVydnarBxj8ig+64m589ohsVAQf2E1JteoC1hqySiU
	I7/qJj/WKzKsJo3Vw5X07Jrv9GF0dAVixQFEBzghS4OuvqZIRfx7DNsY1yw5M2gQ
	OXsDzKwwKbY069PybtStV4iK6CI1tqXzVwG9FkbaJ5C4zhpIT8MC3Dbaj0vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793731017; x=1793817417; bh=Ci7QoPoASEkDX1IGrD4iPIAt0kbCas8ZJY1
	WvYrPl6g=; b=bzjk3YFIOx9+6+Ke49qEWfQrCo5zK96BPhhsBSE3Oh+FA/vH5KN
	NmVMXPraJ1NlDEVBOAk8Kjy0AN07u5A/gaIMKMtk6sOXzkG/vlMrBFb5tfYEZtrE
	UWDeUSTpqfyJvFr2MwVF0aQekW6UPKkxnJXJUdv+pCiipae96GuiWw5fo1SwhEwg
	unlD8fDjWMMpCVU3Jf8+3kZ///GgzEPkiUoU7IQk0O58NubEesi8V1SAVtthUoYU
	iCSIFb3N3iuWNux5gkMbcNrBLZj+ybScNjQwPI1nl7X1R6nmdZR27bC4lDpxbHCm
	bQ8NKIIL88g0TcrQL2nS9xGQ51CsoNl3onQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793731017; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:SaDVeA60rbd1m/PrDds8WCQF3Iz872s7Ew6BMjqV+AmMm+5
	mMB2qgveze7wMvO/Ai3FV/aZJb9Q1JLEj6o75SBjbaYHg941bMvYu4kmda1IP9t9
	jVaQFFvFrf/9PDUzgK62aQZMg14ne0NpHgJ5lNfiNK9tHhVHRuSHozDBEDRpR5ol
	CQlaxi3AFLWY5xqEoOJz9F66DKGt7KFIX/jbLkEGpOa82qGtzHkGxtPXpoHkA5F5
	wEy4jNp5JcsY6a7F/nLQ4w7xvbFNhOvjZ4uVBpyDdDh3O4hEDLjZINs9cTu4uTEv
	ByFlhqJq3hF+kSCKduQdODPTcGTj2ZIF2vg4Zdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dKxQmDfjPoJvd85a1xAfMOs0/tZ/xIS5jZan5ACj8Ww=:wH+83s205axntcxPAXZqQMB8tuTDOlhjNvIBeg6jRDg=;
X-ME-Sender: <xms:ySnqanMLMppDVgrnOdapyt9DDryZFV9AELMmG6tCa_VFt67AqMvDwg>
    <xme:ySnqao0YyQAALaUFiUHblfAbWSsoxtskspGjeANediv1j2_RWX32e06ojPc7osT16
    yyuw4azLWFkVGq5QNx5cCQLxum30-0NwileRuGrVry7r11XWaytkQ>
X-ME-Received: <xmr:ySnqaum0vIx6XhePVChD9UHavVnf8IT5H1OOjqzkh0hJlH0hMchFSFGM55rfZp8THMEhZzVgI0cMsYmSQ-12gFi__GUpOX_vbugh>
X-ME-Proxy-Cause: dmFkZTFGLxQ5dyZA74KKazMbWMyL9NLZ167ketwdQqhNCnFXwlGnTiPafiKfaXwj8uh6fG
    FgwhrFn3SWxoieNBTy7E6lR6CDax8qY3nlkAUM1vVl0GONRIVyoyGX7wQCT7XFFvq5H1px
    CShh6Hr4KSrdSwGBrsLGUgMZFBbVBhg+R2Q7U0Ri64VUJfpFUlwUQflbbDiKwnfQXzdZrh
    dicBYhspSOOGCch0CVM03/9K3Sf9JtaUR4KnMtnDVMQDVreQWjEzWuqJjUg1/ilfCOh5RC
    5PkVzw2+br62Ry7CrNIdfYkyLmE/r2vGgdmKPcJGJVglH+W8DEcDnUdKFgDdW3ks5Lo3Rz
    xdyb/PdyF8dnFEYOw9B6OR81KwWS7ZJ2ih5UaY8+9zsr4PW7L8cRPhkjXTE/Qoi19xNL+h
    gQTvB11ECJXNN7X//smMYs70uepDZnJf6STU+VVT+yjHLEk8WpBtdPaHuvXT/pPVVjzT63
    xzYZUJyLokQ58o5rQfJ5ycZ7WZ6kOYoBl74zJcz7mCazrZfI0tnIkTSpeWpS7ULnrfguvi
    1Yi3kg2HsIX84ust3VwKnLGwsegt1vA89l4VZ6pCOhGdwFhZyOf3cDYj5dePq+Og90+m6W
    jsNOhkVpQmBcPalvPBDT+M5jp8/OLdDRdg01GuAat0/IhPxMj1vy76BJtS6w
X-ME-Proxy: <xmx:ySnqanWHT9E2mIXIPDHsQ5Is2StVar_jrkwfQ8WbzERo6K1G4H7qPQ>
    <xmx:ySnqasuHgR0l4hjTF9Z86F1zR9QFJ0jJ7Nor9r4qJTfw9WKMOf0IYw>
    <xmx:ySnqaiaNRy2FIfpVEu3Kcj6ZQwxbgeHlQFxKSN4ceUlcoz2kKBn4Hg>
    <xmx:ySnqajWFiPl6-Yy47BoiZZkzA8lh-28KsipwSFd1DNyLUR9CXGjJGQ>
    <xmx:ySnqasUNvqWaFPjJHlan0bF84-pNF9fPMulqhPKXS0Va3Oo9skwEbomA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 13:36:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
In-Reply-To: <CAL71e4M7yFnTzYD0eVVGRmzkzSXbU0KZ-JScQOyB4-dB5xkAHA@mail.gmail.com>
	(Kristofer Karlsson's message of "Tue, 3 Nov 2026 09:35:07 +0100")
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
	<xmqq4idyhotf.fsf@gitster.g>
	<CAL71e4M7yFnTzYD0eVVGRmzkzSXbU0KZ-JScQOyB4-dB5xkAHA@mail.gmail.com>
Date: Tue, 03 Nov 2026 10:36:55 -0800
Message-ID: <xmqq7bit92yg.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> My preliminary thinking is that since replacements are
> implemented as regular refs (refs/replace/OLD -> NEW),
> their reachable objects should already be covered by
> ordinary connectivity checks when those refs are fetched
> or pushed.

You are right.  So no need to do anything extra to worry about
"doing both".  It just "ignore replacements" had a wrong connotation
that we ignore the replacing objects and only pay attention to the
connection among underlying objects that misled me.

Thanks.
