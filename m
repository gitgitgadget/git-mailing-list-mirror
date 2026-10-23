Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767256;
	b=gQATxQzC6kf3RCqegoX3pjPCBeUsnHuZVIGnDcbrs7K9ynmNbcOeRBsu28xb2hytdEZK
	 L+YTeMM7ZjyX+F0pHQZ+OGM5AWJ57edvNRcdNKV7nydyr+inj4stcKvIoQQr+AImWeZAM
	 07IC+R+mpHhQXYhM1Pnk1tPyCUUslezzp8sz/+Xaf2fYyoU/AOluLarfgq2MlQfpXVkM9
	 CPnIWnzPwMMKifDH0QpR1hhWk/NH7LbCXyDOhaN3ghbgSS0HIx1h8YIMjUGL//HovF3xX
	 YEVQ7DTH51u8qh5DRa34XMLTbi+O7Y1RNaTmSJFbWeGVz4RYIJMf+YBntSSw7xf7Gzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767256;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OXKgRq+rlqMmSJmQ2szPVRAbOSOSILRz81Y9i5u8CvM=;
	b=eGo66ehXNu84MK0dOAVTw4V55LXunEDagfWngByN/pQu7zAXFkFVbfBvCDjaJtpP0nkx
	 xA2lCVU3F+4pZ/AVQZA/p5fr9DADDs58PoaI8HpXCGUBIYjZzaALakwI4S1a3XdxWnEAv
	 0OakghoZKEC9ncchgOIW+0BoVkrxVhSG6OcT6XcmaZPOwG0SracRo0G2sGMdPhcIZDMln
	 jMZV3kntSppomJnROwo/DYbBH5I3PPX8EZBArWzEGp/gFE9uXFGdsthnQ5mINbI5XAibR
	 6G/tqd2SPY403XMHxiBAKRJAxd7SgenhLBE31UXZWCcfQcD97UtzcO1n+Ogdg0XGMGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GVMQNMZa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="aJidp/lq";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C86606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10C86606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GVMQNMZa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aJidp/lq
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EF991400162
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:54:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 10:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792767255; x=1792853655; bh=OXKgRq+rlq
	MmSJmQ2szPVRAbOSOSILRz81Y9i5u8CvM=; b=GVMQNMZavif+bVuSmBcSkpf52a
	O4nhwQQIqNYLwfW6M1vYfCikAvO4vbdYJ2yJj/1tyKTqgSs67GKx1kARjjNLsw9u
	hyLQ+QuW7P/Z9vmV9xJbUQ0O/jM4VW7sXrg0ZMaWEOSdDDWLo5mEy+QFm94WTaWU
	Swqg19i2UuuCDhoAjlGxLqVnvb9fyCftswMkLGSip3yNVIcbA07L760OjItL2NFV
	6hxsF9PjJPbU6XEXV9IvPh5X6TSQ35PTDg9PgI9qUAJdV++pqOdhuhf6v92hPPla
	i7Cth1F8WINXLMk+drMfpznTbjAfT9IYzhD6YQs2i2OFSB+5Qow7pS3fEAkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792767255; x=1792853655; bh=OXKgRq+rlqMmSJmQ2szPVRAbOSOSILRz81Y
	9i5u8CvM=; b=aJidp/lqqlTsE79AtqidjhcWL26bkRscF+dCD4ATfdr3n486awt
	rVv55m4MJu3LGbSM6P/YNpBmotRhLtC3dwToxr1A0/+w6WQnE5MOdWOmSwiMntQV
	coJg3EV2aBAg2ZsCXXC/zATaGYQTXOHI1gAE08rmfDy9zOqlBiJ6fEINWCIs9Y+F
	i7gYy8FrPpZ+3J1osepAIsSrEKa+0a9/0j1+k5rO8gOr0XesYt+NCnx9aTY7WJfV
	/4Y96045f4MP06WDcNngruqbjyLau3vVmxVFLp3eVqMsj+lp51jFuVBscvJKSiob
	4bH0xM6Zbv67+ufhhzbb3wClNWuZr8BZypQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792767255; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AyzfI6D1WfiU1XfDpGFNz0etI78GpvxZyDjHcF5TifVFUkg
	MC0HH+j/ry6eV1cOVm5H5SFHVkdjHaGGaX+DK1vRl8BTFBlJvBbAYGpnvG3JBAlD
	JQFZFG5Yz2LXvaecO443wlcSMbSxH/Nef/IV/1xBOE6h2BFHfH+IAph3isj5Zz5R
	zeYuAG+sk5stjw6ZGV0h3e/bZt0JIaLzoMu3J086BlefWt8TpRQJn1CKr9GQBlLk
	4XGdy2U8d0FaRpuz+ryt1/gFZ+0Nq6jgqeciBUhggzOO7rqkE8LjVC9qffqSKzZw
	X/0A/b1udWCOZrn6IAPHZ9HgpADUDGb1Uiri8Mg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BK4y7sPoYUUlqmMiwojBoYMwmWDjNd044KKUQhTowck=:Yz4bSMCfmAjiLeg8JGK9aat+bD7LOV/iRmXvc6xg9dk=;
