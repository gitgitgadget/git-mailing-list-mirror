Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00851D63DD
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974856; cv=none; b=UWW6HTLGgn9+DmINL/nLCnj72XHrCnFhIDMimoJeEPipVcZXVUyFX2bWuk3JnXQFHCaFHtohSAolYQcuNN4CwJLeqdLm7zx+QdDRIk2GpQPYY+i9D0Xk2OvUMihIB951S8auylMunKHM2/dZWKN6Eo1wtX1OqbGd+qDzzwwRb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974856; c=relaxed/simple;
	bh=9Bg1PfSNZoVw5QBG5PAJVgelhLTXJbII8j7V3ni9vvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fvPAhCr3u5Ht1RnK6jpwhdGnZtNIczCL7RYuHDkAmCHfwxssv7lV6Jb8CR8CsolB0xbfqpeZrq7IvxVSkRrcjQgxVap6Fa+L0soHGIWhPHWQMm/N6KWfs6L/zZwU/Y9/YxfXAyABePukmzyUrKmyqtU+IwnEZ9fHfxLM+qwRbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uISsylo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sizl5XbD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uISsylo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sizl5XbD"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A90301380389;
	Tue,  3 Jun 2025 14:20:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Jun 2025 14:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748974853; x=1749061253; bh=nbm5HAJ3pL
	FWOzT+j8hSwlNVzRXhqHg8dTzKheTT1CM=; b=uISsylo8lY6oEvewsTepm46IJm
	VJ9L55y+vVKgUfNQ3JgMRmSdxPjjkQcOiPRK/8d4xO0DNJm1IYxy7Wrw1yil0XBZ
	WQBEm0sTfhzqMJ3Hd5AeSYsXZVvK9YtENG1sV2ZLdnwGtiXx2m5UzLWEFYsFNddR
	9V0RQR0FKJ0MP/IEK+jhVABtO2fAvpmnx+rhaUCQ1LNO8NQNO7gEJ5UaRiWNw6vF
	AKm+dcolEbDBSXXty8f5yQPEZYAeniNH6qpzUtvrxqLGfItMTCI6NVwHS4V5tzP0
	t/vhTZpZMIzqag1+ONuC1y9zL2F2J8iVYf49I4G940fSjIKJCDatIw6yZmcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748974853; x=1749061253; bh=nbm5HAJ3pLFWOzT+j8hSwlNVzRXhqHg8dTz
	KheTT1CM=; b=Sizl5XbD+Zlvo++ZVcaocoH83m/g1zxsGiwuksSHk+q9AIp0EQ7
	R/qttEVTSHH630zbQfE0QeIxChkaNXd5BNQsiCEkQ2lhQgcTAjc0EQCaPIB+zJA7
	LFo0DFivCXYbayVXrSjSzcyIKutyfae5Ql1A0b+GxoLEwGKCi1P1eaPuDi+ermaY
	uHRM7WCHaGHTGSarr/TIMVIXPnVLBKnOVn+HdpoAyCQAJl+2JklVt4TmgP91UCi8
	q3EwfmTgE/bwdtHlR1H4J3cmDhvV6DD5fdP9b0jIEx86x54meJieJErZs75hK6Te
	gJyqX+XDE0ycSdZnb1nnUYdVJ4RC4FUlzIA==
X-ME-Sender: <xms:BT0_aOrJYiwbxA1_6NT5cwA8zBv1IV7JfbdPQcMEqD8R_iNmJV60YA>
    <xme:BT0_aMpQJv8JVJEXORh7wAT4yIOjiuwSIAjMs4gdmpR3fIpHQT8XZb6H9Gw_4bIdq
    sTgw4uDA8pqWsED9w>
X-ME-Received: <xmr:BT0_aDM6fq1NaJHOmiU8S5Ghy_kUo8YugGyMgmcVUc-iPpPOmtT8Z56BadCx_ogL8Htf23V-5PL6nW5hPD3WtogXppYG7YXUI4OH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohgurhhighhorhhsug
    gtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:BT0_aN4F8GwK18mkCS0vRM_cFrRz6okTDEWqGuN8bcXBO4dnmjFacw>
    <xmx:BT0_aN63YzCwcBJ_5c64HVfzJHBn7QgbRa5JOLjTT9G-lbtbxxIP8Q>
    <xmx:BT0_aNhZNbdza8VLNKhduHlMKMSA6UCgxpKXAjXkuu-BYYSndWaRug>
    <xmx:BT0_aH7iLIZs2-ACYq5VAFouZO7qGCwPzgTXxd1UOz6zj2W7fDPv2g>
    <xmx:BT0_aCI1ija8XR282stdYzwxbyr_piBJhi2yd4rZoyaZ18lpjbPJhd4O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 14:20:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Rodrigo Carvalho <rodrigorsdc@gmail.com>
Cc: git@vger.kernel.org,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] userdiff: add support for R programming language
In-Reply-To: <20250529221805.97036-1-rodrigorsdc@gmail.com> (Rodrigo
	Carvalho's message of "Thu, 29 May 2025 19:16:41 -0300")
References: <20250525210236.116342-1-rodrigorsdc@gmail.com>
	<20250529221805.97036-1-rodrigorsdc@gmail.com>
Date: Tue, 03 Jun 2025 11:20:51 -0700
Message-ID: <xmqq8qm8k7p8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rodrigo Carvalho <rodrigorsdc@gmail.com> writes:

> The patch appends userdiff.c file in order to support R programming
> language function header. This will be useful for those who use Git
> for versioning .R files.
>
> Also, add three userdiff tests for R programming language
> files. These files define simple function and nested function,
> with and without indentation.
>
> Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
> ---
> Changes in v2:
> - Add support for function defined by '='
> - Replace word regex to '[^ \t']
> - Add new test that handles with nested function

Sorry, but this fell of the radar.

It seems all the reviewer comments on the previous round have been
addressed.  If everybody is happy with this version, let's merge it
down to 'next', for the next cycle.

Thanks.
