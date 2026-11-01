Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569545;
	b=e5uFlA84l2SD+oYRR74Ta8llN55jKAH4YliYTqSGmlZnj7KZGrtZveOIgBppazuv0IIG
	 tdKcF+kFSq0uu5SgcxtJG6nyk6Q77XHpAdaIRkjA4w5kZ3sadLL5RKhrDSj/SwTL3bSFE
	 B7ry38wT4n61r9ZbZYn/9MtMT+yjjWtqALIwJ5e6c9ZQbIBL+saYbSl3Cf/BraSJItROo
	 WtbywU2/K0JBK443fxziGflso6e0wr3m0uBi9yPyyIjHzNzEXucDZgsTjFxAiX95Ytjxt
	 Ot0Y47XsTgVFzElIsOcUT0y1Can61QYDSQ/YqZQEyQDnBBa06PUDhgr0V1fxxC/HcPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Importance:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=1f+e+sI7fhu/vnCzYx7DZNgr5ErRaASXKDRpGBi0KFI=;
	b=emZW0dlFre+8JfUe20Vl8yG5EbSVVXCrzFkPzxbe+hXPT+rSmVlCQu67icpM79nNmfl6
	 VSsvfXdwKZkcMWXswL/bJqGtc1PKg4xMIN/yXo346LQT2GydI2o/fhBAeHaCgs9fbxbZO
	 oqBcV8NbRwaYq2Xrwq/wW3NHYP0vZzPkomvcaryQOgvqkWVlE2kJ3ShVMKWPG1qZHi7pp
	 WjzmhJ4rl8vRrIR5SBVmM1LYBuqPTqhGdt/F8xZiXNxx9BiK1MmZxwp4p6rXv/hsJW0wv
	 Yo/zU7VmwXL8K1bkA243Gwr0R7CqNGBn4fQwjq/6TmywZ0bqGT+NxItz1wK1JNKCDaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MAYXu3WD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s8u8J7W1;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E041606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 21:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E041606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MAYXu3WD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=s8u8J7W1
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9457C140016A
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 16:45:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 01 Nov 2026 16:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793569544; x=1793655944; bh=1f+e+sI7fh
	u/vnCzYx7DZNgr5ErRaASXKDRpGBi0KFI=; b=MAYXu3WD46qSFR6zDX8uqklpzb
	ptaIG29nsjrrJ0aDuAyDsihWm/ybJHKqThMBgN17ZRUrlY34/qofq+x9EqSgBRZ1
	pYcE0pkpOIPAj+iQtmJV8iujOGP2tAtiQPjR94Ijl8YQqire6lgrdOB8ibo6W4Cx
	4ftrs73oj2IRr4aT6qatFNrWFr/9u10Hm7nimH255ZjYpkEPanNNKYtv09wbKoM+
	9iR8lnT08K+kcC9ndKVwFhfqNFLyKZTx0w7k/Wgw24T8gEmAh9OzKsCh/v+iZBHq
	Q5mRoOQgynaBvrzlFLDMquKkzyQt6KhjMEWzs1JZi1VVdDz69XsEXY15ekxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793569544; x=1793655944; bh=1f+e+sI7fhu/vnCzYx7DZNgr5ErRaASXKDR
	pGBi0KFI=; b=s8u8J7W1mOwmX4nq16uS/Xp1P9W8bc8hLv7rUqIAeIaLUcbTufh
	YWKBqlF3S1hW7gBVBdInEUz0mQJNtndWMPB2NuHTCbZ6DvkkVF+FyCWrs8nuOSo+
	i9d7p7+O9R7BKksBN1/f+h5CQHqm/KhAI7Q4AssJQFFBdEOUo6PdhdJMFbJ/bk71
	GOE0Y5X7R6P5gFl1GKlVgkxeOCI8fsvHo/iS/G+WmxXe/a6Yne88zvA5cVLIlQiQ
	H3DPHGhimZXhtMUuAtXbsOVLrLgbwL/837C03ke3q//wxsPYj1SNvV/qYeRxwECp
	DX5HZ1Pcl+0SvWrbo7h7qc7Csif/FLj4Waw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793569544; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:b1D7//r7pAc9CnjygFYpRYNfWTluwXUmw/cgvs2smCkx7A9
	feWLhvEuMyWttvVhlvWrne16o/NukR2vTO7Zt+jwQINtu/H30p0zJ56o0gdZ7W54
	5qhifP2BR12C2+LzBwbGtkbvVNo9fuXJbcWt1RvWJiimGi0lPuJjuMJwloBoC3Uq
	k5/HkeByFfpyqjqXuv+qShQWtnVqJvvgj4UeeWYcm94U9zFcirdB4qXjFrQea0wz
	LZJGZ+UMqhGE3Dzv8NAYhaZxRM3wqmWGhq9OZu274Pf4skAY+0mi0dZQLsBM02K5
	1z8r1kE1nItXcwFtnggKG5Sn5wjt8VGgE+ZJMPg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-type,date,feedback-id,from,importance,in-reply-to,
	message-id,mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZcsJxIbxVC3zWr9w+9eXohfJYf5HE8wUn+QkBbPpiks=:xbfYZsWVf//vaZW/YHl1MQoruexwvsMgwHyNBtAXJt0=;
