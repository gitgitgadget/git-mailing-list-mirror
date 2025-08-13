Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2D80B
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091899; cv=none; b=f4E9T/7YAHCSeMgzidlERBmB9iaTLClJGuAoe+ASm5Nj3XOZJRZBVrVLwRpRtW3GYGEwsH3rZSbjvSPdNV4dIW9ha8LIu+MbARg7vsqCT1bbFro2o/Hyt0XkZnBd8IfUbwmsorHSEOdg6uhofel0bnJ1lOjoxmmb+fYQWDNcsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091899; c=relaxed/simple;
	bh=eLrJlJbXwcwh+HhogMxEHYBFRWbsgx8pJ4bbUT4gbgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgrWyZcBP4sUWY+c3EnEiG0cAIv9l5R4LO14IiOzYpl4ZKoc1yywc9ymUpacmlWLQXi1AMVp0laRdMBYilETtY0JPzxjpF7vFQ/N6s4bycRYT9FAtdUqXA4rxMuZiY7droiP00Af6gertyaoIzQ4DSEGs2Eicrw6i2nl8rf0mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+gXMTBj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+gXMTBj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so59419095e9.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091895; x=1755696695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TJqb5FCx2Ms0EGoJkAUpMAE8o7KJD7GfQ4RqCHPZIX4=;
        b=O+gXMTBjDp5QVnLT76XIstQ126S3CSEHMoqjqxdEH5gmAsXSEIf+qBoNTpec4X4r9H
         WqP92+UbSyfkPxHwEbkmrzvNleqJ8Qag5HNtZfPVtCcn6va1Dg7CsKa7RW1Oq3CEFscs
         jgZlT6jW9TOBUBi4UFOyhgKRQV0g/hTpmndxEmagIteGylWWQdNrzIqK+MUmOGViHGEI
         qMUoPWO0fPIKvZGvacW4Ptiu9+G9yMjUewY5XadBgla3Lgr2ChlXT0Pm9KaSaXgW5uSc
         P/vzfMkG1bBtTsGPmvZl5N98UA6UgGEZ8xWCXcZoLXLanrXYtk9HjEEDN8A6S9pRzOdH
         sjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091895; x=1755696695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TJqb5FCx2Ms0EGoJkAUpMAE8o7KJD7GfQ4RqCHPZIX4=;
        b=rbwDwKPNw19s7EfkD/5Z7HwhMXm5vbJ0RXvtfXyA/mbAm55SKvoYK6vLxO+3/9fmsw
         q6TYqRR8V5fJKvjCurjDknIuR8Lw9JnO64IDeVVz9G3bU2F289nXX5FHAHQ0UKYlLKKc
         Kh1NHnX5ALpcVftJfiNALlbLhM7LwJX/5SW3tbdIi9HjeKaJQyDc/4D/dxa6Uc+cFsD0
         LUYFaXtryyrOnUfSaVvyEIz1AgIdL6CLvC9aI4ttB+v08AqpDLsXmqfzGmxqC1Ehayqi
         vkgFakx2hLD23UYNTEPnzZWJCU/2vFz8lg1Uw/Pg1Dx9ryJkHZcdPABi3OTu9KG774Ha
         Y+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXq2mCMg4zHp0Om/R+ibLz4ZQozy1sLV/tOMRX474e1vWLJe7A5azPhzhOQmqesLR7n+es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyThdbAWpIXj06X4VjPWz09wSGy2Az1kkDv2nwtLouz8wKi61c
	sARwbZH0mxLAW7jKjFS8cJ2UEA0T+Kqgzb5Y+rtmyLSoSQ8M8gcRbYdTkidTyQ==
X-Gm-Gg: ASbGncsFwi0oOi8Lr3ZKijQw/7PvsWqS6qROgCr4ZqFO/94GfwIZKpixnZgqFxfnPyD
	U1vIETM0V94IYWaubB6LUAKKRscaby9t8RZVA89peyjDaQPCMmhHKB/KDPPnH7bv/sOuwyJ7Z9g
	7vKEgtzWGh9dJNZ/LHOe5dnlP351M3tY1DC50Y8m7EUjEXQDlhKftNz2ZLlD3WuKJ+QA0SGqSHu
	0+kfKEghFKxAH+t/58XRY+D5yyis9dANSjv1S8OcUi1HuRqhDir3orWwJDu0zli3seE+TDMP6SQ
	3x5j32dCdo/SZjWfJBKfsKObHzrWCDVF4gAlZrDF83seevyK5hFHUAujmEM0A3hz4YOpLG22n0g
	W618A66DXu6FwlnhzbOIVNBSfEo1XkdsMptAADRNVx0PCYyVPjx3EAMu5hv3AzCI9aUvHP9Zqwg
	Pd
X-Google-Smtp-Source: AGHT+IHBTqZsrfOhWGNqWPDYY/6vi9yEHWOfKKWnKF6vRHs27IP0EhPM11dC5+MdFqrIbeXdw1Vfdw==
X-Received: by 2002:a05:6000:250a:b0:3b7:8abc:eba2 with SMTP id ffacd0b85a97d-3b917e9228cmr2317355f8f.20.1755091895331;
        Wed, 13 Aug 2025 06:31:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm39469091f8f.43.2025.08.13.06.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:31:34 -0700 (PDT)
