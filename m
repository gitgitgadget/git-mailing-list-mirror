Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255514AD0D
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458781; cv=none; b=mmqHa5FCqyLx+IJvm0NEXQW+012X45ac9XsbnglZrlLZGd+mu+1JrIGcNFeLXw6yAXmwz4aSb31/J3hhWInUcUQhCQvjAIVrfy3Lg88FmWKZzkoXw+bTvBYpoL/30ZqdDP55HKPbOyD/q3nbR+gLGVPvFfMAquUulGS93Fl8yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458781; c=relaxed/simple;
	bh=jPLXUHwmoAO7zRopJcr3UB0Kr0ycmCKb7EbBfi+9oFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pkg5zus8sYdRpyYVioR5m8hvpIoCga4cL1cjKvBNBlmoCGLi+uwSG7hA9pPJXmQD66nbbgupZSUCxmpDHU/7lab5Quce5ZRLFYWMYgXzMkTEn5wjoV7EnN9D6bJPMSk9rRtgvFqyfucmPFe8r2whcy5kg9cF/JRcA4s72FZeIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LE8nKJvQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LE8nKJvQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0634B13814C1;
	Thu,  5 Dec 2024 23:19:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Dec 2024 23:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733458778; x=1733545178; bh=G0RBQYH5Of/SQBABGjNA52n5e/IpdrpRC7w
	gSbY5fMs=; b=LE8nKJvQMk3DM8C9VhLEEXf/DlR+YqiC7JvClaD+pVLybpMqfRT
	ZNOW6Y6kh6soJnsopJSMK8YSRE+Hv2K4EwtUv8ZEiJb/KgH23gjU8YWAUMw7+V38
	krDy1F3ZRvFqD8x8OYNyageac4p+Jeq0t+U/u9y9A1XlQ9EPSqSIys1EMZ1mKmyh
	gawObXpsXcfa20DOp81DYLyGq1/IPKDdGKSK54EWlDoRUtZFJX70kPauTkgETPER
	WFQUp2Oep+sC9ACF8PCCIFVH45vCB4KI8chcTW6wmXq2NmQbZTSfBBieG3Nde3IF
	r5EJ3a9ZiUDOiOrQQSgKJNvP+LH/KNB35RQ==
X-ME-Sender: <xms:WXtSZzR73ZHBXHS05g22DdTzZsmXLvzG0EAF3M9-MN_VtoS5ScH2rg>
    <xme:WXtSZ0xJ5AvhuVRYTFAi1p_INRyYrJM-ikGrZXKtQgVfVdjHTeR3rPtG0ZsJevRTO
    LtX2WK_8TS39rwbGQ>
X-ME-Received: <xmr:WXtSZ43VfZt-Ivp67vJNjo36VfMrhC5oA-1z7AYK_wt7F64KzwbIwaK36t-YhnIi0VNMjnTcLVvqxlP8JWwCVR90Zx05RWc0_VSgZKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhnoh
    drmhgrrhhtihhnrdgvvhgvrhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhn
    ohessghmvghvvghrshdruggvpdhrtghpthhtoheprhgrvhhisehprhgvvhgrshdrughkpd
    hrtghpthhtohepjhhpohhimhgsohgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WXtSZzAHUKv3azvWoiZsyXEy225v_wirWollXZNmAMYdbZjiqaN5-A>
    <xmx:WXtSZ8jzC1ShPhTlHBQ2aV2EmY9jhoSyK42gFUei3gDR3ioHTZUmIw>
    <xmx:WXtSZ3oYYzNQlMhFswGDZZbsQkBUtCz8RzM1rl5O8XXJfY1Rzc3PRg>
    <xmx:WXtSZ3iZRLgPJNEv15FCsIYC4uAL5ITSCcnFT-PSWtTrUxz1Win1pw>
    <xmx:WXtSZ_NTNX6vJe0scRtKxupbo4ueu3Xg-NMU-tZuAfI7RQmfHJwmbDJm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 23:19:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  benno.martin.evers@gmail.com,  benno@bmevers.de,  ravi@prevas.dk,
  jpoimboe@kernel.org,  masahiroy@kernel.org
Subject: Re: [PATCH] describe: drop early return for max_candidates == 0
In-Reply-To: <20241206032807.GA3176362@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2024 22:28:07 -0500")
References: <20241106211717.GD956383@coredump.intra.peff.net>
	<00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
	<20241204232750.GA1460551@coredump.intra.peff.net>
	<20241205201449.GA2635755@coredump.intra.peff.net>
	<xmqqser1zf8q.fsf@gitster.g>
	<20241206032807.GA3176362@coredump.intra.peff.net>
Date: Fri, 06 Dec 2024 13:19:36 +0900
Message-ID: <xmqq1pylzbmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Without this patch, all three give the same result:
>> 
>>     $ git describe --exact-match --always HEAD
>>     fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
>>     $ git describe --exact-match --candidates=0 HEAD
>>     fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
>>     $ git describe --candidates=0 --always HEAD
>>     fatal: no tag exactly matches '59d18088fe8ace4bf18ade27eeef3664fb6b0878'
>> 
>> With this patch, we instead get this:
>> 
>>     $ ./git describe --exact-match --always HEAD
>>     59d18088fe
>>     $ ./git describe --exact-match --candidates=0 HEAD
>>     fatal: No tags can describe '59d18088fe8ace4bf18ade27eeef3664fb6b0878'.
>>     Try --always, or create some tags.
>>     $ ./git describe --candidates=0 --always HEAD
>>     59d18088fe
> ...
> I think there are really two questions here:
>
>   1. Is the current behavior of "describe --exact-match --always" a bug?
>      I'll grant that probably nobody cares deeply, which is why the
>      interaction has not been noticed for all of these years. I think
>      the semantics this patch gives are the only ones that make sense,
>      but I also don't care that deeply. But...
>
>   2. What should we do about the new regression caused by limiting the
>      candidate list?

Ahh, OK, these --candidate=0 / --exact-match were for illustration
purposes only.  The real issue is that the user does not, with

  $ git describe --always HEAD

ask for exact matches only at all, but we internally pretend as if
they did, which is not nice.

My gut reaction is that it is wrong not to give the abbreviated
object name in this case, but the price to do so shouldn't be to
change the behaviour when --exact-match was requested the the user.

Loosening the interaction between the two options, when both were
given explicitly, may be an improvement, but I think that should be
treated as a separate topic, with its merit justified independently,
since the command has been behaving this way from fairly early
version, possibly the one that had both of the options for the first
time.

  $ rungit v2.20.0 describe --exact-match HEAD
  fatal: No names found, cannot describe anything.
  $ rungit v2.20.0 describe --exact-match --always HEAD
  fatal: no tag exactly matches '13a3dd7fe014658da465e9621ec3651f5473041e'
  $ rungit v2.20.0 describe --exact-match --candidate=0 HEAD
  fatal: No names found, cannot describe anything.

Thanks.
