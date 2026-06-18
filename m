Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221B32B128
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797223; cv=none; b=rqLbGhT53lA3Owy7cvzJdF6rEsFsAW9hjW5PJQRrJczMXiftwwYrn9rKtzO9U5gp2CX3F7DdgzzGsgkX14qoSEsHNw/fawpbdZQF0g8AzfEh0diDkb/XdFAAWNnUhAoZq/OztXGIi8JZWONedhxopvVLb46wGJnOLBLZZKk1bNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797223; c=relaxed/simple;
	bh=SQd2ymL9tvhZhO+D5GNtJ+PbknmdkL7MdTU+epGLA/0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdNSQ4PMu2Db0d5/s6dfZIPMI4nPinFZPMxtPH7L4U6auQC9QVR2y1aAgO+Z6/45h8mzedjuIjSneRU7bCCmpuOvmV/38aRxzlMQ8KrCOF12tyGquZwp3eJpcuXyHjdwezNi/QVdSLttgdl7rZf/fz0WCp1QU2x/dCG7pjVW5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RzZ1lsmJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eAj9+bNo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RzZ1lsmJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eAj9+bNo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 949AE1400049;
	Thu, 18 Jun 2026 11:40:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 18 Jun 2026 11:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781797221; x=1781883621; bh=zuEeUAm7oI
	xE60htlrNnyhsAHHSst39fWOz8zXUE+JQ=; b=RzZ1lsmJf9v2VsAmzbm4Vfjslk
	BH6MwSokNFEFlo9baCxBsvMCK9BkmzVxVIzoB45flGQZ1lhZyl+RbfKvIlRcukca
	WFKaBSw9fB6g+YtDuGE2ujKgsP+xLN8/fD3O6HSRvUvgTZzLwEYyLA7DhcQYm6tk
	kp7zdkqfcH/CvWlEXFyM0ofQCSdUS3wViZZ8AnRS1Dm3FzPVLZDXYab6Cdi80YWB
	sszOIAtmkmC+exMaUSQuXzy1YWGz1oEDo0KXkk5Oio7aSmEuqG8zLzca9Myn1Fq1
	j5Tji8cfzDWbUQOWin243MYb3qCaOV6kxA8lD4OfGCVob/tHzVTA+HhZHiMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781797221; x=1781883621; bh=zuEeUAm7oIxE60htlrNnyhsAHHSst39fWOz
	8zXUE+JQ=; b=eAj9+bNo+YvwP3aDfUBjH1aiNzcsTYiMt74Ij64Gg2c5AyOBEhc
	jOhIz6PPNVMdq8iboyW3FpTMAr1HdglTtNvHC6tExvNoSSSD3In5H8IB+jExXGJY
	BNU+FdqqZvZBbq7lNkl7Y7ZJ7uEBDDnYNHgq8isz9F7OJhAdeXDhkBJvMwhx/RGQ
	v6Uatt5fXO0Un1fX1NwhSO+mra6O5Wm0O+WnBzE5TEe8GswEPrAL+J6U6Zo62KpM
	fRoxhk9ILo9xmiqzMibggDvcwjoXgY5VwKq1meaUaAXEpFw5hpx7k01F2b7zmdGH
	O8yMJE0RomQ1sHbexF8tL6t4j/hY1wBUEsQ==
X-ME-Sender: <xms:ZRE0arH4m3xQLYqhryq4ffi4wpJ7lzV0FFfNfp0TtbD0CrMPs7_2eA>
    <xme:ZRE0avzg1aJ2u2vdxjBN_fvqJuJua8Efxzf-1cnpMxoM0jBiazRzdWDQo8dUiu8R8
    UrOhVDNb263JxLt36OPskzo0-TJqh_8-3Mv-bAZxTQt9LMhrlbbesI>
