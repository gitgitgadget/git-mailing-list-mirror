Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0034559B60
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799025; cv=none; b=vA0Y4wU53vwgc7RGin+0q90rBmzyqwk2vnUV8ofsZbwabQlNFTQy1L+HMaHc2+djlxG6NhDviFUwDt0a/mn4aNdqhfbu2XNpw1o+mwRcRUJ8CigJEXiezKFQah9esrfUWvBy8d9+ulbm7Wv767GsA5wSRYw1mqn7Jc2RLvUTe4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799025; c=relaxed/simple;
	bh=GG2hdwPPP4SvfN85LOzoU/ffgSNmk1K3lAL9GVIkhQk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rCfDj3mDuImLKJM7WxPraFQ3tfKfeLkW3w0OUnsQNJFoxlpbqqlFIcRMPvru7h9oVU3yohqAA7OQMk2CSVPxfrVd5USBnatVAoBBMQLshpwscWaeh9I0oNmZsCsOHn0R44F1hTFrb2+tcx0Ep7nRQiPixc28bXdiq/jjiiL8EXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=yywVzata; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="yywVzata"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710799021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HwyL7DuAUnuPESQ/Jc5ZhLs6qvQW6a0CfQlzrWaRus=;
	b=yywVzataVLhV4EHsCHKfiKX+0OrFlHlhlzd7pv+y59ew8nVp2LtN8/QAuCbKft+I9miA/G
	rVpFOkIS7kbLp5ABmAIkXysGgDHQyljUM2QaSXUv/5hkMu7XJxJ9Gs9xfqNADWN17YAXXP
	UPhBBnIZnuPdI2d9O1mPrtehfsGBIKqBMPf0wml2VeoMkuabK49Vt25PMT7U8+0SmhD5dq
	MmYpEkEaQbAtESd8jRuVXSuK5e2DkM55neEMHVbN9AnkeT5ke6KtexVUwj0iQNRn+TiQJX
	A9CO8YXF0gmTRPXwWujbY9qS37Cn0AA85xUUCLM+qtsSM8vT1OPA0iC67ojLqA==
Date: Mon, 18 Mar 2024 22:57:00 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 rsbecker@nexbridge.com, github@seichter.de
Subject: Re: [PATCH v2 4/5] t1300: add more tests for whitespace and inline
 comments
In-Reply-To: <CAPig+cQgejS5dFpOYkMT49kwn5zvn5ihvyFqViFwHhEmtr9mqw@mail.gmail.com>
References: <cover.1710646998.git.dsimic@manjaro.org>
 <9a73e7d3cbb9ea210ed1098c5a304b0f5d5e1a2e.1710646998.git.dsimic@manjaro.org>
 <CAPig+cTVmQzC38DympSEtPNhgY=-+dYbZmkr0RTRbhG-hp2fmQ@mail.gmail.com>
 <9996af464aabe2bf594c63c237d7a6e0@manjaro.org>
 <CAPig+cTLrsUpvKVjkFUgs1b1gvj54rm6FBa=5v3uoQtJnB4rZQ@mail.gmail.com>
 <xmqqttl4kvch.fsf@gitster.g> <62a4ec0dace46d7c56e75dac9c42c297@manjaro.org>
 <CAPig+cQgejS5dFpOYkMT49kwn5zvn5ihvyFqViFwHhEmtr9mqw@mail.gmail.com>
Message-ID: <f37d753485094a3ba66fde5e85d0e2dc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-18 20:21, Eric Sunshine wrote:
> On Mon, Mar 18, 2024 at 4:37 AM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-03-18 05:38, Junio C Hamano wrote:
>> >       sed -e 's/^|//' -e 's/Q/   /g' >.git/config <<-\EOF
>> >       |[section]
>> >       |       solid = rock
>> >       |       sparse = big QQ blue
>> >       |       ...
>> >       EOF
>> >
>> This looks quite neat.  Furthermore, I think we should also consider
>> the already existing tests in the t1300 that contain such indentation.
>> As I already explained in my earlier response to Eric, [1] the choice
>> of including the indentation or not seems random to me, so we should
>> perhaps consider taking some broader approach.
>> 
>> How about this as a plan for moving forward:
>> 
>> 1) Sprinkle a couple of tests onto the t1300, which try to be
>>     focused on the verification of the indentation-handling logic;
>>     maybe those additional tests could be even seen as redundant,
>>     but I think they can only help with the test coverage
>> 
>> 2) Create a new helper function that uses the logic you described
>>     above, to make it simpler to include the indentation into configs
>> 
>> 3) Finally, propagate the use of this new helper function into the
>>     new test and the already existing tests in the t1300 that already
>>     include the indentation
>> 
>> I'd be happy to implement all of the above-proposed steps in the next
>> couple of days.  Sure, it would be quite time-consuming, especially 
>> the
>> third proposed step, but it should be worth it in the long run.
> 
> As noted in my other response, while such cleanups may be nice in the
> long-run, the bug-fix patch series under discussion should not be held
> hostage by an ever-increasing set of potential cleanups. Let's focus
> on landing the current series; these tangential cleanups can be done
> in a separate series.

Totally agreed, let's keep this plan for the follow-up patches.
