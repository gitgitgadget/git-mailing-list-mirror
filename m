Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209357;
	b=VaUjMTEFLo+DThHNJooMn8TtKj/5Kc9zTXEUzCEJPDZ6sz25zDUo97ZDk/evyeIAZ7Zx
	 c1o/6E3wTEACybmnXjDNCHo4p6d92VbdPKjMLNtrQq8LVCaueWPgWMVOBInj3CTC/ta07
	 nwhQLan+I7ywwjmbMsvDw00rTOYQ5WJC9uk8c5U7klfNO/uAvbRlrLFacXJnRV7NWpiLX
	 +JbMlUL5Q6E5Ci5EhC5vSUXlJkQpXMTP/ERPISMcICl0mnwPFRAn8WhSt6+yU5uzA0scZ
	 mg2gN0yiRmK08eWZKYuQ9ab90DNyPffw+jh7H36qh1P8efz8UqrzXD8ScXJMFMP1Z9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209357;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jN6OrdwOlRTiPg76IRm/vEf9UWwI+bO7JQ8lry/09uc=;
	b=zzS59L04QjEptS+8XZGFVlYUrxbpzTILpOjlMt0Z6ihfufhF6N8Cw8ONarmWC2jz7nkZ
	 9eYYiWnR0B4RL2n8vh7nCmTyss6MNLDUZATYoe8adjBj3t1oSAOmFM56XCVlseMX0czpB
	 rKvpgdkZd5+Q4Jh4z9CdkkDDzOYFBj7IJ8ODt7q99s6Ph1pnzV1gbO8NHP0+RQVqiOoBi
	 w4CGHo4GikxZvYda1rDP3DK7WFIyL0C5dLZYMNkYNvhr3BW2r5V7+hYFmp9wG8min95Rv
	 yX9j1Bl+Ed+FxxEwtC8UTe1FLrV+2dLckT5Z8GAB0wkuUM8OD37Ne1QDmeAMaxFZQdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OrrP7jzL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UtRgoi2m;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14393606A31F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14393606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OrrP7jzL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UtRgoi2m
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B87B1D0012F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:42:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 13:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793209355; x=1793295755; bh=jN6OrdwOlR
	TiPg76IRm/vEf9UWwI+bO7JQ8lry/09uc=; b=OrrP7jzLvDeGESLpTIwCyKMLkx
	NlXM+A24CoaZ3uO0XpTq4SGIEULQpYvKJcxaggAo8/ocQr8VhABz9Fn8VVvhd+0e
	JwItuooefzHTdySseii1DA0yZD6R10Oiil2hTFb+4uTXAz7o/zCLNubBDb/bTfT2
	K4oWJapEIFjKXISQlqpBhGuL+o0cngMX5sFOETz9fKWFe7NkZCgO9bZbOBCwREUx
	m9tO6CibzK/qtdROjbg1vn9GJ6PolyFXcaT+s818zJ3yhfkc+Ls3cblncHDhC7KA
	+oumiNE9Xb4xM6AHvKT3LLwMYr7BKrQ30sS+7DhuyZ/8x1r8W/VdpLCfBmIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793209355; x=1793295755; bh=jN6OrdwOlRTiPg76IRm/vEf9UWwI+bO7JQ8
	lry/09uc=; b=UtRgoi2mgDJNfkQ5XqJMJNasYUPLlXkE8y8jeEFLUvlGK1hthb2
	v8qfFzfNb6mbS1YMMsp7xJFq70NQEdLsdm8gr/e+GZ3czyH2nPrMe5xQtYbzmc1p
	nSbFJjsZtiUPo6BmNcrxuFKLxbSTwsSbktQ9w+wLd3A5dRsq0zH1u3taKc3gJsse
	rhnQqHqyoQ5wzdtKvMpSu3KSWQqbKr7jOrsnPoq8l6XG2yZ57WWd6gzZuZ2zvnKD
	X30wNqGYAwhTCFM7BKvnLIus/rk7/iQWMWO1We63T1BNtjclsE2aZ+bPGKCTC4Y7
	bmvXFcJVHEmFFelDTztuW27NlJlLOklS1nw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793209355; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RZ6hFH6FArZzSGXBjfHLoSaOoUb+CpJc57ia8E3Ra9HwvpU
	BgyO3mH1fKQdt93/23frsiYgdRZhlYoQZIcTpg5ptOxQiZgAMV/vRfmqQtUakvbO
	QDsUydlDQ3IgYnyBFmLW6NYzuXAhJDLLypkoWqH/nTASQ2dplExZt70rJQA6J/9h
	k3PvLnVr0dgIvgxLDqpbp9e7cmPPeZi1TrSW7MtMq4D38A+QguQVN78iEugeZN0Y
	3qCk2XsThfvLZmY6d7sbdrtKJMnnPkU9ytsYb1hebGieLCJY2cCtiTVIL8NKld54
	V9NpallSrs0P5FzwEW63BeRVoKvuAvQzGY9E2Sw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kQnegU6f1ElIkozZ89W8xpyTdefdyEirtuhdeG0ZVR4=:O0uNXdCszNcoqysOniJKVRXIY6i/IzMivYQUFF8fc4g=;
