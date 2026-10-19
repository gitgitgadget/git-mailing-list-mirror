Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792450485;
	b=xGA8uoGcnPPYktUgJ8EIbH6dTwgIJeq+u+f33klTsFM8/GLUBa2PGD4FTybNj8B8Fhvk
	 JeDO6EH/GAw/pTHJ7AekZe9nrPjloKu5vKHoV7JLSn2e4VvoKvtUgTP72PYpVxnLH7xIE
	 ThCqbhfHVu+KKIw/kx348PWM/09+FoFK8Rr1f575sVI/dUYv2Pbfv4T+Qsvaj7yyIfS8w
	 sBrq+Ec4D/c3DqiPCZ9NWafPGz5/JbYLDP8m/GbHQ9+y7gdEybv6I3OcN4qtNkyJPcteY
	 lWnsuPw5VOX8uItcG/KwSRbWmdZai6Z70aTY0nhpknk0KuegaeuGhYsCeX6zL2uS7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792450485;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=q24Fj+7/xAr6kBItBNkuJhJF/fkBssPWUOL/BxXFeQY=;
	b=bHsVeWOGVUtlwQKT8TVX4z4IdbyGQdK0p5kSBsCluKQCPoC+RPHOfW9A2FbdOVzgrPe6
	 /8X2+trsenycob8d8MCbJj2mm7XpESqsCoqsf2rFW3GWuWeatpVuDkPnzfEJV3yJ1jhWu
	 5loxSku0DBW3eFUOce+Laxm+s07SY8rWVIPjkfBtCIO7mxex0wcMAo/wVmRLOrq3li8e2
	 sxJvhKjBQFRt3BFVVQFFAHKKP1haz/+cmBRb9uf0EIx6MwgLHQhxh6p+9xvzwN23HW2Lp
	 0xRYD81wRe1ZtYdCmLcYC971xahF8JJvUxwsNiqzFCbVqHTXBBh+imCFS2Sf7ocwelQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ncMWk7ne;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GyeZRSiu;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB047606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 22:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB047606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ncMWk7ne;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GyeZRSiu
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F045114000CA
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:54:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 18:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792450483; x=1792536883; bh=q24Fj+7/xA
	r6kBItBNkuJhJF/fkBssPWUOL/BxXFeQY=; b=ncMWk7negKTq+p1rytVAlWKzdV
	CQU2RmMpmUcTtffIufXU0cKDmp1SwMxLF/2Og4Oa8h2eil6E2umBWfIBlJR3XU07
	JYvZFnAXNWXhcrOr5O+c3imy/OUjGcIiWmrPHLzsXZEYyecZWVSbISB4AiMkF+rh
	5G/bz1XIADHkmAKzmB8QTjoMce5PJEx2NpWoAShJQFCD2DmZBLKKWBk3lzm9HA27
	/Ea4xW2MQvqTVBjFLO3t8jmktrSm/Fwn90HqaE7ICIpe9P0QXi/uuLHm13PmuAJb
	Zs4HbMdzcLVs9W0A2YScLhMBMgVs9bIShq0QBKR7cP/3AL/15jIsSOl1q41Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792450483; x=1792536883; bh=q24Fj+7/xAr6kBItBNkuJhJF/fkBssPWUOL
	/BxXFeQY=; b=GyeZRSiueD+xWHyKAHURqM/l3ieOISiDQyBr61XUXg2oy5XZAvG
	je51V02WDqCDC+U4qcGRwrFVXOGcRnzQlivkzTznbw6rK70JQ/zp9SaWNzQICuWq
	lQsGWmJNq8HblcCtkuyQwPIjykc3Llt+Adt/nbDLk3t5Iy29uqOO4iMWLrHNdNsh
	UU9jgEZGpT5yPROhG5TwyJBqhC3GRNC3wENqJedzeGVs/GWwrHIcLvdjmyCeEhzZ
	un7G11KlJO59L7zqAdAaNk1iKeilD4exfHXtYe5OjYu8fA30+5h5vA3V1ms7/XVr
	ObHVY4EAoA5Grpv2mlRjzZmHg7hkr5xqFIA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792450483; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hc/0mXqQLnVcsr40CgQEOmbC+p55CgIHfudrZIeyhaFiNj0
	MLFPc+WAqgn5Gd5uyMWQ1UgF6zTFFPFmof/J4JpM64vqv+2GP4QZVIXt5jXeeDIO
	76GxUkSrstvEkwaae2MbLnjVUBAVj+cdgRWGiIMqnLOD9eZFwir76817sBxeH35l
	vmu+K5yY8eJqacP+vdmqGA53YAEBsuFMknwYRSxgMjPd6ShTC+gktHb6zp3nWwtE
	XLpMmiGipe5M+X/ivD+nUhQYjCCY0NMto1GC7KFPMvC8hWwzWASFa8hjci4YmgG4
	FhpFPy2AMJAanc/isaNUgS00PkZVT7ZDiSBGcdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:N7vSttXoL35ES8P6hvWncsZLUni/XnHlyPLmH7Xe8rc=:stKtOsmbYd/gD7vc9eRCBpX4GYrIsiYyAQsEW9YN5pw=;
