Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795215778;
	b=ZBr4pJZgSt5VkiNTgiJPDZuIVzH//Is1gK48tvIy14s0O9B5nlAHPEXU+WeNPeO9ay9S
	 y7yaRJdFEqrnIFeRZ5aicR1nlB8OyklXJEz3RTfLR+eaW4tBE15BDjrxo6NCpAABrF1+G
	 mfb6SsPUNtkEigwnWerfdlst2IoCu1aMmtfQX374/b8IbelQcb2UUHIoUZUE6eT/Fbio9
	 r2B3B+RUoFqpAXwF4bYNciZ3GlqqNcEGcfLGrnjbYepEJDai/KIZ/NDjbJlBbOLl0lacF
	 wiZ+jppwZN48DRfQMjE24u3uChdWAkC5lPo0MGjwDdQ4ML4IABX5Duk5bUOjoTEMltA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795215778;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=rB7CPQG1k+gFIN9sjNH5uEvwV9agTArZV+sscRiVbsQ=;
	b=oN35Eq9u/8AJq+YPkQ9BFNNXnMVExM3OVWVcvKY1S1JsBVJIWSYZW6vAbrUZmWtC2e80
	 haeXmLQfqNVTusHbZiPjGltEUlVHTT+hWzuBTuprgUrwD1oO/fV7BCwLT3IvijgHPlQme
	 iJ0MIDMBBRJMNt0746ZkuQ7XILiGGperTXr/kYvQ0/gAOmWJ7b/5YMJPh2YIDtvM7NDVm
	 tmwF/P9tK9SpVXNJwg5ytGKWfHnyyMi0ELK1EDFkM6Z8RfpWTh+owp5bempAOx0Dayf+u
	 diWDVc5XlgvlSWTkfj9uM71PoaYZFYJEV7KnFql7hqh07QDGHtDuWddJetyj1XQDK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fnthtnH9;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4eSmZINZ;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7E606A68A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 23:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D7E606A68A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fnthtnH9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4eSmZINZ
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C6B9EC08EC
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:02:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Nov 2026 18:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795215775; x=1795302175; bh=rB7CPQG1k+
	gFIN9sjNH5uEvwV9agTArZV+sscRiVbsQ=; b=fnthtnH9VGi4tYOl3VqZ/h5Tfa
	zWHNyLvhyvC/Rktm4AwSXL07YSkBm3X/YhfRkTwYw91fUuqeAx50cli2E6qahYrC
	Io9YnBqTU+FDDuDf2ENIH/YlGDEP6UzXcGjNsJThBfl++sjKVSDyweYxENfjZ2CP
	YAQqcMYJXIjL61q46fQA4m/Qu954+wcmRmTmRVpmyqM65Azfra7RRvvglPjzauaI
	kJILkSl/scwJ+EB8xd2VUwSBLAM39EhneRaaJSWMpAubpYPOnXM1FiSCkWQagmRK
	79XEgpPX9ufJgyA7Gh5PzJdMrwsj0WrQA6aPJter4daLi3tkF4VcuxoMy2Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795215775; x=1795302175; bh=rB7CPQG1k+gFIN9sjNH5uEvwV9agTArZV+s
	scRiVbsQ=; b=4eSmZINZVGuTy07gtXvJBVVsuQLyjQZ3XX9jQcDoMK9dD9RHzeB
	eHxrACFn5w1Gwttog+b595pci+/R1jE/cnYDa+iLTrMmUphcsoZeY3d3U2mwqmsM
	MOp73lQ/MnDE8C8LpBuLBOpa1ysXMnwQHLVOCN51E3OwdhbBYHiD6o0BrXZxykjL
	g3jm09M4tZIguSrq9dvdvvWehHo4y6ZMSTIrn1TStx0Eb8nvwz0rDi8ih1FMPIFQ
	IjIe9ZkhmkZPXNOykm2vrxqA0A0vZfJ18kOje7+Ob17gxXKxJ809d0BG9OvUMy+1
	+U+r7t06ZPkYDIWBoxdZi25pEIxjwj0pyWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795215775; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:K1ILx1e+I9omN/KPkDF7qXi41Uww9n8fZ81QwLL8sICOzpX
	qFwg5wF1qSrbLubbx1dwUTQXo9BayKkAu0FukPSNT5kwI4xk1fhO50OWWXPfQm30
	AJJCsdYyVq1uzRrUd/9J/3nZ4cXrpWv6lMgN2kalqMxJwPAUl7R5dmIHPq/1z7qs
	CgOI9T++lJ+Svyy/LeiDeaooMRth4G99Ve4mHZbIzAvBchHt+GKfS/vNmkMAoN67
	lC51urZTva84tG49gAqXzGs1apHz/fl0XRGURxjz0Ptn87PhcCK6HaVYzkGmzAWJ
	TF4dUflNCtWT/ARagJFmXSKwKvLSwF3ZVIoi5Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NVOMXQh3R6ubqvI+RMVaq8b/t5Ew9Ikd61HZ/jhzTXY=:/dOfIlBvLGZz9H5Ov8W2TzXRsScdwWN1+3JfW/3yWsA=;
