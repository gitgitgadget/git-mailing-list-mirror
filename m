Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625860;
	b=nTzmWjRjR5MU+3xUPvxlmE/Igl2jf2MufNuKM8VanDXYmQwTn6wt/o6O3obiDypuSvDN
	 adLhQbDQcT4ns7Ck0kqqDrVgK8aXnJGv18Oj+eoO4ogNFlK8/oKwrSXpV1EFg5R1sAp2B
	 lf/oJVaG3c8rhaZJHfBN1lqoPP+wla2nUgmDP6ogoZer+evGjmlD2+vQJ6OQkAnSsJaTf
	 j/cY/oo5BZGtYs6hbs3CYyn62fM19avHq0RYpbKMQjdj5zod1IS9+jDNzR/fFgEgE29np
	 WhoMINYH7X972euuonu3mNtKwugajMdrqrwbLpGbeeT83mZ9vM9nsp+pXeJQ/AftDiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625860;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZVGRfuXFcsusUYIaBOuWxmE2e+DzCMQ1Uppv6/Wd2HU=;
	b=uTDaqhVMh2RrmtbF22rR+g/+v0Zh39aqEU0TW528Og8iM/TvOhlf05vdIASKYiEsmL3E
	 GcaCyZzI+YaodRnfe7HsyYC6iblUaB/DwTYNVItE6sqKrJGWO53gcB+zbAoocPoYRoeM4
	 Q+dQX+/hByyrZBi6RVkWJSSAc0O3FuCrvsDHr4hCzs59bg7jSwL1PWY2mbIEigDe5VOPe
	 1hf7qDby6ADFpxOYmvQmMBCv9wzXBwIQCweTaosqfbhlMVT+cgWaGaIk9sz2/t8yfRYbA
	 xNp1H8BQ61YrxMncbvcTwXu6HnOW6IKSpkgQbC/0aODLGSqBwh55L7GGHRtxAP+q61A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=L3DFlwJA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UHGp4xOJ;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC72606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 16:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FC72606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=L3DFlwJA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=UHGp4xOJ
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 925E214003A5
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:57:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Nov 2026 11:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795625859; x=1795712259; bh=ZVGRfuXFcs
	usUYIaBOuWxmE2e+DzCMQ1Uppv6/Wd2HU=; b=L3DFlwJAoz+C5hbncOeUVLgwUQ
	sxuri1lTulBJUglVtsRrwxBQRN8CrblPjP2+Zl14eE1rh5Cd0Ij6ZjUrVHHAILTs
	R5KBsmEX8FvCrkQZSdHQzg86vcNY7OTrU2b1lezZMSuZW9o4x4QPCbrpZM7dtS4Z
	1wT9k9K1p4sdbxGZPeqezmMzsHUEmUE7282sNaiddK76/xrEmBfH/2rqud6LxROs
	ItpBJKEWfR/6OaBsTTVcJgDWcsfxWMMwysTAtVo796uGfI16NtrvBufewMBqN2t7
	94YgNhncrpAiT21ojiOei9KrmLTh/1CtJ6SxkTuEDMQVbapJEsU+pOfc0JDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795625859; x=1795712259; bh=ZVGRfuXFcsusUYIaBOuWxmE2e+DzCMQ1Upp
	v6/Wd2HU=; b=UHGp4xOJbAfMek3nkyqofaNIAwOzBhwmIQdjY6Uv0g9IexM2LcK
	7dYPQ0sETdqhu5FzGC4vRXKhVHgSeS7p7ZZ+oJJDvp/Esuzz19M1p3RNxdi17OXO
	nMd/pV/400/JLGIcx/PYXtIddJK59OLJ3hP2CmPz2XFp9EnilezxUrtBOLwQC9AM
	6xwCNoD3tKVUHH6cVd46AXxnmdNdWpV8UnHU7lQcHwu4QSh/BZ1QuqA+wlwfaGyD
	02K6l1EY+/ejSxdFiBw25TW6xxU88Xrao9F9ZUkTuI8QYRo7/Oh/kos04frA6M2Z
	gaTRkgymPzHXwW1urCpReB2RTILfCA49rqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795625859; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mk6fsSVRouiFiXcVzruHC/EbDhIfqlVMW1zlCDeUB8F0u9t
	G19hd6mDD81TYSgzLef+QuGX/ggW2ZftMG/ZGCPGnPZYeCtjvZgpBkCk+ipAVz7P
	39cB6SqAC1vlYbFZJZKUkIA3RP21HunsPv/XOfW3OGmMW4wm/w6QtXeLlP+qqYrG
	ICKn/PDCaKOz5ZPD/WKSNqsKPC9OlHLhW4Dbu7APILin31nqk1a7YQhhSICBc9NP
	c6aIV/8GE3gB/qxvyLUIczz7bWea7OwQUGy/XaddqFDvoDpjsESOeMH7DumQFL1k
	wJNsrbFNx+kW5s9NR60UHzOzREaOLQRQy5x8vaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0VPo0+zKG9frH9oqVleJLNk55rLidGVI85GaPDZ5swQ=:Tf1zRooEfrPx8YZJsgBYA6h+jZUVRqJqz5Yeo+YbpXs=;