X-ME-Sender: <xms:s5_Wahg-Fu-PRyXjgk7fu8aEDBluAiT30P79v9mPxWfLpNWiz5UjBw>
    <xme:s5_WatDAkDnr-nYtL4y7YRP5F_ypTAmbSCzTc8w4JF8LMiuAaRd3Ffif90L1tNKMB
    YaECvljftIC-ALXJT7pxmZqIAMNxLviP2eBt1Mqb5fUPXVLYasDpQ>
X-ME-Received: <xmr:s5_WamEGhx0Dlo5JNuOZNtPQqGXY_J-LBU5vfhO73d3UGpGsJsMUs-a2DTDXbpKKR2yiXKOKGffMwWbhAOBiVU9e9QCUvBqFDesa>
X-ME-Proxy-Cause: dmFkZTF/81g0DD2abfjBB4zjuYIfKEAJ6IK5i3+PIE5V20DEpbW0kY0ZDFp8MAtQAnfejl
    ibQFlsR9Nqg15mDvzkq3VHltFP8XGZ7GQzY7ibCOhrmDDYxIwYfqg2mMcwImKzUglPXaxF
    iejjNOnEkQPoSBuRrTo+RoZCyQGFwqjVUVPDwYdhIRjfnHV0pnzftxAiIFt6aKd/51sqJ5
    BsOIAp34hdWpJ/8BICnyun+xWBDeV6m/K2IjvWujvPzJJuf16BBvIfxaaCv7YVN5Z6moXd
    xHkkOgr0r95JCSTM4pcPcB0xtQzDQn1HlJ8havp7Vy/vxTxPxUwdJaM/cWhXSgvOEK9gez
    AJKI1O+XspxJ+A+Hp6pbvzuO0wj/Xj/vVZfzIFrGyC19xNIFV0BaWB1qDD8ZRW0tMJGjL+
    pDuj/oZ44YtUuCbDlDqV9zGyg/IIYwb4fEyxK95AEVuPVXLtYvAaQxDD8PIgZxFnD7KQgA
    soNlB6lylVuQF47RgF7kGiL0qNT/WjOhPXipO5BwOnEriOqWbu5UAYf9lWfKY+itxc98we
    RnedUWrigssgTQ7Ljy8LQsEfU55If3Uc0LnCUlCRRXpaFBG20tMpp20qoTA2aQZCHkvpJf
    aU4CGdMs4KAJG7aHS4XjATsgeorr9SMgPuN7ulFZSQCsmuIfYAaoyQO0Q1fg
