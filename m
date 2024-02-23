Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10885C7C
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722565; cv=none; b=YCP/Sb36SiVUp7WhxYVxC8qWvHjYh6KKB+EKVtRMAZr8SpSqyKlrjKJo2yBw4GhpQjP9RaaEFJ276P6TR14PzMExlEpww2Lpp0Uyhgowb5cEW9RZROuhl+ZKFOP0it0j0Pk7yHK9tXw8IYuRUxYfqExZiY1e5XJ9Ytkxlr2q4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722565; c=relaxed/simple;
	bh=zYTNVeXBmVVtGfYGBRZRv4tFlvnA0LzqDjlYpAHxXtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWEdR15BMQ/4mtMMR7vpJts6qafOzAKOJ/o1orBKJhD9eiaV16h6R37lm97Ftd04zNnP9AF97oX9hHCcL8blFZW+EgT3E5UOJ+I2w5Bj8ASoWVlz+uy725AKI3i4zrrRt7AsK80aOAM6qOh5DFNts5US4aBTH95IOcYzIaQ9QtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=OfU12MBb; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="OfU12MBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1708721969;
	bh=O8cS/Tox+KZCFlrR2rZXV2AG+QB1c7ZvgKE5+8MOPE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OfU12MBbjrNtZ6eS2snEvnvKBqdbQfjgoLJSP3w86qXyczRbwgxBIPITqtm1wo+1w
	 7D+fDOQko2R3k251ZqH6lDqq9fBnSxAFAmK9pxanId2ykUFuJZpQNCpY0yKG0aAtxa
	 kfoqjnqUdmrhgehQit07ARvbtBH0F5LwD8scy4GXVsCdQK4BpRTeeoKjjRpEGf97Fu
	 padG7afdmhj9skVOOs9kh2oeyxEz821kyOA2D5fBIIbTlnEmNHDITmjKnAJ9GV2ikb
	 i4Chb0ke8oX82DMAtnP2wVlJRRnwCF+sOkrfBuNeuuEnOc7QBswoK4TNLqe6PrsjlR
	 PqhZ+jV6kyP9g==
Received: from [192.168.42.22] (162-99-142-46.pool.kielnet.net [46.142.99.162])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 2C3223C0324;
	Fri, 23 Feb 2024 21:59:29 +0100 (CET)
Message-ID: <2739325d-93b1-445c-aac9-3e0ec54a27e4@haller-berlin.de>
Date: Fri, 23 Feb 2024 21:59:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interactive rebase: using "pick" for merge commits
Content-Language: de-DE, en-US
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
 <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
 <ZcnFl8kypKRYeLo3@tanuki> <040f142c-7ee2-429e-88eb-d328b01a4b8c@gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <040f142c-7ee2-429e-88eb-d328b01a4b8c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 12.02.24 15:38, Phillip Wood wrote:
> Hi Patrick and Stefan
> 
> On 12/02/2024 07:15, Patrick Steinhardt wrote:
>> On Sat, Feb 10, 2024 at 10:23:16AM +0100, Stefan Haller wrote:
>>> On 09.02.24 17:24, Phillip Wood wrote:
>>> Yes, I'm familiar with all this, but that's not what I mean. I don't
>>> want to maintain the topology here, and I'm also not suggesting that git
>>> itself generates such "pick" entries with -mX arguments (maybe I wasn't
>>> clear on that). What I want to do is to add such entries myself, as a
>>> user, resulting in the equivalent of doing a "break" at that point in
>>> the rebase and doing a "git cherry-pick -mX <hash-of-merge-commit>"
>>> manually.
>>
>> It would be neat indeed if this could be specified in the instruction
>> sheet. We already support options for the "merge" instruction, so
>> extending "pick" to support options isn't that far-fetched. Then it
>> would become possible to say "pick -m1 fa1afe1".
> 
> It would certainly be possible to extend the sequencer to do that but
> I'm not familiar with why people use "git cherry-pick -m" [1] so I'm
> wondering what this would be used for. It would involve a bit of extra
> complexity so I think we'd want a compelling reason as to why
> cherry-picking merges without maintaining the topology is useful
> especially as one can currently do that via "exec git cherry-pick -m ..."

Ok, I suppose the answer will probably not count as a compelling reason.
My reason for wanting this is that lazygit currently implements
cherry-picking in terms of an interactive rebase, rather then calling
git-cherry-pick. And the reason why it does this is that when you
cherry-pick multiple commits, and one of them conflicts, then you get
lazygit's nice visualization of the rebase todo list to show you where
in the sequence you are, what the conflicting commit is, how many are
left etc. It just happens to support this well for
.git/rebase-merge/git-rebase-todo, but not for .git/sequencer/todo.

It probably makes more sense to teach lazygit to visualize the
.git/sequencer/todo file, and then use git cherry-pick.

See https://github.com/jesseduffield/lazygit/issues/3317

-Stefan
