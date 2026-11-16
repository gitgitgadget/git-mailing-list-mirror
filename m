Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847899;
	b=ap3j3xeO71M9niCREFmy4S1fbeSbINzws/ADQaBIolSXsp0jvRpTvHRHO9rWtQDuM2dT
	 zryCSlPpRWgbMBVXdpV6OPa0YC+u+rQQaHDu843U4/vMrzQ3IuVfGlZioF6Wqry0p/3yI
	 kTaQuC+5bhmAY7VO6/L8XAtr4BtFs/W6h2cdQx9NqHB9uvZWH7Bwizpa4G1oi6K2UC0NQ
	 U/pNLtfsPXsEbPzRO161GUVkc+QZ8DRUMzteGT5vfHpJ+u1UJYRafXmeaZ0BueTJLVyAe
	 ffkDD+cLLIkjNIg9Y1wgBEvL+xTKaqkAF5U5ClhCMG19lenW3DfglKGw7Q2Iov00GlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847899;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=a7QmH3K/cgC+sY664dUwhLTryj+5IFwrzIiM26BD2t8=;
	b=QFE5Qdsevbtl+nfejJ++l7v0tGwsI47laoUnwd1NQO9sr08LlbFom+ewq7G/4LH3YayL
	 gVOqSHVELYraJUj9WSWZ2nHXVXaDh6/9SeWbDpw29fbGLNKWxXpLCqgEuWpQU9x6Po1VR
	 Ui8TY3RmloZ8/S3TXX4W2yiQMEpwnIWQfYuKDqljWrnWG2SU+NHT3DYKedclvQj1fQRsE
	 Dm76lpvubes1MGBS1uKrNUExDxdL1ykrDvgCKEN2EkQJq2cddDETEOAtGFcs9Ud+TMzY0
	 ZYMqHsyhziQ+3adtO5FgQGrjr+4GZBjwQwqrIgORmN6BwtdoyyqzPDlpPZamisVSDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D2gWZqpr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sD5PqnWW;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4B606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=D2gWZqpr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sD5PqnWW
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 99708EC0594
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 11:51:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 16 Nov 2026 11:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794847897; x=1794934297; bh=a7QmH3K/cg
	C+sY664dUwhLTryj+5IFwrzIiM26BD2t8=; b=D2gWZqprgBcwleEGt5gwJ7pyT6
	+KM2VUAJm3csyJqQ++W0PPjwUB7lN7LN8Oh+M0IgdfQ9L0RvyY23NP1xOTMRrYQK
	vGNdqKKQlfI1dfw8O1oXozwRq18TSDAiWkM8tKuN4M7MlnZmwu0jfeEV7WtOREvJ
	gZ1JvK5Fhlq4n9LV+M98TNqMaegvdXN+ul+9FVeFmk82RFdjB4vLQyqurJck0Kz2
	i2VSDmmxd8PoF754brezlyH5x1E858W6iFpHbs5TRYkJaFo6ZnXfalc9dJaCjdAq
	2jsmIFhvfjzbokE4q8uCRfB6t1qNTDySEc+lEEBWAF4NLlvmjn69MQ4eiEBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794847897; x=1794934297; bh=a7QmH3K/cgC+sY664dUwhLTryj+5IFwrzIi
	M26BD2t8=; b=sD5PqnWWsLXdwk4/tsdqEV/RPgiqCQ3BLB2TYI4UVoJep3epR9t
	51LY1YaO0DQnoo0WHxyZ7Gwy5gzKzq+CrXQOPwtMqjaC2MOLJ+Ey1vbrzCjEb2U8
	33z1lfqebglhw5WiK0n+6FpBYVamm6S+6Rq2DSniBZn9uyMikdRtzEuMToFbGGuI
	pdneFgCU2T7cVYYLSKmP/eH5AMC+vgw/iUU2h7JpP2LCCwE7MIKo+wixYmCM3w4X
	3RsDMRIdDSvsj0lmTx1qYVO/ID9+f9PaTo0gz3YNL9XuwMJGl0KcGJksxqmpL8WN
	ECrr9j3nN1fJD+YQRNeo+1TwSPkNyYkG6Mg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794847897; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Zj6iyvqoW2mkPVUl7MyMWSTmarWNxQNavVShxj3nshJ8HV8
	XMzkY40/5U1cok6rguHddS2QQkvzGN6ds6Gglj1WDPXpGeQlHKjgHsiMCXHAMmDf
	NW+qPu+SXX46nvH1o/GOtliiiYoYKKAdzwq7PTxiWOYbyxNYy4VMfVJg+CbF/jfY
	lfgaAxXKoUg7PZ6Qj9pnBWg7Ab7JsBX4AN331aSw8bVJ7D0nueg4Ey6cymbobzYp
	/X6Q15kK6Y4pyboailQXMsuu2Fao1IKzS6dT3Cyd26AZnVvTPiLmYDeON58QfUVf
	k0bz6iQHol3Pj2qI3OKpOt+cFg8CzyoP9oqfiKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0u9nuUezEYbImS5eCE4Hrn7TrRxghtQuq1qvwia/sw8=:Vm1bGgc1X77xDiYacGekVLolfVHjqx4p8YuZxyNT1C0=;
X-ME-Sender: <xms:mTT7aoKtCXISkda44OQ9w0chMaiOKgQZYK9kaoLS1qraOoa2Sypn7g>
    <xme:mTT7avmjq6Hg0yFIeyg6arEsvduBogvjN1kGv6X5rSW9PfcdMJGgsn06y6dqK3Qao
    5YA9b2-JygIwkpTqNZ3qrH5dXm1MraVAUE84zmCENuoaXzMfPdydTQ>
