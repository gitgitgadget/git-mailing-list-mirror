Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4393EFD10
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964870; cv=none; b=rf6GPeNWJfxOKw6nA7qiekJfGEawzaL1KD3DCkNQL1WvaX1iT8x9mAmAuY1ZYUgTEfC8XcybPtQB5Ky1HWmXkiArC/f77x0J15GSWVkiiImghmX/FD04FinIhQe4uIC0EwT1M2ZPYYP6EbLABJCTSll3hIDGgko3+kA9tmSrU5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964870; c=relaxed/simple;
	bh=VtHH1w0ezZgQbx43FCk/4p1jt+xwCb30NR4pkrQBZQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF2AoBZ76GNpSz//VOaT+z+bdiBGleN04Ym94Lc49n5D++esjG7Ad1mrD5uCpWrv9iUrzRbkH10OHIUkwNebc+aTlvzDYxCyeIYilMQHS0H4zdskFq2KDERDE4VLR2sAexseLO+Gew65Ovv4qaOQFqWf+5Km3GwneXnQrhsils0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz3YbzV/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz3YbzV/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C21F000E9;
	Wed,  5 Aug 2026 21:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964861;
	bh=I7rzBgbDRzT+82aA/Y1238tGbkXzhiavSUvshvIcesI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Rz3YbzV/bmf4MLEYh3YMKMjCQW3Xkug3hkUqH/7eZOlgZ6MjvBQ6Ep7JEKhex/PgA
	 GgIf/SR1cKOA8EKfFddQ3FDIPIyH3Owep5fzTMYRojRYn9cgxUp28jR41eq+VS3J+g
	 eGzy4tzt/OeVqdKiiwXXUUq/UUeAiID9/ubL7stjpBtKGa9yiT+B4HFSHVkEI4ayXX
	 zuCh75SntECsQ2BtgHEdH5zLI2wKAK4bLb3Liq/kejwRB1MQe3Folez9RQ3NhLCtt0
	 a+suXa4j3z66SOqf+PusoC5DLm1IWUQ6/m69BfjFSMsI3tjAuqLgyllizgnC/123np
	 Ea4gtzfn/FpQw==
Message-ID: <6a8e934e-5ccc-40cc-877b-d1f1752888de@kernel.org>
Date: Wed, 5 Aug 2026 23:20:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] completion: add 'git history' subcommands
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
 <anLV__4THdvugj8f@pks.im> <xmqq7bm4sfvh.fsf@gitster.g>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <xmqq7bm4sfvh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/08/2026 at 18:15, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> On Tue, Aug 04, 2026 at 09:56:32PM +0200, Vincent Mailhol wrote:
>>> Use the parse-options completion helpers for the "git history"
>>> subcommands and their options. Complete positional arguments as
>>> revisions, and add coverage for each kind of completion.
>>
>> Ah, great! I wanted to write shell completion for git-history(1) for a
>> while but never really found the time to actually do it.
>>
>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>> index e875787710..f10813c8d7 100644
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -2137,6 +2137,30 @@ _git_help ()
>>>  	fi
>>>  }
>>>  
>>> +_git_history ()
>>> +{
>>> +	local subcommands subcommand
>>> +
>>> +	__git_resolve_builtins "history"
>>> +
>>> +	subcommands="$___git_resolved_builtins"
>>> +	subcommand="$(__git_find_subcommand "$subcommands")"
>>> +
>>> +	if [ -z "$subcommand" ]; then
>>> +		__gitcomp "$subcommands"
>>> +		return
>>> +	fi
>>
>> Okay. We first try to figure out whether there is any subcommand passed
>> by the user already. If not, we complete available subcommands.
> 
> This may be a tangent, but anyway.  I was looking at this patch (not
> that I think I am capable of giving a completion patch a serious
> review), comparing with other completions, and the similarity of the
> boilerplate part above was so striking.  I suspect that these were
> organically grown, but at some point when the tree is quiescent, can
> we coalesce the completion routines for subcommands that share the
> same pattern for better maintainability?

I am not sure if this would increase the maintainability.

For example, I started looking at Patrick's suggestion ※ to cover the

  git history split

special case. If we add this, we would need to dispatch this in
_git_history() by adding something like:

	if [ "$subcommand" = "split" ]; then
		__git_complete_history_split
		return
	fi

but if we coalesce the completion routine for the subcommands, where
should this dispatcher go?

I see this boilerplate as a skeleton waiting for extensions. Of course,
maybe I am missing some points and maybe we can coalesce the code while
still allowing for extensions. But currently, I am not able to depict
how this should look like.


※ The fact that I started to look at the 'git history split' completion
doesn't mean that I am committing myself to implement it. I will do a
best effort try in my available time. If I get a decent result, I will
share, if not, I would ask you to bear with the current patch!


Yours sincerely,
Vincent Mailhol