X-ME-Sender: <xms:F3Xbaj2aDLeFFp5m1KGgRI5_3cWG8vX4A7P-qv0xsncjQhUEHXY7qA>
    <xme:F3Xbaphx_gos0v2o-JkPdl8wSAqA0wIRDWoB3qwja4s1lR5mASGFRrnWt1m8qs4ZZ
    25VleOADNHkssN_vLaCHMjWABw_rMkkbB8DPhkZznCNlBpI79QmZLw>
X-ME-Received: <xmr:F3XbahT2AgWETpwjEibBc0cCyZ49rGw_1axp2IFlpNIdope76rIrk0K6MdV1CAQ116sUuirnVdZLzuSGniHLTVEmNP-A5BWHRrAK>
X-ME-Proxy-Cause: dmFkZTG1UDyEm+hpGa2MN8mW2kppiOjMWLFiUoFCN4EHMYTMUURg5PDVJSin/8yXorXLMo
    gg3qGXGJCQj3r70SAglauZ+bvShI9w+JDsmLcX56xAl28StbIbwn78lIHkhJRSW3EAxoPF
    luZkri5Z8TNiV+qeYoI4jQYTRSKT1AAwsyQ8eGu8UGSvjfmyUdAzlQNVjAaUqt9JPHg5dr
    zTVamk6Mp+LxA5noVGLwbTPNDJD0J8/XYT+cJ87pzbAIm22GyqzgdVSd4rpMWzwxEpcsx4
    5ZpxeEYbDJkNs8YMX2y7Ti2HkXKY9ssQqyC7oqN7/1fiLLOXM1tfRphztQTZo2JoW/Aebw
    FtUzkneU3hvkwLNMxSbzLcYNfW2NxnDaaM9Y3b/ZYwlCIpflz2v/GztbFxbxKSZD6DgfCb
    x12L3zJo203EF9GBYCV5xkIFBAOGgfK1ddU41zVVvsHYYwxW1jrtTOJ7GOH40QztbMHG8N
    8ZilYD4i5dZl3d2JjKrbU14jW5OvB6u9GTbHPPl6RCWWfB4LBqtI8YAAAxv0H8bKCuWhLI
    het2lPH2NpZR15Qe7AK8YVu9ztjYEZXUfEqN9fxMr9dhA4OUGAAHDMNqMlXqcLEamANTr0
    2cZdgAT2zgBPfqZd3CxpQTpJdta4L8OJAxeUhkFrSEoQQH0znr0iUQnh0MmA
X-ME-Proxy: <xmx:F3XbaihCk-bL8NPfvK8PUY5UGdsiamNQ2JO7sy1rOL9PQrxvbw5FOQ>
    <xmx:F3Xbap6WZJFHvujC5dtZ46Oj0C8fUDw-OZ1ivQVon6wBKdi_YQ5onQ>
    <xmx:F3XbanCWXy_fyKbqUxx-SNJbwHf-U_xdCpkxNWi-frGhWX-BDqcZDA>
    <xmx:F3Xbaoa37kmBNEEaDL8AIifE85xFhOaMoiY2vlvuF79FJNRZNGrr4g>
    <xmx:F3XbapqLCimSzAsGLcrNyVKRhSTxqXNc9V0nItV2UAk0CgrUG_mq41Im>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 10:54:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] config: honor file permission bits
In-Reply-To: <atsZX6exgGJkNQQQ@pks.im> (Patrick Steinhardt's message of "Fri,
	23 Oct 2026 10:23:05 +0200")
References: <xmqqbj8p7okv.fsf@gitster.g> <atsZX6exgGJkNQQQ@pks.im>
Date: Fri, 23 Oct 2026 07:54:13 -0700
Message-ID: <xmqq8q3obh7u.fsf@gitster.g>
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

> What I wonder is what makes our config file so special compared to
> everything else that uses lockfiles. Or put differently: if we think
> it's important to honor permissions bits (which I think is sensible),
> shouldn't we do that in a central location like in "lockfile.c" so that
> all users of this interface behave the same?

The $HOME/.gitconfig file and its XDG counterparts are the only
out-of-tree files that suffer from this issue, and being outside the
repository is what makes them special.  Theoretically, /etc/gitconfig
on a multi-user system could have the same issue, but the containing
directory would typically be read-only for regular users, which makes
the issue irrelevant there.

I do not see any sensible reason why a user would want to "protect"
in-tree files like .git/index from Git, either by running "chmod -w"
on them or by any other means.  We make files under the .git/objects/
hierarchy read-only, but that is to prevent accidental overwriting
by tools other than Git, so it does not serve as an example of Git
needing to respect read-only bits in the general lockfile machinery.

Having said all that, the patch was intentionally isolated to the
caller's side of the API, primarily because auditing all code paths
that use the lockfile API was far beyond my available time budget.
