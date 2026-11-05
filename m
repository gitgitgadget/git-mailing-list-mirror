Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897223;
	b=FCuaDbHhFU7Lfd68cw+dKNryDquZBU5HXfTEtD0lfyWqLMMaJahP32RwX2ozvfo0y/6J
	 7sXrZzCMuAScq+J/tWC7F5yS3a7VdoeXDk0rtL0sYv+oy0H85kUIbQkWLU0q5AeTue0zY
	 rDf8lnQ2a/Ln850c1WIRMfPvk3fZ1HsqxTxVcHixPHmEqevgNPqh8meY1emSK9h6EhKEW
	 3xec8S8elGg7++6ovoIkKlVAz20KG7fMuzYDYv7PA9+nX7bQt1ejdogdozJI4Qfz0bqkg
	 S1vkr3S29z4MZ4lC2o+QWKvq3MCgyy982qf0SLwYa3cpRL3TTO0Yp7j8sHcASHYabDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897223;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/1F/nQ5xYgevqi1vpIcrewBa6laJPhHv4fOEtmKlnf0=;
	b=uFjq41cClbg2It1ugLCQGJw9l7lV1OGZm0ukvS9xPjNy1EVvRI4fYF1pR+pR7Aeo179/
	 fYx4UqymxKdrUwR2QsdURayNdM+6PuygsSeXr8rUB9gBKDjT65rdMVuSg/hCHpKiSm3uv
	 nAZp9LzJl85uk7DmKeBGWqd4n/4lVU15hlp8XOHo3w/eGRP8AITxT+63IJySiLlNzzwx5
	 yU22HUQpU2oPqXfy0aALY2hegigOgbeTavNC4ak4o6Nyl+d+YejIC+WWEJmRMOqcrGagS
	 PoZ942E1CgOVC+YqxKhk1Dn7iTdG1N9zHIAfjLBEsmdIpZyWu3S5NCIUkHtDBwIamYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GoPr57+d;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EzbXKCft;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D212606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D212606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GoPr57+d;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EzbXKCft
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A43AD14000B7
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 11:47:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 05 Nov 2026 11:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793897221; x=1793983621; bh=/1F/nQ5xYg
	evqi1vpIcrewBa6laJPhHv4fOEtmKlnf0=; b=GoPr57+dXQMU8wYyFkMgYAObZA
	30dX3gzAHh0uYMJlW40jwihQs8FBzgO7zqRS+ThX6S8SBEMA+G5LE/fJ56IVIKSq
	3h1eRZOkupWL5TEBemHcA5msMPgfs5PqF2tM9VJuow0O6dZ7Nw8yRdajoTmclepL
	TzzjgODmlQQFzlhERQHn+zmfPyExGy5WTzWIYXaEGEKecSVcttBBgteVBjrq6pXB
	uoP4QfDfJk+S7QOVyNHYSuEN0oL9E6UH9zjZfc+hsxUiFSP0BPu+PLMP4Y7fy5yp
	ugdcajSVVWONQ2NnPVzI9mW2BwGHdE6c2nscpLKhYt+4IfSipTb5vBaBhViA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793897221; x=1793983621; bh=/1F/nQ5xYgevqi1vpIcrewBa6laJPhHv4fO
	EtmKlnf0=; b=EzbXKCftDJ6OAO1aOFekG/KnLSi8N8yIQ6MKhzm8irbiQluk0CN
	hDOrRWCGA5BaBeMNZALlH8V6S/J1NJVHpHrd31+mAkU/wc7CfHOdL7GWLDDbvuns
	xqhgg3JL4YNw4o9g3rjhctJEYoNh+AXUzz9PRdNcummuvIEyh1DqIAphJQbTRZ0i
	Nar6wWHV/CMcnpZIL5nI11O50dq1f3tpIZcyRFpl13V8WPhvBoNY/c5Hdcg8RaP3
	ByNnSAzHRZ3PcnZEg8Bg5N+3KpqROznlQ9WA5kVjUXScq6CYBTpL8tY7LzANac54
	FCOf+9cjB8/jHFzUVfbpvTiUweBles+Jd0A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793897221; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:i0i2vv8l0FC3s5+jpm2wsGJ8rN93HrdnvRQG5ZwBBFBh3UG
	1oG1BrnbE+anszNpjOeEmwgzMNslmczAZDqDjOl4ICtvpMYXiipSZHVJ0cGpSJR4
	w9PvVzsoVIZDro3mw8GDvMgLbDJkKfgo915627YMy+idjOspPzbA9MYqEHAbf+/+
	pBNW8jd1Qbm8TWpR22EifsKln0u1lpS469bXKuMdiRZ1d7wGeU/D1zKAnRzHFgxG
	WSjI0rx0AzSjfi11ZsHoWeH+eY9M0U88F9AAapPj5GTDPfbBil/TWaOF830nTfwb
	Ku9aKgNRbKSXn4bzf0vjUiUBE0fcZWBdWw5/rdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3VJdtSkSWCj2IGVFDslZZY8dYpOa5RJt8k63VCnGcHI=:5oYX30sbW3TOMuzFFlmIMuJyv6xbYSr0mfXN3cwh5Iw=;
