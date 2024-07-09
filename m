Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BB1FA3
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566481; cv=none; b=ocSUjjhtQ9Oyt/Ko3uCv9InUXRXTwm2eETelDIZ11QpIpAnSM7rdy/VVAoy3VTq3vXgXan+MGy4/VckVRz9DotOR29FV9qOmUqJdWjDOB38WPnwFHmIaNVoF36Hl2yWc3VJFLCleAS4mJcqnn4z+hWhovD+QYbWtrCHxWR++hwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566481; c=relaxed/simple;
	bh=UlHJBr0qnFofhlOpEb5IM4AbwdHH4aNh0ER/OBpyxJE=;
	h=From:To:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=bW0qb6IG3t5YY8yT14le6eUHfSfZxgykVbw0SgW8/0mXa8+81DuhMx49qpS3tmYo0R/AwSvtFFGxi0Ltn9ox3ZyQW3xSPssIQ2ODROtQK2eUT5CQc7WKLtfqHQETrrPiOpgwY4v/qeiPFKF4WsCUVBzRvo9t2rLupWphZiNrVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=p/q9zDAJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="p/q9zDAJ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 11791240027
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 01:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1720566471; bh=UlHJBr0qnFofhlOpEb5IM4AbwdHH4aNh0ER/OBpyxJE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=p/q9zDAJgMGb7IN/0tpSEKOhanySneu3g5Qhb32Lx1lRlMwQXcSxuEwA47eClQN7a
	 UNzvg9ayqS3eRI+jaPb/2GJ4/hMJx+Cc3BDN5Cj+YrARJZ63xh4CbmMTFfNyYed6Xw
	 vCk08VwdvwdkD05+bw3DwwnY9e1BnQk6CuFjBBWddZf7pahPt5elj39pFE89/kK946
	 wQBmVjmRdXiCjVszI78bX+t21EL8vfO19qmQJ2tFeyisjnkJ0xYMFnR5HTE70isZkC
	 g1x4tuWb0U7H/ANMD+V//YFcsTZ0Kw9/uo2gNifRDfz6bYcPogDuNSgeiihbJvmfhS
	 L5i9qrdxQXMIA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WJc8k3M8Bz6tvs
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 01:07:50 +0200 (CEST)
From: Tomas Nordin <tomasn@posteo.net>
To: git@vger.kernel.org
Subject: [Tomas Nordin] Re: Unbalanced closing paren in help of git commit
References: <8734oj7fnv.fsf@posteo.net>
Date: Tue, 09 Jul 2024 23:07:49 +0000
Message-ID: <878qyauptm.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Sorry, I think I forgot to CC the list when I sent the below message]

-------------------- Start of forwarded message --------------------
From: Tomas Nordin <tomasn@posteo.net>
To: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unbalanced closing paren in help of git commit
Date: Mon, 08 Jul 2024 23:11:16 +0200

Junio C Hamano <gitster@pobox.com> writes:

> Tomas Nordin <tomasn@posteo.net> writes:
>
>> Hello List
>>
>> The second line of the help message for git commit looks like this:
>
> This seems to have come from 00ea64ed (doc/git-commit: add
> documentation for fixup=[amend|reword] options, 2021-03-15),
> if "git blame" is to be trusted.
>
>>     [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
>
> We can have --dry-run but we do not have to, we can have only one of
>
>     "-c <commit>"
>     "-C <commit>",
>     "--squash <commit>",
>     "--fixup amend:<commit>"
>     "--fixup reword:<commit>", or
>     "--fixup <commit>"
>
> as they are mutually exclusive, but it is OK if we have none of
> them.
>
> The last closing parenthesis after <commit> but before the closing
> square bracket is unwanted, I think, as you pointed out.

Maybe explicit grouping of the mutually exclusive option-argument pairs
is better? Like this:

[--dry-run] [((-c | -C | --squash) <commit>) | (--fixup [(amend|reword):]<commit>)]

The closing paren would then make sense. I /think/ this is the way I
would have written it.
-------------------- End of forwarded message --------------------
