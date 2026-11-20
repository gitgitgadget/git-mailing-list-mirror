Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156097;
	b=jwzgp51DQRwtlVjlxGplk8YLq57vljQNNRkhwFSMytSz11XK0byZjziltAB+YzmBe9CH
	 syTp0fyov5e1L1+vKcW9PMf0WFKHlZmot7OZ7kLzJZRmURVzYFJr+MvQfSsxZPu455Ig0
	 ZBFNN/d/CVrHQxNo6AN6s2sUDCwjcrvzIpp+tKDtCA3lQEeAEcSSeNxeYlNCuf1YktRvJ
	 vygec965Tg9NFSx3p26kbU3YSAqudMhsK7G8XpyfCIHDEiOvH/fvyGwUkLpKhARSbXjxU
	 7kwET60Wsha5Vr/hrGqe8YxSx9tU0lKWGg3QXWHAdOroRrbFbEXrS9MlWtkYtopljyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156097;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=hRW/zW2RuDKZ/yPsd6DNGKcT2aECzI/n6DVwGzJCvG0=;
	b=GjKZwn+ieetE0YWBeujJwf0SkcYjjDte42BQxcqSHWvrIYAE2SqDytEVkhE92xMp+Esx
	 VSMxF1KD/o5MyFhGnw339qCdDMOBznR8E+de14EWo/UVXN6zbTEAyxJXo7t4nx0oatKUs
	 bkXRGco5M/9VcefrxFTP9x9djWnBfJKJAbVg825GUOiTLh55Y3VACN7u6q4z2kCukbXB5
	 27RzvdYBgnYJo2aBzZbE9wUxP2BRLFDMN/wjMaI9m8NeFdIuYWNbn/du0YvrptEsCCDgS
	 hTRYu6QcrQkAS4067JXK594iDQIxI2mpY1RnRnTT10xIzLkVmh5diGKUTKwaXnzu22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f4zot3DA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bUOsbpVZ;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190C5606A32A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 190C5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=f4zot3DA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bUOsbpVZ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 460FC14001A2
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 01:28:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 20 Nov 2026 01:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795156095; x=1795242495; bh=hRW/zW2RuD
	KZ/yPsd6DNGKcT2aECzI/n6DVwGzJCvG0=; b=f4zot3DAkUhlIFvDYBwoZHLjEP
	l9TqqRme/8mKBcpJZQxN5ZB2WWIz83D+mWzNlV0Xz+9aliR9X/C5ZOSFG36Yp54w
	0MjFzQrceAB6VkFr3V5aFVyKd5peiuT5Jm3TL97k3gVCBvI4QO0kiXhD4xgRLGSY
	4RlJwCJNSptbbROwgHY0vRSVcVKrO79pLATlVZaz/1fgncTFgsvPu+biF+Ur84jp
	VeMklcaWgEulECA2qzkakXOZuM1++ikaA7pXCM5t4RSIqsUOA0KRcJh7h57U41wX
	iofM6Skh7tZd0Vr4njSZ9mPs1t8S5aTK5fbxT71SCxtoKPCs5CEhukIBVUtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795156095; x=1795242495; bh=hRW/zW2RuDKZ/yPsd6DNGKcT2aECzI/n6DV
	wGzJCvG0=; b=bUOsbpVZnabX8725H20dljtDqbDFLIQar1gwLYOHl73nVS1zGMv
	T0aT3coDpfFTPZihAHehCC8n7OWIBF6HDi0khyaV9W7/Gl8RIDodPnMrKnb4A48V
	oDp9XtwqfYk4vPD1lptVJOnmaOxtw8XpI8RNNEmWg4bwqlrytMQuVdBFnmSj3zne
	utKyzXRKZEv19xpd51EEwNVmBOomLKy54nx4pIouqS/4DuktZ7fho+kGHlsRxkf4
	4Zfn5jpLUtgbGbRWSl9OcyW6cGCCMI/xkWr+q+zUX4janXfK7V1P5faIQwHPuobO
	OIPGdXIcA20TDHod7GycNiVFLCbSguizLnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795156095; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dPg1qXdkfWckBnIfne4KK+acq+p6ZbKGnF6xnwXL+kK0nbV
	DOrlOh+Ytu/x3bIMoe04K363eRvhb6c0EM2PwHQLBEi267Gs3kiC2G4N7Gup8Biy
	bucqRRputxR3/hA+AFk7s2vD+BOqeBcDh8F015HB40AIVxDWm/TnncnyvzHYyLwU
	Plf9Q+fGQ15sJQHOqANwIf4jWoj/Pa4a/thKvjBosRc+0e0Q//oY2lSDWrxwt9Wz
	DbW7bIomalB2WsgPbp6xYCuHuQkSwxWm9G8KLkeNuGnr5GaUE/TLlfsSkrxOjClj
	q+uieuJLngwYqtbAome7v7vWkTMMj/KbpNcqw2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5JaWmxn8Y9hNkjeUZcjO5rTikftbdCF7VNSjl/CYEQk=:OH9mFWS/XXCkxuDJswM3z0QIblYD2y6yFmcpJNKEY00=;