X-ME-Sender: <xms:n9EAa20NJj7cahMLXGYfGbC_Di6aJQyEipU6FTpUBRvpQ-B4pzOMmA>
    <xme:n9EAa7qFc7_4DlOniRMvrQgwTjtco-i-GlOb3FHNSQHY9kD51p94D5OweS6qi_WG4
    mCzKXSklPw6ANNGjsnMKmbG86S_1z9We81DCNC3Wo2ON5ArLjmueHQ>
X-ME-Received: <xmr:n9EAayjh6mggd2mENa1QIM20VqPMAZnoCxGN0Y2CEDFpVu2aDU9v0jmwBwS_1IZFKs0ccjOjo1mrO-LXWIGOZjM818diPm6QJzQ3>
X-ME-Proxy-Cause: dmFkZTEU8ubtW5gxCxeWFZh8CUtJozRaKtX2g8lwULqndler9NMJ2akcOzKROMJCK0CpdS
    13Fg9M7PJly+on7nwTieJ0hf3ncooW3tYjV212gFUA2IdZctBVfTUzmcqxnHXWnZK6aI6R
    ImehVYxWxTLKUqx86JC2Kp94owXH0IGRqYXmRKGCxxpHn6/BWoPnCJbUYSqZPB1t6UlWLX
    96SDCX97q6+Ai45BHtQTBrg4bAtpx8Oq0usW7a9bsOAbPGfcF0j+NSYVt+GfEbYYVfz8Tl
    u81mI8ej5PeMxzdKp+jM7SKqg/bNhGWuUZ8+cXCMgxovI+P+SZlfJnD1N8P7pz+sxB6pXC
    0lv1HjyzERRteclajICugRfIVKTFtLcd612pB0otpwQGRP3669wxptJEwUTwMFAK4EhVIt
    hd04kWN2PwTwixHhr8dyKcbC0wMu570roN6kmgGOeDKs8i0HY0AtfsItO1AYlk2yjouvjG
    l5v6zxx4NTZMdumeF8oeLPWgjngT+H60U2Dantr8lklq2iQUQUlzSq5WLC8NXMzPYtET8h
    aC0/3jODohp4rKagHAXLJBXXcApAzjoG1S4irwzOjUqT7Vax0Js+6KRWWUckGVyLWkWgY5
    vZsqtYrtWU00yCILMerPuJ6bhLKnfO9u5LWMJtW2pCjEbixZM2Nt2iKNwxuw
X-ME-Proxy: <xmx:n9EAa3-DuABp8iIiwJ-_U0Uke9rhxNILqNvCpc4qonwMjA_l4RR9Yw>
    <xmx:n9EAa-VGSPGsAvBY8EvkRLMlFJizK95gspis_LcQFc6qqoRvAFb5DA>
    <xmx:n9EAa7CjNa6kNo39tjenrHXlR-HJvxJfS2de_7eFeRy8flhT9yyUKg>
    <xmx:n9EAazHOLa3sDcpNCaA3agnLT_Z9UYrt7I7KwBbZQDczfQVdGuI1Sw>
    <xmx:n9EAa7fkgOAXo5GVr7GKYK0C15DocjM0BxNM22Xc1abZfOFd6X-IL_Pm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 18:02:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 0/4] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 20 Nov 2026 14:24:20
	+0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 15:02:53 -0800
Message-ID: <xmqqqzgfm7he.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes in v9:
>
>  * Fix --delete-integrated dying with "unable to read blob object" when a
>    path was a submodule at the fork point and both the branch and upstream
>    replaced it with different regular files. Such a branch is now kept.
>  * Add a test for that case.

The changes between v8 and v9 looked OK (that does not say anything
about the changes up to v8, or the --delete-merged that was added to
serve as a base of this series, though).

Thanks.
