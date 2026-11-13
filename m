Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595407;
	b=Mlm4h3fd9gHPCv1kBIDrX218uQOf0Cer5ZyiUwIpkvQbGNW68L6OIJ5ilbKWb4WUi3qT
	 qI3F8HDB3ERszDzwYsViuuL/LfgtTU2/AfnOud5q05aYh6684EHJ5XE65M8t750CAZhhw
	 g69uZzWRoVbK7MTk4b4ifVEwhwJnSNE/fMEfm76bgomnaHLArePtWwiSGSm8nRkatitBK
	 ecfqnHcOvKDJeMICcdwd0YDF4ecmab+n5dLxpyoG0QHvuOEjD3D6SRK+QquoZBMsA8U9W
	 rJEylim9bxW3kWmtmyZ+/1QfP4Ykf9QwdT3Aor45BYgvU8tamp1sWwbzFZF4IuuEsDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595407;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=SNdCNVcZdy7UFPvzbXyShuQt5pxyJjI9rBKB//1U/1s=;
	b=OtXhM+KFtZMqYuzeqnkQV0HNMh12Vka/PihRjhtABsQmpU6ky1l2+B8O19HXvmSWNQFb
	 Zs0XCgH9Jcm7nMGg1VmDhqVwI+e2vA45ZoWGTxbrgHsUhcr2IcENA4A8eCDJmq9FnCW9I
	 pAhGG6Hn66Y9fqzUBULT7o7imdEtCp32jkUPvRvgZ+LPw7tFYM500m3PZS7PtxnU1DFfB
	 KQzQdPjC6OLnVPVhU1r/az22+mp3KroK7hq1E6J9ufwddGUUUr1IcLu2pGW8SLJ+27wjf
	 kHcb1kGKZ2B8XqVomq3dCRCxK0YtCv+G0IWxqkF70tPkNsD/WEiWieEzV9TLo33jbzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=UdyflJ9I;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZuUh3flh;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6F606A65F
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 18:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA6F606A65F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=UdyflJ9I;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZuUh3flh
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 147D5EC05BC
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 13:43:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Nov 2026 13:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794595406;
	 x=1794681806; bh=SNdCNVcZdy7UFPvzbXyShuQt5pxyJjI9rBKB//1U/1s=; b=
	UdyflJ9I6jvcjXltW9DVKPT8sxOZAfXn3urO0GczA4Wx18SlBIZsS4i/VZHmPyeG
	/MEAqW3v8RhC9umy51oIX8qUhVTWSzf04F7C8dMoMyB2cCgRCjzrkzOcu3qoTwcE
	hvKuA9m2Id+nOkWcXC9JTWAk+TD5bFpSbIuEPTRFHCBeniwTDCdumZ4tU/2/ct2F
	C5xjkPUMoc6n28LXXGF5ysb7wSGU9OfJAAaiqgiaLVxv9gMf66uTtDy3gbGlfGCU
	NSRNsrTFFzSZeQFBcv3RV9qjWKbWW49cxHaXn/wdO/UStRRb7vvQBWAZoQ1llegf
	Cw0OLOPVcocs3y8HJuu/hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794595406; x=
	1794681806; bh=SNdCNVcZdy7UFPvzbXyShuQt5pxyJjI9rBKB//1U/1s=; b=Z
	uUh3flhf9I8ZtM2HT+3P7n6I602KOHLRm0UCWpdLRS2zK62gImQ1TYsdHdtgPQ9b
	MsbVAn08RFaPB3Vnt+dZkhzxv6HVSJgIqKLqEq5maAARvlKGopprmRnfPsUxQXB/
	GqEpI8JPHXb5vRRdDg1zlolrGd7/1tSaPUfD/PEBTx38d7llntbGBSLTowM1afNf
	TM2ESzpU/1EO2hkIyD1+A0uj/QC7E2qyk8TxBIUVICqUytKZI3KeO7fJefCBz713
	Xe5Ipl9LS1mSFX+dm0Z1l6YzFqtC0RSqyq/KnTRaiH91s6ZJAbYxCB04HNeeKyNw
	cCIyee83tnQRRu8qvJNgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794595406; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xDWfuQ5UpEI/GQkMSNceCUMvJgNYJqVpOZc8o+SlH0mr7sN
	3mey6cvfBUO9J1s2oktjLK7Hggb+yy8UxA1ARyWvEj98HjLdkmfpjMAmn1dV13SY
	iOnXYKHobkKa90HlKJt6fhMvYqysUJWCjcIqpguk0nqMna9NHZDJM1T3MCrc5DHI
	0zetSw6Vhh1UwcpuUf/sl/Xsl76fsxW5qBZNtCGRGQeBgvQPPKgXH0wPMBdb2t/M
	zPm/DI6eewGYjh0s6s+9RH3CedPLmItvLiTOLn6BcCZP9Xs+XyuxZseMlUNZIo+O
	IYKQoEe9qDwjW5sUtHSgwrBlrBJt3E3b5u5V1DA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iE9ri0BK/+FDEpYIlSLZvHBNij+bZg5GhnJiVLPhpW0=:LbG/wfXMg4jWVUIHHeYfwW9EPvBI9iz60eK/eKC2rdU=;
