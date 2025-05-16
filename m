Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CA235069
	for <git@vger.kernel.org>; Fri, 16 May 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399787; cv=none; b=Uc86mNFUbaTtoWh5AoQzvkwVOwNE7NuWm3cBJ9E5q2oLe/et2WQeeLFju/NsC7btJOdk0CYfQUXsDAAdy5KmgHgrR1j6pM3o9VZGnbn1L8XQeoZ0HuEcjXGpjOotFHjOXSt4YAtJTG4MmgSP2YtsyvGsk5IhY/vHEcNGTIe6Miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399787; c=relaxed/simple;
	bh=sdxVV9V/zH36/2Z9HeZ2bH7SCZ37jZAHMb5aL5TJFcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkEnJMjQrmvUWlo8InDCdjUUh39QPqrZmEOalbNPytt5kA7+X+gCAlfjY5MOGGr3SvepOExDEItddBNGcj228TtcNdBl81eiHBq1HCjxvVrJhTdDaBCnKlpRmMsFS1xTUdT3+AB+uYL99oirpC+qy2hArEdgGt54/SzA4A8LXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlZxv2sc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlZxv2sc"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70a23f4fe8bso18926287b3.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747399785; x=1748004585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Owfx0CXnmkvfpKWlY7p3IDr+9bhJI4bcSLKjDLb8jAs=;
        b=nlZxv2scKqU9Vlk2oTfG+Ujp+RjlILHtMX/5JeMWPAoh+VObsuCE3JVsw1DwUj2a9+
         q5jfrlU3XArdgZQN0IRNxZerfrUp7xpSdTefzeqatn+iyXLbi+sP7x68IpVqaGKwERom
         h0crSyFG0xJ/hdcYFQg9KLjNDCug9X5uOhFkauPtUX2yDYweT8i3v0KxV652X4SvMrEj
         cLZPdO6GPqZjotVb+w0n6cdDaud2FQ4zIOuRcoSs/Cyj2arNT3KAx7pE+iWYjKKtDHPu
         1ucoS4IEPzwaeCjrYDSgjH0eC1Sb6zeG6ndVnNGP2HKREOQhgsG9j/DEcRylYKoAUNFC
         XUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399785; x=1748004585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owfx0CXnmkvfpKWlY7p3IDr+9bhJI4bcSLKjDLb8jAs=;
        b=N3j0xuBtjX5ihs+5Tn3gCQI6hVavvZvYe5YJ3P4SVh8GhE2y7ScEqDG1kPj6bgpACH
         UBeY81XUIWEJ1wbuPwoU5LYo5hYKE+WG5uVWzoN7sJstXpY44RRi70gieegf1u3h7/n3
         p0rNeUQtjneMNzvIYZs33ankkESWNk6OohGt5c10ZiS4R6zILVgX7YxqpjQItL7p90rd
         mPX/+Uv2CpxpUV7uG0n/l2GRzmfs+9tJaW4tNZdFApZFkdgm0XmojYRhY+AbRwifMDUi
         LtUDZFtTbK1a6TzIG8DylzkiLp4bMCVkmLZ7rpgAyE0LgB6VjhS4Q69Er8iAlb3Dp0bG
         z0DA==
X-Gm-Message-State: AOJu0YwLwzTWdHQ6eL8gksQ5viLNrb79+lKhVExQ7eTR/0LrLfb5OB1k
	JCXFUIOswsBpu84eLVaUHF4tWILV32yrQZlIirQQD2GvcE6OHLw2fzqO
X-Gm-Gg: ASbGncsHiahtbBwDHAlSBKwNsdzNsrgxTOqliGj6obNy5SvE0Y6cj0QTmx1bTeqD5Vp
	lBsSU2yWMJ+AKvaYijAoxWl8O9PuthI0uLlguTa8qRf1NqFdXgVeAVSJokY+3ZxP0Mbs1Nm5Lav
	uJYmlwtfdKQEkWv8kL4PpIAlDERpK2df0BY9DEH4rZZDXvM9CEOVJx86pmpsW/EiLNCLqOTtGMN
	DGsUp3Wp8PDQ4aA+LzWOLf/oWNxbAc2ROuA6woXodJulhGhVQ2AFRVNzqFJf4Gk7QL02drTk4lw
	UpOQKwpxESQtygmFpGxks8/kBpzLwjOdqPKblsIl/dBuNmQBnOOZ6gVHbfOI12j8wouZuwlIoTP
	Dq/dp6u2+XioWE4TkBDugo7M/OhCl5BKmysxhVLw=
X-Google-Smtp-Source: AGHT+IGCJy89i/oxjq73Rz4DBpFzcWXlj/Gv9RHkeGjLEy5b1MwXceM2Cj2bOOx5iXZL4MBwx957WQ==
X-Received: by 2002:a05:690c:618a:b0:706:aee5:162a with SMTP id 00721157ae682-70ca7c54d05mr48471577b3.36.1747399784487;
        Fri, 16 May 2025 05:49:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca831de79sm3875517b3.32.2025.05.16.05.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:49:43 -0700 (PDT)
