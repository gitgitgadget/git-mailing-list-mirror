Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895824;
	b=fk4Trqs87ND6BfNfzgIUO79dktLLsXH1jCBAZVGcUda86tDsIViLKDpsGzp7R6K0OyNo
	 1bVamCHNBLE+txKk0IJHVqQhI7VR/T8m5Si1GwjboWoxKeMYGCKPn2ppCc4GX9OGoGieF
	 DFKfmj2E3gbuOQKGfIeAJ/zQH4PbjzUGcnTdmPep41NgZipLddUCXrJKAWqZAcA2Yxy5Q
	 JAZbsXVeSc3zGDcelvtBLE5TocmyKxzzLnn/ybMNZV9MnpBvDz5XfaNY41rHPPWar5pER
	 frrUFdhg8VtrdtvzhkQMD3EydJN7mmSjeXOxAxllqr9YM1hMkNV8JOO92clVIcg3hyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=pkrC/LtrDiz7BNUjC0M+4MtZOVcW8nGXIrA/Asj+TiA=;
	b=sTdgZk0yEIYOWN/L0tmf4qcL1tyygoZngtDaugoUy/GeLPFnTqRNdTMpAlivBji+CoPH
	 z2upl9MGtpHWu8hcOmB6aiumG3C1ReQen4j+WM/2vyRLEWJfgOg5ZVOLdP95kI+wUAR1V
	 j9Zzo2xlZ84IVp/o4dwl3SS5AxGwIdXXneP846XMzNQ7r4XfRlc3c6ZjWiQNLeJofFc2g
	 sUaqpOSbLb13iVThIwXOEYbUVgG8XdsKCy5i47TKQ7H6FiyCPQK6EuqElge8RQx1xQg2h
	 e/scy2D+zXKylt1d8wCGo9SQnjZzEHqp5y9C6/UhMg/wfYQXmoIKP9LshefzAaZYZcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTk2IZdG;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA0606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 16:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AAA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aTk2IZdG
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1688048b3a.0
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793895824; x=1794500624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkrC/LtrDiz7BNUjC0M+4MtZOVcW8nGXIrA/Asj+TiA=;
        b=aTk2IZdGi3BXwLjwKOZXbbiP/IjPzFGNfKW7uK+mVPe+8j9llkpwNk8x9Qv6XAs1pt
         Kj9KZIEdq7DdO0y9I8y1vQQLdKg9ti3jEpPVESwmKcOWyFwf+Snl2VBqJ4hSlfZbwTUD
         BppCDLQd9ksAuWrZvbDW9s7w5hwh2X0LwQhH8IOBZM2vuAIorp2w9dazgTnZYDEQbxne
         UxiiBRdxyMb/G61Pz1XSgkdOaIZaASUSU4uJqc1Fefu9NcU6j+tVVNbV4p6tSKYlu+Rj
         7s6DjPv6zdlMdodumj3GRePM6agCyIGUSIEVzXtzDRFlMG9vyn7XyBpEkEC/xMop1A+U
         2X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895824; x=1794500624;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkrC/LtrDiz7BNUjC0M+4MtZOVcW8nGXIrA/Asj+TiA=;
        b=CZs7+91ps3u+KHSXDJc/dz0+Livzwi+SAUHOxCY+fQqVfZHYBNTzB9i59EPU21+jo9
         F1V+9pRBE/dshHJUSxK46ybOZ0zhd5olU4ptavxUp4mfvElK7kVisLdbRu9c9S835UGi
         mECyM7sLHX+vvfkMJo/Znuz0HdIPoupc7DxUADA6/5bzcszWHO3vpLDqj6ADnUDk06EF
         c94LNXNUq4Lma3LKXeMfi98aQZ55uLERctGuDFyDYic625eKYtwFzpdTqCkmQkBQYkpy
         KsY9Z9842iJjkMZ32kl9DFgydnFDfb0Z8DIgoR/gIXUGvENnx1GusEtjs45yjb/6jPhw
         g65g==
X-Forwarded-Encrypted: i=1; AKwUvBy29ro6CPcgXW1ZpyTOgzQYcCtTb0IhTYpgj2phub9+Ck2DiPXyncI9yu1cCbpkq/F0f1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Byy0HEi8G2/krx6qsuXkzsDK0rcffqtf4gW7gcbk0/80R7hPf
	STZRmN36Qe1Ib0vyTcR7xh5VKxZt4+wk0QxVps1ITd/LktL3btCaCAtD
