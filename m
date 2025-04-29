Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08D70800
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918547; cv=none; b=t6AufM6TfFF04FkPCTSOFwu52WmQLwP0egMGc3Yz5T4JIDrI/+gMbL0TkONu1DrycqFqnIT7wM2z9PgEYoI0t3fkl5rlbWLrOIXCMep/LiTtNMJfcnhTroVvc1P7cbLGPFouJtgAKHwhFiW7KD+IFzaTE6YqEzRp+8DNZNeJsus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918547; c=relaxed/simple;
	bh=KNK6mcsWdBLY3iLJXNDJm/4wLh8kod0rPceL9dS9EM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jnns207Ij1hBvTlIkWGgGbiCvJxLzpolkQT00PSWFXWQRt6zSZCXFk08qptTBTkVGVqa70oK0WArArMqKnx98he2Rkongqm+0yhj4pFtjtYNPvN1nIAVdHI6ztlI+/fXaL3iv2wE3s5ZMUAs8N3v7O1Oj3ENx+QS+qJR4g0e6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMqBPD9X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMqBPD9X"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso55974365e9.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2025 02:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745918543; x=1746523343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aRrFmf+NJux2H2I0Q14smX7lVPW7pS6Gx1KBQ6wDap0=;
        b=HMqBPD9XS/b5b7WEn/rHkCmIi3ummIjM1zYQV2dVqjBCWoXJiRn3HAizmzt4L81If/
         QgaQ1Zpv+8a9w9HtMIzisPH9RgxTF39aqhHdvuOpR3dAiKpBMCu7b3znynVVMHaZWlLh
         +cR3+T+k3emFBxGWUDENAgCA2nYGAKTaZAha69QipfYobzlLYYE8hXDXxAl0x3T360Zz
         8hFmfkcZM8sB/vjjSZlC3/osVVtfu7sFgysrMO1H5LU6Tmkycbut02wV4QBVQwKPWt78
         hDng91EPpP+q0l844sC6rqqqCQui/BpirVZySOeq5wbVpDXsUklYCcPs5BksHp6pozzh
         r+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918543; x=1746523343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRrFmf+NJux2H2I0Q14smX7lVPW7pS6Gx1KBQ6wDap0=;
        b=UTZoNosSL6Cpbdfkwaq0Du9LDsp6YR+c6uU/sXyDBfEdTEAwFdr5dSidT058zCMKnA
         UKshZSfyseGBN27xvjcLtB5/FUMfSKxF4gw0IdJcYpyOzSlaEUuqcgrYfgDdLlcoVxNn
         vFCIUohSeuBIJAU6ZmFKT5INg8pnt0LCyP4uJ3YpKpV54O1eJ9gOB2cWYI0qhTDe1sBn
         D42PJQE2W3e7tgi5MqwtXuTAukcsarlm/METUomND4JSmoe1EjiYAhNw8TRFbbYc6xA+
         uHFSV5Rw+WtyLq4zE794HLJo4G2yluPbhmmkiQ9CuEw6i05l3P1RqPpB/dykGeqm4SN9
         mw9g==
X-Forwarded-Encrypted: i=1; AJvYcCUGIqWSaMGSx026fJIJnahQ/nWuJc7497H9YqFPcxl31v5SDBLzslpRl8hOsC5Pm600KrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyJCGXJbRsQVWAWy0I5WWhlXQavq/ZQZQ6OtZonOFHjApCBlj
	x/9W5jR2wt0OB215kWtcv0By7bG0Sycu8k00XaplrTKDlSpGG4NUbF4uKQ==
X-Gm-Gg: ASbGnctbv/CYPACddIyKq78NoOi/khYWILiASjswDbeaHGUf3UEKU+01NW37XGFQMS6
	3TLSY8hy5e4OOrXO4VDKL2aXq8Bj4lD+dbzbzVnFBSRY5FMWqKObx7/zhKe4T3HT0okkCKdjMKd
	nVu23HN4p7DHpja9s63c6qKFmvO/Ol/UTrO0izZTgqKfJtuZF68tvtbPzcwgPPirAqRTbhsPubM
	u+ebCnjYkjKtwgRlvdNNiEFWBD6xSouueU+riHIH/DS7gqOlecMUG/hSEl9G9xVdX1tarKCGZjt
	oUG1xnP0GnZrf5/TwiIg1A/yTVG1/ZuPT9qA8EcCw2ziyTc1WA0iTVVddi0wG3lbftV+5lUc+/v
	oNeA/AVJMTas9ndsQ
X-Google-Smtp-Source: AGHT+IEhfg4QzwYdqVtb4qjOHPVMQSamIKGaBc54q9qi8e4BCDNMnzNU9zXR2iGRCYRdTCrNVWrBqg==
X-Received: by 2002:a05:600c:1d06:b0:43d:1f1:8cd with SMTP id 5b1f17b1804b1-440ab84518bmr83244855e9.24.1745918542987;
        Tue, 29 Apr 2025 02:22:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ac079sm182799415e9.18.2025.04.29.02.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:22:21 -0700 (PDT)
