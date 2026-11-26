Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670263;
	b=qhkD9xjykJGpuT88wKRp7b4jQeXjBTN+DmyTslDxQproK8/CwcphGGQyaVpdNFD23MR9
	 GtqBy3FzNskEbbNLMN9KcA/fo4tYP5NBxfynDWsxtlnfbGRK+igKgPOFtBuMHNOQRlkw+
	 tUrSGAvyN2nnR+GOCZFeATizQx0T9ALu0FiVDHTrNydmg8EdpRAh2v430vShg/Nwa6AtO
	 1s9qwRX0fJa55yIa+XQmvOudQu0XpFgaiezxHYbp/nt87asHYlpKR9qnLITQSp601ekse
	 ujkHOYX4Gc3ThtgfoLxyQFAAHP3Hq3Rg30UU434iNe+eRNFnkbARPITogpDAb4G13Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670263;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=mLz2eaLzskVc1hHKeZb1KlHVQCgLn8I3f5RvCB1Td3w=;
	b=vEhh+9UlxFSJhsFY7YTYfkciqG1dQSqjZTbzW87PJiIvJ9QHIT4cX8ZOvxaYAcEGraH8
	 qspeFWhcGaNmtCxbhKdYkRx8WmUTH4WaarKKc/LbTOi3zbGOWokesml2Cqx4cXui7D++x
	 Ej/kefflRqjqyrXlbALR70eSODow4kjlY5rxSdijpvJ+t4XbyCpDVgGjK3e26JlBqvYSI
	 HznU+BV6NNmWl2lOwyFtb/Tnhe3N+Kef/pdCowUgaFdOvkFEqMvz9h23mLh42lWETGD+z
	 nXFZpIr8vSo80jb7RfSWMg3XjaxR628UjWzHhDVWuO9SdJaFVRA2q9A79QrP0+vESBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iU2TtG+x;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V8+S+YAJ;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1F606A331
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 05:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB1F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=iU2TtG+x;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=V8+S+YAJ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B09D7A0562
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 00:17:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 26 Nov 2026 00:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795670261; x=1795756661; bh=mLz2eaLzsk
	Vc1hHKeZb1KlHVQCgLn8I3f5RvCB1Td3w=; b=iU2TtG+xqDueNgZxcge/ZyqAlJ
	DfezmGSckcPEcjILXIwCIduNv4uWz0a4LSblMqoEBpjWIhRuFpIj3jgAqeiRutOZ
	jzV/Rryd/yQMJsmtfuJN8YMNFxEsk4FyabASHqkLsVGnTiy8aOtEq4ystlwFr58w
	OxsTLPpVzxlite8yo6AxzQlt7mQGk6JM7eVCc5FO6JfKsn5KFKfrRq9p2eLFs9RM
	1CT5JanMYQXsK0qPm7V+elLoKJnyGdUt+jH/qd71czhJdCXks5L/BwIByffRipEa
	98TisL7rGp96CRs6j09heyJ7muS2rbXZfWwET6TxASjeZyOhjgN3dl1evkoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795670261; x=1795756661; bh=mLz2eaLzskVc1hHKeZb1KlHVQCgLn8I3f5R
	vCB1Td3w=; b=V8+S+YAJpKQg6BQN2LcngxITDG4GjEI9SCeOVAn8IADW6VigGr5
	kxF+TCdRKKpGVxQ+pQMg9p/ElHB/BktDPZ8IzvW0pIHiu0aR15nUoijICSYG6hlX
	dQfwbIWUSVyVALt2f6CC5B5XxvuFLEYa9t6jafyhNlr41eN48hLVUojnr5RTO8Ky
	LcAW0rYYqL7+UsWHdcKf1UzHuhxOb/r9IxXJqADjsnQ/Nj3k+KJ6Xo0j95P1rOFj
	B0xgu1C67T+wFkAUIpD69vxztZjUvcWlqgCimpe9U+9UZ8d6EMuM/kFuTvTR8hQp
	KaDmFoca1rUIJ2kpO+rRChE2N0Dveq1OUpg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795670261; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:K3OF8t5bDbr8/q6Tl8VUTp64i3T/j4jtjvhVcFYEFIGtTbV
	eqbeOk8LvDAB02p5KPVrlkVg5rOF9yDJMLUkgl+TgUDK3+8R5MHDpw6S9/XtZQsF
	5+bHhE8fcqt0LXYqJo7RNfA8j54IRxrVZbmFA39g9pjKdpOCCwvRTK4YCPizlbQ3
	FciC/ZDV44JhQ/akkWD7dpK36f+bhq91oTyASlC+iCHEdTb0Db++9dhFkqCzFkAq
	v13Q/1xt93sa6hwwtA4DXOiIRiagWJ1omMSfdbfspwSu/5z7LrzIA41tiGZNysmh
	mW18suk6SeVHPF7IQgfKHlRd/62IW4ErIc5vcGg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7E0ArxgVXzHF5K5HbXBmAjY3l9nQjaZwVoHRoxWElck=:3OBejM/BXkW0YFbvjeu3XjqAXEpSC0bHTu8fJMCNYDM=;
