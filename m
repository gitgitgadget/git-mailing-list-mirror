Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E3258EED
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930987; cv=none; b=UAxzebzvIZyoQbtnO+s61GQZUQtH4MOr8NaZ1hCO1SK8oEgp8zE97v6SgAJdJcEMrl+2QnWK29PKw70WZtJUVPp9j4utxMwxIZxBnPHEd9YdhXmALNhvwvUW06gOFcPIY253vFNQjsWUoyD6r590hFd0QcCiqwjA1da9teZBZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930987; c=relaxed/simple;
	bh=Rx0Pq57QuCMORGAMJZ4wcJ21ErFS+wEVeTzeadaG70o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlmZ5ksLR6YjR2uBsG5Cv13TqABvAVlrV3Em9/E5av/IotTFHcl7hOtaE1Hjmo08V5TyWjHT7whAGySne2DFCU+vZ7P4jyaQbr5SZ6WciDEmA42bMM1OgFGQVl0Tfrre37B3Yn80s+tNQW+tqhUaFe1R8OT+vwlxulf1A+O8lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOxXhRVy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOxXhRVy"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ea115556b2so736579f8f.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757930983; x=1758535783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XDCk+fSFRyRbbn77WNlKnFlSR4gOi6CaQ7tfXqiiqRk=;
        b=FOxXhRVyYIGyFp1MSIlhsbxWiETZaf1k0XlINTQ4zcidvHpEsXTY+BuRFBQbvB3VOK
         SzHpSQrjbw1WdIIGqi2AUWsCUrEkPlapdteekJ/oi1O1tZ5N2H+/lgqE6daulI/kAq8T
         EsJns0ppmYmrp40f2PVpC8Gv+llQmsKm9URenqE2SfFa0x9bA0lAljlJrDLXXY9GG8N8
         C/mAKgcjwbtbexq0Sn/RruCS37PJESc+povsSU6iGNQnIbxgrYT+Unxp89nBXKgI94Em
         ueHWbEra4OVx2x53yKokZjwwltl84uxx2P8M7mUm4TdvSqJVi9kZAS45dFczE55jEJq6
         EHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930983; x=1758535783;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDCk+fSFRyRbbn77WNlKnFlSR4gOi6CaQ7tfXqiiqRk=;
        b=VMhsiBnWtlymV6R9WypiPvOB1DfQWz9k9ONyNcffQu3f7/uS6g/u8gAuG6onIcd2a2
         JZ8SfR8b+UfZyjAlP6xVhUK1wnqcrO38Mb9loIIMbCGi3/zgkIebYAw50XDQ+xrf36wd
         3Da83AUkDobBEUktkwdxdQQiRUhNiiOanx8rINvkr8NKOMyibPP8bsDOfaWVkKY219kP
         2+rwPplDJ2Rsj1kvSV95t5Wf7iFUiCN3hKtteiTNzQfqoAc3vf85UoxLpnR1qcRDuwUN
         qIgqCEqf6KZbwmLbst6TB3WwKiY0Q8zvdN9mI7t4019zL0xpQPQtfbsefmj2s47kRTab
         ZNew==
X-Forwarded-Encrypted: i=1; AJvYcCUBQv3gVPv+fMzmTC6K7bjqMdDTiedWd8pqIKaDGwuUvUGRB2f/XMOCxB+1c5ldRVkfbTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8hiYcGoKC7WKRzQbkKXNZBFaV9se59e4AYz9uLVGKv1a2mSk
	90GZBuoxCN6i8QaAAz8jYJgKVg7HXry7+9lA8LhpdqIX6pneOM281nkz
