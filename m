Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61925F987
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712716; cv=none; b=VUmL36K611B4Is3+9taIsFhUEpB4dHHI3dUazDA+Ngk9nfE9b4DszWVeQ2yiDQBoALbgZY70e37Q4E+oDqUVMihyMBEn3OZTtrPeVMMd2L+fnkNQKx3MVyxFPhyo4S93V/67YpK8aA/g4934RhaZprf5VuoQsLYU77VpXr7IvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712716; c=relaxed/simple;
	bh=Vecw/6Vp5NufVGPCwF4igKCgW1OKuDvaDlqum3sLxsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxj5Jik16uEWWnTfoDg8UHVksL4cLq7XDzopPjoTKq/UyZEo45iIUHXQGFmo6Nmx8TSKjMV8/9PbEvCHzIkuzP68egEXC7kmjjs72PgpNgazb5vA/8weBB0SBe7pNGCAclViS+WwHGVPaWNlGK+Fww63D+jMVAlBJFRxjLwuqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dd8HKbRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0w0ELs9A; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dd8HKbRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0w0ELs9A"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AF8B2540199;
	Tue, 11 Mar 2025 13:05:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 11 Mar 2025 13:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741712713; x=1741799113; bh=hOpSoYvbxR
	P0RXdJJk8c5tU0mbuReLTWrKwiaRLTUSA=; b=dd8HKbRvNsh9K8XmWfoSJJu3UQ
	xK7HQ2NfQQTu4ATypZQRdGptFw/YKfNGk5W1JZ0xkVPPgKmo+dSPTMRoxxyF0bVU
	WJJ1umPPeMsrBhcKO8v+Ao5vaxmraijpmZZ0D53H0aiq2KjCmhbosH9oVzs5HlyS
	oJEQUQROmjNddBLt8gGvCf3AzVfRTinZduCT+xCSsxLh1XhtA3HdapAWJpXi55mk
	w5DLk8R4A1PI2z0Or0RC5eSsJeEdW2+qr+IT0TU0yNdTk+XH/zC9OtgkcUscxgbl
	1e2BTl7ntCKrLkDur2n7Qr735pKWCItAXEgcoreoSXvg2d6QRYjNMosxL6pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741712713; x=1741799113; bh=hOpSoYvbxRP0RXdJJk8c5tU0mbuReLTWrKw
	iaRLTUSA=; b=0w0ELs9AvhOFx0D36DZXm2r+U+ZEKXh/sYrqQSxS16s/RNKxcRo
	Pl0gdRH+wpuYWzLBm3ztxpomjre3D3RYVh5+mAQjUU7w5G2LuAtsPp7TnzaCaUmj
	ObLq+TFpZk9b8sHzB7kG7Hocjxwexv1tn3R6MkIzRSbnKBcVk74aUFKKVDY2Fl6s
	DD97VUbviZ8OkufO8Po0SpPE7IqLRSViQNEhy9ShksIPdbezy+IoCEV7ZuvVlw1y
	zc6VV0n3v/qTu4FYhrPW+km7wARw+CZ+e7qG2BojFGqc5/9aAzF0BDmAoHXOdebU
	2jiAjAbREO2tt23QpcXAA/kEqdeUquuhrHQ==
X-ME-Sender: <xms:SW3QZ-po6DVdeQy5FZzLk1WmFEt5i2Pno74kDWK0U3HJ5qUobj5JKg>
    <xme:SW3QZ8oD5a01smOIsa1fWf6u-Bis78pOHLLGV2QOrbUckW2vyen_Ikqji3Fu8c4Ls
    PKJn11ZLTTT14fvUA>
X-ME-Received: <xmr:SW3QZzNxgm2G8edTooZHGLp1x6stan2T3j0UVll38IhIrFz8tMGtHhtEUfK5fPhflzAF_Lmq912-PPMYiPsntotlR4XiB_nNvyVF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SW3QZ95wJazLXS95wRUqAb3zKcXTefRqddsPYoI2t5GzK0tga8DIYw>
    <xmx:SW3QZ95GRLwDi_NzmAbnS4WavWqgkRdWo5y41YSkV7ROHGN0LO5Neg>
    <xmx:SW3QZ9g8TNoCxf-RAwVuzKYoPBBwIMjTX63m7XylhsBJ8cOWL4KQiA>
    <xmx:SW3QZ36J3UoTXlLO-_6LNDpyewo9RqCwL-Q2Jv5-GhOiT2tEFjA09w>
    <xmx:SW3QZ3llflax-0BBceZskMvUl5xefe-XvzCfrG1iSOrB6PK70H09jSe0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 13:05:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2025, #02; Thu, 6)
In-Reply-To: <Z9BM4r2CUG1kF_Yo@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 11 Mar 2025 22:46:58 +0800")
References: <xmqqzfhxfym4.fsf@gitster.g> <Z9BM4r2CUG1kF_Yo@ArchLinux>
Date: Tue, 11 Mar 2025 10:05:11 -0700
Message-ID: <xmqq8qpb4hx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Thu, Mar 06, 2025 at 04:55:31PM -0800, Junio C Hamano wrote:
>> [Cooking]
>> * ps/refname-avail-check-optim (2025-03-06) 16 commits
>>  - refs: reuse iterators when determining refname availability
>>  - refs/iterator: implement seeking for files iterators
>>  - refs/iterator: implement seeking for packed-ref iterators
>>  - refs/iterator: implement seeking for ref-cache iterators
>>  - refs/iterator: implement seeking for reftable iterators
>>  - refs/iterator: implement seeking for merged iterators
>>  - refs/iterator: provide infrastructure to re-seek iterators
>>  - refs/iterator: separate lifecycle from iteration
>>  - refs: stop re-verifying common prefixes for availability
>>  - refs/files: batch refname availability checks for initial transactions
>>  - refs/files: batch refname availability checks for normal transactions
>>  - refs/reftable: batch refname availability checks
>>  - refs: introduce function to batch refname availability checks
>>  - builtin/update-ref: skip ambiguity checks when parsing object IDs
>>  - object-name: allow skipping ambiguity checks in `get_oid()` family
>>  - object-name: introduce `repo_get_oid_with_flags()`
>>  (this branch is used by kn/non-transactional-batch-updates.)
>> 
>>  The code paths to check whether a refname X is available (by seeing
>>  if another ref X/Y exists, etc.) have been optimized.
>> 
>>  Needs review.
>>  source: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
>
> I have reviewed some patches for the earlier version. This week, if I
> have bandwidth, I would review the whole patches again for this version.

Thanks.  Any topic outside 'next' would not move until the final
release so it is not urgent (read: if you find a new regression
introduced to 'master' during this cycle and can work on fixing it,
that should take precedence), but if you do have bandwidth to do so
it would be great.