X-ME-Sender: <xms:f-j_akYoHcareJOGyehPIOoKhlcQ4w9lrHuI677VFIh83N6npTX-UA>
    <xme:f-j_ambKT8QCVSd3_QxCzxO8YfkwXDpEYMiTV6dbret1lxvO0zvCzfX65MrLn0x70
    YxXJmihz9OtXnjtKw2vMKvh311L1tOa0pgzP7HSSivqqlVRPA0KNQo>
X-ME-Received: <xmr:f-j_aj_fwr3mczeAQ1hXSqTQG7h5m95p1X_bSDmRMtjHQUTbA77dKfNdyKgDzeUBQ9VRPlr3Y8iUUbXmtjSRHp5wr0bUWkABh4Lo>
X-ME-Proxy-Cause: dmFkZTGsitkkMUQrMppZj9X9ZoPUlIBRjGPW7o7VLNpEoFoZ+dQuG4A23spImlkNCNBylM
    VdKiuDJbGWr/HhzKU96FczrXNBFWdAVnycgfZ72+o+ffCY1Np7sP6CODop6k/HZeZWoGl6
    35Z08OrkKokjg8URjNYr/FzlskYfXTxFXEpZJHXqsQpM+m5YcMmpdnrU4iqS7Op3XgvPby
    iWH0gGNma4+VI2nAJQQ2b4qvsY92bPO4kkYsPB/iU4vLIff6lxzThgwJCHQuYCPAS+BJdh
    DtvJT++YViaKUrS8bFz3RcsoJ/xArKgNYjFRuiG2T9WHBXBlYS6kNfzdc0qCkPE/DLr6mF
    E6j9ya1X96Al4aOPjdgrfxgiQDvZ0mSDtTORG8XXbn0B3L5FBH24rBYHNZETd/w3wEueyI
    9swwr7jj7v/YrJuN1JdvrIXnY69B068BvI4A9FDsktUefThy1HM/J5CdAvI/AwDGBjNfxQ
    hymptrJdFgj9MntdURqlpaxwkZJyn00njowIyCXVLXK9ye50mjPNwImvinRQkjri4kSt6J
    mId09hHYLBKyvHbkwCl3SHni81wzLhqgtR6+g1d5puClDFk1O9PBNQp4UMo+BMiktQAJky
    ODkvE85nxJhZhrFZahl8Y+iIjvK3b1ZsAccbOmMIqtMxUP8SwcNYIYOyoG9g
X-ME-Proxy: <xmx:f-j_ati1vyl3H7HY36Yv3_bA75tFX_vGhcrqg3YOhEa8_meyD9lW0Q>
    <xmx:f-j_areyYaRyDUwtl1ZMcvCxDJLCF2DOD6CWPnP3jd8TfUuTVsHD8A>
    <xmx:f-j_asrPc4UdaKO-yQYGj8KXzfYRoP_Nq4MIL0SiGWH5CPZ9GkSsdw>
    <xmx:f-j_aoAIIiGbzbsU9gXLWua89Jv8v91rAh36vq8w6FXR2pLADsAndg>
    <xmx:f-j_ajfqXlCCvKJ05TECVCCxY_HbVJP1K_mHqhZq1JT-ZU-FnFXQUcNf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 01:28:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