X-ME-Received: <xmr:mTT7amGPcFfK-TGqy9W-EFdVJ5BMjHdMKtYZm6UKl0UX7e_9Mzii5YHJ_wYP1ZJ8N0BN3B-_PsMcDq-aC5o8R2XRK50uK_JnB60a>
X-ME-Proxy-Cause: dmFkZTE32gaIfkmtyQR68NXyXisVum0GrAxB/eUPyWAily7p2YMfSg6M4Ozrh9GL4fViQa
    KcO1Rh2EP4S7H3hgQq2G+sbbDJ5WmnJtL4uHMNvLRfqgXBoYmQ60XVNELQhhG8ptF48qep
    3tv0LmquckPJZ7wmSJIwA7SjDp5WIGdofDj69F3uwmHP2YvqJzuYgDqiH6sbu9ZA6+wDaW
    OBcFSoZFdRoqItPtqtSr+Q/jgZiKsxhrCCWJ3pFS0Qg2mLJh4NqrpFU7ntkFNqov+JcEWE
    E8uitE54hfk3V5FLoci03xl9+iMZMtolNoN/9P4/jqcV5ZH0exu5CV3BcoFuHE7aqzjwcH
    MTJHCwQvV+36r/UnKbOOkNBLQExqbWbofANViWVbkwvtIqqaJcWvMnELVQnMoJa16M4Oo5
    Tdw8G9VwYeCoWOcf3MmnZNk+yfqYWpj1jSe7JCEbG62DcK4ZVrt0Iz5eholH93+bU3Z25X
    mM58F/DrutJXTOcXw+DE+XIVIUqCjmMZy//wiO0o48R5nuRp7qf/DFYUDOf+8jv/vPMbph
    zW9ne91m3vhndkOpxFeHBP31n0oPmOhkovPaHo0kOeajxmKOGdAdI4hLK6FLVNjFRq6pzc
    BZPN5NGfDwkV5tW8tRUG7XYfiIiVTwprhbIp4NK28ssWTlvk4LCcTn5HFfyg
X-ME-Proxy: <xmx:mTT7avG19I-6E8Ww2OAd0GbEUS5cNOylwE7ogvM0nIIN7_uduy6DuA>
    <xmx:mTT7ajN5NUmoJfQHxdROxXU6s7NQFcywBkijb8KTzNbIKdgHoN_tcQ>
    <xmx:mTT7auHtPTbG1d6CVvyUslQlGSVoJS7MZUmkxC6WUpsBYlP5flqNHQ>
    <xmx:mTT7aqN4VZNVFr8sGEdBmkBXuO6bA_nsIQ_NuJwHgFc4yyM3bDtICA>
    <xmx:mTT7anmft29exWWgMF1HNWkLK6NcDqJM8iZMoimkatqBKxUFCZtlNb1q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 11:51:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] read-cache: use istate->repo in overlay_tree_on_index()
In-Reply-To: <b7abaeba-1dd9-45f3-ad63-e43c49ee48d4@gmail.com> (Derrick
	Stolee's message of "Mon, 16 Nov 2026 08:11:33 -0500")
References: <pull.2315.git.1794825269464.gitgitgadget@gmail.com>
	<b7abaeba-1dd9-45f3-ad63-e43c49ee48d4@gmail.com>
Date: Mon, 16 Nov 2026 08:51:35 -0800
Message-ID: <xmqqtslglnxk.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> On 11/16/2026 5:34 AM, Srujith A Poojary via GitGitGadget wrote:
>> From: Srujith A Poojary <poojarysrujith@gmail.com>
>> 
>> Use the repository associated with the index state when
>> resolving the tree name, parsing the tree, and reading
>> its entries.
>> 
>> This avoids relying on the global repository when the
>> function already has access to its associated repository.
>
> Cleanups are good.

At least this one is not making things any worse.

But there are other functions in this file, like add_to_index() and
refresh_index(), that take istate but still mention the_repository.
Cleaning these functions that share the same issue together in a
single patch would help us reduce the review load and patch churn.

On the other hand, I do not think it is a good idea to try losing
USE_THE_REPOSITORY from this file all at once.  There are many
lower-level functions that do not take istate (or repo), and it
needs a design based on deeper thinking (which has not been made
here for the obvious reason of not needing one yet) to decide what
to do with them [*].  We do not want to see such changes in the same
series of patches as a mechanical replacement patch like this one.

Thanks.


[Footnote]

 * Passing an extra parameter, either repo or istate, to these
   functions may be an easy way, but the overhead may make it a
   less-than-optimal solution, for example.  Teaching ce which
   istate it belongs to is an absolute no-no, as these things are
   born without their own istate, and are transfered between
   different istates; besides they are so numerous.  Those are
   merely one or two examples that need to be considered before we
   know what the right approach is.


>> +	struct repository *repo = istate->repo;
>
>> -	if (repo_get_oid(the_repository, tree_name, &oid))
>> +	if (repo_get_oid(repo, tree_name, &oid))
>
>> -	tree = repo_parse_tree_indirect(the_repository, &oid);
>> +	tree = repo_parse_tree_indirect(repo, &oid);
>
>> -	err = read_tree(the_repository, tree, &pathspec, fn, istate);
>> +	err = read_tree(repo, tree, &pathspec, fn, istate);
> The only other way to do this would be to replace the_repository
> with 'istate->repo' directly, but having a 'repo' variable is
> just as good.
>
> LGTM.
> -Stolee
