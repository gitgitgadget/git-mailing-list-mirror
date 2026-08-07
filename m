Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0F3C1D7B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090175; cv=none; b=PR6ioFPQpTbb2aUG8g63m00lsOTCTPYnLehLyJvjhdKEERESMDD74OwcXuVooFgIphMF7e8Pr66PF0zt3K21KefbApbbyq5D1Z+B1TOIs1O4i7/xvHf0Jjj28wTDOQhE++6kr0zIqFm8vzmo3K3zrV6OjPr5ZEdwfhWr5VwN7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090175; c=relaxed/simple;
	bh=g656+hALuo601c/DegupuXrTP+FHwlntjRZW1Xbs3Rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0xwncvVwvezV+bh6VvJmQgyNzHizIbhragZiLLPBrqRFUqTtjgn3iaXH9Oo0Muqn+rRlzybSYfeDBCsGm0ugtaDmQ6m36hvfpXx+R9wGHiNvvt2jNAbtfU09eTOsw5R7rma8Udcjcb+I2tXZTXl1tmEkaIG19vU7afZB7ZjNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ10e7V7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ10e7V7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C361F00A3D;
	Fri,  7 Aug 2026 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786090169;
	bh=hhu4may6/287P2jxsL9EEm3ZrHrEui+dLmNrZQfiIpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oJ10e7V7VMNBIvL5de9hkDJzGmEAdodvgqrZxY9T5/rEhwcQNQMG6JnSeFC276v0D
	 GcGYzz6q1amzOvadqk8FYdBPmY2/CLs3+I4r6vz5orcQvR/aAhBpnCjlXDxSB+opIx
	 ceWzI2WiBNWMSsCDV6uV1GmpHxbjDdOb9SE+5OPhHlMM1pPI/NEhtzqtYx4ouqwSGC
	 Gr4TngtbGUMxSIFtEvJRYqA4UX6fq+C0/GJEqj/Kh7AV6sOpASpzWLYlc7VydWEt1C
	 BFofbx5hc3AQqsErT52vQtyQaxb14unYwz31Eqll+UaqNedT/+X1PPo5jV6GKvKx0O
	 jSmSANFyGjcDg==
Message-ID: <0ea2cce4-2174-4866-9619-d7f74ae5c91f@kernel.org>
Date: Fri, 7 Aug 2026 10:09:26 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] completion: add 'git history' subcommands
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
 <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>
 <anV7cHblfmGvbl-e@pks.im> <e894cf4e-7df2-489a-a596-96f1d4d95dc0@kernel.org>
 <anWEcfhdzvNQfskU@pks.im>
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
In-Reply-To: <anWEcfhdzvNQfskU@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2026 at 09:08, Patrick Steinhardt wrote:
> On Fri, Aug 07, 2026 at 08:44:41AM +0200, Vincent Mailhol wrote:
>> On 07/08/2026 at 08:30, Patrick Steinhardt wrote:
>>> On Thu, Aug 06, 2026 at 10:27:36PM +0200, Vincent Mailhol wrote:
>>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>>> index e875787710..7372e2919b 100644
>>>> --- a/contrib/completion/git-completion.bash
>>>> +++ b/contrib/completion/git-completion.bash
>>>> @@ -2137,6 +2137,54 @@ _git_help ()
>>>>  	fi
>>>>  }
>>>>  
>>>> +__git_history_has_revision ()
>>>> +{
>>>> +	local i
>>>> +
>>>> +	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
>>>> +		case "${words[i]}" in
>>>> +		--empty|--update-refs)
>>>> +			((i++))
>>>> +			;;
>>>
>>> This will unfortunately be quite a pain to maintain going forward, as we
>>> now have to be aware of updating this site every single time we add a
>>> new option that accepts a parameter.
>>
>> Do you foreseen such new parameters?
> 
> Yes, I'm very sure we'll gain more parameters for those commands. Commit
> signing, sign-offs, handling of notes are all things that are currently
> being discussed, and they likely will require new options.

Got it! I kind of mixed subcommands and parameters in my head. My
previous answer was totally off topic, sorry.

For the new parameters, indeed. The issue is that these options accept
two syntax:

  --empty=<value>

or

  --empty <value>

The first one falls under the '-*)' switch case anyway, so if you do a

  git history fix --new-option=foo <TAB>

the __git_history_has_revision will handle it properly. If you do:

  git history fix --new-option=<TAB>

you just get no completion until the code is modified to teach what are
the correct value for --new-option. This is acceptable in term of
maintainability.

If you do:

  git history fix --new-option <TAB>

then __git_history_has_revision will assume that --new-option is a
toggle parameter which takes no value and will incorrectly complete it
with a reference.

Finally, if you do a:

  git history fix --new-option value <TAB>

then the value is interpreted as a reference and the <TAB> gives no
completion.

For a

  git history fix --gpg-sign

this is mostly OK. Assuming the new --gpg-sign works identically as the
git rebase option, the --gpg-sign value is optional and default the the
committer identity. So in most of the cases, the user will not give a
value and will correctly get the reference completion when doing:

  git history fix --gpg-sign <TAB>

So the only case where we are screwed is if the option takes an argument
*and* the user specify it as --new-option (without the final '='). In
that case, the damage is still not huge. I expect most of the users to
pass option with the final '='.

>>> I don't really have a good idea for how to fix that reliably though, I
>>> have to admit. Maybe we should just mostly ignore this edge case and
>>> always complete references, unless we have seen a `--`? That can be
>>> checked rather easily via `__git_hash_doubledash`.
>>
>> My toughs are that if such a special case ever surface, we can just
>> dispatch it earlier before we check for the
>> __git_history_has_revision, like this:
>>
>> ---8<---
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index d313780d8b..786fcb5e16 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2193,6 +2193,15 @@ _git_history ()
>>  		esac
>>  	fi
>>  
>> +	# Subcommands which takes something else than a revision
>> +	case "$subcommand" in
>> +	foo)
>> +		# 'git history foo' take a file first
>> +		__git_complete_index_file "--cached"
>> +		return
>> +		;;
>> +	esac
>> +
>>  	if ! __git_history_has_revision; then
>>  		__git_complete_refs
>>  		return
>> ---8<---
>>
>> This seems reasonable to me. Once we know what this mysterious new
>> command would be, maybe we can find a smarter and more tailored
>> solution, but at the moment, I would not call this a blocker.
> 
> I'm not really concerned about new subcommands for now, true. But
> hardcoding the parameters as we do above feels error prone to me and
> will very likely diverge as the command evolves.

I think that there are two options:

  1. What I did, which work great today and will start to diverge the
     day we add more arguments which takes a value as you highlighted.

  2. Ignore the '--argument <value>' syntax and only complete the
     '--argument=<value>'.

Point 2. will consistently give incorrect results when doing:

  git history fix --new-option value <TAB>

but is easier to maintain. And the '--argument <value>' syntax isn't
covered in the manpages anyway, so this option is just a "we implement
the manpages and that's it!" approach.

My preference goes slightly to 1., but I am OK to send a v3 with
option 2.


Yours sincerely,
Vincent Mailhol

