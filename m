Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52401DFFD
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912240; cv=none; b=gjyKVjOC+t0A+Q6tnM0YD7/vwOhdmidk/B04QO5IEOa56mk5xsBez/J0UXfSuvra2eNaXK2DDCeEMc94YlVc+xWsE7yhJQfBn88b3wDpS+xi8UyIOOGeALxNMKxcDErGWA85NOlKuE5CDfSTDpk27RizsPM0U2cUmCPBOuDuhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912240; c=relaxed/simple;
	bh=ItIkdqGoXXzxeQIwgehG8WbXYJq1+wqCgHWCdIq3lZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dsmcv4dqJWFXWE7tUJ3+phSe5imW2b0xUe5QQFuJ0srDQlKj7Q4TPZEzIkQMJxx01Ot72ACt/rxFyhwJ9R/NwoodShVzS9L6H7ZR51Jl9rV60Ryvh3NKvZUhynmW0H5jQx2f+VLXj6Blovby0L1KI6s/hcGuWzGlFE7F2OXyy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pOGkMUm0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pOGkMUm0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD1C11DFAB3;
	Fri,  8 Mar 2024 10:37:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ItIkdqGoXXzx
	eQIwgehG8WbXYJq1+wqCgHWCdIq3lZ0=; b=pOGkMUm05faf3a5wfUIP1kS5xfk3
	DAt8DKJFOt632/KObtHvQurCYaQBpfIlRwBLwRobWraqBwOW+e2egUQdSNrqrS4D
	ZmDgvs01f+AIPTsYNFvMHA8yfS9Edbb5hz10skWH/k9wnKG+6wmonT99b8lzv7EJ
	jhrGzbyAjHONYqE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A501B1DFAB2;
	Fri,  8 Mar 2024 10:37:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D8B41DFAB0;
	Fri,  8 Mar 2024 10:37:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2024, #02; Thu, 7)
In-Reply-To: <CAP8UFD1oWrE-C0XYi47PrBF36bJzHAv-jOq3r1UXw_BVnb97pA@mail.gmail.com>
	(Christian Couder's message of "Fri, 8 Mar 2024 11:31:41 +0100")
References: <xmqqplw5ihm7.fsf@gitster.g>
	<CAP8UFD1oWrE-C0XYi47PrBF36bJzHAv-jOq3r1UXw_BVnb97pA@mail.gmail.com>
Date: Fri, 08 Mar 2024 07:37:16 -0800
Message-ID: <xmqqy1ashh03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BE6B844A-DD61-11EE-9CCF-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> (Sorry for sending this first privately to Junio by mistake.)
>
> On Fri, Mar 8, 2024 at 3:27=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
>
>> * cc/rev-list-allow-missing-tips (2024-02-28) 5 commits
>>   (merged to 'next' on 2024-03-01 at fd7b109d04)
>>  + revision: fix --missing=3D[print|allow*] for annotated tags
>>   (merged to 'next' on 2024-03-01 at ac0fc94378)
>>  + rev-list: allow missing tips with --missing=3D[print|allow*]
>>  + t6022: fix 'test' style and 'even though' typo
>>  + oidset: refactor oidset_insert_from_set()
>>  + revision: clarify a 'return NULL' in get_reference()
>>
>>  Originally merged to 'next' on 2024-02-28
>>
>>  "git rev-list --missing=3Dprint" has learned to optionally take
>>  "--allow-missing-tips", which allows the objects at the starting
>>  points to be missing.
>
> The description might want to be updated as no new
> "--allow-missing-tips" option is introduced anymore. Maybe something
> like this instead:
>
> "git rev-list --missing=3D[print|allow*]" has learned to not die when
> some tips passed to it as command line arguments are missing. Instead
> those tips are just reported among the missing objects and ignored for
> traversal.

Thanks for a comment; better late than never.  We'd probably need to
update the release notes, as this is gone from the list of cooking
topics already.
