Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEF3EF64C
	for <git@vger.kernel.org>; Thu, 21 May 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385544; cv=none; b=oPXJEF8UlDwZkcYKB8uRy2EkPtkloRsWiGHEPSznnrQvrAmSc7qqpLwh/SLgXUoprPWakFFaUiaKMIJlFU4pJR024Mvd8MP/j6LMqq2jN7+9U4NiqYSbnXZHWARerOLNyU237qFhRY0cS3eY8gL/ossl+rX/37E1URw/NLfYM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385544; c=relaxed/simple;
	bh=3rtKhtkX7+BG2wHgI4hLL0gdPGdeSSS+O7HBQJFQWew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7l5LCaKOTufpd4I40/B/b1meNvz5wGx/BrifWjEithJw+gosXgKiMN9Zh8HFjWp/lWbRVbREBRh9iODewMgEY4KqRwCeOHbAuej3D5Pju3MY8DCFG84hYGlFicIyTh49ZsU03QOyi0cmVHZcTSxUxj+Wfdd1Pv2hXLexr26SX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMBK6JRo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMBK6JRo"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b59772d441so79353956d6.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779385542; x=1779990342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5K0VAhhA3iRXZcMSlidhDafEZvluXkO0H8NNblqVsUU=;
        b=gMBK6JRokpLGuxvFBPaIh4RX4n7bggWfXeAFVJfLHjAIt6xsOObJDAdvml80kM5AoJ
         /B5DrsTMKZpl5GapXQsj5G3w7zeDbFtgNylpdfJj6dVfZyAJMPtXiFims2ypb7BIH1Hf
         RfV4yScQsdpz4K5PUve6t2APigeD+66KI0VJQaEttPN9TW5RzSJFhMqZUulAgj/vdyxR
         /dJEYO2jLtHyRNLMZktaCPfVPHx3ufCU82/IuHWJ+M5l60e5IzNmaO5eaNJqx2n/PaXT
         FZE1TYo967zU3+YU+G+AnF+qtPXfpYo4iP8/XHZlaqlmPQ6szlcFQTYtZrP0XfBObDhP
         Uoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385542; x=1779990342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K0VAhhA3iRXZcMSlidhDafEZvluXkO0H8NNblqVsUU=;
        b=PwZThm6Jiu5RK8gD1o1AVYJM0uxuYM2ro7fM4NeaQW0Z4/aG/Ys+XrH4J5F9d/s/ns
         +mZpgBFLTviILU58EQaWusi/4K7eGV+6vJohyMJVgKzRr/vtMRcjYXZCTJgdkqmZIAs6
         xZ6bPsEr8k4JUqmiA4AC3sZW9PhXHFAlJVwYODtG2web4Ti00rMfeSxbbBOqQEddp6O5
         4xKkG3RsL1Iw8712c//8us+3Q0U46EhC4HpvqF7PLXhlJiXWG2ao15swXYxrSHP+FwSH
         Zvh0MKWMHCIfHDG0QrM2FM2CcAE/Z8Uq/wMw7p4DOE4dOxTOXVhmjNmPRW/9eyGbGwoo
         lrfA==
X-Gm-Message-State: AOJu0YyPnWTVtn0CGFcw9OcdxH16r6rxtUtNOM//2J7P852ylBfCAUZe
	+gcITsHsHw5HMGJNEFFYx+oe7qs7lchoIFiX54gU69qfp862xdwnPqCFJQQH6m89
X-Gm-Gg: Acq92OGxUUbsa6u0alNkGEN63upyWKHQL1UXNsrttQMhA6kz4poESeXjZGATuqwRRBq
	WFzvRckbx9/rS7mHNqaFpEl1JiyB0ux61LGWusHPD8UCuab9ghfa9zbcAVzwUNVEIiTwz6N4IVz
	5beARlWZJl9sx6WAquvBbPoDdlVvxCIClLuQWuTLCaB+wSKnymgA0BbQ2GlLQ04rZb2/DEnMPfm
	4gTTUsBwvuQjMS7LmFUhGIvXnHmGgVNA8yYhgJfkWiyB7vqhCSyTLkFQURGVR2SwHt8somFmi1O
	w5rr532SEKUVw0Goa/Zrkd4RCf03knMWC1y6F7WLBOowRALxmvOo9N74AtFfE35vr0IJ4GhhV1Y
	TsHx5ZqYDy3mzkJp5v+sJPBwwZ7+Lohu9JtudfTV8qfNolXc5dHVjjd8Rew3toWqp73pkY3Qepd
	0K15uDBeS1bCeU6AuBfH38VwDuqFqrZbUbKm8juUgtPFuRNn6e9SEtiKQBM746pp3uKrBycLbmV
	TG7OWn2Cw==
