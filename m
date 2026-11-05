Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907958;
	b=lBTFo470QaFZcSucXhBuGTp9abUYwkdCjwRB+pKAiczGuiQkb27ZciA0DnlnByPs284i
	 iKdTctTsI2odx/FztFWjZN6rIdVaxoEFjKHHY2DpczPZZOxYMz/LowUHefxD7XnrmcLah
	 YC1Ex5umx/XiFjbxJaiOVSe9p//XQHtungKm4D1/VEZYb+z72gaObe8geX0VvaJI0hmc3
	 lv/Snzi8X2H5jNX//fQyqW2BnqQsodtEnc7NYD0iymJOi4lLLEXaNyzw2ww7LeFb2KRFC
	 wqIVcn0/aWMc5apRHfaF8X6uhwMXMWjt5Q5T2MxwRYmLWHpwQzmk2/5ctkh47zLl6+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907958;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wGHJVApLX+zeeZpERIBrb9rFU74qzx4CHrlB125oa1w=;
	b=an1osBqCW9ilxZd5Q509kaKUCYpz3fW2g1C+A8g04ZGj0cmB9B9/Gvaut6byKU3YwCGt
	 oYbanonroET9L4IPh6+qEfNLDpXVph1jjD2oAV4H7sSk3UI2y9eYChToNyYesVhfFna3k
	 BYo7HgoUxqlg9FGKnu1Due96Wc3W1+h0cAZcUs5DQkQu9gnVNIDIxqW6eWpYSpUhKrd2c
	 bJ18bXtRd1w797KmF1k3TCBfpHh1G9Wqb6OJNONgwJtd8SQa+5tjAyGr0KDy1Ibmsvnsh
	 biIDHDVGDY9T5ExWR1FUrnuMkqNvKejsfqSBXzL5PVhXFwg4UYl+nzDKhGe/I5gYmAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Q5o1S2wA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3ZYzZCjo;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A7606EEA4
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 290A7606EEA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Q5o1S2wA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3ZYzZCjo
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 600801400170
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:45:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 05 Nov 2026 14:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793907957; x=1793994357; bh=wGHJVApLX+
	zeeZpERIBrb9rFU74qzx4CHrlB125oa1w=; b=Q5o1S2wAgGNs0duWMDumh3cbAh
	9bc1JsHbP7XC2kK6MuJSA1djVgvysKe3CHhFMmv2JJeEfNgGxKIlimQ9WeDp2BZ8
	L85NPQnpeEveJ7GJmx+EtwfpBAG74NQd27Q3b0Fq/XAIHfRz4WUZa5VKiANavhUb
	MnnfCezKSHvcU/SlteVElS4I4jP/V946Cm1IFXkgz4ki+8g4XCh+9jgBHU0VD6Pa
	zSP03QNzWP2EyeaOcv13JrEbs1mP8vENvokjf/f2kjbuuAaxjFDbZDeAd5eMI1vq
	kKTNFJlSfR69L07Bi67m14eto+W6S4o3yaD5v9k+pOXOSBemLsLyoIgDFBfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793907957; x=1793994357; bh=wGHJVApLX+zeeZpERIBrb9rFU74qzx4CHrl
	B125oa1w=; b=3ZYzZCjoqvS0SAoPYt5jkbyMI5MuPdwBZGrr+WOxccRN8i6uRCP
	mKYdOuTaWt9pMR4cdYrjtINA31bOzkwI1dBTw5zm/2pb/Kqtcrkkpjj10ZL3Km17
	kf0+YxrKJ3o2FL5zBR8yqFNUFREoPDnnJqivc6pic4KKTroO+rCD24kLQjk7iWgP
	zxh5HYQi23LTK667sQmetmcdhpJIA4bncZAi1NvOndaAG/lAAdv096fCKShOdXYt
	BqxJ93KvnYbkwE4+DAjoUqLXq19k2wjYmMkqnLmDr1OKVmlYKKD76D/VwwrmghUb
	LtPFu9d1/IUvNY2zaAaUOhoE5tOBbBg79hw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793907957; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bJhfiGsRQmenOUIMjlx5M5eE4UMgxCMIYH11yVPjc31NZT2
	He+jfzdcUEYdRrdCvIK6ahABaCthpDzCPz9p+6kMcjrykmPXSue/M9KWFmUVp2sv
	AMOS0a/Q8EFWhnHqr4i5ncDLxPD1hHfRKWnXMt8TAN3X4NYKj3avYsBI8nKKeiFO
	oWEdGxdFMo04Ftw7nf9LwAmi75eulRiOBdA3ou7pDi/C8RdcThp80hcwRTfLHAFs
	U5HsIIOuUGrXPXKM6T5bWAVjCH8W/cRpNfloCio4uWf6xKD259cy12zxIkKBNPFg
	x95LN0MhQ9v8oDAJ64+Do3QBljH/5mGdzdLdiPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:f6PMCkGh2t9jVzyyovz2Zg+ZLwETnc5vUWpxCBTizDY=:4SMQt1HoEmFqQOyl4TfhWBZNaYA9Joh5b9k4ZMV+GM8=;
