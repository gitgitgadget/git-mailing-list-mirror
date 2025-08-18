Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DB251795
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530046; cv=none; b=A32Lio/+zGKxM0lcYC8GdSAlSOBoRq3hKehRIC+gILXqVLbTj0zPaWdomUPt8UQNQSPWHMkZbM1Rajx+nwRRi89aGZV9JbhShuNlyxvBcPE1tdiPNMo/tmMk6sdgz3ZiQ4EHxbTH6PLM3E23wkotG35EevTyyzaM4e3IFNS1W0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530046; c=relaxed/simple;
	bh=owRurxGwr7x8jOftFmNWN8WVdBu1AV7JGER2bMQjKuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=NEFPWHWk27ib3fWBuhLZ/npilo+cOMPbaY3qSk7jeVNcj3aEVZuMgANk9N+rDNWUPBZ8ZBagwsRHQUTMDHReUD20oVdS4VL5X/a1TVWl2dSWdzo/xC65ImlH7mBWdCY7704YQLPJPt7Tp+BCl7Utm80w8zqEXKtv7hYCJrz8r2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZNh97AR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZNh97AR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso34524295e9.3
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755530043; x=1756134843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vLuluzLrcv3jrON/HpoJfpkfjn/Uq8roSnFSw3Cqj5o=;
        b=TZNh97ARfiYI60oAi0zBs5Xo9xmQJzLEOSFo5W3ihXPcY+e7tw3dLiHvHjcXoaU9sA
         Oc+w/wq+PJGmSMP5yAuGD8xng2XE/dInMQba9g6dOTTGjc5Gs2MMneHFKxr/nYoLgBOJ
         Rii/FFQli3aVXC4XGfNYACcIfoMZLk8NG/jMOASrx6goHJfKzJOmSv6m2q7vt2V1dQRj
         Sadwgrls/ZRYprAuzGUvCfLNPsrhuydCxogF3xJmRFE7vDJqPhyzzmKPv/XiIsGXfLAA
         KvnDkSqoGVMlAlNYRvsghTrts9HE+1dfKEWqp+/Wkxb0eVRqc/R5/yuxkKgUPkS1Z/Z4
         bVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530043; x=1756134843;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLuluzLrcv3jrON/HpoJfpkfjn/Uq8roSnFSw3Cqj5o=;
        b=dYRVJsPZA+oVcH6bTatqL/d2uKntnLEB59NpXzGv+LJvInSU7xDLrL0VRV5pXfRR6S
         BG9YPW8Z+NYQC70UxZ2eqH1FlhnoiQnmbtCOhuztXSZqg358WAh8kG2GY/gYvSx2Oa5Y
         OTjfTqV4fDubgi8Qg02Ed52G2zivkQfrYpcEe01bDSry1Kdfu1AgIaOlyKZtcyXGodMZ
         fdKreitpEpLCVkxkQ2qkXV6wPivaj+HVw5+L32z/GgKJHXVbN4rcLVVlq6U/3R9MDIM3
         deZWXea5bjKFMAj6Ut4NS8oSU/2R3zFdaQ6qFxW3s0YEOedIG4Llcq1b7CcE2+aHoh9o
         IK/g==
X-Forwarded-Encrypted: i=1; AJvYcCU2vAeRPPZem6oF+szl2ihtMcndFNfCctHIcKTHpQXD5/e8qiGNbIB2Ri2hq7yjJHZuP50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYCa26hbO1NatV6wT/wQizMbPftMGovp7zUCu+X9NoW4w9cc+D
	wk2Ra23ZNEJmUoGrkHWIB2qdx1mVstyQDpq8/Rv3I94qBqPOfpoUL40A
X-Gm-Gg: ASbGnctBFh5u2t1rFULY3zSYXV+TRSFTyqOSR8dceSTNOkb0zVuaEOWUVsid319oa9E
	Ng6X2a3utebFBrj8/VbG6EH0oFqEl3MQq4KyCtMHCxjjqS4AnS94vhoUripfiNMVeDT3OR0OySG
	wzJh8PH6ZcWB1tsQI6dVY1pgtW0CJptP62CtJ/ThQJsA7u555h7u9CoU/FEoQq7U4orMGK2PA/C
	fBGpdSR4NeKu9I8Jb6iZEehM6JEPVZ8lB5d5dnvmEFJ5gS4iJwaIFSptofRndj8ro9W6pWMTEkn
	3MHmPx2Hl4a+R8l/tZ0k3mrgvMbsWK3PYXKr+nm2YAHZtCPHD/+9HAP4Baq7wB3jUYmCHmdZAHc
	BOI8+lsLO/pgdoKkRZ5x//IQi9kuBcTlNGa+a/4V33T0DzMvK8uJBzUexRzFQ15Q+9ICmfDgoW4
	eQIQ==