X-ME-Sender: <xms:gxMHa9q1kY5Rj0pF8AGROwTKgcqHLxzqDwSH7QT-2CfFpZbtf06zNQ>
    <xme:gxMHawYZ2rSd3AYLOBIcUHgxFJ3XUnVjYgAO-J69cLSBbjbJ_vlT18o6wqgMKJNMJ
    cWSHSSiq_ALf8zBtFPuPowPyP9uLctsc4x_Zl6EKVs8Ow31JaD5wdQ>
X-ME-Received: <xmr:gxMHa2UqEMhnMoS7UBx_R1739ihDbbWQ4ucrvPPMm1tAJCY2-RSNMEdDXTo7adYYM3spzu0TQAYy0Rh535qhaTvZvwd5YUw-5-qypac>
X-ME-Proxy-Cause: dmFkZTEA4OG6fZVOlrn+mSOZFLeJIttgl7br0nCsp2F90oF2sszEirn0LGHBMNi5f0eeER
    CtuDxLjx8pezqGec3PmvrXek3IuPRLTAaaS6bDqb5iLX8E4r7+ZGPNtS/xYNsN3uHoRWbx
    UHRRWZiQ0WYC0dU1k3rzCQ/tuu8Z50Rnf7IInuukjxA+WzQ++D6ZE1O7HcGqQIqZh/UsYh
    izOBtcT9Beszd5STuAq8vhnGV51gvAveYKErxKH3dqhGY7Q66X8uIghZ6BHUI7eGiDfR5B
    EMItd/3zRTYehV6/u9KzuGTaP+p5qXSK+4XLPp2M2122Ot0+dvFvmd1hkD4GTwAgqJwWqZ
    w9PZv1HaFvmWfYRtsljC5QTpRkEjFB8eM9xKSeLzgb+fnK462oREo1oMuJuC2unAdyTXf1
    l8K5M6bitxhmXoMR6xNCLKk+bC4sQzARbavxJkOV92o2HW0X0PtLrGd4Pkx6ARCU7nq75Y
    wQuZWrGKooMXQtV86IbljSGniUB3aE10uegwSq8W3q4G1hPEic1890Gc0P/tog4RNQk/R5
    6MIJJNdJzy635+tOgUQkuhslCvQ+X8+Nm+GbNXbrtrWLXIh8uTL+BZ6N3mE4q1CeaZDEvz
    X4hJ0hlYPK36kw7qHKV8UNxMuzjLqkmJ31f7FiaHRFiq/WdCUstMSZm3GKLA
