Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD003375BD
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598755; cv=none; b=UIY5qrNisD3xMT6uoek8PddoFANjX3IyYMaLf8jYg52xe6HoEsC4hUb3z3huo4Cs2LYIiQU+86kVnaPxpWIwPw63kUC4DRiO/D8ZtmUV5SZLFP5o0GTg8Ljc61tm83g8MkaElkf8KnD+fAMQH2CMzq8k4RjjOwsiaf4o7APA9Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598755; c=relaxed/simple;
	bh=QKNH3RzTO82ZkwTTscOcbwW2fKi+qQfZXMPt9KmUF58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go5vy6ToiNKUsNPsjN6OGfj1Epd9XQdeDMLzDosalzYyzHOaDI8xoALesbijXJ+X96pHzZdEHkY7kuLDRbvYDE+OUaFn37oQwuKB96faPFiYSScMnxXHuEiPSTVEz/Bv3ZiO1b+18jJSMQMHm/XORZ/FwE3N09rbSZGUpwk7CBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4oIdyLv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4oIdyLv"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b490287648so13623851cf.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598753; x=1758203553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJWEFRl1Hz2PlyAApC6sE/5AhXXFNltgjiyeNLXfmBE=;
        b=S4oIdyLv9Xf/e5gdJc2S6Gp2rohJhH2Cuyg0TDfM1r7Hc/2j/a9VxuNSQFOiDLaq36
         UXLhC1OwpluJ7m9FYlhoZAdrgXFyV/4SS5kv8UYMd8vsXpRwsqbIafdhPdFDi+HDFG7H
         q5c16jMTctZXeZlEOCo6jF+ndyrHpI5fg1wGw7KWLD5cfyqJS8dnACz/IjOVbTuDmKkn
         jUKwUO9FX0eKSN4HvInsr5uOnu4PHF38vr+u7xOPCnYwAI9rYRJNvD7iQGfqGQB2tYB+
         fxcI2SyyFq5r3W/7NCrdLPU9ZnMp3A0OgFuXTOuMsy8vgZ81vXTJAnLT4ORf+FqpVFuU
         dGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598753; x=1758203553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJWEFRl1Hz2PlyAApC6sE/5AhXXFNltgjiyeNLXfmBE=;
        b=KpWS/DpgQ+CXVgh/Ojsn1uYvtEkZlxZFX+OR2O6gvxrV2CODA+WNEM0+Umlh4575Ei
         88x6ggVkXVTNJNqFy5kUueJMj0ym1EpufLNA0aeMHrhzb01pvfP0hIjjBi+5Jg0RxIkS
         OgMfAfz5ZzzICaCJxgr70+rkZKIJgJ/H3dwPFDeDLDO1gHFFyUoMgAyJ6dz31kqaEwI2
         WstgzgBKpEQMCe9CuucyHTBSIeLn4B4wcmNAv16gDCc3hLfB/kWGRfcILK0B9dVALOCI
         eSayOnPAVjvlVPN8e7bD/75wA9jPLRMIS0zcU5gbSwt/ELw+8Sh857BSTjkwccGGwnSo
         ousQ==
X-Gm-Message-State: AOJu0YxyfW2uWzQ9splxvGV757yIhc8pmVOLQUoyhjTsgU/EMIwAD4yU
	a5Jr1IyWf6NsyG3J8suLMKHtuScaeUdEbrfL0xl6Qg9FIx5g8ThE/HBucJ+YQw==