X-ME-Sender: <xms:CzTiaqOCSaCHSAVSW_b7v9ig57xu40fGoQe1kM6LtSb5FerYtCGDIw>
    <xme:CzTiaspSYAozM7FRoAsWwJhJcl0NWGMN7dy3XQBt6xKtrZgvlxhscys5kelqIse5c
    DJzX8tPp-HqTkFk7qUYEk1CmA5RKUySqoN3170sfXuXUuJsku9xpQ>
X-ME-Received: <xmr:CzTiarEWYLw671DkYeVVczv-WRepqqvbnGULKthrSTs5DTw_ELrO6I3UHjg39FkfSpjbUnESfPYqakT3u5R6rms2fB0NvhJyCHEf>
X-ME-Proxy-Cause: dmFkZTGjzkA2/EaFJLiGqamPggZzm0Sk1Bk3nV8ypq0zvBZfMQaNjIe4O0ETUXQiMZGclK
    biR6OVexZoiHT88mqEW/m08Bmxt52/XqVY7NSUPqWSGM+Yg1T18YaBWxfakKhtS2VIVHge
    mVhhF4dEJ1uXc/0lNHp9hPhqnM8EMdF1bunSuNMpDn2KHzpeguSjP4taprzk6lxjbqjS3W
    XgjmKqp87qfwR93uXoi4JqcYFTz2mn63hav8qqrScWeCdwaXeuVcwq8yPyIVOZa2uv2WU6
    Ri6+m/DMCBfW3knvSydg+c30jFbA2LoJ9Wy/GVVVvfE1GqOy3mSRmbmqHNVgZla/xo3FjF
    Jaq/FfB2n7ED2IcD/M3x4WyDj7Z91OIYwTu2Yw8rcvGOKtpBM+W1FqCBG/aQYColqipiWT
    CAsB58mNAOaEjX5eh9V7yhUwWr/EYUQ54xcHSJSjbYr2f/1CyEBq7rw6Py5VQoXP22HjiD
    rpk1V3hvEByMrwSXrTOxygFa7hh4vLKjdZJ8V3Lynki0HxPzPir23s8Nj80QPdk6mFgMXJ
    2OXQhTZRZXxy+0N0JBHbGfcWdDXbvnYZyO6+BzD+OY5ylDeam/nLB0He1uVvbX0mpHmO9N
    /GGZYbMwmKXjIzxMF+NhmvyM7euAu4RBKtA/2k+9oTbZR5mxRsEiEx6vqjgQ
X-ME-Proxy: <xmx:CzTiahofZtbTxOm9pPHkaaRAbcN0kaG-iq2wDiKXZz2EMLwm5J-DTg>
    <xmx:CzTiakZp2qcydbUZkqp9GFSUUdnM1zradeG_LWGEAy4bJ4w-O7EsQA>
    <xmx:CzTiaqXVSwLPcVOhj-5kr020rG6W6eAcLt0eH6jbcq1kyuMKLUGz_g>
    <xmx:CzTiat-rYDTAEbJOgmwStCIKQybDCSQd15Kl1YnXh4snEJ4zvy_Q4w>
    <xmx:CzTiauwgRM0iJv45Yobrz7AKkA9I-g8tsJoQwI--Af23xy8zQaFHh3kh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 13:42:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <241e7bbc-7144-4ebf-af76-84a06a982574@gmail.com> (Phillip Wood's
	message of "Wed, 28 Oct 2026 16:16:13 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
	<CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
	<CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
	<CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
	<xmqq33ttxw9h.fsf@gitster.g>
	<CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
	<xmqqcxswtqd0.fsf@gitster.g>
	<7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
	<xmqqbj8fm54y.fsf@gitster.g>
	<241e7bbc-7144-4ebf-af76-84a06a982574@gmail.com>
Date: Wed, 28 Oct 2026 10:42:33 -0700
Message-ID: <xmqqld7hafhy.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I was hoping that with refmap, the users can tell the system where
>> to store them.  As specifying a shorthand also works,
>> 
>>             [remote "cabal"]
>>                     fetch = master
>>                     fetch = next
>>                     fetch = seen
>>                     refmap = +refs/heads/*:refs/remotes/cabal/*
>> 
>> would be an easy layout to allow adding different branches than
>> having to say
>> 
>>             [remote "cabal"]
>>                     fetch = +refs/heads/master:refs/remotes/cabal/master
>>                     fetch = +refs/heads/next:refs/remotes/cabal/next
>>                     fetch = +refs/heads/seen:refs/remotes/cabal/seen
>
> That makes sense. What should we do if "remote.cabal.refmap" exists and 
> "remote.cabal.fetch" contains a colon? We could just ignore that entry 
> but it might be better to error out.

Possible alternatives include 

 - giving fetch with dst take precedence over refmap
 - storing the result in two locations
 - error out not knowing what is the right thing to do

I think the command line version, i.e.

    $ git fetch $URL --refmap='refs/heads/*:refs/remotes/alt/*' \
		refs/heads/master:refs/remotes/origin/master \
		next

stores 'master' as alt/master and origin/master, and 'next' as
alt/next, i.e., takes the second option.

Thanks.
