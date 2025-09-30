Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76B12D0634
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275571; cv=none; b=Ttu4bWwm3p7EJWcy5bdc8FwuIty1zGK05RCqkZH5kdU8FGvfgT+5pEsz0i5JBE7DybRLlA3eug9Wk5TwuZpa+SoxsykRLylwPdVfULXvT4bD/2STtypAKfpzXLD1SLCCaJwcZuorj258Qg1Ya3ICxDwx2ry3PSdgLVFgS+60O5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275571; c=relaxed/simple;
	bh=Tn0h3nfMa+hG5Dq/cFwOtqncya2ZLOI+PdfWF4928ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Is7Z5Ml7JWr6IDcM1TU04b8YBgKguqsKJANRf5cacPUWqzD8+jluumVlez6Qc9F+1AznnaK2CNwF6qAikSeIHf17trkC5lChOaidQ2s0oXrG7TCX/FGEsipRDCf55M8Qg4bsg12aJtKTXvH76J3Mdhwsf2w3DN2cVl8RooJswr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IqbbCqV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EA1uX0R0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IqbbCqV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EA1uX0R0"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A513214000D3;
	Tue, 30 Sep 2025 19:39:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 19:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759275567; x=1759361967; bh=EGisIcpLVN
	xhtkz2Jh6iPftr2SBmZSi9uolQiIM0qKU=; b=IqbbCqV3HfV7HdWleF8uNCC8ai
	Ifvw0yykWmVbDrbI6nW6NyWtFafOL7BJZSMLXFGNLJ3woYEb59wC76rSa2h4e7S+
	gcisM0U83ZlDE9dN8uOItrMn6LMUrdOA2X4ypHnDqDXDp8jnjYiE6ZI7XV2MhGJ/
	jECXpiYdG2YJkQUB833dQvqXkAZw+XvtCZDltyzaVQUt9/FRAW1Ypgr4QINjAsE0
	wdCUR6TuqC+KS4CUjq7/1QAm49awEXGKltdbA6ZJJXmB7koDMzR7SF0Xzb7Lr7X1
	oMBIouv5O0zqddko46MahIiW5yCgqWWbRyg5lHMgd5/NxP72hSV6/8EV72hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759275567; x=1759361967; bh=EGisIcpLVNxhtkz2Jh6iPftr2SBmZSi9uol
	QiIM0qKU=; b=EA1uX0R0qBf71I3cNPrlWjlFq7Pt5VRhKEt8CEbP0Zofd99Bje9
	HXfVQzwYkbH0uEyfUjXcP5cultw/6sL9TUgzMQZl4skEJ/h6LiMFSmDMOPXzmP60
	4dBjbVu4aY3zlzKh3MUYs+A0O3wmAeXqKpqyQXZuRyt2fueIpBGtaXKe8VUQgLib
	evYigVjOvC7uU7q4Sl6Kij234hrwHvuZDi45Uze3kA0xhR4vxyYZKSV1zzp4xFO3
	JIGMgRYZvwCTfPGJdjDCkMwNEWyvDoGNHetZ5O6xei9bHsPQIenAYCZMxW9m3wE2
	ADGUfRh58zA2nkFpIS4Tpk7yKQON+/Hr71w==
X-ME-Sender: <xms:L2rcaC7HYtGChF-k87cI_v3uXD-3BFkKJlcDlSUlTaQte97HgJ06gg>
    <xme:L2rcaPlj21-XbkFcT09hQtVctTyJbrZDL_iSvzq5W1VqRXTqizIKWFrihvVTsK6bL
    tbQjHlZWK00K05C5E6ZkzsM0K3XhI1VZzS3RdAvXOzguyGZ9PelXQ>
X-ME-Received: <xmr:L2rcaLShikx_k0nZn-0bMCJEUQVbprSajtjF-a1ns4ggwOSOC6TSWcHHgpOPsaZbvdSafGt57aapzW2OuTArqNqihqCEVPoiMgbh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:L2rcaGEBLDJMM4j5hvZzi5tSIqm8ny0czaR1x6VIu_894uc4TzUM5A>
    <xmx:L2rcaIGL26-GX7AKVok4jopdYaN_5bNrqp9Vq_2_H8eDFmewuqviTw>
    <xmx:L2rcaMRq7CedpXZ9PxduUp2pmj_BOEYPcoMAEJsRxtgbOCMqo6kYog>
    <xmx:L2rcaBIETtpWll9yT8zk29k2wgEF0BWQROHRTs_b79QNFChdOTpq4w>
    <xmx:L2rcaOc6FVitUDR89wurKgD1ST_NRPgY9YJLzKjs_ivYsSOYoko6mZeQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 19:39:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v4 2/5] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Tue, 30 Sep 2025 19:58:31
	+0000")
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
	<69825d46349e55dd1b17444ab4e6d542fd44f371.1759262314.git.gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 16:39:25 -0700
Message-ID: <xmqqtt0j33yq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +You can set an upstream branch explicitly with
> +`git push --set-upstream <remote> <branch>` or `git branch --track`,

I am wondering if this confuses beginners, appearing as if the
latter does not need any other command line arguments, as the former
does say two pieces of information needs to be given.

> +but Git will often automatically set the upstream for you, for example:
> +
> +* When you clone a repository, Git will automatically set the upstream
> +  for the default branch.
> +* If you have the `push.autoSetupRemote` configuration option set,
> +  `git push` will automatically set the upstream the first time you push
> +  a branch.
> +* Checking out a remote-tracking branch with `git checkout <branch>`
> +  will automatically create a local branch with that name and set
> +  the upstream to the remote branch.
> +
> +[NOTE]
> +Upstream branches are sometimes referred to as "tracking information",
> +as in "set the branch's tracking information".

Everything else looked great.  Thanks for working on this.
