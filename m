Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735059;
	b=yTiTUCNb0Rvq+vV5MdTRVvZykXQfDIZW5DIbOfuUggWzfj4QhhYBLNLTouKdeQfhrtzY
	 ftB/pGuTwIjStLN/SkOJ7JsZo1kYENZFFnCizG+K7oKKDojYl2zYtvckdTcgtGu09k6fN
	 xAi6KzlG5SisF3MuU5iVO6jhuVfqjGqSrZXHlDqOa14cjUFhweL53E7Tjgnae6uB3o8PR
	 Ohpv1SBXN6ATXENiOL9NydoGTHVHR9eRj5gHPJBBYNqT7cbZ5VhOaz2I43LO28rYkAFZ5
	 NBrG8WPV0tCy32q8iXWhwlr1Yd/1ce9lXFkLeMUrQYhwDqFqg/MQAovo1qaI9vPyWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735059;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ReD+3EhJsmw9lfrZu3jFfZz6QrgLiX1mhGAMfABu8j4=;
	b=uyDPuZu+YgmHQlYIAVxckT91O0Frl1xzt/tCZuS2QVkpHLD333knuOOZkvH18aF4N3Oq
	 SAENyBF1sabWd9anfhHIM+B6OQ/ukAM0HCydZdaBFJRi4qTubQqg39GlRccdwxm+iFK/8
	 bQmbzEsikBuNBzdoC3tLALo2+ROGc5sPWGUKuWl68nTp1YApSs3B9i/4OkZiPEKC2TULI
	 AIqbNhUVOcsmuUauCecZN8HQf60o9WatnxhmRPzs7fsyRSS5oFAm/Lw1XyjGZXmAGkBQx
	 cQMWLeXgwW2Na57JB6RSir6h9XSL981KTrx1XVY2Z/cZMmzDIxLOEb0EjhFDNuIXsIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LKNk0WvK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KqX2gu7X;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE87606A33B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE87606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=LKNk0WvK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KqX2gu7X
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 50CA6EC0687
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 14:44:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 03 Nov 2026 14:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793735058;
	 x=1793821458; bh=ReD+3EhJsmw9lfrZu3jFfZz6QrgLiX1mhGAMfABu8j4=; b=
	LKNk0WvKHSvNOuIPHMtzNqewKALw3GuBVOSzUlUJ9d9ODThXCMSfblIpf5PNwXJP
	+qZmv+qO32ftG6XZbRv+C16YDINHejnjKoR5d3a0T/84uXU6Nlr3MA/qlIS1l92U
	7kUNbPSidhgxqJYuigBDS/MkHyASUviWsDVj7/BHEPx6nQ0lcCu75MHRJdgFPgvA
	0+HZspdzcyZJD1GbHCDY8+8gqz41RKQ/gaz3OnK+7Q0O8/RYB5mdraBN3mUfujyQ
	RVFl052FBrdsnx/fKCxUnEwVvOEQjOCj5MOEzGNloc2DcMbW5ZNC3gb7ssM0OpfF
	HC9wnz5l4ZPRWxaE0S4c+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793735058; x=
	1793821458; bh=ReD+3EhJsmw9lfrZu3jFfZz6QrgLiX1mhGAMfABu8j4=; b=K
	qX2gu7XMAOsAQCFMWjBpcVIqiOvis+T1xJzqHJgiWkpTyT212TgJQB9Ygy0o3qw8
	9h/4Po9jBJiobNWjewWvpGVB+UaVGUrwizCkGMOXDXRyNI9PIKqFbypDaadgdgTU
	f2HCbsgqBTQW3y75agCIJ4JGWNuLVZNZMhlLVn7mxzDkirnyTv3jQuqZcrdp1VQK
	mlNe1hbNn9kvI1ITWqTkQVMLKhN62v/1L6abGwkTN8tnzWi9GL9rSlhycUaEDK2Y
	lLNF8OROM7aR0aj6p+oGLA0f49JCMvYB4/JCwukK2IEtqLeVb6ERGR3t6keKhQjv
	dm9hk+JOF7KmBJF4/pntA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793735058; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:LtEQUPvBDEfPbyD7VzmcUlD2cISiI6bLl15DFbDaTAyUGiv
	wak4P/OCOOHg4KVfjCVb1aSOeZzmJPPj/0cXU254Ac4+lZMGuT3CLOSKSaWIuC0w
	5C2EO2h1Gq2FhIHP3eC885WHzb2J5VxEUsl34f/MLNlijpbf/qSqpDqMXVLN9Rt0
	8O/OF3n43g2QnrCYZg5sOtiK8zIdZkJv5kIQrscltlJZ12HqnLxszIB1+pusg2Cn
	OuRq7XkFXGiwyicP27RXFgMMFDV1SGq/JYbNXWjW2QuHuFd+/uLoGSleNTXatFt5
	hDIq3ei+AYjS3kStVV4SpWvPfrcgYVaZSZf1RDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:GnXi+x6Ac36WVrasCvu3JJCDBtl4KHxjPyP3d1Z98OY=:nIpODB9n4bIg9sEDo0XS8MqV/0pYPzI6Kmpbq4+BkqQ=;
