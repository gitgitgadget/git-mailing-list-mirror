Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F72566D2
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290663; cv=none; b=hN4ZIHbU9jkEqLMr7gM+2m+8y8zHy/GvOmYtWGBoL8Qj9+3L9XjuEPFsGepngAUzvNj2Gf4gyVUPy83vu34CC1rM6EfW13mD0TpVoOCUZUdQcljbDHDdJgKulCz6LLZ6OiLEc/mL0dDOjFDLBJmLjr/WJjVKcJqMmvG16mrpcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290663; c=relaxed/simple;
	bh=e2S6tovS+hkYjzEwjGKLAJ4hCXGfLaioAwqxo8KmcKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPqhmBAqobWq7XsqalK46oP7f1a1a9MGt2RyvHtWKljniTFZcMSbuqqFUbTUruyHM9GZ+RejlBJEdqqwuRkH9rpLwH9ka2dPVEM2BkCLFKz2I8Y47cQmAoh9R/eAZeQCUI9eKBWIfyhdSXK+7JStuLgmF3F3PwkhfLjyq0Pp9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmzyELWW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmzyELWW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46897c60e38so4648755e9.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758290660; x=1758895460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zCapCiGNCnawPdbhFhIo9aSzp0+GD8kPDIV0iuJ0VEM=;
        b=SmzyELWW+rRopSBWXfXKYuLEYs+z4n6BLuiuNPuOfXKXmYh5xl8FAaOJOMbwmLJ+LR
         Kgk0BBLL8dOUOKC4Uar+mp0BPy27+SG3udBMsUObkLU6yBqPolUC3bsEJOusecmt0dSQ
         lesh+cEfn9I7sJRxAYr1n4VI5GwebX6I1CSKbBJOCFhbYfPAWzf8C+tfbxLCTNYl/fdD
         wAnEx/CdBOaSln/T0oeR2JYgV+Ga4bMWsGi+QgF+Xu+Q3c5BeTOi5AzHSgcOnhIU0hkz
         XL4qm7nD/Szdr2sgWD50cgx7/q1oAzAmKUO/Td+R854Cos0RyzzuhN34g02QLdkUhZ4a
         FZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758290660; x=1758895460;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCapCiGNCnawPdbhFhIo9aSzp0+GD8kPDIV0iuJ0VEM=;
        b=rAwr8QXjnBayfoFSaTPNLVjxlgQ0+BSySnHhbPj9hO+loxCse30oj9GO1V+awLhbl8
         eNfWrIVVMwipTqxcZIiTcRYECWKAlW6LZk2r/jtx9Vxsi22qLfMTaw8EH53eTB3RXceG
         FKnxbVDLkL8mekYT9gUUtA9LSkWdpQHMbrjl1PC2UhnZvnKUe+UnJZQDwMxJs9y7eg9a
         yOzDi3K/i53Cksu8Cxbfo3GeZup7xdFvujWcVonlIgU/uIjX7mqysAfwVQnvC7V2heUh
         P7AXuDzLUGSrfGVA0fo5vdFas35EzBci8Trj3xILA2GvreDyrUIFAjSZLPRzzSSHH9mz
         XJHg==
X-Gm-Message-State: AOJu0YymeW7YUZg3clVIdur7R3NHYspsC2Tzx26oAH457THFnOyi+oGi
	XaHwjeXf4DfN5qWhxbRV5y5tUo/x4r0mLQebRUK1TbJeSwKMMRUg3Iew
