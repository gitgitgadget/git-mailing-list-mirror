Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800023B623
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447642; cv=none; b=dDkk4+UNvxuwDnl8BRDeCgsBMFKHR7uizyuyx04/iSB96+gBW/FN0BOkDZH2SVz7gUzGbYiviOKvbU+l3IwwpaDjVm26cMCYS+emA/n7Zq0aTscdoppVT3VpihMu5urQO2l94kQeiLajvj1/f25gmJorBW2YMXA1gUwLyF1J3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447642; c=relaxed/simple;
	bh=J/raosrUvKqhm1uIm7zXOoJsPMMoZQvnCVsSMlL4r/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTgoUXxydk1HPOwixkcswT2fUMelRcj5xA+kvQPv5JAS5UAHI0w+DrgPuWFE6GR8/ZqWtUg/nrzWQ4HKJf0d5HoelQjiSy08VqT2quiACZbFQ85kYhglL8UWtN2c+G+0WkVGYl2aUpeo38sppg5fp2BNyv2BVrm22LMEXXmlH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMgbHUaW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMgbHUaW"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso2992654a91.0
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759447639; x=1760052439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3RUNxrw7fMpxFOkiLUtdHTo2w0j6JiBn2v1bripF0o=;
        b=bMgbHUaWWpUhRASgiBfrpf/yY+I3WWQu4GXKt8xf1pq7/1kA9ZKsU1jwyFDp8XNJpt
         wOv5AhMw4HBJaCNQQPitKvwkBPEI4lM6Cu5ed0qB7VSQxWvWZ6c5S5e+nAHyPVQzXxmb
         SQ8uDMFPhlstNeDFHaIEuaKCUoFVtsPyqeBRAj8pIGNtdcqfOH6hB6JUJMrfQGogn3IM
         I672sFp502PWc18729+Dm50Ou1VY9+0dYcXfrXu5M5U7JXnfZ76iIvVNVErmL2w4dZ8J
         KYn/GFGSFbvm/vAF3YWxoYamu2VB0bJeXy5Il4fks5owyYma2piKmSlNR2hojyG1bqNc
         pyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447639; x=1760052439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3RUNxrw7fMpxFOkiLUtdHTo2w0j6JiBn2v1bripF0o=;
        b=IuY/m6/c+TjQ923gYVnKCioHO5WmH/O/c8g6vEEx5lJav5p2K1uEYHMWHLV/f1Orts
         Ltmq523PL+vjeE85/TjHWuJwVaXrmfzEal+DMvZo9UZ73P0hapRHMLnEKe8vMPryvru0
         6I5bhgP0uXPs55FFTgV2mIBWCg4ZKauVdDBrU1JeqFIH7P1Lq1zySwdnoCRllJLAx/dS
         TufsmpsGs0tYu63GO9K3yDgTac6ZbiaMxFSjbVd3aFhMLWWmmjaB2N4iey0ozMJ7qYs6
         IBHFssT8XX0Ik9t89JuFd98knMnzqGyIpe4IVamhk8kh5qpccp9yqopT7JQBbxdMLyud
         qobA==
X-Gm-Message-State: AOJu0YzIeRbBkET/Fnr5fu5rWsry4LW914bhDSEdZ9ist9Nu+ianKWVS
	YCmGJTy0Xt1b+B1JW9UDiA9zoAW98uWth/HUVUVI3FO61dV03GrPIzJUcrL2wg==
X-Gm-Gg: ASbGnct9lgvdvkdyLVItU2TGgH5jYKl4qTaHzyTm0pL0t/zExNq3ruMZGdZpD4Cuk1G
	0hCvtjzEEwwHoYtftFk7r182knwFY0OaTV6Uq3MCRE6QmbczTK47O1J3LMPBkiSjX4/f2X0YeH6
	z7mEQsCtCo2PXx+QYPK+vRX5gkayftQMkVpHD1QmqIUSSjW0O8yjGzCYxYrTAkVLLOCZ/hhAZ6q
	qOqafRIIGiqoe7U3rjnt8foy4FqsMKv59UJ6NK6a24ouEV6+DSZIW9x8wjfOcvtrNshg1RTkQb0
	Tc3/20o4F5NF1AekP0CJ02bgK8yrbNYEewvyv/6NRQsAfPmlEmpefav7npADJgOYQNd7YFA3oo8
	/bpehZulsDJcTpfkDoiNwxuXPw4JT30CzMEbxQIvImOwF/D9pt1Nx0EpofvzrP3v+6F+rr4GTN/
	4o1ddBmlUaq/1dxgBKzCaA3rsfTISBjCYwmu+gGltTCmEbKEHK6dJedojdZzSHEf1K+o6Sf/nBP
	CRuFusAzIHRs94S8XaVaZs39VHvmstnrw==
