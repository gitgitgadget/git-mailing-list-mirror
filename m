Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92963128AB
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709812; cv=none; b=rGcm/VtX7IBCE7PPQFjoo7rs0OHg9CF2bWH0YOUDntLIE0dNI70twdpPwegw0HV3d7ABwgAMAIc1Ru0m+QRuSU62ckn16SdR/BHrYekei2Dogbg7X3NXSileqSi3GgdUL4CtJckyKamzB+/s7OkxPd0M/YVAfqiq7bQmrQPpCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709812; c=relaxed/simple;
	bh=4v0mG6Cn6R2aScJJUGZR/QRfCgL587mrYxHVYIIiGso=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RE8lhmCNSI9VAd3wr+Jw/7ZJQePZLA496Niq13Fyrr7XAeT5dfo/DWF3XdonoOLjvM+nukPb9QcxyNKbhvZVy3yBWUzqMHiAxjo4J3CoSeJ5pJQQ509uOqTQ2tkeVwj0ky4D7zEoENIaNLyHbDPdC1hUKmo2b+3kxbQv7eX+tfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaCLVsUS; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaCLVsUS"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4327555464cso581631f8f.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767709804; x=1768314604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGszS3YxrfUbjS9yjwCQtP4bJaRQ0gDS5yvxBrFaJrs=;
        b=IaCLVsUS/BvRYNf2lBwyN0l2AYNCKN/WaA8Y4sqmsiT9AveILhte9+wDx81CKJLaii
         VgGAW59cFgUm/eDa4k6lMEm9yvUrIKjmuE9t1HfQtz26k90h73KKxU8/AZkPE6KeoYe9
         ++HhJGUXpslF8VTfyG/sSV/Y40gcKfO57zjtkjgOqsGR/D96Hep43Ozj6k3lyuaYuK38
         cvOa0auDQGwX5YDdMzVgHihLPPsbkcdsJ4RZQBMeNvGouwl/peoA5OfFFfBcXBgrutR4
         E3EXbDe2Zyjri9Lhm4cANimiYRFrMJg+dMdiWP3nYKaDn/z1TjsPXL4l/P06DWlzhIbw
         KZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767709804; x=1768314604;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGszS3YxrfUbjS9yjwCQtP4bJaRQ0gDS5yvxBrFaJrs=;
        b=VkzsH3Z9OcanRN6TB9nBERquiYh3KJOO62AuR0nxTDbRROyg5m84O2jpJxtMEIpULU
         CKj3+4fu8TuAJ6SUemBdW6yGRzS17VGUcPNXm2rF94jSoHZ2atn1ezC1rhzqXR+g4E/L
         N0GQk39+eynQHH8itbFOS/H0ZBU3xb31pratAvQ4pdy28NFe9Ok+2/OsWeG2M9WN0NXa
         0q/IAAgdjqj7ITuPQfJERacwI69VpCx4RcsmCKwoa6BdZSH5cMtLhCXZRlyKAbSpgoJx
         XttzB3Rr7TSiiKA5WoEz0/1BCwH82+X1/woJxIhimlomUzVShMMjlP6Yn7+TfVpxElIl
         XvRA==
X-Gm-Message-State: AOJu0YzMGo445bL3iPf/mgT8m/GLNYHffMbj6mnt1ozl6/jOlZjPCqzr
	daOVRqhu3p4PrYXXMjtS6jUJvNDjlJHswryNKOKqusEwkq6odi9zS3rJOg9ndyO2
X-Gm-Gg: AY/fxX5I6hPJ6MEVbP16iSOzFnX4ds30K+gZtcafsfTG6uvF1/HVw/2TBTZsDx6OXyl
	VgYV1b+sYAoq7+7rYdElWjjTGLI7/mIPCrtAKHsI0G4wuLyC3YwIlrdRx8qVIrbgVKAzoz245YR
	M7VvLihdyHdpI9/iuoHS86/cTHrhqY14o77uJ0Em68kxFSSmMB5MfbILSuHtzHE1l2G66b8j4gB
	14DGTxyleh/fMAZA45CJqSizPkTY8uQgGhb49Ro/hLtYI4y8lNPpisBuTXFUJ1qzXzOgzSOzkTS
	+JAscrjQ/TBXrlYxnIX2+lS7AM0qTXupX1cS45RHM0FF0reUH2gqaE4IQFnv9pS9SLde2Jt0Jwr
	L1aIapxDRAtJsp3vqLZLvFo43BvB2RJ1n3JSm0lqyqr9RdyhV8tX19WJMDZrcKVtBLUUtglJkws
	qxXwPIrOzrw8WQn8l3GAr+bnL9/RKOSSR74OxMwPKvzc0Lz95U0L4Cp8op11T9fenz4V1kgV48q
	P9v