X-ME-Sender: <xms:TVr3akNJxR-gI-UUK95fUcgxHocYnJRlGQD-RPXj7jLOzJUqFOZVuQ>
    <xme:TVr3ah1Kw4VoPn-VhwX8zuUv7H3pFT0f1DGQVNupsA8EFSLolz8H1NNPbJycFsCmX
    t7CRHYFTWKpA0oVj9MImiPdWFdHbTobliccTvqrvNsATWdl9kgnQyqf>
X-ME-Received: <xmr:TVr3ajkvi4SwkbTPEQG_5YseiS2yZ-O3rXhub8zIERi7hTI9yyOWhUvJH7KQy56nT2rZl3zo6mcyR8q7RJhGkiZum35loFXZixEHZwjqAhfoTAVJvA>
X-ME-Proxy-Cause: dmFkZTEZ0ASCX91HcuPsxnGDoXM4C/664+2cEIhVOgz+FH3PV5suyVdnER8FilWP/m50Gw
    Wu0BAlatS0+j7WMisDV/7SlpnTD4ZWh0R/oCOGJmQBY5Fn41/ztbcTJuczcYlC9cQUsSzB
    m75bZNoPf9JjSAcno0jHFTn4dtBgg5a+7AnpN4IGEKLKcnXkJEGyxlQnm9CX2eFqNmSGNz
    EOvJqRlUc0JV9hfVfnNN5TXMzHLAek5y+uYfwfTz8iJwtqWwLtmG44Zfy07AukB/n3GbXW
    dRI4BhhVuqDJ1O77ndJTM/EyMyu8UPeUGKf/g3oIrJ2wj1cqhcLGrfzXLAf5LAj7sC41pn
    jLDtYgCscTLvE0EdQoVNiljlnMSB46DRB/CdeY66qVrgG3ZDhZd3DNfLRFKDIcfjPZjSWt
    2nhLHOxRsd71vpEy9DMZy/v9omLABF8QbSOv5rNonVugB8t46PGONPlBU7N3bzx1fBD6Mq
    nPSnxoKWtP9Kcb7zjvdHBQwNpW1zKVFq2Mocavd2iCb4MzqS79dD1QtvAL2ssSvCyI2BCe
    jBPe9qRdyg6v3nRy2xMUSS7Cz3TnTYhsHZZmTq/lozNwdNnaCV0Ui7RII8NZTfmWOBpMat
    i2BxdW1BVvlSD9bvzq6Iv8Ym81l4W145rDLb1b8OqulclFwzzJ7aOwcphXNg
