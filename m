Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6081E5FDA7
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250682; cv=none; b=eK3/4/ReaXuNmgQ+99++uiVbGl+Y9yt105xW6xalpOZHBz2C5Pins0b/5htVi0k/7mnC0kiM0Pi9TTMutuDH+ThH/8hz+HCVXogp1VnAMrE3Y0VgEpZ7tu6yb3I5AQgNYxMaz0oJw+MBbD0kAv0QJcby5R9EHIOY+aBPjmNPuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250682; c=relaxed/simple;
	bh=rTlgxvnzaD4i5c3lTh+5+npXp/TiT66Bcj7BY0XAaq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2xehZTRnAPz/7MWRA3eUYIiI8S0RMqeDLqKj/oy+NO9jaIAHpXVxWeNP8pOrrlYmzX4OmGEH2bdS9w1DCf1Wezfp3VzPqCRasA1+GnRoqh2Q6I6A6kf9jHEhysc24zYIPwhwXacanH0T9OlvG1+Dmi8qHWq8zcnyw2ul8XKRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQZUyfsJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQZUyfsJ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BAEE138024F;
	Thu, 21 Nov 2024 23:44:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 21 Nov 2024 23:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732250679; x=1732337079; bh=h/vIOkWJ6ZSl6zg8Rqm+tpTcP9qK6kzxU2O
	R5h6z2to=; b=hQZUyfsJNO+xaEXH75EY35GozAUd1Rxp/35BWepA9OVS/g0zU5d
	VLfmbr8oI0Q9hDLlgJiryIi18DTQiWAOiRhRV0CwnX0EBpQQY3JJcgoJTCsvi479
	zu7topQHBo1mOS4J0CIjZThqhlboy47FzaNpCTONDEYQtPEvYRw+Qxm/VB6dExKg
	pBLWpyGV7OCpeGWchULK7oPPzQYv194B4z1seF9GmPc4xbM2E8l9pVG2Q0inTzeM
	MlSDFgtDtWvKsZiDL/X24npfQ9LHUPkqB6TODp5dlfjzAYCFmU7teuQ7iHf17mEH
	OmuoPCSqx67Trc0TPqeBdtQ983wjtQEXdGQ==
X-ME-Sender: <xms:NwxAZ_qVDNtz4y1WYB5-LV4Q2YdcLNBxvO2ofgkhCtBvJfT0BI1AtA>
    <xme:NwxAZ5qTiOl-RU_nA89mr3sXQaVFX728x8K4GDBeAg8oGQUtKQIwTRrm51VYhOwsQ
    IHCnmCPYOo3cFYVBQ>
X-ME-Received: <xmr:NwxAZ8OMG7nQmTW2vr8czydWNmPtfJH5MvE7keTh3_lYd_5z3-rd9Dv1s6PsaPltZ4-8QTm6AJtWZ-bkGqJ5-caEgTIF9TNpYIU_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NwxAZy6N2bM4buiapKaWbF7iHX-hw6Lr0M-LiiS0er1RrBPtOYSRMA>
    <xmx:NwxAZ-40JE8IGuFwElmbn3--EsLilu-WlKcDpdwQmQHes7wE2XzLOw>
    <xmx:NwxAZ6j5Ruo8xckLIJFHA3yDyjHBRQwUSs-_P6qcYCxcl4mNes8U5w>
    <xmx:NwxAZw7OAs7r8JxIn44lcEr1KRRR_QHaydkQS7QILHpCXfSmfCChMw>
    <xmx:NwxAZwTXABthRsWd39QX1on3oXRHadnsvbc7CtcUhFR18GD4_Q_Tvs4S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 23:44:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
In-Reply-To: <d73b8fe2d63c8ad08ad0c4ffeffb5ee2509b2d50.1731591708.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 14 Nov 2024 08:42:12 -0500")
References: <cover.1731518931.git.me@ttaylorr.com>
	<cover.1731591708.git.me@ttaylorr.com>
	<d73b8fe2d63c8ad08ad0c4ffeffb5ee2509b2d50.1731591708.git.me@ttaylorr.com>
Date: Fri, 22 Nov 2024 13:44:37 +0900
Message-ID: <xmqqjzcvand6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> This regression comes from ca0fd69e37 (pack-objects: prepare
> `write_reused_pack_verbatim()` for multi-pack reuse, 2023-12-14), which
> incorrectly assumed that there would be no gaps in reusable regions of
> non-preferred packs.

I was reviewing the past release notes from this year, and saw this
snippet in the 2.44 release notes:

 * Streaming spans of packfile data used to be done only from a
   single, primary, pack in a repository with multiple packfiles.  It
   has been extended to allow reuse from other packfiles, too.

Essentially this two-patch series the change completely so we only
reuse pack data from the primary pack?

Thanks.