X-Google-Smtp-Source: AGHT+IFd8974stQsyaZ/qD904oSyy0C6ja3GDCYh0u0XWX+hpSSFY/i0lRsAlTV84EMdGbBM205Udw==
X-Received: by 2002:a05:6000:609:b0:42f:b9c6:c894 with SMTP id ffacd0b85a97d-432bca4f01amr3962313f8f.52.1767709803804;
        Tue, 06 Jan 2026 06:30:03 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df91fsm4853303f8f.23.2026.01.06.06.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 06:30:03 -0800 (PST)
Message-ID: <2908fbe7-73bb-4f45-8d69-c2c685a9c3a2@gmail.com>
Date: Tue, 6 Jan 2026 14:29:58 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Metadata for merge conflicts during rebase (to aid rustc) and
 potential for better user experience?
Reply-To: phillip.wood@dunelm.org.uk
To: =?UTF-8?Q?Esteban_K=C3=BCber?= <esteban@kuber.com.ar>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
References: <CAHnEOG2o784dk+OpkGt-1qjRJb34=sFMJvh-JRJ3v+GNBxFywQ@mail.gmail.com>
 <CALnO6CAYaOQBOg+8pUZk95frML5tod+N_n3avxASRL10sLtwwA@mail.gmail.com>
 <CAHnEOG29C1fRBZtpEkebat8znMst7D1JiWdqDAVJQceYqMZGkA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHnEOG29C1fRBZtpEkebat8znMst7D1JiWdqDAVJQceYqMZGkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Esteban

On 24/12/2025 15:03, Esteban Küber wrote:
> On Mon, Dec 22, 2025 at 1:56 PM D. Ben Knoble <ben.knoble@gmail.com> wrote:
>> On Mon, Dec 22, 2025 at 9:31 AM Esteban Küber <esteban@kuber.com.ar> wrote:
>>>
>>> The questions I have are:
>>>   - can I *avoid* `--points-at` in any way to identify what branch we're
>>>     rebasing onto?
>>
>> According to "git help rebase", ORIG_HEAD is not reliable but @{1} should be.
> 
> After talking with other members of the compiler team, people have
> concerns about invoking git from the compiler, as it can be a vector
> for unwanted behavior.

