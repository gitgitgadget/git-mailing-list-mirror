Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE52F171CD
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773472741; cv=none; b=HdU5+dlrQhx4tlTUMxdw9MN7xEAOG6TbANlGxABrScQL5tyamHeonhhdVtHto4d15/Lu4Rk9DXbFrs+fMGdIidebklof40eo1O5X9hUbcCLCkNANC3oOKgfd7EQ3z+u191UeIdGvnXHhsd+VYWi8Q2pGFPVnCEED1viKSQQMaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773472741; c=relaxed/simple;
	bh=/d5xovhQBfQHu9qkqMHQ6kJoetEUn/YpVBf4xFONHeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCsgjdM64AeE7KPdOuoAGFDMYLBM8G/2E/NDStpjpNuqmvZbUpqixLQiN3JM63ccNYykX+cNQSSDx4Ya1qupdExB3u70m1hdH2efCPk3sTz8DCzFBmOSZhGAN4cXqEtEVx6j6xA4xnvUJ/Qa5/lRT2iuEoVZMTpaNVGtOn1o9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNuoidZm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNuoidZm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4988e039so26316515ad.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773472739; x=1774077539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZnpeezXffrF6uOC4Ngu0X3WXV4ItkfkBJY/Zu1HM0g=;
        b=eNuoidZmYCyPMc/BAimnfZTf4jAU3P2dbQM+PJpr0Ac/ZWeJVLpCwmM8SZ3yYGy8qv
         eA3nbdU5c4SF6pCfTI76q8QhWUCXMBE2SZvXtR5ATMzVSM2q1chLJwvxed1kcKV9JcXX
         OIfEVHWXG2VrCHQcIpx7Ocf1ldAsXb9gqXceLn+6X/A4PQudRphTwPtqVCai9ivyWP1T
         Nt3XrhHuML++DJL45rdfH11yUl0yQoXjNsVzunHQc6r4H4AVA5c1sB7+QrsJ355ITAn8
         2tTXwaSl44cXt1pTY3x4Ld0Njkh6K2zZBXFX+T1APs+S9hjvmCnidvyYVtbcm0OsHFY3
         UXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773472739; x=1774077539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZnpeezXffrF6uOC4Ngu0X3WXV4ItkfkBJY/Zu1HM0g=;
        b=sexKFrdfBzZNfmBg/hQFKF3+0mWV+XwI8QWDj/hLvrv46/PA2mmUHsb7mKpqLd/e3T
         1Ip1zE5r0uMt68YS56pC3LLXDYqidY+1dSImypFFoWH0fVJwhXU87+pFzV1sX+LhV77f
         L25qlwmSSgX8S1TlPbhZOzc7NY6ljv/nzRkAnsttj9NUeP6ijTOhPnOmHj7E2hjbj6sX
         nL/4YWGNFf6BznlU6bfonHf7UB2ap0eo+7uHF/oq+oGRK1U+Y3hjKvZwFYu1iodYGfer
         NHvaJqZJl5A3SYMYKu+/E8uY1Pq+CWUBW7yPjFwGRsXLZyw83crYrjURVnTmKa719WsX
         QMXA==
X-Gm-Message-State: AOJu0YzW200AX3mr2r65yoLDNVvkODlJUTmN0R5O8gum2Q+5jO1LgeBW
	KQ79PemU9akc5pFNdtAfp3/f57b5ww2ZJ++B7o+XdzGXqgiAAAoDdbqk
