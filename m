Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795517393;
	b=VszhAMyeeftOg+KJtehqD6JdBd+3wgzwQeUFD7TryUCkYZ/TX6xvrGqQtLa37UaVHuDi
	 JFzQdQK3GhSq36LByWiUXn/1NNjjteZTAGV2fLG5C7jv6rKy0Vuv36uE3E032YsVmgp/o
	 C6N+7MpWKTtYcDG54P4yB2wUCsO97WPbB/c5WjdFy5nlwEUFcqk/HoOY10fH+pEwUhg2K
	 Bf85q8nHHBVScC8TmzkbE+b4SVtjWSXAtNZeNGOOJF7BFCiOOZ76Teb3gjdbSQAnKV5DS
	 iKHmijimxOdKzrvOMM5Qbt2eWLsw0Vx9EOE8c0ZF1a8UWTm+MhZBVtta03PGCnswChw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795517393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Y8DyfBtH9fr/Nwmfb1EoBB9wbbudMm/SgC7D8YJtFhg=;
	b=kaKnyNbqwZ9v1hsXL91+zBroS6WnjnYarLpbgChuyg5a8ZmKIm8gc/sZwyxH+gadyCok
	 47hhpoiqknudL+TVcNnxUFSWCo7TCJhxHD0E6VZx7/R+I2DNZBN9Jh913t+7ZbHfKZfVk
	 XgjOx4g8xxH8CzYRv45iPLkQQK/zfgDQdrg+8DzmFiGk/fFUwou9m0uAEdpWR72zf/8SF
	 9dQar2hRpz68Wg3wLk+UTmPQX217M7+oXyxcuBCiI1FbuylZP/zTo2VkFj9KszDbvgXkE
	 FeBdCgYQaaDWKp07b9pyP/E+n+thimIqDBucSLbbRUxsySwFlW3BHUW9TZNEz41o9pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiwXOKDp;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B79606A31E
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B79606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WiwXOKDp
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dee593f18so4125809f8f.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795517392; x=1796122192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8DyfBtH9fr/Nwmfb1EoBB9wbbudMm/SgC7D8YJtFhg=;
        b=WiwXOKDphZugBjjMg62Jqqp3qZqGX6zdmwo/Ben3hvdQuupBCsdHWZfOXEuelasQoA
         64j1IC4V6sdnIEhnMWm/XbJzuixnXacPlOUrjI/ez9Kl4MGq6fpjAf9+lxk95NLPIkIx
         JaA8MXVmk3g/0O7LT1B4k/UGQSalYgCkJUhW0khPGaGsVMvd4wEcIw7lw/UGWgQXrFmf
         UOy0VP/e6ihhPwE5+RkkECKB5yXfsI6wQr3QEmrisDIU7XJ7SUEpFXXV+bVMSwY7WKdf
         RJdbqvy22pDylYIIf0esxlyWL1+qNjn/SiP8LAdFMtHiUhI3MNRiN4JUKWD4gAGwaBQ4
         peZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795517392; x=1796122192;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8DyfBtH9fr/Nwmfb1EoBB9wbbudMm/SgC7D8YJtFhg=;
        b=JIzSp9ZBCVWHhM9A6HKotI+iJPxi3/aSrThY6TuzmOpzdhqsHYzuDSW9YJl4cMfi/C
         4MBTibE+MXimL5wswSRQVYTheI8dJTMn53MBWHBeU44//2njMUsnIWgZL1SwOv560wSX
         t7utYgdteGHnK4UL5n8XRF5JA8vgCZnucrvC2RzNBSqI2kYQw4uJm0tdFhAOskAn6V7u
         stIyF4eFTwFG6/PtSthP7ebEyLMclHjMHeu/MtrbM0ci2PfpJK0CbgfEpcbXNkaZVqp3
         naiIXJu1/PZxHFyIfqMNGNcyen15xyUvZaSvrrwV+7vRxFaggX6X0i8ee5CRMhH7gcz8
         MPcw==
X-Gm-Message-State: APuU4Z9RMk+nZZ+6tvQdnIRqblRpyh1N+t3+h2qK78O6seQOeT/v9Bex
	RkbwB4JMI//6+zwqxFWs6S1+dTIHqeGdxW9QaOG24dhC7gMFYwPEVetJ
