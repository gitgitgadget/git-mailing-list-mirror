Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538F136E
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753575410; cv=none; b=Z+A3mMFl/yHRfTq5jHOYuqRg9f9Ki9H/lw5pX7sG6VSetA9BPo+aDAdS6MooLFnns+YSb/q4ydSvRlAVJDpNok9oiEf25iRBtyK1FTWANnBzfgjYPLCRueFzikR13W9FJ7qDjZOqjpWuoI28C3dIrkicFYacovqCTIP0hqZqR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753575410; c=relaxed/simple;
	bh=YN1Yd1pIDj9XwpqZH1AGR6zitgVgnLmVY3X2Ci1lr1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkamgPjtYta13U4D1OOCzAVJaZEqdzr0N72KCOWwlZPtZfqdnjsIFyaJ1AssDbKtw+7MC/b4zgJdhD4ktGknz9hnlgG8alrvd2ig9wisuz8IGCVfp5RRl0AhHxOQWKjVFriXVbAi45J7J7baDE4vjPcv3BritOM4ZyWwHYyrrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ER0XSXAr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJ9cl1WV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ER0XSXAr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJ9cl1WV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B4BBD1D00D0F;
	Sat, 26 Jul 2025 20:16:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 26 Jul 2025 20:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753575407; x=1753661807; bh=n3wfW6l7+/
	k8DtqeV2V2Jj1Oigt4nYWlliqHxVrJX3Y=; b=ER0XSXArTO9A9QBQrqD3z2631u
	wAj6toblCdxDBmyWJ5Ryoug379iWMIiq6WU9sgTvMFC2x1WtJqNOLnYcIyrzJ1iR
	FXgUYu/ceZRkBCrUVv0/oVTt1N+tIxNtpsgkfb4EpL8/OsvdC/E7Q+M1nVxmMouS
	yEqribLVZt5790C2Esagz+pznKjNmcSOcWNNdsiF2M3tZPhkWspYbJhpO/V4b8ir
	1T1gzzo6jndCXkk4a0kE80RsYBfUoVcAYsD+CgZzjH1A/h/cqoEJW4uwfrhhFKxd
	K3suLXhtjeO3y0eY47g2uG309IZOp/tIe33S/13H+zeM2Dq+DqjK1mqQET7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753575407; x=1753661807; bh=n3wfW6l7+/k8DtqeV2V2Jj1Oigt4nYWlliq
	HxVrJX3Y=; b=gJ9cl1WV12RX0IjG3TgX4mMclvz5ecdymRIc2+v2Z+H8r/uuOXx
	s9Qjboye6sIB5CfsP04JPQO+3y7zSi/s8Tj35U7GxhWzaFkdk5u0u/SgT8XSVd3I
	lOGQpBIOl4tGZ1a5yPkHVn0vwN5cIQGHuzRkGvJ13Z6Unky3EaQFnRzFpTrMAITV
	ePhB47gE5vP+N0/2YuKHNh+63+CrvnVY14OphI4oLe0zi5NS1NvcgbFPhy3x9Kf6
	lbP4xS/pr5/0KrI1niik4za4/X4zK0YB7SJ7v4y+QMrUrZVPN2/T0heaqx2ZGtyp
	9Z28T2uQbe64QAyIJAo5BT49VkE3kjtVMiA==
X-ME-Sender: <xms:72-FaALt9qpVXI81Bl1NoJTQMzfxuvWOi1Dn2VVetUSwQP5dWJFwHg>
    <xme:72-FaDa-aBKFzPrWTOPCfOXy2_eNhonoAhqV3AaDDTQA58NYZ-xFTje_XvlME9t2U
    gAjRABoSrIWh1lcgA>
X-ME-Received: <xmr:72-FaKIEEAj-trkxtH4qPnk0IZkkPhImPHqRXHziLRwWFolqLyqf4UXu-OFD_xd6NmU3iezDkiAADI2aqT-huVgVZ442SsSNhPTy9qM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekjeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:72-FaJAAtf6eD5SU0mZw6kCxDFSbaFENpoS3uiKSsfkyx_cptYIcow>
    <xmx:72-FaHoe5ICq64sWJCa1_bwpzsuydSrOwyVUmHp3OpZEzV-R9Qw6Yw>
    <xmx:72-FaMifzSaf7vwTUhuPYpuABOa9oX7KAnrXw650YzyaLp-AJZgs9A>
    <xmx:72-FaMB4qWIy3GMUa9UwWhu2VxvdaKOmFYf3AsgM8hQEKrZJT3-uzg>
    <xmx:72-FaEDSLqq59uD_ke_kQMiqnORioXRyH9Wmies2USpwcQSvF76AVkcu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 20:16:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
In-Reply-To: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Jul 2025 09:44:30 -0400")
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
Date: Sat, 26 Jul 2025 17:16:45 -0700
Message-ID: <xmqqv7nezdw2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> With Git 2.48.1, I observe the following behavior:
>
> - "git ls-files :^:Documentation/RelNotes | grep Rel" yields
> "RelNotes", as expected

It is deliberately confusing to spell ":(exclude)" as ":^:".

> - "git grep squash :^:Documentation/RelNotes" yields the error
>
> fatal: ambiguous argument ':^:Documentation/RelNotes': unknown
> revision or path not in the working tree.

I think if you write it in longhand,

    $ git grep squash ':(exclude)Documentation/RelNotes'

you would not see such an error.

The error message comes from setup.c:die_verify_filename(), I think,
and setup.c:looks_like_pathspec() allows the control flow to avoid
calling that filename verification code path.  It knows to let the
longhand magic pathspec go, and it may be trivial to teach it a
shorthand magic too, but I offhand do not know the implications of
such a change---there might be unintended consequences.



