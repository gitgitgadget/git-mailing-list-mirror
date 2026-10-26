Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036248;
	b=zTgRVfhH+hHewtLkP+QUcjZzi5ki4cLTLl27cmUAUkb90bhyT2PFwo/N+yz39fznzeUt
	 5sRQ981VbnlV8V4f81xIQQU8JH34q7dNaPBipmzkQX7Gbi3zBMkU27DxtsXQA4dL1R73d
	 awJxt/qIssGyYbpyE/e6cMWXN4wJXtLOrg2eNWUmGqaEP2R9Wu9NzUpzhf8Jx9szhbsGw
	 jencg6Qw+DMBdREj4yspNkqhqoy0aRPn1a9JzFdH88lPCAQl/OSTG3i4qyvlKxA7HSjGG
	 MSqPYm8alSFHZFP/cAdFC+a5Tl9wBkkbrk+rX/ukHn63MJP3Wa4sWMgfvUakGu+NG8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036248;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8Nqndon5CZ8hJ4156Dwc2JReC6UgQfVQ5k5avjOj9Xw=;
	b=tVsRUE75+1MvWcDEyOr5mHCoa71ks1jpiUJuRIAu2MnzZPyTS+AuuWK1Dl0qDzW09cSY
	 jT1rHGt96mlKatwQTUjXeer83adZ2YoARsh7csUga1nBvILJLC+nqq8CbjszEgVd1mL4q
	 goPQ6DgclDjVi+/7BLYaNruuT6ZIBN8FBi/FL28ltIMGfQjaqdFlnSObZpuaj5vLCoKZX
	 WvEaAsh77x0ninA23XXLWlhFzHB+81aNFlAkLxVxb9vvNybqsrd4OHqUzDz+0bfVy7QHA
	 Cif31Thi6tjky9wYXqbgls/FpmhjVdG9lEH2IuqHHrkqZKQEDu0da+GW3zAjAmJJIQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hkoNX+sz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="ZPqXST/r";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C8606A320
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D1C8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=hkoNX+sz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZPqXST/r
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6923F1D00398
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:37:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 26 Oct 2026 13:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793036247; x=1793122647; bh=8Nqndon5CZ
	8hJ4156Dwc2JReC6UgQfVQ5k5avjOj9Xw=; b=hkoNX+sz4qGRdl3HaxQwe9Xchl
	42eS3SrFUtkk0ZlwXOJJcwnNymAO0IbAk4maozSXieeWKrGyyE9nyG2sBOdXzapF
	tlBeZTM/RlvQSFh/0Nplz1d1f1D67RsLgnefNMiTYBd06TM47H9RQpvdJU9Ljzz1
	rEVJZNPY/V5J13W5y5mwJBqjR5pa50ITWCc6NmpQWWpkQe68PA5Xf0qctTeAr070
	h0gA5RU1XIS1W+XaePQQO1MWeeNEIzFsmyT36toWLSrdw+thxaMVo9AsSQ/JRWmP
	WOUfatBk/1MpQNdHI+8b0Z1g2drD/xjn3JIvBY+P0C6HjlRqMhA6sVCFfbrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793036247; x=1793122647; bh=8Nqndon5CZ8hJ4156Dwc2JReC6UgQfVQ5k5
	avjOj9Xw=; b=ZPqXST/rH/Mi0ML2dD9WJ7zVbEAjm59hNX5Cqyh+17pc6UymoAm
	SJcI/QolNo03h50leOJYFexY+xyL5C9KBva63/ffqOVH0BGXkySdVVDSeSDyigH5
	qk3lUMhIqzOyzQ3SvbMYpL4hHBw8W7UzxWrGv/akQnQwu1MQPU2nZvAJiyBWor4O
	2TThtxhAq2M/ccjcTHVvkBTBLSGbRyrIh+Ah9uFDplfLg63HuhO7E8rR+bFiPyqR
	BRH+DfLlBr4iI32+hvbxJoDGkuDlsIorzttazRNv8O+Q9/R8xIO7VjlIkEn6/aTn
	gpypSLesKtQSRHCcF6/V/09b55iJVJoZqkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793036247; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fCh/BpcWMU3+WJhjdMU3+1wsgyTeIkpSayPwBl/9QnpRKoV
	G3fn24RfWPxiD3Qi3FatJlNFcsiEnTcm99mHhwBYmLC9KNw+Z/LhnvZzT6LbaMba
	Qz8o/4mP+T/l6qlzWK6DXz3uHC8S4wGA/GHPJX5qSW2S3em9JJNPSxgd0iDHwc6Q
	GLvM6ty3zooxjQqqqP3JwbWPsoVdSQGrMY4+gY2F4TEwMP0tMVqgqXgdL8lzcMCN
	xdHl8MPD8rNySXoUpR9usgtnpRGGtkD07cO2L/AcdSqDbAE7Q6EpV7mELrbvvv/r
	eNApH1XM/+6apbrNrvi10QqS2/OqY5IMo5WGQLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UiHgEDHABGAaHrlHiK2DJYUIePc0VaLqr0d4qIWin0w=:9ylIaxlGcKe3lJDTBOlJ6sp47wm6YRpGdrifIql9VsI=;