X-Gm-Gg: ASbGncu6R1x8qgZaSY8vELpb8cEPFNBTWVwzhc8jDykZW9wPq9680EW+YMFHLmDq9zz
	YHIM0rsvNh/qecjngsCr4mZzAwLwLYBOP9P3lRs1+HZR8FQMp3+n5rEUyaiHNlB5P8AQZYk1LZK
	XyEVNQmluw+WfNU3pdrMgJLutGh1QwrtYFdyQEP7qtjIaxXiTqWU5OdGykStPHMZe6jcS9qSjKv
	lA6FcrZIXP19IEu9AJenRsLKbZuTwaw/8pq/MbQTt83Rv5G9gYrfJGrqa/p9MpdZPLuVK4GcaL5
	j8R6OsdBElati8Rr2A+ju+a3/3VJaVu4Z6R8cGL7F52hOO365LVeqvg12mLsJxNX7Z3y7YMVA9I
	7MAOP2AGqomkiMAgB4FXw7tHw1WlGJayeVg9i8X0G951AJFzIPZwey9H2RblPKlKKbcAf9gQcl5
	6EQ85TC7EtnM0N+4U=
X-Google-Smtp-Source: AGHT+IFbavzi3fwgBicP2Vd650aTbZH+9i5lh1YSSRlyPYvMcCh7KdSDNNsigi4G4OW0i6pVVMGgvw==
X-Received: by 2002:a05:622a:180a:b0:4b5:f59a:93f6 with SMTP id d75a77b69052e-4b5f8445b70mr288494791cf.50.1757598752817;
        Thu, 11 Sep 2025 06:52:32 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:d5ef:df1b:dc3e:13b8? ([2605:a601:a6de:d300:d5ef:df1b:dc3e:13b8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dcd8f8sm10414451cf.44.2025.09.11.06.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:52:32 -0700 (PDT)
Message-ID: <4ed3dd55-6eba-4cce-ba00-626f4d9cddab@gmail.com>
Date: Thu, 11 Sep 2025 09:52:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] sparse-checkout: match some 'clean' behavior
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <221f3e5fb0c56b75f8fbfa9f4aa34ae93fad0cdb.1752716054.git.gitgitgadget@gmail.com>
 <CABPp-BGQmoPQ9TOLjZPpPPEJ__0rsHgRMJ-nkiW4GcQjPCvaBA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGQmoPQ9TOLjZPpPPEJ__0rsHgRMJ-nkiW4GcQjPCvaBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/25 6:06 PM, Elijah Newren wrote:
> On Wed, Jul 16, 2025 at 6:34 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The 'git sparse-checkout clean' subcommand is somewhat similar to 'git
>> clean' in that it will delete files that should not be in the worktree.
>> The big difference is that it focuses on the directories that should not
>> be in the worktree due to cone-mode sparse-checkout. It also does not
>> discriminate in the kinds of files and focuses on deleting entire
>> directories.
>>
>> However, there are some restrictions that would be good to bring over
>> from 'git clean', specifically how it refuses to do anything without the
>> '-f'/'--force' or '-n'/'--dry-run' arguments. The 'clean.requireForce'
>> config can be set to 'false' to imply '--force'.
>>
>> Add this behavior to avoid accidental deletion of files that cannot be
>> recovered from Git.
> 
> I'm a bit surprised by this.  Given that the only kinds of files that
> this command cleans out are untracked and ignored files, and Junio's
> comments about clean.requireForce over in
> https://lore.kernel.org/git/xmqqv7o2togi.fsf@gitster.g/, I thought his
> comments could be interpreted as not wanting clean.requireForce to
> apply in more places.  Did I misunderstand?
> 
> Alternatively, maybe you thought that there were files other than
> untracked and ignored which `sparse-checkout clean` would clean up,
> and it was because of those files that we wanted the extra protection?
>   (In that case, it'd make sense, but it seems to go against what was
> demonstrated in the final testcase of the previous patch.)

My thought process here was that users expect 'git clean' to be extra
careful to prevent removing files. While Junio mentioned regret in
the decision to require the '-f', I didn't want to have such a major
difference between the two commands.

I also interpreted Junio's comments to be that he wished that
clean.requireForce was 'false' by default instead of the current
assumption of 'true' if unset.

I'm open to reviewers providing a firm stance towards "the new
command should deviate closer to how we wish 'git clean' worked"
and overriding my choice to match behavior.

Thanks,
-Stolee


