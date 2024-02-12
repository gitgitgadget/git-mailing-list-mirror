Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B93F8E4
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756004; cv=none; b=ObWR+HXfcdwRY5BZFX95BLzn9swz9tvcWII5p58+Cxh8eWPdkQUCXKkHh30265DSJpRVvVDkwK52fIMeRaIbv8BHmSI87ek3QxGGncbi/73Zz4ZrIFDmGH5fuQsKs74WGo0aauEr4j7K44wbDS7vM9UIHT5LBCgdzdcgL0/mIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756004; c=relaxed/simple;
	bh=HkUrW52+KnTx1dhXxmlr1AlCLz1EJOkMc4NlwZuFnx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPBa9n70YSPubtVGJK1zpxsUUwLYtnilHznWY+G7Ob00/G/amntEIkQoSATzYARE581alIUiBk8vHIPsZmUfsjjUYoC3xbO5pLqhcvMQbQnFafxSvKpr00y11X9Av+JbtFWJ4N/xlVqWWLvS6LHLnqa4Mxem7lDmJVLkst2Pi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GZc8T2+x; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZc8T2+x"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E27B42BF1D;
	Mon, 12 Feb 2024 11:39:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HkUrW52+KnTx
	1dhXxmlr1AlCLz1EJOkMc4NlwZuFnx4=; b=GZc8T2+xzFiehfdOMxKStbiQfq5W
	y+XaZTgn8lyfaFfHXI3pkCbxwAduuKXGuoJkO9MrSUGBm0abtjywEaaTbDyvyDmB
	wm0hoE6vWLXz9kcoKc1lHd1WaevC9EW3xYqUsAkBZGlGGeK+yNrA3a1jsL1XcD5+
	UYFhaw830g1nkYk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DAF192BF1C;
	Mon, 12 Feb 2024 11:39:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FFDF2BF1B;
	Mon, 12 Feb 2024 11:39:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: git@vger.kernel.org,  mi.al.lohmann@gmail.com
Subject: Re: What's cooking in git.git (Feb 2024, #04; Thu, 8)
In-Reply-To: <13f08ce5-f036-f769-1ba9-7d47b572af28@gmail.com> (Philippe
	Blain's message of "Sat, 10 Feb 2024 13:49:39 -0500")
References: <xmqqzfw9h7oy.fsf@gitster.g>
	<13f08ce5-f036-f769-1ba9-7d47b572af28@gmail.com>
Date: Mon, 12 Feb 2024 08:39:52 -0800
Message-ID: <xmqq8r3p8wmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 59AE88B8-C9C5-11EE-B6E9-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Junio,
>
> Le 2024-02-09 =C3=A0 12:24, Junio C Hamano a =C3=A9crit=C2=A0:
>> * ml/log-merge-with-cherry-pick-and-other-pseudo-heads (2024-02-08) 2 =
commits
>>  - revision: implement `git log --merge` also for rebase/cherry_pick/r=
evert
>>  - revision: ensure MERGE_HEAD is a ref in prepare_show_merge
>>=20
>>  "git log --merge" learned to pay attention to CHERRY_PICK_HEAD and
>>  other kinds of *_HEAD pseudorefs.
>>=20
>>  Will merge to 'next'?
>>  source: <20240117081405.14012-1-mi.al.lohmann@gmail.com>
>>  source: <dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org>
>
> I think this is a very nice addition, I've been meaning to do a similar
> patch for quite some time.
>
> I think the commit message of 2/2 should be improved, which was pointed=
 out a few
> times in the thread. I'll try to send a v4 with a more useful message, =
summarizing=20
> the discussion, so maybe hold off on merging to next.

Thanks.
