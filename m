Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AE3BB114
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105968; cv=none; b=LCPyCK0DoW4CCo/538Yq/wXjtNwI+CVx1JDpCKDiAlxDZNehM1wnETrhLnMH0U1HMP9e01k23prrD0z/eHRSofSqawHgPMRUrI1qNoNK+fyz8PiCcMMKfV74td/6JSIs5IBYRzn5YL7eabBhyhCGxD+srZyRWK33A4rM5RdzfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105968; c=relaxed/simple;
	bh=tynOfWbz7bn1HYYu8ZZsYvfXijT/7yglcvJoNrIdepU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hwZyBKQ++U0GXy+JLJcXqu9slsashPaR4jyFHUZBeFOnsWMpgME0On5KOPPevyNrW79K/2j6g+3CDeaeaxMAQj0vkpT8HglnCIU7uROf3s11CxqMjFjbENlDhoo+moEAoKYNQ/M645BMO24pEiJezv0oyFarUglLb+yLPeJWVQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihjxTFyo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihjxTFyo"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490d1e54b3bso32219765e9.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105965; x=1781710765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zz42vgvtq2qif+glhDd/p3AaCsjZpvrVJlnRDAUy24Y=;
        b=ihjxTFyoPRlvcQnqX3XoX/5aTnED/NnaqjtwyNLAVyk81wmvrfEULCdZqSaiZRBMQj
         KVxFbiEPypElnBd83WbM/FlUAvmTLZ1gj2LaOVoqkpnp2iHDGc4WkxjnfgFH96Mg6s5W
         ugRQD4rIrJlSr91FfqI9xXXOdcFcfOjE4Ttl8jaikqLMzzQIKycPzfDzUivziUMQRU76
         RRGqeOvHCEKYILK0uGmnHQP6nhAdKzwtge70Jrm9QQAHzfF7nS2o/qGpMKxpL2OYkKsI
         qVmykoJ5cGi/9ZQNVLdd7O8VGDq4KL990WSMWIjrI53Q78fWTGpee874AeWfpqpt59jS
         5HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105965; x=1781710765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz42vgvtq2qif+glhDd/p3AaCsjZpvrVJlnRDAUy24Y=;
        b=PxKHtif8dHhA9CGcjO9ZnWqWnls0Me44RtQtFfFah20kiU64br9v7o89rpUv/xw02o
         YuJ1a/c/KiT91hDF9DIaBblz3rWKfufhZshkAulmAlC/9hM57uz32R3g2CcFjLYMh8ri
         vdYO+yBspYfACAL3uAeXEkt8aawmD0KE30xgCiDqZU2GSe7iAYMf3aVHpCxyMj/PwjLx
         IuFO6fh8Cj+FPWLtcZxJA/L2I58UzRb9wh5GlvgyMA3yfWMgYYgcjnlNHcXHrCHcFrg3
         xEB44uAg+IdhcY37z7B61CpUzCAB2E5wizkh4huuHi+t+K3sys0JDyZ0P7v4seYRLnR5
         bBIw==
X-Forwarded-Encrypted: i=1; AFNElJ/yfdz2u4GihmeTltbuXV3rP6fikep7xMaBke3GtcUo2Uam0dGif33oV0r6p6cFjMsfNkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSoo0Y/oFshQJXebsFo77iyA/M6hHQ3/FINjtouDQHgMpU83nc
	QCOH6vw3FgTC0UY9BQkE+G1p5qEY3EV68LOtL4v1TN0xQa/AO/sXTEJSFLllKg==
X-Gm-Gg: Acq92OHtDuBhMU/yD3Dj9oABluZjWtlStrPA3obIux5cd2R1jIg1P4Xc4qRV04xv4Kg
	f5iU59uFWO96LiNuP8Qb12Lq1ZAnH4C18JdLbfAujC3VITMpiIxrmJhd+4UUxFDGdXJ0NNuVHlA
	x2xslMEkeNDk9i/36WcX/P7LiXEejHg1Ki+FRg8MAMJRT/kUzpi2ZtaHSO4eAKbRjEZeiaBDYjf
	nAH/R7jP91ige69IPepj0Z2WUxPqzV8ILmyqTpDmsb909dcMrm//bSaI1yn4PAKoO0WVDrh7mJ6
	fUODFGTSZ68ES7oSPb0St/DKZJzuzt65RTN4V4WfL25hiDpYghdiumzmdLh56S/dzEpW+Q0KAtp
	JJamzL2YzOftMN8zyEcVsm+/jRmMxJx3PSB2mor41UrHU1FWW+ZgPZd3REdWbt2lx7b0bcr3OsL
	2GxMk23Q35S2vt/GtrXz1sCemIi1Um3RS7ZGGLBNqPpYtKmV/euDvWrLQ0RspiZs5g7/tRp5iHO
	0dayYc/DEAw8gg0
