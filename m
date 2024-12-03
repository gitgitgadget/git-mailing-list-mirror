Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C46143AB0
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 04:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200685; cv=none; b=Q/S/OReIl6nacOvyn//Ky17UTLkBls71NBrMfmpTAtZc5perDqawjbmfnMFP1RZtP4b+CYdipg+G+5CYrOTKYxXKVhpF6zcR2zVj5/AO1szqwjtR/0HwVodRCo49IcXX8DyLVW28yHz4DeoPgOGx5+1PAjZnPugh03YlEHlJrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200685; c=relaxed/simple;
	bh=69g93VWZ4HQci1pTDT9L9HVjUZIoBfYU0QBGLNNmwZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CvUGc+xRF3DeeJWl0HkHeQfqd3X4Eyy7WjcC5LILPnezagZ2uou4ZczKg9MeZgbKfWSiINtOCzxhtSHnuQNR7juf+yFoKHaPfXVQCTE897q3WBbS0im2voe5Dj2rscptwH+LuPsBb7BS1qLoQj2yVA8eeaQTr+iD98CLjRrVh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ky/7+bq1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ky/7+bq1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8B4725401F9;
	Mon,  2 Dec 2024 23:38:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 23:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733200681; x=1733287081; bh=jeg3pY46cV5vgtls4sn0wVRhSULSrnhxt42
	uqGXZZCA=; b=Ky/7+bq1AILJBzEjkY9onGX+ZuJyJ1211N71luwQ5NvY1oGiDo6
	T2Ee49n/FCn6smXBErKDebZ8l1p9b+nF/qw3J/XiX/HkMtruyezUnwvi2rI8TzNB
	FCXTuomgkT9dUck2EQT0CofNrs2/LGfI5faHuyMnE1n8HYvSM+jgyey1otpiYdT2
	L5bhresVaN/COUJa7ZS72rYOPeVOixGL2oeeWJcYrtmeKHFISR2VwiX3SBC/Rx0q
	/cW2NiGUKecRJn0tRiLfmW483A42cJbMqI8wTB+CU5fNaMB1V4ay+dfMRHfvaG4H
	buIpM5DL7Exp7YUYyNREDfEaxAbbRQFvkrA==
X-ME-Sender: <xms:KYtOZ-oC8Ts6ClP8FAQpnrUZhAniv0xroVuUsaeTRgjcjNLTBIB6MQ>
    <xme:KYtOZ8qV6vFRo9CHQUZQ_HvVDtcbhGg6v2Rap4XIsRr8JwZiCEccX7sKtJrRlV8gv
    44bKExa_ZPl8kBQYA>
X-ME-Received: <xmr:KYtOZzObDf1XPKuTSfHusRUQG-rhVu50XGFqsuuuiFFu2u3PXno-aimpPVThsZwy82A4FKsHd6aWc3I9WDFD6-VRt3XwDiWBkCDYWVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpth
    htohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:KYtOZ95SIorYc1aoYigvIBddnxh1ynk2DCEq-QJZzApSKF0AhObqvg>
    <xmx:KYtOZ96A_MtsVSIUwK3bb2h1Qcn48sEFnr8A724-VX4CLaiwVaXY6A>
    <xmx:KYtOZ9ju2Ievu7w5Kz1aK4zYriZ5oPQTaGo4E3W1Rr-DD9AiJ_XT8A>
    <xmx:KYtOZ35Tsa-q6BRUaIDZNSH3iaEKelQY2pi15SRabC6D3dsA9ZEkow>
    <xmx:KYtOZ6v2rNc931Nc6SeiVdIq2YSt1IPakek1ULdABLP5msc-IQL7Kla9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 23:38:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: rsbecker@nexbridge.com,  'Eric Sunshine' <sunshine@sunshineco.com>,
  'shejialuo' <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
In-Reply-To: <D61R68MFWDIU.12PI8AA8S3G86@pm.me> (Caleb White's message of
	"Tue, 03 Dec 2024 03:42:02 +0000")
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
	<xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux>
	<xmqqed2pioff.fsf@gitster.g>
	<CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com>
	<xmqqo71tfsif.fsf@gitster.g>
	<025b01db4526$3b05ef00$b111cd00$@nexbridge.com>
	<xmqqiks1fqgl.fsf@gitster.g> <D61R68MFWDIU.12PI8AA8S3G86@pm.me>
Date: Tue, 03 Dec 2024 13:37:59 +0900
Message-ID: <xmqqiks1e5zs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> You're correct in that the worktree ids are only relevant within the
> context of a single repository. However, I've already demonstrated that
> it's possible for a repository to "repair" (i.e., take over) a worktree
> belonging to another repository if the ids match (inferred backlink).

I know.  But isn't that a BUG in the code that "repair"s?  If a
worktree had a name 'develop' that was OK in the context of
repository X, and when you "repair" things so that it becomes one of
the worktrees of a different repository Y, the "repair" operation is
what MUST make sure that the worktree that used to be known as
'develop' to repository X does not interfere any existing worktrees
that is attached to the repository Y.  If the repository Y already
had a worktree called 'develop', the "repair" operation must make
sure that the newly adopted worktree would get a different name.

But then, the concern is exactly the same when you try to create a
new worktree (no "repair" involved) in repository Y and try to give
it a name 'develop', isn't it?  You have to make sure that there is
no worktree that is called 'develop' in the repository Y before
giving it the name.  Is it broken?  If not, what are we doing to
make sure we won't give the name 'develop' to the new worktree?
Certainly we do not use any hash or random number for that, so why
does this new series need to use a random number?

