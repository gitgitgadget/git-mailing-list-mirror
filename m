Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CAB70CBE
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309770; cv=none; b=qY32o6cAbwdrlPMtmwiXyVHd1j3crBwLp6N+UxjoN9tI8AxFWX0S0fINROSV20934XRIG92yM/rnkrnM7uiIOHtIyXfAyMmCYe9AS/Z3HaOgERR2rhPbDnWNoXRuKuY3mGmsyQ/RC5Gjqk9gasJ0oArachMzo6wst5gS1r7+f/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309770; c=relaxed/simple;
	bh=rBVwXN2tGVKltO7gGWUdEcpHd9ac+cGP5d8Wc8XT+Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxMrnob/NKB8TPU4omgTJCQfXKX2Yg2SsAKUyfK8IzOUHpcw+zeO6jHArBXzquTCz6FFeRcz0HDoFTbQoJLE+9Tz9Z3uje4gV9QMJUXbyVnY0NP14RkWuOADPKNMkE2sc4B0MgYcY6xDQV6D9vh/Y43FHlMtaDhMuV3y0w2JxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AJR/ltZS; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AJR/ltZS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 271A21D3A8;
	Fri,  1 Mar 2024 11:16:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rBVwXN2tGVKltO7gGWUdEcpHd9ac+cGP5d8Wc8
	XT+Dw=; b=AJR/ltZSY8K5EOfD4NtejqbCIEFyKHroXov8sXBg9mhZmwE3NlcIuX
	dbBt06i3Be+uXH7wbhLz/jOnEw2poV7LrJltsMvutxJ2G/2teTHrteB9+cdJUK+D
	bZdmwT5e4C1rVTO85z6BoJjicYkAzxRiCYxvH6nN0WCbGjNxkG6DE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 205981D3A7;
	Fri,  1 Mar 2024 11:16:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 75EBD1D3A5;
	Fri,  1 Mar 2024 11:16:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
In-Reply-To: <xmqq1q8ubtg6.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	29 Feb 2024 18:02:17 -0800")
References: <xmqqjzmpm9b8.fsf@gitster.g>
	<owlyil264yew.fsf@fine.c.googlers.com> <xmqq1q8ubtg6.fsf@gitster.g>
Date: Fri, 01 Mar 2024 08:16:01 -0800
Message-ID: <xmqqsf1a7wse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00262CF8-D7E7-11EE-93B3-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> Doh, please wait for my v6 reroll (will send to the list in the next
>> half hour) to clean up the commit messages. Thanks.
>
> If we had communication gap and the topic was prematurely merged and
> was caught within a day or two, I would be a bit more sympathetic,
> but given that this was merged more than a week ago, that's totally
> unacceptable.
>
> If you have improvements, please do so as incremental patches on
> top.  I'll hold the topic in 'next' until we are ready.

Well, I changed my mind.  As we haven't rewound the tip of 'next'
post release, let's eject what is in 'next' and queue the latest,
pretending that the earlier round weren't in 'next' at all.

Thanks.