X-Gm-Gg: ATEYQzzx+SB5nDeJM867Js8hajalGNey2dm14SxukUY2D0mPcTwh2HFE0kfkj90mUYD
	wGQl6yMeo20ZWFlfxi6FdSWwcHphmzqqyNbWXWDCaswC/f4iB5ZIO6hRNS4jp0OBjnaHqzvnjUn
	NX1HkccB2V7GTDl6Sm5zlTbyIMdrMDqeGzHkyv+SUNAmMFEnfZm8igd8M6qOLcsMg7zTAZqbd+4
	uKgGJIIU6reQHK6Lq3KTDjYiQXX2f6eyDSTECORyixaATDmncaGK7i5tSv/g7HtLAbKvRLhwgEb
	/dcgbLfGE4TzMsz5KYdK434e+cpBxJfIfU71Qx+e23Pjm0Pg1wmjdnt7+WlO2xy9y0+dqFmfDi8
	ytohrCYA7Acy9ZgIftaja1AUNih4+v2ZzaGoZwjjHNqnYjm76DY6QLJpSyunAtozCkrvWm6xaTb
	awSMl8DoRf/wuPVAl886q8ixPC1gjPGaUVcs4v8qzOc1ycaZyDCp6WY/2e8aJRp3EAUjFjl0EbV
	7879JmdOdApp7AVOB0vuADlNEeyLJsLFho=
X-Received: by 2002:a17:902:f552:b0:2ad:a96c:e40c with SMTP id d9443c01a7336-2aeca59ab39mr55500695ad.16.1773472739030;
        Sat, 14 Mar 2026 00:18:59 -0700 (PDT)
