Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC97198851
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530910; cv=none; b=AC34osENagME7iqaXRZpYaj0r+ddH7mokTGk4LZQ/nIVc+dywptrrEiEY/Cx9XmKBN2v4in9AvE/0ZzADrbjF3DXNRuGG81GGUYB1szCJIMYusfcPSLpvQCnzLBfnYca4/qyoUkZtCriApV+m0hwLT7F7xJxvGWryzUOnE+/VZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530910; c=relaxed/simple;
	bh=B+dQzfHbK2yNB92cTJfIBsGwuM39IQGD9jXPdO0v0Lw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VW8jPCDQl+jWPxq69334DldawbkjA256IQqBepGDOiRvHvEXaACnFiJcf8kiVZtX/E+YS0wWZbBjAZ6V3+l87Y6hjJjAiI4zqVMnNDJFKa1MTtaryc0HgGcbCIwc4oPVVYzj1XJ2NwLRi/ulvDF+yZ9WZHrPyG3paHnHSuXcz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gkkb5A2I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J1mFluz3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gkkb5A2I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J1mFluz3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 915221140150;
	Thu, 24 Apr 2025 17:41:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 24 Apr 2025 17:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745530907; x=1745617307; bh=2vCoCnE+7c
	yg5sBNxbP3Uy92GQ2HsPnAruDtIhl06hE=; b=gkkb5A2IAhjHh9l3kbASgcIEVj
	xcM9pTeg7NPcc9he+KYyQBV4RHshTIOyqT8q2b8guNQpSXq82yodIVIq6mwFiS4i
	5WdlqfO1p5ILXRMo1LVItYq0QRO9p/WnWS7Ce6tWQYzbOCGJhVxcWfHO90qV+Vg8
	CFYGer0ACbeXyP8ot2cOSR4cgbzWW2UUBP/+r6P8Jwe/V6worigzoFp/Xs0V12G1
	xrRfjCJrfVtSbE12Tjhgw6ojigAxS0+VkGjlPNMZ3GkO5E+B9DK4fEop1LtOSxKU
	8eavnLrJqTyRUx9M1I73jsaCaQEm/dI9O7tyToA8L+nCaR6zWSOz76O0olZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745530907; x=1745617307; bh=2vCoCnE+7cyg5sBNxbP3Uy92GQ2HsPnAruD
	tIhl06hE=; b=J1mFluz3StJBx4dYYaX355E56oGjE9j95rTafO/C5548eT9JJpi
	Zte5e2t1O7SJdKYs7tLq/lZ60e98JwbFayvCh1jDQ03TptfLZVn47qImrHBJu/vu
	I2Sx2FxEBgmdcHkXLxO5Jlkz4vYiNRyzYyAcXp/KfapTFK6rd6EoekDDVtUkB1pt
	4yffMlwlwZKkrAAf1i+yga9rLlz90zW9mCGoTSz9LOtG14WqpVQS4vgPkWLhPsJc
	mn9Jsa4eBBf8nDQFUzvc0SP3muelWKAy6xt6fLfxUrV5H8ZSLOSBqhEByDSy6xfs
	n4TSmESApOr9LAB1alvI3DQOpCTqYcdLFkw==
X-ME-Sender: <xms:G7AKaPlTMblvSJweZCxpwwYrC2aj3FLS9nbZrT71Xlpu0Jq0WyLKqg>
    <xme:G7AKaC2T9Mrf0rmkEeMpeZ_ABvfQON3yi2yVXxYCmccGmRgez1BlVI0G03LoduMJ6
    v2zIGk9Epmm3Qs7tw>
X-ME-Received: <xmr:G7AKaFpwOdHjKErBiR1GGLuZnbAVe3D9JiN0WeqVWXLAvgv_vQaACjGccOsfhv-82GyXfciuhRzFF-1HEVTO34EgbDCVLfO-f8il>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:G7AKaHkeQZS6277dyOAb1kz9C884gVzzu0ishPK69My5WQezM2NsEw>
    <xmx:G7AKaN1z6uL2o4dgf4A2BVzSXJEXud1ZVnLl1Jn_BhicTb8_pp0Yug>
    <xmx:G7AKaGt_jjjgQbcQCO5ASbUC_95jImdESDLlytR0nC5d9zGwL15OPw>
    <xmx:G7AKaBX0Z84bwqBvluqspoRTS2x-KTas2gs_aV3d77KoOjMxkSBDCQ>
    <xmx:G7AKaFh8yAY6rzAq8MqpstVe_M1Ex8VV_clN3zPgrQu2xPu5Rg6kHcr0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 17:41:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] index-pack: allow revisiting REF_DELTA chains
In-Reply-To: <27d36402fe9c8262c459d606bf4aace1919aa2ae.1745430004.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 23 Apr 2025
	17:40:04 +0000")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<27d36402fe9c8262c459d606bf4aace1919aa2ae.1745430004.git.gitgitgadget@gmail.com>
Date: Thu, 24 Apr 2025 14:41:45 -0700
Message-ID: <xmqqjz79texy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> As detailed in the previous changes to t5309-pack-delta-cycles.sh, the
> logic within 'git index-pack' to analyze an incoming thin packfile with
> REF_DELTAs is suspect. The algorithm is overly cautious around delta
> cycles, and that leads in fact to failing even when there is no cycle.
>
> This change adjusts the algorithm to no longer fail in these cases. In
> fact, these cycle cases will no longer fail but more importantly the
> valid cases will no longer fail, either. The resulting packfile from the
> --fix-thin operation will not have cycles either since REF_DELTAs are
> forbidden from the on-disk format and OFS_DELTAs are impossible to write
> as a cycle.

Loosening cycle avoidance indeed is worrysome.  How do we guarantee
"since REF_DELTAs are forbidden from the on-disk format" (it is
obvious with OFS_DELTA only you cannot form a cycle)?  By code
inspection and in-code comment for the code path of "--fix-thin"?

I think the most interesting question would be how, with the
loosening of the cycle check in this patch, we would still protect
against a malicious on-the-wire packdata that has a cycle in it
already, where deltas cannot be resolved.
