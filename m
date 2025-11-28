Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CB823DD
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318257; cv=none; b=FXedhQ8zBH7yg8pA+fonfmSOslDFOQocWfl5Ho1rNnhmr5QNnoUAS+x5j3ZYPid6CeUKgNv0e9jJej/qc3m8qX+uQo3sTFr3J+M2MMn1HdGS7Qw8l+nl0RYipxG3+YXyAmdh9c5rgr03CdDzXAqsqngu+NfbIqG+Ehm3VMrG9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318257; c=relaxed/simple;
	bh=zK4WNbL4j3JmdsD8D7Fv+JWmGsoH3UfV6x+bw+5L+H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h80SkiaH6x5neBHiP3AOrcCMEBcorzznrZghr0OcQgr48owxRTF/7carlsiFnvnREWXHY3U92rGocLcP0Vr/Elajmw7Ioqhed721KFK/Pt5UWILgYWy+w+YflpUgaud6arzcgR49aJ9r00dGVsuimxCFOwnWQGjzsO9hcQ/EUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWCKt6VK; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWCKt6VK"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29555b384acso18727135ad.1
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 00:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318255; x=1764923055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgGgo7lNtzXEeWDx8mjoBQo8rZR7899FIhWSDkPhdRA=;
        b=eWCKt6VKBOablriAxt/TeSdRduxctZELZiLu6Cda+aJdFMPWEXsT/kuq0maUZ8Qy7W
         ER9pJ523u9CFUi+uu9lsAZi12b4T6ImKgh09Obf1aacf9evV+aad+2Tn1zHt5ap7JJTD
         bYffyKpanHFRP+vkD0HL6dpaPyOCkalVfxj9CSpc0epHDIwpAZFaL23IwIGiJ1XHnzUm
         7oh6bjfPwlXkKKO0IT8u/STnCFtvXXPn5bMIQU+DpAxFuOtmrFWA3+6x9QZNL3nTKDIT
         7sXk35NrZIZ8Cu0FPsYwU2DMCORIZa3p6kLrpX7HtNGcBUQEGEUV3fHPw6vmk5a8+VSN
         021w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318255; x=1764923055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YgGgo7lNtzXEeWDx8mjoBQo8rZR7899FIhWSDkPhdRA=;
        b=MC8Dx0riY4JChgauxRtNIApuaRoVdTjPOAsBfC/U7Hz4EwkKHBiXzghja9eND0QUQc
         RT7rfO0AhSQqujdD3YNyp7S0fH6kTWLuy6ScvbSn34bwMpgnv4jo/uWNb70cHBt9SZIE
         0Zshc+Rt4zW+DnbptCYaSbBQpqlnXXZ5mwq8XhxSsQ9zDhc+MKJGydpulcFUC/44klYV
         DJwHak0+n55Fys9tzMo34Szzt/gvP1+n4a6IPpr5zgjFIzi3ce45tUqpd2kTXm00u2d8
         amvAIe6tmg9S0987ua3zj8wzgJZexRdOiX3dbiVyPaClbdbMQ5y4YNK4Qb5ux4zWamNc
         Rj7A==
X-Forwarded-Encrypted: i=1; AJvYcCU9pPaAcGIlbFfohRX+ckv8ubcKQOmoRnh78YzRg7xWfUrVWMo0N/nolhHs+yiss29CW1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyM8oEvxoLnO0SfqFhhlaSko2Z2bw4HDgi20ToKsQxYdSvplfr
	K3jmgWx7gBQZ4Fjxyp5jAjfVUTim0gZH/YJ725j+mLJX9RILNWb+VVI2
X-Gm-Gg: ASbGncscSPWN5h0JHRgOrgXdLCznd3goC5lVm0M5LObPRKQ4wr+jN4OXpPHcL7VEY0s
	GDSGBVzi5A5fRLdXxI3Vhbftoc1Eqax5hQgMse0UQZm73GG6SjMC2Ilae8M8aW2K5k/2Pfxq4v5
	K2jIQ7O24ZH1q5ndoALw0JbkryHvbW5MAHOjRZycQGeamHA2qZ44rIusEMEqObnC1ldyV2+qAh6
	dk0RIwWLYL+4djYNKJQLIzEvXrjzDYLngbZnl5p/MduJFg+qT6Hs4PbXKPXNwZdOxEN59QepMCl
	fpahk8Vcgm1sE/2EoHkueifgi42qDU0fj5vBmSinuOBAhU8WywyfkcZqhx2x8kswyhCjigMy9C0
	UFmSO17CkzvQ49JId123bATCrkryHfX2M2lN9EJZM+EH62sSV34C0UgmAJmLHEGAjAMzWabTGGl
	Ygt5MQMILAhf3ksUsOaCSwCc3XjxCskvmB7gyQFmJaA/j2TnpncAGoHQl9LJSW/fTjT5a+XnbUw
	d1U7VQgSEWTzdfMaZd6yQo=
