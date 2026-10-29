Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793294698;
	b=m4671Ja/3NlA+bx1BC8xCBk4Kq5Pq/selKbHopy0bnCIu+xPttGQKVUVZJQ0aS7Oifgw
	 XOJYAoa1JAtZNnasWYs7uQp+BgHxe1Khu8i4ebYkSbz6hjcqDOQnqDnFUy36RGM1R/OU8
	 tI4mdogjCgNKnmh4AmdjA1W1hbl8/W1e4skEZ/PWQhf6JAAZsS2e6+Zp92km1f1qEhUIM
	 K46bZmTu0+VXhZVPuWRB4qz0l9j8QU5qktRQ7WuFqYHg/qVKsz6l3/AIwdF7eA04p+5rt
	 jLlm8KtsZGJl49FlBYSjQf0pLZB/Q/se5R0KXM4EE7kClctfWeSpM/NQTo7wTY1ZvIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294698;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lQW8LoIYXrRpEitR3Kn7WGUUZ/Q25Gk4Z9CbwtdZVc4=;
	b=coQEKGe68gMXSSEMLkZ5upOtb7FEnA+lVcWhsGL3LQtV87c305TkHa9XOBmu4hrF4K1g
	 +R09vowESDtt2xn+c1MMoEXNV75TC/ebNfh3oLTFcRVEAxhXP8pd0h57f5LBtz8vffJQM
	 OhydKr75/SI4u+tqc9ngCvVF8hpokTYsJn7DBZLwb+iJpK2z6StBy5WF5N1T2LgwN4ox7
	 mkkKL/93R6dT3MGNo6gwV3yigKNRWcI6iE4joIBjhmB87tU2cVJRBo56du+KrpYxoKgr6
	 Kim0NpCTpEEHvsX1wLg+zk3srS6g5Tppj9tbqJXWM5vVoaDMzPZBiT1V/3QGO4JP7XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PGSyHute;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o+SI+1f3;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D22606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 17:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2D22606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PGSyHute;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=o+SI+1f3
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 35D491D000D3
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 13:24:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 13:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793294696; x=1793381096; bh=lQW8LoIYXr
	RpEitR3Kn7WGUUZ/Q25Gk4Z9CbwtdZVc4=; b=PGSyHutepCJ60BYFxAbrZoADJC
	cPcobFlkTyY7Akw5B8fBv8YA8Lyrxlum620RqrJbxWi7moxbAwnJFvjrZvwjQD/c
	qJUkYHNxtr/5GMsC8jgH4z/UxY0oSiXETSfcEX/IXdjB2FcSLGg20pEl3abqfn/v
	INzA5afNCU0ecvSS+iA4GPh57+ISp9IfydWJ/uiKNbWm+5q6i6nawIvGVGUzm3sh
	fXoJldQlzINHn3jVOSWSCB+OsLZZWYJHUqlyNOWv8J57bk5p544g5UXOctEQ2eqw
	IszG3OQSxiK2opAg2hZ9LVirejeYnyIva4Oy+q4VTC01Wdedn19G9qbqkFNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793294696; x=1793381096; bh=lQW8LoIYXrRpEitR3Kn7WGUUZ/Q25Gk4Z9C
	bwtdZVc4=; b=o+SI+1f3BD7tHIRZXlmz6tOc4nQ9WYxKs50EFc/XefjxQvSzc4j
	kStXHsD1ScJZSrrxAd+lJJv8xSISvq+uhjSEUDz6F8wtKzgq308AR1VlHVh+tkL7
	1mtNneLLPenv9tccch0wftTLK8ZEh1xZTQJNmL5hosxW3Nv7c2cDlqBXowWOljnH
	Mw30lWGkw7kZn0zcYMSzHz7w2vwZSt21isbJqEvbTQWtniZE9f48Phr7P+yBbWaC
	pIKjTsUfo0RXHBS48AJvQbM4ka1ELjncYg5zlW1EblUVmCc9gNuPCCVGYIT9Q0/v
	fELh6Kfa9Xz5ecGitSkyT3P6lE+BEgppi5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793294696; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CHB2mpUT5ewGUR0ugj7gPJGrhaAZv7lU6QYBmUzlrIahJyj
	2kJJJ5okchycDOysHVhUFT8NuX6fFoR16XcH4srRoz23yP384iHXn0FLhSMERYGZ
	qNqeiS9O58N1hp3NaZ4C2qw4O67INpmOGksTaZgdj3XdKlCdL+8pqEYDUnOt/huk
	q4I8CUf5Mdu+zrZ8Wnm9NBwg4dYpuSuqHEnFe9wMEjsvMBR8cPo/hfvp6uMpRCsl
	jtMuFz+TZQt9+SLjFFGcsAAAJyU2UGnH6SeIsqbQcRvFveXQopMFTdKMORuFh+e7
	fJAroDfhwKe1IZCDsyErWQAyI46rXeoCTmHF6HQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ErRKaXs9hvOHrI4lnQA3uK2WXk/NpRyTFlgJRdyU6Lo=:vhDCUgF23NnIJnqo5RhhC86OWGKiNblay4TnR/lhhXw=;
