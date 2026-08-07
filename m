Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924452F8E8B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114535; cv=none; b=suaxJj6KF8kFHxh9OO1DvkGjxu9DQexLYLMcR463iNSv5UJ85fFaJNqosIaU2T67WoCdpyYjsYcQrpgxB2JIddc4MTCCZfrk3J8cwBrGRz1A7rRSbb2tYnS4QTt/cMbMfEhRhmKey6pAkk5LhLx/S3y8iHy3+lz/OE1osIooW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114535; c=relaxed/simple;
	bh=iCkitdIWh26frO2pS32yGv4qFms3VOPGFK1tvr5Zixs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=er6qoDznlbXh3jxslRY76G4ALyrFeikEQsCKyqSEikF44JzphOyELYpcVF55xHwBoLxIbuiFkfp//EG/PG9mIn0blw+Qsn1xKrHWDl1H+eB2oxe1J8LrWrzFNu8I1R/R+2/H3xw82Me2DB9tO54ewVTo7EqIqKvfmMhkgtQJvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DfGLdlzu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJTKx7Yd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DfGLdlzu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJTKx7Yd"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B1FD7A013E;
	Fri,  7 Aug 2026 10:55:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 10:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786114528; x=1786200928; bh=ASU7gu/Erh
	s1dIvhQdbHoxPVni6WyyJXNgyllktGITs=; b=DfGLdlzuTA+toMeGhWbzwtU6PW
	aNq01vgGVkGChUjQjmZC5KqkPopGpaKE4/ZJX6hyPYelW59obJKOe8hDUIgwVWrS
	6UFc6p/DIEWjO1/4S69kuXt3f4JzOjf4aPS/+DpvkZg3R3lGisB3kr0U0oNaP3su
	K0BOu/BYa8PKWY8rF348hBVFpR/4XUnNoT5Th6zW78muIa8AAeQ+wDkm+bX2Uye/
	DTCuo/QYIKzLYXT3+K2xUad1TCMWElMX1o88923qsqnwpwpdeXmXnNxf67o1nB5k
	paIi0VYkpmL4vOZmlSJima9TrU4pA7Yn6LH1Jf4ykVHQoqhTAG1ff+Uk8qjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786114528; x=1786200928; bh=ASU7gu/Erhs1dIvhQdbHoxPVni6WyyJXNgy
	llktGITs=; b=OJTKx7YdQcaLhKv1sJdOC5X1wh4Nc3XjG57MSLff/Y1S0tm/C9G
	CafUp4suZtlPzf06LEb21ZXSkq75TFFaEbG3tmATdre9P3JmXqZHZ51WB8QX8RLr
	mqxbjjSpoCWX/IeUmgrL4U1z/z1QzBYFirKAxlSRABBDXa+p23WTNFSpyvZfmiZj
	C16mXwM3CU55DYT2Fmiru327u3ZdfYKUpqW3JdYA5vryM9bLcikdG5UIc74N+z4E
	N5ST/G0mV8Rt/VJUFW0wYJDO0SHBL24xmYqK6CIJVSPXYaKrAHvbr1ijHzoxfQYz
	MnyQ47yp+8Etxcr0USAeorKUhoKkLXzdwmg==
X-ME-Sender: <xms:4PF1agRui1oqaNBwpExIw3-WPOmOQ7XURg0gYnXVYt1-j0tfX5LJgQ>
    <xme:4PF1akwwFBlhPVdzy0puoCY2PHhpEvagrwYvdf9vxPiQ_cUxEjIAcqaA0NW8KNEs9
    hakkOZiT5zXMAtBCnqTnRcoqi9cAi3UOw-67hATl-B5VOeQq0A0RA>