X-ME-Proxy: <xmx:TVr3aoV73fdihjyPoRrH0Sv0PZTPuEhPZkdxBjLpgW-92lsaa0aQaw>
    <xmx:TVr3apvS-O9paQUZV_d5iWy4UZyHewhyBaF6vb02DssMS3u22vFb2A>
    <xmx:TVr3arZHCU_4J0t0swF95L4iordOuLplWy8mAuycXVXaQXaHELh9cg>
    <xmx:TVr3aoVUYkM8A5fcvCCsLuCuIQ03GiuV7LRvyAjMw_DOqoiB8fL-nQ>
    <xmx:Tlr3avmVsocz8d-OITz9mvKcjjlULyeT3B0LSXvIJMOn_h4KGzSWBJJ6>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 13:43:25 -0500 (EST)
Message-ID: <7cff0912-8d60-4a45-b32c-7f2b5b8691e9@jvns.ca>
Date: Fri, 13 Nov 2026 13:43:24 -0500
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
From: Julia Evans <julia@jvns.ca>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v4.git.1792177409868.gitgitgadget@gmail.com>
 <xmqqh5ile4h4.fsf@gitster.g>
 <CALnO6CBGcG42NxtpuPaJVrzAMC=J8iVstsHCSi6vDQhDmFJ-Kw@mail.gmail.com>
 <ddc6d42c-6e40-46a5-bb70-f89f11525ac4@jvns.ca> <xmqq5wy2kqhl.fsf@gitster.g>
 <931a94e4-feab-49a9-b5c6-479f0d7f8b75@jvns.ca> <xmqqik21j1ie.fsf@gitster.g>
 <4d6f9b6a-e658-4797-bc4a-0cfc533056d8@jvns.ca> <xmqqfqx5foxd.fsf@gitster.g>
 <36e73720-287f-47a5-bd3f-dc53629ac968@jvns.ca> <xmqq33t4fxx7.fsf@gitster.g>
 <a70524b5-5ece-49fd-acd5-c97e21faa76d@jvns.ca>
Content-Language: en-US
In-Reply-To: <a70524b5-5ece-49fd-acd5-c97e21faa76d@jvns.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-11-13 12:57 p.m., Julia Evans wrote:
>
> On 2026-11-13 12:23 p.m., Junio C Hamano wrote:
>> Julia Evans <julia@jvns.ca> writes:
>>
>>>> The mention of "your current work" (started at the HEAD) and "next
>>>> commit" is to lay groundwork to explain what happens when they make
>>>> that commit, and how it is different when they are on detached HEAD,
>>>> in contrast to when they are on a branch.  After all, what we were
>>>> discusssing is an improved explanation on detached HEAD, and your
>>>> commits not affecting any of your branch *is* the most important
>>>> aspect of what detached HEAD gives you
>>> I read this a few times and it's hard for me to tell what the issue
>>> being raised is.
>>>
>>> Are you saying that we're not explaining all the details from "`HEAD`
>>> can store either a branch or commit ID" to "if you create new commits
>>> while in detached HEAD state, those commits won't be on a branch"?
>> No.  I do not expect an introductory document to tell *all* the
>> things that needs to be known about a topic.  That is an
>> encyclopedia, not a technical manual.
>>
>> The fact that you would not clobber any branches when you make a
>> temporary commit on a detached HEAD, however, is the most important
>> consequence of HEAD *not* recording what branch we are on that has
>> real *impact* to the end-users.  They can leave their temporary work
>> behind without explicit removal by just checking out a branch, which
>> also means they have to be careful about losing *if* they care about
>> what they did during this temporary state.
>>
>> I view it as a disservice to deliberately avoid talking about it.
>
> Okay. How about this?  (the added sentence is between the **)
>
>   For example, a data scientist could use this to run an old version of a
>   data pipeline or a programmer could use this to figure out when a bug
>   was introduced. **You can also use this to make experimental commits
>   without being on a branch.** By detaching `HEAD`, you don't need to
>   create a temporary branch. 

Also I should say that I do understand that making commits in detached 
HEAD state is very important to some Git users, I have a friend who 
loves detached HEAD state so much that he doesn't even use local 
branches in his Git workflow :)

