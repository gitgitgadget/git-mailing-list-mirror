Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793495233;
	b=2cIxG6dD47DgcaDZ9gyLU9c+POBH+2nr5r+9hz9mBRxqVV01IPSHF3oXkWT4YuzjSFP9
	 RR1cGIrwmY+oht/20eFt2GxZn+vo9eeyAyu8YB3l3Fv7FUg+YRuv2j0QhZSrnHnOQpA+j
	 71yxzfFNi0AJyTaZ/O33aNYxwdeGCXj/1Xv57vAVZvyyIcd0YsHu694sOQhR02Is/ERWL
	 RiT+NJuSQ9L8btgMIlUeIjMmHuh6d27U6ZIF6xvj58nfBqhEXJ0scn8BCvfIaTn7vDDJ3
	 8/D9kNc5G8fy6ZhfVzkiwjisbHyTmGMDh2B6ILQLGMbKgPT4ulHJS/F/0/ZsKFhhPRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793495233;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=I7cT0VVhrNUQpad2+jGXdSWEEfNkJTA7+KD7HOAUT6w=;
	b=q5dYngskDSTr5G4JcbeFI2PUMl1fmoBM5TvXoyd/OJ4p0tLbaJpPNX8UooW/ov5uxmIa
	 iwEIwsqyRV9Aqu1kcmkD/4dCTUe2lN3x3T4BoRkMZj3SUV36m+K4ZC47k1KjjlfuW+DdZ
	 9kYqBi/Rcab0k/zX8aX5VY72DunRZ5o8k6VtNV6GtC/Z2RujLSmsZzTOVt3GohNXJwIVE
	 I0eKPbvxRB2R12nMc6OMqNZxzuNYGJBpVaDRYxpX6c2KjgLyIHSoW5iUxxKjfEqdKqf7w
	 34MQHvtLxxF2qFMWYe686zf090BPWIwMFzf2YSNmpOPVZFdGuoJQ0RSOsVlbQwxONHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="iT9Nn/Bt";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="lVgkyn/G";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F1A606A31A
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 01:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2F1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=iT9Nn/Bt;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=lVgkyn/G
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 234C614001B0
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 21:07:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 31 Oct 2026 21:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793495232; x=1793581632; bh=I7cT0VVhrN
	UQpad2+jGXdSWEEfNkJTA7+KD7HOAUT6w=; b=iT9Nn/BtdeQPcNdIGxkkq4LF7w
	pC2A1/BDOEigIjbhdyNuRDqtAwf8ZmTFCnYhBLF3In4WlFspA8h3JIjRKVe7PkYb
	KbmSgy8fAJ8pbi4MAGlzizmjKp/m3iOpDC+3c6AWsI5Zc1UTp7/QGKBl0OCTIL0K
	90IRy6TXatykWD3TS5uUBk8w5PzF4Ukxe8+2OKAVko7w9UXV16BU+Y1jYnSCXNPZ
	R2qSkPko5hOdrO3v0ubmLKDmIO5D4eWQOeNJ6cdKOtPjhzGSWi73LabGo4B2WRyn
	kDhjK5ZaxdhwwNQfCilgJ+875/vOwKXf5kTM/CLvNoiTxg6TWsBrnkUSDp7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793495232; x=1793581632; bh=I7cT0VVhrNUQpad2+jGXdSWEEfNkJTA7+KD
	7HOAUT6w=; b=lVgkyn/GshS5NKZqF1TZ8KAxVlAeqgi9SRm2x65u1BK/amUIQQi
	TI9y73TAEh6B5ZEqHzM5Dc0uK6ijuHSS1i88+fj0fe249LOy0fif6/csjrOYfW/I
	ymGJbqAGMB+b+KxYpbBAk9Q3FTbDEuDeznUuwuETB6yQM7GIUWqd28N5dPdxhJIu
	IWeaGS+lGc+6GZWUBMMgB8SvLRTxDc/C14q1/rjCuktZyxbGf+5wji1jqU5MepBl
	oIgjW5Cda4pfN5iA8z5BQ+wwOyauvzSbEZLYu0TWIHLcGN7ll6dNv0ganACGE5ZS
	BXXPMhqdTHNfP65s4U+cqGqUxSYsuElCX9w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793495232; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HhJ9Ldxgf/xRwJxnRSxp5w7K6JylVw2/OtCXT//t6MrtGrv
	k1TREKUaBG+uo0K8qzdykTIqd1LQKfWq8CNT/T8KOA6G72LF5Y/I+B4Zi772A51H
	20zt4fNJra1YD/SeKUlsr9S1WM4Rmo/OcNpChl8aQxAUmfhA65XAxTyIJkrHrjdr
	EjE5h3SPXxfao3peywwHZ6Fp8D0zvM69V8EU1mQL1N8ke612mhEvxmkPOyxqdJxp
	eOQj5Akf11xDHoWxGr9XXuAHofq7MTfhXOLS0CuVu46X66d7GhUDYVhvm67TRn6j
	j4/XPeWCkvZmI7tc+Vx9G0Rg65rJYdsT2m+9BIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8gmZK7CF3t+XW3/ji5Uzwh+ZBlO30OgovLVz69Atr8E=:pTmjpZ4EQzC+GPo8OkIne790een268ofqiNZ8wASsoo=;
