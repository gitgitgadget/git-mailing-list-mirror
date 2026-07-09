Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA683D1CBE
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629550; cv=none; b=V5fd464NHr5nS8JojVqL0AkOoIIICiT5PBvb/ZhXQaMefLAkrAEAeNVpt66/Su9hInKy5TMitqopxU20pWodOqngzzCwPZE/tImU5Wlv9YgeNKXH9WxDuoYsmrniCqHEy89YWvJ7rmNmCQAD6fUNpzPA3qFPyUTYiAQclqq9u9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629550; c=relaxed/simple;
	bh=k5xvlruqvKrYC90mXJADwJXEwltr5H4grA+ih7KyhzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nl1t1naCkfx/f0jvJCz1FoEQa3Z93K/z5ETXMIkt8rw0DHL53hx7n/ZaBGxpCtpIAtsT4n6Nn9OjQdYKlOcSFZpKrD9veDXqfEpdGAKHNFbcZbYcTgmvxvGkzNjRpAPzv60uhfnulSxkcMSl0z1py5b3Ta2Zl+ZC3XM0yvLnsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lpFt+tTG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxPafs92; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lpFt+tTG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxPafs92"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95CDE1400166;
	Thu,  9 Jul 2026 16:39:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 16:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783629545; x=1783715945; bh=HRNCXUgJcb
	EqrZ7d+wZBhF6HT0ooOKsXuWTyD5Fr16I=; b=lpFt+tTGlFA5i3FJ1Ya+/Fl5gB
	jxjaEpl9kMiWlJfHyWNjld+a4sYzlJFPepsslVBQCsDlY7HMVdNeRNFW+vwk3an1
	zrJyJV7qkBFDCxT2i4fx+xqhNNDKn+4/jTXL6fcya7Hke/4PefBuqnnscXzdO4YD
	h4ihzc2PTaOUUvYTLaMegZdogulKUlvzkY2qQBdFUKKOFhyG8AZGOVWkA+7tBE78
	XttBuRZe5UD4TqkgDRoWLbkBZ4TiGKvoKu1U04YH8qRB6o9M2djn0EHTGtr/UDV+
	UO5Y9TGWJjOU9Mcu32uRaravL+wNtxwKFkYvw4KqTjtUQOI85CLw6Eid+T9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783629545; x=1783715945; bh=HRNCXUgJcbEqrZ7d+wZBhF6HT0ooOKsXuWT
	yD5Fr16I=; b=FxPafs92qqVVvWBNZsBUHjx1g/n9d8IHxPFVTZ9NKGr8KAgn+YP
	GDKbnlt1cNJHpm8ItNO6Fu9tk3L3NzhN1RaxjM2D0W+MDXNCRLnhTaO5si1X8KCY
	9bmNCGtoB+ca/qSKeo4aRQaJ1hMLhCwPv/vZq87Uf/fqqjPq2ySEZiuveDXqeemw
	VFBAzX/EyhwpDo4yLy/hqnLE6bce2dwkza4GEMR7V776lFDlp5y8+NuvZNHnXDuU
	XuFOj6B6ww2gkzLVIM1dmlzyf0zNx8hoNsuCUAk6zAkecK54ae1mE47WMV8eXZ2Z
	0ucwbmi1OcvDWukrr/l9fd27DIpOzv730Gg==
X-ME-Sender: <xms:6QZQauU6GX7LHL5We58I0z5EKPOPXf-BSz9ucAVie_WTV3br0UJhiA>
    <xme:6QZQaiDJle558WsReD3YVHUC9FPtoqB1TSV0yx5PvrLtgZ5xfM22fqEyLYt0nBoyF
    AmX5hDfwXg41R8mExLXegzKBeqid7eH13TzGDpRfJW9LWPaGSZ9Sw>
X-ME-Received: <xmr:6QZQavxqd4Zf3_w5dYhKSi9YnwtMlEyVzizUumEqLvFa8OAFGhk0fmL4qyrJldTrIQZUkOXt_8G7vdwfGzXLeZ2fGp0CdV2SPR9lMK0>
X-ME-Proxy-Cause: dmFkZTEo+PGg59ez8bHF0fO4uc98iEhcEKRoHee25jfNZkEATjJ+N6IcyiQWK0IFrllqYO
    OyNqU0fSEZ651TbJVXALwuuGfkSVMl34kfdoJQ1qAvizueht+HCOdm67nWlVoy8AJx3NEg
    HyBy/frD/LiXnXTgPgTS/en9uvUXFPDP4RZYDFf0CH9vVN0hSO3R7QoF3OQbOHz0ZhGY1r
    hSyOioI6iG7BnqKw3UmK33hZBvORoP256l6b+LKm7vxr0g/9wDfCKGpAUeCa92JHx45O1a
    ECk2zWuyCF/9ElUkhVpxcgcj0dAQ75nv3XNeuClT5q3O3T1u9Ev7s+CQNiw/PpJKSTKDpA
    gvMIj5cU4N6meedYJ/W2y/qYPGHDAHy3Q+0mpI4lfp6KAy+uii6fVYrjHgolRj0qaKPz95
    mhjCZcGAzp0MvxuFi+EGDPjQWy0cs1DVGoj9j63y9S1B+omYparJ5WyH9+PyLHUAi0kGYY
    VQn8fj4dkl3/3DMeW6OKF/ZQFKazgqTW6/v5BWdSbIzJJflUj1386Fg2kQbviHrHV8CcPh
    q22BFXiG+jIcmbPZvSCc106IT8RkkC6mVVdWklMdLBzqgxVR8onlItP49bbyYXkx5oNRrv
    D6Kb5Nkl3TXcHo7qaMCgrkW6bRVXE0+FEfCF3avapVsbE57yg3JitWq6LsIw
X-ME-Proxy: <xmx:6QZQavB4EZy8oyfvtlAQkqyws-DBUd4xNGnLjSffqiI7zS8phRj8aQ>
    <xmx:6QZQasaZuS0jbST7w82DGdc-roNVgWJSgwUmEKBIQStKZM71f0u1bg>
    <xmx:6QZQanjeR7ngvqkBztClXKmVgt0Qy3cfAxWm2SoLEd2izlWHu0_Xfw>
    <xmx:6QZQau6S7AkU_A8rOKV14EsD20DV2BkD0XklwM3cGgUwclF1xHfdGA>
    <xmx:6QZQaiJHDASYLXPg_O4Dd0uvhqtY6i4-htUHjkJkqUeTwZdxL5Kv3j3->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 16:39:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] refs: remove use of `the_repository`
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	(Patrick Steinhardt's message of "Thu, 09 Jul 2026 10:29:11 +0200")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
Date: Thu, 09 Jul 2026 13:39:03 -0700
Message-ID: <xmqq5x2nlwyg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
> 2026-07-06) with ps/refs-writing-subcommands at 002fe677ca
> (builtin/refs: add "rename" subcommand, 2026-07-06) merged into it.
> Despite that, there's a small set of conflicts with "seen" that can be
> merged like this:

Thanks for a heads-up.

This seems to break so many tests when merged to either 'jch' or
'seen', even though all of them pass standalone.  I did not have
time to figure out what interactions with which other topic are
causing the breakages.