X-Gm-Gg: ASbGncsQCv6fP9WefjehYrxbAIhR1td5geqq4HBcMro5D7wRFpMQuxq6Lv6WZsAZkaH
	utGcF0jev6bkuIXmK5gDWa9fNqeBFIT+SqqRWhg8NYCpzLbvGfkYvTcsjr98/hURxNBjBaNqSv8
	Lw1li23pjgCX1v7ycwWHwST4rBkxR665E2DFWmyeMCNDj9fu3u4xiSQ8g804b42gWQjtRgXHnV4
	YnGuY1UcmGYV+75ZAh9XvD9skYYrDnFTnQTlIdJ5QEydd2tgaArxZbb26twr1jVxZ+RobnXvksV
	hXTKwUaJ/joiU1UickCYeQdxNFVrS7f0aJCngpU+hFTVjyfguagJ3+hPa1AWHJtxuucX9LVD3Zs
	w1DzPDGb9hcRDuF3UjJ/VfxE8nEahDsNQ3jOLIvCAMBybdN/6sAqB0msBa8Zq0GVxFAsgHZnqrw
	A=
X-Google-Smtp-Source: AGHT+IFA3gyWqfXa8clpD/IIz6wRFgDVrDA2UtOga4p6XgviwbuNVUEAg0K05tP4vBBilCzl64y7LQ==
X-Received: by 2002:a05:600c:1912:b0:45f:28ed:6e28 with SMTP id 5b1f17b1804b1-467ee305892mr28196355e9.2.1758290659741;
        Fri, 19 Sep 2025 07:04:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07408258sm8150410f8f.19.2025.09.19.07.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:04:19 -0700 (PDT)
Message-ID: <adad093d-5129-472c-b054-fb569de9f893@gmail.com>
Date: Fri, 19 Sep 2025 15:04:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git Stash Synchronization - Best Workflow?
To: Brooke Kuhlmann <brooke@alchemists.io>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
 <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
 <7a206ee3-d68b-40fd-8133-79e4c2be7174@gmail.com>
 <FEB150D4-2B5E-41CF-ADCE-93DD0B48D364@alchemists.io>
 <94d614fb-63b8-4733-b78d-b55c482fbed8@gmail.com>
 <E308F060-D39C-4C7A-9F38-2CA33BCE4AB2@alchemists.io>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <E308F060-D39C-4C7A-9F38-2CA33BCE4AB2@alchemists.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brooke

On 11/09/2025 03:22, Brooke Kuhlmann wrote:
> 
>> I'm unable to reproduce this. In the script below the final push succeeds.
> 
> That's because you need to export every time before you push. Like this:
> 
> touch one.txt
> git stash push --include-untracked --message "One"
> 
> git stash export --to-ref "refs/stashes/$USER"
> git push --no-verify --force-with-lease --force-if-includes origin "refs/stashes/$USER"
> 
> git stash pop
> git stash push --include-untracked --message "One II"
> 
> git stash export --to-ref "refs/stashes/$USER"
> git push --no-verify --force-with-lease --force-if-includes origin "refs/stashes/$USER"
> 
> The above will yield the following error:
> 
>   ! [rejected]                  refs/stashes/bkuhlmann -> refs/stashes/bkuhlmann (remote ref updated since checkout)
> error: failed to push some refs to 'https://github.com/bkuhlmann/test'
> hint: Updates were rejected because the tip of the remote-tracking branch has
> hint: been updated since the last checkout. If you want to integrate the
> hint: remote changes, use 'git pull' before pushing again.
> hint: See the 'Note about fast-forwards' in 'git push --help' for details.
> 
> However, if you perform the above with only the single "git stash export" then you won't get the error as you discovered in your workflow.

I'm confused by this, here is the relevant part of my script again

 >>     git stash push
 >>     git stash export --to-ref refs/stashes/test

This is the first export before pushing

 >>     git push origin refs/stashes/test
 >>     git stash pop
 >>     git stash push -m message
 >>     git stash export --to-ref refs/stashes/test

This is the second export before pushing

 >>     git push --force-with-lease --force-if-includes  origin 
refs/stashes/test

I'm afraid I'm struggling to see what the difference is.

Thanks

Phillip

