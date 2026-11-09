Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260096;
	b=lOxbm7ct0qSMkta5rLA1Z4U2zBjb7egKmj6XvACgT8LX4vSILRaqTMlWitzCSsLS4ha6
	 6ceGSB97qA2vA1PQo9MD9RHOKkCXRw+ZcKg9MmbpbDkq7Av1xfOTDGa96RAqfchg5YOkk
	 atsPQLUio5mSr/w1s5ARFUtoRCwxFr4bHQ0U8FYwl+pm0MxZbryCkLEjI8nF4ZoWhNWLs
	 Abv+9ZGS4sbhQ84C34RrJYe2EkPXhe0zJiuLDl5hqaIL/5So0EJg2QwGDxACbR/i91A1F
	 JjRuLXytiQP3BBeditzJtfVqKUFp1HEFsuX/vDd1N5JxLRuRTM5FQhOUCLsC+7VkjPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260096;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=agOW+BZbuRt/XhH9oZvBVh7ASKjYy8kPY8orF7eNYlk=;
	b=XVvyRkcO2MGN+VlAf+QoQg+hGwHu/jNR/fXa8DPnrWuq1t5OxzUq7nzqDGjiYS1H0jpQ
	 7Gf/IrOnSg7IthRwYMnP/M9q78v1D/xjbjcPICFHr5UhMJKU/Zb5S6zsm3J821ufdKezp
	 moTcKfXMMJixiB8K8OSKE7Cl7sR+8i9+2F/x7ZgXe081BLW2jY5K+/FYTePdB71n935lt
	 3O59bSLcqOc/hN3nCtOJ5iFvodyPNJ9FgVDZltVpY/jREhW+0R0PiBMl79qrT3QcEUKvB
	 sgdQ20+Nr8SFVgaAr8tELxzMo+beNOjUWtcexPfsovsjXt2Fm3THPUqwnvwX9dd2yMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mFdSa8MA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QAJ0X0vX;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5D606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 21:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF5D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mFdSa8MA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QAJ0X0vX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 077CB14001D8
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:34:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 16:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794260095; x=1794346495; bh=agOW+BZbuR
	t/XhH9oZvBVh7ASKjYy8kPY8orF7eNYlk=; b=mFdSa8MAOYGtEHWYE10yv6zv3u
	P+yGMtfcGi1S2GJzoL9ocWReh5bgtWgQXmRr80fMxehxTJIN3r2+788//wvHmBwc
	R6Iak1fOXtnYnVsH0zM8RsbBpfQeBkdyGCmrDbNWGIXkZwyz5r2lcExZXAT1ykg1
	WmtLES9iUrCl+lY/EAYCqbfCvVxuAVvmmJpqYiGopnvPZWJ7UWSEEYG4HhOAo3Le
	X+cg0eoSTA6+6v8gQyK4zk7twHgBc1Q88qEaVm89r2B19YkqUTULkrymeOCZO6MI
	dY+kbt0L5YVR8Nq4cx4atC6JXfJqNRU/v6hdCjbKXXxGDH+FHTtBMbjWXDjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794260095; x=1794346495; bh=agOW+BZbuRt/XhH9oZvBVh7ASKjYy8kPY8o
	rF7eNYlk=; b=QAJ0X0vXdq+HgqHiMgJickNh24PPMY6YlaOxCgAVQRX10U6yYwa
	1u+R89v4xPI/fzXoZShwxHy8pLIKoEtrMEABaZomNZPtFe7ugxrnFhSJ7/9u8Kfa
	uHywePbXtIGiuqXeQLEkCSkThXiAjH8QEXpQb4JR6k1J3QxZVHudXOmxGxxhAx5t
	2fZq+BZJXd18NejTVRE7QROyJdhV4/JgfxaGs/cjar4CaYJHlnjYH600mrkKUVH2
	3nN96tDDDuZN9MQOfIRl82YGv2FdvFwFxLi8k5YZi9nHw4mfumhNOhLkTKaeMUXH
	kl3COtqvsG8v01mlfZtEDdaE5EwEzkU3Ffw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794260095; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Re+vMwV7Onjnibw63zXj5rcjorB0Jpe5Vruevuz5r9lGSfD
	aWrpkKJXg1C/PMeQdCMOhqH6mPzlU5DSFInDFLBKxI9mNynjTlZZYDbbsNnhkNGr
	mMZ2iyXnUEPydR/cwz9AO9wcFvA7Flj06LXAH92ZEj0Z/KykKEMc9Q5HEHpB5Dix
	zrYWjPBfzzSELHQMwvY5+HxV5AjV1M8xg6cEChCRntG/EYPaijbKgpjurBUIMeHj
	by7e4bZjirBuAyoCAqWmE/ZI5s3WJgl5OOJonk7dCxhN09sPDsBSB2Rrm0S7oCQI
	mTluat+tm5hicS/5QNFZN+eQYNt0XVe0ueZr5dg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gaTWWaJhwv0K9qfqySTLnCRxln8Cm4g4QfQ9b9FDyKc=:z/oB3Bdak0Y0ph/oj5VarD+ho/CQn/SYf8b+XMiczwo=;
