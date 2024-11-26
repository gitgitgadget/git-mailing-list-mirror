Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FF2192B77
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606761; cv=none; b=BI2wdRG1l08nUb1gzuOltGpU/ZkB+toPRG2TBT37D99b4+nHLQ/B0Zv7JX4Lk/W2QCCCyPgmoYtik4bdJmlnwGhEeHFZOEukNAFw540WP5bxuPRs4Il/4hSM8Rle66YmWxgHwwfd4xSW6IvAYac3JB1hD5RURYnSoRxq1EyKLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606761; c=relaxed/simple;
	bh=DbFr0wDIwFW8Yel/aRbWShfkIQR46tGiZD3HKfaUZuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kl5U6S0Qj+mkJNcx+qFYpmlZAl7rO4hfa9MPBI/WdeBrNvZrsu5IujetNvjx/o+9kInIOvgq4+STc+aNvhmKrrBnti0AzlU9+1H1OC2wGwh1AJXywI3MidEL0KVPaZ+QcwJNnfkB3Z5xTsrsqzrxz+DqwumIjacjTaIYrpl0sRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0LPVMSfS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0LPVMSfS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C87891140194;
	Tue, 26 Nov 2024 02:39:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 02:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732606758; x=1732693158; bh=DbFr0wDIwFW8Yel/aRbWShfkIQR46tGiZD3
	HKfaUZuQ=; b=0LPVMSfSIYb4Wa+rCZK+SKLmPSJzxkwd39FFBa/e8rdK+N9RlpE
	kOdM8WJ6KL5ZqF0IfjGde7867YFyv9kogaRvtZPR71i9IuN+2jKya8YgoD5M9g6K
	UN+mRgciJvyQ1IzQxw0YA7uIYrqv+XQvHxrQaPgKcxR3cawhGdVxoZ/qYMzCYy/j
	jLFHNmXpYVJMX3vDsJUD6ZhPsdmuf7xDEXtJ8C0QlkfVS/NH0BvhcLUk06+kmYmf
	Woau/Yxy7jSvPJoGdhSJH8QPFRiwTyB79Wb7t+HGGpM+V5qqLdfb0RX/EM/Zx/Nj
	CMGZM3vljHY37+vjRn+cBCm6QEtumVz97bg==
X-ME-Sender: <xms:JntFZxPlWlvAwaH5QUTOf56gB_EU7NbIMBQdzJodbip0vlxtaAeagQ>
    <xme:JntFZz-3_H5Dy8uwgzZADO-4EphSZEHzJm0aPSTFWXgy9BzEl0ieZt8xKT_s-giWa
    NTbPGH-UI3wWrDgbQ>
X-ME-Received: <xmr:JntFZwT4sKXjoordsQhUvXm3iD1H5NRma8HoyhjCPc3b7YiJG1TwOaPWqNlRhWkQNZfG3bGjm5U-5pYg0iXWjoITZ_ECH6eYBdxT3TU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggv
    lhhinhesghhmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JntFZ9udwOvi8dBKn5Gs329TRGkZvX768qsWT6y9Uib84ifhpBLkNA>
    <xmx:JntFZ5e8_Rpaf9gN3LUuNiUYH_wzp3oA6rSujn7_nLmbR2gGc0gFxQ>
    <xmx:JntFZ52Sk8PnbzsgqgQ6Q-IsS8VQ8uqd4NS5hpfSe_dxeMColAvXZg>
    <xmx:JntFZ18M6JyzJ26ZsuMlLjjB-RI0Peg3Y2SaMZWYzpy2I4-tfyOE5A>
    <xmx:JntFZ02rLCyzW0H9Jq8pvZPa2ap7gZac5QJO-8DAO1aNf_rl-WpbU531>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 02:39:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  peff@peff.net,  johncai86@gmail.com,
  newren@gmail.com,  christian.couder@gmail.com,
  kristofferhaugsbakk@fastmail.com,  jonathantanmy@google.com,  karthik
 nayak <karthik.188@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] PATH WALK I: The path-walk API
In-Reply-To: <Z0Q7oGF6Q5U-f4VX@pks.im> (Patrick Steinhardt's message of "Mon,
	25 Nov 2024 09:56:09 +0100")
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
	<pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<Zz+61fat+vGgb+xL@nand.local> <Z0Q7oGF6Q5U-f4VX@pks.im>
Date: Tue, 26 Nov 2024 16:39:17 +0900
Message-ID: <xmqqa5dmzboa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The question of course is whether these tools require the path-walk API,
> or whether they could be built on top of existing functionality. But if
> there are good reasons why the existing functionality is insufficient
> then I'd be all for having the path-walk API, even if it doesn't help us
> with repo size reductions as we initially thought.

Is the implied statement that we didn't quite see sufficient rationale
to convince ourselves that a new path-walk machinery is needed?

Thanks.