X-Received: by 2002:a05:600c:3551:b0:490:6237:521b with SMTP id 5b1f17b1804b1-490c25cc5c2mr403835205e9.27.1781105964885;
        Wed, 10 Jun 2026 08:39:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm574986175e9.6.2026.06.10.08.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 08:39:24 -0700 (PDT)
Message-ID: <c9918880-31f8-42a2-83a2-8175dbffd07d@gmail.com>
Date: Wed, 10 Jun 2026 16:39:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase --update-refs emits unqualified "update-ref HEAD"
 into the todo
To: betel_taxis4h@icloud.com, git@vger.kernel.org
References: <35A368B8-9B8A-44A9-96DA-65ED16D7D564@icloud.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <35A368B8-9B8A-44A9-96DA-65ED16D7D564@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/06/2026 12:00, betel_taxis4h@icloud.com wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> With rebase.updateRefs=true, an interactive rebase of the checked-out branch generates a todo containing the literal line "update-ref HEAD”, which git's own todo parser then rejects.
> 
> Minimal reproduction (plain repo, no worktrees, no remotes required):
> 
>    git init -b main repro && cd repro
>    git -c user.email=t@t.t -c user.name=t commit --allow-empty -m base
>    git checkout -b feat
>    git -c user.email=t@t.t -c user.name=t commit --allow-empty -m c1
>    git -c user.email=t@t.t -c user.name=t commit --allow-empty -m c2
>    git -c rebase.updateRefs=true rebase -i feat~2
> 
> The generated todo contains:
> 
>    pick <c1> c1
>    pick <c2> c2
>    update-ref HEAD                <-- emitted for HEAD, a symref to the branch being rebased
>    update-ref refs/heads/feat     (correctly placed; this one is fine)

I'm unable to reproduce this with the script above and I do not see any 
update-ref commands added to the todo list (which is expected as feat is 
being rebased so should not appear in the todo list). Do you have 
rebase.instructionFormat set? We recently had a bug report and fix[1] 
for "update-ref HEAD" being added when rebase.instructionFormat includes 
"%d".

Thanks

Phillip

[1] https://lore.kernel.org/git/20260510224111.64467-1-mail@abhinavg.net/

> Letting the editor save the auto-generated todo verbatim (or running `git rebase --continue`) fails immediately with:
> 
>    error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
>    error: invalid line 3: update-ref HEAD
>    You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
> 
> What did you expect to happen? (Expected behavior)
> 
> --update-refs should not emit an "update-ref HEAD" line. HEAD is a symbolic alias of the branch being rebased; the branch ref itself is (correctly) excluded from the update-ref set, so its HEAD alias should be excluded too. The todo should contain only fully-qualified refs/heads/... lines.
> 
> What happened instead? (Actual behavior)
> 
> git emits a todo line ("update-ref HEAD") that its own sequencer parser rejects as not fully qualified, breaking the rebase. The only recovery is `git rebase --edit-todo` to manually delete the line.
> 
> What's different between what you expected and what actually happened?
> 
> git generated a todo command it refuses to execute. The unqualified "HEAD" should either be expanded to its target ref or omitted entirely.
> 
> Anything else you want to add:
> 
> - Reproduces identically in a plain single-worktree repo and in a bare-repo + linked-worktree layout, so it is not worktree-specific.
> - An in-sync remote-tracking ref (origin/feat) on the tip adds a second, valid "update-ref refs/remotes/origin/feat" line but is not required to trigger the fatal "update-ref HEAD".
> - Workaround: unset rebase.updateRefs (or pass -c rebase.updateRefs=false), or delete the "update-ref HEAD" line via `git rebase --edit-todo`.
> 
> 
> [System Info]
> git version:
> git version 2.54.0
> cpu: aarch64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> rust: disabled
> gettext: enabled
> libcurl: 8.14.1
> OpenSSL: OpenSSL 3.5.6 7 Apr 2026
> zlib: 1.3.1
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Linux 7.0.11-orbstack-00360-gc9bc4d96ac70 #1 SMP PREEMPT Thu Jun  4 16:40:25 UTC 2026 aarch64
> compiler info: gnuc: 14.2
> libc info: glibc: 2.41
> $SHELL (typically, interactive shell): /usr/bin/zsh
> 
> 