X-ME-Sender: <xms:aIHjaj-xufGabASxKMEH5J_g3fSxxMaVU6vhRZqHZB7tOa1KElzLvA>
    <xme:aIHjajZT1MAeh2-F_hHQJz-zJhcvrqDGV_IcHFukeLI5I7tDqrYNuj7DjPUGXRdI3
    LLWlxc_achKttgVPtbt0ws63KEFoA-u3nHHs1R7cj7vGua2rCr1DFQ>
X-ME-Received: <xmr:aIHjaq1Mta-GHXfgClaT1ZHgr6Xup0OtZCc_Rau7mk71ZA1zexBtu57E26G6HZivnhuzbwfp1s8oOaXo3G6P73n6cMaqb0SxGF4i>
X-ME-Proxy-Cause: dmFkZTFBsfJwee1ldq4kTL13NUPvUCGdIvNYgSqk6SZjzV+CtZYKV+jruLcovgPIdl9GBZ
    w1jKHIIb58cdkyWF0GneTdwLihjtXbLb35BvKjSmcVYePtqvjqcrklXE2AaAOCgm2zcbho
    YAS/jMQoe+yFvszoRc3U/KP5sjHQKNEhxgSr0Jhml9HIIbgL6+fekOxeGOy93BOA/Yvbbm
    UZaDGBWDNw3bEk0kGfDXQUsLYJizCAvw1Qi/X1C6XYBhf5EgpAoen/qDH9xHPrVQiL+HeZ
    oaB20iDemrEkTOsE32LS79vtz38QNXspqhjD47/wun8vXNXAa7QWJ7RMBYFeLS1fnhRKNp
    d+i6Ivo2X1gs6buROINsXoCQN+A7uVrbsX3yktiwVCEXXsoKeN1LlNldf3RIWBWfOWlgRH
    MPSCNGsEJNEX8KrHY/2rBz/ZDU2Ugq5+YxeRECf4eq2qe6kZHXFzljIuEm52SOEW83PqD6
    90t77lW04xTc+iZaWiqIgHJ0E1CYKNnlPsf6GTa7lBz2daQLVehqqlwpwLGkDtEIZRRfRW
    C+sTAdtuvhU+tFdv7jCIcqyCfgpcLBdSu9pkgK2IssoKpqhIWJ16m728iyRZeyW//vBeAM
    9fq3PNV1fnKweRDdLqhFtQyD4awvlI+EOFOkjZwTjWmX6VXiKuP42cB034jQ
X-ME-Proxy: <xmx:aIHjamaDfkxHmBOOWMUCVE2g3zyDv6eafYO9p3--lmApjSvCU6jjEw>
    <xmx:aIHjaqJlaTijGewZBJXtqfyaEInjoa4Kg2oFLEhZmLInt9Bd9WX7Ew>
    <xmx:aIHjatHwt3IXHdykXu6JkGkcly87fznL7jo21HlTlZwy60wYhWlJFA>
    <xmx:aIHjapvFYWeCQjpmRggwjq5ImigOHy_3Ei6xK6EgOG_d4gpCyjlC1w>
    <xmx:aIHjagyb2_qPZNJPlSFXmymro8rCEF9gjRurlwYxZ6sW6XsGLumEjCRr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 13:24:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH] odb: do not list our own refs as alternate refs in the
 quarantine
In-Reply-To: <pull.2285.git.1793200705017.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Wed, 28 Oct 2026 15:18:24
	+0000")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
Date: Thu, 29 Oct 2026 10:24:54 -0700
Message-ID: <xmqqfqxo4dy1.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     I also tried resolving the object directories that --alternate-refs uses
>     before the quarantine is created. That got a bit messy: it needed a new
>     internal rev-list option, and receive-pack had to carry the list of
>     directories through to each of its connectivity checks. And it only
>     fixes the check itself; other processes running inside the quarantine,
>     like pre-receive hooks, would still see the repository as its own
>     alternate.
>     
>     So the question is really where this should be fixed: is there a better
>     way for processes running inside the quarantine to tell the repository's
>     own object directory apart from real alternates?



> @@ -190,6 +191,20 @@ static int refs_from_alternate_cb(struct odb_files_dir *alternate,
>  		goto out;
>  	if (!strbuf_strip_suffix(&path, "/objects"))
>  		goto out;
> +
> +	/*
> +	 * NEEDSWORK: this is a hack, mainly here to measure the cost of
> +	 * the bug. Inside an object quarantine, tmp-objdir passes our own
> +	 * object directory to child processes as an alternate, so we would
> +	 * list our own refs as alternate refs, including the hidden refs
> +	 * that the connectivity check of receive-pack deliberately skips.
> +	 * Comparing paths papers over that; the quarantine should rather
> +	 * tell its children which directory is ours.
> +	 */

In other words, if we tell our quarantine child where our real
object directory is, say, via the 'GIT_QUARANTINE_OBJECT_DIRECTORY'
environment variable, can the child notice the variable and identify
which of the passed alternates is the real object directory, so that
it knows not to use the refs associated with it?

It is a bit of a shame that tmp_objdir_create() exports the same
value as DB_ENVIRONMENT in GIT_QUARANTINE_ENVIRONMENT, as the only
existing use of the latter is to check if the variable is exported
or not---in other words, to carry a single bit of information ("are
we in quarantine or not").  I wonder if we can change its value to
name the parent process's real object directory instead?  Then we
would not need to export yet another variable to carry the
information we need.