X-Gm-Gg: ASbGncuYBhTQ5l1jCK+ui+C86GaWVae3D9n4wjp3ydqBqvsfMgBFVzvEPtWQICl6q6I
	21MV8zEKL1RLV4tA1f65YOUj0ZqxXXXlVejql4fd8ipAJq4dIZX84Ud+8WKjAZWnFI5MCetHfU+
	d3pu+OEdQcnAXxNezOyIBvSmjQTfX9lVgSM73HJbYxU4NOCFPooeTkryY00Bubn7GcYKL6+6cQI
	/d1rebvTQ7inwaNVd+Z6mrcezQ+f4j1oFAO+wz83SJ1Wkh4kjQSFgls2mxzsa7w6CrI1awGjk5+
	nvF+Q8nTlAE/4T5Qtlc+7+fwBYAQNpTDt7xCcH8PbLiF/EK+yP3egqwGpCM2cPhZuoklnnh9hMf
	kTbwSfCt8tnsrnvM1Xjo2VytMdLbA3gMIAv/Z7UgwDptiVa4o662Rs4bbUxA+ioVhr5dLM0hYup
	175Bw8NfFNog==
X-Google-Smtp-Source: AGHT+IGunyTwWdD8ebNnBhkm+yi4qBPNlzDRUhRJxuLBVBYZqKMSOc7fUqKfNQVFzRALolHbgCYTZw==
X-Received: by 2002:a05:6000:310d:b0:3c8:7fbf:2d6d with SMTP id ffacd0b85a97d-3e7659f4128mr8301440f8f.50.1757930983340;
        Mon, 15 Sep 2025 03:09:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9996f384bsm6546797f8f.56.2025.09.15.03.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:09:42 -0700 (PDT)
Message-ID: <c7f9da8f-61ae-4ebe-b09e-a0c72f84a334@gmail.com>
Date: Mon, 15 Sep 2025 11:09:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] extend --ignore-other-worktrees to 'rebase', add
 hints
To: Gabriel Scherer <gabriel.scherer@inria.fr>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gabriel

On 13/09/2025 15:13, Gabriel Scherer wrote:
> The old 'workdir' contribution script was removed from git upstream in May
> 2025, as it is largely superseded by the 'worktree' command.
> 
> One significant difference between the old script and the command is that
> 'git' refuses to checkout or rebase branches that are already checked out in
> another worktree. My understanding of the reasoning is that users may be
> surprised when a clean worktree becomes dirty as its index is changed from
> another worktree. However, this safety net adds a mental burden to worktree
> users, as they have to keep the other worktrees in mind when moving
> branches. Old goats like me who are used to the old 'workdir' script find
> this restriction somewhat painful.
> 
> See the discussion thread
>    https://lore.kernel.org/git/5580aa89-09f1-426e-8483-c99481c998ab@gmail.com/
> about this transition.
> 
> The present patch series tries to provide a smoother migration path for
> supporters of worktree independence:
> 
>   - when 'checkout' refuses because the branch is used in another worktree,
>     display a 'hint' that mentions the possibility of using '--detach'
>     instead, and the '--ignore-other-worktrees' option to proceed anyway.

I think this is a good idea, though I agree with Junio that we want the 
hint to be a bit more explicit about where using --detach or 
--ignore-other-worktrees are appropriate.
>   - add support for '--ignore-other-worktrees' in 'rebase' as well, with
>     a similar hint.

I'm less convinced this is a good idea as the rebase command updates the 
branch which is going to be confusing if the branch is checked out 
elsewhere.

Thanks

Phillip
> In the future I would be interested in adding an option
> 'branch.ignoreOtherWorktrees' to be able to ignore other worktrees globally.
> 
> Note: this is my first experience submitting a patch to the Git project, so
> I apologize in advance for any mishap and welcome beginner-level feedback.
> 
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: D. Ben Knoble <ben.knoble@gmail.com>
> Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Signed-off-by: Gabriel Scherer <gabriel.scherer@inria.fr>
> 
> Gabriel.Scherer (3):
>    checkout: provide hint when failing due to another worktree
>    rebase: support --ignore-other-worktrees
>    rebase: hint when failing on branch used by another worktree
> 
>   Documentation/config/advice.adoc |  3 +++
>   Documentation/git-rebase.adoc    |  6 ++++++
>   advice.c                         |  1 +
>   advice.h                         |  1 +
>   branch.c                         | 13 +++++++++++--
>   branch.h                         |  4 ++++
>   builtin/checkout.c               | 12 ++++++++++--
>   builtin/rebase.c                 | 19 ++++++++++++++++++-
>   t/t3400-rebase.sh                |  4 +++-
>   9 files changed, 57 insertions(+), 6 deletions(-)
> 