X-ME-Received: <xmr:ZRE0aqg7AaLLW9NwARcPzmp1Xgij6o2zC92ttJKfI67CmYfcQ4nVpUqvA-ZuoEQaiOBe0yaJU-KKfGOSNoNhoPGWHuacoLhakV-Y>
X-ME-Proxy-Cause: dmFkZTFDTxO7QVLdIfnh1ZIT0mGLqIir/Xd3AvRW4yVjbDOMXOR3JU/hxbFoS2+mdD3aKv
    k4fmS8qQnZpptehLzMhGv68j1TwaTXrNZvbRlqykDHekWg70K0UU/XjpSbfMEaVg0LtCYk
    hGsFTFMCZqATvY6RaUFsm4hyelZD0FNCGh4C1kAtLw8yUTcttVbYAppGY95GdaOktpR5Eh
    Qpd43JDtZWQLEb9ekfNc4zPh/cxhI7wlrO6NGr4wAH/xYzT10EX1GlLrT8LMiQsJofIinh
    lghfEfzpYM8EIv7AHbBkxBP/SGSl3w5R54GDyZAZ08vNXQOI6oyJClRqaBYK13nlR+Q4N5
    r6wIcDwYhsqUei0k7jsWsiJMxBwfVd98TKxBYpUuae4BWugUUg31Ahl3r5/yq4wzKW6xdp
    woEaEHjsiU40o5/zoExyt5Xusr3I18Ext3J92R4fzdDN5wjm3cjxHXuOXjCDlcDfcnN15W
    qfwmfR38QQbNwJXt7iUk5NzTssXGp1sEzwyFGGf+VwUD/siILzHJboy/p8evHaxL8/IRjd
    HcMGbmueF7lUzZit4QIdJvE/3ogM8EHvUUjlH2ocOEYEvTYsAzb13MjA+DaVQijk3vvMG4
    Dtzy1e606G+TONZBRWf9vWwNwtwjsOgsi4CPXkJNDFOV7iX6yLto+1fP/V/A
X-ME-Proxy: <xmx:ZRE0aizaya0P5U2sIVuviXspKfwBD_venRPaZ7JYy3wfcPCZ1wmTPw>
    <xmx:ZRE0alLo5gtktjNLEQG_Y3CklgbQFVUpOC9Td839CNO4IagEsYZ7Ew>
    <xmx:ZRE0ahQYNNh5wx0Jgk82lxL7kauu_IrOdM8P5GXtoSbZRHrv2aFdwg>
    <xmx:ZRE0alpCE9S4CNfk_uVqge-6GDj-LRwfzlSQKY6rFg1gZW2Kma-bgg>
    <xmx:ZRE0ajweTDBGfMtN63MgXca2XOUmMkY-4Z4iADCfpcS3EEBUtZeVxkW_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 11:40:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: address design critiques
In-Reply-To: <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
	(Michael Montalbo's message of "Wed, 17 Jun 2026 20:53:07 -0700")
References: <CAC2QwmJdF+YzAQE3WDEaUrurLVkYcAA0Cgs1YAqyxYcQ0jKfqA@mail.gmail.com>
Date: Thu, 18 Jun 2026 08:40:19 -0700
Message-ID: <xmqqqzm3svq4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> Two small suggestions: open with a direct imperative and replace
> "effort in the implementation" with "effort on the implementation".
>
>     [B]e particularly mindful of...
>     ... too much effort [on] the implementation...

Yeah, I started from something like that then toned it down, but I
agree that it is more appropriate to be more assertive here.

> Maybe it would help to spell out what the explanation/justification is
> for more explicitly (though it may be a bit redundant with the
> "meaningful message" blurb):

Yeah, and it depends on what kind of higher level issues the
reviewer comment is about, so ...

>     Make sure that any new version explains and justifies those
>     design decisions more clearly: why the change is worth making,
>     what alternatives were considered, and why the chosen approach
>     is correct.  Put that justification in the cover letter, your
>     responses, and the revised commit messages.  Aim to make the
>     reviewers say "it is now clear why we may want to do this with
>     the updated version".

... I find the beginning part of the above very much better than
what I had in my version, but part of the first sentence after the
colon is probably a bit too much.

I'll send out v3 sometime before the next week.

Thanks.

