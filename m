Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633502;
	b=chiZrE7ZLwzV2rvtlr/rMtlwAtnRRxdjY6fx/ftc30plRfbsJngn7It1el6hTVK1Ap4g
	 gr2z1idATO76eAB/4YbjVa8icTo4sQzPBbhtnOFcizpgEofNzBtpOXQ0yV3T3Z9ICb88n
	 mOX2CXcy6uQc8My4xQewWrvLmvW9zIha8jEdUJ3YAzpOZ7HiLcfg5VKAgisLdp9cjw+Yw
	 mn4RHMj+9F73zo1qyXzbRmozJxb6RXe9b6BesNy4tdwpOve0f0IJFkTV6n5daGLTHTvca
	 sGkuzWca6ebf5dVLfymUQ98XTQyRZHt9Tb6ct9guCDEvrXkbjOmafc3In5cCGTb2psg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633502;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=RWdLJJfqyBckWED1jgbN7BaQObzNJiLlGzAx2omsPW4=;
	b=KWcvLctYzp9lm6bNT09vb6OVBJ2hON078j9b+vv1qWsMDiDO0F2SbVXDTsV702eQSiuk
	 0sbROnfu9cjY84MyQVVTa24WeJX/M1ikmAJp0kAWVdyzyX+rdkJ76I6knAadIZzHYNEJW
	 +zIsmAXWfvK5cTGFiMsMRlpkgf60dWEB2Z6wE9U4gw4Yp37+TlTB5SDijzzY8ueKBS0Al
	 j7G9qQRvedeuuBBSVU62DQd4J9kQPqBn794yA7h2XiaP51wRJgYpkR9f0xTiFlj2KjYxW
	 SZDq1xHJc10bTzMS12XFk/zxW0sOIcSno/66Rm5OUqAtf7BsWIW/bVIb0bE5me/0cSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TjFf6VyP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KWEGq1UO;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E1606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 578E1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TjFf6VyP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KWEGq1UO
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 455AC140035C
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 14:05:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 14:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795633500; x=1795719900; bh=RWdLJJfqyB
	ckWED1jgbN7BaQObzNJiLlGzAx2omsPW4=; b=TjFf6VyPpHFucodST0y7wzkwXM
	NO8DS50BENPcS9fuodxBxWO4xP8BcJrabGvcwzoWEwpc7AKiLzUfBn5w86P6l3AL
	djbMXwqAsnkV8tJibq5E3rf6dJNm26sVcCsQjrsF/2gSKqyc1Dh2iTDndfKj88yh
	plCzuGNxPSDOhlp5ec+uk70bFm0NUXW5HCKPwMEH2l5gIcswnCIB3FFjeu7jDPNJ
	fi+7Awi0hYwHaML/4LxGHl3XJ863alHkveUnJe18QH5mhCQyJ87uN9phOFZDgo3Q
	pTtiL7ikCm/NhXOjfRVIb1fMsgl1sBVOuyw9uWqYouAaMX+eTZlyxYr2YMJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795633500; x=1795719900; bh=RWdLJJfqyBckWED1jgbN7BaQObzNJiLlGzA
	x2omsPW4=; b=KWEGq1UOOS68TqvccW4R2shqjNew6XDRBqjXkdX9guOqqooU/uP
	C2BM6MGmlV5yplO/CpHTqC8TRwoT8Lp8EVzIP6AfSLLyI3eBVVb3JtldThpTiAGr
	ldINlt81u23n/ry5UTJzndrxT9Su4ku2fv1wn/hJY0ZEzUd9cs/RW7SHUd2V1HuP
	Ys+FtPrZMSwfXibq2nhYr5xH+DJnUrelRX9WONwCMsTkV2iz5BSjB6UmVF+c3oEB
	zQ7o8kVgmq6xWUsBkx//kPkA4CYR3PF6bc5/Bj+aCfRFzl1xEvhm56Y4cXN1b8Mn
	bjcBPOdq2NVup1ESgxK7rJ+N1D5eVyqcBew==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795633500; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:OnvO2NHIh7/APe1IqBrr0eSl9Hh/nMWFEK3mYGqaEowgDfw
	QYCoDwtAxa11MBPkkgLvmpoPJDEwpdZcmCVsJ7Hez+xODI78GfOKcQkRzpDChV5P
	vTXE7JpiyK02RNNpFBPRT26GgqrVfhpA3kTeUsfO6snge1XKqGStWqMOcecWbCe8
	6d3kEslatHkJdBsE4hbaH5+3IdY8TzpBBrIUuxOpsAZqbxJYALztZjN4ztGWvpe4
	3n7xD8zH9g52NI1s0BBdGlnZaU9TUNQHOrj5RO+jMwTxJpCqaEQN53BCZ99xiMvs
	TeXujWJBO6r9vVo7QxNN0eCJep3aIqF5b1X/5dw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BxELzjdkf7/XKJKkevp7jitwohirZpLXVO5uOoomVxE=:6WAhNkCwJAWGM1zcXk3yedWH1XkJiZXIoVb/vzsHlVY=;
