Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5B1DF980
	for <git@vger.kernel.org>; Tue, 12 May 2026 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561472; cv=none; b=tXa4NcsyDKtAxUerEEJLM90QuNWfsa3GphU/WnvvvwvKVZA9LMWhvYPI3PUThv0KSFQ9yG4N5CD/rqK8sEAoUpZvHWUd+77zZlbArqpLrSjHTOs4poto230geva/Wwbx5XB7iah/hV66AQz9DmTZ4r9q8f00pEH5ixEow91wCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561472; c=relaxed/simple;
	bh=2EeW42qR6bcAFfabRdKakJduDwEzDXFsXzNyMJkaHik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4dI6nfwdHa6JA6L2Ya1TO4/JK6I8Da/u0BsRmZYzTTJgknABROLAmnsqEBPLoINs8SJeG12JyQP2RyaNTMnvbMRFz6ojBGHxSOJq4pUzCT8AWn86pnn4u6stGn53abIrn978DSFpneUajrYcZwNnBREW2WED2TBbIuva9Y3Brg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x0zvy8Uv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ntQubmwe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x0zvy8Uv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ntQubmwe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 81C741D000CD;
	Tue, 12 May 2026 00:51:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 00:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778561470; x=1778647870; bh=/ZD3Jbc+12
	h0JhD0PhOc8uyTZrv1pZX5t53fEpyJAwo=; b=x0zvy8Uv6j5GkVxnESqppv8n7s
	4UXRnqEcak+Ljy//ykLCVihADtLr9RKmxQEW+FLrgh3OhP8df3ZuV3NkoGeeS3sV
	V8AKCFiMQUWPPUeW6BaXRVC6xjlp+422IIiqhe6X9G1iIze+XX12QvYh2N/OUWaG
	YM3U4eG6w0FJ0Xu1Jfgxhe1y3JbXVDOYd070U+Hl9sMwA6/5QMJMYwq3Bdxok+zS
	1Jefk06CmCD63VqrF/PCFHOCUxv7ouT69YMdIHua9cD2+LJgfyPOweJX59SLHYhm
	gW9m9Lg6Iwx4rr3EtdHAYwYV69puAMEB7/lrtAH8RArDCtDBICJl2FuD6dyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778561470; x=1778647870; bh=/ZD3Jbc+12h0JhD0PhOc8uyTZrv1pZX5t53
	fEpyJAwo=; b=ntQubmweGhiS0Ek4nfrWaN6WV3A6YdASkdOFm/K7AXkBFop24sD
	/Ey907KjhQCDHPV9w3wWI1LDvbtH4RvfbQ8BHj+s1Q5/X/X6YMzZQGeS5BaFuoZy
	S89C96StF/S3O9KzBzR3pEWjlrsF3Ju2pEo/yJhx7YWhNpDdWGpoIJ5NKvqT8tFu
	8/VjkiQ/GAYp+XGpGbza3U8fQlYo9zTSXHtj8AO2FgOYAg7pzQv7QGgEnWIXhM5E
	3s+BTXux9wyRaL9TqCD5YRt6wIrvzIIUytE3+TOguiPz9wHVjvKnzwWr6gQ3EsUf
	n+CpcpM8an7DStZjDFf0t3uUv2TQYC8afmw==
X-ME-Sender: <xms:vrECaoh5O52U-TYlSVMKqZ2DfJBvASG1b9ex-GT8elVgMUCtKWaVhQ>
    <xme:vrECakswVFJcoeLdy2JoXZ11-NkOAYysfUQiRNM0G1nlfyev49a3jbMIhsrP760et
    X-C0qH6qMqW10z8n4VWHf4N0hQPY-2KZ24qrkKC7kpdhqHFqeDw>
X-ME-Received: <xmr:vrECap5MI4mqUJxoNyn_uRxU6a376ER4-YtmVPUjv9ieV-jK9c7Ovc1JuSx2MSn5XBxrtPd4F7t4qgxixHJbzztxQLSvzRXO7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:vrECagMDc6SlIixxx9U97wS9LN7i-qPbMk37BLKTEE1RxsdSgd_5ZA>
    <xmx:vrECanvJ5iBwWahbZHWm_36qvBlZkAGwBMH7h1-2__THCjXttth0OA>
    <xmx:vrECajZq3FGcOOzSdnAmAgaGX8NGGJTWzrP5NAgc3HZLBtZ4w3BGEg>
    <xmx:vrECapwzFq7aRLnlw629qWt69nIngWoScX-7fJkvtT4Dq1IaPjCxFA>
    <xmx:vrECahuGYQjpxGSH6_1XeSnKS-6BKZT5YyWxZHRONbwdaFPJ8rOul1L0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 00:51:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Tian Yuchen <cat@malon.dev>
Subject: Re: [PATCH v3 1/3] replay: allow callers to control what happens
 with empty commits
In-Reply-To: <20260427-b4-pks-history-fixup-v3-1-cb908f06264b@pks.im> (Patrick
	Steinhardt's message of "Mon, 27 Apr 2026 07:53:51 +0200")
References: <20260427-b4-pks-history-fixup-v3-0-cb908f06264b@pks.im>
	<20260427-b4-pks-history-fixup-v3-1-cb908f06264b@pks.im>
Date: Tue, 12 May 2026 13:51:08 +0900
Message-ID: <xmqq7bp9p6wz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	/* Handle commits that become empty */
>  	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
> -	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
> -		return replayed_base;
> +	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid)) {
> +		switch (empty) {
> +		case REPLAY_EMPTY_COMMIT_DROP:
> +			return replayed_base;
> +		case REPLAY_EMPTY_COMMIT_KEEP:
> +			break;
> +		case REPLAY_EMPTY_COMMIT_ABORT:
> +			result->clean = error(_("commit %s became empty after replay"),
> +					      oid_to_hex(&pickme->object.oid));

OK.  merge-ort.h clearly explains what negative values in .clean
member means, so this is a good way to signal a failure up the
call chain.

> +			return NULL;
> +		}
> +	}