> The only way I've been able to make this work is to do this:
> 
> touch one.txt
> git stash push --include-untracked --message "One"
> 
> git stash export --to-ref "refs/stashes/$USER"
> git push --no-verify --force origin "refs/stashes/$USER"
> 
> git stash pop
> git stash push --include-untracked --message "One II"
> 
> git stash export --to-ref "refs/stashes/$USER"
> git push --no-verify --force origin "refs/stashes/$USER"
> 
> Notice that I always export before the push AND that I'm using `--force` each time. That's the only way to ensure your local stash is in sync with the remote stash.
> 
> You can always verify that the remote stash is being updated by always clearing your local stash and then immediately importing to check if your stash message was updated properly. Example:
> 
> git stash clear
> git stash import "refs/stashes/$USER"
> git stash list
> 
> Once you perform the import, and immediately list what's in your stash, you should see something similar to the following:
> 
> stash@{0} 6ba4eaea3751 On main: One II
> 
> When your remote stash isn't updated, you'll see this:
> 
> stash@{0} 6ba4eaea3751 On main: One
> 
> (Notice the difference between the message of "One" versus "One II")
> 
>> You can force the creation of a reflog
> 
> I tried that too which makes the error go away but doesn't update the remote stash at all. Example:
> 
> touch one.txt
> git stash push --include-untracked --message "One"
> 
> git stash export --to-ref "refs/stashes/$USER"
> git push --no-verify --force-with-lease --force-if-includes origin "refs/stashes/$USER"
> 
> git stash pop
> git stash push --include-untracked --message "One II"
> 
> oid=$(git rev-parse --verify refs/stashes/$USER) &&
>    git update-ref -d refs/stashes/$USER &&
>    git update-ref --create-reflog -m 'export stashes' refs/stashes/$USER $oid
> 
> git push --no-verify --force-with-lease --force-if-includes origin "refs/stashes/$USER"
> 
> The above works but if I run `git stash clear && git stash import "refs/stashes/$USER"`, I find that my local stash doesn't have the message change (still using "One" instead of "One II" which means the remote stash never got updated).
> 
> Sadly, I can only seem to make this work when using a force push but would definitely be nice to not have to use a force push.
> 
>>
>>     set -ex
>>     dir="$(mktemp -d)"
>>     cd "$dir"
>>     git init --bare origin
>>     git init repo
>>     cd repo
>>     git remote add origin "file://${PWD%/*}/origin"
>>     git config core.logAllRefUpdates always
>>     git config remote.origin.fetch refs/stashes/*:refs/remote/origin/stashes/*
>>     echo a >a
>>     git add a
>>     git commit -m a
>>     echo b >a
>>     git stash push
>>     echo c >a
>>     git stash push
>>     git stash export --to-ref refs/stashes/test
>>     git push origin refs/stashes/test
>>     git stash pop
>>     git stash push -m message
>>     git stash export --to-ref refs/stashes/test
>>     git push --force-with-lease --force-if-includes  origin refs/stashes/test
>>
>>>> You need to pass the name of the ref whose reflog you want to look at,
>>>> otherwise it defaults to showing the reflog for HEAD. You should be
>>>> able to see the reflog for you exported stashes.>
>>> I gave this a try and every time I use `git reflog refs/stashes/$USER`,
>>> I always get a blank response. No errors and no output.
>> Ah, I wonder if core.logAllRefUpdates only affects the creation of new
>> refs. You can force the creation of a reflog by running
>>
>> 	oid=$(git rev-parse --verify refs/stashes/$USER) &&
>> 	git update-ref -d refs/stashes/$USER &&
>> 	git update-ref --create-reflog -m 'export stashes' refs/stashes/$USER $oid
>>
>> the same applies to refs/remote/stashes/origin/$USER
>>
>>>> Let's try and find why the remote update say's it rejected when it isn't
>>>> and then we can think about the best way to document pushing and
>>>> pulling exported stashes.
>> I haven't thought much about the pulling side of this. "git stash import"
>> appends to the existing stashes so I'm not sure how we'd cope with forced
>> updates - have got got any experience of handling this from your
>> experiments?
>>
>> Thanks
>>
>> Phillip
> 
> 