X-Received: by 2002:ad4:5c65:0:b0:8a1:8ddd:e12e with SMTP id 6a1803df08f44-8cc7b5feacdmr5286936d6.48.1779385541944;
        Thu, 21 May 2026 10:45:41 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768b71d2sm12072516d6.9.2026.05.21.10.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 10:45:41 -0700 (PDT)
Message-ID: <780a52d9-7119-4870-990a-16280005503d@gmail.com>
Date: Thu, 21 May 2026 13:45:41 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
To: Shroom Moo <egg_mushroomcow@foxmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
 Aina Boot <bootaina702@gmail.com>
References: <tencent_E13EB585242AD7C263B8B3B732A428465D09@qq.com>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <tencent_E13EB585242AD7C263B8B3B732A428465D09@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/21/26 12:55 AM, Shroom Moo wrote:
> On 5/21/26 4:24 AM, Mark Levedahl wrote:
>> +	} elseif [file exists {gitdir}] {
>> +		if {[catch {
>> +			set fd_gitdir [open {gitdir} {r}]
>> +			set gitlink_parent [file dirname [read $fd_gitdir]]
>> +			catch {close $fd_gitdir}
>> +			set worktree [git -C $gitlink_parent rev-parse --show-toplevel]
>> +			set parent_gitdir [git -C $worktree rev-parse --absolute-git-dir]
>> +			if {$::_gitdir ne $parent_gitdir} {
>> +				set worktree {}
>> +			}
>> +		}]} {
>> +			catch {close $fd_gitdir}
>> +			set worktree {}
>> +		}
>> +	}
> There is also an unaddressed issue: 
> In [file exists {gitdir}] and [open {gitdir} r], {gitdir} is a 
> literal string referring to a file named gitdir in the current 
> working directory. However, in the context of a linked worktree 
> (created via git worktree add), the actual file path is 
> $_gitdir/gitdir (e.g., .git/worktrees/<name>/gitdir). While the 
> current working directory could be anywhere (even inside the .git 
> directory), $_gitdir is an absolute path pointing to that worktree's 
> gitdir (e.g., /path/to/main/.git/worktrees/branch). The gitdir file 
> resides within the $_gitdir directory and contains a relative path 
> like ../../.git/worktrees/branch. The current code logic will never 
> locate this file. 
You have to be in the particular worktree's gitdir for this to work. I there exists
    worktrees/foo
    worktrees/frotz
    worktrees/bar
Which would we expore? The code above must be in foo, frotz, bar

The main worktree is found not from worktrees/*, but from the root of the gitdir.
>
> Additionally, [file exists {gitdir}] checks for the gitdir file in 
> the current working directory. Since the function has not yet 
> switched to $_gitdir when this check runs, it is almost impossible 
> to find the file. Consequently, this logic never triggers, preventing 
> linked worktrees from being recognized. 
>
> Maybe the identification of linked worktree should not directly look 
> for the gitdir file, but should check whether there is a.git file and 
> its content points to... /.git/worktrees/... ? Anyways, using the 
> literal {gitdir} to search in the current directory lead to risks. 
>
> Shroom
>
We cannot get to this code if not inside the gitdir, and if the user set GIT_DIR and/or
GIT_WORK_TREE to do something clever, that either worked or the code already threw an
error. git, without GIT_WORK_TREE set, uses the current directory as the worktree, or the
parent directory containing .git. So, we must be inside the gitdir if this code path gets hit.

Mark

Mark