X-ME-Proxy: <xmx:s5_WalLrxLpCwePu3N8C9CiM3T8KHFFP4pit2G0Y88bXF-R6BQTFRQ>
    <xmx:s5_WaqkTHSoRJJ2GNFzWbDXW9ywD-GLG_ZJ2WfVRbt0BVWg7jWaidA>
    <xmx:s5_WatSCbQoxuCKVKOG_aBkyCVT_8yHWDZBV67Wp_CTj_4HIHfjy8w>
    <xmx:s5_WasI_hs_cekqz2dZRvOd87Fe8kBa83yJJUUGgXyLnOaTPAcNv1A>
    <xmx:s5_WatmPzN8LUXva6am8i6OUPtRuds1vpjZyzN_PnpYZQlZVNaKky-8s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 18:54:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] status: compare against both upstream and push branch
 by default
In-Reply-To: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Mon, 19 Oct 2026 19:23:18
	+0000")
References: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 15:54:42 -0700
Message-ID: <xmqq33u11etp.fsf@gitster.g>
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
> In a triangular workflow, where a branch is pulled from one place and
> pushed to another, "git status" only compares the branch to its
> upstream. It says nothing about the branch it is pushed to unless
> status.compareBranches is configured.

I would have expected such an explanation to be on a commit that
allowed this default change to be such a small code change (i.e.,
the commit that added support for status.compareBranches).  In other
words, shouldn't the first paragraph be more like this:

    Commit XXXXX added status.compareBranches so that "git status"
    can show comparison of the current branch with its upstream in
    addition to where the branch is pushed to, which is great to
    support the triangular workflow.  It however did not make it the
    default to show both.

It would highlight that the primary task this commit wants to
achieve is to change the default, which is explained next.

> Show both comparisons by default. When the two resolve to the same
> branch, which is the common case, only one comparison is shown, so the
> output for most users does not change. Setting status.compareBranches
> to "@{upstream}" gives the previous output.

Most users not seeing any change is not a good excuse to make a
default change.  Thinking through different use cases and see if
there are cases where negative impact is made relative to the
current one is how we should evaluate.

In this case, especially given that this is "git status" output
that is meant to shown to interactive end-users, I do not think
of a reason why those who use triangular workflows would not want to
see both by default.

> -test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> -	test_config -C test status.compareBranches "@{upstream}" &&
> -	git -C test checkout main &&
> -	git -C test status >actual &&
> -	cat >expect <<-EOF &&
> -	On branch main
> -	Your branch is up to date with ${SQ}origin/main${SQ}.
> -
> -	nothing to commit, working tree clean
> -	EOF
> -	test_cmp expect actual
> -'

What's this deletion about?  Is this duplicated or something?

> @@ -361,9 +348,8 @@ test_expect_success 'status.compareBranches with only push shows only push' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
> +test_expect_success 'status shows ahead of both upstream and push branch by default' '
>  	test_config -C test push.default current &&
> -	test_config -C test status.compareBranches "@{upstream} @{push}" &&
>  	git -C test checkout -b feature3 origin/main &&
>  	git -C test push origin HEAD &&
>  	(cd test && advance work) &&

Even if the default changed, shouldn't we make sure that the
configuration also work as expected?

In other words, the changes to the tests I would expect from a
change like this is (1) to update the tests that have been relying
on the old default to gain test_config to explicitly set the old
default, and (2) new test that demonstrates the new behaviour
without configuration.  That assumes that the test coverage before
the patch is adequate, which may not have been the case for this
test and further changes may be warranted.  It is not quite clear
to me, but the addition we see below is such a case our existing
test failed to cover?

One large argument the proposed commit log message hangs its
decision to change the default on is that we won't see extra output
when @{upstream} and @{push} happen to point at the same place, so
naturally I'd expect to have two tests that show the two cases
(i.e., one with triangular, the other just pulling from where you
push to).  With this test update, do we have adequate test coverage
for these cases?  If so, that is something we should explain in the
proposed commit log message, too.

Thanks.

> +test_expect_success 'status.compareBranches with only upstream shows only upstream' '
> +	test_config -C test push.default current &&
> +	test_config -C test status.compareBranches "@{upstream}" &&
> +	git -C test checkout feature3 &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature3
> +	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