X-ME-Sender: <xms:fjzyajwz8Sdv3_M5EE7D-wRUY0Mx-XQDkAubJJ6-VCLQQjps-ZEz4w>
    <xme:fjzyaiKfNxSOX0n4ShxcQVIvR22IvvkHsG0w-dkzq7LZK10a_OWxcQDvvfQ2PBWXC
    xZ0axXKiBXoM1hSfpJAANpT3l4TZHlSMCx4iMzHD0bn4XFl2ty9lw>
X-ME-Received: <xmr:fjzyalrgEWdd2RzOUQ62jDJTBRRbLEYTl8FBCoxBaHYC5VdaYQQrfcUOy6h2G_izjdx6_k8uwujfKck0F0Sdv6hMkZpQXASKzE_v>
X-ME-Proxy-Cause: dmFkZTF3q22d7e1NsIkgaW+4NW4QR0kVhv16iDJpEuM4KeNdq9GydgZpVu45TdcsdixTTn
    gdrr7V8m4GxVdGiQEd6rkOyuzxUzYu+Y0yBigCbwOUNTv5U1C/5217UhFvs3HL0JOhFDnZ
    b83Tss84WgFN6m1RDO2LLztgqXJFPdC948oA8z2GPCy12hOXUaeRUcMhwAWPiyHGbUaRJe
    0YUJzLb2t99h8kDOCWgHmswc5TWVw5n6iYHSHTOQ+fFoqVknxSDVWOlPB9aBnA+1RlwvWU
    lhiyEIVP8U6w6JVdptgJg6Z/TR3Eai5/ePsNqvqNw4OFjYa8+R2btPqiM4OUCY3h0CyfGU
    gaApwlvxU1/AMd9Pz7B1mKtJgUtUNuY3va4z8WA4BJcnJkDOFM6bcVXV4Ft3e0o+I/JRBr
    QhYslILBU26K/rYrXBDsrXkWIrzC9u8yp7smyILj+3Bvn+WYc5emr2a/r4+C6mrj6Sm+I6
    E6Cd8kwf4dNv5oVxLRZJ2BiJ3nzk6kprt1GT/aHYsLybcc5Kmi6h4LvTCgkr8d833HJPIs
    Wy18Bh8BjEortxKltgBZfodCiFRrU7mtIwJjurxWrtca/lZLnf8/q/09cmGgmEzbtgpWPY
    F1J7pY5E9VmCTyc6dXJy3f9rIMTBYX8x4MhatBhHN0pBMXJe/nWc025NOBhQ
X-ME-Proxy: <xmx:fjzyapKMxlbyZAfjeiM3W-AHo4PM-pSkDgcfZe2F0_7xMe_Foz6img>
    <xmx:fjzyaiTDgryVeReEvJe8IzgZQc8jp2e7lgl_J4hthuoOpbQxFq7hnQ>
    <xmx:fjzyagvIK-AsewO7-YMRxKiOwiuzBvzRdpNn_UP-Yy-mTqO1V2AaGw>
    <xmx:fjzyarZWuxJssVcNCBIsnmz8uPc9ok5DglBSOQNdej3tUcdqQpefCQ>
    <xmx:fzzyakaZCYv7I5NfnV9s6Y37k7PxSJ4n5iEX-mFxmeUf1pNigNKF3h9y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 16:34:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Ilia via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Ilia <ki.stfu@gmail.com>
Subject: Re: [PATCH v2] fsmonitor: check the untracked cache after a trivial
 response
In-Reply-To: <xmqq8q31yb5s.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	09 Nov 2026 12:58:39 -0800")
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
	<pull.2247.v2.git.1794251653636.gitgitgadget@gmail.com>
	<fefa2680-695c-41db-9975-7e972590b969@gmail.com>
	<xmqq8q31yb5s.fsf@gitster.g>
Date: Mon, 09 Nov 2026 13:34:53 -0800
Message-ID: <xmqqse19wuwy.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

>> Thanks for these improvements. The v2 patch LGTM.
>>
>>>      * rebased against ToT
>>
>> Generally, you shouldn't do this as the maintainer will apply
>> your patch in the same spot and handle most merge conflicts
>> via rerere, but rebasing interrupts that. The main exception
>> is when you rebase onto a specific topic or with regards to a
>> large refactor that merged recently.
>
> Good suggestion.  Worse yet, the topic is already in 'next' so a
> wholesale replacement is not very welcome.

Well, I ended up reverting the merge to 'next', and queued this
iteration (applied on exactly the same base as v1 was applied in my
tree---the patch cleanly applied as if there were no rebase).  I'll
mark the topic again ready for 'next' after waiting for a few days
to see if there are any more feedback.

Thanks, all.