Message-ID: <52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
Date: Wed, 13 Aug 2025 14:31:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>, Julia Evans <julia@jvns.ca>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
 <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julia

On 11/08/2025 22:51, Julia Evans via GitGitGadget wrote:
>   * move "You can also use git rebase to reorder or combine commits:" to the
>     beginning

Great

>   * replace "detailed description" with "simplified description" -- I thought
>     that I could write something that was relatively readable and also
>     accurate, but as usual Git has proven me wrong :). I tried to leave in
>     the details that I think seem relevant to using git: for example git
>     checkout --detach is relevant because it explains why git reflog works
>     well after a rebase.
>   * replace the git switch with git checkout that I'd missed previously
> 
> I didn't use the git log --cherry-pick option in the explanation because I
> had personally never heard of that option before today, and I don't want
> people to have to read the git log man page to be able to understand the
> explanation. I also left out --reapply-cherry-picks just because I don't
> understand the use case so I couldn't evaluate how likely it is to be
> relevant to the person reading.
The use case for --reapply-cherry-picks is mostly that it is faster to 
try picking a commit and then drop it if it results in a empty change 
than it is to do the patch-id comparisons to avoid picking the commit in 
the first place. This is especially true on partial clones where the 
cherry-pick detection is really slow. I'm happy to leave it out but I 
wonder if we should drop the references to --fork-point and --root as 
well given they're also both pretty niche. I'd also be very happy to go 
with Junio's suggestion to replace steps 1 & 2 with a general 
description that does not mention 'git log' at all.

Thanks

Phillip

> 
> Julia Evans (5):
>    doc: git-rebase: start with an example
>    doc: git rebase: dedup merge conflict discussion
>    doc: git rebase: clarify arguments syntax
>    doc: git-rebase: move --onto explanation down
>    doc: git-rebase: update discussion of internals
> 
>   Documentation/git-rebase.adoc | 302 +++++++++++++++-------------------
>   1 file changed, 136 insertions(+), 166 deletions(-)
> 
> 
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v6
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v6
> Pull-Request: https://github.com/gitgitgadget/git/pull/1949
> 
> Range-diff vs v5:
> 
>   1:  c2f2e05078f ! 1:  e7a8fbbe53c doc: git-rebase: start with an example
>       @@ Documentation/git-rebase.adoc: SYNOPSIS
>         DESCRIPTION
>         -----------
>        +Transplant a series of commits onto a different starting point.
>       ++You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
>       ++MODE below for how to do that.
>        +
>        +For example, imagine that you have been working on the `topic` branch in this
>        +history, and you want to "catch up" to the work done on the `master` branch.
>       @@ Documentation/git-rebase.adoc: SYNOPSIS
>        +    D---E---F---G master
>        +------------
>        +
>       -+You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
>       -+MODE below for how to do that.
>        +
>         If `<branch>` is specified, `git rebase` will perform an automatic
>         `git switch <branch>` before doing anything else.  Otherwise
>   2:  5459b7ff560 ! 2:  ad63f69918d doc: git rebase: dedup merge conflict discussion
>       @@ Commit message
>        
>         ## Documentation/git-rebase.adoc ##
>        @@ Documentation/git-rebase.adoc: shortcut for `git checkout topic && git rebase master`.
>       - You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
>       - MODE below for how to do that.
>       + ------------
>       +
>         
>        +If there is a merge conflict during this process, `git rebase` will stop at the
>        +first problematic commit and leave conflict markers. If this happens, you can do
>   3:  948c205f1e6 = 3:  7ee6b0afe88 doc: git rebase: clarify arguments syntax
>   4:  e229b9fccb2 = 4:  4686417b28e doc: git-rebase: move --onto explanation down
>   5:  5ab235b067b ! 5:  9c7f2716bc8 doc: git-rebase: update discussion of internals
>       @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
>        -`--onto` option was supplied.  This has the exact same effect as
>        -`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
>        -to point at the tip of the branch before the reset.
>       -+Here is a more detailed description of what `git rebase <upstream>` does:
>       ++Here is a simplified description of what `git rebase <upstream>` does:
>        +
>       -+1. Make a list of all commits in the current branch that are not in
>       -+   `<upstream>`. This is the same set of commits that would be shown by `git log
>       -+   <upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
>       -+   list of commits is constructed.
>       ++1. Make a list of all new commits on your current branch since it branched
>       ++   off from `<upstream>`. This is the same set of commits that would be shown
>       ++   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
>       ++   change how this list of commits is constructed.
>        +2. Check whether any of those commits are duplicates of commits already
>       -+   in `<upstream>`, remove them from the list, and print out a warning about
>       -+   each removed commit. You can use `--reapply-cherry-picks` to include
>       -+   duplicate commits.
>       -+3. Check out `<upstream>` (or `<newbase>` if the `--onto` option was
>       -+   supplied) with the equivalent of `git checkout --detach <upstream>`.
>       ++   in `<upstream>` and remove them from the list.
>       ++3. Check out `<upstream>` with the equivalent of `git checkout --detach <upstream>`.
>        +4. Replay the commits, one by one, in order. This is similar to running
>        +   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
>        +   are handled.
>        +5. Update your branch to point to the final commit with the equivalent
>       -+   of `git switch -C <branch>`.
>       ++   of `git checkout -C <branch>`.
>         
>         [NOTE]
>        -`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
> 

