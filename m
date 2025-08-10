Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9852F9D9
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754831996; cv=none; b=nrwCr8ldWcAWj6vk7yXYyeQ1m8vB2Z6JVBroVjhb1i6hJQdHNPAxd62q5Zjm2+daHQLRTiL+R1qmAOGgaWvwIQkrpduI482BfTBOULCoagA10NSYpRBGDQhgpHRVB+WttmucLlUUAVqtH90xentvt4nsCeB5HJvyyxXEHi7cA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754831996; c=relaxed/simple;
	bh=1Z8NWsZyfF4P7i9JmVeaxvOvTqJlmZqWPIF2IBSg/v4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XvlTWFgsD7MhJlvnyGxdZvsbVyn5mogJZtlHI/YAhIZ722Drjgl+1yGV95UAENccZJCb5AJIua3L6onJryWS3lqkycAO7rbAMQHu6g5O8pDTZAquJby0Oa6lsbt3Qn9rgqnVBDZoywSJwIUMO4otHmgU5uBpB9WgsdaJ/w+n6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPUIJk5G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPUIJk5G"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so2130730f8f.3
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754831993; x=1755436793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DcvEtJEZinoZKPE1/oc/HSjQD30pBNguXUUtgzNe/7w=;
        b=GPUIJk5GyybisV9/RgcIG31iDOG/TNNPJK6des8u5nC8s+fHd9bsiu1o6ibcbrhwv2
         mlBOL6S0jeroE5mnle90+aKjN1IeazKZ6QYOaEJOpWw+YReWsdGjaIiSZDv66SNQE2R3
         vWIcpvMcsGj5XHJw+dQkXaJ7KcydJIwV9sJPXIj05Ak0PYDL99bi3mRGI+Vw2FT8f4Da
         EHsyfMI95Fa6L+sbqyNK122lwHHUsinA6QVWyrf+ivIlF725enzAR60+LfksuhZFMr8E
         QXe+g8IfYj8sw4RcMsX0SFjGW16v0lUfTmFw3iqc0mjgflJcc0v+vtr08aipI/zCU8t4
         JBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754831993; x=1755436793;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcvEtJEZinoZKPE1/oc/HSjQD30pBNguXUUtgzNe/7w=;
        b=lpWjQt8EH37PVsZtijbwuBDE/u4ejGOnj75teyjjzTcoJ7zVQSx4iStoffVPGYKk+3
         18lkM8NLzpA2Fg91PC0UVR1xUDd0g2lsuP/kVEBGkM0OrBttoOr+u3VDaznFDnxyzCEX
         1U2q7gXUG7OKEJqJsfYbLZc43bZrzAzvzovg7bqivPwIvRY/EIXBaai1ctkFv3qDK3zx
         ti7x4V9085+ZHqzz0u6GBF+v5lcC702J5nbMAMy/jNVgiIhW1HLh5H+PLWzv4EkjYCP8
         9e+nmD4aYKTjy6qE5J/8Oe2qGE/gniPaPGOtVTN66putKdm/r0RG/seevhSOYvf/rTVE
         tEEw==
X-Gm-Message-State: AOJu0YyitwxFuE59SufYV4vZ4QAT7G0v232iwsFzeULfUJ3Gs3hFq8lr
	qWVom61ffgpplg8464SSD1Sn36ke/s7qN1tBSj8andmnjv4c9vkMMSWk
