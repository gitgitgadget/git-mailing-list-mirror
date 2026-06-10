Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69934183AD
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103085; cv=none; b=jeR9fNQRF3DhMy1hAKLdcyTBUYZNzzp+TiZYFjmKd85KPZoN04tACU6gpBJ09rK8QAJIESpDZe+HrR1BAPpcEe+7UgZ31v8YIDKBDO16pKExXZQ2PTwZMMOLM8kUMayMpEu7k2meWduLzUHBsIGkIqm/v4fmbwwOtgnHQYdLsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103085; c=relaxed/simple;
	bh=IyQLqKgLglMbpuv+gOMYqxhs2reHaWFEqviWy0wshSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdCK8WtPjHJD0dD66jSvoUNmeMdHe8nzQ4kfyzsg5bZ/pZDUBMTmXHbDa0kjp7A2oBqfcEzzoPdGWikAc9k4/PEML7hQFDnD6onrnnLTRbPOfHCDVF20c+ZHUlwMddLGPQ/JJVr5KlKldgd7a9jmp9U54U9HfjxnkqE2c+LatHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P/ddzcIb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gtlj0kUr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/ddzcIb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gtlj0kUr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B4A0140013D;
	Wed, 10 Jun 2026 10:51:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 10 Jun 2026 10:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781103081; x=1781189481; bh=IyQLqKgLgl
	Mbpuv+gOMYqxhs2reHaWFEqviWy0wshSA=; b=P/ddzcIbFQ3mNqOjpQtXqPd1Db
	Yq3ftBhcpUz3WxgK+lsaMf4FVSfVC1QIaXxVXhu/RdS0rgILUpzkfcQCs4tlDZtj
	jMzHrQJJ6afFmycEPcuNmCY+uLLltg4jxzMezS6S2PmUfEMhQjRRVDuXDHlCH9/p
	UFpTYLS+blfwTRpVdg34G+A0TDllcBrzvITL3c+ekqg48e8oTtobEEm+RF3esE6W
	zkzr3x4HQSzD/sIA23S0YMfId3TmX3iIXNk8SfMKvDwMozd/yItWAiDWjixWBB2c
	8YZUZFu9E5I2rxfOEjQ5Vrd0ww3l+ui6RoIeTmTLa3FJNZOvoOV/MupgpgKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781103081; x=1781189481; bh=IyQLqKgLglMbpuv+gOMYqxhs2reHaWFEqvi
	Wy0wshSA=; b=gtlj0kUruGKt2He/UWhJZsRdEFSPIwJ9XOz6GtCTbvrxV2p9qSA
	Liur3MfRkGwIhcxTGfpbzjqpYMdlRTyC2W3R0k/UUYo4bsTAu72csDGHdLV+Sdbk
	7enKK/AK40XmQZKTRGJUt+aUA0yUAfT37pP4gE5sj3ifetQ9ZE5elfVz7YvM5S7k
	7zE8NyOUgsq9xrV0f6QM5GMd3ZMxh2HsnkgE8TO9G0tkSWs5+TR23/YWvLi8ZaoM
	pGZFUIyOd1dPvn/BO0MMVQgwrWelBlx1RdBCiSD56kK6osSfG74V58578H3zRGpU
	h3OQ+B74CRLfMuF5QNANMwbASISYOD5F4Dg==
X-ME-Sender: <xms:6HkpamQ1SYv8vXJRGdrWK8wAGz0OFvxdGuzpI6rHHWHk877hzFctBQ>
    <xme:6Hkpaq2OvJLk8UKwcghkf5ezCzPR7uBTSme2TyxB8zzsKiF-mUXGZKHJTFprhKMr-
    _83D7etbRiUgwVwBwCeOgV6VHDCBe-Rog_xCYRU7mBcSAn1JME1z_I>
