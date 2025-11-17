Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B268F48
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763345335; cv=none; b=EP+c/ksyx0NSTQLxUCrtGkjrDP9sup5bt7GzFEr2Fh04wWm3WtTKjdBqpi/by9mpX2bcQqP0v+KURGP8SqraaaGHduJ0CHPUcR+Uyr4eUYfvjxo50pS38YD1AaPooIkFVzt/BXBg/BWakJ3OaGVef1FiLAwf/dwwotDs7c22Lrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763345335; c=relaxed/simple;
	bh=cTyA4zuTP9c1i3FAJW4tMOAoFoDwr1FH3Sdzo6I/xhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftbGDRfDIJq3odQZpsgVCagBOfnNY7CqMQ9qdBq69LywyFjyqPjx/BqR7R7NThoXS67m2+5FGNR+g+HXElQeiMrx2zQ9lCAKqucp7rjTU3/PQXRiP237wYqyakpLK/GkIpZ0PdyXRLHJEAherqCtQAI6v2VmpyqPz0c4jZA81do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=SMbnifWU; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="SMbnifWU"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id KofavP9Ia9u4DKofbvoWJJ; Mon, 17 Nov 2025 02:08:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1763345324; bh=8eZ0orKT8fI6cJhAaxj4yDowrYiKPYFQFUavX3h7rTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SMbnifWU6I8AzYDOp4u1/X/I8L58VubJkQx146HwBHquGEViof5WT3MVSezXDOpbX
	 Y17G9ddWBk3rZkNRGn2g9fhdhrj/pky5Gn/JnwzjbMYxnK3L8newDfcwKG97SfPt+g
	 Qi8Rm4RtVOurzTU3ijB+NsNSxAJ6soZ1N5jGQJLeMKsGnviKfvxt9qB3ArzveIvQ+R
	 QODF40gz4qxetZ+P22R8EAlLLqdKSX1dc4rqHLtp4nrr2OjSuLzj9v2yagOEAJjHlG
	 XCebKdqu9Jr6lc3Weju6iIqAKXlAYxMjmGrB5CXqyJn7xt6nRhWJVeiNubIexa6EkW
	 lt4Q0mRZj9Cgw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UKJ+Hzfy c=1 sm=1 tr=0 ts=691a83ac
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=R7njS3VIc4PqCLsFrzYA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <dd012ab5-d239-49b8-8635-8d22e16c9f1c@ramsayjones.plus.com>
Date: Mon, 17 Nov 2025 02:08:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>, Chris Torek <chris.torek@gmail.com>
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
 <5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
 <a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
 <xmqqpl9jfdso.fsf@gitster.g> <xmqqzf8la20o.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqzf8la20o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIVWGb+/guZV4rXSKBaQ1LNAMEesmYOG/9k1fmkRrvJLASJYz46MBXKC0C23nH6FYzy90YuFqQKDW+hNmn03KjdZlAS9jSx9BJcwJJiAYeG2ndp0U1Ja
 noK/9+YpO5LTIJbY08lJpWNMAF6uNsPxcpsYjLNE/o2mRWlNHqM4ollr762iqBhE/ZqsED+KrziWbFPrjxW76bj7g0GhcVC9k58=



On 17/11/2025 1:20 am, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Me neither, but I suspect it may mostly use of non-word "signless"
>> that is the issue.
> 
> So, the patch text that claims C's "char" is "signless" still needs
> to be updated, I think.  The problematic paragraph (with a bit of
> rewrapping) reads like this:

Sorry for being AFK for a over a day! :) I didn't think this would
generate so much traffic.

>     C comparison problem: While the sign of `char` is implementation
>     defined, it's also signless (neither signed nor unsigned). When
>     building with `make DEVELOPER=1` it will complain about a
>     "differ in signedness" when `char` is compared with `uint8_t` or
>     `int8_t`.

Yes, the 'signless' nonsense is what 'triggered' me. ;)

> 
> Perhaps
> 
>     The C language leaves the signedness of `char` implementation
>     defined.  Because our developer build enables -Wsign-compare,
>     comparison of a value of `char` type with either signed or
>     unsigned integers will trigger warnings from the compiler.

s/will/may/ - it depends!

>     Avoiding `char` of implementation defined signedness helps us
>     being a bit more explicit.
> 
> or something is sufficient?

Yes, this looks good to me (but then I am not particularly good at
word-smithing).

Thanks.

ATB,
Ramsay Jones



