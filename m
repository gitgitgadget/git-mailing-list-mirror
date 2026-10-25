Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792951676;
	b=3g7joYJVC5dAJ366N06likuTQXg0E53OunC0mJJWVFZFR/ysx5fMo0dO/6WNGmA0JexI
	 DC+klxazRHJl7ek1SzFOnArFfrFdXBeLoKFYDdIihLLywAL12JuR/j470aGOXbY1V/47g
	 6c1RS54pOdSmAWDSpjn9HZeLBUB5bgPWXW7OHx/HUmztYnoeTCBiZvj4uaRKz0V1WpQqr
	 l6LjuTcK+vdDoWmQVdHwnj5dMj4+xK7GL7h2x2dLaGgYAsK/puu4thC9lT+v2n42ExxzV
	 KSHcN2EDFpA9MRIHS0ShIwMl50wejNhwfeIWnF2iK0WhL/WsdmOOy7qS8vkfijy/qYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951676;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4SX9diARKtULdHLMABrD683/RlU8Fh0g828iOzOzlBI=;
	b=UmWYA2I7xs2JLdM5fIHF7evltH1m3nV0MSks+QtoKL0gEZk2ccC9Qrf0A7qS1A1XQv6u
	 JG+haaxH7JEZFfYReHM5H1e3bYN32SVnb2tKuGCNUOq2ejLIaoDSgpebHHv+SZ5/xQp2N
	 2CsdBpmH26pFfVVK1KXpZ401So20dC+wiV1s4lD4DtiwUoeajcwughZxcIk3E0vExaYX6
	 LSN1Ni+0raEFhi1dRUnq1B3kS8DZT2CsbcrgBdRJcnjuiHXjl+kP6ggg7O6OUQbavBOvb
	 zH590DOzUId0MZiFphIwVqxNXb23pWwSzHJ8hDBx+qxypsnL/CdbQn2u+l3VVf6sxbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gvd6hDp7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uE6I4AbP;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C7606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 18:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=gvd6hDp7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uE6I4AbP
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 246D014000D4
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 14:07:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 25 Oct 2026 14:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792951675; x=1793038075; bh=4SX9diARKt
	ULdHLMABrD683/RlU8Fh0g828iOzOzlBI=; b=gvd6hDp7BmZYzNzvEmsMzW/Xr1
	hisEn7iSafDa/3XVSnbHIoGJ4IjBXyQWHIsufPNAoD96mn2X6h20Tu7u9NPPTGXy
	nlBm6hb59us8gUgRCE4OwWFxu83T719fZD2appx+ggUdmLEMDC9jTKJdUIwBSjdg
	15rSxKO9R3dOFpVkf1KATXdUwmCpW7ZW02/bvvRkf7tqQFecFpwdB7I9ommv4eHE
	cWQNXiUuwVZNSYPtA8fwXjM5CYkM3pMTxvaA0WLVsA3CQSRPnw5HvRUxeJ1biVDn
	3YmHvHRaddUurDbTrcrL+iSMq69wyAPJ7wzcKPNR9wzGOHhxEi4KoP0DZCcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792951675; x=1793038075; bh=4SX9diARKtULdHLMABrD683/RlU8Fh0g828
	iOzOzlBI=; b=uE6I4AbP5x7Y/L1m+huXsIgxqXkBVtB1cBO3LNlW5PwGp/CJz6x
	iqNHt/6YaTvI/oqLdvpNEa2Y1ZFbu3rPH4BPtGi76mGPV8yv+gm9Sb7Lhy8Q5K2V
	Xg6LXXDIgDQiPMkkLEOsZsYM8xe4BwHPaftiNyeoav44jXIvzfXqzJs+5Y61LsGv
	OD/4wfAm4v7hU2CXBQf7WgY2U4TW8XXAqwJAmJBOeY4LWcGwx79eL351cMMtiRt9
	xOnbnyxPcvGkItcan5Wj9JjyJ6PWKeKFV7b7p+udb5OGy+ZM9prfslTWw7PN4Ufb
	u/iBlaP9hOMpYJh3T0WKYBCKUN2BpaXRY0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792951675; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YpHXYfKlDzbdzMKjw7ebGPbOM9QJux7JwPkUARnl2ShmBex
	FTzQTGW+nVQIaz8wipXRs6OPJZvUqhnMGePbrc/z2CyQjQk6hxQPcBraUC9UopDm
	aGN6SyeSqi6ZH3qF1lLVyfAZP6r+sDeJ2A562UZLgo4GneHJ9FtPePRledb0VWMc
	ZOgoIqrPfTXazI7MabDZ33GirNLsBkh19Omdi3Er6xJYzZ3wGv5edoLrhl+Xrm0K
	Lx5ILDB7x4yn5QsEahG5zB9zsmu/q5qbMpQuJmD5vgBQvLteiHr2m3GYfDuYY5NE
	7PTpIDxF/ZjJTT01C8V2mgm4jW97PgqlQcnV9Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3fSW0rmNHee6EndyH7lO/B4rQkWL54ADzbmTD7UVdAE=:Jl+SzmiOn8BI7o/jP49AekGh91iSWXWduAZZd6JLhus=;
