Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5004740852
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662549; cv=none; b=apQRRozSH2PDGGWlIdj9KlcVSzpqyLwGyA4Aqu4v92+jVQHQlgTbFFdMNVxf3OQ3nWoBhNK46P/khXnpJCwpoZ1G6SDB1o/iY8FlKFJcCrGtlVb4nVlkPBQSqpqFpQ04UOQp/dr8iJ8KjRICsSDeQk6Hczu4dCYYmdjuWgSGXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662549; c=relaxed/simple;
	bh=uZO9z84Xj217JJ3lzumI2uaqpfg7ptrri1ei13ib0Nk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=g1D5KpxfZcP7Sqn0c2oqbmAhrgBiz4k+JVq+6vZmZ0Ags3ixvjDEs5b4Z5AJEG82S8fkCD3X95KY7m+NW987qeyBisDRFgV3sM3Ur2ks7UzNTk4h5lK9B3lTa6HGOXcHnxurOVY0/XMIW36ls9hIiSwWqgZqpB2hhd2M3VOLI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qICo45pC; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qICo45pC"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711662544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1h5Wqm1OtACFHsV9hqNeOTOa1qiIzHMD60lLsdE+fk=;
	b=qICo45pC7uMyRByJHotVL+F4L1GVJj4VbK4YHvemcMzVrOv+MWPADGAODU5Wi9EZ45R01n
	947hyC7ItZyIZZjWkNkBSn7CcDaa2/Uvxn3B0I85iG9dop4+LL8SzxtzFswhQsAnaZUMUb
	0WjlVwYgCYKNxX0PBtkgQDLEgqrQwBqwDMjC6VRY/wqIqc0hERe6wqyA1uYmtvYOLDVNmF
	y+ii3u56JjdQ/qsaSBQyogFRu25FHe1uQ7VaECvwhF3xnaBKo1pGDWjEeu/eSvUhGcEOdv
	oZJZSxPAcnjMeNmLSyjr+gMA8Hh02N6X66CcVoi4iUe/rk/bCBCQRAYnBO9sdw==
Date: Thu, 28 Mar 2024 22:49:04 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eugenio Bargiacchi <svalorzen@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Better visual separation of hunks in `git add -p`
In-Reply-To: <CAHfn=+uXhAW+7YG6R6BAeTOcWdrGQjUwGYCT6QJ3u9d9TwaySg@mail.gmail.com>
References: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
 <xmqqo7ayuwpi.fsf@gitster.g> <a9cffbe4aadd319760635ca6d5b4f465@manjaro.org>
 <xmqq1q7uusin.fsf@gitster.g> <1b81a013dd0faccdc24fe018fd740755@manjaro.org>
 <CAHfn=+tsrgAyUUqUkq4TpXcABr7=ZcH+cna+vwALJqZ3H8LxFA@mail.gmail.com>
 <26f8d21dfd53d699804485b0f8c6abe1@manjaro.org>
 <CAHfn=+s5_hvV1osP1HFjWs4wxRfr9YUW-9=WkXbgSp-8sPZ-Qg@mail.gmail.com>
 <de182310842ea3ff04c171a271587ca1@manjaro.org> <xmqqr0fut7di.fsf@gitster.g>
 <fc4ede3ecffd33811adca702493c8763@manjaro.org>
 <CAHfn=+uXhAW+7YG6R6BAeTOcWdrGQjUwGYCT6QJ3u9d9TwaySg@mail.gmail.com>
Message-ID: <a26d1f79fce1ecc5671e7539c390b2b9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-28 22:43, Eugenio Bargiacchi wrote:
> It seems to me that the two options are orthogonal: allowing the user
> to add an arbitrary prefix is not a block for allowing the user to
> clear the screen or vice-versa. If anything, the arbitrary prefix
> seems the more general flag to me as it at least offers a way (however
> unportable) to perform a clear. So saying that if we do not allow the
> user to clear the screen then it is not fine to add arbitrary prefixes
> seems strange.

Well, it all depends on one's perspective.  To me more precise, I don't
care about the prefixes because I've never wanted them, but I'd like to 
be
able to clear the screen.  Thus, from my viewpoint, which is presumably
shared with other users, forcing me to use the prefix to be able to 
clear
the screen, and to use it in a messy way, makes little sense.

I hope this makes my perspective mroe clear.


> On Thu, 28 Mar 2024 at 22:19, Dragan Simic <dsimic@manjaro.org> wrote:
>> 
>> On 2024-03-28 21:43, Junio C Hamano wrote:
>> > Dragan Simic <dsimic@manjaro.org> writes:
>> >
>> >> Of course, users could pick the right escape sequences for their
>> >> terminals, but as you already noted, the same configurations could
>> >> end up being used on different terminals.  For example, even SSHing
>> >> into a machine using a different SSH client could lead to a mess.
>> >
>> > There is a separate discussion of conditional configuration based on
>> > environment variable settings, e.g.
>> >
>> >     [includeIf "env:TERM:vt100"]
>> >       path = ~/.git-config-bits/vt100
>> >
>> > where the named file might have
>> >
>> >     [prompt] prefix = "\033[H\033[J"
>> >
>> > so it is certainly doable.
>> >
>> > It is a different story if doing so is sensible, of course.
>> 
>> Quite frankly, I think that would be like opening a can of worms.
>> In other words, if we end up implementing support for the "add -P"
>> prefix, allowing the users to do whatever they want with the prefixes
>> would surely be fine, but only if we implement "add -P" at the same
>> time, to already provide a reliable and simple way for clearing the
>> screen.
