Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA330DEB0
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800853; cv=none; b=PtMypetr/5DasscJUX7PCsJLmrOB2fSPoNSP9CXHZNmBFrZiY2vHvnXgGKqsV3up3tcODRC9tCYtJBy8/Hfd7hsaTKXdABbbdXDBJHHVS9auUfVLbOV7DQsiZbqDZugJMfihj2E26B+VC55wAq/i8/BGMTMRGFsQ4DBkeZUKYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800853; c=relaxed/simple;
	bh=K9X7WPdg7ajgJCpM32vzNwMXUHMsy3Zao22sGM/fJBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e3NyS59ImtdfkfTr1F5aVckMQHiMoikz4rBf95kex0eWQmmU0LJTmvZcZUPq8kLtH27ZxrY7oXG/Rh23t4g4kUAzAmA+yK9cHCjHqWAfkjMrQnSn9sODJx+IFRiOqATiqXrd2MgjMv0Sbm+LkYHBAS5xuIYy8ny97kh3g6mJpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewOKtlCy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewOKtlCy"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d9603c2c0so252982a91.2
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800851; x=1775405651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Y6fxPbM/aGV4HLt3nl03DB4aXCnQJbcRVcR5UPGCJk=;
        b=ewOKtlCyqDz0owQW9+jgXstA6WZKOOS0xi0eKFRdh5fQEgiBa2Wd9stBmdkMrZPpBY
         t51wLC/h/m7P6ZbreXGGCL38OaCSzjYPsuOSgyEgXh7HtygrcAVB6zB9PrtQ1UPDbKdr
         SFYh3MTUnsBobLr8OusO5l2/K3ePVhfRO8id3Sg104DfS42coLfy9/+hMbdeVprvIqrE
         EqBpgX19IseJkgvCtlIkLl7zT5usDK65IQsSZ5ZtrZ9o3bhKhDCBALtTx1cbiiv/oy2P
         JaIs4dSd/ZVT7ntoQiyAAnGZQS6xHQU0DJYLqZ/Ms1MI0qkkMYwkFLNmF8DjdvmLYzd5
         z5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800851; x=1775405651;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Y6fxPbM/aGV4HLt3nl03DB4aXCnQJbcRVcR5UPGCJk=;
        b=B5vRiLpMqok4U9dVX70g7jbs6dwnsDReu/ECyEoBN12xel3DebInYAxbXx5iKXViwj
         DbjJdAZuABFs8wnANqI+e5C3Ol1ejpGhKiEWWXajZW9htro59pprPSVRRhDbAbA5fU7Z
         Qxs3Y3gFxGckmB7b5iJI3DEBkXoUkwdni1fmRTDkQO7r1xijBPoSApKyh32DE0UTNt86
         04A6fab2C07nQkfYrwG2BKss60794qI1M9ya7zEQdEv9v3Fa90RqRfsajJyKUp67pFrR
         2pAlf1g3qOYHwAqgSsYO6FkisShHw4gtAOUZudtERYFCEqtwvnEUNj0NiruF9DEsiWFH
         9ROg==
X-Forwarded-Encrypted: i=1; AJvYcCUOW32upfHn6vvqrjrt3X2+THoFNeNa5G6zQL40/77Z4NWUl+BrCaodR0TWdpDp6rw0kS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6rMjnnd4j3ZFUYyjkDUaYh0HNkQ04yK+jeRiXYBs6kTlruCB
	NgLViM0UnkBza+Y60Afj+LzmOT9/fxMwfE/b9Tevga74Z4+O83kMuNy5
X-Gm-Gg: ATEYQzzSUd6tJZxIRvfSFrWO4vH2rOxRyq5PBH7VB32TAJ0b4jW0esR7mbSoC15m4CW
	ehl+7ThlLWdzAROnkAYzFZUS7WpBeMdqsTvyB8nSeqmWiKMM1Nq4FZmLb3plXG9DT4hPRUlbtII
	3qtysofEXQ1hb+wu7cwGas8B1yYp/95qABIyoCNTDHrzkZl3BM0tDkaczIgCYRzdP9j5f3e5bAG
	RT1/TtgwGNusGtQqQA0mNweP1j1gcD0kTefdzkE2m1bwbAjU1p8MmtRVZ6lG2YitpOn23hUGsou
	yZKlOKPGrbkNgrNMK4KV8YkEemkKPWCRqXtpUposbWTaWlYfP9Smgdr5F0dFX2lKSfV8RCocwI6
	CqYKco+G/uuDpmnrgvpC/Qy/u4XxlQoVwXYKeT43m64/8KxFsnazSDFRW9IolIiA5eWO7q+abyU
	NyUGat/tpS8135/kYkrjlk3wfSlOylmsKOkBOftoxCUtVucXEJzc4j69wCEb/U5TKx6d+9tQZBu
	inR8pi24e8=
X-Received: by 2002:a05:6a00:4006:b0:82c:248c:6cbe with SMTP id d2e1a72fcca58-82c95afbb02mr5305959b3a.1.1774800851163;
        Sun, 29 Mar 2026 09:14:11 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843db09sm5320341b3a.7.2026.03.29.09.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 09:14:10 -0700 (PDT)
Message-ID: <acce32dc-b7ef-4b28-a36f-8ab90ccdc825@gmail.com>
Date: Mon, 30 Mar 2026 00:14:07 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH 11/16] t3903: avoid suppressing git's exit code
Content-Language: en-US
To: Trieu Huynh <vikingtc4@gmail.com>, git@vger.kernel.org
References: <20260328200255.247759-1-vikingtc4@gmail.com>
 <20260328200255.247759-12-vikingtc4@gmail.com>
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260328200255.247759-12-vikingtc4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/29/26 04:02, Trieu Huynh wrote:
> Update t3903-stash.sh to redirect git-cmds output to a temporary
> file instead of piping it directly to not hide the exit code
> of git commands behind pipes, as a crash in git might go
> unnoticed.
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   t/t3903-stash.sh | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..b67cf23fbb 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -962,7 +962,8 @@ test_expect_success 'store updates stash ref and reflog' '
>   	test_path_is_missing bazzy &&
>   	git stash store -m quuxery $STASH_ID &&
>   	test $(git rev-parse stash) = $STASH_ID &&
> -	git reflog --format=%H stash| grep $STASH_ID &&
> +	git reflog --format=%H stash >actual &&
> +	test_grep "$STASH_ID" actual &&
>   	git stash pop &&
>   	grep quux bazzy
>   '
> @@ -976,7 +977,7 @@ test_expect_success 'handle stash specification with spaces' '
>   	echo cow >file &&
>   	git stash &&
>   	git stash apply "stash@{$stamp}" &&
> -	grep pig file
> +	test_grep pig file

What does this have to do with the title of this patch? There is no pipe 
operator here, not even a single Git command. I suspect you wrote a 
script to generate this series of patches. The commit messages are the 
same for every patch.

As mentioned in the link provided by Junio, what matters in 
microprojects is quality, not quantity. Are these patches meaningful in 
and of themselves? Of course they are, but are they *necessary*? That’s 
a matter of opinion. What really matters is that the Git community 
evaluates your overall performance to determine whether you have the 
ability to write code according to the code guidelines, test your own 
work, and communicate with other developers — not how useful the patch 
itself is.

>   '
>   
>   test_expect_success 'setup stash with index and worktree changes' '

Keep learning, and welcome to the Git community!

Regards, Yuchen

