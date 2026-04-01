Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA608258CCC
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076632; cv=none; b=tI+IqOunGXwXZnnYEg9P+QoR8IBtSt1Pf0Eezv2CT18Ih5R6lIskA+/HS04ECcnoD5u9wSiqhhTkdiU6RURvd4O01TQXhr4Z5IEZliCOWpIcv6/+O6C68aUQqRi8zhfdyN+QAKVg4ZbzHSJO9IEpUlSdSBp521K6qeOAY0BoQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076632; c=relaxed/simple;
	bh=bwhyai+zyj4mTrxEuBDgkWZzrujJhM75UOiJi1u08EU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMqh/odOKE9qbKlv5AYt9CQeS42rvKjl9xIZH7hEK6LGg9InfkGhnRZXOlIN0ojg+9UYvlQpOiA8JBQ79BtHSCj21ln9/L+nqG1ku0BJskr97P0uF7X0YzBlZ5czBxOhn9LXCJqZ4jbTOrPZUm4pRSloQpQdbK3pv3/YU/ZnQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ERbtjLHn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vGjrywAD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ERbtjLHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vGjrywAD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2CBB7A0289;
	Wed,  1 Apr 2026 16:50:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 16:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775076629; x=1775163029; bh=yNmWlfAdUb
	0+JRVzjQa/vibv77Mlx7KxF9nbKw1YzTs=; b=ERbtjLHnQnxmvFZEQFPgLYjDIP
	vmpx3fANzdwenHmcCwyiKBsVRx43dhGk3zowQ4h3tRy6qX4/zGlD9jMQMef7xowP
	yhF0ENi8tQ2tHa/0YFI3cXdG4/vrDRRHLEyP2+lHW0YAr1ZAwXUkswRCO3Kw2zqA
	V9D42d837rdyPZbOpqyDFVL6LcvppRN+AghyEDGhU7uGZdzPpK3ENlkgj5MWKwzj
	n50byqLFSXrorTk1Mrr0hKutlVyYnZqgiOaoFl3XKUX3PbSyynlZZg7dvfKMNHNl
	KHDj8hSWAT7Dmj75AIL3GyUoE/+VLcEzJFSJQXVMW4oBzcJzkn6AsPPmZ2JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775076629; x=1775163029; bh=yNmWlfAdUb0+JRVzjQa/vibv77Mlx7KxF9n
	bKw1YzTs=; b=vGjrywADlNFiCETbIeaRu2HQWOk8bKcG4lBb+EvKPfoQUDl7mGi
	V4I/zUDgmf3q6qRKEwzeOaVxGC0ZNS44d3zj8pfuTWAa01V8KLbNoqIRpL0yPsPV
	V4STQvliBH+qgu3LTxm59bKUFFGdiW2SWtm8Qf+5fq42Y/k1AJmgvoLNpkePAVht
	ZN/JJEdn7vzhCOiFIH3s9JZ3SFU6uzXoKET0GkUhoJeSm7dnurv4ihlSZV0bD0IR
	AAAWFWmfXhOb+Qh+V8zBhVRunhPAASXSblYtpDKG6frCY9RTT9zO263ewJ8C3qng
	YUpANmahYMCiw3zzJIw6aBHWyULmQXWk1rw==
X-ME-Sender: <xms:FYXNaWDBM28d6eAvH4-SBdXh9EDB-RE0jgX4v2_GAf4Snx45HaT2sQ>
    <xme:FYXNaXZ8cnhT2MAVcoh5MznUZx-PZQED6bmkTriZd9IMPAz2sZjBLWmXgrTproroH
    86ceP8Wd6ThnCZeZeRe6KN7YK9Jy9u-dhNOlgR6wcRZNVw_FGWZww>
X-ME-Received: <xmr:FYXNaR6Va9hIVcW66vZbP2m4qCunDBK_3YRyT6WhcvPud8olhYDH6Cw2vsWlG1rBKRksnhifr32dG7JNjmag7he8uajavsxrig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgholhhlihhnrdhfuhhn
    khdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FYXNaQacEM8IZeH1o71FLm6yTXX9eFM2QTvj2T1K7FY9G77DMnPMfg>
    <xmx:FYXNaYiP3VTDai6EFvBQJUJFU8hqe5IGBKQsaE7JynHHeDKN3lpi0A>
    <xmx:FYXNaZ-mpnYdy-lfRGMxoSBBRDVGuErjpSg2rN0HU-gS2Tb8IPFdlA>
    <xmx:FYXNaboTdREn7zPnRvj_THLv2qd5zgPhEIGZ7cispIHM17x3J1sAXQ>
    <xmx:FYXNaWx3gsC0f6JB3AKEIJXpt-kzbI1REmiXa2BbPIRWogH0_Pp1RdmW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 16:50:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Collin Funk <collin.funk1@gmail.com>,  Michael J
 Gruber <git@grubix.eu>
Subject: Re: [PATCH 04/12] pager: explicitly cast away strchr() constness
In-Reply-To: <20260331234220.GD2328529@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 31 Mar 2026 19:42:20 -0400")
References: <20260331233856.GA2327197@coredump.intra.peff.net>
	<20260331234220.GD2328529@coredump.intra.peff.net>
Date: Wed, 01 Apr 2026 13:50:27 -0700
Message-ID: <xmqqh5puv20c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> When we do:
>
>   char *cp = strchr(argv[i], '=');
>
> it implicitly removes the constness from argv[i]. We need "cp" to remain
> writable (since we overwrite it with a NUL). In theory we should be able
> to drop the const from argv[i], because it is a sub-pointer into our
> duplicated pager_env variable.
>
> But we get it from split_cmdline(), which uses the traditional "const
> char **" type for argv. This is overly limiting, but changing it would
> be awkward for all the other callers of split_cmdline().

Yeah, it was the first thing that came to my mind that const char
**argv is the source of the problem.  We could cast the pointer we
give to split_cmdline() and drop const from argv[] instead, which
may make the in-code comment unnecessary but the patch we see here
is good enough.



>
> Let's do an explicit cast with a note about why it is OK. This is enough
> to silence compiler warnings about the implicit const problems.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pager.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/pager.c b/pager.c
> index 5531fff50e..801ba392f2 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -118,7 +118,8 @@ static void setup_pager_env(struct strvec *env)
>  			split_cmdline_strerror(n));
>  
>  	for (i = 0; i < n; i++) {
> -		char *cp = strchr(argv[i], '=');
> +		/* we know this is writable because it was split from pager_env */
> +		char *cp = strchr((char *)argv[i], '=');
>  
>  		if (!cp)
>  			die("malformed build-time PAGER_ENV");