X-ME-Sender: <xms:9dzsapMhdBYe-grPA1PTXz13MJrGemEpq8YrQ37S7Z9A_VMiJXCmSw>
    <xme:9dzsavqekUqc3XtBSMjrDa_YIwkoU_8stTBb0A9fx1aeBnkAFkcXege52jneo3Knd
    bBrLT5cCY4hxovXd9wwk8iWmC_Ov3I400V4fBB-33uRQHq935kTfA>
X-ME-Received: <xmr:9dzsaiGnEDgbtDDyGT5zw0EkmMoFpgU6mVlTxYKb-5AanyvYaE6GWAoJh-loGk5WpBMmoSY4Hd8fhGEU2sec5UyAcYlyegnKfKWv>
X-ME-Proxy-Cause: dmFkZTEHlAoBFy1iXW4zUfRBfuUChww1cEjiySGt8Jf9mq9kkDf+vosSEqn/5jITMsspz3
    W9mkvHqTgXDWppqeY/ldja/VOxHFcGuGAI75g/NS2zJKWGNSrwofdiNFIOkC6XK3iX9icf
    rLCYbqUyOZ+SFNbndSJjGK3IoFargpiswZ6iLe70mcewVPZHOEoS+VHN7Avw9nj4Tm8fvp
    PfQjojav+n4aXbduKG5+V/W3+3ewCtxRGI/k00LxlgXLMFd9VvJt6jAVYHwcS9/6hc0XzP
    Y/4ejKW0hBUgVKJEMDemGCd1RwcN6ZWR26A4RgfQAbYwkWifO5sSLOxuuKxpRmKZJESaFA
    aBLx+LQhoggu5kvygV2yshLxjh/A9YgA39aDalY4eBsf3WdtyiSTZcYsF5CfuwY6oE9Wan
    J8r5Fh9fuw6nHf7ql/tFG6804rwO4j2SFV4UCanlTKBKfD04fNJDtdN9bcjvVXKoEZ8nxL
    ne7GQUFm3JCgaMlfK+nPP7jKdZ9ZHeeEQXTduvZha9oBQiR3+ZKGTxPD0oTkKrVdRcZpF2
    Pj8TkNe7sBaZtOJtpnJ8BGddYDWKVq0Qhar26MMgoufeWELRozrPOCWzmPlmCTAsa8V1i4
    henJVvx8egKpDcxVGArT9dGhRymFpzqs7RxQrB6eeOk33VyFtJB3mq3ZyR1g
X-ME-Proxy: <xmx:9dzsaso-mGnHov-A7jEYKnW1NtluqpRUWdpG_Dst1017f_pk5Jg1YQ>
    <xmx:9dzsajYH6jLZMqTuPmm-TxzdPbBcNgIzJcwb2SCg0x0Sk7dARq9eAg>
    <xmx:9dzsatW0F_k2zm9xhQDHNvT1BVi4EvfLDNKctHm4JeGfXH1QzYTRVg>
    <xmx:9dzsak_T89OLTS0AlqihUlbuYbQ_sl-lnKwYkBXXbYfvc6_K45TxUw>
    <xmx:9dzsar4ngZg8RYQKNmoG5VkV2-oEbsqQHzaeNA1y6xMMx-msDSWyrzKk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:45:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <20261105172358.HxmMJ%taahol@utu.fi> (Tuomas Ahola's message of
	"Thu, 5 Nov 2026 19:23:58 +0200")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<20261105172358.HxmMJ%taahol@utu.fi>
Date: Thu, 05 Nov 2026 11:45:55 -0800
Message-ID: <xmqq8q37t630.fsf@gitster.g>
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

> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> wrote:
>
>>  --------
>>  [synopsis]
>>  git diff [<options>] [<commit>] [--] [<path>...]
>> -git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
>> +git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
>>  git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
>>  git diff [<options>] <commit>...<commit> [--] [<path>...]
>>  git diff [<options>] <blob> <blob>
>
> Sorry, that breaks the test number 0450.218.  Please change the synopsis of
> "git diff -h" as well.

Ah, good point.  Thanks for noticing.
