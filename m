Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E002459CF
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261913; cv=none; b=Djodm8gsZbwJ+t7rSD6c/iCKQgevF6ilaVgssyYyrD3q+qeHzUHrV20fTqATTSZOjauX0xgdxtHT1O1kbWWp2BPJKqHDYsqGqT66jUNCx074LdhLmSsU+Sv/8nA7VPLDex2g8w7HElZc/sGzAwpR2VqTkIxuidoQZEXfyiSFkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261913; c=relaxed/simple;
	bh=xODcHPE+I8InObH4wYMVOp/HwSTx8HxYA9rA2YxecEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ngf9tJYAOzCzeKzGcXfHi0DA1V7mcn1S1obu85fZ4Y2aE8reRoD5EmHGZCDAR6wsYArKRDTUfEcAlK/q/95YJN7RH82ovBgxfkFKWJlAIsWsEuWYwM8YgXB7XjB+bCLGmnPA9gU1xkrofolagPlXxZQ3tTHPB9CUAa9Fsm2DgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3AS0y8D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3AS0y8D"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso75677f8f.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776261910; x=1776866710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sTqwRb8MFk1wn8GyQ5TP+qsb8MIGwd6a7DqRdvyGnUU=;
        b=f3AS0y8Dv0Bh5JLZs956HAXZkWpnx1RVA6hOXfh2j6fr0VWsfjq26jFBz0/00bLY51
         vmuR99iE9ipUJVohAsl4h+WwGLe97NU0J7J4/Vx5rSR7mWDqzxf3vkd2/S6UQ1Lr7A0L
         vmhLmkcAiJzGSks7Z3DNoF1GROCeVeAfoZzZiOKEYeOLo01pF26pyZ24GvS/wDLnXWRF
         1U/TX4ke0xKXQCXLI5jspuNsBmOFdl1KS+jrlsgpGJky3W+pAmR3DM+92v++vV6BSMeu
         KGHbbM6S1Esbh/btK3hgcTgtO8cA9TJmj2/Ahbohhtc/8TfFJkpRRhVereeJWaLkZBQc
         BG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261910; x=1776866710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTqwRb8MFk1wn8GyQ5TP+qsb8MIGwd6a7DqRdvyGnUU=;
        b=UoJ2+ov0mIodXsa4qsJRG+iLVbzaRc+0Mh01Rilm9zzcBadtQTl4vuxNnEv+o8iMwm
         Yi3hcYCtaGldgOZ90fcFhhguS8vTJR71IDyLmYcajLfdqaLSDSSsOuSqTPzOAAt88njW
         VgvgqbXK+3wPsru7Ke8wySgbU6iNY3TKx/HLiNKk0U3/0sEOB8/lStJWjYImembP9Bn9
         srISrnn6BTZfwv2BFeB2Qa4WQeTNFhi5SOADrrbH42ZIWmrWDxlrET4QBdqteWhg6JMo
         XPUlpm1WGG9knxcffIKy+0060BvCm2YMi5orvLdE1rprNyAnCfVvsto4/Iu4k2mkjEZy
         sVGw==
X-Forwarded-Encrypted: i=1; AFNElJ9MSggw37JnWrUlyo36JVjCksm30OQ061sQeEX8UL/PbPWU+BiZXJKDYhfT6Pxq056GQ90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvdxt0LrNVdvuyaGpbkHSZKMPgn3w3MwA7P3Z1VzAPb0kRAGfg
	9xit3sgg+8sVbt4WnWKvjucCB1t7vcE/aDUK/B7nEOD/VV4wvDp9e1KSAMl0Bg==
X-Gm-Gg: AeBDies6nlNrxj8ENT/LjrHRhQOwWnKn4JYwHRL8tHvmTPpICVsgGd2J91CapLGgrcB
	oKTBvxKU/iZvYNzb8ze06Iw7UBu1Ritv947umiCMm8bilY8ULG9Logopc1cOnENBZGaN5NAtiFA
	JhvJQB82iVKCidfIYWkrXedGcMx76s6Cuf734oBa1wethQWJyygIxhMV7FJyyicNHbkgPBDt1Zk
	mtRxUCqDQrgApe2sHyZHiC+9Ol77ae69gHiSKQVpkjPaUod15uVMK6PHZzNDK56vLxNaJzI/Nm8
	jAa5iC5/7KcU0FmX/5NuoL8caAn5EJkBLhlI1z0KmQIcmOZiwm/T/4yLjZ5k1/WJdwWGaal91OU
	w6F6SVabp7lYvpPUaS2OfpISc3Lp9eEEeRmaqTC3/6UQyGDHtKZlmgCaUZY1VJOT4p4iEZv81Rd
	pMD2ktwqSE+lQTMTUXx4rksV294BshPvWpdHVqhZnUhEkTzonbHbM/dy90p7F4sUeEQoiinW7Kg
	Vs=
