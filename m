Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1A881E
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368720; cv=none; b=trdoiPyg/FUwdXdR8ZLw3B17jRfmDVvgEgBl8D0gdxXxCe9QaiJYbap3BWfY2ZEb4lx80/Y0YhK2/BOI1kap/HMVP529syMLi2GpchLckfo6VEa6GwG+TYiUHCrJad8i1tcQ2CbBDYa9KaWrGlD9rsnB+/6h8mki9tTLqjtER/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368720; c=relaxed/simple;
	bh=G/nr5xQlR6j1GMF/d0i/IphVyNVt2sdS56YqlaNorPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIwiKro8sqLuaEHDD+sXOySZqp/LB1TRUqEfVEziCEo8THTfwjLmns3q3m0MeFnnjeQSDhL43xaSt5thEcJeUlZn3fGZYRmqO3NhM3DplW+LhriWGBXMCex1w5J3cjv8LwCV1RwXh7/13Nv8MCked4R/ZHcSRnrRCCJRpMnglaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFn4P6XX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFn4P6XX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso6118045e9.0
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730368717; x=1730973517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yY4LFYy6ozSQMKOwX4EFdlh2VPvj9avNGuxw14OagYI=;
        b=GFn4P6XXIydQn5jXXkVOewRuuz6Tk5hA5AnMWw4H07y3JAAZKTWI9EwVIogArbijQF
         EqXSCbaxV1GWFGD4eS6bmzJOx2vnItzx448UaRgc+yedXKSBX26TSBZrWgaDxwxqO7L/
         /GJp8FLoUFG2pIyN5t53hcS1atKyV/2vSMxhRGEW6QBbH5Ygkwv6k7Ac3f/N02rr8IWJ
         OV66+/R+3+k4n6c0o3rEx3DSH0zoPlxUtsuE1TD0VDUQ3H/pt/PqIkGphaaABKbbAiXv
         ZdVWGL13xZbnuNU8uTynafljAYDoAOeaUDyyenYAOFW9UxElDmUlwLoZDtk0Id+od6UC
         neEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368717; x=1730973517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yY4LFYy6ozSQMKOwX4EFdlh2VPvj9avNGuxw14OagYI=;
        b=SAyWGdsDB7//86+luIaFC1Uf6brwBfHMAOPS4I4TrahC6kmm/FnwA6g7ZnlpGELn9Q
         cDEur3Us9cDAhB0MZuSZe1dJXWfbjhiUeg8G5W7n57NKcjcK6HuTJwvllb7oQk8+cshs
         pVpY3Ryfpxi8dzgNvpbQG1OJAP/2mYL7mIZME1hOkCu7hMl9o5s+ZQMzIwtmrFSCn7vs
         GpEXi/RqoEZVnx7rYzjqyCrSS40fE/fE8Wc0ruI7RBUgI1aiZq2oW4qgq+enPkXCGIVk
         W9ggiaBNw1k6SCiyLzWwr8SpxlVOaKFFdbQb0g6c5uAcFvBM0GBVUp8hvB80BFDqKm5j
         rhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuR539zScfZ0r5Hs3Dw8DQreWzOetAb0ouKCmXd18CjV1vbFgMBj4nWQ9FtcQGYXfmGmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPWaV2QJjasvDZxmkT9ZzlzqYtdYF23xEqSsK5BrVNymz2Vqf
	SlxCZmqahmCiOZzope8XsYAvp7P50PID3Tv2yEdvzEM1Q/d/csPJ
X-Google-Smtp-Source: AGHT+IElgZLcafD1Nz85iUVQWFWSsJrWb8L14XsqSPl26+VUxOtPeJ3sId2rW4bU3+Ecanx7CPBSSQ==
X-Received: by 2002:a05:600c:358e:b0:431:52f5:f497 with SMTP id 5b1f17b1804b1-4319ac956fdmr158540435e9.9.1730368716855;
        Thu, 31 Oct 2024 02:58:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49d4sm1624383f8f.34.2024.10.31.02.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:58:36 -0700 (PDT)
Message-ID: <3c081d3c-3f6f-45ff-b254-09f1cd6b7de5@gmail.com>
Date: Thu, 31 Oct 2024 09:58:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] merge: replace atoi() with strtol_i() for marker
 size validation
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <5d58c150efbed1a10e90dba10e18f8641d11a70f.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHH-oHE7g09xIR@pks.im> <e4a70501-af2d-450a-a232-4c7952196a74@gmail.com>
 <CAPSxiM-X3gk4tsVSJ_dFP2EGWX_dvFnqRp0rTYvhPxqYsUeijg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAPSxiM-X3gk4tsVSJ_dFP2EGWX_dvFnqRp0rTYvhPxqYsUeijg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Usman

On 30/10/2024 16:19, Usman Akinyemi wrote:
> On Wed, Oct 30, 2024 at 3:20 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 21/10/2024 13:20, Patrick Steinhardt wrote:
>>> On Fri, Oct 18, 2024 at 01:52:59PM +0000, Usman Akinyemi via GitGitGadget wrote:
>>>> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>>> These are a bit curious. As your test demonstrates, we retrieve the
>>> values from the "gitattributes" file. And given that the file tends to be
>>> checked into the repository, you can now basically break somebody elses
>>> commands by having an invalid value in there.
>>>
>>> That makes me think that we likely shouldn't die here. We may print a
>>> warning, but other than that we should likely continue and use the
>>> DEFAULT_CONFLICT_MARKER_SIZE.
>>
>> I think using a warning here is a good idea, we should probably fix the
>> whitespace attributes to do the same. If you have
>>
>>       * whitespace=indent-with-non-tab,tab-in-indent
>>
>> in .gitattributes then "git diff" dies with
>>
>>       fatal: cannot enforce both tab-in-indent and indent-with-non-tab
>>
>> Anyway that's not really related to this series but I thought I'd add it
>> as #leftoverbits for future reference.
>>
>> Thanks for working on this Usman, what is queued in next looks good to me.
> 
> I just checked it. I will be glad to work on it.

If you want to work on this that's great, but please don't feel any 
obligation to do so.

> I also noticed that the test used for testing used a different
> approach(test_must_fail) compared to the one I wrote which used
> test_grep. Should I change the test also ?

I'm not sure which test you are looking at but I assume it is using 
test_must_fail because the command being tested is expected to die. If 
we change the code to print a warning instead then we'd need to capture 
stderr and use test_grep or test_cmp. Note that we only want to print a 
warning when parsing .gitattributes, the other callers of 
parse_whitespace_rule() still want to die. Also we should decide what 
value to use when the user provides both - neither indent-with-non-tab 
or tab-in-indent are on by default so it's not clear exactly what we 
should do.

> Also, when should someone redirect a warning/failure into a file then
> use test_grep or just used test_must_fail ?

You must use test_must_fail if you expect a git command to fail, if you 
expect the command to print a warning but exit successfully you should 
not use test_must_fail. So if you expect a command to fail and print an 
error or warning then you'd do

     test_must_fail git my failing command 2>err &&
     test_grep "error message" err

test_must_fail checks that the command fails, but reports an error if 
the command is killed by a signal such as SIGSEV.

Best Wishes

Phillip

> Thank you
> Usman Akinyemi
>>
>> Best Wishes
>>
>> Phillip
>>
>>
>>> Patrick
>>>
>>
> 

