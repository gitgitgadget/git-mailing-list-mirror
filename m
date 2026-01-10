Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922D1FE47B
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011664; cv=none; b=KQHrcLPh8BZf/mFaoz9/GERqCJy7JWk2q23mGslOSXOnUhsNsVryrcB2loWxdqxickvFD3+qIHI0BsKzyt3uH03qQZh9fyp2J/a9ZAx3k4MXV6YOIL1sgn+pfmNVuH5U+CzWBNPuEaR9D8Wp+fEXhyGy8dJhL+aRzQobPaG9jFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011664; c=relaxed/simple;
	bh=EhTOjUQRT0eYg4TuPBGx2LuDoW1ddQC6ijtNyU6iJlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sF03ydgjFIggkt2NPq9RwR9PP/Y7OPAkAhamSvZ1xRxS+AYzHsuOJE5Xnpb3syB66YS7n63oIpuTnRpzCm2X3I/IlDC5pjm0EOCme2piENrHdo/TqSXJ+JjwgCWu9wcBleBfen6b9oGxP5usRIpbt6+iagijBQNeYLCFjCOw7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eNz9Tfiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zMhI02q+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eNz9Tfiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zMhI02q+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D931D7A0098;
	Fri,  9 Jan 2026 21:21:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 21:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768011662; x=1768098062; bh=oSSbCLoPYu
	hJLpkTbp6K8Qp81vG1GKuySH8O0RAz01U=; b=eNz9TfivMryBgIarDhYHK81/uD
	F5QtcBp37/S8IVfzR/FmML81hY3zksWIINJTxaOg2/dUaJ7lTCfOaLWn55Dn5NQt
	lx3HnTh7Y4/+xxH3ns/1qaRJ4RuUhrgapiKKrI+uD3X4zxotqVLwyfAmKtfgdA1Z
	jY/sK3/qFJ1+w7Ah0wWyTgPpoe8ge885FANwUTtisMU3cZzNgepaNbOzFhp/9QZm
	2Vl/yY9g7t7WmIzeFWkLNx6OHcrVLUaECq7wyu6t2+sbY/u0fxpqCzPjyKx+r49K
	RuoYwyPOINCaqbVLtTuCVJo7M/sNzO1LMiaVHH5P2dM6JAl/rb2CYPaN2aSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768011662; x=1768098062; bh=oSSbCLoPYuhJLpkTbp6K8Qp81vG1GKuySH8
	O0RAz01U=; b=zMhI02q+dA2wpQXk5NmrpsGkdj3azP5clzNeEeIcbK/QNx2A52I
	JcUwWuzG0mjEfnm5cuRHc5X/wnNl8Fq7jadZgquLMF3wTPxEcxRYgMD7qkS0yVcu
	7Kr1K08x414NHETzpr/3NrBJP1MB5xWh73L0kyS8rCpDOdSdzh6n3PsNC2bpWpAe
	V4pTCfW6G9NauDXyugtQNn6jUGflAI8MJn+pi7GM+6kxy++IA+xP50lI/mmPUw2m
	+jqt5JE1PEIb5R9KuEAZphiF5z31m4n83AJjvajQqJjF/oyoNiEJ9iK3K0hQJLmR
	NvJ2QY5mgrx99jhEUVeNqup/pBybs3Ahw9w==
X-ME-Sender: <xms:jrdhaQxTBIn68tG1GXE5KKtZzndtt99VoWrHTMJSRylMX-mGeMQnkA>
    <xme:jrdhabTkspN7X85okBa51C2q6R4GRUfAcrac7DR27jqDAVYoOP4J1qyrxW5eRHzxe
    YMXLpW6FM0nDQd_Udv-M9rFWpJWFnFeFfYoXdWQIRL1J7mNT_S_-g>
X-ME-Received: <xmr:jrdhaXUmf_jDqnQn5hH71fPIV601LpW13E97enlCxbScoQXL2XDugrIOQlz085wKyuOr6Lq4306FALG5N_sMw3en4g2esqQ9Yn8Jpl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jrdhadaLrM0mTLejiYJiIFLjw_6ayU1SFN3dRr7DehsXOc0tAy75cg>
    <xmx:jrdhad0Do8JwUIFAZUznQYyjPgpC4KAcgvQK92FbONzfcdywWDL5ug>
    <xmx:jrdhafiAM9mOWlGmlXTmuWIJVwpmUPc4l0Nsyg-jQrJh0l6tnW6vOw>
    <xmx:jrdhaRbNVz3xPtX_aQ8qhgqPG1NR-FA2vjlsKTgJs6uQGdbiY1jMaQ>
    <xmx:jrdhae0QkkE1iNV2wFC8EfbBMq4DJRcIebygDEyYjTN5E4ei5L604CeI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 21:21:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v19 2/2] status: show comparison with push remote
 tracking branch
In-Reply-To: <dc8ab23158e5b43cf650f71ef5c2b3a094f54129.1767984037.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 09 Jan 2026
	18:40:37 +0000")
References: <pull.2138.v18.git.git.1767976906.gitgitgadget@gmail.com>
	<pull.2138.v19.git.git.1767984037.gitgitgadget@gmail.com>
	<dc8ab23158e5b43cf650f71ef5c2b3a094f54129.1767984037.git.gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 18:21:01 -0800
Message-ID: <xmqq7btqtdgy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -2303,6 +2369,11 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  	const char *full_base;
>  	char *base;
>  	int upstream_is_gone = 0;
> +	unsigned base_branch_modes = BRANCH_MODE_PULL | BRANCH_MODE_PUSH;
> +	int push_ours, push_theirs, push_sti;
> +	char *full_push = NULL;
> +	char *push = NULL;
> +	unsigned push_branch_modes = 0;
>  
>  	sti = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
>  	if (sti < 0) {
> @@ -2314,6 +2385,16 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>  	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
>  					    full_base, 0);
>  
> +	push = get_remote_push_branch(branch, &full_push);
> +	if (push && strcmp(base, push)) {
> +		push_sti = stat_branch_pair(branch->refname, full_push,
> +					   &push_ours, &push_theirs, abf);

Why is this variable called "push_sti"?  Calling the return value of
stat_tracking_info() "sti" was klumsy but understandable.  It would
have been much easier to follow the code if the variable were named
after what it _means_ in this particular caller's code flow, like
"cmp_fetch" (comparison on the fetching side, by convention negative
signals an error, and zero signals 'the same').  Perhaps rename "sti"
and "push_sti" at the same time to make them more symmetric?

Other than this minor nit, this step looks nicely done (and the
previous one is also good).

Thanks.