X-ME-Received: <xmr:6HkpaqDrgANP8BLWv2q71fsZ7J7PvccSRPqI1-iAihq3h7JrbdLBFPF6f82lvgFH1lL_qK4-vqXGbhVxrjvchRJHJPwl87_aAK5q>
X-ME-Proxy-Cause: dmFkZTGaop4cfcS6NMP7p+npNH8ww/DUZJ7tbLdC+zZ4FEla2Vo2ytPnxqIFoVSQ5BziAv
    8v4QguWyUHkb2peMeobhUY/5Aokte12x18+vekPIM0sjal8yXWWa+EDtNtfOASVQptZhC3
    wSOOAHfj5yPt8EdBXec5Tt7lblPA/C4OVjzG+I7iOBQ0qCS2aoeivgjVIlpkTgKWWOVobs
    2q5z1mHwJpO9ejQK/JSi+hs3Nt3I31GbbMg8KrSkOYCdIG+4lMnxqGAXLYYdLudVu3FlSL
    MFwMYi53o+nFQv97zQp8h+ohzlVeugzEI+9moOwDUFgt8Id3RACntsW1kNqr8EAxRKpaHz
    CNAKZBLYN2PkhQKk+GjxB6v3Kg02iHL+XNCXa/wz9Kz14ZHNdiD+214T8+flppZr84BNos
    azc3C1ZDX+4Cig80KPKIJ75Vog8X21JJnLV7ty7NCBQqeWb2tUOjeQ6Z55XqWPToGb8hkU
    VK4c9b1fvbR8oz4+cOIv5dL11UauogNTXfGDArO66T8rsdrFuJaB/92Pls1l5rfEBzNPJl
    j+6HZeFrhSSsBSX9yPL+F1hbeEambhHW1CyKlDgU7rbwtMXpvFQrrDkeUK27Evd7u3wG5s
    Yil19SgHWYLYE8b23zvvueqOck80pkfizhpXjpcpM+8vOTJfivM7MX6Y/EEQ
X-ME-Proxy: <xmx:6Hkpaugw_71EcL5Q8l-x4uzWKujAg5rnAyNQ8DfQ2a6B5zaTueeIZQ>
    <xmx:6HkpakPRtplQbhB1m-B0dv78xr6oa7u5xXErct8U9iEJJjlQSDYGEw>
    <xmx:6Hkpam9JVZeIoeZ4R9qVr9KJcNBK3AtJhz8XO-wwck59iR2Bu5HMUA>
    <xmx:6HkpatdOYYa3qUxOg4kqsPj5RkwcD63hH7EkIbrf-PXBTsGrEjMrdA>
    <xmx:6XkpamTDq2aGG0No8iItyqL9btm2hREoVG-wE7JJJAmzarcUlI3TkFTy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:51:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arijit Banerjee <arijit91@gmail.com>
Cc: Jeff King <peff@peff.net>,  Arijit Banerjee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJu?=
 =?utf-8?B?ZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Derrick Stolee <stolee@gmail.com>,  Arijit Banerjee
 <arijit@effectiveailabs.com>
Subject: Re: [PATCH v3] index-pack: retain child bases in delta cache
In-Reply-To: <08B48BBE-4084-4619-94B0-503158B93BEF@gmail.com> (Arijit
	Banerjee's message of "Fri, 5 Jun 2026 14:18:27 -0700")
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
	<pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
	<20260604071204.GA3196596@coredump.intra.peff.net>
	<08B48BBE-4084-4619-94B0-503158B93BEF@gmail.com>
Date: Wed, 10 Jun 2026 07:51:19 -0700
Message-ID: <xmqqldcmxxco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arijit Banerjee <arijit91@gmail.com> writes:

> Apologies, my earlier replies were sent through GitHub's notification
> emails and appeared only as PR comments, so they did not reach the mailing
> list.
>
> On Thu, Jun 4, 2026, Jeff King wrote:
>> So I am happy with either v2 or v3.
>
> I also did not see a meaningful performance difference between v2 and v3.
> I am happy with either direction and defer to the maintainers on whether
> v3's more precise release is worth the added complexity.

I have no strong preference either way.

> On Wed, Jun 3, 2026, Derrick Stolee wrote:
>> Did you see any evidence that this change has the intended effect of
>> reducing process memory proactively instead of relying on cache evictions?
>
> I do not have strong RSS evidence. The spot checks showed no meaningful RSS
> change, and max RSS is not a good signal here because free_base_data()
> lowers Git's internal base_cache_used accounting but may not return pages
> to the OS or reduce the recorded peak.
>
> The evidence for v3 is therefore structural: it releases the cached data
> once all direct children have been dispatched and retain_data reaches zero,
> rather than waiting for cache-pressure eviction.

