Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D146AEE1
	for <git@vger.kernel.org>; Wed,  6 May 2026 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076310; cv=none; b=gFa84UzCZtweuoFrPnsN4czMUidAryVU/WqCeTvuCPa3luxuEue6+JAiRZ4pfcAuQeTAVi0ySQPQ2QZhLGptz69jznmbjmX6tJm0ZsT2q3qglqZ/03r80LRD42ioQYFtFUCaq4OGWU0M4WlYiyk4UmzWPcyCj/FNpFDmCGyDY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076310; c=relaxed/simple;
	bh=J9Wpij8Bucjt+cG7NOEoNDDq9Yi0IDIwuwf8Ho9YvIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pP0tJaAUYz2najXVBEC4UCdBaNRcYqk/ylr3fhhDiJ/O7QykjXk55B4TW6C8GmuSqtBgWooPABfTBb1/QLZ+1oZ6ANuy0Fd7ozZzBRJj3EhSf/OQVnQwr0qyUhwQ+/kmq2EaGu8dtHFX6LYIavZzU/R8j1Gy583QJEhV5UEeiKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4N1OT1+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4N1OT1+"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cbc593a67aso576012685a.2
        for <git@vger.kernel.org>; Wed, 06 May 2026 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778076308; x=1778681108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9Wpij8Bucjt+cG7NOEoNDDq9Yi0IDIwuwf8Ho9YvIk=;
        b=E4N1OT1+3Zx9xPBbG7TpRH3969k5oJFbB+VxfR7Jyi2NUV+U/NGfetHVgEj82NhF1v
         PJXeuywuu+wXtDh4Bu3iQTuP2VAgZsijL/bxc+hK27NAEH3U6wRrC3oEBfU/6twNCSeX
         1gvGCIDLWssPhZwomDd/MnLov3zOmydfTNHBue1GGyWM7AA/6/RulpqQx57zndTnvtH0
         7woSLoMPFXzHySbWw0OqqR2jY8ATtbktpU7tQWK+jBWuWYj7XJbfHNywwKgjnyZ05+G8
         hDQl70n9j5xKGX8GOs775zPZh3xKGY+zz7/6tbNMt/8mcJ9uzQdlQNh1hw8FcIVW7sQ4
         Jojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076308; x=1778681108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9Wpij8Bucjt+cG7NOEoNDDq9Yi0IDIwuwf8Ho9YvIk=;
        b=Tf1w+fVTRVbYrGFlaLMvXZs3HEqgrfX9ajsUnJq0KdkrNRFyuugABs8CCoZTYSuKTY
         kGaILsOTPkTB/EZariBjxpLBbk+gyLXF74n3jV/3AKfAB2IyPkPF4vJ/x+QyDkQsGhCd
         XvcV5vzdqJRiTIACwrvU0laH9lkipnjuWP5yVqwiAH9htMmsptLg2C3eTwKCu5crMBzE
         Y6BUT580DBYF5dB3YEprPKKx27/hKtgpACiWXXxEutzVDdtnW5jlR5kgM/5umxNXol/+
         jYD5plHB6cee7n4dCfalM3w5P9ppfzWK6rCz2G7p+1oqh+TQJQCbKYb4sT3rhYSFnHfi
         Za6g==
X-Gm-Message-State: AOJu0YzloWPoFYoX3Zi9xfAyiZ+6pguMTeIPAjAPa5lwATeR0fdtjf2x
	JRpeBCF+BJK+uRbOjCK3NvV6JmFsN1OCXCD3URqXU0444Pi0kbKct1GjslVz+dRb
X-Gm-Gg: AeBDieu/1f3f3gokqVCWAM7rAMBXG7P4LENAA/CZJWCLcZM/CZXJ4eoDHttMZFj8OJb
	ThBmRnVK7dXfFFNaHNw8KVST5ce8VKQpAVtp87xCD/dgVhpDvXzi+zI9zN28FP9P88BIZSdMKnm
	xEJadpeEl1UInpJ1WzLkUR5VjEdUxDbT6ZNx0JDHnHctTGaW84h7cS0W2t7HoUUWsL+IwDmFT2P
	fMIrMtvvMpMZXmKknnTu0+V5I//ZVQjkmmY4rvaHwXReUrJKFzfWqgS0WobanHS8nvMbo8tLBAM
	2oVzfBr93aQ25mWa3NmqwTVMqyU/CwloiM/rScSptFds8qjJFDTfthxg5yv908k7GizYtgaeIog
	qOogCXIKCIB5HfUoTpw0UET0g42l1yFNbxBlJZYjb3PJ3NUec9kvtxqAMsT5yl255/J76Zhz2C0
	HWo2OREzYDi2HjNAgMk3QsSQ0orCI8P9PzMtmAtzVRRAuy