X-ME-Sender: <xms:14_fakQRCA4L5-kENUC1IEOUMtkMeZwusjAoF-wCxiVLPDzaNHeBCA>
    <xme:14_faopYzzYqH8oynNzHTr6ylflsBPfSPr48a1kmlmASZo5hSUk1dZcwGrehwkWdj
    v8Xd1YFnN0TxBwL-CqYwgiNF_l6YjWpP-IY5lDCbzXrfcoMc-EhgUk>
X-ME-Received: <xmr:14_faqJBH455fKhXpzGxQul7hYZbuf9mfk0VvD6fDXvDODS-M8f4MHUUgVazF7skW7bxIldwLQO-S_4d5u5sb2zS69G1TLWImFck>
X-ME-Proxy-Cause: dmFkZTGPkhCTlzApEj17/6V6qHwQh9hSTP0DRttB7jILXcsq9iVBjpA3bdWOCubMcJ6Dhc
    9f+Y5fPs40TGYtGsL/2/W8h0QwBndiO9tRHr6wvgDuOP0ZLwAfyQ9AbfXVPQY1FUvEDIHn
    zDml70l0eUy0zcFzgSKXBX3RMdXvT0AG0q4SwoMpa91NIhqLnQBhF60OM8XQXK+8AnsHVf
    ngVw9lxFqC0uAppUlNrUhqomcnFJWRdNwHdMBQQcHJVVsmhWg6IGHB42vKpH1RRihf9lkT
    +xbC+KqaMXDPUouYpsVa35217KyD9lVxOXjBl4R+UwMR7KPsdkMDIPVTkifC1RbswERik4
    nDjOzPtEZY+0I1Z6fCEIsIPDp5H2VM4j1/LsWhoa7D1+CO2VomQVC5Y/UO8ayjb+4e9JG2
    GmjtKpSlXDg8e+30xnuRdXeh9U7KfzCjkaA0BogV9Hm9QzU+pakC465r6riuFGR+mAvcZY
    BQ9BXgAX5oeoHwYr12yVAcelgNsCvQUUaGJTjYVffDe3EoRycWvJqq/kv+aUeKDpcRwLVX
    +wEQg+GWqV3x1tZLI7qG9eWrhitbYad9B3nj6dz42D2iTGdcnd0E8q86ui/8PEry/spfXm
    6Va44DWc8pzfI0D6eB28BlpaPCbpAMNgggavEJb/b82xsUJFTpQpfoTHjbvA
X-ME-Proxy: <xmx:14_fajqoPxvKqya-XVQCKOBCyl5tZZ3AdDsUhMuoCvUOlfDFjTr4Wg>
    <xmx:14_faqx5zGE-ncGQHPONJLgTMSibqDUL9jCi9Y_-b9Z5Y31shvlowA>
    <xmx:14_favOv7K-N_GT7D9kYKC5r21Tk6PKp7EoF_mGscZBpjn0dFotkZg>
    <xmx:14_fan6EGNJxTPu55Gre04MFJj3GUK8jItg5cRMbb6v2GleXbiTo1A>
    <xmx:14_fau7W8oJrJ9fCQdRCY96aMcIhFdI45zmA6fowhceD3lWYrnaoY8pw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:37:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Srujith
 A Poojary <poojarysrujith@gmail.com>
Subject: Re: [PATCH v5] diff-delta: use safe integer arithmetic
In-Reply-To: <pull.2276.v5.git.1792956031588.gitgitgadget@gmail.com> (Srujith
	A. Poojary via GitGitGadget's message of "Sun, 25 Oct 2026 19:20:31
	+0000")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<pull.2276.v5.git.1792956031588.gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 10:37:25 -0700
Message-ID: <xmqqpkwwqs6i.fsf@gitster.g>
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
> In create_delta_index(), buffer sizes for allocating the delta index
> are calculated using arithmetic operations on entries and hsize:
>
>   memsize = sizeof(*hash) * hsize + sizeof(*entry) * entries
>
> To prevent potential size_t wrap-around when computing allocation sizes
> on 32-bit systems, replace manual arithmetic with overflow-checked
> helpers (st_mult, st_add, st_add3).
>
> For the unpacked index allocation:
> - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
>   which may be padded to 16 bytes depending on compiler alignment rules.
> - sizeof(struct index_entry *) is 4 bytes.
> - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is 16,
>   limiting entries to 1,048,575.
> - hsize is the smallest power of 2 greater than or equal to entries,
>   capped at 1,048,576.
>
> While entries is bounded in current code, using st_mult() and st_add()
> guarantees that any unexpected growth in struct sizes or bounds changes
> will safely die() on size_t overflow instead of wrapping around.

Much more useful for future developers to learn what led to the
conclusion.

> For the packed index allocation:
> - Passing (hsize + 1) as an argument to st_add3() is safe from overflow
>   because hsize is capped at 1,048,576 early in the function.

hsize+1 is *not* an argument to st_add3(), though.  It is given to
st_mult().
