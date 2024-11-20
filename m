Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB47AD27
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065462; cv=none; b=MuwVj2jVQYL8Kyjd/vUIpz5FCWJq6MEB9TCU6n4u+VIJobUlXB9ovgVOGlgeWZ6Lz1Fds7sLKYeiMWvHaXPm/rvMBPMYuuZkrSN01TJ8Xco6ONmDH1IEmrb2+UcHFdX+56lmwez5H71jKUS+6rocgfh0wDhKCfgus7da9j6pHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065462; c=relaxed/simple;
	bh=TWCg4IFLogv4bGmpiPuiQl3L+WNXufp4EgmzZg+VAf4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOwNDmTMoxUmyt92vfFAMFUu8G+rJtUx384a1bJgQfM3eUBi654ZCSb+9qL05X1H2rnkcDJVeP4MlLiTxMQQgq5VZWeBcwDGL7TLNQCVB3B5n0C22Pnz08pMKk/5UmK+Kl/xmObpzQRPaMIVFXWJZ5oq2PZvS0QmSv6Mv/o4AX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brINuV3j; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brINuV3j"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 26AC311401C4;
	Tue, 19 Nov 2024 20:17:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 19 Nov 2024 20:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1732065459; x=1732151859; bh=FwD6K9LvsDQjEC/I7vBsDgLI2WORMqZ08dP
	QMY4PGck=; b=brINuV3j+oUr5fcL+dTLx+VXnk6LStq5/N8e+BhAjDYWzNqVTOb
	vfqs6DHhkhnrbNuLHU0nhduAgpQXvkYbYRS7AzvFGxkP/R4IcVeJV/e5uXVsvdQa
	nUIaMjiWJsrtIG3HucghWa/4E04ODEkSNKulupftzQeHdjuCJBQ2ZuRFbM9drGn2
	D1p/7rnHYcVIpEiJBeVzjrz2Kip/VHcpW/ICuux1be6n/Vj/hWb8S5w6ZvxhmgpG
	UeGCAev1VWbhVnmMi/2iyAgTXEGdkkkTcACrucaPsx3QHY1PRhKGMSqkHfUovvA6
	fqjrDGnCs3ZKiXP5VvLVNZIajOZ1/HM1/sg==
X-ME-Sender: <xms:sjg9Z-xY0ugUhI_ffVTGBycWq-adKt1IdUksxb6TnGfdRMVuA4D9GQ>
    <xme:sjg9Z6QA-gYABXcSY-WwFYyj7Q9PLkDxGiiwLPs30wP9JYcmPUGMvv4xjcfjNeLDa
    -a2iARFZu4T5E0IZQ>
X-ME-Received: <xmr:sjg9ZwX2lVtdZD-4PIBDzLz8Lk1BIbzQZBNN4C4Xv7-m7co5MF_5t2vT1qfQ62r5A6aI5ZjPv-6L4fiwSPHI8DYd1pp7WfjviXlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeigvghnohhtvghrrhgrtg
    hiuggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:sjg9Z0iqYSGCWQZoSSomXT_E0NeY0lFMqpp2sbQm9zpm8bfXePlbEA>
    <xmx:sjg9ZwD1NZzi7stjMmlWwqTsl5sHN48kuzdnvTDfjXCA8oa0E4PQjA>
    <xmx:sjg9Z1Lt_Vl6kuAGVA78vdhlNiZT4xD64IM_anhzEZtLGzWi6YlSMQ>
    <xmx:sjg9Z3BJi8rgXCZ8kOi370qg_TjxwY673aGfcegvUgBmDOO1OcqBYw>
    <xmx:sjg9Z_6IY7em57bj_b86aFgpYEd6NYkA43mK3Eta-jvJMrPA_0quguw7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 20:17:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb Cushing <xenoterracide@gmail.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>,  Jeff King <peff@peff.net>,
  git@vger.kernel.org
Subject: Re: git remote set-head automatically
In-Reply-To: <CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
	(Caleb Cushing's message of "Tue, 19 Nov 2024 10:40:55 -0500")
References: <CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=fh0UwO+9-6RRfA@mail.gmail.com>
	<20241116033616.GB1782794@coredump.intra.peff.net>
	<D5NOZMMISX44.2PTTMY57J5EM6@ferdinandy.com>
	<CAAHKNRF8JDUTH-QzPG1b4-wafzU+MXaMNinfBRu3JfCssfwGUw@mail.gmail.com>
Date: Wed, 20 Nov 2024 10:17:37 +0900
Message-ID: <xmqqv7wiaeku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb Cushing <xenoterracide@gmail.com> writes:

> sounds great. I think I realized why I didn't have it. It's not done
> by `git remote add <origin> https://...`  my experiment was `git
> remote rm origin` and then `git remote add origin ... ; git fetch
> --all --prune` I think I also tried without the prune option. git
> version 2.46.1

Yes, "git fetch" does not notice a missing remotes/$name/HEAD and
does not automatically create it.

This is being worked on in a separate thread.

Doing it unconditionally may hurt some existing users (including me)
who see more than one primarily interesting branches in a single
remote and want to force themselves to be more explicit, though.
For us, leaving remotes/$name/HEAD missing (e.g. by "git clone"
followed by "git update-ref --no-deref -d refs/remotes/origin/HEAD")
is a way to allow ourselves to say things like

    $ git checkout -b mytopic origin/maint
    $ git rebase origin/master mytopic

but not

    $ git checkout --detach origin

because the last one is ambiguous between the two branches of
primary interest.

But hopefully they have trained their fingers not to say "origin" by
now ;-) So changing "git fetch" to auto-fill remotes/origin/HEAD to
whatever branch the remote is pointing at at the time of running
would be good enough for an initial enhanced version, even though we
might need to further improve on by allowing folks to opt out of the
feature.
