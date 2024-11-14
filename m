Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9701CCEE7
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 01:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546740; cv=none; b=oYnRlb534SiG0KT6qFqbVNoHn0496F3JuvHGHx/RMl52B5hAYwqz4J/adApNTG8MB8G8KCYbfKgIgImSpKIziWbX0Sd0MMuPEEARUOLXDYIpKQocYWUGTQIEcY7PiKsxdvnUyhMceh+ORWVeuF63ZDeI0JIHX73AbUKjrfwSd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546740; c=relaxed/simple;
	bh=3wzjZpGbLCIR+pMfmc1zg54yNlm7Dd0g2525mkJbG+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahAT5daGmMjlc3pqYISgeKVFn1tvkr/RG6huVPXW8I6SrNfZynGy0EZiqQGBBB+dFQVH6Kx6xCK7YTatPo6pCNfxXopG0f3t2By5ax8IUnn2k/40luYiaJCssAUssf2d7KMwWEhrksZtaj65uQDH7QbA+Isd7odCC6oSEnCKn8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ik7BaMUo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ik7BaMUo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2218E13801F7;
	Wed, 13 Nov 2024 20:12:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 20:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731546737; x=1731633137; bh=XkUvdRTq72RY/Xy4l3hWxFKZLcTWhue5N5q
	Nkm0NdJE=; b=Ik7BaMUonx75gJLMXn66u5wcZsFZcVhn3G72UFCVUJHS9YDn2ee
	qWqpz8EARLWH2cmFyfXriDzLIyjGbfqp6A8kwCJ/pfvNo80/JV6zXm7OiyNBpvN2
	uVlI8WRwJ0V+FCqCKMT6TsUlF5t4+879q0kl0lDZCge9xtsDB1Vgi05XKCfeafuf
	xADL/J93wzqMX/CcmYHCbikqqugyMlGlGeYTI2rvlyV+SkZI+q0+Hbr5giiUTmKY
	dV49sdEA1fhvLHLU0URuj0tVz7N/m+DGFg5w/u/GOBqRMWlQMFD9nJCihoCbNkoW
	EQChqH2MTD2s3d/093cfi56WCF6OR3xUHvQ==
X-ME-Sender: <xms:cE41ZyuvDEgEAM4hQUPoCMj3yI41GU6oIdED_5OjlX0kF_iveOsW1g>
    <xme:cE41Z3dTYSCC09xHKMimc9B6_f3qusdAo6uu3oMEp1sxnbGCelq2nf5EjxEM2yhX_
    18ZnJl61HXvj791yw>
X-ME-Received: <xmr:cE41Z9zLgVV8N5aDk1XqUMzQAVl6XOiCDhh5rBaj8VJBxtSBq8i1H44kgS-CYPE4KnjDq3-QkhdLp_EJDSzx6YNaGBEv1pKFrdER>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepnhgvfihrvghnsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cE41Z9PgHgHEQbKvuDLQxwvG7p1iLxpZUsqueeD0NTJjpKy4lmf9eA>
    <xmx:cU41Zy8Q67DnLpptrpz2eAGqj_BTTcnH1sBvu-Fa4LYVCBgke9Vzog>
    <xmx:cU41Z1W62rISoNG6PEJxmQspPxfLXFmsCupEPjnQLcAWEBC1Vru24A>
    <xmx:cU41Z7dFg5nKeJTBV4rm7ox9ruKHqSISK3l9PD8DURSfdA1IO4exIg>
    <xmx:cU41Z5npU50IFjZt2ZAYNu0VYquDFqm5goOFCGo7WBPQDo1sdqq0Ek2G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 20:12:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 1/2] t5332-multi-pack-reuse.sh: demonstrate duplicate
 packing failure
In-Reply-To: <7a69cf84ae5b92d99e5777d4600270712424c4d7.1731518931.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 13 Nov 2024 12:32:55 -0500")
References: <cover.1731518931.git.me@ttaylorr.com>
	<7a69cf84ae5b92d99e5777d4600270712424c4d7.1731518931.git.me@ttaylorr.com>
Date: Thu, 14 Nov 2024 10:12:15 +0900
Message-ID: <xmqq8qtm8vps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> +test_expect_failure 'duplicate objects with verbatim reuse' '
> +	git init duplicate-objects-verbatim &&
> +	(
> +		cd duplicate-objects-verbatim &&
> +
> +		git config pack.allowPackReuse multi &&
> +
> +		test_commit_bulk 64 &&
> +
> +		# take the first object from the main pack...
> +		git show-index <$(ls $packdir/pack-*.idx) >obj.raw &&
> +		sort -nk1 <obj.raw | head -n1 | cut -d" " -f2 >in &&
> +
> +		# ...and create a separate pack containing just that object
> +		p="$(git pack-objects $packdir/pack <in)" &&
> +		git show-index <$packdir/pack-$p.idx &&

Is this done so that "git show-index" fails when the .idx file fed
is malformed?  Or is it a leftover debugging aid, where a human
developer was helped by eyeballing the contents of the .idx file in
human readable form?  If the latter, do we perhaps want to "parse"
the output the same way in this test to validate our expectation?

> +		git multi-pack-index write --bitmap --preferred-pack=pack-$p.idx &&
> +
> +		test_pack_objects_reused_all 192 2
> +	)
> +'
> +
>  test_done