X-Google-Smtp-Source: AGHT+IGtMuzzKNCk2ARD+D31P6PqtHZV/vTbNOHkeMBM00yxQmW3wn875OSFDjvu9n4KDQQ0qmezLQ==
X-Received: by 2002:a05:600c:4755:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-45a2674e40amr89752455e9.15.1755530042710;
        Mon, 18 Aug 2025 08:14:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64664171sm13963927f8f.10.2025.08.18.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:14:02 -0700 (PDT)
Message-ID: <63e7901f-4210-438e-9389-8117d5fb83b6@gmail.com>
Date: Mon, 18 Aug 2025 16:14:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Bug] commit cleanup does not happen during autosquash rebase
To: Simon Cheng <cyqsimon@gmail.com>, git@vger.kernel.org
References: <CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <CA+itcS3DxbgpFy2aPRvHQvTAYE=dU0kfeDdidVwWLU=rBAWR4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Simon

On 13/08/2025 12:39, Simon Cheng wrote:
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> 1. Initialize a git repo with `git init`
> 2. Install a custom `prepare-commit-msg` hook that injects some comments
>    - Intention: inject the output of `git log --oneline -n10` during
> interactive commit, so I can see past commits
> 3. Run `git config commit.cleanup strip`
>    - Intention: strip the injected comments too in non-interactive mode
> (e.g. `git cherry-pick` & `git rebase`)
> 4. Run `touch foo && git add -A && git commit -m "Initial commit"`
> 5. Run `touch bar && git add -A && git commit --fixup=@`
> 6. Run `git rebase --root --autosquash`

Thanks for providing a simple way to reproduce this

> What did you expect to happen? (Expected behavior)
> 
> Git would perform the autosquash, while keeping the commit message of
> the squash target unchanged.
> 
> What happened instead? (Actual behavior)
> 
> Git performed the autosquash, but the commit message of the squash
> target is now clobbered with my injected comments.

It looks like this stems from f7d42ceec52 (rebase -i: do leave commit 
message intact in fixup! chains, 2021-01-28) which was added in response 
to a bug report[1]. That commit switched from always cleaning up the 
fixup message to never cleaning it up. I wonder if instead we should be 
respecting the user's commit.cleanup setting. The commit message says 
that should not respect commit.cleanup because we want to use the 
message verbatim but that is not what we do with "pick" commands which 
respect commit.cleanup if it is set. Given that we call the 
prepare-commit-msg hook we cannot be sure that we're reusing the 
original commit message verbatim anyway so I think we should probably 
change "fixup" commands to use the same cleanup flags as "pick" commands.

I'm going to be off the list for a week from tomorrow but I'll try and 
look at this again when I'm back if no one else has picked it up in the 
meantime.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/CANVGpwZGbzYLMeMze64e_OU9p3bjyEgzC5thmNBr6LttBt+YGw@mail.gmail.com/

> What's different between what you expected and what actually happened?
> 
> I expected commit cleanup to happen during the autosquash. It seems
> like that didn't happen.
> 
> Anything else you want to add:
> 
> Here is my `prepare-commit-msg` script. But I expect this issue to be
> replicable with anything that injects comments.
> 
> ```
> #!/usr/bin/env bash
> {
>    echo '# Last 10 commits:'
>    git log --oneline -n 10 --decorate=short | sed 's/^/#   /'
>    echo '#'
> } >> "$1"
> ```
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.50.1
> cpu: x86_64
> built from commit: d82adb61ba2fd11d8f2587fca1b6bd7925ce4044
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 8.14.1
> OpenSSL: OpenSSL 3.5.1 1 Jul 2025
> zlib-ng: 2.2.4
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> uname: Linux 6.12.41-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 01 Aug 2025
> 20:42:03 +0000 x86_64
> compiler info: gnuc: 15.1
> libc info: glibc: 2.42
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]
> prepare-commit-msg
> 