X-Google-Smtp-Source: AGHT+IGMgrcYTmuuPXzwGD0hd8ITGFCQCnEJhWmCRrf92+KOPVq4XyUWd91JGb43j2UoXxH/o3E/cg==
X-Received: by 2002:a17:90b:1e07:b0:327:53f0:6368 with SMTP id 98e67ed59e1d1-339c20a316cmr1454127a91.2.1759447638319;
        Thu, 02 Oct 2025 16:27:18 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:b4ff:982c:6a19:d5f4:4acb? ([2406:7400:56:b4ff:982c:6a19:d5f4:4acb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebd987sm6006173a91.7.2025.10.02.16.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 16:27:17 -0700 (PDT)
Message-ID: <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
Date: Fri, 3 Oct 2025 04:57:11 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 ps@pks.im, code@khaugsbakk.name, rybak.a.v@gmail.com, karthik.188@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 02/10/25 22:02, Elijah Newren wrote:
> Hi,
>
> First of all, thanks for continuing to work on this.
>
> On Fri, Sep 26, 2025 at 4:09 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> The git replay command currently outputs update commands that must be
> can be, not must be.
>
> This separation had three advantages:
>    * it made testing easy (when state isn't modified from one step to
> the next, you don't need to make temporary branches or have undo
> commands, or try to track the changes)
>    * it provided a natural can-it-rebase-cleanly (and what would it
> rebase to) capability without automatically updating refs, I guess
> kind of like a --dry-run
>    * it provided a natural low-level tool for the suite of hash-object,
> mktree, commit-tree, mktag, merge-tree, and update-ref, allowing users
> to have another building block for experimentation and making new
> tools.
>
> I was particularly focused on the last of those items for the intial
> version at the time, but it should be noted that all three of these
> are somewhat special cases, and the most common user desire is going
> to be replaying commits and updating the references at the end.


You are absolutely right - I mischaracterized both the "must be" claim and
the atomicity guarantee. Phillip and Karthik confirmed that update-ref
--stdin IS atomic by default, so my justification was fundamentally wrong.

Your suggested commit message structure is much better. It accurately
captures the real trade-offs (testing, dry-run capability, building
block) without making false claims, and explains why making ref updates
default serves the common case better.

I will use your suggested rewrite verbatim for v3.


>> piped to git update-ref --stdin to actually update references:
>>
>>      git replay --onto main topic1..topic2 | git update-ref --stdin
> or, alternatively, for those that want a single, atomic (assuming the
> backend supports it) transaction:
>
>     (echo start; git replay --onto main topic1..topic2; echo prepare;
> echo commit) | git update-ref --stdin
>
>> This design has significant limitations for server-side operations. The
>> two-command pipeline creates coordination complexity,
> agreed
>
>> provides no atomic
>> transaction guarantees by default,
> Sure, but it's quite trivial to add, right -- as shown above with the
> extra "start", "prepare", "commit" directives?


You are absolutely right. I overstated the difficulty - atomicity is
trivial to achieve with those directives. The real benefit is eliminating
the pipeline entirely for the common case, not providing atomicity that
wasn't already available.


>> and complicates automation in bare
>> repository environments where git replay is primarily used.
> Isn't this repeating the first statement from this paragraph?
>
> The paragraph also leaves off that I think it makes it more
> useful/usable to end-users.


You are right - I was repeating the coordination complexity point. And I
missed the broader benefit to end users (not just server-side). I will use
your suggested rewrite which captures this properly.


>
>> The core issue is that git replay was designed around command output rather
>> than direct action. This made sense for a plumbing tool, but creates barriers
>> for the primary use case: server-side operations that need reliable, atomic
>> ref updates without pipeline complexity.
> git replay was originally written with the goal of eventually
> providing a better interactive rebase.  I thought it important to have
> the earlier versions provide new useful low-level building blocks, but
> didn't intend for it to just be a low-level building block
> indefinitely.  The primary use case originally envisioned was
> client-side user interactive operations without much thought for the
> server, but it turned out to be easiest to implement what server-side
> operations needed first.  I made others aware of what I was working on
> so they could see, and Christian latched on and to my surprise told me
> it had enough for what he needed...and Johannes said about the same.
> Unfortunately, I got reassigned away from Git at my former dayjob,
> _and_ had multiple big long-term family issues strike about the same
> time, _and_ all Git-related employers did mass layoffs and locked down
> hiring about that time as well...so the end result is only that
> initial server-side stuff was done and it looks to outside observers
> like git replay's design and usecase was around the server.  While
> that's an understandable guess from the outside, this paragraph
> appears to have taken those guesses and rewrites them as fact.  I
> think it could be reworded with small tweaks to alter it and make it
> factual (s/designed/focused initially/, s/the primary use case/its
> current primary use case/), but even then, the paragraph that remains
> feels like it's just repeating what you said above.  It doesn't feel
> like it adds any positive value.
>
> Might I suggest a rewrite of the text of the commit message to this point?
>
> =====
> The git replay command currently outputs update commands that can be
> piped to update-ref to achieve a rebase, e.g.
>
>    git replay --onto main topic1..topic2 | git update-ref --stdin
>
> This separation had advantages for three special cases:
>    * it made testing easy (when state isn't modified from one step to
> the next, you don't need to make temporary branches or have undo
> commands, or try to track the changes)
>    * it provided a natural can-it-rebase-cleanly (and what would it
> rebase to) capability without automatically updating refs, I guess
> kind of like a --dry-run
>    * it provided a natural low-level tool for the suite of hash-object,
> mktree, commit-tree, mktag, merge-tree, and update-ref, allowing users
> to have another building block for experimentation and making new
> tools.
>
> However, it should be noted that all three of these are somewhat
> special cases; users, whether on the client or server side, would
> almost certainly find it more ergonomical to simply have the updating
> of refs be the default.  Change the default behavior to update refs
> directly, and atomically (at least to the extent supported by the refs
> backend in use).
> ====
>
> after this, I'd suggest also nuking your next few paragraphs and then
> continuing with:
>
>> For users needing the traditional pipeline workflow, --output-commands
>> preserves the original behavior:
>>
>>      git replay --output-commands --onto main topic1..topic2 | git update-ref --stdin
> This is good.  Did you also add a config option so that someone can
> just set that option once and use the old behavior?  (as per the
> suggestion at https://lore.kernel.org/git/xmqq5xdrvand.fsf@gitster.g/
> ?)


I didn't, but I should have. I will add a config option for v3.

For naming, I am thinking either:
   - replay.updateRefs (boolean: true = update, false = output-commands)
   - replay.defaultOutput (string: "update" | "commands")

The boolean feels simpler, but the string might be more extensible if we
add other output modes later. Which pattern feels more consistent with
existing Git config conventions? Looking at rebase.* they're mostly
boolean toggles, but am I missing a better example to follow?


>> The --allow-partial option enables partial failure tolerance. However, following
>> maintainer feedback, it implements a "strict success" model: the command exits
>> with code 0 only if ALL ref updates succeed, and exits with code 1 if ANY
>> updates fail. This ensures that --allow-partial changes error reporting style
>> (warnings vs hard errors) but not success criteria, handling edge cases like
>> "no updates needed" cleanly.
> Why is --allow-partial helpful?  You discussed at length why you
> wanted atomic transactions, but you introduce this option with no
> rationale and instead just discuss that you implemented it and some
> design choices once you presuppose that someone wants to use it.
>
> Is there a usecase?  I asked for it last time, and suggested
> discarding the modes without one, but you only discarded one of the
> extras while leaving this one in.  I'd recommend discarding this one
> too and just having the two modes -- the output commands that get fed
> to update-ref, or the automatic transactional update of all or no
> refs.


You are right - I don't have a concrete use case. I was trying to
anticipate potential needs but ended up adding unjustified complexity.

I will remove --allow-partial entirely from v3. This simplifies to exactly
two modes with clear purposes:
   1. Default: atomic ref updates (all-or-nothing)
   2. --output-commands: traditional pipeline for special cases

Much cleaner design.


>
>> Implementation details:
> Christian's comments on this list are good; it seems to mostly be
> stuff that belongs in the cover letter.  But I'll comment/query about
> two things...
>
>> - Empty commit ranges now return success (exit code 0) rather than failure,
>>    as no commits to replay is a valid successful operation
> That is a useful thing to call out.  Hmm....
>
>> - Defaults to atomic behavior while preserving pipeline compatibility
> The first part has already been covered at length; it doesn't seem
> like it needs to be repeated.  What does "while preserving pipeline
> compatibility" mean, though?


That was meant to reference --output-commands allowing the traditional
workflow, but you are right it's vague and redundant since that's already
been discussed. I will remove it.


>
>
>> The result is a command that works better for its primary use case (server-side
>> operations)
> This sentence feels like it's rewriting the history behind the
> command, and undersells the change by not noting that it *also* helps
> with client-side usage.  Also, since I think it's about the third time
> you've said this, it adds nothing to the discussion either; let's just
> strike it.
>
>> while maintaining full backward compatibility for existing workflows.
> and this is clearly false; backwards compatibility was intentionally
> broken by making update-refs the default.  Junio suggested making it
> easy to get the old behavior with a config setting, but looking ahead
> it appears you didn't even make it easy for users to recover the old
> behavior; they have to specify an additional flag with every command
> they run.
>
> Also, you further broke "full" backward compatibility by changing the
> exit status for empty ranges.  I think that's a rather minor change
> and maybe bugfix, but "full" invites comparisons and scrutiny of that
> sort.
>
> We could say something like "while making it easy to recover the
> traditional behavior with a simple command line flag", but this again
> feels like you're just repeating what was called out above.  Maybe
> just strike it as well?
>
>
> And on a separate note, several of your lines in your commit message
> are too long; in an 80-column terminal, a `git log` on your commit
> message has several lines wrapping around.  (Command lines, and for
> future reference output from commands, can run longer, but regular
> paragraphs should fit.)


I will wrap the commit message paragraphs to fit 80 columns
(keeping command lines and output longer as appropriate).


>
>> +...Use `--output-commands`
>> +to get the old default behavior where update commands that can be piped
>> +to `git update-ref --stdin` are emitted (see the OUTPUT section below).
> Perhaps instead:
>
> Use `--output-commands` to avoid the automatic ref updates and instead
> get update commands that can be piped
> to `git update-ref --stdin` (see the OUTPUT section below).
>
>> +--output-commands::
>> +       Output update-ref commands instead of updating refs directly.
>> +       When this option is used, the output can be piped to `git update-ref --stdin`
>> +       for successive, relatively slow, ref updates. This is equivalent to the
>> +       old default behavior.
> "piped" => "piped as-is" + "successive, relatively slow," => "a
> non-transactional set of" ?


Good wording improvements. "Piped as-is" clarifies no transformation is
needed, and "non-transactional" is more accurate than "successive,
relatively slow" which made performance claims without justification.


>> +--allow-partial::
>> +       Allow some ref updates to succeed even if others fail. By default,
>> +       ref updates are atomic (all succeed or all fail). With this option,
>> +       failed updates are reported as warnings rather than causing the entire
>> +       command to fail. The command exits with code 0 only if all updates
>> +       succeed; any failures result in exit code 1. Cannot be used with
>> +       `--output-commands`.
> If we keep this, I like Phillip's suggestion to combine to a single
> flag with a value.  But I still want to hear the use case behind it;
> it goes against what you repeatedly claimed was wanted on the server,
> and you didn't discuss any other usecase.  It feels like you were
> trying to proactively support every possible way people might want to
> update without considering the usecases behind it, and I'd rather just
> leave it unimplemented unless or until there's demand for it.
>
>> +
>>   <revision-range>::
>>          Range of commits to replay. More than one <revision-range> can
>>          be passed, but in `--advance <branch>` mode, they should have
>> @@ -54,15 +68,20 @@ include::rev-list-options.adoc[]
>>   OUTPUT
>>   ------
>>
>> -When there are no conflicts, the output of this command is usable as
>> -input to `git update-ref --stdin`.  It is of the form:
>> +By default, when there are no conflicts, this command updates the relevant
>> +references using atomic transactions
> atomic transaction*s*?  Shouldn't that be *an* atomic transaction instead?


You are right. Each invocation is one transaction with multiple updates.
I wrote "transactions" thinking about multiple command invocations, but
that's confusing.

I will change to "an atomic transaction" and clarify once that all ref
updates succeed or all fail, rather than repeating the point.


>
>>> and produces no output. All ref updates
>> +succeed or all fail (atomic behavior).
> Why the need to repeat?


You are right saying "atomic transactions" and then "(atomic behavior)"
is redundant. I will state it once clearly: "using an atomic transaction"
and remove the parenthetical.


>
>> +To rebase multiple branches with partial failure tolerance:
>> +
>> +------------
>> +$ git replay --allow-partial --contained --onto origin/main origin/main..tipbranch
>> +------------
> I don't understand why this one deserves an example; the command line
> flag seems to be self-explanatory.  The onto and advanced are
> interesting in that the ranges specified with them might not be
> obvious from their description and so examples help.  One or maybe two
> --contained examples can go with those, to demonstrate how it involves
> additional branches, though those might be better coupled with the
> --output-commands because the output more clearly demonstrates what is
> happening (i.e. what is being updated).  But I don't see what this
> example might elucidate.
>
> Then again, while I perfectly understand what the flag does, I have no
> idea why you thought it was useful to add, so maybe I'm just missing
> something.
>
>>   When calling `git replay`, one does not need to specify a range of
>>   commits to replay using the syntax `A..B`; any range expression will
>> -do:
>> +do. Here's an example where you explicitly specify which branches to rebase:
>>
>>   ------------
>>   $ git replay --onto origin/main ^base branch1 branch2 branch3
>> +------------
>> +
>> +This gives you explicit control over exactly which branches are rebased,
>> +unlike the previous `--contained` example which automatically discovers them.
>> +
>> +To see the update commands that would be executed:
>> +
>> +------------
>> +$ git replay --output-commands --onto origin/main ^base branch1 branch2 branch3
>>   update refs/heads/branch1 ${NEW_branch1_HASH} ${OLD_branch1_HASH}
>>   update refs/heads/branch2 ${NEW_branch2_HASH} ${OLD_branch2_HASH}
>>   update refs/heads/branch3 ${NEW_branch3_HASH} ${OLD_branch3_HASH}
> As noted above, I don't think we need to repeat an --output-commands
> example for every example that exists; it feels like overkill.  One
> (or _maybe_ two) should be sufficient.


Agreed. With --allow-partial removed, I will keep just one clear
--output-commands example that demonstrates the traditional pipeline
workflow. The multiple examples were overkill.


>
>> @@ -330,9 +361,12 @@ int cmd_replay(int argc,
>>                  usage_with_options(replay_usage, replay_options);
>>          }
>>
>> -       if (advance_name_opt && contained)
>> -               die(_("options '%s' and '%s' cannot be used together"),
>> -                   "--advance", "--contained");
>> +       die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>> +                                 contained, "--contained");
> Broken indentation.  Also, should this have been done as a preparatory
> cleanup patch?


Good catches. I will fix the indentation.

On making it a preparatory patch: should I split it out as a separate
cleanup commit, or is it minor enough to fold into the main change? I am
leaning toward folding it in since it's directly related to the option
handling changes



>
>> @@ -407,6 +452,8 @@ int cmd_replay(int argc,
>>                  khint_t pos;
>>                  int hr;
>>
>> +               commits_processed = 1;
>> +
>>                  if (!commit->parents)
>>                          die(_("replaying down to root commit is not supported yet!"));
>>                  if (commit->parents->next)
>> @@ -457,9 +535,17 @@ int cmd_replay(int argc,
>>                  strset_clear(update_refs);
>>                  free(update_refs);
>>          }
>> -       ret = result.clean;
>> +
>> +       /* Handle empty ranges: if no commits were processed, treat as success */
>> +       if (!commits_processed)
>> +               ret = 1; /* Success - no commits to replay is not an error */
>> +       else
>> +               ret = result.clean;
> The change to treat empty ranges as success is an orthogonal change
> that I think at a minimum belongs in a separate patch.  Out of
> curiosity, how did you discover the exit status with an empty commit
> range?  Why does someone specify such a range, and what form or forms
> might it come in?  And is merely returning a successful result enough,
> or is there more that needs to be done for correctness?


I was thinking about automated scripts that compute ranges dynamically -
they might generate A..B where it turns out A==B, and treating that as
"no work needed, success" seemed reasonable for scripting.

But you raise a good point: A..A seems like obvious user error (why would
anyone do that intentionally?), and B..A where B contains A is likely a
mistake that maybe should error rather than silently succeed.

I am inclined to drop it entirely from this series. If there's real demand
for specific empty-range handling, we can add it later with proper
discussion of the actual use cases. Does that sound reasonable?


>
>> +test_expect_success 'using replay with default atomic behavior (no output)' '
>> +       # Create a test branch that wont interfere with others
> This works, but I feel doing this clutters the repo for someone
> inspecting later when some test in the testsuite fails, and makes
> readers track more branches to find out what the tests are all doing.
> Would it be easier to prefix your test with something like
>
>          START=$(git rev-parse topic2) &&
>          test_when_finished "git branch -f topic2 $START" &&


That's much cleaner - I will rework all the new tests to use
test_when_finished instead of creating new branches. It keeps the test
state contained and makes it easier to understand what each test is
actually verifying.


>
> and then...
>
>> +       git branch atomic-test topic2 &&
>> +       git rev-parse atomic-test >atomic-test-old &&
> drop these lines...
>
>> +
>> +       # Default behavior: atomic ref updates (no output)
>> +       git replay --onto main topic1..atomic-test >output &&
> use topic2 instead of atomic-test...
>
>> +       test_must_be_empty output &&
>> +
>> +       # Verify the branch was updated
>> +       git rev-parse atomic-test >atomic-test-new &&
>> +       ! test_cmp atomic-test-old atomic-test-new &&
> Not sure this comparison to verify the branch was updated makes much
> sense given that the few lines below both test that it was updated and
> that it was updated to the right thing.
>
>> +
>> +       # Verify the history is correct
>> +       git log --format=%s atomic-test >actual &&
>> +       test_write_lines E D M L B A >expect &&
>> +       test_cmp expect actual
> ...and finally use topic2 instead of atomic-test here.
>
>
> Similarly, using test_when_finished throughout the rest of the
> testsuite similarly I think would make it a bit easier to follow and
> later debug.
>
>
>>   test_expect_success 'using replay on bare repo to rebase two branches, one on top of other' '
>> -       git -C bare replay --onto main topic1..topic2 >result-bare &&
>> -       test_cmp expect result-bare
>> +       git -C bare replay --output-commands --onto main topic1..topic2 >result-bare &&
>> +
>> +       # The result should match what we got from the regular repo
>> +       test_cmp result result-bare
>>   '
> What do you mean by "regular repo"?  There's only one repo at play.
>
> Also, why change "expect" to "result" here?  You don't care if you get
> the expected result, merely that you get the same result as a previous
> test even if it was also buggy?


You are right "regular repo" is confusing since we are just comparing
non-bare vs bare on the same repository.

The "result" vs "expect" issue happened because I inserted a test between
the expectation-building and this test. I will reorder the tests so the
expectation is built immediately before this test, or just rebuild the
expectation here for clarity.


> I think the reason was that you inserted a test since writing the
> expectation out, but I think it'd be better to either re-write the
> expectation out and compare to it, or reorder the tests so you can
> use the same expectation from before.
>
>
>> +# Tests for new default atomic behavior and options
> The word "new" here is going to become unhelpful in the future when
> someone reads this a few years from now; you should strike it.  What
> does "and options" mean here?


Good point. I will change it to just "# Tests for default atomic behavior"
since that's what the tests actually verify - the default behavior and
that it's atomic.


>
>> +
>> +test_expect_success 'replay default behavior should not produce output when successful' '
>> +       git replay --onto main topic1..topic3 >output &&
>> +       test_must_be_empty output
>> +'
> This changes where topic3 points; I think a test_when_finished to
> reset it back at the end of the test would be nice.
>
>> +test_expect_success 'replay with --output-commands produces traditional output' '
>> +       git replay --output-commands --onto main topic1..topic3 >output &&
>> +       test_line_count = 1 output &&
>> +       grep "^update refs/heads/topic3 " output
>> +'
> The fact that topic3 was already replayed in the previous test makes
> this test weaker.  And the fact that it does nothing but check that
> there is in fact some output makes it weaker still.  But rather than
> fix it, there were already lots of commands that tested
> --output-commands prior to this, and you added a comment above that
> you were adding tests of the atomic behavior, I don't see why we need
> any additional tests of --output-commands.


You are right this test is redundant given existing --output-commands
tests. I will remove it since we already have adequate coverage of that
mode.


>
>> +test_expect_success 'replay with --allow-partial should not produce output when successful' '
>> +       git replay --allow-partial --onto main topic1..topic3 >output &&
>> +       test_must_be_empty output
>> +
>> +test_expect_success 'replay fails when --output-commands and --allow-partial are used together' '
>> +       test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
>> +       grep "cannot be used together" error
>> +'
> These are fine if --allow-partial can be motivated, but otherwise
> should be removed along with that flag.
>
>> +
>> +test_expect_success 'replay with --contained updates multiple branches atomically' '
>> +       # Create fresh test branches based on the original structure
> Unnecessary if you use the test_when_finished stuff I showed you to
> ensure the original structure remains intact
>
>> +       # contained-topic1 should be contained within the range to contained-topic3
>> +       git branch contained-base main &&
>> +       git checkout -b contained-topic1 contained-base &&
>> +       test_commit ContainedC &&
>> +       git checkout -b contained-topic3 contained-topic1 &&
>> +       test_commit ContainedG &&
>> +       test_commit ContainedH &&
>> +       git checkout main &&
>> +
>> +       # Store original states
>> +       git rev-parse contained-topic1 >contained-topic1-old &&
>> +       git rev-parse contained-topic3 >contained-topic3-old &&
>> +
>> +       # Use --contained to update multiple branches - this should update both
>> +       git replay --contained --onto main contained-base..contained-topic3 &&
>> +
>> +       # Verify both branches were updated
>> +       git rev-parse contained-topic1 >contained-topic1-new &&
>> +       git rev-parse contained-topic3 >contained-topic3-new &&
>> +       ! test_cmp contained-topic1-old contained-topic1-new &&
>> +       ! test_cmp contained-topic3-old contained-topic3-new
>> +'
> I think verifying both branches were modified without checking
> anything about the modification is a pretty weak test.  We should
> check that both branches have the appropriate commit sequence in them
> via git log output, as previous tests do.


Right. I will add verification of the actual commit sequences using
git log --format=%s for both branches, not just that they changed.


>
>> +test_expect_success 'replay atomic behavior: all refs updated or none' '
>> +       # Store original state
>> +       git rev-parse topic4 >topic4-old &&
>> +
>> +       # Default atomic behavior
>> +       git replay --onto main main..topic4 &&
>> +
>> +       # Verify ref was updated
>> +       git rev-parse topic4 >topic4-new &&
>> +       ! test_cmp topic4-old topic4-new &&
>> +
>> +       # Verify no partial state
>> +       git log --format=%s topic4 >actual &&
>> +       test_write_lines J I M L B A >expect &&
>> +       test_cmp expect actual
>> +'
> This test doesn't test what it says it does.  It merely tests that the
> single topic was modified, and as such, isn't a very useful additional
> test.  Using the contained flag where one of the branches had a lock
> in the way or a simultaneous push and then testing that none of the
> branches got updated would be needed if you want to test this.


You are absolutely right - testing a single ref doesn't demonstrate
atomicity at all.

For v3, I will create a real atomic test: use --contained with multiple
branches, introduce a lock on one of the refs (maybe via
.git/refs/heads/branch.lock), then verify that NONE of the branches got
updated when the transaction fails. That actually tests the all-or-nothing
guarantee.


>
>> +test_expect_success 'replay works correctly with bare repositories' '
>> +       # Test atomic behavior in bare repo (important for Gitaly)
>> +       git checkout -b bare-test topic1 &&
>> +       test_commit BareTest &&
>> +
>> +       # Test with bare repo - replay the commits from main..bare-test to get the full history
>> +       git -C bare fetch .. bare-test:bare-test &&
>> +       git -C bare replay --onto main main..bare-test &&
>> +
>> +       # Verify the bare repo was updated correctly (no output)
>> +       git -C bare log --format=%s bare-test >actual &&
>> +       test_write_lines BareTest F C M L B A >expect &&
>> +       test_cmp expect actual
>> +'
> This doesn't test what the initial comment says is the important bit;
> in fact, since only a single ref is being updated there's no chance to
> test atomicity of updating multiple refs. Or is the parenthetical
> ambiguous and I should have read that as bare repositories being
> important?  If the latter, this test is mere redundancy; there were
> multiple tests in a bare repository previously.


The parenthetical was ambiguous, I meant bare repositories are important
for Gitaly, not that this test demonstrates atomicity. Since there are
already multiple bare repo tests, I'll either remove this as redundant or
reframe it to test atomicity with multiple refs in a bare repo.


>
>> +test_expect_success 'replay --allow-partial with no failures produces no output' '
>> +       git checkout -b partial-test topic1 &&
>> +       test_commit PartialTest &&
>> +
>> +       # Should succeed silently even with partial mode
>> +       git replay --allow-partial --onto main topic1..partial-test >output &&
>> +       test_must_be_empty output
>> +'
> Test is fine, _if_ --allow-partial is worthwhile to add.
>
>> +test_expect_success 'replay maintains ref update consistency' '
>> +       # Test that traditional vs atomic produce equivalent results
> I think the comment is a better test name than the actual test name;
> I'd remove the existing testname, and move the comment to the test
> name, and then not have a comment here.


Good suggestion. I will rename to:

   test_expect_success 'traditional pipeline and atomic update produce
   equivalent results'

Much clearer what it's actually testing.


>
>> +       git checkout -b method1-test topic2 &&
>> +       git checkout -b method2-test topic2 &&
>> +
>> +       # Both methods should update refs to point to the same replayed commits
>> +       git replay --output-commands --onto main topic1..method1-test >update-commands &&
>> +       git update-ref --stdin <update-commands &&
>> +       git log --format=%s method1-test >traditional-result &&
>> +
>> +       # Direct atomic method should produce same commit history
>> +       git replay --onto main topic1..method2-test &&
>> +       git log --format=%s method2-test >atomic-result &&
>> +
>> +       # Both methods should produce identical commit histories
>> +       test_cmp traditional-result atomic-result
>> +'
>> +
>> +test_expect_success 'replay error messages are helpful and clear' '
>> +       # Test that error messages are clear
>> +       test_must_fail git replay --output-commands --allow-partial --onto main topic1..topic2 2>error &&
>> +       grep "cannot be used together" error
>> +'
> Does this test that "error messages are helpful and clear" or just
> that "--output-commands and --allow-partial" are incompatible?


It's really just testing incompatible options. Since --allow-partial is
going away, this test goes away too.


> The former would be a test of _all_ error messages from git replay, and
> would need to look at more than just a small substring of the error
> message(s).


It's really just testing incompatible options. Since --allow-partial is
going away, this test goes away too. The option incompatibility will be
reduced to just the existing --advance/--contained check.


>
>> +test_expect_success 'replay with empty range produces no output and no changes' '
>> +       # Create a test branch for empty range testing
> Why?  Since you use an A..A range below, you can just use any existing
> branch in that place, right?
>
>> +       git checkout -b empty-test topic1 &&
>> +       git rev-parse empty-test >empty-test-before &&
>> +
>> +       # Empty range should succeed but do nothing
>> +       git replay --onto main empty-test..empty-test >output &&
>> +       test_must_be_empty output &&
> Is A..A the only consideration?  Why would anyone ever pass that to
> the tool?  I would have thought that if someone made this mistake it
> was a B..A range where it wasn't obvious to the caller that B
> contained A.  I don't see why anyone would do A..A and then get
> surprised at the exit status; that feels like user error.  And in the
> B..A case, it's not clear to me that returning success without
> updating A is correct.  You might be giving the user false hope that
> the command did what they wanted.


Good point. I only considered A..A, but you are right that B..A (where B
contains A) is more likely and problematic. Silently succeeding could mask
a mistake in their range specification.

I will drop the entire empty range change from this series. The behavior
for empty ranges probably deserves its own focused discussion if there's
real demand for special handling


>
>> +       # Branch should be unchanged
>> +       git rev-parse empty-test >empty-test-after &&
>> +       test_cmp empty-test-before empty-test-after
>> +'
>> +
>>   test_done
>> --
>> 2.51.0


Thanks again for taking the time to provide such detailed feedback. This
is incredibly helpful.