X-Gm-Gg: AZFdTZe5dim2bU5B0o+1S854Kfcm7KAYw8SPEgnIXuvQbtROTAa8oMjRUpW/DGUTBuh
	RYTAm4clp6ypbtxAZZlM07MJd32M+kg5guHXh8eTmBPy9e5YCZh3SXFqjraPTy4GqMfdg81mhsk
	SGx2KqkXbE4TTx933bs/kxYd4OnMCVd5pRdv5ZslzlHIYX+l5VczAlI5/kb0Xf0eiHejfHFGG9D
	DtUZ2HAH1V8S1YkShlra8hK9jbCy3Vei2XQNFQ4r3ZMf2sZPYpJXQMZr2uhBd2G50J1/qqs+QNr
	udqMnrPv18SSGRmAdkrbH3OY7gEwaOEanFjsExyYCpUdYYpWhOnGB3TsZOW4YaZcmSShKtqWz7i
	W77fT8cPajB80hIxiJWOw50EAakFgHh2zIl2WkO2RHnn/TIk4CJHzqpH8a5bWHb/nzvi7bgpt6M
	NvN6cOIMNVPWX22ZUorneYs0KbodBJ0S+l6qOEsFRJCiRNQq74MoZ0Nv7kuwHl4cc5cEsyZ6z7C
	gg7+yxdTv8FqjgzsFrLw/VSWb4AFa0c0DbP0QarX/knirfB6wZViU+2tbgKGbZ9uQRdPbSpmB8t
	o3KRKJENnz13joBiPpq603Xp89/DTs5jcklIzhV8qDCpIhowDcMdNNeV+lr8+aSB5rwK4bq8tlR
	333CoqcxR7+tszmDN9Rocax4XUt+c
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id 5b1f17b1804b1-4bb88804d4dmr311354505e9.7.1795517391523;
        Tue, 24 Nov 2026 02:49:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm27322340f8f.50.2026.11.24.02.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:49:51 -0800 (PST)
Message-ID: <14c971ef-438c-4197-b0cd-df9bf0ef0ae4@gmail.com>
Date: Tue, 24 Nov 2026 10:49:42 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] history: refuse to rewrite branches used by other
 worktrees
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Nikita Bobko <nikita@nbobko.com>
References: <20261123103911.98860-1-aniketgupta3001@gmail.com>
 <a0ebd98f-669e-4ff2-bca2-cfd5da5a7316@gmail.com>
 <20261123215431.27574-1-aniketgupta3001@gmail.com>
Content-Language: en-US
In-Reply-To: <20261123215431.27574-1-aniketgupta3001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2026 21:54, Aniket Gupta wrote:
> Thanks for taking a look!

You're welcome, thanks for working on it.

>> What happens if a rebase is running in the same worktree as the user
>> tries to run "git history"?
> 
> It is refused. HEAD is detached then, so the branch being rebased is not
> the one this worktree has checked out, and it gets treated like any
> other branch in use. There is a test for it, but the commit message does
> not contain this. Will fix.
> 
> In that case --update-refs=head is not refused: it only rewrites the
> detached HEAD, same as before. I tried fixup, reword, drop and squash
> that way, and "git rebase --continue" finished fine each time.

That sounds like a bug though, because "git history" will update HEAD in 
the middle of a rebase and we throw away the result of running "git 
history" when "git rebase" completes.

> 
>> We should also prevent rebase from rewriting a branch that is being
>> rewritten by "git history" but that can come later.
> 
> Agreed, that can come later.

we should also refuse to run if another "git history" is rewriting the 
same branches - that's also something for another time.

>> This is correct, but it duplicates the revision walk we're already
>> doing when looking for merge commits.
> 
> Makes sense. I gave it a try and it works. One point: the branch
> pointing at the rewritten commit itself is not part of the walk, so I
> look at its decorations too.

Great, I realized that after I sent my mail yesterday, well spotted.

Thanks

Phillip

> Rewriting a commit that another worktree's
> branch points at goes through without it. Will do it like this in v2.

