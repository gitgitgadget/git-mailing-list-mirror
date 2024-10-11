Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBD20A5F0
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638271; cv=none; b=cGEJQQKBdcGsrdbyJyfme4WvVcos8quDxMD75DSmioIV2T7Bj0mYQfSOUs46G9/UvgbkyLt+yzcAYPgta+NnRwcxpFEw4cNqyAi9Cv6c06yyCVlI966ggVX2QTcUYvff+IuFomw2P3e4poVPKdSDvovsxNCJe7AYutqHhjpAVpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638271; c=relaxed/simple;
	bh=iH9n54je3He0pvRuFjHyOR9rX6kWWZ+Lz664UHHvN2M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tAe/3MiJTjIyTWgfDTD4BrulJvH8fl2VQSSHRYthJ8yp6AIVvgw86BcqIaL+YNMEB1Ft1uWH8ix46vNlXaGDlg7NX2tblXPkHcMX4epRwfzvGgYFJNf50MSxhBk4W8W3zK7rmpiyO2f6Jm5yPN5xjN3itcaA6QeQUuCf5zh2Mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AneA9huh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AneA9huh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4305413aec9so16455025e9.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728638268; x=1729243068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oPo9OgWlAcLVjTHJrY5JFnMfQVObA/dsjhBvZrz+Is=;
        b=AneA9huhKWQ7Arf2EEG1Gqn+RCAkkZKY8MG9FzlIlZhqQ4dCtUZnakrFp3NnPPfiSO
         uv7wQKScwhOALDvVMgu8a1226B5Hxe80uabEGAcMN0BxMM8BQuAV35h/hiM1eQC5cdnr
         6L18CCW6QxqqaodOK1yykdMjyMT7JzwjfDbklgkB112pGqbWhQIR/3wd70nFGABv/cd3
         NbwNaSzHqqRV7UvySNdm/E2KMSoY9duBrmRAX49j/cn92LgIS5Pz2Owq3pW61Lo+ge1C
         Y1O0Ze+t2oBNkx92UROY+PUgZIINyjkpL2j3YPGXETDUnrwNVAkMlgeo4sK+jvsNodfe
         OgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728638268; x=1729243068;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oPo9OgWlAcLVjTHJrY5JFnMfQVObA/dsjhBvZrz+Is=;
        b=aiBTGnb1c/5AC2qYWmUQozPAJuAe99y5LcLv/Pf56Bcd6RUWuLgunv/f2i02oIPpgy
         Tm68xxL9NOkO9d3KBbcJbRhtQ+l9NRQjsp1J4Veyl2420IHcaomW2aLAwOdFIdhIOtLy
         8gcDKC/2xwXi9LsnYWtsH7RlzzZ0g4sGsF4ViODUU4ZGe/m6+bBaikH4dBXOfZ7uNnUG
         4xCi5cOKRVAVPsWhqj8TBq6jnZuVKYdxLcAdVClZX/b9BU2EI7gwQqbwZMKYlU4I7vgR
         1SlnR1+DGY9x+XBIwEPkk5Xp4P8DQ3/cqfbTPhHKYFK0oIvBliU5nG0ClMXPxNbXFN/p
         +I5w==
X-Gm-Message-State: AOJu0YwWUX3h/XO1XXJtbBVHIaExrdKRCRpi0fImI9ikrSM4Fc049wTl
	J+WsQt7LqLj5qVYlfy30oEQX1T6ipLUdSv9RP4y04LFVg+45DDBo
X-Google-Smtp-Source: AGHT+IFlipL0lXy6Z9djLBXbbfU4jbm2Z0tNTZxbiLptXrEVa6VxgaWKvPVSMp9PGSYZRLp1UKuptQ==
X-Received: by 2002:a05:600c:548a:b0:431:157a:986e with SMTP id 5b1f17b1804b1-4311dee8220mr13281605e9.20.1728638268024;
        Fri, 11 Oct 2024 02:17:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4674sm69479215e9.38.2024.10.11.02.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 02:17:47 -0700 (PDT)
Message-ID: <712557bd-f3f1-4489-95df-a55f90f1dbda@gmail.com>
Date: Fri, 11 Oct 2024 10:17:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v2] t6050: avoid pipes with downstream Git
 commands
To: Chizoba ODINAKA <chizobajames21@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, ps@pks.im
References: <20241008162117.6452-1-chizobajames21@gmail.com>
 <20241010063906.51767-1-chizobajames21@gmail.com>
 <90dea722-0762-4a37-a216-6883f4889c67@gmail.com>
 <CACwP9aqEoRchNN-4iuSxrhtt5k-yHMsjmyQjaG9uV4xUsQ7geg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACwP9aqEoRchNN-4iuSxrhtt5k-yHMsjmyQjaG9uV4xUsQ7geg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chizoba

On 10/10/2024 19:51, Chizoba ODINAKA wrote:
> On Thu, 10 Oct 2024 at 15:08, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 10/10/2024 07:39, chizobajames21@gmail.com wrote:
>>> From: Chizoba ODINAKA <chizobajames21@gmail.com>
>>>
>>> In order not to loss the entire result code of tests,
>>> write output of upstreams into a file.
>>
>> We're interested in checking the exit code of git, but not other
>> commands so it would be helpful to make that clear. Usman's patch [1]
>> has a good explanation of this.
>>
> I just read that sentence again, it obviously needs some clarity. "In order not
> to miss the exit code of any Git command, avoid using pipe and write
> output into a file"
> has more clarity. I will look up on Usman's patch [1], before my next changes.
> 
>> This patch also changes instances of "grep" to "test_grep" so the commit
>> message needs to explain the reason for that change which is that it
>> gives a better debugging experience if the test fails.
>>
> I had included that in my "Changes in v2", appended beneath my "Sign-off-by".
> "Changes in v2:
> - split multiple commands chain on the same line across multiple line,
>    for easier readability
> - replace "grep" with "test_grep", for more context in case of a "grep"
>    failure"
> Maybe it was not so obvious that you didn't notice, or it is not the
> traditional way of including it.

It's great that you listed the changes between versions below the "---" 
line - that is really helpful for reviewers. However those comments are 
not part of the commit message when the patch is applied. It is 
important for the commit message to explain the reasons for all the 
changes in a patch so that someone reading it later can understand why 
the change was made. Therefore the grep->test_grep change should be 
explained in the commit message. In general one should avoid making 
unrelated changes in the same commit. In this case I think one can argue 
that the changes are small enough that combining them is fine.

> Thanks Philip for the review, I will make the needed changes in my
> next patch.

That's great, I look forward to reviewing it

> And look into
> the index-pack proposal in a new patch, since it is outside this scope.

Let's finish this patch first. I'm not sure what the best way to improve 
that test is at the moment.

Best Wishes

Phillip
