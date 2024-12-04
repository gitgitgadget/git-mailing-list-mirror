Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373713D51E
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288539; cv=none; b=P87L66wKjHA3KN0zGuRXlOW1ljeiMKzRbjAR0C8OHRvM9nS/gRnOIRPaCJP2WC0LcpgMzZDAgp0n9PjVXff+s8SGIx71KDUciWOWK3kJQYARFpvTPqjPtBAD9YR9Go1UTeaPlJaHKCJdc2zgpwcZ8BDqDVWZTCxWN5FlROeMQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288539; c=relaxed/simple;
	bh=u/xA/lXoXM4aX9odX6weUUgrU596NpbfPYKpw3ewqV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ayUhzJ6wc+btF+hygJxWVH/b1Y6qygSjmske5sqtQqmcfkW2ELkgFfOIEUVsUfGbjBCow0DPKSB9pX9msS2Dt34qP2uCxUHv0g9DSpn9lNg/ug+kGRCdddB5ia8c0OTHQY8ZlDeSDLK7Rcb5XnlEMdBC2vF6lOioOC2ZFow6BNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BCIy7B1/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BCIy7B1/"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 337FE13802D7;
	Wed,  4 Dec 2024 00:02:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 04 Dec 2024 00:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733288536; x=1733374936; bh=55rQN0hTOIIgoa6tqCbs9ZVoRcgS5tYcKa6
	bbpbXHUs=; b=BCIy7B1/gVILN0mqSUxH8SBddXrk96ewzqxSF59SPKosumBhE7k
	UcetAil8g4p8y7DVu482ZndlwQtexXYLpCTqZ6q+pb+K+BNPJi8AA+5sqTXSFiIT
	Ol6AJtsIyfL5Z97NgpEvJ6j9/eCqThiXKHIRfbeUp6tiVK1zk2OzNsiqDmmOJKGZ
	nnMyhCRvXwTjicdk0gW70F1BTPL1GvvUtte4EmbQJssHn86l2yyPqHLmJN+VzFrE
	J3zhF1JB/sAmA0dcWAMTopMwQmnnSWnKz7Bkwb/Hm0EUD7zLfyMMw11y2zvFwLWc
	F4+wp/eFFrla+ZAW7WUNFYUk2IUDE/TsSHg==
X-ME-Sender: <xms:V-JPZ0SgQAqtzbvRyzXI4zrY_8FxahI85LJ9wo6fp4gcFR50-3uhJw>
    <xme:V-JPZxxxJ2zDyVfNSVKjgu3cfJBrn-TWi9Unna1UJrEL6h-nI00U0TwYYZRfcfhPa
    7FoM0fr0GDpnPJqFg>
X-ME-Received: <xmr:V-JPZx2pmgHjlYnmV5NbFQ2JkiWr-VtqgAOm1TZGOvJaH5stjN2brll3_hL48WCqIL30jyjMH_0IBovvCwrMFGB4vWyUTs0z1huS70w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhohhhntggrihek
    ieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WOJPZ4B7afT1XIys1khtwlYrbklQ5lEYkQXuutlZoCW8AIXYariG1A>
    <xmx:WOJPZ9hZIuyk1d8HETrgRSqu5jr8Lwy769AIScN_GpHh_D0IrWPhnA>
    <xmx:WOJPZ0rtXgsqtZLwFIlQ0CHNJU9VUmzmNTYzsQZELAqopkei1Rck1A>
    <xmx:WOJPZwgWcX_loJsqnSgcE0QSNhJsotTbZEd99XMpspNLTtdDe5X9eA>
    <xmx:WOJPZ4rmEiXM6Wz03UN_WNZMfv1RUBvQ4rJ3xDje70frVMuPymL3va5u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Dec 2024 00:02:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  jonathantanmy@google.com
Subject: Re: [PATCH v2 0/8] pack-objects: Create an alternative name hash
 algorithm (recreated)
In-Reply-To: <b07c6b94-b1cc-4391-83fd-adc5bb5f92e3@gmail.com> (Derrick
	Stolee's message of "Tue, 3 Dec 2024 23:56:33 -0500")
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
	<pull.1823.v2.git.1733181682.gitgitgadget@gmail.com>
	<xmqq1pypfo05.fsf@gitster.g>
	<b07c6b94-b1cc-4391-83fd-adc5bb5f92e3@gmail.com>
Date: Wed, 04 Dec 2024 14:02:14 +0900
Message-ID: <xmqqldww3usp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> These do not sound like versions but more like variants to me,
>> especially if one is expected to perform better than another in some
>> cases and worse in some other cases.  Is it expected that JTan's hash
>> to perform better than the original and current hash in almost all
>> cases (I would not be surprised at all if that were the case)?
>
> There are some cases, such as the Linux kernel repo, that have slightly
> worse compression using JTan's hash. But the naming conventions in that
> repo are such that the v1 name hash was already pretty effective for
> that repo. The Git repository has similar issues. See Patch 5 for
> detailed analysis of these scenarios using the p5313-pack-objects.sh
> test script.

So it indeed is more "variant" than "version" where v(N+1) is almost
always an implementation of a better idea than vN.

> It may be possible to adapt some of the collision rate analysis from
> the test helper in Patch 6 to create a tool that recommends or
> dynamically selects the hash function that works best for the repo.
> Such a feature should be delayed until this code is exercised in more
> places.

Surely.  But that is more advanced feature that can wait.  It
certainly has to wait until we have a foundation to use more than
one variant safely, which this series lays a good foundation for.

Thanks.

