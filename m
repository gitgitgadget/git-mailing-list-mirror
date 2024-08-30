Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDD1B86E2
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043273; cv=none; b=BQf6FccJ1oCXyjk7z1zlmvM7ajYCFRTPC1oY/qTEsw3iTWytuag3YxN+Mg9T6aZDaVngUNPMuM/t26bm1wSBjkV1RTMeNQsrvvoCvZR16RittiXwqTihWNLv6NR5KZ5E73BqpBcdZcFCjEYnsMdOeKiL9NVCq2nT5Az27+Upc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043273; c=relaxed/simple;
	bh=qcrE6cmC/m3A+ZaoSDrAGt0CB0XkZoquY0IfR+4Vm3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMTQ7UFol45pdzIfjkK2t243DphDlqMv+AxLctR/5CxDtfKNAkhSck8vKDqI8cDcOx1mlqzOfXhlwz37+DyN7tWvzezEkOOfkK/IC5N9L9Ma8e3kyGdtMJLkMO4+of6OOh76bfhX+2cAX/mG7+5UNIq9SG3Z5YYy5g2QkMVMdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GX9fr5be; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GX9fr5be"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A55720A47;
	Fri, 30 Aug 2024 14:41:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qcrE6cmC/m3A+ZaoSDrAGt0CB0XkZoquY0IfR+
	4Vm3Q=; b=GX9fr5beDO/wACVbxhOueqKqdlzr1p0MAZ4V8EYWXTcHBId7Zgeq3L
	e7ktr/ydsfRTSH3qB2J2SyBGNxw7nM6aWi2BOdgQwoj6rm0VYSE85RzKKGEdMV4b
	fu6cxYVMBF5lAIzfpzx+EI7E+ztnzC5sHG4tB7Sok5HMRVwkKX8M8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1129020A46;
	Fri, 30 Aug 2024 14:41:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5869F20A45;
	Fri, 30 Aug 2024 14:41:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Eric Sunshine <ericsunshine@charter.net>,  git@vger.kernel.org,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH 1/2] chainlint: make error messages self-explanatory
In-Reply-To: <CAPig+cQ+6am7-BSnWZz5=C0Q1Vyng0T4goB+ZE9TKJMrpi_Jpg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 29 Aug 2024 18:04:43 -0400")
References: <20240829091625.41297-1-ericsunshine@charter.net>
	<20240829091625.41297-2-ericsunshine@charter.net>
	<xmqq7cbzxrry.fsf@gitster.g>
	<CAPig+cQ+6am7-BSnWZz5=C0Q1Vyng0T4goB+ZE9TKJMrpi_Jpg@mail.gmail.com>
Date: Fri, 30 Aug 2024 11:41:08 -0700
Message-ID: <xmqqv7zhrgzf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D0B5AF8-66FF-11EF-AC54-9B0F950A682E-77302942!pb-smtp2.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> How about this?
>
>     The "?!LOOP?!" case is particularly serious because that terse
>     single word does nothing to convey that the loop body should end
>     with "|| return 1" (or "|| exit 1" in a subshell) to ensure that a
>     failing command in the body aborts the loop immediately, which is
>     important since a shell loop does not automatically terminate when
>     an error occurs within its body. Moreover, unlike &&-chaining
>     which is ubiquitous in Git tests, the "|| return 1" idiom is
>     relatively infrequent, thus may be harder for a newcomer to
>     discover by consulting nearby code.

Strike ", which is important since .*\ its body." and the above
reads perfect.

>> > -# name and the test body with a `?!FOO?!` annotation at the location of each
>> > +# name and the test body with a `?!ERR?!` annotation at the location of each
>> >  # detected problem, where "FOO" is a tag such as "AMP" which indicates a broken
>>
>> "FOO" -> "ERR"?
>
> Yep. Sharp eyes.

OK.  I'll mark the topic to be expecting a reroll for these small
messaging plus "ERR" -> "ERR:" but without other larger changes
mentioned in the thread.

Thanks.
