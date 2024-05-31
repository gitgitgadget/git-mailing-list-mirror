Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D0770F3
	for <git@vger.kernel.org>; Fri, 31 May 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175113; cv=none; b=RoQb+iw0SSrLOdjOm+cor43DTVIFJ264NZWx0DtAA4bJSRDPEp/45L9i9v+Om9nVq9DWhFiCWc9e6gwswgfx3qcJYbblG7IKukpq++fqbeZ6SJnO2NjrNDRZ2hJycY38dG0NWcTzmRP1lddmklrczU0l1ZBQi8LrxPP9JInVp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175113; c=relaxed/simple;
	bh=a79FS0Y1LbgaIp99+KMzznFI1udkX26mm35xqNS8omE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IHQeuyWBtDb0k7ZrIdZ4EowI7ZkZqpw2xuA0aAtTiUpqeAsx/umrnKnPToG9/yVWt4cgcklKLorOVf814mToBgS5HrB+d3fnDpqeuqHue9OnCxOCam7h9eld5B/p/tF7D2aoTAb1bx+LEhcjb8yrhnBZYQEEELPsqn4Jai7QQQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TI0YzcU1; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TI0YzcU1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86CB01BD24;
	Fri, 31 May 2024 13:05:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=a79FS0Y1LbgaIp99+KMzznFI1udkX26mm35xqN
	S8omE=; b=TI0YzcU1eM9GqCXDifbQKcakz0UGtifD8Of/5DBAEFFbr1K4LwIzko
	g2/5DsxhoR6Of3/MfGAQsID59VA8DBAFiAqWezIg51bh6fX1wb3c0mOvMCRJNVM8
	78rrIm8ttbjCZa9J9v4J/Z/Z5Rki0tLJU9Zgrs05yMCFXC+V4CrXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BD281BD23;
	Fri, 31 May 2024 13:05:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7CAE1BD22;
	Fri, 31 May 2024 13:05:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
In-Reply-To: <40594bda5c8050c2a863df8c9f6f92cd98ea8484.1717141598.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 31 May 2024 09:56:46 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717141598.git.ps@pks.im>
	<40594bda5c8050c2a863df8c9f6f92cd98ea8484.1717141598.git.ps@pks.im>
Date: Fri, 31 May 2024 10:05:08 -0700
Message-ID: <xmqqcyp1gbej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EFEEF4E8-1F6F-11EF-A397-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The git-checkout(1) command is seen by many as hard to understand
> because it connects two somewhat unrelated features: switching between
> branches and restoring worktree files from arbitrary revisions. In 2019,
> we thus implemented two new commands git-switch(1) and git-restore(1) to
> split out these separate concerns into standalone functions.
>
> This "replacement" of git-checkout(1) has repeatedly triggered concerns
> for our userbase that git-checkout(1) will eventually go away. This is
> not the case though: the use of that command is still widespread, and it
> is not expected that this will change anytime soon.
>
> Document that neither of these commands will not go away anytime soon.

"neither" -> "none"?  It is accepted to use neither to pick among
three things these days, but the latter is clearer.