X-Gm-Gg: AYBFou0N1Cssn3EoAKSRQu3TSFf0No8kI30Fzldn5U1juZ3HIWU3iK3vbMmI5E7SH1W
	Me3NoIqoQarG4/aIkIHFfUMk4srod0XyHiaHtAkqyMW8UCRPMcZ3jdI1G79k45ig1DpBFHb6Pt2
	1L5NxHwtpZLn0r3GvmyckXLkyJaVPnyDNIUIKidWdkrQzweH9apjKzNbMoOJ06+qKyNIfdRV5G9
	KocGxuEP2hWSHElVMOKPl811fENhvuwrZH2uZ+s1Hjnfe20t6lH3DkZplASMm4RiqthfdmbP01n
	1YccIsCIeYX4hd0XnxHkbrMXIkxSDzUAH3PGUu+z4XPfpgTML9gCoJUw/gk6ZcIdcRP54e22Por
	ChDo7If7DsCED+ZhvLOVbE77sUFQEP/Xx7IbCpXNjPrupPJcR9rUp7Ndr6njd/H5P4soiGdrXvQ
	gf0tPURuDmGeOs0+vLYwspWQSKsTk3aTU6lwSuoYF5Tf6HpUduVfFssAaNiAY0X6quF3cmlNGeQ
	fgF/bdTjk9qGaj7gl1PuyLOtY52eCobzyBXS7QRzmc+jKKKiuoARYr6GSrIQxUwM+GQ6pKdhnP8
	W1xZOzmaoeuftdz8iugZmMvFGbUCZ0On+vz2GnMIUy0=
X-Received: by 2002:a05:6a00:4c1c:b0:899:9267:3abc with SMTP id d2e1a72fcca58-8a9bf046e8fmr16443899b3a.41.1793895823615;
        Thu, 05 Nov 2026 08:23:43 -0800 (PST)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b6634cesm2238143b3a.39.2026.11.05.08.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 08:23:42 -0800 (PST)
Message-ID: <b818b1ed-5034-4588-8d48-64b7f9efa764@gmail.com>
Date: Thu, 5 Nov 2026 21:53:39 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Outreachy] Project Proposal [v2] : Implement promisor remote
 fetch ordering
To: Shashank S <shashu8660@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <CANHmUQTDpwW7N7axexos32PxvPBPB10NFSpM1bUiKAbk3SMSyw@mail.gmail.com>
 <CANHmUQSBs=Mq1Y1GTY6P9FtyCQz58bDWFgJPgwv4r5rLP3C1Bg@mail.gmail.com>
 <CANHmUQSZqXtqXsiDQs+1unGcyEuaPhaF8__E_Cy4fWNqxapY5A@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CANHmUQSZqXtqXsiDQs+1unGcyEuaPhaF8__E_Cy4fWNqxapY5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Shashank,

Thank you for your interest in this project and for submitting a proposal!

On 11/4/26 17:57, Shashank S wrote:
> During this Outreachy contribution phase, I initially focused on Git's
> core libification and option-parsing APIs. However, my true interest
> lies in network optimization. Diving into Git's GIT_TRACE2 engine to
> map out how partial clones communicate with promisor remotes convinced
> me that the "Implement promisor remote fetch ordering" project is
> exactly where I want to focus my 13-week internship.
> 

That is interesting to know. Thanks!

> Past Experience with Git
> ========================
> I have been using Git extensively for version control in my personal
> projects. This contribution period was my first time engaging directly
> with a mailing list-based open-source community.
> 
> Learning to use git send-email and GitGitGadget to format patches,
> manage versioned rerolls, and incorporate maintainer feedback has been
> a massive learning curve, but a highly rewarding one. I learned the
> importance of atomic commits, clean commit messages, and the strict
> rules around not ignoring Git's exit codes in shell scripts.
> 

That's great!

> Contributions to the Git Community
> ==================================
> 
> 1. t0081: modernize the code testing whether a file exists
>     Link: https://lore.kernel.org/git/pull.2254.git.1791962806807.gitgitgadget@gmail.com/
>     Status: Merged to master.
>     Commit: https://github.com/git/git/commit/e1bb515788e48d500c9d4e36f13c66c4daddd3d4
> 
> 2. t2403: modernize test for directory existence
>     Link: https://lore.kernel.org/git/pull.2259.git.1792125111461.gitgitgadget@gmail.com/
>     Status: Merged to seen.

Queued in seen?

>     Commit: https://github.com/git/git/commit/c645a5db002ded161115dc8f6c15a40acfdde2b2
> 
> 3.  prune-packed: remove USE_THE_REPOSITORY_VARIABLE
>     Status: Reviewed and marked ready for integration by Patrick Steinhardt.

I think the appropriate status per What's cooking is "Will merge to master".

I'm not sure why you removed the link to the mailing list patch. You 
could keep it.

