Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501457;
	b=nmZ3cYeLm0bv9rYFWgJzFBUgmS3LW0rPz+VhSi2Sb/ldn7Q96uilhE1nIJa1kDrUM2uK
	 NG8pBovP31fETbmMeWEo5SzTo7lIFE2T2ea18OVkORReDbzHjQnfqja1RF+fULQ7MO8Qq
	 QLt0tu5zW9WOI/woXMdFJC1J6ONXNnpnsSCkvUiZmCNSuM2ud6Rppem80dfs0VdFmwOu+
	 ZGiJXR8A0wUk8+cLi1ob8h1glU6H+ObCOoK0iDYxeSd3+VKjk7z/aHLf0uMYsXBjcPoHy
	 jYV07g7BhnAt3QHz1MXP3wZnruEkqTwa91asXwxhySXDtHrROXgBRL3iWCOo7byIiWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501457;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PLgRu7/waUfhVTYFjG+iMU966WEN3cykhyC5tbwIWNs=;
	b=06AGQ0XgYoDW/vjoCY/kCDwqoHuWRg1mj217toJ9fCQeJ37mGHNB5jJ/qK4t8qbipV3A
	 xeJnZr1RBAMfvlMoo2/Fxi6lRqUwTvUO6IXOhCs0rumx4yY047j8rb1eq0EH4VmMHUSKj
	 58Pb+IhPzjnTc8WXqHW5Vuym0mYWiLSEb9yKCFuzcExYU7augT0wAtZEBc+3odg2I1sCo
	 0L283Nd/WT7aRYSxK0z3eKA4SFsxonEvH6y6lHOG4nxnsjWti/ps9E8ahA5kW5SXmQIwY
	 QsB0D6to+S0RgTeabbZhxOl3Ek6weGtOPNv3eI4nHfPTd0JKNjnzDOCVUtvEGV+WoVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=DC5vttPS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j+6MIuMx;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E14606A880
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 16:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14E14606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=DC5vttPS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j+6MIuMx
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3351BEC0108
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 11:37:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Nov 2026 11:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794501456;
	 x=1794587856; bh=PLgRu7/waUfhVTYFjG+iMU966WEN3cykhyC5tbwIWNs=; b=
	DC5vttPSTVbcgXvGKS+ZRPZKWsrqtOeS+O7RVMTmanSyXs7k9/zZrgcbnx93aqhe
	sqtLKMk2Mj8cWuVChbNAiEj7W0QdIeVkCOsutuuKaFIgggZzGaIWiqhMiqs5bsWz
	Lor3s8nzHkfYSqktrgNr5CpMohGcPvHW51ejc67UfTWt7chCGTz1Nuu5f0/4/Pj3
	RGKOFwrgi1bRWFsevsRKzmuusTKzOZs88t4gFymOf2/nfJYwFWQVEhlSBVanhye7
	L/rwgqBGu5Gyg8HgGuBx3FQq/SzWMcGcxME70rJ96W2bSlHeTvKx+3wy+Snc19eL
	DQDgesPO6PLVlDlEv5Hu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794501456; x=
	1794587856; bh=PLgRu7/waUfhVTYFjG+iMU966WEN3cykhyC5tbwIWNs=; b=j
	+6MIuMxCEDvCh8rVG5EA0E782rFAQLcxF+kHmXdDYqoEjUGDwnhaHlfKI0xSWRhs
	BYQJwKSnLKYLsaz/SL5fQNEdnR64U9z+wfSJsBssPekQ8oFkrwqxBXiOGreCxD/O
	qV4JzMwZMeLkT+YL3QEI5vqdO0FzIKrANzzjeWBFmmjJCAoAA9ZHsPqhorcZapPd
	T6yx0TRa/0aFp50sONhxNsgfv2dBUkCRlE1NXXN/Mgpx87NF6S7AU1BJkYt7Vp6r
	T49eTvL+ryg10XIVXRabwkLHgCvHdYIWHuESmI2S6jagDn/D+bnrgdDfcBxrWYQW
	m9+FhiYJ7WoxdLWJ6BgVQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794501456; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:V6qiMaRuJdNpXWEOppsDvu7Zc5W/eDAttYc8BPPv7FZPgQk
	HUQqJqpmmQrfZO5rSNfnu5gE37OOkpo2dSR4wikMsJ07wmNkpUWYvdFJ/UAtKi1a
	o7QVQIljtOcDOWcROeHQqY/1I0OuXotXplCWQLGQfSFln2Jvjsec1LvvbrokQ7Tb
	D2YTzJVH5M9AR1+wGUaXFDliEOsAk8tKP/Fb0cMr0SSkf4XTjrPmcQiOjEWn1vev
	cp75j2SFiWcHiiFahdKpNpcyMoJKYCLPlCd/opF+wZL45mGvQImEuw9sDvZfkUrU
	hd0o3V3UUA36Q/lhQ7brECkcum02xzReywbhYIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:STet5acxk93paVwELsFsBJiSVNt30Dxu61kTqq/ruTk=:xH+MwL4yW6uohm9dZFNLTBsfmxSqXdrUWVUMeqG07BE=;
X-ME-Sender: <xms:UOv1asQ4K_GqdVJiR9Phs11fdLFmX_KdZ_szKpf4QEzyrGM9_kpx3Q>
    <xme:UOv1agoqROyZ37e6-qnjxxoQBHIMCbFFe-iyKdeMf-gjlkqAmNZh71bA_BoLU4YKe
    s7PXn7l_Om9wVd3RUHCCmKhWfwuEGaUfwAvyPJStrzBr45qIB-DOLcHlw>