Received: from ?IPV6:2409:40e3:308b:f961:6950:2a48:4c4a:2156? ([2409:40e3:308b:f961:6950:2a48:4c4a:2156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62d0easm57829995ad.39.2026.03.14.00.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 00:18:58 -0700 (PDT)
Message-ID: <5370f3b2-2c4a-4d9d-904d-2a8f6094b6e1@gmail.com>
Date: Sat, 14 Mar 2026 12:48:55 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] git-replay: implement subcommands
To: Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
References: <20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com>
 <abGutGnWo1gN0Dii@denethor> <87v7ezsnqf.fsf@iotcl.com>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <87v7ezsnqf.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/26 21:52, Toon Claes wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
>> On 26/03/09 08:30PM, Toon Claes wrote:
>>> git-replay(1) has various operation modes. The mode depends on which of
>>> the options `--onto`, `--advance`, or `--revert` is given. These options
>>> are mutually exclusive. This usage pattern is counterintuitive and
>>> uncommon for Git commands to behave this way.
>>>
>>> Implement subcommands into git-replay(1):
>>>
>>> * `rebase`: This replaces what `--onto=` used to do.
>>
>> I'm a bit confused by this. It appears that the "rebase" subcommand
>> still requires the `--onto` option so it doesn't seem to really be
>> replacing anything. I assume we are tyring to break these operations
>> into distinct categories which seems reasonable.
> 
> Okay, maybe I should be more verbose about the problem I'm trying to
> solve.
> 
> Let's start with the existing option `--onto`. This implies a "rebase"
> operation. The argument to this option is a revision which acts as the
> base for the rebase. On this base the commits in the revision-range are
> replayed.
> 
> In the end, git-replay(1) takes the ref from the upper boundary of this
> revision-range, and updates that to the result of the rebase.
> 
> A usage example:
> 
>      $ git replay --onto=master master..my-branch
> 
> With option --ref-action=print, you'll get:
> 
>      update refs/heads/my-branch aaabbbccc 000111222
> 
> (using abbreviated OIDs for simplification in this email)
> 
> So 000111222 would be the commit my-branch is pointing to before the
> git-replay(1), and aaabbbccc the new commit.
> 
> Now looking at `--advance`, this works differently:
> 
>      $ git replay --advance=other-branch master..my-branch
> 
> With option --ref-action=print, you'll get:
> 
>      update refs/heads/other-branch 888999000 444555666
> 
> As you can see, the argument of --advance is the ref that gets updated.
> 
> So this command would be identical to:
> 
>      $ git replay --advance=other-branch master..000111222
> 
> If we try to do use the commit OID in the revision-range when using
> --onto:
> 
>      $ git replay --onto=master master..000111222
> 
> Nothing (noticable) happens. git-replay(1) does the replay, but doesn't
> know which ref to update.
> 
> This assymetry between --onto and --revert & --advance is the main issue
> I'm trying to resolve with this proposal.
> 
> 
>>> * `pick`: This replaces what `--advance=` used to do.
>>> * `revert`: This replaces what `--revert=` used to do.
>>>
>>> Option `--onto` is still accepted. It's mandatory for the `rebase`
>>> subcommand and needs to be used in the exact same way.
>>>
>>> Option `--ref` is added and required for the `pick` and `revert`
>>> subcommands. This replaces what `--advance` and `--revert` used to do,
>>> but as a single uniform option for all subcommands.
>>>
>>> The `rebase` subcommand also accepts option `--ref`, and when given this
>>> is the ref that's updated with the outcome of the git-replay(1) command.
>>> Thus following commands are identical:
>>>
>>>      $ git replay rebase --onto=master master..branch-1
>>>
>>>      $ git replay rebase --onto=master master..branch-1^{0} --ref=refs/heads/branch-1
>>>
>>> In the second example the upper boundary of the revision range is peeled
>>> down to a commit (using '^{0}'). Without option `--ref`, git-replay(1)
>>> doesn't know which ref to update, that's why `--ref` is passed
>>> explicitly.
>>>
>>> For the subcommands `pick` and `revert` it's also possible to combine
>>> `--ref` and `--onto`. Here are again two identical examples:
>>>
>>>      $ git replay pick --onto=branch-1 master..aabbccdd
>>>
>>>      $ git replay pick --onto=branch-1^{0} master..aabbccdd --ref=refs/heads/branch-1
>>>
>>> In the latter the argument for `--onto` is peeled down to a commit, so
>>> the command doesn't know which ref to update. To inform git-replay(1)
>>> which refs should be updated, it's passed explicitly as option `--ref`.
>>>
>>> Signed-off-by: Toon Claes <toon@iotcl.com>
>>> ---
>>> In the patch series by Siddharth Asthana[1] the option `--revert` is
>>> added to git-replay(1). This is implemented as option `--revert`, next
>>> to the existing options `--advance` and `--onto`.
>>>
>>> The usage of these options is mutually exclusive, so the user can only
>>> use one of them, and depending on which one, git-replay(1) selects a
>>> "mode of operating".
>>>
>>> Various people have raised this behavior is somewhat confusing. In this
>>> series we attempt to make the usage of git-replay(1) more intuitive and
>>> user-friendly by implementing the modes as subcommands.
>>
>> Ok, subcommands for git-replay(1) seem like they could be a good fit
>> here.
> 
> <3
> 
>>
>>> This patch is submitted as an RFC to gather feedback about the design.
>>> All changes are implemented as a single patch right now, and thus
>>> reviewing the changes might be challenging. When we got people aligned
>>> on the direction, I'll work toward cleaner patches.
>>>
>>> These changes are based on 'master' at 864f55e190 (The second batch,
>>> 2026-02-09) with the patches of Siddharth[1] applied: 'sa/replay-revert'
>>> at f79189a653 (replay: add --revert mode to reverse commit changes,
>>> 2026-02-19)
>>>
>>> [1]: 20260218234215.89326-3-siddharthasthana31@gmail.com
>>> ---
>>>   Documentation/git-replay.adoc | 124 ++++++++++++++++----------
>>>   builtin/replay.c              | 150 ++++++++++++++++++++++++-------
>>>   replay.c                      |  66 +++++++-------
>>>   replay.h                      |  31 +++----
>>>   t/t3650-replay-basics.sh      | 199 +++++++++++++++++++++++-------------------
>>>   5 files changed, 349 insertions(+), 221 deletions(-)
>>>
>>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>>> index ffdf790278..a7e8dac23f 100644
>>> --- a/Documentation/git-replay.adoc
>>> +++ b/Documentation/git-replay.adoc
>>> @@ -8,8 +8,13 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>>>   
>>>   SYNOPSIS
>>>   --------
>>> -[verse]
>>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
>>
>> Do we intent to remove the experimental marker?
> 
> Yeah, I did. I don't like them in this synopsis. It seems git-replay(1)
> is the only one doing this, so I'd like to get rid of it.
> 
> Doing this should end up in a separate commit.
> 
>>> +[synopsis]
>>> +git replay rebase --onto <newbase> [--ref <branch>] [--contained]
>>> +		[--ref-action[=<mode>]] <revision-range>
>>> +git replay pick --ref <branch> [--onto <newbase>]
>>> +		[--ref-action[=<mode>]] <revision-range>
>>> +git replay revert --ref <branch> [--onto <newbase>]
>>> +		[--ref-action[=<mode>]] <revision-range>
>>
>> Subcommands with required options like this feel quite bad IMO and I'm
>> not sure it makes it much more intuitive.
> 
> Okay, I did some looking up, and maybe you're right, I couldn't find any
> other command that has required options. It seems all commands have some
> kind of "default behavior" when no options are given.
> 
>> I guess subcommands do make it easier to convey which options pertain
>> to which operation. Maybe it would be better if required arguments
>> remained positional though?
> 
> I'm not sure that's better:
> 
>      [synopsis]
>      git replay rebase <newbase> [--ref <branch>] [--contained]
>      		[--ref-action[=<mode>]] <revision-range>
>      git replay pick <branch> [--onto <newbase>]
>      		[--ref-action[=<mode>]] <revision-range>
>      git replay revert <branch> [--onto <newbase>]
>      		[--ref-action[=<mode>]] <revision-range>
> 
> I don't think is better because the required argument for 'rebase' is
> used differently than 'pick' and 'revert', as explained above.
> 
> I guess my main gripe with the current options is the naming: `--onto`
> to rebase, `--advance` to cherry-pick, and `--revert` to revert. And
> while the last one does sound intuitive, the argument to that option is
> the branch you want to replay the reverted commits onto. So the argument
> isn't *what* you're reverting, it's *where* you're reverting to.
> 
> With my proposal I wanted to make that more clear.
> 
> This proposal is trying to be not too disruptive (for example, for
> rebase you only need to a add `rebase`), but that's maybe not a good
> idea. So an alternative could be: on top of this proposal, make both
> `--onto` and `--ref` required. In various cases the user will provide
> the exact same argument to both options, but since git-replay(1) is a
> plumbing command, we can consider this is acceptable?
> 
> And now, while writing this, I was thinking about yet another proposal.
> Because --advance and --revert are pretty similar. Why is --revert not
> an additional option you can add when using --advance. So instead of:
> 
>      git replay --revert=my-branch master..other-branch
>      git replay --advance=my-branch --revert master..other-branch
> 
> @Siddharth, have you considered that?


Yeah, I though about this early on but it didn't feel right. --advance 
means "cherry-pick onto this branch and move it forward", so combining 
it with --revert reads weird -- you would be "advancing" by reverting.

They also work quite differently under the hood. Revert uses 
newest-first ordering (revs.reverse = 0) while advance uses 
oldest-first, and revert sets author to the current user (author = NULL 
in create_commit) instead of preserving the original. So they really are 
different modes, kind of like how cherry-pick and revert are separate 
commands even though the merge machinery is shared.

On the subcommand RFC -- I think this is a good direction and it would 
clean up the asymmetry you pointed out between --onto and 
--advance/--revert. My v4 should be a clean base for it (which your RFC 
already builds on).

Thanks,
Siddharth


> 
>> Also, using these subcommands appears to be required now which is a
>> breaking change compared to before. The command is experimental, so this
>> may be fine, but should probably be more directly mentioned.
> 
> Sure, I can do that when I clean up the commits.
> 

