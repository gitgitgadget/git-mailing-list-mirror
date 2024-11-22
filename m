Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360C230999
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240670; cv=none; b=Zbrwyn1sIEUorEmlUF0quKUgLrFM3d7Aznl/Xn1ABmTHBK8nWw8Vqod9WcDGTcHUE/jPzt2myazHzQ18VT3zFztZlMseqYvujbHkt023FhkhnhDp4kcrLoUZ931tZgb+BkyplAqm8dXpO2tppE4b5nWq+OjOFQADnKPMRfPHb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240670; c=relaxed/simple;
	bh=Tt2ZafJYLVIDOTrzEop59gN6rw3QQkPQMVox+XUbOO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QCtL3K5tbeIK6c9SETStrsgZqWN0y4Jgobb/kLxM1Cssi4dG6Z2TdiOb2pW1zA4ulRMdUvXksttDWLSHhBUS3q5dsL/SOgoBA4jgHEIpqbPDlD6L1RpAzrDDjexGeIQblreKIN/I/W9818kWw7vhHRLAVYkHyBZVQiLPtDC1ZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rERqNn/P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rERqNn/P"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 342561140105;
	Thu, 21 Nov 2024 20:57:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 21 Nov 2024 20:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732240667; x=1732327067; bh=m9/fk3wdW455Pgf1e/+tc2uw6sF20m7HSc6
	t40w09gM=; b=rERqNn/PAhQb81z55Ey1L4hbO2fSvUtlWQW8lux4ToRboC+OgeO
	7nMetVt3iPCGjCAX47Zl7ksvnruvzXMhUUED6UipxFOpZaQtCk4SrFd3N1wrkAyB
	ifNLlnS5wGoff1I1rQ+IsaOhBjNVS8JwJmR23uw0FH00VqC6D5bB0Wj7B+t7ofnX
	NKkyujN4nKbM5Kka6Yh+sks7Wjkq+Oh0N5yIQNgt8Ahs3zma3llfwoImr3kum6am
	a966Xh2NBKter29bOFpMI11jobBWZC/JsvPzq95mZoUTEXtQ+Dwd1HlkL9Wr6A8y
	5wuyonOcGwYce3+BSvfIW5rwdUyKY9gnO5Q==
X-ME-Sender: <xms:G-U_Z41V0bApaz7lea4WglwR2lXw8LX1fHwnbPRxecYMeXu91vm48A>
    <xme:G-U_ZzE38MeuvHij9AFBbDEtV_1a2LPojrBZF1pxGXgCOVtd95u_upL8mI-09fD7p
    bNpyalV_aSBteSCvw>
X-ME-Received: <xmr:G-U_Zw7eaUlqVUd6QstYQTcEeQTLVZkSL-Ux5DvGhcc8jIxFUgDijPtA7ZWk4zLN3MtU755fQ3r7So7kTl9s3gVX1UPx1BiZc9N0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G-U_Zx2MX31SDtALrifICBJzBbpeGqA01AFZEEfye4glvvaTxec4vQ>
    <xmx:G-U_Z7F6kMb4EXmuCBb68Bmt4VzfAfkZelaVMwYonDpo3sCBbu_oYg>
    <xmx:G-U_Z6_f0XOEdwpGPFPeDrmwcBraHRcBVnvnDqr3S5BhdiRcdip-BQ>
    <xmx:G-U_ZwkJRUmTToWsw5WY7J2WJjtePoo779XJG-Ii7isZYbfFTZ0JMg>
    <xmx:G-U_ZzDs7jLwH8RxkU6iW7Ssdd2L-0MCamvCjk5p7xhqaxnFpT790Mmx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 20:57:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] fetch-pack: expose `fetch_pack_config_cb()`
In-Reply-To: <20241121204119.1440773-5-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Nov 2024 14:41:18 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-5-jltobler@gmail.com>
Date: Fri, 22 Nov 2024 10:57:45 +0900
Message-ID: <xmqqa5dsc9nq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> With `fetch_pack_config_cb()`, fsck configuration gets populated to a
> `fetch_pack_options`. Expose `fetch_pack_config_cb()`, to facilitate
> formatted fsck message configuration generation. In a subsequent commit,
> this is used to wire message configuration to `unbundle()` during bundle
> fetches.

This is generally going in the right direction, but this particular
iteration is highly disappointing for two reasons.

 - The callback calls git_default_config() at end.  Other callers
   may not want it happen.  Think of the reason why a new caller may
   want to use this callback (see the next item).

 - fetch_pack_config_cb() was perfectly good name back when it was
   hidden inside fetch-pack.c, as a private internal implementation
   detail, EVEN THOUGH it did not give its callers everything that
   tries to configure the behaviour of fetch-pack.  It ONLY is about
   how fsck behaviour is affected.  It must be renamed so that any
   new caller can realize that it is configuring fsck checking
   machinery and not general fetch-pack features.

So, I would suggest making at least two changes.

 - rename it to a more sensible name that includes "fsck" somewhere
   (as it is about "fetch.fsck.*" configuration variables, "fetch"
   should also stay in the name).  Let's tentatively call it foo().

 - stop calling git_default_config() from foo().  Instead, return
   some special value foo() does not currently return, let's say -1
   to signal that the key was something foo() was not interested in,
   and write a thin replacement helper

    static int fetch_pack_config_cb(...)
    {
	int st = foo(...);
	if (st < 0)
	    return git_default_config(var, value, ctx, cb);
	return st;
    }

   and call that from fetch_pack_config().

No, "foo()" has neither "fetch" or "fsck" in it; I am not suggesting
to use that as the final name ;-).

Thanks.
