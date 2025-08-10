Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7BFC0B
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840525; cv=none; b=Cf/dkNtfwCdWU2Tc8RlW38jjGg3oYvQgmQlIh2qUhkbFKnCH7PN75zsvYK/MzVtVgLfyWLnDEKrC51LCPqcM5ee8DULlm+ApM6docHpG2vEP/svye7XnKEthZmhec3QcSnYWbJacPlJxKPW5K5fxTAFcI6O36as2G3tyHeKO/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840525; c=relaxed/simple;
	bh=1JwbwufjAOYRdA0qA75f758KJAjoIhr0uDtF4l6dOrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0Zb0fCMsDoQvvP1eMy+DEcupTRlEE+FtGMap9WJL8M5S1dXfwOhP1tuobexlz7dufYcnQe8fSmIdeL9B8CTBeA28n0zlmgrFu1LUod5MSHRksRoewvS8bGYIjOYZzwOKgvAdfNKwaOYznZCi0wSIdLJTjUmxqywcZkWsaTNoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UehwM9RL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UehwM9RL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so33760225e9.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754840522; x=1755445322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlQxNFtS/auFT65v01053t8cOc55xY0PFYtD0mc6Dis=;
        b=UehwM9RLgMV4Pn0fLBtuzSMfPjaa17VZfvyyc1HbpSiFmJhpeD173yu6SiIkBZwo7r
         9AIriMxM8daBDys+hFFLARC5ld3BaIfRS2NSOWme/+74zy603fTwyTeHWaY8+3xbE67s
         WxveQbUme3+w9unFkhgk1CX9VKR/MGPfYWtiA/xdhMmuiafdRifULrLu9XzdeZ4oYNBN
         Q9WjtO8kwfUI9HRrBjb2OGcUFu9jYKK8pyolQd9So05QSYjhePNzq8NSxBzzZvOAV0/0
         GfP/KUecrFZIVHtuzhB/62PoS90cd+WFcybx0iZaKpPOV01WJHQ/nlHTU55RrhPYZCmF
         P75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754840522; x=1755445322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlQxNFtS/auFT65v01053t8cOc55xY0PFYtD0mc6Dis=;
        b=XanyPuKcy8YQ4rPkWx4teUxmhAsv8UXk3eLTe+5s/KJ4ajQPEKkPeW+C9LbXgP4sw0
         ODGFLIoPVr6ndL+cKBmCbTysCmT9+dh1CopwO2fAisOIDRZg/+LILaJDtSZtzcRxhA2d
         /pImlpunExXLOqFCfMUTcU0BMM7fhOQ8bfe/eQ9H90E8cz2nu4mZidHZVsrpBInVypHr
         MUkA5JeBv1NeyZdyLVTbTXPZ4/DhYw/xc8wPLTzV8KJZ0jWzLEul80shRWNExh8yWudv
         g3giS1XzGcTnqwg84uc4pJ4xRuE9tYHxU4CIb4+xFZKqBx/qkQCh3DE63xAVbC9a538f
         wuyw==
X-Forwarded-Encrypted: i=1; AJvYcCVWmomar6Gb2qwGqPC06m3vSTrkxw+OnK84oPMwHniXa2mjYSBC43taJDLcLoocwFLr/dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweqx8fxJwdRbS0e+K6P7EphvFG1qwA/keMmeJYJ/8rtcBjmDp3
	TQSUoAvV83YLljtfIW4Jc22EHqE5DUkdbm6z3X4KNN0G3RC8nqYalKj2
X-Gm-Gg: ASbGncsjOX3B3mLxRCZfzm54czfsAX2Z2zuJ5njA1gMGsdbj3uSyf/mOhi3l7bvYNGy
	hPIRISbQ1oCS36IFmm/IqOdCkStCAm/ysuJykmarv5ymhTOzoxTLA19Y6AAQT0eiVmYFDLTYEHu
	uwhp966kEjFB0I4AK9fU/GKL3O/VdJgJnA2Xm+y+vAy1JnTPhuUKl0crEDhNQCKov23bAx4yDtL
	aFjDFiebFAAOVOxm9ebxo4AG27I54CyFLBILAzLCjZOfqWg1gtTdqhPRXQzyy+bcEsMl5GakcPz
	8MvHCe+vWB/cwzxlGDtpEEx17Rt6546At8oh75/JbzXdbSlA5vRAElM1TjfPUZcr8SN5DHYlhSz
	eUHnoQfb9Rj6JeE0zHwXt6sHwxpuYitV3mk3A/jfsLCRWHdcZa0jOzlMRY1VMVKQdoZWaGgpSkI
	qu
X-Google-Smtp-Source: AGHT+IEBat/trL6G7pR7IEUwN8V0jP15OXbqLkAhctoCkcEaA6xoEWAnZMBCsqSW/BpAFQP81nRwcA==
X-Received: by 2002:a05:600c:358a:b0:456:1ac8:cac8 with SMTP id 5b1f17b1804b1-459f4ec638cmr99948855e9.15.1754840522021;
        Sun, 10 Aug 2025 08:42:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586eef8sm214276055e9.21.2025.08.10.08.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 08:42:01 -0700 (PDT)
Message-ID: <10372e00-3bb1-453a-bb62-332aaa935b24@gmail.com>
Date: Sun, 10 Aug 2025 16:42:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/5] doc: git-rebase: update discussion of internals
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <105a65e6e7121ac6a9a8a1d0b4f3217495a9f5e7.1754702057.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Julia

On 09/08/2025 02:14, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
> 
> +Here is a more detailed description of what `git rebase <upstream>` does:
> +
> +First, it makes a list of all commits in the current branch that are not in
> +`<upstream>`. This is the same set of commits that would be shown by `git log
> +<upstream>..HEAD`.

The existing text is not quite accurate here, it should really say `git 
log --cherry-pick --right-only <upstream>...HEAD` as we drop any commits 
from the branch that have already been cherry-picked to <upstream>.

> You can use `--fork-point` or `--root` to change how this
> +list of commits is constructed.

`--reapply-cherry-picks` also changes how the list is constructed so I 
think it would be worth adding that option here as well.

Thanks for working on this, it makes the description section much more 
readable.

Phillip
> +
> +Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option was
> +supplied) with the equivalent of `git switch --detach <upstream>`.
> +
> +Then it replays the commits, one by one, in order. This is similar to running
> +`git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
> +are handled.
> +
> +Finally, it updates your branch to point to the final commit with the equivalent
> +of `git switch -C <branch>`.
>   
>   [NOTE]
> +`ORIG_HEAD` is set to point at the tip of the branch before the rebase.
>   `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
>   at the end of the rebase if other commands that write that pseudo-ref
>   (e.g. `git reset`) are used during the rebase. The previous branch tip,
>   however, is accessible using the reflog of the current branch
>   (i.e. `@{1}`, see linkgit:gitrevisions[7]).
>   
> -The commits that were previously saved into the temporary area are
> -then reapplied to the current branch, one by one, in order. Note that
> -any commits in `HEAD` which introduce the same textual changes as a commit
> -in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
> -with a different commit message or timestamp will be skipped).
> -
>   If the upstream branch already contains a change you have made (e.g.,
>   because you mailed a patch which was applied upstream), then that commit
>   will be skipped and warnings will be issued (if the 'merge' backend is

