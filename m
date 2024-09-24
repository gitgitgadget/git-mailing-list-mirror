Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6011B85F1
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205825; cv=none; b=o5Ma8zsMDjxXW5+3QOYiaQ3qVS5Q+7U0MGmf+1IM9h0fTYjfYNmqhJh1REEGNVeDUhYoha3W+4aYopFE6MwfddJOzClNWgoZ2L245AOlsSQFrt2fNLjUHPO7eXGgzM97m0eB/DvcBSb05WIfbrh4lyhqK3VC7NI2OtVoYTAlYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205825; c=relaxed/simple;
	bh=b3ae2FN9o0MhFRp5VOwxVlMtZewPaGL/ZpH8tSNwfLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3OryIq51WqSIX6KmIQP2DL0ZOG5c+qG30TT91C7bteFox+LPNMqvoJd1jIsgXqAyOFoXGtA1Fdhq/DksMUBCnUZ3Vw1kKVE+MkPoUzZIPYyZ2Dv+MIIdG1uKR5fRmeMVlm2mzM5Jx05ZBnVZvxjfoq8KeEG7OlItmwYztkpqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqTlhr8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqTlhr8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B620C4CEC4;
	Tue, 24 Sep 2024 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727205824;
	bh=b3ae2FN9o0MhFRp5VOwxVlMtZewPaGL/ZpH8tSNwfLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqTlhr8DX20U7/Z40O0UyGE5N1h2kxhlZuprkpEFWMtDRGPS6iNQ05AewaYHfJYgH
	 NqsjzdECFcQJEKYsnHvaNi7wH5pE2KPMjRQYLjAwd/Mvw1sqSFQzSAqG/p4UibJgkh
	 HvTT8HbUx6dOV/tWOzifvmOt/LN9hVTk5eQzB5Y8=
Date: Tue, 24 Sep 2024 15:23:41 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
Message-ID: <20240924-loud-honeybee-of-development-d2f893@meerkat>
References: <Zu78E+0Uk5fMSeQv@five231003>
 <xmqqsetr5wl1.fsf@gitster.g>
 <20240923-spirited-lime-lyrebird-fe90d5@lemur>
 <xmqqbk0exdk4.fsf@gitster.g>
 <20240924-sawfish-of-exotic-fantasy-b6abdb@meerkat>
 <xmqqmsjwsw1q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsjwsw1q.fsf@gitster.g>

On Tue, Sep 24, 2024 at 12:15:13PM GMT, Junio C Hamano wrote:
> > To enable it, I only need a list of people who are allowed to trigger bugspray
> > via the "bugspray track" trigger phrase. I assume it's going to be more than
> > just you?
> 
> Now we'll have to come up with and maintain an official list of
> trusted contributors.  Which at first may sound like such a list may
> alianate those who did not make the list, but when deciding which
> topics are ready to hit 'next', such a "selection" is implicitly
> made to choose whose opinion weigh more anyway.

Yeah, you're overthinking this. :) I literally just want to restrict the
ability to invoke bugspray to a limited number of people, at least for the
time being -- to avoid a situation like a troll sending "bugspray track" to
every possible thread. 

The people on this list don't have to have any kind of official standing with
the git project itself.

> I suspect that the list of folks who can operator bugspray do not
> necessarily have to be with deep technical knowledge of the innards
> of Git.  They have to be able to dedicate the time to read and
> understand what was said in the discussion threads, recognise when a
> problem is identified ("bugspray track"), have been long enough to
> know or able to use "git blame / git log" to see who likely has
> useful insight into the issue than others ("bugspray tag"?),

FYI, "bugspray tag" assigns the bug in bugzilla to a specific person. If you
don't intend to use bugzilla to this degree, you can ignore this aspect of it
entirely and never use the tag command.

> and have good enough taste to recognise irrelevant "bugs" that are
> opened by those with worse taste.  In a sense, it is very different
> from the earlier "list of those whose opinion weigh more in
> assessing topic's doneness".  Competent "project secretaries" are
> the kinds of people we want.
> 
> If I misunderstood the nature of "allow-list" for trigger phrase,
> please correct me.  Also it would be very welcome to hear from those
> listening in from the sidelines who want to see different kinds of
> people to be on the trigger phrase list.

Hopefully, I clarified it a bit. Also, bugspray is still an early model, so I
am happy to add functionality based on the feedback I receive.

-K
