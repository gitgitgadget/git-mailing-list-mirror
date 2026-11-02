Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623623;
	b=Ed9NwnjYermXt1qVsXvcFdsxzae8Ilzcy08B1n1YbWzGh0b1g244gJqNZ39LQ2129LRA
	 6j64Gh0kzqj0JKjGT+Us8EYd0jYncXT2M2Q6riSV8X8jEGqJWJJPbyOYDmlf0odT5w4Y+
	 ClOffrWzUX/0+q2+KWMTCpnCIEkfSRdtCieQDLqzq1Jtd+ZkJpH4bw2QzmcRLiF0Xex2Y
	 dcBDv/6wSLytbnUaX1hmwg5wIEUJjej7zxYD868xDPlzjtFVezc0f+7izuOqB+5FvxmAU
	 wgvmANOlrsI49yRmFjAMFf9uXO/oPY5rWvu2nR28E01/6tadyXIbjTW2yeFuc+eglqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623623;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zhco/Ox4Y5giTkaZNxwPPlw3N3iAMAsZ/2K+obc7L5c=;
	b=WFlWGjungPImCN2XOexvQDak/E6O6WCw1ZbGkTQLTSMzzQc/06jUjfd0KkYsB72EQXaf
	 oRF3npAVf94sER3OrT+rrisdW3T6bvNXxTbr4NWsTlD5wYhvA3CAFrpMJv66lJho7zy+f
	 ovjAZIRO6qzbIYS/Y8M4EUcpCCrYo1gmpN+zu+9ZRx1PuqPw0qiwBpUdbqiqiD3sIJiUY
	 l9GvGoYfbwy/vbn4nOF6MGuTGfa0z9l7+W+Wc0gQDS+oYy2wJ+Na+HWDJKEvqxoRcqIlA
	 Cdmz7GPCpTCtsbP9yWPRBzemlR4gIyHQ+JLIEYiXWMfq/t5MbPyfn1CwrhQ+5Azge5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OyccmHj4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dakEvb3r;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1495606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 12:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1495606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=OyccmHj4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dakEvb3r
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2B207A012B
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 07:47:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 07:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793623621; x=1793710021; bh=zhco/Ox4Y5
	giTkaZNxwPPlw3N3iAMAsZ/2K+obc7L5c=; b=OyccmHj4UACROvONloPiAcT9+r
	sRzsxXM0e+WhrnUEsA1ZsH6vgUZwqpfynWP/CgH0QY4SgFt0avVzTSbQUpU/qnse
	sv9NTRBYLtu+zSRM/UMH5WitVpSFZYH7uwmoLRKBpL8zmIuUtNyVOsb2u6lDaxoA
	ceqyn/b8tR/mtqq66yCjdnc2Ct1G4YPNTkYOO0jNFS5VFaH8kqxp4nBP7p1diQKV
	Ny0pAV0D4GRxxonU6pYPu3SW5pYgrB1gYy4ucOegnYKkdXyHxOA7DBmi/UJrLM93
	rT/eU72wnzpfGcZ0UdVLtbDFtg2ZD+wtjUosU8eFgBJWjH3QRDoG3hxo0mcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793623621; x=1793710021; bh=zhco/Ox4Y5giTkaZNxwPPlw3N3iAMAsZ/2K
	+obc7L5c=; b=dakEvb3rWZnHPJqr8ulUtOgFfHSQh+Dg26VfzgdtsZw5a/EA1Zq
	h6MnILLhtTxeQMGgFQoWVUxy66ilb5SuvIXPhgDawBiBqdV7gf3VYHSf81/v0coK
	fQ2ZAarqZIVh/IqJoQXTaBAPor+X3hZXDxR7WR6RpepKlIxGmfZIC0HuDMf2b3+y
	gK08sMMMV4pvVJCHQms+0OjmT3foXAe/U3nhRG6jEmKlR784P+mFtKz0hVFxvCIi
	kCuQxqABoajAAFBURnUWy0JcIwLt2NwDyj9IzfBB89atfFIZ7dcMse6Fpuhmm1u/
	V1PshAeyx27lLn5RxxH+wKXgI9oPe0euKow==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793623621; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VttLRN9cBZdNBBFJLLfGvehFyoCYn/5e/rvhrJwSlGgNt2B
	UumFVB3R5uKZVTh2/9VlAOcHfm3NcvWRaRIInmaWrhITc0pgax8v5S5QVUiA112K
	Wp2sO3wn31e2mVYNgPbUFNa1K/VXXD6pMP3M22m7LmTEHUzTK+4ITp+GC9tdBr0R
	TzfgIaa356IRBNSf8+oWatkfkYgvNg/vzBU9CQhnXh3Hh83f7zpfvGsL5ImyBY9I
	R29FGHomuXYRoJfptpR1p5QB5xcBqn+dX/TV1jVKH9osgIUorcqTzhI5PH5eWnRt
	EKUIIPsb6TS8HgNhlfA9gYMyMFUfWCHkCPoK9Cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sI2m+sqeiVcOE5UAwCVrtfbK24NDIrv8ocRNlv6YgXY=:mU4TujCtFwRpO8mNB74XhjQ1Y4ck+3NC7PVvdubBLJw=;
X-ME-Sender: <xms:RYboaqE24vyj2Vx59t3_wmnOCLY_dvPoYDcLMpqz8GNVVk_uPSnDWw>
    <xme:RYboaiWpAEe87BRXe6UiQ0m3HUKSFejPRPDLBnhkguGV6P0l8l1PNOEdXuNVhubhA
    RqbN6ZxFC7eFtBK52JbfHWjNrZjcNzQ0mK_S-B2JL8Fpdsq1VQvtDM>
