Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A31A01CD
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562752; cv=none; b=KhfIzArv6TJF8X19QKkvaw8e6T75yDjpxnG0kE4hFd9kGF0U+djF5LxpuTegobqG7vmq2t9d+vr/HqDJjCtwT5s2F78oqIg8QT/LpOHr1Za48blzLXNzZ5EmK5WDiaSi1wWtUcH52rYgM1ys/wtMdyCaYa3owNoUI994RYFn2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562752; c=relaxed/simple;
	bh=L079R1YsfqFmWOkmXfdCw1cjKtPP6ZgGvrUm7S1VgK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9CE9jniBgcMYUI0RAdwNmC3GeUqBvO0lwsIPkwo/XX85/5ydyWLcP8gdD3Xgub3y8rSdO/hJg86l0tnpjH+DZn9UTyd4SUXwBhAJyrleLkYPKY61xWM73DP+pX4jzvSKxqGdeIda3FP5IR714nAqJ8jC1q0d5IOD5x2Mg5YHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oQunDAVC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQunDAVC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 283951E4F7;
	Tue, 13 Aug 2024 11:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L079R1YsfqFmWOkmXfdCw1cjKtPP6ZgGvrUm7S
	1VgK4=; b=oQunDAVCzzBzlQvdLG0ewN0Xdng593kKBVk2H61vSinZjbMKXQFeNU
	EecURuGgNw5NNRAjpGy1FrSM6X7Q+o2jxwEF6CbOY+IZyFxgXMt07I/CyBLwX6tp
	tsNGayz0ePR3/fKldH3B8qy2vGkYR0N7D7jS7kgWQHrHck53FNrRA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FCF31E4F6;
	Tue, 13 Aug 2024 11:25:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B16E1E4F4;
	Tue, 13 Aug 2024 11:25:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v3 3/7] t/clar: fix whitespace errors
In-Reply-To: <35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 8 Aug 2024 07:38:22 +0200")
References: <cover.1722415748.git.ps@pks.im> <cover.1723095269.git.ps@pks.im>
	<35682b7686e570a96a8432f6b8af1996ab8d748e.1723095269.git.ps@pks.im>
Date: Tue, 13 Aug 2024 08:25:45 -0700
Message-ID: <xmqqv8048mx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5020BF3E-5988-11EF-A9A1-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Fix whitespace errors in the clar that make git-apply(1) unhappy. This
> has been cherry-picked from the upstream pull request at [1].
>
> [1]: https://github.com/clar-test/clar/pull/97
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/unit-tests/clar/clar/sandbox.h  | 5 ++---
>  t/unit-tests/clar/generate.py     | 1 -
>  t/unit-tests/clar/test/.gitignore | 1 -
>  3 files changed, 2 insertions(+), 5 deletions(-)

A funny thing about this step is that the copy I carried for the
past few days was an empty patch, because out of habit I use the
"--whitespace=fix" option while running "git am".  As that fixes
the whitespace breakage this step addresses while applying the
previous step, this one becomes empty.

I'll requeue these patches with --whitespace=warn instead.

Thanks.
