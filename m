Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28833436D
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599624; cv=none; b=IGO0DgJbQSxUfxgYzc4n5LQXWbG24aSketYJiEMwMmp7HsHDGrdCvPeGBj8YmVFpGqes85OXX6I8GVwymjiRy8SUsaOssk0f5u2FQz4aaCJ8zUjwhuFEE+lw5cKDTSqJYoTeYr7VAxsHNNNkITacG4RKr0yti96FtD5A+ZF1Aic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599624; c=relaxed/simple;
	bh=z9QtfO6CJXVt8EkoPxpqqyQTMUYoIPOUDcu9dJ6jBvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eq7DCHVsXA7zJKLvdWgaKY/3qqEc0dY4RtxdMAxKvxvLF/3JV+5xhPxwItCE7+Dw9q5QCtOjm/nPbcjUVoaC1DJ9uLwlNrbFYnEcP+s671VMO+f7O6/PS5bUgz5c0GxKX5+5OZYy+BOLXal5hvBc2nLHPbQEK99nJ6vt3OqGV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+IGsyb/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+IGsyb/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8173e8effa1so48542785a.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757599621; x=1758204421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UMmhFxn1CVUNEzjSqQdawFTMBskbuKyRGdI/C9GXZA=;
        b=R+IGsyb/JseB1cWnkCmQGBiwz+6ieX7uLHg4AcSJygG1sLMcizTKu8IuBXkxirLHUU
         3z2oCc1l2ZQ9Azp5zO9wm30ZT70ApdXCmw/wQ/zzUbt2VuC54u/J7Ou5xAbzRTZErcA8
         QY6WqEd/Fi1+HCLgX9f8CtGy3GfCjy/FIaP5Akh3vL+MdtlIn+8g43y34gxdn56ehpKv
         S3ox4CMfuEZT5MLz8PqKQCI+AnAbUdzbK4eTwoSC0H+X/yD5gox2jQX+/SaTUylEGmLi
         MgcxDjgr4NgFJ0EdyMKS+KZ9j6fOMPLPacfSEynhL3cw8AXMHpZjzlfm1zV6ru80MMpa
         g9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599621; x=1758204421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UMmhFxn1CVUNEzjSqQdawFTMBskbuKyRGdI/C9GXZA=;
        b=BF+HTOidqF1Erz5PVHsTfYfAVtXfjvdpmYVn2ivn0k536xQ9rWIEK4RCJ6c3AB40xs
         TI47yJgTNH18cXbWN48aDZzvNXbrwHRVYvw032N1JbgjJrsSh4EZIlCZiuy2lOBb0gqs
         aWeQVua1D88rJTIrypOUZ6EFb1CVR8RSc8PdYnuJuyO5VTAkuFGd5ymYw//66zBQMduH
         QQ6Zh6C63pCxyKHye0d29027GcAf8comwL2sFzHIOapD3hSKdhhfgQ8StNFe52GhgNb6
         1TXZLfmL0hP9p3y2iSE9UyLPaEnOlMQs6RPggSdBeQAT29OlvoKOPdOfV9kXsJGVS10B
         Thwg==
X-Gm-Message-State: AOJu0YwcEZaqxT1QtgxC6qySO1RSOcEiMyPfwSSTk/mctycvlFWEKnAp
	UBNIIiuYGCaacZIKq/9QpITq628HUOgtz7h1nvQz8KOPDd5vJsMpe4tT
