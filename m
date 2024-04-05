Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2E339AC
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358964; cv=none; b=OymYfXZFscwTzgmLfFUNoy5oKny9NJnf+lCdihoEzJb9Ie+GlHQGP7mBPdlPxpy5sUy8AzjuqYy8gKiudKCY8+vXl40tnSH5Y9U6yEi0VL1LeaOQ6/Tn9GuNZkg4jVxDZXIHGl6lE9KpdqmWjo5o9jEKRyIr2p7oGLdzClIEyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358964; c=relaxed/simple;
	bh=TtO5vt+4E9srpHTX9qsL1uvgxiRvx036YxwJOdv5+kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTppGsXPs4ldXHNZJ0AcyOld0NXYDLVO3nc175sBR6S0Xwk0WwaJyb8Lopm/cOWi+jH483zPN+gmCpvilXXjRiBskpmIva3RwneduafbBKXkPRYZa8t8Ra/x5YozyL3h4iQQDzgSRW5f+mpmuSz3+hWp7ysWBrAq5+W1gjq+UHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SUZ/yq4d; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SUZ/yq4d"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7B28723C62;
	Fri,  5 Apr 2024 19:16:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TtO5vt+4E9srpHTX9qsL1uvgxiRvx036YxwJOd
	v5+kc=; b=SUZ/yq4dbzJ6j5U+yrJ4qq9RYZo2r2wIjeY6MNkOF0DgSLpCvKV/40
	888TwSOxdKhp0TPHuI2LxOTVHoW63tqXnYekY4QqzrGtqLnKB2xAT3jUejnOLAd7
	iZPpNZjg+ufIo1OfZvdJql3GwdPOKsYN30fvUUW3a5icIDE/ZdguI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7355923C61;
	Fri,  5 Apr 2024 19:16:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BE57123C5F;
	Fri,  5 Apr 2024 19:15:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] CodingGuidelines: quote assigned value with "local" and
 "export"
In-Reply-To: <xmqqr0fjtxei.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	05 Apr 2024 12:36:05 -0700")
References: <cover.1712235356.git.ps@pks.im>
	<c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
	<xmqqmsq7yezc.fsf@gitster.g> <xmqqbk6nyej1.fsf_-_@gitster.g>
	<20240405174859.GE2529133@coredump.intra.peff.net>
	<xmqqr0fjtxei.fsf@gitster.g>
Date: Fri, 05 Apr 2024 16:15:57 -0700
Message-ID: <xmqq4jcftn82.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 762CF298-F3A2-11EE-AD86-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> I think that is a good rule for "local", but I thought we did not allow
>> "export foo=bar" at all, and required:
>>
>>   foo=bar
>>   export foo
>>
>> If that was only because of this bug, it would be nice to loosen the
>> rules a bit.
>
> That rule in Documentation/CodingGuidelines predates the discovery
> of this bug.  I have this vague feeling that it was for the shell on
> old Solaris, which would not matter to us anymore, but I do not
> remember.

Heh, I do not even see any such rule in the guidelines.  What
enforces it is actually in t/check-non-portable-shell.pl script.  It
came from 9968ffff (test-lint: detect 'export FOO=bar', 2013-07-08),
which in turn comes from https://lore.kernel.org/git/201307081121.22769.tboegi@web.de/

We make multiple uses of it in ci/*.sh but the environments ci/
scripts are used in are rather sterile, so they do not quite count
as a proof that the problematic shells no longer exist.

We may instead want to add a separate rule e.g.,

	/\blocal\s+[a-zA-z0-9_]*=\$/ and err q(quote "$val" in 'local var=$val');

to the check script.