X-ME-Sender: <xms:XDEHa3OBvrIYUs6lCP9BWaLLELM-PcfyMj9qF1TSs0No5nhPWSM9qg>
    <xme:XDEHa0N0PFIzZw4NlVr5kyEfLOC8GnAXWP6QuRTY9gcipZq_1mA4g2vdNq1_GzaBW
    mq4t-XxdMgZBEREudkXuEp2dyawGFfGFCsCQKRAhWleJ71oga9k4RQ>
X-ME-Received: <xmr:XDEHa4iOOYeKdxG8F4CtjI4McSQX92VQMrF1WEQZCe3weR6RrX8SRjct7WjnWgwosGNjTzvQaS3M2m5_dC2PQsGkHhfxCItpqsd2rR4>
X-ME-Proxy-Cause: dmFkZTF/zHXMozOs5nfUA9v9U4xu/MAm/10cqkD8+dSAyvvcs30ts2IS+SP53ttwt7PfV/
    19BiJ3fPPRTvWeqlFZtHuO8uGJ/BaYf6446FTqEho0+vY+vurVBvniGrhtdRlFTzTC1NZe
    0JGdhjXFDXOXbi+fi2+T10amE2oZbIx4Ue+l2jhg0y76IJnt9Riep+hNRyBO5N0tQn1fwF
    Sbwkr8b8i/nhi7CNCcXiYLiF+y1UfEbUDrxPvajuDHl5PYF+6M6ymjkY5MZY6WOtP9UCQh
    G8ANQINwN3RGXBJdQ1Gi6Deq36LB2Sggqa1gHF7aZHbdCg+7Q9PETVclIVdGRBct8RDofj
    CL1Crx2/9MKZrb6AZUbnFu+UFgbL1T+Bg5irGD6rt4vxqj+oNHquArEZCopSTOLDD/1ga/
    gU4H8b4UD1pIWtGZkRxPdhjJCy7zMs3hSoLY89LTYx84Y/w9168/xdjZPn87ShTduJBbMQ
    SHzs10+McOoeWZ9x29WAqmurrOEGQgyJtrvnq3sUanyBz8+ajQA26TXi/YEK56O7apFzFo
    GVaZJlgb6vzSh04Ih0ZXknfFx7L8KWAdkvRDeM8EoQouWj2zjKA2vgGNTslPcCnIwsZ+n0
    0v+DklRo0qS2g/M3iFBHwVd7T501jGeCx7fgtjngUauvTQqo0qRAns4vvpiQ
X-ME-Proxy: <xmx:XDEHaxtOny2d2dWE-7mYg_cXU8tNq17N0w_N8lg4ENaGQ5QXcny8kw>
    <xmx:XDEHa-RXmT85e4DghTLMB3iSYL2WweWJiGb8vpr2CGXf9_RhGye88w>
    <xmx:XDEHa92jvumpik5IO7-zZRUzjdCQuK0UJ32zxQ3kFjyxGlBtikTZZA>
    <xmx:XDEHa7uu-vYMXhG0KZ3DqLGO5oM5VPpVll6KG9xTvu7mC7WQGSOc7g>
    <xmx:XDEHa8UUi2_3igUqYZvsjNRuMZPZim8qYSJW55PcOoHgUunXid96pTJm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 14:04:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v5 0/5] http: exponential backoff, configurable status
 codes, and post_rpc() retries
In-Reply-To: <pull.2287.v5.git.1795628913.gitgitgadget@gmail.com> (Ravi Mistry
	via GitGitGadget's message of "Wed, 25 Nov 2026 17:48:28 +0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v5.git.1795628913.gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 11:04:58 -0800
Message-ID: <xmqqbj7c3f6t.fsf@gitster.g>
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

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v4 (thanks to Junio C Hamano for the review):
>
>  * Patches 1/5, 2/5, 5/5: Unchanged from v4.
>  * Patch 3/5: Documented in http.retryStatusCodes that an empty value (from
>    the configuration or the environment variable) disables retries for all
>    status codes instead of restoring the default, and that listing 401 or
>    404 has no effect. Added a test for the empty value.
>  * Patch 4/5: Cleared results before each run_one_slot() call in post_rpc()
>    and probe_rpc() so that a request that fails to start does not report the
>    status of a previous attempt.

>      @@ Documentation/config/http.adoc: http.maxRetryTime::
>       +	400..599 range) that should be retried up to `http.maxRetries`
>       +	times. Defaults to `429` (Too Many Requests). Can be overridden by
>       +	the `GIT_HTTP_RETRY_STATUS_CODES` environment variable.
>      ++	An empty value, whether from the configuration or from the
>      ++	environment variable, disables retries for all status codes; it
>      ++	does not restore the default. HTTP 401 and 404 are handled
>      ++	separately (as authentication and "not found" responses), so
>      ++	listing them has no effect.

OK, I guess.  I would have said, instead of "handled separately", that
listing them has no effect because they cannot be retried.  But the
above is just fine.

Will replace.  I'll mark the topic as ready for 'next' unless I hear
objections in a few days.

Thanks.
