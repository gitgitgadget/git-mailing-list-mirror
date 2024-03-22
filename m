Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641E80C02
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711145153; cv=none; b=foj3ILpXlk2LMcOE51WgauPx/82qNha5n8gJYsBkkVA4C4jcNHrv9xZs8eI1vYmmKSX60WVOKOBkUiChKx/+mPOYcUVdNmebXfXSBTDaTzaimnkz3Ez3qPsomlBairSnhDU4vUJjS5dZB8Mmg1BSYw6uxLNAERL7bsNnalv+Z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711145153; c=relaxed/simple;
	bh=giD1eKaOE1txsjpzS/6V2KSdYKeQga84ECnBZrvfmI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjQhgW+T2wQ1b15kk1ONgGJcNxMDfFaZnpoZqKKBne5anGqCcwMX9+K5qxsTOBReXb5t0KNJvDrjcelzqafQsWP2kFs79YSFef05vmil5DehK2xc9rGG8DJkx5MCPKbv7AOByPl/DfkvqZVPtw+yORlSemfcQCHIjGcKJK4MLl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=S4eMfB2K; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="S4eMfB2K"
Received: from [10.2.12.48] (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id D9D4119FD460;
	Fri, 22 Mar 2024 23:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711145149; bh=giD1eKaOE1txsjpzS/6V2KSdYKeQga84ECnBZrvfmI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S4eMfB2KQ9lh/nOkSJ5ILvXySlsNLNeEf4wJi5OFrxELpPv8EZYgxuQ2Asw3W7N+w
	 hbkNLMF/BiZtnUwSnSNQyG7w0xM5vRvd0VjTNCOrlPp32ELQ4wmf2yOSEjo/+u5agn
	 tyu72hwvwDKSGavJYynEgH6l0ZIVZcEvWXj2PSyQ=
Message-ID: <0c8f5b5b-ed25-483e-901c-cd0850640697@schinagl.nl>
Date: Fri, 22 Mar 2024 23:05:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
Content-Language: nl
To: Chris Torek <chris.torek@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
 <34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
 <CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
From: Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03-03-2024 08:23, Chris Torek wrote:
> Continuing the digression a bit:
> 
> On Sat, Mar 2, 2024 at 11:58 AM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>> This looks similar to the discussion from a [stash] topic:
>>
>> • Proposed introducing config variables which change how `git stash
>>    push` and `git stash save` behave (what they save)
>> • Concern about how that could break third-party scripts
> [snippage]
>> 🔗 [stash]: https://lore.kernel.org/git/xmqq34tnyhhf.fsf@gitster.g/
> 
> As I see it, the general issue here is the tension between Git
> commands that are used for scripting -- which ideally should
> always be plumbing commands -- and those used by end-users.
> 
> This tension is relieved somewhat when there *are* separate
> plumbing commands, such as `git diff-index` and `git diff-tree`
> and so on, or `git rev-list` vs `git log`. Unfortunately there
> are some commands, including `git log` itself, that have options
> that are missing from the roughly-equivalent plumbing command,
> and there are commands (such as `git stash` and `git status`)
> that either do not have, or at one time lacked, plumbing command
> equivalents or options.

I think you are spot on; and as I mentioned earlier, who is git for? 
Which commands are for whom. Human or machine. I suppose you can never 
avoid commands being abused, but should we favor machine abuse for very 
poor UX for the human? I would say 'absolutly not' but up until now, 
this has always been the case.

Maybe it comes from Linus's strict 'never break userspace'. But I think 
the situation is different. We want to enrich the user experience, we 
are constantly degrading it in favor of machines. Even though the 
manuals and interwebs are full of 'don't use these commands in scripts, 
they may break'. In that light, I would say 'lets break it in favor of UX :p

> 
> The `git status` command shows one way out of this problem:
> we can *add* `--porcelain` options.  Perhaps every command (or
> every non-plumbing-only one) should have `--porcelain[=<version>]`.

That's a fair argument, and makes it clear, however, there's tons of 
scripts that probably don't do this right now.

> 
> This doesn't fix the situation today, but provides an obvious
> future-proofing path.
> 
> Chris
