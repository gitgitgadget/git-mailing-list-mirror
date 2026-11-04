Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752448;
	b=ralVOEG58w8tCPvbAvITsizGTZyARP/GxxeLJf5y8HyV3DacpJTNhXoWnjQ3kYyghmq+
	 gqqyawVy/0Wpp6VAhJkfz6Z5xyOcsUke+v2kIKG37nD3gWFKyM8TLL/0F1PClMAdf6EYP
	 lGn6QKYBbzTueowGChCcKYm3XHNx3gk/Zs9qdb/H32XhBxIxWY9X5P8ronyHXb9mquisV
	 U3Uvsxk9k/y0NreRpg2lMTUNbvMJI20oDZeq+wcol3PQ6gxRJ2N+/OQtfmOlskJg0qKG2
	 s1heDNUbXT/T/sbPxhJaIMIZxrAheAsmGGYSu3g5QZ7uF0cwo1Ulq5G9nKWRFRwpf0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752448;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=HJNaxX2cOO/IE9t+0u7CI9b3BfRQl5jWYuqm3Vcn93E=;
	b=LUqsYzhH5EfeNs+2uVDVIJkVNbM7djR6ddzxPhUn7dW/q7et+5RS3oUf+Fn1KO+Lhfpv
	 uYnS5Q218dH2gEH9HazfH2f4fH4x1UCQ+Ub8x4cSfNiSWp23iSat5akTuf+jHq+EEuY3d
	 ZVGdD8qC4Dgoii3jpkqhJKAgU5c4iYjff717ZHc3MVNp8l1PMneR2UanJJXUQDbsEqU8J
	 NWDYB4TgZA1kX4PhleY/t8MAc1OUQWrGO/+hq4r309dUtdwj//aJlHsKgQGJ8eFLrKR/D
	 2jgRTUeW4R9cYqau/6YctwFdeyz8W9k4pgfXTIGqrVfVZXGUgGKbicGRydtC0P8MhBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZMavaT4X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I8GLywEe;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13353606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 00:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13353606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZMavaT4X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=I8GLywEe
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F0264EC012B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:34:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 03 Nov 2026 19:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793752446; x=1793838846; bh=HJNaxX2cOO
	/IE9t+0u7CI9b3BfRQl5jWYuqm3Vcn93E=; b=ZMavaT4XRQL1hNlcckyP1vKvaz
	6ADWaDAs2+cPhuYDvwVtUAece87kCzwfTFsrOADBE2/GLKbgmgaIwulvmXVKnZrb
	CPdg51ZaYHBLyxHODFcGEukQrV0L6MJF7xlgMSuQujLEz1WkYPSHpnIT35rF8LXr
	TMRFAw7S13N08+ge5t2fL1IXT5Xu7zhwBnOm0lwh5z2R5ogZOCXGjThZ/d2tzuV6
	+GLlP8MB92sQre2AB3ZuUWGH3Z0vXBdX4AF1QC0CgcMCMA8hzwUA9akhX/L/uHj1
	+BBaxmR+UyPLcBn5EK6BToidVQbK8Za8XtYTfmJNd1maeEhLR4P35pPnPf7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793752446; x=1793838846; bh=HJNaxX2cOO/IE9t+0u7CI9b3BfRQl5jWYuq
	m3Vcn93E=; b=I8GLywEeUSjY1muGHP7+XRI+0p12w4YvIemaqnFSPUcYlkudC93
	2gH0D1a0m9yNPy8fgvQEMkcoXl1S3UVqYNrB2dAdWGkW+gJOdJ2AD3Q3ipG8tVTz
	/nC/JN97s013rpH2X2yBjBlriguosmG+ZtpkxtBcurQzwzjIQvyO/IRdB6FqPnAt
	vLMmjwxE58XVSFRf4NR8lzwHTo9HrhvrxxD7XTJoOZzEXEWuxXfu4zmyVcLsQmch
	2OuNJpPpwmT566JjGYniRYCxgypITZt8gYySL5O/NhReOPL11XrBL39h9M1cPgkz
	00BEmYDXSRqFnZY69lFye0Dx1g2fgRPiI7g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793752446; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aTmSRGUHeb6aiNn/D50wzqCmW+H32Tr/aXpHouvVSm24Y3Y
	Uau4Z/6kQpLmoDJ0280EYQrJMuW6Z2nfk6l17y0k9+upfBusx+YNf5g8jGsbfrmd
	0/pMEmbIJv/qwYpODQM9vrzBLIfnEa7LKN4dOd+Kfpp/eKfyePhk0KFSB5jPADj8
	ZiqFI50ITTG40BDz2wt+FUxhmvn8anWeLi5M3zVZYXMuxsaL/ro7tqIhOiPOjDtF
	Gj//lIZQo3WHLv90DT/9Zpu2Ws0vA29RTXAPRecfC0ZbGgiCzogU26cyPWrAN8lw
	6waCPB4fA7qD0SKyLNw/VzExs+uEn9ZHsHmXTBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:2ydADePvF3vQ4pD2KFg/PxZcLfSlQZvv7ZzRLiY2n/A=:PWI0h7N5SVs+eg0cr9xgmpiqEuv6grnBBoOEX/atlTQ=;