X-ME-Sender: <xms:BbPsasaAkIYKevaxf2OB6U1SepetjQkqOUlctwfrWjbssDBeBsFZuA>
    <xme:BbPsauSe7aSD5mOYlZVefoqw1H2Me7RO3oZtPGal2HU5Wdq8e3W8wFvC06NyEQaHc
    jER8VRYBUknSKOtrKaWrudqy85dztRQm5fzt0Xkb0WTOUbsoldXAA>
X-ME-Received: <xmr:BbPsavQRMIvUhMt04-3MkAuTdzaPrnevOU0BwDKW9XaSdqBSecORbAEsta--iShi8ZUQztPlf1eSXw9PJSCoPEDv9Ozz8kudI5wk>
X-ME-Proxy-Cause: dmFkZTGPZGPCOcr9Z6cIVKbgUh9Yhhfm7RQ5GAEGql+Huac6PCZpBHWkUUMHqIGI6NPMxM
    KE5pIkD2GfNj6AFmI3Z3Jhkob7a7taC8C+oONMD4q/fWcvwgSW3KwgE+uiyaHNHHjWwaq8
    E4hWHEUWP2T9/KM/DE2rcO9HMK6UXe5a4btXkmPn8ZedgVM0hbr3NEWkOmnz8YV3YR20Bt
    EIhDaFYhKUSYbk44ji+xVBKbzwpg5QVRWNxO0fVQHYggXDZyp5ElUOY/AjGNDmumahVWm8
    EqSoQJUzF0iCl1LQIyeZiKnw8GhDqxfKcS6oas9snOKjEtu+aOQB3ndc41/OzUx5CXaZWc
    h2bF6xaY+JO98U9ZfhSv/PFRZ/qCz0brfl+Iqs74hQPyLgtdLK6MeLRhFUfc9kQs+UButI
    zghlBpdlKgUEc6t2qUdUYjacHSZCQ+nLvawMNuwV7mPDYNsShgyDBj3Pq+I10y+Vf+TXOt
    kKScuTnbMhYZbt7JDppCr+74hBHbnkfS31IM8tki7NyPzksleUzVOEary8QOqeil3KputM
    4tkfc67mEVfNHXDGgQPD+/s8qsuTefJgGibWR7s2EDX34jGhF5WJQgRkPLbF0qTXXpsSUb
    dRshbevdmDous2OsmwzH9oiLxBIDFCOVBYJ0LZAddLc4U2CwjM24Wrx6NczA
X-ME-Proxy: <xmx:BbPsaiQHKh68IaOSzOmYhAtPsFKEfOuXgUSgYKbIXkjwz2ib7V18qg>
    <xmx:BbPsak4flZyRXndyLSFWm5VjvIELcO9lzKsQoR9CLPQJ3Czyo1sqLg>
    <xmx:BbPsau3BgilcwO4YY4SkAYWxcJ0GG6tc-iap9dsZ-aKzw-4b5ZxqbQ>
    <xmx:BbPsavDHnMlrnPwbpiHYTCSTxsaTZRTpls95r-NH2vREpr4S9lVW2g>
    <xmx:BbPsalg-xynjbH46XBcYhIDV6bBZVLDlQcNgeVWVS15BwCz8LgIRJItw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 11:47:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Thu, 05 Nov 2026 15:40:17 +0000")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
Date: Thu, 05 Nov 2026 08:46:59 -0800
Message-ID: <xmqq33tfxm2k.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      +-git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
>      ++git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]

This goes against what you said earlier, which was

> - Mention both `git diff --staged` and `git diff --cached`, because
>   "staged" is the term the Git user interface uses and several users
>   said they find it easier to understand. Add an entry for --staged
>   saying that it's a synonym. Like with `git switch`, and `git checkout`
>   it's useful to leave the older version for folks who are used to using
>   `git diff --cached` since we've seen that many people who are used to
>   using a command don't see any value in changing how they use it.

Perhaps (--cached|--staged) or have two lines (i.e., turn the range
diff into

>      + git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
>      ++git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]

or something).

>      +@@ Documentation/git-diff.adoc: files on disk.
>      + 	do not give _<commit>_, it defaults to `HEAD`.
>      + 	If `HEAD` does not exist (e.g. unborn branches) and
>      + 	_<commit>_ is not given, it shows all staged changes.
>      +-	`--staged` is a synonym of `--cached`.
>      ++	`--cached` is a synonym of `--staged`.

And this is the other way around.

Other than that, the rest, including the resurrection of AUTO_MERGE,
looked OK.