If we're talking about "git rev-parse --git-path" then that does not run 
any hooks or external processes. In a linked worktree or submodule then 
".git" is a file rather than a directory. You will need to read the file 
(which looks like "gitdir: <path>\n" to find the path to the directory.

> I would agree with that assessment, so I am
> trying to settle on a mechanism where I can parse git state myself
> (on a best-effort basis; this is only for diagnostics, so fully
> featured support for all environments is not necessary).
> 
>>>   - is there already a better way to identify if the rebase was triggered by
>>>     `git rebase` or `git pull` (configured to rebase)?
>>
>> I haven't studied the internals on this yet, but I think the common
>> pattern is to look at REBASE_HEAD vs. MERGE_HEAD.
> 
> Thank you for the additional information! That prompted me to look
> into the rest of the files once more, which gave me some hacky ideas
> on how to get the data I want, and this indeed seems to be
> sufficient to differentiate these two.
> 
>>>   - if neither of the above has a "yes" answer, would git consider *adding*
>>>     that information, both for third-parties as well as to extend its own UI?
>>
>> I think "git status" already shows some of this (maybe not the
>> branches in question, but certainly the "it looks like you're in the
>> middle of a rebase/merge/cherry-pick/etc.").
> 
> I looked around again and arrived to the following conclusions:
> 
>   - presence of .git/rebase-merge (and its files) is enough to
>     differentiate between a rebase and a merge

Being pedantic the presence of ".git/rebase-merge" tells us that a 
rebase is in progress, it does not guarantee that the conflicts were 
created by the rebase though as it is possible for the user to run "git 
merge", "git cherry-pick" or "git revert" during a rebase. When a commit 
is being split it is possible that the conflicts come from "git stash 
pop" if the user stashes some changes, edits a file, commits and then 
pops the stashed changes.

>   - .git/rebase-merge/head-name is enough to identify one of the sections

Yes, that will give you the name of the branch being rebased.

>   - identifying *at least* one of the sections is enough to make the
>     output clear enough (even if ideally you'd identify both)
>   - the sha in FETCH_HEAD matching .git/rebase-merge/onto is enough
>     to identify that we're dealing with a `git rebase --rebase`

Note that FETCH_HEAD stays around until it is overwritten by the next 
fetch so that if I run

	git pull --rebase

followed by one of

	git rebase --autosquash [--keep-base]
	git rebase -i [--keep-base]

without running "git fetch" then ".git/rebase-merge/onto" will match 
FETCH_HEAD but I'm not running "git pull" and I'm not rebasing onto a 
new base so any conflicts come from re-arranging the existing commits, 
not from changes in the upstream branch.

I think the most sensible way of solving this is for "git rebase" to 
start writing a description of the "onto" commit to 
".git/rebase-merge/onto-desc". That would allow the output of "git 
status" to include the branch or tag that we're rebasing onto as well. 
I've got a rough patch that creates that file in common cases. If the 
base of the branch is not being changed the file contains "same base" 
[1], if "onto" matches the upstream branch it contains "upstream <ref>" 
where <ref> is the full ref of the upstream branch. If the argument 
given to "--onto" is a ref then the file contains the full name of the 
ref [2]. Finally when rebasing onto a new root commit it contains "new 
root".

[1] Detecting that in the general case involves a revision walk which
     I'd like to avoid so it only works in common cases like
         git rebase -i HEAD~<n>
         git rebase --keep-base --autostash
         git rebase -i --onto ...@{u}

[2] If "--onto" is omitted then it defaults to "<upstream>" so if the
     user runs "git rebase some-branch" the file will contain
     "refs/heads/some-branch". Unfortunately "git pull --rebase" passes
     object id's rather than refnames when it run "git rebase" so the
     branch name is only detected when rebasing onto the upstream branch.


I'll try and post a patch next week.

>   - there's information that is only present in MERGE_MSG in
>     free-form text, that isn't present anywhere else

I assume that's the name of the branch we're merging into HEAD. For 
squash merges the equivalent file is SQUASH_MSG.

>   - I can extract the "missing" information for either the
>     identifying information of where we are merging, be it because of
>     a `git pull --no-rebase` or `git merge`; the only issue I see is
>     in having to rely that the output will not change from either of
>     "Merge branch 'main' into branch-name" and
>     "Merge branch 'main' of example.url:user/repo" (how much trouble
>     am I inviting if I were to try and rely on this text not changing
>     so that I can get 'main' and the remote url from here?)

I'd be surprised if the messages changed but I don't think anyone is 
going to pledge that they'll never change. You read the object id out of 
MERGE_HEAD (that is always a file even if the repository is using the 
reftable backend) and use "git for-each-ref --points-at" to find the 
branch name.

> First, the information present in MERGE_MSG should be available in a
> more structured format, to allow for tools to deal with git state in
> a less coupled way. (This might not be worth it, and the textual
> representation is already "stable enough" to rely on.)

That might be useful for "git status" as we could say which branch was 
being merged.

> Secondly, and perhaps more importantly, when generating the diff
> markers that end up in the user files, their description includes
> only the full sha or HEAD, or the short-sha and the commit message.
> I would propose that the branch be identified as well in the
> generated code.  This could look something like:
> 
> `git rebase`:
> <<<<<<< HEAD [branch 'main']

In the general case HEAD isn't really the branch 'main', it is main plus 
whatever commits we've already applied. I think I saw someone suggest 
[from 'main'] which might be better

> =======
>>>>>>>> e644375 (commit message) [branch 'name']

Unless we're applying the last commit from the branch this isn't branch 
'name' but one of the commit from it.

> 
> `git merge`:
> <<<<<<< HEAD [branch 'name']
> =======
> ------- between this marker and `>>>>>>>` is the code from branch 'master'

I'm skeptical that we want to inject extra text into the conflicted 
region. It makes sense for rustc's diagnostics but it makes it harder to 
resolve the conflict if we inject them into the file.

>      println!("Hello, main!");
>>>>>>>> [branch 'main']

For merges [branch '<name>'] definitely makes sense for the two merge 
heads, I'm not sure what we'd do for the merge base though.

> `git pull --rebase`:
> <<<<<<< HEAD [local branch 'main']

Do we really need a different label when pulling?

> =======
>>>>>>>> 8191e7e4f9f82be45bdd4e71c37d2adcf4f88aa2 [branch 'main' of example.tld:user/repo]

Ideally we'd use the remote tracking branch here when pulling from a 
configured remote repository rather than giving the name of the branch 
on the remote and it's url.

> `git pull --no-rebase`:
> <<<<<<< HEAD [branch 'main' of example.tld:user/repo]
> =======
>>>>>>>> ebbeec7 (commit message) [local branch 'main']
> 
> The format doesn't have to match the above exactly, but having the
> commit *and branch* information will make it much easier for people
> to identify things at a glance, at the cost of some additional
> verbosity in the generated code.
> 
> The source of the issue is that where "our" and "their" code is in
> the patch depends on a somewhat "arbitrary" distinction (as far as
> a non-implementer is concerned) and it *swaps places* depending on
> whether we are rebasing or merging. Adding some context to the
> resulting patches would go a long way of mitigating the confusion
> this causes.

I agree having some indication of which branch each side comes would be 
useful but I think when rebasing it needs to be clear that the branch 
does not necessarily point to that particular commit.

Thanks

Phillip

> Happy holidays,
> Esteban Küber
> 