Message-ID: <ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
Date: Tue, 29 Apr 2025 10:22:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
References: <20250428194048.149348-1-code@khaugsbakk.name>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250428194048.149348-1-code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 28/04/2025 20:40, Kristoffer Haugsbakk wrote:
> From: code@khaugsbakk.name
> 
> We did `git rebase --rebase-merges` on a branch with merge commits.  Including
> back merges.  The reflog after that showed some weird symbols for
> certain merge commits (only merges):
> 
>      e9c962f2ea0 HEAD@{8}: <binary>�: Merged in <branch> (pull request #4441)

Thanks for reporting this. I'm afraid I'm rather confused. In 
run_git_commit() we set GIT_REFLOG_ACTION with

	strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=%s", ctx->reflog_message);

ctx is allocated with calloc() so ctx->reflog_message is initially NULL. 
At the start of pick_commits() we store the result of 
sequencer_reflog_action() in ctx->reflog_message. That function returns 
a heap allocation that is not freed until we call replay_opts_release() 
at the end of the rebase. If we're doing a normal pick rather than a 
merge we store the result of reflog_message() in ctx->reflog_message. 
That function returns a string stored in a static strbuf. So when we 
call do_merge() from pick_commits() ctx->reflog_message should point to 
a valid string though that string will not hold the correct reflog 
message for the merge because do_merge() does not call reflog_message().

> This is the backtrace when I get the apparently uninit. string:
> 
> ```
> #0  run_git_commit (defmsg=0x555555babe70 "<repo path>/MERGE_MSG", opts=0x7fffffffc070, flags=0) at sequencer.c:1158

Thanks for the backtrace. It would be useful to know what's stored in 
opts->ctx->reflog_message at this point if it's not too much trouble 
please can you run "print *opts" and "print *opts->ctx" here.

Thanks

Phillip

> #1  0x00005555558740d9 in do_merge (r=0x555555a67020 <the_repo>, commit=0x555555b75cb0,
>      arg=0x555555b2164d "<branch stuff> # Merged in <branch> { (pull request #4464)\nlabel branch-point-9\npick 4026b5ced849724bd3857283b6ad50c8609b6d33 only sh"..., arg_len=125, flags=0, check_todo=0x7fffffffb1e0, opts=0x7fffffffc070) at sequencer.c:4380
> #2  0x0000555555876629 in pick_commits (r=0x555555a67020 <the_repo>, todo_list=0x7fffffffbf50, opts=0x7fffffffc070) at sequencer.c:5048
> #3  0x0000555555877eeb in sequencer_continue (r=0x555555a67020 <the_repo>, opts=0x7fffffffc070) at sequencer.c:5480
> #4  0x000055555563a491 in run_sequencer_rebase (opts=0x7fffffffc330) at builtin/rebase.c:369
> #5  0x000055555563bc74 in run_specific_rebase (opts=0x7fffffffc330) at builtin/rebase.c:746
> #6  0x000055555563fe2a in cmd_rebase (argc=0, argv=0x555555a73890, prefix=0x0, repo=0x555555a67020 <the_repo>) at builtin/rebase.c:1878
> #7  0x0000555555574c0d in run_builtin (p=0x555555a34908 <commands+2280>, argc=2, argv=0x555555a73890, repo=0x555555a67020 <the_repo>) at git.c:480
> #8  0x00005555555750ca in handle_builtin (args=0x7fffffffd8a0) at git.c:743
> #9  0x000055555557538c in run_argv (args=0x7fffffffd8a0) at git.c:810
> #10 0x00005555555759e2 in cmd_main (argc=2, argv=0x7fffffffda30) at git.c:950
> #11 0x000055555569b0c3 in main (argc=5, argv=0x7fffffffda18) at common-main.c:9
> ```
> 
> § No reproduction script
> 
> I was unable to reproduce with a simple repo. setup.  I tried:
> 
> 1. Creating a side branch which had a merge
> 2. The side branch conflicted with the other branch
> 3. Rebased with `--rebase-merges`
> 
> -----
> 
> Normal bugreport questionaire follows.
> 
> -----
> 
>      Thank you for filling out a Git bug report!
>      Please answer the following questions to help us understand your issue.
> 
>      What did you do before the bug happened? (Steps to reproduce your issue)
> 
> `git rebase --rebase-merges` on a branch with merge commits.  Including
> back merges.
> 
>      What did you expect to happen? (Expected behavior)
> 
> Normal “action” string for the reflog like for example `continue`:
> 
>      3f90f6ab14d (HEAD -> <branch>) HEAD@{1}: rebase (continue): Merged in <branch> (pull request #4507)
> 
> What happened instead? (Actual behavior)
> 
> The “action” (or whatever it is) string is arbitrary bytes.  Like some
> uninit. memory.
> 
> ```
> e9c962f2ea0 HEAD@{8}: <binary>�: Merged in <branch> (pull request #4441)
> ```
> 
>      What's different between what you expected and what actually happened?
> 
> Apparently uninit. string.
> 
>       Anything else you want to add:
> 
>       Please review the rest of the bug report below.
>       You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.49.0.459.gf65182a99e5
> cpu: x86_64
> built from commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 7.81.0
> OpenSSL: OpenSSL 3.0.2 15 Mar 2022
> zlib: 1.2.11
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> uname: Linux 6.8.0-58-generic #60~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Mar 28 16:09:21 UTC 2 x86_64
> compiler info: gnuc: 11.4
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]
> 