X-Received: by 2002:a05:6000:220b:b0:43c:fbfa:20a0 with SMTP id ffacd0b85a97d-43d642b98fdmr33351008f8f.25.1776261910195;
        Wed, 15 Apr 2026 07:05:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d65asm5545100f8f.4.2026.04.15.07.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 07:05:09 -0700 (PDT)
Message-ID: <823d30b3-b355-430b-b8af-c8421a87b0aa@gmail.com>
Date: Wed, 15 Apr 2026 15:05:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] worktree: add --recurse-submodules support to git worktree
 add
To: JAM <kratsbinovish@gmail.com>, git@vger.kernel.org
References: <CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/04/2026 01:14, JAM wrote:
> Back in 2022, Glen Choo noted [1] that git worktree add leaves submodules
> unhandled and suggested a --recurse-submodules flag to fix that. The thread
> went quiet. The 2015–2016 discussions by Duy and Beller [2][3] had flagged a
> deeper design concern: submodule existence (which worktrees have which
> submodules checked out) is tangled up with submodule configuration (URL, 
> path),
> making per-worktree submodule support tricky to reason about.
> 
> This proposal sidesteps that concern entirely. Rather than touching 
> submodule
> configuration at all, the idea is to reuse the git object data that's 
> already
> present in the main repository — the same thing git worktree add already 
> does
> for the top-level object store, extended down to the submodule layer.

I'm not really a submodule user so maybe I'm missing something. 
Worktrees separate out per-worktree data such as refs like HEAD which 
are stored under the worktree's gitdir in 
"$GIT_COMMON_DIR/worktrees/$id" and per-repository data such as the 
object store which is stored under "$GIT_COMMON_DIR". The proposal below 
appears to use the same modules directory for each worktree so if I have 
two worktrees A and B each with a submodule "sub" how can I checkout 
commit C1 in "A/sub" and commit C2 in "B/sub" when they share the same 
gitdir? It makes sense for "A/sub" and "B/sub" to share the same object 
database, but they don't want to share the same HEAD.

Thanks

Phillip


> 
> The use case has also grown more pressing: multi-agent development workflows
> (where several autonomous coding agents work concurrently on different 
> branches
> of the same repository) rely heavily on worktrees for isolation, and 
> fall apart
> on projects with submodules.
> 
> Concretely, git worktree add --recurse-submodules would:
> 
> 1. Hardlink $GIT_COMMON_DIR/modules/ into the new worktree's entry.
> Independent directory trees, shared inodes — no extra disk, no network.
> 2. Rewrite core.worktree in the hardlinked config and config.worktree
> files to point at the new worktree's working directory instead of the main
> repo's.
> 3. Run git submodule update inside the new worktree to write the .git
> pointer files into each submodule directory. Entirely local since the
> modules directory is already there.
> 4. Populate working trees with git read-tree HEAD && git checkout -- . per
> submodule, since the hardlinked index files start empty.
> 
> A shell script implementing this as a prototype is attached.
> 
> The worktreeConfig extension case (step 2) is the one place that needs care,
> since core.worktree may live in either config or config.worktree
> depending on the submodule. The prototype handles both. The other open 
> question
> is policy for submodules not yet initialized in the main repo — skip 
> silently,
> warn, or error out.
> 
> Would there be interest in a proper patch series for this?
> 
> [1] https://lore.kernel.org/git/kl6lwnimyxbq.fsf@chooglen- 
> macbookpro.roam.corp.google.com/ <https://lore.kernel.org/git/ 
> kl6lwnimyxbq.fsf@chooglen-macbookpro.roam.corp.google.com/>
> [2] https://lore.kernel.org/git/CACsJy8D8Ur4W348t- 
> WFUPrb7SQxmff5MJ4aRp+w+ZiQ7VVvipg@mail.gmail.com/ <https:// 
> lore.kernel.org/git/CACsJy8D8Ur4W348t- 
> WFUPrb7SQxmff5MJ4aRp+w+ZiQ7VVvipg@mail.gmail.com/>
> [3] https://lore.kernel.org/git/CAGZ79kZB8U+ERNeYpZ- 
> i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com/ <https:// 
> lore.kernel.org/git/CAGZ79kZB8U+ERNeYpZ- 
> i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com/>
> 
> Signed-off-by: Jimmy Aguilar kratsbinovish@gmail.com 
> <mailto:kratsbinovish@gmail.com>