X-ME-Sender: <xms:v5DmaqsOsTWfuhnooZ7qaqVUAqOs1q-DCql-eSV7_q7DvAbZhb6J3w>
    <xme:v5DmamXHYdoJZLVUAMuQeDjXEZi8nduJIKRZjLpIU1r9jietFTVAuxHhRp_DEqYqA
    IIOVMH-PNnbdfpyQsB-pe10haX0nOe6IdKs0eDsefy7BvDIB3LkGc-i>
X-ME-Received: <xmr:v5DmauE29d630Mb25P0-MHYX8kh-VUlA0D51-aNR1PlvnxYFe3C47vKAdJjpCz6YvP2dsY9HC-mGOhQlviYYN9P5soR9Rnaqej7v>
X-ME-Proxy-Cause: dmFkZTEoiRtQDuOGJAzG3SINwROXCn6tnuSZXHX3SkF4Aov9LJVZF5ffJlqVZq4LiyAoGQ
    MPY6eh0trS2rxxNpRUCFV4/fheLPbbDbeuWGWbMV9+j2427NZ7xs/5jf8SMghgqpI4pIyu
    PFNwpXlTC0G9cYvINT5+4cnZzpUW/IokuOKRvYb+ScqnStdK7Pa5KqyDjYvm3/SggrVke3
    0tPG8AJa0KCHBqfJVMKb+CtKE6AIUyw8mJgq8V5uwtigg0cznATVptj3T4VSd1NLYRY54S
    Uahg3r1cPhbfWBvvadHvz2Pr6xnQmdYtVuBkvfVH6e+l83cgJnQd9AXgLJKhV5GIlT3llk
    UZwFJAyUUBky7BOnNGtAJ8iSCKavQeYqIsLDcfTN3j/7amnxpvVemPGRgzjjs69UbCGIM8
    u9n/NAelQdQPK96rKGkNrpwizTJqZdK8/qni2SZ9n+JKR7VJp7G306V7U7M01F7A3t8m0b
    jXG20aRQRkWo2Dqp51MaGM2BphQFKdEQ+LgzXrA16SihkIv8ewJjIuj08C9pEKM02PnUyQ
    gdi24O3H1hwlJgM/u5m0jmE/yL7LNevXVc6Uxg1OG0bcIWV/u1fU5lqOwvrrv002TM7q8w
    dBHC50KOA60JEXEYHC9kuIfLerhJWxRdXDN1xehBHR7XBHOAvEd6xiGDZleg
X-ME-Proxy: <xmx:v5Dmag2uw3h8cqETGv0Pcx-1YG82xQcfea30nvhDzezbYDeYtN09vQ>
    <xmx:v5DmaoOGwiga-szkJeQygcyXOwEZf_uvUzOy6gi10jluIurozJnNsg>
    <xmx:v5Dman5Rbb6yeaxB9yNRzkvQi0Orzz2tOAVZ7fjKVjRWG-sJVGNyDg>
    <xmx:v5Dmaq0uJAZ5sADFv8mITu6UaP2zuEcQ2dSx7Or9xeLTUma8igje6w>
    <xmx:wJDmauQuzTFxM_KAmrWkJ1zM_LNg462J2VibfJlkrmDkuFYjNVvTbqjB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Oct 2026 21:07:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Linus Torvalds <torvalds@kernel.org>,  <git@vger.kernel.org>,  Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] describe: count the distance correctly when commit
 dates are skewed
In-Reply-To: <20261031123149.yxap3%taahol@utu.fi> (Tuomas Ahola's message of
	"Sat, 31 Oct 2026 14:31:49 +0200")
References: <20261031065525.19883-2-torvalds@kernel.org>
	<20261031123149.yxap3%taahol@utu.fi>
