Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429F3A6B83
	for <git@vger.kernel.org>; Fri, 22 May 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443268; cv=none; b=lfvv5CobtADeJRFyFvw+Kiw2OmAtvPWo04XCaLJqJGum8l12cKfpTjIMRkuQft8mH8DrpURbExQ0f9d6PnQkGDGCxSSQn2Hz+vPjZtJEaK7AcHHPwGh6Z4/ZSr0qZ44k4+5HwSHnNDUpGx5wa6HfOVNs6LwsDxLN7haOer9Lj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443268; c=relaxed/simple;
	bh=6+uNkIDzV5KLi6R3sNBWWgbBjs/spz+RdeorFbEK6q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Npk0N+CbucgaFdW4JJFXHo/ZjAVMALCHup6oQ9QaeWenWHW9rEiKKBMH5zEKJmGX9xtcGET+iFrRdyA9G3WmOzdBfeKOPWwZfjBbWsCp2WMQ9svU/s9ZkbzatgPZn56b9XgkLKU15Do58Efv55jWicQx7M9AMGvdsOg0ghvrgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFJugXBE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFJugXBE"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44a14580111so5451253f8f.0
        for <git@vger.kernel.org>; Fri, 22 May 2026 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779443265; x=1780048065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6luNQ3vbZp0gppRMmaDqs3TsCp2V9snd/4a+KVoTTag=;
        b=dFJugXBEn9uR4OCEdgFuVYoCN5XQBf425OvjehO4COcnk9idkUTdi5Lgd/9bdM5ZLg
         600ac80fP1NUAU0u08QMfdqR9/LXWnGLzip1nmHqpyrMHJnud/lG2R+grnt4JSvsIOgr
         wWESgiigw4b+SU3zQqFsUOOEeCnxRQGdkEG8fn0J7jaqqMCaNdvc+Fepiy9B/2QFDkVa
         AxtTaPAWRrlnLdqmkpHCJzT+Yxboi3awjNKr9on6NEM6UMxRdanknyEj7c5enmC1pmDy
         +oi4fDX+XhW5LoL5rbbHZjAVxkPHuAurdiIH0+1psM6i8xyJojGthrGLxrjNNDwoRT7t
         gbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779443265; x=1780048065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6luNQ3vbZp0gppRMmaDqs3TsCp2V9snd/4a+KVoTTag=;
        b=F5ugnwYMl2MEQlnY0LRDi/yMrhI06mM0aWyeMvkCbDKUMFaW75AlDnr6HcGJP+tW/Q
         AvM97x/UuSXZ3v7IiMCgNLjuDpvK9hdesBu8pIV6h5/ZgYMm5+Csal5Rd6dtu64vqeUN
         H+homlJzFaS2h6QEWaAm5wm+m/YL1yyWW3++8lNpBxVDqSrjR3ipcJTz6ZLA99J2tCJT
         ccO3ZThVoYtmK4Z2fH01t1uJYCNKRUa+C3f/sAFy69rxor+vC6Pv810UDUT9clfXFx9b
         mRzR7pkBrjfV7AHpw9x+d/GZrFrkWtQs/PfmkG+8XO5B2pTjyyM1Vo0vrOyobFMt+6/S
         oRJg==
X-Forwarded-Encrypted: i=1; AFNElJ8leBpTE2KzOO9Bp8bYpafI3MkuJHJdWmZKWhtokHSyMZ3mM8KAsIP2kIbtqPbE0EH2Y+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcyP7+HRXcYr6g9kwBqQJOBQBnQi4+vfFINP5bt79H+1Bulmx
	OxvDNtPubmhch3iOK0aoRl/+T7YeCkCxYEm664TOhQ2X6le/5AlMANkx
