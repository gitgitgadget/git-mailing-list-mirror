Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C22D5C86
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319562; cv=none; b=GiwOlY6bi2dk694O1ZvPJw3wI13+zEGcB7pvqnlhPlVmEBv1qsH5UgG9mrgzNjcV9EXXHTFoWV8kwOh6MhKrSbpMzWLypMa8yR6HD7BeQCxJ4efa24G/NclpnTWQ96m8RwziKu+yuQd01GKcucSQbpYG3RXZIN/8HNtwYXXy/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319562; c=relaxed/simple;
	bh=Cdeqr5FPIzj0C+jQxLmYcyHa9hbE+OUgq0MTvSHIPPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTJW4u7NJJr2N8GFzR6KQzrBMjnDOCGCBxPon6OyZYmOejKUXHBWaIrTnS2NVoYrynPbQvaUWLgFGhEbkBee/vk1Ez6BzSFGt5pCypMcNO+rWCvh3bhkku3cDut3d1xLFo820xjP7THzxOzppa7mrDUpnTBdvVAo6t7xOp3l7F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cib/0Sk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qex0bnBr; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cib/0Sk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qex0bnBr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E24891D0004E;
	Tue, 13 Jan 2026 10:52:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 10:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768319557; x=1768405957; bh=jYXd1GRrtZ
	HHygmqGPCXCFbjcnPsKMiuganU6Khewcs=; b=Cib/0Sk84u69E0KdIW+WWW+lPZ
	RiBz8lPXfZMUNVPUb5n6u6pg4Bxx0AL6Sd/bxzdhVdtkHQE+/KzLw9TTIugDCSQX
	zBOWtQ+/reeRYO8Z+G8E+D/UQD03QSWrvVyH6s3ecLgejwBT810wRdwiUlvwn3OF
	hQIunIwPnHR1/QqjY0sshfYzuNbhTnyZLhWXYtKkwAPuoO9L1rfzH6oZUbHuvojq
	zqSYOpcokYO0Hlz99hbzzLyodaEOdCdIgryuW/ekeyUprwHYek66jdcabdhfmWoV
	qrqyMVDBUrSpeB1y2n18IX0oYVEpYc5RMQOi2sV3A/37oYRsVrx3PyZv7E3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768319557; x=1768405957; bh=jYXd1GRrtZHHygmqGPCXCFbjcnPsKMiugan
	U6Khewcs=; b=qex0bnBrvBS2g7ko2nLj8ISvV83G2e7np5BTriNa4AY8k8WCa2y
	qNEXAF8ZdQvhQhAKU1mXDem0f6AQrRh6feXLDNNzXPi+5HriqvNiEioxbJuHleMl
	jzfRNUFaxosJlXNFpOuq6DrGPqL93h2L3lQWywrarBgKBHzKmPm8ui0E3Qk7RLZe
	+QOxcyk9MgmZavPjb9tefMr/XhLq+l4Kj0/4vuZWIWBmCTbtpovvH2/+/UUSRE3H
	rryLnC0qHgNFGC7LN2L8d4lt7y7u+EGjJ1qALU4TNxZHJUJmAzXh5CCCx7VN5tan
	zKRHp/i7c4PhvPbXAPWxSvOG3R/MxqTI3Jg==
X-ME-Sender: <xms:RWpmabZ-g64CIP3uAx8DrSPnRSoOfJgfx4eGofwLxMdfBvrgNHIzYg>
    <xme:RWpmaR1vbse8faeMROPE3qGWapX2zePbAufEuVAnDyV-6AHgu_Z97PN54Qihl0b0b
    PYe7gXX-rw2BTeykSaFMEv4f29S31a-5Eq7vy8xlLcsgpMMijvdxQ>
X-ME-Received: <xmr:RWpmabVlE-sRdIkge952bVlRJisAdrRYtIY18maC38QZbQ7yU0Ioa7HsCnzDJSmfRn2RGuOjJq4kZ2N-7ifn7NSzC5TqUGZivND87uI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgvghhosehighgrlhhirgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:RWpmabVvSSZP5ljEM2uKhU1Yu125wwXGzC0IzlK8h9qethfkRkXjgQ>
    <xmx:RWpmaaep3qL7b92Z7yTU68XGJ9iYO3fKcAdSkWuGWQ-WBNywIiGr8A>
    <xmx:RWpmaUXHv6e9F8eHEowYTrC-uxowfNgKqdw09H8c5UXKCcNH3G9juQ>
    <xmx:RWpmaTfgHrEJ2hGm1ynFFzlAXPrUjiOy2VVy_tYSCZBxFviy58Q3jg>
    <xmx:RWpmaeeEXgziqqcNg7-KocaFuYgCk6-iZBYpPYzI0yYELiWPjDisKN4v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 10:52:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Manuel Rego Casasnovas <rego@igalia.com>
Cc: git@vger.kernel.org
Subject: Re: git shortlog --committer vs --committer=<pattern>
In-Reply-To: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com> (Manuel Rego
	Casasnovas's message of "Tue, 13 Jan 2026 16:22:31 +0100")
References: <e2733434-f632-4be5-a9e0-28412b4043c4@igalia.com>
Date: Tue, 13 Jan 2026 07:52:35 -0800
Message-ID: <xmqqms2hjyrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Manuel Rego Casasnovas <rego@igalia.com> writes:

> Doing something like this in a Git repository returns an error (git 
> version 2.51.0):
> $ git shortlog --committer=foo
> error: option `committer' takes no value

Thanks for noticing and reporting.

> It would be nice to either allow using "--committer=<pattern>" for 
> shortlog

I took a brief look at the command line parser's source.  It
shouldn't be impossible to improve the status quo, but it would be
impossible to match what other commands in the "git regv-lits"
family of commands like "git log" would do, because "--committer"
can take its <pattern> as a separate parameter.

So it is clear that "git log --committer" (no other parameters) is a
syntax error, "git log --committer -n" (no other parameters) is not
an error but is looking for a committer that match the pattern -n,
but the same reasoning cannot apply for "git shortlog".  Most
notably, "git shortlog --committer -n" cannot behave the same way as
"git shortlog --committer=-n".