Message-ID: <3c4ef12a-3ad4-4078-a513-473f13a670fb@gmail.com>
Date: Fri, 16 May 2025 08:49:43 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] apply: integrate with the sparse index
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
 <0e6e199cd19ef186fb10b192529269cafc47805a.1746579321.git.gitgitgadget@gmail.com>
 <CABPp-BHkgvc0UQbhXfP4POtY8GPVpz9J8ZbX3_jyzL_V7GyBbA@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHkgvc0UQbhXfP4POtY8GPVpz9J8ZbX3_jyzL_V7GyBbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/9/25 11:18 PM, Elijah Newren wrote:
> On Tue, May 6, 2025 at 5:55 PM Derrick Stolee via GitGitGadget


>> +       # Expands when using --index.
>> +       ensure_expanded apply --index ../patch-outside &&
>> +       git -C sparse-index reset --hard &&
> 
> All makes sense up to here.
> 
>> +
>> +       # Does not expand when using --cached.
>> +       ensure_not_expanded apply --cached ../patch-outside
> 
> Wait, what?  That makes no sense.
> 
> After some digging, I see why the test passed, but it's very
> misleading.  Just before this command, if you ran the following
> commands from the sparse-index directory, you'd see the following:
> 
> $ rm testme
> $ GIT_TRACE2_EVENT=$(pwd)/testme git apply --cached ../patch-outside
> $ grep ensure_full_index testme
> $
> 
> Which matches what you were testing and shows why it passed for you.
> But I'd argue the test is not correct and confusing for anyone that
> reads it, because:
> 
> $ git ls-files -s --sparse | grep folder2
> 040000 cb4007891397aa2a451037d1c69e57f0cf498c24 0    folder2/0/
> 100644 78981922613b2afb6025042ff6bd878ac1994e85 0    folder2/a
> 
> In other words, the index was *already* (partially) expanded by the
> `git apply --index`, and the `git reset --hard` did not fix that
> contrary to expectations.  Continuing from here we see:
> 
> $ git reset --hard
> HEAD is now at 703fd3e initial commit
> $ git ls-files -s --sparse | grep folder2
> 040000 cb4007891397aa2a451037d1c69e57f0cf498c24 0    folder2/0/
> 100644 78981922613b2afb6025042ff6bd878ac1994e85 0    folder2/a
> $ git sparse-checkout reapply
> $ git ls-files -s --sparse | grep folder2
> 040000 123706f6fc38949628eaf0483edbf97ba21123ae 0    folder2/
> 
> So, we need to do a `git sparse-checkout reapply` to make sure we were
> actually in the expected fully sparse state.  From here...
> 
> $ rm testme
> $ GIT_TRACE2_EVENT=$(pwd)/testme git apply --cached ../patch-outside
> $ grep ensure_full_index testme
> {"event":"region_enter","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c","thread":"main","time":"2025-05-10T03:08:56.856008Z","file":"sparse-index.c","line":372,"repo":1,"nesting":1,"category":"index","label":"ensure_full_index"}
> {"event":"region_leave","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c","thread":"main","time":"2025-05-10T03:08:56.856454Z","file":"sparse-index.c","line":455,"repo":1,"t_rel":0.000446,"nesting":1,"category":"index","label":"ensure_full_index"}
> {"event":"region_enter","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c","thread":"main","time":"2025-05-10T03:08:56.857016Z","file":"sparse-index.c","line":372,"repo":1,"nesting":1,"category":"index","label":"ensure_full_index"}
> {"event":"region_leave","sid":"20250510T030856.854763Z-H8ec63c79-P0000371c","thread":"main","time":"2025-05-10T03:08:56.857135Z","file":"sparse-index.c","line":455,"repo":1,"t_rel":0.000119,"nesting":1,"category":"index","label":"ensure_full_index"}
> 
> So, indeed, `git apply --cached ../patch-outside` DOES expand the
> index, as I expected.  It has to when folder2/ is a directory in the
> index, so that we can get a folder2/a entry that we can modify.  And
> that's just what we see:
> 
> $ git ls-files -s --sparse | grep folder2
> 040000 cb4007891397aa2a451037d1c69e57f0cf498c24 0    folder2/0/
> 100644 50f4ca4e6265a0497ec2ee6782648138914ad398 0    folder2/a
> 
> 
> Can you add a `git sparse-checkout reapply` right after your `git
> reset --hard`, and then switch the ensure_not_expanded to
> ensure_expanded for the apply --cached call?

Thanks for digging in here. I'm going to augment the test to
include both the ensure_expanded and ensure_not_expanded so we
get the extra coverage for these two scenarios.

Thanks for the careful eye!
-Stolee

