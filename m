Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8813B7B3
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897672; cv=none; b=nNapJYZinwCyH2rzJe5/3mPEgcxN7Gbc33hgNv0j86P6Fu3liYp9O42/FbaXFXqaCD5j8h8kwbE2QjaOdHIbz2QNGvMWb55hQBSgznHHOTcUNiGUpo0ZT2VQFIrO7L+rdYpnv3poLGbrH+p3P+819SBqHJuLswf9ITRhHYeA+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897672; c=relaxed/simple;
	bh=FA4uUpTqHP19Mf6nc9/WnLruY9bLHpvWcabal7bUMXc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hdE9IIljDeSts2DIhIwohins7VhRMF0BZhnMzXfOwCbDTYgn4DtY1i42DnvU7j96wBCGhDbZPC40Bq7Q4NhdEiyiSPNxScwtCSHxF4H5XdSLF+CghEYIHOWi5EEE90DrH7893RnnLDK/JkqfMBwswkdyBWNwFsvJRJ/COKE+gOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y53GhUnK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y53GhUnK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so1956164f8f.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739897668; x=1740502468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAmzzykjEYEgKDAuqO88jcdzNAkO9QkGQ0aIb42DcUo=;
        b=Y53GhUnKWWz2Ex+ewQrxvP1i2RLvgTDZ/iIPYAhrlrIf6Zbc2or0XZcX8BXvUeIsZG
         pMLJEUTDTG/kwXC9Yzwx3BMRGv+PFuBhMs6SJLZnykCf+l7O1EEkvYOYRTjIWrhXgqsY
         V8wnZcDqSnNtNkNvR7SIf2xPov4R/nLRIof3rr369oWwH19CElCuPv6s9SXEFcXLOxvM
         Q0oa0qWDuXJW9pVFpkbUK1dOelhuqg5WUdwQ+lOPbvS7NR3+VRv5FkalLVSF33m5J43Y
         XL8CbQJZTyyK1/i6EqTdzkRg+MFc8F/ftEUxZulExaCINzuTNz9LwUHQALPuich/4p4P
         mCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897668; x=1740502468;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAmzzykjEYEgKDAuqO88jcdzNAkO9QkGQ0aIb42DcUo=;
        b=JWzG9nUib7T0oTHKZchPYkMvLODFG/whiT8pGcwSnTAq7gztkzT7gYwmJbokjjnT1J
         TTx7BGxYkQH+OlvjXvuT9UiJeYFNTq0xRb7aO4Dn5IL1lGQ9WxELaBhK3IHp3wkLOvBv
         BNTnwpdy5Y7Rr+a+HsD53e3gBYviIEvdeDSb/vzxA79jBtfJIz5Vm+f3X9w/JcmAYv3e
         YYFpt8R3ZDCgxyzoJo7lKbhoPkzQq560R1fj9wYrophnRGHeybwUojqiVrfq3MheFy8/
         n8ejZASUGT67NeQ5kSASHv6mZrMqdmSHqmRG6LZ9T5rlPCVL89uYCvynKu859B3BkmAA
         rERA==
X-Gm-Message-State: AOJu0YxgwzxY7fGWEDVBRJUmh9wMX42H1YO3vs1pTOjLum0x6BCyWYmy
	CiDiueeaEqAoyvUD6sxq9AFNwnsYSWKwKgG4gd7Tzp6qD2vSBuMR
X-Gm-Gg: ASbGncti7RmiaJkPGkWHMLPqtR1CmBeBmoa4aDvCYEVLOXfQOwBXXwIYSVVOStcvfri
	aRKjtK3C8OHuOwcmatglIzq4RN5U3fh/H12lfrHU8oU/v66xpZs5kzlcjWgLXGC2Vujf7IXg1iZ
	w6e8fzjgf0bIimGEX5Z6YaAblPG+Mg73GgoEu4IrZ8YN73tCm09PqISnzr1jjB+UlwF27VBefdC
	ho7TPyHpVRadYdGpOV04zyMPsS3YUGuoPZ5SVppgVrNeomld/2cy0mOPyFWo4NlBt6eryQuw86/
	AROfFERt9tkor+yb8qjsyOvR8GRge4feKigGYmyAIeloM/i+KUWvXWO7HDsvvfhDg3yF3g==
X-Google-Smtp-Source: AGHT+IF3twZMjAQnvrp4Ps5QwT/riH2dAUexVuVrENB5X1owlM8OO53gNraf2Q9jRHSb+1csB58hfw==
X-Received: by 2002:a5d:5f4b:0:b0:38f:4e6e:22 with SMTP id ffacd0b85a97d-38f587f3ca4mr144638f8f.48.1739897668354;
        Tue, 18 Feb 2025 08:54:28 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm15472664f8f.76.2025.02.18.08.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:54:27 -0800 (PST)
Message-ID: <a0281e37-d025-4ef4-89dc-49d5f88c0ef0@gmail.com>
Date: Tue, 18 Feb 2025 16:54:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] merge-tree --stdin: flush stdout
To: Elijah Newren <newren@gmail.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com>
 <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
 <CABPp-BE3NtP463P4R+stzcQ_MufjobL-CX-rB=0m5gC0DzA9ww@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BE3NtP463P4R+stzcQ_MufjobL-CX-rB=0m5gC0DzA9ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2025 16:46, Elijah Newren wrote:
> On Tue, Feb 18, 2025 at 8:24 AM Phillip Wood via GitGitGadget
>> Range-diff vs v1:
>>
>>   1:  3b317978509 = 1:  3b317978509 merge-tree --stdin: flush stdout to avoid deadlock
>>   2:  16fec87766f ! 2:  63b09dbe1b7 merge-tree: remove redundant code
>>       @@ Commit message
>>
>>            real_merge() only ever returns "0" or "1" as it dies if the merge status
>>            is less than zero. Therefore the check for "result < 0" is redundant and
>>       -    the result variable is not needed.
>>       +    the result variable is not needed. The return value of real_merge() is
>>       +    ignored because exit status of "git merge-tree --stdin" is "0" for both
>>       +    successful and conflicted merges (the status of each merge is written to
>>       +    stdout). The return type of real_merge() is not changed as it is used
>>       +    for the program's exit status when "--stdin" is not given.
>>
>>            Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>>   3:  bf1dc603a15 = 3:  f95a15a4203 merge-tree: only use basic merge config
>>   4:  4c416850634 = 4:  1645b0e747e merge-tree: improve docs for --stdin
>>   5:  89722894c87 = 5:  a0179820092 merge-tree: fix link formatting in html docs
> 
> This round looks good to me; thanks.

That's great, thanks very much for reviewing these patches

Best Wishes

Phillip
