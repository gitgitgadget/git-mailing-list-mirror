Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D10145B25
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872953; cv=none; b=RdqBxEjeDB5TBE8a3VdI46SL1bIww9NEjfLvxlijrUCK4bAIr4AfKJeRp61oLcyfr4CBEz1pGOSox0X8RD/xkOgEUX1lF3k5wO1r4G3bnr828j9hNIJQOZ+yHSoK0foYQo04ank7FsOl6p6Dn986tmbLpDgen8ybzOpIpVAo8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872953; c=relaxed/simple;
	bh=iAt18CEJ0LqbwhsYs8JTF/pLoKq1On1XYiFNxx2LXvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah8qqekPRSvOZGoLFvHyQALKXLzT0LRP8tUFaaPRqBwNuprmMyvlrJOaJtJ/01U4dExA4r3JsitbiWowRX1feJrrDRR0FJDpZ7zx02FiKCqGymqhnECBG28CuriwbhAE6H1/Md9hPeu4PlMPk4nkrG9IxjE5BzAOuzF2qCLAbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIWlLwcJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIWlLwcJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso57349985e9.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 02:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739872949; x=1740477749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8FTDUhAjjkDa9oo0xIVpHCe84s2o+M6jdIZYHfOt9L8=;
        b=UIWlLwcJ4jBm8UB2ELdd52RSC+jRQBplLWNMgcayUWg5xvqJ6uLK3UYUufuyo4oPac
         p40O10I6wnHXJD72GJxetCmQtiI8xHQopg0j/GobDGwUXAiSMgzjjQNGYn0rhpXeQzCj
         hyGQ3UoLtUefPwSKY/bi4oXF3KMtMmSL+0NA6czQtXjwYZXlQwMgAhtQwFWY62/x8Hid
         tVK1y6pR0W6//STsg4NeFUMXYk8F82OvpQ7HWaI390ZeJI39LwE/DyMpceHfOkzGyZEM
         1T6lYBnq8nNfUIz4VXxuT/kiTFxjocE5+p7afoBQnyRO2mQ2BPKf3pegnINYZKrBFqV1
         KAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872949; x=1740477749;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8FTDUhAjjkDa9oo0xIVpHCe84s2o+M6jdIZYHfOt9L8=;
        b=ZxCjNRiQZGtqqMJjX0b+bvpE9+e+C3gstWBONeq2ni2mWzLpK3D4NfsZvWNKcadPXP
         mfLJ2W0895KB5LLXdDiX7mNYsg3HBn3AsVDvdjWoloPX2u3ND0NYfhVYRxxpQwN+x4ho
         yflqslwyyz+y9SlbQPyfxpc0VACWAMqiRr0RiG9zgOqESc7acVwlWknCM6p+fopGrAAk
         O/d7zZoWz9HzbO5N+9m6w5LKJpk5dzT259a/8zcOaXIrjhl08C49RNZT9vD2X2s0N/l2
         EZPZYg/7TDSw1DNznHsPHxCuGcw4vRROUo0kN+qOZ1XgalUeP4+Vzb70T/OCdJcirpEn
         h8SQ==
X-Gm-Message-State: AOJu0Yzw0cxqvnBTAe1jrWwR/SkUuBi4UU2dFy8dzIhdUDJ5NEWAfg80
	JIQW7FfF44m3XbYDDHJfDgSl3NNCFlqFfBGzLnCQqWWrtXcGxW4K4f/Y7TZmpDw=
X-Gm-Gg: ASbGncsNXHtIRMAQ63Gkbmwr5GXXm0LLgyvPz9umILNnQOIRTNnQD6lcj7TkRTwfE/H
	JDUyVo5MpxLcVm5gjhGKYbTY3BmzeAe8iwzO+JPelVyvMgNS+ONllsBzJfPc8MkPEciUjA0t7P7
	3q6bLItTpLSRMVTc1TWJ/k3HMCOkBrQbZYx91IWEX6p63GXZ8E2r2/1QQUPsT2njjdQooqEVI+y
	t2kRsAChdtF5L/ay76oQz6z+B41cjscCxMArY2l0cx0ZjxgCQ4YsFlcZQ3SBURt3d+deKpxVFlF
	eJWvNEbNRpnHGImMQW5E0SauLa6iz+Irpe0qMliURM3ea/JJ9uyRsO0s9Ws64a0FNi7NTw==
X-Google-Smtp-Source: AGHT+IHLYW4JdyO9ZYX6gJQ6tgoRf/5ypsNJyKh37nan3bCT0cTua2ApixE3jX8M8kjuEsm7awjOyA==
X-Received: by 2002:a05:600c:3151:b0:439:94f8:fc79 with SMTP id 5b1f17b1804b1-43994f8ff8amr18777215e9.0.1739872949257;
        Tue, 18 Feb 2025 02:02:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439872b59e9sm45229745e9.31.2025.02.18.02.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:02:28 -0800 (PST)
Message-ID: <1b6ba7c4-56e2-4892-93d3-d57c7193432d@gmail.com>
Date: Tue, 18 Feb 2025 10:02:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] merge-tree: improve docs for --stdin
To: Elijah Newren <newren@gmail.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
 <4c4168506346fa3eed3d01445980044bce6c14ab.1739723830.git.gitgitgadget@gmail.com>
 <CABPp-BG13wHuUKLZ6xAJn7z44HbNoO=4D71cY48vmBUnpfoiTg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BG13wHuUKLZ6xAJn7z44HbNoO=4D71cY48vmBUnpfoiTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

On 17/02/2025 20:26, Elijah Newren wrote:
> On Sun, Feb 16, 2025 at 8:37 AM Phillip Wood via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Also correct the
>> merge status documentation for --stdin as if the status is less than
>> zero "git merge-tree" dies before printing it.
> 
> This also makes sense, but...die'ing still has an exit status
> associated with it right?

It does, but that is documented in a separate section which says that if 
there is an error it exits with a code that isn't 0 or 1. The section 
I've altered is documenting what "git merge-tree --stdin" prints to 
stdout and if result.clean is less than zero then it dies it does not 
print anything to stdout.

Best Wishes

Phillip

>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   Documentation/git-merge-tree.txt | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
>> index 0b6a8a19b1f..efb16b4f27d 100644
>> --- a/Documentation/git-merge-tree.txt
>> +++ b/Documentation/git-merge-tree.txt
>> @@ -40,6 +40,11 @@ After the merge completes, a new toplevel tree object is created.  See
>>   OPTIONS
>>   -------
>>
>> +--stdin::
>> +       Read the commits to merge from the standard input rather than
>> +       the command-line. See <<INPUT,INPUT FORMAT>> below for more
>> +       information.  Implies `-z`.
>> +
>>   -z::
>>          Do not quote filenames in the <Conflicted file info> section,
>>          and end each filename with a NUL character rather than
>> @@ -116,8 +121,6 @@ This is an integer status followed by a NUL character.  The integer status is:
>>
>>        0: merge had conflicts
>>        1: merge was clean
>> -     <0: something prevented the merge from running (e.g. access to repository
>> -        objects denied by filesystem)
> 
> Should this line be kept but replace "<0" with "128" (the exit status of die)?
> 
>>
>>   [[OIDTLT]]
>>   OID of toplevel tree
>> @@ -235,6 +238,7 @@ with linkgit:git-merge[1]:
>>     * any messages that would have been printed to stdout (the
>>       <<IM,Informational messages>>)
>>
>> +[[INPUT]]
>>   INPUT FORMAT
>>   ------------
>>   'git merge-tree --stdin' input format is fully text based. Each line
>> --
>> gitgitgadget
> 