X-ME-Sender: <xms:9cAHa7WSt_s1PtcA2k9rZF_K5QrXMhUo-12cmTwglHNoJN5u-MXN9A>
    <xme:9cAHa6nVArM_vaagTzWGurHsU2I4-K6T0Pla2cJWXYTEPK0-nb24Id-sacwhdrjwJ
    6F5oGqfSiBun4-H1noIYvryJhCDEZqJncsCOPJ5dQDMaFSPIDAyJwI>
X-ME-Received: <xmr:9cAHa8bc4Lcc1HeXbjy0QzjFTl08tPVYCXph03mV1RA_LEMWNbxuS9lfw17vvMBZzfE-HZYqMe_srBldptxLMKwh1_w9yRrvdQ-q3Ws>
X-ME-Proxy-Cause: dmFkZTGHTj2ylvXsvdvaIKjuBhjMH4sHjRjowj3k4sjcUFjAbc7+qiIwPgkuPuQv47YUMP
    a73l6DWRfMtmhGu4ej15ObpE3ATBfBBCwKm5YvkLOAxGVnZmorpAfQLLJnh7eGwTnPFA5c
    JOaLX2oy1V/kY5vXQR/dpmbgW7UZsTzFg3b3ucCgY+N4axr7ch78/uq3p0HHKgWaahS/ZA
    ayJQPI1vjVspkIigOg8NB7pFNAdlarhhZoS4ayrYPSKm+lhpel9f0nPONjBd719xkSHkiG
    ylMlyQ10A/+Y41wZOFZ+PWfUbSWi+KTV76hqLmun9u0VLBZs1oLirKcPTzv8SQnzBTjqd9
    XFU7kJ9rjNLC30wz+bs5qM69Yo4oWsNm508U5k4h4YESAyr1j/MQUZe7FQH3T/g/aXyMoa
    dtzFYgA6mKlS/thWrk1BaRFEHC/zuaMWwy8TuKxLBaz7Bl5xhVawte2Rat0WezKP/uBGUt
    GSx6bZgy+4+c68Yinjq4ZjyLvg272xKM2FiTTlNXCN2UCKr8J5NCilETdIt73xpUF3EjgF
    W9GYuT1zz2ljrNk9hxANsrWDv0n3Y+wl4A2rMU3b6B0Jdh1p7igTXPRSdNYhKSVLIvOIRW
    NS6mkQY/hsFGC5EM68OSx+QxNnQ1ZuLSBisgK3IHS7tj8/3Z/lKiSee73E1A
X-ME-Proxy: <xmx:9cAHa1Pyv2RkmGsU8qbLldrIjZG9v6RWgCH2urXTk8kp0dfT1-1T7g>
    <xmx:9cAHaxb1NWWQBBRBMqyo_gsr3EYfVNE6i4fzfA9lXu5RNEyrkoHFDw>
    <xmx:9cAHaz1sCeVLscfKeQnkc87m0v-2QHuuFgzJW00OMwnLnHjkS-eyDw>
    <xmx:9cAHa3f3aDJ7uW6f8-ialVd2XrgRFU3uRw5671EP-IK4Sumv-R8QWA>
    <xmx:9cAHa35257wFKEP2dDfDqIULxNaAQ_OZWsa6-SeqLBXGIoThSZ9B5xSr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 00:17:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 3/3] remote: reject invalid branch names in add -m
In-Reply-To: <bc1e30f6d05cf3e724a454e4c922a33f34c5a55c.1795632934.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 25 Nov 2026
	18:55:34 +0000")
References: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
	<bc1e30f6d05cf3e724a454e4c922a33f34c5a55c.1795632934.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 21:17:40 -0800
Message-ID: <xmqq5wxkqih7.fsf@gitster.g>
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

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git remote add -m" only looked at its argument after the remote had
> been created and fetched from. A bad name such as @{u} therefore got
> as far as a network fetch before failing with "Could not setup
> master", leaving a half configured remote behind.

Again, log messages are written in present tense.  Have you perhaps
changed your LLM settings or something?

Minor factual nit on the commit log.  In add(), fetch_remote() only runs
when -f is passed, so without -f no network fetch happens before
refs_update_symref() fails with "Could not setup master '%s'".  Saying
"after the remote has been created and (with -f) fetched from" would be
more accurate.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index b04cbe70b6..35c6a1f7fd 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -226,6 +226,14 @@ static int add(int argc, const char **argv, const char *prefix,
>  		die(_("specifying branches to track makes sense only with fetch mirrors"));
>  	for (size_t i = 0; i < track.nr; i++)
>  		validate_tracked_branchname(track.items[i].string, mirror);
> +	if (master) {
> +		struct strbuf ref = STRBUF_INIT;
> +
> +		strbuf_addf(&ref, "refs/heads/%s", master);
> +		if (check_refname_format(ref.buf, 0))
> +			die(_("'%s' is not a valid branch name"), master);
> +		strbuf_release(&ref);
> +	}

Passing 0 instead of REFNAME_REFSPEC_PATTERN here is the right choice,
because -m names a single branch rather than a refspec glob pattern.

Because check_refname_format() allows "HEAD" as a component, -m HEAD
still passes this check.  We would then later attempt to point
refs/remotes/<name>/HEAD to itself, which would be similar to the crazy
configurations this series tries to prevent.

