Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149903242D8
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781864024; cv=none; b=J3SO5INRQxdZZQiJtG6IlByLGiHJL44z8QXZO88gXh4Rc3CNasNJY65ybQNZACvhYCeRIOSURZMbD595KjN7zAY4fBVCltvk7yFexRUmAWWxT2Gv1Vxk/4zd/LY2BVCqVVm0Px2PbaE9N2Di8txMR9Zx7qY5ekgqFBFb0tlLRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781864024; c=relaxed/simple;
	bh=dlrUQiigWJkE6hqqazhADrz2I6wQiES+YrfFeZF2YLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY/D0xJvVRW/bmcbpcWH+2a2+DyW3IbaLYhRGEaCT/hInWd0geNVePw4C5hI8BZlOa4DjhX4l15G7/4Z/BBq2AtYBMDA599dd7Wtz7uCNMPUKYBoNyX5ESjABG/i7/AhEk7FqIHeSnhkFZpJvdAJX4gRBZlxIhgaI2DnfgCW3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ophGwYD2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ophGwYD2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ac357c55so18834115e9.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781864017; x=1782468817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a7fHPNbten1SQaYBdEKoJoM6nppSa+1+1GknOW+XSt4=;
        b=ophGwYD2g41820nE3HsxCZ2cKozDOtEjADwoFQJ0sbLzS13krrsWUnKbAS/88W/ovg
         qn5AKIeOhmwTtmHZksSPo+MNbeS0dyAw/FTIzLhqRA7PPrbaOeOYD6BxJ8OaiDPuo0kA
         uOhkk55t5Yb3ZpA0b7/rF6a4kkVeQQ4tyTnej5kSCx4H5mKVcA8X4o1lp6rEjOfBWwkm
         sdaloGUODqJZSYtx090Encg0KUnovQGUHWmCMdH+yeCQLR96R7GrpwXT6Oiyacz20R1L
         ABKTB2jcpu9u2QTI2zBQO8UE3pnyphUsmQD/DbbK4wtwfSqgvaAbHfFKpfHZvM7cGCRR
         Zixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781864017; x=1782468817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7fHPNbten1SQaYBdEKoJoM6nppSa+1+1GknOW+XSt4=;
        b=dOz5lZOP5oFbL7Xkvi9AbeI9aCuqr50NeaD2/obhsOKtPaML2O4VA3q67Cr95R5OPw
         ejflup2YYTXOujXr4OARzNqSg7GDD7qs1BPjDeNVlm3u6INOy2yONHR2hxmymK3vI+K+
         iHSJiHex9n430K/1Hmgry8h2TUI2srsdC4IyakanuTWrFgI2p4k3ZjnYE5YVz4fXtoQl
         GN0jS+ZgMYOWt9LCw9jDt+7mJxl7OzeauHUYMEcbUdRaw5DI7/jGzhsQQCRWuQPl9TQ9
         7vMvqJW/YJTyhZ9htn9PeARgcVFKBhLVmW/9g6jAjpK6spGg9spnMbnPAsWZiJUaNpPp
         IWnA==
X-Gm-Message-State: AOJu0Yz3LTckSOX/mmdmc8oHiTokSd4YgrheRoA57JbXJMgHlpAjhdXv
	G4//I+yrXceyZWOx223HkMWbzHSPcvMQjN4PN8KdOuE24ZkDBKI+Nm+L
X-Gm-Gg: AfdE7cniOgR6nA/wAkIeW/L2Rfe1nESTMC+vGYRnjgFGBpq54jaNnDXoiALlXfFGVfS
	62GoKvzTtlLY6ZfiSHs4KQ3XRKBwH4dFbc1cgkrmx7vKzci2vaJjShjzkVz00lN4H+SkNOfRVJ/
	NA941Y6j5BS97lwsyqOv2BJm2mRsX6pmL7zKzJzQPJM91SdjBhILHOM8Civn5YvbMzDiMxw9YPn
	0g0Lf0es/SuS+pSanp2Cgr/3qs59DKqXPiq57vPjAgLCdOQd20uaAL2zT/hyQw/Mz5fM4gKY2Kh
	31ByT5lel0OB0f7NLpQTHBy8AclO6AZaI9OONJjseWiE4VHs/0FNGIbaFXQiDKGI3BSOO3onNOg
	2SfIPUeLBEGNZbiTk2H0SwcI0+YfmRddpdSXToupvQLIHQn/U+4oBCFVY95IIDJ1SFoJBeianLh
	ecez4Yqzb/7gTX5VZqFBX1jozFbmhI9AcWZ4GrEX6hWBLz9BiT2miV3nxL7SXy8qiJLVcxcQ==
X-Received: by 2002:a05:600c:c494:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-49240e05938mr44980415e9.9.1781864017027;
        Fri, 19 Jun 2026 03:13:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm93991425e9.0.2026.06.19.03.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 03:13:35 -0700 (PDT)
