Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59F15E5CA
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732751592; cv=none; b=p3Rd9OQIbb/v/35esi1R42LQxOHJLVXMaVcqZNZMBWzcj6ROCqkG7OLY+wDq16yZ+2NCZd7L6qYi3UFggdpidHldkLoZn1Q+/R2NGG1CbvaRO+VFXhA3PDOQIgMTaTmLPwPUfNKgY1L1/0Qac0UnWYXxw53+6oRzx6wBIW5j9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732751592; c=relaxed/simple;
	bh=xVdLcJMk1MKmBeQiZE1ok3wSUEgaQg/lhknxQs0AZjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZeG43y/4Oq/IDlFNVr8VXFqkQ6A9Vka3qYHidZPtOmZo60bez0izcfYntRWuyUb4GR8Gv7COBcJzrJYKYljs1nZNzVdGJyX5P6Vlpr9NMFvUfP6bEUOmcJa42I+A9ois3cYYyn0ty+j+dpROy7FeoUkl/pukB2Ie8KxmYJwAN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3m1oFKTR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3m1oFKTR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AEDD138013C;
	Wed, 27 Nov 2024 18:53:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 27 Nov 2024 18:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732751588; x=1732837988; bh=kqukOkJv6oVrLCesaW6d08jl6fTMa950xkr
	aiciObXM=; b=3m1oFKTRHVP0qHXn5TX74Z45PhCFGfPHvO8KQUb7+4Xq8FPNeGq
	Q74pXOafEBTU9DsD4WzLfNJuBPRP6+94DhollndLe15OOdwvEnzYmnnDSUtYv3Sv
	KgDaHPB9149X+ScdkuiNB00DDSN9BrD0MnjRGDQ18ZIXH5OYmC4PQGYLXc7o66KP
	UcUM2nMma0S+S8be3yntzgw5UlRleq/GtJVPCcNhfvT8QlENfdBllu8GaiDmDXzZ
	Kohz6zNx2i6EddABbHF3LYULkZqjUCXCZOJzQCleX2IzbS8EErNZnrliuGjDJe89
	cnRk+ozzuKyA/QUgQmdCVn7GjSJGsEj02xw==
X-ME-Sender: <xms:5LBHZ9u7yFyFwad38cxswF853strsHuq94v0QqW0yp0NYv5rlbUqtg>
    <xme:5LBHZ2faGDqUKxgqGSHyq2cRGh5oT1aQTsXpPaDz31vA70okhqos5x8fqBAITJEPl
    A4sq4hRKH0g6geP2A>
X-ME-Received: <xmr:5LBHZwzgIbFJmFLHxDqAqm9b6dBNAzTQqAgg7SSLGHRUTDXKnS4nWheo7wrjW0Qcf75TQSew3nTBP_usHrvE2HSEzOZ_YmLBjxxC7zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:5LBHZ0OZqhKfqVG935qijTixVHEewngzgQ3LB2l2OhDe1Dd8GTW8KA>
    <xmx:5LBHZ983XdgDRwD6xEW-fw7ZzZkNbtkSC4veT-wlRkljY0COavflsA>
    <xmx:5LBHZ0XAXUSs0W2D0QJCVxEpvqgULmJA0G4bbZi_FHvnS97nHBip2w>
    <xmx:5LBHZ-ds4t5gHZ9oLBJ5XvUjkTri06ee-cIwjBSPAXE3ACWkeJNBaA>
    <xmx:5LBHZ4YJIpVkl_pv12SKM7pR8wBUPhaGPkJ7h0IzHrUFXk9sq8ZAvB-m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 18:53:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: Extending whitespace checks
In-Reply-To: <20241127150429.GD2554@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Nov 2024 10:04:29 -0500")
References: <xmqqbjy5bc6m.fsf@gitster.g>
	<20241127150429.GD2554@coredump.intra.peff.net>
Date: Thu, 28 Nov 2024 08:53:06 +0900
Message-ID: <xmqq7c8os07x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But it seems like a very deep rabbit hole to start adding in
> shared-library line validators, because I think it ends in "now
> compile this before I agree to apply the patch".

I am not sure I understand your conclusion.  Who is telling that to
whom?  Somebody sends a patch that creates a file that requires a
special validator and the maintainer gives the validator and tells
the contributor to go use it to make sure their addition passses
before resubmitting?

I was hoping that the ability to add extra validators is more of an
enabler (than requirement and hindrance) for those who choose to be
extra careful.  It is similar to CFLAGS in our Makefile that allows
you to use options to enable more strict compiler warnings than what
other developers usually use, to notice certain class of problems
others may miss.

Shared-libraries and plug-ins remain to be solution in search of
problem at least for this project.  I do not really need CSV comma
counter, but I thought it may give a good excuse for those who want
to play with Rust and other stuff ;-)