X-ME-Sender: <xms:CLPnamvygDY-qpLq4wsZHydINzXGU8WyafPOPrLAdBi8viA9oytcig>
    <xme:CLPnaicahrbC1r6YuYrUNBA71ucJpDiPW58xX17vUXUp4mFKCpn_lrkDRtVaSIPA3
    _020iQhaZJgqHjD7WWtu9WouxnNbYOIw2mSKKFfHHmutZZPPGBOYw>
X-ME-Received: <xmr:CLPnamw6do6bKRRKcOCEjetha7ymXuaz157FmkDFeNdJ8WP6t2s5VPKeTcBfa0_180Kqqjjc5ePN14TylnJiqJPotIcbZFFNeP-0>
X-ME-Proxy-Cause: dmFkZTEoKGtuhtnkaKeLYAhdnD6pewkU2kkwjtdVCt8EOifAcaAvBNQr3lLzcH+1BXHUB3
    LAjQn9AwTcfcbNAkOvPviVMha7z6rIiXMRRVOnx1gbr85qEA/qEQkunM5YluLzSry8bDwN
    Ghs1ES+rFbcd2TXs8lvqiyzy0KStBL0mbVBZ5uxwGEx9rhXrbaQxPSMrUUgUEVYXj3xXQn
    k4AolVt3y/IZ0BO8Na+6p8lfl83bl5MuQAoRwk7lyiyPAuv7q/HTjnxrN4GTuwOgDRWyrx
    iJcnoiTFJBo2mRYkH2k7XYjqIZv5heutZyJ44+lJ2BV9SfBU77hLYtzSJd0kp3Uvh7eIT6
    +CmZze4VDJbWjaj7NOXOFphx5yi3FRtqSMMoI3mS9+RBrSZw49S38b9vUG547KeRCfW5x4
    PyYYjHFtLz45cPYzLE/AoF1qdgB8m1+zeHxZ07FP3wbs+ghxPiacv8GoUAk32pNImGob8z
    X9s7/RmUa0NbkoXIx+nDQSezqVERzQPilHM4V9uOJcfSNm0CmTDWK4sBuzPmtdxqYUODGy
    E/SyZm3JC8Xgq4OjT20RIyHhwUAraikSYnQ1t44ikBdlTE0nzm1JHlP6xc57ge45EwqYGq
    dBoZqCWUR/kbFVKAw88WAO4kC3+hSMTPX65EfUCGeyBul5kvXcHKveFgELLQ
X-ME-Proxy: <xmx:CLPnagH2gz2uWxMW9uXUKBHLlO0SJ1u2HafIdmmE9Uo68ThZrthZ-w>
    <xmx:CLPnaizaYRTcyyPVcTWTl0BfrkjyOIUhFsSN9K4qDD9MLM2ahM4EuA>
    <xmx:CLPnapu60y5dr_0UNe_prPjqWN0IGkQyBfY9M5YLU3BF7nqQ4uiiLg>
    <xmx:CLPnan3JnCKX7tFxyViwa_aHV3TgL8aQoGm09GkSx6HmOIafT8qrUg>
    <xmx:CLPnaqQfVi-J_Lmwhuz2WkN3HTWBJU-QFN0KNGGX7V0EGZgEQ3gUOGDV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 16:45:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Srujith A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v3] submodule: use the submodule repository to
 abbreviate commits
In-Reply-To: <pull.2288.v3.git.1793474657981.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Sat, 31 Oct 2026 19:24:17
	+0000")
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v3.git.1793474657981.gitgitgadget@gmail.com>
Importance: high
Date: Sun, 01 Nov 2026 13:45:42 -0800
Message-ID: <xmqqecd4z0mx.fsf@gitster.g>
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

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> The commit IDs shown in a submodule diff header belong to the
> submodule's object database. However, strbuf_add_unique_abbrev()
> uses the_repository, so it checks the superproject's object
> database when abbreviating those IDs.
>
> Use the submodule repository when it is available, and fall back
> to the repository from the diff options when it is not.

While the fallback behaviour does not make much sense (the commit
object recorded in gitlink is not expected to be found in the
superproject's repository, which is the reason why you are adding
this fix in the first place), it would mean that for unpopulated
submodules for which you haven't run "git submodule init", the
behaviour would stay the ame as before.

> diff --git a/submodule.c b/submodule.c
> index 6fcb606f7e..1302c11ddf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_options *o,
>  		struct commit **left, struct commit **right,
>  		struct commit_list **merge_bases)
>  {
> +	struct repository *repo = sub ? sub : o->repo;
>  	const char *message = NULL;
>  	struct strbuf sb = STRBUF_INIT;
>  	int fast_forward = 0, fast_backward = 0;
> @@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_options *o,
>  
>  output_header:
>  	strbuf_addf(&sb, "Submodule %s ", path);
> -	strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> +	strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
>  	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
> -	strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> +	strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
>  	if (message)
>  		strbuf_addf(&sb, " %s\n", message);
>  	else

Quite straightforward.

> +test_expect_success SHA1 'submodule commit abbreviation uses submodule object database' '

Hmph.  I wonder if there is a way to use the test_oid_cache
facility to allow test with both SHA-1 and SHA-256 hashes?

Will queue.

Thanks.
