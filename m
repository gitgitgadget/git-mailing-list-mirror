Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50E2BE642
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959398; cv=none; b=g6pB21PCOQVTxd6jiSeevkUgLYkG91zFlNn/+/MmotA+oPQoGG8VoYGpFM4EgVcSl1ZQmkoRKJ65Imf56rwXeaeQqy2jessl1OiJ3mQy+C01f5G2tHAFsY+Xae9yZt06RNHAdD8+vK/FK93y1y5Cb3DNUMVoklmW63o/nwTH6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959398; c=relaxed/simple;
	bh=9TTpX6FlELqde4l9wZlAdwhK95RLpUkbTBkmVWuNSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HatcgBhKWAKKixTwNA7SQVzZciRboJnySnBQor9PI48fmJKW3KXxBKUfAzIgtiNhKNIzkhOFflhPRcyrUys3sbfNHRLjQItnIG8zFSAf9OVC6rX0kdFcIQ+VzgiZNmsem/vKk5/qjC/FwUo+Gsjy4CXsZCo+YFRhvSop/gK+0VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnItc8Kt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnItc8Kt"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38c68e6b62cso39587071fa.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774959395; x=1775564195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf8RbkOd6sKCLzclWLL+4rGRJHts4Yg4q9UBiRhs6e0=;
        b=pnItc8KtBdsgYhMTF9aDZ2scBKwiY5hlE7+V5nvPSSQwucdp2CXwsetIERpMgkenjD
         CtDeh33pdLevkr4Fu/URhN7vW7il1I8VIAbSsX/lXuWx1dvDkx2ARYD615mLtCq3sIcp
         paRF15EoghFjnr86uUP7TmR3nUPD3I+gwFe3UmSCkRHSXJ0URSvlepT+rID65D229vwo
         B3vtpD5n7TLBYGtODMZnMIR29r6mpox0YKXLlqJO7+ZlpJLkBK/+HUl4QvqEYi3wNKfM
         kg/CX+qnKcbKXTvdZ0jl4Y9DoxAOrHzojmHwUoatvrHPQcpsim9oX6sqR2iHWuuEmwy7
         Nwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959395; x=1775564195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tf8RbkOd6sKCLzclWLL+4rGRJHts4Yg4q9UBiRhs6e0=;
        b=KiNBzHUCEhwC5TywgPmr97n9FYSbpXYsoNFpezSqmRuA1ANIVhama+YPuEKvXj9KEQ
         9eRu06pEhSvZL4pJRy12GisMB/A9kufTU2TyXnBx7gc95Ri7QPxXZ56CLWSHsykNA54D
         vHgcW9rHWxhYiXhveAS3Wzv7dt8uObuy8y/2DKS43Dp0j3w8po33FAen2AokdCxUC+Jk
         cHtWfufC39ugk5K4zvImFkdY+BpHLiOi4yXXhhRwTjAU6vEMIF3etWVsVJ9BrZv2jnUW
         dy8gvwWzHn3Yd5kZaIsld1wm+zItN5bzFulNF1F25oQVtrapn3TTS8Lw+YNa4MeBhSNy
         p+Hw==
X-Gm-Message-State: AOJu0YxtlrSeWVLEL0Wb1/CQOQTzSw8vzNw69m7h5G/8T/a/mRW91dJk
	dviRoxooI9TH16PULpZqnQWzH9jjGH6a1t1ajaBKCz9NBIuX+NlXdjzE
X-Gm-Gg: ATEYQzzqscoLjX/9Kmp70fyEE1XQsQy3fFWbQBaOEHifLLWPuAhFTcpC7gbvYQgLzEW
	W1hGksUkDwO36DwFRuUR6N+RqIOxUjWj/kBK4dVtwUhOMxdM+hEHAsSOysPkj8TVGkNCXvuP71W
	UMERw0xv1L/VEZ1hhSyAR1+uTSH6NoW7Duw5kDC29iJQpUjpVp5HWX0MEf9KqNPr83XVwQqDTdQ
	3/g/5n7eBa0033uXO+3Vkw3jao4nNE27eWmmJ3RWOjNJOi83EBSILTej7NYrDhxAVM92rVcstsT
	U2OZMIEXYKYtAAuqdhAea5CaaWtikKrsQ/+symJoYmMD9Z+bF07KR1bqYEqt72MT+GOdodevuzq
	xg9JiX5hwA57SvMy3O7W/6DSduKi8gNFDfYkdn7Y1GFxCRRtucIsEl7/aBCrxWFUrpog22PKRUL
	xQircjxrfnYMXQnSPN82pPw0wrlbnjjlNhcDlUxlB31mjy1kIOeIHTzfiSIe40L6UbufC/aFWEo
	l91PQOw12D+yr7EPQfT8w==
X-Received: by 2002:a05:651c:324a:b0:387:d29:fd4f with SMTP id 38308e7fff4ca-38c73065e4fmr50052931fa.1.1774959394681;
        Tue, 31 Mar 2026 05:16:34 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c838daa4bsm23419011fa.32.2026.03.31.05.16.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 05:16:33 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 31 Mar 2026 14:16:33 +0200
Message-ID: <20260331121633.14907-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq4imbn4sw.fsf@gitster.g>
References: <xmqq4imbn4sw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> FWIW, I very much like what I see in 
> 
>    $ git checkout hn/git-checkout-m-with-stash && git diff @{1}
> 
> output.  It is great that we do not have to do any dry-run, because
> the "real" run safely aborts, we can do the "stash && merge && unstash"
> dance as a fallback instead.  All the credit goes to Phillip and you
> for the idea and the execution of this.
> 
> I do use "checkout -m" a few times a week, but I do not do anything
> complex with submodules or run the command with unrelated local
> modifications, so there may be changes in behaviour I haven't seen
> in corner cases that I do not exercise.

I wonder if my implementation is not really up to par. I have ran into a
few "conflicts", were 'git stash pop' simply worked afterwards.

So not quite production ready.


Harald
