Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01518244664
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763876968; cv=none; b=AMu5hucTgj39zwLqZdXqJ1OTHa6IHQ7tcEET2FLHGQZP9qKpbA4jAxM0YSI0WXJb8qL5BMdAJHzZAfO5csdtbTbu2nlJLBVGSgiBI2eu1zpsW7AYAbwLx4HiIoHYcIWvTncRQyxoGRogQ0LIAX6uQ3xZEwzSH7Gqzb4Qb8yeIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763876968; c=relaxed/simple;
	bh=a641t4vmBApOfG5DODUftavCE9GW33bDbHieSxXjiSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ln1WfcspiPMedHteCu/y5TiLF8EaIf0CxTef5+VbcsdGlEbaSsWdt6oihRCgmOlp81IdxXndhjt6PYBsNfWF3xTI4dUnaoeCi2IRSnPnyJ+R/kWSHGHdvAfia1qgeEFUEfUPu+hmZNGTINlAPKAnoKJE3sbbt7GsVkursI5GRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ha+zKXbI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UP77JOZ4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ha+zKXbI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UP77JOZ4"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 081301400058;
	Sun, 23 Nov 2025 00:49:25 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 23 Nov 2025 00:49:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763876965; x=1763963365; bh=ctSgtj+Loh
	Hp8ETQhFkA7736TYZziLKBRuf2CSK0B6Q=; b=Ha+zKXbI4yxKjhF2cQAvHYdq/d
	7F3NZFHDyFfAZGj/a/1/fMwEXW/A8VeThrSySZjmdNXK6bmWJOopZE/VQmxmXbdj
	sw74aRh29pGunkLqXqvIOh5yqS3QmopOpLrn5b1jZgPWHenwmyL9rSwzSz5pN74x
	9ugDLOS1dr30zpXgIeRsizJd8vkID+Mycah4rElRiRx1gYbuWbZJ0pxT8eReONP6
	SDm/vCPlNQ8JHrY8D9xg8lHpjModXQJYopmboeX5u49I0XeL3HQz8DfSeXWymGkk
	jNrCs4CIsgS0CRT0kVucWSLUz5hzuWZOyhKyn3K7I4yJ56eRqcv5Rzv13o9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763876965; x=1763963365; bh=ctSgtj+LohHp8ETQhFkA7736TYZziLKBRuf
	2CSK0B6Q=; b=UP77JOZ4PjR54MWgp8vqWMCHkUIvRjX3Z98pORRwGIypFbFZRWH
	fyybB0E2zIfGYNuVUZeZWHwputLMgWiwc8QIlmUKvEfjwGWJjqg9v/yBu1Mh4Ir5
	whLX1ii0YTKjDWGZHInFtCPohV7Ee74UQz6Kh0R+QVaOjKamaCM4Xz+rc7CPA7VH
	4QRuhYzLzaKuC9yJiSS8r/EHmGNT7MEYV5pEt0Jjs/sXThJssOViISLAi4zmnJuj
	Fe3O0d+fguubZI7Mc41Xwg9zK9XQW1X2tACN8OoobX9gTVA2Y8jxI7nE1X7yvaqE
	4UBs3mSvMmEk74B89hppFz3ONssXsko/asg==
X-ME-Sender: <xms:ZKAiaZBJ7YbJTPWXNBMqxLI7AwG8-XHAYTJCJGNKNaTCCpgq5dxr6g>
    <xme:ZKAiabPzUEs1D5tL4v4L6pycApK40Tg6YSgelyPgZXSFuBw_ONtevhRzNm0pydUh5
    qpUyfPXeuhRMbEEFzDlRr92UO7umCcbxBZK3tv1Z1LcpxHP8UsnDg>
X-ME-Received: <xmr:ZKAiaebvMfjTa7jF8yt7SOJvlVCkq6l1KFSmFHHp0aljUmgw6lnkHgd_nL_8Z3JUhDuWY-TTRlbDaexKPEKzXmmKX6lmbu-TA0v8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:ZKAiaas4wQoLLdhl_bTPsIsTOGc5P3SFSq7LAwArYovC3vVraH0R6Q>
    <xmx:ZKAiaQOSSBsuQZRK0UYqDQe32JgxnBhjuOQWaCRcEMyR4V_tsazoCw>
    <xmx:ZKAiaR78CJW2oLm_FCWKoHp82TlaGAORguMsRZm6UPqwuV8GXY5ASA>
    <xmx:ZKAiaWTDBgUChp5DPXzjCIDdD_oAtILkS7RQ_uIgnISCPRdCLNqvaw>
    <xmx:ZKAiaem32I9yOx5YwbN-qO28ox6ndKLTVuBbumfs_U0HDigLEXZpaXWf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 00:49:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  correctmost
 <cmlists@sent.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/9] asan bonanza
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 18 Nov 2025 04:11:27 -0500")
References: <20251112075522.GA978866@coredump.intra.peff.net>
	<20251118091127.GA4175601@coredump.intra.peff.net>
Date: Sat, 22 Nov 2025 21:49:22 -0800
Message-ID: <xmqqy0nxz4bh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Here's a v2 based on feedback:
>
>   - added the extra assertion in the midx code
>
>   - meson changes are squashed into patch 3
>
>   - The cache-tree integer parsing is more robust around total garbage
>     inputs (with no digits at all). I agree with the reviewers that it
>     would be nice to have a robust, reusable integer parsing function.
>     But I think it's non-trivial to do (and I left more comments in the
>     thread). I'd like to stick here to just fixing the memory issues
>     without making anything worse (which I think this version does).
>
>     Note that since the new helper takes an out-parameter, we have to
>     match the type more strictly to what the callers have. So it is now
>     parse_int(), and not parse_long().
>
> Range diff is below.
>
>   [1/9]: compat/mmap: mark unused argument in git_munmap()
>   [2/9]: pack-bitmap: handle name-hash lookups in incremental bitmaps
>   [3/9]: Makefile: turn on NO_MMAP when building with ASan
>   [4/9]: cache-tree: avoid strtol() on non-string buffer
>   [5/9]: fsck: assert newline presence in fsck_ident()
>   [6/9]: fsck: avoid strcspn() in fsck_ident()
>   [7/9]: fsck: remove redundant date timestamp check
>   [8/9]: fsck: avoid parse_timestamp() on buffer that isn't NUL-terminated
>   [9/9]: t: enable ASan's strict_string_checks option

Aside from the comment on strtol() replacement, this iteration did
not see any comments.  What do we want to do next with this series?