X-Google-Smtp-Source: AGHT+IE926DHVxsC2FddqZa8aJRDXOuAHZIwkMzPVFFbW4k7TTfZPjGcNzcSthJHjxLxOXVstxaKcA==
X-Received: by 2002:a17:903:40cb:b0:295:5945:2930 with SMTP id d9443c01a7336-29b6c3c2b02mr295240395ad.2.1764318254776;
        Fri, 28 Nov 2025 00:24:14 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:7804:9774:f26c:920d? ([2409:40e3:30a4:b776:7804:9774:f26c:920d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40ab81sm38421345ad.3.2025.11.28.00.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 00:24:14 -0800 (PST)
Message-ID: <c930d6df-5dc4-401f-a9a1-eb2f00b2e837@gmail.com>
Date: Fri, 28 Nov 2025 13:54:07 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
 christian.couder@gmail.com, ps@pks.im, phillip.wood123@gmail.com,
 phillip.wood@dunelm.org.uk, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
 <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com> <xmqqcy54mro6.fsf@gitster.g>
 <fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
 <CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BFsDJVtR6RV8KugCW2vmbD1=rTOKLp2jeawRfuPUEsNEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 28/11/25 13:37, Elijah Newren wrote:
> On Thu, Nov 27, 2025 at 11:21 AM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> On 27/11/25 02:34, Junio C Hamano wrote:
>>> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>>>
>>>> 1. For quick undoing an entire MR, the `merge-tree` approach you
>>>> suggest is indeed more efficient and avoids unnecessary intermediate
>>>> conflicts.
>>>>
>>>> 2. For commit-by-commit reverts, we need individual revert commits with
>>>> proper attribution (which commit is being reverted) for auditability and
>>>> history clarity. This is particularly useful when only specific commits
>>>> from a merged branch need to be reverted.
>>> These are both good workflows with appropriate uses.  To make the
>>> tool useful for #2, it needs to be able to allow "I have merged a
>>> topic with 7 commits, but the first commit and the fourth commit are
>>> faulty and I need to revert them", i.e., not just a range
>>
>> Since replay uses the same rev-list machinery as `git log`, users can
>> already specify disconnected commits:
>>
>>       git replay --revert <target> <commit1> <commit4>


Hi Elijah,


> No, this command does not specify disconnected commits.  A <range> of
> "<commit1> <commit4>" specifies all commits in the history of either
> <commit1> or <commit4>.


You are right, I misspoke. I was conflating the command-line syntax with 
what the revision machinery actually produces after prepare_revision_walk().


>    Thus, this example command line would be
> asking to revert all commits in the history of either <commit1> or
> <commit4> (all the way back to the initial commit), rather than just
> reverting those two commits.  This is just like how
>     git log <commit1> <commit4>
> shows all commits in the history of either <commit1> or <commit4>
> instead of just showing those two commits.
>
> There isn't really a mechanism in replay right now to handle a
> disconnected set of commits for either --advance or --revert.


Right, the check at line 190 in replay.c:

     if (rinfo.positive_refexprs > 1)
         die(_("cannot advance target with multiple sources..."));

fires before we even get to the revision walk.


> If there were, it'd probably look like
>
>     git replay --advance <branch> --no-walk <commit1> <commit4>
>
> but the code isn't set up to check whether you specified --no-walk,
> and thinks "Um, you specified multiple branches here and it's not
> clear the order in which to cherry-pick them" so it throws an error:
>
> $ git replay --advance main --no-walk Commit1 Commit7
> fatal: cannot advance target with multiple sources because ordering
> would be ill-defined
>
> If you comment out the relevant check which dies with that error, then
> you end up in some codepath that segfaults instead (not-properly
> initialized commit/tree objects or something?).  I'm sure that could
> be fixed, but "users can already specify disconnected commits" is just
> not accurate.
>
>> I will add a test to verify this works and document the capability.
> Supporting --no-walk so that folks can do disconnected commits for
> both --advance and --revert may be nice, but given that it's missing
> for --advance already, it might be considered a separate change from
> your current submission.  I'll leave that up to you.



Agreed. I will keep the current submission focused on basic --revert 
functionality. Supporting --no-walk for disconnected commits (benefiting 
both --advance and --revert) would make a nice follow-up series.

Thanks for the correction.

Siddharth