X-Gm-Gg: ASbGncs7pc3QpR/PNMWPkbF6xUIR1BSeIJLTzVPQ/oYgC0lAThkTkkYxYNkcywJekrh
	x1jvU6GJxwpDM8RDa4O720NTfs8nN4BAuP2DTv7pxLqb4o2DzSCnN/jCVCCjEU33DnlwACJZt6K
	eXeWfcnPzBg+7DKTuVqqMljXYMIy/a2qiAMXEDvEboOlmGu6jVHZQn0ppr3F1MgSWBJhg4TITpg
	ovfXFrj/C7CJCSa31gNSWG61B3I7gNTG2Ne5JHSEpsrnMiXg7r26UD/siLggdDyBkm19jtmsq2E
	9FBmHR+pZijV9YpJXs9DtWqmMMvwSoHydHXOvEWMVKMwC4M8kY5n/7XoPERhRjE6gX7JMdWv3VD
	Ou1qLg0V9Oipaa42IVqMHdX+/MYEM0dgUVRrmtR0VjfJpVb1IaTFEXljAx99+/SqsV9lQZnm/Gu
	5fa4wFHhw=
X-Google-Smtp-Source: AGHT+IG9I9EnS02ejTuy51cNau5bsnzGQKdup7AoXmp1lFKLtrHumJMAETm5BDVi/8goRxAbCS70Eg==
X-Received: by 2002:a05:6000:3108:b0:3b7:7ceb:1428 with SMTP id ffacd0b85a97d-3b90092cc2amr7565256f8f.8.1754831992819;
        Sun, 10 Aug 2025 06:19:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:388b:154d:e1e3:7131? ([2a0a:ef40:7a5:4701:388b:154d:e1e3:7131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dc7e1ddesm297930745e9.27.2025.08.10.06.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 06:19:52 -0700 (PDT)
Message-ID: <3f9eb0ed-576d-451a-93db-9b9508c99c27@gmail.com>
Date: Sun, 10 Aug 2025 14:20:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git-jump: make `diff` work with filenames containing
 spaces
From: Phillip Wood <phillip.wood123@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Greg Hurrell <greg.hurrell@datadoghq.com>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <CALnO6CDnSXpUVQEUJr=dc1ZY6errSv2M=4EmeaOmfDvcifHvnA@mail.gmail.com>
 <cc90fefd-9234-4fb7-a00e-96c4004ddace@gmail.com>
Content-Language: en-US
In-Reply-To: <cc90fefd-9234-4fb7-a00e-96c4004ddace@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/08/2025 11:09, Phillip Wood wrote:
> On 09/08/2025 15:44, D. Ben Knoble wrote:
>> On Fri, Aug 8, 2025 at 1:43 PM Greg Hurrell via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> From: Greg Hurrell <greg.hurrell@datadoghq.com>
>>>
>>> This commit takes the simple approach of unconditionally stripping any
>>> trailing tab. Consider the following three examples:
>>>
>>> 1. For file "foo bar", Git will emit "foo bar\t".
>>> 2. For file "foo\t", Git will emit "foo\t".
>>> 3. For file "foo bar\t", Git will emit "foo bar\t\t".

When I wrote earlier I forgot that git quotes filenames with control 
characters. If a name contains a tab it it quoted and so cases 2 and 3 
will be quoted and so there is no ambiguity when trimming a literal tab 
character from the end. I haven't checked but I suspect git-jump does 
not handle quoted filenames, if we wanted to add support it should be 
pretty easy as Git.pm has a function to do the unquoting for us.

Thanks

Phillip

>>>
>>> Before this commit, `git-jump` correctly handled only case "2".
>>>
>>> After this commit, `git-jump` correctly handles cases "1" and "3". In
>>> reality, "1" is the only case people are going to run into with any
>>> regularity, and the other two are extreme edge cases.
>>
>> So we drop support for case 2? Hm. I personally try to avoid this
>> situation anyway, but it would be nice if we could just do the right
>> thing here.
>> Or maybe we should consider trying to parse --patch-with-raw output
>> for the filenames?
> 
> An alternative would be to parse the filename from the "diff --git" line 
> like "git apply" does. As we're generating the diff with "--no-prefix" 
> that should be straight forward as the line is "diff --git <name> 
> <name>" where <name> is the name of the post-image file unless it is a 
> deletion in which case it is the name of the pre-image file. We'd still 
> need to check the "+++ " line or look for a "deleted file mode" line to 
> handle deletions.
> 
> Thanks
> 
> Phillip

