Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37E118EAC
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d5UpDEPN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 29A18278CF;
	Fri, 15 Dec 2023 17:19:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Lg2ZLsV3UPTi0SqHK2FCScuX9BgQbTD+sbhYAI
	LsHeQ=; b=d5UpDEPNsLu50GL7T7zibGR823vVzfZiMsFcVIa/ethKgI4z2LaDeu
	CIY+w8YPlxX9PRHaw4+H4nHkRCzMsS4cFxZ97qUW1JX//HZNNciTPCZ2w3N9gtZf
	oxsEL3NIsHoGHgUb/xQH+MfnFd4cwwrk3shc42r5jOXpPJDiPpHoo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2259A278CE;
	Fri, 15 Dec 2023 17:19:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60C30278CC;
	Fri, 15 Dec 2023 17:19:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/5] git.txt: HEAD is not that special
In-Reply-To: <xmqq1qbnktnl.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	15 Dec 2023 14:06:22 -0800")
References: <20231215203245.3622299-1-gitster@pobox.com>
	<20231215203245.3622299-2-gitster@pobox.com>
	<0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
	<xmqq1qbnktnl.fsf@gitster.g>
Date: Fri, 15 Dec 2023 14:19:48 -0800
Message-ID: <xmqqttojjegr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1031ED5C-9B98-11EE-9E5A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>>> -may contain the SHA-1 name of an object or the name of another ref.  Refs
>>> -with names beginning `ref/head/` contain the SHA-1 name of the most
>>> +may contain the SHA-1 name of an object or the name of another ref (the
>>> +latter is called a "symbolic ref").
>>> +Refs with names beginning `ref/head/` contain the SHA-1 name of the most
>>
>> Hmm, s:ref/head:refs/heads: right?
>
> Yeah, right, not a new problem with this change, but is indeed a
> good thing to catch and correct.  Thanks for a careful review.

And we have ref/tags/ just below, which I also have fixed locally.
