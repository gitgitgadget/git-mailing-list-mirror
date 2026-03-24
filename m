Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE6314B9A
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369171; cv=none; b=W87kAC/rX0rfVRMp4+dOhEcbQ7Dzf3FHopeYcfLfsQvnNhbETrfX/ptuLnXZuDxJDKESSeZyKS13YUSopWkeN496jRIUUNAMobZ72Q5iicMvd7W9HX7F8AuAd0kMWE9vx8EBUcdjD+8Brx9NM8NJluLXO8oJKxpr0QZYl4rNA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369171; c=relaxed/simple;
	bh=Y7pL2tiBWeQB6fIrrvYNa2t3pg+cF0hjozwlhrwNYy8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m+YVSd+CERH3/1KTZJ0wOaiI7LmVCfG46yfIiD4AMKolPY/1skZm3cQbSjL+jhfgQqdXSnhGu0auDJhrl6iQNyg95s1PVVWCUhrGIjacMQaihHSoHgQUAKqSqIcmVdMQLGsHm/L+WWu8gXWHj3lP9+VJGrXFVg6mCpxr1k3bFuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OK1Duds/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eq0pS+mz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OK1Duds/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eq0pS+mz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 790DE7A017D;
	Tue, 24 Mar 2026 12:19:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 24 Mar 2026 12:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774369168;
	 x=1774455568; bh=ClIisDTN6uzSHXywOdMxlCy7bwXltZ8RkkrseGVBxkg=; b=
	OK1Duds/YZ5+jfW595zjkrSIIs8Z4F6kSE4xDwYQ+wdl/7ciiGOKwQyutH5OkoJD
	Y0x/UhEm90dq1OmQQ2b0ZIJqyEIeDpmQyEqpWIAQ9j5Y4kmzOfedjlRPLdbun0iL
	DZwEIbGD0f+Ri1HsFrxAQ2fW5y3Lzab1KbKFD+VeVUVFzFGkf0GgtoYE6hJI7+Xx
	aIhDcLExZYDsrPP8hAPV9FaOXWu5E2LggU9af907Zl/evUBAU9Wm5kt+El2eguwn
	jC1+rBAQCwqeqX7OrP2oDvJYLRXTiFsD9VIdzZu349drlJiclRz8nxc0Zo85mfqX
	++w0TtpVn4OxSMwV3fCNWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774369168; x=
	1774455568; bh=ClIisDTN6uzSHXywOdMxlCy7bwXltZ8RkkrseGVBxkg=; b=E
	q0pS+mzljsdUMyPRAlhP/chKy6CcWsTIxOQysdspBfkoSkUdOlcTeFTW3Bk/ftl+
	BWGk/4Bt8IXbycFHYoHzCMT2vPInr/tywz7oSfM3qkz4Gn7nBJB046UovOPDIH1y
	2al05vIVaPYMQ4bRSuoj2OFZoYXEFsmGbXVA0csUT3omKd/aW/EsgVu3JzOVmUsC
	XZzB3k4eqRDAhFFYSXTXHyb/H98HY3Wahc/y/YaTd+JuMvngIjuJtvUFJkDgEIG5
	owCsXVYiLt3R1qx24fIqqcuwMZ9UCVCpzLJX8EBblVCixYBaL/fFUUDtrFfE0wty
	mDRqZc7nKbqRhgEl22TpA==
X-ME-Sender: <xms:kLnCafhWf14MhdaL96xIHQ2tl-KQjr9tcukxwQge840Kh0ttzStCxao>
    <xme:kLnCaW2ribxJgsQJ69wpAM-dxmXznYXk47iVAwK1ParRGgCo_9pZGoWw8Syr-MnCg
    wCmU9wJP_upDHg4kPjAilLgFN1AbJNRV3vA8l-AtQ2C9Lr1ESEv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeel
    uefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmh
    hrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kLnCaY8KqvEK4wgyqV9jym2LTq63N7Q4hb8sns2J3T-qW5Y7Mc6ScA>
    <xmx:kLnCaYd8gVG4ID_ONNKLWTPdmpiW9GK88cQrvMF8CWM-8ZeeeAuQCw>
    <xmx:kLnCaRHL2FLSt_rvLB8rKb5DL6r-NpbEJA4OD0LVzpAq2pZ0jszq7w>
    <xmx:kLnCaWc9_QgcVNYJGxhse-kRfu5oL0YxrJYpH90gnwNfSepcWNSmMg>
    <xmx:kLnCaWI161a1vcld_ztEeE2LeKq8HbTwVF9-PYP-pqkruLX6RRehv2rF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 094A51EA006B; Tue, 24 Mar 2026 12:19:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7JpA1he84vN
Date: Tue, 24 Mar 2026 17:19:07 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Mirko Faina" <mroik@delayed.space>
Cc: git@vger.kernel.org
Message-Id: <95c249dc-6946-425a-bc44-2a943b4bf551@app.fastmail.com>
In-Reply-To: <xmqqqzpa489h.fsf@gitster.g>
References: <cover.1773959395.git.mroik@delayed.space>
 <cover.1774284699.git.mroik@delayed.space> <xmqqqzpa489h.fsf@gitster.g>
Subject: Re: [PATCH v3 0/8] improve "git format-patch --commit-list-format"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 23, 2026, at 21:10, Junio C Hamano wrote:
>>[snip]
>>  7 files changed, 84 insertions(+), 53 deletions(-)
>
> All incremental changes look reasonable to me, and it seems we have
> already reached the point of diminishing returns?
>
> It is possible that people are only commenting on low-hanging
> obvious typoes and mistakes without seeing a bigger picture,

All my comments here are from spotting things accidentally and are not
in any way holistic assessments. ;)

> but I think I've read through an earlier iteration of the series,
> and found it more-or-less solid, and I do not think there was a
> drastic change of course since then, so I am happy to mark the topic
> for 'next' now.
>
> Unless other people find bigger issues remaining in the series, that
> is, of course ;-)