X-ME-Proxy: <xmx:gxMHa59BHW7jVQETg7nnjNxHSmz1UjkRW_rzkPXpDO6F7peubYgiFg>
    <xmx:gxMHa__Oy4qIjzZiteT_GejrSzziHB7tMprLNYHG4HwdxcZMWAmHdQ>
    <xmx:gxMHa5QYGBXO7UdtbmaNox-eeyVrwbkwMixAqph4CxNXh8gbdZ7iKQ>
    <xmx:gxMHazfddjBVA5bdI6wAe5-JN0HmwFqzfnBYBWZ5yxZG5KZC0O9e7Q>
    <xmx:gxMHa_8TUliZS7TRpZNqCbBBlp4B6ezUZ0wvt60Mth-w5ffqtU5hw2K->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 11:57:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Wonseok
 Oh <wonseok_oh@korea.ac.kr>,  Wonseok Oh <marinelay7@gmail.com>
Subject: Re: [PATCH v2 1/2] sequencer: clear saved HEAD OID when picking
 onto an unborn branch
In-Reply-To: <7c0fe312f161247a5e7192e214e8677547521a92.1795577024.git.gitgitgadget@gmail.com>
	(Wonseok Oh via GitGitGadget's message of "Wed, 25 Nov 2026 03:23:43
	+0000")
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
	<pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
	<7c0fe312f161247a5e7192e214e8677547521a92.1795577024.git.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 08:57:38 -0800
Message-ID: <xmqq8q2g97ct.fsf@gitster.g>
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

"Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> However, sequencer_pick_revisions() does not handle this case. On an
> unborn branch, repo_get_oid() fails to resolve HEAD, and the function
> saves the uninitialized 'oid' to .git/sequencer/head. As a result,
> "--abort" is not guaranteed to refuse the abort as intended (e.g., the
> saved 'oid' may point to a random commit, and "--abort" then moves the
> branch there).

Nicely described.

In sequencer_pick_revisions(), an earlier loop over opts->revs->pending
declares an inner struct object_id oid of its own, so the outer oid can
either hold arbitrary stack garbage (including an invalid '.algo' member
passed to oid_to_hex()) or retain the OID of the last commit checked in
that loop.

> diff --git a/sequencer.c b/sequencer.c
> index 4a1c0e70b8..20bfe00ba3 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5788,9 +5788,12 @@ int sequencer_pick_revisions(struct repository *r,
>  		goto out;
>  	}
>  
> -	if (repo_get_oid(r, "HEAD", &oid) && (opts->action == REPLAY_REVERT)) {
> -		res = error(_("can't revert as initial commit"));
> -		goto out;
> +	if (repo_get_oid(r, "HEAD", &oid)) {
> +		if (opts->action == REPLAY_REVERT) {
> +			res = error(_("can't revert as initial commit"));
> +			goto out;
> +		}
> +		oidclr(&oid, r->hash_algo);
>  	}
>  
>  	if (save_head(oid_to_hex(&oid))) {

Calling oidclr(&oid, r->hash_algo) initializes both '.hash' and '.algo'
members, so save_head(oid_to_hex(&oid)) writes the right null OID for
the repository's hash algorithm.  Later, sequencer_rollback() parses
.git/sequencer/head and hits its is_null_oid(&oid) check to reject
"--abort" before touching HEAD.

> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index 9400ddfc45..d52fda1c54 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -269,6 +269,21 @@ test_expect_success 'allow skipping commit but not abort for a new history' '
>  	test_cmp expect advice
>  '
>  
> +test_expect_success 'cannot abort a cherry-pick sequence started on an unborn branch' '
> +	pristine_detach initial &&
> +	git checkout --orphan new_disconnected_seq &&
> +	git reset --hard &&
> +	test_must_fail git cherry-pick initial picked 2>err &&
> +	test_grep "could not apply .* picked" err &&
> +	echo $ZERO_OID >expect &&
> +	test_cmp expect .git/sequencer/head &&
> +	git rev-parse HEAD >expect &&
> +	test_must_fail git cherry-pick --abort 2>err &&
> +	test_grep "cannot abort from a branch yet to be born" err &&
> +	git rev-parse HEAD >actual &&
> +	test_cmp expect actual
> +'

Checking that "initial" applies cleanly so the sequence stops at
"picked", validating .git/sequencer/head directly against $ZERO_OID, and
verifying that HEAD stays put on "--abort" closes the gaps from v1.

Looking good.
