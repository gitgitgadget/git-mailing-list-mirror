Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477015F31F
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621446; cv=none; b=UKzh4CQgTBOC9NX4T9gFh3oDtJ9Si51jsVKAiPdcKt4E6Ik+lVHdXwPNqAL2oZASyX+dHFAcaBLkhPXsNbHgGbs6DIFdRRUoKJtmeZY8EFCyLQzM78ifqA9ciP0VaS6uFTKszWPrx+9KqHWZ7GJuXCCHcBJ2HVt9idIIEnQGjL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621446; c=relaxed/simple;
	bh=J3wEVgMy4GCeztDPF+EP1P1AGMcwps3nwv7oCxXpui8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g0qxLE50S6MmSIDBJGmEIcnNpa5BSANtMZM27+uQMfRMZEo/K7qzQv5eZWcUYBut1MvDvWe+FtliWz4BHgjwVPzhgJasmMXlXDO4YKtVOvGUr1V887dOwBIwqmnEYD/ilXA0Qcz32Byj2twa68+PZvH4as84zn6pmTsj5s4ksU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danoloan.es; spf=pass smtp.mailfrom=danoloan.es; dkim=pass (2048-bit key) header.d=danoloan.es header.i=@danoloan.es header.b=5nMqj73+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danoloan.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danoloan.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danoloan.es header.i=@danoloan.es header.b="5nMqj73+"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <danolo@danoloan.es>)
	id 1sExnY-003vj9-10; Wed, 05 Jun 2024 23:03:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=danoloan.es
	; s=selector2; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID;
	bh=J3wEVgMy4GCeztDPF+EP1P1AGMcwps3nwv7oCxXpui8=; b=5nMqj73+cmHz/ceTDYlk7khqhG
	vE4UQaG4Ge3MkkYcaQ0k7DpQ3nPvOKq2H+VfGMTvmUWbsn/PksiYB+laCWK7SDK9eUEK7D+7GB3x/
	d4ZNWBs8MhaumH30UMJTFin2TnSznrHalQClTR0O0UOsPEIe0dbYhuok0fIkkgss8tz07OuHDpXNj
	qbTJhCBauKeD/quMg4iyVZ8QqQR418+jqJLqlcjZMpPm6OC+A8AkCOVl87c0zMI585EpZv/PEYU6i
	P8v1zvbXS9x4CEZZWhulMkqjwdHPC6pRCisqpBGhOQXjGBapkNmJp9IcvNa0AR7yweiWk9eY+julY
	+nuGpRLQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <danolo@danoloan.es>)
	id 1sExnW-0001X8-EH; Wed, 05 Jun 2024 23:03:55 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1188930)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sExnJ-006Mh2-9u; Wed, 05 Jun 2024 23:03:41 +0200
Message-ID: <9cfa7220a143046eb792c7361ea371c29e65eb18.camel@danoloan.es>
Subject: Re: Git submodule recursive update not syncing submodule URLs makes
 the operation fail for commits updating the URLs
From: Danoloan <danolo@danoloan.es>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Date: Wed, 05 Jun 2024 23:03:39 +0200
In-Reply-To: <xmqqtti7s3at.fsf@gitster.g>
References: <7869f213fe59fa80b9e8331dde89e795bd8cd5d4.camel@danoloan.es>
	 <xmqqtti7s3at.fsf@gitster.g>
Autocrypt: addr=danolo@danoloan.es; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for the response. To be honest, I didn't even think of that
possibility, so thanks for the clarification.

The main problem with the current implementation is that there is no
way of doing a recursive update in this scenario even when servers may
be trusted. So the end-user may be able to investigate the failure,
eventually discover the root cause being the URL change, then choose
whether to sync and re-run the update. But thus the "--recursive"
functionality remains broken.

Could trusted servers be configured in some other way instead? Maybe in
the gitconfig, similar to how the file:// protocol may be (un)allowed?
Or something similar to SSH's known_hosts? Of course, that would only
make sense if the "--recursive" functionality is meant to be supported
in this case.

Thanks & BR


El mi=C3=A9, 05-06-2024 a las 10:32 -0700, Junio C Hamano escribi=C3=B3:
> Danoloan <danolo@danoloan.es> writes:
>=20
> > the old one. This is typical when the new URL may be a fork or a
> > mirror
> > in another server.
>=20
> Isn't the flip side of the same coin that you can sneak in a change
> to .gitmodules in the superproject ("hey I have this neat fork of
> the superproject at this other URL, please pull from me"), so that
> it points at a malicious URL?=C2=A0 If the end-user is not given a chance
> to inspect where the URL moved to and agree (or disagree) to switch
> to that other URL, your "recursive" update will end up fetching from
> an unverified URL into the submodule without anybody watching, no?
>=20
> So, I suspect that it is working as a security measure that it does
> not blindly sync.
>=20
> Yes "git clone --recursive" may be looser, but I would actually
> consider use of "--recursive" there as a security lapse.