X-ME-Received: <xmr:UOv1aiJ1FecIGaEgAsjDlH1JesbXVot1e-hLAnvGXo90wOEX7_2XoiaeCx7UI2zMJwZj6ckrVJW1qUoHREKDWfI38cT4iERexE3jy-7cmrgaPcI_xQ>
X-ME-Proxy-Cause: dmFkZTFK++ljW/Z5KIlHBUuo14VhTIAmAYwDJQOVBZ+U8K5q1boLA7jwZa4E3Ga36opTU+
    UJ9H4krj2eN6OWmxRChsEblWX1DGsVUkSgMxrT1DrXsFzevcnATynCdf5pgWg01poKc7RG
    PXR4GjsZ5vMqkRHKkUzeraFSfPgznW3npw4/pjLY1vxynmQkM7foZMQyTwEsMgMkCFOLlk
    RuRKyBtvgRSJsMyOmVqm1PigwBuTZT6Mb4PYSYOUnEpX8wh+DS8PpBO6GjqYKBroF6b63b
    yLyl2z8l0N7aepJrezbhd3Fb+VjramQQC0sNg5gx1RI/95iTfLI9ebwwv+nQ80UyBGKal2
    D2CcsvmZNvBzZY07DiH7tzUd22YkSP9DvbYceJARxrZmDJPZcDx3nLWov5mzJiUnBYwjiD
    sIZ3+w5wi1ePE8kCKROs1HYrDNasNCuKnU0Z4BiRguxgllwUFy+GjY7Dc17OQ2Ly1cvCFG
    C2UuFSfn4HvHtGprzGBd+lsKuqBrRUQQB6KmXVHalOGKwYu2ZyPwVXU8S2c0dnRPhGFppr
    zhJO2B6bqruFQnpDeCaWykbGff0ksGc3Lau8cl5IktaCdfvX14dKKsS2IjGADFT4iYpvqt
    raJxCCt/iSQ6w3eE1wIS6MDARkitvIPZsjR6eSFvbiV7uCutCHAwCtgH+q9w
X-ME-Proxy: <xmx:UOv1arqVWKhrE7yNGxCJhyFkC1BFcbImxdbHmp5sIVNFVsPJ3P7QWw>
    <xmx:UOv1aiyZysx6u2OFV2hBYw3MOMTCcgJBfqwEg9izBtAr559ZQk5oNQ>
    <xmx:UOv1anMZbZgun-kSJKS3qGrUTVth36X82GuO9j3j2tDksskaXkYgNw>
    <xmx:UOv1av5vjnEzWuQKNfQzgEJXxchlaWJF237vmAm3eNiGg6usVbSXYg>
    <xmx:UOv1am6k67GuPYgEfpLUyhTVK6jqZgQyQd84gMQDU3Jqjmx1S_EzJ0uD>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 11:37:35 -0500 (EST)
Message-ID: <931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca>
Date: Thu, 12 Nov 2026 11:37:35 -0500
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] doc: checkout: rewrite detached HEAD state explanation
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca> <xmqq5wy2kqhl.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqq5wy2kqhl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-11-12 10:40 a.m., Junio C Hamano wrote:
> Julia Evans <julia@jvns.ca> writes:
>
>> Yeah I agree the "it's the parent of the next commit" would be
>> distracting unless there's a specific reason we need to include it.
>>
>> I agree "the state from which your current changes started" isn't right
>> but I think if we reinterpret it as "the current commit you have checked
>> out" (which I think has the same or a very similar meaning) then it'll
>> seem familiar to folks and might even help.
>> ...
>> because I couldn't think of a reason why someone would clobber an
>> existing branch to check out an old version of their code.
> When I find something interesting in a topic, which may be an old
> commit from the point of view of 'seen', I would detach HEAD at the
> tip of the branch to take a look at its contents, because what I am
> going to do next would very often involve modifying the working tree
> files to experiment.  Even a topic that is documentation only, like
> the je/doc-detached-head topic, can have a cascading effect that
> ends up breaking tests, for example, and I'd be futzing with the
> sources and tests to figure out what the best fix would be.  Even
> though I am not going to make any permanent commits out of these
> efforts, being able to make temporary commits to mark a resumable
> state is handy, and when my spelunking gets longer, I do make such
> commits.
Thanks, this is helpful, it makes sense now why this would be useful to 
you as the Git maintainer with what I've learned about your workflow.
> I guess it requires a developer's mindset and imagination to
> appreciate why detached HEAD is useful while spelunking.  We often
> phrase the act of visiting random commits (often older ones) as
> "sight-seeing", but in reality, even when you are mostly looking,
> you do want to futz with things you see there.

I'm not sure what you mean by "it requires a developer's mindset", in my 
time working as a developer using Git I never ran into a case where I 
would have needed to clobber a branch in this way :)

It's important to remember that different Git users can have very 
different workflows (especially among developers, I think!) and that one 
person's workflow may not generalize well to other developers.

This is something I pay a lot of attention to in my own work: some parts 
of my own personal workflow are a bit unusual and I keep a mental 
catalog of those things to avoid giving them as advice.

> It is in a developer's heart ;-).
>
> Hope this clarifies.
