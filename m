Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B952C182
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962148; cv=none; b=TBAbpJvGjc6HWF5TFJaJVrPAGdqu1MT2F3aq4k5dY01qp2YKv9DkPvGhbjd1CuhYJlxs3hCX91JOlSUc5lmq70tPxodp+0CoDoYM0M5lwyGaej4xnLoJerkESyznKvlfIBMK3sD+KHJUc22tQQpV9utgKRWtXs3lKRmMd8yJEFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962148; c=relaxed/simple;
	bh=+zyVc8bDAWNPC83oqUoXYfyQpG8SB7Wj2OQb+3LcK3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oz+eS4J8p9O77hHoK/gcACmsHU4cEUncZfWXscEn08gBpSNwEXuQom7Y52keUBTc7DS9p6ScvVZNdrudGYA3992aBJ2lfPKKAccAnOFGGYGxWYMaFuN8C8qne6vJeYdkmMxr1Y7+Ky1tE2XuH3Kxn9rIEvMgznpYY2vNeiLaFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lni8EHOH; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lni8EHOH"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AEA70361CD;
	Tue,  6 Aug 2024 12:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+zyVc8bDAWNPC83oqUoXYfyQpG8SB7Wj2OQb+3
	LcK3g=; b=lni8EHOHV7fVFYGBtrI2Jkm2PneYPhIZ42YU1Ob0oWAOfpKpuWZw/P
	sxegew/n0CMfd0ejdcXB3XUcq6FJparUcrnILz3sysepco24DPn2NrynMUk8CInT
	c3psdDNeFtyZabfOqCD6JxGxn3DphvMx3l70Aj6yzPJ+RVBVrQnUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A6AC4361CC;
	Tue,  6 Aug 2024 12:35:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2F235361C9;
	Tue,  6 Aug 2024 12:35:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: AbdAlRahman Gad <abdobngad@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 8/8] [Newcomer] t7004: Use single quotes instead of
 double quotes
In-Reply-To: <CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 5 Aug 2024 23:02:01 -0400")
References: <20240805235917.190699-1-abdobngad@gmail.com>
	<20240805235917.190699-9-abdobngad@gmail.com>
	<CAPig+cSzq+6bua=T7w0M-+7+2zbzfD6ihXLkWfondZ8NbqUG4A@mail.gmail.com>
Date: Tue, 06 Aug 2024 09:35:33 -0700
Message-ID: <xmqqo765vcbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E8680A8A-5411-11EF-B535-BF444491E1BC-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> As a practical example, consider a test with a body like this:
>
>     echo nothing >nothing &&
>     git add nothing &&
>     git commit -m nothing &&
>     hash=$(git rev-parse HEAD) &&
>     ...
>
> If this body is inside a double-quoted string, then `$(git rev-parse
> HEAD)` will be evaluated and its value assigned to `hash` _before_
> test_expect_success() is called,

I know it is just your finger slipping, but the variable "hash" is
not assigned to before test_expect_success is called even with the
body inside dq.  

What happens is that the value of HEAD is expanded in the string
that will be evaled by test_expect_success so the 4th line in the
above becomes "hash=3469a23659d8197190d2765cf9f31dec5ab602fa &&";
as the resulting string is then eval'ed by test_expect_success,
the end result is as you descirbed, i.e., ...

> thus also before the `git commit`
> command inside the test body (which is almost certainly not what the
> author intended).

... $hash does not get the name of the commit object resulting from
the "git commit" command before it.

>> -       "
>> -       test_expect_success "Doing 'git tag --list-like $option <commit> <pattern> is permitted" "
>> +       '
>> +       test_expect_success 'Doing "git tag --list-like $option <commit> <pattern> is permitted' '
>
> ... changing the double-quotes to single-quotes for the test _titles_
> in these instances is actively wrong. In this case, we _want_
> interpolation of `$option` to happen in the title string so that the
> output looks like this:
>
>     ok 167 - mixing incompatible modes with --contains is forbidden
>     ok 169 - mixing incompatible modes with --with is forbidden
>     ok 171 - mixing incompatible modes with --no-contains is forbidden
>
> By changing the title to use single-quotes, you suppress interpolation
> of `$option`, with the result that the displayed titles become rather
> useless:
>
>     ok 167 - mixing incompatible modes with $option is forbidden
>     ok 169 - mixing incompatible modes with $option is forbidden
>     ok 171 - mixing incompatible modes with $option is forbidden

Yes, these has to be done carefully, both for titles and bodies.

Thanks.