X-Gm-Gg: Acq92OEo0Lq/g7n1dThf79r23V53O7hDxNCZ55xp3MBLjkF87UbWNaU2ZKVGrk3qZI4
	irnqjqjwcWnWcUWW/JQlhrPwektK5vxOjGuLBbqLrgaQW4GUfgsxb2EHTIP2lvmqdpwjE0MMzJH
	c7k14tjC9yEErITqVJqlYQxx3htYx+MU8Zx55i6+IWvLxN2MvqIONllAx33lP0/Hrg7G4rZSHvr
	RNysxKZPr1JXpLFFleCIiXkVmJpwqKGVxWiBaHDokCEMFP5e1588wDN0skqQHpq5wOymn4Vs7oM
	ift7iYrCHQ8PMMPf06KO/W8th2k3X0JmiGwJnDoc/GvH9S81fcCzXE60RLzGYtEI9q2u1Nx5e61
	KzaviboOBxcTFLHzxul/BsOol7e4oFyesj3L2KZyVWzi7zRsYP+Jr5vLQr+K5XxWnk7mBrAtpKk
	74rQtEyicLB7V4mFZDFjCXeqmXOqeFbDCLXCEHz2a+nzvHSEBkqdI1xcAYksaOrPFdvPPcVK17r
	lf8LjFbF+DDXaeHMTK+76tB
X-Received: by 2002:a05:6000:26cf:b0:45e:b215:12e9 with SMTP id ffacd0b85a97d-45eb368903emr3924610f8f.6.1779443264696;
        Fri, 22 May 2026 02:47:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d47b82sm2688781f8f.19.2026.05.22.02.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:47:44 -0700 (PDT)
Message-ID: <6ae90274-3fbb-4d2a-b0f4-cd9260e4d6b3@gmail.com>
Date: Fri, 22 May 2026 10:47:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v9 3/5] branch: add --prune-merged <remote>
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v8.git.git.1778605658.gitgitgadget@gmail.com>
 <pull.2285.v9.git.git.1778700883.gitgitgadget@gmail.com>
 <f87e96e99d64c48bd92afecf3a6a819d36e56f6c.1778700883.git.gitgitgadget@gmail.com>
 <6501a3d5-a5ec-421b-8526-ee7d4ae5ea98@gmail.com>
 <f1d15d08-6fee-479f-8ed0-34efd256d8dc@gmail.com>
 <CAHwyqnVhhwT80Ao+7QLUAsTnUJaN5vE=ZiaxeqF3rYxxiD_Qww@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnVhhwT80Ao+7QLUAsTnUJaN5vE=ZiaxeqF3rYxxiD_Qww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harald

On 21/05/2026 20:16, Harald Nordgren wrote:
>> While we want to clean up topic branches, we want to avoid cleaning up
>> branches like "master" which follow an upstream branch and therefore
>> look like they've been merged straight after they've been pulled. So I
>> think as well as checking that the local branch is merged into its
>> upstream branch, we want to check that the local branch is not pushed to
>> the upstream branch i.e. that branch@{upstream} != branch@{push}.
> 
> This one I handle already by letting the default branch be guarded.

I used "master" as an example of a branch name above. There is no 
guarantee that a remote even defines a default branch, let alone that 
there is only one local branch where the its upstream and push 
destinations match. I don't see how you can avoid checking that the 
branch pushes to a different ref than its upstream and still be safe.

I'm going to be off the list from now until the week after next, I'll 
catch up with this thread when I'm back on line.

Thanks

Phillip


> 
> Harald
> 
> On Thu, May 21, 2026 at 11:46 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Harald
>>
>> A couple more thoughts ...
>>
>> On 18/05/2026 16:27, Phillip Wood wrote:
>>> On 13/05/2026 20:34, Harald Nordgren via GitGitGadget wrote:
>>>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>>>
>>>> Delete the local branches that --forked <remote> would list, but
>>>> only those whose tip is reachable from their configured upstream
>>>> remote-tracking branch (branch.<name>.merge): the work has already
>>>> landed on the upstream it tracks, so the local copy is no longer
>>>> needed.
>>
>> While we want to clean up topic branches, we want to avoid cleaning up
>> branches like "master" which follow an upstream branch and therefore
>> look like they've been merged straight after they've been pulled. So I
>> think as well as checking that the local branch is merged into its
>> upstream branch, we want to check that the local branch is not pushed to
>> the upstream branch i.e. that branch@{upstream} != branch@{push}. That
>> should also avoid deleting newly created topic branches that match their
>> upstream (I think that's probably less likely to happen in practice as
>> I'd expect the branch to be checked out and therefore protected against
>> deletion).
>>
>> Also as this is a destructive operation (there is no way to restore a
>> deleted branch and its reflog) it would be good to have a --dry-run option.
>>
>> Thanks
>>
>> Phillip
>>
> 