>     Description: I refactored the C file to pass a struct repository *r
> pointer through a void *cb_data callback API, successfully removing
> the reliance on Git's global state variables.
> 
> 4.  test-chmtime: use parse_options() to parse command-line flags
>     Status: v2 submitted.
>     Description: I ported ad-hoc command-line argument scanning to
> Git's official C-level parse_options() API, handling edge cases for
> relative time offsets, and added t0082-test-chmtime.sh.
> 

Ditto.

> Internship Plan and 13-Week Timeline
> ====================================
> The internship runs from 7 December 2026 to 8 March 2027.
> 
> Weeks 1–2 (Dec 7 – Dec 20): Phase 1 - Visibility and Baseline

I'm a little unsure if this needs 2 weeks...

> - Goal: Document and lock in Git's current behavior to act as a safety net.
> - Tasks: Submit a docs-only upstream patch defining the current
> fallback rules (accepted before configured, extensions.partialClone
> last, fallback on failure). Develop automated tests utilizing
> GIT_TRACE2 to definitively lock in and prove the current sequential
> fetch order.
> 
> Weeks 3–5 (Dec 21 – Jan 10): Phase 2 - Client-Side Ordering
> - Goal: Implement local configuration for promisor remote priorities.
> - Tasks: Introduce the promisor.fetchOrder configuration list. A list
> is preferred over per-remote integers as it composes cleanly across
> config files.

I think choosing between list vs. per-remote is not in scope of this 
application. It is better done in a separate RFC in the mailing either 
as a small patch or as a discussion that covers pros and cons of either.

Also, I think you do intend to send this change to the list during this 
week but it may be worth mentioning that explicitly for clarity.
> Refactor internal sorting logic in promisor-remote.c to
> reorder remotes based on this list before initiating lazy fetches.
> Implement edge-case handling for unlisted remotes and preserve the
> extensions.partialClone-last fallback rule.
> 
> Weeks 6–9 (Jan 11 – Feb 7): Phase 3 - Server-Advertised Order
> - Goal: Extend Protocol v2 to allow servers to broadcast their
> preferred priority.
> - Tasks: Draft an RFC proposing the protocol v2 explicit priority=<n>
> fields. Implement server-side advertisement gated by a new
> promisor.sendFields configuration.

It is a bit interesting that just drafting the RFC is covered in this 
phase and not discussing this on the list (like how it is mentioned 
below). May be you intend to but haven't communicated it clearly?

Also, isn't `promisor.sendFields` already exist? Do you mean to say a 
new field that the server sends when the promisor-remote is advertised?

> Implement the client-side parser,
> strictly adhering to the "ignore unknown fields" rule to maintain
> backward compatibility.
> 
> Weeks 10–12 (Feb 8 – Feb 28): Phase 4 - Upstreaming & Precedence
> - Goal: Secure mailing list approval and resolve precedence rules.
> - Tasks: Settle precedence conflicts (Recommendation: local client
> config maintains absolute authority, while the server's advertised
> order sorts unranked remotes). Split Phase 2 and Phase 3 into a clean,
> reviewable patch series. Route through at least two rounds of mailing
> list review.
> 
> Week 13 (Mar 1 – Mar 8): Polish & Stretch Goals
> - Goal: Finalize documentation and explore dynamic caching.
> - Tasks: Write final release notes and user-facing documentation.
> Stretch Goal: Implement runtime memory of failed remotes within a
> single process to skip them on subsequent lazy fetches to reduce
> latency. Submit final Outreachy report.
> 

To be honest, this plans seems mostly reiterating the "tasks" section of 
the project. I would love to see you dive a bit more deeply into the 
nuances with your own judgement. While discussion is necessary to 
achieve consensus, knowing your thought process helps us understand how 
much you've understood about the project.

Also, it may be worth mentioning what kinds of potential difficulties 
you expect while implementing the plan? What open questions do you 
expect to settle in the RFC discussions? etc

> Availability
> ============
> I can commit 40 hours a week to the project during the internship. I
> am based in India (IST, UTC+5:30) and can adjust my hours for
> synchronous calls, pair programming, and mailing list reviews to
> overlap with my mentors' timezones.
>

That's good. If you have any other commitments like exams / planned 
vacation etc., kindly share them upfront.

> Blogging
> ========
> I will document my technical journey , posting weekly updates on the
> C-level challenges I face, how I navigate network tracing, and the
> feedback I receive from the Git community. I will share each post on
> the mailing list.
>

Cool!


> After the Internship
> ====================
> After the internship, I intend to remain an active contributor to the
> Git core project. Having touched the libification, option parsing, and
> network protocol subsystems during my application, I want to continue
> bridging these areas—specifically helping remove the remaining
> USE_THE_REPOSITORY_VARIABLE macros from network-facing C files like
> promisor-remote.c.
> 

Great!

-- 
Sivaraam

