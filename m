Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077DC8FE
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457631; cv=none; b=gr263KvHKf0a7gpo8vUovZpjj5EUwbo4spjRPXEfYNef72jsSZiW5S9EX1BD2qiWs6MRn+yLDgriwW3hu9bcNUl7Qh0ABBXMIWU8XLJ3yNaif7DNpRMKWWjOLnNaTwqmb9O1dgH072HOFQTNYBPl2Gdhbifa4LSuZEs0o7tT8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457631; c=relaxed/simple;
	bh=Q6NP/HusOyORs6FxI7LPHhr5P4eZxsUiBsA2TWSkRg8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXoBepr1Pa6KLoJmrhaUvqNXveUfQNvMoBkGvdShtD3xJaN234HxyNF3V111/94qnky0bVlv7bEPj4F3/zvbgBdamuj+OoUCKjj/r6ltBywzNMIe1Y+oJFMoGw971Nz/8kLi+utXpemSoSCKZND2OSvA2JaTG3PpkwMjg7oSjyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZUBR9jN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZUBR9jN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C5DDE13814C8;
	Thu,  5 Dec 2024 23:00:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Dec 2024 23:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733457625; x=1733544025; bh=7f5xPUTiAzlyHg8oyKOl8kLg8tJrWYfSCsD
	sX9gI4Ig=; b=ZZUBR9jNDrZ+oUWsTGox8UEYgP9i5BgYhhwccpEklOlePUld4NA
	aMPK/in4Hi7qHSSYgriLztQ/gp9YAOqF8kZEfxjdbi1e+vrqhnM2LkdZLnN0uYIE
	ntNtE9LXQc8ZY/xrJ1GdaulgLGEHFilVB0C+hWjO+0YcCHRlcMYP4nL+l4IRtkbv
	12Syi5+vJD2SypQGdSINK0WFGwNS6OtkzlKvrtL5dNTW9WfXjsBU2TkVchXKLHcq
	ZmZ9ixJGkGBMnvK+ZlqA6/w8njOkCB4OZ0rlhqHf0u3b3D0Uv+vJ96uvWLWsFE7M
	9SiATq7bhyDcHCKikyZ6yGE/FqXj97W32uQ==
X-ME-Sender: <xms:2HZSZ-Qh79wOotLp3ZzPEw22Gh8OdXmA6ws4t9UAL4lQrdHHOA86yQ>
    <xme:2HZSZzxiaigkSA5nyFy6kbPMmfJ9DY83c5xZTBafg74IWuVKvjqf2RMqCSkrnkbyi
    GYqU9OBGb61zzAa4g>
X-ME-Received: <xmr:2HZSZ70TPlh_OuocpNYGsxGtffzkGE1JZAiQOb5YAh4yNXdEVpzFtZ6SoQBrW_p6jIrIvxJkOXsNfADxJW10XjTdIyTEEKT2QfdG1G0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2HZSZ6ChSbW-0uAf-wgeivfV0KfqNs2rzJ45GWvm5qfPeKeFn1AunA>
    <xmx:2HZSZ3hVU1ODEEXxnL4dZst-_Tk2EsSyE56X_G4NDfbjhQLJ96zmsg>
    <xmx:2HZSZ2rQy7S02vRBCfqGFG06OuFMT-Ueulk7eUMzhvllpfUDT8Ntkw>
    <xmx:2HZSZ6iKXJjvaVjke80ubSTwfzNkNPsaSuX0TdrzTLlF3DRCgNfZ8g>
    <xmx:2XZSZ6rR_u1Y8_vcrylxHsOu0s0h1pXRGmy5P7SfoWPU0oo5Lr29GtKY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 23:00:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  bence@ferdinandy.com,  phillip.wood@dunelm.org.uk,
  l.s.r@web.de,  Johannes.Schindelin@gmx.de,  karthik.188@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  jonathantanmy@google.com
Subject: Re: [PATCH] Fix `git fetch --tags` in repo with no configured remote
In-Reply-To: <xmqqcyi5zdzb.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Dec 2024 12:28:56 +0900")
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
	<b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
	<xmqqcyi5zdzb.fsf@gitster.g>
Date: Fri, 06 Dec 2024 13:00:23 +0900
Message-ID: <xmqq8qstzciw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> And if we unconditionally add HEAD even when we do not need to,
> especially with the loss of the ref-prefixes condition that was
> there in order to implement "learn refs/tags/* hierarchy only when
> we are doing the default fetch", wouldn't it mean we may learn
> refs/tags/* even when we do not have to?

Micro-correction.  "We grab tags only when we are fetching something
else as well" is what I should have said.

The general direction my comment leads to does not change, though.
Because we ask for "HEAD" even when we do not need to, the
additional change this patch names to unconditionally add "refs/tags/"
would make us ask to list all the tags even when we do not need to
see them.

Thanks.