X-Received: by 2002:a05:620a:2944:b0:8c3:7f27:a65d with SMTP id af79cd13be357-904d5d0d8c0mr508449085a.28.1778076306980;
        Wed, 06 May 2026 07:05:06 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100::59a? ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938d0bcsm1628454285a.4.2026.05.06.07.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:05:06 -0700 (PDT)
Message-ID: <7a963eec-80d2-4605-8cb1-52fb7bc9cf8e@gmail.com>
Date: Wed, 6 May 2026 10:05:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] git-gui: handle missing worktree and separated
 gitdir
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Shroom Moo <egg_mushroomcow@foxmail.com>
References: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
 <tencent_8A236D9D4A8D8CCA7DAA083157AA8543700A@qq.com>
 <3b0b37ed-1a5d-4fe1-b2b4-7db67a62a06d@gmail.com>
 <77219c75-7968-413f-a642-0446145c8023@kdbg.org>
 <a1a7237c-ffed-4a7a-ae58-55769aaa4453@gmail.com>
 <93e1c61f-e58b-4a0c-8ece-7a8d945fa900@gmail.com>
 <73b99b54-1d39-45c1-bd06-26ac1008fddb@kdbg.org>
 <7d5cf952-badb-4071-a0eb-af9443fa8b5b@gmail.com>
 <ac115a8f-5dbc-4988-b8a5-c1647af1bb74@kdbg.org>
 <f6c7c3d5-1d68-45b5-87a7-ae19b59270f4@gmail.com>
 <9fecbb11-3cc5-4084-bc29-bd948962dca0@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <9fecbb11-3cc5-4084-bc29-bd948962dca0@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/6/26 8:57 AM, Johannes Sixt wrote:
> Am 06.05.26 um 13:27 schrieb Mark Levedahl:
>> A git repository (gitdir) can have config.bare true | false | not set
>> git rev-parse --is-bare-repository tells you that whatever gitdir is discovered from the
>> current directory has core.bare==true. This happens whether the call is from inside the
>> gitdir, or in the parent dir of a gitdir named '.git', or in a directory containing a
>> symlink or a gitfile link to the gitdir. This call never tells you what directory you are
>> actually in.
> OK. But how does "find out which directory we are in" come into play
> here? If we find a bare repository, we do not need a worktree. If we are
> in a non-bare repository, we can find the worktree with `rev-parse
> --show-toplevel`.
>
>> git rev-parse --is-inside-work-tree gives:
>>     true - the call is made from a directory that is suported/supportable as a worktree of
>> a gitdir.
>>     false - the call is made from inside a gitdir, or from a directory linked to a to a
>> gitdir with core.bare == true.
>>     and error is thrown if no gitdir is discovered.
>>
>> I find --is-inside-work-tree a much better call to make early in setup. 
>>     true - full git-gui is ok, 
>>     false - blame/browser is ok (gitdir might have core.bare true)
>>     error - no gitdir found, the repository picker should be called.
> But we would still make an exception for the case that $PWD is a
> non-bare repository named ".git", because then, by Git GUI's definition,
> its parent is the corresponding worktree.

I find the organization using rev-parse --is-inside-work-tree easier to reason about, and
if I were writing this from scratch, I would do it that way. But, you have one or more
patches in progress, if this idea is useful there great, otherwise, drop it.

>> As you mentioned elsewhere, the problem on browser/blame is that _gitworktree is empty
>> when no worktree is found, so GIT_WORK_TREE is exported to the environment as an empty
>> variable. This cause is in a commit from 12 years ago:
>>
>>     3decb8e0ac ("git-gui: tolerate major version changes when comparing the git version",
>> 2014-05-17)
> I don't think that this commit very relevant. The problem is in `git
> branch --show-current` (and probably other git command variants) that
> want to turn an empty $GIT_WORK_TREE into an absolute path even in cases
> where no worktree is needed. I haven't tried to figure out which commit
> (in the Git repository) started to do this.

Reverting that commit in any way has nothing to do with fixing this problem now. But,
detecting breakage at that commit is what lead me to discover the problem was _gitworktree
== {} and GIT_WORK_TREE="". As you say, browser/blame may well not have broken until a
more recent commit to git itself. I cannot say, even the 2019 git prior to rev parse
--top-level being taught to error out will not build on my computer due to incompatibilities.

>> The fix is to set _gitworktree to _gitdir before exporting GIT_WORK_TREE, or to just not
>> export an empty GIT_WORK_TREE. Obviously, having GIT_WORK_TREE = GIT_DIR is asking for
>> trouble, but perhaps is ok as git-gui is running in a read-only mode for browse/blame. My
>> limited testing shows this works.
> Good to know. My preference is to not set GIT_WORK_TREE at all provided
> that setting GIT_DIR without GIT_WORK_TREE is a use-case supported by Git.
>
>

I just confirmed that git-gui modified to export GIT_DIR only, not GIT_WORK_TREE, and
actually to make sure GIT_WORK_TREE is not in env, has blame/browser working correctly in
a gitdir with no worktree.

Mark
