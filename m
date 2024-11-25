Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A617BA9
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732504959; cv=none; b=ntDWgx0h3CEw60mSKYMLorNh7Oncda6NhrV7+YSc5Lk94E/R6nTOI3+K+U9V3lePPsci6H7glN3hI2aH+abwyTefe0XqtUPfUseDigrJHzDWl+rIxN38SpQP8BsEgRE3oRG3WvhBMZrJwYfe5VCJOYyE6/6b8n8MuBTR4zix/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732504959; c=relaxed/simple;
	bh=ePcwpHuRQgumWJl51AzGZyEOefSJxa+Dv13YEwiTECw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYWtVo6L6uTI9QUUgifTW1Xa03HOfnZ1gkCwarqN9p1+jXXCynuNNlYmQHs5I+DO+f36Y58w65/gS2OF26rOsesW0AhsDXbOAijisjx4qV1ffSegdYmEIA7wyr5GzMqfbwxiPp7InjjzccJKoR6T6wfaQviIh7geQaVUR686vNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZX3KcRL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZX3KcRL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C98392540166;
	Sun, 24 Nov 2024 22:22:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 24 Nov 2024 22:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732504956; x=1732591356; bh=vVaambTTHfJj/ZrDIbiWcEUgaPtmM2dE/ic
	Or1wZtUg=; b=dZX3KcRLG0QhRNKeBvYLdFTBmWgf+A5qjgHd5hdow2IdBpWqr7J
	VVC3kIJo9lo4eXutNQDXYb0G5mKwYnKX/ST5ZwR6BQG1MRAGhYypL3qbmGe07vTK
	eKrlCBbPY0o6EomTqzD2MemuVepLwRXNY/vfanKyVl8NvGEaYM0WQS4hqHlH2KgE
	TV9f9TQRojTyf7bZRxnOhRcnDaIiq/BjqVTSIrNNvPFqd+h2nzvooFEC+0c0PWP8
	hGq0Aeplyva8sw5TnsL+ULLVJ7fUz+mnE4eU8h81MAW6XJJ6VDSHVKFaJKtaUmb2
	sIX/ryXVO3oSjWQV6H1hWPIyRVeVFUxFZow==
X-ME-Sender: <xms:fO1DZw9tX4vdVRU0Oqps0CIozdMPNEGcnWqajE2zFnyzaCOWMxQCPQ>
    <xme:fO1DZ4sFZ-eO5uzjs3NXZxoybff8HuTvp92HtrDxYQIT7afLJOnxwnxMstdiIcMa8
    dqVlMe7NTqzhaJoIg>
X-ME-Received: <xmr:fO1DZ2CWXLM63byHEXbVKlacgJ3C0ZcengQXmVw-XgZ7goJbwfKKQEeuBnHEoy2z3l4lnKdr7ZxSVw3VkJj19_9tqfbKLEdurVP9HHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptedttd
    evffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledunecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepphgruhhluhhssehoiihlrggsshdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fO1DZwez6bL9COcJhiQDvKMJnAKxWhYJm6fnzw2lgy0GBn0Agbq7Jg>
    <xmx:fO1DZ1NIEX1dDmVCgRopzKYbEihV9lJRsdyBBmwR6hXZvr6oaRb7pA>
    <xmx:fO1DZ6n5wO7K2lqFKJjsauL0pK6blAGmY7HbPEUpFIFsrTUjEzGHAA>
    <xmx:fO1DZ3u04TAvgCtS9yr6cvkRuwORJVdSbqqEwFlR7nWNVnq75102Ug>
    <xmx:fO1DZ6o36Us9GVASFwVyZ7Q-vSTVlOzO-CyHIs1pGXMiWbw--jMH2wZK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 22:22:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,  Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [GIT PULL] gitk: synchronize repository trees
In-Reply-To: <2c70404d-d4ee-4e42-a330-b7fdc7c8f8c0@kdbg.org> (Johannes Sixt's
	message of "Sun, 24 Nov 2024 18:39:43 +0100")
References: <2c70404d-d4ee-4e42-a330-b7fdc7c8f8c0@kdbg.org>
Date: Mon, 25 Nov 2024 12:22:34 +0900
Message-ID: <xmqqbjy46lqd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> As stated in an earlier message[*], I am taking over maintainership of
> Gitk. This first pull request of mine synchronizes my tree with that of
> version 2.47.0 in the git.git repository:
>
> $ git rev-parse v2.47.0:gitk-git
> 192acffcdd37921fc1c46c0373806651876d772c
>
> There is no functional change because I only continued on top of the
> commits that are already in git.git and cherry-picked the changes listed
> below (which were tree-wide changes that covered gitk-git) into my
> history.
>
> I have prepared the change that brought us here in branch
> tp/macos-visiblity-fix, but it is not yet included, because I want to
> give it some workout on Windows before I move it forward.

Thanks.  Will pull to synchronise the 'maint' and then merge it
upwards.

>
> [*] https://lore.kernel.org/git/5ccc1943-c2a3-4896-a858-aa5fd6cdd426@kdbg.org/
>
> ----------------------------------------------------------------
> Josh Soref (2):
>       doc: update links to current pages
>       doc: switch links to https
>
> Taylor Blau (1):
>       Makefile(s): avoid recipe prefix in conditional statements
>
>  Makefile | 4 ++--
>  gitk     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