X-ME-Sender: <xms:kjnqahHRCNd4rum3Ev21tCJpb9IOgOsixBIbyYwqFMFH_7pHOv2OkQ>
    <xme:kjnqatMwbw_T_keBr9MCArchmeOTo1tUX_eMr9PM2fUvnKMHxRnBcyRKi-_L-UXTu
    MarsLMqLs_L9c3uplLwVoo0hDwrzdKN8TBywNvDrMyFR7-4Si9BT5c>
X-ME-Received: <xmr:kjnqarfuyxek2v3onpKSzg8upqfxbcnlIuQ9qoqKQRiEOrF77EmNlTht9l0rksOnN6s9QCn2nvD3-LbQbhDe33kgwWdJjYbSGB2v>
X-ME-Proxy-Cause: dmFkZTEP26umSMKvBAXz6lXVRfarA7rw03e0S0nsXQsWwqO1YUvFkpdvITKn35eVDYPBbW
    +Pa9T5LLGMEBduonX0ZzOM3jUe9x7iD2Y0ZgY+fCHaw3TCRiSUu61uW3Rsj8jUnZJkQ7fj
    d9iHW2kNNfTb9GD1hIdsiF5hsNXj8FD0uvn/08AozNIOFBJFOTeLbi79akGm3aZ+0tDsCA
    1xT+PfLfgKzm//ziEKD8ZkmTFKrPVtdgSgdpZKs96A55JYvuoohXyHE6AV0Rp/oER88L8h
    gSEkMP8MCyhd1E1r+m4qkKjMPuovXEeJ1+VUo8L8aisX1HEt9DTcpb1qcfjh2FjIUFPye/
    5/xFPu2NtgTX5Nwp15ofoY09Y+t1YI9eKWS2Jql7NLDJ6doV+KBJBLoLcEoUiDvzMMieZQ
    ZgQPOB0/fovZdsTqpMOo+fxYV5IDDAurPsqRwrxJEfnTAxemk6CZw/Felpc9JtiyD7vgda
    nNKRQNQgd29I3mDobqGUvr0yvD1ZPcCb1jXloWHlQErjqyG8WQUqUK37AXISd0GnYbhEYS
    RKjlVpCwWluSYGr/LljjxEWTzlyXyX7yoZciF94sWTo2fmbF2wr2GPRwKTFyKrCqUrd0Dv
    YcaUdT0Z5eaEqqP11Lh8irXyA5UasiRTwSqr+1ZKzcLPXp15KyUpPzGFZ8qQ
X-ME-Proxy: <xmx:kjnqais4oqLvSSy8gZ2INc6Rw-DajYzJ1ugP9I1_17efJjCUZztdvg>
    <xmx:kjnqaklJQkRNgrz_HeWLCi-jo13rrOX9Xb1k2AaEJsG0Ed5TpDTqBw>
    <xmx:kjnqaswjWX-139MxpkJzStlkXtrNWzTqTOLU-ZsVNKPPaKscPWzPcw>
    <xmx:kjnqauPNZo2vXmslCVbKPV5jF37o3m3G3RkpkEMThV-QvRrtuXOOXw>
    <xmx:kjnqah9enWD8JMN1tw7Rz0VOqbG5mtQqd3wCQY-cJt0Ld4XXVLlJF6RD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 14:44:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <pull.2293.git.1793720007182.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Tue, 03 Nov 2026 15:33:27 +0000")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 11:44:16 -0800
Message-ID: <xmqqbj857l9r.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Here's what one of the tables looks like on an 80-character terminal
>     with a little bit of wrapping.
>     
>        ┌─────────────────────────┬───────────────────────┐
>        │Ignore all whitespace    │ git diff              │
>        │changes                  │ --ignore-all-space    │
>        ├─────────────────────────┼───────────────────────┤
>        │Show which individual    │ git diff --word-diff  │
>        │words changed instead of │                       │
>        │the whole line           │                       │
>        └─────────────────────────┴───────────────────────┘

Personally, I would not want to see these line-wrapped sentences in
tables, which makes it impossible to cut-and-paste.  But preferences
vary from person to person, of course, on these things.

> -Various ways to check your working tree::
> -+
> -------------
> -$ git diff            <1>
> -$ git diff --cached   <2>
> -$ git diff HEAD       <3>
> -$ git diff AUTO_MERGE <4>
> -------------
> -+
> -<1> Changes in the working tree not yet staged for the next commit.
> -<2> Changes between the index and your last commit; what you
> -    would be committing if you run `git commit` without `-a` option.
> -<3> Changes in the working tree since your last commit; what you
> -    would be committing if you run `git commit -a`
> -<4> Changes in the working tree you've made to resolve textual
> -    conflicts so far.
> ...
> +[cols="1,1"]
> +|===
> +|Show unstaged changes
> +|`git diff`
> +
> +|Show staged changes
> +|`git diff --staged`

Do not sneak this change into an unrelated "change the format to use
table to make it readable" topic.  Doing this change to just this
single example would be a severe regression.

Look at SYNOPSIS of "git help diff" and notice there is no mention
of "--staged".  The description on "--cached" explains it as a
synonym for it.  If we wanted to promote "--staged" (which I would
not personally support), we'd need to do matching changes to the
main part of the text.

> +|Show all changes since the latest commit
> +|`git diff HEAD`
> +|===

Yes, as you mentioned in the commentary, loss of AUTO_MERGE is a
regression.  I do not see a reason why you needed to drop it?  Is it
because some external limitation like you cannot have a table with
more than 3 rows or something?

Thanks.