X-ME-Sender: <xms:ekXeagg6dYde1YJpZs8_6qR693LE8GLDK993NaJMt0FmMW3Z73C3mA>
    <xme:ekXeassm3mWXcDGrrtkBtRXa5uJ3zhUVyuWTMDC72Ezyg7iElzahQ2kFYEK8DOi4W
    McfOHZQdKYF0T9TeosrKtFcIHJzHD0jo7U7JoRgXi6McpO7IBgSwlw>
X-ME-Received: <xmr:ekXeah5BWAxRaeFGZErmxBxLxoh9hkeRBGUwGOYf-4mOvrheXJGiPjx140hNoh3B9yLYypnKU-GdyNVDK0syeQ8jd4MdJeDLBXgQ>
X-ME-Proxy-Cause: dmFkZTE7S/7BNiqPItNVdg3vC1+BWKtr0EnyIrhiTR4bHHWHLyDxvmsukjsUY7j4Q2vhAA
    2qTRIVmP7/TxFOxGDYjXmHuw23YKZYJ54GVt3cf3t7pKRMdBzKgs295CEphmZwoLEVIMH2
    DdudfkU8+Rg34Poo1+J3pwUG/E5Lae4XCpo+RlR+U83MvSxbczdfq74hShDl3PZNFlyK/x
    RrFk7z0KN6lGdIeLUJXxscIkp+6othizhrfIiSBV3HC+okAgeWqGja/uEiOcgaytEd3xnd
    8rJ6Ni6UnKwHFq0RDAyhGWaNnE2pSYZhbj1YDmhWx95gTqieaiABHOSH/xeJ6zpNFRRUDN
    wIcbk+bpOlElIZrpPBqSrr7wYd8wmFBs6rwlr4qtzHqK7m4xIQfFOvLTxcuGQuJuKbtJbG
    5H7vCvK/j240mgl4UhpbwGMxYQunmctM/AkaupILnmL/TWR6a6EN5KZu6mVO0I1rRiuPnV
    DjcLaYQIc4h2vunJ8Mg7gYKgxpZiW5L4Rq1UKPFjTab3gh4lyac2CF7xflJ0ZVRlpiO/wT
    CIRdvx/16LuKupDmyH4wg+j/J8yinI1xUozw/iSYcAoIJUH/ota9QENPKvT2XBP3+oc0jF
    0yZBIN6t0lVyWzzmetzs3/P2hCnrZQJmUiU4JMTA61fUfJa65G/2Kmp1e4Lg
X-ME-Proxy: <xmx:ekXeaoMdqnu8N2OgyW946J_215Qh2rBGWrGVSos7CywD75EQ9MwgXA>
    <xmx:ekXeavsRLLPUlmLmFFZuaGbLYg-0DiCWuLm13Gc2Yr79AUBUs5TpOg>
    <xmx:ekXearZIf641j4f9Qoe5GwKQfIPDFCAvp-L5xBlNviPMObH4RJxwxg>
    <xmx:ekXeahzwVZGsjO3KTnjB4XZeh_siLi1YIXDrSpq7RvI6Y7Cm1DGBKA>
    <xmx:e0XeagpBefdsQX8aoLn6-Y387Kc8PRnBhhgB0UkKqKKNvve8yM6Zl8Ej>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 14:07:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  Sven Weiland <sven.weiland@tngtech.com>
Subject: Re: [PATCH] builtin/reflog: say "would prune" for named refs with
 --dry-run
In-Reply-To: <20261024013850.66448-1-laveeshb@laveeshbansal.com> (Laveesh
	Bansal's message of "Fri, 23 Oct 2026 18:38:50 -0700")
References: <20261024013850.66448-1-laveeshb@laveeshbansal.com>
Date: Sun, 25 Oct 2026 11:07:53 -0700
Message-ID: <xmqqqzhdy7pi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Laveesh Bansal <laveeshb@laveeshbansal.com> writes:

> With --dry-run --verbose, "git reflog expire --all" reports the entries
> it would remove as "would prune", but when refs are named on the command
> line it reports them as "prune", which looks as if they were removed:
>
>     $ git reflog expire --dry-run --verbose --expire=now HEAD
>     prune commit (initial): first
>
> Nothing is removed in either case, only the label is wrong. This was
> reported at [1].
>
> fcd2c3d9d8 (reflog + refs-backend: move "verbose" out of the backend,
> 2021-12-22) added dry_run to struct expire_reflog_policy_cb and set it
> in the --all loop, but not in the loop for named refs. Set it there
> too.
> ...
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 1211c58fa4..49e5453dd9 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -279,7 +279,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix,
>  
>  	for (i = 0; i < argc; i++) {
>  		char *ref;
> -		struct expire_reflog_policy_cb cb = { .opts = opts };
> +		struct expire_reflog_policy_cb cb = {
> +			.opts = opts,
> +			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
> +		};

This obviously mimics what happens in the "if (do_all)" side.

But I have to wonder why nobody finds it disgusting that what
happens inside the "for_each_string_list_item()" and the later "for
(i = 0; i < rgc; i++)" loop have striking similarity between them.

Would it make sense to retructure the code flow to

	if (do_all) {
		collect "all" to a strvec or string list
	}
	foreach arg in argv[]) {
		add arg to the same strvec or string list
	}
	foreach ref in collected {
		do the expiration of ref's reflog
	}

That will help prevent a similar bug from ever happening again, as
there would be only a single place that sets up how the expiration
is called, instead of two we currently have.

