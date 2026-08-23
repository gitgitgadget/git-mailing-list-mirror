Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342725782D
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787497311; cv=none; b=NbiQjTZjVuCMS9V47jYB8AG+6rsWtuwG+AF5T+324XBrWVbDi1GqO1CpKb9w2tc86Csn8tnYS2v1z6RjlVQxYHolGW/UFEmGwmPwn9Q0skrx3L19WhtotRcuSFoQcu1BlaIoOI/Xek2vZ3oh0zxXjlK6NEw6cRooW21YFM3rAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787497311; c=relaxed/simple;
	bh=TAbT+g5Qf+K58iXIpaThWsiRe76Nb+gJCM62KOrWqKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5gFCpMjy3Li+hXN9WbBkzlCDblL9Sioo4rgxY3D/kOluG6/JTjCedXWaNd0reA+ZWtmji9oJN6tFFhH1Qn5gf8eAiBFkl1qZy3QYQ1zFswQyIKhU7FAH0HbgqCwIh8AmIyFONCLgfaAZJCBFvlo68k/qzKTCFccuqXkPE782x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gg0uLlZk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ln8PDwFZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gg0uLlZk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ln8PDwFZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71B821400094;
	Sun, 23 Aug 2026 11:01:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 23 Aug 2026 11:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787497308; x=1787583708; bh=6EuiA33DnH
	F82T4QgLATvXo7m8lPexm0sB7kW5cLLy4=; b=Gg0uLlZkdUc4gk+MfeKAW2GePW
	Vbm9BJHmyua9QSUDeQIwrD74p5dZCbxbXWAQOTRXfBXdn7EQ+WYhEOKE0ePAN7gh
	lxNXekPkxqBj77RU99IQYm6DJtoibo+L6vKNJFlZJHJcFyKCWfIHSRr0LXO5b5dr
	EAhC0rjosXDHcwEXcQ5oxdRTQ4v+mNJRcbMQ6xJqSwMnjPIjtfAnUIFTnWtj24mi
	pj0JDkc36YGafW9u59kfS2PR7mvVDmdcE3cDV6bLzX+I3VA0ryDVmNLf5IUX0qSp
	Q/I3PjdQEzmRKJNO6B4fkXqNIR0XAHpwyzNR2JXwd73fNEtfpGodDDtH0Xng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787497308; x=1787583708; bh=6EuiA33DnHF82T4QgLATvXo7m8lPexm0sB7
	kW5cLLy4=; b=ln8PDwFZnPVaLR/yBshrPgSOS7sXVmIWpfqnrzesLJNaPTDFnSl
	NyL2epp+A/0fjbknrpyD4OmEHA7T0pl7pK58rLxls+IB2H8EoW7Pk4z/F8A+OhEk
	FDpXbsHrmWuGwUv4Xe0jgNCf3KvwPZ2MAsXGMA4IMI9tUCgPkhkMjG7ITO8KrnKj
	dcDDO28jRNxoZ3eptOjqaZAVLaO9KuJgn09oSF438wbhGwgRNWS5pfRd199i7yrq
	IzocNqSd9F0Hfl32QNysenbXhBMh8AHno4P2ZKPyzIAi9mxKqhZbOJ4Pj00ifykW
	x2nisgcby54UFQqaSsitT8TMjR/kzJB6q4w==
X-ME-Sender: <xms:XAuLaotFwEb2vraOMtfQD-N_EONaRB9FgpK2_Pz6LPb51IQhFuXp2g>
    <xme:XAuLas51TjbDk_pJPMArhMlmmQiu-hURUzTx9qhKOpGTgxYAdjZumKBG19LLirnWy
    rCirRDHEnfYbJgJYFmRvaEPoK_HmOTixOblpaP_Y8BQjxY7HVNrh78>
X-ME-Received: <xmr:XAuLahJFpQ_0P8JiqjJKzkrFhzhoNFXj7ahE8IFG1W1MaKjWrBlBDSBcwI78tj_STcRzHA-sbmSTGHJKWVNiJ6f_swDsW3aEVg>
X-ME-Proxy-Cause: dmFkZTEovx8LsCOh72CPeyXns/SUXsWvtWOmaG++JPxxKE7guCRU1F5WDoifwj0hifMg70
    7xclx/SdbYPg5yXrpJu8YGvwgnVsLQiIKHb6/xYN7OcVggb9ukLsm03bMq6FHsLXHAQATZ
    9IWIVIvNOTL3kD+gcOp6VpygTwcncjkDrIy6XCIeQofnRyg0uGOJFYr9b/wqiUfotk07G3
    4zQs3YkvEU4hmBbCTUFgDrh2eQ5jkCNiVLIOcK5z4cgnXaWwZn729yhejxckOdtgoP4nPx
    otITlDefchUTTh6qwrNMaaeThBhZ6Ba7BnWFI0mTDYm520RqKUZFKgLG2qisWoNnlZsvUY
    3U2anZ0GS6sZqeGCjKzulyosnEFcu5qg2+2zfADIC78hW9EQ7t41Iy+gBjUzM0dLCV150u
    UBMlLF+iJV85Jbner9E853cDq7/OAmhWJv/j0Ffd0cS0009peUGEI8leBtnnxl/GJIb7Rd
    0OMj9ZEwixCrNaKuVImK9jS8MeyG27DuTSLH2MTFfNtkDCT3mNVFJJVf4V9RzonsfeqZUo
    c6JLbZEHiyI9Qvj/xT7p72pJAtoL32oH4wfHfbm0mkisBCE8luArEToVTP1lBkb8/7P3hm
    aHHjLyPeVQsB/0eO8KkwYd0TkXmnumzuTxVP4wtkNxczQoY43f+w14tbrZlQ
X-ME-Proxy: <xmx:XAuLak4Yz1Zz4pd47ZvAQdxWQRJt7DoQ74nbvRU2N5OPbNeqML2cmQ>
    <xmx:XAuLaszoTHzUpu9mGj70jkU2RLIZ-SUX9TOt0LkEBD5PVA66NUpkBg>
    <xmx:XAuLagboh5RWLLiGo4SAYKF06XyqKXRbM5SLtwR03onGgpehC0OVFQ>
    <xmx:XAuLamQ4rt9RHhqk-6GOkhrrseRf0Y7PJEfMsobKNFTXArvpe0C_4w>
    <xmx:XAuLavdrp18MgUwbJCn_84Ry37KCvSCd8vCUJt6r0PDkmfwoH1qko_gc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 11:01:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [GSoC Patch 0/2] add unicode support to git repo structure
In-Reply-To: <aorzcZVdCK27pdjG@ugly.lan> (Oswald Buddenhagen's message of
	"Sun, 23 Aug 2026 15:19:45 +0200")
References: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
	<xmqqse47pfyy.fsf@gitster.g> <aorzcZVdCK27pdjG@ugly.lan>
Date: Sun, 23 Aug 2026 08:01:46 -0700
Message-ID: <xmqqqzjovq1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> if compatibility with broken terminals/fonts is considered important, an 
> option can be introduced to opt out from the modern experience.

Absolutely.  My response was mostly a reaction to the implementation
that only paid attention to the locale settings, leaving no way for
people to opt out without discarding UTF-8 altogether.