In-Reply-To: <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
	(Kaartic Sivaraam's message of "Thu, 19 Nov 2026 22:59:15 +0530")
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
	<20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
Date: Thu, 19 Nov 2026 22:28:13 -0800
Message-ID: <xmqqpkw0rp8i.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Recently, we've acquired quite a few expensive tests in our test suite.
> For instance, these commits add several tests that require
> multi-gigabytes of memory:
>
>   - 9048b48fb (t1600-index: add expensive tests for over-long
>     tree paths, 2026-10-16) added tests to t1600

No such commit X-<.  Perhaps 89048b48fb (t1600-index: add expensive
tests for over-long tree paths, 2026-10-16).

>   - 288266c11d (xdiff: use size_t for merge buffer size computations,
>     2026-10-16) added tests to t4300
>
>   - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
>     2026-03-25), added tests to t4141

Inconsistent use of "," after the (close parentheses).

> +# EXPENSIVE tests may need many gigabytes of memory or disk, so two of
> +# them running at the same time can exhaust the machine.
> +#
> +# Allow only one at a time across all test scripts that share
> +# this TEST_OUTPUT_DIRECTORY.
> +expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
> +have_expensive_lock_=
> +
> +acquire_expensive_lock_ () {
> +	local owner waited=
> +	mkdir -p "$TEST_RESULTS_DIR" || return 1
> +	while ! mkdir "$expensive_lock_" 2>/dev/null
> +	do
> +		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
> +		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
> +		then
> +			# The holder was killed without releasing the lock.
> +			rm -rf "$expensive_lock_"
> +			continue
> +		fi
> +		if test -z "$waited"
> +		then
> +			say >&3 "waiting for another EXPENSIVE test to finish"
> +			waited=t
> +		fi
> +		sleep 1
> +	done
> +	echo $$ >"$expensive_lock_/pid"
> +	have_expensive_lock_=t
> +}

Hmph, is the above safe when multiple processes are working with
expensive tests during normal (i.e., not involving SIGKILL)
operation, or does it still have TOCTOU race on the lock file?

 * T1 holds $expensive_lock_, finishes its last EXPENSIVE test,
   calls release_expensive_lock_ (rm -rf "$expensive_lock_"), and
   exits.

 * Waiter T2 read owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
   (obtaining T1's PID) just before T1 removed the directory.

 * Waiter T3 runs mkdir "$expensive_lock_", succeeds, writes T3's
   PID to pid, and begins its EXPENSIVE test.

 * T2 now checks test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
   against T1's exited PID, finds that T1 is gone, runs rm -rf
   "$expensive_lock_", which deletes T3's active lock.  It loops,
   succeeds on mkdir "$expensive_lock_", and runs its EXPENSIVE test
   concurrently with T3.

Also, between the time you successfully mkdir the lock directory and
the time you leave this function, you can be killed by a signal with
INT, TERM, or HUP, for which t/test-lib.sh installs a hander to call
exit, and there is a "trap die EXIT".

You may manage to create $expensive_lock_ directory, open pid file
for writing, and then get killed before you echo $$ to the pid file
or assign 't' to have_expensive_lock_ variable.

When your die handler calls release_expensive_lock_, you would leave
with the directory behind and exit.  You may not have pid file, or
the pid file may be empty.  The waiting processes will not run the
kill -0 "$owner" part (because they do not know who you are that held
the lock and left before writing $$ in pid), the waiters will wait
for the mkdir to successfully create the directory that already
exists and nobody will ever remove, no?

Between the TOCTOU race allowing multiple processes entering the
expensive region and deadlocking denying everybody from entering the
expensive region, the latter is far worse, of course.

> +release_expensive_lock_ () {
> +	test -n "$have_expensive_lock_" || return 0
> +	rm -rf "$expensive_lock_"
> +	have_expensive_lock_=
> +}