Message-ID: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
Date: Fri, 19 Jun 2026 11:13:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sequencer: Skip copying notes for commits that disappear
 during rebase
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <20260616174012.601651-2-u.kleine-koenig@baylibre.com>
 <xmqqzf0txpu4.fsf@gitster.g> <ajKimV1TDCgE-GzK@monoceros>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ajKimV1TDCgE-GzK@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe and Junio

On 17/06/2026 14:58, Uwe Kleine-König wrote:
> 
>> It is not yet clear to me if we want to _always_ discard a note from
>> a commit that would become "empty" during a rebase session (in other
>> words, a commit that becomes empty during a rebase is _always_ a
>> sign that the change it brings in is _already_ in the new base of
>> the rebase
> 
> Yeah, or in a patch that was picked before.
> 
>> and the necessary information the note wanted to carry to
>> the target branch is there without need to _duplicate_ it by copying
>> the note).  But assuming that we want the behaviour, the code change
>> to sequencer.c looks very reasonable to me, except for one thing that
>> I am not clear about.
> 
> I think given the commit goes away, it's natural that the note goes
> away, too. And to come back to your question above: I think it doesn't
> need documentation, that if a commit disappears its notes go away, too.
> But that might be subjective?!

I tend to agree with this - if we're throwing away the commit message 
without asking the user I think it makes sense to do the same for the 
notes. We have "--empty=ask" if the user does not want commits that 
become empty to be automatically discarded.

>>> diff --git a/sequencer.c b/sequencer.c
>>> index 57855b0066ac..da2185a37c5d 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> ...
>>> @@ -4965,7 +4965,7 @@ static int pick_one_commit(struct repository *r,
>>>   		return error_with_patch(r, commit,
>>>   					arg, item->arg_len, opts, res, !res);
>>>   	}
>>> -	if (is_rebase_i(opts) && !res)
>>> +	if (is_rebase_i(opts) && !res && !dropped_commit)
>>>   		record_in_rewritten(&item->commit->object.oid,
>>>   				    peek_command(todo_list, 1));
>>
>> If we have a sequence of commits where a commit that was *not*
>> dropped is followed by a fixup commit that *is* dropped (e.g.,
>> because it became empty/redundant), wouldn't it prevent the
>> previously pending commit from being flushed to skip
>> `record_in_rewritten` entirely for the dropped fixup commit?

That's a good point - we should call flush_rewritten_pending() in that 
case. Looking at the code there are some other bugs related to dropping 
commits either because they become empty or the user runs "git rebase 
--skip"

  - If we drop the final fixup we don't cleanup the commit message

  - If we drop an "edit" command then "git rebase --continue" records it
    as being rewritten HEAD so we'll copy the notes to the wrong commit

  - Running "git rebase --skip" causes the commit that had conflicts
    to also be recorded as as being rewritten to HEAD leading to the
    same issue.

> Huh, sounds possible. I wonder if that makes the change so complicated
> that my time isn't well spend working on that given that I'm not used to
> git's source code and it's better addressed by someone with deeper
> knowledge. Sounds as if we need a state signaling "Current commit is
> done".

I'm happy to take this forward and try and fix at least some of the 
other bugs I've listed above. Uwe - if I don't cc you on some patches 
within the next couple of weeks please feel free to send a reminder.

Thanks

Phillip


>> Wouldn't it map the note for `X` to rewritten `C`?
>>
>>> diff --git a/t/t3322-notes-rebase.sh b/t/t3322-notes-rebase.sh
>>> new file mode 100755
>>> index 000000000000..0eddde7f9961
>>> --- /dev/null
>>> +++ b/t/t3322-notes-rebase.sh
>>> @@ -0,0 +1,37 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='Test notes on rebase'
>>> +
>>> +. ./test-lib.sh
>>> +
>>> +test_expect_success setup '
>>> +	git init &&
>>> +	git config notes.rewriteRef refs/notes/commits &&
>>> +	git version > version &&
>>> +	echo A > A &&
>>
>> Style.  In our codebase, redirection operator sticks to the
>> redirection target without SP in between, i.e.
>>
>> 	git version >version &&
>> 	echo A >A &&
>>
>>> +	git notes add -m "This is B" @ &&
>>
>> '@' is hard to read; when you refer to HEAD, please write HEAD.
>>
>>
>>> +test_expect_success 'rebase B + C on top of BD' '
>>> +	git rebase @ master
>>> +'
>>> +
>>> +test_expect_success 'assert there is no note on BD' '
>>> +	if git notes list branch >/tmp/lalaa; then return 1; fi
>>> +'
>>
>> Do not step outside of $TRASH_DIRECTORY without a good reason.
> 
> Oh, that is a debug thing that shouldn't have made it into the patch.
>   
>> Style.  In our codebase, shell scripts do not use ';' and written
>> more like
>>
>> 	if git notes list branch >notes-list
>> 	then
>> 		return 1
>> 	fi
>>
>> But more importantly, if you want to make sure the command makes a
>> controlled exit (not crash), use
>>
>> 	test_must_fail git notes list branch
> 
> Ah, I really wondered if I'm missing something because it should be
> easier to say "this command should fail".
> 
> Best regards
> Uwe