X-ME-Received: <xmr:4PF1ai3m9qyi_-ai1E6sLhOJCIVIQPe6oFrMnLVbPYMxGcIk5BIuHl8H8I160QmaU8izq8n-hm9FNcj01bsnAnfiK9RroBhYYg>
X-ME-Proxy-Cause: dmFkZTG0sVDY3QAi3TZeNFGQsxTdMBAE8tOWDg4ieC+zelha9nar4ktglcKGB7uXdkS7dU
    vL7InYfSbhyVGhUdgB1hC5Uj/Cwoyj8rW54U6VqakKhSeJhEs8Z4GcBbiV3iA9ezzam+87
    uFUvPIuSxy1zpjn8xlFrHnj7oCPmaYn+kzy754qYsfivjorI2FI+NY45ddnbE4DY+f7tAT
    jUhk8IjoAg4wy2GUHGE7Zc7UfwAzg1/ZuPyZhxjTrT5+MHic4SKPyeJPMtmXqqx70mgQbM
    M18y/7eucvW6l0b3qjR/frrldQNTM6DOkOEBA8Rf1kkzfMadZqzO1HIRjLqwU4GyGnkJMl
    pXRt0RxhMnCuq2nueYG0lhdxfRQ0Ykji77VdHsHYQpPAt/psGswqy5Jd7UguNDtXZGaxZB
    eFjCfcMILouHW4YD15I02wANlxlD7LDnK3Y/72vT2Axl6iyBezjvg6VR7T5LxOYxkhOhUX
    5ZgeMqDTGn9vMNFi0NlYr5imLXo8eOXFqfBasoPHq+gklZvB2HEgNWO3OM05wm1Y3CZJiK
    mQk3wjF6aBWJYC9aLoI07m0LP18P4ma/Cs/F26ojt5REgS37bAUbvHgto+CzsJUgbQVRGW
    60A8r2jrz7cxAIysKHrvadUQUGSv5BHCDKHd5eVvU+eMQ7NFJiUYeWHhbrgA
X-ME-Proxy: <xmx:4PF1ai59iIhhHQdf4ZcgRFm2yacuPerP80SBA0ncjmZxufXwTKADFw>
    <xmx:4PF1alXWPbrQ9rNV0Was2L_gBgIMf5rM4qvMyJy6M9lI2TpYil0EWg>
    <xmx:4PF1ahDu1nWUYOdI98u4JNHjthOkbB5Tb1EYCgaSTY3Ied5dLRlOLQ>
    <xmx:4PF1ak7QECVVJYSs69DxQgdIlCrtJc8kxrWGiHvCDm6O5P3uI8JB2A>
    <xmx:4PF1aoMThOUNq2ubutQsrFRppibbCw1rnAQeXh35uOSN5sAktDKWNcBN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 10:55:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "Douglas Puchalski (dpuchals)" <dpuchals@cisco.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] Separate explicit fetch mapping from default
 fetch selection
In-Reply-To: <10103c22-af8f-4bf3-b4ab-a3e4ce0491d4@gmail.com> (Phillip Wood's
	message of "Fri, 7 Aug 2026 14:08:22 +0100")
References: <C47215A6-B86F-4AB2-B20D-54D048B9B2BA@cisco.com>
	<xmqqcxvuhcrg.fsf@gitster.g>
	<10103c22-af8f-4bf3-b4ab-a3e4ce0491d4@gmail.com>
Date: Fri, 07 Aug 2026 07:55:26 -0700
Message-ID: <xmqqtsp6f09t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> It was a long ago this was invented, and I haven't used it for
>> almost forever, but shouldn't this
>> 
>>      $ git fetch \
>>              --refmap="refs/heads/*:refs/remotes/origin/*" \
>>              origin topic/example
>> 
>> do what you want to do?  If so, perhaps it would make a good
>> starting point to make it easier to use (e.g., perhaps a
>> configuration variable can specify the refmap to be used, or
>> something).
>
> So we'd have something like "remote.<remote>.fetchMap" and 
> "remote.<remote>.pushMap" that mapped refnames, but did not affect what 
> gets fetched or push by default? That sounds useful (I've not thought 
> through the interaction with the existing settings though).

As I said, I do not know what the final system should look like,
but the idea behind 'refmap' was to separate (A) the rule
describing the correspondence between reference names on their end
and those on our end, and (B) the specification of which source
references are transferred to the destination repository.  Since the
transfer can work both ways, we would need two sets of maps, one for
each direction.

Once established, I suspect that 'git fetch' could learn something
like the 'matching' mode that 'git push' has in 'push.default'.
Using that mode, the OP's everyday 'git fetch' would then: (1)
interact with the default remote; (2) decide which of their
references to fetch by reverse-mapping the remote-tracking branches
we already have using the fetch 'refmap'; and (3) update the
remote-tracking references using those references we decided to
fetch in the previous step.  If the OP decides to extend the area of
interest by fetching a new branch from the remote,

    $ git fetch origin a-new-topic

naming only the remote and their branch, we would know which
remote-tracking branch to store the result in and add a new
refs/remotes/origin/a-new-topic remote-tracking branch.  This would
automatically extend what the next 'git fetch' grabs from them.

Or something like that, perhaps?