X-Gm-Gg: ASbGnctpFPV0PX9+MWl92mva6s6i3zicXS29CSkDZD3Gtt7xRK/NTkLIy8kGQoCjy+p
	JRcOtXBXr+bcxMpp8+lNCKmjVZWVHRzYlx368nAvE25RkJNnYGBVPF3/10npvFi94KiQOjTzEW9
	qZN8d0zO+zdT6ogwZ2ih5iop5O2POOYW0BPDrNyrN6qzIn52EvCZKuT8T2sLSfxi8Sec9pH+8oJ
	Rme5U3F2OyLPoEONiE8t+NpDoopnjhPpGJw2EMoF4aTUTBP8sPehtqiNcMsuTZqqXrd9cYKq4YF
	CGZHhqK0Mcuijr23dCHqPI06dqvdhXZYfo32EHloP9N9z6D/RwjliMOJZ245Vh0JeWKIu2ox8h4
	PJvZSdA/L0A16af9Qkh9TDrXVke1xz8Az9vL0DTT917aVo3UAj9Ynwrol0A4T0XJqf+eMm9erZ4
	xv/fsRieIohM8ebowFWHI4
X-Google-Smtp-Source: AGHT+IGUXcne+IWRNwcj6sYpml5aKQIbTPXuRX7xlG5wyMqjKUijXRc+UPzjcu6YP1VWOBucv6QMBA==
X-Received: by 2002:a05:620a:4515:b0:818:2b52:2315 with SMTP id af79cd13be357-8182b522920mr1790985985a.49.1757599620210;
        Thu, 11 Sep 2025 07:07:00 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:5913:c7c1:28e1:c1ec? ([2605:a601:a6de:d300:5913:c7c1:28e1:c1ec])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763c131f7bdsm11065166d6.70.2025.09.11.07.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:06:59 -0700 (PDT)
Message-ID: <879b6673-1af9-4bb3-add3-a61c87d98777@gmail.com>
Date: Thu, 11 Sep 2025 10:06:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] sparse-checkout: add --verbose option to 'clean'
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <f464bb5ed6be91940c3abb54b77cb7b9d893bd67.1752716054.git.gitgitgadget@gmail.com>
 <CABPp-BFaPG1YpGOcTm=aX6n1XZ3upQ4iYB=nNND4bvsNZ=CqqQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFaPG1YpGOcTm=aX6n1XZ3upQ4iYB=nNND4bvsNZ=CqqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/5/25 6:22 PM, Elijah Newren wrote:
> On Wed, Jul 16, 2025 at 6:34 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The 'git sparse-checkout clean' subcommand is focused on directories,
>> deleting any tracked sparse directories to clean up the worktree and
>> make the sparse index feature work optimally.
>>
>> However, this directory-focused approach can leave users wondering why
>> those directories exist at all. In my experience, these files are left
>> over due to ignore or exclude patterns, Windows file handles, or
>> possibly merge conflict resolutions.
> 
> Seems reasonable.  And based on your previous testcases, it might not
> even be merge conflict resolutions, but just someone placing a
> (possibly-modified) copy of a tracked file back into the directory.
> 
> (I've seen folks do that, so it's not "just" your testcase doing
> something unusual.)
> 
>> Add a new '--verbose' option for users to see all the files that are
>> being deleted (with '--force') or would be deleted (with '--dry-run').
> 
> Does that answer the users' question?  You said above in your
> experience it came from a few different reasons; will users want to
> know which reason(s) for which files, or will they only want to know
> the files that are present?

I've had users asking for answers to both of these questions:

  1. What files will this remove? (I want to make sure it won't remove
     something I care about.)

  2. What files were causing my sparse index to expand? (I want to
     understand how my workflow impacts this behavior.)

> You stated in the commit message that "users wonder...why those
> directories exist at all."  Presuming that listing files is sufficient
> to answer those users questions, this patch looks good to me.  I'm
> unsure if that answers the question, or if some kind of classification
> of the files would also be wanted (ignored, untracked, conflicted,
> tracked-with-unstaged-changes, tracked-wtih-no-changes,
> tracked-with-staged-changes).  Maybe the answer is we start with this
> and wait for user feedback and only add more if there's demand, but if
> so it might be nice to state as much in the commit message.

Sounds like a plan. This verbose output is intended to be human-
readable and can easily be expanded in the future.

Thanks,
-Stolee