X-ME-Received: <xmr:RYboapJQRUWn0gXbfLLoNeipH3nXwHr4_1BwXk-fHuPig8CzMmOdtXth78cZkbgyOgKQ6Q>
X-ME-Proxy-Cause: dmFkZTE2WQBavtO8S9QaRBMIb3muJ7TW6e2vNATgGRfv3gVpw8g2uI3O2Ch1y2CQqj51C3
    sZjmFkt0XYaQGu2uJBdBj6UP2bKMiZYpn02I+IsTvciL67vDVn3oBSFWvUDQev3VD0EXHc
    fb15flJb2PMwYYz9LoU0bpR7r2GzzJ9ziQ0aPbR09rvARJMmEQ55y2HKJL9bANN2TLNfws
    D9EX3TzWJIVSLaUaIeXoPKJw1L+NnX5ILjm1y5JfMCk08jRORpiiCDUHszkfjjeKPlXlcx
    DzBWnJsx6D7vM7P2N5UqS6E9GbW5jbM1PFxg1WRsXsU6GwvzkeUVdy7NmFzIGeD0Z0ntOu
    T8LFbnnUiGtraJ7+iOAs4nYO96C6TOE9GfTDap++BtDz9+bO+HF4x6nMJqjvdRJsR4Vjyo
    nc1j7bELBRgUGzVQjYUqgUjq+i9PAq9+eZDDnXup03zx6r49eCnOdoxVVYC3YUkAkHUiKd
    Kkq01TwAWjpTDPWS41ScQF53iCBAl2C/77nVMr4BG9jqmD1sUfa8LT5OVAFVt//+tEPKFe
    eoD8P59D2ZgWD/I9vw0sINsjsxKMPUFN+f6I/wxEknvW6XHYdLHesCj/u2K79z3rf6zByR
    PBLLGz+UyI8/s1a64EhpVVQhHnXwSyc64cPsHgVMVBNZJhQ8wWO5LvEKj3tQ
X-ME-Proxy: <xmx:RYboai-InoDWt70xrWFp8TxTdjuweF2OdMI-VpkuOfov1ZIgeHLoNg>
    <xmx:RYboasJrbyzCMb1mAtoFoOYUci1ZqLUQzMydMBdV3qLNPbvtjUbbZw>
    <xmx:RYboanl7r-cWjrXy0nnOcXXMsGSCgIpy3t70_1tSoCytzJnaRhW4FQ>
    <xmx:RYboagNcHZhTqart7NC5G5iS_DZfIzFapv01su_-EqCwXK7olZeL_Q>
    <xmx:RYboag6tlUm4IzSTjtg04sPDdf6HXFlnfnGg9GwwtpoFzbvFFUntZLe9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 07:47:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f922d4fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 12:46:59 +0000 (UTC)
Date: Mon, 2 Nov 2026 13:46:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Linus Torvalds <torvalds@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
Message-ID: <auiGP4XhObUzC9vD@pks.im>
References: <20261031065525.19883-2-torvalds@kernel.org>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031065525.19883-2-torvalds@kernel.org>

On Fri, Oct 30, 2026 at 11:55:03PM -0700, Linus Torvalds wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> The current merge window for Linux v7.4 showed annoying behavior with
> 'git describe', where it doesn't actually follow the documented intent
> of the result: the commit distance is miscomputed when the commit dates
> aren't entirely reliable.
> 
> This makes the 'git describe' output not match what the kernel
> calculates in its localversion:
> 
> 	linux$ git describe && uname -r
> 	v7.3-19342-g2a500a04d6f9
> 	7.3.0-19059-g2a500a04d6f9
> 
> and the kernel calculation is correct, and 'git describe' is wrong. The
> number that 'git describe' gives (19342) is nonsense.

Out of curiosity, how do you calculate the localversion...? *goes
checking* Ah, you seem to use `git rev-list --count --left-right $tag`,
so you basically reimplement parts of git-describe(1).

Is there a reason why you use your own script, e.g. because of a missing
feature? Besides the fact of course that git-describe(1) is buggy in
this particular case.

> The fix is to take the commit generation number into account when
> ordering the commits. That will still fail if the repository has no
> commit graph, but it at least improves on the situation in the common
> case. With that one-liner fix, 'git describe' gets the correct commit
> distance on my kernel tree:
> 
> 	linux$ git describe && uname -r
> 	v7.3-19059-g2a500a04d6f9
> 	7.3.0-19059-g2a500a04d6f9
> 
> See also commit 1b600e659a ("Compute accurate distances in git-describe
> before output.", 2007-01-27) which fixed a different issue in this same
> area. Clearly the *intent* is that the distance number is actually the
> real distance.

Hmm. The big downside of this particular change is that you may now get
different results depending on whether or not you have a recent commit
graph. So you may get different results based on when git-maintenance(1)
last decided to update it, and that would in turn result in highly
puzzling behaviour for the end user.

So...

> diff --git a/builtin/describe.c b/builtin/describe.c
> index c0abc931a5..2cd597d919 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -328,7 +328,7 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
>  static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  {
>  	struct commit *c, *gave_up_on = NULL;
> -	struct prio_queue queue = { compare_commits_by_commit_date };
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  	struct commit_name *n;
>  	struct possible_tag all_matches[MAX_TAGS];
>  	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;

... I wonder whether we should also call `ensure_generations_valid()`
here. That function is very expensive in cases where we don't have a
commit graph as it backfills generation numbers, and it may have to walk
the complete commit graph to do so. But isn't that better compared to
silently yielding a potentially-wrong result?

Thanks!

Patrick
