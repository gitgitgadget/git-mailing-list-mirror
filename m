Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68ED46B5
	for <git@vger.kernel.org>; Wed, 20 May 2026 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247612; cv=none; b=Tc7radsTnO3LIYq/7ydCV6BcxhZQ7IxPBv0wgoAOyK7M89DiwKFSQ3X8YzXMpN+Hg85xAi9OhQtk8zuYUAPY2ST0h+LGCMrlnOJ/QUMcDemvSCZIAOi+1e3Zb5EqFQFT91bYrita/8Dllkkxou730OVpweAQQd/2d2ogfCuKFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247612; c=relaxed/simple;
	bh=UefEMouLMxvRDZoO0GrQeMUor2DLsVoGdWtC4ZK6aGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bBKnAucPD53tZcc9gCdIBWcmV2jtbbHKDUI2zSGGuW5CrXBbkZJHgYW59MvOXgpdAAnZPnpC9H+oGqsoxzx0TQudSXzxxG1r2PfckWEBiWp/B6RsCMvj4jyxRXW2tEnthaCKDDEpEn3+j7Z8x6EtL+MXtHWHaZ1mhpTHLAsbkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ki3/Okcz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1K4WC8k; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ki3/Okcz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1K4WC8k"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 570F81D00112;
	Tue, 19 May 2026 23:26:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 23:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779247609; x=1779334009; bh=WXEK3obBZc
	KhX4lO8ruwgTqR7kgsa4PGqyIXEaRBn4Y=; b=Ki3/Okcz3ouhefsDz0gZleXA8d
	R2cVphylCZ2ay/F3KHaNSBHq7ArWjt5pN7B/Pji/3lxfIubeYcwwYLnHs5folcg2
	QQkB+3nM2YXiw+O07FU7m0yWbkesQMGhxRJ6PN412lsTZIuzBR2iDYQOsHS1fC9f
	8PWuIhlPmXdjJ6IctcjLkr4aWeQM7lNiM7gz4TCJfyLyRG3vWXlPJEeEeDaNeLDq
	vfhOev10ZP321GDm9pNpQ0BtAXdrxiwg8/n2grYoSjXnmpLrXIw1jkBsjiAH+VT2
	Vr4dn1G9chnDY/oHkAwoOrYftHuuFwaW20wjy60NRmvaKpFFbxmOch178ndw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779247609; x=1779334009; bh=WXEK3obBZcKhX4lO8ruwgTqR7kgsa4PGqyI
	XEaRBn4Y=; b=M1K4WC8k4Vh4P9r/SOUVXnA8QLSBSy+lkC0vMsMQ4NsyFbJ08Zb
	IiWNYuLrUJcvjzjwXX6cPvVmmttvVaf9Qgo6XGD3rCf7uyGcDMzXetcwhtm7gtMS
	uOjOtbBJFY8Ioq8lL3aNDmHb8YlByxz29xBCrTI7we2ahOBThOs09TAYSuWAaKEi
	6XPaSCXOhoiiT+k6pXwlbE77oWpxnbxg91LBsNGxCtVE+oM8pmibErEKUA8rrARp
	3iqvR6Bg3zhZ5G68WH+aASqYMqDN+p+1ka/sNrO/Xu/OQeiR4+HYl8jhvDkIh+OT
	bkBdzUZLoGLT2L/qIkpTpvamXs3TjPvAs4Q==
X-ME-Sender: <xms:-CkNahWiAIJLyDNAKzmKo8G_2UqSGp0UpKv1cHCDTPtA1s-Fl2GAUg>
    <xme:-CkNagrcqBt1ROQudut8s-JRn-MNciDuPJgJ6zf6TsZH7AJbI6r_BH8JMbXboCOb_
    13_JeqvSQ0rtjRpllPDSSxMQ2mHpXhWH0kRqPpoA01sw5yMwFqhwA>
X-ME-Received: <xmr:-CkNajlqW5XXZIE5kkkcEjpQ5-J5mgyv1L1hPovwwTO9dRkIc1FNteU0YEXTxTreXFSrVScMe3BawQKpRQU6JNGmu8iyriiVQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteehffehffektddufeejtefhteeiudfhgeduveegleehgfeiieeffedugeej
    ffegnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsih
    guughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-CkNag2O0IhH0m8fkus4-lQmWGeshl4fYgotN3GgLZjjzs3WDmmq5g>
    <xmx:-CkNagS4pgK8d27udnDW2bHZaBNXNsbo-gDWxK3QENGaKUmDmg39jA>
    <xmx:-CkNapzvt-ZJ3ccsG0wfFeabuD_gNKnPfNpB0VbxoJrD8rC0v6ktYA>
    <xmx:-CkNagB-Kiz9lng7zBB7mQDToWBlrtsSmBW-QiTPA3bboqBFKUkZYQ>
    <xmx:-SkNakPhqy2PmVfF1fj2SPoqURNvQm9KWA31FtZTqGFfV8hGl4-9D_cH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 23:26:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com,
  jn.avila@free.fr
Subject: Re: [PATCH v5 1/1] cat-file: add mailmap subcommand to --batch-command
In-Reply-To: <20260416033250.4327-2-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Thu, 16 Apr 2026 09:02:50 +0530")
References: <20260415150943.40493-1-siddharthasthana31@gmail.com>
	<20260416033250.4327-1-siddharthasthana31@gmail.com>
	<20260416033250.4327-2-siddharthasthana31@gmail.com>
Date: Wed, 20 May 2026 12:26:46 +0900
Message-ID: <xmqqwlwy4v7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
> but this option needs to be set when the process is created. This means
> we cannot change this option mid-operation.
>
> At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
> process and it would be useful if --batch-command supported toggling
> mailmap dynamically on an existing process.
>
> Add a `mailmap` subcommand to --batch-command that takes a boolean
> argument (usual ways you can specify a boolean value like 'yes', 'true',
> etc., are supported). Mailmap data is loaded lazily and kept in memory,
> while a helper centralizes the one-time load path used both at startup
> and from the batch-command handler.
>
> Extend tests to cover runtime toggling, startup option interactions
> (`--mailmap`/`--no-mailmap`), accepted boolean forms, and invalid values.
>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
> CI: https://gitlab.com/gitlab-org/git/-/pipelines/2456596910

I do not think we have heard any comment on this iteration, and it
seems to address the points raised in the reviews in previous
rounds.  Shall we mark the topic for 'next'?

Thanks.