Date: Sat, 31 Oct 2026 18:07:10 -0700
Message-ID: <xmqqa4nt2wch.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> Linus Torvalds <torvalds@kernel.org> wrote:
>
>> From: Linus Torvalds <torvalds@linux-foundation.org>
>> 
>> The current merge window for Linux v7.4 showed annoying behavior with
>> 'git describe', where it doesn't actually follow the documented intent
>> of the result: the commit distance is miscomputed when the commit dates
>> aren't entirely reliable.
>> 
>> This makes the 'git describe' output not match what the kernel
>> calculates in its localversion:
>> 
>> 	linux$ git describe && uname -r
>> 	v7.3-19342-g2a500a04d6f9
>> 	7.3.0-19059-g2a500a04d6f9
>> 
>> and the kernel calculation is correct, and 'git describe' is wrong. The
>> number that 'git describe' gives (19342) is nonsense.
>> 
>> The reason is that 'git describe' has walked the commit list past the
>> actual tagged release due to walking the commits purely in date order,
>> and is thus counting a few hundred commits that were already included in
>> Linux 7.3.
>> 
>> The fix is to take the commit generation number into account when
>> ordering the commits. That will still fail if the repository has no
>> commit graph, but it at least improves on the situation in the common
>> case. With that one-liner fix, 'git describe' gets the correct commit
>> distance on my kernel tree:
>> 
>> 	linux$ git describe && uname -r
>> 	v7.3-19059-g2a500a04d6f9
>> 	7.3.0-19059-g2a500a04d6f9
>> 
>> See also commit 1b600e659a ("Compute accurate distances in git-describe
>> before output.", 2007-01-27) which fixed a different issue in this same
>> area. Clearly the *intent* is that the distance number is actually the
>> real distance.
>> 
>> Also add a test-case for this. Thanks to Claude.
>> 
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>> ---
>> +test_expect_success 'setup: describe a tag dated before its parent' '
>> +	git init skew &&
>> +	(
>> +		cd skew &&
>> +		git config core.commitGraph true &&
>> +		test_commit --date "2020-01-01 18:00" base &&
>> +		test_commit --date "2020-01-01 18:01" o &&
>> +		test_commit --annotate --date "2020-01-01 17:01" T &&
>> +		git checkout -b side o &&
>> +		test_commit --date "2020-01-01 18:02" B &&
>> +		git checkout main &&
>> +		GIT_COMMITTER_DATE="2020-01-01 18:03" git merge --no-ff -m x side &&
>> +		git commit-graph write --reachable
>> +	)
>> +'
>
> Just a clueless rewrite of the above.  I had quite fun writing it, so why not
> to share... it works and might even offer some not-completely-bogus food for
> thought.
>
> 	git init skew &&
> 	(
> 		cd skew &&
> 		test_config core.commitGraph true &&

Doesn't this barf when it tries to register a clean-up action from
inside a subshell?

> 		test_commit base &&
> 		test_commit o &&
> 		test_tick=$(($test_tick - 3600)) &&
> 		test_commit --annotate T &&
> 		test_tick=$(($test_tick + 3600)) &&
> 		git checkout o &&
> 		test_commit B &&

Quite honestly, I do not see much value in this rewrite.  Explicit
dates and times from six years ago will eventually become distant
history, but at least they made it clear, even in the source code,
which event was recorded with what exact timestamp.  In the
original, it was much easier to tell which commit had a newer or
older timestamp than in the rewritten version.  Can you tell if the
annotated commit 'T' has a timestamp older by 3600, 3599, or 3601
seconds than the next commit 'B', just by looking at the sequence
above and without inspecting how 'test_commit --annotate' is
implemented?

Unless the focus of the test in question is "I do not really care
what time they record as long as they are reasonable and
reproducible from one run to the next", relying on $test_tick is
probably counterproductive.  The test for this fix, where the issue
is entirely about the relative ordering of timestamps on the
involved commits, is a prime example of where using explicit --date
options would make things much easier to understand.

> 		git checkout main &&
> 		test_merge x B &&
> 		git commit-graph write --reachable
> 	)
>
>> +
>> +check_describe -C skew "T-2-gHASH" HEAD
>> +
>>  test_expect_success 'setup misleading taggerdates' '
>>  	GIT_COMMITTER_DATE="2006-12-12 12:31" git tag -a -m "another tag" newer-tag-older-commit unique-file~1
>>  '
>> -- 
>> 2.56.0.237.g993442f913
>> 
