Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C94158A30
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725666987; cv=none; b=MU2hopSs9IfEd6+0gODeVQDSO6WvUsZ/mLCh05KFzy/J+52/W+V4+uOKgEvJfRR2irJe5qN6i9d/YlW6jox6IiCJEhslcA4MswYyeNyIq09GBg/tjI5aCVhx9U8Vr679JC4uZTFS61F9aTnF8VsIZhM5FtNKBPzXJpkLyOlA3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725666987; c=relaxed/simple;
	bh=A+uKrln0x3JYwo9fDzaM9ZBzUpw+7UlTcKpwOSes1po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiDDTXPLjwq1xShQcDTYQ2xd7boaTrBi4LMx4OQP4wXBjilJ0sFtdKCzkdnWJ3MWjClpXKTbvMj8VV/DHQx0LO17y8Fx87cihiE9OKm+qreA32StdgH3UQzc4aQaGaoXTgRE9q7MS2IMDxZAQJvuGj9mk7Cyidl5lpRLXOX7+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=D9UbuM49; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="D9UbuM49"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id milLs1e8zQyRxmilNsymDH; Sat, 07 Sep 2024 00:53:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1725666794; bh=axn/+jAGssOZGjrfO1EbelFVk9/QBU5JWTLFaoFQOeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D9UbuM49z7aTiSXqS7ZG7mLWK/3jo8+R+4/hm7pWpdTSykaWueEiKvbqudf5pBFuy
	 kuibF3DLiusLWANL37kNLjJS2sgXG1EgIvRAvDFJ9LuMFSGpvDF5UElMq/YVoLXB+r
	 KHdCj35WB/wCnAm8OECMmz8/fUAaTIduomRK37EwzMlT92I52Z6J4Vaf3yWYraqGMI
	 QM9pz223do7sJ7cGYd8JwN7TLYo17C/wPQmaGq2sPK3J0By6En2dwTM9ITRadCQvFb
	 hoH2cibDzLCkobODpfFuCCUbmqDtLqeh3yeoSQvVqP8IYxjwepcwCDSye0oxytbof8
	 0/YhYWonkviWw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XaAqz555 c=1 sm=1 tr=0 ts=66db95ea
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=WTQHVFz4FaAGvr70K28A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <c18fc95a-4dec-4e7b-8ec3-ba9747e9c464@ramsayjones.plus.com>
Date: Sat, 7 Sep 2024 00:53:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config
 section
To: Jeff King <peff@peff.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Adam Dinwoodie <git@dinwoodie.org>
References: <a59f53af-58f7-42f5-aefb-50a4d9f344c4@ramsayjones.plus.com>
 <20240905104331.GD2556395@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20240905104331.GD2556395@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEQz2ZZ1TK90nMIK+dsaweY7hyC7hm/0JRgbbByO6R9nXGCZV+c68zaYqi8XiPX7u0Qke65mk6CvhlYJ7wx8ZRfYDEK7+yja1rifZwlc00mmD9mPOwRH
 QLdDroW3H+58r6SRi3QrL8DpDDhxGfdStub2VgBStuMpx7Pb/jm7ZVhXnqLB3cUah8mbi3D0V8wAcIJWf+opZaHo1A3U+DFwY5o=



On 05/09/2024 11:43, Jeff King wrote:
> On Mon, Sep 02, 2024 at 11:15:35PM +0100, Ramsay Jones wrote:
> 
>> Still, I need to do a full test suite run, just to check for any regressions.
>> (Unfortunately, that takes about 6 hours to run, so I can't get to that soon).
> 
> I'm not sure if we cover this at all in the test suite, since it implies
> access to an actual terminal. All of the auth tests rely on the askpass
> interface to simulate the user typing a password.
> 
> We do have test_terminal, which simulates a pty, but I don't think it
> would work for this case. For one thing, I don't know that it counts as
> the controlling terminal, so opening /dev/tty wouldn't find it. And two,
> the stdin handling had race problems that caused us to remove it
> recently. So it's really only good for checking isatty() for
> stdout/stderr.

Heh, yes I suspect you are correct - it's just that I have been tripped
up too many times thinking "well, these changes can't possibly affect
the test-suite ..." :)

Anyway, I confirmed tonight that there are no regressions noticed by
the test-suite. (Which is not to say there aren't any ;) ).

> On the plus side, if it works for you in a single manual test then I
> suspect that's enough. The key thing is really "can we get something
> tty-ish that responds to termios", and it sounds like you can.
> 
> Certainly doesn't hurt to test the single-key mode of "add -p", etc,
> though.

Yeah, I still need to check the 'other uses' out. Hmm, I have never
used 'add -p' (never felt the need), so I guess I will have to read
up on how to use it ...

ATB,
Ramsay Jones