X-ME-Sender: <xms:fn3qaoNmwfLbPsvd4-iZt3uAzHK6B7smgqibHMLmH-cFW5n1Ej4o5Q>
    <xme:fn3qal8YZZxA_artPHmEJe5_7xuvjZBZBUPT3Qo6wlc54QyRkUQ39j-A-3QfMH-qw
    2zWpc_P8aooL3uVQs50nZiyKGEF8IGWwv0uYVHKU7AiNQ9hQHee7g>
X-ME-Received: <xmr:fn3qakTIbrIAui3OGz5vae57Vcyn-y9zWQQu6SZk-6Gc2w431q1WITAaKw2Bs8i88obHaReMiAugWxU_hGQ3YdMeHmHG6ESUN99d>
X-ME-Proxy-Cause: dmFkZTEMLxnVDJBb1gkNjVzCFm++6Kelk8Xk0/NDhk72mttKuoq7aZzKYYEhIUfP6I/Zku
    SmxFBgqdrdH9l9oLByVKLoOEYCTzGe4mEOqZIgPvZ1CmJkB716wBREJjQNPNI/7BTX2a/P
    1/YjvDmg+z+xmJ8j6DuU1E1huPSSEdZfN0gh/vvNl3QPEpkrysXxcprbJP4EI+//pmE5BZ
    Ck8gA2P8wusvqwaKdK49xIf6uzv9KdrkfiEJXb0eNt0xSpzpd9/CNeTWanNzeQrOrKTfSv
    pvHLl5pzZeuN7MIi8evXIpXBKB7PsQbdUBbS3SGm5Esu5JMlD8pq58JvMtszM0sEtxnlpE
    7xFibOB1lSsPtFNtWqpVmPGUvZaUj5/SoHQAoHAxN4HMIomHTjOWIiAYWg+kImdUY7yliC
    ajKpu+TzVEkyRmwpodrCnelkFEpj2D2KASlWGt0jfBXglsYK0qkSokf7NEg32QQI/aDtNC
    C69wetLL1sDpuDLSsNv7fzi2Zz80K7kVemlD3Hc5B1d4J9AklOXNPwgcv2o5REDuppzn5F
    opKMESYyF3NNYJoFxOlgAatLWGbZlf1QiHR4AzcxnGpSPAVl6B/Z30zzPOBUIJR7WDGlve
    O/lcsbHKGJzNNjpn69FPofWSrTu77Pb/xaSC2GcDju4a3u+JdIo9U3+4aoJA
X-ME-Proxy: <xmx:fn3qavlq6PAByBtzGYW55pgCP0I2dq5g3v9wdfl8wAtjuXZpoCmiyA>
    <xmx:fn3qasR33ptsw1BPEF4ps7buKWY6Fwkj-rnUp-9HkRkhH78ijP8qRg>
    <xmx:fn3qalNkmexCMksfyej8GVgdOkXgurQct0fqfVD3tFsHvQccmm_Xog>
    <xmx:fn3qatVc4YtefPTWinIwJ4qVVqmvOi0LCxS5Kjgi2YVc8DqW1R5xkw>
    <xmx:fn3qagOqNNm3OftJShkvDesPP1WltJa3GSAl0hW-2SqQl1XCjubIea4r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 19:34:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  git@vger.kernel.org
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
In-Reply-To: <aumKXUS7_x0i7ZU1@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Nov 2026 08:16:45 +0100")
References: <20261031065525.19883-2-torvalds@kernel.org>
	<auiGP4XhObUzC9vD@pks.im>
	<CAHk-=wijLfduoJyOM+AW6FS6c02cuEFRAuQWLE+uf7SGhj8jXA@mail.gmail.com>
	<aumKXUS7_x0i7ZU1@pks.im>
Date: Tue, 03 Nov 2026 16:34:04 -0800
Message-ID: <xmqq5wyd4epv.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

>> I suspect that is just *way* too expensive in the bad case, but I
>> would hope/assume that any big repo already has generation numbers in
>> it, so maybe it doesn't matter.
>
> We nowadays generate commit graphs by default, yes. So usually
> repositories should have one, but there will of course be outliers where
> they don't exist because of whatever reason.

FWIW, one (out of two) tests that are expected to fail in
t6120-describe.sh started failing in the feature-testbed CI job
started failing.  I think GIT_TEST_COMMIT_GRAPH is the culprit.

> An alternative that might be worth considering here is to instead make
> users opt-out with "--no-exact", and then make that discoverable by
> emitting a warning in the case where we don't have a commit graph in the
> repository.

That would work as an escape hatch.  Sounds like a good plan.
